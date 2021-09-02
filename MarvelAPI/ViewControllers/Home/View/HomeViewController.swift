//
//  ViewController.swift
//  MarvelAPI
//
//  Created by German Huerta on 27/08/21.
//

import UIKit

final class HomeViewController: BaseViewController {
// MARK: - Private
    private let headerHeight:CGFloat = 80.0
    private let transition = CircularTransition()
    private var cellPoisition = CGPoint.zero
    private var vm:TableContentProtocol!

    @IBOutlet weak private var headerView: HeaderView!
    @IBOutlet weak private var headerImage: UIImageView!
    @IBOutlet weak private var headerHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var tableView: UITableView!
    
// MARK: - Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.headerImage.image = UIImage(named: self.vm.getHeaderImage())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showLoadingIndicator()
    }
    
}
// MARK: - Config
extension HomeViewController {
    func config(withVM vm:TableContentProtocol ) {
        self.vm = vm
        self.configBindings()
        vm.getItems(offset: 0)
    }
    
    private func configBindings() {
        vm.reloadDataIfNeeded { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.hideLoadingIndicator()
            }
        }
        
        vm.errorHandler { [weak self] error in
            self?.hideLoadingIndicator()
            self?.showErrorDialog(error: error)
        }
        
        self.vm.selectionHandler {[weak self]  index in
            self?.selectedItem(index: index)
        }
    }
}

// MARK: - TableView Deletegate
extension HomeViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yOffset = scrollView.contentOffset.y
        print("y offset:\(yOffset) current height:\(self.headerHeightConstraint.constant)")
        if scrollView.contentOffset.y < 0 && self.headerHeightConstraint.constant < 160 {
            self.headerHeightConstraint.constant += abs(scrollView.contentOffset.y)
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if self.headerHeightConstraint.constant > headerHeight {
            animateHeader()
        }
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if self.headerHeightConstraint.constant > headerHeight {
            animateHeader()
        }
    }
    
    private func animateHeader() {
        self.headerHeightConstraint.constant = headerHeight
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options:[.curveEaseOut], animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.getCount()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellRect = tableView.rectForRow(at: indexPath)
        let yPosition = cellRect.origin.y + (cellRect.size.height / 2.0)
        let xPosition = cellRect.size.width / 2.0
        self.cellPoisition = CGPoint(x: xPosition, y: yPosition)
        tableView.deselectRow(at: indexPath, animated: false)
        self.vm.itemSelected(atIndex: indexPath.row)
    }
    
    func selectedItem(index:Int) {
        guard let detailVC = self.storyboard?.instantiateViewController(identifier: "DetailsViewController") as? DetailsViewController else {
            return
        }
        let vm = self.vm.getItemVM(at: index)
        detailVC.modalPresentationStyle = .popover
        detailVC.transitioningDelegate = self
        detailVC.modalPresentationStyle = .custom
        detailVC.config(withVM: vm)
        self.present(detailVC, animated: true, completion: nil)
    }
    
}

// MARK: - TableView DataSource
extension HomeViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ComicTableViewCell.cellID) as? ComicTableViewCell  ?? ComicTableViewCell(style: .default, reuseIdentifier: ComicTableViewCell.cellID)
        let cellVM = vm.getItemVM(at: indexPath.row)
        cell.config(with: cellVM)
        if indexPath.row == (self.vm.getCount() - 1) {
            self.loadMore()
        }
        return cell
    }
}

// MARK: - Load more items
extension HomeViewController {
    private func loadMore() {
        let currentCount = self.vm.getCount() + 1
        self.vm.getItems(offset: currentCount)
    }
}

// MARK: - Transitioning Delegate
extension HomeViewController:UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = self.view.center //self.cellPoisition
        transition.circleColor = .clear
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = self.view.center // self.cellPoisition
        transition.circleColor = .clear
        
        return transition
    }
}
