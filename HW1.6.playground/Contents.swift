import UIKit

//: # Home Work 6

/*:
 ## Задание 1
 1.1 Создайте класс `Orange` со следующими свойствами:
 
 - `color: String`
 
 - `taste: String`
 
 - `radius: Double`
 
 Необходимо реализовать возможность создания экземпляра класса со значенями по умолчанию для свойств *color* и *taste*. Свойство *radius* должно быть обязательным для инициализации, т.е. не должно быть возможности создания экземпляра класса без радиуса.
 
 Объявите геттер *orangeVolume*, возвращающий объем апельсина. При этом расчет объема необходимо реализовать в методе *calculateOrangeVolume* (число Пи в Swift можно получить через константу `Double.pi`. Формулу расчета можно погуглить).
 
 Создайте экземпляр класса `Orange`, вызвав при этом инициализатор только для радиуса. Остальным свойствам, созданного экземпляра присвойте следующие значения:
 
 - `color` — *Orange*

 - `taste` — *Sweet*
 
 Выведите на консоль сообщение: «Orange has <...> color and <...> taste. The volume of orange is <...>», обращаясь к этим значениям через экземпляр класса.
 */
class Orange {
    let color: String
    let taste: String
    let radius: Double
    
    private var volume = 0.0
    
    init(
        color: String = "Orange",
        taste: String = "Sweet",
        radius: Double
    ) {
        self.color = color
        self.taste = taste
        self.radius = radius
    }
    
    var orangeVolume: Double {
        //можно сразу вызвать метод подсчета объема, для того что бы объем был сразу подсчитан
        //calculateOrangeVolume()
        volume
    }
    
    func calculateOrangeVolume() {
        volume = (4.0 / 3.0) * Double.pi * pow(radius, 3.0)
    }
}

let orange = Orange(radius: 2.3)

//если я в геттере вызываю метод, то тут мне уже не нужно вызывать
orange.calculateOrangeVolume()

print("Orange has \(orange.color) color and \(orange.taste) taste. The volume of orange is \(String(format: "%.3f", orange.orangeVolume))")
/*:
 ## Задание 2
 2.1 Создайте класс `Shape` (родительский класс) со следующими свойствами:
 
 - `height: Float`
 
 - `width: Float`
 
 - `radius: Float`
 
 - `square: Float`
 
 - `perimeter: Float`
 
 Oбъявите в классе методы `squareOfShape` и `perimeterOfShape` для расчетов площади и периметра (длины) фигуры соответственно. Методы должены возвращать `Float`. Создайте отдельный инициализатор для высоты и ширины и отдельный инициализатор для радиуса. Так же создайте свойство `description`, которое должно возвращать сообщение следующего вида: «Площадь фигуры <тип фигуры> равна <... >, периметр (длина) равен(а) <...>»
 */
class Shape {
    let height: Float
    let width: Float
    let radius: Float
    var square: Float
    var perimeter: Float
    
    var description: String {
        "Площадь фигуры равна \(square), периметр (длина) равен(а) \(perimeter)"
    }
    
    init(
        height: Float,
        width: Float
    ) {
        self.height = height
        self.width = width
        self.radius = 0.0
        self.square = 0.0
        self.perimeter = 0.0
    }
    
    init(
        radius: Float
    ) {
        self.height = 0.0
        self.width = 0.0
        self.radius = radius
        self.square = 0.0
        self.perimeter = 0.0
    }
    
    func squareOfShape() -> Float {
        return square
    }

    func perimeterOfShape() -> Float {
        return perimeter
    }
}
/*:
 2.2. Создайте классы `Circle`, `Rectangle` и `Ellipse`, унаследовав их от `Shape`. Переопределите методы `squareOfShape` и `perimeterOfShape` для каждого класса в соответствии с правилом расчета площади и периметра (длины) конкретной фигуры.
 */
class Circle: Shape {
    override var description: String {
        "Площадь круга равна \(String(format: "%.2f", square)), периметр (длина) равен(а) \(String(format: "%.2f", perimeter))"
    }
    
    override func squareOfShape() -> Float {
        square = Float(Double.pi * pow(Double(radius), 2.0))
        return square
    }
    
    override func perimeterOfShape() -> Float {
        perimeter = Float(2 * Double.pi * Double(radius))
        return perimeter
    }
}

class Rectangle: Shape {
    override var description: String {
        "Площадь прямоугольника равна \(String(format: "%.2f", square)), периметр (длина) равен(а) \(String(format: "%.2f", perimeter))"
    }
    
    override func squareOfShape() -> Float {
        square = height * width
        return square
    }
    
    override func perimeterOfShape() -> Float {
        perimeter = width + width + height + height
        return perimeter
    }
}

class Ellipse: Shape {
    override var description: String {
        "Площадь эллипса равна \(String(format: "%.2f", square)), периметр (длина) равен(а) \(String(format: "%.2f", perimeter))"
    }
    
    override func squareOfShape() -> Float {
        let (a, b) = calculateSemiAxis(height: height, width: width)
        square = Float(Double.pi) * a * b
        return square
    }
    
    override func perimeterOfShape() -> Float {
        let (a, b) = calculateSemiAxis(height: height, width: width)
        perimeter = 4 * (Float(Double.pi) * a * b + (a - b) / (a + b))
        return perimeter
    }
    
    //метод для определения большой и малой полуоси
    private func calculateSemiAxis(height: Float, width: Float) -> (Float, Float) {
        if height < width {
            return (width / 2, height / 2)
        } else {
            return (height / 2, width / 2)
        }
    }
}
//: 2.3 Создайте по экземпляру каждого класса, кроме `Shape` и проинициализируйте свойства `height` и `width` или `radius` для каждого класса в любые значения. Выведите значение свойства `description` на консоль.
let circle = Circle(radius: 2.6)
circle.squareOfShape()
circle.perimeterOfShape()
print(circle.description)

let ellipse = Ellipse(height: 3, width: 1)
ellipse.perimeterOfShape()
ellipse.squareOfShape()
print(ellipse.description)

let rectangle = Rectangle(height: 2, width: 5.4)
rectangle.squareOfShape()
rectangle.perimeterOfShape()
print(rectangle.description)
/*:
 ## Задание 3
 3.1 Создайте класс `Employee` (сотрудник) со следующими свойствами:
 
 - `salary`
 
 - `name`
 
 - `surname`
 */
class Employee {
    let salary: Int
    let name: String
    let surname: String
    
    init(
        salary: Int,
        name: String,
        surname: String
    ) {
        self.salary = salary
        self.name = name
        self.surname = surname
    }
}
//: 3.2 Создайте массив `names` со следующими именами: *John*, *Aaron*, *Tim*, *Ted*, *Steven*. И еще один массив `surnames` со следующими фамилиями: *Smith*, *Dow*, *Isaacson*, *Pennyworth*, *Jankins*. Массивы должны быть созданы вне класса.
let names = ["John", "Aaron", "Tim", "Ted", "Steven"]
let surnames = ["Smith", "Dow", "Isaacson", "Pennyworth", "Jankins"]
//: 3.3 Объявите массив `employees` и создайте цикл, в котором он заполняется десятью объектами класса `Employee` таким образом, что свойства `name` и `surname` инициализируются случайными именами и фамилиями из массивов `names` и `surnames`, соответственно. Свойство `salary` (зарплата) тоже должно генерироваться в случайном диапазоне от *$1000* до *$2000*
var employees = [Employee]()

for _ in 1...10 {
    let randomName = names[Int.random(in: 0...4)]
    let randomSurname = surnames[Int.random(in: 0...4)]
    let randomSalary = Int.random(in: 1000...2000)
    
    employees.append(Employee(salary: randomSalary, name: randomName, surname: randomSurname))
}
//: 3.4 Переберите массив `employees` и выведите информацию по каждому сотруднику в виде: «<имя> <фимилия>’s salary is $<... >»
for employee in employees {
    print("\(employee.name) \(employee.surname)'s salary is $\(employee.salary)")
}


//: 3.5 Создайте еще один массив на основе `employees`, который включает только тех работников, чья зарплата чётная. Выведите информацию по каждому сотруднику с четной зарплатой, как в пункте 3.4
//var employeesWithEvenSalary = [Employee]()
//
//print("Сотрудники с четной зарплатой")
//for employee in employees {
//    if employee.salary % 2 == 0 {
//        employeesWithEvenSalary.append(employee)
//    }
//}

var employeesWithEvenSalary = employees.filter { (employee) in
    employee.salary % 2 == 0
}

print("Сотрудники с четной зарплатой:")
for employee in employeesWithEvenSalary {
    print("\(employee.name) \(employee.surname)'s salary is $\(employee.salary)")
}