//
//  GameSelectionScene.swift
//  inEggGame2
//
//  Created by Yuxiang Tang on 9/21/15.
//  Copyright (c) 2015 陈天远. All rights reserved.
//

import UIKit
import SpriteKit

extension UIView {
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.CGPath
        self.layer.mask = mask
    }
}

class GameSelectionScene: SKScene {
    
    var mainView: UIView!
    
    var backButton: UIButton!
    
    let screenWidth = UIScreen.mainScreen().bounds.width
    let screenHeight = UIScreen.mainScreen().bounds.height
    
    var levelOne: UIButton!
    var levelOneLabel: UILabel!
    
    var levelTwo: UIButton!
    var levelTwoLabel: UILabel!
    
    var levelThree: UIButton!
    var levelThreeLabel: UILabel!
    
    var lineLayer: CAShapeLayer!
    var bezierPath: UIBezierPath!
    
    var lineLayer2: CAShapeLayer!
    
    var backgroundImageView: UIImageView!
    
    var navigationLabel: UIView!
    var rightButton: UIButton!
    var rightButtonView: UIView!
    var leftButton: UIButton!
    var leftButtonView: UIView!

   
//    override init(size: CGSize){
//        super.init(size: size)
//    }
//    required init?(coder aDecoder:NSCoder){
//        super.init(coder:aDecoder)
//    }

    
    override func didMoveToView(view: SKView) {
        self.backgroundColor = UIColor.whiteColor()
        
//        self.backgroundImageView = UIImageView(frame: CGRectMake(0, 0, self.screenWidth, self.screenHeight))
//        self.backgroundImageView.image = UIImage(named: "background")
        //self.view.addSubview(self.backgroundImageView)
        
        self.mainView = UIView(frame: CGRectMake(0, 0, self.screenWidth, self.screenHeight))
        self.mainView.backgroundColor = UIColor.clearColor()
        self.view?.addSubview(self.mainView)
        
        
        self.navigationLabel = UIView(frame: CGRectMake(0, -20, self.screenWidth, 80))
        self.navigationLabel.layer.cornerRadius = 20
        self.navigationLabel.backgroundColor = UIColor.lightGrayColor()
        self.view!.addSubview(self.navigationLabel)
        
        self.rightButtonView = UIView(frame: CGRectMake(self.screenWidth - 60 , 20, 60, 60))
        self.rightButtonView.backgroundColor = UIColor.grayColor()
        self.rightButtonView.roundCorners(.TopLeft | .BottomRight, radius: 20)
        self.navigationLabel.addSubview(self.rightButtonView)
        
        self.rightButton = UIButton(frame: CGRectMake(15, 15, 30, 30))
        self.rightButton.setBackgroundImage(UIImage(named: "menu"), forState: UIControlState.Normal)
        self.rightButton.addTarget(self, action: "goToLevel", forControlEvents: UIControlEvents.TouchUpInside)
        self.rightButtonView.addSubview(self.rightButton)
        
        self.leftButtonView = UIView(frame: CGRectMake(0, 20,60 , 60))
        self.leftButtonView.backgroundColor = UIColor.grayColor()
        self.leftButtonView.roundCorners( .TopRight | .BottomLeft, radius: 20)
        self.navigationLabel.addSubview(self.leftButtonView)
        
        
        
        
        
//        self.backButton = UIButton(frame: CGRectMake(0.0, self.screenHeight - 60, 80.0, 60.0))
//        self.backButton.setBackgroundImage(UIImage(named: "backButton"), forState: UIControlState.Normal)
//        self.backButton.addTarget(self, action: "goBack:", forControlEvents: UIControlEvents.TouchUpInside)
//        self.view!.addSubview(self.backButton)
        
        self.levelOne = UIButton(frame: CGRectMake(self.screenWidth / 2 - 30.0, self.screenHeight - 80.0, 60.0, 60.0))
        self.levelOne.setBackgroundImage(UIImage(named: "circle"), forState: UIControlState.Normal)
        self.levelOne.addTarget(self, action: "goToLevel:", forControlEvents: UIControlEvents.TouchUpInside)
        self.levelOneLabel = UILabel(frame: CGRectMake(self.screenWidth / 2 - 20.0, self.screenHeight - 70.0, 40.0, 40.0))
        self.levelOneLabel.text = "1"
        self.levelOneLabel.textAlignment = .Center
        
        self.levelTwo = UIButton(frame: CGRectMake(self.screenWidth / 2 - 30.0, self.screenHeight - 200.0, 60.0, 60.0))
        self.levelTwo.setBackgroundImage(UIImage(named: "circle"), forState: UIControlState.Normal)
        self.levelTwo.addTarget(self, action: "goToLevel:", forControlEvents: UIControlEvents.TouchUpInside)
        self.levelTwoLabel = UILabel(frame: CGRectMake(self.screenWidth / 2 - 20.0, self.screenHeight - 190.0, 40.0, 40.0))
        self.levelTwoLabel.text = "2"
        self.levelTwoLabel.textAlignment = .Center
        
        self.levelThree = UIButton(frame: CGRectMake(self.screenWidth / 2 - 30.0, self.screenHeight - 320.0, 60.0, 60.0))
        self.levelThree.setBackgroundImage(UIImage(named: "circle"), forState: UIControlState.Normal)
        self.levelThree.addTarget(self, action: "goToLevel:", forControlEvents: UIControlEvents.TouchUpInside)
        self.levelThreeLabel = UILabel(frame: CGRectMake(self.screenWidth / 2 - 20.0, self.screenHeight - 310.0, 40.0, 40.0))
        self.levelThreeLabel.text = "3"
        self.levelThreeLabel.textAlignment = .Center
        
        
        self.lineLayer = CAShapeLayer()
        self.bezierPath = self.drawLineFromPoint(CGPointMake(self.screenWidth / 2 , self.screenHeight - 75.0), toPoint: CGPointMake(self.screenWidth / 2, self.screenHeight - 145.0))
        self.lineLayer.path = self.bezierPath.CGPath
        self.lineLayer.strokeColor = UIColor.purpleColor().CGColor
        self.lineLayer.lineWidth = 4.0
        
        
        self.lineLayer2 = CAShapeLayer()
        self.bezierPath = self.drawLineFromPoint(CGPointMake(self.screenWidth / 2 , self.screenHeight - 190.0), toPoint: CGPointMake(self.screenWidth / 2, self.screenHeight - 260.0))
        self.lineLayer2.path = self.bezierPath.CGPath
        self.lineLayer2.strokeColor = UIColor.purpleColor().CGColor
        self.lineLayer2.lineWidth = 4.0
        
        
        
        
        self.mainView.layer.addSublayer(self.lineLayer)
        self.mainView.layer.addSublayer(self.lineLayer2)
        self.mainView.addSubview(self.levelOne)
        self.mainView.addSubview(self.levelOneLabel)
        self.mainView.addSubview(self.levelTwo)
        self.mainView.addSubview(self.levelTwoLabel)
        self.mainView.addSubview(self.levelThree)
        self.mainView.addSubview(self.levelThreeLabel)
    }
    
    func drawLineFromPoint(start: CGPoint, toPoint end: CGPoint) -> UIBezierPath {
        var path = UIBezierPath()
        path.moveToPoint(start)
        path.addLineToPoint(end)
        path.stroke()
        
        return path
        
    }
    
    func goToLevel(sender: UIButton){
        
        var transition:SKTransition = SKTransition.flipHorizontalWithDuration(0.5)
        var gameScene:SKScene = GameScene(size:CGSizeMake(self.screenWidth, self.screenHeight))
        self.mainView.hidden = true
        self.navigationLabel.hidden = true
        self.view?.presentScene(gameScene, transition: transition)
    }
    
    
    
}
