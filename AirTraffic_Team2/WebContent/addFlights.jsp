<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="com.AirTraffic.Team2.Models.AirportBean"%>
<%@page import="com.AirTraffic.Team2.Models.FlightBean"%>
<%@page import="com.AirTraffic.Team2.Models.AirplaneBean"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.AirTraffic.Team2.Servlets.AddFlightServlet"%>

<jsp:useBean id="searchFlight" scope="request"
	class="com.AirTraffic.Team2.Models.FlightBean" />

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script
	src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<link rel="stylesheet" href="/resources/demos/style.css">
<link
	href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/ui-lightness/jquery-ui.css"
	rel="stylesheet" type="text/css" />
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.5/jquery.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"></script>
	<script src="Web Pages/gen_validatorv4.js"> </script>
	
<script type="text/javascript">
	function checkAirport(){
		var deptAirport = document.getElementById("departureAirport");
		var arrAirport = document.getElementById("arrivalAirport");
		
		
		/* alert("Please select different Departure & Arrival Airports"); */
		
		var deptAirportValue = deptAirport.options[deptAirport.selectedIndex].value;
        var arrAirportValue = arrAirport.options[arrAirport.selectedIndex].value;        
        
		if(deptAirportValue == arrAirportValue)
			{
			document.getElementById("addFlightbtn").disabled = true;
			alert("Please select different Departure & Arrival Airports");
			}
	}
</script>
	




<title>Add Flights</title>
</head>
<body>
	<div class="container">
		<div class="btn-group">
			<button type="button" class="btn btn-success" class="active"
				onclick="location.href='./searchFlight';">
				<span class="glyphicon glyphicon-plane" aria-hidden="true">Book
					Flight </span>
			</button>
			<button type="button" class="btn btn-success"
				onclick="location.href='./printTicket';">
				<span class="glyphicon glyphicon-print" aria-hidden="true">
					Print Ticket </span>
			</button>
			<button type="button" class="btn btn-success"
				onclick="location.href='./cancelBooking';">
				<span class="glyphicon glyphicon-scissors" aria-hidden="true">
					Cancel Booking </span>
			</button>
			<button type="button" class="btn btn-warning"
				onclick="location.href='./addFlights';">
				<span class="glyphicon glyphicon-plus-sign" aria-hidden="true">
					Add Flights </span>
			</button>
			<button type="button" class="btn btn-success"
				onclick="location.href='./assignRunway';">
				<span class="glyphicon glyphicon-king" aria-hidden="true">
					Assign Runway </span>
			</button>
		</div>
	</div>

	<div class="container">
		<div class="panel panel-default">
			<div class="panel-body"
				style="background: url(http://www.aldogroup.com/img/DREAMS%20TAKE%20FLIGHT/BANNER_DREAMS-TAKE-FLIGHT.jpg); background-size: cover;">

				<form method=post id="addFlightForm" action="addFlights">


					<%
						if (request.getAttribute("error") != null) {
					%>
					<h3>Something Went Wrong</h3>
					<!-- <%=request.getAttribute("error")%> -->
					<%
						} else {
							if(request.getAttribute("returnmsg")!=null && request.getAttribute("returnmsg").equals("success")){
					%>
					<h3>Flight Successfully Added </h3><br>
					<% 
						}									
							if(request.getAttribute("returnmsg")!=null && request.getAttribute("returnmsg").equals("false")){
								%>
								<h3>Something Went Wrong </h3><br>
								<% 
							}
							List<AirportBean> airportIataList = (ArrayList<AirportBean>) request.getAttribute("airportIataList");
					%>

					<div align="left">
					
					<table class = "table">
					<tr><td>
						Departure Airport
						</td>
						<td>
						<select name="departureAirport" id="departureAirport" onchange="checkAirport()">
							<%
								for (int i = 0; i < airportIataList.size(); i++) {
							%>
							<option value="<%=airportIataList.get(i).getAirport_iata()%>"><%=airportIataList.get(i).getAirport_iata()%></option>
							<%
								}
							%>
						</select> 
							</td>
						</tr><tr><td>
						
						
						Arrival Airport
						</td>
						<td>
						<select name="arrivalAirport" id="arrivalAirport" onchange="checkAirport()">
							<%
								for (int i = airportIataList.size() - 1; i >= 0; i--) {
							%>
							<option value="<%=airportIataList.get(i).getAirport_iata()%>"><%=airportIataList.get(i).getAirport_iata()%></option>
							<%
								}
							%>
						</select></td></tr>
<tr><td>
						<%
							List<AirplaneBean> airplaneList = (ArrayList<AirplaneBean>) request
										.getAttribute("airplaneList");
						%>

						Select Airplane</td>
						<td>
						 <select name="airplaneId">
							<%
								for (int i = 0; i < airplaneList.size(); i++) {
							%>
							<option value="<%=airplaneList.get(i).getAirplane_id()%>"><%=airplaneList.get(i).getAirplane_id()%></option>
							<%
								}
							%>
						</select> 
						</td></tr>
						<tr><td>						
						Flight Id
						</td><td>
						<div id='addFlightForm_flightId_errorloc' style="color: red;" class='error_strings'>
                       </div><br>  
						<input type="text" placeholder="Enter Flight Id" name="flightId" id="flightId"></td></tr>
						<tr><td> 
						Scheduled Departure Time </td><td><select name="scheduledDepartureHour"> 
							<%
								for (int i = 0; i < 24; i++) {
							%>
							<option value ="<%= i %>"><%= i %></option> 
							<%
								}
							%>
							</select>
							<select name="scheduledDepartureMin">						
							<%
							for (int i = 0; i < 60; i++) {
							%>
							<option value ="<%= i %>"><%= i %></option>
							<%
								}
								%>
								</select>
								<select name="scheduledDepartureSec">							
								<%
								for (int i = 0; i < 60; i++) {
							%>
								<option value ="<%= i %>"><%= i %></option>
							<%
								}
							
							%>
							</select></td></tr><tr><td>
						Scheduled Arrival Time</td><td> <select name="scheduledArrivalHour"> 
							<%
								for (int i = 0; i < 24; i++) {
							%>
							<option value ="<%= i %>"><%= i %></option> 
							<%
								}
							%>
							</select>
							<select name="scheduledArrivalMin">						
							<%
							for (int i = 0; i < 60; i++) {
							%>
							<option value ="<%= i %>"><%= i %></option>
							<%
								}
								%>
								</select>
								<select name="scheduledArrivalSec">							
								<%
								for (int i = 0; i < 60; i++) {
							%>
								<option value ="<%= i %>"><%= i %></option>
							<%
								}
							
							%>
							</select>
							</td>
							</tr>
							</table>
							<table class = "table">
							<tr><td>
							First Class Cabin luggage limit</td><td>
						Business Class Cabin luggage limit  </td><td>
						Economy Class Cabin luggage limit </td><td>
						</tr>
						<tr><td>
						<input type="text" name="firstclasscabinluggage"></td><td>
						<input type="text" name="businessclasscabinluggage"></td><td>
						<input type="text" name="economyclasscabinluggage"></td><td>
						</tr>
						<tr><td>
						First Class	Checkin luggage limit</td><td> 
						Business Class Checkin luggage limit</td><td> 
						Economy	Class Checkin luggage limit</td>
						</tr>
						<tr><td>
						<input type="text" name="firstclasscheckinluggage"></td><td>
						<input type="text" name="businessclasscheckinluggage"></td><td>
						<input type="text" name="economyclasscheckinluggage"></td>
				</tr>
					<tr><td>
							First Class Ticket price</td><td>
						Business Class Ticket price  </td><td>
						Economy Class Ticket price </td><td>
						</td></tr>
						<tr><td>
						<input type="text" name="firstclassPrice"></td><td>
						<input type="text" name="businessclassPrice"></td><td>
						<input type="text" name="economyclassPrice"></td><td>
						</td></tr>
	
			<tr>	
			<td>
			</table>
			<table class = "table">
			<tr><td colspan="6">
						Select flight scheduled days </td></tr>
						<tr><td>
						Sunday <input type="checkbox" name="flightDays" value="SUN"></td><td> 
						Monday <input type="checkbox" name="flightDays" value="MON"></td><td> 
						Tuesday <input type="checkbox" name="flightDays" value="TUES"> </td><td>
						Wednesday <input type="checkbox" name="flightDays" value="WEDNES"> </td><td>
						Thursday <input type="checkbox" name="flightDays" value="THURS"> </td><td>
						Friday <input type="checkbox" name="flightDays" value="FRI"></td><td>
						Saturday <input type="checkbox" name="flightDays" value="SATUR"> </td>

						<%
							}
						%>
						</tr>
			<tr><td colspan="6">
						<br> <br>
						<button type="submit" class="btn btn-info" name="addFlightbtn">
							<span class="glyphicon glyphicon-plus" aria-hidden="true">
								Add Flight </span>
						</button></td></tr>
</table>
					</div>
				</form>
			</div>
		</div>
	</div>
<script language="JavaScript" type="text/javascript">
  var frmvalidator  = new Validator("addFlightForm");
  frmvalidator.EnableOnPageErrorDisplay();
  frmvalidator.EnableMsgsTogether();
  
  frmvalidator.addValidation("flightId","req","Please enter flight id");
  frmvalidator.addValidation("flightId","maxlen=10","For flightId, Max length is 10"); 
   
</script>

</body>
</html>