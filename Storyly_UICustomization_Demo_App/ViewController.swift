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
    @IBOutlet weak var containerToCustom: UIView!
    
    var customizedView = StorylyView()
    let STORYLY_INSTANCE_TOKEN = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhY2NfaWQiOjc2MCwiYXBwX2lkIjo0MDUsImluc19pZCI6NDA0fQ.1AkqOy_lsiownTBNhVOUKc91uc9fDcAxfQZtpm3nj40"

    
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
    var rgbValuesOfProperties = [[0,0,0],[189,61,16],[0,0,0],[0,0,0]] //needs to be updated with default values
    var currentPropertyIndex = 0
    @IBOutlet weak var colorShowcase: UIView!

//Seen - Not seen system
    @IBOutlet weak var seenColorView: UIView!
    @IBOutlet weak var notSeenColorView: UIView!
    var colorsOfSeenState : [Int:UIColor] = [:]
    var colorsOfNotSeenSate: [Int:UIColor] = [:]
    var rgbValuesOfSeenState:[Int] = [0,0,0]
    var rgbValuesOfNotSeenState:[Int] = [0,0,0]
    @IBOutlet weak var viewsContainer: UIView!
    @IBOutlet weak var notSeenColorsLabel: UILabel!
    @IBOutlet weak var seenColorsLabel: UILabel!
    @IBOutlet weak var stateColorPicker: UIPickerView!
    var coordinateKeeperNotSeen = 20.0
    let widthOfStack = 80
    var availableIndexesNotSeen = [0,2,4,6]
    var availableIndexesSeen = [1,3,5,7]
    let colorsAndRGB = ["Red": [186,0,0],"Black":[0,0,0], "Yellow":[2,3,0]]
    var frontItem = "x"
    var pickedSize = "large"
    
    
//    Story Group Size element
    @IBOutlet weak var smallButton: UIButton!
    @IBOutlet weak var largeButton: UIButton!
    @IBOutlet weak var customButton: UIButton!

    @IBOutlet weak var heightTextF: UITextField!
    @IBOutlet weak var widthTextF: UITextField!
    @IBOutlet weak var cornerRadiusTextF: UITextField!
//    NEEDS TO BE UPDATED WITH DEFAULT SIZES
    var height = 12
    var width = 12
    var cRadius = 10
    
//    Story Group List Styling
    
    @IBOutlet weak var edgePadding: UITextField!
    @IBOutlet weak var paddingBetweenItems: UITextField!
    var edgePadValue = 10 //needs to be updated with default values
    var padBetweenItemsValue = 10
    
    
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
        
        containerToCustom.addSubview(customizedView)
        customizedView.translatesAutoresizingMaskIntoConstraints = false
        customizedView.heightAnchor.constraint(equalTo: containerToCustom.heightAnchor).isActive = true
        customizedView.widthAnchor.constraint(equalTo: containerToCustom.widthAnchor).isActive = true
        customizedView.centerXAnchor.constraint(equalTo: containerToCustom.centerXAnchor).isActive = true
        customizedView.centerYAnchor.constraint(equalTo: containerToCustom.centerYAnchor).isActive = true
        
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
        lineNumber = 2
        fontSize = 12
        font = UIFont.systemFont(ofSize: CGFloat(12))
        rgbValuesOfProperties = [[0,0,0],[189,61,16],[0,0,0],[0,0,0]]
//        COLORS OF BORDER STATES NEED TO BE RESETED
        height = 12
        width = 12
        cRadius = 10
        pickedSize = "large"
        
        customizedView.removeFromSuperview()
        customizedView = StorylyView()
        customizedView.storylyInit = StorylyInit(storylyId: STORYLY_INSTANCE_TOKEN)
        customizedView.rootViewController = self
        customizedView.delegate = self
        containerToCustom.addSubview(customizedView)
        customizedView.translatesAutoresizingMaskIntoConstraints = false
        customizedView.heightAnchor.constraint(equalTo: containerToCustom.heightAnchor).isActive = true
        customizedView.widthAnchor.constraint(equalTo: containerToCustom.widthAnchor).isActive = true
        customizedView.centerXAnchor.constraint(equalTo: containerToCustom.centerXAnchor).isActive = true
        customizedView.centerYAnchor.constraint(equalTo: containerToCustom.centerYAnchor).isActive = true
        
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
        let currentColor = rgbValuesOfProperties[3]
        self.customizedView.storyGroupTextStyling = StoryGroupTextStyling(isVisible: self.storyGroupTextIsVisible, color: UIColor.init(red: CGFloat(currentColor[0])/255, green: CGFloat(currentColor[1])/255, blue: CGFloat(currentColor[2])/255, alpha: 1.0), font: font, lines: lineNumber)
        
    }
    
    @IBAction func notSeenAddButton(_ sender: Any) {
        if(!availableIndexesNotSeen.isEmpty){
            let myStak = UIView()
            myStak.translatesAutoresizingMaskIntoConstraints = false

            notSeenColorView.addSubview(myStak)
            myStak.widthAnchor.constraint(equalToConstant: CGFloat(widthOfStack)).isActive = true
            myStak.heightAnchor.constraint(equalToConstant: CGFloat(30)).isActive = true
            myStak.leftAnchor.constraint(equalTo: notSeenColorsLabel.rightAnchor , constant: CGFloat((Double(widthOfStack * availableIndexesNotSeen[0]) / 2.0) * 1.1)).isActive = true
            myStak.centerYAnchor.constraint(equalTo: notSeenColorsLabel.centerYAnchor).isActive = true
        
            let button = UIButton()
            button.tag = availableIndexesNotSeen[0]
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
            button.widthAnchor.constraint(equalToConstant: CGFloat(Double(widthOfStack) * 0.4)).isActive = true
            button.heightAnchor.constraint(equalToConstant: CGFloat(20)).isActive = true
            button.centerYAnchor.constraint(equalTo: myStak.centerYAnchor).isActive = true
            button.rightAnchor.constraint(equalTo: myStak.rightAnchor,constant: CGFloat(-3)).isActive = true
            myLabel.translatesAutoresizingMaskIntoConstraints = false
            myLabel.leftAnchor.constraint(equalTo: myStak.leftAnchor,constant: CGFloat(2)).isActive = true
            myLabel.centerYAnchor.constraint(equalTo: myStak.centerYAnchor).isActive = true
            
            
            colorsOfNotSeenSate[availableIndexesNotSeen[0]] =  UIColor.init(red: CGFloat(rgbValuesOfNotSeenState[0])/255, green: CGFloat(rgbValuesOfNotSeenState[1])/255, blue: CGFloat(rgbValuesOfNotSeenState[2])/255, alpha: 1.0) //to fill the border colors dict
            let val = Array(colorsOfNotSeenSate.values)
            customizedView.storyGroupIconBorderColorNotSeen = val
            availableIndexesNotSeen.remove(at: 0)
        }
       
    }
    
    @IBAction func seenAddButton(_ sender: Any) {
        if(!availableIndexesSeen.isEmpty){
            let myStack = UIView() // will be convertted to stack
            myStack.translatesAutoresizingMaskIntoConstraints = false

            seenColorView.addSubview(myStack)
            myStack.widthAnchor.constraint(equalToConstant: CGFloat(widthOfStack)).isActive = true
            myStack.heightAnchor.constraint(equalToConstant: CGFloat(30)).isActive = true
            myStack.leftAnchor.constraint(equalTo: seenColorsLabel.rightAnchor , constant: CGFloat((Double(widthOfStack * (availableIndexesSeen[0] - 1)) / 2.0) * 1.1)).isActive = true
            myStack.centerYAnchor.constraint(equalTo: seenColorsLabel.centerYAnchor).isActive = true
        
            let button = UIButton()
            button.tag = availableIndexesSeen[0]
            button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            
            button.setImage(UIImage.init(systemName: "clear.fill"), for: .normal)

            lazy var myLabel: UILabel = {
                let label = UILabel()
                label.translatesAutoresizingMaskIntoConstraints = false
                label.text = "(" + rgbValuesOfSeenState[0].description + ", " +  rgbValuesOfSeenState[1].description + ", " + rgbValuesOfSeenState[2].description + ")"
                label.font = UIFont.systemFont(ofSize: 12)
                return label
            }()
            myStack.layer.cornerRadius = 8
            myStack.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4)
            myStack.addSubview(button)
            myStack.addSubview(myLabel)
            button.widthAnchor.constraint(equalToConstant: CGFloat(Double(widthOfStack) * 0.4)).isActive = true
            button.heightAnchor.constraint(equalToConstant: CGFloat(20)).isActive = true
            button.centerYAnchor.constraint(equalTo: myStack.centerYAnchor).isActive = true
            button.rightAnchor.constraint(equalTo: myStack.rightAnchor,constant: CGFloat(-3)).isActive = true
            myLabel.translatesAutoresizingMaskIntoConstraints = false
            myLabel.leftAnchor.constraint(equalTo: myStack.leftAnchor,constant: CGFloat(2)).isActive = true
            myLabel.centerYAnchor.constraint(equalTo: myStack.centerYAnchor).isActive = true
            
            
            colorsOfSeenState[availableIndexesSeen[0]] = UIColor.init(red: CGFloat(rgbValuesOfSeenState[0])/255, green: CGFloat(rgbValuesOfSeenState[1])/255, blue: CGFloat(rgbValuesOfSeenState[2])/255, alpha: 1.0)
            let vals = Array(colorsOfSeenState.values)
            customizedView.storyGroupIconBorderColorSeen = vals
            availableIndexesSeen.remove(at: 0)
        
        }
    }
    
    @objc func buttonAction(_ sender: UIButton){
        
        sender.superview?.removeFromSuperview()
        if(sender.tag % 2 == 0){//it means func called from notSeenState button
            availableIndexesNotSeen.insert(sender.tag, at: 0)
            availableIndexesNotSeen.sort()
            colorsOfNotSeenSate.removeValue(forKey: sender.tag)
            let val = Array(colorsOfNotSeenSate.values)
            customizedView.storyGroupIconBorderColorNotSeen = val
        }
        else{
            availableIndexesSeen.insert(sender.tag, at: 0)
            availableIndexesSeen.sort()
            colorsOfSeenState.removeValue(forKey: sender.tag)
            let val = Array(colorsOfSeenState.values)
            customizedView.storyGroupIconBorderColorSeen = val
        }
        
    }
//    Story Group Size functions
    @IBAction func convertToSmall(_ sender: Any) {
        
        smallButton.setImage(UIImage(systemName: "circle.inset.filled",withConfiguration: UIImage.SymbolConfiguration(scale: .large))?.withTintColor(UIColor.black), for: UIControl.State.normal)
        customizedView.removeFromSuperview()
        customizedView = StorylyView()
        customizedView.storylyInit = StorylyInit(storylyId: STORYLY_INSTANCE_TOKEN)
        customizedView.storyGroupSize = "small"
        customizedView.rootViewController = self
        customizedView.delegate = self
        bringBackOldProperties()
        
        containerToCustom.addSubview(customizedView)
        customizedView.translatesAutoresizingMaskIntoConstraints = false
        customizedView.heightAnchor.constraint(equalTo: containerToCustom.heightAnchor).isActive = true
        customizedView.widthAnchor.constraint(equalTo: containerToCustom.widthAnchor).isActive = true
        customizedView.centerXAnchor.constraint(equalTo: containerToCustom.centerXAnchor).isActive = true
        customizedView.centerYAnchor.constraint(equalTo: containerToCustom.centerYAnchor).isActive = true
        if(pickedSize == "custom"){
            customButton.setImage(UIImage(systemName: "circle",withConfiguration: UIImage.SymbolConfiguration(scale: .large))?.withTintColor(UIColor.black), for: UIControl.State.normal)
        }
        else{
            largeButton.setImage(UIImage(systemName: "circle",withConfiguration: UIImage.SymbolConfiguration(scale: .large))?.withTintColor(UIColor.black), for: UIControl.State.normal)
        }
        pickedSize = "small"
        customizedView.storyGroupSize = "small"
        
    }
    @IBAction func convertToLarge(_ sender: Any) {
        largeButton.setImage(UIImage(systemName: "circle.inset.filled",withConfiguration: UIImage.SymbolConfiguration(scale: .large))?.withTintColor(UIColor.black), for: UIControl.State.normal)
        customizedView.removeFromSuperview()
        customizedView = StorylyView()
        customizedView.storylyInit = StorylyInit(storylyId: STORYLY_INSTANCE_TOKEN)
        customizedView.storyGroupSize = "large"
        customizedView.rootViewController = self
        customizedView.delegate = self
        bringBackOldProperties()
        containerToCustom.addSubview(customizedView)
        customizedView.translatesAutoresizingMaskIntoConstraints = false
        customizedView.heightAnchor.constraint(equalTo: containerToCustom.heightAnchor).isActive = true
        customizedView.widthAnchor.constraint(equalTo: containerToCustom.widthAnchor).isActive = true
        customizedView.centerXAnchor.constraint(equalTo: containerToCustom.centerXAnchor).isActive = true
        customizedView.centerYAnchor.constraint(equalTo: containerToCustom.centerYAnchor).isActive = true
        if(pickedSize == "custom"){
            customButton.setImage(UIImage(systemName: "circle",withConfiguration: UIImage.SymbolConfiguration(scale: .large))?.withTintColor(UIColor.black), for: UIControl.State.normal)
        }
        else{
            smallButton.setImage(UIImage(systemName: "circle",withConfiguration: UIImage.SymbolConfiguration(scale: .large))?.withTintColor(UIColor.black), for: UIControl.State.normal)
        }
        
        pickedSize = "large"
        customizedView.storyGroupSize = "large"
    }
    @IBAction func converToCustom(_ sender: Any) {
        customButton.setImage(UIImage(systemName: "circle.inset.filled",withConfiguration: UIImage.SymbolConfiguration(scale: .large))?.withTintColor(UIColor.black), for: UIControl.State.normal)
        if(pickedSize == "small"){
            smallButton.setImage(UIImage(systemName: "circle",withConfiguration: UIImage.SymbolConfiguration(scale: .large))?.withTintColor(UIColor.black), for: UIControl.State.normal)
        }
        else{
            largeButton.setImage(UIImage(systemName: "circle",withConfiguration: UIImage.SymbolConfiguration(scale: .large))?.withTintColor(UIColor.black), for: UIControl.State.normal)
        }
        pickedSize = "custom"
        customizedView.storyGroupSize = "custom"
    }

    
    
    @IBAction func applyCustomSizes(_ sender: Any) {
//      12 needs to be changed to default values of storyly
        if(pickedSize == "custom"){
            let h = Int(heightTextF.text ?? "12")
            let w = Int(widthTextF.text  ?? "12")
            let c = Int(cornerRadiusTextF.text  ?? "12")
            height = h ?? 10
            width = w ?? 10
            cRadius = c ?? 10
            customizedView.removeFromSuperview()
            customizedView = StorylyView()
            customizedView.storylyInit = StorylyInit(storylyId: STORYLY_INSTANCE_TOKEN)
            customizedView.storyGroupSize = "custom"
            customizedView.storyGroupIconStyling = StoryGroupIconStyling(height: CGFloat(h!), width: CGFloat(w!), cornerRadius: CGFloat(c!))
            customizedView.storyGroupListStyling = StoryGroupListStyling(edgePadding: CGFloat(edgePadValue), paddingBetweenItems: CGFloat(padBetweenItemsValue))
            let currentValues = rgbValuesOfProperties[3]
            customizedView.storyGroupTextStyling =  StoryGroupTextStyling(isVisible: self.storyGroupTextIsVisible, color:UIColor.init(red: CGFloat(currentValues[0])/255, green: CGFloat(currentValues[1])/255, blue: CGFloat(currentValues[2])/255, alpha: 1.0), font: self.font, lines: self.lineNumber)
            
            let currentValues2 = rgbValuesOfProperties[2]
            customizedView.storyGroupIVodIconColor = UIColor.init(red: CGFloat(currentValues2[0])/255, green: CGFloat(currentValues2[1])/255, blue: CGFloat(currentValues2[2])/255, alpha: 1.0)
            
            let currentValues3 = rgbValuesOfProperties[1]
            customizedView.storyGroupPinIconColor = UIColor.init(red: CGFloat(currentValues3[0])/255, green: CGFloat(currentValues3[1])/255, blue: CGFloat(currentValues3[2])/255, alpha: 1.0)
            
            let currentValues4 = rgbValuesOfProperties[0]
            customizedView.storyGroupIconBackgroundColor = UIColor.init(red: CGFloat(currentValues4[0])/255, green: CGFloat(currentValues4[1])/255, blue: CGFloat(currentValues4[2])/255, alpha: 1.0)
            
            customizedView.rootViewController = self
            customizedView.delegate = self
            containerToCustom.addSubview(customizedView)
            customizedView.translatesAutoresizingMaskIntoConstraints = false
            customizedView.heightAnchor.constraint(equalTo: containerToCustom.heightAnchor).isActive = true
            customizedView.widthAnchor.constraint(equalTo: containerToCustom.widthAnchor).isActive = true
            customizedView.centerXAnchor.constraint(equalTo: containerToCustom.centerXAnchor).isActive = true
            customizedView.centerYAnchor.constraint(equalTo: containerToCustom.centerYAnchor).isActive = true
            print("applied")
        }
        
        
        
        
        
    }
    
   
    func bringBackOldProperties()
    {
        let currentValues = rgbValuesOfProperties[3]
        customizedView.storyGroupTextStyling =  StoryGroupTextStyling(isVisible: self.storyGroupTextIsVisible, color:UIColor.init(red: CGFloat(currentValues[0])/255, green: CGFloat(currentValues[1])/255, blue: CGFloat(currentValues[2])/255, alpha: 1.0), font: self.font, lines: self.lineNumber)
        
        let currentValues2 = rgbValuesOfProperties[2]
        customizedView.storyGroupIVodIconColor = UIColor.init(red: CGFloat(currentValues2[0])/255, green: CGFloat(currentValues2[1])/255, blue: CGFloat(currentValues2[2])/255, alpha: 1.0)
        
        let currentValues3 = rgbValuesOfProperties[1]
        customizedView.storyGroupPinIconColor = UIColor.init(red: CGFloat(currentValues3[0])/255, green: CGFloat(currentValues3[1])/255, blue: CGFloat(currentValues3[2])/255, alpha: 1.0)
        
        let currentValues4 = rgbValuesOfProperties[0]
        customizedView.storyGroupIconBackgroundColor = UIColor.init(red: CGFloat(currentValues4[0])/255, green: CGFloat(currentValues4[1])/255, blue: CGFloat(currentValues4[2])/255, alpha: 1.0)
        let vals = Array(colorsOfSeenState.values)
        customizedView.storyGroupIconBorderColorSeen = vals
        let val = Array(colorsOfNotSeenSate.values)
        customizedView.storyGroupIconBorderColorNotSeen = val
        
    }
    
    
    @IBAction func applyListStyling(_ sender: Any) {
        
        edgePadValue = Int(edgePadding.text ?? "12") ?? 10
        padBetweenItemsValue = Int(paddingBetweenItems.text ?? "12") ?? 10
        
        customizedView.removeFromSuperview()
        customizedView = StorylyView()
        customizedView.storylyInit = StorylyInit(storylyId: STORYLY_INSTANCE_TOKEN)
        customizedView.storyGroupSize = pickedSize
        if(pickedSize == "custom"){
            customizedView.storyGroupIconStyling = StoryGroupIconStyling(height: CGFloat(height), width: CGFloat(width), cornerRadius: CGFloat(cRadius))
        }
        customizedView.rootViewController = self
        customizedView.delegate = self
        customizedView.storyGroupListStyling = StoryGroupListStyling(edgePadding: CGFloat(edgePadValue), paddingBetweenItems: CGFloat(padBetweenItemsValue))
        bringBackOldProperties()
        containerToCustom.addSubview(customizedView)
        customizedView.translatesAutoresizingMaskIntoConstraints = false
        customizedView.heightAnchor.constraint(equalTo: containerToCustom.heightAnchor).isActive = true
        customizedView.widthAnchor.constraint(equalTo: containerToCustom.widthAnchor).isActive = true
        customizedView.centerXAnchor.constraint(equalTo: containerToCustom.centerXAnchor).isActive = true
        customizedView.centerYAnchor.constraint(equalTo: containerToCustom.centerYAnchor).isActive = true
        
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
        let currentColor = rgbValuesOfProperties[3]
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
                    stylesAndColors.selectRow(rgbValuesOfProperties[row][i-1], inComponent: i, animated: true)
                }
                let currentValues = rgbValuesOfProperties[currentPropertyIndex]
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
            
            rgbValuesOfProperties[currentPropertyIndex][component-1] = row
            var currentValues = rgbValuesOfProperties[0]
            switch currentPropertyIndex{
            case 0:
                currentValues = rgbValuesOfProperties[0]
                self.customizedView.storyGroupIconBackgroundColor = UIColor.init(red: CGFloat(currentValues[0])/255, green: CGFloat(currentValues[1])/255, blue: CGFloat(currentValues[2])/255, alpha: 1.0)
                break
            case 1:
                currentValues = rgbValuesOfProperties[1]
                self.customizedView.storyGroupPinIconColor = UIColor.init(red: CGFloat(currentValues[0])/255, green: CGFloat(currentValues[1])/255, blue: CGFloat(currentValues[2])/255, alpha: 1.0)
                
                break
            case 2:
                currentValues = rgbValuesOfProperties[2]
                self.customizedView.storyGroupIVodIconColor = UIColor.init(red: CGFloat(currentValues[0])/255, green: CGFloat(currentValues[1])/255, blue: CGFloat(currentValues[2])/255, alpha: 1.0)
                break
            case 3:
                currentValues = rgbValuesOfProperties[3]
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

//:- Extension for UIImage for hex values


extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
