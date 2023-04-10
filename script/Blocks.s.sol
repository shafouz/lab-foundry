pragma solidity 0.8.17;

import "forge-std/Script.sol";
import "src/Blocks.sol";

contract BlocksScript is Script {
    function setUp() public {}

    function run() public {
      Blocks blocks = new Blocks();
      blocks.print("1");
    }

    function deploy() public {
      uint256 deployer = 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80;

      address contract_addr = 0xDc64a140Aa3E981100a9becA4E685f962f0cF6C9;

      vm.startBroadcast(deployer);
      Blocks blocks = new Blocks();
      blocks.printExternal("lelele");
      vm.stopBroadcast();

      vm.startBroadcast(deployer);
      blocks.printExternal1("lelele");
      vm.stopBroadcast();
    }
}
