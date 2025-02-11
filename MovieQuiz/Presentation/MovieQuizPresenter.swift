//
//  MovieQuizPresenter.swift
//  MovieQuiz
//
//  Created by Дмитрий Перчемиди on 11.02.2025.
//

import UIKit

final class MovieQuizPresenter {
    
    let questionsAmount: Int = 10
    private var currentQuestionIndex: Int = 0
    
    func isLastQuestion() -> Bool {
            currentQuestionIndex == questionsAmount - 1
        }
        
        func resetQuestionIndex() {
            currentQuestionIndex = 0
        }
        
        func switchToNextQuestion() {
            currentQuestionIndex += 1
        }
    
    func convert(model: QuizQuestion) -> QuizStepViewModel {
        let image = UIImage(data: model.imageName) ?? UIImage()
        let question = model.text
        let questionNumber: String =
        "\(currentQuestionIndex + 1)/\(questionsAmount)"
        
        return QuizStepViewModel(
            image: image, question: question, questionNumber: questionNumber)
    }
}
