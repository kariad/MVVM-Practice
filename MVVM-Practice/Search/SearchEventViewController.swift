import UIKit
import RxCocoa
import RxSwift
import PureLayout

class SearchEventViewController: UIViewController {
    let searchBar = UISearchBar(frame: .zero)
    let tableview = UITableView(frame: .zero, style: .grouped)
    let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    var events = [Event]()
    let eventCellIdentifier = "eventCell"
    
    var router: NavigationRouter
    var searchEventViewModel: SearchEventViewModel!
    
    var disposeBag = DisposeBag()
    
    init(router: NavigationRouter) {
        self.router = router
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.addSubviews()
        self.configureSubviews()
        self.addConstraints()
        
        self.addBindToViewModel()
    }
    
    func addSubviews() {
        self.view.addSubview(self.tableview)
        self.view.addSubview(self.activityIndicatorView)
    }
    
    func configureSubviews() {
        self.view.backgroundColor = .white
        self.navigationItem.titleView = self.searchBar
        self.searchBar.delegate = self
        self.searchBar.showsCancelButton = true
        self.tableview.dataSource = self
        self.tableview.delegate = self
        self.tableview.register(EventCell.self, forCellReuseIdentifier: self.eventCellIdentifier)
    }
    
    func addConstraints() {
        self.tableview.autoPinEdgesToSuperviewEdges()
        
        self.activityIndicatorView.autoAlignAxis(toSuperviewAxis: .vertical)
        self.activityIndicatorView.autoAlignAxis(toSuperviewAxis: .horizontal)
    }
    
    func addBindToViewModel() {
        self.searchEventViewModel = SearchEventViewModel(
            searchText: self.searchBar.rx.text.asDriver(),
            searchButtonTapped: self.searchBar.rx.searchButtonClicked.asDriver(),
            cancelButtonTapped: self.searchBar.rx.cancelButtonClicked.asDriver()
        )
        
        self.searchEventViewModel.searchText
            .asDriver()
            .drive(self.searchBar.rx.text)
            .disposed(by: self.disposeBag)
        
        self.searchEventViewModel.events
            .asDriver()
            .drive(onNext: { [unowned self] evnets in
                self.events = evnets
                self.tableview.reloadData()
            })
            .disposed(by: self.disposeBag)
        
        self.searchEventViewModel.isLoading
            .asDriver()
            .drive(self.activityIndicatorView.rx.isAnimating)
            .disposed(by: self.disposeBag)
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
