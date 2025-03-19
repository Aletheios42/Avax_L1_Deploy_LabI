# Guía de Despliegue de Cadenas L1 en Avalanche

Este documento describe el proceso completo para desplegar una blockchain de capa 1 (L1) personalizada en el ecosistema Avalanche, aprovechando la tecnología Subnet-EVM.

## 1. Instalación de Avalanche CLI

El primer paso es instalar la interfaz de línea de comandos de Avalanche:

```bash
curl -sSfL https://raw.githubusercontent.com/ava-labs/avalanche-cli/main/scripts/install.sh | sh -s -- -n
```

## 2. Iniciar un Nodo Local

Antes de desplegar cualquier blockchain, necesitamos iniciar un nodo local de Avalanche:

```bash
avalanche network start
```

Deberías ver una salida similar a esta:

```
Installing avalanchego-v1.12.2...
avalanchego-v1.12.2 installation successful
AvalancheGo path: /home/aletheios/.avalanche-cli/bin/avalanchego/avalanchego-v1.12.2/avalanchego

Booting Network. Wait until healthy...

Node logs directory: /home/aletheios/.avalanche-cli/runs/network_20250319_190256/<NodeID>/logs

Network ready to use.

+------------------------------------------------------------------+
|                           PRIMARY NODES                          |
+------------------------------------------+-----------------------+
| NODE ID                                  | LOCALHOST ENDPOINT    |
+------------------------------------------+-----------------------+
| NodeID-7Xhw2mDxuDS44j42TCB6U5579esbSt3Lg | http://127.0.0.1:9650 |
+------------------------------------------+-----------------------+
| NodeID-MFrZFVCXPv5iCn6M9K6XduxGTYp891xXZ | http://127.0.0.1:9652 |
+------------------------------------------+-----------------------+
```

## 3. Creación de una Clave

Para gestionar los validadores, necesitas crear una clave:

```bash
avalanche key create mi-clave
```

## 4. Despliegue de la Blockchain

Existen dos enfoques para crear y desplegar una blockchain en Avalanche:

### 4.1. Método Simple (Configuración por Defecto)

Este método utiliza las configuraciones predeterminadas de Avalanche:

```bash
avalanche blockchain create sauco
```

Durante el proceso interactivo, selecciona:

- **VM**: Subnet-EVM
- **Mecanismo de validación**: Proof Of Authority
- **Clave**: Selecciona "Get address from an existing stored key" y elige la clave creada anteriormente
- **Configuración**: "I want to use defaults for a test environment"
- **ChainID**: Un entero positivo (por ejemplo, 5000)
- **Símbolo del token**: Un identificador para tu token nativo (por ejemplo, SCO)

### 4.2. Método Personalizado (Configuración con Génesis)

Para una configuración más personalizada, puedes crear un archivo génesis:

```bash
avalanche blockchain create sauco --genesis mi-genesis.json --evm --proof-of-authority
```

Cuando se solicite un controlador para el contrato ValidatorManager, selecciona la clave creada anteriormente.

### 4.3. Realizar el Despliegue

Una vez configurada, despliega la blockchain:

```bash
avalanche blockchain deploy sauco
```

Si estás desplegando una VM personalizada, podrías necesitar especificar un script de compilación (por ejemplo, `./build.sh`).

## 5. Inspección de la Blockchain Desplegada

Después del despliegue, el sistema mostrará información detallada sobre tu blockchain:

- **RPC Endpoint**: La URL para conectarse a tu blockchain (ej: `http://127.0.0.1:39051/ext/bc/brWfRT5C98WUc8GoQMCMugsxbUYcNd9eJCgS9qVbX4JgMCknP/rpc`)
- **Chain ID**: El identificador de la cadena (ej: 5000)
- **Asignación inicial de tokens**: Direcciones prefundadas y sus balances
- **Contratos desplegados**: Información sobre contratos core como el ValidatorManager

## 6. Interactuando con tu Blockchain

### 6.1. Consultas Básicas

Para verificar que la blockchain está operativa, puedes consultar el Chain ID:

```bash
curl -X POST --data '{"jsonrpc":"2.0","method":"eth_chainId","params":[],"id":1}' -H 'content-type:application/json' http://127.0.0.1:39051/ext/bc/brWfRT5C98WUc8GoQMCMugsxbUYcNd9eJCgS9qVbX4JgMCknP/rpc
```

Respuesta esperada:

```json
{ "jsonrpc": "2.0", "id": 1, "result": "0x45" }
```

### 6.2. Conexión desde MetaMask

Puedes conectar wallets como MetaMask a tu blockchain:

1. Abrir MetaMask
2. Hacer clic en "Agregar red"
3. Configurar red personalizada:

   - Nombre de la red: El nombre de tu blockchain (ej: "test")
   - URL RPC: La URL de RPC proporcionada (ej: `http://127.0.0.1:39051/ext/bc/brWfRT5C98WUc8GoQMCMugsxbUYcNd9eJCgS9qVbX4JgMCknP/rpc`)
   - Chain ID: El ID de cadena (ej: 5000)
   - Símbolo: El símbolo de tu token nativo (ej: SCO)

4. Para importar una cuenta ya financiada, usa la clave privada `ewoq`:
   ```
   56289e99c94b6912bfc12adc093c9b51124f0dc54ac7a766b2bc5ccf558d8027
   ```

## 7. Comandos Útiles

- **Describir blockchain**: `avalanche blockchain describe sauco`
- **Ver génesis**: `avalanche blockchain describe sauco --genesis`
- **Listar blockchains**: `avalanche blockchain list`
- **Verificar estado de la red**: `avalanche network status`
- **Ayuda de comandos**: `avalanche --help`, `avalanche blockchain --help`, `avalanche network --help`

## 8. Estructura de un Proyecto de VM Personalizada

Para VMs personalizadas, esta es una estructura típica de proyecto:

```
.
├── build/                # Directorio para binarios compilados
├── build.sh              # Script de compilación para la VM
├── cmd/
│   └── sauco/
│       └── main.go       # Punto de entrada de la VM
├── mi-genesis.json       # Archivo de génesis
├── go.mod                # Dependencias de Go
└── README.md
```

## 9. Solución de Problemas

Si encuentras el error "connection refused", asegúrate de que:

1. El nodo Avalanche está en ejecución (`avalanche network status`)
2. Estás usando el puerto y la ruta correctos en la URL de RPC
3. El ID de blockchain en la URL es correcto

Para reiniciar desde cero:

```bash
avalanche network stop
rm -rf ~/.avalanche-cli/network/
avalanche network start
```

---

## Referencias

- [Documentación oficial de Avalanche](https://build.avax.network/docs)
- [Repositorio Subnet-EVM](https://github.com/ava-labs/subnet-evm/releases)
- [Avalanche CLI](https://github.com/ava-labs/avalanche-cli)
