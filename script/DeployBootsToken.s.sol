// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";

import {BootsToken} from "../src/BootsToken.sol";

contract DeployBootsToken is Script {
    uint256 private constant INITIAL_SUPPLY = 100 ether;

    function run() external returns (BootsToken) {
        vm.startBroadcast();
        BootsToken bt = new BootsToken(INITIAL_SUPPLY);
        vm.stopBroadcast();
        return bt;
    }
}
