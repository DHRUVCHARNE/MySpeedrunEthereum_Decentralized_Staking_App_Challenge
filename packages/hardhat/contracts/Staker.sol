// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "hardhat/console.sol";
import "./ExampleExternalContract.sol";

contract Staker {
    event Stake(address indexed staker, uint256 amount);

    uint256 public constant THRESHOLD = 1 ether;
    uint256 public deadline;
    mapping(address => uint256) public balances;
    bool public openForWithdraw;
    ExampleExternalContract public exampleExternalContract;

    constructor(address exampleExternalContractAddress) {
        exampleExternalContract = ExampleExternalContract(exampleExternalContractAddress);
        deadline = block.timestamp + 1000 hours;
    }

    modifier notCompleted() {
        require(!exampleExternalContract.completed(), "Already completed");
        _;
    }

    function stake() public payable notCompleted {
        require(msg.value > 0, "Stake amount must be greater than zero");
        require(block.timestamp < deadline, "Deadline has passed");
        balances[msg.sender] += msg.value;
        emit Stake(msg.sender, msg.value);
    }

    function execute() public notCompleted {
        require(block.timestamp >= deadline, "Deadline not yet reached");

        if (address(this).balance >= THRESHOLD) {
            exampleExternalContract.complete{value: address(this).balance}();
        } else {
            openForWithdraw = true;
        }
    }

    function withdraw() public notCompleted {
        require(openForWithdraw, "Withdrawals not open");
        uint256 userBalance = balances[msg.sender];
        require(userBalance > 0, "No balance to withdraw");

        balances[msg.sender] = 0;
        (bool success, ) = payable(msg.sender).call{value: userBalance}("");
        require(success, "Withdraw failed");
    }

    function timeLeft() public view returns (uint256) {
        if (block.timestamp >= deadline) return 0;
        return deadline - block.timestamp;
    }

    receive() external payable {
        stake();
    }
}
