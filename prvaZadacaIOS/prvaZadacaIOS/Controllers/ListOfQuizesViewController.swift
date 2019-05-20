//
//  ListOfQuizesViewController.swift
//  prvaZadacaIOS
//
//  Created by Borna Kovacevic on 15/05/2019.
//  Copyright © 2019 Borna Kovacevic. All rights reserved.
//

import UIKit

class ListOfQuizesViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    var fetchedQuizzes: FetchedQuizzes!
    
    var quizzes = [Quiz]()
    
    let cellReuseIdentifier = "cellReuseIdentifier"
    override func viewDidLoad() {
        super.viewDidLoad()
        //if(fetchQuestions()){
        fetchQuestions(){
            self.refresh()
        }
        //updateTableView()
        setupTableView()
        bindViewModel()
        //}
        
        //setupKeyboard()
    }
    @objc func refresh() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            //self.refreshControl.endRefreshing()
        }
    }
    //var viewModel: ReviewsViewModel!
    
//    convenience init(viewModel: ReviewsViewModel) {
//        self.init()
//        self.viewModel = viewModel
//    }
//
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    func setupTableView() {
        tableView.backgroundColor = UIColor.lightGray
        //tableView.delegate = self
        //tableView.dataSource = self
        
        //tableView.dataSource = self
        tableView.delegate = self
        self.tableView.dataSource = self
        tableView.separatorStyle = .none
        
        // UIRefreshControl je jos jedna vrsta UIView-a koju za property moze imati UITableView.
        // Dodavanjem RefreshCotnrol na tableView, dodajemo pull-to-refresh opciju u tableView
        // Na refreshControl mozemo vezati target-action koji ce se izvrsiti kada korisnik napravi pull-to-refresh
        
        
//        refreshControl = UIRefreshControl()
//        refreshControl.addTarget(self, action: #selector(ListOfQuizesViewController.refresh), for: UIControl.Event.valueChanged)
//        tableView.refreshControl = refreshControl
//
        
        // Buduci da tableView reuse-a odreden skup UITableViewCell objekata za prikaz podataka, potrebno je registrirati tip podataka (razred ili nib) celija koje cemo
        // kasnije moci deque-ati (dohvatiti od tableViewa)
        tableView.register(UINib(nibName: "TableCellView", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
        
        // UITableView ima property tableFooterView u koji mozemo postaviti bilo koji UIView koji ce biti prikazan na dnu UITableView-a
        // Slicno mozemo postaviti i tableHeaderView
//        tableFooterView = ReviewsTableViewFooterView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 200))
//        // ReviewsTableViewFooterView objektu za delegata postavljamo ovaj viewController. Dolje ovaj viewController implementira protokol TableViewFooterViewDelegate
//        tableFooterView.delegate = self
//        tableView.tableFooterView = tableFooterView
    }
    
    func bindViewModel() {
        
        // Ovim pozivom metode fetchReviews, viewModela govorimo viewModelu da dohvati podatke sa servera i nakon dohvacanja refreshamo tableView
        //viewModel.fetchReviews {
//            self.refresh()
//        }
//
        
    }
    
    
    func fetchQuestions(completion: @escaping (() -> Void)){
        
        let urlString = "https://iosquiz.herokuapp.com/api/quizzes"
        let questionService = QuestionServices()
        
        questionService.fetchQuestion(urlString: urlString) { (quizzes) in
            self.fetchedQuizzes = quizzes
            var num = 0
            DispatchQueue.main.async {
                if let quizzes = quizzes {
                    
                    for object in quizzes.quiz{
                        num = num + object.questionList.filter{$0.question.contains("NBA")}.count
                        print(object.title)
                        
                    }
//                    if let colorCategory = CategoryColor(rawValue: quizzes.quiz[quizNumber].category) {
//                        print(colorCategory.description)
//                        self.quizTitle.backgroundColor = colorCategory.description
//                        self.quizImage.backgroundColor = colorCategory.description
//                    }
                    self.quizzes.append(quizzes.quiz[0])
                    self.quizzes.append(quizzes.quiz[1])
                    self.quizzes.append(quizzes.quiz[2])
                    
                    
                    //self.errorMessage.isHidden = true
                    
                }else{
//                    self.errorMessage.isHidden = false
//                    self.QuestionViewFrame.isHidden = true
//                    self.quizTitle.isHidden = true
//                    self.quizImage.isHidden = true
//                    errorOccured = true
//                    self.numberOfQuestions.text = "Fun fact"
                }
                //self.addCustomView()
            }
            completion()
        }
        
        
    }
    
}

extension ListOfQuizesViewController: UITableViewDelegate {
    // metoda UITableView delegata koju UITableView zove kada zeli dobiti visinu celije za oderedeni indexPath
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    // metoda UITableView delegata koju UITableView zove kada zeli dobiti view za header jedne sekcije
    
    
    // metoda UITableView delegata koju UITableView zove kada se dogodi tap na neku celiju na indexPath-u
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // ReviewsViewController ima ReviewsViewModel i iz njega dohvaca sve potrebne podatke, kada s jednog ViewControllera prelazimo na drugi ( bilo pushanjem na navigationController, presentanjem novog ViewControllera u ovaj ViewController) tada iz trenutnog viewModela (ReviewsViewModel) dohvacamo viewModel (SingleReviewViewModel) za iduci ViewCotnroller (SingleReviewViewController)
        
        
//        if let viewModel = viewModel.viewModel(atIndex: indexPath.row) {
//            let singleReviewViewController = SingleReviewViewController(viewModel: viewModel)
//            navigationController?.pushViewController(singleReviewViewController, animated: true)
//        }
        let viewModel = quizzes[indexPath.row]
        let secondViewController = FirstViewController(viewModel: viewModel)
            self.present(secondViewController, animated: true, completion: nil)
        
       
        
    }
}

extension ListOfQuizesViewController: UITableViewDataSource {
    
    // Metoda UITableView dataSource-a koju UITableView zove da dobije UITableViewCell koji ce prikazati za odredeni indexPath
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //fetchQuestions()
        // celije 'stvaramo' metodom dequeueReusableCell koja zapravo dohvaca prvu slobodnu celiju iz skupa celija koje UITableView ima stvoreno kod sebe
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! TableCellView
        
        // Ovdje pitamo viewModel da nam da 'model' objekt koji ce celija iskoristiti da se napuni podacima
        // Ovdje viewModel vraca objekt tipa ReviewCellModel koji sluzi tome da sadrzi podatke Review-a koji su dovolji ReviewsTableViewCell-u da se njima napuni
        // Ovdje mozemo, ako zelimo bit manje striktni dohvatiti i Review i njega poslati celiji da se napuni podacima
        // Takoder, recimo ako je celija kompliciranija, mozemo dohvatiti novi viewModel koji ce celija korisiti da se napuni podacima i za bilo sto drugo sto joj treba
        if quizzes.count>0{
            let quiz = quizzes[indexPath.row]
            cell.setup(withQuiz: quiz)
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Metode dataSource-a koju UITableView zove da dobije broj redaka koje treba prikazati u tablici
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // pitamo viewModel za broj redaka koje treba prikazati, viewModel ima informaciju o modelu, viewModel je dataSoruce ovog viewControllera
        //return viewModel.numberOfReviews()
        return 3
    }
}
