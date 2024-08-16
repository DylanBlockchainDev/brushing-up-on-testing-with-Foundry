// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Test, console} from "../../lib/forge-std/src/Test.sol";

// Topics
// - Invariant
// - Difference between fuzz and invariant = for a fuzz a randome input is passed into a function. for invariant a sequence of fucntions are randomly called.
// - Failing invariant
// - Passing invariant
// - Stats - runs, calls, reverts

contract IntorInvariant {
    bool public flag;

    function func_1() external {}
    function func_2() external {}
    function func_3() external {}
    function func_4() external {}
    function func_5() external {
        flag = true;
    }
}

contract IntorInvariantTest is Test {
    IntorInvariant private target;

    function setUp() public {
        target = new IntorInvariant();
    }

    function invariant_flag_is_always_false() public view {
        assertEq(target.flag(), false);
    }
} 