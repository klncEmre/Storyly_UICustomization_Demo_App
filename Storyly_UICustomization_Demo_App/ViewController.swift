//
//  ViewController.swift
//  Storyly_UICustomization_Demo_App
//
//  Created by Emre Kılınç on 21.06.2022.
//

import UIKit
import Storyly
class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var defaultView: StorylyView!
    @IBOutlet weak var customizedView: StorylyView!
    let STORYLY_INSTANCE_TOKEN = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhY2NfaWQiOjc2MCwiYXBwX2lkIjo0MDUsImluc19pZCI6NDA0fQ.1AkqOy_lsiownTBNhVOUKc91uc9fDcAxfQZtpm3nj40"
    let scrollView = UIScrollView()
    let contentView = UIView()
    
//    Story Group Text Styling
   
    var storyGroupTextIsVisible = true
    @IBOutlet weak var textVisibleButton: UIButton!
    
//    var storyGroupTextColor
//    var storyGroupTextFont
//    var storyGroupTextLines
    
    
    
    @IBOutlet weak var viewsContainer: UIView!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        //default
        defaultView.storylyInit = StorylyInit(storylyId: STORYLY_INSTANCE_TOKEN)
        defaultView.rootViewController = self
        defaultView.delegate = self
        
        //customized
        customizedView.storylyInit = StorylyInit(storylyId: STORYLY_INSTANCE_TOKEN)
        customizedView.rootViewController = self
        customizedView.delegate = self
//        setupScrollView()
//        setUpTextStyling()
        
        }
    
    @IBAction func resetButtonAction(_ sender: Any) {
        
    }
    @IBAction func textVisibilityChange(_ sender: Any) {
        if(storyGroupTextIsVisible){
            storyGroupTextIsVisible = false
            textVisibleButton.setImage(UIImage(systemName: "circle",withConfiguration: UIImage.SymbolConfiguration(scale: .large))?.withTintColor(UIColor.black), for: UIControl.State.normal)
        }
        else{
            storyGroupTextIsVisible = true
            textVisibleButton.setImage(UIImage(systemName: "circle.inset.filled",withConfiguration: UIImage.SymbolConfiguration(scale: .large))?.withTintColor(UIColor.black), for: UIControl.State.normal)
        }
    }
    
    
}

extension ViewController: StorylyDelegate{
    
}
