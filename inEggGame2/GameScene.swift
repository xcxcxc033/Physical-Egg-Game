//
//  GameScene.swift
//  inEggGame2
//
//  Created by 陈天远 on 15/9/18.
//  Copyright (c) 2015年 陈天远. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    let screenWidth = UIScreen.mainScreen().bounds.width
    let screenHeight = UIScreen.mainScreen().bounds.height
    
    var lastYieldTimeInterval:NSTimeInterval=NSTimeInterval()
    var lastUpdateTimeInterval:NSTimeInterval=NSTimeInterval()
    var timeSinceLastUpdate:NSTimeInterval=NSTimeInterval()
    var example:SKSpriteNode=SKSpriteNode()//just for compare
    let ballCategory:UInt32=0x1 << 1
    let basketCategory:UInt32=0x1 << 0
    let rectCategory:UInt32=0x1 << 2
    
    var ball:SKSpriteNode=SKSpriteNode()
    var hen:SKSpriteNode=SKSpriteNode()
    var basket:SKSpriteNode=SKSpriteNode()
    var rect0:SKSpriteNode=SKSpriteNode()
    var rect1:SKSpriteNode=SKSpriteNode()
    var bottomFrame:SKSpriteNode=SKSpriteNode()
    var framework:SKSpriteNode=SKSpriteNode()
    var isPlaceRectangle = false
    var temp:String = "label"
    var menuButton:UIButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
    var playButton:UIButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
    
    var menuView: UIView!
    var syncProgress: UIButton!
    var resetAssetsButton: UIButton!
    var returnGameSelectionButton: UIButton!
    var transparentButton: UIButton!
    var blurView: UIVisualEffectView!
    
    
    override init(size: CGSize){
        super.init(size: size)
    }
    
    required init?(coder aDecoder:NSCoder){
        super.init(coder:aDecoder)
    }

    
    override func didMoveToView(view: SKView) {
        
        self.initMenu()
        /* Setup your scene here */
        self.backgroundColor=SKColor.blackColor()
        self.physicsWorld.gravity=CGVectorMake(0, -1.8)
        println(self.frame.size.width)
        println(self.frame.size.height)
        //button
        
        menuButton.frame=CGRectMake(self.screenWidth - 50, 20, 30, 30)
        menuButton.setTitleColor(UIColor.whiteColor(),forState: .Normal)
        menuButton.setBackgroundImage(UIImage(named:"menu2"),forState:.Normal)
        menuButton.addTarget(self, action: "goToMenu:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view!.addSubview(menuButton)
        
        
        
        playButton.frame=CGRectMake(20, 20, 35, 35);
        playButton.setTitleColor(UIColor.whiteColor(),forState: .Normal)
        playButton.setBackgroundImage(UIImage(named:"start2"),forState:.Normal)
        self.view!.addSubview(playButton);
        playButton.addTarget(self,action:Selector("tapped"),forControlEvents:UIControlEvents.TouchUpInside)
        
    
        //hen
        self.hen=SKSpriteNode(imageNamed: "muji")
        self.hen.size.width = 80
        self.hen.size.height = 80
        self.hen.anchorPoint = CGPointZero
        hen.position=CGPointMake(30, self.screenHeight - 150)
        self.addChild(hen)

        //ball
        self.ball=SKSpriteNode(imageNamed: "round")
        //self.ball.anchorPoint = CGPointZero
        ball.position=CGPointMake(60, self.screenHeight - 150)
        ball.physicsBody=SKPhysicsBody(circleOfRadius: ball.size.width/2)
        ball.physicsBody?.dynamic = false
        example.position = ball.position//just for compare
        ball.physicsBody?.categoryBitMask=ballCategory
        ball.physicsBody?.contactTestBitMask=basketCategory
    //    ball.physicsBody?.collisionBitMask=basketCategory & rectCategory
        
        self.addChild(ball)
        
        
        //basket
        basket=SKSpriteNode(imageNamed: "basket2")
        self.basket.size.width = 80
        self.basket.size.height = 80
        self.basket.anchorPoint = CGPointZero
        basket.position=CGPointMake(self.screenWidth - 100, 100)
        basket.physicsBody=SKPhysicsBody(rectangleOfSize: ball.size)
        basket.physicsBody?.dynamic = false
        
        basket.physicsBody?.categoryBitMask=basketCategory
        basket.physicsBody?.contactTestBitMask=ballCategory
      //  basket.physicsBody?.collisionBitMask=ballCategory & rectCategory
        
        basket.physicsBody?.usesPreciseCollisionDetection = true
        
        self.addChild(basket)
        
        //frame
        framework=SKSpriteNode(imageNamed: "framework")
        framework.name = "framework"
        self.framework.size.width = 1500
        self.framework.size.height = 3
        self.framework.anchorPoint = CGPointZero
        framework.position=CGPointMake(0, 80)
        framework.physicsBody=SKPhysicsBody(rectangleOfSize: framework.size)
        framework.physicsBody?.dynamic = false
        self.addChild(framework)
        
        // 2 triagnle
        rect0=SKSpriteNode(imageNamed: "triangle")
        rect0.name = "rect0"
        self.rect0.size.width = 40
        self.rect0.size.height = 40
        //self.rect0.anchorPoint = CGPointZero
        rect0.position=CGPointMake(50, 30)
        
        rect0.physicsBody = SKPhysicsBody(texture: rect0.texture, size: rect0.texture!.size())
        rect0.physicsBody?.categoryBitMask=rectCategory
        rect0.physicsBody?.contactTestBitMask = 0
        println("rect0 texture size")
        print(rect0.texture?.size())
        rect0.physicsBody?.dynamic = false
        
      //  rect0.physicsBody?.collisionBitMask=ballCategory & basketCategory
         self.addChild(rect0)
        
        rect1=SKSpriteNode(imageNamed: "triangle")
        rect1.name = "rect1"
        self.rect1.size.width = 40
        self.rect1.size.height = 40
        //self.rect1.anchorPoint = CGPointZero
        rect1.position=CGPointMake(50, 30)
        
        rect1.physicsBody = SKPhysicsBody(texture: rect1.texture, size: rect1.texture!.size())
        
        
        rect1.physicsBody?.categoryBitMask=rectCategory
        rect1.physicsBody?.contactTestBitMask = 0
        //  rect1.physicsBody?.collisionBitMask=ballCategory & basketCategory
        rect1.physicsBody?.dynamic = false
        self.addChild(rect1)
        
        self.physicsWorld.contactDelegate = self

    }
    
    func tapped(){
        println("tapped")
        ball.physicsBody?.dynamic = true
        //ball.physicsBody?.applyImpulse(CGVectorMake(2, 3))
        rect0.name = "rect0static"
        rect1.name = "rect1static"
        playButton.removeTarget(self, action: Selector("tapped"), forControlEvents: UIControlEvents.TouchUpInside)
   //     playbutton.addTarget(self,action:Selector("tapped2"),forControlEvents:UIControlEvents.TouchUpInside)
        playButton.removeFromSuperview()
        menuButton.removeFromSuperview()
   
    }
    
    func tapped2(){
        println("tapped2")
        

        //maybe for stop the ball
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        timeSinceLastUpdate = currentTime - lastUpdateTimeInterval
        if(timeSinceLastUpdate>1){
            lastUpdateTimeInterval=currentTime
            if(ball.position.y<=framework.position.y+30){
                println("conlision with framework")
                
                var transition1:SKTransition = SKTransition.flipHorizontalWithDuration(0.5)
                var YouWinScene1:SKScene = youWinScene(size: self.frame.size, won:false)
                self.view?.presentScene(YouWinScene1, transition: transition1)
                
                
            }
            if(ball.physicsBody?.dynamic == true){
                if(example.position==ball.position){
                    var transition1:SKTransition = SKTransition.flipHorizontalWithDuration(0.5)
                    var YouWinScene1:SKScene = youWinScene(size: self.frame.size, won:false)
                    self.view?.presentScene(YouWinScene1, transition: transition1)

                }
                else{
                    example.position = ball.position
                }
                

            }
            
        }
        
        
        
    }
    
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        var touch =  (touches as NSSet).anyObject() as! UITouch!
        var location = touch.locationInNode(self)
        println("000")
        
        if let body = self.physicsWorld.bodyAtPoint(location){
            //    println("111")
            println(body.node!.name)
            
            if body.node!.name == "rect0" {
                println("place a rectangle")
                isPlaceRectangle = true
                temp = "rect0"
            }
   
            if body.node!.name == "rect1" {
                println("place a rectangle")
                isPlaceRectangle = true
                temp = "rect1"
            }
            
            if body.node!.name == "startend" {
                println("start")
                
                ball.physicsBody?.dynamic = true;
                //ball.physicsBody?.applyImpulse(CGVectorMake(3, 3))
                //stop the function of startend!!!!!!!!!
                
            }
            
        }
        
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        if isPlaceRectangle {
            var touch =  (touches as NSSet).anyObject() as! UITouch!
            var location = touch.locationInNode(self)
            
            var prevLocation = touch.previousLocationInNode(self)

            //var rectangle0:SKSpriteNode=SKSpriteNode(imageNamed: "rectangle0")
            
            var rectangle0 = childNodeWithName(temp) as! SKSpriteNode
            
            var xPos = rectangle0.position.x + (location.x - prevLocation.x)
            
            var yPos = rectangle0.position.y + (location.y - prevLocation.y)
            
            rectangle0.position = CGPointMake(xPos, yPos)
            
        }
        
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        if temp == "rect1" || temp == "rect0" {
            var rectangle0 = childNodeWithName(temp) as! SKSpriteNode
          
            var longLine = childNodeWithName("framework") as! SKSpriteNode
            if rectangle0.position.y < longLine.position.y{
                rectangle0.position = CGPointMake(50, 20)
            }
        }

        temp  = "label";
        isPlaceRectangle = false
       // if rect under the line set it to default place
        
    }

    func didBeginContact(contact: SKPhysicsContact) {
        var firstBody:SKPhysicsBody
        var secondBody:SKPhysicsBody
        
        if(contact.bodyA.contactTestBitMask < contact.bodyB.contactTestBitMask){
            firstBody = contact.bodyA
            secondBody = contact.bodyB
            
        }else{
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if((firstBody.contactTestBitMask & basketCategory) != 0 && (secondBody.contactTestBitMask & ballCategory) != 0){
            basketDidCollideWithBall(firstBody.node as! SKSpriteNode, ball: secondBody.node as! SKSpriteNode)
        }
    }
    
    func basketDidCollideWithBall(basket:SKSpriteNode,ball:SKSpriteNode){
        println("HIT")

        
            //transition to gameover or success
            var transition:SKTransition = SKTransition.flipHorizontalWithDuration(0.5)
            var YouWinScene:SKScene = youWinScene(size: self.frame.size, won:true)
            self.view?.presentScene(YouWinScene, transition: transition)
       
        
    }
    
    func initMenu(){
        self.menuView = UIView(frame: CGRectMake(self.screenWidth / 2 - 100, -self.screenHeight / 2 - 150, 200, 250))
        self.menuView.backgroundColor = UIColor(red: 6 / 255, green: 82 / 255, blue: 121 / 255, alpha: 1.0)
        self.menuView.layer.cornerRadius = 15
        
        self.syncProgress = UIButton(frame: CGRectMake(self.menuView.frame.width / 2 - 60, 50, 120, 40))
        self.syncProgress.backgroundColor = UIColor(red: 238 / 255, green: 222 / 255, blue: 176 / 255, alpha: 1.0)
        self.syncProgress.setTitle("Sync Progress", forState: UIControlState.Normal)
        self.syncProgress.titleLabel?.font = UIFont.systemFontOfSize(16)
        self.syncProgress.layer.cornerRadius = 20
        self.menuView.addSubview(self.syncProgress)
        
        self.resetAssetsButton = UIButton(frame: CGRectMake(self.menuView.frame.width / 2 - 60, 110, 120, 40))
        self.resetAssetsButton.backgroundColor = UIColor(red: 237 / 255, green: 209 / 255, blue: 216 / 255, alpha: 1.0)
        self.resetAssetsButton.setTitle("Restart", forState: UIControlState.Normal)
        self.resetAssetsButton.titleLabel?.font = UIFont.systemFontOfSize(16)
        self.resetAssetsButton.layer.cornerRadius = 20
        self.resetAssetsButton.addTarget(self, action: "resetGame:", forControlEvents: UIControlEvents.TouchUpInside)
        self.menuView.addSubview(self.resetAssetsButton)
        
        
        self.returnGameSelectionButton = UIButton(frame: CGRectMake(self.menuView.frame.width / 2 - 60, 170, 120, 40))
        self.returnGameSelectionButton.backgroundColor = UIColor(red: 233 / 255, green: 241 / 255, blue: 246 / 255, alpha: 1.0)
        self.returnGameSelectionButton.setTitle("Exit to Map", forState: UIControlState.Normal)
        self.returnGameSelectionButton.titleLabel?.font = UIFont.systemFontOfSize(16)
        self.returnGameSelectionButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.returnGameSelectionButton.layer.cornerRadius = 20
        self.returnGameSelectionButton.addTarget(self, action: "returnGameSelection:", forControlEvents: UIControlEvents.TouchUpInside)
        self.menuView.addSubview(self.returnGameSelectionButton)

    
        self.transparentButton = UIButton(frame: CGRectMake(0, 0, self.screenWidth, self.screenHeight))
        self.transparentButton.backgroundColor = UIColor.clearColor()
        self.transparentButton.addTarget(self, action: "dismissMenuView:", forControlEvents: UIControlEvents.TouchUpInside)
        

        self.blurView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.Light))
        self.blurView.frame = self.view!.frame
        self.view?.addSubview(self.blurView)
        self.blurView.addSubview(self.transparentButton)
        self.blurView.addSubview(self.menuView)
        
        self.blurView.hidden = true
        
    
    }
    
    func freezeGame(){
        self.rect0.hidden = true
        self.rect1.hidden = true
        self.playButton.hidden = true
        self.menuButton.hidden = true
        self.transparentButton.hidden = false
        self.blurView.hidden = false
        self.blurView.alpha = 1.0
    
    }
    
    func resumeGame(){
        self.rect0.hidden = false
        self.rect1.hidden = false
        self.playButton.hidden = false
        self.menuButton.hidden = false
        self.transparentButton.hidden = true
    }
    
    
    
    //for button targets
    func goToMenu(sender: UIButton){
        
        self.freezeGame()
        
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.menuView.frame.origin.y = self.screenHeight / 2 - 150
        }, completion: nil)
        
        
    }
    
    func dismissMenuView(sender: UIButton){
        
        UIView.animateWithDuration(0.8, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.menuView.frame.origin.y = -self.screenHeight / 2 - 150
            }, completion: nil)
        
        
        UIView.animateWithDuration(0.3, delay: 0.3, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.blurView.alpha = 0.1
            }, completion: {
                finished in
                self.blurView.hidden = true
        })
        
        self.resumeGame()
        
    }
    
    func returnGameSelection(sender: UIButton){
        
        self.dismissMenuView(self.transparentButton)
        
        var sceneTransition = SKTransition.crossFadeWithDuration(0.5)
        var gameSectionScene:SKScene = GameSelectionScene()
        self.view?.presentScene(gameSectionScene, transition: sceneTransition)
        
        
    }
    
    func resetGame(sender: UIButton){
        
        self.dismissMenuView(sender)
    
    }

    
   
    
}
