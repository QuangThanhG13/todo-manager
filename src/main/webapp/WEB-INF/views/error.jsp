<%@ include file="common/header.jspf"%>
<%@ include file="common/navigation.jspf"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="container">
	<div style="margin-top: 100px; text-align: center; padding: 30px; background-color: #ffffff; border-radius: 10px; box-shadow: 0 5px 15px rgba(0,0,0,0.1);">
		<h2 style="color: #dc3545; margin-bottom: 20px;">Application Error</h2>
		<p style="color: #333; font-size: 16px;">The application has encountered an error. Please contact support for assistance.</p>
		
		<c:if test="${not empty errorMessage}">
			<div style="margin-top: 30px; text-align: left; padding: 15px; background-color: #f8f9fa; border-radius: 5px; border-left: 4px solid #dc3545;">
				<p><strong>Error Type:</strong> ${errorType}</p>
				<p><strong>Error Message:</strong> ${errorMessage}</p>
				<p><strong>Request URL:</strong> ${requestUrl}</p>
			</div>
		</c:if>
		
		<a href="/" class="btn btn-primary" style="margin-top: 20px; display: inline-block; padding: 8px 16px; background-color: #007bff; color: white; text-decoration: none; border-radius: 4px;">Return to Home</a>
	</div>
</div>

<script src="webjars/jquery/1.9.1/jquery.min.js"></script>
<script src="webjars/bootstrap/3.3.6/js/bootstrap.min.js"></script>