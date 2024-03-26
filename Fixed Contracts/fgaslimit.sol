// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GasLimit {
    struct User {
        address userAddress;
        uint256 reward;
    }

    User[] public userList;

    function distributeRewards(uint256 iterations) external {
        for (uint256 i = 0; i < iterations && i < userList.length; i++) {
            userList[i].reward += 1;
        }
    }

    function addUser(address newUser) external {
        userList.push(User(newUser, 0));
    }
}
