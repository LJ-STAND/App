//
//  ModelViewController.swift
//  LJ STAND
//
//  Created by Lachlan Grant on 19/10/16.
//  Copyright © 2016 Lachlan Grant. All rights reserved.
//

import UIKit
import SceneKit
import Chameleon
import MKKit

class ModelViewController: UIViewController {
    var sceneView: SCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView = SCNView(frame: self.view.frame)
        sceneView.scene = try! SCNScene(url: URL(fileURLWithPath: Bundle.main.path(forResource: "Robot", ofType: "obj")!), options: nil)
        sceneView.backgroundColor = UIColor.flatWhite()
        
        sceneView.autoenablesDefaultLighting = true
        sceneView.allowsCameraControl = true
        sceneView.preferredFramesPerSecond = 60
        sceneView.antialiasingMode = SCNAntialiasingMode.multisampling2X
        sceneView.sizeToFit()
        self.view.addSubview(sceneView)
    }
}
