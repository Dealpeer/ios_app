//
//  MulticastDelegate.swift
//  Modules
//
//  Created by Sergey Galezdinov on 18.02.16.
//  Copyright © 2016 4talk Global Inc.. All rights reserved.
//

import Foundation

/**
 Вспомогательный generic класс-обёртка для реализации паттерна Observer.\
 Инстансы, которые предполагают несколько подписчиков могут использовать класс для бродкаста событий.\
 Основной способ применения - Т = protocol (паттерн делегирования), но допустимо также использовать обычные классы.

 Пример использования:
 ```swift
 protocol Test {
    func method1()
    func method2()
 }

 struct DelegateHolder {
    internal var multicast = MulticastDelegate<Test>()

    func perform() {
        multicast.broadcast { $0.method1() }
        multicast.broadcast { $0.method2() }
    }
 }

 class TestImpl: Test {
    func method1() {
        print("method1")
    }
    func method2() {
        print("method2")
    }
 }

 let holder = DelegateHolder()
 let impl = TestImpl()
 holder.multicast.add(delegate: impl)
 holder.perform()
 ```
 */
open class MulticastDelegate<T> {
    private var delegates = NSHashTable<AnyObject>.weakObjects()

    func add(delegate: T) {
        delegates.add(delegate as AnyObject)
    }
    func remove(delegate: T) {
        delegates.remove(delegate as AnyObject)
    }

    func broadcast(_ closure: (T) -> Void) {
        for delegate in delegates.allObjects {
            guard let tDelegate = delegate as? T else { continue }
            closure(tDelegate)
        }
    }

    var count: Int {
        return delegates.count
    }
}

/**
 Вспомогательный протокол, добавляет shortcut-методы для добавления и удаления листенеров, что позволяет упростить вызывающий код.
 Пример:
 ```
 extension DelegateHolder: MultiCastable { typealias MulticastType = Test }

 let holder = DelegateHolder()
 let impl = TestImpl()
 holder.add(delegate: impl)
 holder.perform()
 ```
*/
public protocol MultiCastable {
    associatedtype MulticastType
    var multicast: MulticastDelegate<MulticastType> { get }
}

extension MultiCastable {
    func add(delegate: MulticastType) {
        self.multicast.add(delegate: delegate)
    }
    func remove(delegate: MulticastType) {
        self.multicast.remove(delegate: delegate)
    }
}
