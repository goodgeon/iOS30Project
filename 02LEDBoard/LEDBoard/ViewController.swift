//
//  ViewController.swift
//  LEDBoard
//
//  Created by 李 グッゴン on 2022/04/11.
//

import UIKit

protocol LEDBoardSettingDelegate: AnyObject {
    func saveSetting(text: String?, textColor: UIColor, backgroundColor: UIColor)
}

class ViewController: UIViewController, LEDBoardSettingDelegate {
    @IBOutlet weak var contentsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.shadowImage = nil
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let settingVC = segue.destination as? SettingViewController {
            settingVC.delegate = self
            settingVC.ledText = self.contentsLabel.text
            settingVC.textColor = self.contentsLabel.textColor
            settingVC.backgroundColor = self.view.backgroundColor ?? .black
        }
    }
    
    func saveSetting(text: String?, textColor: UIColor, backgroundColor: UIColor) {
        self.contentsLabel.text = text
        self.contentsLabel.textColor = textColor
        self.view.backgroundColor = backgroundColor
    }


}

