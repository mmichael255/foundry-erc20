-include .env

.PHONY: all test deploy

help:
	@echo "Usage:"
	@echo " make deploy [ARGS=...]"

build:; forge build

install:; forge install OpenZeppelin/openzeppelin-contracts --no-commit

test:; forge test

NETWORK_ARGS := --rpc-url http://localhost:8545 --private-key $(PRIVATE_KEY_ANVIL) --broadcast -vvvv

ifeq ($(findstring --network sepolia, $(ARGS)),--network sepolia)
	NETWORK_ARGS := --rpc-url $(SEPOLIA_RPC_URL) --private-key $(PRIVATE_KEY) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY)
endif

deploy:
	@forge script script/DeployBootsToken.s.sol:DeployBootsToken $(NETWORK_ARGS)

# cast abi-encode "constructor(uint256)" 1000000000000000000000000 -> 0x00000000000000000000000000000000000000000000d3c21bcecceda1000000
# Update with your contract address, constructor arguments and anything else
verify:
	@forge verify-contract --chain-id 11155111 --num-of-optimizations 200 --watch --constructor-args 0x00000000000000000000000000000000000000000000d3c21bcecceda1000000 --etherscan-api-key $(ETHERSCAN_API_KEY) --compiler-version v0.8.19+commit.7dd6d404 0x089dc24123e0a27d44282a1ccc2fd815989e3300 src/BootsToken.sol:OurToBootsTokenken
