//
//  LoopPage.swift
//  STUIComponent
//
//  Created by XuAzen on 16/2/25.
//  Copyright © 2016年 st company. All rights reserved.
//

public typealias LoopPageCountClosure = () -> Int
public typealias LoopPageCurrentViewClosure = (pageIndex : Int) -> UIView
public typealias LoopPageTapActionClosure = (pageIndex : Int) -> Void

public class LoopPage: UIView {

    public var defaultImage : UIImage!  // default is nil (UIView && backgroundColor = whiteColor)
    public var timeInterval : NSTimeInterval!  //   default is 0 -> 不自动轮播
    
    private var collectionView : UICollectionView?
    private var pageCountClosure : LoopPageCountClosure?
    private var pageCurrentClosure : LoopPageCurrentViewClosure?
    private var pageTapActionClosure : LoopPageTapActionClosure?
    
    private var pageCount : Int {
        get {
            var pageC = 1
            if pageCountClosure != nil {
                if pageCountClosure!() != 0 {
                    pageC = pageCountClosure!()
                }
            }
            return pageC
        }
    }
    
    private var privateTimeInterval : NSTimeInterval {
        get {
            if timeInterval == 0 {
                return Double(CGFloat.max)
            }
            else {
                return timeInterval
            }
        }
    }
    
    private var realPageCount : Int {
        get {
            return 5000 * pageCount
        }
    }

    override public init(frame: CGRect) {
        pageCountClosure = {() -> Int in
            return 1
        }
        pageCurrentClosure = {(pageIndex : Int) -> UIView in
            let view = UIView()
            view.backgroundColor = UIColor.whiteColor()
            return view
        }
        defaultImage = nil
        timeInterval = 0
        super.init(frame: frame)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience public init(frame: CGRect, countClosur: LoopPageCountClosure, pageClosure: LoopPageCurrentViewClosure, actionClosure: LoopPageTapActionClosure) {
        self.init(frame: frame)
        pageCountClosure = countClosur
        pageCurrentClosure = pageClosure
        pageTapActionClosure = actionClosure
    }
    
    override public func didMoveToSuperview() {
        super.didMoveToSuperview()
        setupBasic()
        timer.fire()
    }
    
    // MARK: - Private
    private func setupBasic() {
        // MARK: - 初始化collection
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: frame.width, height: frame.height)
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView?.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "loopCell")
        collectionView!.dataSource = self
        collectionView!.delegate = self
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.pagingEnabled = true
        addSubview(collectionView!)
        
        pageCtl.frame = CGRect(x: 0, y: 0, width: 100, height: 20)
        pageCtl.center.x = center.x
        pageCtl.frame.origin.y = frame.height - pageCtl.frame.height
        
        if pageCountClosure != nil {
            pageCtl.numberOfPages = pageCountClosure!()
            pageCtl.hidden = false
        } else {
            pageCtl.hidden = true
        }
        addSubview(pageCtl)
    }
    
    //MAEK: - Target
    private var realIndex = 0
    private var index : Int {
        get {
            return realIndex++
        }
    }
    @objc private func timerStart() {
        let num = index
        collectionView?.scrollToItemAtIndexPath(NSIndexPath(forItem: num, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.Left, animated: true)
        print(num)
    }
    
    //KARK: - Lazy
    private lazy var pageCtl : UIPageControl = {
        let pageCtl = UIPageControl()
        pageCtl.backgroundColor = UIColor.redColor()
        return pageCtl
    }()
    
    private lazy var timer : NSTimer = {
        let loopTimer = NSTimer.scheduledTimerWithTimeInterval(1000, target: self, selector: Selector("timerStart"), userInfo: nil, repeats: true)
        return loopTimer
    }()
}

extension LoopPage : UICollectionViewDataSource, UICollectionViewDelegate {
    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return realPageCount
    }
    
    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let page = collectionView.dequeueReusableCellWithReuseIdentifier("loopCell", forIndexPath: indexPath)
        page.backgroundColor = UIColor.randomColor()
        let realIndex = indexPath.item % pageCount
        let currentView = pageCurrentClosure!(pageIndex: realIndex)
        currentView.frame = page.bounds
        for subView in page.subviews {
            subView.removeFromSuperview()
        }
        page.addSubview(currentView)
        
        return page
    }
    
    public func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        
        let currentPageIndex = collectionView.indexPathsForVisibleItems().first
        print(currentPageIndex)
        if let currentPageNum = currentPageIndex?.item {
            pageCtl.currentPage = currentPageNum % pageCount
        }
    }
    
    public func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if pageTapActionClosure != nil {
            pageTapActionClosure!(pageIndex: indexPath.item % pageCount)
        }
    }
}


//TODO: - 添加进Categray中
extension UIColor {
    class func randomColor() -> UIColor {
        return UIColor(red: CGFloat(Double(arc4random_uniform(100)) * 0.01), green: CGFloat(Double(arc4random_uniform(100)) * 0.01), blue: CGFloat(Double(arc4random_uniform(100)) * 0.01), alpha: 1)
    }
}



