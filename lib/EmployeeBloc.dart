//7 step to doing bloc:
//#1 imports
//#2 get list of data
//#3 stream controller
//#4 stream, sink, getter
//#5 constructor - add data / listen to changes
//#6 core functions
//#7 dispose

import 'dart:async';
import 'Employee.dart';

class EmployeeBloc {
  List<Employee> _employeeList = [
    Employee(1, "Employee One", 100.0),
    Employee(2, "Employee Two", 200.0),
    Employee(3, "Employee Three", 300.0),
    Employee(4, "Employee Four", 400.0),
    Employee(5, "Employee Five", 500.0)
  ];

  //for list
  final _employeeListStreamController = StreamController<List<Employee>>();

  //for inc and dec
  final _employeeSalaryIncrementStreamController = StreamController<Employee>();
  final _employeeSalaryDecrementStreamController = StreamController<Employee>();

  //getters
  Stream<List<Employee>> get employeeListStream =>
      _employeeListStreamController.stream;
  StreamSink<List<Employee>> get employeeListSink =>
      _employeeListStreamController.sink;
  StreamSink<Employee> get employeeSalaryIncrement =>
      _employeeSalaryIncrementStreamController.sink;
  StreamSink<Employee> get employeeSalaryDecrement =>
      _employeeSalaryDecrementStreamController.sink;

  //constructor
  EmployeeBloc() {
    //add data hardcode
    _employeeListStreamController.add(_employeeList);
    _employeeSalaryIncrementStreamController.stream.listen(_incrementSalary);
    _employeeSalaryDecrementStreamController.stream.listen(_decrementSalary);
  }

  _incrementSalary(Employee employee) {
    double salary = employee.salary;
    double incrementedSalary = salary * 20 / 100;
    _employeeList[employee.id - 1].salary = salary + incrementedSalary;
    employeeListSink.add(_employeeList);
  }

  _decrementSalary(Employee employee) {
    double salary = employee.salary;
    double decrementedSalary = salary * 20 / 100;
    _employeeList[employee.id - 1].salary = salary - decrementedSalary;
    employeeListSink.add(_employeeList);
  }

  void dispose() {
    _employeeSalaryDecrementStreamController.close();
    _employeeSalaryIncrementStreamController.close();
    _employeeListStreamController.close();
  }
}
