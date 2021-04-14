//
//  ViewController.swift
//  Instagrid
//
//  Created by David Da Silva on 06/04/2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        selectedMiddle.isHidden = false
    }
    
    @IBOutlet weak var selectedLeft: UIImageView!
    
    @IBOutlet weak var selectedRight: UIImageView!
    
    @IBOutlet weak var selectedMiddle: UIImageView!

    @IBAction func leftButton(_ sender: Any) {
       
    }
    
    @IBAction func middleButton(_ sender: Any) {

    }
    
    @IBAction func rightButton(_ sender: Any) {

    }
    
    @IBOutlet weak var imageOne: UIImageView!
    
    @IBOutlet weak var imageTwo: UIImageView!
    
    @IBOutlet weak var imageThree: UIImageView!
    
    @IBAction func didTapPlusOne(_ sender: Any) {
    }
    
    @IBAction func didTapPlusTwo(_ sender: Any) {
    }
    
    @IBAction func didTapPlusThree(_ sender: Any) {
    }
    
}

