FROM golang:1.19-alpine

WORKDIR /app

# Instalar dependencias del sistema
RUN apk add --no-cache git build-base

# Copiar archivos de configuración
COPY go.mod go.sum* ./
RUN go mod download

# Copiar el código fuente
COPY . .

# Compilar la VM
RUN chmod +x build.sh && ./build.sh

# Instalar Avalanche CLI
RUN go install github.com/ava-labs/avalanche-cli@latest

# Exponer los puertos de Avalanche
EXPOSE 9650 9651

# Comando para iniciar la blockchain
CMD ["avalanche", "blockchain", "deploy", "sauco"]

