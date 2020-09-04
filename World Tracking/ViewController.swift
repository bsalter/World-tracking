//
//  ViewController.swift
//  World Tracking
//
//  Created by Benjamin Salter on 8/22/20.
//  Copyright © 2020 Benjamin Salter. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {
    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        self.sceneView.session.run(configuration)
        self.sceneView.autoenablesDefaultLighting = true
    }
    
    @IBAction func Add(_ sender: UIButton) {
        let pyramidNode = SCNNode()
        pyramidNode.geometry = SCNPyramid(width: 0.1, height: 0.1, length: 0.1)
        pyramidNode.geometry?.firstMaterial?.specular.contents = UIColor.orange
        pyramidNode.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        pyramidNode.eulerAngles = SCNVector3(90.degreesToRadians, 0, 0)
//        let x = randomNumbers(firstNum: -0.3, secondNum: 0.3)
//        let y = randomNumbers(firstNum: -0.3, secondNum: 0.3)
//        let z = randomNumbers(firstNum: -0.3, secondNum: 0.3)
        let cylinderNode = SCNNode()
        cylinderNode.geometry = SCNCylinder(radius: 0.05, height: 0.05)
        cylinderNode.geometry?.firstMaterial?.specular.contents = UIColor.green
        cylinderNode.geometry?.firstMaterial?.diffuse.contents = UIColor.purple
        pyramidNode.position = SCNVector3(0.2, 0.3, -0.2)
        cylinderNode.position = SCNVector3(-0.3, 0.2, -0.3)
        self.sceneView.scene.rootNode.addChildNode(pyramidNode)
        pyramidNode.addChildNode(cylinderNode)
    }
    
    @IBAction func reset(_ sender: UIButton) {
        restartSession()
        
    }
    
    func restartSession() {
        self.sceneView.session.pause()
        self.sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
            node.removeFromParentNode()
        }
        self.sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    func randomNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }

}

extension Int {
    var degreesToRadians: Float {
        return Float(Double(self) * .pi/180)
    }
}
