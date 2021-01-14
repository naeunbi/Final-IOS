//
//  TestViewController.swift
//  ios timer 1
//
//  Created by 나은비 on 2021/01/14.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet weak var Label_Test: UILabel!
     
    override func viewDidLoad() {
        Label_Test.transform = CGAffineTransform(translationX: 0, y: 50)
        super.viewDidLoad()

    }
    @IBAction func Button_Animation(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5, animations: {
            self.Label_Test.transform = CGAffineTransform(translationX: 0, y: 0)
    })
    }
}
