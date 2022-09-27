
# Error Handling
mutable struct GroupException <: Exception
    msg::String
    GroupException() = new("Element doesnt belong to the BaseGroup")
    function GroupException(msg0::String)
        new(msg0)
    end
    function GroupException(ex::ExceptionType)
        if ex == BaseGroupEx
            return new("Groups or Elements do not belong to the BaseGroup")
        elseif ex == GroupDefinitionEx
            return new("Group cant be creater")
        elseif ex == SuperGroupEx
            return new("Groups or Elements do not belong to the SuperGroup")
        elseif ex == NotSubGroupEx
            return new("Second group is not a subgroup of first one")
        elseif ex == NotNormalEx
            return new("Second group is not a normal subgroup of first one")
        elseif ex == CyclicsGroupEx
            return new("Groups are not cyclics")
        elseif ex == SemiDirectProdEx
            return new("Semi-direct product does not exits")
        end
    end
end

Base.show(io::IO, grEx::GroupException) = print(io, grEx.msg)
