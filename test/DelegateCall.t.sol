pragma solidity ^0.8.0;

import {Delegator, Caller} from "src/DelegateCall.sol";
import {Test} from "forge-std/Test.sol";
import "forge-std/console.sol";

contract DelegatorTest is Test {
    Delegator delegator;
    Caller caller;

    function setUp() public {
        delegator = new Delegator();
        caller = new Caller();
    }

    function testDelegateCall() public {
        bytes memory str = delegator.delegate(address(caller), "getDelegateString()");
        assertEq(abi.decode(str, (string)), "this_is_from_delegator");
    }

    function testDelegateCallDontExist() public {
        bytes memory str = delegator.delegate(address(caller), "getDelegateStringDontExist()");
        assertEq(abi.decode(str, (string)), "");
    }
}
