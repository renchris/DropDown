//
//  ThirdViewController.swift
//  tabBarApp
//
//  Created by default on 2020-05-22.
//  Copyright © 2020 Chris Ren. All rights reserved.
//


import UIKit

import DropDown

//note. for FirstViewController with the Calendar, when on a day, and it turns the next day on midnight, the blue fill white inner circle circle that indicates Today is selected, stays on the previous day. It only changes to the new day (the day after midnight) once the app is refreshed.
//Also, when dismiss/closing the app, and restarting it, it goes to the Today date (like kind of expected). Think I should improve it by making it the current date still if it was the previous day and there are entires. for when working on an event past midnight.

//need with drop down:
// 1.  have two drop for one button.  done
// 2.  both show when clicked.        can do, did
// 3.  allow click on either or       need to figure out how to make area outside of chosen dropdown clickable
//     when both are up
// 4.  dismiss when both dropdowns    need to figure out above
//     have a cell selected
// 5.  dismiss when area              need to figure out above
//     outside is clicked


class ViewController: UIViewController{
    
    //lazy var coverTextField = createTextField(labelTitle: "Fill in cover elgibility")
    var coverButtonView = UIStackView()
    lazy var coverLeftHourDropdown = createDropdown(items: ["10", "11", "12", "1", "2", "3"])
    lazy var coverLeftMinuteDropdown = createDropdown(items: ["00", "15", "30", "45"])
    lazy var coverRightDropdown = createDropdown(items: ["10", "11", "12", "1", "2", "3"])
    
    let cellBackgroundColour = UIColor(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, alpha: 1.0)
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        //Cover Field
        //let coverTextField = createTextField(labelTitle: "Fill in cover elgibility")
        //let coverTextFieldView = createLabelView(textField: coverTextField)
        
        let coverLeftButton = createCoverButton(buttonTitle: "NO COVER")
        let coverRighButton = createCoverButton(buttonTitle: "DISCOUNT")
        
        coverLeftHourDropdown.anchorView = coverLeftButton
        coverLeftMinuteDropdown.anchorView = coverLeftButton
        coverRightDropdown.anchorView = coverRighButton
        
        
        
        print("left button 0 width: \(coverLeftButton.frame.width)")
        

        coverLeftHourDropdown.willShowAction = {
            if let button = self.coverLeftHourDropdown.anchorView as? UIButton{
                print("left button A width: \(button.frame.width)")
                self.coverLeftHourDropdown.width = button.frame.width / 2
                self.coverLeftMinuteDropdown.bottomOffset = CGPoint(x: self.coverLeftHourDropdown.width!, y: self.coverLeftMinuteDropdown.bottomOffset.y)
                
            }
        }
        
        
        
        
        
//        coverLeftDropdown.willShowAction = {
//
//        }
        
        coverLeftHourDropdown.selectionAction = { (index, string) in
            print("Dropdown cell selected: \(index), \(string)")
            if(index == 0){
                if let button = self.coverLeftHourDropdown.anchorView as? UIButton {
                    print("zero (\(index) index selected")
                    button.isSelected = false
                    button.setTitleColor(.black, for: .normal)
                    button.layer.borderColor = UIColor.systemGray2.cgColor
                    print("left button 1 width: \(button.frame.width)")
                }
            }else{
                if let button = self.coverLeftHourDropdown.anchorView as? UIButton {
                    print("\(index) index selected")
                    button.isSelected = true
                    button.setTitleColor(.systemBlue, for: .normal)
                    button.layer.borderColor = UIColor.systemBlue.cgColor
                    print("left button 2 width: \(button.frame.size.width)")
                }
            }
            //print("left dropdown width: \(self.coverLeftDropdown.width)")
            
        }
        
        coverRightDropdown.selectionAction = { (index, string) in
            print("Dropdown cell selected: \(index), \(string)")
            if(index == 0){
                if let button = self.coverRightDropdown.anchorView as? UIButton {
                    print("zero (\(index) index selected")
                    button.isSelected = false
                    button.setTitleColor(.black, for: .normal)
                    button.layer.borderColor = UIColor.systemGray2.cgColor
                }
            }else{
                if let button = self.coverRightDropdown.anchorView as? UIButton {
                    print("\(index) index selected")
                    button.isSelected = true
                    button.setTitleColor(.systemBlue, for: .normal)
                    button.layer.borderColor = UIColor.systemBlue.cgColor
                }
            }
        }

    
        coverButtonView.axis  = NSLayoutConstraint.Axis.horizontal
        coverButtonView.distribution = UIStackView.Distribution.fillEqually
        coverButtonView.spacing = 8.0
        coverButtonView.addArrangedSubview(coverLeftButton)
        coverButtonView.addArrangedSubview(coverRighButton)
        
        
        let coverView = UIStackView()
        coverView.axis  = NSLayoutConstraint.Axis.vertical
        //coverView.addArrangedSubview(coverTextFieldView)
        coverView.addArrangedSubview(coverButtonView)
        
        
        
        //Stack View
        let stackView   = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing   = 16.0*2.5
        //makes center look off from top nav bar and button hm.

        stackView.addArrangedSubview(coverView)
    
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(stackView)
        //Constraints

        stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0).isActive = true
        //stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true //button and padding above and below
        coverView.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
    }

    
    //MARK: - View and Subview Creation Methods
    
    func createCoverButton(buttonTitle: String) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 48).isActive = true
        button.layer.cornerRadius = 8
        button.backgroundColor = .clear
        button.setTitle(buttonTitle, for: .normal)
        
        button.isSelected = false
        button.setTitleColor(.black, for: .normal)
        button.layer.borderColor = UIColor.systemGray2.cgColor
        button.layer.borderWidth = 2.0
        
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18.0)
        
//        let title = button.title(for: .normal) ?? ""
//        let attributedTitle = NSAttributedString(string: title, attributes: [NSAttributedString.Key.kern: 1.0])
//        button.setAttributedTitle(attributedTitle, for: .normal)
        
        button.addTarget(self, action: #selector(coverButtonAction), for: .touchUpInside)
        
        return button
    }
    
    func createDropdown(items: [String]) -> DropDown{
        let dropdown = DropDown()
        dropdown.dataSource = items
        
        dropdown.direction = .bottom
        let buttonHeight = 48
        dropdown.bottomOffset = CGPoint(x: 0, y: buttonHeight)
        dropdown.selectRow(0)
        return dropdown
    }
    
    @objc func coverButtonAction(sender: UIButton!) {
        
        if(sender === self.coverButtonView.subviews[0]){
            coverLeftHourDropdown.show()
            coverLeftMinuteDropdown.show()
        }
        if(sender === self.coverButtonView.subviews[1]){
            coverRightDropdown.show()
        }
    }
    
    @objc func coverButtonHoldDown(sender:UIButton)
    {
        if(!sender.isSelected){
            sender.layer.borderColor = UIColor.systemGray2.cgColor
        }
        
    }

    @objc func coverButtonHoldRelease(sender:UIButton)
    {
        if(!sender.isSelected){
            sender.layer.borderColor = cellBackgroundColour.cgColor
        }
        
    }
    
    @objc func coverButtonHoldReEnter(sender:UIButton)
    {
        if(!sender.isSelected){
            sender.layer.borderColor = UIColor.systemGray3.cgColor
        }
    }
}
