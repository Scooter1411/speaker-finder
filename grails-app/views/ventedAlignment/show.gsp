

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'ventedAlignment.label', default: 'VentedAlignment')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-ventedAlignment" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-ventedAlignment" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list ventedAlignment">
			
				<g:if test="${ventedAlignmentInstance?.rpre}">
				<li class="fieldcontain">
					<span id="rpre-label" class="property-label"><g:message code="ventedAlignment.rpre.label" default="Rpre" /></span>
					
						<span class="property-value" aria-labelledby="rpre-label"><g:fieldValue bean="${ventedAlignmentInstance}" field="rpre"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${ventedAlignmentInstance?.dateCreated}">
				<li class="fieldcontain">
					<span id="dateCreated-label" class="property-label"><g:message code="ventedAlignment.dateCreated.label" default="Date Created" /></span>
					
						<span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate date="${ventedAlignmentInstance?.dateCreated}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${ventedAlignmentInstance?.lastUpdated}">
				<li class="fieldcontain">
					<span id="lastUpdated-label" class="property-label"><g:message code="ventedAlignment.lastUpdated.label" default="Last Updated" /></span>
					
						<span class="property-value" aria-labelledby="lastUpdated-label"><g:formatDate date="${ventedAlignmentInstance?.lastUpdated}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${ventedAlignmentInstance?.createdBy}">
				<li class="fieldcontain">
					<span id="createdBy-label" class="property-label"><g:message code="ventedAlignment.createdBy.label" default="Created By" /></span>
					
						<span class="property-value" aria-labelledby="createdBy-label"><g:fieldValue bean="${ventedAlignmentInstance}" field="createdBy"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${ventedAlignmentInstance?.lastModifiedBy}">
				<li class="fieldcontain">
					<span id="lastModifiedBy-label" class="property-label"><g:message code="ventedAlignment.lastModifiedBy.label" default="Last Modified By" /></span>
					
						<span class="property-value" aria-labelledby="lastModifiedBy-label"><g:fieldValue bean="${ventedAlignmentInstance}" field="lastModifiedBy"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${ventedAlignmentInstance?.vx}">
				<li class="fieldcontain">
					<span id="vx-label" class="property-label"><g:message code="ventedAlignment.vx.label" default="Vx" /></span>
					
						<span class="property-value" aria-labelledby="vx-label"><g:fieldValue bean="${ventedAlignmentInstance}" field="vx"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:ventedAlignmentInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${ventedAlignmentInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
