



<div class="fieldcontain ${hasErrors(bean: closedEnclosureInstance, field: 'pmax', 'error')} required">
	<label for="pmax">
		<g:message code="closedEnclosure.pmax.label" default="Pmax" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="pmax" value="${fieldValue(bean: closedEnclosureInstance, field: 'pmax')}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: closedEnclosureInstance, field: 'spl', 'error')} required">
	<label for="spl">
		<g:message code="closedEnclosure.spl.label" default="Spl" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="spl" value="${fieldValue(bean: closedEnclosureInstance, field: 'spl')}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: closedEnclosureInstance, field: 'splMech', 'error')} required">
	<label for="splMech">
		<g:message code="closedEnclosure.splMech.label" default="Spl Mech" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="splMech" value="${fieldValue(bean: closedEnclosureInstance, field: 'splMech')}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: closedEnclosureInstance, field: 'pmech', 'error')} required">
	<label for="pmech">
		<g:message code="closedEnclosure.pmech.label" default="Pmech" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="pmech" value="${fieldValue(bean: closedEnclosureInstance, field: 'pmech')}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: closedEnclosureInstance, field: 'splEle', 'error')} required">
	<label for="splEle">
		<g:message code="closedEnclosure.splEle.label" default="Spl Ele" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="splEle" value="${fieldValue(bean: closedEnclosureInstance, field: 'splEle')}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: closedEnclosureInstance, field: 'f3', 'error')} required">
	<label for="f3">
		<g:message code="closedEnclosure.f3.label" default="F3" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="f3" value="${fieldValue(bean: closedEnclosureInstance, field: 'f3')}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: closedEnclosureInstance, field: 'vb', 'error')} required">
	<label for="vb">
		<g:message code="closedEnclosure.vb.label" default="Vb" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="vb" value="${fieldValue(bean: closedEnclosureInstance, field: 'vb')}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: closedEnclosureInstance, field: 'alignment', 'error')} required">
	<label for="alignment">
		<g:message code="closedEnclosure.alignment.label" default="Alignment" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="alignment" name="alignment.id" from="${Alignment.list()}" optionKey="id" required="" value="${closedEnclosureInstance?.alignment?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: closedEnclosureInstance, field: 'parameterSet', 'error')} required">
	<label for="parameterSet">
		<g:message code="closedEnclosure.parameterSet.label" default="Parameter Set" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="parameterSet" name="parameterSet.id" from="${ParameterSet.list()}" optionKey="id" required="" value="${closedEnclosureInstance?.parameterSet?.id}" class="many-to-one"/>

</div>

