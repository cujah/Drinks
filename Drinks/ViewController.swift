//
//  ViewController.swift
//  Drinks
//
//  Created by Илья on 28.03.2022.
//

import UIKit
import SnapKit


class ViewController: UIViewController {
    
    var drinks = Drinks()
    
    var leftConstraint: Int = 8
    var topConstraint:  Int = 8
    var rightConstraint: Int = 0
    var bottomConstraint: Int = 0
    let padding: Int = 8
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.async {
            self.drinks.getData {
                self.showTagCloud()
                self.showSearchBar()
            }
        }
    }
    
    
    private func showTagCloud() {
        
        let tagArea = UIScrollView()
        tagArea.bounces = true
        tagArea.contentSize = self.view.frame.size
        tagArea.showsVerticalScrollIndicator = false
//        tagArea.backgroundColor = .systemMint
        self.view.addSubview(tagArea)
        tagArea.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            
        }
        tagArea.layoutIfNeeded()
        let tagAreaWidth = Int(tagArea.frame.size.width)
        
        
        for drink in drinks.drinkArray {
            
            let tag = createButton(title: drink.strDrink)
            let tagWidth = Int(tag.frame.size.width)
            
            leftConstraint += tagWidth + padding
            rightConstraint = leftConstraint + Int(tag.bounds.size.width) + padding
            bottomConstraint = topConstraint + Int(tag.frame.size.height)
            
            if rightConstraint > tagAreaWidth - padding * 4 {
                leftConstraint = padding
                topConstraint = bottomConstraint + padding
            }
            tagArea.addSubview(tag)
        }
        
    }
    
    
    private func showSearchBar() {
        
        let searchBar = UITextField()
        searchBar.backgroundColor = .white
        searchBar.font = UIFont.boldSystemFont(ofSize: 13)
        searchBar.placeholder = "Cocktail name"
        searchBar.textAlignment = .center
        searchBar.borderStyle = .roundedRect
        
        searchBar.layer.shadowOpacity = 1
        searchBar.layer.shadowRadius = 10
        searchBar.layer.shadowOffset = CGSize.zero
        searchBar.layer.shadowColor = UIColor.gray.cgColor
        
        self.view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-150)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).inset(50)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).offset(-50)
        }
        
    }
    
    

    private func createButton(title: String) -> UIButton {
        let button = UIButton()
        button.frame = CGRect(x: leftConstraint, y: topConstraint, width: 100, height: 30)
        button.setTitle("    " + title + "    " , for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.clipsToBounds = true
        button.layer.cornerRadius = 7
        button.backgroundColor = .gray
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.isSelected = false
        button.sizeToFit()
        return button
    }

 
    @objc func buttonAction(_ sender: UIButton!) {
        
        let gradient = CAGradientLayer()
        gradient.name = "gradient"
        gradient.colors = [UIColor.systemRed.cgColor, UIColor.systemPurple.cgColor]
        gradient.frame = sender.bounds
        
        if sender.isSelected {
            guard let layers = sender.layer.sublayers else { return }
            for layer in layers {
                 if layer.name == "gradient" {
                      layer.removeFromSuperlayer()
                 }
             }
            sender.isSelected = false
        } else {
            sender.layer.insertSublayer(gradient, at: 0)
            sender.isSelected = true
        }
    }

    
}




























/*
 
 var leftConstraint = 8
 var rightConstraint = 15
 var topConstraint = 100
 let padding = 8

 for drink in drinks.drinkArray {
     
     let tagArea = UIView()
     tagArea.backgroundColor = .green
     view.addSubview(tagArea)
     tagArea.snp.makeConstraints { make in
         make.edges.equalTo(view.safeAreaLayoutGuide)
     }
     
     

     let label = UILabel()
     label.text = drink.strDrink
     label.textColor = .white
//            label.backgroundColor = .gray
     view.addSubview(label)

     label.snp.makeConstraints { make in
         make.leading.equalTo(leftConstraint)
         make.top.equalTo(topConstraint)
     }

     label.layoutIfNeeded()

     leftConstraint += Int(label.bounds.width) + padding
     rightConstraint = leftConstraint + Int(label.bounds.width) + padding

     
     
     if rightConstraint > Int(view.bounds.width) {
         topConstraint += 28
         leftConstraint = 8
     }



 }
 
 
 
 */
