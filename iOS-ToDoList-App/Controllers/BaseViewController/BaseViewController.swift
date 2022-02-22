//
// Created by pavels.garklavs on 21/02/2022.
//

import UIKit

class BaseViewController: UIViewController {

    struct Constants {
        static let insetValue = 50
    }

    private var _titleTextField = UITextField()
    private var _descriptionTextView = UITextView()
    private var _completionButton = UIButton()
    var index: Int = 0

}

private extension BaseViewController {
    func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = UIColor(named: "tigerOrange")
    }

    func setupTitleTextField() {
        view.addSubview(_titleTextField)

        _titleTextField.delegate = self
        _titleTextField.borderStyle = .roundedRect
        _titleTextField.returnKeyType = .continue
        _titleTextField.placeholder = "Title"
        _titleTextField.backgroundColor = UIColor(named: "dairyCream")

        _titleTextField.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.right.left.equalToSuperview().inset(Constants.insetValue)
            make.top.equalToSuperview().offset(100)
        }
    }

    func setupDescriptionTextView() {
        view.addSubview(_descriptionTextView)

        _descriptionTextView.delegate = self
        _descriptionTextView.layer.cornerRadius = 3
        _descriptionTextView.returnKeyType = .done
        _descriptionTextView.backgroundColor = UIColor(named: "dairyCream")

        _descriptionTextView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.right.left.equalToSuperview().inset(Constants.insetValue)
            make.top.equalTo(_titleTextField.snp.bottom).offset(20)
        }
    }

    func setupCompletionButton() {
        view.addSubview(_completionButton)

        _completionButton.layer.cornerRadius = 3
        _completionButton.setTitleColor(.black, for: .normal)
        _completionButton.setTitleColor(.gray, for: .highlighted)
        _completionButton.backgroundColor = UIColor(named: "dairyCream")

        _completionButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.right.left.equalToSuperview().inset(100)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(Constants.insetValue)
            make.top.equalTo(_descriptionTextView.snp.bottom).offset(50)
        }
    }
}

extension BaseViewController {
    public var completionButton: UIButton {
        get { _completionButton }
        set { _completionButton = newValue }
    }

    public var titleTextField: UITextField {
        get { _titleTextField }
        set { _titleTextField = newValue }
    }

    public var descriptionTextView: UITextView {
        get { _descriptionTextView }
        set { _descriptionTextView = newValue }
    }

    func setupController() {
        view.backgroundColor = .white
        setupNavigationBar()
        setupTitleTextField()
        setupDescriptionTextView()
        setupCompletionButton()
    }

    func setNavigationTitle(title: String) {
        navigationItem.title = title
    }

    func setButtonTitle(title: String) {
        completionButton.setTitle(title, for: .normal)
    }
}

extension BaseViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""

        guard let stringRange = Range(range, in: currentText) else {
            return false
        }
        let updateText = currentText.replacingCharacters(in: stringRange, with: string)
        return updateText.count <= 24
    }
}

extension BaseViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        return numberOfChars <= 128
    }
}
