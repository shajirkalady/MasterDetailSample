//
//  FlickerView.swift
//  SpaceXLaunches
//
//  Created by Shajir Kalady on 9/24/22.
//

import Foundation
import UIKit

/*
 * Flicker image view
 */
class FlickerView: UIView {
    let kCONTENT_XIB_NAME = "FlickerView"
    var imageUrls: [String] = []
    
    @IBOutlet var contentView: UIView!
    @IBOutlet var scrolContentView: UIView!
    @IBOutlet weak var scrollContentViewWidth: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
        contentView.fixInView(self)
    }
    
    // function for update the UI
    func updateView(images: [String]){
        let imageWidth = self.frame.width
        pageControl.numberOfPages = images.count
        pageControl.currentPage = 0
        for i in 0..<images.count {
            let offset = i == 0 ? 0 : (CGFloat(i) * (imageWidth + 10))
            let imgView = UIImageView(frame: CGRect(x: offset, y: 0, width: imageWidth, height: imageWidth))
            imgView.clipsToBounds = true
            imgView.contentMode = .scaleAspectFit
            imgView.cacheAndLoadImage(url: images[i], completion: nil)
            scrolContentView.addSubview(imgView)
        }        
        scrollContentViewWidth.constant = CGFloat(images.count) * (imageWidth + 10)
    }
}

// MARK: - Scroll view delegate
extension FlickerView: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
}
