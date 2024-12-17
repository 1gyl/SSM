package aop;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import service.UserService;

import java.util.Arrays;

@Aspect
@Component
public class LoginAop {

    @Autowired
    public UserService userService;
    @Pointcut("execution(* service.UserServiceImpl.login(..))")
    private void anyMethod(){}//定义一个切入点

    @Before("anyMethod()")
    public void doAccessCheck(JoinPoint joinPoint) throws Exception {
        System.out.println("参数为："+ Arrays.toString(joinPoint.getArgs()));
        System.out.println("前置通知");
    }

    @AfterReturning(value = "anyMethod()", returning = "returnVal")
    public void doAfter(JoinPoint joinPoint, Object returnVal) {
        if (returnVal == null) {
            System.out.println("登录失败");
        } else {
            System.out.println("登录成功：" + returnVal);
        }
    }


    @After("anyMethod()")
    public void after(JoinPoint joinPoint){
    }

    @AfterThrowing("anyMethod()")
    public void doAfterThrow(){
        System.out.println("例外通知");
    }

    @Around("anyMethod()")
    public Object doBasicProfiling(ProceedingJoinPoint pjp) throws Throwable{
        System.out.println("进入环绕通知");
        Object object = pjp.proceed();//执行该方法
        return object;
    }

}



