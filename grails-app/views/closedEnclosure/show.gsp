

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'closedEnclosure.label', default: 'ClosedEnclosure')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-closedEnclosure" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-closedEnclosure" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list closedEnclosure">
			
				<g:if test="${closedEnclosureInstance?.pmax}">
				<li class="fieldcontain">
					<span id="pmax-label" class="property-label"><g:message code="closedEnclosure.pmax.label" default="Pmax" /></span>
					
						<span class="property-value" aria-labelledby="pmax-label"><g:fieldValue bean="${closedEnclosureInstance}" field="pmax"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${closedEnclosureInstance?.spl}">
				<li class="fieldcontain">
					<span id="spl-label" class="property-label"><g:message code="closedEnclosure.spl.label" default="Spl" /></span>
					
						<span class="property-value" aria-labelledby="spl-label"><g:fieldValue bean="${closedEnclosureInstance}" field="spl"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${closedEnclosureInstance?.splMech}">
				<li class="fieldcontain">
					<span id="splMech-label" class="property-label"><g:message code="closedEnclosure.splMech.label" default="Spl Mech" /></span>
					
						<span class="property-value" aria-labelledby="splMech-label"><g:fieldValue bean="${closedEnclosureInstance}" field="splMech"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${closedEnclosureInstance?.pmech}">
				<li class="fieldcontain">
					<span id="pmech-label" class="property-label"><g:message code="closedEnclosure.pmech.label" default="Pmech" /></span>
					
						<span class="property-value" aria-labelledby="pmech-label"><g:fieldValue bean="${closedEnclosureInstance}" field="pmech"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${closedEnclosureInstance?.splEle}">
				<li class="fieldcontain">
					<span id="splEle-label" class="property-label"><g:message code="closedEnclosure.splEle.label" default="Spl Ele" /></span>
					
						<span class="property-value" aria-labelledby="splEle-label"><g:fieldValue bean="${closedEnclosureInstance}" field="splEle"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${closedEnclosureInstance?.f3}">
				<li class="fieldcontain">
					<span id="f3-label" class="property-label"><g:message code="closedEnclosure.f3.label" default="F3" /></span>
					
						<span class="property-value" aria-labelledby="f3-label"><g:fieldValue bean="${closedEnclosureInstance}" field="f3"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${closedEnclosureInstance?.vb}">
				<li class="fieldcontain">
					<span id="vb-label" class="property-label"><g:message code="closedEnclosure.vb.label" default="Vb" /></span>
					
						<span class="property-value" aria-labelledby="vb-label"><g:fieldValue bean="${closedEnclosureInstance}" field="vb"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${closedEnclosureInstance?.alignment}">
				<li class="fieldcontain">
					<span id="alignment-label" class="property-label"><g:message code="closedEnclosure.alignment.label" default="Alignment" /></span>
					
						<span class="property-value" aria-labelledby="alignment-label"><g:link controller="alignment" action="show" id="${closedEnclosureInstance?.alignment?.id}">${closedEnclosureInstance?.alignment?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${closedEnclosureInstance?.parameterSet}">
				<li class="fieldcontain">
					<span id="parameterSet-label" class="property-label"><g:message code="closedEnclosure.parameterSet.label" default="Parameter Set" /></span>
					
						<span class="property-value" aria-labelledby="parameterSet-label"><g:link controller="parameterSet" action="show" id="${closedEnclosureInstance?.parameterSet?.id}">${closedEnclosureInstance?.parameterSet?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:closedEnclosureInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${closedEnclosureInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
