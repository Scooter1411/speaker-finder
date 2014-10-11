

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'parameterSet.label', default: 'ParameterSet')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-parameterSet" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-parameterSet" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list parameterSet">
			
				<g:if test="${parameterSetInstance?.cms}">
				<li class="fieldcontain">
					<span id="cms-label" class="property-label"><g:message code="parameterSet.cms.label" default="Cms" /></span>
					
						<span class="property-value" aria-labelledby="cms-label"><g:fieldValue bean="${parameterSetInstance}" field="cms"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${parameterSetInstance?.driver}">
				<li class="fieldcontain">
					<span id="driver-label" class="property-label"><g:message code="parameterSet.driver.label" default="Driver" /></span>
					
						<span class="property-value" aria-labelledby="driver-label"><g:link controller="driver" action="show" id="${parameterSetInstance?.driver?.id}">${parameterSetInstance?.driver?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${parameterSetInstance?.fs}">
				<li class="fieldcontain">
					<span id="fs-label" class="property-label"><g:message code="parameterSet.fs.label" default="Fs" /></span>
					
						<span class="property-value" aria-labelledby="fs-label"><g:fieldValue bean="${parameterSetInstance}" field="fs"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${parameterSetInstance?.le}">
				<li class="fieldcontain">
					<span id="le-label" class="property-label"><g:message code="parameterSet.le.label" default="Le" /></span>
					
						<span class="property-value" aria-labelledby="le-label"><g:fieldValue bean="${parameterSetInstance}" field="le"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${parameterSetInstance?.mms}">
				<li class="fieldcontain">
					<span id="mms-label" class="property-label"><g:message code="parameterSet.mms.label" default="Mms" /></span>
					
						<span class="property-value" aria-labelledby="mms-label"><g:fieldValue bean="${parameterSetInstance}" field="mms"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${parameterSetInstance?.nvc}">
				<li class="fieldcontain">
					<span id="nvc-label" class="property-label"><g:message code="parameterSet.nvc.label" default="Nvc" /></span>
					
						<span class="property-value" aria-labelledby="nvc-label"><g:fieldValue bean="${parameterSetInstance}" field="nvc"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${parameterSetInstance?.pmax}">
				<li class="fieldcontain">
					<span id="pmax-label" class="property-label"><g:message code="parameterSet.pmax.label" default="Pmax" /></span>
					
						<span class="property-value" aria-labelledby="pmax-label"><g:fieldValue bean="${parameterSetInstance}" field="pmax"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${parameterSetInstance?.qes}">
				<li class="fieldcontain">
					<span id="qes-label" class="property-label"><g:message code="parameterSet.qes.label" default="Qes" /></span>
					
						<span class="property-value" aria-labelledby="qes-label"><g:fieldValue bean="${parameterSetInstance}" field="qes"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${parameterSetInstance?.qms}">
				<li class="fieldcontain">
					<span id="qms-label" class="property-label"><g:message code="parameterSet.qms.label" default="Qms" /></span>
					
						<span class="property-value" aria-labelledby="qms-label"><g:fieldValue bean="${parameterSetInstance}" field="qms"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${parameterSetInstance?.qts}">
				<li class="fieldcontain">
					<span id="qts-label" class="property-label"><g:message code="parameterSet.qts.label" default="Qts" /></span>
					
						<span class="property-value" aria-labelledby="qts-label"><g:fieldValue bean="${parameterSetInstance}" field="qts"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${parameterSetInstance?.re}">
				<li class="fieldcontain">
					<span id="re-label" class="property-label"><g:message code="parameterSet.re.label" default="Re" /></span>
					
						<span class="property-value" aria-labelledby="re-label"><g:fieldValue bean="${parameterSetInstance}" field="re"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${parameterSetInstance?.sd}">
				<li class="fieldcontain">
					<span id="sd-label" class="property-label"><g:message code="parameterSet.sd.label" default="Sd" /></span>
					
						<span class="property-value" aria-labelledby="sd-label"><g:fieldValue bean="${parameterSetInstance}" field="sd"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${parameterSetInstance?.spl}">
				<li class="fieldcontain">
					<span id="spl-label" class="property-label"><g:message code="parameterSet.spl.label" default="Spl" /></span>
					
						<span class="property-value" aria-labelledby="spl-label"><g:fieldValue bean="${parameterSetInstance}" field="spl"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${parameterSetInstance?.vas}">
				<li class="fieldcontain">
					<span id="vas-label" class="property-label"><g:message code="parameterSet.vas.label" default="Vas" /></span>
					
						<span class="property-value" aria-labelledby="vas-label"><g:fieldValue bean="${parameterSetInstance}" field="vas"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${parameterSetInstance?.xmax}">
				<li class="fieldcontain">
					<span id="xmax-label" class="property-label"><g:message code="parameterSet.xmax.label" default="Xmax" /></span>
					
						<span class="property-value" aria-labelledby="xmax-label"><g:fieldValue bean="${parameterSetInstance}" field="xmax"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:parameterSetInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${parameterSetInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
