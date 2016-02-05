select m.name || ' ' ||d.name as Driver, a.rpre, a.qtc from Parameter_set PS, Driver d, maker m, alignment a 
where m.id = d.maker_id and ps.driver_id = d.id and a.class = 'ClosedAlignment';

select m.name || ' ' ||d.name as Driver, a.rpre, a.qtc,
ps.qes, ps.qes * ( ps.re + a.rpre ) / ps.re as qes1, 
ps.qts, 1/((1/ps.qms) + (1/qes1)) as qts1
from Parameter_set PS, Driver d, maker m, alignment a 
where m.id = d.maker_id and ps.driver_id = d.id and a.class = 'ClosedAlignment';

select Driver, rpre, qtc, 
qes, qes1, 
qts, 1/((1/qms) + (1/qes1)) as qts1
from
(
select m.name || ' ' ||d.name as Driver, a.rpre, a.qtc,
ps.qes, ps.qes * ( ps.re + a.rpre ) / ps.re as qes1,
ps.qms, ps.qts
from Parameter_set PS, Driver d, maker m, alignment a 
where m.id = d.maker_id and ps.driver_id = d.id and a.class = 'ClosedAlignment'
)
;

select Driver, rpre, qtc, 
qes, qes1, 
qts, vd,
1/((1/qms) + (1/qes1)) as qts1,
9.64 * 0.0000000001 * fs*fs*fs * vas / qes1 as eff
from
(
select 
    m.name || ' ' ||d.name as Driver, 
    a.rpre, a.qtc,
    ps.qes, ps.qms, ps.qts, ps.fs, ps.vas,
    ps.qes * ( ps.re + a.rpre ) / ps.re as qes1,
    ps.sd * 2 * xmax / 10 as vd
from Parameter_set PS, Driver d, maker m, alignment a 
where m.id = d.maker_id and ps.driver_id = d.id and a.class = 'ClosedAlignment'
)
;

select
    driver, rpre, qtc, qes, qes1, qts, vd, qts1, eff,
    112 + 10 * log( eff ) / log(10) as spl1
from (
	select 
		Driver, rpre, qtc, qes, qes1, qts, vd,
		1/((1/qms) + (1/qes1)) as qts1, 9.64 * 0.0000000001 * fs*fs*fs * vas / qes1 as eff
	from (
		select 
			m.name || ' ' ||d.name as Driver, a.rpre, a.qtc, ps.qes, ps.qms, ps.qts, ps.fs, ps.vas, ps.qes * ( ps.re + a.rpre ) / ps.re as qes1, ps.sd * 2 * xmax / 10 as vd
		from Parameter_set PS, Driver d, maker m, alignment a where m.id = d.maker_id and ps.driver_id = d.id and a.class = 'ClosedAlignment'
	)
);

select
    driver, rpre, qtc, qes, qes1, qts, vd, qts1, eff,
    112 + 10 * log( eff ) / log(10) as spl1,
    316000 * qts1 / re / fs as cs
from (
	select 
		driver, rpre, qtc, qes, qes1, qts, vd, re, fs,
		1/((1/qms) + (1/qes1)) as qts1, 9.64 * 0.0000000001 * fs*fs*fs * vas / qes1 as eff
	from (
		select 
			m.name || ' ' ||d.name as Driver, a.rpre, a.qtc, ps.qes, ps.qms, ps.qts, ps.fs,ps.re,  ps.vas, ps.qes * ( ps.re + a.rpre ) / ps.re as qes1, ps.sd * 2 * xmax / 10 as vd
		from Parameter_set PS, Driver d, maker m, alignment a where m.id = d.maker_id and ps.driver_id = d.id and a.class = 'ClosedAlignment'
	)
);

select
    driver, rpre, qtc, qes, qes1, qts, vd, qts1, eff,
    112 + 10 * log( eff ) / log(10) as spl1,
    316000 * qts1 / re / fs as cs,
    qtc /qts1 * fs as fc
from (
	select 
		driver, rpre, qtc, qes, qes1, qts, vd, re, fs,
		1/((1/qms) + (1/qes1)) as qts1, 9.64 * 0.0000000001 * fs*fs*fs * vas / qes1 as eff
	from (
		select 
			m.name || ' ' ||d.name as Driver, a.rpre, a.qtc, ps.qes, ps.qms, ps.qts, ps.fs,ps.re,  ps.vas, ps.qes * ( ps.re + a.rpre ) / ps.re as qes1, ps.sd * 2 * xmax / 10 as vd
		from Parameter_set PS, Driver d, maker m, alignment a where m.id = d.maker_id and ps.driver_id = d.id and a.class = 'ClosedAlignment'
	)
);

select driver, rpre, qtc,
case 
    when qtc < 0.525 then 1.45 * fc 
    when qtc < 0.55 then 1.35 * fc 
    when qtc < 0.575 then 1.29 * fc 
    when qtc < 0.60 then 1.24 * fc 
    when qtc < 0.65 then 1.14 * fc 
    when qtc < 0.7 then 1.05 * fc 
    when qtc < 0.75 then 0.98 * fc 
    when qtc < 0.8 then 0.93 * fc 
    when qtc < 0.85 then 0.88 * fc 
    when qtc < 0.9 then 0.85 * fc 
    when qtc < 0.95 then 0.81 * fc 
    when qtc < 1.0 then 0.79 * fc 
    when qtc < 1.05 then 0.77 * fc 
    else 0.75 * fc 
end 
as f3
from (
select
    driver, rpre, qtc, qes, qes1, qts, vd, qts1, eff,
    112 + 10 * log( eff ) / log(10) as spl1,
    316000 * qts1 / re / fs as cs,
    qtc /qts1 * fs as fc
from (
	select 
		driver, rpre, qtc, qes, qes1, qts, vd, re, fs,
		1/((1/qms) + (1/qes1)) as qts1, 9.64 * 0.0000000001 * fs*fs*fs * vas / qes1 as eff
	from (
		select 
			m.name || ' ' ||d.name as Driver, a.rpre, a.qtc, ps.qes, ps.qms, ps.qts, ps.fs,ps.re,  ps.vas, ps.qes * ( ps.re + a.rpre ) / ps.re as qes1, ps.sd * 2 * xmax / 10 as vd
		from Parameter_set PS, Driver d, maker m, alignment a where m.id = d.maker_id and ps.driver_id = d.id and a.class = 'ClosedAlignment'
	)
)
);

select driver, rpre, qtc, f3,
20 * log( 0.37 * f3 * f3 * vd ) / log(10) as spl2,
p0 * exp(( spl2 - spl1)/10*log(10)) as p2
from (
select driver, rpre, qtc, vd,
case 
    when qtc < 0.525 then 1.45 * fc 
    when qtc < 0.55 then 1.35 * fc 
    when qtc < 0.575 then 1.29 * fc 
    when qtc < 0.60 then 1.24 * fc 
    when qtc < 0.65 then 1.14 * fc 
    when qtc < 0.7 then 1.05 * fc 
    when qtc < 0.75 then 0.98 * fc 
    when qtc < 0.8 then 0.93 * fc 
    when qtc < 0.85 then 0.88 * fc 
    when qtc < 0.9 then 0.85 * fc 
    when qtc < 0.95 then 0.81 * fc 
    when qtc < 1.0 then 0.79 * fc 
    when qtc < 1.05 then 0.77 * fc 
    else 0.75 * fc 
end 
as f3
from (
select
    driver, rpre, qtc, qes, qes1, qts, vd, qts1, eff,
    112 + 10 * log( eff ) / log(10) as spl1,
    316000 * qts1 / re / fs as cs,
    qtc /qts1 * fs as fc
from (
	select 
		driver, rpre, qtc, qes, qes1, qts, vd, re, fs,
		1/((1/qms) + (1/qes1)) as qts1, 9.64 * 0.0000000001 * fs*fs*fs * vas / qes1 as eff
	from (
		select 
			m.name || ' ' ||d.name as Driver, a.rpre, a.qtc, ps.qes, ps.qms, ps.qts, ps.fs,ps.re,  ps.vas, ps.qes * ( ps.re + a.rpre ) / ps.re as qes1, ps.sd * 2 * xmax / 10 as vd
		from Parameter_set PS, Driver d, maker m, alignment a where m.id = d.maker_id and ps.driver_id = d.id and a.class = 'ClosedAlignment'
	)
)
)
);
select driver, rpre, qtc, f3, spl2,
p0 * 2 as pow2
from (
select driver, rpre, qtc, f3, p0,
20 * log( 0.37 * f3 * f3 * vd ) / log(10) as spl2,
from (
select driver, rpre, qtc, vd, p0,
case 
    when qtc < 0.525 then 1.45 * fc 
    when qtc < 0.55 then 1.35 * fc 
    when qtc < 0.575 then 1.29 * fc 
    when qtc < 0.60 then 1.24 * fc 
    when qtc < 0.65 then 1.14 * fc 
    when qtc < 0.7 then 1.05 * fc 
    when qtc < 0.75 then 0.98 * fc 
    when qtc < 0.8 then 0.93 * fc 
    when qtc < 0.85 then 0.88 * fc 
    when qtc < 0.9 then 0.85 * fc 
    when qtc < 0.95 then 0.81 * fc 
    when qtc < 1.0 then 0.79 * fc 
    when qtc < 1.05 then 0.77 * fc 
    else 0.75 * fc 
end 
as f3
from (
select
    driver, rpre, qtc, qes, qes1, qts, vd, qts1, eff, p0,
    112 + 10 * log( eff ) / log(10) as spl1,
    316000 * qts1 / re / fs as cs,
    qtc /qts1 * fs as fc
from (
	select 
		driver, rpre, qtc, qes, qes1, qts, vd, re, fs, p0,
		1/((1/qms) + (1/qes1)) as qts1, 9.64 * 0.0000000001 * fs*fs*fs * vas / qes1 as eff
	from (
		select 
			m.name || ' ' ||d.name as Driver, a.rpre, a.qtc, ps.qes, ps.qms, ps.qts, ps.fs,ps.re,  ps.vas, ps.qes * ( ps.re + a.rpre ) / ps.re as qes1, ps.sd * 2 * xmax / 10 as vd, 2.83 * 2.83 / ps.re as p0
		from Parameter_set PS, Driver d, maker m, alignment a where m.id = d.maker_id and ps.driver_id = d.id and a.class = 'ClosedAlignment'
	)
)
)
)
);

create or replace view alignment_view as
select id, rpre, qtc, class,
case 
    when qtc < 0.525 then 1.45  
    when qtc < 0.55 then 1.35  
    when qtc < 0.575 then 1.29  
    when qtc < 0.60 then 1.24  
    when qtc < 0.65 then 1.14  
    when qtc < 0.7 then 1.05 
    when qtc < 0.75 then 0.98  
    when qtc < 0.8 then 0.93  
    when qtc < 0.85 then 0.88  
    when qtc < 0.9 then 0.85 
    when qtc < 0.95 then 0.81  
    when qtc < 1.0 then 0.79  
    when qtc < 1.05 then 0.77  
    else 0.75 
end 
as factor
from alignment;

create or replace view closed_enclosure_view1 as
select 
    m.name || ' ' ||d.name as Driver, ps.id as parameter_set_id, a.id as closed_alignment_id, a.rpre, a.qtc, a.factor, ps.qes, ps.qms, ps.qts, ps.fs,ps.re, ps.pmax, ps.vas, ps.qes * ( ps.re + a.rpre ) / ps.re as qes1, ps.sd * 2 * xmax / 10 as vd, 2.83 * 2.83 / ps.re as p0
from Parameter_set PS, Driver d, maker m, alignment_view a where m.id = d.maker_id and ps.driver_id = d.id and a.class = 'ClosedAlignment';

create or replace view closed_enclosure_view2 as
select 
	driver, parameter_set_id, closed_alignment_id, rpre, qtc, factor, qes, qes1, qts, vas, vd, re, fs, p0, pmax,
	1/((1/qms) + (1/qes1)) as qts1, 9.64 * 0.0000000001 * fs*fs*fs * vas / qes1 as eff
from closed_enclosure_view1;
	
create or replace view closed_enclosure_view3 as
select
    driver, parameter_set_id, closed_alignment_id, rpre, qtc, factor, qes, qes1, qts, vd, qts1, eff, p0, pmax,
    112 + 10 * log( eff ) / log(10) as spl1,
    316000 * qts1 / re / fs as cs,
    qtc /qts1 * fs as fc,
	vas / ((( qtc * qtc )/( qts1 * qts1 ))-1) as vb
from closed_enclosure_view2 where qtc > qts1;	

create or replace view closed_enclosure_view4 as
select 
    driver, parameter_set_id, closed_alignment_id, rpre, qtc, vd, p0, spl1,  pmax, vb,
    factor * fc as f3
from closed_enclosure_view3;

create or replace view closed_enclosure_view5 as
select 
    driver, parameter_set_id, closed_alignment_id, rpre, spl1, qtc, vb, pmax, 
	20 * log( 0.37 * f3 * f3 * vd ) / log(10) as spl2,
	f3, p0,
    spl1 + 10 * log( pmax / p0 ) / log(10) as spl3
from closed_enclosure_view4;

create or replace view closed_enclosure_view as
select 
    driver, parameter_set_id, closed_alignment_id, rownum as id, pmax, rpre, spl1 as spl, qtc, vb,
	spl2 as spl_mech,
    p0 * exp(( spl2 - spl1)/10*log(10)) as pmech,
	spl3 as spl_ele,
	f3
from closed_enclosure_view5 order by driver, rpre, qtc;

create or replace view enclosure_view as
select 
    driver, parameter_set_d, closed_alignment_id, rownum as id, pmax, rpre, spl1 as spl, qtc, vb, spl_mech, pmech, spl_ele, f3, 'ClosedEnclosure' as class
from closed_enclosure_view;

create or replace view closed_enclosure_view_rounded as
SELECT driver, round(pmax,0), rpre, round(spl,1), qtc, round(vb,1), round(spl_mech,1), round(pmech,1), round(spl_ele,1),	round(f3,1) 
FROM CLOSED_ENCLOSURE_VIEW;
