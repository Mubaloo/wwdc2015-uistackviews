//
//  DynamicStackViewController.swift
//  UIStackViewDemo
//
//  Created by Richard Hodgkins on 09/06/2015.
//  Copyright © 2015 Rich H. All rights reserved.
//

import UIKit

final class DynamicStackViewController: UIViewController {

    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var textFieldEntryLabel: UILabel!
    @IBOutlet private weak var labelControl: UISegmentedControl!
    @IBOutlet private weak var firstDependentLabel: UILabel!
    @IBOutlet private weak var secondDependentLabel: UILabel!
    @IBOutlet private weak var imageSwitch: UISwitch!
    @IBOutlet private weak var imageRow: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        // Set initial state
        labelControl.selectedSegmentIndex = 0
        imageSwitch.on = true
        
        // Update view states
        doTextFieldTextChangedAction()
        doLabelControlChangedAction()
        doImageSwitchChangedAction()
    }
    
    private func animatedStackViewChange(animation: () -> Void) {
        if view.window == nil {
            // Don't animate if we're not on screen (covers setup case)
            animation()
        } else {
            UIView.animateWithDuration(0.333, animations: animation)
        }
    }
}

// MARK: - Targets

private extension DynamicStackViewController {
    
    @IBAction func doTextFieldTextChangedAction() {
        
        let newHiddenState: Bool
        
        if let text = textField.text where !text.isEmpty {
            textFieldEntryLabel.text = text
            newHiddenState = false
        } else {
            newHiddenState = true
        }
        
        animatedStackViewChange {
            self.textFieldEntryLabel.hidden = newHiddenState
        }
    }
    
    @IBAction func doLabelControlChangedAction() {
    
        func updateLabelState() {
        
            switch labelControl.selectedSegmentIndex {
                case 0:
                    // First
                    firstDependentLabel.hidden = false
                    secondDependentLabel.hidden = true
                
                case 1:
                    // Second
                    firstDependentLabel.hidden = true
                    secondDependentLabel.hidden = false
                
                case 2:
                    // Both
                    firstDependentLabel.hidden = false
                    secondDependentLabel.hidden = false
                
                case 3:
                    // None
                    firstDependentLabel.hidden = true
                    secondDependentLabel.hidden = true
                
                default:
                    break
            }
        }
        
        animatedStackViewChange(updateLabelState)
    }
    
    @IBAction func doImageSwitchChangedAction() {
        animatedStackViewChange {
            self.imageRow.hidden = !self.imageSwitch.on
        }
    }
}
