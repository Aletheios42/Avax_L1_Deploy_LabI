# Recursos

https://build.avax.network/docs/tooling/get-avalanche-cli

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
