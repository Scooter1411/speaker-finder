

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'enclosure.label', default: 'Enclosure')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-enclosure" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-enclosure" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list enclosure">
			
				<g:if test="${enclosureInstance?.pmax}">
				<li class="fieldcontain">
					<span id="pmax-label" class="property-label"><g:message code="enclosure.pmax.label" default="Pmax" /></span>
					
						<span class="property-value" aria-labelledby="pmax-label"><g:fieldValue bean="${enclosureInstance}" field="pmax"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${enclosureInstance?.spl}">
				<li class="fieldcontain">
					<span id="spl-label" class="property-label"><g:message code="enclosure.spl.label" default="Spl" /></span>
					
						<span class="property-value" aria-labelledby="spl-label"><g:fieldValue bean="${enclosureInstance}" field="spl"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${enclosureInstance?.splMech}">
				<li class="fieldcontain">
					<span id="splMech-label" class="property-label"><g:message code="enclosure.splMech.label" default="Spl Mech" /></span>
					
						<span class="property-value" aria-labelledby="splMech-label"><g:fieldValue bean="${enclosureInstance}" field="splMech"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${enclosureInstance?.pmech}">
				<li class="fieldcontain">
					<span id="pmech-label" class="property-label"><g:message code="enclosure.pmech.label" default="Pmech" /></span>
					
						<span class="property-value" aria-labelledby="pmech-label"><g:fieldValue bean="${enclosureInstance}" field="pmech"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${enclosureInstance?.splEle}">
				<li class="fieldcontain">
					<span id="splEle-label" class="property-label"><g:message code="enclosure.splEle.label" default="Spl Ele" /></span>
					
						<span class="property-value" aria-labelledby="splEle-label"><g:fieldValue bean="${enclosureInstance}" field="splEle"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${enclosureInstance?.f3}">
				<li class="fieldcontain">
					<span id="f3-label" class="property-label"><g:message code="enclosure.f3.label" default="F3" /></span>
					
						<span class="property-value" aria-labelledby="f3-label"><g:fieldValue bean="${enclosureInstance}" field="f3"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${enclosureInstance?.alignment}">
				<li class="fieldcontain">
					<span id="alignment-label" class="property-label"><g:message code="enclosure.alignment.label" default="Alignment" /></span>
					
						<span class="property-value" aria-labelledby="alignment-label"><g:link controller="alignment" action="show" id="${enclosureInstance?.alignment?.id}">${enclosureInstance?.alignment?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${enclosureInstance?.parameterSet}">
				<li class="fieldcontain">
					<span id="parameterSet-label" class="property-label"><g:message code="enclosure.parameterSet.label" default="Parameter Set" /></span>
					
						<span class="property-value" aria-labelledby="parameterSet-label"><g:link controller="parameterSet" action="show" id="${enclosureInstance?.parameterSet?.id}">${enclosureInstance?.parameterSet?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:enclosureInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${enclosureInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
