# def _add(num1, num2)
#     @t1=Integer(num1)
#     @t2=Integer(num2)
#     return @t1+@t2
# end

# def _sub(num1, num2)
#     @t1=Integer(num1)
#     @t2=Integer(num2)
#     return @t1-@t2
# end

# def _mul(num1, num2)
#     @t1=Integer(num1)
#     @t2=Integer(num2)
#     return @t1*@t2
# end

# def _div(num1, num2)
#     @t1=Integer(num1)
#     @t2=Integer(num2)
#     return @t1/@t2
# end
# num1="100"
# num2="3601"
# puts num2+"/"+num1
# puts _div(num2, num1)

# Stack
class Stack
    @@items=[]
    # def initialize()
    #     @items=[]
    # end
    def push(element)
        @@items<<element
    end
    def pop()
        @@items.delete_at(@@items.size-1)
    end
    def top()
        return @@items[@@items.size-1]
    end
end


# Variables declaration
@items=Stack.new

# Function
def priority(st)
    case st
        when "#"
            return 0
        when "("
            return 1
        when "+"
            return 2
        when "-"
            return 2
        when "*"
            return 3
        when "/"
            return 3
        when ")"
            return 4
        else
            return -1
    end
end

# def push(items=@items, element)
#     items<<element
# end
# def pop(items=@items)
#     items.delete_at(items.size-1)
# end
# def top(items=@items)
#     return items[items.size-1]
# end

def invpn(sentence)
    '''
    inverse polish notation
    sentence: string -> Infix expression
    return string -> Sufix expression
    '''
    res=""
    # push @items, "#"
    @items.push("#")
    index=0
    
    while index<sentence.length do
        if sentence[index]>='0' and sentence[index]<='9'
            res+=sentence[index]
        else
            if res[(res.length)-1]>='0' and res[(res.length)-1]<='9'
                res+=" "
            end
            if sentence[index]==")"
                while @items.top()!="(" do
                    res+=@items.top()
                    @items.pop()
                end
                @items.pop()
            elsif sentence[index]=="("
                @items.push(sentence[index])
            elsif priority(sentence[index])>priority(@items.top())
                @items.push(sentence[index])
            elsif priority(sentence[index])<=priority(@items.top())
                res+=@items.top()
                @items.pop()
                res+=" "
                @items.push(sentence[index])
            else
                # 
            end
        end
        index+=1
    end
    while @items.top() !="#"
        res+=" "
        res+=@items.top()
        @items.pop()
    end
    return res
end

def compute(pn)
    '''
    pn: string -> sufix expression
    return bignum -> calculation result
    '''
    index=0
    @temp=""
    @stack=Stack.new
    while index<pn.length do
        # print pn[index]
        if pn[index]=='+' or pn[index]=='-' or pn[index]=='*' or pn[index]=='/'
            @t1=@stack.top()
            @a1=@t1.to_i
            @stack.pop()
            
            @t2=@stack.top()
            @a2=@t2.to_i
            @stack.pop()
            @res=0
            case pn[index]
            when "+"
                @res=@a2+@a1
            when "-"
                @res=@a2-@a1
            when "*"
                @res=@a2*@a1
            when "/"
                @res=@a2/@a1
            else
                puts "Calculation Error"
            end
            # print "calc:",@res
            # puts
            @stack.push(@res)

        elsif pn[index]!=" "
            @temp+=pn[index]
        else
            if @temp!=""
                @stack.push(@temp)
                # puts @temp
            end
            @temp=""
        end
        index+=1
    end
    return @stack.top()
end

#sentence="100+3601*20"
# sentence="1+2*3+4/5"
print "Please input expression:"
sentence=gets.chomp
sufix=invpn(sentence)
# puts sufix
print "Result: ", compute(sufix)
# puts compute(sufix)