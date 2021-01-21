//
//  ViewController.swift

//  Test
//
//  Created by Gyeongtae Nam on 2021. 1. 17..
//  Copyright © 2021년 Gyeongtae Nam. All rights reserved.
//

import UIKit


enum VoiceOverMode {
    case none
    case running
}

class ViewController: UIViewController {
    
    var mode  :VoiceOverMode = .none

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "접근성데모"
       

    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch(segue.identifier) {
            case "Menu":
                ()
            default:
                ()
        }
    }

    @IBAction func action(_ sender: UIButton) {
        self.performSegue(withIdentifier: "Menu", sender: nil)
    }
}

