class_name MyTest extends RefCounted
		

class MyCoroutine extends lpt.Coroutine:

	func run(arg,_myEnd := lpt._EndChecker.new(self)):
		print("start = id : "  + str(arg))
		await _S_Tick
		print("do-1  = id : "  + str(arg))
		await _S_Tick
		print("do-2  = id : "  + str(arg))
		await _S_Tick
		print("end  = id : "  + str(arg))
		
func _ready():
	print("Main Start")
		
	var co = MyCoroutine.new()	
	var co1 = MyCoroutine.new()	

	lpt.CoroutineMgr.create(co,11)
	lpt.CoroutineMgr.create(co1,22)
	
	lpt.CoroutineMgr.run()
	lpt.CoroutineMgr.run()
	co1.isEnd = true
		
	lpt.CoroutineMgr.run()	
	lpt.CoroutineMgr.run()
	
	print("Main End")