class String
    
    BINARY_OPERATOR = ['+','-','*','/','[]','<<','>>','<','>','>=','<=','==','===','=~','||','&&','||=']
    
    def to_proc
        code_str = self.strip
        
        #Fill up missing operands/args
        case code_str
        when *BINARY_OPERATOR                                         #if it is a single binary operator, fill two operands
            code_str = '$0' + code_str + '$1'
        when /^[\+\-\*\/\<\=\>\|\&\.\?]/                              #if it starts with operator, fill first operand
            code_str = '$0' + (code_str[0,1] == '?' ? ' ' : '') + code_str
        end
        
        #find how many distinct args
        args = code_str.scan(/\$\d/).uniq.map{|arg| arg[1,1]}
        arg_len = args.max.to_i + 1
        var_list = (97 .. 96 + arg_len).map(&:chr)
        
        #convert $d to var:a,b,c,...
        code_str = code_str.gsub(/\$(\d)/){(97 + $1.to_i).chr}
        eval "Proc.new { |" + var_list.join(",") + "| " + code_str + " }"
    end
    
    alias_method :old_add, :+
    
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
