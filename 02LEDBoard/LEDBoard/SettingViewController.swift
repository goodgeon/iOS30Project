//
//  SettingViewController.swift
//  LEDBoard
//
//  Created by 李 グッゴン on 2022/04/11.
//

import Foundation
import UIKit

class SettingViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var purpleButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var blackButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var orangeButton: UIButton!
    
    var ledText: String?
    var textColor: UIColor = .yellow
    var backgroundColor: UIColor = .black
    
    weak var delegate: LEDBoardSettingDelegate?
    
    override func viewDidLoad() {
        configureView()
    }
    
    func configureView() {
        textField.text = ledText
        setTextColor(textColor: textColor)
        setBackgroundColor(backgroundColor: backgroundColor)
    }
    
    @IBAction func textColorButtonAction(_ sender: UIButton) {
        if sender == yellowButton {
            self.textColor = .yellow
            setTextColor(textColor: .yellow)
        } else if sender == purpleButton {
            self.textColor = .purple
            setTextColor(textColor: .purple)
        } else {
            self.textColor = .green
            setTextColor(textColor: .green)
        }
    }
    
    @IBAction func backgroundColorButtonAction(_ sender: UIButton) {
        if sender == blackButton {
            self.backgroundColor = .black
            setBackgroundColor(backgroundColor: .black)
        } else if sender == blueButton {
            self.backgroundColor = .blue
            setBackgroundColor(backgroundColor: .blue)
        } else {
            self.backgroundColor = .orange
            setBackgroundColor(backgroundColor: .orange)
        }
    }
    
    func setTextColor(textColor: UIColor) {
        yellowButton.alpha = textColor == .yellow ? 1 : 0.2
        purpleButton.alpha = textColor == .purple ? 1 : 0.2
        greenButton.alpha = textColor == .green ? 1 : 0.2
    }
    
    func setBackgroundColor(backgroundColor : UIColor) {
        blackButton.alpha = backgroundColor == .black ? 1 : 0.2
        blueButton.alpha = backgroundColor == .blue ? 1 : 0.2
        orangeButton.alpha = backgroundColor == .orange ? 1 : 0.2
    }
    
    @IBAction func saveButtonAction(_ sender: UIButton) {
        self.delegate?.saveSetting(text: self.textField.text, textColor: self.textColor, backgroundColor: self.backgroundColor)
        self.navigationController?.popViewController(animated: true)
    }
}
