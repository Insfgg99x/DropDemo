//
//  DropScene.swift
//  Rainning&SakuraDemo
//
//  Created by xgf on 2018/8/9.
//  Copyright © 2018年 wxm. All rights reserved.
//

import UIKit
import SpriteKit

class DropScene: SKScene {
    private var dropAction = SKAction.init()
    
    override init(size: CGSize) {
        super.init(size: size)
        setup()
        addNodes()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init()
        setup()
        addNodes()
    }
    private func setup() {
        backgroundColor = .clear
    }
}
extension DropScene {
    //MARK: - 再次调用，会自动取消上一次的drop
    public func drop() {
        stop()
        run(dropAction, withKey: "drop")
    }
    public func stop() {
        removeAction(forKey: "drop")
        removeAllChildren()
    }
}
extension DropScene {
    private func addNodes() {
        let addAction = SKAction.run {
            self.addPiece()
        }
        let wait = SKAction.wait(forDuration: 0.2)
        let sequence = SKAction.sequence([addAction, wait])
        //SKAction.repeat(sequence, count: 20)
        dropAction = SKAction.repeatForever(sequence)
    }
    private func addPiece() {
        let minDuration : CGFloat = 4
        let maxDuration : CGFloat = 5
        let duration = CGFloat(arc4random_uniform(UInt32(maxDuration - minDuration) * 100)) / 100.0 + minDuration
        let node = SKSpriteNode.init(imageNamed: "s")
        let nodeSize = node.size
        let minx = Int(node.size.width)
        let maxx = Int(size.width - nodeSize.width)
        var xpos = Int(arc4random_uniform(UInt32(maxx - minx))) + minx
        node.position = .init(x: CGFloat(xpos), y: size.height + node.size.height)
        addChild(node)
        xpos = Int(arc4random_uniform(UInt32(maxx - minx))) + minx
        let move = SKAction.move(to: .init(x: CGFloat(xpos), y: -node.size.height), duration: TimeInterval(duration))
        let remove = SKAction.run {
            node.removeFromParent()
        }
        let sequence = SKAction.sequence([move, remove])
        node.run(sequence)
    }
}
extension SKAction {
    public class func fadingOutRmove(_ duration : TimeInterval) -> SKAction {
        let feedOut = SKAction.fadeOut(withDuration: 0.1)
        let remove = SKAction.removeFromParent()
        let sequence = SKAction.sequence([feedOut, remove])
        return sequence
    }
}
class DropView: SKView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        return nil
    }
}
