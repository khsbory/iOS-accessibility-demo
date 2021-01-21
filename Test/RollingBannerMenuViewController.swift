//
//  RollingBannerMenuViewController.swift
//  Test
//
//  Created by vitus on 2021/01/22.
//  Copyright © 2021 Gyeongtae Nam. All rights reserved.
//

import UIKit

class RollingBannerMenuViewController: UIViewController {

    var mode:VoiceOverMode = .none	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "롤링배너"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch(segue.identifier) {
        case "VoiceOver":
            let vc = segue.destination as! BannerViewController
            vc.mode = self.mode
   
        default:
            ()
        }
    }

    @IBAction func actionApply(_ sender: UIButton) {
        
        self.mode = .running
        
        self.performSegue(withIdentifier: "VoiceOver", sender: nil)
    }
    
    @IBAction func actionNormal(_ sender: UIButton) {
        
        self.mode = .none
        
         self.performSegue(withIdentifier: "VoiceOver", sender: nil)
    }

}
