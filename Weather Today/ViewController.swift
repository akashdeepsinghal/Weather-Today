//
//  ViewController.swift
//  Weather Today
//
//  Created by Akash Singhal on 15/11/16.
//  Copyright © 2016 Akash Singhal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?zip=london,uk&appid=3ee8177904d514f2cc9645f283cc8416&units=metric")!
        
        let task = URLSession.shared.dataTask(with: url){(data, response, error) in
            if error != nil {
                print(error ?? "Some error fetching data from URL")
            } else {
                if let urlContent = data{
                    do {
                        let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers)
                        
                        print(jsonResult)
                    } catch {
                        print("JSON Serialization failed!")
                    }
                }
            }
        }
        
        task.resume()
        
//        dataTask(with: url, completionHandler: (data, response, error) -> Void)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

