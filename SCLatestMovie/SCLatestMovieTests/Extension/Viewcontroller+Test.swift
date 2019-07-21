//
//  Viewcontroller+Test.swift
//  SCLatestMovieTests
//
//  Created by Suman Chatterjee on 21/07/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import UIKit
import Quick
import Nimble

extension UIViewController {
    func preloadView() {
        _ = view
    }
    
    func appear() {
        beginAppearanceTransition(true, animated: false)
        endAppearanceTransition()
    }
    
    func appearInWindow() -> UIWindow {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = self
        window.makeKeyAndVisible()
        
        _ = self.view
        expect(self.isViewLoaded).toEventually(beTrue(), pollInterval: 0.3)
        
        return window
    }
    
    @discardableResult
    func appearInWindowTearDown() -> (window: UIWindow, tearDown: () -> ()) {
        let window = appearInWindow()
        
        let tearDown = {
            window.rootViewController = nil
        }
        
        return (window: window, tearDown: tearDown)
    }
    
    func presentInWindow() -> UIWindow {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let parent = UIViewController()
        window.rootViewController = parent
        window.makeKeyAndVisible()
        parent.present(self, animated: false)
        
        _ = parent.view
        expect(parent.isViewLoaded).toEventually(beTrue(), pollInterval: 0.5)
        
        _ = self.view
        expect(self.isViewLoaded).toEventually(beTrue(), pollInterval: 0.5)
        
        return window
    }
    
    @discardableResult
    func presentInWindowTearDown() -> (window: UIWindow, tearDown: ()->()) {
        let window = presentInWindow()
        
        let tearDown = {
            self.dismiss(animated: false) {
                self.removeFromParent()
                window.rootViewController?.dismiss(animated: false)
                window.rootViewController = nil
            }
        }
        
        return (window, tearDown)
    }
}
