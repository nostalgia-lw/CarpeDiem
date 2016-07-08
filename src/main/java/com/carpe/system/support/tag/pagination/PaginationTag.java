package com.carpe.system.support.tag.pagination;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;
import java.io.IOException;
import java.util.Enumeration;

/**
 * 分页标签
 * @author tanghom
 */
public class PaginationTag extends TagSupport {
    /**
     * 序列化标记
     */
    private static final long serialVersionUID = -7338165728772121017L;
    /**
     * 请求URI
     */
    private String url;
    /**
     * 每页要显示的记录数
     */
    private int pageSize = 10;
    /**
     * 当前页号
     */
    private int pageNo = 1;
    /**
     * 总记录数
     */
    private int recordCount;

    @Override
    public int doStartTag() throws JspException {
        int pageCount=0;
        
        if(pageSize>0){
            pageCount = (recordCount + pageSize - 1) / pageSize; // 计算总页数
 
        }
        // 拼写要输出到页面的HTML文本
        StringBuilder sb = new StringBuilder();

        sb.append("<div style=\"float: right;\">\r\n");
        if (recordCount != 0) {
            // 页号越界处理
            if (pageNo > pageCount) {
                pageNo = pageCount;
            }
            if (pageNo < 1) {
                pageNo = 1;
            }

            sb.append("<form method=\"post\" action=\"").append(this.url)
                    .append("\" name=\"qPagerForm\">\r\n");
            // 获取请求中的所有参数
            HttpServletRequest request = (HttpServletRequest) pageContext
                    .getRequest();
            Enumeration<String> enumeration = request.getParameterNames();
            String name = null; // 参数名
            String value = null; // 参数值
            // 把请求中的所有参数当作隐藏表单域
            while (enumeration.hasMoreElements()) {
                name = enumeration.nextElement();
                value = request.getParameter(name);
                // 去除页号
                if (name.equals("pageNo")) {
                    if (null != value && !"".equals(value)) {
                        pageNo = Integer.parseInt(value);
                    }
                    continue;
                }
                sb.append("<input type=\"hidden\" name=\"").append(name)
                        .append("\" value=\"").append(value).append("\"/>\r\n");
            }

            

            // 上一页处理
            if (pageNo == 1) {
                sb.append("<span class=\"label label-default\">&lt;")
                        .append("</span>\r\n");
            } else {
                sb.append("<a href=\"javascript:turnOverPage(")
                        .append((pageNo - 1)).append(")\" class=\"label label-primary\">&lt;</a>\r\n");
            }

            // 如果前面页数过多,显示"..."
            int start = 1;
            if (this.pageNo > 4) {
                start = this.pageNo - 2;
                sb.append("<a href=\"javascript:turnOverPage(1)\" class=\"label label-primary\">1</a>\r\n");
                sb.append("&nbsp;&hellip;&nbsp;\r\n");
            }
            // 显示当前页附近的页
            int end = this.pageNo + 2;
            if (end > pageCount) {
                end = pageCount;
            }
            for (int i = start; i <= end; i++) {
                if (pageNo == i) { // 当前页号不需要超链接
                    sb.append("<span class=\"label label-danger\">").append(i)
                            .append("</span>\r\n");
                } else {
                    sb.append("<a href=\"javascript:turnOverPage(").append(i)
                            .append(")\" class=\"label label-primary\">").append(i).append("</a>\r\n");
                }
            }
            // 如果后面页数过多,显示"..."
            if (end < pageCount - 1) {
                sb.append("&hellip;\r\n");
            }
            if (end < pageCount) {
                sb.append("<a href=\"javascript:turnOverPage(")
                        .append(pageCount).append(")\" class=\"label label-primary\">").append(pageCount)
                        .append("</a>\r\n");
            }
            // 下一页处理
            if (pageNo == pageCount) {
                sb.append("<span class=\"label label-default\" >&gt;")
                        .append("</span>\r\n");
            } else {
                sb.append("<a href=\"javascript:turnOverPage(")
                        .append((pageNo + 1)).append(")\" class=\"label label-primary\">&gt;</a>\r\n");
            }
            
            // 跳页处理
            if(pageCount > 1){
            	 sb.append("<input type=\"text\" id=\"jumpNum\" value=\""+pageNo+"\" style=\"width: 30px;height: 24px;border-radius: 2px;border: 1px solid #ccc;text-align: center;\" onkeyup=\"this.value=this.value.replace(/[^\\d]/g,'') \" onafterpaste=\"this.value=this.value.replace(/[^\\d]/g,'') \" onblur=\"this.value=this.value.replace(/[^\\d]/g,'') \"/>\r\n")
             		.append("<a href=\"javascript:turnOverPage($('#jumpNum').val())\" class=\"label label-success\">").append("跳</a>\r\n");
            }
            
            // 输出统计数据
            sb.append("&nbsp;共<strong>").append(recordCount)
                    .append("</strong>项").append(",&nbsp;<strong>").append(pageCount)
                    .append("</strong>页&nbsp;\r\n");
            
            // 把当前页号设置成请求参数
            sb.append("<input type=\"hidden\" name=\"").append("pageNo")
                    .append("\" value=\"").append(pageNo).append("\"/>\r\n");
            sb.append("</form>\r\n");
            // 生成提交表单的JS
            sb.append("<script language=\"javascript\">\r\n");
            sb.append("function turnOverPage(no){\r\n");
            sb.append("if(no>").append(pageCount).append("){");
            sb.append("no=").append(pageCount).append(";}\r\n");
            sb.append("if(no<1 || no==''){no=1;}\r\n");
            sb.append("document.qPagerForm.pageNo.value=no;\r\n");
            sb.append("document.qPagerForm.submit();\r\n");
            sb.append("}\r\n");
            sb.append("</script>\r\n");
        }
        sb.append("</div>\r\n");

        // 把生成的HTML输出到响应中
        try {
            pageContext.getOut().println(sb.toString());
        } catch (IOException e) {
            throw new JspException(e);
        }
        return SKIP_BODY; // 本标签主体为空,所以直接跳过主体
    }

    /**
     * 设置请求地址
     * 
     * @param url
     *            请求地址
     */
    public void setUrl(String url) {
        this.url = url;
    }

    /**
     * 设置分页大小
     * 
     * @param pageSize
     *            分页大小
     */
    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    /**
     * 设置当前页
     * 
     * @param pageNo
     *            当前页
     */
    public void setPageNo(int pageNo) {
        this.pageNo = pageNo;
    }

    /**
     * 设置总记录数
     * 
     * @param recordCount
     *            总记录数
     */
    public void setRecordCount(int recordCount) {
        this.recordCount = recordCount;
    }
}
