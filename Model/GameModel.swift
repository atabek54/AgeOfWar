//
//  GameModel.swift
//  AgeOfWar
//
//  Created by Selman Atabek on 27.04.2023.
//

import SpriteKit

struct  Game {
    var myPoint:Int
    var enemyPoint:Int
    var isCoolDown:Bool
    
    var isBattleIndex1 = false
    var isBattleIndex2 = false
    var isBattleIndex3 = false
    var isBattleIndex4 = false
    var isBattleIndex5 = false
    var isBattleIndex6 = false
    
    let enemyCategory:UInt32 = 0x1
    let knightCategory:UInt32 = 0x10
    let mySideCategory:UInt32 = 0x100
    let enemySideCategory:UInt32 = 0x1000
    
    
    var samuraiTextures:[SKTexture] = []
    var senseiTextures:[SKTexture] = []
    var senseiAttackTextures:[SKTexture] = []
    
    
    
    var my_progressBar_width = 690
    var enemy_progressBar_width = 690
    
    func changeAnimation(texture:[SKTexture],knight:SKSpriteNode){
        let animation = SKAction.animate(with:texture, timePerFrame: 0.1)
        let animationRepeat = SKAction.repeatForever(animation)
        knight.run(animationRepeat)
    }
}

