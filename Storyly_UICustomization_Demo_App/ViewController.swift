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
    var properties = ["Background":"#000000","Pin Icon":"#000000","Ivod Icon":"#000000","Text Color":"#000000", ]
    var propertiesNames = ["Background","Pin Icon","Ivod Icon","Text Color"]
     //needs to be updated with default values
    var currentPropertyIndex = "Background" //change this to property name
    @IBOutlet weak var colorShowcase: UIView!
    @IBOutlet weak var colorField: UITextField!
    

//Seen - Not seen system
    @IBOutlet weak var seenColorView: UIView!
    @IBOutlet weak var notSeenColorView: UIView!
    let seenStack = UIStackView()
    let notSeenStack = UIStackView()
    var colorsOfSeenState : [UIColor] = []
    var colorsOfNotSeenSate: [Int:UIColor] = [:]
    var rgbValuesOfSeenState:[Int] = [0,0,0]
    var rgbValuesOfNotSeenState:[Int] = [0,0,0]
    @IBOutlet weak var viewsContainer: UIView!
    @IBOutlet weak var notSeenColorsLabel: UILabel!
    @IBOutlet weak var seenColorsLabel: UILabel!
    @IBOutlet weak var borderColorField: UITextField!
    
    var coordinateKeeperNotSeen = 20.0
    let widthOfStack = 80
    var availableIndexesNotSeen = [0,2,4,6]

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
    
    @IBOutlet weak var customDesignView: UIStackView!
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
        
        colorField.delegate = self
        customDesignView.isUserInteractionEnabled = false
        seenColorView.addSubview(seenStack)
        seenStack.translatesAutoresizingMaskIntoConstraints = false
        seenStack.leftAnchor.constraint(equalTo: seenColorsLabel.rightAnchor,constant: CGFloat(20)).isActive = true
        seenStack.spacing = CGFloat(10)
        
    }
    
    @IBAction func resetButtonAction(_ sender: Any) {
        lineNumber = 2
        fontSize = 12
        font = UIFont.systemFont(ofSize: CGFloat(12))
        properties = ["Background":"#000000","Pin Icon":"#000000","Ivod Icon":"#000000","Text Color":"#000000"]
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
        let currentColor = properties["Text Color"]
        self.customizedView.storyGroupTextStyling = StoryGroupTextStyling(isVisible: self.storyGroupTextIsVisible, color: UIColor.init(hexString: currentColor ?? "#000000"), font: font, lines: lineNumber)
        
    }
    
    
    @IBAction func applyColorToProperty(_ sender: Any) {
        colorShowcase.backgroundColor = UIColor(hexString: colorField.text ?? "#000000")
        switch currentPropertyIndex{
            case "Background":
            //Background
                self.customizedView.storyGroupIconBackgroundColor = UIColor(hexString: colorField.text ?? "#000000")
                properties["Background"] = colorField.text ?? "#000000"
                break
            case "Pin Icon":
                self.customizedView.storyGroupPinIconColor = UIColor(hexString: colorField.text ?? "#000000" )
                properties["Pin Icon"] = colorField.text ?? "#000000"
                break
            case "Ivod Icon":
                self.customizedView.storyGroupIVodIconColor = UIColor(hexString: colorField.text ?? "#000000")
                properties["Ivod Icon"] = colorField.text ?? "#000000"
                
                break
            case "Text Color":
                self.customizedView.storyGroupTextStyling =  StoryGroupTextStyling(isVisible: self.storyGroupTextIsVisible, color:UIColor(hexString: colorField.text  ?? "#000000"), font: self.font, lines: self.lineNumber)
                properties["Text Color"] =  colorField.text ?? "#000000"
                break
        default:
            break
        }
        
        
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
            button.addTarget(self, action: #selector(buttonActionForStateColors), for: .touchUpInside)
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
       
        let myStack = UIStackView() // will be convertted to stack
        myStack.translatesAutoresizingMaskIntoConstraints = false

        seenStack.addArrangedSubview(myStack)
        myStack.widthAnchor.constraint(equalToConstant: CGFloat(widthOfStack)).isActive = true
        myStack.heightAnchor.constraint(equalToConstant: CGFloat(30)).isActive = true
        myStack.centerYAnchor.constraint(equalTo: seenColorsLabel.centerYAnchor).isActive = true
    
        let button = UIButton()
        button.tag = 1
        button.addTarget(self, action: #selector(buttonActionForStateColors), for: .touchUpInside)
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
        
       
        colorsOfSeenState.append( UIColor.init(red: CGFloat(rgbValuesOfSeenState[0])/255, green: CGFloat(rgbValuesOfSeenState[1])/255, blue: CGFloat(rgbValuesOfSeenState[2])/255, alpha: 1.0))
        customizedView.storyGroupIconBorderColorSeen = colorsOfSeenState
        
    
        
    }
    
    @objc func buttonActionForStateColors(_ sender: UIButton){
        
        sender.superview?.removeFromSuperview()
        if(sender.tag % 2 == 0){//it means func called from notSeenState button
            availableIndexesNotSeen.insert(sender.tag, at: 0)
            availableIndexesNotSeen.sort()
            colorsOfNotSeenSate.removeValue(forKey: sender.tag)
            let val = Array(colorsOfNotSeenSate.values)
            customizedView.storyGroupIconBorderColorNotSeen = val
        }
        else{
           
            customizedView.storyGroupIconBorderColorSeen = colorsOfSeenState
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
        customDesignView.isUserInteractionEnabled = false
        
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
        customDesignView.isUserInteractionEnabled = false
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
        customDesignView.isUserInteractionEnabled = true
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
            let currentValues = properties["Text Color"]
            customizedView.storyGroupTextStyling =  StoryGroupTextStyling(isVisible: self.storyGroupTextIsVisible, color:UIColor(hexString: currentValues ?? "#000000"), font: self.font, lines: self.lineNumber)
            
            let currentValues2 = properties["Ivod Icon"]
            customizedView.storyGroupIVodIconColor = UIColor(hexString: currentValues2 ?? "#000000")
            
            let currentValues3 = properties["Pin Icon"]
            customizedView.storyGroupPinIconColor = UIColor(hexString: currentValues3 ?? "#000000")
            
            let currentValues4 = properties["Background"]
            customizedView.storyGroupIconBackgroundColor = UIColor(hexString: currentValues4 ?? "#000000")
            
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
        let currentValues = properties["Text Color"]
        customizedView.storyGroupTextStyling =  StoryGroupTextStyling(isVisible: self.storyGroupTextIsVisible, color:UIColor(hexString: currentValues ?? "#000000"), font: self.font, lines: self.lineNumber)
        
        let currentValues2 = properties["Ivod Icon"]
        customizedView.storyGroupIVodIconColor = UIColor(hexString: currentValues2 ?? "#000000")
        
        let currentValues3 = properties["Pin Icon"]
        customizedView.storyGroupPinIconColor = UIColor(hexString: currentValues3 ?? "#000000")
        
        let currentValues4 = properties["Background"]
        customizedView.storyGroupIconBackgroundColor = UIColor(hexString: currentValues4 ?? "#000000")
       
        customizedView.storyGroupIconBorderColorSeen = colorsOfSeenState
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
            return 1
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
            default:
                return 1
            }
            
          
        }
       
        else if(component == 1 && pickerView == fontPicker) {
            return 12
        }
       
    
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if(component == 0) {
            let propertyNames = Array(properties.keys)
            switch pickerView{
                case fontPicker:
                    let key = Array(groupTextFontDict.keys)
                    return key[row]
                case lineNumberPicker:
                    return  (row+1).description
                case stylesAndColors:
                    return propertiesNames[row]
    
                default:
                    return "x"
            }
           
        }
        else if(pickerView == fontPicker && component == 1){
            return (row+1).description
        }
        return "x"
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let currentColor = properties["Text Color"]
        if(component == 0){
            switch pickerView{
                case fontPicker:
                    let values = Array(groupTextFontDict.values)
                    font = values[row]
                    self.customizedView.storyGroupTextStyling =  StoryGroupTextStyling(isVisible:  self.storyGroupTextIsVisible, color: UIColor(hexString: currentColor ?? "#000000"), font: self.font, lines: self.lineNumber)
                    break
                    
            case lineNumberPicker:
                lineNumber = row + 1
                self.customizedView.storyGroupTextStyling =  StoryGroupTextStyling(isVisible: self.storyGroupTextIsVisible, color:UIColor(hexString: currentColor ?? "#000000"), font: self.font, lines: self.lineNumber)
                break
            case stylesAndColors:
                currentPropertyIndex = propertiesNames[row]
                print(currentPropertyIndex)
                let currentValue = properties[currentPropertyIndex]
                colorShowcase.backgroundColor = UIColor(hexString: currentValue ?? "#000000")
                colorField.text = currentValue
               
                
                break
            
            default:
                break
            }
           
        }
        else if(pickerView == fontPicker && component == 1){
            fontSize = row + 1
            font = font.withSize(CGFloat(fontSize))
            self.customizedView.storyGroupTextStyling =  StoryGroupTextStyling(isVisible: self.storyGroupTextIsVisible, color:UIColor(hexString: currentColor ?? "#000000"), font: self.font, lines: self.lineNumber)
        }
        
       
                
    }
    
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        let w = pickerView.frame.size.width
        
        switch pickerView{
            case stylesAndColors:
                return w 
            
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



extension ViewController: UITextFieldDelegate{
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if let toCheck = textField.text{
            if(toCheck.count == 7){
                return true
            }
       
        }
        return false
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        colorShowcase.backgroundColor = UIColor(hexString: textField.text ?? "#000000")
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("check")
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
}
//else if(pickerView == stylesAndColors && component != 0){
//
//    rgbValuesOfProperties[currentPropertyIndex][component-1] = row
//    var currentValues = rgbValuesOfProperties[0]
//    switch currentPropertyIndex{
//    case 0:
//        currentValues = rgbValuesOfProperties[0]
//        self.customizedView.storyGroupIconBackgroundColor = UIColor.init(red: CGFloat(currentValues[0])/255, green: CGFloat(currentValues[1])/255, blue: CGFloat(currentValues[2])/255, alpha: 1.0)
//        break
//    case 1:
//        currentValues = rgbValuesOfProperties[1]
//        self.customizedView.storyGroupPinIconColor = UIColor.init(red: CGFloat(currentValues[0])/255, green: CGFloat(currentValues[1])/255, blue: CGFloat(currentValues[2])/255, alpha: 1.0)
//
//        break
//    case 2:
//        currentValues = rgbValuesOfProperties[2]
//        self.customizedView.storyGroupIVodIconColor = UIColor.init(red: CGFloat(currentValues[0])/255, green: CGFloat(currentValues[1])/255, blue: CGFloat(currentValues[2])/255, alpha: 1.0)
//        break
//    case 3:
//        currentValues = rgbValuesOfProperties[3]
//        self.customizedView.storyGroupTextStyling =  StoryGroupTextStyling(isVisible: self.storyGroupTextIsVisible, color:UIColor.init(red: CGFloat(currentValues[0])/255, green: CGFloat(currentValues[1])/255, blue: CGFloat(currentValues[2])/255, alpha: 1.0), font: self.font, lines: self.lineNumber)
//        break
//    default:
//        break
//
//    }
//    colorShowcase.backgroundColor = UIColor.init(red: CGFloat(currentValues[0])/255, green: CGFloat(currentValues[1])/255, blue: CGFloat(currentValues[2])/255, alpha: 1.0)
//    colorShowcase.tintColor = UIColor.init(red: CGFloat(currentValues[0])/255, green: CGFloat(currentValues[1])/255, blue: CGFloat(currentValues[2])/255, alpha: 1.0)
//}
