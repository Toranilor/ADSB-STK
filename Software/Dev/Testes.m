function [ output_args ] = Testes(arg1,varargin )
%TEST FUNCTION
fprintf('Num %d\n',nargin);
switch char(varargin(1))
    case 'n'
        disp('Smoke weed every day')
    case NULL
        disp('Soup')
end
nargin
end

