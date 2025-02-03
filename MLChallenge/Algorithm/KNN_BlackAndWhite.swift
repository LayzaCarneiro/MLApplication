//
//  KNN_BlackAndWhite.swift
//  MLChallenge
//
//  Created by Layza Maria Rodrigues Carneiro on 03/02/25.
//

import MLX
import MLXLinalg
import MLXNN
import MLXRandom

func KNN_BlackAndWhite() {
    
    let train = MLXArray(
        converting: [
            [0.0],
            [0.1],
            [0.2],
            [0.3],
            [0.4],
            [0.6],
            [0.7],
            [0.8],
            [0.9],
            [1.0],
        ]
            .flatMap(\.self)
    )
        .reshaped([10, 1])
    
    let labels = ["Preto", "Branco"]
    
    let trainLabels = MLXArray(
        [
            0, 0, 0, 0, 0, 1, 1, 1, 1, 1,
        ]
    )
    
    let tests = [
        [0.4],
        [0.1],
        [0.8]
    ]
    
    for _test in tests {
        let test = MLXArray(converting: _test)
                
        let distances = norm(test - train, axes: [1])
                
        let k = 5
        
        let kNearestIndices = argSort(distances)[..<k]
        
        let kNearestLabels = trainLabels[kNearestIndices]
        
        let prediction = {
            let count = MLXArray.zeros([3])
            for label in kNearestLabels {
                count[label] = count[label] + 1
            }
            return count.argMax().item(Int.self)
        }()
        
        print("\(test) prediction: \(labels[prediction])")
    }
}
