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
    @IBOutlet weak var textColorPicker: UIPickerView!
    @IBOutlet weak var fontPicker: UIPickerView!
    let groupTextColorDict:[String:UIColor] = ["Black":UIColor.black,"Red":UIColor.red,"Orange":UIColor.orange,"Yellow":UIColor.yellow]
    var groupTextFontDict: [String:UIFont] = ["System Font": UIFont.systemFont(ofSize: 12),"Bold System Font" : UIFont.boldSystemFont(ofSize: 12)]
    var pickedColor = UIColor.black
    var lineNumber = 2
    var fontSize = 12
    var font = UIFont.systemFont(ofSize: CGFloat(12))
    
    
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
       
        //Story Group Text Styling
        textColorPicker.delegate = self
        textColorPicker.dataSource = self
        fontPicker.delegate = self
        fontPicker.dataSource = self
        fontPicker.selectRow(11, inComponent: 1, animated: true)
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
        
        self.customizedView.storyGroupTextStyling = StoryGroupTextStyling(isVisible: self.storyGroupTextIsVisible, color: pickedColor, font: font, lines: lineNumber)
        
       
        
    }
    
    
}

extension ViewController: StorylyDelegate{
    
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if(pickerView == fontPicker){
            return 2
        }
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(component == 0){
        if(pickerView == fontPicker){
            return self.groupTextFontDict.count
        }
        else {
            return self.groupTextColorDict.count
        }
        }
        else{
            return 50
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(component == 0) { //MEANS I HAVE ONE ELEMENT IN A ROW.
            if(pickerView == fontPicker){
                let key = Array(groupTextFontDict.keys)
                return key[row]
            }
            else {
                let key = Array(groupTextColorDict.keys)
                return  key[row]
            }
        }
        else{
            return (row+1).description
        }
        
       
        
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(component == 0){
            if(pickerView == fontPicker){
                let values = Array(groupTextFontDict.values)
                font = values[row]
                self.customizedView.storyGroupTextStyling =  StoryGroupTextStyling(isVisible: self.storyGroupTextIsVisible, color: self.pickedColor, font: self.font, lines: self.lineNumber)
                
                
            }
            else{
                let values = Array(groupTextColorDict.values)
                pickedColor = values[row]
                self.customizedView.storyGroupTextStyling =  StoryGroupTextStyling(isVisible: self.storyGroupTextIsVisible, color: values[row], font: self.font, lines: self.lineNumber)
            }
        }
        else{
            fontSize = row + 1
            font = font.withSize(CGFloat(fontSize))
            self.customizedView.storyGroupTextStyling =  StoryGroupTextStyling(isVisible: self.storyGroupTextIsVisible, color:pickedColor, font: self.font, lines: self.lineNumber)
        }
                
    }
    
}
