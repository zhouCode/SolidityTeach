// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface Test {}

interface Test2 is Test {}

interface IOrderBook {
    struct Order {
        address owner;
        uint price;
        uint quantity;
    }
    function getOrder(uint id) external view returns (Order memory);
}

interface IStatus {
    enum Status {
        Pending,
        Complete
    }
    function getStatus() external view returns (Status);
}
