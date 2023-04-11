pragma solidity 0.8.17;

import "forge-std/Script.sol";
import "src/Lib.sol";

contract LibraryDeployScript is Script {
    DeployProxy proxy;

    function setUp() public {
      vm.broadcast();
      proxy = new DeployProxy();
    }

    function run() public {
      bytes memory deploymentData = type(Lib).creationCode;
      address lib = proxy.create(deploymentData);

      lib.call(abi.encodeWithSignature("destroy()"));
      lib.delegatecall(abi.encodeWithSignature("destroy()"));
    }
}

contract DeployProxy {
  function create(bytes memory deploymentData) public returns(address) {
    bytes32 salt = "";
    address lib;

    assembly {
        lib := create2(0x0, add(0x20, deploymentData), mload(deploymentData), salt)
    }

    return lib;
  }
}
