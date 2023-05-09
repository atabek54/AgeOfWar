//
//  CharacterModel.swift
//  MyFirstGame
//
//  Created by Selman Atabek on 15.04.2023.
//

import Foundation
import SpriteKit



class Knight {
    var samuraiSize = CGSize(width: 100, height: 100)
    var senseiSize = CGSize(width: 120, height: 120)
  
    let followDistance: CGFloat = 205 // Takip mesafesi
    let arrowDistance: CGFloat = 400
    var targetPosition: CGPoint?
    
    
    func follow (target:CGFloat,knight_position:CGFloat) -> Bool{
        let distance = knight_position - target

        
        if abs(distance) + 100  > followDistance {
            return true

        }
        else {
            return false

        }
    }
    
   
    var index:Int
    var name: String
    var hp:Int
      var power: Int
    var velocity:Int
    var type : SKSpriteNode
      
    init(index:Int,name: String,hp:Int = 10000, power: Int = 1000,velocity:Int = 50, type :SKSpriteNode) {
        self.index = index
          self.name = name
        self.hp = hp
          self.power = power
          self.type = type
        self.velocity = velocity
      }
   
  
  
}



