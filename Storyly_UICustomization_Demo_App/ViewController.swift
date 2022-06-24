//
//  ViewController.swift
//  Storyly_UICustomization_Demo_App
//
//  Created by Emre Kılınç on 21.06.2022.
//

import UIKit
import Storyly
class ViewController: UIViewController {
    
    
//    DEFAULT PICKER VIEW VALUES NEED TO BE UPDATED TO DEFAULT OF STORYLY.
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
    @IBOutlet weak var notSeenColorView: UIView!
    var colorsOfSeenState : [UIColor] = []
    var colorsOfNotSeenSate: [UIColor] = []
    var rgbValuesOfSeenState:[Int] = [0,0,0]
    var rgbValuesOfNotSeenState:[Int] = [0,0,0]
    @IBOutlet weak var viewsContainer: UIView!
    @IBOutlet weak var notSeenColorsLabel: UILabel!
    @IBOutlet weak var stateColorPicker: UIPickerView!
    var coordinateKeeperNotSeen = 20.0
    let sizeOfStack = 80
    var availableIndexes = [0,1,2,3]
    let colorsAndRGB = ["Red": [186,0,0],"Black":[1,0,0], "Yellow":[2,3,0]]
    var frontItem = "x"
    
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
        stateColorPicker.delegate = self
        stateColorPicker.dataSource = self
        
        
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
       
        let myStak = UIView()
        myStak.translatesAutoresizingMaskIntoConstraints = false

        notSeenColorView.addSubview(myStak)
        myStak.widthAnchor.constraint(equalToConstant: CGFloat(sizeOfStack)).isActive = true
        myStak.heightAnchor.constraint(equalToConstant: CGFloat(30)).isActive = true
        myStak.leftAnchor.constraint(equalTo: notSeenColorsLabel.rightAnchor , constant: CGFloat(Double(sizeOfStack * availableIndexes[0]) * 1.1)).isActive = true
        myStak.centerYAnchor.constraint(equalTo: notSeenColorsLabel.centerYAnchor).isActive = true
    
        let button = UIButton()
        button.tag = availableIndexes[0]
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setImage(UIImage.init(systemName: "clear.fill"), for: .normal)

        lazy var myLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "(" + rgbValuesOfNotSeenState[0].description + ", " +  rgbValuesOfNotSeenState[1].description + ", " + rgbValuesOfNotSeenState[2].description + ")"
            label.font = UIFont.systemFont(ofSize: 12)
            return label
        }()
        myStak.layer.cornerRadius = 8
        myStak.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4)
        myStak.addSubview(button)
        myStak.addSubview(myLabel)
        button.widthAnchor.constraint(equalToConstant: CGFloat(Double(sizeOfStack) * 0.4)).isActive = true
        button.heightAnchor.constraint(equalToConstant: CGFloat(20)).isActive = true
        button.centerYAnchor.constraint(equalTo: myStak.centerYAnchor).isActive = true
        button.rightAnchor.constraint(equalTo: myStak.rightAnchor,constant: CGFloat(-3)).isActive = true
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        myLabel.leftAnchor.constraint(equalTo: myStak.leftAnchor,constant: CGFloat(2)).isActive = true
        myLabel.centerYAnchor.constraint(equalTo: myStak.centerYAnchor).isActive = true
        
        availableIndexes.remove(at: 0)
        customizedView.storyGroupIconBorderColorNotSeen = colorsOfNotSeenSate
        
       
    }
    
    @IBAction func seenAddButton(_ sender: Any) {
    }
    
    @objc func buttonAction(_ sender: UIButton){
        
        sender.superview?.removeFromSuperview()
        availableIndexes.insert(sender.tag, at: 0)
        availableIndexes.sort()
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
        else if(pickerView == stateColorPicker){
            return 4
        }
        else if(pickerView == lineNumberPicker){
            return 1
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
            case stateColorPicker:
                return colorsAndRGB.count
            default:
                return 1
            }
            
          
        }
        else if(component != 0 && pickerView ==  stateColorPicker){
            return 255
        }
        else if(component == 1 && pickerView == fontPicker) {
            return 12
        }
        else if(component != 0 && (pickerView == stylesAndColors)) {
            return 255
        }
       
    
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if(component == 0) {
            switch pickerView{
                case fontPicker:
                    let key = Array(groupTextFontDict.keys)
                    return key[row]
                case lineNumberPicker:
                    return  (row+1).description
                case stylesAndColors:
                    return properties[row]
                case stateColorPicker:
                    let k = Array(colorsAndRGB.keys)
                    frontItem = k[row]
                    return k[row]
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
        else if(pickerView == stateColorPicker ) {
            if(component == 3){
                let v = Array(colorsAndRGB.values)
                rgbValuesOfNotSeenState = v[1]
                stateColorPicker.selectRow(1, inComponent: 0, animated: true)
                for i in 1...3{
                    stateColorPicker.selectRow(v[1][i-1], inComponent: i, animated: true)
                }
                

            }
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
            case stateColorPicker:
                let v = Array(colorsAndRGB.values)
                rgbValuesOfNotSeenState = v[row]
                for i in 1...3{
                    stateColorPicker.selectRow(v[row][i-1], inComponent: i, animated: true)
                }
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
        if(pickerView == stylesAndColors  || pickerView == stateColorPicker ){
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
