pragma solidity 0.8.17;

import "forge-std/Script.sol";
import "src/YulLab.sol";

contract YulLabScript is Script {
    function setUp() public {}

    function run() public {
        YulLab yulLab = new YulLab();
        // yulLab.v();
        yulLab.access();
    }
}
