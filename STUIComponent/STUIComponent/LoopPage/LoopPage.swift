//
//  LoopPage.swift
//  STUIComponent
//
//  Created by XuAzen on 16/2/25.
//  Copyright © 2016年 st company. All rights reserved.
//

public class LoopPage: UIView {

    var collectionView : UICollectionView?
    
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
    
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func didMoveToSuperview() {
        super.didMoveToSuperview()
        setupBasic()
    }
    
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
        collectionView?.delegate = self
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.pagingEnabled = true
        addSubview(collectionView!)
        
        pageCtl.frame = CGRect(x: 0, y: 0, width: 100, height: 20)
        pageCtl.frame.origin.x = (frame.width - pageCtl.frame.width) * 0.5
        pageCtl.frame.origin.y = frame.height - pageCtl.frame.height
        addSubview(pageCtl)
        
    }
    
    
    //KARK: - Lazy
    let pageCtl : UIPageControl = {
        let pageCtl = UIPageControl()
        pageCtl.numberOfPages = 5
        pageCtl.backgroundColor = UIColor.redColor()
        return pageCtl
    }()
}

extension LoopPage : UICollectionViewDataSource, UICollectionViewDelegate {
    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let page = collectionView.dequeueReusableCellWithReuseIdentifier("loopCell", forIndexPath: indexPath)
        
        page.backgroundColor = UIColor(red: CGFloat(Double(arc4random_uniform(100)) * 0.01), green: CGFloat(Double(arc4random_uniform(100)) * 0.01), blue: CGFloat(Double(arc4random_uniform(100)) * 0.01), alpha: 0.5)
        return page
    }
    
    public func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        
        let currentPageIndex = collectionView.indexPathsForVisibleItems().first
        print(currentPageIndex)
        pageCtl.currentPage = (currentPageIndex?.item)!
    }
    
}