//
//  ListOfQuizesViewController.swift
//  prvaZadacaIOS
//
//  Created by Borna Kovacevic on 15/05/2019.
//  Copyright © 2019 Borna Kovacevic. All rights reserved.
//

import UIKit

class ListOfQuizesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var refreshControl: UIRefreshControl!
    //var tableFooterView: ReviewsTableViewFooterView!
    
    let cellReuseIdentifier = "cellReuseIdentifier"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        bindViewModel()
        
        setupKeyboard()
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
        tableView.delegate = self
        //tableView.dataSource = self
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
        self.refresh()
    }
    
    @objc func refresh() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            //self.refreshControl.endRefreshing()
        }
    }
    
    
    /// Keyboard dio
    
    // Ovdje registriramo ovaj viewController kao observer na notifikacije imena keyboardWillShowNotification i keyboardWillHideNotification
    // Kada se dogode ti event-ovi u sustavi sustav ce ispaliti notifikaciju tog imena i svi registrirani observeri ce je primiti i izvrsiti kod koji su registrirali keyboardWillShow / keyboardWillHide funkcije
    func setupKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // Pozivi ovih funckcija dohvacaju visinu tipkovnice iz NSNotifikacije i mijenjaju property contentInset od UITableView-a gdje bottom property odgovara visini tipkovnice
    // contentInset property tipa UIEdgeInsets je zapravo property UIScrollView-a (kojeg nasljeduje UITableView) koji govori koliko je contentView scrollView-a odmaknut od rubova
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardHeight = getKeyboardHeight(notification: notification) {
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification){
        if let keyboardHeight = getKeyboardHeight(notification: notification) {
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
        }
    }
    
    // pomocna funckija koja iz NSNotification objekta izvlaci visinu tipkovnice
    func getKeyboardHeight(notification: NSNotification) -> CGFloat? {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            return keyboardHeight
        }
        return nil
    }
}

extension ListOfQuizesViewController: UITableViewDelegate {
    // metoda UITableView delegata koju UITableView zove kada zeli dobiti visinu celije za oderedeni indexPath
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    // metoda UITableView delegata koju UITableView zove kada zeli dobiti view za header jedne sekcije
    
    // metoda UITableView delegata koju UITableView zove kada zeli dobiti visinu view-a hedera jedne sekcije
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    // metoda UITableView delegata koju UITableView zove kada se dogodi tap na neku celiju na indexPath-u
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // ReviewsViewController ima ReviewsViewModel i iz njega dohvaca sve potrebne podatke, kada s jednog ViewControllera prelazimo na drugi ( bilo pushanjem na navigationController, presentanjem novog ViewControllera u ovaj ViewController) tada iz trenutnog viewModela (ReviewsViewModel) dohvacamo viewModel (SingleReviewViewModel) za iduci ViewCotnroller (SingleReviewViewController)
//        if let viewModel = viewModel.viewModel(atIndex: indexPath.row) {
//            let singleReviewViewController = SingleReviewViewController(viewModel: viewModel)
//            navigationController?.pushViewController(singleReviewViewController, animated: true)
//        }
    }
}

//extension ListOfQuizesViewController: UITableViewDataSource {
//
//    // Metoda UITableView dataSource-a koju UITableView zove da dobije UITableViewCell koji ce prikazati za odredeni indexPath
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
        // celije 'stvaramo' metodom dequeueReusableCell koja zapravo dohvaca prvu slobodnu celiju iz skupa celija koje UITableView ima stvoreno kod sebe
//        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! ReviewsTableViewCell
        
        // Ovdje pitamo viewModel da nam da 'model' objekt koji ce celija iskoristiti da se napuni podacima
        // Ovdje viewModel vraca objekt tipa ReviewCellModel koji sluzi tome da sadrzi podatke Review-a koji su dovolji ReviewsTableViewCell-u da se njima napuni
        // Ovdje mozemo, ako zelimo bit manje striktni dohvatiti i Review i njega poslati celiji da se napuni podacima
        // Takoder, recimo ako je celija kompliciranija, mozemo dohvatiti novi viewModel koji ce celija korisiti da se napuni podacima i za bilo sto drugo sto joj treba
//        if let review = viewModel.review(atIndex: indexPath.row) {
//            cell.setup(withReview: review)
        //}
        //return cell
//    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }

    // Metode dataSource-a koju UITableView zove da dobije broj redaka koje treba prikazati u tablici
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // pitamo viewModel za broj redaka koje treba prikazati, viewModel ima informaciju o modelu, viewModel je dataSoruce ovog viewControllera
//        return viewModel.numberOfReviews()
//    }
//}

// Primjer delegation protokola na nasem custom UIView-u ReviewsTableViewFooterView
//extension ReviewsViewController: TableViewFooterViewDelegate {
//    // Kada se dogodi stvaranje novog review-a u ReviewsTableViewFooterView, on ce to dojaviti svom delegatu (ovom viewControlleru) koji ce se onda dalje pobrinuti za stvaranje review-a
//    func reviewCreated(withText title: String, date: String, summary: String) {
//        // stvaranje review-a se naravno radi u viewModelu
//        viewModel.createReview(withText: title, date: date, summary: summary)
//        // Ovdje, nakon sto smo stvorili novi review, koji ce u konacnici dodati novi review u dataSoruce, mozemo pozvati tableView.reloadData() i tableView ce se osvjeziti novim podacima
//        // ali u ovom trenutku, nakon dodavanja review-a u dataSource, mozemo i 'rucno' dodati jos jedan redak u tablicu (buduci da dataSource u ovom trenutku i ima jedan objekt vise nego sto tableView ima redaka)
//        // Metoda insertRows prima i tip animacije dodavanja redaka, te na ovaj nacin recimo efektnije mozemo osvjeziti tablicu nakon dodavanja jednog retka
//        tableView.insertRows(at: [IndexPath(row: viewModel.numberOfReviews()-1, section: 0)], with: UITableView.RowAnimation.automatic)
//    }

//}
