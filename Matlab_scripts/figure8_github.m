
close all
clear all
load('ecosimoutputsjuly2023.mat')
ecosimoutputs=ecosimoutputsjuly2023;
%% Vulnerability 1

vulnerability=ecosimoutputs{:,5};
VULNERABILITY=unique(vulnerability);

scenario=ecosimoutputs{:,6};
SCENARIO=unique(scenario);
a =find(scenario==SCENARIO(6) & vulnerability==VULNERABILITY(1)); % no MHWs
c =find(scenario==SCENARIO(1) & vulnerability==VULNERABILITY(1)); % MHW
e =find(scenario==SCENARIO(2) & vulnerability==VULNERABILITY(1)); % longMHW
g =find(scenario==SCENARIO(3) & vulnerability==VULNERABILITY(1)); % strong2
h =find(scenario==SCENARIO(5) & vulnerability==VULNERABILITY(1)); % strong3
%% control:

species=ecosimoutputs{a,8};
biomass=ecosimoutputs{a,10};
biomass_std=ecosimoutputs{a,11};
cathegory=ecosimoutputs{a,9};
SPECIES=unique(species);

for i=1:length(SPECIES)
A=find(species == SPECIES(i));
biomass_nomhw(:,i)=biomass(A); 
biomass_nomhw_std(:,i)=biomass_std(A); 
CATHEGORY(i)=unique(cathegory(A));
end
%% current MHWs:
species=ecosimoutputs{c,8};
biomass=ecosimoutputs{c,10};
biomass_std=ecosimoutputs{c,11};
cathegory=ecosimoutputs{c,9};
SPECIES=unique(species);

for i=1:length(SPECIES)
A=find(species == SPECIES(i));
biomass_mhw(:,i)=biomass(A); 
biomass_mhw_std(:,i)=biomass_std(A);
end
%% long MHWs:
species=ecosimoutputs{e,8};
biomass=ecosimoutputs{e,10};
biomass_std=ecosimoutputs{e,11};
cathegory=ecosimoutputs{e,9};
SPECIES=unique(species);

for i=1:length(SPECIES)
A=find(species == SPECIES(i));
biomass_longmhw(:,i)=biomass(A); 
biomass_longmhw_std(:,i)=biomass_std(A);
end
%% moderate MHWs:
species=ecosimoutputs{g,8};
biomass=ecosimoutputs{g,10};
biomass_std=ecosimoutputs{g,11};
cathegory=ecosimoutputs{g,9};
SPECIES=unique(species);

for i=1:length(SPECIES)
A=find(species == SPECIES(i));
biomass_strong2mhw(:,i)=biomass(A); 
biomass_strong2mhw_std(:,i)=biomass_std(A);
end
%% strong MHWs:
species=ecosimoutputs{h,8};
biomass=ecosimoutputs{h,10};
biomass_std=ecosimoutputs{h,11};
cathegory=ecosimoutputs{h,9};
SPECIES=unique(species);

for i=1:length(SPECIES)
A=find(species == SPECIES(i));
biomass_strong3mhw(:,i)=biomass(A); 
biomass_strong3mhw_std(:,i)=biomass_std(A);
end
%% R and error:
rel_mhw=((biomass_mhw-biomass_nomhw)./biomass_nomhw)*100;
rel_long=((biomass_longmhw-biomass_nomhw)./biomass_nomhw)*100;
rel_strong2=((biomass_strong2mhw-biomass_nomhw)./biomass_nomhw)*100;
rel_strong3=((biomass_strong3mhw-biomass_nomhw)./biomass_nomhw)*100;
B=biomass_nomhw;
EB=biomass_nomhw_std/sqrt(500);
SB=biomass_nomhw_std;
A=biomass_mhw;
EA=biomass_mhw_std/sqrt(500);
SA=biomass_mhw_std;

rel_mhw_std2=(abs(A./B).*(sqrt((SA./A)).^2+(SB./B).^2))*100;
A=biomass_longmhw;
EA=biomass_longmhw_std/sqrt(500);
SA=biomass_longmhw_std;

rel_longmhw_std2=(abs(A./B).*(sqrt((SA./A)).^2+(SB./B).^2))*100;
A=biomass_strong2mhw;
EA=biomass_strong2mhw_std/sqrt(500);
SA=biomass_strong2mhw_std;

rel_strong2mhw_std2=(abs(A./B).*(sqrt((SA./A)).^2+(SB./B).^2))*100;
A=biomass_strong2mhw;
EA=biomass_strong2mhw_std/sqrt(500);
SA=biomass_strong2mhw_std;

rel_strong3mhw_std2=(abs(A./B).*(sqrt((SA./A)).^2+(SB./B).^2))*100;
limx=[datenum(2012,01,01)  datenum(2042,12,31)];
dvec=datenum(2012:1:2042,01,01);
ttime=datenum(2012,01:372,01);
COLOR=jet(36)
%% grafico por esecie por separado para el scenario MHW
v2=load('rel_mhw_vulenrability2_v5');
v2_long=load('rel_mhw_long_vulenrability2_v5.mat');
v2_strong2=load('rel_mhw_strong2_vulenrability2_v5.mat');
v2_strong3=load('rel_mhw_strong3_vulenrability2_v5.mat');
v10=load('rel_mhw_vulenrability10_v5');
v10_long=load('rel_mhw_long_vulenrability10_v5');
v10_strong2=load('rel_mhw_strong2_vulenrability10_v5');
v10_strong3=load('rel_mhw_strong3_vulenrability10_v5');


[a b]=find(CATHEGORY=="Primary producers");
[A B]=find(CATHEGORY=="Microbial community");
[e f]=find(CATHEGORY=="Corals");
[g h]=find(CATHEGORY=="Sponges");
[a1, b1]=find(CATHEGORY=="Herbivores");
[c d]=find(CATHEGORY=="Detritus");
[a2 b2]=find(CATHEGORY=="Omnivores");
[a3 b3]=find(CATHEGORY=="Low-level predators");
[a4 b4]=find(CATHEGORY=="Mid-level predators");
[a5 b5]=find(CATHEGORY=="Top-level predators");
CATT=unique(CATHEGORY);

%% CONSUMERS/PRODUCERS
[A B]=find(SPECIES==SPECIES(27));% fito
[C D]=find(SPECIES==SPECIES(20))% micro
[E F]=find(SPECIES==SPECIES(24))% micro
[a b]=find(CATHEGORY==CATT(8));
producers_nomhw_v1=nansum(biomass_nomhw(:,b),2)-nansum(biomass_nomhw(:,A),2);
total_biomass_nomhw_v1=nansum(biomass_nomhw,2)-nansum(biomass_nomhw(:,C),2)-nansum(biomass_nomhw(:,E),2);
consumers_nomhw_v1=total_biomass_nomhw_v1-producers_nomhw_v1;
cpr_nomhw_v1=consumers_nomhw_v1./producers_nomhw_v1;
producers_mhw_v1=nansum(biomass_mhw(:,b),2)-nansum(biomass_mhw(:,A),2);
total_biomass_mhw_v1=nansum(biomass_mhw,2)-nansum(biomass_mhw(:,C),2)-nansum(biomass_mhw(:,E),2);
consumers_mhw_v1=total_biomass_mhw_v1-producers_mhw_v1;
cpr_mhw_v1=consumers_mhw_v1./producers_mhw_v1;
producers_longmhw_v1=nansum(biomass_longmhw(:,b),2)-nansum(biomass_longmhw(:,A),2);
total_biomass_longmhw_v1=nansum(biomass_longmhw,2)-nansum(biomass_longmhw(:,C),2)-nansum(biomass_longmhw(:,E),2);
consumers_longmhw_v1=total_biomass_longmhw_v1-producers_longmhw_v1;
cpr_longmhw_v1=consumers_longmhw_v1./producers_longmhw_v1;
producers_strong2mhw_v1=nansum(biomass_strong2mhw(:,b),2)-nansum(biomass_strong2mhw(:,A),2);
total_biomass_strong2mhw_v1=nansum(biomass_strong2mhw,2)-nansum(biomass_strong2mhw(:,C),2)-nansum(biomass_strong2mhw(:,E),2);
consumers_strong2mhw_v1=total_biomass_strong2mhw_v1-producers_strong2mhw_v1;
cpr_strong2mhw_v1=consumers_strong2mhw_v1./producers_strong2mhw_v1;
producers_strong3mhw_v1=nansum(biomass_strong3mhw(:,b),2)-nansum(biomass_strong3mhw(:,A),2);
total_biomass_strong3mhw_v1=nansum(biomass_strong3mhw,2)-nansum(biomass_strong3mhw(:,C),2)-nansum(biomass_strong3mhw(:,E),2);
consumers_strong3mhw_v1=total_biomass_strong3mhw_v1-producers_strong3mhw_v1;
cpr_strong3mhw_v1=consumers_strong3mhw_v1./producers_strong3mhw_v1;
producers_nomhw_v2=nansum(v2.biomass_nomhw(:,b),2)-nansum(v2.biomass_nomhw(:,A),2);
total_biomass_nomhw_v2=nansum(v2.biomass_nomhw,2)-nansum(v2.biomass_nomhw(:,C),2)-nansum(v2.biomass_nomhw(:,E),2);
consumers_nomhw_v2=total_biomass_nomhw_v2-producers_nomhw_v2;
cpr_nomhw_v2=consumers_nomhw_v2./producers_nomhw_v2;
producers_mhw_v2=nansum(v2.biomass_mhw(:,b),2)-nansum(v2.biomass_mhw(:,A),2);
total_biomass_mhw_v2=nansum(v2.biomass_mhw,2)-nansum(v2.biomass_mhw(:,C),2)-nansum(v2.biomass_mhw(:,E),2);
consumers_mhw_v2=total_biomass_mhw_v2-producers_mhw_v2;
cpr_mhw_v2=consumers_mhw_v2./producers_mhw_v2;
producers_longmhw_v2=nansum(v2_long.biomass_longmhw(:,b),2)-nansum(v2_long.biomass_longmhw(:,A),2);
total_biomass_longmhw_v2=nansum(v2_long.biomass_longmhw,2)-nansum(v2_long.biomass_longmhw(:,C),2)-nansum(v2_long.biomass_longmhw(:,E),2);
consumers_longmhw_v2=total_biomass_longmhw_v2-producers_longmhw_v2;
cpr_longmhw_v2=consumers_longmhw_v2./producers_longmhw_v2;
producers_strong2mhw_v2=nansum(v2_strong2.biomass_strong2mhw(:,b),2)-nansum(v2_strong2.biomass_strong2mhw(:,A),2);
total_biomass_strong2mhw_v2=nansum(v2_strong2.biomass_strong2mhw,2)-nansum(v2_strong2.biomass_strong2mhw(:,C),2)-nansum(v2_strong2.biomass_strong2mhw(:,E),2);
consumers_strong2mhw_v2=total_biomass_strong2mhw_v2-producers_strong2mhw_v2;
cpr_strong2mhw_v2=consumers_strong2mhw_v2./producers_strong2mhw_v2;
producers_strong3mhw_v2=nansum(v2_strong3.biomass_strong3mhw(:,b),2)-nansum(v2_strong3.biomass_strong3mhw(:,A),2);
total_biomass_strong3mhw_v2=nansum(v2_strong3.biomass_strong3mhw,2)-nansum(v2_strong3.biomass_strong3mhw(:,C),2)-nansum(v2_strong3.biomass_strong3mhw(:,E),2);
consumers_strong3mhw_v2=total_biomass_strong3mhw_v2-producers_strong3mhw_v2;
cpr_strong3mhw_v2=consumers_strong3mhw_v2./producers_strong3mhw_v2;
producers_nomhw_v10=nansum(v10.biomass_nomhw(:,b),2)-nansum(v10.biomass_nomhw(:,A),2);
total_biomass_nomhw_v10=nansum(v10.biomass_nomhw,2)-nansum(v10.biomass_nomhw(:,C),2)-nansum(v10.biomass_nomhw(:,E),2);
consumers_nomhw_v10=total_biomass_nomhw_v10-producers_nomhw_v10;
cpr_nomhw_v10=consumers_nomhw_v10./producers_nomhw_v10;
producers_mhw_v10=nansum(v10.biomass_mhw(:,b),2)-nansum(v10.biomass_mhw(:,A),2);
total_biomass_mhw_v10=nansum(v10.biomass_mhw,2)-nansum(v10.biomass_mhw(:,C),2)-nansum(v10.biomass_mhw(:,E),2);
consumers_mhw_v10=total_biomass_mhw_v10-producers_mhw_v10;
cpr_mhw_v10=consumers_mhw_v10./producers_mhw_v10;
producers_longmhw_v10=nansum(v10_long.biomass_longmhw(:,b),2)-nansum(v10_long.biomass_longmhw(:,A),2);
total_biomass_longmhw_v10=nansum(v10_long.biomass_longmhw,2)-nansum(v10_long.biomass_longmhw(:,C),2)-nansum(v10_long.biomass_longmhw(:,E),2);
consumers_longmhw_v10=total_biomass_longmhw_v10-producers_longmhw_v10;
cpr_longmhw_v10=consumers_longmhw_v10./producers_longmhw_v10;
producers_strong2mhw_v10=nansum(v10_strong2.biomass_strong2mhw(:,b),2)-nansum(v10_strong2.biomass_strong2mhw(:,A),2);
total_biomass_strong2mhw_v10=nansum(v10_strong2.biomass_strong2mhw,2)-nansum(v10_strong2.biomass_strong2mhw(:,C),2)-nansum(v10_strong2.biomass_strong2mhw(:,E),2);
consumers_strong2mhw_v10=total_biomass_strong2mhw_v10-producers_strong2mhw_v10;
cpr_strong2mhw_v10=consumers_strong2mhw_v10./producers_strong2mhw_v10;
producers_strong3mhw_v10=nansum(v10_strong3.biomass_strong3mhw(:,b),2)-nansum(v10_strong3.biomass_strong3mhw(:,A),2);
total_biomass_strong3mhw_v10=nansum(v10_strong3.biomass_strong3mhw,2)-nansum(v10_strong3.biomass_strong3mhw(:,C),2)-nansum(v10_strong3.biomass_strong3mhw(:,E),2);
consumers_strong3mhw_v10=total_biomass_strong3mhw_v10-producers_strong3mhw_v10;
cpr_strong3mhw_v10=consumers_strong3mhw_v10./producers_strong3mhw_v10;
%% CORAL/ALGAE
[a b]=find(CATHEGORY==CATT(1));
[c d]=find(SPECIES==SPECIES(8)|SPECIES==SPECIES(12)|SPECIES==SPECIES(34));%Crustose coralline algae 8- Fleshy macroalgae 12- Turfing microalgae 34
corals_nomhw_v1=nansum(biomass_nomhw(:,b),2);
algae_nomhw_v1=nansum(biomass_nomhw(:,c),2);
car_nomhw_v1=corals_nomhw_v1./algae_nomhw_v1;
corals_mhw_v1=nansum(biomass_mhw(:,b),2);
algae_mhw_v1=nansum(biomass_mhw(:,c),2);
car_mhw_v1=corals_mhw_v1./algae_mhw_v1;
corals_longmhw_v1=nansum(biomass_longmhw(:,b),2);
algae_longmhw_v1=nansum(biomass_longmhw(:,c),2);
car_longmhw_v1=corals_longmhw_v1./algae_longmhw_v1;
corals_strong2mhw_v1=nansum(biomass_strong2mhw(:,b),2);
algae_strong2mhw_v1=nansum(biomass_strong2mhw(:,c),2);
car_strong2mhw_v1=corals_strong2mhw_v1./algae_strong2mhw_v1;
corals_strong3mhw_v1=nansum(biomass_strong3mhw(:,b),2);
algae_strong3mhw_v1=nansum(biomass_strong3mhw(:,c),2);
car_strong3mhw_v1=corals_strong3mhw_v1./algae_strong3mhw_v1;
corals_nomhw_v2=nansum(v2.biomass_nomhw(:,b),2);
algae_nomhw_v2=nansum(v2.biomass_nomhw(:,c),2);
car_nomhw_v2=corals_nomhw_v2./algae_nomhw_v2;
corals_mhw_v2=nansum(v2.biomass_mhw(:,b),2);
algae_mhw_v2=nansum(v2.biomass_mhw(:,c),2);
car_mhw_v2=corals_mhw_v2./algae_mhw_v2;
corals_longmhw_v2=nansum(v2_long.biomass_longmhw(:,b),2);
algae_longmhw_v2=nansum(v2_long.biomass_longmhw(:,c),2);
car_longmhw_v2=corals_longmhw_v2./algae_longmhw_v2;
corals_strong2mhw_v2=nansum(v2_strong2.biomass_strong2mhw(:,b),2);
algae_strong2mhw_v2=nansum(v2_strong2.biomass_strong2mhw(:,c),2);
car_strong2mhw_v2=corals_strong2mhw_v2./algae_strong2mhw_v2;
corals_strong3mhw_v2=nansum(v2_strong3.biomass_strong3mhw(:,b),2);
algae_strong3mhw_v2=nansum(v2_strong3.biomass_strong3mhw(:,c),2);
car_strong3mhw_v2=corals_strong3mhw_v2./algae_strong3mhw_v2;
corals_nomhw_v10=nansum(v10.biomass_nomhw(:,b),2);
algae_nomhw_v10=nansum(v10.biomass_nomhw(:,c),2);
car_nomhw_v10=corals_nomhw_v10./algae_nomhw_v10;
corals_mhw_v10=nansum(v10.biomass_mhw(:,b),2);
algae_mhw_v10=nansum(v10.biomass_mhw(:,c),2);
car_mhw_v10=corals_mhw_v10./algae_mhw_v10;
corals_longmhw_v10=nansum(v10_long.biomass_longmhw(:,b),2);
algae_longmhw_v10=nansum(v10_long.biomass_longmhw(:,c),2);
car_longmhw_v10=corals_longmhw_v10./algae_longmhw_v10;
corals_strong2mhw_v10=nansum(v10_strong2.biomass_strong2mhw(:,b),2);
algae_strong2mhw_v10=nansum(v10_strong2.biomass_strong2mhw(:,c),2);
car_strong2mhw_v10=corals_strong2mhw_v10./algae_strong2mhw_v10;
corals_strong3mhw_v10=nansum(v10_strong3.biomass_strong3mhw(:,b),2);
algae_strong3mhw_v10=nansum(v10_strong3.biomass_strong3mhw(:,c),2);
car_strong3mhw_v10=corals_strong3mhw_v10./algae_strong3mhw_v10;

%% CORALS/SPONGES
[a b]=find(CATHEGORY==CATT(1)); % corals
[c d]=find(CATHEGORY==CATT(9)); %sponges
corals_nomhw_v1=nansum(biomass_nomhw(:,b),2);
sponges_nomhw_v1=nansum(biomass_nomhw(:,d),2);
csr_nomhw_v1=corals_nomhw_v1./sponges_nomhw_v1;
corals_mhw_v1=nansum(biomass_mhw(:,b),2);
sponges_mhw_v1=nansum(biomass_mhw(:,d),2);
csr_mhw_v1=corals_mhw_v1./sponges_mhw_v1;
corals_longmhw_v1=nansum(biomass_longmhw(:,b),2);
sponges_longmhw_v1=nansum(biomass_longmhw(:,d),2);
csr_longmhw_v1=corals_longmhw_v1./sponges_longmhw_v1;
corals_strong2mhw_v1=nansum(biomass_strong2mhw(:,b),2);
sponges_strong2mhw_v1=nansum(biomass_strong2mhw(:,d),2);
csr_strong2mhw_v1=corals_strong2mhw_v1./sponges_strong2mhw_v1;
corals_strong3mhw_v1=nansum(biomass_strong3mhw(:,b),2);
sponges_strong3mhw_v1=nansum(biomass_strong3mhw(:,d),2);
csr_strong3mhw_v1=corals_strong3mhw_v1./sponges_strong3mhw_v1;
corals_nomhw_v2=nansum(v2.biomass_nomhw(:,b),2);
sponges_nomhw_v2=nansum(v2.biomass_nomhw(:,d),2);
csr_nomhw_v2=corals_nomhw_v2./sponges_nomhw_v2;
corals_mhw_v2=nansum(v2.biomass_mhw(:,b),2);
sponges_mhw_v2=nansum(v2.biomass_mhw(:,d),2);
csr_mhw_v2=corals_mhw_v2./sponges_mhw_v2;
corals_longmhw_v2=nansum(v2_long.biomass_longmhw(:,b),2);
sponges_longmhw_v2=nansum(v2_long.biomass_longmhw(:,d),2);
csr_longmhw_v2=corals_longmhw_v2./sponges_longmhw_v2;
corals_strong2mhw_v2=nansum(v2_strong2.biomass_strong2mhw(:,b),2);
sponges_strong2mhw_v2=nansum(v2_strong2.biomass_strong2mhw(:,d),2);
csr_strong2mhw_v2=corals_strong2mhw_v2./sponges_strong2mhw_v2;
corals_strong3mhw_v2=nansum(v2_strong3.biomass_strong3mhw(:,b),2);
sponges_strong3mhw_v2=nansum(v2_strong3.biomass_strong3mhw(:,d),2);
csr_strong3mhw_v2=corals_strong3mhw_v2./sponges_strong3mhw_v2;
corals_nomhw_v10=nansum(v10.biomass_nomhw(:,b),2);
sponges_nomhw_v10=nansum(v10.biomass_nomhw(:,d),2);
csr_nomhw_v10=corals_nomhw_v10./sponges_nomhw_v10;
corals_mhw_v10=nansum(v10.biomass_mhw(:,b),2);
sponges_mhw_v10=nansum(v10.biomass_mhw(:,d),2);
csr_mhw_v10=corals_mhw_v10./sponges_mhw_v10;
corals_longmhw_v10=nansum(v10_long.biomass_longmhw(:,b),2);
sponges_longmhw_v10=nansum(v10_long.biomass_longmhw(:,d),2);
csr_longmhw_v10=corals_longmhw_v10./sponges_longmhw_v10;
corals_strong2mhw_v10=nansum(v10_strong2.biomass_strong2mhw(:,b),2);
sponges_strong2mhw_v10=nansum(v10_strong2.biomass_strong2mhw(:,d),2);
csr_strong2mhw_v10=corals_strong2mhw_v10./sponges_strong2mhw_v10;
corals_strong3mhw_v10=nansum(v10_strong3.biomass_strong3mhw(:,b),2);
sponges_strong3mhw_v10=nansum(v10_strong3.biomass_strong3mhw(:,d),2);
csr_strong3mhw_v10=corals_strong3mhw_v10./sponges_strong3mhw_v10;

%% plots :
COLOR=lines(4);
limx=[datenum(2012,01,01)  datenum(2042,12,31)];
dvec=datenum(2012:1:2042,01,01);
time=datenum(2012,01:372,01);
[a b]=find(time>=datenum(2042,01,01) & time<datenum(2042,12,31));
[c d]=find(time>=datenum(2025,01,01) & time<datenum(2025,12,31));
figure('pos',[10 10 1500 1500]);
subplot(3,1,1)
plot(nanmean(((cpr_mhw_v1(b)-cpr_nomhw_v1(b))./cpr_nomhw_v1(b))*100)-nanmean(((cpr_mhw_v1(d)-cpr_nomhw_v1(d))./cpr_nomhw_v1(d))*100),1,'o','color','k','MarkerFaceColor',COLOR(1,:))
hold on
plot(nanmean((cpr_longmhw_v1(b)-cpr_nomhw_v1(b))./cpr_nomhw_v1(b))*100-nanmean((cpr_longmhw_v1(d)-cpr_nomhw_v1(d))./cpr_nomhw_v1(d))*100,1,'o','color','k','MarkerFaceColor',COLOR(2,:))
plot(nanmean((cpr_strong2mhw_v1(b)-cpr_nomhw_v1(b))./cpr_nomhw_v1(b))*100-nanmean((cpr_strong2mhw_v1(d)-cpr_nomhw_v1(d))./cpr_nomhw_v1(d))*100,1,'o','color','k','MarkerFaceColor',COLOR(3,:))
plot(nanmean((cpr_strong3mhw_v1(b)-cpr_nomhw_v1(b))./cpr_nomhw_v1(b))*100-nanmean((cpr_strong3mhw_v1(d)-cpr_nomhw_v1(d))./cpr_nomhw_v1(d))*100,1,'o','color','k','MarkerFaceColor',COLOR(4,:))
plot(nanmean((car_mhw_v1(b)-car_nomhw_v1(b))./car_nomhw_v1(b))*100-nanmean((car_mhw_v1(d)-car_nomhw_v1(d))./car_nomhw_v1(d))*100,2,'o','color','k','MarkerFaceColor',COLOR(1,:))
hold on
plot(nanmean((car_longmhw_v1(b)-car_nomhw_v1(b))./car_nomhw_v1(b))*100-nanmean((car_longmhw_v1(d)-car_nomhw_v1(d))./car_nomhw_v1(d))*100,2,'o','color','k','MarkerFaceColor',COLOR(2,:))
plot(nanmean((car_strong2mhw_v1(b)-car_nomhw_v1(b))./car_nomhw_v1(b))*100-nanmean((car_strong2mhw_v1(d)-car_nomhw_v1(d))./car_nomhw_v1(d))*100,2,'o','color','k','MarkerFaceColor',COLOR(3,:))
plot(nanmean((car_strong3mhw_v1(b)-car_nomhw_v1(b))./car_nomhw_v1(b))*100-nanmean((car_strong3mhw_v1(d)-car_nomhw_v1(d))./car_nomhw_v1(d))*100,2,'o','color','k','MarkerFaceColor',COLOR(4,:))
plot(nanmean((csr_mhw_v1(b)-csr_nomhw_v1(b))./csr_nomhw_v1(b))*100-nanmean((csr_mhw_v1(d)-csr_nomhw_v1(d))./csr_nomhw_v1(d))*100,3,'o','color','k','MarkerFaceColor',COLOR(1,:))
hold on
plot(nanmean((csr_longmhw_v1(b)-csr_nomhw_v1(b))./csr_nomhw_v1(b))*100-nanmean((csr_longmhw_v1(d)-csr_nomhw_v1(d))./csr_nomhw_v1(d))*100,3,'o','color','k','MarkerFaceColor',COLOR(2,:))
plot(nanmean((csr_strong2mhw_v1(b)-csr_nomhw_v1(b))./csr_nomhw_v1(b))*100-nanmean((csr_strong2mhw_v1(d)-csr_nomhw_v1(d))./csr_nomhw_v1(d))*100,3,'o','color','k','MarkerFaceColor',COLOR(3,:))
plot(nanmean((csr_strong3mhw_v1(b)-csr_nomhw_v1(b))./csr_nomhw_v1(b))*100-nanmean((csr_strong3mhw_v1(d)-csr_nomhw_v1(d))./csr_nomhw_v1(d))*100,3,'o','color','k','MarkerFaceColor',COLOR(4,:))
plot(0.5,4,'o','color','k','MarkerFaceColor',COLOR(1,:)) % current
plot(-1.7,4,'o','color','k','MarkerFaceColor',COLOR(2,:)) % long
plot(-0.6,4,'o','color','k','MarkerFaceColor',COLOR(3,:)) % moderate
plot(-0.95,4,'o','color','k','MarkerFaceColor',COLOR(4,:)) % strong

grid on
ylim([0.5 4.5])
set(gca,'ytick',[0:1:5])
yticklabels({'','comsumers/producers','corals/algae','coral/sponges','total biomasss'})
%vline(0)
title('Bottom up')
subplot(3,1,2)
plot(nanmean(((cpr_mhw_v2(b)-cpr_nomhw_v2(b))./cpr_nomhw_v2(b))*100)-nanmean(((cpr_mhw_v2(d)-cpr_nomhw_v2(d))./cpr_nomhw_v1(d))*100),1,'o','color','k','MarkerFaceColor',COLOR(1,:))
hold on
plot(nanmean((cpr_longmhw_v2(b)-cpr_nomhw_v2(b))./cpr_nomhw_v2(b))*100-nanmean((cpr_longmhw_v2(d)-cpr_nomhw_v2(d))./cpr_nomhw_v1(d))*100,1,'o','color','k','MarkerFaceColor',COLOR(2,:))
plot(nanmean((cpr_strong2mhw_v2(b)-cpr_nomhw_v2(b))./cpr_nomhw_v2(b))*100-nanmean((cpr_strong2mhw_v2(d)-cpr_nomhw_v2(d))./cpr_nomhw_v1(d))*100,1,'o','color','k','MarkerFaceColor',COLOR(3,:))
plot(nanmean((cpr_strong3mhw_v2(b)-cpr_nomhw_v2(b))./cpr_nomhw_v2(b))*100-nanmean((cpr_strong3mhw_v2(d)-cpr_nomhw_v2(d))./cpr_nomhw_v1(d))*100,1,'o','color','k','MarkerFaceColor',COLOR(4,:))
plot(nanmean((car_mhw_v2(b)-car_nomhw_v2(b))./car_nomhw_v2(b))*100-nanmean((car_mhw_v2(d)-car_nomhw_v2(d))./car_nomhw_v1(d))*100,2,'o','color','k','MarkerFaceColor',COLOR(1,:))
hold on
plot(nanmean((car_longmhw_v2(b)-car_nomhw_v2(b))./car_nomhw_v2(b))*100-nanmean((car_longmhw_v2(d)-car_nomhw_v2(d))./car_nomhw_v1(d))*100,2,'o','color','k','MarkerFaceColor',COLOR(2,:))
plot(nanmean((car_strong2mhw_v2(b)-car_nomhw_v2(b))./car_nomhw_v2(b))*100-nanmean((car_strong2mhw_v2(d)-car_nomhw_v2(d))./car_nomhw_v1(d))*100,2,'o','color','k','MarkerFaceColor',COLOR(3,:))
plot(nanmean((car_strong3mhw_v2(b)-car_nomhw_v2(b))./car_nomhw_v2(b))*100-nanmean((car_strong3mhw_v2(d)-car_nomhw_v2(d))./car_nomhw_v1(d))*100,2,'o','color','k','MarkerFaceColor',COLOR(4,:))
plot(nanmean((csr_mhw_v2(b)-csr_nomhw_v2(b))./csr_nomhw_v2(b))*100-nanmean((csr_mhw_v2(d)-csr_nomhw_v2(d))./csr_nomhw_v2(d))*100,3,'o','color','k','MarkerFaceColor',COLOR(1,:))
hold on
plot(nanmean((csr_longmhw_v2(b)-csr_nomhw_v2(b))./csr_nomhw_v2(b))*100-nanmean((csr_longmhw_v2(d)-csr_nomhw_v2(d))./csr_nomhw_v2(d))*100,3,'o','color','k','MarkerFaceColor',COLOR(2,:))
plot(nanmean((csr_strong2mhw_v2(b)-csr_nomhw_v2(b))./csr_nomhw_v2(b))*100-nanmean((csr_strong2mhw_v2(d)-csr_nomhw_v2(d))./csr_nomhw_v2(d))*100,3,'o','color','k','MarkerFaceColor',COLOR(3,:))
plot(nanmean((csr_strong3mhw_v2(b)-csr_nomhw_v2(b))./csr_nomhw_v2(b))*100-nanmean((csr_strong3mhw_v2(d)-csr_nomhw_v2(d))./csr_nomhw_v2(d))*100,3,'o','color','k','MarkerFaceColor',COLOR(4,:))

plot(-1.73,4,'o','color','k','MarkerFaceColor',COLOR(1,:)) % current
plot(-0.06,4,'o','color','k','MarkerFaceColor',COLOR(2,:)) % long
plot(-1.21,4,'o','color','k','MarkerFaceColor',COLOR(3,:)) % moderate
plot(-1.73,4,'o','color','k','MarkerFaceColor',COLOR(4,:)) % strong 
grid on
ylim([0.5 4.5])
set(gca,'ytick',[0:1:5])
yticklabels({'','comsumers/producers','corals/algae','coral/sponges','total biomasss'})
%vline(0)
title('Mixed trophic control')
subplot(3,1,3)
plot(nanmean(((cpr_mhw_v10(b)-cpr_nomhw_v10(b))./cpr_nomhw_v10(b))*100)-nanmean(((cpr_mhw_v10(d)-cpr_nomhw_v10(d))./cpr_nomhw_v10(d))*100),1,'o','color','k','MarkerFaceColor',COLOR(1,:))
hold on
plot(nanmean((cpr_longmhw_v10(b)-cpr_nomhw_v10(b))./cpr_nomhw_v10(b))*100-nanmean((cpr_longmhw_v10(d)-cpr_nomhw_v10(d))./cpr_nomhw_v10(d))*100,1,'o','color','k','MarkerFaceColor',COLOR(2,:))
plot(nanmean((cpr_strong2mhw_v10(b)-cpr_nomhw_v10(b))./cpr_nomhw_v10(b))*100-nanmean((cpr_strong2mhw_v10(d)-cpr_nomhw_v10(d))./cpr_nomhw_v10(d))*100,1,'o','color','k','MarkerFaceColor',COLOR(3,:))
plot(nanmean((cpr_strong3mhw_v10(b)-cpr_nomhw_v10(b))./cpr_nomhw_v10(b))*100-nanmean((cpr_strong3mhw_v10(d)-cpr_nomhw_v10(d))./cpr_nomhw_v10(d))*100,1,'o','color','k','MarkerFaceColor',COLOR(4,:))
plot(nanmean((car_mhw_v10(b)-car_nomhw_v10(b))./car_nomhw_v10(b))*100-nanmean((car_mhw_v10(d)-car_nomhw_v10(d))./car_nomhw_v10(d))*100,2,'o','color','k','MarkerFaceColor',COLOR(1,:))
hold on
plot(nanmean((car_longmhw_v10(b)-car_nomhw_v10(b))./car_nomhw_v10(b))*100-nanmean((car_longmhw_v10(d)-car_nomhw_v10(d))./car_nomhw_v10(d))*100,2,'o','color','k','MarkerFaceColor',COLOR(2,:))
plot(nanmean((car_strong2mhw_v10(b)-car_nomhw_v10(b))./car_nomhw_v10(b))*100-nanmean((car_strong2mhw_v10(d)-car_nomhw_v10(d))./car_nomhw_v10(d))*100,2,'o','color','k','MarkerFaceColor',COLOR(3,:))
plot(nanmean((car_strong3mhw_v10(b)-car_nomhw_v10(b))./car_nomhw_v10(b))*100-nanmean((car_strong3mhw_v10(d)-car_nomhw_v10(d))./car_nomhw_v10(d))*100,2,'o','color','k','MarkerFaceColor',COLOR(4,:))
a1a=plot(nanmean((csr_mhw_v10(b)-csr_nomhw_v10(b))./csr_nomhw_v10(b))*100-nanmean((csr_mhw_v10(d)-csr_nomhw_v10(d))./csr_nomhw_v10(d))*100,3,'o','color','k','MarkerFaceColor',COLOR(1,:))
hold on
a2a=plot(nanmean((csr_longmhw_v10(b)-csr_nomhw_v10(b))./csr_nomhw_v10(b))*100-nanmean((csr_longmhw_v10(d)-csr_nomhw_v10(d))./csr_nomhw_v10(d))*100,3,'o','color','k','MarkerFaceColor',COLOR(2,:))
a3a=plot(nanmean((csr_strong2mhw_v10(b)-csr_nomhw_v10(b))./csr_nomhw_v10(b))*100-nanmean((csr_strong2mhw_v10(d)-csr_nomhw_v10(d))./csr_nomhw_v10(d))*100,3,'o','color','k','MarkerFaceColor',COLOR(3,:))
a4a=plot(nanmean((csr_strong3mhw_v10(b)-csr_nomhw_v10(b))./csr_nomhw_v10(b))*100-nanmean((csr_strong3mhw_v10(d)-csr_nomhw_v10(d))./csr_nomhw_v10(d))*100,3,'o','color','k','MarkerFaceColor',COLOR(4,:))
plot(-4.35,4,'o','color','k','MarkerFaceColor',COLOR(1,:)) % current
plot(-5.37,4,'o','color','k','MarkerFaceColor',COLOR(2,:)) % long
plot(-7.64,4,'o','color','k','MarkerFaceColor',COLOR(3,:)) % moderate
plot(-10.09,4,'o','color','k','MarkerFaceColor',COLOR(4,:)) % strong 
grid on
ylim([0.5 4.5])
set(gca,'ytick',[0:1:5])
yticklabels({'','comsumers/producers','corals/algae','coral/sponges','total biomasss'})
title('Top-down')
legend([a1a a2a a3a a4a],{'Current MHW','Long MHW','Moderate MHW','Strong MHWs'})

