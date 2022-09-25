
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
        elseif ex == SubGroupElementEx
            return new("Element doens belong to the SuperGroup")
        elseif ex == NotSubGroupEx
            return new("Second group is not a subgroup of first one")
        elseif ex == NotNormalEx
            return new("Second group is not a normal subgroup of first one")
        end
    end
end

Base.show(io::IO, grEx::GroupException) = print(io, grEx.msg)
