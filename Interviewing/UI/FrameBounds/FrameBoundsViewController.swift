//
//  FrameBoundsViewController.swift
//  Interviewing
//
//  Created by Алексей on 29.11.17.
//  Copyright © 2017 Алексей. All rights reserved.
//

import UIKit

class FrameBoundsViewController: UIViewController {

    @IBOutlet weak var movedLabel: UILabel!
    
    @IBOutlet weak var infoTextView: UITextView!
    
    func move(recognizer: UIPanGestureRecognizer){
        let translation = recognizer.translation(in: self.view)
        if let view = recognizer.view {
            view.center = CGPoint(x:view.center.x + translation.x,
                                  y:view.center.y + translation.y)
        }
        recognizer.setTranslation(CGPoint.zero, in: self.view)
        showPosition()
    }
    
    func showPosition(){
        let position =  "b.x = \(movedLabel.bounds.origin.x) \n" +
                        " b.y = \(movedLabel.bounds.origin.y) \n" +
                        " b.h = \(movedLabel.bounds.size.height) \n" +
                        " b.w = \(movedLabel.bounds.size.width) \n" +
                        " f.x = \(movedLabel.frame.origin.x) \n" +
                        " f.y = \(movedLabel.frame.origin.y) \n" +
                        " f.h = \(movedLabel.frame.size.height) \n" +
                        " f.w = \(movedLabel.frame.size.width) \n"
        print(position)
        infoTextView.text = position
    }
    
    @IBAction func moved(_ sender: UIPanGestureRecognizer) {
        move(recognizer: sender)
    }
    

}
