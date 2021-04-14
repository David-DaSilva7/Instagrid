//
//  ViewController2.swift
//  Instagrid
//
//  Created by David Da Silva on 13/04/2021.
//

import UIKit

class ViewController2: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        selectedLeft.isHidden  = false
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var selectedLeft: UIImageView!
    
    @IBOutlet weak var selectedMiddle: UIImageView!
    
    @IBOutlet weak var selectedRight: UIImageView!
    
    
    @IBAction func leftButton(_ sender: Any) {

    }
    

    @IBAction func middleButton(_ sender: Any) {
    }
    
    
    @IBAction func rightButton(_ sender: Any) {
 
    }
}
