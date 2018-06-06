package ${packagePath}.service;

import ${packagePath}.model.${classInfo.className};
import com.github.pagehelper.PageInfo;

/**
* ${classInfo.classComment}
*
* Created by gaoshijia on '${.now?string('yyyy-MM-dd HH:mm:ss')}'.
*/
public interface ${classInfo.className}Service {

    /**
    * 新增
    */
    public void insert(${classInfo.className} ${classInfo.className?uncap_first});

    /**
    * 删除
    */
    public void delete(${classInfo.idField.fieldClass} ${classInfo.idField.fieldName});

    /**
    * 更新
    */
    public void update(${classInfo.className} ${classInfo.className?uncap_first});

    /**
    * Load查询
    */
    public ${classInfo.className} load(${classInfo.idField.fieldClass} ${classInfo.idField.fieldName});

    /**
    * 分页查询
    */
    public PageInfo<${classInfo.className}> pageList(int pageNum, int pagesize);

}
