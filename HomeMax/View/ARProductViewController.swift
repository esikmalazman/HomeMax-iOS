//
//  ARProductViewController.swift
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

final class ARProductViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var sceneView: ARSCNView!
    
    //MARK: - Variables
    private var nodeItems = [SCNNode]()
    private var planeItems = [ARPlaneAnchor]()
    private var bottomSheet : BottomSheet = {
        let vc = BottomSheet(nibName: BottomSheet.nibName, bundle: nil)
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        return vc
    }()
    /// Create view to display for onboarding instructions like Apple does
    private let coachingOverlay = ARCoachingOverlayView()
    
    var assetsName : Assets?
    var selectedProduct : Product?
    
    //MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.isUserInteractionEnabled = false
        navigationController?.navigationBar.tintColor = .primaryDarkGreen
        AppTheme.clearDefaultNavigationBar(navigationController!.navigationBar)
        setupCoachingOverlay()
        setupSceneConfiguration()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Pause view session
        sceneView.session.pause()
    }
    //MARK: - Actions
    @IBAction func refreshTap(_ sender: UIBarButtonItem) {
        removeAllItem()
        // Reset sceneView
        setupCoachingOverlay()
        setupSceneConfiguration()
    }
}

//MARK: - ARSceneViewDelegate
extension ARProductViewController : ARSCNViewDelegate {
    // Allow to get info about width and height from ARAnchor for detected surface
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        // Allow only one plane get created when it detect
        guard planeItems.isEmpty else {return}
        // Determine if detected anchor is ARPlaneAnchor
        guard let planeAnchor = anchor as? ARPlaneAnchor else {return}
        planeItems.append(planeAnchor)
        let planeNode = createPlaneNode(with: planeAnchor)
        // Add plane node to root node
        node.addChildNode(planeNode)
    }
}

//MARK: - UITouch events method
extension ARProductViewController {
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
        // Allow to only one item get created when touch
        guard nodeItems.count < 1 else {return}
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
        let sceneNode = createScene(fromHitResults: hitTestResults)
        // Add new node in collections
        nodeItems.append(sceneNode)
        sceneView.scene.rootNode.addChildNode(sceneNode)
    }
}

//MARK: - Private methods
extension ARProductViewController {
    private func createPlaneNode(with planeAnchor : ARPlaneAnchor) -> SCNNode {
        // Convert dimension of anchor to SCNPlane, that allow to create plane in SceneKit
        let plane = SCNPlane(width:CGFloat( planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.z))
        
        // Add the material to the plane
        let planeMaterial = SCNMaterial()
        planeMaterial.transparency = 0.4
        planeMaterial.diffuse.contents = UIImage(named: "circle")
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
        
        return planeNode
    }
    
    private func removeAllItem() {
        for item in nodeItems {
            item.removeFromParentNode()
            nodeItems.removeAll()
        }
        for anchor in planeItems {
            sceneView.session.remove(anchor: anchor)
            planeItems.removeAll()
        }
    }
    
    private func createScene(fromHitResults hitResults: ARHitTestResult) -> SCNNode {
        
        let objectScene = SCNScene().addContentFromAssets(named: assetsName!)
        let objectNode = objectScene.rootNode.childNode(withName: assetsName?.rawValue ?? "nil", recursively: true)!
        // World Transform,  allow to get value for position and orientation in world coordinate system
        objectNode.position = SCNVector3(
            x:hitResults.worldTransform.columns.3.x,
            y: hitResults.worldTransform.columns.3.y,
            z: hitResults.worldTransform.columns.3.z - 0.5
        )
        return objectNode
    }
    
    func setupCoachingOverlay() {
        // Determine instructions to user on coach overlay, in this case we set to give horizontalPlane instructions
        coachingOverlay.goal = .horizontalPlane
        // Enable coach overlay
        coachingOverlay.activatesAutomatically = true
        coachingOverlay.frame = view.bounds
        // Add coach coverlay as subview of sceneView
        sceneView.addSubview(coachingOverlay)
        // Add coach overlay to sceneView session
        coachingOverlay.session = sceneView.session
        // Set ARCoachingOverlay delegate
        coachingOverlay.delegate = self
    }
    
    private func setupSceneView() {
        // Set view's delegate
        sceneView.delegate = self
        sceneView.autoenablesDefaultLighting = true
    }
    private func setupSceneConfiguration() {
        let configuration = ARWorldTrackingConfiguration()
        // Enable horizontal plane detection
        configuration.planeDetection = .horizontal
        configuration.isAutoFocusEnabled = true
        
        // Run view session
        sceneView.session.run(configuration, options: [.resetTracking,.removeExistingAnchors])
        
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupBottomSheet() {
        add(bottomSheet)
        guard let selectedProduct = selectedProduct else {return}
        bottomSheet.setBottomSheetContent(image: selectedProduct.image, label: selectedProduct.name, price: selectedProduct.price)
        bottomSheet.runBottomSheetAnimation()
        NSLayoutConstraint.activate([
            bottomSheet.view.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            bottomSheet.view.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            bottomSheet.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

//MARK: - ARCoachingOverlayView Delegate
extension ARProductViewController : ARCoachingOverlayViewDelegate {
    
    func coachingOverlayViewDidDeactivate(_ coachingOverlayView: ARCoachingOverlayView) {
        view.isUserInteractionEnabled = true
        navigationController?.navigationBar.isHidden = false
        showToaster(withMessage: "Tap screen to place the furniture in your space")
        setupSceneView()
        setupBottomSheet()
    }
}
