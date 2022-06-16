//
//  DiaryDetailViewController.swift
//  05Diary
//
//  Created by Good geon Lee on 2022/06/14.
//

import UIKit

class DiaryDetailViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentsTextView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    var starButton: UIBarButtonItem?
        
    var diary: Diary?
    var indexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        NotificationCenter.default.addObserver(self, selector: #selector(starDiaryNotification(_:)), name: Notification.Name("starDiary"), object: nil)
    }
    
    private func configureView() {
        guard let diary = self.diary else { return }
        titleLabel.text = diary.title
        contentsTextView.text = diary.contents
        dateLabel.text = dateToString(date: diary.date)
        starButton = UIBarButtonItem(image: nil, style: .plain, target: self, action: #selector(tapStarButton))
        starButton?.image = diary.isStar ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        starButton?.tintColor = UIColor.orange
        self.navigationItem.rightBarButtonItem = starButton
    }
    
    private func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        
        return formatter.string(from: date)
    }
    
    @IBAction func tapEditButton(_ sender: UIButton) {
        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "WriteDiaryViewController") as? WriteDiaryViewController else { return }
        guard let indexPath = self.indexPath else { return }
        guard let diary = self.diary else { return }
        
        NotificationCenter.default.addObserver(self, selector: #selector(editDiaryNotification(_:)), name: Notification.Name("editDiary"), object: nil)
        viewController.diaryEditMode = .edit(indexPath, diary)
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc
    private func editDiaryNotification(_ notification: Notification) {
        guard let diary = notification.object as? Diary else { return }
        self.diary = diary
        self.configureView()
    }
    
    @objc private func starDiaryNotification(_ notification: Notification) {
        guard let starDiary = notification.object as? [String: Any] else { return }
        guard let isStar = starDiary["isStar"] as? Bool else { return }
        guard let uuidString = starDiary["uuidString"] as? String else { return }
        guard let diary = self.diary else { return }
        
        if diary.uuidString == uuidString {
            self.diary?.isStar = isStar
            self.configureView()
        }
    }
    
    
    @IBAction func tapDeleteButton(_ sender: UIButton) {
        guard let uuidString = self.diary?.uuidString else { return }
        NotificationCenter.default.post(name: Notification.Name("deleteDiary"), object: uuidString, userInfo: nil)
//        self.delegate?.didSelectDelete(indexPath: indexPath)
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func tapStarButton() {
        guard let isStar = self.diary?.isStar else { return }
        
        if isStar {
            self.starButton?.image = UIImage(systemName: "star")
        } else {
            self.starButton?.image = UIImage(systemName: "star.fill")
        }
        
        self.diary?.isStar = !isStar
        NotificationCenter.default.post(name: Notification.Name("starDiary"),
                                        object: [
                                            "diary": self.diary,
                                            "isStar": self.diary?.isStar ?? false,
                                            "uuidString": self.diary?.uuidString
                                        ],
                                        userInfo: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
