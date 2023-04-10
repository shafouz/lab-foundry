pragma solidity >=0.8.17;

import "forge-std/Test.sol";
import "forge-std/console.sol";

contract ModifierTest is Test {
  Modifier mod;

  function setUp() public {
    mod = new Modifier();
  }

  function testSkipsFunction() public {
    assertEq(0, mod.run());
  }

  function testDoesNothing() public {
    assertEq(123, mod.run1());
  }

  function testFirstSwapSecond() public {
    assertEq(0, mod.run2());
  }

  function testFirstSwapSecondLate() public {
    assertEq(123, mod.run3());
  }
}

contract Modifier {
    uint256 public runCount = 0;

    constructor() payable {}

    modifier earlyReturn() {
        return;
        _;
    }

    modifier lateReturn() {
        _;
        return;
    }

    modifier catcher() {
      try this.run() {
        _; 
      } catch {
        _; 
      }
    }

    modifier overrideReturn() {
        _;
    }

    // wont compile
    // modifier overrideReturn() {
    //     _;
    //     return 1;
    // }

    function run() public earlyReturn returns(uint8) {
        return 123;
    }

    function run1() public lateReturn returns(uint8) {
        return 123;
    }

    function run2() public overrideReturn earlyReturn returns(uint8) {
        return 123;
    }

    function run3() public overrideReturn lateReturn returns(uint8) {
        return 123;
    }
}
