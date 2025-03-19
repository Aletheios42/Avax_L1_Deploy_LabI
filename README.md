# Avax_L1_Deploy_LabI

Blockchain Sauco basada en Avalanche Subnet-EVM. Este repositorio contiene el código necesario para desplegar y ejecutar una blockchain personalizada en el ecosistema Avalanche.

## Requisitos previos

- Go 1.19 o superior instalado
- CLI de Avalanche instalada (`avalanche-cli`)
- Docker (opcional)

## Estructura del proyecto

```
.
├── build/                # Directorio para binarios compilados
├── build.sh              # Script de compilación para la VM
├── cmd/
│   └── sauco/
│       └── main.go       # Punto de entrada de la VM
├── mi-genesis.json       # Archivo de génesis para configuración de la blockchain
├── go.mod                # Dependencias de Go
└── README.md             # Este archivo
```

## Instalación

### Usando Go directamente

1. Clona el repositorio:

   ```bash
   git clone https://github.com/Aletheios42/Avax_L1_Deploy_LabI.git
   cd Avax_L1_Deploy_LabI
   ```

2. Descarga las dependencias:

   ```bash
   go mod tidy
   ```

3. Compila la VM:
   ```bash
   ./build.sh
   ```

### Usando Docker

1. Construye la imagen Docker:

   ```bash
   docker build -t sauco-vm .
   ```

2. Ejecuta el contenedor:
   ```bash
   docker run -p 9650:9650 -p 9651:9651 sauco-vm
   ```

## Despliegue de la blockchain

1. Crea una clave para gestionar los validadores:

   ```bash
   avalanche key create mi-clave
   ```

2. Despliega la blockchain:

   ```bash
   avalanche blockchain create sauco
   ```

   Selecciona "Custom VM" y "Proof of Authority" cuando se te solicite.

3. Cuando se te pida un script de compilación, escribe:

   ```
   ./build.sh
   ```

4. Para el archivo de génesis, usa:

   ```
   mi-genesis.json
   ```

5. Selecciona tu clave creada anteriormente cuando se te solicite.

Una vez que la blockchain esté desplegada, puedes verificar que está ejecutándose:

```bash
avalanche blockchain list
```

## Conexión a la blockchain

La blockchain estará disponible en:

```
http://localhost:9650/ext/bc/<BLOCKCHAIN_ID>/rpc
```

Donde `<BLOCKCHAIN_ID>` es el ID asignado por Avalanche (puedes obtenerlo con `avalanche blockchain list`).

Para realizar una consulta básica:

```bash
curl -X POST --data '{
    "jsonrpc":"2.0",
    "method":"eth_chainId",
    "params":[],
    "id":1
}' -H 'content-type:application/json' http://localhost:9650/ext/bc/<BLOCKCHAIN_ID>/rpc
```

## Conexión desde MetaMask

1. Abre MetaMask
2. Haz clic en el selector de red y selecciona "Agregar red"
3. Configura:
   - Nombre de la red: SAUCO
   - URL RPC: http://localhost:9650/ext/bc/<BLOCKCHAIN_ID>/rpc
   - ID de cadena: 5000
   - Símbolo: SCO

Para verificar si el servicio está activo:

```bash
netstat -tuln | grep 9650
```
