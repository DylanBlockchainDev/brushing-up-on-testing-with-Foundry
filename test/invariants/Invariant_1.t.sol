// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Test, console} from "../../lib/forge-std/src/Test.sol";
import {WETH} from "../../src/WETH.sol";

// https://book.getfoundry.sh/forge/invariant-testing?highlight=targetSelector#invariant-targets
// https://mirror.xyz/horsefacts.eth/Jex2YVaO65dda6zEyfM_-DXlXhOWCAoSpOx5PLocYgw

// NOTE: open testing - randomly call all public functions
contract WETH_Open_Invariant_Tests is Test {
    WETH public weth;

    function setUp() public {
        weth = new WETH();
    }

    function invariant_totalSupply_is_always_zero() public view {
        assertEq(weth.totalSupply(), 0);
    }
}