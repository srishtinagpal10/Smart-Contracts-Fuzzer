// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract UnchekedExternalCall {
    mapping(address => uint256) public balances;

    function transferFunds(address payable recipient, uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient funds");
        balances[msg.sender] -= amount;

        (bool success, ) = recipient.call{value: amount}("");
        require(success, "Transfer failed");
    }
}


