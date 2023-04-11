// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "src/Lib.sol";

contract SelfDestructLibAttackTest is Test {
    Something some;

    function setUp() public {
        some = new Something();
    }

    function testSelfDestruct() public {
        vm.deal(address(some), 100 ether);
        some.main();
        assertEq(address(some).balance, 0 ether);
    }

    function testUsingRawHex() public {
      bytes memory deploymentData = hex"609b610051600b82828239805160001a6073146044577f4e487b7100000000000000000000000000000000000000000000000000000000600052600060045260246000fd5b30600052607381538281f3fe730000000000000000000000000000000000000000301460806040526004361060335760003560e01c806383197ef0146038575b600080fd5b818015604357600080fd5b50604a604c565b005b3373ffffffffffffffffffffffffffffffffffffffff16fffea26469706673582212201fbca1308e46bf86bd1acd3518538b18ee9199cb4e0ce0d6215496c1108b08eb64736f6c63430008120033";
      bytes32 salt = "";
      address lib;

      assembly {
          lib := create2(0x0, add(0x20, deploymentData), mload(deploymentData), salt)
      }

      assertGt(lib.code.length, 0);

      vm.expectRevert();
      lib.call(abi.encodeWithSignature("destroy()"));
    }

    function testUsingCreationCode() public {
      bytes memory deploymentData = type(Lib).creationCode;
      bytes32 salt = "";
      address lib;

      assembly {
          lib := create2(0x0, add(0x20, deploymentData), mload(deploymentData), salt)
      }

      assertGt(lib.code.length, 0);

      vm.expectRevert();
      lib.call(abi.encodeWithSignature("destroy()"));
    }
}

contract Something {
    function main() public {
        Lib.destroy();
    }
}
