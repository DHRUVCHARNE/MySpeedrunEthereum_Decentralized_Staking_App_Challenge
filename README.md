# 🔏 Decentralized Staking App

A beginner-friendly decentralized application (dApp) that allows users to stake ETH in a smart contract. The app coordinates a group funding effort and interacts with an external contract, demonstrating the power of Ethereum for trustless cooperation.

---

## 🌟 Skills You’ll Gain

- Design and implement a decentralized application (dApp) with a state machine.
- Handle and send ETH in a smart contract using `payable` functions.
- Interact with external smart contracts.
- Use events to track and display on-chain activity on the frontend.

---

## 🏗 Challenge Overview

A superpower of Ethereum is allowing builders to create a simple set of rules that an adversarial group of players can use to work together. In this challenge:

- Users can stake ETH using the `Staker.sol` contract.
- If the threshold ETH is met before the deadline, the contract sends the balance to an `ExampleExternalContract` and triggers the `complete()` action.
- If the threshold is not met, users can safely withdraw their stakes.
- The frontend displays staker information and event activity in real-time using the `Stake` event.

---

## 📜 Contracts

- **Staker.sol** – [View on Etherscan](https://sepolia.etherscan.io/address/0x6d8b4da09e3514363395f6e4e3010d0d2da0bff2)  
  Collects ETH stakes, tracks balances, and interacts with the external contract.

- **ExampleExternalContract.sol** – [View on Etherscan](https://sepolia.etherscan.io/address/0x35f383d4864cd70f7ce9e4a666e04c5be42e03ae)  
  Receives ETH from `Staker.sol` when the staking threshold is reached.

---

## 💻 Frontend

- Built with Next.js
- Displays staker balances, deadlines, and on-chain events
- Allows users to stake ETH directly from the browser

**Frontend URL:** [here](https://my-staking-dapp-zeta.vercel.app/)

---

## 🛠 How It Works

1. Users call `stake()` on `Staker.sol` with ETH.
2. `Staker.sol` keeps track of all staker balances and deadlines.
3. If the contract balance meets the threshold by the deadline:
   - ETH is sent to `ExampleExternalContract`.
   - The `complete()` function is triggered.
4. If not enough ETH is collected, users can safely withdraw using `withdraw()`.
5. All stakes are tracked on-chain using the `Stake(address, uint256)` event.

> **Note:** If named arguments are used in the event (e.g., `event Stake(address indexed staker, uint256 amount)`), ensure the frontend references them by name instead of numeric indices.

---

## ⏱ Time to Complete

3 – 8 hours

---

## 🎓 Skill Level

Beginner

---

## 🔗 Helpful Links

- [SpeedRunEthereum Profile](https://speedrunethereum.com/builders/0x337c6Cc82221266B951f773E1AbD81eA0354ff25)  
- [Solidity by Example](https://solidity-by-example.org/)  
- [Previous Challenge](https://speedrunethereum.com/challenges)

---

## 🚀 Deployment

- Deploy contracts to Sepolia or other Ethereum testnets.
- Deploy the frontend using Vercel:  

```bash
yarn vercel
