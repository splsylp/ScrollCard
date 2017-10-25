//
//  CardView.swift
//  ScrollCard
//
//  Created by Tony on 2017/9/26.
//  Copyright © 2017年 Tony. All rights reserved.
//

import UIKit

class CourseCardView: UIView {
    
    var selectedIndex = 0
    var models: [String] = [String]() {
        didSet {
            if models.count < 2 {
                collectionView.isScrollEnabled = false
            }
        }
    }
    var selectedCourseClosure: ((String) -> Void)?
    
    lazy fileprivate var collectionView: UICollectionView = {
        let layout = CourseCardFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsetsMake(0, FIT_SCREEN_WIDTH(107) * 2, 0, FIT_SCREEN_WIDTH(107) * 2)
        layout.minimumLineSpacing = -FIT_SCREEN_WIDTH(40)
        layout.itemSize = CGSize(width: FIT_SCREEN_WIDTH(107), height: FIT_SCREEN_HEIGHT(130))
        
        let xPadding = FIT_SCREEN_WIDTH(35)
        let collectionView = UICollectionView(frame: CGRect(x: xPadding, y: FIT_SCREEN_HEIGHT(275), width: SCREEN_WIDTH - xPadding * 2, height: FIT_SCREEN_HEIGHT(157)), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.collectionViewLayout = layout
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "CourseCardCell", bundle: nil), forCellWithReuseIdentifier: "CourseCardCell")
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        self.y = self.height
        self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        // 灯光
        let lightView = UIImageView(frame: CGRect(x: 0, y: FIT_SCREEN_HEIGHT(200), width: FIT_SCREEN_WIDTH(245), height: FIT_SCREEN_HEIGHT(125)))
        lightView.centerX = self.centerX
        lightView.image = #imageLiteral(resourceName: "img_dengguang")
        self.addSubview(lightView)
        
        // 卡片
        self.addSubview(collectionView)
        
        // 操作提示
        let noteLable = UILabel(frame: CGRect(x: 0, y: collectionView.bottom + FIT_SCREEN_HEIGHT(8), width: self.width, height: FIT_SCREEN_HEIGHT(30)))
        noteLable.text = "左右滑动\n选择喜欢的课程吧"
        noteLable.font = UIFont.systemFont(ofSize: 12)
        noteLable.textColor = UIColor.white
        noteLable.textAlignment = .center
        noteLable.numberOfLines = 0
        self.addSubview(noteLable)
        
        // 关闭按钮
        let closeBtn = UIButton(frame: CGRect(x: 0, y: noteLable.bottom + FIT_SCREEN_HEIGHT(35), width: FIT_SCREEN_WIDTH(24), height: FIT_SCREEN_WIDTH(24)))
        closeBtn.centerX = self.centerX
        closeBtn.setImage(#imageLiteral(resourceName: "icon_closeBook"), for: .normal)
        closeBtn.addTarget(self, action: #selector(closeBtnClicked), for: .touchUpInside)
        self.addSubview(closeBtn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func closeBtnClicked() {
        remove()
    }
    
    // 展示
    public func show() {
        
        UIApplication.shared.keyWindow?.addSubview(self)
        self.scrollToItem(withAnimation: true, index: self.selectedIndex)
        UIView.animate(withDuration: 1, animations: {
            self.y = 0
        }) { (finished) in
        }
    }
    
    // 移除
    private func remove() {
        
        UIView.animate(withDuration: 0.5, animations: {
            self.y = self.height
        }) { (finished) in
            self.removeFromSuperview()
        }
    }
}


extension CourseCardView: UICollectionViewDataSource, UICollectionViewDelegate, CAAnimationDelegate {
    
    // MARK:- CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CourseCardCell", for: indexPath) as! CourseCardCell
        let index = indexPath.row
        cell.imgView.image = UIImage(named: "img_book\(index % 3)")
        cell.nameLabel.text = models[index]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let index = indexPath.row
        let pointInView = self.convert(collectionView.center, to: collectionView)
        let centerIndex = collectionView.indexPathForItem(at: pointInView)?.row ?? 0
        print("cnterIndex: ", centerIndex)
        
        if index == centerIndex { // 若点击的是中间位置的书，则选择完成
            let cell = collectionView.cellForItem(at: indexPath) as! CourseCardCell
            cell.imgView.image = #imageLiteral(resourceName: "img_book_inner")
            cell.nameLabel.text = ""
            
            let ca = CATransition()
            ca.delegate = self
            ca.type = "pageCurl"
            ca.subtype = kCATransitionFromRight
            ca.duration = 1
            ca.isRemovedOnCompletion = false
            ca.fillMode = kCAFillModeRemoved
            cell.containerView.layer.add(ca, forKey: nil)
            
            selectedIndex = index
            selectedCourseClosure?(models[index])
            
        } else { // 若点击旁边的书，则让其滚动至中间位置
            scrollToItem(withAnimation: true, index: index)
            print("点击下标：\(index)")
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let pointInView = self.convert(collectionView.center, to: collectionView)
        let index = collectionView.indexPathForItem(at: pointInView)?.row ?? 0
        print("滚动至下标：\(index)")
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let pointInView = self.convert(collectionView.center, to: collectionView)
        let index = collectionView.indexPathForItem(at: pointInView)?.row ?? 0
        
        if let cell = collectionView.cellForItem(at: IndexPath.init(row: index - 2, section: 0)) {
            collectionView.bringSubview(toFront: cell)
        }
        if let cell = collectionView.cellForItem(at: IndexPath.init(row: index + 2, section: 0)) {
            collectionView.bringSubview(toFront: cell)
        }
        if let cell = collectionView.cellForItem(at: IndexPath.init(row: index - 1, section: 0)) {
            collectionView.bringSubview(toFront: cell)
        }
        if let cell = collectionView.cellForItem(at: IndexPath.init(row: index + 1, section: 0)) {
            collectionView.bringSubview(toFront: cell)
        }
        if let cell = collectionView.cellForItem(at: IndexPath.init(row: index, section: 0)) {
            collectionView.bringSubview(toFront: cell)
        }
    }
    
    fileprivate func scrollToItem(withAnimation animation: Bool, index: Int) {
        
        let index = index < models.count ? index : 0
        self.collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: animation)
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        print("stop")
        remove()
    }
}
