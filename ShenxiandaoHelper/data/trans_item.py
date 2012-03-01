#coding=utf-8
import re
def parse_item(item):
    data = [];
    item = item.strip();
    item = item.replace('x', '",');
    data = item.split(' ');
    return data;

def trans_zhuangbei():
    fp = open('zhuangbei.txt', 'r');
    data = [];
    index = 0;
    data.append('{\n');

    for line in fp:
        line = line.strip();
        match = re.search('^(?P<name>[^\s]+)\s+(?P<pro>[^\s]+)\s+(?P<level>\d+)\s+(?P<item>.+)$', line);
        if match:
            name = match.group('name');
            pro = match.group('pro');
            level = match.group('level');
            item = match.group('item');
            data.append('"{0}": {{\n'.format(name));
            data.append('    "image" : ".png",\n');
            data.append('    "type : "equipment",\n');
            data.append('    "color" : "purple",\n');
            data.append('    "data" : "{0}",\n'.format(pro));
            data.append('    "level" : {0},\n'.format(level));

            item_xx = parse_item(item);
            item_line = '    "items" : ['
            amount = len(item_xx);
            i = 0;
            for each in item_xx:
                i += 1;
                if i == amount:
                    item_line += ' "{0} ]\n'.format(each);
                else:
                    item_line += ' "{0}, '.format(each);
            data.append(item_line);
            data.append('    },\n');
    fp.close();

    fp = open('cailiao.txt', 'r');
    for line in fp:
        line = line.strip();
        match = re.search('^(?P<name>[^\s]+)\s+(?P<where>[^\s]+)\s+(?P<item>.+)$', line);
        if match:
            name = match.group('name');
            where = match.group('where');
            item = match.group('item');
            data.append('"{0}": {{\n'.format(name));
            data.append('    "image" : ".png",\n');
            data.append('    "type : "material",\n');
            data.append('    "data" : "{0}",\n'.format(where));

            item_xx = parse_item(item);
            item_line = '    "items" : ['
            amount = len(item_xx);
            i = 0;
            for each in item_xx:
                i += 1;
                if i == amount:
                    item_line += ' "{0}" ]\n'.format(each);
                else:
                    item_line += ' "{0}", '.format(each);
            data.append(item_line);
            data.append('    },\n');
    fp.close();

    fp = open('danyao.txt', 'r');
    for line in fp:
        line = line.strip();
        match = re.search('^(?P<name>[^\s]+)\s+(?P<level>\d+)\s+(?P<item>.+)$', line);
        if match:
            name = match.group('name');
            level = match.group('level');
            item = match.group('item');
            data.append('"{0}": {{\n'.format(name));
            data.append('    "image" : ".png",\n');
            data.append('    "type : "drug",\n');
            data.append('    "color" : "purple",\n');
            data.append('    "level" : {0},\n'.format(level));

            item_xx = parse_item(item);
            item_line = '    "items" : ['
            amount = len(item_xx);
            i = 0;
            for each in item_xx:
                i += 1;
                if i == amount:
                    item_line += ' "{0} ]\n'.format(each);
                else:
                    item_line += ' "{0}, '.format(each);
            data.append(item_line);
            data.append('    },\n');
    fp.close();

    data.append('}\n');
    fpw = open('itemex.json', 'w');
    fpw.writelines(data);
    fpw.close();

trans_zhuangbei();

