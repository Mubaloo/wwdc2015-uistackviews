//
//  AnimatedStackViewController.swift
//  UIStackViewDemo
//
//  Created by Richard Hodgkins on 09/06/2015.
//  Copyright © 2015 Rich H. All rights reserved.
//

import UIKit

final class AnimatedStackViewController: UIViewController {

    @IBOutlet private var stacks: [UIStackView]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        toggle()
    }
    
    private func toggle() {
        func toggleAxis(s: UIStackView) {
            if s.axis == .Horizontal {
                s.axis = .Vertical
                s.spacing = s.bounds.height * 0.05
            } else {
                s.axis = .Horizontal
                s.spacing = s.bounds.width * 0.05
            }
        }
        for s in stacks {
            toggleAxis(s)
        }
    }
    
    @IBAction func doAxisBarItemAction() {
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: -2, options: .CurveEaseInOut, animations: toggle, completion: nil)
    }
}
