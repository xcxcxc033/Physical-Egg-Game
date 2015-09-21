//
//  GameScene.swift
//  inEggGame2
//
//  Created by 陈天远 on 15/9/18.
//  Copyright (c) 2015年 陈天远. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
  //  let screenwidth = UIScreen.mainScreen().bounds.width
  //  let screenheight = UIScreen.mainScreen().bounds.height
    
    var lastYieldTimeInterval:NSTimeInterval=NSTimeInterval()
    var lastUpdateTimeInterval:NSTimeInterval=NSTimeInterval()
    var timeSinceLastUpdate:NSTimeInterval=NSTimeInterval()
    var example:SKSpriteNode=SKSpriteNode()//just for compare
    let ballCategory:UInt32=0x1 << 1
    let basketCategory:UInt32=0x1 << 0
    let rectCategory:UInt32=0x1 << 2
    
    
    var ball:SKSpriteNode=SKSpriteNode()
    var muji:SKSpriteNode=SKSpriteNode()
    var basket:SKSpriteNode=SKSpriteNode()
    var rect0:SKSpriteNode=SKSpriteNode()
    var rect1:SKSpriteNode=SKSpriteNode()
    var bottomFrame:SKSpriteNode=SKSpriteNode()
    //var menutable:SKSpriteNode=SKSpriteNode()
   // var startbutton:SKSpriteNode=SKSpriteNode()
    var framework:SKSpriteNode=SKSpriteNode()
    var isPlaceRectangle = false
    var temp:String = "label"
    var menubutton:UIButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton;
    var playbutton:UIButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton;
    
    override init(size: CGSize){
        super.init(size: size)
    }
    required init?(coder aDecoder:NSCoder){
        super.init(coder:aDecoder)
    }

    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        self.backgroundColor=SKColor.blackColor()
        self.physicsWorld.gravity=CGVectorMake(0, -1.8)
        println(self.frame.size.width)
        println(self.frame.size.height)
        //button
        
        menubutton.frame=CGRectMake(self.frame.size.width/2-500, self.frame.size.height/2-370, 30, 30);
        menubutton.setTitleColor(UIColor.whiteColor(),forState: .Normal)
        menubutton.setBackgroundImage(UIImage(named:"menu2"),forState:.Normal)
        self.view!.addSubview(menubutton);
        
        
        
        playbutton.frame=CGRectMake(self.frame.size.width/2-180, self.frame.size.height/2-370, 35, 35);
        playbutton.setTitleColor(UIColor.whiteColor(),forState: .Normal)
        playbutton.setBackgroundImage(UIImage(named:"start2"),forState:.Normal)
        self.view!.addSubview(playbutton);
        playbutton.addTarget(self,action:Selector("tapped"),forControlEvents:UIControlEvents.TouchUpInside)
        
        
        
        /*
        //menu
        menutable=SKSpriteNode(imageNamed: "menu2")
        self.menutable.size.width = 30
        self.menutable.size.height = 30
        menutable.position=CGPointMake(self.frame.size.width/2-170, self.frame.size.height/2+350)
        menutable.physicsBody=SKPhysicsBody(rectangleOfSize: menutable.size)
        menutable.physicsBody?.dynamic = false
        self.addChild(menutable)
        
        //start
        startbutton=SKSpriteNode(imageNamed: "start2")
        self.startbutton.size.width = 30
        self.startbutton.size.height = 30
        startbutton.position=CGPointMake(self.frame.size.width/2+170, self.frame.size.height/2+350)
        startbutton.physicsBody=SKPhysicsBody(rectangleOfSize: startbutton.size)
        startbutton.physicsBody?.dynamic = false
        self.addChild(startbutton)
*/
        //muji
        muji=SKSpriteNode(imageNamed: "muji")
        self.muji.size.width = 80
        self.muji.size.height = 80
        muji.position=CGPointMake(self.frame.size.width*3/7, self.frame.size.height*3/4)
        self.addChild(muji)

        //ball
        ball=SKSpriteNode(imageNamed: "round")
        ball.position=CGPointMake(self.frame.size.width*3/7, self.frame.size.height*3/4)
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
        basket.position=CGPointMake(self.frame.size.width/2+100, self.frame.size.height/2-200)
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
        framework.position=CGPointMake(self.frame.size.width/2, self.frame.size.height/2-310)
        framework.physicsBody=SKPhysicsBody(rectangleOfSize: framework.size)
        framework.physicsBody?.dynamic = false
        self.addChild(framework)
        
        // 2 triagnle
        rect0=SKSpriteNode(imageNamed: "triangle")
        rect0.name = "rect0"
        self.rect0.size.width = 40
        self.rect0.size.height = 40
        rect0.position=CGPointMake(self.frame.size.width/2-150, self.frame.size.height/2-350)
        rect0.physicsBody=SKPhysicsBody(rectangleOfSize: rect0.size)
        rect0.physicsBody?.dynamic = false
        
        rect0.physicsBody?.categoryBitMask=rectCategory
        rect0.physicsBody?.contactTestBitMask = 0
      //  rect0.physicsBody?.collisionBitMask=ballCategory & basketCategory
         self.addChild(rect0)
        
        rect1=SKSpriteNode(imageNamed: "triangle")
        rect1.name = "rect1"
        self.rect1.size.width = 40
        self.rect1.size.height = 40
        rect1.position=CGPointMake(self.frame.size.width/2-150, self.frame.size.height/2-350)
        rect1.physicsBody=SKPhysicsBody(rectangleOfSize: rect1.size)
        rect1.physicsBody?.dynamic = false
        
        rect1.physicsBody?.categoryBitMask=rectCategory
        rect1.physicsBody?.contactTestBitMask = 0
        //  rect1.physicsBody?.collisionBitMask=ballCategory & basketCategory
        self.addChild(rect1)
        
        self.physicsWorld.contactDelegate = self

    }
    
    func tapped(){
        println("tapped")
        ball.physicsBody?.dynamic = true
        ball.physicsBody?.applyImpulse(CGVectorMake(2, 3))
        rect0.name = "rect0static"
        rect1.name = "rect1static"
        playbutton.removeTarget(self, action: Selector("tapped"), forControlEvents: UIControlEvents.TouchUpInside)
   //     playbutton.addTarget(self,action:Selector("tapped2"),forControlEvents:UIControlEvents.TouchUpInside)
        playbutton.removeFromSuperview()
        menubutton.removeFromSuperview()
   
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
        // println("000")
        
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
                let ball = childNodeWithName("ball") as! SKSpriteNode
                
                ball.physicsBody?.dynamic = true;
                ball.physicsBody?.applyImpulse(CGVectorMake(3, 3))
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
            if rectangle0.position.y < longLine.position.y+30{
                rectangle0.position = CGPointMake(self.frame.size.width/2-150, self.frame.size.height/2-350)
            }
        }

        temp  = "label";
        isPlaceRectangle = false
        //if rect under the line set it to default place
        
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


    
   
    
}
