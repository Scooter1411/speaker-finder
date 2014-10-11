



<div class="fieldcontain ${hasErrors(bean: parameterSetInstance, field: 'cms', 'error')} required">
	<label for="cms">
		<g:message code="parameterSet.cms.label" default="Cms" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="cms" value="${fieldValue(bean: parameterSetInstance, field: 'cms')}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: parameterSetInstance, field: 'driver', 'error')} required">
	<label for="driver">
		<g:message code="parameterSet.driver.label" default="Driver" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="driver" name="driver.id" from="${Driver.list()}" optionKey="id" required="" value="${parameterSetInstance?.driver?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: parameterSetInstance, field: 'fs', 'error')} required">
	<label for="fs">
		<g:message code="parameterSet.fs.label" default="Fs" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="fs" value="${fieldValue(bean: parameterSetInstance, field: 'fs')}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: parameterSetInstance, field: 'le', 'error')} required">
	<label for="le">
		<g:message code="parameterSet.le.label" default="Le" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="le" value="${fieldValue(bean: parameterSetInstance, field: 'le')}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: parameterSetInstance, field: 'mms', 'error')} required">
	<label for="mms">
		<g:message code="parameterSet.mms.label" default="Mms" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="mms" value="${fieldValue(bean: parameterSetInstance, field: 'mms')}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: parameterSetInstance, field: 'nvc', 'error')} required">
	<label for="nvc">
		<g:message code="parameterSet.nvc.label" default="Nvc" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="nvc" type="number" value="${parameterSetInstance.nvc}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: parameterSetInstance, field: 'pmax', 'error')} required">
	<label for="pmax">
		<g:message code="parameterSet.pmax.label" default="Pmax" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="pmax" value="${fieldValue(bean: parameterSetInstance, field: 'pmax')}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: parameterSetInstance, field: 'qes', 'error')} required">
	<label for="qes">
		<g:message code="parameterSet.qes.label" default="Qes" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="qes" value="${fieldValue(bean: parameterSetInstance, field: 'qes')}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: parameterSetInstance, field: 'qms', 'error')} required">
	<label for="qms">
		<g:message code="parameterSet.qms.label" default="Qms" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="qms" value="${fieldValue(bean: parameterSetInstance, field: 'qms')}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: parameterSetInstance, field: 'qts', 'error')} required">
	<label for="qts">
		<g:message code="parameterSet.qts.label" default="Qts" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="qts" value="${fieldValue(bean: parameterSetInstance, field: 'qts')}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: parameterSetInstance, field: 're', 'error')} required">
	<label for="re">
		<g:message code="parameterSet.re.label" default="Re" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="re" value="${fieldValue(bean: parameterSetInstance, field: 're')}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: parameterSetInstance, field: 'sd', 'error')} required">
	<label for="sd">
		<g:message code="parameterSet.sd.label" default="Sd" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="sd" value="${fieldValue(bean: parameterSetInstance, field: 'sd')}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: parameterSetInstance, field: 'spl', 'error')} required">
	<label for="spl">
		<g:message code="parameterSet.spl.label" default="Spl" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="spl" value="${fieldValue(bean: parameterSetInstance, field: 'spl')}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: parameterSetInstance, field: 'vas', 'error')} required">
	<label for="vas">
		<g:message code="parameterSet.vas.label" default="Vas" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="vas" value="${fieldValue(bean: parameterSetInstance, field: 'vas')}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: parameterSetInstance, field: 'xmax', 'error')} required">
	<label for="xmax">
		<g:message code="parameterSet.xmax.label" default="Xmax" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="xmax" value="${fieldValue(bean: parameterSetInstance, field: 'xmax')}" required=""/>

</div>

