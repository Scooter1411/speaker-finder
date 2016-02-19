



<div class="fieldcontain ${hasErrors(bean: ventedEnclosureInstance, field: 'pmax', 'error')} required">
	<label for="pmax">
		<g:message code="ventedEnclosure.pmax.label" default="Pmax" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="pmax" value="${fieldValue(bean: ventedEnclosureInstance, field: 'pmax')}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: ventedEnclosureInstance, field: 'spl', 'error')} required">
	<label for="spl">
		<g:message code="ventedEnclosure.spl.label" default="Spl" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="spl" value="${fieldValue(bean: ventedEnclosureInstance, field: 'spl')}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: ventedEnclosureInstance, field: 'splMech', 'error')} required">
	<label for="splMech">
		<g:message code="ventedEnclosure.splMech.label" default="Spl Mech" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="splMech" value="${fieldValue(bean: ventedEnclosureInstance, field: 'splMech')}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: ventedEnclosureInstance, field: 'pmech', 'error')} required">
	<label for="pmech">
		<g:message code="ventedEnclosure.pmech.label" default="Pmech" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="pmech" value="${fieldValue(bean: ventedEnclosureInstance, field: 'pmech')}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: ventedEnclosureInstance, field: 'splEle', 'error')} required">
	<label for="splEle">
		<g:message code="ventedEnclosure.splEle.label" default="Spl Ele" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="splEle" value="${fieldValue(bean: ventedEnclosureInstance, field: 'splEle')}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: ventedEnclosureInstance, field: 'f3', 'error')} required">
	<label for="f3">
		<g:message code="ventedEnclosure.f3.label" default="F3" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="f3" value="${fieldValue(bean: ventedEnclosureInstance, field: 'f3')}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: ventedEnclosureInstance, field: 'vb', 'error')} required">
	<label for="vb">
		<g:message code="ventedEnclosure.vb.label" default="Vb" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="vb" value="${fieldValue(bean: ventedEnclosureInstance, field: 'vb')}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: ventedEnclosureInstance, field: 'alignment', 'error')} required">
	<label for="alignment">
		<g:message code="ventedEnclosure.alignment.label" default="Alignment" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="alignment" name="alignment.id" from="${Alignment.list()}" optionKey="id" required="" value="${ventedEnclosureInstance?.alignment?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: ventedEnclosureInstance, field: 'closedAlignment', 'error')} required">
	<label for="closedAlignment">
		<g:message code="ventedEnclosure.closedAlignment.label" default="Closed Alignment" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="closedAlignment" name="closedAlignment.id" from="${ClosedAlignment.list()}" optionKey="id" required="" value="${ventedEnclosureInstance?.closedAlignment?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: ventedEnclosureInstance, field: 'length', 'error')} required">
	<label for="length">
		<g:message code="ventedEnclosure.length.label" default="Length" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="length" value="${fieldValue(bean: ventedEnclosureInstance, field: 'length')}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: ventedEnclosureInstance, field: 'parameterSet', 'error')} required">
	<label for="parameterSet">
		<g:message code="ventedEnclosure.parameterSet.label" default="Parameter Set" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="parameterSet" name="parameterSet.id" from="${ParameterSet.list()}" optionKey="id" required="" value="${ventedEnclosureInstance?.parameterSet?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: ventedEnclosureInstance, field: 'tube', 'error')} required">
	<label for="tube">
		<g:message code="ventedEnclosure.tube.label" default="Tube" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="tube" name="tube.id" from="${Tube.list()}" optionKey="id" required="" value="${ventedEnclosureInstance?.tube?.id}" class="many-to-one"/>

</div>

