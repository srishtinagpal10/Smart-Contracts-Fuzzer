// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FindThisHash {
    mapping(address => bytes32) public commitments;

    function commit(bytes32 commitment) external payable {
        require(commitments[msg.sender] == 0, "Already committed");
        require(msg.value > 0, "Value must be greater than 0");

        commitments[msg.sender] = commitment;
    }

    function reveal(string memory solution, uint256 nonce) external {
        bytes32 commitment = keccak256(abi.encodePacked(solution, nonce));
        require(commitments[msg.sender] == commitment, "Invalid commitment");

        require(keccak256(abi.encodePacked(solution)) == hash, "Incorrect answer");

        commitments[msg.sender] = 0;
        (bool sent, ) = msg.sender.call{value: 10 ether}("");
        require(sent, "Failed to send Ether");
        
    }

    bytes32 public constant hash =
        0x564ccaf7594d66b1eaaea24fe01f0585bf52ee70852af4eac0cc4b04711cd0e2;
}
