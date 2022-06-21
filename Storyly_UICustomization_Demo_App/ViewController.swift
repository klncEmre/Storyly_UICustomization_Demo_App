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
    
    func setupScrollView(){
           scrollView.translatesAutoresizingMaskIntoConstraints = false
           contentView.translatesAutoresizingMaskIntoConstraints = false
            
           view.addSubview(scrollView)
           scrollView.addSubview(contentView)
           scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
           scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
           scrollView.topAnchor.constraint(equalTo: viewsContainer.bottomAnchor ).isActive = true
           scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
           
           contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
           contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
           contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
           contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        
        
    }
    func setupCustoms(){
            let titleLabel: UILabel = {
                let label = UILabel()
                label.text = "."
                label.numberOfLines = 0
                label.sizeToFit()
                label.textColor = UIColor.black
                label.translatesAutoresizingMaskIntoConstraints = false
                return label
            }()
            
            let subtitleLabel: UILabel = {
                let label = UILabel()
                label.text = "?"
                label.numberOfLines = 0
                label.sizeToFit()
                label.textColor = UIColor.black
                label.translatesAutoresizingMaskIntoConstraints = false
                return label
            }()
           contentView.addSubview(titleLabel)
           titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
           titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
           titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4).isActive = true
           
           contentView.addSubview(subtitleLabel)
           subtitleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
           subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25).isActive = true
           subtitleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4).isActive = true
           subtitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
       }
    func setUpTextStyling() {
        
        lazy var titleLabel: UILabel = {
            let label = UILabel()
            label.text = "storyGroupTextIsVisible"
            label.numberOfLines = 0
            label.sizeToFit()
            label.textColor = UIColor.black
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        lazy var button: UIButton! = {
            
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.backgroundColor = UIColor.systemBlue
            button.setTitleColor(.red, for: .normal)
            button.addTarget(self, action: #selector(didTaped(_:)), for: .touchUpInside)
            button.tag = 1
            button.layer.cornerRadius = 20
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.black.cgColor
            
            return button
          }()
        
    
        
    }
    
    @objc func didTaped(_ sender: UIButton){
        if(storyGroupTextIsVisible) {
            storyGroupTextIsVisible = false
        }
        print("Pressed")
    }
   
    
    
    @objc func pressed(_ sender: UIButton) {
                   
                    
     }

}

extension ViewController: StorylyDelegate{
    
}
