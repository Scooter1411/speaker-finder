

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'infiniteBaffleAlignment.label', default: 'InfiniteBaffleAlignment')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-infiniteBaffleAlignment" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-infiniteBaffleAlignment" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list infiniteBaffleAlignment">
			
				<g:if test="${infiniteBaffleAlignmentInstance?.rpre}">
				<li class="fieldcontain">
					<span id="rpre-label" class="property-label"><g:message code="infiniteBaffleAlignment.rpre.label" default="Rpre" /></span>
					
						<span class="property-value" aria-labelledby="rpre-label"><g:fieldValue bean="${infiniteBaffleAlignmentInstance}" field="rpre"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${infiniteBaffleAlignmentInstance?.dateCreated}">
				<li class="fieldcontain">
					<span id="dateCreated-label" class="property-label"><g:message code="infiniteBaffleAlignment.dateCreated.label" default="Date Created" /></span>
					
						<span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate date="${infiniteBaffleAlignmentInstance?.dateCreated}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${infiniteBaffleAlignmentInstance?.lastUpdated}">
				<li class="fieldcontain">
					<span id="lastUpdated-label" class="property-label"><g:message code="infiniteBaffleAlignment.lastUpdated.label" default="Last Updated" /></span>
					
						<span class="property-value" aria-labelledby="lastUpdated-label"><g:formatDate date="${infiniteBaffleAlignmentInstance?.lastUpdated}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${infiniteBaffleAlignmentInstance?.createdBy}">
				<li class="fieldcontain">
					<span id="createdBy-label" class="property-label"><g:message code="infiniteBaffleAlignment.createdBy.label" default="Created By" /></span>
					
						<span class="property-value" aria-labelledby="createdBy-label"><g:fieldValue bean="${infiniteBaffleAlignmentInstance}" field="createdBy"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${infiniteBaffleAlignmentInstance?.lastModifiedBy}">
				<li class="fieldcontain">
					<span id="lastModifiedBy-label" class="property-label"><g:message code="infiniteBaffleAlignment.lastModifiedBy.label" default="Last Modified By" /></span>
					
						<span class="property-value" aria-labelledby="lastModifiedBy-label"><g:fieldValue bean="${infiniteBaffleAlignmentInstance}" field="lastModifiedBy"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${infiniteBaffleAlignmentInstance?.nvc}">
				<li class="fieldcontain">
					<span id="nvc-label" class="property-label"><g:message code="infiniteBaffleAlignment.nvc.label" default="Nvc" /></span>
					
						<span class="property-value" aria-labelledby="nvc-label"><g:fieldValue bean="${infiniteBaffleAlignmentInstance}" field="nvc"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${infiniteBaffleAlignmentInstance?.rpara}">
				<li class="fieldcontain">
					<span id="rpara-label" class="property-label"><g:message code="infiniteBaffleAlignment.rpara.label" default="Rpara" /></span>
					
						<span class="property-value" aria-labelledby="rpara-label"><g:fieldValue bean="${infiniteBaffleAlignmentInstance}" field="rpara"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:infiniteBaffleAlignmentInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${infiniteBaffleAlignmentInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
