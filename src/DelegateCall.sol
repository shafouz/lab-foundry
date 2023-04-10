pragma solidity ^0.8.0;

contract Delegator {
    bytes delegate_string = "this_is_from_delegator";

    constructor() payable {}

    function delegate(address _contract, string memory data) public returns (bytes memory) {
        (bool success, bytes memory _data) = _contract.delegatecall(abi.encodeWithSignature(data));
        return _data;
    }
}

contract Caller {
    bytes deletegate_string = "this_is_from_caller";
    bytes deletegate_string_1 = "this_is_from_caller1";

    constructor() payable {}

    function getDelegateString() public view returns (bytes memory) {
        return deletegate_string;
    }

    function getDelegateStringDontExist() public view returns (bytes memory) {
        return deletegate_string_1;
    }
}
