//
//  CalenderController.swift
//  Gank
//
//  Created by NuGelaLiee on 2018/7/2.
//

import UIKit
import FSCalendar

import RxCocoa
import RxSwift

protocol CalenderControllerDelegate: class {
    func selectCalender(to date: String)
}

class CalenderController: BaseViewController {
    
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var month: UILabel!
    @IBOutlet weak var year: UILabel!
    fileprivate var historyNSDateGroups: [Date] = []
    weak var delegate: CalenderControllerDelegate?
    fileprivate let gregorian = Calendar(identifier: .gregorian)

    var viewModel: historyViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.register(DIYCalendarCell.self, forCellReuseIdentifier: "DIYCalendarCell")
        calendar.dataSource = self
        calendar.allowsMultipleSelection = true
        calendar.delegate = self
        calendar.appearance.eventSelectionColor = UIColor.white
        calendar.appearance.eventOffset = CGPoint(x: 0, y: -7)
        calendar.today = nil // Hide the today circle
        //calendar.swipeToChooseGesture.isEnabled = true
        calendar.headerHeight = 0
        calendar.weekdayHeight = 0
        //calendar.calendarHeaderView
        let today = Date()
        year.text = today.year
        month.text = today.month?.toMonth()
        
        let scopeGesture = UIPanGestureRecognizer(target: calendar, action: #selector(calendar.handleScopeGesture(_:)));
        calendar.addGestureRecognizer(scopeGesture)
        
    }

    
    override func setupRxConfig() {
        viewModel = historyViewModel(dispose: disposeBag)
        viewModel.tableData.asObservable()
            .map {$0.map {$0.toDate()}.filterNil()}
            .subscribeNext { [weak self] (items) in
                guard let `self` = self else {return}
                items.forEach({ (date) in
                    self.calendar.select(date)
                })
                self.historyNSDateGroups = items
                self.calendar.setCurrentPage(Date(), animated: true)
                self.calendar.reloadData()
        }.disposed(by: disposeBag)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension CalenderController: FSCalendarDataSource {
    
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "DIYCalendarCell", for: date, at: position)
        return cell
    }
    
    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at position: FSCalendarMonthPosition) {
        self.configure(cell: cell, for: date, at: position)
    }
    
    func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
        if self.gregorian.isDateInToday(date) {
            return "今"
        }
        return nil
    }
    
}
extension CalenderController: FSCalendarDelegate {
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        let today = calendar.currentPage
        year.text = today.year
        month.text = today.month?.toMonth()
    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.calendar.frame.size.height = bounds.height
        //self.eventLabel.frame.origin.y = calendar.frame.maxY + 10
    }
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        return monthPosition == .current
    }
    
    func calendar(_ calendar: FSCalendar, shouldDeselect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        return monthPosition == .current
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        //self.configureVisibleCells()
        if historyNSDateGroups.contains(date) {
            guard let time = date.detailTime else {return}
            if let delegate = delegate {
                delegate.selectCalender(to: time)
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date) {
        if historyNSDateGroups.contains(date) {
            guard let time = date.detailTime else {return}
            if let delegate = delegate {
                delegate.selectCalender(to: time)
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
        if self.gregorian.isDateInToday(date) {
            return [UIColor.colorWith(r: 201, g: 141, b: 44)]
        }
        return [appearance.eventDefaultColor]
    }
}

extension CalenderController: FSCalendarDelegateAppearance {
    // MARK: - Private functions
    
    private func configureVisibleCells() {
        calendar.visibleCells().forEach { (cell) in
            let date = calendar.date(for: cell)
            let position = calendar.monthPosition(for: cell)
            self.configure(cell: cell, for: date!, at: position)
        }
    }
    
    private func configure(cell: FSCalendarCell, for date: Date, at position: FSCalendarMonthPosition) {
        
        guard let diyCell = cell as? DIYCalendarCell else {
            return
        }
        
        // Custom today circle
        diyCell.circleImageView.isHidden = !self.gregorian.isDateInToday(date)
        // Configure selection layer
        if position == .current {
            
            var selectionType = SelectionType.none
            
            if calendar.selectedDates.contains(date) {
//                let previousDate = self.gregorian.date(byAdding: .day, value: -1, to: date)!
//                let nextDate = self.gregorian.date(byAdding: .day, value: 1, to: date)!
//                if calendar.selectedDates.contains(date) {
//                    if calendar.selectedDates.contains(previousDate) && calendar.selectedDates.contains(nextDate) {
//                        selectionType = .middle
//                    }
//                    else if calendar.selectedDates.contains(previousDate) && calendar.selectedDates.contains(date) {
//                        selectionType = .rightBorder
//                    }
//                    else if calendar.selectedDates.contains(nextDate) {
//                        selectionType = .leftBorder
//                    }
//                    else {
//                        selectionType = .single
//                    }
//                }
                selectionType = .single
            }
            else {
                selectionType = .none
            }
            if selectionType == .none {
                diyCell.selectionLayer.isHidden = true
                return
            }
            diyCell.selectionLayer.isHidden = false
            diyCell.selectionType = selectionType
            
        } else {
            diyCell.circleImageView.isHidden = true
            diyCell.selectionLayer.isHidden = true
        }
    }
    
  
}


