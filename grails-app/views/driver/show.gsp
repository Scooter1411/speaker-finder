

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'driver.label', default: 'Driver')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-driver" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-driver" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list driver">
			
<<<<<<< HEAD
				<g:if test="${driverInstance?.maker}">
				<li class="fieldcontain">
					<span id="maker-label" class="property-label"><g:message code="driver.maker.label" default="Maker" /></span>
					
						<span class="property-value" aria-labelledby="maker-label"><g:link controller="maker" action="show" id="${driverInstance?.maker?.id}">${driverInstance?.maker?.encodeAsHTML()}</g:link></span>
=======
				<g:if test="${driverInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="driver.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${driverInstance}" field="name"/></span>
>>>>>>> 31a21eb335dfb7b03323bd9498ef71be639a1d9b
					
				</li>
				</g:if>
			
				<g:if test="${driverInstance?.dateCreated}">
				<li class="fieldcontain">
					<span id="dateCreated-label" class="property-label"><g:message code="driver.dateCreated.label" default="Date Created" /></span>
					
						<span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate date="${driverInstance?.dateCreated}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${driverInstance?.lastUpdated}">
				<li class="fieldcontain">
					<span id="lastUpdated-label" class="property-label"><g:message code="driver.lastUpdated.label" default="Last Updated" /></span>
					
						<span class="property-value" aria-labelledby="lastUpdated-label"><g:formatDate date="${driverInstance?.lastUpdated}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${driverInstance?.createdBy}">
				<li class="fieldcontain">
					<span id="createdBy-label" class="property-label"><g:message code="driver.createdBy.label" default="Created By" /></span>
					
						<span class="property-value" aria-labelledby="createdBy-label"><g:fieldValue bean="${driverInstance}" field="createdBy"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${driverInstance?.lastModifiedBy}">
				<li class="fieldcontain">
					<span id="lastModifiedBy-label" class="property-label"><g:message code="driver.lastModifiedBy.label" default="Last Modified By" /></span>
					
						<span class="property-value" aria-labelledby="lastModifiedBy-label"><g:fieldValue bean="${driverInstance}" field="lastModifiedBy"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${driverInstance?.maker}">
				<li class="fieldcontain">
					<span id="maker-label" class="property-label"><g:message code="driver.maker.label" default="Maker" /></span>
					
						<span class="property-value" aria-labelledby="maker-label"><g:link controller="maker" action="show" id="${driverInstance?.maker?.id}">${driverInstance?.maker?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${driverInstance?.parameterSets}">
				<li class="fieldcontain">
					<span id="parameterSets-label" class="property-label"><g:message code="driver.parameterSets.label" default="Parameter Sets" /></span>
					
						<g:each in="${driverInstance.parameterSets}" var="p">
						<span class="property-value" aria-labelledby="parameterSets-label"><g:link controller="parameterSet" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:driverInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${driverInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
