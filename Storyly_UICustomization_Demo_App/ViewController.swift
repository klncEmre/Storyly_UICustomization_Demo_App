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
    let fontNames = ["System Font","Bold System Font"]
    let fonts = [UIFont.systemFont(ofSize: 12),UIFont.boldSystemFont(ofSize: 12)]
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
    private lazy var seenStack : UIStackView = {
        let stack = UIStackView()
        stack.spacing = CGFloat(10)
        return stack
    }()
    private lazy var notSeenStack : UIStackView = {
        let stack = UIStackView()
        stack.spacing = CGFloat(10)
        return stack
    }()
    @IBOutlet weak var viewsContainer: UIView!
    @IBOutlet weak var notSeenColorsLabel: UILabel!
    @IBOutlet weak var seenColorsLabel: UILabel!
    @IBOutlet weak var borderColorField: UITextField!
    let widthOfStack = 60
    var frontItem = "x"
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
    var edgePadValue = 20 //needs to be updated with default values
    var padBetweenItemsValue = 20
//    icon images for selections.
    let filledCircle = UIImage(systemName: "circle.inset.filled",withConfiguration: UIImage.SymbolConfiguration(scale: .large))?.withTintColor(UIColor.tintColor)
    let emptyCircle = UIImage(systemName: "circle",withConfiguration: UIImage.SymbolConfiguration(scale: .large))?.withTintColor(UIColor.black)
    enum sizePicked { //size to determine size of storyly bar.
        case small,large,custom
    }
    var pickedSize = sizePicked.large //default
    override func viewDidLoad() {
        super.viewDidLoad()
        //default
        defaultView.storylyInit = StorylyInit(storylyId: STORYLY_INSTANCE_TOKEN)
        defaultView.rootViewController = self
        defaultView.delegate = self
        //for customized parts
        resetAndSetCustomizedView()
        //Story Group Text Styling
        fontPicker.delegate = self
        fontPicker.dataSource = self
        fontPicker.selectRow(11, inComponent: 1, animated: true)
        lineNumberPicker.delegate = self
        lineNumberPicker.dataSource = self
        lineNumberPicker.selectRow(1, inComponent: 0, animated: true)
//        property and color system
        stylesAndColors.delegate = self
        stylesAndColors.dataSource = self
        colorShowcase.layer.cornerRadius = colorShowcase.frame.size.width/2
        colorShowcase.clipsToBounds = true
        colorShowcase.backgroundColor = UIColor.black
        colorField.delegate = self
        colorField.tag = 0
//        Seen and not Seen border color system
        seenColorView.addSubview(seenStack)
        notSeenColorView.addSubview(notSeenStack)
        seenStack.translatesAutoresizingMaskIntoConstraints = false
        seenStack.leftAnchor.constraint(equalTo: seenColorsLabel.rightAnchor,constant: CGFloat(10)).isActive = true
        notSeenStack.translatesAutoresizingMaskIntoConstraints = false
        notSeenStack.leftAnchor.constraint(equalTo: notSeenColorsLabel.rightAnchor,constant: CGFloat(10)).isActive = true
//      color input setting
        borderColorField.tag = 1
        borderColorField.delegate = self
    }

    @IBAction func resetButtonAction(_ sender: Any) { //To reset the customized view and its property picker etc.
        setDefaultValues()
        resetAndSetCustomizedView()
        
    }
    func setDefaultValues() {
        lineNumber = 2
        fontSize = 12
        fontPicker.selectRow(11, inComponent: 1, animated: true)
        fontPicker.selectRow(0, inComponent: 0, animated: true)
        stylesAndColors.selectRow(0, inComponent: 0, animated: true)
        lineNumberPicker.selectRow(1, inComponent: 0, animated: true)
        font = UIFont.systemFont(ofSize: CGFloat(12))
        properties = ["Background":"#000000","Pin Icon":"#000000","Ivod Icon":"#000000","Text Color":"#000000"]
        currentPropertyIndex = "Background"
        height = 12
        width = 12
        cRadius = 10
        edgePadValue = 20 //needs to be updated with default values
        padBetweenItemsValue = 20
        storyGroupTextIsVisible = true
    }
    func resetAndSetCustomizedView(){
        seenStack.arrangedSubviews.forEach{$0.removeFromSuperview()}
        notSeenStack.arrangedSubviews.forEach{$0.removeFromSuperview()}
        customDesignView.isUserInteractionEnabled = false
        textVisibleButton.setImage(filledCircle, for: UIControl.State.normal)
        convertToLarge(largeButton!)
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
            textVisibleButton.setImage(emptyCircle, for: UIControl.State.normal)
        }
        else{
            storyGroupTextIsVisible = true
            textVisibleButton.setImage(filledCircle, for: UIControl.State.normal)
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
       addButtonToStack(stackToAdd: notSeenStack)
    }
    
    @IBAction func seenAddButton(_ sender: Any) {
        addButtonToStack(stackToAdd: seenStack)
        
    }
    
    func addButtonToStack(stackToAdd:UIStackView){
        lazy var coloredButton: UIButton = {
            let button = UIButton()
            button.addTarget(self, action: #selector(buttonActionForStateColors), for: .touchUpInside)
            button.setTitle(borderColorField.text ?? "#FFFFFF", for: UIControl.State.normal)
            button.titleLabel?.font = .systemFont(ofSize: 10)
            button.backgroundColor = UIColor(hexString: borderColorField.text ?? "#FFFFFF")
            return button
        }()
    
        stackToAdd.addArrangedSubview(coloredButton)
        coloredButton.translatesAutoresizingMaskIntoConstraints = false
        coloredButton.widthAnchor.constraint(equalToConstant: CGFloat(widthOfStack)).isActive = true
        coloredButton.heightAnchor.constraint(equalToConstant: CGFloat(30)).isActive = true
        coloredButton.layer.cornerRadius = 8
        var colorsToUse : [UIColor] = []
        stackToAdd.arrangedSubviews.forEach { colorsToUse.append($0.backgroundColor!) }
        if(stackToAdd == seenStack){
            customizedView.storyGroupIconBorderColorSeen = colorsToUse
        }
        else {
            customizedView.storyGroupIconBorderColorNotSeen = colorsToUse
        }
        
    }
    
    @objc func buttonActionForStateColors(_ sender: UIButton){ //TO REMOVE A COLOR.
        if(sender.superview! == seenStack){
            sender.removeFromSuperview()
            var colorsOfSeen : [UIColor] = []
            seenStack.arrangedSubviews.forEach { colorsOfSeen.append($0.backgroundColor!) }
            customizedView.storyGroupIconBorderColorSeen = colorsOfSeen
            
        }
        else{
            sender.removeFromSuperview()
            var colorsOfNotSeen : [UIColor] = []
            notSeenStack.arrangedSubviews.forEach {colorsOfNotSeen.append($0.backgroundColor!) }
            customizedView.storyGroupIconBorderColorNotSeen = colorsOfNotSeen
            
        }
        
    }
//    Story Group Size functions
    
    func changeTheSize(pickedOne:sizePicked){
        switch pickedOne{
        case sizePicked.small:
            smallButton.setImage(filledCircle, for: UIControl.State.normal)
            customButton.setImage(emptyCircle, for: UIControl.State.normal)
            largeButton.setImage(emptyCircle, for: UIControl.State.normal)
            customDesignView.isUserInteractionEnabled = false
        case sizePicked.large:
            largeButton.setImage(filledCircle, for: UIControl.State.normal)
            smallButton.setImage(emptyCircle, for: UIControl.State.normal)
            customButton.setImage(emptyCircle, for: UIControl.State.normal)
            customDesignView.isUserInteractionEnabled = false
        case sizePicked.custom:
            customButton.setImage(filledCircle, for: UIControl.State.normal)
            smallButton.setImage(emptyCircle, for: UIControl.State.normal)
            largeButton.setImage(emptyCircle, for: UIControl.State.normal)
            customDesignView.isUserInteractionEnabled = true
        }
        bringBackOldProperties()
    }
        
    @IBAction func convertToSmall(_ sender: Any) {
        pickedSize =  sizePicked.small
        changeTheSize(pickedOne: sizePicked.small)
        
    }
    @IBAction func convertToLarge(_ sender: Any) {
        pickedSize = sizePicked.large
        changeTheSize(pickedOne: sizePicked.large)
        
    }
    @IBAction func converToCustom(_ sender: Any) {
        pickedSize = sizePicked.custom
        changeTheSize(pickedOne: sizePicked.custom)
    }

    @IBAction func applyCustomSizes(_ sender: Any) {
//      12 needs to be changed to default values of storyly
        if(pickedSize == sizePicked.custom){
            bringBackOldProperties()
            print("applied")
        }
    }
    func bringBackOldProperties()
    {
        var sizeText = "large"
        if(pickedSize == sizePicked.small){
            sizeText = "small"
        }
        else if(pickedSize == sizePicked.custom){
            sizeText = "custom"
        }
        customizedView.removeFromSuperview()
        customizedView = StorylyView()
        customizedView.storylyInit = StorylyInit(storylyId: STORYLY_INSTANCE_TOKEN)
        customizedView.storyGroupSize = sizeText
        if(pickedSize == sizePicked.custom){
            let h = Int(heightTextF.text ?? "12")
            let w = Int(widthTextF.text  ?? "12")
            let c = Int(cornerRadiusTextF.text  ?? "12")
            height = h ?? 10
            width = w ?? 10
            cRadius = c ?? 10
            customizedView.storyGroupIconStyling = StoryGroupIconStyling(height: CGFloat(h ?? 40), width: CGFloat(w ?? 40), cornerRadius: CGFloat(c ?? 30))
        }
        let currentValues = properties["Text Color"]
        customizedView.storyGroupTextStyling =  StoryGroupTextStyling(isVisible: self.storyGroupTextIsVisible, color:UIColor(hexString: currentValues ?? "#000000"), font: self.font, lines: self.lineNumber)
        
        let currentValues2 = properties["Ivod Icon"]
        customizedView.storyGroupIVodIconColor = UIColor(hexString: currentValues2 ?? "#000000")
        
        let currentValues3 = properties["Pin Icon"]
        customizedView.storyGroupPinIconColor = UIColor(hexString: currentValues3 ?? "#000000")
        
        let currentValues4 = properties["Background"]
        customizedView.storyGroupIconBackgroundColor = UIColor(hexString: currentValues4 ?? "#000000")
        
        customizedView.storyGroupListStyling = StoryGroupListStyling(edgePadding: CGFloat(edgePadValue), paddingBetweenItems: CGFloat(padBetweenItemsValue))
        var colorsOfSeen : [UIColor] = []
        seenStack.arrangedSubviews.forEach { colorsOfSeen.append($0.backgroundColor!) }
        customizedView.storyGroupIconBorderColorSeen = colorsOfSeen
        customizedView.storyGroupIconBorderColorSeen = colorsOfSeen
        var colorsOfNotSeen : [UIColor] = []
        notSeenStack.arrangedSubviews.forEach {colorsOfNotSeen.append($0.backgroundColor!) }
        customizedView.storyGroupIconBorderColorNotSeen = colorsOfNotSeen
        customizedView.storyGroupIconBorderColorNotSeen = colorsOfNotSeen
        customizedView.rootViewController = self
        customizedView.delegate = self
        containerToCustom.addSubview(customizedView)
        customizedView.translatesAutoresizingMaskIntoConstraints = false
        customizedView.heightAnchor.constraint(equalTo: containerToCustom.heightAnchor).isActive = true
        customizedView.widthAnchor.constraint(equalTo: containerToCustom.widthAnchor).isActive = true
        customizedView.centerXAnchor.constraint(equalTo: containerToCustom.centerXAnchor).isActive = true
        customizedView.centerYAnchor.constraint(equalTo: containerToCustom.centerYAnchor).isActive = true
    }
    
    @IBAction func applyListStyling(_ sender: Any) {
        edgePadValue = Int(edgePadding.text ?? "12") ?? 10
        padBetweenItemsValue = Int(paddingBetweenItems.text ?? "12") ?? 10
        bringBackOldProperties()
    }
    
}
//-
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
                return self.fonts.count
            case lineNumberPicker:
                return 5
            case stylesAndColors:
                return properties.count
            default:
                return 1
            }
        }
        else if(component == 1 && pickerView == fontPicker) {
            return 50
        }
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if(component == 0) {
            switch pickerView{
                case fontPicker:
                    return fontNames[row]
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
                    
                    font = fonts[row]
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
            var refreshBar = false
            if((row + 1) > fontSize){
                refreshBar = true
            }
            fontSize = row + 1
            font = font.withSize(CGFloat(fontSize))
            self.customizedView.storyGroupTextStyling =  StoryGroupTextStyling(isVisible: self.storyGroupTextIsVisible, color:UIColor(hexString: currentColor ?? "#000000"), font: self.font, lines: self.lineNumber)
            if(refreshBar){
                bringBackOldProperties()
                
            }
        }
    }

    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        let w = pickerView.frame.size.width
        
        switch pickerView{
            case stylesAndColors:
                return w 
            
            case fontPicker:
                return w/2
            case lineNumberPicker:
                return w
        default:
            return w
        }
    }
}

// Extension for UIImage for hex values
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
                if(toCheck.count == 7 && textField.tag == 0){
                    return true
                }
                else if(toCheck.count == 7 && textField.tag == 1){
                    return true
                }
            }
        return false
    }
    public func textFieldDidEndEditing(_ textField: UITextField) {
        if(textField == colorField){
            colorShowcase.backgroundColor = UIColor(hexString: textField.text ?? "#000000")
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}
//MARK: - TO DO
//seperate property and constraint set DONE
//reset button and viewdidload kinda do same thing, merge them into a function DONE
//use button indexes at stack to remove them. DONE
//Also function to add button to stack with both button is implemented for clearity.
