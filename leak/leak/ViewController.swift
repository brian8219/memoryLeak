import UIKit

class FirstViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

class SecondViewController: UIViewController {
    
    var classA: ClassA? = ClassA()
    var classB: ClassB? = ClassB()
    var classA2: ClassA = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("arc of classA is \(CFGetRetainCount(classA))")
        classA?.strongReference = classB
        
        //unmark one of below to see difference
//        classB?.strongReference = classA
//        classB?.weekReference = classA
        classB?.unownedReference = classA
        //unmark one of above to see difference
        
        print("arc of classA is \(CFGetRetainCount(classA))")
        classA = nil
//        classB = nil // classA1 and C1 cannot deinitialized correctly
        print("strong reference of class B is \(classB?.strongReference)")
        print("week reference of class B is \(classB?.weekReference)")
        print("unownedReference reference of class B is \(classB?.unownedReference)")
        
//        classA2.action = {
//            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
//                print("controller won't deinit, and will excute doSomething()")
//                self.doSomething()
//            }
//        }
//
//        classA2.action = { [weak self] in
//            print("controller will deinit, and won't excute doSomething()")
//            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
//                self?.doSomething()
//            }
//        }
//
//        classA2.action = { [unowned self] in
//            print("controller will deinit, and will crash")
//            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
//                self.doSomething()
//            }
//        }
    }

    func doSomething() {
        print("do something in controller")
    }

    @IBAction func pop(sender: Any) {
        self.navigationController?.popViewController(animated: true)
        classA2.action?()
    }
    
    deinit {
        print("View Controller deinit")
    }
}

class ClassA {
    var strongReference: ClassB?
    var action: (() -> ())?
    init() {}

    deinit {
        print("Class A deinit")
    }
}

class ClassB {
    var strongReference: ClassA?
    weak var weekReference: ClassA?
    unowned var unownedReference: ClassA?
    
    init() {}
    
    deinit {
        print("Class B deinit")
    }
}
