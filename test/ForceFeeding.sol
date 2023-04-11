pragma solidity >=0.8.13;

import "forge-std/Test.sol";

contract ForceFeedingTest is Test {
    Eater public ff;
    Atk public atk;

    function setUp() public {
        ff = new Eater();
        atk = new Atk();
    }

    function testBypassesFallbackAndReceive() public {
        vm.deal(address(atk), 100 ether);
        atk.destroy(payable(address(ff)));
        assertEq(address(ff).balance, 100 ether);
    }
}

contract Atk {
    function destroy(address payable addr) public {
        selfdestruct(addr);
    }
}

contract Eater {
    fallback() external payable {
        revert();
    }

    receive() external payable {
        revert();
    }
}
