// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Script.sol";
import "../src/token.sol";

contract DeployToken is Script {
    function run() external {
        vm.startBroadcast(); 

        TT token = new TT(); 

        vm.stopBroadcast();

        console.log("token contract deployed at: ", address(token)); 
    }
}