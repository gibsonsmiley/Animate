//
//  ViewController.swift
//  Animate
//
//  Created by Taylor Mott on 11/16/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var yConstraint: NSLayoutConstraint?
    var drawerShown = true

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let ghostImageView = UIImageView(frame: CGRectMake(157, 357, 100, 100))
        ghostImageView.image = UIImage(named: "ghost")
        view.addSubview(ghostImageView)
        
        let happyGhostImageView = UIImageView(frame: CGRectMake(207, 557, 50, 50))
        happyGhostImageView.image = UIImage(named: "happyGhost")
        view.addSubview(happyGhostImageView)
        
        ghostImageView.alpha = 0.0
        
        let rotateTransform = CGAffineTransformMakeRotation(CGFloat(M_PI))
        let scaleTransform = CGAffineTransformMakeScale(2.0, 2.0)
        
        UIView.animateWithDuration(2.0) { () -> Void in
            ghostImageView.alpha = 1.0
            ghostImageView.center = CGPoint(x: ghostImageView.center.x, y: ghostImageView.center.y - 200)
//            ghostImageView.transform = CGAffineTransformConcat(rotateTransform, scaleTransform)
            ghostImageView.transform = rotateTransform
            ghostImageView.transform = scaleTransform
            
            happyGhostImageView.alpha = 0.0
            happyGhostImageView.transform = scaleTransform
            happyGhostImageView.center = CGPoint(x: happyGhostImageView.center.x, y: happyGhostImageView.center.y - 125)
        }
        
        let rocketImageView = UIImageView(frame: CGRectMake(-100, 275, 75, 75))
        rocketImageView.image = UIImage(named: "rocket")
        view.addSubview(rocketImageView)
        
        let basicAnimation = CABasicAnimation()
        basicAnimation.keyPath = "position.x"
        basicAnimation.fromValue = rocketImageView.center.x
        basicAnimation.toValue = rocketImageView.center.x + 750
        basicAnimation.duration = 1.5
        rocketImageView.layer.addAnimation(basicAnimation, forKey: "launchAnimation")
        rocketImageView.center.x += 750
        
        let passwordImageView = UIImageView(frame: CGRect(x: 58, y: 355, width: 298, height: 71))
        passwordImageView.image = UIImage(named: "password")
        view.addSubview(passwordImageView)
        
        let shakeAnimation = CAKeyframeAnimation()
        shakeAnimation.keyPath = "position.x"
        shakeAnimation.values = [0, 10, -10, 0]
        shakeAnimation.keyTimes = [0, 1/6.0, 3/6.0, 5/6.0, 1.0]
        shakeAnimation.duration = 1.0
        shakeAnimation.additive = true
        passwordImageView.layer.addAnimation(shakeAnimation, forKey: "shake")
        
        let earthImageView = UIImageView(frame: CGRectMake(157, 515, 100, 100))
        earthImageView.image = UIImage(named: "earth")
        view.addSubview(earthImageView)
        
        let satelliteImageView = UIImageView(frame: CGRectMake(157, 515, 50, 50))
        satelliteImageView.image = UIImage(named: "satellite")
        view.addSubview(satelliteImageView)
        
        let boundRect = CGRectMake(-60, -60, 170, 170)

        let orbitAnimation = CAKeyframeAnimation()
        orbitAnimation.keyPath = "position"
        orbitAnimation.path = CGPathCreateWithEllipseInRect(boundRect, nil)
        orbitAnimation.duration = 10.0
        orbitAnimation.additive = true
        orbitAnimation.repeatCount = Float.infinity
        orbitAnimation.calculationMode = kCAAnimationCubicPaced
        orbitAnimation.rotationMode = kCAAnimationRotateAuto
        
        satelliteImageView.layer.addAnimation(orbitAnimation, forKey: "orbit")
        
        satelliteImageView.animationImages = [UIImage(named: "satellite")!, UIImage(named: "satellite1")!, UIImage(named: "satellite2")!, UIImage(named: "satellite3")!]
        
        satelliteImageView.animationDuration = 1.0
        satelliteImageView.animationRepeatCount = Int.max
        satelliteImageView.startAnimating()
        
        let mouseImageView = UIImageView(frame: CGRectMake(0, 0, 90, 50))
        mouseImageView.image = UIImage(named: "mouse")
        view.addSubview(mouseImageView)
        
        let mouseAnimation = CAKeyframeAnimation()
        mouseAnimation.keyPath = "position"
        mouseAnimation.rotationMode = kCAAnimationRotateAuto
        mouseAnimation.calculationMode = kCAAnimationCubicPaced
        mouseAnimation.repeatCount = Float.infinity
        mouseAnimation.path = CGPathCreateWithRect(CGRect(x: 25, y: 25, width: view.frame.width - 50, height: view.frame.height - 50), nil)
        mouseAnimation.duration = 5.0
        
        mouseImageView.layer.addAnimation(mouseAnimation, forKey: "mouse")
        
        let drawerView = UIView()
        drawerView.backgroundColor = .purpleColor()
        drawerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(drawerView)
        
        let xConstraint = NSLayoutConstraint(item: drawerView, attribute: .Leading, relatedBy: .Equal, toItem: view, attribute: .Leading, multiplier: 1.0, constant: 0)
        view.addConstraint(xConstraint)
        
        yConstraint = NSLayoutConstraint(item: drawerView, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1.0, constant: -80)
        view.addConstraint(yConstraint!)
        
        let heightConstraint = NSLayoutConstraint(item: drawerView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 80)
        view.addConstraint(heightConstraint)
        
        let widthConstraint = NSLayoutConstraint(item: drawerView, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: 1.0, constant: 0)
        view.addConstraint(widthConstraint)
        
        
        let button = UIButton(frame: CGRectMake(50, 50, 50, 50))
        button.backgroundColor = .purpleColor()
        button.setTitle("Toggle Drawer", forState: .Normal)
        button.setTitleColor(.whiteColor(), forState: .Normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: "toggleDrawerView", forControlEvents: .TouchUpInside)
        view.addSubview(button)
        
        var constraint = NSLayoutConstraint(item: button, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.0, constant: 0)
        view.addConstraint(constraint)
        
        constraint = NSLayoutConstraint(item: button, attribute: .CenterY, relatedBy: .Equal, toItem: view, attribute: .CenterY, multiplier: 1.0, constant: 0)
        view.addConstraint(constraint)
        
        constraint = NSLayoutConstraint(item: button, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 44)
        view.addConstraint(constraint)
        
        constraint = NSLayoutConstraint(item: button, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: 0.5, constant: 0)
        view.addConstraint(constraint)

    }

    func toggleDrawerView() {
        guard let yConstraint = yConstraint else { return }
        view.layoutIfNeeded()
        
        if drawerShown {
            yConstraint.constant = 0.0
        } else {
            yConstraint.constant = -80.0
        }
        
        UIView.animateWithDuration(0.75) { () -> Void in
            self.view.layoutIfNeeded()
        }
        
        drawerShown = !drawerShown
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

