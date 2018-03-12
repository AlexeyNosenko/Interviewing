//
//  CoreAnimationViewController.swift
//  Interviewing
//
//  Created by Алексей on 04.12.17.
//  Copyright © 2017 Алексей. All rights reserved.
//

import UIKit

class CoreAnimationViewController: UIViewController {

    var action: Actions!
    
    @IBOutlet weak var btnStart: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: Actions
    @IBAction func start(_ sender: UIButton) {
        switch action {
        case .baseAnimation:
            baseAnimation()
        case .keyAnimation:
            keyFrameAnimation()
        case .transition:
            transitionAnimation()
        case .animationGroup:
            animationGroup()
        case .block:
            blockAnimation()
        case .animation:
            animationAnimation()
        default:
            return
        }
    }

    // MARK: Methods
    
    func baseAnimation(){
        let animation = CABasicAnimation.init(keyPath: "position")
        animation.fromValue = CGPoint.init(x: btnStart.frame.origin.x, y: btnStart.frame.origin.y)
        let addedHeight = self.navigationController?.navigationBar.intrinsicContentSize.height ?? 0.0
        print(addedHeight)
        animation.toValue = CGPoint.init(x: btnStart.frame.size.width / 2, y: addedHeight + btnStart.frame.size.height / 2)
        animation.duration = 2.0
        animation.autoreverses = true
        animation.repeatCount = 3
        btnStart.layer.add(animation, forKey: "aMoved")
    }
    
    func keyFrameAnimation(){
        let animation = CAKeyframeAnimation()
        let pointArray = [CGPoint.init(x: btnStart.frame.origin.x, y: btnStart.frame.origin.y),
                          CGPoint.init(x: 50.0, y: 200.0),
                          CGPoint.init(x: 200.0, y: 100.0)]
        animation.values = pointArray
        animation.keyPath = "position"
        animation.duration = 2.0
        animation.autoreverses = true
        animation.repeatCount = 3
        btnStart.layer.add(animation, forKey: "aMoved")
    }
    
    func transitionAnimation(){
        let animation = CATransition()
        animation.duration = 2.5
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        animation.type = kCATransitionFade
        let coreView = CoreAnimationTableViewController()
        self.navigationController?.view.layer.add(animation, forKey: nil)
        self.navigationController?.pushViewController(coreView, animated: false)
    }
    
    func animationGroup(){
        var animations = [CABasicAnimation]()
        let posAnimation = CABasicAnimation(keyPath: "position")
        posAnimation.duration = 10.0
        posAnimation.autoreverses = true
        posAnimation.fromValue = CGPoint(x: 0, y: self.btnStart.frame.origin.y)
        posAnimation.toValue = CGPoint(x: self.view.frame.size.width, y: self.btnStart.frame.origin.y)
        animations.append(posAnimation)
        
        let heightAnimation = CABasicAnimation(keyPath: "bounds.size")
        heightAnimation.autoreverses = true
        heightAnimation.duration = 10.0
        heightAnimation.fromValue =  CGSize(width: self.btnStart.frame.size.width, height: self.btnStart.frame.size.height)
        heightAnimation.toValue = CGSize(width: self.btnStart.frame.size.width, height: 200.0)
        heightAnimation.beginTime = 5.0
        animations.append(heightAnimation)
        
        let group = CAAnimationGroup()
        group.duration = 10.0
        group.animations = animations
        self.btnStart.layer.add(group, forKey: "nil")
    }
    
    func blockAnimation(){
        UIView.transition(with: self.view, duration: 1.5, options: .transitionFlipFromTop, animations: {
            let iView = UIImageView.init(image: #imageLiteral(resourceName: "bird_red"))
            iView.frame = CGRect.init(x: 100, y: 100, width: 100, height: 100)
            self.view.addSubview(iView)
        }, completion: nil)
    }
    
    func animationAnimation(){
        imageView.isHidden = false
        var img = [UIImage]()
        img.append(#imageLiteral(resourceName: "bird_red"))
        img.append(#imageLiteral(resourceName: "bird_red1"))
        img.append(#imageLiteral(resourceName: "bird_blue"))
        imageView.animationImages = img
        imageView.animationDuration = 2.5
        imageView.startAnimating()
    }
    
    
}

enum Actions{
    case baseAnimation
    case keyAnimation
    case transition
    case animationGroup
    case block
    case animation
}
