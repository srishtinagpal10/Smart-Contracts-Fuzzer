// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    mapping(address => bool) public hasVoted;
    mapping(string => uint) public votesReceived;
    string[] public candidateList;

    constructor(string[] memory _candidateList) {
        candidateList = _candidateList;
    }

    function vote(string memory candidate) public {
        require(bytes(candidate).length > 0, "Candidate name cannot be empty");
        require(!hasVoted[msg.sender], "You can only vote once");

        votesReceived[candidate]++;
        hasVoted[msg.sender] = true;
    }

    function getWinners() public view returns (string[] memory) {
        uint maxVotes = 0;
        string[] memory winners;

        for (uint i = 0; i < candidateList.length; i++) {
            if (votesReceived[candidateList[i]] > maxVotes) {
                maxVotes = votesReceived[candidateList[i]];
                winners = new string[](1);
                winners[0] = candidateList[i];
            } else if (votesReceived[candidateList[i]] == maxVotes) {
                string[] memory newWinner = new string[](winners.length + 1);
                for (uint j = 0; j < winners.length; j++) {
                    newWinner[j] = winners[j];
                }
                newWinner[winners.length] = candidateList[i];
                winners = newWinner;
            }
        }

        return winners;
    }
}



