//
//  ViewController.swift
//  Netflix
//
//  Created by Saadet Şimşek on 07/05/2024.
//

import UIKit

class HomeViewController: UIViewController {
    
    let secrionTitles: [String] = ["Trending Movies","Trending TV", "Popular", "Upcoming Movies", "Top Rating"]

    private let homeFeedTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemMint
        view.addSubview(homeFeedTableView)
        
        homeFeedTableView.delegate = self
        homeFeedTableView.dataSource = self
        
        configureNavigationBar()
        
        let headerView = HeroHeaderUIView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: view.bounds.width,
                                              height: 450))
        homeFeedTableView.tableHeaderView = headerView
        
        fetchData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTableView.frame = view.frame
    }
    
    private func configureNavigationBar(){
        var image = UIImage(named: "netflixLogo")
        image = image?.withRenderingMode(.alwaysOriginal) //resmin değişmemesi için
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image,
                                                           style: .done,
                                                           target: self,
                                                           action: nil)
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"),
                            style: .done,
                            target: self,
                            action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"),
                            style: .done,
                            target: self,
                            action: nil)
        ]
        navigationController?.navigationBar.tintColor = .systemRed
    }
    
    private func fetchData(){
        APICaller.shared.getTrendingMovies { results in
            switch results {
            case .success(let movies):
                print(movies)
            case .failure(let failure):
                print(failure)
            }
        }
        
    
      /* APICaller.shared.getTrendingTvs { _ in
            <#code#>
        }
        
        APICaller.shared.getPopular { _ in
            <#code#>
        }
       */
    }



}
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return secrionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else{
            return
        }
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20,
                                         y: header.bounds.origin.y,
                                         width: 100,
                                         height: header.bounds.height)
        header.textLabel?.textColor = .black
        header.textLabel?.text = header.textLabel?.text?.lowercased().capitalizeFirstLetter()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return secrionTitles[section]
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) { //navigation bar if scroll, stick to do top
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
}

