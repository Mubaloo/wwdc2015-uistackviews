//
//  RotatingStackViewController.swift
//  UIStackViewDemo
//
//  Created by Richard Hodgkins on 09/06/2015.
//  Copyright © 2015 Rich H. All rights reserved.
//

import UIKit

final class RotatingStackViewController: UIViewController {

    @IBOutlet private weak var stack: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func willTransitionToTraitCollection(newCollection: UITraitCollection, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransitionToTraitCollection(newCollection, withTransitionCoordinator: coordinator)
        
        coordinator.animateAlongsideTransition({ _ in
            
            self.stack?.axis = newCollection.verticalSizeClass == .Compact ? .Horizontal : .Vertical
            
        }) { _ in
            
            
//            print("Comp: V - \(self.stack?.axis == .Vertical)")
        }
    }
    
    override func traitCollectionDidChange(previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        print("\(previousTraitCollection) -> \n\(traitCollection)")
//
//        print(stack.axis == .Vertical)
//        view.layoutIfNeeded()
//        
//        stack.axis = traitCollection.verticalSizeClass == .Compact ? .Horizontal : .Vertical
        
        //        print(stack)
//        print("DID: V - \(stack.axis == .Vertical)")
//        print("DID: S - \(stack.spacing)")
//        view.layoutIfNeeded()
    }
}

