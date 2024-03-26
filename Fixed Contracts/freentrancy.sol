// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract bank{
    mapping(address => uint256) public balances;

    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw() external {
        require(balances[msg.sender]>0, "Insufficient Funds");
        balances[msg.sender]=0;
        (bool success,) = msg.sender.call{value: balances[msg.sender]}("");
        require(success, "Transfer Failed");
    }
}

