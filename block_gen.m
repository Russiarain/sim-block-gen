currentStr = datestr(now,'yymmddHHMMSS');
mdName = ['Out_' currentStr];

md = new_system(mdName);

blockTxt = fileread('blocks.json');
blockStruct = jsondecode(blockTxt);

numOfBlocks = length(blockStruct.Blocks);

fprintf('%d blocks found in config file.\n',numOfBlocks)

for j = 1:numOfBlocks
    subName = blockStruct.Blocks(j).Name;
    subPath = [mdName '/' subName];

    add_block('simulink/Ports & Subsystems/Subsystem',subPath);

    % handle inports
    numOfInports = length(blockStruct.Blocks(j).Inports);
    switch numOfInports
    case 0
        delete_block([subPath '/In1']);
    case 1
        % do nothing
    otherwise
        for m = 2:numOfInports
            add_block('simulink/Sources/In1',[subPath sprintf('/In%d', m)]);
        end
    end

    % handle outports
    numOfOutports = length(blockStruct.Blocks(j).Outports);
    switch numOfOutports
    case 0
        delete_block([subPath '/Out1']);
    case 1
        % do nothing
    otherwise
        for m = 2:numOfOutports
            add_block('simulink/Sinks/Out1',[subPath sprintf('/Out%d', m)]);
        end
    end

    thisMask = Simulink.Mask.create(subPath);
    display_code = "";
    for m = 1:numOfInports
        display_code = append(display_code, sprintf("port_label('input',%d,'%s');", m,blockStruct.Blocks(j).Inports{m}));
    end
    for m = 1:numOfOutports
        display_code = append(display_code, sprintf("port_label('output',%d,'%s');", m,blockStruct.Blocks(j).Outports{m}));
    end

    display_name = sprintf("disp('%s');", blockStruct.Blocks(j).Name);
    display_code = append(display_code, display_name);

    thisMask.set('Display', display_code)
end

save_system(md)