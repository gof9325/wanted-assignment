//
//  LoadButton.swift
//  wanted
//

import Foundation
import UIKit

class LoadButton: UIButton {
    
    var urlString: String?
    
    init(_ url: String){
        super.init(frame: .zero)
        self.urlString = url
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 10
        self.backgroundColor = .systemBlue
        self.setTitle("Load", for: .normal)
    }
    
    @objc func loadImage() {
        request()
    }
    
    func request() {
        guard let hasUrl = urlString else { return }
        guard let url = URL(string: hasUrl) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
                
        session.dataTask(with: request) { data, response, error in
            print("response : \(response.debugDescription)")
        }.resume()
        session.finishTasksAndInvalidate()

    }
    
}
