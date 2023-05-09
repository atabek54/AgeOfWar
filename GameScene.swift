//
//  GameScene.swift
//  AgeOfWar
//
//  Created by Selman Atabek on 16.04.2023.
//

import SpriteKit
import GameplayKit


var knightsIndex1 = [Knight]()
var knightsIndex2 = [Knight]()
var knightsIndex3 = [Knight]()
var knightsIndex4 = [Knight]()
var knightsIndex5 = [Knight]()
var knightsIndex6 = [Knight]()


var enemiesIndex_1 = [Knight]()
var enemiesIndex_2 = [Knight]()
var enemiesIndex_3 = [Knight]()
var enemiesIndex_4 = [Knight]()
var enemiesIndex_5 = [Knight]()
var enemiesIndex_6 = [Knight]()


var randomIndex = 0
var selectedIndex = 0
var selectedCharacterIndex = 0


var battle1:Battle!
var battle2:Battle!
var battle3:Battle!
var battle4:Battle!
var battle5:Battle!
var battle6:Battle!

class GameScene: SKScene,SKPhysicsContactDelegate {
   


    
    var my_progressBar:SKSpriteNode!
    var enemy_progressBar:SKSpriteNode!
  

    var my_side:SKSpriteNode!
    var circle:SKShapeNode!
    var enemy_side:SKSpriteNode!
    var label1:SKLabelNode!
    var label2:SKLabelNode!

    var index_arrow: SKSpriteNode!
    var ok_button: SKSpriteNode!
    var up_button: SKSpriteNode!
    var down_button: SKSpriteNode!
    var left_button: SKSpriteNode!
    var right_button: SKSpriteNode!
    var game:Game?
    var characterTimer: Timer?

    func playSound(){
       let sound = SKAction.playSoundFileNamed("sword", waitForCompletion: false)
        run(sound)
    }
    
    func didBegin(_ contact: SKPhysicsContact){
        let bodyA = contact.bodyA.node?.name?.last
       
        switch bodyA {
       case "0":
            game!.isBattleIndex1 = true
            battle1 = Battle(knight: knightsIndex1.first!, enemy: enemiesIndex_1.first!)
       case "1":
            game!.isBattleIndex2 = true
            battle2 = Battle(knight: knightsIndex2.first!, enemy: enemiesIndex_2.first!)
       case "2":
            game!.isBattleIndex3 = true
            battle3 = Battle(knight: knightsIndex3.first!, enemy: enemiesIndex_3.first!)
       case "3":
            game!.isBattleIndex4 = true
            battle4 = Battle(knight: knightsIndex4.first!, enemy: enemiesIndex_4.first!)
           
        case "4":
            game!.isBattleIndex5 = true
            battle5 = Battle(knight: knightsIndex5.first!, enemy: enemiesIndex_5.first!)
            
        case "5":
            game!.isBattleIndex6 = true
            battle6 = Battle(knight: knightsIndex6.first!, enemy: enemiesIndex_6.first!)
         
        
       default:
           print("Değer belirtilen aralıklarda değil.")
       }
        
        

        
        
        let collision : UInt32 = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        if collision == game!.knightCategory | game!.knightCategory {
            contact.bodyA.node?.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            contact.bodyB.node?.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
    }
       
        else if collision == game!.knightCategory | game!.enemyCategory {
            let nameA = (contact.bodyA.node?.name)
            let nameB = (contact.bodyB.node?.name)
            if nameA!.prefix(6) == "Sensei" {
                game!.changeAnimation(texture: game!.senseiAttackTextures, knight: contact.bodyA.node! as! SKSpriteNode)
            }
            if nameB!.prefix(6) == "Sensei" {
                game!.changeAnimation(texture: game!.senseiAttackTextures, knight: contact.bodyB.node! as! SKSpriteNode)
            }
            
         
        }
        else  if collision == game!.mySideCategory | game!.enemyCategory {
            let name =  contact.bodyB.node?.name?.last
            switch name {
           case "0":
                enemiesIndex_1.first?.type.removeFromParent()
                enemiesIndex_1.remove(at: 0)
           case "1":
                enemiesIndex_2.first?.type.removeFromParent()
                enemiesIndex_2.remove(at: 0)
           case "2":
                enemiesIndex_3.first?.type.removeFromParent()
                enemiesIndex_3.remove(at: 0)
           case "3":
                enemiesIndex_4.first?.type.removeFromParent()
                enemiesIndex_4.remove(at: 0)

            case "4":
                enemiesIndex_5.first?.type.removeFromParent()
                enemiesIndex_5.remove(at: 0)
            case "5":
                enemiesIndex_6.first?.type.removeFromParent()
                enemiesIndex_6.remove(at: 0)
            
           default:
               print("Değer belirtilen aralıklarda değil.")
           }
            // Düşman puan kazandı
            game?.enemyPoint += 100
            game?.myPoint -= 100
            updateProgressBar(isMine: false)
     
            if game!.enemyPoint > 1699 {
                let scene = GameOver(fileNamed: "GameOver")
                scene?.win = false
                
                scene?.scaleMode = .aspectFit
                let transistion = SKTransition.push(with: .up, duration: 3.0)
                self.view?.presentScene(scene!,transition: transistion)
            }
            

            
            
        }
        else  if collision == game!.enemySideCategory | game!.knightCategory {
             
          let name =  contact.bodyB.node?.name
            switch Int(name!) {
           case 0:
                knightsIndex1.first?.type.removeFromParent()
                knightsIndex1.remove(at: 0)
           case 1:
                knightsIndex2.first?.type.removeFromParent()
                knightsIndex2.remove(at: 0)
           case 2:
                knightsIndex3.first?.type.removeFromParent()
                knightsIndex3.remove(at: 0)
           case 3:
                knightsIndex4.first?.type.removeFromParent()
                knightsIndex4.remove(at: 0)

            case 4:
                knightsIndex5.first?.type.removeFromParent()
                knightsIndex5.remove(at: 0)
            case 5:
                knightsIndex6.first?.type.removeFromParent()
                knightsIndex6.remove(at: 0)
            
           default:
               print("Değer belirtilen aralıklarda değil.")
           }
            //BEN PUAN KAZANDIM
            game?.myPoint += 100
            game?.enemyPoint -= 100
            
         updateProgressBar(isMine: true)
            if game!.myPoint > 1699 {
                let scene = GameOver(fileNamed: "GameOver")
                scene?.win = true
                
                
                scene?.scaleMode = .aspectFit
                let transistion = SKTransition.push(with: .up, duration: 3.0)
                self.view?.presentScene(scene!,transition: transistion)
            }
            
        }
    
       }
    
    func updateProgressBar(isMine:Bool){
        if isMine {
            enemy_progressBar.position.x += CGFloat(40)
            my_progressBar.position.x += CGFloat(40)
            my_progressBar.size.width += CGFloat(80)
        } else {
            my_progressBar.position.x -= CGFloat(40)
            enemy_progressBar.position.x -= CGFloat(20)
            enemy_progressBar.size.width += CGFloat(40)
        }
    }
    func changeLabelColor(index:Int){
        if index == 0 {
            label1.fontColor = .systemGreen
            label2.fontColor = .white.withAlphaComponent(0.7)
        }else {
            label1.fontColor = .white.withAlphaComponent(0.7)
            label2.fontColor = .systemGreen
        }
    }
        
    override func didMove(to view: SKView) {

        self.physicsWorld.contactDelegate = self
        selectedIndex = 0
        selectedCharacterIndex = 0
        game = Game(myPoint: 0, enemyPoint: 0, isCoolDown: false)
       
       label1 = SKLabelNode(text: "Samuray")
        label1.zPosition = 8
        label1.position = CGPoint(x: -450, y: 300)
        label1.fontName = "Helvetica-Bold"
        label1.fontSize = 30
        
        label1.fontColor = .systemGreen
        self.addChild(label1)
        
         label2 = SKLabelNode(text: "Sensei")
          label2.zPosition = 8
          label2.position = CGPoint(x: -300, y: 300)
          label2.fontName = "Helvetica-Bold"
          label2.fontSize = 30
        label2.fontColor =  .white.withAlphaComponent(0.7)
          self.addChild(label2)
       
        
    
       
        my_side = SKSpriteNode(color: .gray, size: CGSize(width:1, height: size.height))
        my_side.position = CGPoint(x:-668, y: 0)
        my_side.zPosition = 10
        my_side.physicsBody = SKPhysicsBody.init(rectangleOf:CGSize(width: 1, height: size.height))
        my_side.physicsBody?.allowsRotation = false
        my_side.physicsBody?.isDynamic = false
        my_side.physicsBody?.affectedByGravity = false
        my_side.physicsBody?.categoryBitMask = game!.mySideCategory
        my_side.physicsBody?.contactTestBitMask = game!.enemyCategory
        my_side.name = "my_side"
        self.addChild(my_side)
        //enemy_side
        enemy_side = SKSpriteNode(color: .gray, size: CGSize(width:1, height: size.height))
        enemy_side.position = CGPoint(x:668, y: 0)
        enemy_side.zPosition = 10
        enemy_side.physicsBody = SKPhysicsBody.init(rectangleOf:CGSize(width: 1, height: size.height))
        enemy_side.physicsBody?.allowsRotation = false
        enemy_side.physicsBody?.isDynamic = false
        enemy_side.physicsBody?.affectedByGravity = false
        enemy_side.physicsBody?.categoryBitMask = game!.enemySideCategory
        enemy_side.physicsBody?.contactTestBitMask = game!.knightCategory
        enemy_side.name = "enemy_side"
        self.addChild(enemy_side)
        
    
        my_progressBar = SKSpriteNode(color: .green, size: CGSize(width:game!.my_progressBar_width, height: 30))
        my_progressBar.position = CGPoint(x:-350, y: 360.0)
        my_progressBar.zPosition = 10
        my_progressBar.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.addChild(my_progressBar)
  
        enemy_progressBar = SKSpriteNode(color: .red, size: CGSize(width:game!.enemy_progressBar_width, height: 30))
        enemy_progressBar.position = CGPoint(x:350, y: 360.0)
        enemy_progressBar.zPosition = 10
        enemy_progressBar.anchorPoint = CGPoint(x: 0.5, y: 0.5)

        self.addChild(enemy_progressBar)
     
        index_arrow = SKSpriteNode(imageNamed: "index_arrow")
        index_arrow.position = CGPoint(x:-650.0, y: -310.0)
        index_arrow.zPosition = 8
        index_arrow.size = CGSize(width: 100, height: 100)
        self.addChild(index_arrow)
        
        ok_button = SKSpriteNode(imageNamed: "ok_button")
        ok_button.position = CGPoint(x:534.0, y: -165.0)
        ok_button.zPosition = 15
        ok_button.size = CGSize(width: 100, height: 100)
        self.addChild(ok_button)
      
        
        up_button = SKSpriteNode(imageNamed: "up_arrow")
        up_button.position = CGPoint(x:534.0, y: -80.0)
        up_button.zPosition = 15
        up_button.size = CGSize(width: 100, height: 100)
        self.addChild(up_button)
        
        down_button = SKSpriteNode(imageNamed: "down_arrow")
        down_button.position = CGPoint(x:534.0, y: -250.0)
        down_button.zPosition = 15
        down_button.size = CGSize(width: 100, height: 100)
        self.addChild(down_button)
        
        left_button = SKSpriteNode(imageNamed: "left_arrow")
        left_button.position = CGPoint(x:434.0, y: -165.0)
        left_button.zPosition = 15
        left_button.size = CGSize(width: 100, height: 100)
        self.addChild(left_button)
        
        
        right_button = SKSpriteNode(imageNamed: "right_arrow")
        right_button.position = CGPoint(x:624.0, y: -165.0)
        right_button.zPosition = 15
        right_button.size = CGSize(width: 70, height: 70)
        self.addChild(right_button)
        
        
        
        
        
       for i in 1...8{
           game!.samuraiTextures.append(SKTexture(imageNamed: "s_\(i)"))
        }
        for i in 1...8{
            game!.senseiTextures.append(SKTexture(imageNamed: "k\(i)"))
         }
        for i in 1...13{
            game!.senseiAttackTextures.append(SKTexture(imageNamed: "a\(i)"))
         }
       
      
        
        characterTimer = Timer.scheduledTimer(withTimeInterval: TimeInterval(Int(arc4random_uniform(1)) + Int.random(in: 6...8)), repeats: true) { [weak self] (timer) in
           
            self?.createEnemy()
           
                }
        
        
        
   
      
       

        

     
    }

    func createEnemy(){
    
        let random = Int.random(in: 0...1)
        randomIndex =  Int.random(in: 0...5)
        print("RANDOM : \(randomIndex)")
        var enemy = Knight(index:randomIndex,name: "Samurai\(randomIndex)",velocity: -50, type:SKSpriteNode(imageNamed: "s_1"))
        
        switch random {
       case 0:
            enemy = Knight(index:randomIndex,name: "Samurai\(randomIndex)",power: 1500,velocity: -50, type:SKSpriteNode(imageNamed: "s_1"))
            
       case 1:
           enemy = Knight(index:randomIndex,name: "Sensei\(randomIndex)", power: 2500,velocity: -50, type:SKSpriteNode(imageNamed: "s_walk_1"))
   
        
       default:
           print("Değer belirtilen aralıklarda değil.")
       }
         
        var positionY = 0.0
       
        switch randomIndex {
       case 0:
           positionY = -310
            enemiesIndex_1.append(enemy)
       case 1:
            positionY = -190
            enemiesIndex_2.append(enemy)
       case 2:
            positionY = -70
            enemiesIndex_3.append(enemy)
       case 3:
            positionY = 50
            enemiesIndex_4.append(enemy)
        case 4:
             positionY = 170
            enemiesIndex_5.append(enemy)
        case 5:
             positionY = 290
            enemiesIndex_6.append(enemy)
        
       default:
           print("Değer belirtilen aralıklarda değil.")
       }
        enemy.type.name = random == 0 ? "Samurai\(randomIndex)" : "Sensei\(randomIndex)"
        enemy.type.position = CGPoint(x: 632  , y: positionY)
        enemy.type.zPosition = 10
        enemy.type.size = random == 0 ? enemy.samuraiSize : enemy.senseiSize
        enemy.type.physicsBody?.allowsRotation = false
        enemy.type.physicsBody?.isDynamic = false
        enemy.type.xScale = random == 1 ? -1 : -1
        enemy.type.physicsBody = SKPhysicsBody.init(circleOfRadius:random == 0 ? 30 : 20)
        enemy.type.physicsBody?.categoryBitMask = game!.enemyCategory
        enemy.type.physicsBody?.contactTestBitMask = game!.enemyCategory | game!.knightCategory | game!.mySideCategory

        enemy.type.physicsBody?.affectedByGravity = false
        addChild(enemy.type)
        
        let animation = SKAction.animate(with:random == 0 ? game!.samuraiTextures : game!.senseiTextures, timePerFrame: 0.1)
        let animationRepeat = SKAction.repeatForever(animation)
        enemy.type.run(animationRepeat)

    
        
    }

    func createKnight(index:Int){
        var knight = Knight(index:index,name: "Samurai\(selectedIndex)", type:SKSpriteNode(imageNamed: "k1"))
      
        switch selectedCharacterIndex {
       case 0:
            knight = Knight(index:index,
                            name: "Samurai\(selectedIndex)",
                            type:SKSpriteNode(imageNamed: "s_1")
            )
            
       case 1:
           knight = Knight(index:index,
                           name: "Sensei\(selectedIndex)",
                           power: 2500,
                           type:SKSpriteNode(imageNamed: "s_walk_1")
           )
   
        
       default:
           print("Değer belirtilen aralıklarda değil.")
       }
        
       
        var positionY  = 0.0
         switch index {
        case 0:
            positionY = -310
             knightsIndex1.append(knight)
        case 1:
             positionY = -190
             knightsIndex2.append(knight)
        case 2:
             positionY = -70
             knightsIndex3.append(knight)
        case 3:
             positionY = 50
             knightsIndex4.append(knight)
         case 4:
              positionY = 170
             knightsIndex5.append(knight)
         case 5:
              positionY = 290
             knightsIndex6.append(knight)
         
        default:
            print("Değer belirtilen aralıklarda değil.")
        }
        knight.type.name = selectedCharacterIndex == 0 ? "Samurai\(selectedIndex)" : "Sensei\(selectedIndex)"
        knight.type.position = CGPoint(x: -650  , y: positionY)
        knight.type.zPosition = 10
        knight.type.size = selectedCharacterIndex == 0 ? knight.samuraiSize : knight.senseiSize
        knight.type.physicsBody?.allowsRotation = false
        knight.type.physicsBody?.isDynamic = false
        knight.type.physicsBody?.linearDamping = 1000
        knight.type.physicsBody = SKPhysicsBody.init(circleOfRadius:selectedCharacterIndex == 0 ? 30 : 20)
        knight.type.physicsBody?.categoryBitMask = game!.knightCategory
        knight.type.physicsBody?.contactTestBitMask = game!.enemyCategory | game!.knightCategory | game!.mySideCategory
        knight.type.xScale = selectedCharacterIndex == 0 ?  1 : 1
        knight.type.physicsBody?.affectedByGravity = false
        addChild(knight.type)

        let animation = SKAction.animate(with:selectedCharacterIndex == 0 ?  game!.samuraiTextures:game!.senseiTextures, timePerFrame: 0.15)
        let animationRepeat = SKAction.repeatForever(animation)
        knight.type.run(animationRepeat)
      
        
    }
 
    func updateCoolDown(){
        game?.isCoolDown = true
        ok_button.isHidden = true
        if game?.isCoolDown == true {
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) { [self] in
            game?.isCoolDown = false
            if game?.isCoolDown == false {
                ok_button.isHidden = false
            }
        }}
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for _ in touches {
            for touch in touches {
                let location = touch.location(in: self)
                print(location)
                
                let node = self.atPoint(location)
                if node == ok_button {
                    if   game?.isCoolDown == false {
                           createKnight(index:selectedIndex)

                       }
              updateCoolDown()
               
                }
                if node == up_button {
                    if selectedIndex < 5 {
                        selectedIndex += 1
                        
                        index_arrow.position.y += 120
                    }
                    
                    
                    
                    
                    
                }
                if node == down_button {
                    if selectedIndex > 0 {
                        selectedIndex -= 1
                        index_arrow.position.y -= 120
                        
                    }
                    
        
                    
                }
                if node == left_button {
                    // Bu, mySprite'a dokunulduğunda çalışacak fonksiyonunuzu çağırmak için bir yerdir.
                    if selectedCharacterIndex > 0 {
                        selectedCharacterIndex -= 1
                        changeLabelColor(index: selectedCharacterIndex)

                    }
                    
              

                }
                if node == right_button {
                    if selectedCharacterIndex < 1 {
                        selectedCharacterIndex += 1
                        changeLabelColor(index: selectedCharacterIndex)

                    }

                }
                
            }
        }
        
        
        
    }
  
    func battleKnight(){
        
        
        
        if game!.isBattleIndex1 == true {
          
            knightsIndex1.first?.velocity = 0
            enemiesIndex_1.first?.velocity = 0
            let result =  battle1.battle()
            if result.isDone == true {
                game!.isBattleIndex1 = false
                if result.amIWinner == true {
                    enemiesIndex_1.first?.type.removeFromParent()
                    enemiesIndex_1.remove(at: 0)
                    knightsIndex1.first?.velocity = 50
                    knightsIndex1.first?.hp = result.hp
                    game?.changeAnimation(texture: knightsIndex1.first?.type.name?.prefix(6) == "Sensei" ? game!.senseiTextures:game!.samuraiTextures, knight:    knightsIndex1.first?.type as! SKSpriteNode)
                }else {
                    knightsIndex1.first?.type.removeFromParent()
                    knightsIndex1.remove(at: 0)
                    enemiesIndex_1.first?.velocity = -50
                    enemiesIndex_1.first?.hp = result.hp
                    game?.changeAnimation(texture: enemiesIndex_1.first?.type.name?.prefix(6) == "Sensei" ? game!.senseiTextures:game!.samuraiTextures, knight: enemiesIndex_1.first?.type as! SKSpriteNode)
                }
            }
         
            
        }
        if game!.isBattleIndex2 == true {
          //  print("2. sırada savaş var")
             knightsIndex2.first?.velocity = 0
             enemiesIndex_2.first?.velocity = 0
            let result =  battle2.battle()
              if result.isDone == true {
                  game!.isBattleIndex2 = false
                  if result.amIWinner == true {
                      enemiesIndex_2.first?.type.removeFromParent()
                      enemiesIndex_2.remove(at: 0)
                      knightsIndex2.first?.velocity = 50
                      knightsIndex2.first?.hp = result.hp
                      game?.changeAnimation(texture:knightsIndex2.first?.type.name?.prefix(6) == "Sensei" ? game!.senseiTextures:game!.samuraiTextures, knight:    knightsIndex2.first?.type as! SKSpriteNode)
                  }else {
                      knightsIndex2.first?.type.removeFromParent()
                      knightsIndex2.remove(at: 0)
                      enemiesIndex_2.first?.velocity = -50
                      enemiesIndex_2.first?.hp = result.hp
                      game?.changeAnimation(texture: enemiesIndex_2.first?.type.name?.prefix(6) == "Sensei" ? game!.senseiTextures:game!.samuraiTextures, knight:    enemiesIndex_2.first?.type as! SKSpriteNode)
                  }
              }
          
        }
        if game!.isBattleIndex3 == true {
            knightsIndex3.first?.velocity = 0
            enemiesIndex_3.first?.velocity = 0
         //   print("3. sırada savaş var")
            let result =  battle3.battle()
             if result.isDone == true {
                 game!.isBattleIndex3 = false
                 if result.amIWinner == true {
                     enemiesIndex_3.first?.type.removeFromParent()
                     enemiesIndex_3.remove(at: 0)
                     knightsIndex3.first?.velocity = 50
                     knightsIndex3.first?.hp = result.hp
                     game?.changeAnimation(texture: knightsIndex3.first?.type.name?.prefix(6) == "Sensei" ? game!.senseiTextures:game!.samuraiTextures, knight:    knightsIndex3.first?.type as! SKSpriteNode)
                 }else {
                     knightsIndex3.first?.type.removeFromParent()
                     knightsIndex3.remove(at: 0)
                     enemiesIndex_3.first?.velocity = -50
                     enemiesIndex_3.first?.hp = result.hp
                     game?.changeAnimation(texture: enemiesIndex_3.first?.type.name?.prefix(6) == "Sensei" ? game!.senseiTextures:game!.samuraiTextures, knight:    enemiesIndex_3.first?.type as! SKSpriteNode)
                 }
             }
        }
        if game!.isBattleIndex4 == true {
            knightsIndex4.first?.velocity = 0
            enemiesIndex_4.first?.velocity = 0
         //   print("4. sırada savaş var")
            let result =  battle4.battle()
             if result.isDone == true {
                 game!.isBattleIndex4 = false
                 if result.amIWinner == true {
                     enemiesIndex_4.first?.type.removeFromParent()
                     enemiesIndex_4.remove(at: 0)
                     knightsIndex4.first?.velocity = 50
                     knightsIndex4.first?.hp = result.hp
                     game?.changeAnimation(texture:knightsIndex4.first?.type.name?.prefix(6) == "Sensei" ? game!.senseiTextures:game!.samuraiTextures, knight:    knightsIndex4.first?.type as! SKSpriteNode)
                 }else {
                     knightsIndex4.first?.type.removeFromParent()
                     knightsIndex4.remove(at: 0)
                     enemiesIndex_4.first?.velocity = -50
                     enemiesIndex_4.first?.hp = result.hp
                     game?.changeAnimation(texture: enemiesIndex_4.first?.type.name?.prefix(6) == "Sensei" ? game!.senseiTextures:game!.samuraiTextures, knight:    enemiesIndex_4.first?.type as! SKSpriteNode)
                 }
             }
        }
        if game!.isBattleIndex5 == true {
            knightsIndex5.first?.velocity = 0
            enemiesIndex_5.first?.velocity = 0
         //   print("5. sırada savaş var")
            let result =  battle5.battle()
             if result.isDone == true {
                 game!.isBattleIndex5 = false
                 if result.amIWinner == true {
                     enemiesIndex_5.first?.type.removeFromParent()
                     enemiesIndex_5.remove(at: 0)
                     knightsIndex5.first?.velocity = 50
                     knightsIndex5.first?.hp = result.hp
                     game?.changeAnimation(texture: knightsIndex5.first?.type.name?.prefix(6) == "Sensei" ? game!.senseiTextures:game!.samuraiTextures, knight:    knightsIndex5.first?.type as! SKSpriteNode)
                 }else {
                     knightsIndex5.first?.type.removeFromParent()
                     knightsIndex5.remove(at: 0)
                     enemiesIndex_5.first?.velocity = -50
                     enemiesIndex_5.first?.hp = result.hp
                     game?.changeAnimation(texture: enemiesIndex_5.first?.type.name?.prefix(6) == "Sensei" ? game!.senseiTextures:game!.samuraiTextures, knight:    enemiesIndex_5.first?.type as! SKSpriteNode)
                 }
             }
        }
        
        if game!.isBattleIndex6 == true {
            knightsIndex6.first?.velocity = 0
            enemiesIndex_6.first?.velocity = 0
           // print("6. sırada savaş var")
            let result =  battle6.battle()
             if result.isDone == true {
                 game!.isBattleIndex6 = false
                 if result.amIWinner == true {
                     enemiesIndex_6.first?.type.removeFromParent()
                     enemiesIndex_6.remove(at: 0)
                     knightsIndex6.first?.velocity = 50
                     knightsIndex6.first?.hp = result.hp
                     game?.changeAnimation(texture: knightsIndex6.first?.type.name?.prefix(6) == "Sensei" ? game!.senseiTextures:game!.samuraiTextures, knight:knightsIndex6.first?.type as! SKSpriteNode)
                 }else {
                     knightsIndex6.first?.type.removeFromParent()
                     knightsIndex6.remove(at: 0)
                     enemiesIndex_6.first?.velocity = -50
                     enemiesIndex_6.first?.hp = result.hp
                     game?.changeAnimation(texture:enemiesIndex_6.first?.type.name?.prefix(6) == "Sensei" ? game!.senseiTextures:game!.samuraiTextures, knight:    enemiesIndex_6.first?.type as! SKSpriteNode)
                 }
             }
        }
        
    
    }
    var counter: TimeInterval = 0
    let interval: TimeInterval = 30000000
    
    override func update(_ currentTime: TimeInterval) {
        counter += currentTime
              
              if counter >= interval {
                  // Belirli bir işlemi yürüt
              
                  if game!.isBattleIndex1 == true || game!.isBattleIndex2 == true || game!.isBattleIndex3 == true || game!.isBattleIndex4 == true  || game!.isBattleIndex5 == true || game!.isBattleIndex6 == true  {
                      playSound()
                  }
                  // Sayaçı sıfırla
                  counter = 0
              }
            //SAVAŞ KISMI
       battleKnight()
 
        
       //HAREKET KISMI
      
        moveKnights()

    }
    func moveKnights(){
        for (index, value) in knightsIndex1.enumerated()  {
            if index != 0 {
                let movement =  value.follow(target: knightsIndex1[index-1].type.position.x, knight_position:knightsIndex1[index].type.position.x)
                
                if movement == true {
                    value.type.physicsBody?.velocity = CGVector(dx: value.velocity, dy: 0)

                }
                else {
                    value.type.physicsBody?.velocity = CGVector(dx: 0, dy: 0)

                }
            }
            if index == 0 {
                knightsIndex1.first?.type.physicsBody?.velocity  = CGVector(dx: value.velocity, dy: 0)
            }
        
        }
        //2
        for (index, value) in knightsIndex2.enumerated()  {
          
         
// Yakın Dövüşçü
            
            if index != 0 {
                                
                let movement =  value.follow(target: knightsIndex2[index-1].type.position.x, knight_position:knightsIndex2[index].type.position.x)
                
                
                if movement == true {
                    value.type.physicsBody?.velocity = CGVector(dx: value.velocity, dy: 0)

                }
                else {
                    value.type.physicsBody?.velocity = CGVector(dx: 0, dy: 0)

                }
                
            }
            if index == 0 {
                knightsIndex2.first?.type.physicsBody?.velocity  = CGVector(dx: value.velocity, dy: 0)
            }
           
          
        }
        //3
        for (index, value) in knightsIndex3.enumerated()  {
            if index != 0 {
                let movement =  value.follow(target: knightsIndex3[index-1].type.position.x, knight_position:knightsIndex3[index].type.position.x)
                
                if movement == true {
                    value.type.physicsBody?.velocity = CGVector(dx: value.velocity, dy: 0)

                }
                else {
                    value.type.physicsBody?.velocity = CGVector(dx: value.velocity, dy: 0)

                }
            }
            if index == 0 {
                knightsIndex3.first?.type.physicsBody?.velocity  = CGVector(dx: value.velocity, dy: 0)
            }
          
        }
        //4
        for (index, value) in knightsIndex4.enumerated()  {
            if index != 0 {
                let movement =  value.follow(target: knightsIndex4[index-1].type.position.x, knight_position:knightsIndex4[index].type.position.x)
                
                if movement == true {
                    value.type.physicsBody?.velocity = CGVector(dx: value.velocity, dy: 0)

                }
                else {
                    value.type.physicsBody?.velocity = CGVector(dx: 0, dy: 0)

                }
            }
            if index == 0 {
                knightsIndex4.first?.type.physicsBody?.velocity  = CGVector(dx: value.velocity, dy: 0)
            }
        }
        //5
        for (index, value) in knightsIndex5.enumerated()  {
            if index != 0 {
                let movement =  value.follow(target: knightsIndex5[index-1].type.position.x, knight_position:knightsIndex5[index].type.position.x)
                
                if movement == true {
                    value.type.physicsBody?.velocity = CGVector(dx: value.velocity, dy: 0)

                }
                else {
                    value.type.physicsBody?.velocity = CGVector(dx: 0, dy: 0)

                }
            }
            if index == 0 {
                knightsIndex5.first?.type.physicsBody?.velocity  = CGVector(dx: value.velocity, dy: 0)
            }
        
        }
        //6
        for (index, value) in knightsIndex6.enumerated()  {
            if index != 0 {
                let movement =  value.follow(target: knightsIndex6[index-1].type.position.x, knight_position:knightsIndex6[index].type.position.x)
                
                if movement == true {
                    value.type.physicsBody?.velocity = CGVector(dx: value.velocity, dy: 0)

                }
                else {
                    value.type.physicsBody?.velocity = CGVector(dx: 0, dy: 0)

                }
            }
            if index == 0 {
                knightsIndex6.first?.type.physicsBody?.velocity  = CGVector(dx: value.velocity, dy: 0)
            }
         
        }
        // Düşman Hareketi
        for (index, value) in enemiesIndex_1.enumerated()  {
            if index != 0 {
                let movement =  value.follow(target: enemiesIndex_1[index-1].type.position.x, knight_position:enemiesIndex_1[index].type.position.x)
                
                if movement == true {
                    value.type.physicsBody?.velocity = CGVector(dx: value.velocity, dy: 0)

                }
                else {
                    value.type.physicsBody?.velocity = CGVector(dx: 0, dy: 0)

                }
            }
            if index == 0 {
                enemiesIndex_1.first?.type.physicsBody?.velocity  = CGVector(dx: value.velocity, dy: 0)
            }
        
          
        }
        //2
        for (index, value) in enemiesIndex_2.enumerated()  {
            if index != 0 {
                let movement =  value.follow(target: enemiesIndex_2[index-1].type.position.x, knight_position:enemiesIndex_2[index].type.position.x)
                
                if movement == true {
                    value.type.physicsBody?.velocity = CGVector(dx: value.velocity, dy: 0)

                }
                else {
                    value.type.physicsBody?.velocity = CGVector(dx: 0, dy: 0)

                }
            }
            if index == 0 {
                enemiesIndex_2.first?.type.physicsBody?.velocity  = CGVector(dx: value.velocity, dy: 0)
            }
          
        }        //3
        for (index, value) in enemiesIndex_3.enumerated()  {
            if index != 0 {
                let movement =  value.follow(target: enemiesIndex_3[index-1].type.position.x, knight_position:enemiesIndex_3[index].type.position.x)
                
                if movement == true {
                    value.type.physicsBody?.velocity = CGVector(dx: value.velocity, dy: 0)

                }
                else {
                    value.type.physicsBody?.velocity = CGVector(dx: 0, dy: 0)

                }
            }
            if index == 0 {
                enemiesIndex_3.first?.type.physicsBody?.velocity  = CGVector(dx: value.velocity, dy: 0)
            }
          
        }//4
        for (index, value) in enemiesIndex_4.enumerated()  {
            if index != 0 {
                let movement =  value.follow(target: enemiesIndex_4[index-1].type.position.x, knight_position:enemiesIndex_4[index].type.position.x)
                
                if movement == true {
                    value.type.physicsBody?.velocity = CGVector(dx: value.velocity, dy: 0)

                }
                else {
                    value.type.physicsBody?.velocity = CGVector(dx: 0, dy: 0)

                }
            }
            if index == 0 {
                enemiesIndex_4.first?.type.physicsBody?.velocity  = CGVector(dx: value.velocity, dy: 0)
            }
          
        }
        
        //5
        for (index, value) in enemiesIndex_5.enumerated()  {
            if index != 0 {
                let movement =  value.follow(target: enemiesIndex_5[index-1].type.position.x, knight_position:enemiesIndex_5[index].type.position.x)
                
                if movement == true {
                    value.type.physicsBody?.velocity = CGVector(dx: value.velocity, dy: 0)

                }
                else {
                    value.type.physicsBody?.velocity = CGVector(dx: 0, dy: 0)

                }
            }
            if index == 0 {
                enemiesIndex_5.first?.type.physicsBody?.velocity  = CGVector(dx: value.velocity, dy: 0)
            }
          
        }
        //6
        for (index, value) in enemiesIndex_6.enumerated()  {
            if index != 0 {
                let movement =  value.follow(target: enemiesIndex_6[index-1].type.position.x, knight_position:enemiesIndex_6[index].type.position.x)
                
                if movement == true {
                    value.type.physicsBody?.velocity = CGVector(dx: value.velocity, dy: 0)

                }
                else {
                    value.type.physicsBody?.velocity = CGVector(dx: 0, dy: 0)

                }
            }
            if index == 0 {
                enemiesIndex_6.first?.type.physicsBody?.velocity  = CGVector(dx: value.velocity, dy: 0)
            }
          
        }
            
            
         
          
          
        }
    }
