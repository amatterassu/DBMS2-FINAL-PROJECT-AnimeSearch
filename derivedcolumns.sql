--First derived column определяет популярность и даёт аниме своебразную оценку
--We used it in genre section and searching section
create or replace function get_pop
    (p_pop number) 
    return varchar2 deterministic is
    v_pop varchar2(25);
    v_max number;
    v_min number;
    v_avg number;
begin
    select avg(popularity)
    into v_avg from anime4;
    
    select max(popularity)
    into v_max from anime4;
    
    select min(popularity)
    into v_min from anime4;
    
    if(v_max >= p_pop and p_pop >= 2500) then
        v_pop := 'Little known';
    elsif(2500 > p_pop and p_pop >= 1100) then
        v_pop := 'Extremely Unpopular';
    elsif(1100 > p_pop and p_pop >= 360) then
        v_pop := 'Middle popular';
    elsif(v_min <= p_pop and p_pop < 360) then
        v_pop := 'the MOST famous';
    end if;
    return v_pop;
end;

--alter table anime4 drop column world_popularity;

alter table anime4 add(
world_popularity varchar2(4000) as (get_pop(popularity)));

-------------------------------------------------------------------------------------------
--Second derived column определяет оценки и даёт аниме своебразную оценку (тавтология велком)
--We used it in genre section and searching section
create or replace function get_score
    (p_score anime4.score%type) 
    return varchar2 deterministic is
    v_com varchar2(100);
    v_max anime4.score%type;
    v_min anime4.score%type;
    v_avg anime4.score%type;
begin 
    select avg(score)
    into v_avg from anime4;
    
    select max(score)
    into v_max from anime4;
    
    select min(score)
    into v_min from anime4;

    if(v_max >= p_score and p_score >= 8.3) then
        v_com := 'Outstanding anime';
    elsif(8.3 > p_score and p_score >= v_avg) then
        v_com := 'Wonderful anime';
    elsif(v_avg > p_score and p_score >= 8) then
        v_com := 'Very Good anime';
    elsif(8 > p_score and p_score >= 7.86) then
        v_com := 'Suitable, Can be revised';
    elsif(v_min <= p_score and p_score < 7.86) then
        v_com := 'Not bad, What I liked rather than not';
    end if;
    return v_com;
end;

--alter table anime4 drop column commentary;

alter table anime4 add(
commentary varchar2(4000) as (get_score(score)));
