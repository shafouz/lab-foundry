// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "src/Create2.sol";

contract Create2Script is Script {
    function setUp() public {}

    function run() public {
        Create2 create2 = new Create2();
        create2.main();
        create2.main();
    }
}
