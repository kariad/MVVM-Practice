import UIKit
import RxCocoa
import RxSwift
import PureLayout

class SearchEventViewController: UIViewController {
    let searchBar = UISearchBar(frame: .zero)
    let tableview = UITableView(frame: .zero, style: .grouped)
    let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    var events = [ConnpassEvent]()
    let eventCellIdentifier = "eventCell"
    
    var router: Router
    var searchEventViewModel: SearchEventViewModelProtocol
    
    var disposeBag = DisposeBag()
    
    init(router: Router, searchEventViewModel: SearchEventViewModelProtocol) {
        self.router = router
        self.searchEventViewModel = searchEventViewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        addSubviews()
        configureSubviews()
        addConstraints()
        
        addBindToViewModel()
    }
    
    func addSubviews() {
        view.addSubview(tableview)
        view.addSubview(activityIndicatorView)
    }
    
    func configureSubviews() {
        self.view.backgroundColor = .white
        self.navigationItem.titleView = searchBar
        self.searchBar.delegate = self
        self.searchBar.showsCancelButton = true
        self.tableview.dataSource = self
        self.tableview.delegate = self
        self.tableview.register(EventCell.self, forCellReuseIdentifier: eventCellIdentifier)
    }
    
    func addConstraints() {
        tableview.autoPinEdgesToSuperviewEdges()
        
        activityIndicatorView.autoAlignAxis(toSuperviewAxis: .vertical)
        activityIndicatorView.autoAlignAxis(toSuperviewAxis: .horizontal)
    }
    
    fileprivate func addBindToViewModel() {
        searchEventViewModel.inject(
            searchText: searchBar.rx.text.asDriver(),
            tappedSearchButton: searchBar.rx.searchButtonClicked.asSignal(),
            cancelButtonTapped: searchBar.rx.cancelButtonClicked.asSignal()
        )

        searchEventViewModel.searchText
            .asDriver()
            .drive(searchBar.rx.text)
            .disposed(by: disposeBag)
        
        searchEventViewModel.events
            .asDriver()
            .drive(onNext: { [unowned self] evnets in
                self.events = evnets
                self.tableview.reloadData()
            })
            .disposed(by: disposeBag)
        
        searchEventViewModel.isLoading
            .asDriver()
            .drive(activityIndicatorView.rx.isAnimating)
            .disposed(by: disposeBag)
    }
}

extension SearchEventViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: self.eventCellIdentifier) as! EventCell
        cell.configureCell(self.events[indexPath.row])
        return cell
    }
}

extension SearchEventViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableview.deselectRow(at: indexPath, animated: true)
        self.router.displayEventDetailView(url: self.events[indexPath.row].eventUrl)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
}

extension SearchEventViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
