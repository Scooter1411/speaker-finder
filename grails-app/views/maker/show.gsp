

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'maker.label', default: 'Maker')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-maker" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-maker" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list maker">
			
				<g:if test="${makerInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="maker.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${makerInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${makerInstance?.dateCreated}">
				<li class="fieldcontain">
					<span id="dateCreated-label" class="property-label"><g:message code="maker.dateCreated.label" default="Date Created" /></span>
					
						<span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate date="${makerInstance?.dateCreated}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${makerInstance?.lastUpdated}">
				<li class="fieldcontain">
					<span id="lastUpdated-label" class="property-label"><g:message code="maker.lastUpdated.label" default="Last Updated" /></span>
					
						<span class="property-value" aria-labelledby="lastUpdated-label"><g:formatDate date="${makerInstance?.lastUpdated}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${makerInstance?.createdBy}">
				<li class="fieldcontain">
					<span id="createdBy-label" class="property-label"><g:message code="maker.createdBy.label" default="Created By" /></span>
					
						<span class="property-value" aria-labelledby="createdBy-label"><g:fieldValue bean="${makerInstance}" field="createdBy"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${makerInstance?.lastModifiedBy}">
				<li class="fieldcontain">
					<span id="lastModifiedBy-label" class="property-label"><g:message code="maker.lastModifiedBy.label" default="Last Modified By" /></span>
					
						<span class="property-value" aria-labelledby="lastModifiedBy-label"><g:fieldValue bean="${makerInstance}" field="lastModifiedBy"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${makerInstance?.drivers}">
				<li class="fieldcontain">
					<span id="drivers-label" class="property-label"><g:message code="maker.drivers.label" default="Drivers" /></span>
					
						<g:each in="${makerInstance.drivers}" var="d">
						<span class="property-value" aria-labelledby="drivers-label"><g:link controller="driver" action="show" id="${d.id}">${d?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:makerInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${makerInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
