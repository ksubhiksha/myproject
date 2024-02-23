<%@ page language="java" import="java.io.*,java.util.*"%>
<%
String mode = (String)request.getParameter("pageaction");
if(mode == null) mode = "";
String status = (String)request.getParameter("status");
if(status == null) status = "0";
String viewBy = (String)request.getParameter("viewBy");
if(viewBy == null) viewBy = "WEEK";
String ts_main_id = (String)request.getParameter("ts_main_id");
if(ts_main_id == null) ts_main_id = "0";

try 
{
	if("DB_VIEW_TS".equals(mode.trim()))
	{
		session.setAttribute("sesSaUser_TsStatus", status);
		session.setAttribute("sesSaUser_TsViewBy", viewBy);
	}else if("TS_LIST_TO_ENTRY".equals(mode.trim()))
	{
		session.setAttribute("sesSaUser_TsMainId", Integer.parseInt(ts_main_id));
	}
}catch(Exception e)
{
	System.out.println("Exception while setting the session variables in setsessionvariables.jsp :: " +e.getMessage());
}
 %>