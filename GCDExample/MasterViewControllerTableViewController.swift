import UIKit

class MasterViewControllerTableViewController: UITableViewController {
    let cellIdentifier = "master_cell_identifier"
    let controllerTitle = "Topics"
    let titles = ["Queues", "Sync v. Async", "Barrier", "Groups"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = controllerTitle
    }

    // MARK: - Table view delegates

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let title = titles[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = title
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier {
            // todo perform correct segueue
        }
    }
}
