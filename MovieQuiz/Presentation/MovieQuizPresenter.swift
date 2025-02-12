//
//  MovieQuizPresenter.swift
//  MovieQuiz
//
//  Created by Дмитрий Перчемиди on 11.02.2025.
//

import UIKit

final class MovieQuizPresenter {
    
    var currentQuestion: QuizQuestion?
    weak var viewController: MovieQuizViewController?
    private var correctAnswers = 0
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
    
    private func isCorrectAnswer(nameOfButtonClicked: String) -> Bool? {
        guard let currentQuestion = currentQuestion else { return nil }
        let isYesButton = nameOfButtonClicked == "yesButton"
        let isCorrect = currentQuestion.correctAnswer == isYesButton
        
        if isCorrect {
            correctAnswers += 1
        }
        
        return isCorrect
    }
    
    func noButtonClicked() {
        guard let isCorrect = isCorrectAnswer(nameOfButtonClicked: "noButton") else { return }
        viewController?.showAnswerResult(isCorrect: isCorrect)
    }
    
    func yesButtonClicked() {
        guard let isCorrect = isCorrectAnswer(nameOfButtonClicked: "yesButton") else {return}
        viewController?.showAnswerResult(isCorrect: isCorrect)
    }
}
