%Initialise STK Connection
disp('Initialising STK');
app = actxserver('STK10.Application');
root = app.Personality2;

%http://www.agi.com/products/stk/modules/default.aspx/id/matlab-connectors-setup-and-installation