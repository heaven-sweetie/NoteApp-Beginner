
import UIKit

class NoteViewController: UIViewController {
    
    // MARK: - Data
    private var noteController: NoteController
    
    // MARK: - UI Layout
    private func layout() {
        view.backgroundColor = UIColor.white
        
        view.addSubview(textView)
        let constratins = [
            textView.leftAnchor.constraint(equalTo: view.leftAnchor),
            textView.topAnchor.constraint(equalTo: view.topAnchor),
            textView.rightAnchor.constraint(equalTo: view.rightAnchor),
            textView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ]
        view.addConstraints(constratins)
    }
    
    private var textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    // MARK: - Navigation
    private func configureNavigation() {
        title = "Note"
        
        let newButton = UIBarButtonItem(barButtonSystemItem: .add,
                                         target: self,
                                         action: #selector(didNewButton(_:)))
        navigationItem.leftBarButtonItem = newButton
        
        let listButton = UIBarButtonItem(barButtonSystemItem: .organize,
                                         target: self,
                                         action: #selector(didTapListButton(_:)))
        navigationItem.rightBarButtonItem = listButton
    }
    
    @objc private func didNewButton(_ sender: UIBarButtonItem) {
        noteController.saveNote(with: textView.text)
        
        textView.text = noteController.newNote().text
    }
    
    @objc private func didTapListButton(_ sender: UIBarButtonItem) {
        let listViewController = NoteListViewController(noteController: noteController)
        listViewController.delegate = self
        let navigationController = UINavigationController(rootViewController: listViewController)
        present(navigationController, animated: true)
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        layout()
        configureNavigation()
        
        textView.text = noteController.lastNoteOrNew.text
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        noteController.saveNote(with: textView.text)
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

extension NoteViewController: NoteListViewDelegate {
    
    func didPicked(note: Note) {
        textView.text = note.text
    }
    
}
