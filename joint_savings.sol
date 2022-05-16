
pragma solidity ^0.5.0;


// Define the contract JointSavings
contract JointSavings {

    address payable accountOne;
    address payable accountTwo;
    address public lastToWithdraw;
    uint public lastWithdrawAmount;
    uint public contractBalance;


    function withdraw(uint amount, address payable recipient) public {

        // Define a `require` statement that checks if the `recipient` is equal to either `accountOne` or `accountTwo`.
        // The `requiere` statement returns an error.
        require(recipient == accountOne || recipient == accountTwo, "You don't own this account!");

        // Define a `require` statement that checks if the `balance` is sufficient to accomplish the withdraw operation.
        // Return an error if there are insufficient funds.
        require(amount <= contractBalance, "Insufficient funds!");

        // Check if the `lastToWithdraw` is not equal to to `recipient` If `lastToWithdraw` is not equal,
        // then set it to the current value of `recipient`.
        if(lastToWithdraw != recipient) {
            lastToWithdraw = recipient;
        }

        // Call the `transfer` function of the `recipient` and pass it the `amount` to transfer as an argument.
        recipient.transfer(amount);

        // Set  `lastWithdrawAmount` equal to `amount`
        lastWithdrawAmount = amount;

        // Set `contractBalance` equal to the balance of the contract to reflect the new balance of the contract.
        contractBalance = address(this).balance;
    }

    // Define a `public payable` function named `deposit`.
    function deposit() public payable {

        // Set `contractBalance` equal to the balance of the contract to reflect the new balance of the contract.
        contractBalance = address(this).balance;
    }

    // Define a `public` function named `setAccounts` that receive two `address payable` arguments named `account1` and `account2`.
    function setAccounts(address payable account1, address payable account2) public{

        // Set the values of `accountOne` and `accountTwo` to `account1` and `account2` respectively.
        accountOne = account1;
        accountTwo = account2;
    }

    // Add the **default fallback function** so that your contract can store Ether sent from outside the deposit function.
    function() external payable {}
}
