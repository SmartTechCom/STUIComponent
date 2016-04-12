//
//  SliderButtonView.swift
//  test
//
//  Created by 姜云锋 on 16/2/25.
//  Copyright © 2016 姜云锋. All rights reserved.
//

import UIKit

public protocol SliderButtonViewDelegate {
    func sliderButtonView(slider:SliderButtonView, index:NSInteger)
}

public class SliderButtonView: UIView, UIScrollViewDelegate {
    public var delegate:SliderButtonViewDelegate?
    var mySeletColor:UIColor?
    var myUnSeletColor:UIColor?
    var scrollView:UIScrollView?
    var count:NSInteger = 0
    var currentIndex:NSInteger = 0
    var imageView:UIImageView?
    var unseleImageArray:NSMutableArray = []
    var seleImageArray:NSMutableArray = []
    var titleArray:NSMutableArray = []
    var width:NSInteger = 0
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//    }
//
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public init(titleArray:NSMutableArray, width:NSInteger, slectColor:UIColor, unSelectColor:UIColor){
        super.init(frame:CGRect(x: 0, y: 0, width: width, height: 50))
        self.titleArray = titleArray;
        self.width = width;
        self.mySeletColor = slectColor
        self.myUnSeletColor = unSelectColor
        self.setup()
    }
    
     func setup() {
        self.backgroundColor = UIColor.whiteColor()
        self.scrollView = UIScrollView.init(frame: CGRectMake(0, 0, CGFloat(self.width), 50))
        self.scrollView!.showsHorizontalScrollIndicator=false //不显示横向滚动条
        
        self.scrollView!.bounces = false
        
        
        let buttonW = width/titleArray.count
        let buttonH = 45
        
        let count:NSInteger = titleArray.count
        
        
        for  var i = 0; i < count; i++ {
            
            let btn:UIButton = UIButton(frame: CGRect(x: buttonW * i, y: 0, width: buttonW, height: buttonH))
            
            self.scrollView!.contentSize = CGSizeMake(CGFloat(self.width), 45)
            btn.tag = 100+i
            btn.setTitle(titleArray[i] as? String, forState: UIControlState.Normal)
            btn.titleLabel!.font = UIFont.systemFontOfSize(16)
            btn.setTitleColor(myUnSeletColor, forState: UIControlState.Normal)
            btn.setTitleColor(mySeletColor, forState: UIControlState.Selected)
            
            btn.titleLabel!.font = UIFont.systemFontOfSize(16)
            if 320 == self.width {
                btn.titleLabel!.font = UIFont.systemFontOfSize(14)
            }
            
            //选中按钮背景
            btn.tintColor = UIColor.whiteColor();
            btn.addTarget(self, action:Selector("btnClicked:"), forControlEvents: UIControlEvents.TouchUpInside)
            self.scrollView!.addSubview(btn)
        }
        
        let backlabel:UILabel = UILabel(frame: CGRect(x: 0, y: 44, width: width, height: 1));
        backlabel.backgroundColor = UIColor.init(colorLiteralRed: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        self.addSubview(backlabel);
        
        self.imageView = UIImageView(frame: CGRect(x: 15, y: buttonH-2, width: buttonW, height: 2));
        
        self.imageView!.backgroundColor = mySeletColor
        self.scrollView!.addSubview(self.imageView!)
        
        self.count = titleArray.count
        
        self.frame = self.scrollView!.bounds
        self.addSubview(self.scrollView!)
        self.selectAtIndex(0);
    }
    
    public func changeSliderViewBack(backAlpha:CGFloat) {
        self.imageView?.alpha = backAlpha
        for subView:UIView in self.scrollView!.subviews {
            if subView.isKindOfClass(UIButton.classForCoder()) {
                let btn:UIButton = subView as! UIButton
                if backAlpha > 0.5 {
                    btn.setTitleColor(UIColor.init(colorLiteralRed: 0.25, green: 0.25, blue: 0.25, alpha: 1.00), forState: UIControlState.Normal)
                    btn.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Selected)
                } else {
                    btn.setTitleColor(UIColor.init(red: 0.6, green: 0.6, blue: 0.6, alpha: backAlpha), forState: UIControlState.Normal)
                    btn.setTitleColor(UIColor.init(white: 1, alpha: backAlpha), forState: UIControlState.Selected)
                }
                
            }
        }
    }
    
    public func selectAtIndex(index:NSInteger) {
        self.currentIndex = index;
        for subView:UIView in self.scrollView!.subviews {
            if subView.isKindOfClass(UIButton.classForCoder()) {
                let btn:UIButton = subView as! UIButton
                btn.selected = false
            }
        }
        let button:UIButton = self.scrollView!.viewWithTag(100+index) as! UIButton
        var frame:CGRect = button.frame;
        frame.origin.y = 45-2;
        frame.size.height = 2;
        self.imageView!.frame = frame;
        button.selected = true
    }
    
    func btnClicked(button:UIButton) {
        if (self.currentIndex != button.tag-100) {
            
            self.selectAtIndex(button.tag-100)
            self.delegate?.sliderButtonView(self, index: button.tag-100)
        }
    }

}


