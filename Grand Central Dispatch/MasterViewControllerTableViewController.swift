import UIKit

class MasterViewControllerTableViewController: UITableViewController {
    let cellIdentifier = "master_cell_identifier"
    let controllerTitle = "Topics"
    let titles = ["Queues", "Sync v. Async", "Barrier", "Groups"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = controllerTitle
        self.tableView.tableFooterView = UIView()
    }

    // MARK: - Table view delegates

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let title = titles[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            // Queues
            splitViewController?.showDetailViewController(QueuesViewController(), sender: nil)
            
        case 1:
            // Sync v. Async
            splitViewController?.showDetailViewController(SyncAsyncViewController(), sender: nil)
        case 2:
            // Barrier
            splitViewController?.showDetailViewController(BarrierViewController(), sender: nil)
        case 3:
            // Groups
            splitViewController?.showDetailViewController(GroupsViewController(), sender: nil)
        default:
            return
        }
    }
}
