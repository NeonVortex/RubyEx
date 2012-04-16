class String
	
	Bi_op = ['+','-','*','/','[]',
			 '<<','>>','<','>','>=','<=','==','===','=~','||','&&','||=']
	
	def to_proc
		code_str = self.strip
		
		#make up missing operands/args
		if Bi_op.include?(code_str)								#if it is a single operator
			code_str = '$0' + code_str + ' $1'
		elsif code_str[0,1] =~ /[\+\-\*\/\<\=\>\|\&\.]/			#if it starts with operator(\[)
			code_str = '$0' + (code_str[0,1] == '?' ? ' ' : '') + code_str
		end														#otherwise we assume it's a complete expression
		
		#find how many distinct args
		args = code_str.scan(/\$\d/).uniq
		arg_len = args.max[1,1].to_i + 1
		var_list = (97 .. 96 + arg_len).map(&:chr)
		
		#convert $d to var:a,b,c,...
		code_str = code_str.gsub(/\$(\d)/){(97 + $1.to_i).chr}
		eval "Proc.new { |" + var_list.join(",") + "| " + code_str + " }"
	end
	
	alias :old_add :+
	
	def +(other)
		if other.is_a?(Integer)
			if self.length == 1
				(self.ord + other).chr
			else
				self + other.to_s
			end
		else
			old_add(other)
		end
	end		
end
