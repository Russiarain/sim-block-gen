% generate json config string of blocks with many inports/outports
% which has similar structure of name. Output string ONLY contains parts
% inside of the bracket. eg.
% inports : ["DataIN1","SofIN1","DataIN2","SofIN2","DataIN3","SofIN3"...]
%            ^                                                      ^
%           (output start)                               (output end)

numOfPorts = 32;

namePrefix1 = "DataIN";
namePrefix2 = "SofIN";

output = "";

for j = 1:numOfPorts
    output = append(output,sprintf(',"%s%d","%s%d"',namePrefix1,j,namePrefix2,j));
end
output = strip(output,'left',',');
disp(output)