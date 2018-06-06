package ${packagePath}.service;

import com.alibaba.fastjson.JSON;
import com.github.pagehelper.PageInfo;
import ${packagePath}.model.${classInfo.className};
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;


@RunWith(SpringRunner.class)
@SpringBootTest
public class ${classInfo.className}ServiceTest {
    @Autowired
    private ${classInfo.className}Service ${classInfo.className?uncap_first}Service;

    @Test
    public void pageListTest() {
        PageInfo<${classInfo.className}> ${classInfo.className?uncap_first}PageInfo = ${classInfo.className?uncap_first}Service.pageList(1,5);
        System.out.print(JSON.toJSONString(${classInfo.className?uncap_first}PageInfo));
    }
}
