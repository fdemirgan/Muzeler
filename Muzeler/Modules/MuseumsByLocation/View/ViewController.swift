//
//  ViewController.swift
//  Muzeler
//
//  Created by Ferhat on 21.02.2024.
//

import UIKit
class ViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    private var viewModel = ViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchMuseumList()
        viewModel.delegate = self
        RegisterCellManager.shared.registerCells(tableViewCell: MuseumTableViewCell.self, tableView: tableView)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == SegueIdentifier.MuseumDetailVC.rawValue else { return }
        if let museum = sender as? MuseumData {
            let destinationVC = segue.destination as! DetailViewController
            destinationVC.museum = museum
        }
    }
    @IBAction func museumsLocationTapped(_ sender: Any) {
        print("Listedeki müzelerin konumları gösterilecek.")
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.museums.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let museum = viewModel.museums[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MuseumTableViewCell.self)) as! MuseumTableViewCell
        cell.prepareCell(with: CellViewModel(museum: museum))
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let museum = viewModel.museums[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: SegueIdentifier.MuseumDetailVC.rawValue, sender: museum)
    }
}


extension ViewController: MuseumTableViewModelDelegate {
    func notify(_ notify: NotifyViewModel) {
        switch notify {
        case .reloadTableView:
            tableView.reloadData()
        case .error(let museumApiError):
            print(museumApiError)
        }
    }
}


