// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {BasicNft} from "src/BasicNft.sol";
import {console} from "forge-std/console.sol";

contract DeployBasicNft is Script {
    function run() external returns (BasicNft) {
        vm.startBroadcast();
        // Deploy the BasicNft contract
        BasicNft basicNft = new BasicNft();
        vm.stopBroadcast();

        // Log the address of the deployed contract
        console.log("BasicNft deployed to:", address(basicNft));
        return basicNft;
    }
}
