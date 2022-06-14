//
//  ViewController.swift
//  03Calculator
//
//  Created by 李 グッゴン on 2022/06/09.
//

import UIKit
enum Operation {
    case Add
    case Subtract
    case Divide
    case Multiply
    case unknown
}

class ViewController: UIViewController {
    @IBOutlet weak var numberOutputLabel: UILabel!
    
    var displayNumber = ""
    var firstOperand = ""
    var secondOperand = ""
    var result = ""
    var currentOperation: Operation = .unknown
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func tapNumberButton(_ sender: UIButton) {
        guard let numberValue = sender.title(for: .normal) else { return }
                
        if displayNumber.count < 9 {
            displayNumber += numberValue
            numberOutputLabel.text = displayNumber
        }
    }
    
    @IBAction func tapClearButton(_ sender: UIButton) {
        displayNumber = ""
        firstOperand = ""
        secondOperand = ""
        result = ""
        numberOutputLabel.text = "0"
        currentOperation = .unknown
    }
    
    @IBAction func tapDotButton(_ sender: UIButton) {
        if displayNumber.count < 8, !displayNumber.contains(".") {
            displayNumber += self.displayNumber.isEmpty ? "0." : "."
            numberOutputLabel.text = displayNumber
        }
    }
    
    @IBAction func tapDivideButton(_ sender: UIButton) {
        operation(.Divide)
    }
    
    @IBAction func tapMultiplyButton(_ sender: UIButton) {
        operation(.Multiply)
    }
    
    @IBAction func tapSubtractButton(_ sender: UIButton) {
        operation(.Subtract)
    }
    
    @IBAction func tapPlusButton(_ sender: UIButton) {
        operation(.Add)
    }
    
    @IBAction func tapEqualButton(_ sender: UIButton) {
        operation(currentOperation)
    }
    
    func operation(_ operation: Operation) {
        if currentOperation != .unknown {
            if !displayNumber.isEmpty {
                secondOperand = displayNumber
                displayNumber = ""

                guard let firstOperand = Double(firstOperand) else { return }
                guard let secondOperand = Double(secondOperand) else { return }
                
                switch(currentOperation) {
                case .Add:
                    result = "\(firstOperand + secondOperand)"
                case .Subtract:
                    result = "\(firstOperand - secondOperand)"
                case .Divide:
                    result = "\(firstOperand / secondOperand)"
                case .Multiply:
                    result = "\(firstOperand * secondOperand)"
                case .unknown:
                    break
                }

                
                if let result = Double(result), result.truncatingRemainder(dividingBy: 1) == 0 {
                    self.result = "\(Int(result))"
                }
                
                self.firstOperand = result
                numberOutputLabel.text = result
                return
            }
            
            currentOperation = operation
        } else {
            firstOperand = displayNumber
            currentOperation = operation
            displayNumber = ""
            
        }
    }
}

