

% ________________________________note_____________________________________
% the huge bulk of text at the start of each section is me trying to
% explain as best as i can the concept in this section. you can totaly skip 
% reading it. enjoy ;)


%% enter the number of players and check if the entered number is valid

% prompt the players to enter their names then check if the number of
% players entered is a whole number by using the modulus. if the
% modulus is 0, then this is a whole number and the loop will continue to 
% check if the number is smaller or bigger than 2. sadly we cant play secret
% santa with less than 2 players :(.
% if the modulus is anuthing but 0, then this is a decimal number and the
% loop will restart. if it is a string, the system will display an error 
% and the loop will restart.


% set condition to be false as a start
cond = 0;
while cond == 0
    % ask the user to enter the players number
    prompt = "Please enter the number of players.  ";
    num_players = (input(prompt));

    % check if the entered number is a whole number
    if mod(num_players,1) == 0

        if (num_players <= 2)
            disp("The number you entered is smaller than 2. Please enter a " + ...
                "bigger number.")   
        elseif (num_players > 2)
            cond = 1 ; 
        end    
    else
        disp("You didn't enter a corret value. Please enter a whole number bigger than 2.")
    end
end


%% enter the players names

% the entered names will be set to lower case and any spaces at the start 
% or the end will be trimed. then they will be saved in an array called
% players_list


% create an empty string with the size of the players
players_list = strings(1,num_players);

for i = 1:num_players
    players_list(i) = strtrim(lower(input(sprintf("Please enter the name of player number %d.  ",i),'s')));
end    


%% assigne players to each others

% create two unique arrays r1 & r2 both containing random numbers from 1 up
% to the number of players and the number of elements inside is also equal
% to the number of players. then, check if the i-th number in both arrays 
% are similar. if so, then the numbers in r2 will change until the are no 
% longer similar in their position as r1. 
% example: r1 = 1,3 ; r2 = 1,3  this is not accepted, so r2 will change and 
% will be r2 = 3,1   .
% next, each number in r1 will be paired with its respective in r2 and all 
% numbers will be put next to each other in an array called players_pairs.
% example: players_pairs = 1,3,3,1  or players_pairs = r1(1),r2(1),r1(2),r2(2)
% finaly, each number is assigned to a name and we end up with an array 
% called players_pairs_names in which each player will be the secret santa 
% of the previous one.

% create two random arrays r1 and r2
r1 = randperm(num_players,num_players)
r2 = randperm(num_players,num_players)

% check if each ID in r1 isn't the same as it's respective ID in r2
i = 1;
while i < (num_players+1)
    if r1(i) == r2(i)
        r2 = randperm(num_players,num_players)
        i = 1;
        continue
    end 
    i = i + 1;
end   

% create an array of zeroes with size double the number of players
players_pairs = zeros(1,num_players*2)

% put each ID and its opposing one from r1 and r2 next to each other in 
% an array. this array contains all the ID.
I = 1;
for i = 1:2:num_players*2
    players_pairs(i) = r1(I);
    players_pairs(i+1) = r2(I);
    I = I + 1;
end

% create an empty aray of strings of size double the number of players
players_pairs_names = strings(1,num_players*2);

% replace each ID with the player's name
for i = 1:2:num_players*2
    players_pairs_names(i) = players_list(players_pairs(i));
    players_pairs_names(i+1) = players_list(players_pairs(i+1));
end


%% ask each player individualy to enter his/her name and display his secret santa

% prompt the player to enter his name. the entered names will be set to 
% lower case and any spaces at the start or the end will be trimed. then, 
% check if the entered value is a string and that this string is either a
% name on the players list or end. if it is a name on the players list, then
% the respective secret santa will be displayed. is it is he word 'end', then
% the game will end deleting any saved values. if it is anything else a
% message will be displayed to ask the user to re-enter the name


cond = 0;
End = "end";
sprintf("In the next part, each player chould enter his/her name individualy" + ...
    " and their secret santa will be displayed. \n When you finish please enter" + ...
    " the word 'end' in plase of your name.\n")

while cond == 0
    % temporarly put the entered name in a variable 
    name = strtrim(lower(input(sprintf("Please enter your name.  "),'s')));
    
    % check if the entered name is in the players list and display the
    % secret santa
    if ismember(name,players_pairs_names)
        for i = 1:2:num_players*2
            if strcmp(name,players_pairs_names(i))
                sprintf("your secret santa is %s.",players_pairs_names(i+1))
                break
            end    
        end

    % check if the entered name is the word 'end'    
    elseif strcmp(name,End)
        break
    
    else
        disp("Your name is not on the players list. Please check that there are no typos")
    end    
end






