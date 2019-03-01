package com.platform.generator;

import org.apache.commons.lang.StringUtils;

public class Atoi {


    public static void main(String[] args) {
        String str = "214hjkkk6";
        boolean res = myAtoi(121);
        System.out.println(res);
    }

    public static boolean myAtoi(int x) {

        int old = x;
        if(x<0){
            return false;
        }
        int res = 0;
        while(x!=0){
            int pop = x%10;
            x = x/10;
            if(res > Integer.MAX_VALUE/10 || (res == Integer.MAX_VALUE/10 && pop > 7) )return false;
            if(res<Integer.MIN_VALUE/10 || (res == Integer.MIN_VALUE/10 && pop<-8)) return false;
            res = res * 10 + pop;
        }

        if(res==old){
            return true;
        }else{
            return false;
        }
    }


}
