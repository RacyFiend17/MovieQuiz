//
//  StatisticServiceProtocol.swift
//  MovieQuiz
//
//  Created by Дмитрий Перчемиди on 31.01.2025.
//

import Foundation

protocol StatisticServiceProtocol {
    var gamesCount: Int { get }
    var bestGame: GameResult { get }
    var totalAccuracy: Double { get }
    func storeResult(correct count: Int, total amount: Int) 
}
