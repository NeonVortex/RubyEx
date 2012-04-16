class Hash
	
	def + (appendant)
		raise ArgumentError, "Type mismatch: #{appendant.name} does not correspond to hash." unless appendant.respond_to?(:to_hash)
		self.merge(appendant.to_hash)
	end
	
end
