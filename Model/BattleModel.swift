//
//  BattleModel.swift
//  AgeOfWar
//
//  Created by Selman Atabek on 18.04.2023.
//

import SpriteKit

struct Battle {
    var knight:Knight
    var enemy:Knight
   
  //  init(knight: Knight, enemy: Knight) {
    //    self.knight = knight
      //  self.enemy = enemy
    //}
    func calcAttack(power:Float)->Float{
        let attack = power * 0.01 + Float.random(in: 1...50)
        return attack
    }
    
    func battle () -> (isDone:Bool,amIWinner:Bool,hp:Int){
        knight.hp -= Int(calcAttack(power: Float(enemy.power)))
        enemy.hp -= Int(calcAttack(power: Float(knight.power)))
        print("MYHP: \(knight.hp)")
        print("ENEMYHP: \(enemy.hp)")

        if knight.hp < 0  {
            
            return (true,false,enemy.hp)

        }
        else {
            if enemy.hp < 0 {
                return (true,true,knight.hp)
            }
            return (false,false,0)

        }
    }
}

    
   
    
   
  

