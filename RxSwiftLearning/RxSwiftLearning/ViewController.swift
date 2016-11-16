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
		flatMap()
//		map()
//		combineLatest()
//		filter()
//		startWith()
		
//		example(description: "empty", action: {
//			let emptySequence: Observable<Int> = .empty()
//			_ = emptySequence.subscribe({ (event) in
//				print(event)
//			})
//		})
		
		
		
		
//		example(description: "never", action: {
//			let neverSequence: Observable<Int> = .never()
//			_ = neverSequence.subscribe({ (event) in
//				print("never sink will never be called")
//			})
//		})
		
//		example(description: "just", action: {
//			let neverSequence: Observable<Int> = .just(32)
//			_ = neverSequence.subscribe({ (event) in
//				print(event)
//			})
//		})
		
//		example(description: "sequenceOf", action: {() -> () in
//			_  =  (0, 1, 2, 3)
//			
//		})
		
//		example(description: "from", action: {() -> () in
////			let sequenceOfElements  = [1,2,3,4].asObservable()
//			
//		})
		
//		example(description: "create", action: {() -> () in
//			let myJust = { (singleElement: Int) -> Observable<Int> in
//				return Observable.create{ observer -> Disposable in
////					observer.onNext(singleElement)
////					observer.onCompleted()
//					observer.on(.next(50))
//					observer.on(.completed)
//					
//					return Disposables.create()
//				}
//			}
//			
//			print(myJust(5))
//			
//			_ = myJust(5).subscribe({ (event) in
//				print(event)
//			})
//			
//			let observer = myJust(5)
////			_ = observer.subscribe(onNext: { (element) in
////				print(element)
////			}, onError: { (error) in
////				
////			}, onCompleted: { 
////				
////			}, onDisposed: { 
////				
////			})
////			
////			_ = observer.do(onCompleted:{
////				
////			})
//			
////			_ = observer.do(onNext: { (ob) in
////				print(ob)
////			}, onError: { (error) in
////				print(error)
////			}, onCompleted: { 
////				print("complete")
////			}, onSubscribe: { 
////				print("subscribe")
////			}, onDispose: { 
////				print("dispose")
////			})
//			
//			_ = observer.do(onCompleted: {
//				print("subscribed the onCompleted action")
//			}, onSubscribe: { 
//				print("subscribed the onSubscrib action")
//			}, onDispose: { 
//				print("subscribed the onDispose action")
//			}).subscribe(onNext: { (element) in
//				print(element)
//			}).addDisposableTo(DisposeBag())
//			
//			let subject: BehaviorSubject = BehaviorSubject(value: "z")
////			subject.on(.next("6"))
////			subject.onNext("6000")
//			_ = subject.subscribe({ (string) in
//				print(string)
//			})
//
//			subject.onNext("6000")
//			
//			_ = subject.subscribe({ (string) in
//				print(string)
//			})
//			
////			_ = subject.subscribe(onNext: { (str) in
////				print(str)
////			})
////			
////			_ = subject.subscribe({ (e) in
////				print(e)
////			})
//			
////			subject.on(.next("6"))
//			subject.onNext("6")
//			
////			print(subject)
//			
//			_ = observer.subscribe(onNext: { (ele) in
//				
//			}, onError: { (error) in
//				
//			}, onCompleted: { 
//				
//			}, onDisposed: { 
//				
//			})
//			
//		})
		
//			.subscribe(onNext: { (element) in
//				print(element)
//			})
		
//		example(description: "failWith") {
//			let error = NSError(domain: "test", code:-1, userInfo:nil)
//			
//			let errorSequence: Observable<Int> = Observable.error(error)
//			_ = errorSequence.subscribe({ (event) in
//				print(event)
//			})
//		}
		
//		example(description: "deferred", action: {
//			let deferredSequence: Observable<Int> = Observable.deferred({ () -> Observable<Int> in
//				print("creating")
//				return Observable.create({ (observer) -> Disposable in
//					print("emmiting")
//					observer.onNext(0)
//					observer.onNext(1)
//					observer.onNext(2)
//					return Disposables.create()
//				})
//			})
//			
//			print("go")
//			_ = deferredSequence.subscribe({ (event) in
//				print(event)
//			})
//			
//			_ = deferredSequence.subscribe({ (event) in
//				print(event)
//			})
//		})
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

	
	func example(description: String, action: () -> ()) {
		print("\n--- \(description) example ---")
		action()
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
		_ = subject.subscribe { (str) in
			print(str)
		}
		subject.on(.next("5"))
		
		_ = subject.map { (str) -> String in
			return str.appending("4378")
		}.subscribe { (str) in
			print(str)
		}
		subject.on(.next("55"))
		
		//this subject can be subcribed and mapped successfully
		let beh = BehaviorSubject.init(value: "beha")
		_ = beh.map { (str) in
			return str.appending("jfkld")
		}.subscribe { (ele) in
			print(ele)
		}
		_ = beh.subscribe { (str) in
			print(str)
		}
		
		_ = beh.subscribe({ (str) in
			print("------\(str)")
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
		_ = combinedSubject.subscribe { (string) in
			print(string)
		}
	}
//MARK: -- filter  filter elements with a condition
	func filter() {
		let subject = BehaviorSubject.init(value: "2478AAA34378")
		_ = subject.filter { (str) -> Bool in
			return str.contains("AAA")
		}.subscribe { (str) in
			print("the filted string is \(str)")
		}
	}
	
//MARK: -- startWith  insert a sink at the begining element
	func startWith() {
		let subject = BehaviorSubject.init(value: "subject")
		_ = subject.startWith("star!").subscribe { (str) in
			print("\(str)")
		}
	}
	

}

