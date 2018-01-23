import UIKit

class Queues: UIView {
    let margin: CGFloat = 8.0
    
    /// MARK:- Views
    let title = UILabel()
    let topic1Header = UILabel()
    let topic1Description = UILabel()
    
    var contentWidth: CGFloat {
        return width - 2.0 * margin
    }
    
    // MARK:- Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK:- Private
    
    private func setup() {
        viewSetup()
        addSubviews()
    }
    
    private func viewSetup() {
        title.text = "Queues"
        
        topic1Header.text = "Serial and Concurrent Queues"
        
        topic1Description.numberOfLines = 0
        topic1Description.text = """
        There are 2 types of Queues: Serial and Concurrent. Serial queues execute tasks one at a time in the order that they are added.
        Concurrent queues start tasks in the order they are inserted, but doesn't wait for a task to finish before starting the next one.
        """
    }
    
    private func addSubviews() {
        addSubview(title)
        addSubview(topic1Header)
        addSubview(topic1Description)
    }
    
    /// MARK:- Layout
    override func layoutSubviews() {
        title.frame = CGRect(x: margin, y: 0, width: contentWidth, height: 30)
        topic1Header.frame = CGRect(x: margin, y: title.maxY, width: contentWidth, height: 30)
        topic1Description.frame = CGRect(x: margin, y: topic1Header.maxY, width: contentWidth, height: 100)
    }
}
