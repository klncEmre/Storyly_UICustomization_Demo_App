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
    @IBOutlet weak var fontPicker: UIPickerView!
    @IBOutlet weak var lineNumberPicker: UIPickerView!
    
    let groupTextFontDict: [String:UIFont] = ["System Font": UIFont.systemFont(ofSize: 12),"Bold System Font" : UIFont.boldSystemFont(ofSize: 12)]
    
    var lineNumber = 2
    var fontSize = 12
    var font = UIFont.systemFont(ofSize: CGFloat(12))
    
//    STORY GROUP COLORS
    @IBOutlet weak var stylesAndColors: UIPickerView!
    let properties = ["Background","Pin Icon","Ivod Icon","Text Color"]
    var rgbValues = [[0,0,0],[189,61,16],[0,0,0],[0,0,0]]
    var currentPropertyIndex = 0
    @IBOutlet weak var colorShowcase: UIView!
    
//seen - not seen system
    @IBOutlet weak var seenColorStack: UIStackView!
    @IBOutlet weak var notSeenColorStack: UIStackView!
    var colorsOfSeenState : [UIColor] = []
    var colorsOfNotSeenSate: [UIColor] = []
    var rgbValuesOfSeenState:[Int] = [0,0,0]
    var rgbValuesOfNotSeenState:[Int] = [0,0,0]
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
        customizedView.storyGroupSize = "large"
       
        //Story Group Text Styling
      
        fontPicker.delegate = self
        fontPicker.dataSource = self
        fontPicker.selectRow(11, inComponent: 1, animated: true)
        lineNumberPicker.delegate = self
        lineNumberPicker.dataSource = self
        lineNumberPicker.selectRow(1, inComponent: 0, animated: true)
        stylesAndColors.delegate = self
        stylesAndColors.dataSource = self
        colorShowcase.layer.cornerRadius = colorShowcase.frame.size.width/2
        colorShowcase.clipsToBounds = true
        colorShowcase.backgroundColor = UIColor.black
        
        
        
    }
    
    @IBAction func resetButtonAction(_ sender: Any) {
//        pickedC.text = backgroundField.text
        
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
        let currentColor = rgbValues[3]
        self.customizedView.storyGroupTextStyling = StoryGroupTextStyling(isVisible: self.storyGroupTextIsVisible, color: UIColor.init(red: CGFloat(currentColor[0])/255, green: CGFloat(currentColor[1])/255, blue: CGFloat(currentColor[2])/255, alpha: 1.0), font: font, lines: lineNumber)
        
    }
    
    @IBAction func notSeenAddButton(_ sender: Any) {
        let colorStack = UIStackView()
        colorStack.axis = .horizontal
        colorStack.alignment = .center
        
        let label: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0
            label.text = "(" + rgbValuesOfNotSeenState[0].description + rgbValuesOfNotSeenState[1].description + rgbValuesOfNotSeenState[2].description + ")"
            return label
        }()
        colorStack.addArrangedSubview(label)
        let button = UIButton()
        button.setImage(UIImage.init(systemName: "clear.fill"), for: .normal)
        button.setTitleColor(.systemBlue,
                             for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self,
                         action: #selector(buttonAction),
                         for: .touchUpInside)
        colorStack.addArrangedSubview(button)
        colorStack.backgroundColor = UIColor.systemGray.withAlphaComponent(0.8)
        colorStack.layer.cornerRadius = colorStack.frame.size.width / 2
        colorStack.distribution = .equalCentering
        notSeenColorStack.addArrangedSubview(colorStack)
        notSeenColorStack.spacing = 20
        
        
        
       
    }
    
    @IBAction func seenAddButton(_ sender: Any) {
    }
    
    @objc func buttonAction(_ sender: UIButton){
        
        sender.superview?.removeFromSuperview()
        
    }
    
    
    
}

extension ViewController: StorylyDelegate{
    
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        if(pickerView == fontPicker){
            return 2
        }
        else if (pickerView == stylesAndColors){
            return 4
        }
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        
       
        if(component == 0){
            switch pickerView{
            case fontPicker:
                return self.groupTextFontDict.count
            case lineNumberPicker:
                return 5
            case stylesAndColors:
                return properties.count
            default:
                return 1
            }
            
          
        }
        else if(component == 1 && pickerView == fontPicker) {
            return 12
        }
        else if(component != 0 && pickerView == stylesAndColors) {
            return 255
        }
        
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if(component == 0) { //MEANS I HAVE ONE ELEMENT IN A ROW.
            switch pickerView{
                case fontPicker:
                    let key = Array(groupTextFontDict.keys)
                    return key[row]
                case lineNumberPicker:
                    return  (row+1).description
                case stylesAndColors:
                    return properties[row]
                default:
                    return "x"
            }
           
        }
        else if(pickerView == fontPicker && component == 1){
            return (row+1).description
        }
        else if(pickerView == stylesAndColors){
            return row.description
        }
           
        
       
        return "x"
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let currentColor = rgbValues[3]
        if(component == 0){
            switch pickerView{
                case fontPicker:
                    let values = Array(groupTextFontDict.values)
                    font = values[row]
                    self.customizedView.storyGroupTextStyling =  StoryGroupTextStyling(isVisible:  self.storyGroupTextIsVisible, color: UIColor.init(red: CGFloat(currentColor[0])/255, green: CGFloat(currentColor[1])/255, blue: CGFloat(currentColor[2])/255, alpha: 1.0), font: self.font, lines: self.lineNumber)
                    break
                    
            case lineNumberPicker:
                lineNumber = row + 1
                self.customizedView.storyGroupTextStyling =  StoryGroupTextStyling(isVisible: self.storyGroupTextIsVisible, color:UIColor.init(red: CGFloat(currentColor[0])/255, green: CGFloat(currentColor[1])/255, blue: CGFloat(currentColor[2])/255, alpha: 1.0), font: self.font, lines: self.lineNumber)
                break
            case stylesAndColors:
                currentPropertyIndex = row
                for i in 1...3{
                    stylesAndColors.selectRow(rgbValues[row][i-1], inComponent: i, animated: true)
                }
                let currentValues = rgbValues[currentPropertyIndex]
                colorShowcase.backgroundColor = UIColor.init(red: CGFloat(currentValues[0])/255, green: CGFloat(currentValues[1])/255, blue: CGFloat(currentValues[2])/255, alpha: 1.0)
                break
            default:
                break
            }
           
        }
        else if(pickerView == fontPicker && component == 1){
            fontSize = row + 1
            font = font.withSize(CGFloat(fontSize))
            self.customizedView.storyGroupTextStyling =  StoryGroupTextStyling(isVisible: self.storyGroupTextIsVisible, color:UIColor.init(red: CGFloat(currentColor[0])/255, green: CGFloat(currentColor[1])/255, blue: CGFloat(currentColor[2])/255, alpha: 1.0), font: self.font, lines: self.lineNumber)
        }
        else if(pickerView == stylesAndColors && component != 0){
            
            rgbValues[currentPropertyIndex][component-1] = row
            var currentValues = rgbValues[0]
            switch currentPropertyIndex{
            case 0:
                currentValues = rgbValues[0]
                self.customizedView.storyGroupIconBackgroundColor = UIColor.init(red: CGFloat(currentValues[0])/255, green: CGFloat(currentValues[1])/255, blue: CGFloat(currentValues[2])/255, alpha: 1.0)
                break
            case 1:
                currentValues = rgbValues[1]
                self.customizedView.storyGroupPinIconColor = UIColor.init(red: CGFloat(currentValues[0])/255, green: CGFloat(currentValues[1])/255, blue: CGFloat(currentValues[2])/255, alpha: 1.0)
                
                break
            case 2:
                currentValues = rgbValues[2]
                self.customizedView.storyGroupIVodIconColor = UIColor.init(red: CGFloat(currentValues[0])/255, green: CGFloat(currentValues[1])/255, blue: CGFloat(currentValues[2])/255, alpha: 1.0)
                break
            case 3:
                currentValues = rgbValues[3]
                self.customizedView.storyGroupTextStyling =  StoryGroupTextStyling(isVisible: self.storyGroupTextIsVisible, color:UIColor.init(red: CGFloat(currentValues[0])/255, green: CGFloat(currentValues[1])/255, blue: CGFloat(currentValues[2])/255, alpha: 1.0), font: self.font, lines: self.lineNumber)
                break
            default:
                break
            
            }
            colorShowcase.backgroundColor = UIColor.init(red: CGFloat(currentValues[0])/255, green: CGFloat(currentValues[1])/255, blue: CGFloat(currentValues[2])/255, alpha: 1.0)
            colorShowcase.tintColor = UIColor.init(red: CGFloat(currentValues[0])/255, green: CGFloat(currentValues[1])/255, blue: CGFloat(currentValues[2])/255, alpha: 1.0)
        }
       
                
    }
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        let w = pickerView.frame.size.width
        if(pickerView == stylesAndColors ){
            if(component == 0){
                return w * 0.4
            }
            else {
                return w * 0.2
            }
        }
        switch pickerView{
            case fontPicker:
                return w
            case lineNumberPicker:
                return w
            
        default:
            return w
        }
        
    
    }
}
