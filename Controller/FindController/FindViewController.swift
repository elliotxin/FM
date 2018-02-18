//
//  FindViewController.swift
//  FM
//
//  Created by elliot xin on 2/18/18.
//  Copyright © 2018 elliot xin. All rights reserved.
//

import UIKit

class FindViewController: UIViewController {

    @IBOutlet weak var SubtitileView: UIView!
    @IBOutlet weak var SliderView: UIView!
    
    var pageViewController: UIPageViewController!

    var recommednController: RecommendViewController!
    var classifyController: ClassifyViewController!
    var radioController: RadioViewController!
    var listController: ListViewController!
    var anchorController: AnchorViewController!
    var controllers = [UIViewController]()
    var sliderImageView: UIImageView!
    
    var lastPage = 0
    var currentPage:Int = 0 {
        didSet{
            let offset = self.view.frame.width / 5 * CGFloat(currentPage) + ((self.view.frame.width / 5 - 37) / 2)
            UIView.animate(withDuration: 0.3) {
                self.sliderImageView.frame.origin = CGPoint(x: offset, y: 0)
            }
            
            if currentPage > lastPage {
                self.pageViewController.setViewControllers([controllers[currentPage]], direction: .forward, animated: true, completion: nil)
            } else  {
                self.pageViewController.setViewControllers([controllers[currentPage]], direction: .reverse, animated: true, completion: nil)
            }
            
            lastPage = currentPage
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pageViewController = self.childViewControllers.first as! UIPageViewController
        
        
        recommednController = storyboard?.instantiateViewController(withIdentifier: "RecommendID") as! RecommendViewController
        classifyController = storyboard?.instantiateViewController(withIdentifier: "ClassifyID") as! ClassifyViewController
        radioController = storyboard?.instantiateViewController(withIdentifier: "RadioID") as! RadioViewController
        listController = storyboard?.instantiateViewController(withIdentifier: "ListID") as! ListViewController
        anchorController = storyboard?.instantiateViewController(withIdentifier: "AnchorID") as! AnchorViewController
    
        pageViewController.dataSource = self
        pageViewController.setViewControllers([recommednController], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)

        controllers.append(recommednController)
        controllers.append(classifyController)
        controllers.append(radioController)
        controllers.append(listController)
        controllers.append(anchorController)
        
        sliderImageView = UIImageView()
        sliderImageView.image = UIImage(named: "slider")
        SliderView.addSubview(sliderImageView)
        sliderImageView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 37, height: 2))
            make.left.equalTo(SliderView.snp.left).offset((self.view.frame.width / 5 - 37) / 2)
            make.top.equalTo(SliderView.snp.top)
            make.bottom.equalTo(SliderView.snp.bottom)
        }
        
        let btnArray = ["推荐","分类","广播","列表","主播"]
        AddSubtitleBtn(btnArray: btnArray)
        
        NotificationCenter.default.addObserver(self, selector: #selector(currentPageChanged(notification:)), name: NSNotification.Name(rawValue: "currentPageChanged") ,object: nil)
    }

    func AddSubtitleBtn(btnArray : Array<Any>) {
        
        let btnW = self.view.frame.width / 5
        let btnH = SubtitileView.frame.height
        var bt = UIButton(type: .custom)
        for num : Int in  0..<(btnArray.count) {
            bt = UIButton(frame:CGRect(x: CGFloat(num) * btnW , y: 0, width: btnW , height: btnH))
            bt.setTitle( btnArray[num] as? String , for: .normal)
            bt.setTitleColor(UIColor.gray, for: .normal)
            bt.setTitleColor(UIColor.red, for: .selected)
            bt.tag = 100 + num
            bt.addTarget(self, action: #selector(changeCurrentPage(_:)), for: .touchUpInside)
            SubtitileView.addSubview(bt)
        }
        
        changeCurrentPage(SubtitileView.viewWithTag(100) as! UIButton)
        
    }
    
    @objc func currentPageChanged(notification: NSNotification) {
        
        currentPage = notification.object as! Int
    }
    
    @objc func changeCurrentPage(_ sender: UIButton){
        sender.isSelected = true
        sender.isUserInteractionEnabled = false
        
        for sbtn in SubtitileView.subviews {
            guard let xbtn = sbtn as? UIButton else { continue }
            if xbtn.tag == sender.tag{
                continue
            }
            xbtn.isSelected = false
            xbtn.isUserInteractionEnabled = true
        }
        
        currentPage = sender.tag - 100
    }
}

extension FindViewController : UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if viewController is RecommendViewController{
            return classifyController
        } else if viewController is ClassifyViewController {
            return radioController
        } else if viewController is RadioViewController {
            return listController
        } else if viewController is ListViewController {
            return anchorController
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if viewController is AnchorViewController {
            return listController
        } else if viewController is ListViewController {
            return radioController
        } else if viewController is RadioViewController {
            return classifyController
        } else if viewController is ClassifyViewController {
            return recommednController
        }
        return nil
    }
}
