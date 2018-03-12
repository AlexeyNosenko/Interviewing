//
//  LiveCicleViewController.swift
//  Interviewing
//
//  Created by Алексей on 29.11.17.
//  Copyright © 2017 Алексей. All rights reserved.
//

import UIKit

class LiveCicleViewController: UIViewController{
    
    // MARK: outlets
    @IBOutlet weak var textView: UITextView!
    
    var message = "" {
        didSet{
            if let tv = textView{
                tv.text = message
            }
        }
    }
    
    // MARK: viewController override
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("view DidDisappears")
        message.append("view DidDisappears \n")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("view DIdAppear")
        super.viewDidAppear(animated)
        message.append("view DidAppear \n")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("view WillDisappear")
        super.viewWillDisappear(animated)
        message.append("view WillDisappear \n")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("view WillAppear")
        super.viewWillAppear(animated)
        message.append("view WillAppear \n")
    }
 
    override func viewDidLoad() {
        print("view DidLoad")
        super.viewDidLoad()
        message.append("view DidLoad \n")
    }
}
