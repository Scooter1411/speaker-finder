

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'closedAlignment.label', default: 'ClosedAlignment')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-closedAlignment" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-closedAlignment" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list closedAlignment">
			
				<g:if test="${closedAlignmentInstance?.rpre}">
				<li class="fieldcontain">
					<span id="rpre-label" class="property-label"><g:message code="closedAlignment.rpre.label" default="Rpre" /></span>
					
						<span class="property-value" aria-labelledby="rpre-label"><g:fieldValue bean="${closedAlignmentInstance}" field="rpre"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${closedAlignmentInstance?.dateCreated}">
				<li class="fieldcontain">
					<span id="dateCreated-label" class="property-label"><g:message code="closedAlignment.dateCreated.label" default="Date Created" /></span>
					
						<span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate date="${closedAlignmentInstance?.dateCreated}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${closedAlignmentInstance?.lastUpdated}">
				<li class="fieldcontain">
					<span id="lastUpdated-label" class="property-label"><g:message code="closedAlignment.lastUpdated.label" default="Last Updated" /></span>
					
						<span class="property-value" aria-labelledby="lastUpdated-label"><g:formatDate date="${closedAlignmentInstance?.lastUpdated}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${closedAlignmentInstance?.createdBy}">
				<li class="fieldcontain">
					<span id="createdBy-label" class="property-label"><g:message code="closedAlignment.createdBy.label" default="Created By" /></span>
					
						<span class="property-value" aria-labelledby="createdBy-label"><g:fieldValue bean="${closedAlignmentInstance}" field="createdBy"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${closedAlignmentInstance?.lastModifiedBy}">
				<li class="fieldcontain">
					<span id="lastModifiedBy-label" class="property-label"><g:message code="closedAlignment.lastModifiedBy.label" default="Last Modified By" /></span>
					
						<span class="property-value" aria-labelledby="lastModifiedBy-label"><g:fieldValue bean="${closedAlignmentInstance}" field="lastModifiedBy"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${closedAlignmentInstance?.qtc}">
				<li class="fieldcontain">
					<span id="qtc-label" class="property-label"><g:message code="closedAlignment.qtc.label" default="Qtc" /></span>
					
						<span class="property-value" aria-labelledby="qtc-label"><g:fieldValue bean="${closedAlignmentInstance}" field="qtc"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:closedAlignmentInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${closedAlignmentInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
