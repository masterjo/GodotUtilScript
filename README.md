Starting with Godot 4.0, coroutines cannot be controlled directly from GDScript.

I had no choice but to write a library using await and signals like yield and resume.

example:

class MyCoroutine extends lpt.Coroutine:
	func run(arg,_myEnd := _EndChecker.new(self)):
		print("start = id : "  + str(arg))
		await _S_Tick
		print("do-1  = id : "  + str(arg))
		await _S_Tick
		print("do-2  = id : "  + str(arg))
		await _S_Tick
		print("end  = id : "  + str(arg))

var co = MyCoroutine.new()	
	var co1 = MyCoroutine.new()	

	lpt.CoroutineMgr.create(co,11)
	
	lpt.CoroutineMgr.run()
	lpt.CoroutineMgr.run()
	
	
	lpt.CoroutineMgr.create(co1,22)
	
	
	lpt.CoroutineMgr.run()
	co1.isEnd = true
	
	lpt.CoroutineMgr.run()
	
	lpt.CoroutineMgr.run()
	lpt.CoroutineMgr.run()
	
