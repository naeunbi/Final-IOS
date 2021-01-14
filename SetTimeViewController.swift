//
//  SetTimeViewController.swift
//  ios timer 1
//
//  Created by 나은비 on 2021/01/14.
//

import UIKit

class SetTimeViewController: UIViewController {

    @IBOutlet weak var Label_alltime: UILabel!
    @IBOutlet weak var Label_timer: UILabel!
    @IBOutlet weak var Text_H1: UITextField!
    @IBOutlet weak var Text_M1: UITextField!
    @IBOutlet weak var Text_H2: UITextField!
    @IBOutlet weak var Text_M2: UITextField!
    
    var H1: Int = 8
    var M1: Int = 0
    var H2: Int = 0
    var M2: Int = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Text_H1.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        Text_M1.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        Text_H2.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        Text_M2.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
    }
    @objc func textFieldDidChange(textField: UITextField){
//        총 목표시간, 타이머 시간을 자동으로 계산해서 보여줄 생각
        if(Text_H1.text !="")
        {
            H1 = Int(Text_H1.text!)! 
    }
    @IBAction func Button_SET(_ sender: UIButton) {
    }
    
}

}
