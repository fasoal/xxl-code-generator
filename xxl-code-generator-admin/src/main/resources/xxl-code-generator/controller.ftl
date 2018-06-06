package ${packagePath}.controller;

import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import ${packagePath}.service.${classInfo.className}Service;
import ${packagePath}.model.${classInfo.className};
import org.springframework.web.bind.annotation.RestController;

/**
* ${classInfo.classComment}
*
* Created by gaoshijia on '${.now?string('yyyy-MM-dd HH:mm:ss')}'.
*/
@RestController
@RequestMapping("/${classInfo.className?uncap_first}")
public class ${classInfo.className}Controller {

    @Autowired
    private ${classInfo.className}Service ${classInfo.className?uncap_first}Service;

    /**
    * 新增
    */
    @RequestMapping("/insert")
    @ResponseBody
    public void insert(${classInfo.className} ${classInfo.className?uncap_first}){
        ${classInfo.className?uncap_first}Service.insert(${classInfo.className?uncap_first});
    }

    /**
    * 删除
    */
    @RequestMapping("/delete")
    @ResponseBody
    public void delete(${classInfo.idField.fieldClass} ${classInfo.idField.fieldName}){
        ${classInfo.className?uncap_first}Service.delete(${classInfo.idField.fieldName});
    }

    /**
    * 更新
    */
    @RequestMapping("/update")
    @ResponseBody
    public void update(${classInfo.className} ${classInfo.className?uncap_first}){
        ${classInfo.className?uncap_first}Service.update(${classInfo.className?uncap_first});
    }

    /**
    * Load查询
    */
    @RequestMapping("/load")
    @ResponseBody
    public ${classInfo.className} load(${classInfo.idField.fieldClass} ${classInfo.idField.fieldName}){
        return ${classInfo.className?uncap_first}Service.load(${classInfo.idField.fieldName});
    }

    /**
    * 分页查询
    */
    @RequestMapping("/pageList")
    @ResponseBody
    public PageInfo<${classInfo.className}> pageList(@RequestParam(required = false, defaultValue = "0") int offset,
                                        @RequestParam(required = false, defaultValue = "10") int pagesize) {
        return ${classInfo.className?uncap_first}Service.pageList(offset, pagesize);
    }

}
