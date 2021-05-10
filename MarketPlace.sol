// SPDX-License-Identifier: MIT
pragma solidity ^0.5.0;

contract MarketPlace {
    address public seller;
    address public buyer;
    mapping (address=>uint) public balances;

    event ListItem(address seller, uint price);
    event PurchasedItem(address seller, address buyer, uint price);

    enum StateType {
        ItemAvailable,
        ItemPurchased
    }

    StateType public State;

    constructor() public {
        seller = msg.sender;
        State = StateType.ItemAvailable;
    }

    function buy(address _seller, address _buyer, uint _price) public payable {
        require(_price <=balances[buyer], "Insufficient Balance");
        State = StateType.ItemPurchased;
        balances[_buyer] -= _price;
        balances[_seller] += _price;

        emit PurchasedItem(_seller, _buyer, msg.value);
    }
}