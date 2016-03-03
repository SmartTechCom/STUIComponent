//
//  ViewController.swift
//  STCEditProject
//
//  Created by XuAzen on 16/2/24.
//  Copyright © 2016年 XuAzen. All rights reserved.
//

import UIKit
import STUIComponent

class ViewController: UIViewController ,SliderButtonViewDelegate{

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var testLabel: LineSpacingLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
//        setupBasic()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        setupBasic()
        setupSlider()
    }
    // MARK: - 初始化
    func setupBasic() {
        loopPage.frame = headerView.bounds
        headerView.addSubview(loopPage)
        testLabel.lineSpacing = 3
//        testLabel.text = "哈2"
    }
    
    // MARK: - Lazy
    lazy var loopPage : LoopPage = {
        
        let page = LoopPage(frame: CGRect(x: 0,y: 0,width: 375,height: 100), timeInter: 0, countClosur: { () -> Int in
            return 5
            }, pageClosure: { (pageIndex) -> UIView in
                let label = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
                label.text = "pageIndex：\(pageIndex)"
                label.textAlignment = NSTextAlignment.Center
                
                return label
            }, actionClosure: { (pageIndex) -> Void in
                print("\(pageIndex)")
        })
        return page
    }()

    
    func setupSlider() {
        let slider:SliderButtonView = SliderButtonView(titleArray: ["111", "222"], width: 320)
        slider.delegate = self
        self.view.addSubview(slider)
    }
    func sliderButtonView(slider: SliderButtonView, index: NSInteger) {
        print("\(index)")
    }
}

