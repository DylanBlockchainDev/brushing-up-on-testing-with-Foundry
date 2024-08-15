// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Test, console, stdError} from "lib/forge-std/src/Test.sol";
import {Counter} from "../src/Counter.sol";

contract CounterTest is Test {
    Counter public counter;

    function setUp() public {
        counter = new Counter();
    }

    function testInc() public {
        counter.inc();
        assertEq(counter.count(), 1);
    }

    function testFailDec() public {
        counter.dec();
    }

    function testDecUnderflow() public {
        vm.expectRevert(stdError.arithmeticError);
        counter.dec();
    }

    function testDec() public {
        counter.inc(); // .count is now = 1
        counter.inc(); // .count is now = 2
        console.log("count after inc calls", counter.count());
        counter.dec(); // .count is now = 0
        console.log("count after dec call", counter.count());
        assertEq(counter.count(), 1);
    }
}