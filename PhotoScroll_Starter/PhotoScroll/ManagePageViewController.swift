//
//  ManagePageViewController.swift
//  PhotoScroll
//
//  Created by Deep Thought on 2017/7/18.
//  Copyright © 2017年 raywenderlich. All rights reserved.
//

import UIKit

class ManagePageViewController: UIPageViewController {
    var photos = ["photo1","photo2","photo3","photo4","photo5"]
    var currentIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let viewController = viewPhotoCommentController(currentIndex ?? 0){
            let viewControllers = [viewController]
            
            setViewControllers(viewControllers, direction: .forward, animated: false, completion: nil)
        }
        
        dataSource = self
        
    }
    
    func viewPhotoCommentController(_ index: Int) -> PhotoCommentViewController? {
        guard let storyboard = storyboard, let page = storyboard.instantiateViewController(withIdentifier:"photoCommentViewController") as? PhotoCommentViewController else {
            return nil
        }
        page.photoName = photos[index]
        page.photoIndex = index
        return page
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension ManagePageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let viewController = viewController as? PhotoCommentViewController, let index = viewController.photoIndex,
            index > 0{
            return viewPhotoCommentController(index - 1)
        }
        return nil
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let viewController = viewController as? PhotoCommentViewController, let index = viewController.photoIndex,(index + 1) < photos.count {
        return viewPhotoCommentController(index + 1)
        }
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return photos.count
    }
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentIndex ?? 0
    }
}
