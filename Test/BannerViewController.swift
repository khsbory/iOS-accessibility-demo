//
//  BannerViewController.swift
//  Test
//
//  Created by Gyeongtae Nam on 2021. 1. 17..
//  Copyright © 2021년 Gyeongtae Nam. All rights reserved.
//

import UIKit

class BannerViewController: UIViewController {
    var mode  :VoiceOverMode = .none
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var btPrev: UIButton!
    @IBOutlet weak var btNext: UIButton!

    
    var count : Int = 0
    
    let banners = [
        "맥도날드",
        "롯데리아",
        "맘스터치",
        "버거킹",
        "파파이스"
    ]
    
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func next(_ sender: UIButton) {
        self.count = self.count + 1
        
        if self.count > self.banners.count - 1  {
            self.count = 0
        }
  
        let x = UIScreen.main.bounds.width * CGFloat(self.count)
        
        self.scrollView.contentOffset = CGPoint(x: x, y: 0)
        

       
        sleep(1)
        UIAccessibility.post(notification: .screenChanged, argument: scrollView)
        UIAccessibility.post(notification: .announcement, argument: self.banners[self.count])
        
        sleep(1)

    }
    @IBAction func prev(_ sender: UIButton) {
        self.count = self.count - 1
        
        if self.count < 0  {
            self.count = self.banners.count - 1
        }

        let x = UIScreen.main.bounds.width * CGFloat(self.count)
        
        self.scrollView.contentOffset = CGPoint(x: x, y: 0)
        
        sleep(1)
        UIAccessibility.post(notification: .screenChanged, argument: scrollView)
        UIAccessibility.post(notification: .announcement, argument: banners[self.count])
        sleep(1)
    }
    
    func setup() {
        

        print(self.mode)
        
        if self.mode == .running {
        
            if UIAccessibility.isVoiceOverRunning {
                self.mode = .running
            }else {
               self.mode = .none
            }
        }
        
        btNext.accessibilityLabel = "다음배너"
        btPrev.accessibilityLabel = "이전배너"
        
        let frame = scrollView.frame
        
        
        var x:CGFloat = 0
        let y:CGFloat = 0
        for (i,banner) in banners.enumerated() {
            
            let width = self.scrollView.frame.width
            let button = MyButton(frame: CGRect(x: x, y: y, width: width, height: 252))
            button.setTitle(banner, for: .normal)
            button.tag = i 
//            view.addSubview(label)
            
            button.accessibilityLabel = banner
            button.backgroundColor = .red
            
            button.addTarget(self, action: #selector(clicked(_:)), for: .touchUpInside)
            view.addSubview(button)
            
            
            scrollView.addSubview(button)
            
            x = x + width
            
        }
        
        


        
        scrollView.contentSize = CGSize(width: x, height: frame.size.height)
        
        
        //let w = frame.size.width
        
        switch(mode) {
        case .none:
            //타이머실행
            timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { (timer) in
                self.count = self.count + 1
                
                if self.count > self.banners.count - 1  {
                    self.count = 0
                }
                
                let x = frame.size.width * CGFloat(self.count)
          
                self.scrollView.contentOffset = CGPoint(x: x, y: 0)
                
            }
            
            btPrev.isHidden = true
            btNext.isHidden = true
            
            self.title = "롤링배너"
        case .running:
             self.title = "접근성이 적용된 예시"
            //타이머 실행 안함
            btPrev.isHidden = false
            btNext.isHidden = false
            
            
            scrollView.isAccessibilityElement = true
            scrollView.accessibilityTraits = .adjustable
        }
    }
    
    override func accessibilityIncrement() {
        scrollView.accessibilityValue = self.banners[self.count]
    }

    override func accessibilityDecrement() {
        scrollView.accessibilityValue = self.banners[self.count]
    }
    
    @objc func clicked(_ sender:UIButton) {
        
        let tag = sender.tag
        
        let title = banners[tag]
        let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
              switch action.style{
              case .default:
                    ()
              case .cancel:
                    ()
              case .destructive:
                    ()
        }}))
        self.present(alert, animated: true, completion: nil)
    }

}



class MyButton : UIButton {
    override var accessibilityTraits: UIAccessibilityTraits {
        get {
            return .adjustable
        }
        set {
            super.accessibilityTraits = newValue
        }
    }

    
}
