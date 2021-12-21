//
//  SCNNode+Extensions.swift
//  HomeMax
//
//  Created by Ikmal Azman on 20/12/2021.
//

import SceneKit

extension SCNScene {
    func addContentFromAssets(named name : Assets) -> SCNScene {
        let assetsURL = "Art.scnassets/" + "\(name.rawValue)"+".scn"
        let scene = SCNScene(named: assetsURL)!
        return scene
    }
}
