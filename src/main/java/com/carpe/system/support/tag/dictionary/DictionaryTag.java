package com.carpe.system.support.tag.dictionary;

import com.cddgg.system.util.EhcacheUtils;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;
import java.io.IOException;
import java.util.List;

public class DictionaryTag extends TagSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 2434167440210964353L;
	
	private String code;
	@Override
	public int doStartTag() throws JspException {
			try {
				List keys = EhcacheUtils.getKeys();
				for (int i = 0; i < keys.size(); i++) {
					System.out.println(EhcacheUtils.get(keys.get(i)));
				}
				String codeValue = (String) EhcacheUtils.get(code);
				pageContext.getOut().println(codeValue==null?code:codeValue);
			} catch (IOException e) {
				throw new JspException(e);
			}
			return super.doStartTag();
	}
	public void setCode(String code) {
		this.code = code;
	}

}
