//
//  GridStackViewController.swift
//  UIStackViewDemo
//
//  Created by Richard Hodgkins on 15/06/2015.
//  Copyright © 2015 Rich H. All rights reserved.
//

import UIKit

final class GridStackViewController: UIViewController {

    @IBOutlet private weak var label: UILabel!
    
    override func traitCollectionDidChange(previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        label?.text = "Width: \(traitCollection.horizontalSizeClass)\nHeight: \(traitCollection.verticalSizeClass)"
    }
}

extension UIUserInterfaceSizeClass: CustomStringConvertible {
    
    public var description: String {
        switch self {
            case Regular:
                return "Regular"
            case Compact:
                return "Compact"
            case Unspecified:
                return "Unspecified"
        }
    }
}