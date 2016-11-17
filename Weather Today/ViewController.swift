//
//  ViewController.swift
//  Weather Today
//
//  Created by Akash Singhal on 15/11/16.
//  Copyright © 2016 Akash Singhal. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class ViewController: UIViewController {
    
    
    @IBOutlet var cityInput: UITextField!
    @IBOutlet var city: UILabel!
    @IBOutlet var tempDesc: UILabel!
    @IBOutlet var temperature: UILabel!
    
    @IBAction func submit(_ sender: Any) {
        view.endEditing(true)
        self.hideKeyboardWhenTappedAround()
        Alamofire.request("http://api.openweathermap.org/data/2.5/weather?q="+self.cityInput.text!+"&appid=3ee8177904d514f2cc9645f283cc8416&units=metric").responseData { (resData) -> Void in
            if((resData.result.value) != nil) {
                let swiftyJsonVar = JSON(data : resData.result.value!)
//                    resData.result.value!
                print(swiftyJsonVar)
                
                let cityName = swiftyJsonVar["name"].rawString()
                let weatherDesc = swiftyJsonVar["weather"][0]["description"].rawString()?.uppercased()
                let mainTemp = swiftyJsonVar["main"]["temp"].rawString()
                DispatchQueue.main.async {
                    self.city.text = cityName
                    self.tempDesc.text = weatherDesc
                    self.temperature.text = mainTemp! + "º"
                    self.city.alpha = 1
                    self.tempDesc.alpha = 1
                    self.temperature.alpha = 1
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// Put this piece of code anywhere you like
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
