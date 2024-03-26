// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/VRFConsumerBase.sol";

contract Lottery is VRFConsumerBase {

    bytes32 internal keyHash;
    uint256 internal fee;
    uint256 public randomResult;

    constructor(address vrfCoordinator, address link, bytes32 _keyHash, uint256 _fee)
        VRFConsumerBase(vrfCoordinator, link)
    {
        keyHash = _keyHash;
        fee = _fee;
    }

    function requestRandomness() internal returns (bytes32 requestId) {
        require(LINK.balanceOf(address(this)) >= fee, "Not enough LINK - fill contract with faucet");
        return requestRandomness(keyHash, fee);
    }

    function fulfillRandomness(bytes32 requestId, uint256 randomness) internal override {
        randomResult = randomness;
    }

    function oddOrEven(bool yourGuess) external payable returns (bool) {
        bytes32 requestId = requestRandomness();
        uint256 randomValue = uint256(keccak256(abi.encodePacked(randomResult, block.timestamp)));
        
        if ((randomValue % 2 == 0) == yourGuess) {
            uint fee = msg.value / 10;
            payable(msg.sender).transfer(msg.value * 2 - fee);
            return true;
        }
        return false;
    }
}
