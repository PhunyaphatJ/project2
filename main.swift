import Foundation;

//class
class Company{
    static var id = 0
    var employees = Store<Employee>()
    var countEmployee:Int{employees.count}

    func addEmployee(employee:Employee){
        employees.add(item: employee)
    }

    func search(id:Int)->Employee?{
        return employees.searchID(id: id)
    }

    func show(){
        employees.show()
    }
}


class Person{
    var name:String
    var age:Int?

    init(name:String,age:Int?){
        self.name = name
        self.age = age
    }
}


class Employee:Person{
    var id:Int
    var salary:Double
    var isManager:Bool

    init(name:String,age:Int?,salary:Double,isManager:Bool){
        Company.id += 1
        self.id = Company.id
        self.salary = salary
        self.isManager = isManager
        super.init(name: name, age: age)
    }


    convenience init(name:String,salary:Double){
        self.init(name:name,age:nil,salary:salary,isManager: false)
    }

    func show(){
        print("ID: \(id) name: \(name) age: \(age != nil ? "\(age!)" : "nil") salary: \(salary)")
    }
}

class Seller:Employee{
    let departmentID = 10
    var customers:[Customer] = []


    override init(name:String,age:Int?,salary:Double,isManager:Bool){
        super.init(name: name, age: age, salary: salary,isManager: isManager)
    }

}

class IT:Employee{
    let departmentID = 20

    override init(name:String,age:Int?,salary:Double,isManager:Bool){
        super.init(name: name, age: age, salary: salary, isManager: isManager)
    }
    
}

class Account:Employee{
    let departmentID = 30

    override init(name:String,age:Int?,salary:Double,isManager:Bool){
        super.init(name: name, age: age, salary: salary, isManager: isManager)
    }
}



class Customer:Person{
    static private var count = 0
    let cust_id:Int
    // var orders:[Orders] = []

    init(name:String,age:Int){
        Customer.count += 1
        cust_id = Customer.count
        super.init(name: name, age: age)
    }
    
}

class Order{
    static private var count = 0
    var order_id:Int
    var cust_id:Int
    var orderDetails:[(id:Int,name:String,quantity:Int,price:Double)] = []

    init(cust_id:Int){
        Order.count += 1
        self.order_id = Order.count
        self.cust_id = cust_id
    }

    func buy(item:(id:Int,name:String,quantity:Int,price:Double)){
        orderDetails.append(item)
    }
    
}

class Product{
    static private var count = 0
    let product_id:Int
    var name:String
    var quantity:Int
    var price:Double

    init(name:String,quantity:Int,price:Double){
        Product.count += 1
        self.product_id = Product.count
        self.name = name
        self.quantity = quantity
        self.price = price
    }

    func add(quantity:Int){
        if quantity < 0{
            return
        }
        self.quantity += quantity
    }

    func reduce(quantity:Int){
        if quantity < 0{
            return
        }
        self.quantity -= quantity
    }

}

//end class & struct

//data store
struct Store<T>{
    var items:[T] = []
    var count:Int {items.count}

    mutating func add(item:T){
        items.append(item)
    }
    
    // mutating func remove()->T{
    //     return items
    // }

    func show(){
        for item in items{
            if let product = item as? Product{
                print(product.name,product.quantity)
            }else if let order = item as? Order{
                print(order.cust_id)
            }else if let employee = item as? Employee{
                print(employee.id)
            }
        }
    }

    func searchID(id:Int)->T?{
        for item in items{
            if let product = item as? Product,product.product_id == id{
                return product as? T
            }else if let order = item as? Order,order.order_id == id{
                return order as? T
            }else if let employee = item as? Employee,employee.id == id{
                return employee as? T
            }
        }
        return nil
    }
   

}

//product
var products = Store<Product>()
products.add(item: Product(name:"product1",quantity:10,price:10))
products.add(item: Product(name: "product2", quantity: 20, price: 50))

//orders
var orders = Store<Order>()
// orders.add(item: ())



//company
let company = Company()
company.addEmployee(employee: Seller(name: "Seller Manger", age: 30, salary: 50000,isManager: true))
company.addEmployee(employee: Seller(name: "seller1", age: 30, salary: 25000,isManager: false))
company.show()

//end data store