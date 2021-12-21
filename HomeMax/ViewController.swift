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
    case bastone = "Bastone"
    case bookcase = "Bookcase"
    case dresser = "Dresser"
    case sofa = "Sofa"
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
        sceneView.autoenablesDefaultLighting = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        // Enable horizontal plane detection
        configuration.planeDetection = .horizontal
        configuration.isAutoFocusEnabled = true
        // Run view session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Pause view session
        sceneView.session.pause()
    }
    
    /*
     Hit Test Concepts
     1. App run, user tap on screen
     2. User tap being convert to its location
     3. if touchesBegan method being trigger, it will find touch location as 2D spaces (x,y)
     4. Convert the location tap to 3D coordinate in sceneView
     5. Object will be places on detected plane
     */
    
    // Detect touches on screen, and place the object in real world
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Detect if get the first touch
        guard let firstTouch = touches.first else {return}
        // Store variable for location(2D location) of detected touch in sceneView
        let touchLocation = firstTouch.location(in: sceneView)
        // Convert touch location (2D) to 3D coordinate, search the position in Real World
        let results = sceneView.hitTest(touchLocation, types : .existingPlaneUsingExtent)
        // Get the first hit test results
        guard let hitTestResults = results.first else {return}
        //        print("Hit Test Results \(hitTestResults)")
        // Create and place scene at the hit test results
        let objectScene = SCNScene().addContentFromAssets(named: .bastone)
        let objectNode = objectScene.rootNode.childNode(withName: Assets.bastone.rawValue, recursively: true)!
        // World Transform,  allow to get value for position and orientation in world coordinate system
        objectNode.position = SCNVector3(
            x:hitTestResults.worldTransform.columns.3.x,
            y: hitTestResults.worldTransform.columns.3.y - 0.1,
            z: hitTestResults.worldTransform.columns.3.z - 0.5
        )
        sceneView.scene.rootNode.addChildNode(objectNode)
    }
}
//MARK: - ARSceneViewDelegate
extension ViewController : ARSCNViewDelegate {
    // Allow to get info about width and height from ARAnchor for detected surface
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
        // Determine if detected anchor is ARPlaneAnchor
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
