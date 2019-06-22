 ﻿<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
.pageTitle {
	margin-top: 0px;
}
</style>

<style type="text/css">
.fit-img {
	position: absolute;
	top: 0;
	right: 0;
	bottom: 0;
	left: 0;
	margin: auto;
	max-width: 60%;
	max-height: 60%
}

.fit-img-bottom {
	top: auto;
}

.fit-img-tight {
	max-width: 60%;
	max-height: 60%
}
</style>

<link
	href="${pageContext.request.contextPath}/resources/css/material-dashboard.css?v=2.1.1"
	rel="stylesheet" />
<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>
<body onload="searchReport()">

	<!--topLeft-nav-->
	<div class="sidebarOuter"></div>
	<!--topLeft-nav-->

	<!--wrapper-start-->
	<div class="wrapper">

		<!--topHeader-->
		<jsp:include page="/WEB-INF/views/include/logo.jsp">

			<jsp:param name="fr" value="${frDetails}" />
		</jsp:include>
		<c:url var="getDashboardCount" value="/getDashboardCount" />




		<!--topHeader-->

		<!--rightContainer-->
		<div class="fullGrid center">
			<!--fullGrid-->
			<div class="wrapperIn2">

				<jsp:include page="/WEB-INF/views/include/left.jsp">
					<jsp:param name="myMenu" value="${menuList}" />

				</jsp:include>

				<!--rightSidebar-->
				<div class="sidebarright">
					<div class="content">
						<div class="container-fluid">

							<div class="row">

								<div class="col1">
									<div class="col1title">
										<b>From&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b> <input
											id="fromdatepicker" placeholder="Delivery Date"
											name="from_Date" type="text" size="35" value="${frommonth}">
									</div>
								</div>
								<div class="col2">
									<div class="col1title">
										<b>TO&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b> <input
											id="todatepicker" placeholder="Delivery Date" name="to_Date"
											type="text" size="35" value="${tomonth}">
									</div>
								</div>


								<div align="center">
									<button class="btn search_btn" onclick="searchReport()">HTML
										View</button>
								</div>
							</div>
							<div class="row">
								<div class="latestNews">

									<h3 class="latestNewsTitle">Purchase value</h3>


								</div>
								<div class="col-lg-3 col-md-6 col-sm-6">
									<div class="card card-stats">


										<div class="card-category">
											<h2 style="font-size: 20px;">&nbsp;Purchase Value</h2>
											<h3 class="card-title">
												<span class="count" style="font-size: 22px;"
													id=prevActualTotal> <fmt:formatNumber type="number"
														maxFractionDigits="2" value="${frData.prevActualTotal}" />

												</span>
											</h3>
										</div>
										<div class="card-footer">
											<div class="stats" id="prevMonthName"></div>
										</div>
									</div>


								</div>

								<div class="col-lg-3 col-md-6 col-sm-6">
									<div class="card card-stats">


										<div class="card-category">
											<h2 style="font-size: 20px;">&nbsp;Purchase Value</h2>
											<h3 class="card-title">
												<span class="count" style="font-size: 22px;"
													id="curActualTotal"> <fmt:formatNumber type="number"
														maxFractionDigits="2" value="${frData.curActualTotal}" /></span>
											</h3>
										</div>
										<div class="card-footer">
											<div class="stats" id="curMonthName"></div>
										</div>
									</div>


								</div>
							</div>


							<div class="row">
								<div class="latestNews">

									<h3 class="latestNewsTitle">GRN Dashboard</h3>


								</div>
								<div class="col-lg-2 col-md-6 col-sm-6">
									<div class="card card-stats">

										<div class="card-category">
											<h2 style="font-size: 20px;">&nbsp;Total GRN Value</h2>

											<h3 class="card-title">
												<span class="count" style="font-size: 22px;"
													id="prevGrnTotal"> <fmt:formatNumber type="number"
														maxFractionDigits="2" value="${frData.prevGrnTotal}" /></span>
											</h3>

										</div>
										<div class="card-footer">
											<div class="stats" id="prevMonthName1"></div>
										</div>
									</div>
								</div>
								<div class="col-lg-2 col-md-6 col-sm-6">
									<div class="card card-stats">

										<div class="card-category">
											<h2 style="font-size: 20px;">&nbsp;Company Contribution</h2>


											<h3 class="card-title">
												<span class="count" style="font-size: 22px;"
													id="prevCompanyGrnContri"> <fmt:formatNumber
														type="number" maxFractionDigits="2"
														value="${frData.prevCompanyGrnContri}" /></span>
											</h3>
										</div>
										<div class="card-footer">
											<div class="stats" id="prevMonthName2"></div>
										</div>
									</div>
								</div>
								<div class="col-lg-2 col-md-6 col-sm-6">
									<div class="card card-stats">

										<div class="card-category">
											<h2 style="font-size: 20px;">&nbsp;Franchisee
												Contribution</h2>


											<h3 class="card-title">
												<span class="count" style="font-size: 22px;"
													id="prevFrGrnContribution"> <fmt:formatNumber
														type="number" maxFractionDigits="2"
														value="${frData.prevFrGrnContribution}" /></span>
											</h3>


										</div>
										<div class="card-footer">
											<div class="stats" id="prevMonthName3"></div>
										</div>
									</div>
								</div>

								<div class="col-lg-2 col-md-6 col-sm-6">
									<div class="card card-stats">

										<div class="card-category">
											<h2 style="font-size: 20px;">&nbsp;Return Percentage</h2>


											<h3 class="card-title">
												<span class="count" style="font-size: 22px;"
													id="prevReturnPerGrn"> <fmt:formatNumber
														type="number" maxFractionDigits="2"
														value="${frData.prevReturnPerGrn}" /></span>
											</h3>


										</div>
										<div class="card-footer">
											<div class="stats" id="prevMonthName4"></div>
										</div>
									</div>
								</div>



								<div class="col-lg-2 col-md-6 col-sm-6">
									<div class="card card-stats">

										<div class="card-category">
											<h2 style="font-size: 20px;">&nbsp;Target Return</h2>


											<h3 class="card-title">
												<span class="count" style="font-size: 22px;"
													id="preGrnTarget"> <fmt:formatNumber type="number"
														maxFractionDigits="2" value="${frData.preGrnTarget}" /></span>
											</h3>


										</div>
										<div class="card-footer">
											<div class="stats" id="prevMonthName5"></div>
										</div>
									</div>
								</div>
							</div>

							<div class="row">
								<div class="col-lg-2 col-md-6 col-sm-6">
									<div class="card card-stats">

										<div class="card-category">
											<h2 style="font-size: 20px;">&nbsp;Total GRN Value</h2>
											<h3 class="card-title">
												<span class="count" style="font-size: 22px;"
													id="curGrnTotal"> <fmt:formatNumber type="number"
														maxFractionDigits="2" value="${frData.curGrnTotal}" />
												</span>
											</h3>
										</div>
										<div class="card-footer">
											<div class="stats" id="curMonthName1"></div>
										</div>
									</div>
								</div>

								<div class="col-lg-2 col-md-6 col-sm-6">
									<div class="card card-stats">

										<div class="card-category">
											<h2 style="font-size: 20px;">&nbsp;Company Contribution</h2>
											<h3 class="card-title">
												<span class="count" style="font-size: 22px;"
													id="curCompanyGrnContri"> <fmt:formatNumber
														type="number" maxFractionDigits="2"
														value="${frData.curCompanyGrnContri}" />
												</span>
											</h3>
										</div>
										<div class="card-footer">
											<div class="stats" id="curMonthName2"></div>
										</div>
									</div>
								</div>

								<div class="col-lg-2 col-md-6 col-sm-6">
									<div class="card card-stats">

										<div class="card-category">
											<h2 style="font-size: 20px;">&nbsp; Franchisee
												Contribution</h2>
											<h3 class="card-title">
												<span class="count" style="font-size: 22px;"
													id="curFrGrnContribution"> <fmt:formatNumber
														type="number" maxFractionDigits="2"
														value="${frData.curFrGrnContribution}" />
												</span>
											</h3>

										</div>
										<div class="card-footer">
											<div class="stats" id="curMonthName3"></div>
										</div>
									</div>
								</div>

								<div class="col-lg-2 col-md-6 col-sm-6">
									<div class="card card-stats">

										<div class="card-category">
											<h2 style="font-size: 20px;">&nbsp; Return Percentage</h2>
											<h3 class="card-title">
												<span class="count" style="font-size: 22px;"
													id="curReturnPerGrn"> <fmt:formatNumber
														type="number" maxFractionDigits="2"
														value="${frData.curReturnPerGrn}" />
												</span>
											</h3>

										</div>
										<div class="card-footer">
											<div class="stats" id="curMonthName4"></div>
										</div>
									</div>
								</div>



								<div class="col-lg-2 col-md-6 col-sm-6">
									<div class="card card-stats">

										<div class="card-category">
											<h2 style="font-size: 20px;">&nbsp; Target Return</h2>
											<h3 class="card-title">
												<span class="count" style="font-size: 22px;"
													id="curGrnTarget"> <fmt:formatNumber type="number"
														maxFractionDigits="2" value="${frData.curGrnTarget}" />
												</span>
											</h3>

										</div>
										<div class="card-footer">
											<div class="stats" id="curMonthName5"></div>
										</div>
									</div>
								</div>
							</div>



							<div class="row">
								<div class="latestNews">

									<h3 class="latestNewsTitle">GVN Dashboard</h3>


								</div>
								<div class="col-lg-2 col-md-6 col-sm-6">
									<div class="card card-stats">

										<div class="card-category">
											<h2 style="font-size: 20px;">&nbsp;Total GVN Value</h2>
											<h3 class="card-title">
												<span class="count" style="font-size: 22px;"
													id="prevGvnTotal"> <fmt:formatNumber type="number"
														maxFractionDigits="2" value="${frData.prevGvnTotal}" />
												</span>
											</h3>

										</div>
										<div class="card-footer">
											<div class="stats" id="prevMonthName8"></div>
										</div>
									</div>
								</div>

								<div class="col-lg-2 col-md-6 col-sm-6">
									<div class="card card-stats">

										<div class="card-category">
											<h2 style="font-size: 20px;">&nbsp;Total GVN Value</h2>

											<h3 class="card-title">
												<span class="count" style="font-size: 22px;"
													id="curGvnTotal"> <fmt:formatNumber type="number"
														maxFractionDigits="2" value="${frData.curGvnTotal}" />
												</span>
											</h3>
										</div>
										<div class="card-footer">
											<div class="stats" id="curMonthName6"></div>
										</div>
									</div>
								</div>

							</div>



							<div class="row">
								<div class="latestNews">

									<h3 class="latestNewsTitle">Sales Dashboard</h3>


								</div>
								<div class="col-lg-2 col-md-6 col-sm-6">
									<div class="card card-stats">

										<div class="card-category">
											<h2 style="font-size: 20px;">&nbsp; Sale Target Value</h2>

											<h3 class="card-title">
												<span class="count" style="font-size: 22px;"
													id="preSaleTarget"> <fmt:formatNumber type="number"
														maxFractionDigits="2" value="${frData.preSaleTarget}" />
												</span>
											</h3>


										</div>
										<div class="card-footer">
											<div class="stats" id="prevMonthName6"></div>
										</div>
									</div>
								</div>

								<div class="col-lg-2 col-md-6 col-sm-6">
									<div class="card card-stats">

										<div class="card-category">
											<h2 style="font-size: 20px;">&nbsp;Expected Sale Value</h2>

											<h3 class="card-title">
												<span class="count" style="font-size: 22px;"
													id="expectedPrevActualTotal"> <fmt:formatNumber
														type="number" maxFractionDigits="2"
														value="${frData.expectedPrevActualTotal}" />
												</span>
											</h3>

										</div>
										<div class="card-footer">
											<div class="stats" id="prevMonthName7"></div>
										</div>
									</div>
								</div>



								<div class="col-lg-2 col-md-6 col-sm-6">
									<div class="card card-stats">

										<div class="card-category">
											<h2 style="font-size: 20px;">&nbsp; Sale Target Value</h2>

											<h3 class="card-title">
												<span class="count" style="font-size: 22px;"
													id="curSaleTarget"> <fmt:formatNumber type="number"
														maxFractionDigits="2" value="${frData.curSaleTarget}" />
												</span>
											</h3>


										</div>
										<div class="card-footer">
											<div class="stats" id="curMonthName7"></div>
										</div>
									</div>
								</div>

								<div class="col-lg-2 col-md-6 col-sm-6">
									<div class="card card-stats">

										<div class="card-category">
											<h2 style="font-size: 20px;">&nbsp; Expected Sale Value</h2>

											<h3 class="card-title">
												<span class="count" style="font-size: 22px;"
													id="expectedCurActualTotal"> <fmt:formatNumber
														type="number" maxFractionDigits="2"
														value="${frData.expectedCurActualTotal}" />
												</span>
											</h3>


										</div>
										<div class="card-footer">
											<div class="stats" id="curMonthName8"></div>
										</div>
									</div>
								</div>
								<%-- 
							<div class="col-lg-2 col-md-6 col-sm-6">
								<div class="card card-stats">

									<div class="card-category">
										<h2 style="font-size: 20px;">&nbsp;Punched Sale Value</h2>

										<h3 class="card-title">
											<span class="count" style="font-size: 22px;"
												id="calCurSaleSpGrandTotal"> <fmt:formatNumber
													type="number" maxFractionDigits="2"
													value="${frData.calCurSaleSpGrandTotal}" />
											</span>
										</h3>


									</div>
									<div class="card-footer">
										<div class="stats">Current Month</div>
									</div>
								</div>
							</div>
 --%>

							</div>


							<div class="row">
								<div class="col-lg-3 col-md-6 col-sm-6">
									<div class="card card-stats">

										<div class="card-category">
											<h2 style="font-size: 20px;">&nbsp;School Visit</h2>

											<h3 class="card-title">
												<span class="count" style="font-size: 22px;"
													id="curSchoolTarget"> <fmt:formatNumber
														type="number" maxFractionDigits="2"
														value="${frData.curSchoolTarget}" />
												</span>
											</h3>


										</div>
										<div class="card-footer">
											<div class="stats">Current Year(Jan to Dec)</div>
										</div>
									</div>
								</div>
								<div class="col-lg-3 col-md-6 col-sm-6">
									<div class="card card-stats">

										<div class="card-category">
											<h2 style="font-size: 20px;">&nbsp;Achieved School Visit</h2>

											<h3 class="card-title">
												<span class="count" style="font-size: 22px;"
													id="curAchSchoolTarget"> <fmt:formatNumber
														type="number" maxFractionDigits="2"
														value="${frData.curAchSchoolTarget}" />
												</span>
											</h3>

										</div>
										<div class="card-footer">
											<div class="stats">Current Year(Jan to Dec)</div>
										</div>
									</div>
								</div>


								<div class="col-lg-3 col-md-6 col-sm-6">
									<div class="card card-stats">

										<div class="card-category">
											<h2 style="font-size: 20px;">&nbsp;Pending School Visit</h2>

											<h3 class="card-title">
												<span class="count" style="font-size: 22px;"
													id="penCurSchoolTarget"> <fmt:formatNumber
														type="number" maxFractionDigits="2"
														value="${(frData.curSchoolTarget)-(frData.curAchSchoolTarget)}" />
												</span>
											</h3>

										</div>
										<div class="card-footer">
											<div class="stats">Current Year(Jan to Dec)</div>
										</div>
									</div>
								</div>




							</div>

						</div>


					</div>
				</div>
				<!--rightSidebar-->

			</div>
			<!--fullGrid-->
		</div>
		<!--rightContainer-->

	</div>
	<!--wrapper-end-->

	<script type="text/javascript"
		src="https://www.gstatic.com/charts/loader.js"></script>
	<script type="text/javascript">
		var achievedTarget = document.getElementById("achievedTarget").value;
		var target = document.getElementById("target").value;
		var monthTarget = target;
		google.charts.load('current', {
			packages : [ 'corechart', 'bar' ]
		});
		google.charts.setOnLoadCallback(drawMultSeries);

		function drawMultSeries() {

			achievedTarget = Math.ceil(achievedTarget);

			if (achievedTarget >= target) {

				target = 0;
			} else {

				target = target - achievedTarget;

			}

			var data = google.visualization.arrayToDataTable([
					[ 'Target In Lakhs', 'Assigned Target' ],
					[ 'Monthly Target:' + monthTarget, target ],
					[ 'Achieved Target:' + achievedTarget, achievedTarget ], ]);

			var options = {
				title : 'Franchise Target',
				chartArea : {
					width : '1220',
					height : '1220'
				},
				hAxis : {
					title : 'Target Details',
					minValue : 0
				},
				vAxis : {
					title : 'Target In Lakhs'
				}

			};

			var chart = new google.visualization.PieChart(document
					.getElementById('chart_div'));

			chart.draw(data, options);
		}
	</script>

	<script type="text/javascript">
		// onclick of submit to search order 
		function searchReport() {

			var fromDate = document.getElementById("fromdatepicker").value;
			var toDate = document.getElementById("todatepicker").value;

			//alert("fromdatepicker" + fromDate);
			//alert("todatepicker" + toDate);

			var valid = true;

			if (fromDate == null || fromDate == "") {
				valid = false;
				alert("Please select from date");
			}

			else if (toDate == null || toDate == "") {
				valid = false;
				alert("Please select to date");
			}

			if (fromDate > toDate) {
				valid = false;
				alert("from date greater than todate ");
			}
			if (valid == true) {

				$
						.getJSON(
								'${getDashboardCount}',
								{

									fromDate : fromDate,
									toDate : toDate,
									ajax : 'true',

								},

								function(data) {

									document.getElementById("prevActualTotal").innerText = data.prevActualTotal
											.toFixed(0);
									document.getElementById("curActualTotal").innerText = data.curActualTotal
											.toFixed(0);
									document.getElementById("prevGrnTotal").innerText = data.prevGrnTotal
											.toFixed(0);
									document
											.getElementById("prevCompanyGrnContri").innerText = data.prevCompanyGrnContri
											.toFixed(0);
									document
											.getElementById("prevFrGrnContribution").innerText = data.prevFrGrnContribution
											.toFixed(0);

									document.getElementById("prevReturnPerGrn").innerText = data.prevReturnPerGrn;

									document.getElementById("preGrnTarget").innerText = data.preGrnTarget
											.toFixed(0);

									document.getElementById("curGrnTotal").innerText = data.curGrnTotal
											.toFixed(0);
									document
											.getElementById("curCompanyGrnContri").innerText = data.curCompanyGrnContri
											.toFixed(0);
									document
											.getElementById("curFrGrnContribution").innerText = data.curFrGrnContribution
											.toFixed(0);

									document.getElementById("curReturnPerGrn").innerText = data.curReturnPerGrn;

									document.getElementById("curGrnTarget").innerText = data.curGrnTarget
											.toFixed(0);
									document.getElementById("prevGvnTotal").innerText = data.prevGvnTotal
											.toFixed(0);

									document.getElementById("curGvnTotal").innerText = (data.curGvnTotal)
											.toFixed(0);

									document.getElementById("preSaleTarget").innerText = (data.preSaleTarget)
											.toFixed(0);

									document
											.getElementById("expectedPrevActualTotal").innerText = (data.expectedPrevActualTotal)
											.toFixed(0);

									document.getElementById("curSaleTarget").innerText = (data.curSaleTarget)
											.toFixed(0);

									document
											.getElementById("expectedCurActualTotal").innerText = (data.expectedCurActualTotal)
											.toFixed(0);

									document.getElementById("curSchoolTarget").innerText = (data.curSchoolTarget)
											.toFixed(0);

									document
											.getElementById("curAchSchoolTarget").innerText = (data.curAchSchoolTarget)
											.toFixed(0);

									document
											.getElementById("penCurSchoolTarget").innerText = (data.curSchoolTarget - data.curAchSchoolTarget)
											.toFixed(0);

									document.getElementById("prevMonthName").innerText = data.prevMonthName
									document.getElementById("prevMonthName1").innerText = data.prevMonthName
									document.getElementById("prevMonthName2").innerText = data.prevMonthName
									document.getElementById("prevMonthName3").innerText = data.prevMonthName
									document.getElementById("prevMonthName4").innerText = data.prevMonthName
									document.getElementById("prevMonthName5").innerText = data.prevMonthName
									document.getElementById("prevMonthName6").innerText = data.prevMonthName
									document.getElementById("prevMonthName7").innerText = data.prevMonthName
									document.getElementById("prevMonthName8").innerText = data.prevMonthName

									document.getElementById("curMonthName").innerText = data.curMonthName
									document.getElementById("curMonthName1").innerText = data.curMonthName
									document.getElementById("curMonthName2").innerText = data.curMonthName
									document.getElementById("curMonthName3").innerText = data.curMonthName
									document.getElementById("curMonthName4").innerText = data.curMonthName
									document.getElementById("curMonthName5").innerText = data.curMonthName
									document.getElementById("curMonthName6").innerText = data.curMonthName
									document.getElementById("curMonthName7").innerText = data.curMonthName
									document.getElementById("curMonthName8").innerText = data.curMonthName

								});

			}//end of if valid ==true

		}
	</script>
	<script>
		$(document)
				.ready(
						function() {
							$('#fromdatepicker')
									.datepicker(
											{
												changeMonth : true,
												changeYear : true,
												dateFormat : 'mm-yy',

												onClose : function() {
													var iMonth = $(
															"#ui-datepicker-div .ui-datepicker-month :selected")
															.val();
													var iYear = $(
															"#ui-datepicker-div .ui-datepicker-year :selected")
															.val();
													$(this).datepicker(
															'setDate',
															new Date(iYear,
																	iMonth, 1));
												},

												beforeShow : function() {
													$('#ui-datepicker-div')
															.addClass(
																	'hide-calendar');

													/*  if ((selDate = $(this).val()).length > 0) 
													 {
													    iYear = selDate.substring(selDate.length - 4, selDate.length);
													    iMonth = jQuery.inArray(selDate.substring(0, selDate.length - 5), $(this).datepicker('option', 'monthNames'));
													    $(this).datepicker('option', 'defaultDate', new Date(iYear, iMonth, 1));
													     $(this).datepicker('setDate', new Date(iYear, iMonth, 1));
													 } */
												}
											});
						});
	</script>

	<script>
		$(document)
				.ready(
						function() {
							$('#todatepicker')
									.datepicker(
											{
												changeMonth : true,
												changeYear : true,
												dateFormat : 'mm-yy',

												onClose : function() {
													var iMonth = $(
															"#ui-datepicker-div .ui-datepicker-month :selected")
															.val();
													var iYear = $(
															"#ui-datepicker-div .ui-datepicker-year :selected")
															.val();
													$(this).datepicker(
															'setDate',
															new Date(iYear,
																	iMonth, 1));
												},

												beforeShow : function() {
													$('#ui-datepicker-div')
															.addClass(
																	'hide-calendar');

													/*   if ((selDate = $(this).val()).length > 0) 
													  {
													     iYear = selDate.substring(selDate.length - 4, selDate.length);
													     iMonth = jQuery.inArray(selDate.substring(0, selDate.length - 5), $(this).datepicker('option', 'monthNames'));
													     $(this).datepicker('option', 'defaultDate', new Date(iYear, iMonth, 1));
													     $(this).datepicker('setDate', new Date(iYear, iMonth, 1));
													  } */
												}
											});
						});
	</script>

</body>
</html>
