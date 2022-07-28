/* 1 - fact  */

:- dynamic movie/5, movie_title/3, cast/1, keyword/1.

/*   fix data   */
genre('Drama').
genre('Action').
genre('Crime').
genre('Biography').
genre('Adventure').
genre('History').
genre('Sci-Fi').
genre('genre-test-1').


language('en').
language('fr').
language('cn').

/* dynamic data*/


/*  
movie/5
movie(movie_title(id,name,description),[cast(cast1),cast(cast2)], [keyword('key1'), keyword('key2') ], [genre('Drama'), genre('Action')], [language('en'),language('cn').])   
*/
movie(movie_title(1, 'The Shawshank Redemption','description')                              , [cast('Tim Robbins'), cast('Morgan Freeman'), cast('Bob Gunton')]              , [keyword('story'), keyword('wrongful imprisonment'), keyword('prison'), keyword('based on the works of stephen king'), keyword( 'escape from prison'), keyword( 'voice over narration')]    , [genre('Drama')]                                         , [ language('en'), language('fr')]     ).
movie(movie_title(2, 'The Godfather','description')                                         , [cast('Marlon Brando'), cast('Al Pacino'), cast('James Caan','')]              , [keyword('story'), keyword('mafia'), keyword( 'patriarch'), keyword( 'crime family'), keyword( 'organized crime'), keyword( 'gambling syndicate')]                                          , [genre('Drama'), genre('Crime')]                         , [ language('en')]          ).
movie(movie_title(3, 'The Dark Knight','description')                                       , [cast('Christian Bale'), cast('Heath Ledger'), cast('Aaron Eckhart')]          , [keyword('story'), keyword('dc comics'), keyword( 'moral dilemma'), keyword( 'psychopath'), keyword( 'clown'), keyword( 'superhero')]                                                       , [genre('Drama'), genre('Crime'), genre('Action')]        , [ language('en'), language('fr'), language('cn')]).
movie(movie_title(4, 'The Godfather: Part II','description')                                , [cast('Al Pacino'), cast('Robert De Niro'), cast('Robert Duvall')]             , [keyword('story'), keyword('revenge'), keyword( 'mafia'), keyword( '1950s'), keyword( 'corrupt politician'), keyword( 'cuban revolution')]                                                  , [genre('Drama'), genre('Crime')]                         , [ language('en'), language('fr')]     ).
movie(movie_title(5, '12 Angry Men','description')                                          , [cast('Henry Fonda'), cast('Lee J. Cobb'), cast( 'Martin Balsam')]             , [keyword('story'), keyword('jury room'), keyword( 'jury'), keyword( 'dialogue driven'), keyword( 'courtroom'), keyword( 'trial')]                                                           , [genre('Drama'), genre('Crime')]                         , [ language('en'), language('fr'), language('cn')]).
movie(movie_title(6, 'The Lord of the Rings: The Return of the King','description')         , [cast('Elijah Wood'), cast('Viggo Mortensen'), cast('Ian McKellen')]           , [keyword('story'), keyword('epic'), keyword( 'orc'), keyword( 'hobbit'), keyword( 'ring'), keyword( 'middle earth')]                                                                        , [genre('Drama'), genre('Action'), genre('Adventure')]    , [ language('en')]          ).
movie(movie_title(7, 'Pulp Fiction','description')                                          , [cast('John Travolta'), cast('Uma Thurman'), cast('Samuel L. Jackson')]        , [keyword('story'), keyword('nonlinear timeline'), keyword( 'overdose'), keyword( 'drug use'), keyword( 'drug overdose'), keyword( 'drug dealing')]                                          , [genre('Drama'), genre('Crime')]                         , [ language('en')]          ).
movie(movie_title(8, 'Schindler''s List','description')                                     , [cast('Liam Neeson'), cast('Ralph Fiennes'), cast('Ben Kingsley')]             , [keyword('story'), keyword('soap'), keyword( 'accountant'), keyword( 'champagne'), keyword( 'villa'), keyword( 'womanizer')]                                                                , [genre('Drama'), genre('Biography'), genre('History')]   , [ language('en'), language('fr')]    ).
movie(movie_title(9, 'Inception','description')                                             , [cast('Leonardo DiCaprio'), cast( 'Joseph Gordon-Levitt'), cast('Elliot Page')], [keyword('story'), keyword('dream'), keyword( 'ambiguous ending'), keyword( 'subconscious'), keyword( 'mindbender'), keyword( 'surprise ending')]                                           , [genre('Drama'), genre('Adventure'), genre('Sci-Fi')]   , [ language('en'), language('fr'), language('cn')]).
movie(movie_title(10, 'The Lord of the Rings: The Fellowship of the Ring','description')    , [cast('Elijah Wood'), cast('Ian McKellen'), cast('Orlando Bloom')]             , [keyword('story'), keyword('ring'), keyword( 'quest'), keyword( 'hobbit'), keyword( 'epic'), keyword( 'middle earth')]                                                                      , [genre('Drama'), genre('Action'), genre('Adventure')]    , [ language('en'), language('fr')]    ).




/*  2-  Rule                       */

member(X, [X|_]) .
member(X, [_|R]) :- member(X, R).
members([X|T], L) :- member(X, L), members(T, L).
members([X|[]], L) :- member(X, L).

/*
test:
    member(1,[1,2]).
    members([genre('History')], [genre('History')]).
????
    findall(genre(L), genre(L), LL), members([genre('History')], LL).
    findall(genre(L), genre(L), LL), members([genre('History'), genre('Sci-Fi')], LL).    
    findall(genre(L), genre(L), LL),members([genre('History'), genre('Sci-Fi'),genre('not not')], LL).

*/

includeString(X,Y) :-
    sub_atom(Y,_,_,_,X).


/* ----------------------------  3. function in Java : CRUD  */
/*   add   */
add_movie(ID, Name, Description, Casts, Keywords, Genres, Languages) :-
    % check if casts length is not less than 3
    length(Casts, NumCasts),
    NumCasts<3 ->
        write('update failed, the casts number is less than 3.'), fail();

    % check if Keywords length is not less than 5
    length(Keywords, NumKeywords),
    NumKeywords<5 ->
        write('update failed, the Keywords number is less than 5.'), fail();

    findall(genre(G), genre(G), GL),
    findall(language(L), language(L), LL),

    not(movie(movie_title(ID, _, _), _, _, _, _ )) , members(Genres, GL), members(Languages, LL) -> 
        assertz(movie(movie_title(ID, Name, Description), Casts, Keywords, Genres, Languages));
        write('update failed, please check if movie id is duplicated, genre or language is existed.'),
        fail().

/*

add_movie( 'test2,','title 1', 'Description 1', [cast('c1'), cast('c2'), cast('c3')],  [keyword('k1'), keyword('k2'), keyword('k3'), keyword('k4'), keyword('k5')],  [genre('History'), genre('Sci-Fi')],  [language('en'), language('fr')]).

% will be fail due to the duplicated id
add_movie( 'test2,','title 2', 'Description 1', [cast('c1'), cast('c2'), cast('c3')],  [keyword('k1'), keyword('k2'), keyword('k3'), keyword('k4'), keyword('k5')],  [genre('History'), genre('Sci-Fi')],  [language('en'), language('fr')]).

% will be fail due to  not existed language
add_movie( 'test3,','title 3', 'Description 1', [cast('c1'), cast('c2'), cast('c3')],  [keyword('k1'), keyword('k2'), keyword('k3'), keyword('k4'), keyword('k5')],  [genre('History'), genre('Sci-Fi')],  [language('en'), language('sp')]).

% will be fail due to  missing enough keyword
add_movie( 'test4,','title 4', 'Description 1', [cast('c1'), cast('c2'), cast('c3')],  [keyword('k1'), keyword('k2'), keyword('k3'), keyword('k4')],  [genre('History'), genre('Sci-Fi')],  [language('en'), language('fr')]).

% will be fail due to  missing enough cast
add_movie( 'test5,','title 1', 'Description 1', [cast('c1'), cast('c2')],  [keyword('k1'), keyword('k2'), keyword('k3'), keyword('k4'), keyword('k5')],  [genre('History'), genre('Sci-Fi')],  [language('en'), language('fr')]).


*/
/*   add movie title   */
add_movie_title(NewId, NewTitle):-
    not(movie(movie_title(NewId, _, _), _, _, _, _ )) ->
        assertz(movie(movie_title(NewId, NewTitle, ''), [], [], [], []));
        write('update failed, please check if movie id existed.'),
        fail().

/*
add_movie_title('id 1','title 1').
add_movie_title('id 2','title 2').
//will be fail
add_movie_title('id 1','title 11').

*/

/*   update   */
update_movie_title(Update_id, Update_title):-
    movie(movie_title(Update_id, Origin_title, Description), Casts, Keywords, Genres, Languages) ->
        retract(movie(movie_title(Update_id, Origin_title, Description), Casts, Keywords, Genres, Languages)),
        assertz(movie(movie_title(Update_id, Update_title, Description), Casts, Keywords, Genres, Languages));
        write('update failed, please check if movie id existed.'),
        fail().

/*
update_movie_title('id 1','title 1- updated').
update_movie_title('id 2','title 2 - updated').

will faile 
update_movie_title('id 2000','title 2 - updated').


*/


/*   remove   */
remove_movie(Movid_id):-
    movie(movie_title(Movid_id, _, _), _, _, _, _ ) ->
        retract(movie(movie_title(Movid_id, _, _), _, _, _, _ ));
        write('movie id is not existed, fail to remove.'),fail.


/*
remove_movie('id 1').
*/

/* ---------------------------- print all movie titles.   */

print_all(Id, Title):-
    %movie(Id, Title, _, _, _, _).
    movie(movie_title(Id,Title, _), _, _, _, _ ).

print_all(Title,Casts,Keywords,Genres,Languages)   :-
    movie( Title, Casts, Keywords, Genres, Languages).