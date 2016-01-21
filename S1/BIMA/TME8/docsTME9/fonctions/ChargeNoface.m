function [ imatab ] = ChargeNoface( PathTrain)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

listima=dir([PathTrain '*.jpg'])

nl=64;
nc=64;
d=nc*nl;
n=length(listima);

imatab=zeros(nl,nc,n);

%Lecture des images
for ii=1:n;
    filename= listima(ii).name
    imatab(:,:,ii) = couleurtoniveaugris(imread([PathTrain,filename]));
end