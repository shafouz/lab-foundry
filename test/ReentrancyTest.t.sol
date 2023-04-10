pragma solidity >=0.8.0;

import "forge-std/Test.sol";

contract ReentrancyTest is Test {
    Reentrancy public r;
    Atk public atk;

    function setUp() public {
      r = new Reentrancy();
      atk = new Atk();
    }

    function testDoesItRevert() public {
      vm.prank(address(atk));
      vm.expectRevert();
      r.withdraw();
      assertEq(address(atk).balance, 0);
    }
}

contract Atk {
  bool public called = false;

  fallback() external payable {
    if (called == true) return;
    called = true;
    Reentrancy(msg.sender).withdraw();
  }
}

contract Reentrancy {
    mapping(address => uint) public balances;

    function withdraw() public {
      balances[msg.sender] += 20;
      (bool success, ) = msg.sender.call("");
      require(false);
    }
}
