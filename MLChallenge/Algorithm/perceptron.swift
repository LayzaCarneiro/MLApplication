//
//  perceptron.swift
//  MLChallenge
//
//  Created by Layza Maria Rodrigues Carneiro on 03/02/25.
//

import Foundation

class Perceptron {
    var W: [Double]
    var alpha: Double
    
    init(N: Int, alpha: Double = 0.1) {
        // Inicializa a matriz de pesos e armazena a taxa de aprendizado
        self.W = (0..<N + 1).map { _ in Double.random(in: -1.0..<1.0) / sqrt(Double(N)) }
        self.alpha = alpha
    }
    
    // Função de ativação (passo)
    func step(x: Double) -> Int {
        return x > 0 ? 1 : 0
    }
    
    // Função de treinamento
    func fit(X: [[Double]], y: [Int], epochs: Int = 10) {
        var X = X
        for i in 0..<X.count {
            X[i].append(1.0)  // Adiciona a coluna de 1's (bias)
        }
        
        // Laço sobre o número de épocas
        for _ in 0..<epochs {
            // Laço sobre cada ponto de dados
            for (x, target) in zip(X, y) {
                let dotProduct = zip(x, W).reduce(0.0) { $0 + $1.0 * $1.1 }  // Produto escalar
                let p = step(x: dotProduct)  // Predição
                
                // Atualiza os pesos se a predição não for igual ao alvo
                if p != target {
                    let error = p - target
                    for j in 0..<W.count {
                        W[j] -= alpha * Double(error) * x[j]
                    }
                }
            }
        }
    }
    
    // Função de predição
    func predict(X: [Double], addBias: Bool = true) -> Int {
        var X = X
        if addBias {
            X.append(1.0)  // Adiciona a coluna de 1's (bias)
        }
        
        let dotProduct = zip(X, W).reduce(0.0) { $0 + $1.0 * $1.1 }  // Produto escalar
        return step(x: dotProduct)
    }
}

func perceptron() {
    // Dataset OR
//    let X: [[Double]] = [[0, 0], [0, 1], [1, 0], [1, 1]]
//    let y: [Int] = [0, 1, 1, 1]
    
    // Dataset AND
    let X: [[Double]] = [[0, 0], [0, 1], [1, 0], [1, 1]]
    let y: [Int] = [0, 0, 0, 1]
    
    // Define o perceptron e o treina
    print("[INFO] training perceptron...")
    let p = Perceptron(N: X[0].count, alpha: 0.1)
    p.fit(X: X, y: y, epochs: 20)
    
    // Avalia o perceptron
    print("[INFO] testing perceptron...")
    for (x, target) in zip(X, y) {
        let pred = p.predict(X: x)
        print("[INFO] data=\(x), ground-truth=\(target), pred=\(pred)")
    }
}
