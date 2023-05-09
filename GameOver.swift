//
//  GameOver.swift
//  CoinCatcher2
//
//  Created by Selman Atabek on 16.04.2023.
//

import Foundation
//
//  GameScene.swift
//  CoinCatcher2
//
//  Created by Selman Atabek on 16.04.2023.
//

import SpriteKit
import GameplayKit

class GameOver: SKScene {
    public var win = true


    
    override func didMove(to view: SKView) {
        
        // Get label node from scene and store it for use later
        let label = self.childNode(withName: "//gameover_label") as? SKLabelNode
    

        if win == false {
            label?.text = "Kaybettin."
        }
       
       
    }
    
    

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      let scene = GameScene(fileNamed: "HomeScene")
        scene!.scaleMode = .aspectFit
        self.view?.presentScene(scene)
    }
    
  
    
   
}
