

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'ventedEnclosure.label', default: 'VentedEnclosure')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-ventedEnclosure" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-ventedEnclosure" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list ventedEnclosure">
			
				<g:if test="${ventedEnclosureInstance?.pmax}">
				<li class="fieldcontain">
					<span id="pmax-label" class="property-label"><g:message code="ventedEnclosure.pmax.label" default="Pmax" /></span>
					
						<span class="property-value" aria-labelledby="pmax-label"><g:fieldValue bean="${ventedEnclosureInstance}" field="pmax"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${ventedEnclosureInstance?.spl}">
				<li class="fieldcontain">
					<span id="spl-label" class="property-label"><g:message code="ventedEnclosure.spl.label" default="Spl" /></span>
					
						<span class="property-value" aria-labelledby="spl-label"><g:fieldValue bean="${ventedEnclosureInstance}" field="spl"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${ventedEnclosureInstance?.splMech}">
				<li class="fieldcontain">
					<span id="splMech-label" class="property-label"><g:message code="ventedEnclosure.splMech.label" default="Spl Mech" /></span>
					
						<span class="property-value" aria-labelledby="splMech-label"><g:fieldValue bean="${ventedEnclosureInstance}" field="splMech"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${ventedEnclosureInstance?.pmech}">
				<li class="fieldcontain">
					<span id="pmech-label" class="property-label"><g:message code="ventedEnclosure.pmech.label" default="Pmech" /></span>
					
						<span class="property-value" aria-labelledby="pmech-label"><g:fieldValue bean="${ventedEnclosureInstance}" field="pmech"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${ventedEnclosureInstance?.splEle}">
				<li class="fieldcontain">
					<span id="splEle-label" class="property-label"><g:message code="ventedEnclosure.splEle.label" default="Spl Ele" /></span>
					
						<span class="property-value" aria-labelledby="splEle-label"><g:fieldValue bean="${ventedEnclosureInstance}" field="splEle"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${ventedEnclosureInstance?.f3}">
				<li class="fieldcontain">
					<span id="f3-label" class="property-label"><g:message code="ventedEnclosure.f3.label" default="F3" /></span>
					
						<span class="property-value" aria-labelledby="f3-label"><g:fieldValue bean="${ventedEnclosureInstance}" field="f3"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${ventedEnclosureInstance?.vb}">
				<li class="fieldcontain">
					<span id="vb-label" class="property-label"><g:message code="ventedEnclosure.vb.label" default="Vb" /></span>
					
						<span class="property-value" aria-labelledby="vb-label"><g:fieldValue bean="${ventedEnclosureInstance}" field="vb"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${ventedEnclosureInstance?.alignment}">
				<li class="fieldcontain">
					<span id="alignment-label" class="property-label"><g:message code="ventedEnclosure.alignment.label" default="Alignment" /></span>
					
						<span class="property-value" aria-labelledby="alignment-label"><g:link controller="alignment" action="show" id="${ventedEnclosureInstance?.alignment?.id}">${ventedEnclosureInstance?.alignment?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${ventedEnclosureInstance?.closedAlignment}">
				<li class="fieldcontain">
					<span id="closedAlignment-label" class="property-label"><g:message code="ventedEnclosure.closedAlignment.label" default="Closed Alignment" /></span>
					
						<span class="property-value" aria-labelledby="closedAlignment-label"><g:link controller="closedAlignment" action="show" id="${ventedEnclosureInstance?.closedAlignment?.id}">${ventedEnclosureInstance?.closedAlignment?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${ventedEnclosureInstance?.length}">
				<li class="fieldcontain">
					<span id="length-label" class="property-label"><g:message code="ventedEnclosure.length.label" default="Length" /></span>
					
						<span class="property-value" aria-labelledby="length-label"><g:fieldValue bean="${ventedEnclosureInstance}" field="length"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${ventedEnclosureInstance?.parameterSet}">
				<li class="fieldcontain">
					<span id="parameterSet-label" class="property-label"><g:message code="ventedEnclosure.parameterSet.label" default="Parameter Set" /></span>
					
						<span class="property-value" aria-labelledby="parameterSet-label"><g:link controller="parameterSet" action="show" id="${ventedEnclosureInstance?.parameterSet?.id}">${ventedEnclosureInstance?.parameterSet?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${ventedEnclosureInstance?.tube}">
				<li class="fieldcontain">
					<span id="tube-label" class="property-label"><g:message code="ventedEnclosure.tube.label" default="Tube" /></span>
					
						<span class="property-value" aria-labelledby="tube-label"><g:link controller="tube" action="show" id="${ventedEnclosureInstance?.tube?.id}">${ventedEnclosureInstance?.tube?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:ventedEnclosureInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${ventedEnclosureInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
