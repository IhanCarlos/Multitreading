//
//  ViewController.swift
//  MultiTrheds
//
//  Created by ihan carlos on 05/12/23.
//

import UIKit

class ViewController: UIViewController {
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Aguardando resultados..."
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        fetchDataConcurrently()
    }
    
    private func setupUI() {
        view.addSubview(resultLabel)
        
        NSLayoutConstraint.activate([
            resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func fetchDataConcurrently() {
        let dispatchGroup = DispatchGroup()
        
        var resultData1: String?
        var resultData2: String?
        
        dispatchGroup.enter()
        fetchDataFromAPI1 { data in
            resultData1 = data
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        fetchDataFromAPI2 { data in
            resultData2 = data
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            // Ambos os conjuntos de dados foram carregados, atualize a interface
            let combinedResult = "\(resultData1 ?? "")\n\(resultData2 ?? "")"
            self.resultLabel.text = combinedResult
        }
    }
    
    private func fetchDataFromAPI1(completion: @escaping (String) -> Void) {
        DispatchQueue.global().async {
            // Simulação de operação demorada
            Thread.sleep(forTimeInterval: 3)
            let data = "Dados da API 1"
            completion(data)
        }
    }
    
    private func fetchDataFromAPI2(completion: @escaping (String) -> Void) {
        DispatchQueue.global().async {
            // Simulação de operação demorada
            Thread.sleep(forTimeInterval: 2)
            let data = "Dados da API 2"
            completion(data)
        }
    }
}
