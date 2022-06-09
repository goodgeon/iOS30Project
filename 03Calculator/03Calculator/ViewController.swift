//
//  ViewController.swift
//  03Calculator
//
//  Created by 李 グッゴン on 2022/06/09.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button7: RoundButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("viewDidLoad")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear")
    }
    
    override func viewDidLayoutSubviews() {
        print("viewDidLayoutSubviews")
//        button7.layer.cornerRadius = button7.frame.height / 2
        button7.isRound = true
    }


}

