//
//  ViewController.swift
//  MultiTrheds
//
//  Created by ihan carlos on 05/12/23.
//

import UIKit

class ViewController: UIViewController {
    
    private let myLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Carregando..."
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        fetchData()
    }
    
    private func setupUI() {
        view.addSubview(myLabel)
        
        NSLayoutConstraint.activate([
            myLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func fetchData() {
        DispatchQueue.global(qos: .background).async {
            // Simulação de operação demorada
            let data = self.loadData()
            
            DispatchQueue.main.async {
                // Atualização da interface na thread principal
                self.myLabel.text = data
            }
        }
    }
    
    private func loadData() -> String {
        // Simulação de operação demorada
        Thread.sleep(forTimeInterval: 2)
        return "Dados carregados com sucesso!"
    }
}
