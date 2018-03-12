//
//  JSONViewController.swift
//  Interviewing
//
//  Created by Алексей on 25.12.2017.
//  Copyright © 2017 Алексей. All rights reserved.
//

import UIKit

class JSONViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Actions
    @IBAction func parse(_ sender: Any) {
        var json = textView.text!
        
        // Decoder
        var jsonData = json.data(using: .utf8)!
        let decoder = JSONDecoder()
        let city = try! decoder.decode(City.self, from: jsonData)
        print(city)
        print("City name: \(city.name)")
        print("temp: \(city.main.temp)")
        
        // Encoder
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        jsonData = try! encoder.encode(city)
        json = String.init(data: jsonData, encoding: .utf8)!
        print("JSON = \(json)")
    }
}
