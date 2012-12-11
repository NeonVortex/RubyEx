class Hash
	
	def +(appendant)
		raise ArgumentError, "Type mismatch: #{appendant.name} does not correspond to hash." unless appendant.respond_to?(:to_hash)
		self.merge(appendant.to_hash)
	end
	
	class << self
	  alias_method :__new__,:new
	  def new(*obj,&block)
	    if obj.size == 1 && block && block.arity == 1
	      rval = __new__(obj[0])
	      yield rval
	      rval
	    else
	      __new__(*obj,&block)
	    end
	  end
	end
	
end

