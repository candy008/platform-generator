package com.platform.generator;

/**
 * 最长回文子串，找到中心点想两边扩散找，直到两边的字符不想等。记录中心到该位置的长度
 */
public class ManacherTest {


    public static void main(String[] args) {
        String s = "navnavan";
        doManacher(s);
    }

    public static void doManacher(String s) {
        //在字符串两头和质检添加特殊字符转成奇数长度，原理：奇数+奇数+1=奇数，偶数+偶数+1=奇数。
        StringBuffer sb = new StringBuffer();
        sb.append("#");
        for (int i = 0; i < s.length(); i++) {
            sb = sb.append(s.substring(i, i + 1)).append("#");
        }
        s = sb.toString();

        int pos, maxValuePos = 0, maxValue = 0;
//		以每个字符为轴求最长回文串半径，其中半径=1表示字符本身。
        int[] p = new int[s.length()];
        int left, right = 0;
        for (int i = 0; i < s.length(); i++) {
            int len = 1;
            for (left = i - 1, right = i + 1; left >= 0 && right <= (2 * i) && right < s.length(); left--, right++) {
                if (s.charAt(left) == s.charAt(right)) {
                    len = len + 1;
                    continue;//如果匹配成功就继续
                } else {
                    break;//不成功就跳出循环
                }
            }
            p[i] = len;
            if (p[i] > maxValue) {
                maxValue = p[i];
                maxValuePos = i;
            }
        }
        maxValue = p[maxValuePos];

        //求最长回文串内容
        String huiwen;
        StringBuffer realHuiwen = new StringBuffer();
        if (maxValue == 1) {
            System.out.println("最长回文串为：" + s.charAt(maxValuePos));
        } else {
            huiwen = s.substring((maxValuePos + 1 - maxValue), maxValuePos + maxValue);
            for (int j = 0; j < huiwen.length(); j++) {
                if (j % 2 != 0)
                    realHuiwen = realHuiwen.append(huiwen.charAt(j));
            }
            System.out.println("最长回文串为：" + realHuiwen.toString());
        }
    }
}
