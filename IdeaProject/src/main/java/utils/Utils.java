package utils;

import com.alibaba.fastjson.JSONObject;
import entity.*;
import eu.bitwalker.useragentutils.UserAgent;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

public class Utils {

    public static String getRegisterDay(String register_time) throws ParseException {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date date = simpleDateFormat.parse(register_time.substring(0, 10));
        float days = (new Date().getTime() - date.getTime()) / 86400000;
        if (days < 1) days = 1;
        String registerDays = Float.toString(days).substring(0, Float.toString(days).length() - 2);
        return registerDays;
    }

    // 获取当前时间
    public static Timestamp getNowTime() {
        Date utilDate = new Date();
        Timestamp sqlDate = new Timestamp(utilDate.getTime());
        return sqlDate;
    }

    public static String getStringTime() {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String nowTime = simpleDateFormat.format(new Date());
        return nowTime;
    }

    public static String transSqlTime(Timestamp tp) {
        SimpleDateFormat st = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String sqlTime = st.format(tp);
        String stringTime = sqlTime.substring(0, sqlTime.length() - 2);
        return stringTime;
    }

    public static String transDate(Date date){
        SimpleDateFormat st = new SimpleDateFormat();
        return st.format(date);
    }

    public static String transGMT(String GMT) {
        SimpleDateFormat format = new SimpleDateFormat("EEE MMM dd yyyy HH:mm:ss", Locale.ENGLISH);
        Date dateTrans = null;
        try {
            dateTrans = format.parse(GMT);
            SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");
            String date = sdf2.format(dateTrans).replace("-", "-");
            return date;
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static Timestamp sqlDate(Date date) throws ParseException {
        Timestamp sqlDate = new Timestamp(date.getTime());
        return sqlDate;
    }

    public static Salary getPersonalSalary(Staff staff, Department dept) {
        Salary salary = new Salary();
        salary.setStaff_id(staff.getStaff_id());
        salary.setSalary(staff.getRank() * dept.getBase_salary());
        salary.setSubsidy(staff.getRank() * dept.getBase_subsidy());
        salary.setBonus(staff.getRank() * dept.getBase_bonus());
        salary.setAnnual(dept.getBase_annual() * (salary.getSalary() + salary.getSubsidy() + salary.getBonus()));
        return salary;
    }

    public static Salary getUpdateSalary(Salary salary, Department dept) {
        salary.setSalary(salary.getRank() * dept.getBase_salary());
        salary.setSubsidy(salary.getRank() * dept.getBase_subsidy());
        salary.setBonus(salary.getRank() * dept.getBase_bonus());
        salary.setAnnual(dept.getBase_annual() * (salary.getSalary() + salary.getSubsidy() + salary.getBonus()));
        return salary;
    }

    public static Department deptFactory(List<Department> deptList, String department) {
        for (Department dept : deptList) {
            if (department.equals(dept.getDepartment())) {
                return dept;
            }
        }
        return null;
    }

    public static String address(String ip) {
        if ("0:0:0:0:0:0:0:1".equals(ip) || ip == null) {
            ip = "";
        }
        String address = "";
        try {
            String st = Http.sendGet("https://67ip.cn/check", "ip=" + ip + "&token=08dbc7d7ab7a8b6afd24f133e950c0ed");
            Map<String, Object> ads = JSONObject.parseObject(st);
            JSONObject data = (JSONObject) ads.get("data");
            address = data.get("province").toString() + data.get("city").toString();
            if ("".equals(address)) {
                address = data.get("country").toString();
            }
        } catch (Exception e) {
            address = "未知";
        }
        return address;
    }

    public static String getBrowser(String header) {
        UserAgent userAgent = UserAgent.parseUserAgentString(header);
        if (header.contains("Edg")) {
            return "MSEdge";
        } else {
            return userAgent.getBrowser().getName();
        }
    }

    public void test() {
        System.out.println(123);
    }
}
