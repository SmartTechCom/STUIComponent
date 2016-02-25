//
//  LoopPage.swift
//  STUIComponent
//
//  Created by XuAzen on 16/2/25.
//  Copyright © 2016年 st company. All rights reserved.
//

public class LoopPage: UIView {
    let collectionLayoyt : UICollectionViewFlowLayout?
    let collectionView : UICollectionView?
    
    override public init(frame: CGRect) {
        
        collectionLayoyt = UICollectionViewFlowLayout()
        collectionLayoyt!.itemSize = CGSize(width: frame.width, height: frame.height)
        
        collectionView = UICollectionView(frame: frame, collectionViewLayout: collectionLayoyt!)
        collectionView!.backgroundColor = UIColor.purpleColor()
        collectionView?.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "loopCell")
        
        super.init(frame: frame)
        
        collectionView!.dataSource = self
        addSubview(collectionView!)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func didMoveToSuperview() {
        super.didMoveToSuperview()
        collectionLayoyt?.itemSize = bounds.size
        collectionView?.frame = bounds
    }
}

extension LoopPage : UICollectionViewDataSource {
    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let page = collectionView.dequeueReusableCellWithReuseIdentifier("loopCell", forIndexPath: indexPath)
        page.backgroundColor = UIColor.blackColor()
        return page
    }
}