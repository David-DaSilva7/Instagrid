//
//  File.swift
//  Instagrid
//
//  Created by David Da Silva on 29/04/2021.
//

import Foundation
import UIKit


extension UIView {
    
    // initialize an image rendering with parameters such as output image dimensions and aspect ratio
    var screenshot: UIImage? {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in layer.render(in: rendererContext.cgContext) }
    }
}
