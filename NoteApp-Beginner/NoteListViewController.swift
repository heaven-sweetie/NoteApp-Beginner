import UIKit

protocol NoteListViewDelegate {
    func didPicked(note: Note)
}

class NoteListViewController: UIViewController {
    
    public var delegate: NoteListViewDelegate?
    private let noteController: NoteController
    
    // MARK: - Layout
    private func layout() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate(
            [tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
             tableView.topAnchor.constraint(equalTo: view.topAnchor),
             view.rightAnchor.constraint(equalTo: tableView.rightAnchor),
             view.bottomAnchor.constraint(equalTo: tableView.bottomAnchor)]
        )
    }
    
    // MARK: TableView
    private lazy var tableView: UITableView = {
       let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private let titleCellIdentifier = "TitleCell"
    private func configureTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: titleCellIdentifier)
    }
    
    // MARK: - Navigation
    private func configureNavigation() {
        title = "NoteList"
        
        let listButton = UIBarButtonItem(barButtonSystemItem: .cancel,
                                         target: self,
                                         action: #selector(didTapCancelButton(_:)))
        navigationItem.rightBarButtonItem = listButton
    }
    
    @objc func didTapCancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        configureNavigation()
        configureTableView()
    }
    
    // MARK: - Construction
    init(noteController: NoteController) {
        self.noteController = noteController
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension NoteListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteController.numberOfNotes
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: titleCellIdentifier, for: indexPath)
        cell.textLabel?.text = noteController.title(at: indexPath.row)
        return cell
    }
    
}

extension NoteListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note = noteController.pickNote(at: indexPath.row)
        delegate?.didPicked(note: note)
        dismiss(animated: true)
    }
}
