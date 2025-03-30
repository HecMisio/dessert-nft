# Dessert NFT - Mood-Based NFT Project

**Dessert NFT** is a blockchain-based project built with **Foundry**, featuring two types of NFTs: `BasicNft` and `MoodNft`.This is a project for learning. You can find the corresponding courses <a herf="https://updraft.cyfrin.io/courses/advanced-foundry">here</a>.

- **BasicNft**: A simple NFT implementation with metadata stored on IPFS.
- **MoodNft**: A dynamic NFT that reflects different moods (e.g., Happy, Sad, Angry, Excited, Bored) and is fully on-chain, including metadata and SVG images.

---

## **Project Overview**

This project uses the following tools and technologies:

- **Foundry**: A fast, portable, and modular toolkit for Ethereum development.
- **Solidity**: The programming language for writing smart contracts.
- **OpenZeppelin**: A library for secure and reusable smart contract components.
- **IPFS**: For storing and retrieving metadata and images (used in `BasicNft`).

The core functionality includes:

- Minting NFTs with static metadata (`BasicNft`).
- Minting NFTs with dynamic mood-based states (`MoodNft`).
- Changing the mood of a `MoodNft`.
- Fully on-chain metadata and SVG rendering for `MoodNft`.

---

## **BasicNft**

The `BasicNft` contract is a simple implementation of an NFT that stores its metadata on IPFS. It is designed to demonstrate the basic functionality of an ERC721 token.

### **Features**

- **IPFS Metadata**: Metadata for each NFT is stored on IPFS, ensuring decentralized and persistent storage.
- **Minting**: Users can mint NFTs with predefined metadata URIs.
- **ERC721 Compliance**: Fully compliant with the ERC721 standard, including metadata extensions.

### **Usage**

1. **Deploy BasicNft Contract**
   - Deploy the `BasicNft` contract to the specified network.
   - Command:

     ```bash
     make deploy
     ```

2. **Mint a BasicNft**
   - Mint a new `BasicNft` token.
   - Command:

     ```bash
     make mint
     ```

---

## **MoodNft**

The `MoodNft` contract is a dynamic NFT implementation where each token represents a specific mood (e.g., Happy, Sad, Angry, Excited, Bored). The metadata and SVG images are fully stored on-chain, making it a completely decentralized solution.

### **Features**

- **Dynamic Mood States**: Each NFT can change its mood dynamically, reflecting different states.
- **On-Chain Metadata**: Metadata and SVG images are fully stored on-chain, ensuring immutability and decentralization.
- **Mood Transitions**: Owners or approved addresses can change the mood of an NFT.
- **ERC721 Compliance**: Fully compliant with the ERC721 standard, including metadata extensions.

### **Usage**

1. **Deploy MoodNft Contract**
   - Deploy the `MoodNft` contract to the specified network.
   - Command:

     ```bash
     make deploy-mood
     ```

2. **Mint a MoodNft**
   - Mint a new `MoodNft` token.
   - Command:

     ```bash
     make mint-mood
     ```

3. **Change Mood of a MoodNft**
   - Change the mood of an existing `MoodNft` token.
   - Command:

     ```bash
     make change-mood
     ```

---

## **Environment Variables**

The `Makefile` uses the following environment variables to configure the network and account details:

- **`LOCAL_ACCOUNT`**: The private key of the local account.
- **`SEPOLIA_RPC_URL`**: The RPC URL for the Sepolia testnet.
- **`SEPOLIA_ACCOUNT`**: The private key of the account for Sepolia.
- **`ETHERSCAN_API_KEY`**: The API key for verifying contracts on Etherscan.

You can define these variables in a `.env` file for convenience.

---

## **Example `.env` File**

```plaintext
LOCAL_ACCOUNT=0xYOUR_LOCAL_PRIVATE_KEY
SEPOLIA_RPC_URL=https://sepolia.infura.io/v3/YOUR_INFURA_PROJECT_ID
SEPOLIA_ACCOUNT=0xYOUR_SEPOLIA_PRIVATE_KEY
ETHERSCAN_API_KEY=YOUR_ETHERSCAN_API_KEY
```

---

## **Notes**

- Ensure you have installed Foundry and configured the environment variables before running the commands.
- Use the `--network` flag in `ARGS` to specify the target network (e.g., `--network sepolia`).

---
