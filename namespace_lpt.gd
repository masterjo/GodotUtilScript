
# ���ӽ����̽� lpt  
class_name lpt

#region  Coroutine 
class CoroutineMgr:		
	static var _coroutineList = LinkedList.new()
	static func create(co : Coroutine,arg):
		_coroutineList.push_back(co)
		co.run(arg)

	static func run():
		for iter in _coroutineList.get_iterator():
			var co : Coroutine = iter.data
			if co.isEnd:
				_coroutineList.erase(iter)	 
			else:
				co.resume()			
	static func clear():
		for iter in _coroutineList.get_iterator():
			_coroutineList.erase(iter)	 	

class _EndChecker extends RefCounted:
	var co : Coroutine
	func _init(arg : Coroutine):
		self.co = arg		
	func _notification(what):
		if what == NOTIFICATION_PREDELETE:
			co.isEnd = true
	
class Coroutine extends RefCounted:
	signal _S_Tick	
	var isEnd = false
	
	func resume():
		_S_Tick.emit()

	func run(_arg,_myEnd : _EndChecker = _EndChecker.new(self)):
		assert(false,"override func run()")

#endregion	 Coroutine		


#####################################################################
#####################################################################

#region  LinkedList			
class LinkedList extends RefCounted:	
	var head : _ListNode = null
	var tail : _ListNode = null
	
	func get_iterator():
		return _ForwardIterator.new(head)
	
	func is_empty():
		return head == null
# ����Ʈ�� ���� �� ��� �߰�
	func push_back(data):
		var new_node = _ListNode.new(data)
		new_node.parent = self
		
		if head == null:
			head = new_node
			tail = new_node
		else:
			tail.next_node = new_node
			new_node.prev_node = tail
			tail = new_node
		
# Ư�� ��带 ���� ����
	func erase(node : _ListNode):
		if node == null:
			return	
				
		assert( node.parent == self)

		node.parent = null
		node.data = null

		# ��尡 ����Ʈ�� ù ��° ����� ���
		if node.prev_node == null:
			head = node.next_node
		else:
			node.prev_node.next_node = node.next_node
		
		# ��尡 ����Ʈ�� ������ ����� ���
		if node.next_node == null:
			tail = node.prev_node
		else:
			node.next_node.prev_node = node.prev_node
	
			
################################################	
	class _ListNode extends RefCounted:
		var data = null
		var prev_node : _ListNode = null
		var next_node : _ListNode = null
		var parent : LinkedList = null

		func _init(arg):
			self.data = arg
################################################	

################################################	
	class _ForwardIterator extends RefCounted:
		var current : _ListNode = null

		func _init(head_node : _ListNode):
			self.current = head_node

		func _iter_init(_arg):
			#current = start
			return current != null

		func _iter_next(_arg):
			current = current.next_node
			return current != null

		func _iter_get(_arg):
			return current
################################################	

#endregion LinkedList
