// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {ERC20} from "lib/solmate/src/tokens/ERC20.sol";

contract Token is ERC20("name", "symbol", 18) {}