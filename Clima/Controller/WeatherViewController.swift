//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var searchTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
    }
    
    

    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        //keyboard退出
        print(searchTextField.text!)
    }
    
    // textfield生命周期：处理键盘回车
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(searchTextField.text!)
        //keyboard退出
        searchTextField.endEditing(true)
        return true
    }
    
    //textfield生命周期：验证是否应该结束编辑
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            //如果未输入内容，不应该结束编辑，返回false
            textField.placeholder = "Type something"
            return false
        }
    }
    
    //textfield生命周期：完成编辑
    func textFieldDidEndEditing(_ textField: UITextField) {
        // Use searchTextFied.text to get the weather for that city.
        //清空输入框
        searchTextField.text = ""
    }
    
}

