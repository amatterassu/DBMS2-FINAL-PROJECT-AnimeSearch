----------Function for searching
create or replace TYPE t_anime_tab IS OBJECT(title varchar2(200),img_url varchar2(200), score number(10,2), episodes number(10,0), world_popularity varchar2(4000), commentary varchar2(4000));

--DROP TYPE t_anime_tab FORCE;

create or replace TYPE t_table IS TABLE OF t_anime_tab;

create or replace FUNCTION search(p_title IN anime4.title%TYPE)
    RETURN t_table IS
    t_result t_table := t_table();

    CURSOR cur_title IS 
    SELECT title,img_url,score, episodes,world_popularity, commentary FROM anime4
        WHERE lower(title) LIKE lower(p_title)||'%' AND popularity IS NOT NULL
        ORDER BY popularity asc;
       
BEGIN
    FOR i IN cur_title LOOP
        t_result.extend;
            t_result(t_result.count) := t_anime_tab(null, null, null, null, null, null);
            t_result(t_result.count).title :=  i.title;
            t_result(t_result.count).img_url :=  i.img_url;
            t_result(t_result.count).score :=  i.score;
            t_result(t_result.count).episodes := i.episodes;
            t_result(t_result.count).world_popularity := i.world_popularity;
            t_result(t_result.count).commentary := i.commentary;
    END LOOP;
    RETURN t_result;
END;

select*from anime4;

select * from table(search('Death'));