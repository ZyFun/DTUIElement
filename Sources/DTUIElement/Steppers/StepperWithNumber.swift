//
//  StepperWithNumber.swift
//  UIElements
//
//  Created by Дмитрий Данилин on 06.05.2023.
//

import UIKit

/// Степпер со счетчиком между кнопок + и -
/// - Чтобы следить за изменеиями степпера, достаточно подписаться на уведомление об изменениях
///
/// ```
/// stepper.addTarget(
///     self,
///     action: #selector(stepperValueChanged), // @objc метод, который отработает после изменения значения
///     for: .valueChanged
/// )
/// ```
///
public final class StepperWithNumber: UIControl {
    //MARK: - Public properties
    
    /// Счетчик степпера
    public var currentValue = 1 {
        didSet {
            currentValue = currentValue > 0 ? currentValue : 0
            currentStepValueLabel.text = "\(currentValue)"
        }
    }
    
    //MARK: - Private properties
    
    private lazy var decreaseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.black, for: .normal)
        button.setTitle("-", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var increaseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private lazy var currentStepValueLabel: UILabel = {
        var label = UILabel()
        label.textColor = .black
        label.text = "\(currentValue)"
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 15, weight: UIFont.Weight.regular)
        return label
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    //MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func setupViews() {
        backgroundColor = .systemGray6
        layer.cornerRadius = 15
        
        addSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(decreaseButton)
        horizontalStackView.addArrangedSubview(currentStepValueLabel)
        horizontalStackView.addArrangedSubview(increaseButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            horizontalStackView.widthAnchor.constraint(equalToConstant: 90),
            horizontalStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            horizontalStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            horizontalStackView.topAnchor.constraint(equalTo: topAnchor),
            horizontalStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    //MARK: - Actions
    
    @objc private func buttonAction(_ sender: UIButton) {
        switch sender {
        case decreaseButton:
            currentValue -= 1
        case increaseButton:
            currentValue += 1
        default:
            break
        }
        sendActions(for: .valueChanged)
    }
}
