//
//  WriteDiaryViewController.swift
//  05Diary
//
//  Created by Good geon Lee on 2022/06/14.
//

import UIKit

enum DiaryEditMode {
    case new
    case edit(IndexPath, Diary)
}

protocol WriteDiaryViewDelegate: AnyObject {
    func didSelectRegister(diary: Diary)
}

class WriteDiaryViewController: UIViewController {

    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var contentsTextView: UITextView!
    @IBOutlet var dateTextField: UITextField!
    
    private let datePicker = UIDatePicker()
    private var diaryDate: Date?
    weak var delegate: WriteDiaryViewDelegate?
    var diaryEditMode: DiaryEditMode = .new
    
    @IBOutlet var confirmButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.confirmButton.isEnabled = false
        self.configureContentsTextView()
        self.configureDateTextField()
        self.configureInputField()
        self.configureEditMode()
        
    }
    
    private func configureEditMode() {
        switch self.diaryEditMode {
        case let .edit(_, diary):
            self.titleTextField.text = diary.title
            self.contentsTextView.text = diary.contents
            self.dateTextField.text = dateToString(date: diary.date)
            self.diaryDate = diary.date
            self.confirmButton.title = "수정"
        default: break
        }
    }
    
    private func configureContentsTextView() {
        let borderColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        contentsTextView.layer.borderColor = borderColor.cgColor
        contentsTextView.layer.borderWidth = 0.5
        contentsTextView.layer.cornerRadius = 5.0
    }
    
    private func configureDateTextField() {
        self.datePicker.datePickerMode = .date
        self.datePicker.preferredDatePickerStyle = .wheels
        self.datePicker.addTarget(self, action: #selector(datePickerValueDidChange), for: .valueChanged)
        self.datePicker.locale = Locale(identifier: "ko_KR")
        self.dateTextField.inputView = self.datePicker
    }
    
    private func configureInputField() {
        contentsTextView.delegate = self
        titleTextField.addTarget(self, action: #selector(titleTextFieldDidChange(_:)), for: .editingChanged)
        dateTextField.addTarget(self, action: #selector(dateTextFieldDidChange(_:)), for: .editingChanged)
    }
    
    private func validateInputField() {
        confirmButton.isEnabled = !(titleTextField.text?.isEmpty ?? true) && !contentsTextView.text.isEmpty && !(dateTextField.text?.isEmpty ?? true)
    }
    
    @IBAction func tapConfirmButton(_ sender: UIBarButtonItem) {
        guard let title = self.titleTextField.text else { return }
        guard let contents = self.contentsTextView.text else { return }
        guard let date = self.diaryDate else { return }
        
        
        switch self.diaryEditMode {
        case .new:
            let diary = Diary(uuidString: UUID().uuidString, title: title, contents: contents, date: date, isStar: false)
            self.delegate?.didSelectRegister(diary: diary)
        case let .edit(indexPath, diary):
            let diary = Diary(uuidString: diary.uuidString, title: title, contents: contents, date: date, isStar: diary.isStar)
            NotificationCenter.default.post(name: NSNotification.Name("editDiary"),
                                            object: diary,
                                            userInfo: nil)
        }
        
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func datePickerValueDidChange(_ datePicker: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        self.diaryDate = datePicker.date
        dateTextField.text = formatter.string(from: datePicker.date)
        self.dateTextField.sendActions(for: .editingChanged)
    }
    
    @objc
    private func titleTextFieldDidChange(_ textField: UITextField) {
        self.validateInputField()
    }
    
    @objc
    private func dateTextFieldDidChange(_ textField: UITextField) {
        self.validateInputField()
    }
    
    private func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        
        return formatter.string(from: date)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension WriteDiaryViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        self.validateInputField()
    }
}
