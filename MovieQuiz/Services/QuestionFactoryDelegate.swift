//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by Дмитрий Перчемиди on 26.01.2025.
//

import Foundation
protocol QuestionFactoryDelegate: AnyObject {               // 1
    func didReceiveNextQuestion(question: QuizQuestion?)    // 2
} 
