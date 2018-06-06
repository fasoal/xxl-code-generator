package ${packagePath}.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import ${packagePath}.dao.${classInfo.className}Dao;
import ${packagePath}.model.${classInfo.className};
import ${packagePath}.service.${classInfo.className}Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
* ${classInfo.classComment}
*
* Created by gaoshijia on '${.now?string('yyyy-MM-dd HH:mm:ss')}'.
*/
@Service
public class ${classInfo.className}ServiceImpl implements ${classInfo.className}Service {

	@Autowired
	private ${classInfo.className}Dao ${classInfo.className?uncap_first}Dao;

	/**
    * 新增
    */
	@Override
	public void insert(${classInfo.className} ${classInfo.className?uncap_first}) {
		${classInfo.className?uncap_first}Dao.insert(${classInfo.className?uncap_first});
	}

	/**
	* 删除
	*/
	@Override
	public void delete(${classInfo.idField.fieldClass} ${classInfo.idField.fieldName}) {
		int ret = ${classInfo.className?uncap_first}Dao.delete(${classInfo.idField.fieldName});
	}

	/**
	* 更新
	*/
	@Override
	public void update(${classInfo.className} ${classInfo.className?uncap_first}) {
		int ret = ${classInfo.className?uncap_first}Dao.update(${classInfo.className?uncap_first});
	}

	/**
	* Load查询
	*/
	@Override
	public ${classInfo.className} load(${classInfo.idField.fieldClass} ${classInfo.idField.fieldName}) {
            return ${classInfo.className?uncap_first}Dao.load(${classInfo.idField.fieldName});
	}

	/**
	* 分页查询
	*/
	@Override
	public PageInfo<${classInfo.className}> pageList(int pageNum, int pagesize) {
		PageHelper.startPage(pageNum, pagesize);
                    List<${classInfo.className}> pageList = ${classInfo.className?uncap_first}Dao.list();
		PageInfo result = new PageInfo(pageList);

	    return result;
	}

}
