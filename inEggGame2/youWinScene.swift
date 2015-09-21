//
//  youWinScene.swift
//  inEggGame2
//
//  Created by 陈天远 on 15/9/19.
//  Copyright (c) 2015年 陈天远. All rights reserved.
//

import UIKit
import SpriteKit

class youWinScene: SKScene {
    
//    var menubutton:UIButton = UIButton.buttonWithType(UIButtonType.ContactAdd) as! UIButton
    
    init(size: CGSize,won: Bool){
        super.init(size : size)
        
        self.backgroundColor = SKColor.blackColor()
        
        var message:NSString = NSString()
        if(won){
            message="You Win!"
        }else{
            message  = "Game Over!"
        }
        
        var label:SKLabelNode = SKLabelNode(fontNamed: "DamascusBold")
        label.text = message as String
        label.color = SKColor.whiteColor()
        label.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2)
        println(self.frame.size.width)
        println(self.frame.size.height)
     

        self.addChild(label)
                /*
        self.runAction(SKAction.sequence([SKAction.waitForDuration(3.0),
            SKAction.runBlock({
                var transition:SKTransition = SKTransition.flipHorizontalWithDuration(0.5)
                var scene:SKScene = GameScene(size:self.frame.size)
                self.view?.presentScene(scene, transition:transition)
            })
            ]))
        */
        
        
    }
    required init?(coder aDecoder:NSCoder){
        super.init(coder:aDecoder)
    }

    override func didMoveToView(view: SKView) {
        /*   if(won==false){
        
        menubutton.frame=CGRectMake(self.frame.size.width/2, self.frame.size.height/2-100, 80, 80)
        menubutton.setTitleColor(UIColor.blueColor(),forState: .Normal)
        self.view?.addSubview(menubutton)
           }*/
        
    }
    
}
