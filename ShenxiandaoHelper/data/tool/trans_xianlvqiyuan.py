
def trans_xianlvqiyuan():
    fp = open('xianlvqiyuan.txt', 'r');
    data = [];
    index = 0;
    data.append('[\n');
    question = "";
    answer1 = "";
    price1 = "";
    answer2 = "";
    price2 = "";

    for line in fp:
        line = line.strip();

        if index == 0:
            pass;
        elif index == 1:
            if question != "":
                data.append('{{"question" : "{0}",\n'.format(question));
                data.append('    "answer1" : "{0}",\n'.format(answer1));
                data.append('        "price1" : "{0}",\n'.format(price1));
                data.append('    "answer2" : "{0}",\n'.format(answer2));
                data.append('        "price2" : "{0}"}},\n'.format(price2));
            question = line;
        elif index == 2:
            answer1 = line;
        elif index == 3:
            price1 = line;
        elif index == 4:
            answer2 = line;
        elif index == 5:
            price2 = line;

        index += 1;
        if index == 6:
            index = 0;

    if question != "":
        data.append('{{"question" : "{0}",\n'.format(question));
        data.append('    "answer1" : "{0}",\n'.format(answer1));
        data.append('        "price1" : "{0}",\n'.format(price1));
        data.append('    "answer2" : "{0}",\n'.format(answer2));
        data.append('        "price2" : "{0}"}}\n'.format(price2));
    data.append(']\n');

    fp.close();
    fpw = open('xianlvqiyuan.json', 'w');
    fpw.writelines(data);
    fpw.close();

trans_xianlvqiyuan();
