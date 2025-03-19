# Recursos

https://build.avax.network/docs/tooling/get-avalanche-cli

# Instalar el CLI

```bash
curl -sSfL https://raw.githubusercontent.com/ava-labs/avalanche-cli/main/scripts/install.sh | sh -s -- -n
avalanche network start
```

# Iniciar un nodo

```bash
❯ avalanche network start
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

# Deployear tu L1 de Avax

#### Crear la configuración para una local

```bash
avalanche blockchain create <sauco>
```

- Choose Your VM:
  Select Subnet-EVM.
- Choose Validator Manager:
  Select Proof Of Authority.
  Select Get address from an existing stored key.
  Select ewoq.

- Choose Blockchain Configuration
  Select I want to use defaults for a test environment.

- Enter Your Avalanche L1's ChainID
  ✗ Chain ID:
  Choose a positive integer for your EVM-style ChainID.
- Token Symbol
  Enter a string to name your Avalanche L1's native token. The token symbol doesn't necessarily need to be unique.

Deberías ver:
✓ Successfully created blockchain configuration

#### Crear la configuración para una custom

##### Prerequisitos

- configuracion json

```bash
avalanche blockchain describe <blockchain_name> --genesis
```

- cartera:
  ```bash
  avalanche key create mi-clave
  ```

###### Configuracion de custom VM

```bash
  avalanche blockchain create <name_blockchain> --genesis <name_config.json> --evm --proof-of-authority
```

? Which address do you want to enable as controller of ValidatorManager contract?:
▸ Get address from an existing stored key (created from avalanche key create or avalanche key import)
y selecciona el nombre de la key que acabamos de crear

- version vm:
  mirar docs: https://github.com/ava-labs/subnet-evm/releases

##### To view the Genesis configuration, use the following command:

```bash
avalanche blockchain describe myblockchain --genesis
```

#### Deployear la blockchain

```bash
avalanche blockchain deploy <sauco>
```

##### OUTPUT

❯ curl -X POST --data '{"jsonrpc":"2.0","method":"eth_chainId","params":[],"id":1}' -H 'content-type:application/json' http://127.0.0.1:39051/ext/bc/brWfRT5C98WUc8GoQMCMugsxbUYcNd9eJCgS9qVbX4JgMCknP/rpc
{"jsonrpc":"2.0","id":1,"result":"0x45"}
