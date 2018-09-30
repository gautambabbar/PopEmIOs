
//
//  Animation.swift
//  Balloons
//
//  Created by Sarthak Babbar on 9/8/18.
//  Copyright © 2018 Sarthak Babbar. All rights reserved.
//

import SpriteKit
import UIKit


class AnimationScene: SKScene {
    var i=0
    var livesCounter = 3
    var levelCounter = 1
    var barColor = "1"
    var gameEnd = "False"
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
        
        // Notifying GameEnd
        NotificationCenter.default.post(name: Notification.Name("GameEnded"), object: nil)
        
        
        
        
        if gameEnd == "True" {
            return()
        }
        
        //        if levelControl() == 1{
        //            addRectangle()
        //        }
        
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
                let nameString = (touched.name)
                if nameString?.contains("bubble") == true{
                    
                    
                    
                    if nameString?.contains(String(levelControl())) == false{
                        livesCounter -= 1
                        if livesCounter == 0{
                            // game over move to the other page
                            gameEnd = "True"
                            
                            
                        }
                        
                    }
                    //if touched.== colorBalloon(type: "bar", number: levelControl()){
                    touched.removeFromParent()
                    
                    //}
                }
            }
            
            
        }
    }
    func addBubble() {
        let bubble = SKSpriteNode(imageNamed: "balloon.png")
        
        bubble.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        let randomNumber = Int(arc4random_uniform(5))+1
        let color = applyColor(number: randomNumber)
        
        bubble.name = "bubble,"+String(randomNumber)
        bubble.color = color
        bubble.colorBlendFactor = 1.0
        
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
        
        let wait = SKAction.wait(forDuration: 1)
        let remove = SKAction.removeFromParent()
        let sequence = SKAction.sequence([wait, remove])
        levelText.run(sequence)
        
        let livesText = SKLabelNode(fontNamed: "Chalkduster")
        livesText.text = "Lives: \(livesCounter)"
        livesText.name = "LivesCounter"
        livesText.fontSize = 20
        livesText.fontColor = SKColor.black
        //livesText.horizontalAlignmentMode = .right
        
        livesText.position = CGPoint(x: 45, y: frame.maxY-50)
        addChild(livesText)
        
        livesText.run(sequence)
        
        
        
    }
    
    func floatBubbles() {
        for child in animationBackground.children {
            // control the speed of the balloon
            // 400 is too fast
            
            if child.name != "bar"{
                let yOffset: CGFloat = CGFloat((levelCounter%10)*30)
                let newLocation = CGPoint(x: child.position.x, y: child.position.y + yOffset)
                let moveAction = SKAction.move(to: newLocation, duration: 0.1)
                child.run(moveAction)
            }
        }
    }
    
    func removeExcessBubbles() {
        for child in animationBackground.children {
            if child.position.y > 0 {
                if child.name?.contains(String(levelControl())) == true{
                    livesCounter -= 1
                    if livesCounter == 0 {
                        gameEnd = "True"
                    }
                }
                child.removeFromParent()
            }
            
        }
    }
    
    
    func applyColor(number:Int) -> UIColor{
        var color = [UIColor]()
        color = [UIColor.cyan,UIColor.blue,UIColor.green,UIColor.brown,UIColor.red]
        return color[number-1]
    }
    
    
    func createRectangle(rectangleNumber:Int){
        let bar = SKSpriteNode(color:applyColor(number:levelControl()), size: CGSize(width: frame.maxX/CGFloat(rectangleNumber), height: 50))
        //        /CGFloat(rectangleNumber)
        bar.name = "bar"
        bar.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        
        bar.colorBlendFactor = 1.0
        barColor = String(levelControl()-1)
        
        let startingPoint = CGPoint(x:frame.midX, y: frame.maxY+30)
        //        (CGFloat(rectangleNumber-1)*bar.size.width)
        bar.position = startingPoint
        animationBackground.addChild(bar)
    }
    
    func addRectangle(){
        for j in 0...levelControl(){
            createRectangle(rectangleNumber: j+1)
        }
    }
    func removeRectangle(){
        for child in animationBackground.children {
            if child.name == "bar"{
                child.removeFromParent()
            }
        }
    }
    
    func levelControl() -> Int{
        var control:Int
        switch levelCounter{
        case  1..<11:
            control = 1
            return control
        case  11..<21:
            control = 2
            return control
        case  21..<31:
            control = 3
            return control
        case  31...41:
            control = 4
            return control
        case  40..<51:
            control = 5
            return control
            
        default:
            control = 1
            return control
        }
    }
}
