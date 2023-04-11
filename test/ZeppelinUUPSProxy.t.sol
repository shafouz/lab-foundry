pragma solidity >=0.8.17;

import "forge-std/console.sol";
import "forge-std/Test.sol";
import "@openzeppelin/proxy/utils/Initializable.sol";
import "@openzeppelin/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin/proxy/ERC1967/ERC1967Proxy.sol";

contract ZeppelinProxyTest is Test {
    ERC1967Proxy proxy;
    ERC1967Proxy proxyInherited;
    MyContractInherited myInherited;

    function setUp() public {
        MyContract my = new MyContract();
        proxy = new ERC1967Proxy(address(my), "");

        myInherited = new MyContractInherited();
        proxyInherited = new ERC1967Proxy(address(myInherited), "");
    }

    function testProxy() public {
        address(proxy).call(abi.encodeWithSignature("main()"));
    }

    function testUpgrades() public {
        UUPSUpgradeable(address(proxy)).upgradeTo(address(new MyContract1()));
        (bool result, bytes memory data) = address(proxy).call(abi.encodeWithSignature("main()"));
        assertEq(abi.decode(data, (string)), "hello2");
    }

    function testUpgradesInheritance() public {
        address(proxyInherited).call(abi.encodeWithSignature("initialize()"));
        (bool result, bytes memory data) = address(proxyInherited).call(abi.encodeWithSignature("main()"));
        assertEq(result, true);
        string memory decoded = abi.decode(data, (string));
        assertEq(decoded, "hello");

        MyContractInherited1 newImpl = new MyContractInherited1();
        UUPSUpgradeable(address(proxyInherited)).upgradeTo(address(newImpl));

        (bool result1, bytes memory data1) = address(proxyInherited).call(abi.encodeWithSignature("main2()"));
        assertEq(result, true);
    }
}

contract MyContract is UUPSUpgradeable {
    function main() public returns (string memory) {
        return "hello";
    }

    function _authorizeUpgrade(address newImplementation) internal virtual override {}
}

contract MyContract1 is UUPSUpgradeable {
    function main() public returns (string memory) {
        return "hello2";
    }

    function _authorizeUpgrade(address newImplementation) internal virtual override {}
}

contract MyContractInherited is Initializable, UUPSUpgradeable {
    string public b;

    function initialize() public initializer {
        b = "hello";
    }

    function main() public returns (string memory) {
        return b;
    }

    function _authorizeUpgrade(address newImplementation) internal virtual override {}
}

contract MyContractInherited1 is MyContractInherited {
    function main2() public returns (string memory) {}
}
