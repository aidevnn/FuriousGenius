
export ExceptionType, GroupType

@enum ExceptionType begin
    GroupDefinitionEx
    BaseGroupEx
    SubGroupElementEx # TODO
    NotSubGroupEx # TODO
    NotNormalEx # TODO
end

@enum GroupType begin
    NonAbelianGroup
    AbelianGroup
end
