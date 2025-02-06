//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by Дмитрий Перчемиди on 26.01.2025.
//

import Foundation
protocol QuestionFactoryDelegate {
    func didReceiveNextQuestion(question: QuizQuestion?)
    func didLoadDataFromServer() 
    func didFailToLoadData(with error: Error)
}
