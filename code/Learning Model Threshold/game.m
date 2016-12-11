%% game function. Representing one game of poker. Calls the functions headsup and headsup2
function [winner,counter]=game(startCapitalP1,riskFactorP1,startCapitalP2,riskFactorP2,betValue)

%transfer of variables
playerP1 = [riskFactorP1 startCapitalP1 0 0 1.16]; %player matrix containing all important parameters and variable for player1
playerP2 = [riskFactorP2 startCapitalP2 0 0]; %player matrix containing all important parameters and variable for player2
counter = 0;

%loop calling the headsup functions alternating between headsup and
%headsup2. Runs until one player is out of "money".
%headsup: player1 has to pay the mandatory blind
%headsup2: player2 has to pay the mandatory blind
while playerP1(2) > 0 && playerP2(2) > 0; 
    counter = counter + 1;
    decide_who_starts = mod(counter, 2);
    
    %input: needed variables captial, risk factor, bet size
    %output: capital of player1 and player2
    oldRiskFactor = playerP1(5); %set value to determine if riskfactor has changed
    if decide_who_starts == 1
        [playerP1(2),playerP2(2),playerP1(5)]=headsup(playerP1(2),playerP1(1),playerP2(2),playerP2(1),betValue,playerP1(5));
    else
        [playerP1(2),playerP2(2),playerP1(5)]=headsup2(playerP1(2),playerP1(1),playerP2(2),playerP2(1),betValue,playerP1(5));
    end;
    
    %adjust risk factor of player1 to optimal value for the estimated
    %risk factor from player 2, if it has changed
    if  playerP1(5)<1.16 && oldRiskFactor ~= playerP1(5)
        playerP1(1) = adjustRiskFactor(playerP1(5));
    end  
end;

%when player2 is out of money the win counter is increased by 1
if playerP1(2) == 0
    winner = 0;
elseif playerP2(2) == 0
    winner = 1;
else
    error('Error with headsup')
end