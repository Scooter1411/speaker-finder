

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'tube.label', default: 'Tube')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-tube" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-tube" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list tube">
			
				<g:if test="${tubeInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="tube.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${tubeInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${tubeInstance?.diameter}">
				<li class="fieldcontain">
					<span id="diameter-label" class="property-label"><g:message code="tube.diameter.label" default="Diameter" /></span>
					
						<span class="property-value" aria-labelledby="diameter-label"><g:fieldValue bean="${tubeInstance}" field="diameter"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${tubeInstance?.dateCreated}">
				<li class="fieldcontain">
					<span id="dateCreated-label" class="property-label"><g:message code="tube.dateCreated.label" default="Date Created" /></span>
					
						<span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate date="${tubeInstance?.dateCreated}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${tubeInstance?.lastUpdated}">
				<li class="fieldcontain">
					<span id="lastUpdated-label" class="property-label"><g:message code="tube.lastUpdated.label" default="Last Updated" /></span>
					
						<span class="property-value" aria-labelledby="lastUpdated-label"><g:formatDate date="${tubeInstance?.lastUpdated}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${tubeInstance?.createdBy}">
				<li class="fieldcontain">
					<span id="createdBy-label" class="property-label"><g:message code="tube.createdBy.label" default="Created By" /></span>
					
						<span class="property-value" aria-labelledby="createdBy-label"><g:fieldValue bean="${tubeInstance}" field="createdBy"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${tubeInstance?.lastModifiedBy}">
				<li class="fieldcontain">
					<span id="lastModifiedBy-label" class="property-label"><g:message code="tube.lastModifiedBy.label" default="Last Modified By" /></span>
					
						<span class="property-value" aria-labelledby="lastModifiedBy-label"><g:fieldValue bean="${tubeInstance}" field="lastModifiedBy"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${tubeInstance?.area}">
				<li class="fieldcontain">
					<span id="area-label" class="property-label"><g:message code="tube.area.label" default="Area" /></span>
					
						<span class="property-value" aria-labelledby="area-label"><g:fieldValue bean="${tubeInstance}" field="area"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:tubeInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${tubeInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
