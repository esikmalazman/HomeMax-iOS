//
//  ViewController.swift
//  HomeMax
//
//  Created by Ikmal Azman on 19/12/2021.
//

import UIKit
import SceneKit
import ARKit

enum Assets : String {
    case bastone = "Bastone.scn"
    case bookcase = "Bookcase.scn"
    case dresser = "Dresser.scn"
    case sofa = "Sofa.scn"
}

final class ViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var sceneView: ARSCNView!
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = SCNScene().addContentFromAssets(named: .sofa)
        sceneView.scene = scene
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    
}

