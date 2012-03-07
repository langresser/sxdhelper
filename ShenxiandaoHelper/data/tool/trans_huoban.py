#coding=utf-8
import re,codecs

def trans_huoban():
    file = codecs.open('huoban.txt', 'r', 'utf8');
    
    xingming = "";
    zhiye = "";
    fuben = "";
    shengwang = "";
    feiyong = "";
    wuli = "";
    jueji = "";
    fashu = "";
    zhanfa = "";
    miaoshu = "";
    data = [];
    data.append('[\n');
    for line in file:
        line = line.strip();
        match = re.search('姓名\s+(?P<name>[^\s]+)\s+职业\s+(?P<pro>[^\s]+)\s*', line);
        #match = re.search('姓名\s+(?P<name>[^\s]+)\s+', line);
        match2 = re.search('副本\s+(?P<fuben>[^\s]+)\s+声望\s+(?P<shengw>[^\s]+)\s*', line);
        match3 = re.search('费用\s+(?P<feiyong>[^\s]+)\s*', line);
        match4 = re.search('属性\s+武力[^\d]*(?P<wuli>[\d]+)[^\d]*绝技[^\d]*(?P<jueji>[\d]+)[^\d]*法术[^\d]*(?P<fashu>[\d]+)\s*', line);
        match5 = re.search('战法\s+(?P<zhanfa>[^\s]+)\s*', line);
        match6 = re.search('伙伴描述[:：]{1}(?P<miaoshu>.+)\s*', line);
        
        if match:
            if xingming != "":
                data.append('  {{ "姓名" : "{0}",\n'.format(xingming));
                data.append('     "职业" : "{0}",\n'.format(zhiye));
                data.append('     "副本" : "{0}",\n'.format(fuben));
                data.append('     "声望" : "{0}",\n'.format(shengwang));
                data.append('     "费用" : "{0}",\n'.format(feiyong));
                data.append('     "武力" : "{0}",\n'.format(wuli));
                data.append('     "绝技" : "{0}",\n'.format(jueji));
                data.append('     "法术" : "{0}",\n'.format(fashu));
                data.append('     "战法" : "{0}",\n'.format(zhanfa));
                data.append('     "伙伴描述" : "{0}",\n'.format(miaoshu));
                data.append('     "评价" : " ",\n');
                data.append('     "image_small" : " .jpg",\n');
                data.append('     "image_big" : " .jpg" },\n');
            xingming = match.group('name');
            zhiye = match.group('pro');
        if match2:
            fuben = match2.group('fuben');
            shengwang = match2.group('shengw');
        if match3:
            feiyong = match3.group('feiyong');
        if match4:
            wuli = match4.group('wuli');
            jueji = match4.group('jueji');
            fashu = match4.group('fashu');
        if match5:
            zhanfa = match5.group('zhanfa');
        if match6:
            miaoshu = match6.group('miaoshu');

    if xingming != "":
        data.append('  {{ "姓名" : "{0}",\n'.format(xingming));
        data.append('     "职业" : "{0}",\n'.format(zhiye));
        data.append('     "副本" : "{0}",\n'.format(fuben));
        data.append('     "声望" : "{0}",\n'.format(shengwang));
        data.append('     "费用" : "{0}",\n'.format(feiyong));
        data.append('     "武力" : "{0}",\n'.format(wuli));
        data.append('     "绝技" : "{0}",\n'.format(jueji));
        data.append('     "法术" : "{0}",\n'.format(fashu));
        data.append('     "战法" : "{0}",\n'.format(zhanfa));
        data.append('     "伙伴描述" : "{0}",\n'.format(miaoshu));
        data.append('     "评价" : " ",\n');
        data.append('     "image_small" : " .jpg",\n');
        data.append('     "image_big" : " .jpg" }\n');

    data.append(']\n');
    file.close();
    
    fpw = open('huoban.json', 'w');
    fpw.writelines(data);
    fpw.close();
trans_huoban();
