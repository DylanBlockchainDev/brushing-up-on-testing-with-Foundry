// SPDX-License-Identifier: MIT 
pragma solidity 0.8.20;

import {Test} from "../lib/forge-std/src/Test.sol";
import {Bit} from "../src/Bit.sol";

// Topics
// - fuzz
// - assume and bound
// - stats

contract FuzzTest is Test {
    Bit public b;

    function setUp() public {
        b = new Bit();
    }

    function mostSignificantBit(uint256 x) private pure returns (uint256) {
        uint i = 0;
        while ((x >>= 1) > 0) {
            i++;
        }
        return i;
    }

    function testMostSignificantBitManual() public view {
        assertEq(b.mostSignificantBit(0), 0);
        assertEq(b.mostSignificantBit(1), 0);
        assertEq(b.mostSignificantBit(2), 1);
        assertEq(b.mostSignificantBit(4), 2);
        assertEq(b.mostSignificantBit(8), 3);
        assertEq(b.mostSignificantBit(type(uint256).max), 255);
    }

    function testMostSignificantBitFuzz(uint256 x) public view {
        // assume - If false, the fuzzer will discard the current fuzz inputs
        //          and start a new fuzz run
        // vm.assume(x > 0);
        // assertGt(x, 0);

        // bound(input, min, max) - bound input between min and max
        // Bound
        x = bound(x, 1, 10);
        // assertGe(x, 1);
        // assertLe(x, 10);

        uint i = b.mostSignificantBit(x);
        assertEq(i, b.mostSignificantBit(x));
    }
}