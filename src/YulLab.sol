pragma solidity 0.8.17;

import "forge-std/console.sol";

contract YulLab {
    bytes hello = "hello";

    constructor() {}

    function main(uint256 slot) public returns (bytes32 cdata, bytes32 mdata, bytes32 sdata) {
        assembly {
            cdata := calldataload(0)
            mdata := mload(0)
            sdata := sload(0)
            // ret := sdata
        }
    }

    function v() public {
        (bytes32 cdata, bytes32 mdata, bytes32 sdata) = main(uint256(0x2));

        console.logBytes32(cdata);
        console.logBytes32(mdata);
        console.logBytes32(sdata);
    }

    function access() public view {
        bytes memory cool;

        assembly {
            cool := 41414141
        }

        console.logBytes(cool);
    }
}
