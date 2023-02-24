//
//  LoadButton.swift
//  wanted
//

import Foundation
import UIKit

class Component: UIStackView {
    var imageView: UIImageView!
    var progressBar: UIProgressView!
    
    var urlString: String?
    
    init(_ url: String) {
        super.init(frame: .zero)
        self.urlString = url
        configure()
        makeImageView()
        makeProgressBar()
        makeLoadButton()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeImageView() {
        imageView = UIImageView()
        
        imageView.image = UIImage(systemName: "photo")
        
        imageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 130).isActive = true
        
        self.addArrangedSubview(imageView)
    }
    
    func makeProgressBar() {
        progressBar = UIProgressView()
        
        progressBar.widthAnchor.constraint(equalToConstant: 160).isActive = true
        progressBar.progressViewStyle = .default
        progressBar.progress = 0.5
        
        self.addArrangedSubview(progressBar)
    }
    
    func makeLoadButton() {
        
        guard let urlString = self.urlString else { return }
        let loadButton = LoadButton(urlString)
        
        loadButton.addTarget(self, action: #selector(loadImage), for: .touchUpInside)
        
        self.addArrangedSubview(loadButton)
        
    }
    
    @objc func loadImage() {
        imageView.image = UIImage(systemName: "photo")
        request()
    }
    
    func request() {
        guard let hasUrl = urlString else { return }
        guard let url = URL(string: hasUrl) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        DispatchQueue.global().async { [weak self] in
            session.dataTask(with: request) { data, response, error in
                
                guard let hasData = data else { return }
                
                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(data: hasData)
                }
                
            }.resume()
            session.finishTasksAndInvalidate()
        }
    }
    
    private func configure() {
        self.axis = .horizontal
        self.alignment = .center
        self.distribution = .fillProportionally
        self.spacing = 5
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
}
