pragma solidity >=0.8.0;

import "forge-std/console.sol";

contract Blocks {
    constructor() payable {}

    function printBlock() public payable {
        console.log(block.number);
        console.log(block.timestamp);
    }

    function printWhatever(string memory _whatever) public payable {
        console.log(_whatever);
    }

    function print(string memory a) external payable {
      console.log(a);
    }

    function print1(string memory a) public payable {
      console.log(a);
    }

    function printExternal(string memory a) public payable {
      this.print(a);
    }

    function printExternal1(string memory a) public payable {
      print1(a);
    }

    fallback() external payable {
      console.log("fallback");
    }
}
