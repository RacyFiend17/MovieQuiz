//
//  StatisticsService.swift
//  MovieQuiz
//
//  Created by Дмитрий Перчемиди on 31.01.2025.
//

import Foundation

final class StatisticsService: StatisticServiceProtocol {
    private let questionAmount: Int = 10
    private enum Keys: String {
        case correct
        case bestGameDate
        case gamesCount
        case correctAmount
        case accuracy
    }
    
    private let storage: UserDefaults = .standard
    
    private var correctAnswers: Int {
        get {
            storage.integer(forKey: Keys.correctAmount.rawValue)
        }
        set {
            storage.set(newValue, forKey: Keys.correctAmount.rawValue)
        }
    }
    
    var gamesCount: Int {
        get {
            storage.integer(forKey: Keys.gamesCount.rawValue)
        }
        set {
            storage.set(newValue, forKey: Keys.gamesCount.rawValue)
        }
    }
    
    var bestGame: GameResult {
        get {
            let correct = storage.integer(forKey: Keys.correct.rawValue)
            let total = storage.integer(forKey: String(questionAmount))
            let date = storage.object(forKey: Keys.bestGameDate.rawValue) as? Date ?? Date()
            return GameResult(correct: correct, total: total, date: date)
        }
        set {
            storage.set(newValue.correct, forKey: Keys.correct.rawValue)
            storage.set(newValue.total, forKey: String(questionAmount))
            storage.set(newValue.date, forKey: Keys.bestGameDate.rawValue)
        }
    }
    
    var totalAccuracy: Double {
        get {
            if gamesCount != 0 {
                return Double(correctAnswers * 100) / (Double(gamesCount * questionAmount))
            }
            else {
                return 0.00
            }
        }
    }
    
    func storeResult(correct count: Int, total amount: Int) {
        let newGameResult = GameResult(correct: count, total: amount, date: Date())
        if newGameResult.isBetterThan(bestGame) {
            bestGame = newGameResult
        }
//        print(gamesCount)
//        print(correctAnswers)
        refreshStatistics(correct: count)
    }
    
    private func refreshStatistics(correct count: Int) {
        gamesCount += 1
        correctAnswers += count
    }
}
