// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Test, console, StdCheats, StdUtils} from "../../lib/forge-std/src/Test.sol";
import {CommonBase} from "../../lib/forge-std/src/Base.sol";
import {WETH} from "../../src/WETH.sol";

// Topics
// - handler based testing - test functions under specific conditions
// - target contract
// - target selector

contract Handler is CommonBase, StdCheats, StdUtils {
    WETH private weth;
    uint public wethBalance;

    constructor(WETH _weth) {
        weth = _weth;
    }

    receive() external payable {}

    function sendToFallback(uint amount) public {
        amount = bound(amount, 0, address(this).balance);
        wethBalance += amount;
        (bool ok, ) = address(weth).call{value: amount}("");
        require(ok, "sendToFallback failed");
    }

    function deposit(uint amount) public {
        amount = bound(amount, 0, address(this).balance);
        wethBalance += amount;
        weth.deposit{value: amount}();
    }

    function withdraw(uint amount) public {
        amount = bound(amount, 0, weth.balanceOf(address(this)));
        wethBalance -= amount;
        weth.withdraw(amount);
    }

    // function fail() public { // leave unmarked with pure
    //     revert("failed");
    // }
}

contract WEHT_Handler_Base_Invariant_Test is Test {
    WETH public weth;
    Handler public handler;

    function setUp() public {
        weth = new WETH();
        handler = new Handler(weth);

        deal(address(handler), 100 * 1e18);
        targetContract(address(handler));

        bytes4[] memory selectors = new bytes4[](3);
        selectors[0] = handler.deposit.selector;
        selectors[1] = handler.withdraw.selector;
        selectors[2] = handler.sendToFallback.selector;

        targetSelector(
            FuzzSelector({addr: address(handler), selectors: selectors})
        );
    }

    function invariant_eth_balance() public view {
        assertGe(address(weth).balance, handler.wethBalance());
    }
}