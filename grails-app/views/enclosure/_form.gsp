



<div class="fieldcontain ${hasErrors(bean: enclosureInstance, field: 'pmax', 'error')} required">
	<label for="pmax">
		<g:message code="enclosure.pmax.label" default="Pmax" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="pmax" value="${fieldValue(bean: enclosureInstance, field: 'pmax')}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: enclosureInstance, field: 'spl', 'error')} required">
	<label for="spl">
		<g:message code="enclosure.spl.label" default="Spl" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="spl" value="${fieldValue(bean: enclosureInstance, field: 'spl')}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: enclosureInstance, field: 'splMech', 'error')} required">
	<label for="splMech">
		<g:message code="enclosure.splMech.label" default="Spl Mech" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="splMech" value="${fieldValue(bean: enclosureInstance, field: 'splMech')}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: enclosureInstance, field: 'pmech', 'error')} required">
	<label for="pmech">
		<g:message code="enclosure.pmech.label" default="Pmech" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="pmech" value="${fieldValue(bean: enclosureInstance, field: 'pmech')}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: enclosureInstance, field: 'splEle', 'error')} required">
	<label for="splEle">
		<g:message code="enclosure.splEle.label" default="Spl Ele" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="splEle" value="${fieldValue(bean: enclosureInstance, field: 'splEle')}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: enclosureInstance, field: 'f3', 'error')} required">
	<label for="f3">
		<g:message code="enclosure.f3.label" default="F3" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="f3" value="${fieldValue(bean: enclosureInstance, field: 'f3')}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: enclosureInstance, field: 'alignment', 'error')} required">
	<label for="alignment">
		<g:message code="enclosure.alignment.label" default="Alignment" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="alignment" name="alignment.id" from="${Alignment.list()}" optionKey="id" required="" value="${enclosureInstance?.alignment?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: enclosureInstance, field: 'parameterSet', 'error')} required">
	<label for="parameterSet">
		<g:message code="enclosure.parameterSet.label" default="Parameter Set" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="parameterSet" name="parameterSet.id" from="${ParameterSet.list()}" optionKey="id" required="" value="${enclosureInstance?.parameterSet?.id}" class="many-to-one"/>

</div>

