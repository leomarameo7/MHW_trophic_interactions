close all
clear all

load('ecosimoutputsjuly2023.mat')
ecosimoutputs=ecosimoutputsjuly2023;

%% vulnerability 1
%for each vulnerability:
vulnerability=ecosimoutputs{:,5};
VULNERABILITY=unique(vulnerability);
% for each scenario:
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

%% current

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
%% long:

species=ecosimoutputs{e,8};
biomass=ecosimoutputs{e,10};
biomass_std=ecosimoutputs{e,11};
cathegory=ecosimoutputs{e,9};
SPECIES=unique(species);
% armo las series temporales por especie:
for i=1:length(SPECIES)
A=find(species == SPECIES(i));
biomass_longmhw(:,i)=biomass(A); % serie temporal por especie
biomass_longmhw_std(:,i)=biomass_std(A);
end
%% moderate

species=ecosimoutputs{g,8};
biomass=ecosimoutputs{g,10};
biomass_std=ecosimoutputs{g,11};
cathegory=ecosimoutputs{g,9};
SPECIES=unique(species);
% armo las series temporales por especie:
for i=1:length(SPECIES)
A=find(species == SPECIES(i));
biomass_strong2mhw(:,i)=biomass(A); % serie temporal por especie
biomass_strong2mhw_std(:,i)=biomass_std(A);
end

%% strong

species=ecosimoutputs{h,8};
biomass=ecosimoutputs{h,10};
biomass_std=ecosimoutputs{h,11};
cathegory=ecosimoutputs{h,9};
SPECIES=unique(species);
% armo las series temporales por especie:
for i=1:length(SPECIES)
A=find(species == SPECIES(i));
biomass_strong3mhw(:,i)=biomass(A); % serie temporal por especie
biomass_strong3mhw_std(:,i)=biomass_std(A);
end


%% R computation and error:

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

%% load same computation but for V2 and V10
v2=load('rel_mhw_vulenrability2_v5');
v2_long=load('rel_mhw_long_vulenrability2_v5.mat');
v2_strong2=load('rel_mhw_strong2_vulenrability2_v5.mat');
v2_strong3=load('rel_mhw_strong3_vulenrability2_v5.mat');

v10=load('rel_mhw_vulenrability10_v5');
v10_long=load('rel_mhw_long_vulenrability10_v5');
v10_strong2=load('rel_mhw_strong2_vulenrability10_v5');
v10_strong3=load('rel_mhw_strong3_vulenrability10_v5');


    [a b]=find(ttime>=datenum(2019,01,01) & ttime<datenum(2021,12,31));


dif_mean_mhw=nanmean(rel_mhw(b,:),1);
dif_mean_long=nanmean(rel_long(b,:),1);
dif_mean_strong2=nanmean(rel_strong2(b,:),1);
dif_mean_strong3=nanmean(rel_strong3(b,:),1);

dif_std_mhw=nanmean(rel_mhw_std2(b,:),1);
dif_std_long=nanmean(rel_longmhw_std2(b,:),1);
dif_std_strong2=nanmean(rel_strong2mhw_std2(b,:),1);
dif_std_strong3=nanmean(rel_strong3mhw_std2(b,:),1);

v2.dif_mean_mhw=nanmean(v2.rel_mhw(b,:),1);
v2.dif_mean_long=nanmean(v2_long.rel_long(b,:),1);
v2.dif_mean_strong2=nanmean(v2_strong2.rel_strong2(b,:),1);
v2.dif_mean_strong3=nanmean(v2_strong3.rel_strong3(b,:),1);

v2.dif_std_mhw=nanmean(v2.rel_mhw_std2(b,:),1);
v2.dif_std_long=nanmean(v2_long.rel_longmhw_std2(b,:),1);
v2.dif_std_strong2=nanmean(v2_strong2.rel_strong2mhw_std2(b,:),1);
v2.dif_std_strong3=nanmean(v2_strong3.rel_strong3mhw_std2(b,:),1);

v10.dif_mean_mhw=nanmean(v10.rel_mhw(b,:),1);
v10.dif_mean_long=nanmean(v10_long.rel_long(b,:),1);
v10.dif_mean_strong2=nanmean(v10_strong2.rel_strong2(b,:),1);
v10.dif_mean_strong3=nanmean(v10_strong3.rel_strong3(b,:),1);

v10.dif_std_mhw=nanmean(v10.rel_mhw_std2(b,:),1);
v10.dif_std_long=nanmean(v10_long.rel_longmhw_std2(b,:),1);
v10.dif_std_strong2=nanmean(v10_strong2.rel_strong2mhw_std2(b,:),1);
v10.dif_std_strong3=nanmean(v10_strong3.rel_strong3mhw_std2(b,:),1);




%% organize by trophic level

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

tti=[SPECIES(b);SPECIES(B);SPECIES(f);SPECIES(h);SPECIES(b1);SPECIES(d);SPECIES(b2);SPECIES(b3);SPECIES(b4);SPECIES(b5)];
ytick2=cellstr(tti);




%% plot


figure('pos',[10 10 1500 1500]);
a1a=plot(dif_mean_mhw(d),1:2,'o','color','k','MarkerFaceColor',[0 0.68 0.73]);
hold on
errorbar(dif_mean_mhw(d),1:2,'horizontal',"LineStyle","none",'color',[0 0.68 0.73],'linewidth',1)
plot(dif_mean_mhw(B),3:4,'o','color','k','MarkerFaceColor',[0 0.68 0.73]);
errorbar(dif_mean_mhw(B),3:4,dif_std_mhw(B),'horizontal',"LineStyle","none",'color',[0 0.68 0.73],'linewidth',1)
plot(dif_mean_mhw(h),5,'o','color','k','MarkerFaceColor',[0 0.68 0.73]);
errorbar(dif_mean_mhw(h),5,dif_std_mhw(h),'horizontal',"LineStyle","none",'color',[0 0.68 0.73],'linewidth',1)
plot(dif_mean_mhw(f),6,'o','color','k','MarkerFaceColor',[0 0.68 0.73]);
errorbar(dif_mean_mhw(f),6,dif_std_mhw(f),'horizontal',"LineStyle","none",'color',[0 0.68 0.73],'linewidth',1)
plot(dif_mean_mhw(b),7:10,'o','color','k','MarkerFaceColor',[0 0.68 0.73]);
errorbar(dif_mean_mhw(b),7:10,dif_std_mhw(b),'horizontal',"LineStyle","none",'color',[0 0.68 0.73],'linewidth',1)
plot(dif_mean_mhw(b1),11:16,'o','color','k','MarkerFaceColor',[0 0.68 0.73]);
errorbar(dif_mean_mhw(b1),11:16,dif_std_mhw(b1),'horizontal',"LineStyle","none",'color',[0 0.68 0.73],'linewidth',1)
plot(dif_mean_mhw(b2),17:22,'o','color','k','MarkerFaceColor',[0 0.68 0.73]);
errorbar(dif_mean_mhw(b2),17:22,dif_std_mhw(b2),'horizontal',"LineStyle","none",'color',[0 0.68 0.73],'linewidth',1)
plot(dif_mean_mhw(b3),23:28,'o','color','k','MarkerFaceColor',[0 0.68 0.73]);
errorbar(dif_mean_mhw(b3),23:28,dif_std_mhw(b3),'horizontal',"LineStyle","none",'color',[0 0.68 0.73],'linewidth',1)
plot(dif_mean_mhw(b4),29:33,'o','color','k','MarkerFaceColor',[0 0.68 0.73]);
errorbar(dif_mean_mhw(b4),29:33,dif_std_mhw(b4),'horizontal',"LineStyle","none",'color',[0 0.68 0.73],'linewidth',1)
plot(dif_mean_mhw(b5),34:36,'o','color','k','MarkerFaceColor',[0 0.68 0.73]);
errorbar(dif_mean_mhw(b5),34:36,dif_std_mhw(b5),'horizontal',"LineStyle","none",'color',[0 0.68 0.73],'linewidth',1)

a2a=plot(v2.dif_mean_mhw(d),1:2,'o','color','k','MarkerFaceColor',[0.9 0.72 0]);
hold on
errorbar(v2.dif_mean_mhw(d),1:2,v2.dif_std_mhw(d),'horizontal',"LineStyle","none",'color',[0.9 0.72 0],'linewidth',1)
plot(v2.dif_mean_mhw(B),3:4,'o','color','k','MarkerFaceColor',[0.9 0.72 0]);
errorbar(v2.dif_mean_mhw(B),3:4,v2.dif_std_mhw(B),'horizontal',"LineStyle","none",'color',[0.9 0.72 0],'linewidth',1)
plot(v2.dif_mean_mhw(h),5,'o','color','k','MarkerFaceColor',[0.9 0.72 0]);
errorbar(v2.dif_mean_mhw(h),5,v2.dif_std_mhw(h),'horizontal',"LineStyle","none",'color',[0.9 0.72 0],'linewidth',1)
plot(v2.dif_mean_mhw(f),6,'o','color','k','MarkerFaceColor',[0.9 0.72 0]);
errorbar(v2.dif_mean_mhw(f),6,v2.dif_std_mhw(f),'horizontal',"LineStyle","none",'color',[0.9 0.72 0],'linewidth',1)
plot(v2.dif_mean_mhw(b),7:10,'o','color','k','MarkerFaceColor',[0.9 0.72 0]);
errorbar(v2.dif_mean_mhw(b),7:10,v2.dif_std_mhw(b),'horizontal',"LineStyle","none",'color',[0.9 0.72 0],'linewidth',1)
plot(v2.dif_mean_mhw(b1),11:16,'o','color','k','MarkerFaceColor',[0.9 0.72 0]);
errorbar(v2.dif_mean_mhw(b1),11:16,v2.dif_std_mhw(b1),'horizontal',"LineStyle","none",'color',[0.9 0.72 0],'linewidth',1)
plot(v2.dif_mean_mhw(b2),17:22,'o','color','k','MarkerFaceColor',[0.9 0.72 0]);
errorbar(v2.dif_mean_mhw(b2),17:22,v2.dif_std_mhw(b2),'horizontal',"LineStyle","none",'color',[0.9 0.72 0],'linewidth',1)
plot(v2.dif_mean_mhw(b3),23:28,'o','color','k','MarkerFaceColor',[0.9 0.72 0]);
errorbar(v2.dif_mean_mhw(b3),23:28,v2.dif_std_mhw(b3),'horizontal',"LineStyle","none",'color',[0.9 0.72 0],'linewidth',1)
plot(v2.dif_mean_mhw(b4),29:33,'o','color','k','MarkerFaceColor',[0.9 0.72 0]);
errorbar(v2.dif_mean_mhw(b4),29:33,v2.dif_std_mhw(b4),'horizontal',"LineStyle","none",'color',[0.9 0.72 0],'linewidth',1)
plot(v2.dif_mean_mhw(b5),34:36,'o','color','k','MarkerFaceColor',[0.9 0.72 0]);
errorbar(v2.dif_mean_mhw(b5),34:36,v2.dif_std_mhw(b5),'horizontal',"LineStyle","none",'color',[0.9 0.72 0],'linewidth',1)

a3a=plot(v10.dif_mean_mhw(d),1:2,'o','color','k','MarkerFaceColor',[0.98 0.30 0.02]);
hold on
errorbar(v10.dif_mean_mhw(d),1:2,v10.dif_std_mhw(d),'horizontal',"LineStyle","none",'color',[0.98 0.30 0.02],'linewidth',1)
plot(v10.dif_mean_mhw(B),3:4,'o','color','k','MarkerFaceColor',[0.98 0.30 0.02]);
errorbar(v10.dif_mean_mhw(B),3:4,v10.dif_std_mhw(B),'horizontal',"LineStyle","none",'color',[0.98 0.30 0.02],'linewidth',1)
plot(v10.dif_mean_mhw(h),5,'o','color','k','MarkerFaceColor',[0.98 0.30 0.02]);
errorbar(v10.dif_mean_mhw(h),5,v10.dif_std_mhw(h),'horizontal',"LineStyle","none",'color',[0.98 0.30 0.02],'linewidth',1)
plot(v10.dif_mean_mhw(f),6,'o','color','k','MarkerFaceColor',[0.98 0.30 0.02]);
errorbar(v10.dif_mean_mhw(f),6,v10.dif_std_mhw(f),'horizontal',"LineStyle","none",'color',[0.98 0.30 0.02],'linewidth',1)
plot(v10.dif_mean_mhw(b),7:10,'o','color','k','MarkerFaceColor',[0.98 0.30 0.02]);
errorbar(v10.dif_mean_mhw(b),7:10,v10.dif_std_mhw(b),'horizontal',"LineStyle","none",'color',[0.98 0.30 0.02],'linewidth',1)
plot(v10.dif_mean_mhw(b1),11:16,'o','color','k','MarkerFaceColor',[0.98 0.30 0.02]);
errorbar(v10.dif_mean_mhw(b1),11:16,v10.dif_std_mhw(b1),'horizontal',"LineStyle","none",'color',[0.98 0.30 0.02],'linewidth',1)
plot(v10.dif_mean_mhw(b2),17:22,'o','color','k','MarkerFaceColor',[0.98 0.30 0.02]);
errorbar(v10.dif_mean_mhw(b2),17:22,v10.dif_std_mhw(b2),'horizontal',"LineStyle","none",'color',[0.98 0.30 0.02],'linewidth',1)
plot(v10.dif_mean_mhw(b3),23:28,'o','color','k','MarkerFaceColor',[0.98 0.30 0.02]);
errorbar(v10.dif_mean_mhw(b3),23:28,v10.dif_std_mhw(b3),'horizontal',"LineStyle","none",'color',[0.98 0.30 0.02],'linewidth',1)
plot(v10.dif_mean_mhw(b4),29:33,'o','color','k','MarkerFaceColor',[0.98 0.30 0.02]);
errorbar(v10.dif_mean_mhw(b4),29:33,v10.dif_std_mhw(b4),'horizontal',"LineStyle","none",'color',[0.98 0.30 0.02],'linewidth',1)
plot(v10.dif_mean_mhw(b5),34:36,'o','color','k','MarkerFaceColor',[0.98 0.30 0.02]);
errorbar(v10.dif_mean_mhw(b5),34:36,v10.dif_std_mhw(b5),'horizontal',"LineStyle","none",'color',[0.98 0.30 0.02],'linewidth',1)

title('MHWs 2019-2021')
set(gca,'ytick',[1:36],'yticklabel',[ytick2])
ylim([0 37])
grid on
legend([a1a a2a a3a],{'Bottom up','mixed trophic control','Strong top down'})
xlim([-15 15])
xlabel('biomass change (%)')





