



<div class="fieldcontain ${hasErrors(bean: infiniteBaffleAlignmentInstance, field: 'rpre', 'error')} required">
	<label for="rpre">
		<g:message code="infiniteBaffleAlignment.rpre.label" default="Rpre" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="rpre" value="${fieldValue(bean: infiniteBaffleAlignmentInstance, field: 'rpre')}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: infiniteBaffleAlignmentInstance, field: 'createdBy', 'error')} ">
	<label for="createdBy">
		<g:message code="infiniteBaffleAlignment.createdBy.label" default="Created By" />
		
	</label>
	<g:textField name="createdBy" value="${infiniteBaffleAlignmentInstance?.createdBy}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: infiniteBaffleAlignmentInstance, field: 'lastModifiedBy', 'error')} ">
	<label for="lastModifiedBy">
		<g:message code="infiniteBaffleAlignment.lastModifiedBy.label" default="Last Modified By" />
		
	</label>
	<g:textField name="lastModifiedBy" value="${infiniteBaffleAlignmentInstance?.lastModifiedBy}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: infiniteBaffleAlignmentInstance, field: 'nvc', 'error')} required">
	<label for="nvc">
		<g:message code="infiniteBaffleAlignment.nvc.label" default="Nvc" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="nvc" from="${infiniteBaffleAlignmentInstance.constraints.nvc.inList}" required="" value="${fieldValue(bean: infiniteBaffleAlignmentInstance, field: 'nvc')}" valueMessagePrefix="infiniteBaffleAlignment.nvc"/>

</div>

<div class="fieldcontain ${hasErrors(bean: infiniteBaffleAlignmentInstance, field: 'rpara', 'error')} ">
	<label for="rpara">
		<g:message code="infiniteBaffleAlignment.rpara.label" default="Rpara" />
		
	</label>
	<g:field name="rpara" value="${fieldValue(bean: infiniteBaffleAlignmentInstance, field: 'rpara')}"/>

</div>

