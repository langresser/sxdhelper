
def trans_xianlvqiyuan():
    fp = open('xianlvqiyuan.txt', 'r');
    data = [];
    index = 0;
    data.append('{\n');
    question = "";
    answer1 = "";
    price1 = "";
    answer2 = "";
    price2 = "";

    for line in fp:
        line = line.strip();

        if index == 0:
            if question != "":
                data.append('"{0}":\n'.format(question));
                data.append('\t[{{ "{0}"  :  "{1}" }},\n'.format(answer1, price1));
                data.append('\t {{ "{0}"  :  "{1}" }}],\n'.format(answer2, price2));
            question = line;
        elif index == 1:
            answer1 = line;
        elif index == 2:
            price1 = line;
        elif index == 3:
            answer2 = line;
        elif index == 4:
            price2 = line;
        index += 1;
        if index == 5:
            index = 0;

    if question != "":
       data.append('"{0}":\n'.format(question));
       data.append('\t[{{ "{0}"  :  "{1}" }},\n'.format(answer1, price1));
       data.append('\t {{ "{0}"  :  "{1}" }}]\n'.format(answer2, price2));
    data.append('}\n');

    fp.close();
    fpw = open('xianlvqiyuan.json', 'w');
    fpw.writelines(data);
    fpw.close();

trans_xianlvqiyuan();
