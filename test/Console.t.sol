// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Test, console} from "./../lib/forge-std/src/Test.sol";

contract ConsoleTest is Test {
    function testLogSomething() public pure {
        console.log("Log something here");

        int x = -1;
        console.logInt(x);
    }
}