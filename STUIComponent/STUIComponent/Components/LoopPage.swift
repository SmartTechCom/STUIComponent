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

    public var timeInterval : NSTimeInterval!  //   default is 0 -> 不自动轮播
    
    private var collectionView : UICollectionView?
    private var pageCountClosure : LoopPageCountClosure?
    private var pageCurrentClosure : LoopPageCurrentViewClosure?
    private var pageTapActionClosure : LoopPageTapActionClosure?
    private var timer : NSTimer?
    
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
    
    
    //MARK: - init
    override private init(frame: CGRect) {
        pageCountClosure = {() -> Int in
            return 1
        }
        pageCurrentClosure = {(pageIndex : Int) -> UIView in
            let view = UIView()
            view.backgroundColor = UIColor.whiteColor()
            return view
        }
        timeInterval = 0
        super.init(frame: frame)
        
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     快速生成LoopPage
     
     - parameter frame:         frame
     - parameter timeInter:     自动轮播时长，为0时表示不自动轮播
     - parameter countClosur:   返回page数
     - parameter pageClosure:   当前page
     - parameter actionClosure: page点击事件
     
     - returns: LoopPage
     */
    convenience public init(frame: CGRect, timeInter: NSTimeInterval, countClosur: LoopPageCountClosure, pageClosure: LoopPageCurrentViewClosure, actionClosure: LoopPageTapActionClosure) {
        self.init(frame: frame)
        timeInterval = timeInter
        pageCountClosure = countClosur
        pageCurrentClosure = pageClosure
        pageTapActionClosure = actionClosure
    }
    
    //MARK: - LifeCircle
    override public func didMoveToSuperview() {
        super.didMoveToSuperview()
        setupBasic()
    }
    
    // MARK: - Private
    private func setupBasic() {
        //  设定layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: frame.width, height: frame.height)
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        //  设定collectionView
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView!.backgroundColor = UIColor.whiteColor()
        collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "loopCell")
        collectionView!.dataSource = self
        collectionView!.delegate = self
        collectionView!.showsVerticalScrollIndicator = false
        collectionView!.showsHorizontalScrollIndicator = false
        collectionView!.pagingEnabled = true
        collectionView!.bounces = false
        addSubview(collectionView!)
        //  设定pageCtl
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
        
        //  处理时间
        removeTimer()
        
        if pageCount > 1 { addTimer() }
    }
    
    //MARK: - Timer
    private func addTimer() -> Void {
        timer = NSTimer.scheduledTimerWithTimeInterval(privateTimeInterval, target: self, selector: Selector("timerStart"), userInfo: nil, repeats: true)
        NSRunLoop.currentRunLoop().addTimer(timer!, forMode: NSRunLoopCommonModes)
    }
    private func removeTimer() -> Void {
        timer?.invalidate()
        timer = nil
    }
    
    //MARK: - Target
    private var realIndex = 0
    private var index : Int {
        get {
            return realIndex++
        }
    }
    
    @objc private func timerStart() {
        let num = index
        collectionView?.scrollToItemAtIndexPath(NSIndexPath(forItem: num, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.Left, animated: true)
    }
    
    //KARK: - Lazy
    private lazy var pageCtl : UIPageControl = {
        let pageCtl = UIPageControl()
        return pageCtl
    }()
}

extension LoopPage : UICollectionViewDataSource, UICollectionViewDelegate {
    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return realPageCount
    }
    
    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let page = collectionView.dequeueReusableCellWithReuseIdentifier("loopCell", forIndexPath: indexPath)
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
        if let currentPageNum = currentPageIndex?.item {
            realIndex = currentPageIndex!.item
            pageCtl.currentPage = currentPageNum % pageCount
        }
    }

    
    public func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if pageTapActionClosure != nil {
            pageTapActionClosure!(pageIndex: indexPath.item % pageCount)
        }
    }
    
    public func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        if pageCount == 1 {
            collectionView?.contentSize = CGSizeZero
        }
        else {
            if let visIndexPath = collectionView?.indexPathsForVisibleItems().first {
                if visIndexPath.item == 0 {
                    collectionView?.scrollToItemAtIndexPath(NSIndexPath(forItem: realPageCount / 2, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.Left, animated: false)
                }
            }
            removeTimer()
        }
    }
    
    public func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        addTimer()
    }
}