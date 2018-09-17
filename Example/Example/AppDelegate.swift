//
//  AppDelegate.swift
//  Example
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
	
	func applicationDidFinishLaunching(_ application: UIApplication) {

		// It's the simpest way!
        Visualizer.start()
		
        // Initialize with config - octocat
//		var config = Configuration()
//		config.color = UIColor.black
//		config.showsTimer = true
//		config.showsTouchRadius = true
//		config.showsLog = true
//		config.image = UIImage(named: "octocat")
//		Visualizer.start(config)
	}
}

