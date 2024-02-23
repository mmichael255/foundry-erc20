// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {BootsToken} from "../src/BootsToken.sol";
import {DeployBootsToken} from "../script/DeployBootsToken.s.sol";

contract BootsTokenTest is Test {
    DeployBootsToken deployer;
    BootsToken bt;

    address bob = makeAddr("bob");
    address alice = makeAddr("alice");
    uint256 public constant STARTING_BALANCE = 50 ether;

    function setUp() public {
        deployer = new DeployBootsToken();
        bt = deployer.run();
        vm.prank(address(msg.sender));
        bt.transfer(bob, STARTING_BALANCE);
    }

    function testBobBlance() public {
        assert(STARTING_BALANCE == bt.balanceOf(bob));
    }

    function testAllowance() public {
        uint256 initialAllowance = 1000;
        vm.prank(bob);
        bt.approve(alice, initialAllowance);

        uint256 spentToken = 500;

        vm.prank(alice);
        bt.transferFrom(bob, alice, spentToken);
        assert(bt.balanceOf(alice) == spentToken);
        assert(bt.balanceOf(bob) == STARTING_BALANCE - spentToken);
    }
}
