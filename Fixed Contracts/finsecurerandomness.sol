// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SecureRandomness {
    uint256 private commit;
    address private committer;
    bool private hasCommitted;
    
    function commitRandomNumber(uint256 _commit) public {
        require(!hasCommitted, "Already committed");
        commit = _commit;
        committer = msg.sender;
        hasCommitted = true;
    }
    
    function revealRandomNumber(uint256 _randomNumber) public returns (uint256) {
        require(hasCommitted, "Not yet committed");
        require(msg.sender == committer, "Only committer can reveal");
        uint256 randomNumber = uint256(keccak256(abi.encodePacked(_randomNumber, committer, blockhash(block.number))));
        // You can modify the range as needed
        uint256 finalRandomNumber = (randomNumber % 100) + 1;
        
        // Reset state variables
        commit = 0;
        committer = address(0);
        hasCommitted = false;
        
        return finalRandomNumber;
    }
}
