pragma solidity >=0.8.17;

import "forge-std/Test.sol";

contract CastingTest is Test {
  function testCasts() public {
    MyContract2 c2 = new MyContract2();

    MyContract(address(c2)).main();

    vm.expectRevert();
    MyContract(address(c2)).main2();
  }
}

contract MyContract {
  function main() public {}
  function main2() public {}
}

contract MyContract2 {
  function main() public {}
}
