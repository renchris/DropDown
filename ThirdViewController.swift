////
////  ThirdViewController.swift
////  tabBarApp
////
////  Created by default on 2020-05-22.
////  Copyright © 2020 Chris Ren. All rights reserved.
////
//
//
//import UIKit
//import RAMAnimatedTabBarController
//import RealmSwift
//import IQKeyboardManagerSwift
//import DropDown
//
////note. for FirstViewController with the Calendar, when on a day, and it turns the next day on midnight, the blue fill white inner circle circle that indicates Today is selected, stays on the previous day. It only changes to the new day (the day after midnight) once the app is refreshed.
////Also, when dismiss/closing the app, and restarting it, it goes to the Today date (like kind of expected). Think I should improve it by making it the current date still if it was the previous day and there are entires. for when working on an event past midnight.
//
////need with drop down:
//// 1.  have two drop for one button.  done
//// 2.  both show when clicked.        can do, did
//// 3.  allow click on either or       need to figure out how to make area outside of chosen dropdown clickable
////     when both are up
//// 4.  dismiss when both dropdowns    need to figure out above
////     have a cell selected
//// 5.  dismiss when area              need to figure out above
////     outside is clicked
//
//
//class ThirdViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
//
//    let realm = try! Realm()
//
//    var newEventDate: EventDate?
//
//    @IBOutlet weak var thirdNavigationItem_Add: UINavigationItem!
//
//    @IBOutlet weak var thirdTabBarItem_Add: RAMAnimatedTabBarItem!
//
//    let cellBackgroundColour = UIColor(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, alpha: 1.0)
//
//    var savedTextViewHeight: CGFloat = 0
//
//    lazy var notesTextView = createTextView(labelTitle: "")
//    lazy var nameTextField = createTextField(labelTitle: "First Last")
//    lazy var nameValidationMessageView = createValidationMessageView(messageTitle: "Warning Message")
//
//    lazy var guestTextField = createTextField(labelTitle: "+ 0")
//    lazy var guestValidationMessageView = createValidationMessageView(messageTitle: "Warning Message")
//    lazy var guestPrefixLabel = createLabel(labelTitle: "+ ")
//
//    //lazy var coverTextField = createTextField(labelTitle: "Fill in cover elgibility")
//    var coverButtonView = UIStackView()
//    lazy var coverLeftHourDropdown = createDropdown(items: ["10", "11", "12", "1", "2", "3"])
//    lazy var coverLeftMinuteDropdown = createDropdown(items: ["00", "15", "30", "45"])
//    lazy var coverRightDropdown = createDropdown(items: ["10", "11", "12", "1", "2", "3"])
//
//    lazy var buttonValidationMessageView = createValidationMessageView(messageTitle: "Result Warning Message")
//
//    let warningImage = UIImage(systemName: "exclamationmark.octagon")
//    let successImage = UIImage(systemName: "checkmark.circle")
//    let errorImage = UIImage(systemName: "xmark.circle")
//
//    override func viewDidLoad(){
//        super.viewDidLoad()
//
//        //Name Field
//        let nameHeaderLabel = createHeader(headerTitle: "Full Name")
//        //let nameTextField = createTextField(labelTitle: "Fill in guest's name")
//        nameTextField.autocapitalizationType = UITextAutocapitalizationType.words
//        let nameTextFieldView = createLabelView(textField: nameTextField)
//
//        let nameView = UIStackView()
//        nameView.axis  = NSLayoutConstraint.Axis.vertical
//        nameView.addArrangedSubview(nameHeaderLabel)
//        nameView.addArrangedSubview(nameTextFieldView)
//        nameView.addSubview(nameValidationMessageView)
//
//        //Guests Field
//        let guestHeaderLabel = createHeader(headerTitle: "Additional Guests")
//        //let guestTextField = createTextField(labelTitle: "Fill in number of additional guests")
//        let guestTextFieldView = createLabelViewWithLabel(textField: guestTextField, prefixLabel: guestPrefixLabel)
//        guestPrefixLabel.isHidden = true
//
//        guestTextField.keyboardType = .numberPad
//
//        addDoneButtonOnNumpad(textField: guestTextField)
//
//        let guestView = UIStackView()
//        guestView.axis  = NSLayoutConstraint.Axis.vertical
//        guestView.addArrangedSubview(guestHeaderLabel)
//        guestView.addArrangedSubview(guestTextFieldView)
//        guestView.addSubview(guestValidationMessageView)
//
//        //Cover Field
//        let coverHeaderLabel = createHeader(headerTitle: "Cover")
//        //let coverTextField = createTextField(labelTitle: "Fill in cover elgibility")
//        //let coverTextFieldView = createLabelView(textField: coverTextField)
//
//        let coverLeftButton = createCoverButton(buttonTitle: "NO COVER")
//        let coverRighButton = createCoverButton(buttonTitle: "DISCOUNT")
//
//        coverLeftHourDropdown.anchorView = coverLeftButton
//        coverLeftMinuteDropdown.anchorView = coverLeftButton
//        coverRightDropdown.anchorView = coverRighButton
//
//
//
//        print("left button 0 width: \(coverLeftButton.frame.width)")
//
//
//        coverLeftHourDropdown.willShowAction = {
//            if let button = self.coverLeftHourDropdown.anchorView as? UIButton{
//                print("left button A width: \(button.frame.width)")
//                self.coverLeftHourDropdown.width = button.frame.width / 2
//                self.coverLeftMinuteDropdown.bottomOffset = CGPoint(x: self.coverLeftHourDropdown.width!, y: self.coverLeftMinuteDropdown.bottomOffset.y)
//
//            }
//        }
//
//
//
//
//
////        coverLeftDropdown.willShowAction = {
////
////        }
//
//        coverLeftHourDropdown.selectionAction = { (index, string) in
//            print("Dropdown cell selected: \(index), \(string)")
//            if(index == 0){
//                if let button = self.coverLeftHourDropdown.anchorView as? UIButton {
//                    print("zero (\(index) index selected")
//                    button.isSelected = false
//                    button.setTitleColor(.black, for: .normal)
//                    button.layer.borderColor = UIColor.systemGray2.cgColor
//                    print("left button 1 width: \(button.frame.width)")
//                }
//            }else{
//                if let button = self.coverLeftHourDropdown.anchorView as? UIButton {
//                    print("\(index) index selected")
//                    button.isSelected = true
//                    button.setTitleColor(.systemBlue, for: .normal)
//                    button.layer.borderColor = UIColor.systemBlue.cgColor
//                    print("left button 2 width: \(button.frame.size.width)")
//                }
//            }
//            //print("left dropdown width: \(self.coverLeftDropdown.width)")
//
//        }
//
//        coverRightDropdown.selectionAction = { (index, string) in
//            print("Dropdown cell selected: \(index), \(string)")
//            if(index == 0){
//                if let button = self.coverRightDropdown.anchorView as? UIButton {
//                    print("zero (\(index) index selected")
//                    button.isSelected = false
//                    button.setTitleColor(.black, for: .normal)
//                    button.layer.borderColor = UIColor.systemGray2.cgColor
//                }
//            }else{
//                if let button = self.coverRightDropdown.anchorView as? UIButton {
//                    print("\(index) index selected")
//                    button.isSelected = true
//                    button.setTitleColor(.systemBlue, for: .normal)
//                    button.layer.borderColor = UIColor.systemBlue.cgColor
//                }
//            }
//        }
//
//
//        coverButtonView.axis  = NSLayoutConstraint.Axis.horizontal
//        coverButtonView.distribution = UIStackView.Distribution.fillEqually
//        coverButtonView.spacing = 8.0
//        coverButtonView.addArrangedSubview(coverLeftButton)
//        coverButtonView.addArrangedSubview(coverRighButton)
//
//
//        let coverView = UIStackView()
//        coverView.axis  = NSLayoutConstraint.Axis.vertical
//        coverView.addArrangedSubview(coverHeaderLabel)
//        //coverView.addArrangedSubview(coverTextFieldView)
//        coverView.addArrangedSubview(coverButtonView)
//
//        //Notes Field
//        let notesHeaderLabel = createHeader(headerTitle: "Notes")
//        //let notesTextView = createTextView(labelTitle: "")
//
//        //notesPlaceholderLabel.transform = CGAffineTransform(translationX: 20, y: 7)
//
//        let placeholderLabel = UILabel()
//        placeholderLabel.font = UIFont.systemFont(ofSize: 24.0)
//        placeholderLabel.textColor = .lightGray
//        placeholderLabel.text  = "Add notes about guest"
//        placeholderLabel.textAlignment = .left
//        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
//
//        notesTextView.addSubview(placeholderLabel)
//
//
//
//        let notesView = UIStackView()
//        notesView.axis  = NSLayoutConstraint.Axis.vertical
//        notesView.addArrangedSubview(notesHeaderLabel)
//        notesView.addArrangedSubview(notesTextView)
//        //notesView.addArrangedSubview(notesTextFieldView)
//
//        //Stack View
//        let stackView   = UIStackView()
//        stackView.axis  = NSLayoutConstraint.Axis.vertical
//        stackView.distribution  = UIStackView.Distribution.equalSpacing
//        stackView.alignment = UIStackView.Alignment.center
//        stackView.spacing   = 16.0*2.5
//        //makes center look off from top nav bar and button hm.
//
//        stackView.addArrangedSubview(nameView)
//        stackView.addArrangedSubview(guestView)
//        stackView.addArrangedSubview(coverView)
//        stackView.addArrangedSubview(notesView)
//
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//
//        self.view.addSubview(stackView)
//
//        //Button Validation Message
//        self.view.addSubview(buttonValidationMessageView)
//
//        //Button
//        let button = createAddGuestButton(buttonTitle: "Add Guest")
//
//        self.view.addSubview(button)
//
//        print("button fs_height: \(button.fs_height)")
//
//        //safe area not recognizing tab bar. seems like its 84? at least for iphone 11 pro max on simulator
//
//        print("self.view.fs_bottom: \(self.view.fs_bottom)")
//        print("self.view.safeAreaLayoutGuide.layoutFrame.height: \(self.view.safeAreaLayoutGuide.layoutFrame.height)")
//
//        //Constraints
//        button.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0).isActive = true
//        button.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0).isActive = true
//        button.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
//
//        buttonValidationMessageView.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
//        buttonValidationMessageView.bottomAnchor.constraint(equalTo: button.topAnchor).isActive = true
//
//        nameHeaderLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
//        nameTextFieldView.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
//        nameTextField.leadingAnchor.constraint(equalTo: nameTextFieldView.leadingAnchor, constant: 16.0).isActive = true
//        nameTextField.trailingAnchor.constraint(equalTo: nameTextFieldView.trailingAnchor, constant: -16.0).isActive = true
//        nameTextField.centerYAnchor.constraint(equalTo: nameTextFieldView.centerYAnchor).isActive = true
//        nameValidationMessageView.topAnchor.constraint(equalTo: nameTextFieldView.bottomAnchor).isActive = true
//        nameValidationMessageView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
//
//        guestHeaderLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
//        guestTextFieldView.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
//        //guestTextField.leadingAnchor.constraint(equalTo: guestTextFieldView.leadingAnchor, constant: 16.0).isActive = true
//        //guestTextField.trailingAnchor.constraint(equalTo: guestTextFieldView.trailingAnchor, constant: -16.0).isActive = true
//        guestTextField.centerYAnchor.constraint(equalTo: guestTextFieldView.centerYAnchor).isActive = true
//        guestValidationMessageView.topAnchor.constraint(equalTo: guestTextFieldView.bottomAnchor).isActive = true
//        guestValidationMessageView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
//
//        coverHeaderLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
//        //coverTextFieldView.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
//        coverButtonView.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
////        coverTextField.leadingAnchor.constraint(equalTo: coverTextFieldView.leadingAnchor, constant: 16.0).isActive = true
////        coverTextField.trailingAnchor.constraint(equalTo: coverTextFieldView.trailingAnchor, constant: -16.0).isActive = true
////        coverTextField.centerYAnchor.constraint(equalTo: coverTextFieldView.centerYAnchor).isActive = true
//
//        notesHeaderLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
//        notesTextView.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
//        //Not sure why leading anchor is 21 offset and not 16.
//        placeholderLabel.topAnchor.constraint(equalTo: notesTextView.topAnchor, constant: 16).isActive = true
//        placeholderLabel.leadingAnchor.constraint(equalTo: notesTextView.leadingAnchor, constant: 21).isActive = true
//
//        stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0).isActive = true
//        stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0).isActive = true
//        //stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
//        stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true //button and padding above and below
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        thirdNavigationItem_Add.setTitle("Add", subtitleOne: "Venue Nightclub", subtitleTwo: FirstViewController.selectedDate)
//    }
//
//    //MARK: - View and Subview Creation Methods
//    func createHeader(headerTitle: String) -> UILabel {
//        let headerLabel = UILabel()
//        headerLabel.font = UIFont.boldSystemFont(ofSize: 24.0)
//        headerLabel.heightAnchor.constraint(equalToConstant: 48).isActive = true
//        headerLabel.text  = headerTitle
//        headerLabel.textAlignment = .left
//
//        return headerLabel
//    }
//
//    func createLabel(labelTitle: String) -> UILabel {
//        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 24.0)
//        label.heightAnchor.constraint(equalToConstant: 48).isActive = true
//        label.text  = labelTitle
//        label.textColor = .black
//
//        return label
//    }
//
//    func createValidationMessageView(messageTitle: String) -> UIStackView {
//
//        let stackView   = UIStackView()
//        stackView.axis  = NSLayoutConstraint.Axis.horizontal
//        stackView.alignment = UIStackView.Alignment.center
//        stackView.spacing   = 2.0
//        stackView.isHidden = true
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//
//        let messageLabel = UILabel()
//        messageLabel.font = UIFont.systemFont(ofSize: 20)
//        messageLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
//        messageLabel.text  = messageTitle
//        messageLabel.textColor = .systemRed
//        messageLabel.translatesAutoresizingMaskIntoConstraints = false
//
//        let imageView = UIImageView(image: warningImage)
//        imageView.tintColor = .systemRed
//
//        stackView.addArrangedSubview(imageView)
//        stackView.addArrangedSubview(messageLabel)
//
//        return stackView
//    }
//
//    func createTextField(labelTitle: String) -> UITextField{
//        let textField = UITextField()
//        textField.font = UIFont.systemFont(ofSize: 24.0)
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        textField.textColor = .black
//        textField.attributedPlaceholder = NSAttributedString(string:"placeholder text", attributes:[NSAttributedString.Key.foregroundColor: UIColor.lightGray])
//
//        textField.placeholder  = labelTitle
//
//        textField.autocorrectionType = UITextAutocorrectionType.no
//        textField.keyboardType = UIKeyboardType.default
//        textField.returnKeyType = UIReturnKeyType.done
//        textField.textAlignment = .left
//        textField.delegate = self
//
//        return textField
//    }
//
//    func createTextView(labelTitle: String) -> UITextView{
//        let textView = UITextView()
//
//        textView.addObserver(self, forKeyPath: "frame", options: .new, context: nil)
//
//        textView.isScrollEnabled = false
//        textView.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
//        textView.layer.cornerRadius = 8
//
//        textView.font = UIFont.systemFont(ofSize: 24.0)
//        textView.translatesAutoresizingMaskIntoConstraints = false
//        textView.textColor = .lightGray
//        textView.text  = labelTitle
//
//        textView.backgroundColor = cellBackgroundColour
//
//        textView.autocorrectionType = UITextAutocorrectionType.no
//        textView.keyboardType = UIKeyboardType.default
//        textView.returnKeyType = UIReturnKeyType.done
//        textView.textAlignment = .left
//        textView.delegate = self
//
//        return textView
//    }
//
//    func createLabelView(textField: UITextField) -> UIView{
//        let textLabelView = UIView()
//        textLabelView.backgroundColor = self.cellBackgroundColour
//        textLabelView.layer.cornerRadius = 8
//        textLabelView.heightAnchor.constraint(equalToConstant: 48).isActive = true
//
//        textLabelView.addSubview(textField)
//
//        return textLabelView
//    }
//
//    func createLabelViewWithLabel(textField: UITextField, prefixLabel: UILabel) -> UIView{
//        let textLabelView = UIView()
//        textLabelView.backgroundColor = self.cellBackgroundColour
//        textLabelView.layer.cornerRadius = 8
//        textLabelView.heightAnchor.constraint(equalToConstant: 48).isActive = true
//        textLabelView.translatesAutoresizingMaskIntoConstraints = false
//
//        let guestStackView   = UIStackView()
//        guestStackView.axis  = NSLayoutConstraint.Axis.horizontal
//        guestStackView.alignment = UIStackView.Alignment.center
//        guestStackView.distribution = UIStackView.Distribution.fill
//        guestStackView.spacing   = 0.0
//        guestStackView.isHidden = false
//        guestStackView.translatesAutoresizingMaskIntoConstraints = false
//
//        guestStackView.addArrangedSubview(prefixLabel)
//        guestStackView.addArrangedSubview(textField)
//
//        //Not sure why UILabel is slightly lower than UITextField with same font size.
//        prefixLabel.bottomAnchor.constraint(equalTo: textField.bottomAnchor, constant: -0.2).isActive = true
//
//        textLabelView.addSubview(guestStackView)
//
//        guestStackView.leadingAnchor.constraint(equalTo: textLabelView.leadingAnchor, constant: 16.0).isActive = true
//        guestStackView.trailingAnchor.constraint(equalTo: textLabelView.trailingAnchor, constant: -16.0).isActive = true
//        guestStackView.centerYAnchor.constraint(equalTo: textLabelView.centerYAnchor).isActive = true
//
//        return textLabelView
//    }
//
//    func createAddGuestButton(buttonTitle: String) -> UIButton {
//        let button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.heightAnchor.constraint(equalToConstant: 48).isActive = true
//        button.layer.cornerRadius = 8
//        button.backgroundColor = .systemBlue
//        button.setTitle(buttonTitle, for: .normal)
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 24.0)
//        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
//        button.addTarget(self, action: #selector(buttonHoldDown), for: .touchDown)
//        button.addTarget(self, action: #selector(buttonHoldRelease), for: .touchDragExit)
//        button.addTarget(self, action: #selector(buttonHoldReEnter), for: .touchDragEnter)
//
//        button.layer.shadowRadius = 6
//        button.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
//        button.layer.shadowOpacity = 0.8
//
//        return button
//    }
//
//    func createCoverButton(buttonTitle: String) -> UIButton {
//        let button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.heightAnchor.constraint(equalToConstant: 48).isActive = true
//        button.layer.cornerRadius = 8
//        button.backgroundColor = .clear
//        button.setTitle(buttonTitle, for: .normal)
//
//        button.isSelected = false
//        button.setTitleColor(.black, for: .normal)
//        button.layer.borderColor = UIColor.systemGray2.cgColor
//        button.layer.borderWidth = 2.0
//
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 18.0)
//
////        let title = button.title(for: .normal) ?? ""
////        let attributedTitle = NSAttributedString(string: title, attributes: [NSAttributedString.Key.kern: 1.0])
////        button.setAttributedTitle(attributedTitle, for: .normal)
//
//        button.addTarget(self, action: #selector(coverButtonAction), for: .touchUpInside)
//
//        return button
//    }
//
//    func createDropdown(items: [String]) -> DropDown{
//        let dropdown = DropDown()
//        dropdown.dataSource = items
//
//        dropdown.direction = .bottom
//        let buttonHeight = 48
//        dropdown.bottomOffset = CGPoint(x: 0, y: buttonHeight)
//        dropdown.selectRow(0)
//        return dropdown
//    }
//
//    //MARK: - Observer Methods
//    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//        if keyPath == "frame" && object as AnyObject? === self.notesTextView {
//            if(self.notesTextView.frame.height != savedTextViewHeight){
//                IQKeyboardManager.shared.reloadLayoutIfNeeded()
//                savedTextViewHeight = self.notesTextView.frame.height
//            }
//        }
//    }
//
//    deinit {
//        self.notesTextView.removeObserver(self, forKeyPath: "frame")
//    }
//
//    //MARK: - Text Field Methods
//    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true;
//    }
//
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//
//        //GuestTextField has an additonal subview, a stackView, before the superview UIView
//        if(textField === self.guestTextField){
//            textField.superview?.superview?.layer.borderColor = UIColor.systemBlue.cgColor
//            textField.superview?.superview?.layer.borderWidth = 2.0
//        }
//        else{
//            textField.superview?.layer.borderColor = UIColor.systemBlue.cgColor
//            textField.superview?.layer.borderWidth = 2.0
//        }
//
//    }
//
//    func textFieldDidEndEditing(_ textField: UITextField) {
//
//        //GuestTextField has an additonal subview, a stackView, before the superview UIView
//        if(textField === self.guestTextField){
//            textField.superview?.superview?.layer.borderWidth = 0.0
//        }
//        else{
//            textField.superview?.layer.borderWidth = 0.0
//        }
//
//        if(textField === self.nameTextField){
//            nameValidationMessageView.isHidden = true
//
//            if(!isValidEntry(entry: textField.text!, regex: "\\w+\\s\\w+.*") && textField.text!.count > 0){
//                textField.superview?.layer.borderColor = UIColor.systemRed.cgColor
//                textField.superview?.layer.borderWidth = 2.0
//                nameValidationMessageView.isHidden = false
//
//                for subview in nameValidationMessageView.subviews{
//                    if let textLabel = subview as? UILabel {
//                        textLabel.text = "Enter both first and last names"
//                    }
//                }
//                if(!isValidEntry(entry: textField.text!, regex: "\\w+.*") && textField.text!.count > 0){
//                    for subview in nameValidationMessageView.subviews{
//                        if let textLabel = subview as? UILabel {
//                            textLabel.text = "Enter a valid first name"
//                        }
//                    }
//                }
//            }
//        }
//        else if(textField === self.guestTextField){
//            guestValidationMessageView.isHidden = true
//
//            if(!isValidEntry(entry: textField.text!, regex: "\\d*")){
//                textField.superview?.layer.borderColor = UIColor.systemRed.cgColor
//                textField.superview?.layer.borderWidth = 2.0
//                guestValidationMessageView.isHidden = false
//                for subview in guestValidationMessageView.subviews{
//                    if let textLabel = subview as? UILabel {
//                        textLabel.text = "Enter a valid number"
//                    }
//                }
//            }
//        }
//    }
//
//    func isValidEntry(entry: String, regex: String) -> Bool {
//        let entryPredicate = NSPredicate(format:"SELF MATCHES %@", regex)
//        return entryPredicate.evaluate(with: entry)
//    }
//
//    //For guestTextFieldView to hide or show label if guestTextField text is empty or not
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        // Combine the textField text and the replacement text to
//        // create the updated text string
//        let currentText:String = textField.text!
//        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
//
//        for subview in textField.superview!.subviews{
//            if let placeholderLabel = subview as? UILabel {
//                placeholderLabel.isHidden = updatedText.isEmpty
//            }
//        }
//
//        return true
//    }
//
//    //MARK: - Text View Methods
//    func textViewDidBeginEditing(_ textView: UITextView) {
//        textView.layer.borderColor = UIColor.systemBlue.cgColor
//        textView.layer.borderWidth = 2.0
//        textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
//    }
//
//    func textViewDidEndEditing(_ textView: UITextView) {
//        textView.layer.borderWidth = 0.0
//    }
//
//    func textViewDidChange(_ textView: UITextView) {
//
//        if(textView.contentSize.height >= 118)
//        {
//            textView.translatesAutoresizingMaskIntoConstraints = true
//            textView.isScrollEnabled = true
//        }
//        else {
//            textView.translatesAutoresizingMaskIntoConstraints = false
//            textView.isScrollEnabled = false
//            textView.sizeToFit()
//        }
//
//    }
//
//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        if(text == "\n") {
//            textView.resignFirstResponder()
//            return false
//        }
//
//        // Combine the textView text and the replacement text to
//        // create the updated text string
//        let currentText:String = textView.text
//        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
//
//        //60.666  1 line
//        //89.333  2 lines
//        //118.0   3 lines
//        //146.666 4 lines
//
//        for subview in textView.subviews{
//            if let placeholderLabel = subview as? UILabel {
//                placeholderLabel.isHidden = true
//            }
//        }
//
//        // If updated text view will be empty, add the placeholder
//        // and set the cursor to the beginning of the text view
//        if updatedText.isEmpty {
//
//            for subview in textView.subviews{
//                if let placeholderLabel = subview as? UILabel {
//                    placeholderLabel.isHidden = false
//                }
//            }
//
//            textView.text = ""
//            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
//
//            //properly resizes textView when coming from isScrollEnabled = true ie. scrollable amount of lines then deleting all
//            textView.translatesAutoresizingMaskIntoConstraints = false
//            textView.isScrollEnabled = false
//            textView.sizeToFit()
//        }
//
//        // Else if the text view's placeholder is showing and the
//        // length of the replacement string is greater than 0, set
//        // the text color to black then set its text to the
//        // replacement string
//         else if textView.textColor == UIColor.lightGray && !text.isEmpty {
//            textView.textColor = UIColor.black
//            textView.text = text
//        }
//
//        // For every other case, the text should change with the usual
//        // behavior...
//        else {
//            return true
//        }
//
//        // ...otherwise return false since the updates have already
//        // been made
//        return false
//
//    }
//
//    //MARK: - Button Action Methods
//    @objc func buttonAction(sender: UIButton!) {
//
//        view.endEditing(true)
//
//        let generator = UINotificationFeedbackGenerator()
//        buttonValidationMessageView.isHidden = false
//
//        if(nameValidationMessageView.isHidden && guestValidationMessageView.isHidden && nameTextField.text!.count > 0){
//            //Force unwrap FirstViewController.selectedDateUnformatted because FirstViewController is root view controller so will load and set variable first.
//
//            //If doesn't already have selectedDate in EventDates
//            if(self.realm.objects(EventDate.self).filter("dateOfEvent == %@", FirstViewController.selectedDateUnformatted!).count == 0){
//                self.newEventDate = EventDate()
//                self.newEventDate!.dateOfEvent = FirstViewController.selectedDateUnformatted
//                self.saveEventDate(eventDate: self.newEventDate!)
//
//            } //Else then must already have selectedDate in EventDates
//            else{
//                self.newEventDate = self.realm.objects(EventDate.self).filter("dateOfEvent == %@", FirstViewController.selectedDateUnformatted!)[0]
//            }
//
//            do{
//                try self.realm.write{
//                    let newGuest = Guest()
//                    newGuest.name = nameTextField.text!.trimmingCharacters(in: .whitespaces)
//                    let guests = guestTextField.text!
//                    newGuest.additonalGuests = Int(guests) ?? 0
//                    newGuest.notes = notesTextView.text!
//                    newGuest.dateCreated = Date()
//                    self.newEventDate!.guests.append(newGuest)
//                }
//
//                generator.notificationOccurred(.success)
//
//                for subview in buttonValidationMessageView.subviews{
//                    if let textLabel = subview as? UILabel {
//                        textLabel.text = "Successfully added \(nameTextField.text!)"
//                        textLabel.textColor = .systemGreen
//                    }
//                    else if let imageView = subview as? UIImageView{
//                        imageView.image = successImage
//                        imageView.tintColor = .systemGreen
//                    }
//                }
//
//                sender.backgroundColor = .green
//
//                nameTextField.text = ""
//                guestTextField.text = ""
//                guestPrefixLabel.isHidden = true
//                //coverTextField.text = ""
//                for button in coverButtonView.subviews{
//                    if let button = button as? UIButton {
//                        button.isSelected = false
//                        button.setTitleColor(.black, for: .normal)
//                        button.layer.borderColor = UIColor.systemGray2.cgColor
//                    }
//                }
//                notesTextView.text = ""
//                for subview in notesTextView.subviews{
//                    if let placeholderLabel = subview as? UILabel {
//                        placeholderLabel.isHidden = false
//                    }
//                }
//                notesTextView.isScrollEnabled = false
//                notesTextView.translatesAutoresizingMaskIntoConstraints = false
//                notesTextView.sizeToFit()
//
//            } catch{
//                print("error saving new guest, \(error)")
//            }
//        } else{
//
//            if(nameTextField.text!.count == 0){
//                nameValidationMessageView.isHidden = false
//                for subview in nameValidationMessageView.subviews{
//                    if let textLabel = subview as? UILabel {
//                        textLabel.text = "Cannot leave name blank"
//                    }
//                }
//            }
//
//            generator.notificationOccurred(.error)
//
//            for subview in buttonValidationMessageView.subviews{
//                if let textLabel = subview as? UILabel {
//                    textLabel.text = "Failed to add guest"
//                    textLabel.textColor = .systemRed
//                }
//                else if let imageView = subview as? UIImageView{
//                    imageView.image = errorImage
//                    imageView.tintColor = .systemRed
//                }
//            }
//
//            sender.backgroundColor = .systemRed
//        }
//
//        sender.isEnabled = false
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
//
//            sender.alpha = 1
//            UIView.animate(withDuration: 0.5) {
//                sender.backgroundColor = .systemBlue
//            }
//            sender.isEnabled = true
//        }
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.75) {
//            let groupAnimation = self.createShadowGroupAnimation(sender: sender, duration: 0.5, opacityToValue: 0.8, heightOffsetToValue: 5.0, radiusToValue: 6.0)
//            sender.layer.add(groupAnimation, forKey: nil)
//
//            sender.layer.shadowRadius = 6
//            sender.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
//            sender.layer.shadowOpacity = 0.8
//        }
//
//    }
//
//    @objc func coverButtonAction(sender: UIButton!) {
//
////        sender.isSelected = !sender.isSelected
////        let generator = UISelectionFeedbackGenerator()
////
////        if(sender.isSelected){
////            sender.setTitleColor(.systemBlue, for: .normal)
////            sender.layer.borderColor = UIColor.systemBlue.cgColor
////            generator.selectionChanged()
////        } else{
////            sender.setTitleColor(.black, for: .normal)
////            sender.layer.borderColor = UIColor.systemGray2.cgColor
////        }
//
//        if(sender === self.coverButtonView.subviews[0]){
//            coverLeftHourDropdown.show()
//            coverLeftMinuteDropdown.show()
//        }
//        if(sender === self.coverButtonView.subviews[1]){
//            coverRightDropdown.show()
//        }
//    }
//
//    @objc func coverButtonHoldDown(sender:UIButton)
//    {
//        if(!sender.isSelected){
//            sender.layer.borderColor = UIColor.systemGray2.cgColor
//        }
//
//    }
//
//    @objc func coverButtonHoldRelease(sender:UIButton)
//    {
//        if(!sender.isSelected){
//            sender.layer.borderColor = cellBackgroundColour.cgColor
//        }
//
//    }
//
//    @objc func coverButtonHoldReEnter(sender:UIButton)
//    {
//        if(!sender.isSelected){
//            sender.layer.borderColor = UIColor.systemGray3.cgColor
//        }
//    }
//
//    @objc func buttonHoldDown(sender:UIButton)
//    {
//        print("hold down")
//
//        //https://paletton.com/#uid=13B0u0k++++qKZWAF+V+VAFZWqK
//        sender.backgroundColor = UIColor(red: 0, green: 86/255, blue: 182/255, alpha: 1.0)
//
//        let groupAnimation = createShadowGroupAnimation(sender: sender, duration: 0.05, opacityToValue: 1.0, heightOffsetToValue: 1.0, radiusToValue: 1.0)
//        sender.layer.add(groupAnimation, forKey: nil)
//
//        sender.layer.shadowRadius = 1
//        sender.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
//        sender.layer.shadowOpacity = 1
//    }
//
//    @objc func buttonHoldRelease(sender:UIButton)
//    {
//        print("hold release")
//
//        sender.backgroundColor = .systemBlue
//
//        let groupAnimation = createShadowGroupAnimation(sender: sender, duration: 0.25, opacityToValue: 0.8, heightOffsetToValue: 5.0, radiusToValue: 6.0)
//        sender.layer.add(groupAnimation, forKey: nil)
//
//        sender.layer.shadowRadius = 6
//        sender.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
//        sender.layer.shadowOpacity = 0.8
//    }
//
//    @objc func buttonHoldReEnter(sender:UIButton)
//    {
//        print("hold reneter")
//
//        sender.backgroundColor = UIColor(red: 0, green: 86/255, blue: 182/255, alpha: 1.0)
//
//        let groupAnimation = createShadowGroupAnimation(sender: sender, duration: 0.05, opacityToValue: 1.0, heightOffsetToValue: 1.0, radiusToValue: 1.0)
//        sender.layer.add(groupAnimation, forKey: nil)
//
//        sender.layer.shadowRadius = 1
//        sender.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
//        sender.layer.shadowOpacity = 1
//    }
//
//    func createShadowGroupAnimation(sender: UIButton, duration: CFTimeInterval, opacityToValue: Float, heightOffsetToValue: CGFloat, radiusToValue: CGFloat) -> CAAnimationGroup {
//
//        let groupAnimation = CAAnimationGroup()
//        groupAnimation.duration = duration
//
//        let shadowOpacityChange = CABasicAnimation(keyPath: "shadowOpacity")
//        shadowOpacityChange.fromValue = sender.layer.shadowOpacity
//        shadowOpacityChange.toValue = opacityToValue
//        let shadowOffsetChange = CABasicAnimation(keyPath: "shadowOffset")
//        shadowOffsetChange.fromValue = sender.layer.shadowOffset
//        shadowOffsetChange.toValue = CGSize(width: 0.0, height: heightOffsetToValue)
//        let shadowRadiusChange = CABasicAnimation(keyPath: "shadowRadius")
//        shadowRadiusChange.fromValue = sender.layer.shadowRadius
//        shadowRadiusChange.toValue = radiusToValue
//
//        groupAnimation.animations = [shadowOpacityChange, shadowRadiusChange, shadowOffsetChange]
//
//        return groupAnimation
//    }
//
//
//    func addDoneButtonOnNumpad(textField: UITextField) {
//
//        let keypadToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 35))
//        keypadToolbar.sizeToFit()
//
//        // add a done button to the numberpad
//        keypadToolbar.items=[
//            UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil),
//            UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: textField, action: #selector(UITextField.resignFirstResponder)),
//        ]
//
//        // add a toolbar with a done button above the number pad
//        textField.inputAccessoryView = keypadToolbar
//    }
//
//    //MARK: - Data Manipulation Methods
//
//    func saveEventDate(eventDate: EventDate){
//
//        do{
//            try realm.write{
//                realm.add(eventDate)
//            }
//        } catch{
//                print("Error saving eventDate \(error)")
//            }
//
//    }
//}
