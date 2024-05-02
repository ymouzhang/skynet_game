# skynet_game
Develop games using skynet

## Usage
### Directory specification
- `etc`: Store configuration files
- `luaclib`: Store some C modules
- `lualib`: Store some lua modules
- `service`: Store the Lua code of each service
- `skynet`: Store skynet framework

### Build
build skynet framework 
```shell
cd skynet
git submodule update --init --recursive
make linux
```
Execute sample code
```shell
./skynet/skynet ./etc/config.node1
```
