pragma solidity 0.8.17;

import "forge-std/console.sol";

contract Create2 {
    constructor() payable {}

    function main() public {
        bytes32 salt = "";
        bytes memory deploymentData = abi.encodePacked(type(MyContract).creationCode, uint256(uint160(0x0)));
        MyContract myContract;

        assembly {
            myContract := create2(0x0, add(0x20, deploymentData), mload(deploymentData), salt)
        }

        console.log("myContract: %s", myContract.hello());
        console.log("myContract: %s", address(myContract));
    }
}

contract MyContract {
    constructor() payable {}

    function hello() public pure returns (string memory) {
        return "hello";
    }
}
