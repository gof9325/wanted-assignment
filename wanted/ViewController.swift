//
//  ViewController.swift
//  wanted
//

import UIKit

class ViewController: UIViewController {
    
    var stackView : UIStackView!
    var loadAllImagesButton: UIButton!
    
    var components: [Component] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setStackView()
    }
    
    func setStackView() {
        self.stackView = UIStackView()
        self.stackView.axis = .vertical
        self.stackView.alignment = .fill
        self.stackView.distribution = .fillProportionally
        self.stackView.spacing = 8
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.stackView)
        self.stackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 80).isActive = true
        self.stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 5).isActive = true
        self.view.trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor, constant: 5).isActive = true
        
        let urls = ["https://cdn.eyesmag.com/content/uploads/posts/2022/08/08/main-ad65ae47-5a50-456d-a41f-528b63071b7b.jpg", "https://i.pinimg.com/564x/0e/10/aa/0e10aad14befac6e513e4d57080a7928.jpg", "https://i.pinimg.com/564x/3f/00/58/3f0058f7321a44cece33df5102b62fc6.jpg", "https://i.pinimg.com/564x/18/97/52/18975206b3bb66b40047fdf048b22746.jpg", "https://i.pinimg.com/736x/2b/53/3b/2b533b53cb249b848612747882ca7a4e.jpg"]
        components = urls.map {
            Component.init($0)
        }
        for component in components {
            self.stackView.addArrangedSubview(component)
        }
        
        self.makeLoadAllImagesButton()
        
        self.stackView.addArrangedSubview(loadAllImagesButton)
    }
    
    func makeLoadAllImagesButton() {
        self.loadAllImagesButton = UIButton()
        
        self.loadAllImagesButton.setTitle("Load All Images", for: .normal)
        self.loadAllImagesButton.backgroundColor = .systemBlue
        self.loadAllImagesButton.layer.cornerRadius = 5
        
        self.loadAllImagesButton.addTarget(self, action: #selector(loadAllImages), for: .touchUpInside)
    }
    
    @objc func loadAllImages() {
        for component in components {
            component.loadImage()
        }
    }
    
    func makeComponent(_ urlString: String) -> UIStackView {
        let component = Component(urlString)
            
        component.translatesAutoresizingMaskIntoConstraints = false
        
        component.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        component.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        component.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        component.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        component.frame = CGRect(x: 0, y: 0, width: 0, height: 150)
        
        return component

    }
}

