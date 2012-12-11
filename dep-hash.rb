class DepHash

    def self.new
        Hash.new{|h,k| h[k]=Hash.new(&h.default_proc)}
    end

end

