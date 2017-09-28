//
//  ViewController.swift
//  ScrollCard
//
//  Created by Tony on 2017/9/26.
//  Copyright © 2017年 Tony. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var titleBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    @IBAction func titleBtnClicked(_ sender: UIButton) {
        
        let courseCardView = CourseCardView()
        courseCardView.models = ["C语言程序与设计", "Swift入门与实践", "教你怎么不生气", "沉默的愤怒", "颈椎病康复指南", "腰椎间盘突出日常护理", "心脏病的预防与防治", "高血压降压宝典", "精神病症状学", "活着"]
        courseCardView.selectedIndex = 3
        courseCardView.show()
        courseCardView.selectedCourseClosure = { course in
            self.titleBtn.setTitle(course, for: .normal)
        }
    }
}

