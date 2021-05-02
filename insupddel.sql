CREATE OR REPLACE PACKAGE paket AS
    PROCEDURE add_anime(
        v_id number,
        v_title  anime4.title%TYPE, 
        v_synopsis anime4.synopsis%type,   
        v_genre  anime4.genre%TYPE,
        v_aired  anime4.aired%TYPE, 
        v_episodes  anime4.episodes%TYPE,
        v_members  anime4.members%TYPE,
        v_popularity  anime4.popularity%TYPE, 
        v_ranked  anime4.ranked%TYPE,
        v_score  anime4.score%TYPE,
        v_image  anime4.img_url%type,
        v_link  anime4.link%TYPE);
        
    PROCEDURE upd_anime(
        v_title  anime4.title%TYPE,             v_synopsis anime4.synopsis%type,   
        v_genre  anime4.genre%TYPE,             v_aired  anime4.aired%TYPE, 
        v_episodes  anime4.episodes%TYPE,       v_members  anime4.members%TYPE,
        v_popularity  anime4.popularity%TYPE,   v_ranked  anime4.ranked%TYPE,
        v_score  anime4.score%TYPE,             v_image  anime4.img_url%type,
        v_link  anime4.link%TYPE,               v_id  number);
    
    PROCEDURE del_anime
        (p_id number);      
END;


CREATE OR REPLACE PACKAGE BODY paket AS
     PROCEDURE add_anime(
        v_id number,
        v_title  anime4.title%TYPE, 
        v_synopsis anime4.synopsis%type,   
        v_genre  anime4.genre%TYPE,
        v_aired  anime4.aired%TYPE, 
        v_episodes  anime4.episodes%TYPE,
        v_members  anime4.members%TYPE,
        v_popularity  anime4.popularity%TYPE, 
        v_ranked  anime4.ranked%TYPE,
        v_score  anime4.score%TYPE,
        v_image  anime4.img_url%type,
        v_link  anime4.link%TYPE) IS
    BEGIN
        EXECUTE IMMEDIATE 'INSERT INTO anime4(id,title,synopsis,genre,aired,episodes,members,popularity,ranked,score,img_url,link) VALUES(:1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12)'
        using v_id, v_title, v_synopsis, v_genre, v_aired, v_episodes, v_members, v_popularity, v_ranked, v_score, v_image, v_link; 
    end add_anime;
    
    PROCEDURE upd_anime(
        v_title  anime4.title%TYPE,             v_synopsis anime4.synopsis%type,   
        v_genre  anime4.genre%TYPE,             v_aired  anime4.aired%TYPE, 
        v_episodes  anime4.episodes%TYPE,       v_members  anime4.members%TYPE,
        v_popularity  anime4.popularity%TYPE,   v_ranked  anime4.ranked%TYPE,
        v_score  anime4.score%TYPE,             v_image  anime4.img_url%type,
        v_link  anime4.link%TYPE,               v_id  number) IS
        
    BEGIN
        EXECUTE IMMEDIATE 'UPDATE anime4 SET title = :1, synopsis = :2, genre = :3, aired = :4,episodes = :5, members = :6 ,popularity = :7, ranked = :8 ,score = :9, img_url = :10,link = :11 WHERE id = :id' 
        USING v_title, v_synopsis, v_genre, v_aired, v_episodes, v_members, v_popularity, v_ranked, v_score, v_image, v_link, v_id;
    END upd_anime;


    PROCEDURE del_anime(p_id number) IS 
    BEGIN
    EXECUTE IMMEDIATE 'DELETE FROM anime4 where id = :id' using p_id;
    END del_anime;
END paket;

----insert
--BEGIN 
--paket.add_anime(12130,'Amaterasu','Hello gues Im so deaddd','Action','15-fdu-2021',1,5000,12000,16,9,'https://cdn.myanimelist.net/images/anime/3/83528.jpg','www.google.com'); 
--END; 

----update
--BEGIN 
--paket.upd_anime('Jango','Hello gues Im whot','GzzzA','15-fdu-2021',1,6000,18000,10,8,'https://cdn.myanimelist.net/images/anime/3/83528.jpg','www.youtube.com',10); 
--END;

--BEGIN 
--paket.del_anime(10); 
--END;