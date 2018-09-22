
//
//  Animation.swift
//  Balloons
//
//  Created by Sarthak Babbar on 9/8/18.
//  Copyright © 2018 Sarthak Babbar. All rights reserved.
//

import SpriteKit


class AnimationScene: SKScene {
    var i=0
    var levelCounter = 1
    var animationBackground: SKSpriteNode!

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        anchorPoint = CGPoint(x: 0, y: 1.0)
        
        
        animationBackground = SKSpriteNode(color: UIColor.lightGray, size: size)
        animationBackground.anchorPoint = CGPoint(x: 0, y: 1.0)
        animationBackground.position = CGPoint(x: 0, y: 0)
        self.addChild(animationBackground)
    }
    
    override func update(_ currentTime: CFTimeInterval) {
        
        i += 1
        // to control the creation speed of the balloon and number of balloons
        // 20 balloons are created
        if i%10  == 0 && i<=200
        {
            addBubble()
        }
        // controls going to the next level
        if i >= 250{
            i = 0
            levelCounter += 1
            
        }
        
        floatBubbles()
        removeExcessBubbles()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            for touched in self.nodes(at: location){
                if touched.name == "remove"{
                    touched.removeFromParent()
                
                }
            }
            
            
        }
    }
    func addBubble() {
        let bubble = SKSpriteNode(imageNamed: "balloon.png")
        bubble.name = "remove"
        bubble.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        
        bubble.color = colorBalloon()
        bubble.colorBlendFactor = 1.0
        //let colors = [UIColor:,"blue","green","darkgreen","brown"]
        
        animationBackground.addChild(bubble)
        let startingPoint = CGPoint(x: size.width*0.1   + CGFloat(arc4random_uniform(UInt32(size.width*0.8))), y: (-1)*size.height)
        bubble.position = startingPoint
        
        let levelText = SKLabelNode(fontNamed: "Chalkduster")
        levelText.text = "Level: \(levelCounter)"
        levelText.name = "LeveCounter"
        levelText.fontSize = 65
        levelText.fontColor = SKColor.black
        levelText.position = CGPoint(x: frame.midX, y: frame.midY)
        
        addChild(levelText)
        
    }
    
    func floatBubbles() {
        for child in animationBackground.children {
            // control the speed of the balloon
            // 400 is too fast
            
            let yOffset: CGFloat = 100.0
            let newLocation = CGPoint(x: child.position.x, y: child.position.y + yOffset)
            let moveAction = SKAction.move(to: newLocation, duration: 0.1)
            child.run(moveAction)
        }
    }
    
    func removeExcessBubbles() {
        for child in animationBackground.children {
            if child.position.y > 0  {
                child.removeFromParent()
                
            }
        }
    }
    func colorBalloon() -> UIColor{
        var color = [UIColor]()
        color = [UIColor.cyan,UIColor.red,UIColor.blue,UIColor.green,UIColor.brown]
        let randomNumber = arc4random_uniform(UInt32(color.count))
        let randomColor = color[Int(randomNumber)]
        return (randomColor)
    }
    func createRectangle(){
        let bubble = SKSpriteNode()
        bubble.name = "remove"
        bubble.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        
        bubble.color = colorBalloon()
        bubble.colorBlendFactor = 1.0
        //let colors = [UIColor:,"blue","green","darkgreen","brown"]
        
        animationBackground.addChild(bubble)
        let startingPoint = CGPoint(x: size.width*0.1   + CGFloat(arc4random_uniform(UInt32(size.width*0.8))), y: (-1)*size.height)
        bubble.position = startingPoint
    }
}
