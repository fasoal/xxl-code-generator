package ${packagePath}.dao;

import ${packagePath}.model.${classInfo.className};
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
* ${classInfo.classComment}
*
* Created by gaoshijia on '${.now?string('yyyy-MM-dd HH:mm:ss')}'.
*/
@Mapper
public interface ${classInfo.className}Dao {

    /**
    * 新增
    */
    public void insert(@Param("${classInfo.className?uncap_first}") ${classInfo.className} ${classInfo.className?uncap_first});

    /**
    * 删除
    */
    public int delete(@Param("${classInfo.idField.fieldName}") ${classInfo.idField.fieldClass} ${classInfo.idField.fieldName});

    /**
    * 更新
    */
    public int update(@Param("${classInfo.className?uncap_first}") ${classInfo.className} ${classInfo.className?uncap_first});

    /**
    * Load查询
    */
    public ${classInfo.className} load(@Param("${classInfo.idField.fieldName}") ${classInfo.idField.fieldClass} ${classInfo.idField.fieldName});

    /**
    * 查询Data
    */
	public List<${classInfo.className}> list();

}
