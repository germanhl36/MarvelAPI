//
//  ViewController.swift
//  MarvelAPI
//
//  Created by German Huerta on 27/08/21.
//

import UIKit

final class HomeViewController: BaseViewController {
    // MARK - Private
    
    @IBOutlet weak var headerView: HeaderView!
    
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!
    
   private var vm:TableContentProtocol!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.headerImage.image = self.vm.getHeaderImage()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showLoadingIndicator()
    }

}

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
        
    }
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.getCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ComicTableViewCell.cellID) as? ComicTableViewCell  ?? ComicTableViewCell(style: .default, reuseIdentifier: ComicTableViewCell.cellID)
        let cellVM = vm.getCellVM(at: indexPath.row)
        cell.config(with: cellVM)
        if indexPath.row == (self.vm.getCount() - 1) {
            self.loadMore()
        }
        return cell
    }
}

extension HomeViewController {
    private func loadMore() {
        let currentCount = self.vm.getCount() + 1
        self.vm.getItems(offset: currentCount)
    }
}


extension HomeViewController {
    private func showErrorDialog(error:Error) {
        let alert = UIAlertController(title: "Marvel", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
