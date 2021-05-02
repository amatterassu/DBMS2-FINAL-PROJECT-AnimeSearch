create or replace TYPE t_genre_tab IS OBJECT
        (img_url varchar2(200),
         title varchar2(200),
         genre VARCHAR2(256), 
         episodes number(10,0),
         score number(10,2),
         world_popularity varchar2(4000), 
         commentary varchar2(4000));

--DROP TYPE t_genre_tab FORCE;

create or replace TYPE t_g_table IS TABLE OF t_genre_tab;

create or replace FUNCTION fun_genre
    (p_genre IN anime4.genre%TYPE)
     RETURN t_g_table IS
     t_result t_g_table := t_g_table();
     
    cursor cur_genre is
        select title , img_url ,genre, episodes,score ,world_popularity,commentary
        from (select * from anime4 where genre like '%'||p_genre||'%')
        where rownum <= 15;    
BEGIN
    FOR i IN cur_genre LOOP
        t_result.extend;
            t_result(t_result.count) := t_genre_tab(null, null,null,null, null, null, null);
            t_result(t_result.count).img_url :=  i.img_url;
            t_result(t_result.count).title :=  i.title;
            t_result(t_result.count).genre :=  i.genre;
            t_result(t_result.count).episodes := i.episodes;
            t_result(t_result.count).score :=  i.score;
            t_result(t_result.count).world_popularity :=  i.world_popularity;
            t_result(t_result.count).commentary :=  i.commentary;

    END LOOP;
    RETURN t_result;
END; 

select * from table(fun_genre('Sci-Fi'));