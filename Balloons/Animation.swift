
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
    var msgSent = 0
    var animationBackground: SKSpriteNode!
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        anchorPoint = CGPoint(x: 0, y: 1.0)
        
        animationBackground = SKSpriteNode(imageNamed: "background.png")
        //animationBackground = SKSpriteNode(color: UIColor.yellow, size: size)
        animationBackground.anchorPoint = CGPoint(x: 0, y: 1.0)
        animationBackground.position = CGPoint(x: 0, y: 0)
        
        
        
        
        self.addChild(animationBackground)
    }
    
    
    override func update(_ currentTime: CFTimeInterval) {
        
        if gameEnd == "True" {
            
            
            
            
            // Notifying GameEnd
            if msgSent == 0 {
            NotificationCenter.default.post(name: Notification.Name("GameEnded"), object: nil)
            msgSent += 1
            }
            return
           
        }
        
        
        i += 1
        // to control the creation speed of the balloon and number of balloons
        // 20 balloons are created
        if i%10  == 0 && i<=100
        {
            addBubble()
            addBalloonIcon()
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
                    
                    
                    
                    if colorCoordinate(balloon_color: nameString!) == false{
                        livesCounter -= 1
                        if livesCounter < 1 {
                            // game over move to the other page
                            gameEnd = "True"
                            
                            
                        }
                        
                    }
                   
                    touched.removeFromParent()
                    
                    
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
//
                let yOffset: CGFloat = CGFloat((((levelCounter-1)%10)*10)+20)
                let newLocation = CGPoint(x: child.position.x, y: child.position.y + yOffset)
                let moveAction = SKAction.move(to: newLocation, duration: 0.1)
                child.run(moveAction)
            }
        }
    }
    
    func removeExcessBubbles() {
        for child in animationBackground.children {
            if child.position.y > 0 {
                if colorCoordinate(balloon_color: child.name!) == true{
                    livesCounter -= 1
                    if livesCounter < 1 {
                        gameEnd = "True"
                    }
                }
                child.removeFromParent()
            }
            
        }
    }
    
    func createBalloonIcon(colorNumber:Int,position:Int) {
        let icon = SKShapeNode(circleOfRadius:15)
        icon.name = "icon"
        icon.position = CGPoint(x: frame.maxX-CGFloat(30+position), y: frame.maxY-50)
        icon.glowWidth = 1.0
        icon.fillColor = applyColor(number: colorNumber)
        addChild(icon)
        
    }
    func removeBalloonIcon(){
        for child in animationBackground.children{
            if child.name == "icon"{
                child.removeFromParent()
            }
        }
    }
    func addBalloonIcon(){
        var iconPosition:Int
        var numberIcons:Int
        switch levelCounter{
        case  1..<11:
            numberIcons = 1
            for i in 1...numberIcons{
                iconPosition = i
                createBalloonIcon(colorNumber: i,position: Int(15)*(iconPosition-1))
            }
        case  11..<21:
            removeBalloonIcon()
            numberIcons = 2
            for i in 1...numberIcons{
                iconPosition = i
                createBalloonIcon(colorNumber: i,position: Int(15)*(iconPosition-1))
            }
        case  21..<31:
            removeBalloonIcon()
            numberIcons = 3
            for i in 1...numberIcons{
                iconPosition = i
                createBalloonIcon(colorNumber: i,position: Int(15)*(iconPosition-1))
            }
        case  31...41:
            removeBalloonIcon()
            numberIcons = 4
            for i in 1...numberIcons{
                iconPosition = i
                createBalloonIcon(colorNumber: i,position: Int(15)*(iconPosition-1))
            }
        case  40..<51:
            removeBalloonIcon()
            numberIcons = 5
            for i in 1...numberIcons{
                iconPosition = i
                createBalloonIcon(colorNumber: i,position: Int(15)*(iconPosition-1))
            }
            
        default:
            numberIcons = 1
            for i in 1...numberIcons{
                iconPosition = i
                createBalloonIcon(colorNumber: i,position: Int(15)*(iconPosition-1))
            }
        }
    }
    
    
    func applyColor(number:Int) -> UIColor{
        var color = [UIColor]()
        color = [UIColor.cyan,UIColor.blue,UIColor.green,UIColor.brown,UIColor.red]
        return color[number-1]
    }
    
  
    
    func colorCoordinate(balloon_color:String) -> Bool{
        if levelControl() == 1
        {
            if balloon_color.contains("1"){
                return true
            }
            else{
                return false
            }
        }
        else if levelControl() == 2
        {
            if balloon_color.contains("1") || balloon_color.contains("2"){
                return true
            }
            else {
                return false
            }
        }
        else if levelControl() == 3
        {
            if balloon_color.contains("1") || balloon_color.contains("2")  || balloon_color.contains("3"){
                return true
            }
            else {
                return false
            }
        }
        else if levelControl() == 4
        {
            if balloon_color.contains("1") || balloon_color.contains("2")  || balloon_color.contains("3")  || balloon_color.contains("4"){
                return true
            }
            else {
                return false
            }
        }
        else if levelControl() == 5
        {
            if balloon_color.contains("1") || balloon_color.contains("2")  || balloon_color.contains("3")  || balloon_color.contains("4")  || balloon_color.contains("5"){
                return true
            }
            else {
                return false
            }
        }
        return true
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
