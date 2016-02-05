



<div class="fieldcontain ${hasErrors(bean: makerInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="maker.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" maxlength="60" required="" value="${makerInstance?.name}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: makerInstance, field: 'createdBy', 'error')} ">
	<label for="createdBy">
		<g:message code="maker.createdBy.label" default="Created By" />
		
	</label>
	<g:textField name="createdBy" readonly="readonly" value="${makerInstance?.createdBy}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: makerInstance, field: 'lastModifiedBy', 'error')} ">
	<label for="lastModifiedBy">
		<g:message code="maker.lastModifiedBy.label" default="Last Modified By" />
		
	</label>
	<g:textField name="lastModifiedBy" readonly="readonly" value="${makerInstance?.lastModifiedBy}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: makerInstance, field: 'drivers', 'error')} ">
	<label for="drivers">
		<g:message code="maker.drivers.label" default="Drivers" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${makerInstance?.drivers?}" var="d">
    <li><g:link controller="driver" action="show" id="${d.id}">${d?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="driver" action="create" params="['maker.id': makerInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'driver.label', default: 'Driver')])}</g:link>
</li>
</ul>


</div>

