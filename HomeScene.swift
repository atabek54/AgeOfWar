//
//  HomeScene.swift
//  AgeOfWar
//
//  Created by Selman Atabek on 27.04.2023.
//

import Foundation
import SpriteKit

class HomeScene: SKScene{
    private var sefere_cik_label : SKLabelNode?
    private var title : SKLabelNode?
    private var irk_secimi_label: SKLabelNode?
    private var knight_img: SKSpriteNode?
    private var knight_title: SKLabelNode?
    private var knight_desc: SKLabelNode?
    private var main_menu: SKLabelNode?
    private var start_battle: SKLabelNode?







    override func didMove(to view: SKView) {
    

        self.sefere_cik_label = self.childNode(withName: "//sefere_cik_label") as? SKLabelNode
        self.title = self.childNode(withName: "//title") as? SKLabelNode
        self.irk_secimi_label = self.childNode(withName: "//irk_secimi_label") as? SKLabelNode
        self.knight_img = self.childNode(withName: "//knight_img") as? SKSpriteNode
        self.knight_title = self.childNode(withName: "//knight_title") as? SKLabelNode
        self.knight_desc = self.childNode(withName: "//knight_desc") as? SKLabelNode
        self.main_menu = self.childNode(withName: "//main_menu") as? SKLabelNode
        self.start_battle = self.childNode(withName: "//start_battle") as? SKLabelNode
        
        
        
        

     

    }
    
    func startBattleScene(){
        let scene = HomeScene(fileNamed: "GameScene")
        
        scene?.scaleMode = .aspectFit
        let transistion = SKTransition.push(with: .up, duration: 3.0)
        self.view?.presentScene(scene!,transition: transistion)

    }
    func goMenu(isMain:Bool){
        if isMain == false {
            irk_secimi_label?.isHidden = false
            knight_img?.isHidden = false

            knight_title?.isHidden = false

            knight_desc?.isHidden = false

            main_menu?.isHidden = false

            start_battle?.isHidden = false
            
            sefere_cik_label?.isHidden = true

            
        }
        else {
            irk_secimi_label?.isHidden = true
            knight_img?.isHidden = true

            knight_title?.isHidden = true

            knight_desc?.isHidden = true

            main_menu?.isHidden = true

            start_battle?.isHidden = true
            
            sefere_cik_label?.isHidden = false
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            for touch in touches {
                let location = touch.location(in: self)
                print(location)
                
                let node = self.atPoint(location)
                
                if node == sefere_cik_label{
                    print("Sefere Çık")
                 goMenu(isMain: false)
                  
                }
                if node == main_menu{
                    print("Ana Menü")
                    goMenu(isMain: true)
                    
                }
                if node == start_battle{
              startBattleScene()

                    
                }
            }
        }
        
        
        
    }
 
}
