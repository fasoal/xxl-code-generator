<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${packagePath}.dao.${classInfo.className}Dao">

    <resultMap id="${classInfo.className}" type="${packagePath}.model.${classInfo.className}" >
    <#if classInfo.fieldList?exists && classInfo.fieldList?size gt 0>
    <#list classInfo.fieldList as fieldItem >
        <result column="${fieldItem.columnName}" property="${fieldItem.fieldName}" />
    </#list>
    </#if>
    </resultMap>

    <sql id="Base_Column_List">
    <#if classInfo.fieldList?exists && classInfo.fieldList?size gt 0>
    <#list classInfo.fieldList as fieldItem >
        `${fieldItem.columnName}`<#if fieldItem_has_next>,</#if>
    </#list>
    </#if>
    </sql>

    <insert id="insert" parameterType="${packagePath}.model.${classInfo.className}" >
        INSERT INTO ${classInfo.tableName} (
        <#if classInfo.fieldList?exists && classInfo.fieldList?size gt 0>
        <#list classInfo.fieldList as fieldItem >
            <#if fieldItem.columnName != classInfo.idField.columnName >
            `${fieldItem.columnName}`<#if fieldItem_has_next>,</#if>
            </#if>
        </#list>
        </#if>
        )
        VALUES(
        <#if classInfo.fieldList?exists && classInfo.fieldList?size gt 0>
        <#list classInfo.fieldList as fieldItem >
        <#if fieldItem.columnName != classInfo.idField.columnName >
            ${r"#{"}${classInfo.className?uncap_first}.${fieldItem.fieldName}${r"}"}<#if fieldItem_has_next>,</#if>
        </#if>
        </#list>
        </#if>
        )
    </insert>

    <delete id="delete" >
        DELETE FROM ${classInfo.tableName}
        WHERE ${classInfo.idField.columnName} = ${r"#{"}${classInfo.idField.fieldName}${r"}"}
    </delete>

    <update id="update" parameterType="${packagePath}.model.${classInfo.className}" >
        UPDATE ${classInfo.tableName}
        SET
        <#list classInfo.fieldList as fieldItem >
        <#if fieldItem.columnName != classInfo.idField.columnName>
            ${fieldItem.columnName} = ${r"#{"}${classInfo.className?uncap_first}.${fieldItem.fieldName}${r"}"}<#if fieldItem_has_next>,</#if>
        </#if>
        </#list>
        WHERE ${classInfo.idField.columnName} = ${r"#{"}${classInfo.className?uncap_first}.${classInfo.idField.fieldName}${r"}"}
    </update>


    <select id="load" resultMap="${classInfo.className}">
        SELECT <include refid="Base_Column_List" />
        FROM ${classInfo.tableName}
        WHERE ${classInfo.idField.columnName} = ${r"#{"}${classInfo.idField.fieldName}${r"}"}
    </select>

    <select id="list" resultType="${packagePath}.model.${classInfo.className}" resultMap="${classInfo.className}">
        SELECT <include refid="Base_Column_List" />
        FROM ${classInfo.tableName}
    </select>

</mapper>
