package com.xxl.codegenerator.admin.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.xxl.codegenerator.admin.model.ReturnT;
import com.xxl.codegenerator.admin.util.FreemarkerUtil;
import com.xxl.codegenerator.admin.util.ZipMultiFile;
import com.xxl.codegenerator.core.CodeGeneratorTool;
import com.xxl.codegenerator.core.model.ClassInfo;
import freemarker.template.TemplateException;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

/**
 * sso server (for web)
 *
 * @author xuxueli 2017-08-01 21:39:47
 */
@Controller
public class IndexController {
    private static final Logger logger = LoggerFactory.getLogger(IndexController.class);

    @RequestMapping("/")
    public String index() {
        return "index";
    }

    private File generateFile(String templateName,Map<String, Object> params,String filePath) throws IOException,TemplateException{
        File file = new File(filePath);
        FileUtils.writeStringToFile(file,FreemarkerUtil.processString(templateName, params));
        return file;
    }

    @RequestMapping("/codeDownload")
    @ResponseBody
    public void codeDownload(String queryCondition, HttpServletResponse response) {
        try {
            System.out.print(queryCondition);
            JSONObject jsonObject = JSON.parseObject(queryCondition);

            // parse table
            ClassInfo classInfo = CodeGeneratorTool.processTableIntoClassInfo(jsonObject.getString("tableSql"));

            // code genarete
            Map<String, Object> params = new HashMap<String, Object>();
            params.put("classInfo", classInfo);
            params.put("packagePath",jsonObject.getString("packagePath"));
            // result
            Map<String, String> result = new HashMap<String, String>();

            String baseFilePath = System.getProperty("java.io.tmpdir") + File.separator
                    + UUID.randomUUID();
            File baseFilefolder = new File(baseFilePath);
            baseFilefolder.mkdir();

            File controllerFile = generateFile("controller.ftl", params,baseFilePath+File.separator+classInfo.getClassName()+"Controller.java");
            File serviceFile = generateFile("service.ftl", params,baseFilePath+File.separator+classInfo.getClassName()+"Service.java");
            File serviceImplFile = generateFile("service_impl.ftl", params,baseFilePath+File.separator+classInfo.getClassName()+"ServiceImpl.java");
            File serviceTestFile = generateFile("service_test.ftl", params,baseFilePath+File.separator+classInfo.getClassName()+"ServiceTest.java");
            File daoFile = generateFile("dao.ftl", params,baseFilePath+File.separator+classInfo.getClassName()+"Dao.java");
            File mybatisFile = generateFile("mybatis.ftl", params,baseFilePath+File.separator+classInfo.getClassName()+"Dao.xml");
            File modelFile = generateFile("model.ftl", params,baseFilePath+File.separator+classInfo.getClassName()+".java");

            String zipFilePath = System.getProperty("java.io.tmpdir") + File.separator
                    + UUID.randomUUID() + ".zip";
//            ZipCompress zipCompress = new ZipCompress(zipFile,baseFilePath);
//            zipCompress.zip();

//            File[] srcFiles = new File[]{controllerFile,serviceFile,serviceImplFile,daoFile,mybatisFile,modelFile};
            File zipFile = new File(zipFilePath);
            ZipMultiFile.zipFiles(baseFilefolder.listFiles(),zipFile);

            buildFileResponce(response,zipFile,"sourceCode.zip");
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
        }
    }



    @RequestMapping("/codeGenerate")
    @ResponseBody
    public ReturnT<Map<String, String>> codeGenerate(String tableSql,String packagePath) {
        System.out.print(packagePath);

        try {

            if (StringUtils.isBlank(tableSql)) {
                return new ReturnT<Map<String, String>>(ReturnT.FAIL_CODE, "表结构信息不可为空");
            }

            // parse table
            ClassInfo classInfo = CodeGeneratorTool.processTableIntoClassInfo(tableSql);

            // code genarete
            Map<String, Object> params = new HashMap<String, Object>();
            params.put("classInfo", classInfo);
            params.put("packagePath",packagePath);
            // result
            Map<String, String> result = new HashMap<String, String>();

            result.put("controller_code", FreemarkerUtil.processString("controller.ftl", params));
            result.put("service_code", FreemarkerUtil.processString("service.ftl", params));
            result.put("service_impl_code", FreemarkerUtil.processString("service_impl.ftl", params));

            result.put("dao_code", FreemarkerUtil.processString("dao.ftl", params));
            result.put("mybatis_code", FreemarkerUtil.processString("mybatis.ftl", params));
            result.put("model_code", FreemarkerUtil.processString("model.ftl", params));

            return new ReturnT<Map<String, String>>(result);
        } catch (IOException | TemplateException e) {
            logger.error(e.getMessage(), e);
            return new ReturnT<Map<String, String>>(ReturnT.FAIL_CODE, "表结构解析失败");
        }

    }


    /**
     * 构建返回文件Responce
     *
     * @throws UnsupportedEncodingException
     */
    protected void buildFileResponce(HttpServletResponse response, File file, String fileName) {
        response.setContentType("application/octet-stream ");
        response.setHeader("Connection", "close"); // 表示不能用浏览器直接打开
        response.setHeader("Accept-Ranges", "bytes");// 告诉客户端允许断点续传多线程连接下载
        response.setCharacterEncoding("UTF-8");
        try {
            response.addHeader("Content-Disposition",
                    "attachment;fileName=" + URLEncoder.encode(fileName, "UTF-8"));// 设置文件名
        }
        catch (UnsupportedEncodingException e) {
            throw new RuntimeException(e);
        }

        byte[] buffer = new byte[1024];
        FileInputStream fis = null;
        BufferedInputStream bis = null;
        try {
            fis = new FileInputStream(file);
            bis = new BufferedInputStream(fis);
            OutputStream os = response.getOutputStream();
            int i = bis.read(buffer);
            while (i != -1) {
                os.write(buffer, 0, i);
                i = bis.read(buffer);
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        finally {
            if (bis != null) {
                try {
                    bis.close();
                }
                catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if (fis != null) {
                try {
                    fis.close();
                }
                catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    public static void main(String[] args) throws Exception{
        String zipFile = System.getProperty("java.io.tmpdir") + File.separator
                + UUID.randomUUID() + ".zip";
//        ZipCompress zipCompress = new ZipCompress(zipFile,"C:\\Users\\Administrator\\AppData\\Local\\Temp\\f73a993e-c43e-46de-9fd1-a3e9fcccdd90");
//        zipCompress.zip();
//        System.out.print(zipFile);

        File file = new File("C:\\Users\\Administrator\\AppData\\Local\\Temp\\f73a993e-c43e-46de-9fd1-a3e9fcccdd90");

        ZipMultiFile.zipFiles(file.listFiles(),new File(zipFile));

        System.out.print(zipFile);
    }

}