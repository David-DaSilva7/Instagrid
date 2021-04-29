//
//  File.swift
//  Instagrid
//
//  Created by David Da Silva on 29/04/2021.
//

import Foundation
import UIKit


extension UIView {
    
    public class func findByAccessibilityIdentifier(identifier: String) -> UIView? {
        guard let window = UIApplication.shared.keyWindow else {
            return nil
        }
        
        func findByID(_ view: UIView, _ id: String) -> UIView? {
            if view.accessibilityIdentifier == id {
                return view
            }
            for v in view.subviews {
                if let a = findByID(v, id) {
                    return a
                }
            }
            return nil
        }
        
        return findByID(window, identifier)
    }
    
var screenshot: UIImage? {
    let renderer = UIGraphicsImageRenderer(bounds: bounds)
    return renderer.image { rendererContext in layer.render(in: rendererContext.cgContext) }
}
}
