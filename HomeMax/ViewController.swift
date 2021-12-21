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
        // Set view's delegate
        sceneView.delegate = self
        sceneView.debugOptions = .showFeaturePoints
        // Create new scene
        let scene = SCNScene().addContentFromAssets(named: .sofa)
        // Set scene to view
        sceneView.scene = scene
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        // Enable horizontal plane detection
        configuration.planeDetection = .horizontal
        // Run view session
        sceneView.session.run(configuration)
        sceneView.autoenablesDefaultLighting = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Pause view session
        sceneView.session.pause()
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let firstTouch = touches.first else {return}
//        print("Touch : \(firstTouch.altitudeAngle)")
//    }
    
    
}
//MARK: - ARSceneViewDelegate
extension ViewController : ARSCNViewDelegate {
    // Allow to get info about width and height from ARAnchor for detected surface
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        // Deterimine if detected anchor is ARPlaneAnchor
        guard let planeAnchor = anchor as? ARPlaneAnchor else {return}
        // Convert dimension of anchor to SCNPlane, that allow to create plane in SceneKit
        let plane = SCNPlane(width:CGFloat( planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.z))
        // Add the material to the plane
        let planeMaterial = SCNMaterial()
        planeMaterial.diffuse.contents = UIImage(named: "grid")
        plane.materials = [planeMaterial]
        // Create node for plane
        let planeNode = SCNNode()
        // Add position for planeAnchor
        planeNode.position = SCNVector3(x: planeAnchor.center.x, y: 0, z: planeAnchor.center.z)
        // Convert plane anchor to horizontal, as default, SceneKit create plane as Vertical, so we need to make it horizontal with transform it
        // Rotate on plane on X-axis
        planeNode.transform = SCNMatrix4MakeRotation(-Float.pi / 2, 1, 0, 0)
        // Add plane to node
        planeNode.geometry = plane
       // Add plane node to root node
        node.addChildNode(planeNode)
    }
}
