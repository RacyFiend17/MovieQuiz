//
//  MovieQuizPresenter.swift
//  MovieQuiz
//
//  Created by Дмитрий Перчемиди on 11.02.2025.
//

import UIKit

protocol MovieQuizViewControllerProtocol: AnyObject {
    func show(quiz step: QuizStepViewModel)
    func showResults(quiz result: QuizResultsViewModel)
    
    func highlightImageBorder(isCorrectAnswer: Bool)
    
    func showLoadingIndicator()
    func hideLoadingIndicator()
    
    func showNetworkError(message: String)
} 

final class MovieQuizPresenter: QuestionFactoryDelegate  {
    
    private var statisticService: StatisticServiceProtocol!
    private var questionFactory: QuestionFactoryProtocol?
    weak var viewController: MovieQuizViewController?
    var currentQuestion: QuizQuestion?
    private var correctAnswers = 0
    let questionsAmount: Int = 10
    private var currentQuestionIndex: Int = 0
    
    init(viewController: MovieQuizViewControllerProtocol) {
        self.viewController = viewController as? MovieQuizViewController
        
        statisticService = StatisticsService()
        
        questionFactory = QuestionFactory(moviesLoader: MoviesLoader(), delegate: self)
        questionFactory?.loadData()
        viewController.showLoadingIndicator()
    }
    
    func makeResultsMessage() -> String {
        statisticService.storeResult(correct: correctAnswers, total: questionsAmount)
        
        let bestGame = statisticService.bestGame
        
        let totalPlaysCountLine = "Количество сыгранных квизов: \(statisticService.gamesCount)"
        let currentGameResultLine = "Ваш результат: \(correctAnswers)\\\(questionsAmount)"
        let bestGameInfoLine = "Рекорд: \(bestGame.correct)\\\(bestGame.total)"
        + " (\(bestGame.date.dateTimeString))"
        let averageAccuracyLine = "Средняя точность: \(String(format: "%.2f", statisticService.totalAccuracy))%"
        
        let resultMessage = [
            currentGameResultLine, totalPlaysCountLine, bestGameInfoLine, averageAccuracyLine
        ].joined(separator: "\n")
        
        return resultMessage
    }
    
    func didLoadDataFromServer() {
        viewController?.hideLoadingIndicator()
        questionFactory?.requestNextQuestion()
    }
    
    func didFailToLoadData(with error: any Error) {
        let message = error.localizedDescription
        viewController?.showNetworkError(message: message)
    }
    
    func isLastQuestion() -> Bool {
        currentQuestionIndex == questionsAmount - 1
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
        proceedWithAnswer(isCorrect: isCorrect)
    }
    
    func yesButtonClicked() {
        guard let isCorrect = isCorrectAnswer(nameOfButtonClicked: "yesButton") else {return}
        proceedWithAnswer(isCorrect: isCorrect)
    }
    
    func didReceiveNextQuestion(question: QuizQuestion?) {
        guard let question = question else {
            return
        }
        
        currentQuestion = question
        let viewModel = convert(model: question)
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.show(quiz: viewModel)
        }
    }
    
    func proceedToNextQuestionOrResults() {
        if self.isLastQuestion() {
            let statisticsService: StatisticServiceProtocol = StatisticsService()
            statisticsService.storeResult(correct: correctAnswers, total: self.questionsAmount)
            
            let text = """
                Ваш результат: \(correctAnswers)/10
                Количество сыгранных квизов: \(statisticsService.gamesCount)
                Рекорд: \(statisticsService.bestGame.correct)/\(statisticsService.bestGame.total) \(statisticsService.bestGame.date.dateTimeString)
                Средняя точность: \(String(format: "%.2f", statisticsService.totalAccuracy))%
                """
            
            
            let viewResults = QuizResultsViewModel(
                title: "Этот раунд окончен!", text: text,
                buttonText: "Сыграть ещё раз")
            viewController?.showResults(quiz: viewResults)
        } else {
            self.switchToNextQuestion()
            questionFactory?.requestNextQuestion()
            
        }
    }
    
    func makeAndPresentAlertWithResults(result: QuizResultsViewModel) {
        let alertModel = AlertModel(title: result.title, message: result.text, buttonText: result.buttonText) { [weak self] in
            guard let self = self else { return }
            restartGame()
            self.viewController?.setImageBorderToZero()
        }
        let alertPresenter = AlertPresenter()
        let alert = alertPresenter.presentAlert(model: alertModel)
        
        self.viewController?.present(alert, animated: true, completion: nil)
    }
    
    func restartGame() {
        correctAnswers = 0
        questionFactory?.requestNextQuestion()
        currentQuestionIndex = 0
    }
    
    func makeAndPresentNetworkError(message: String) {
        let alertModel = AlertModel(title: "Ошибка", message: message, buttonText: "Попробовать еще раз") { [weak self] in
            guard let self = self else { return }
            restartGame()
            //    self.imageView.layer.borderWidth = 0
        }
        let alertPresenter = AlertPresenter()
        let alert = alertPresenter.presentAlert(model: alertModel)
        
        self.viewController?.present(alert, animated: true, completion: nil)
    }
    
    func proceedWithAnswer(isCorrect: Bool) {
        viewController?.enableButtons()
        viewController?.highlightImageBorder(isCorrectAnswer: isCorrect)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in                                                                  guard let self else { return }
            proceedToNextQuestionOrResults()
        }
    }
    
}
