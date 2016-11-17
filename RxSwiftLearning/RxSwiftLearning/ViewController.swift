//
//  ViewController.swift
//  RxSwiftLearning
//
//  Created by 彭柯柱 on 2016/11/15.
//  Copyright © 2016年 彭柯柱. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
//		flatMap()
//		map()
//		combineLatest()
//		filter()
//		startWith()
//		just()
//		defered()
//		publishSubject()
//		behaviorSubject()
//		doOnAndSubscribe()
//		never()
//		createASianal()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
//MARK: -- flatMap  return a sink who's closure return another sinkB and then can be subscribe the sinkB directly
	
	func flatMap() {
		let signal = Observable<String>.create { (obser) -> Disposable in
			obser.onNext("subject")
			obser.onCompleted()
			return Disposables.create()
		}
//
		let va = Variable("7")
		print(va.asObservable())
		_ = va.asObservable().subscribe { (result) in
			print(result)
		}
		_ = va.asObservable().flatMap { str in
			return Observable.just("ire")
		}.subscribe({ (event) in
			print(event)
		})
		
		let subjectN = BehaviorSubject.init(value: signal)
		print(subjectN)
		_ = subjectN.flatMap {signal in
			return Observable.just(signal)
		}.subscribe { (event) in
			print(event)
		}
	}
	
//MARK: -- map
	func map() {
		//this is a unique observer who can be not be subscribed I still don't know why
		let subject = Variable.init("56").asObservable() as! BehaviorSubject
		_ = subject.subscribe { (event) in
			print(event)
		}
		subject.on(.next("5"))
		
		_ = subject.map { (str) -> String in
			return str.appending("4378")
		}.subscribe { (event) in
			print(event)
		}
		subject.on(.next("55"))
		
		//this subject can be subcribed and mapped successfully
		let beh = BehaviorSubject.init(value: "beha")
		_ = beh.map { (str) in
			return str.appending("jfkld")
		}.subscribe { (event) in
			print(event)
		}
		_ = beh.subscribe { (event) in
			print(event)
		}
		
		_ = beh.subscribe({ (event) in
			print("------\(event)")
		})
		beh.on(.next("566"))
	}
	
//MARK: -- combineLatest combine several sinks with the latest event to do something with the elements of them and then return something
	func combineLatest() {
		let subjectA = BehaviorSubject.init(value: "elementA")
		let subjectB = BehaviorSubject.init(value: "elementB")
		let combinedSubject = Observable.combineLatest(subjectA, subjectB, resultSelector: { (str1, str2) -> String in
			  return str1.uppercased()
		})
		_ = combinedSubject.subscribe { (event) in
			print(event)
		}
	}
//MARK: -- filter  filter elements with a condition
	func filter() {
		let subject = BehaviorSubject.init(value: "2478AAA34378")
		_ = subject.filter { (str) -> Bool in
			return str.contains("AAA")
		}.subscribe { (event) in
			print("the filted string is \(event)")
		}
	}
	
//MARK: -- startWith  insert a sink at the begining element
	func startWith() {
		let subject = BehaviorSubject.init(value: "subject")
		_ = subject.startWith("star!").subscribe { (str) in
			print("\(str)")
		}
	}
	
//MARK: -- just is just a sink who can only be subscribed one element
	func just() {
		let just = Observable.just("element")
		_ = just.subscribe { (event) in
			print(event)
		}
	}
	
//MARK: -- from to create a ObservableSequence instance from an array or another ObservableSequence instance
	func from() {
		let sequence =  Observable.from([1,2,3])
		_ = sequence.subscribe({ (event) in
			print(event)
		})
	}
	
//MARK: -- defer to create a Observable instance the deferred signal returned when the deferred signal was subscribed
	func defered() {
		let deferedSequence = Observable.deferred { () -> Observable<Int> in
			print("creating")
			return Observable.create({ (observer) -> Disposable in
				print("emmiting")
				observer.onNext(78)
				observer.onNext(45)
				return Disposables.create()
			})
		}
		
		_ = deferedSequence.subscribe { (event) in
			print(event)
		}
	}
	
//MARK: -- publishSubject to create a subject who can observer the event when it is subscribed firstly,it is a most usual tool
	func publishSubject() {
		let publishSubject = PublishSubject<String>.init()
		_ = publishSubject.subscribe { (event) in
			print(event)
		}
		publishSubject.onNext("publishSubject1")
		publishSubject.onNext("publishSubject2")
		
		_ = publishSubject.subscribe { (event) in
			print(event)
		}
		publishSubject.onNext("publishSubject3")
		publishSubject.onNext("publishSubject4")
		
	}
	
//MARK: -- behaviorSubject to create a subject and when it was subscribed ,it will send the latest signal to the new subscriber,if no,send the default
	func behaviorSubject() {
		let behSubject = BehaviorSubject.init(value: "behavior")
		_ = behSubject.subscribe { (event) in
			print(event)
		}
		behSubject.onNext("behavior1")
		_ = behSubject.subscribe { (event) in
			print(event)
		}
		behSubject.onNext("behavior2")
		_ = behSubject.subscribe { (event) in
			print(event)
		}
	}
	

	func doOnAndSubscribe() {
		let subject = PublishSubject<String>.init()
		
		// notice: publish subject can only be subscribed a result when it is subscribd firstly,
		// and the function do(::::) need to be subscribed at the end
		_ = subject.subscribe { (string) in
			print(string)
		}
		_ = subject.do(onNext: { (element) in
			print(element)
		}, onError: { (error) in
			print(error)
		}, onCompleted: { 
			print("send completed")
		}, onSubscribe: { 
			print("I was subcribed")
		}, onDispose: { 
			print("I was disposed")
		}).subscribe({ (event) in
			print(event)
		})
		
		subject.onNext("nextElement")
		subject.onCompleted()
	}
	
//MARK: -- to create a signal who can not subscribed any results
	func never() {
		let neverSignal = Observable<String>.never()
		_ = neverSignal.subscribe { (event) in
			print("I can never be called so this print will not excute")
		}
	}
	
//MARK: -- to create a signal (hot signal who can only send element at its inialize)
	func createASianal() {
		let signal = Observable<String>.create { (observer) -> Disposable in
			observer.onNext("element")
			observer.onCompleted()
			return Disposables.create()
		}
		_ = signal.subscribe(onNext: { (value) in
			print(value)
		})
		
	}
}

