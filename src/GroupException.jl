using Exceptions

export GroupException

# Error Handling
mutable struct GroupException <: Exception
    msg::String
    GroupException() = new("Element doesnt belong to the BaseGroup")
    function GroupException(msg0::String)
        new(msg0)
    end
    function GroupException(ex::ExceptionType)
        if ex == BaseGroupEx
            return new("Element doesnt belong to the BaseGroup")
        elseif ex == GroupDefinitionEx
            return new("Group cant be creater")
        end
    end
end

Base.show(io::IO, grEx::GroupException) = print(io, grEx.msg)
