// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../src/DaoAttack.sol";

contract DaoAttackTest is Test {
    DaoAttack public dao;
    Attacker public attacker;

    function setUp() public {
        dao = new DaoAttack();
        attacker = new Attacker(payable(dao));
        vm.deal(address(dao), 100 ether);
        vm.deal(address(attacker), 100 ether);
    }

    function testCreates() public {
        assertEq(address(dao), address(dao));
        assertEq(address(attacker), address(attacker));
    }

    function testAttackWorks() public {
        attacker.attack();
        assertEq(address(attacker).balance, 102 ether);
        assertEq(address(dao).balance, 98 ether);
    }
}
