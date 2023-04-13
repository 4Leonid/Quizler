//
//  ViewController.swift
//  Quizler
//
//  Created by Леонид Турко on 11.04.2023.
//

import UIKit
import SwiftUI
import SnapKit

class QuizlerViewController: UIViewController {
  //  MARK: - Private Properties
  private var quizBrain = QuizBrain()
  
  private lazy var stackView: UIStackView = {
    let element = UIStackView()
    element.axis = .vertical
    element.distribution = .fillProportionally
    element.spacing = 10
    return element
  }()
  
  private lazy var questionLabel: UILabel = {
    let element = UILabel()
    element.text = "Question Text"
    element.numberOfLines = 0
    element.textAlignment = .center
    element.font = UIFont.boldSystemFont(ofSize: 30)
    element.textColor = .white
    return element
  }()
  
  private lazy var scoreLabel: UILabel = {
    let element = UILabel()
    element.text = "Score: "
    element.numberOfLines = 0
    element.textAlignment = .left
    element.font = UIFont.boldSystemFont(ofSize: 30)
    element.textColor = .white
    return element
  }()
  
  private lazy var firstButton: UIButton = {
    let element = UIButton(type: .system)
    element.setTitle("Choice 1", for: .normal)
    element.setBackgroundImage(UIImage(named: "Rectangle"), for: .normal)
    element.titleLabel?.font = UIFont.systemFont(ofSize: 25)
    element.tintColor = .white
    element.addTarget(self, action: #selector(answerButtonPressed), for: .touchUpInside)
    return element
  }()
  
  private lazy var secondButton: UIButton = {
    let element = UIButton(type: .system)
    element.setTitle("Choice 2", for: .normal)
    element.setBackgroundImage(UIImage(named: "Rectangle"), for: .normal)
    element.titleLabel?.font = UIFont.systemFont(ofSize: 25)
    element.tintColor = .white
    element.addTarget(self, action: #selector(answerButtonPressed), for: .touchUpInside)
    return element
  }()
  
  private lazy var thirdButton: UIButton = {
    let element = UIButton(type: .system)
    element.setTitle("Choice 3", for: .normal)
    element.setBackgroundImage(UIImage(named: "Rectangle"), for: .normal)
    element.titleLabel?.font = UIFont.systemFont(ofSize: 25)
    element.tintColor = .white
    element.addTarget(self, action: #selector(answerButtonPressed), for: .touchUpInside)
    return element
  }()
  
  private lazy var backgroundImage: UIImageView = {
    let element = UIImageView()
    element.image = UIImage(named: "Background-Bubbles")
    element.contentMode = .scaleAspectFill
    return element
  }()
  
  private lazy var progressView: UIProgressView = {
    let element = UIProgressView()
    element.progress = 0.1
    element.progressTintColor = #colorLiteral(red: 0.9220053554, green: 0.4237217307, blue: 0.6071870327, alpha: 1)
    element.trackTintColor = .white
    return element
  }()

  //  MARK: - Override Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    setViews()
    setConstraints()
    updateUI()
  }
  
  @objc private func answerButtonPressed(_ sender: UIButton) {
    guard let userAnswer = sender.currentTitle else { return }
    let userCorrect = quizBrain.checkAnswer(userAnswer)
    
    if userCorrect {
      sender.backgroundColor = .green
    } else {
      sender.backgroundColor = .red
    }
    
    quizBrain.nexQuestion()
    
    Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
  }
  
  @objc private func updateUI() {
    questionLabel.text = quizBrain.getQuestionText()
    progressView.progress = quizBrain.getProgress()
    scoreLabel.text = "Score: \(quizBrain.getScore())"
    setButtons(firstButton, secondButton, thirdButton)
    clearButtons(firstButton, secondButton, thirdButton)
  }
}

//  MARK: -  Private Methods
extension QuizlerViewController {
  
  private func setButtons(_ buttons: UIButton...) {
    let numbers = [0, 1, 2]
    for (button, number) in zip(buttons, numbers) {
      button.setTitle(quizBrain.getAnswerText()[number], for: .normal)
    }
  }
  
  private func clearButtons(_ buttons: UIButton...) {
    buttons.forEach {
      $0.backgroundColor = .clear
    }
  }
  
  private func setViews() {
    view.backgroundColor = #colorLiteral(red: 0.1902135015, green: 0.2324904501, blue: 0.3610794246, alpha: 1)
    view.addSubview(stackView)
    view.addSubview(backgroundImage)
    stackView.addArrangedSubview(scoreLabel)
    stackView.addArrangedSubview(questionLabel)
    stackView.addArrangedSubview(firstButton)
    stackView.addArrangedSubview(secondButton)
    stackView.addArrangedSubview(thirdButton)
    stackView.addArrangedSubview(progressView)
  }
  
  private func setConstraints() {
    backgroundImage.snp.makeConstraints { make in
      make.bottom.leading.trailing.equalToSuperview()
      make.height.equalTo(102)
    }
    
    stackView.snp.makeConstraints { make in
      make.leading.trailing.equalTo(view.layoutMarginsGuide)
      make.top.bottom.equalTo(view.safeAreaLayoutGuide)
    }
    
    firstButton.snp.makeConstraints { make in
      make.height.equalTo(80)
    }
    
    secondButton.snp.makeConstraints { make in
      make.height.equalTo(firstButton.snp.height)
    }
    
    thirdButton.snp.makeConstraints { make in
      make.height.equalTo(firstButton.snp.height)
    }
    
    progressView.snp.makeConstraints { make in
      make.height.equalTo(10)
    }
  }
}

//  MARK: - Show Canvas
struct ContentViewController: UIViewControllerRepresentable {
  
  typealias UIViewControllerType = QuizlerViewController
  
  func makeUIViewController(context: Context) -> UIViewControllerType {
    return QuizlerViewController()
  }
  
  func updateUIViewController(_ uiViewController: QuizlerViewController, context: Context) {}
}

struct ContentViewController_Previews: PreviewProvider {
  static var previews: some View {
    ContentViewController()
      .edgesIgnoringSafeArea(.all)
      .colorScheme(.light) // or .dark
  }
}
