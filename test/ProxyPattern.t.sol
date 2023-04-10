pragma solidity >=0.8.17;

import "forge-std/Test.sol";
import "forge-std/console.sol";

contract ProxyTest is Test {
  Implementation impl;
  Proxy proxy;
    
  function setUp() public {
    impl = new Implementation();
    proxy = new Proxy(address(impl));
  }

  function testProxy() public {
    address(proxy).call(abi.encodeWithSignature("main()"));
  }

  function testCollides() public {
    (bool result, bytes memory data) = address(proxy).call(abi.encodeWithSignature("main()"));
    address decoded = abi.decode(data, (address));
    assertEq(decoded, address(impl));
  }
}

contract Proxy {
    address delegate;
    address owner = msg.sender;

    constructor(address _delegate) {
        delegate = _delegate;
    }

    function upgradeDelegate(address newDelegateAddress) public {
        require(msg.sender == owner);
        delegate = newDelegateAddress;
    }

    fallback() external payable {
      assembly {
          let _target := sload(0)
          calldatacopy(0x0, 0x0, calldatasize())

          let result := delegatecall(gas(), _target, 0x0, calldatasize(), 0x0, 0)
          returndatacopy(0x0, 0x0, returndatasize())

          switch result
          case 0 {revert(0, 0)}
          default {return (0, returndatasize())}
      }
    }
}

contract Implementation {
    address collider = address(0xffffffffffffffff);

    function main() public returns(address) {
      return collider;
    }
}
