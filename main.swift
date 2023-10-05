import Foundation;

//class
class Company{
    var employees = Store<Employee>()
    var countEmployee:Int{employees.count}
    
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
    static private var count:Int = 0
    var id:Int
    var salary:Double

    init(name:String,age:Int?,salary:Double){
        Employee.count += 1
        self.id = Employee.count
        self.salary = salary
        super.init(name: name, age: age)
    }


    convenience init(name:String,salary:Double){
        self.init(name:name,age:nil,salary:salary)
    }

    func show(){
        print("ID: \(id) name: \(name) age: \(age != nil ? "\(age!)" : "nil") salary: \(salary)")
    }
}

// class Programmer:Employee{
//     static private var count:Int = 0 
    
// }

class Seller:Employee{

    var customers:[Customer] = []


    override init(name:String,age:Int?,salary:Double){
        super.init(name: name, age: age, salary: salary)
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

struct Order{
    static private var count = 0
    var order_id:Int
    var cust_id:Int
    var orderDetails:[(name:String,quantity:Int,price:Double)] = []
    
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
            }
        }
    }

    func searchID(id:Int)->T?{
        for item in items{
            if let product = item as? Product,product.product_id == id{
                return product as? T
            }else if let order = item as? Order,order.order_id == id{
                return order as? T
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

//end data store