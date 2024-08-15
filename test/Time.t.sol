// SPDX-License-Identifier: MIT 
pragma solidity 0.8.20;

import {Test, console} from "../lib/forge-std/src/Test.sol";
import {Auction} from "../src/Time.sol";

contract TimeTest is Test {
    Auction public auction;
    uint256 private startAt;

    // vm.warp - set block.timestamp to future timestamp
    // vm.roll - set block.number
    // skip - increment current timestamp
    // rewind - decrement current timestamp

    function setUp() public {
        auction = new Auction();
        startAt = block.timestamp;
    }

    function testBidFailsBeforeStartTime() public {
        vm.expectRevert(bytes("cannot bid"));
        auction.bid();
    }

    function testBid() public {
        vm.warp(startAt + 1 days);
        auction.bid();
    }

    function testBidFailsAfterEndTime() public {
        vm.expectRevert(bytes("cannot bid"));
        vm.warp(startAt + 2 days);
        auction.bid();
    }

    function testTimeStamp() public {
        uint t = block.timestamp;

        // skip - increment current timestamp
        skip(100);
        assertEq(block.timestamp, t + 100);

        // rewind - decrement current timestamp
        rewind(10);
        assertEq(block.timestamp, t + 100 - 10);
    }

    function testBlockNumber() public {
        uint b = block.number;
        vm.roll(999);
        assertEq(block.number, 999);
        console.log("uint b = ", b);
        console.log("block.number = ", block.number);
        console.log("uint b + block.number = ", b + block.number); 
    }

}