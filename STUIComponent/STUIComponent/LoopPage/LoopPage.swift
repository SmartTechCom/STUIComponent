//
//  LoopPage.swift
//  STUIComponent
//
//  Created by XuAzen on 16/2/25.
//  Copyright © 2016年 st company. All rights reserved.
//

public protocol LoopPageDelegate : UITableViewDelegate {
    func loopPage(numberOfPagesInLoopPage: LoopPage) -> Int
    func loopPage(loopPage: LoopPage , pageViewAtIndex: Int) -> UIView
    func loopPage(loopPage: LoopPage , didSelectPageAtIndex: Int)
}

public class LoopPage: UIView {
    
    public weak var delegate : LoopPageDelegate?
    var collection : UICollectionView?
    var pageControl : UIPageControl?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
}