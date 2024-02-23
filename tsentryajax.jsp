<%@ page language="java" import="java.io.*,java.util.*,java.text.*,com.saapps.task.Timesheet"%>
<jsp:useBean id="TS" class="com.saapps.task.Timesheet" scope="request"/>
<jsp:setProperty name="TS" property="*"/> 
<%

String sesSaUser_FirstName = (String)session.getAttribute("sesSaUser_FirstName");
if(sesSaUser_FirstName == null){
	response.sendRedirect("sessionexpire.jsp");
}else
{
	Integer sesSaUser_User_Id = (Integer)session.getAttribute("sesSaUser_User_Id");
	if(sesSaUser_User_Id == null)sesSaUser_User_Id =0;
	Integer sesSaUser_UserTypeId = (Integer)session.getAttribute("sesSaUser_UserTypeId");
	if(sesSaUser_UserTypeId == null)sesSaUser_UserTypeId =0;
	int sesSaUser_TsMainId = (Integer)session.getAttribute("sesSaUser_TsMainId");
	String mode = (String)request.getParameter("pageaction");
	if(mode == null) mode = "";
	String msg = "";
	List lstTs = new ArrayList();
	DecimalFormat decimalFormat = new DecimalFormat("#0.00");
	try 
	{
		int timesheet_main_id = 0;
  		String timesheet_date = "";
  		int timesheet_day_of_week = 0;
  		int user_id = 0;
  		String user_name = "";
  		double worked_hours = 0;
  		int timesheet_status_id = 0;
  		String timesheet_status = "";
  		int submitted_by_id =0;
  		String submitted_by = "";
  		String submitted_date = "";
  		int approved_by_id =0;
  		String approved_by = "";
  		String approved_date = "";
  		int is_current_week =0;
  		int is_enable_date =0;
  		
  		int is_ts_saved = 0;
		if("TS_ENTRY_LIST".equals(mode.trim()) && sesSaUser_TsMainId > 0)
		{
			lstTs = TS.getTimesheetMainInfo(sesSaUser_User_Id, sesSaUser_UserTypeId, sesSaUser_TsMainId);
			String statusLabelClass = "";String addIconClass = "";
      		
      		
      		Iterator itsTs = lstTs.iterator();
    		while(itsTs.hasNext())
    		{
    			timesheet_main_id = (Integer)itsTs.next();
    			timesheet_date = (String)itsTs.next();
    			timesheet_day_of_week = (Integer)itsTs.next();
    			user_id = (Integer)itsTs.next();
    			user_name = (String)itsTs.next();
    			worked_hours = (Double)itsTs.next();
    			timesheet_status_id = (Integer)itsTs.next();
    			timesheet_status = (String)itsTs.next();
    			
    			submitted_by_id = (Integer)itsTs.next();
    			submitted_by = (String)itsTs.next();
    			submitted_date = (String)itsTs.next();
    			
    			approved_by_id = (Integer)itsTs.next();
    			approved_by = (String)itsTs.next();
    			approved_date = (String)itsTs.next();
    			
    			is_current_week = (Integer)itsTs.next();
    			is_enable_date = (Integer)itsTs.next();
    			is_ts_saved = (Integer)itsTs.next();
    			
    			statusLabelClass = "label-success"; // for open
    			if(timesheet_status_id == 1)
       			{
       				statusLabelClass = "label-warning";
       			}else if(timesheet_status_id == 2)
       			{
       				statusLabelClass = "label-primary";
       			}else if(timesheet_status_id == 3){
       				statusLabelClass = "label-danger";
       			}else if(timesheet_status_id == 4){
       				statusLabelClass = "label-default";
       			}
    			
    			addIconClass = "fa-plus";
    			if(is_ts_saved == 1)
       			{
    				addIconClass = "fa-pencil-square-o";
       			}
    		}
			%>
			<div class="wrapper wrapper-content animated fadeInRight">
        	<div class="row">
             	<div class="ibox float-e-margins col-lg-12" id="listDiv">
					<div class="ibox-content">	
					<div class="row" style="margin-bottom:20px;">
					
						<div class="col-lg-12 col-md-12">
							<table class="table table-striped">
				                <tbody>
					                <tr>
					                    <td>
					                        <div style="margin-bottom:10px;"><b>User Name</b></div><span class="btn btn-primary btn-sm" style=""><%=user_name%></span>
					                    </td>
					                    <td>
					                        <div style="margin-bottom:10px;"><b>Timesheet Date</b></div><span class="btn btn-danger btn-sm" style=""><%=timesheet_date%></span>
					                    </td>
					                    <td>
					                        <div style="margin-bottom:10px;"><b>Status</b></div><span class="btn btn-warning btn-sm" style=""><%=timesheet_status%></span>
					                    </td>
					                     <td>
					                        <div style="margin-bottom:10px;"><b>Total Hours</b></div><span class="btn btn-success btn-sm" style="width:60px;"><%=decimalFormat.format(worked_hours)%></span>
					                    </td>
					                </tr>
				                </tbody>
				            </table>
						</div>
					
					</div>
						<%-- <div class="row" style="margin-bottom:0px;">
	                     <%
	                     if(lstTs.size() > 0)
	                     {
	                     %>
	                     	<div class="table-responsive">
								<table class="table table-striped table-bordered table-hover" data-paging="true" data-filter=#filter id="tblTs">
									<thead>
		                           		<tr>
		                               		<th title="Sort by Date" class="text-center">Date</th>
		                               		<%
						                     if(sesSaUser_UserTypeId != 4)
						                     {
						                     %>
		                               		<th title="Sort by User" class="text-center">User</th>
		                               		<%
						                     }
		                               		%>
		                               		<th title="Sort by Hours" class="text-center">Hours</th>
		                               		<th title="Sort by Status" class="text-center">Status</th>
		                               		<th title="Sort by Subitted By" class="text-center">Subitted By</th>  
		                               		<th title="Sort by Subitted Date" class="text-center">Subitted Date</th>    
		                               		<th class="text-center" style="background-color: #fff;">Actions</th>                                      
		                           		</tr>
		                      		</thead>
									<tbody>
									<%
		                          		Iterator itsTs = lstTs.iterator();
		                        		while(itsTs.hasNext())
		                        		{
		                        			timesheet_main_id = (Integer)itsTs.next();
		                        			timesheet_date = (String)itsTs.next();
		                        			timesheet_day_of_week = (Integer)itsTs.next();
		                        			user_id = (Integer)itsTs.next();
		                        			user_name = (String)itsTs.next();
		                        			worked_hours = (Double)itsTs.next();
		                        			timesheet_status_id = (Integer)itsTs.next();
		                        			timesheet_status = (String)itsTs.next();
		                        			
		                        			submitted_by_id = (Integer)itsTs.next();
		                        			submitted_by = (String)itsTs.next();
		                        			submitted_date = (String)itsTs.next();
		                        			
		                        			approved_by_id = (Integer)itsTs.next();
		                        			approved_by = (String)itsTs.next();
		                        			approved_date = (String)itsTs.next();
		                        			
		                        			is_current_week = (Integer)itsTs.next();
		                        			is_enable_date = (Integer)itsTs.next();
		                        			is_ts_saved = (Integer)itsTs.next();
		                        			
		                        			statusLabelClass = "label-success"; // for open
		                        			if(timesheet_status_id == 1)
		                           			{
		                           				statusLabelClass = "label-warning";
		                           			}else if(timesheet_status_id == 2)
		                           			{
		                           				statusLabelClass = "label-primary";
		                           			}else if(timesheet_status_id == 3){
		                           				statusLabelClass = "label-danger";
		                           			}else if(timesheet_status_id == 4){
		                           				statusLabelClass = "label-default";
		                           			}
		                        			
		                        			addIconClass = "fa-plus";
		                        			if(is_ts_saved == 1)
		                           			{
		                        				addIconClass = "fa-pencil-square-o";
		                           			}
		                        			
										%>
											<tr class="gradeX">
										   		<td style="text-align:center;vertical-align: middle;"><%=timesheet_date%></td>
										   		<%
							                     if(sesSaUser_UserTypeId != 4)
							                     {
							                     %>
										   		<td style="text-align:left;vertical-align: middle;"><%=user_name%></td>
										   		<%
							                     }
			                               		%>
										   		<td style="text-align:right;vertical-align: middle;"><%=decimalFormat.format(worked_hours)%></td>
										   		<td style="text-align:center;vertical-align: middle;"><span class="label label-primary" style="display:inline-block;width:80px;"><%=timesheet_status%></span></td>
										   		<td style="text-align:left;vertical-align: middle;"><%=submitted_by%></td>
										   		<td style="text-align:center;vertical-align: middle;"><%=submitted_date%></td>
										   		<td style="text-align:center;vertical-align: middle;">
										   			<%
								                     if(is_enable_date > 0)
								                     {
								                     %>
										   			<i class="fa <%=addIconClass%>" onclick="javascript:funEditProject('<%=timesheet_main_id%>');" aria-hidden="true" data-toggle="tooltip" data-placement="left" data-original-title="Click to edit" style="color: #1c84c6;cursor: pointer;font-size: 16px;vertical-align: middle;"></i>
										   			<%
								                     }else
								                     {
				                               		%>
				                               		<i class="fa <%=addIconClass%>" style="color:#CCC;cursor: pointer;font-size: 16px;vertical-align: middle;"></i>
				                               		<%
								                     }
				                               		%>
										   		</td>
										   		
										 	</tr>						  
										<%
											}
										%>  
		                     		</tbody>
								</table>
							</div>
	                     <%
	                     }else
	                     {
	                     %>
								<div class="col-lg-4 col-md-4 col-sm-12 col-xl-12" align="center">
									<div class="float-e-margins">									
											<div class="col-lg-3 col-md-3 col-sm-2 col-xl-1"></div>
											<div class="col-lg-6 col-md-6 col-sm-8 col-xl-10">
												<div class="alert alert-danger" style="text-align:center">
													Timesheet not available.
												</div>
											</div>
											<div class="col-lg-3 col-md-3 col-sm-2 col-xl-1"></div>									
									</div>
								</div>
	                     <%
	                     }
	                     %>                         	
                         </div> --%>
					</div>
		 		</div>
        	</div>
     	</div>
			<%
		}
	}catch(Exception e)
	{
		System.out.println("Exception while getting information in tsentryajax.jsp :: " +e.getMessage());
	}
}
 %>