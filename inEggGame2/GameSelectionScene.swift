//
//  GameSelectionScene.swift
//  inEggGame2
//
//  Created by Yuxiang Tang on 9/21/15.
//  Copyright (c) 2015 陈天远. All rights reserved.
//

import UIKit
import SpriteKit

class GameSelectionScene: SKScene {
    
    var settingLabel: SKSpriteNode!
   
    override init(size: CGSize){
        super.init(size: size)
    }
    required init?(coder aDecoder:NSCoder){
        super.init(coder:aDecoder)
    }

    
    override func didMoveToView(view: SKView) {
        self.backgroundColor = UIColor.greenColor()
        
        self.settingLabel = SKSpriteNode(imageNamed: "menu")
        self.settingLabel.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2)
        self.addChild(self.settingLabel)
    }
    
    
    
}
