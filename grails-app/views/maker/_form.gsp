



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

<div class="fieldcontain ${hasErrors(bean: makerInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="maker.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" required="" value="${makerInstance?.name}"/>

</div>

