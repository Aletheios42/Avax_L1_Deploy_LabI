FROM golang:1.20-alpine

WORKDIR /app

# Instalar dependencias del sistema
RUN apk add --no-cache git build-base bash

# Copiar archivos de configuración
COPY go.mod ./
COPY go.sum ./

# Corregir dependencias y descargarlas
RUN go mod tidy && go mod download

# Copiar el código fuente
COPY . .

# Compilar la VM
RUN chmod +x build.sh && ./build.sh

# Instalar Avalanche CLI
RUN go install github.com/ava-labs/avalanche-cli@latest

# Crear directorio para CLI y configuración
RUN mkdir -p /root/.avalanche-cli

# Script de entrada para desplegar la blockchain
RUN echo '#!/bin/bash\n\
	avalanche key create mi-clave --force\n\
	echo "Blockchain deployment starting..."\n\
	avalanche blockchain deploy sauco --genesis mi-genesis.json --vm ./build/sauco\n\
	echo "Blockchain deployed, starting RPC server..."\n\
	tail -f /dev/null' > /app/entrypoint.sh && chmod +x /app/entrypoint.sh

# Configurar volumen para persistencia
VOLUME ["/root/.avalanche-cli"]

# Exponer los puertos de Avalanche
EXPOSE 9650 9651

# Comando para iniciar la blockchain
CMD ["/app/entrypoint.sh"]
