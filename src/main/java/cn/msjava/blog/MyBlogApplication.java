package cn.msjava.blog;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

@MapperScan("cn.msjava.blog.mapper")
@SpringBootApplication
// 接口文档
@EnableSwagger2
public class MyBlogApplication {
    public static void main(String[] args) {
        SpringApplication.run(MyBlogApplication.class, args);
    }
}
