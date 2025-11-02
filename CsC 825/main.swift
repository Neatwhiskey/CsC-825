//
//  main.swift
//  CsC 825
//
//  Created by Jamaaldeen Opasina on 02/11/2025.
//

import Foundation

    // MARK: - Abstraction
    // Define a general class for all account types
class BankAccount {
        // MARK: - Encapsulation
    private var balance: Double
    let accountNumber: String
    let ownerName: String
    
    init(accountNumber: String, ownerName: String, initialBalance: Double) {
        self.accountNumber = accountNumber
        self.ownerName = ownerName
        self.balance = initialBalance
    }
    
    func deposit(amount: Double) {
        guard amount > 0 else {
            print("❌ Deposit amount must be positive.")
            return
        }
        balance += amount
        print("✅ ₦\(amount) deposited successfully.")
    }
    
    func withdraw(amount: Double) {
        guard amount > 0 else {
            print("❌ Withdrawal amount must be positive.")
            return
        }
        if amount <= balance {
            balance -= amount
            print("✅ ₦\(amount) withdrawn successfully.")
        } else {
            print("❌ Insufficient funds.")
        }
    }
    
    func calculateInterest() -> Double {
        return 0.0
    }
    
    func getBalance() -> Double {
        return balance
    }
}

    // MARK: - Inheritance
class SavingsAccount: BankAccount {
    private let interestRate: Double = 0.05
    
    override func calculateInterest() -> Double {
        return getBalance() * interestRate
    }
}

class CurrentAccount: BankAccount {
    private let serviceCharge: Double = 50.0
    
    override func withdraw(amount: Double) {
        let total = amount + serviceCharge
        print("ℹ️ Service charge of ₦\(serviceCharge) applied.")
        super.withdraw(amount: total)
    }
}

    // MARK: - Polymorphism in Action
class Bank {
    private var accounts: [BankAccount] = []
    
    func createAccount() {
        print("Enter account type (1 for Savings, 2 for Current): ", terminator: "")
        guard let typeInput = readLine(),
              let type = Int(typeInput),
              (1...2).contains(type) else {
            print("❌ Invalid input.")
            return
        }
        
        print("Enter account number: ", terminator: "")
        guard let accNum = readLine(), !accNum.isEmpty else {
            print("❌ Invalid account number.")
            return
        }
        
        print("Enter account owner name: ", terminator: "")
        guard let name = readLine(), !name.isEmpty else {
            print("❌ Invalid name.")
            return
        }
        
        print("Enter initial deposit: ", terminator: "")
        guard let balInput = readLine(),
              let balance = Double(balInput), balance >= 0 else {
            print("❌ Invalid amount.")
            return
        }
        
        let account: BankAccount
        if type == 1 {
            account = SavingsAccount(accountNumber: accNum, ownerName: name, initialBalance: balance)
        } else {
            account = CurrentAccount(accountNumber: accNum, ownerName: name, initialBalance: balance)
        }
        
        accounts.append(account)
        print("✅ Account for \(name) created successfully.\n")
    }
    
    func depositToAccount() {
        print("Enter account number: ", terminator: "")
        guard let accNum = readLine(),
              let account = findAccount(accNum) else {
            print("❌ Account not found.")
            return
        }
        
        print("Enter deposit amount: ", terminator: "")
        if let input = readLine(), let amount = Double(input) {
            account.deposit(amount: amount)
        } else {
            print("❌ Invalid amount.")
        }
    }
    
    func withdrawFromAccount() {
        print("Enter account number: ", terminator: "")
        guard let accNum = readLine(),
              let account = findAccount(accNum) else {
            print("❌ Account not found.")
            return
        }
        
        print("Enter withdrawal amount: ", terminator: "")
        if let input = readLine(), let amount = Double(input) {
            account.withdraw(amount: amount)
        } else {
            print("❌ Invalid amount.")
        }
    }
    
    func checkBalance() {
        print("Enter account number: ", terminator: "")
        guard let accNum = readLine(),
              let account = findAccount(accNum) else {
            print("❌ Account not found.")
            return
        }
        
        print("💰 \(account.ownerName)'s balance: ₦\(account.getBalance())")
    }
    
    func calculateInterest() {
        print("Enter account number: ", terminator: "")
        guard let accNum = readLine(),
              let account = findAccount(accNum) else {
            print("❌ Account not found.")
            return
        }
        
        let interest = account.calculateInterest()
        if interest > 0 {
            print("💵 Interest earned: ₦\(interest)")
        } else {
            print("ℹ️ No interest applicable for this account type.")
        }
    }
    
    private func findAccount(_ number: String) -> BankAccount? {
        return accounts.first { $0.accountNumber == number }
    }
}

    // MARK: - Program Execution
let bank = Bank()

while true {
    print("""
    \n=== Swift Bank System ===
    1. Create Account
    2. Deposit
    3. Withdraw
    4. Check Balance
    5. Calculate Interest
    6. Exit
    Enter your choice: 
    """, terminator: "")
    
    guard let choiceInput = readLine(),
          let choice = Int(choiceInput) else {
        print("❌ Invalid input.")
        continue
    }
    
    switch choice {
    case 1:
        bank.createAccount()
    case 2:
        bank.depositToAccount()
    case 3:
        bank.withdrawFromAccount()
    case 4:
        bank.checkBalance()
    case 5:
        bank.calculateInterest()
    case 6:
        print("👋 Exiting program...")
        exit(0)
    default:
        print("❌ Invalid choice. Try again.")
    }
}


