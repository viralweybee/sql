select * from actor
select * from director
select * from genres
select * from movie
select * from movie_cast;
select * from movie_direction;
select * from movie_genres;
select * from rating;
select * from reviewer;

--1) Write a SQL query to find the name and year of the movies. Return movie title, movie release year.
select mov_title,mov_year from movie

--2)write a SQL query to find when the movie ‘American Beauty’ released. Return movie release year.
select mov_year from movie where mov_title='American Beauty';

--3) write a SQL query to find the movie, which was made in the year 1999. Return movie title.
select mov_title from movie where mov_year='1999';

--4) write a SQL query to find those movies, which was made before 1998. Return movie title.
select mov_title from movie where mov_year<'1998';

--5)write a SQL query to find the name of all reviewers and movies together in a single list.
select rv.rev_name,m.mov_title from movie m inner join rating r on m.mov_id=r.mov_id inner join reviewer rv on r.rev_id=rv.rev_id

--6)write a SQL query to find all reviewers who have rated 7 or more stars to their rating. Return reviewer name.
select rv.rev_name,ra.rev_stars from rating ra inner join reviewer rv on ra.rev_id=rv.rev_id where ra.rev_stars>'7';

--7)write a SQL query to find the movies without any rating. Return movie title.
select m.mov_title,r.rev_id from movie m inner join rating r on m.mov_id=r.mov_id where r.rev_stars is null

--8)write a SQL query to find the movies with ID 905 or 907 or 917. Return movie title.
select mov_title from movie where mov_id='905' or mov_id='907' or mov_id='917';

--9)write a SQL query to find those movie titles, which include the words 'Boogie Nights'. Sort the result-set in ascending order by movie year. Return movie ID, movie title and movie release year
select mov_id,mov_title,mov_year from movie where mov_title='Boogie Nights' or mov_title='%Boogie Nights%' or mov_title='%Boogie Nights' or mov_title='Boogie Nights%' order by mov_year;

--10)write a SQL query to find those actors whose first name is 'Woody' and the last name is 'Allen'. Return actor ID
select act_id from actor where act_fname='Woody' and act_lname='Allen';




--                                                            subqueries



--1.	Find the actors who played a role in the movie 'Annie Hall'. Return all the fields of actor table.
select a.* from movie m inner join movie_cast mc on m.mov_id=mc.mov_id inner join actor a on mc.act_id=a.act_id where m.mov_title='Annie Hall'


--2.write a SQL query to find the director who directed a movie that casted a role for 'Eyes Wide Shut'. Return director first name, last name.
select  d.dir_fname,d.dir_lname
from movie m inner join movie_direction md on m.mov_id=md.mov_id
inner join director d on md.dir_id=d.dir_id where m.mov_title='Eyes Wide Shut';

--3.write a SQL query to find those movies, which released in the country besides UK. Return movie title, movie year, movie time, date of release, releasing country.
select mov_title,mov_year,mov_time,mov_dt_rel,mov_rel_country
from movie 
where mov_rel_country <> 'UK'

--4.write a SQL query to find those movies where reviewer is unknown. Return movie title, year, release date, director first name, last name, actor first name, last name.
select m.mov_title,m.mov_year,m.mov_dt_rel,d.dir_fname,d.dir_lname,a.act_fname,a.act_lname from 
movie m inner join rating r on m.mov_id=r.mov_id
inner join reviewer rv on r.rev_id=rv.rev_id 
inner join movie_direction mv on m.mov_id=mv.mov_id
inner join director d on mv.dir_id=d.dir_id
inner join movie_cast mc on m.mov_id=mc.mov_id
inner join actor a on mc.act_id=a.act_id
where rv.rev_name='';

--5.write a SQL query to find those movies directed by the director whose first name is ‘Woddy’ and last name is ‘Allen’. Return movie title. 
select mov_title from movie 
where movie.mov_id in (select mov_id from movie_direction 
where movie_direction.dir_id in (select dir_id from director 
where dir_fname='Woody' and dir_lname='Allen'))

--6. write a SQL query to find those years, which produced at least one movie and that, received a rating of more than three stars. Sort the result-set in ascending order by movie year. Return movie year.
select mov_year 
from movie 
where mov_id in (select mov_id 
from rating 
where rev_stars >'3' )
order by mov_year
--7.write a SQL query to find those movies, which have no ratings. Return movie title.
select mov_title 
from movie 
where mov_id in(select mov_id 
from rating 
where rev_stars is null)
--8.write a SQL query to find those reviewers who have rated nothing for some movies. Return reviewer name.
select rev_name
from reviewer 
where rev_id in (select rev_id 
from rating 
where rev_stars is null)	

--9.write a SQL query to find those movies, which reviewed by a reviewer and got a rating. Sort the result-set in ascending order by reviewer name, movie title, review Stars. Return reviewer name, movie title, review Stars.
select reviewer.rev_name,rating.rev_stars,movie.mov_title
from movie,reviewer,rating 
where movie.mov_id=rating.mov_id 
and rating.rev_id=reviewer.rev_id and rev_stars is not null and num_o_ratings is not null
order by reviewer.rev_name,movie.mov_title,rating.rev_stars

--10.	write a SQL query to find those reviewers who rated more than one movie. Group the result set on reviewer’s name, movie title. Return reviewer’s name, movie title.

select rev_name, mov_title 
from reviewer, movie, rating, rating r
where rating.mov_id=movie.mov_id 
  and reviewer.rev_id=rating.rev_ID 
    and rating.rev_id = r.rev_id 
group by rev_name,mov_title having count(*) > 1;



--11 write a SQL query to find those movies, which have received highest number of stars. Group the result set on movie title and sorts the result-set in ascending order by movie title. Return movie title and maximum number of review stars. 
select a.mov_title,b.num_o_ratings,b.rev_stars from movie a , rating b 
     where a.mov_id=b.mov_id and b.rev_stars in (select max(rev_stars) from rating )
     order by a.mov_title
--12.	 write a SQL query to find all reviewers who rated the movie 'American Beauty'. Return reviewer name.

select rev_name from reviewer where rev_id in (select rev_id from rating where mov_id in (select mov_id from movie where mov_title='American Beauty'))

--13. write a SQL query to find the movies, which have reviewed by any reviewer body except by 'Paul Monks'. Return movie title. 
select mov_title from movie where mov_id in (select mov_id from rating where rev_id in (select rev_id from reviewer where rev_name!='Paul Monks'))

--14.	write a SQL query to find the lowest rated movies. Return reviewer name, movie title, and number of stars for those movies.
select reviewer.rev_name, movie.mov_title, rating.rev_stars
from reviewer, movie, rating
where  rating.rev_id = reviewer.rev_id
and rating.mov_id = movie.mov_id and rating.rev_stars in (
select MIN(rating.rev_stars)
from rating
)

--15.	 write a SQL query to find the movies directed by 'James Cameron'. Return movie title. 
select mov_title ,mov_id
from movie 
where mov_id 
in (select mov_id 
from movie_direction 
where dir_id 
in(select dir_id 
from director where dir_fname='James' and dir_lname='Cameron'));

--16.	Write a query in SQL to find the name of those movies where one or more actors acted in two or more movies.
	select act_id from movie_cast group by act_id
	having count(mov_id)>1
	select mov_title from movie where mov_id in (select mov_id from movie_cast where act_id in (select act_id from movie_cast group by act_id
	having count(mov_id)>1))

--1) subqueries 
select actor.* from movie,movie_cast,actor
where movie.mov_id=movie_cast.mov_id and actor.act_id =movie_cast.act_id
and movie.mov_title='Annie Hall';

select * from actor
where actor.act_id in (select act_id from movie_cast 
where mov_id in (select mov_id from movie where mov_title='Annie Hall'))
 




 --                                join
 --1.	write a SQL query to find the name of all reviewers who have rated their ratings with a NULL value. Return reviewer name.

 select rv.rev_name from reviewer rv 
 inner join rating r on r.rev_id=rv.rev_id
 where r.rev_stars is null;

 --2.	write a SQL query to find the actors who were cast in the movie 'Annie Hall'. Return actor first name, last name and role. 

 select a.act_fname,a.act_lname,mc.role from movie m
 inner join movie_cast mc on mc.mov_id=m.mov_id inner join actor 
 a on a.act_id = mc.act_id where m.mov_title='Annie Hall'


 --3.	write a SQL query to find the director who directed a movie that casted a role for 'Eyes Wide Shut'. Return director first name, last name and movie title.

 select d.dir_fname,d.dir_lname,m.mov_title from movie m inner join movie_direction md on m.mov_id=md.mov_id inner join director d on d.dir_id= md.dir_id
 where m.mov_title='Eyes Wide Shut'  

 --4.	write a SQL query to find who directed a movie that casted a role as ‘Sean Maguire’. Return director first name, last name and movie title.

 select d.dir_fname,d.dir_lname,m.mov_title from movie m inner join movie_direction md on m.mov_id=md.mov_id inner join director d on d.dir_id= md.dir_id inner join movie_cast mc on mc.mov_id=m.mov_id
 where mc.role='Sean Maguire'


 --5.	write a SQL query to find the actors who have not acted in any movie between1990 and 2000 (Begin and end values are included.). Return actor first name, last name, movie title and release year.

 select a.act_fname,a.act_lname,m.mov_title,m.mov_dt_rel from movie m inner join movie_cast mc on mc.mov_id=m.mov_id
 inner join actor a on a.act_id= mc.act_id where m.mov_year >=1990 and m.mov_year<=2000

 --6.	write a SQL query to find the directors with number of genres movies. Group the result set on director first name, last name and generic title. Sort the result-set in ascending order by director first name and last name. Return director first name, last name and number of genres movies.

 select d.dir_fname,d.dir_lname,g.gen_title,count(g.gen_id) from director d inner join movie_direction md on d.dir_id=md.dir_id inner join movie_genres mg on mg.mov_id=md.mov_id inner join genres g on g.gen_id=mg.gen_id
 group by d.dir_fname,d.dir_lname,g.gen_title
 order by d.dir_fname, d.dir_lname

 --7.	write a SQL query to find the movies with year and genres. Return movie title, movie year and generic title.

 select m.mov_title,m.mov_year,g.gen_title from movie m inner join movie_genres mg on mg.mov_id=m.mov_id inner join genres g on g.gen_id=mg.gen_id

 --8.	write a SQL query to find all the movies with year, genres, and name of the director.
 select m.mov_year,g.gen_title,d.dir_fname,d.dir_lname from movie m inner join movie_genres mg on mg.mov_id=m.mov_id inner join genres g on mg.gen_id=g.gen_id inner join movie_direction md on md.mov_id=m.mov_id inner join director d on md.dir_id=d.dir_id;

 --9.	write a SQL query to find the movies released before 1st January 1989. Sort the result-set in descending order by date of release. Return movie title, release year, date of release, duration, and first and last name of the director

 select m.mov_title,m.mov_year,m.mov_dt_rel,m.mov_time,d.dir_fname,d.dir_lname from movie m inner join movie_direction md on md.mov_id=m.mov_id inner join director d on d.dir_id=md.dir_id
 where m.mov_dt_rel<'1989-01-01'
 order by m.mov_dt_rel desc

 --10. write a SQL query to compute the average time and count number of movies for each genre. Return genre title, average time and number of movies for each genre
 select gen_id,count(mov_id) from movie_genres group by gen_id
  select avg(m.mov_time),count(mg.mov_id),g.gen_title from movie_genres mg inner join movie m on m.mov_id=mg.mov_id inner join genres g on g.gen_id=mg.gen_id group by mg.gen_id,g.gen_title

  --11. write a SQL query to find movies with the lowest duration. Return movie title, movie year, director first name, last name, actor first name, last name and role.
  select m.mov_title,m.mov_year,d.dir_fname, d.dir_lname,a.act_fname,a.act_lname,mc.role from movie m inner join movie_direction md on m.mov_id=md.mov_id inner join director d on d.dir_id=md.dir_id inner join movie_cast mc on
  mc.mov_id=m.mov_id inner join actor a on a.act_id=mc.act_id  where m.mov_time in (select min(mov_time) from movie);

  --12.	write a SQL query to find those years when a movie received a rating of 3 or 4. Sort the result in increasing order on movie year. Return move year
  select m.mov_year from movie m inner join rating r on m.mov_id = r.mov_id where r.rev_stars='3' or r.rev_stars='4' order by m.mov_year

  --13.	write a SQL query to get the reviewer name, movie title, and stars in an order that reviewer name will come first, then by movie title, and lastly by number of stars.
  select rv.rev_name,m.mov_title,r.rev_stars from movie m inner join rating r on m.mov_id =r.mov_id inner join reviewer rv on rv.rev_id=r.rev_id order by rv.rev_name,m.mov_title,r.rev_stars 

  --14.	write a SQL query to find those movies that have at least one rating and received highest number of stars. Sort the result-set on movie title. Return movie title and maximum review stars.
  select m.mov_title,r.rev_stars from movie m inner join rating r on r.mov_id=m.mov_id where r.num_o_ratings>1 and r.rev_stars =(select max(rev_stars) from rating)

  --15.	write a SQL query to find those movies, which have received ratings. Return movie title, director first name, director last name and review stars.
  select m.mov_title,d.dir_fname,d.dir_lname,r.rev_stars from movie m inner join rating r on r.mov_id=m.mov_id inner join movie_direction md on md.mov_id=m.mov_id inner join director d on d.dir_id=md.dir_id where r.rev_stars is not null

  --16.	Write a query in SQL to find the movie title, actor first and last name, and the role for those movies where one or more actors acted in two or more movies
	select m.mov_title from movie m inner join movie_cast mc on mc.mov_id=m.mov_id inner join  actor a on a.act_id=mc.act_id 
	where a.act_id in (select act_id from movie_cast group by act_id having count(mov_id)>1)
