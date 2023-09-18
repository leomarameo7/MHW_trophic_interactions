close all
clear all

load('ecosimoutputsjuly2023.mat')
ecosimoutputs=ecosimoutputsjuly2023;

%% VULNERABILITY 1

vulnerability=ecosimoutputs{:,5};
VULNERABILITY=unique(vulnerability);

scenario=ecosimoutputs{:,6};
SCENARIO=unique(scenario);
a =find(scenario==SCENARIO(6) & vulnerability==VULNERABILITY(1)); % no MHWs
c =find(scenario==SCENARIO(1) & vulnerability==VULNERABILITY(1)); % MHW
e =find(scenario==SCENARIO(2) & vulnerability==VULNERABILITY(1)); % longMHW
g =find(scenario==SCENARIO(3) & vulnerability==VULNERABILITY(1)); % strong2
h =find(scenario==SCENARIO(5) & vulnerability==VULNERABILITY(1)); % strong3

species=ecosimoutputs{a,8};
biomass=ecosimoutputs{a,10};
biomass_std=ecosimoutputs{a,11};
cathegory=ecosimoutputs{a,9};
SPECIES=unique(species);

%% control

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
%% long

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
%% moderate

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

%% strong

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


%% R and error

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


rel_mhw_std2=((abs(A./B).*(sqrt((SA./A).^2+(SB./B).^2))))*100;


A=biomass_longmhw;
EA=biomass_longmhw_std/sqrt(500);
SA=biomass_longmhw_std;


rel_longmhw_std2=((abs(A./B).*(sqrt((SA./A).^2+(SB./B).^2))))*100;


A=biomass_strong2mhw;
EA=biomass_strong2mhw_std/sqrt(500);
SA=biomass_strong2mhw_std;


rel_strong2mhw_std2=((abs(A./B).*(sqrt((SA./A).^2+(SB./B).^2))))*100;


A=biomass_strong2mhw;
EA=biomass_strong2mhw_std/sqrt(500);
SA=biomass_strong2mhw_std;


rel_strong3mhw_std2=((abs(A./B).*(sqrt((SA./A).^2+(SB./B).^2))))*100;


limx=[datenum(2012,01,01)  datenum(2042,12,31)];
dvec=datenum(2012:1:2042,01,01);
ttime=datenum(2012,01:372,01);
COLOR=jet(36)

%% short term changes

 [a b]=find(ttime>=datenum(2023,01,01) & ttime<datenum(2025,12,31));


dif_mean_mhw=nanmean(rel_mhw(b,:),1);
dif_mean_long=nanmean(rel_long(b,:),1);
dif_mean_strong2=nanmean(rel_strong2(b,:),1);
dif_mean_strong3=nanmean(rel_strong3(b,:),1);

dif_std_mhw=nanmean(rel_mhw_std2(b,:),1);
dif_std_long=nanmean(rel_longmhw_std2(b,:),1);
dif_std_strong2=nanmean(rel_strong2mhw_std2(b,:),1);
dif_std_strong3=nanmean(rel_strong3mhw_std2(b,:),1);



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

tti=[SPECIES(d);SPECIES(B);SPECIES(h);SPECIES(f);SPECIES(b);SPECIES(b1);SPECIES(b2);SPECIES(b3);SPECIES(b4);SPECIES(b5)];
ytick2=cellstr(tti);

COLOR=lines(4);


 
figure('pos',[10 10 1500 1500]);
%initfigpaysage;
subplot(1,2,1)
a1a=plot(dif_mean_mhw(d),1:2,'o','color','k','MarkerFaceColor',COLOR(1,:));
hold on
errorbar(dif_mean_mhw(d),1:2,dif_std_mhw(d),'horizontal',"LineStyle","none",'color',COLOR(1,:),'linewidth',1)
plot(dif_mean_mhw(B),3:4,'o','color','k','MarkerFaceColor',COLOR(1,:));
errorbar(dif_mean_mhw(B),3:4,dif_std_mhw(B),'horizontal',"LineStyle","none",'color',COLOR(1,:),'linewidth',1)
plot(dif_mean_mhw(h),5,'o','color','k','MarkerFaceColor',COLOR(1,:));
errorbar(dif_mean_mhw(h),5,dif_std_mhw(h),'horizontal',"LineStyle","none",'color',COLOR(1,:),'linewidth',1)
plot(dif_mean_mhw(f),6,'o','color','k','MarkerFaceColor',COLOR(1,:));
errorbar(dif_mean_mhw(f),6,dif_std_mhw(f),'horizontal',"LineStyle","none",'color',COLOR(1,:),'linewidth',1)
plot(dif_mean_mhw(b),7:10,'o','color','k','MarkerFaceColor',COLOR(1,:));
errorbar(dif_mean_mhw(b),7:10,dif_std_mhw(b),'horizontal',"LineStyle","none",'color',COLOR(1,:),'linewidth',1)
plot(dif_mean_mhw(b1),11:16,'o','color','k','MarkerFaceColor',COLOR(1,:));
errorbar(dif_mean_mhw(b1),11:16,dif_std_mhw(b1),'horizontal',"LineStyle","none",'color',COLOR(1,:),'linewidth',1)
plot(dif_mean_mhw(b2),17:22,'o','color','k','MarkerFaceColor',COLOR(1,:));
errorbar(dif_mean_mhw(b2),17:22,dif_std_mhw(b2),'horizontal',"LineStyle","none",'color',COLOR(1,:),'linewidth',1)
plot(dif_mean_mhw(b3),23:28,'o','color','k','MarkerFaceColor',COLOR(1,:));
errorbar(dif_mean_mhw(b3),23:28,dif_std_mhw(b3),'horizontal',"LineStyle","none",'color',COLOR(1,:),'linewidth',1)
plot(dif_mean_mhw(b4),29:33,'o','color','k','MarkerFaceColor',COLOR(1,:));
errorbar(dif_mean_mhw(b4),29:33,dif_std_mhw(b4),'horizontal',"LineStyle","none",'color',COLOR(1,:),'linewidth',1)
plot(dif_mean_mhw(b5),34:36,'o','color','k','MarkerFaceColor',COLOR(1,:));
errorbar(dif_mean_mhw(b5),34:36,dif_std_mhw(b5),'horizontal',"LineStyle","none",'color',COLOR(1,:),'linewidth',1)



a2a=plot(dif_mean_long(d),1:2,'o','color','k','MarkerFaceColor',COLOR(2,:));
hold on
errorbar(dif_mean_long(d),1:2,dif_std_long(d),'horizontal',"LineStyle","none",'color',COLOR(2,:),'linewidth',1)
plot(dif_mean_long(B),3:4,'o','color','k','MarkerFaceColor',COLOR(2,:));
errorbar(dif_mean_long(B),3:4,dif_std_long(B),'horizontal',"LineStyle","none",'color',COLOR(2,:),'linewidth',1)
plot(dif_mean_long(h),5,'o','color','k','MarkerFaceColor',COLOR(2,:));
errorbar(dif_mean_long(h),5,dif_std_long(h),'horizontal',"LineStyle","none",'color',COLOR(2,:),'linewidth',1)
plot(dif_mean_long(f),6,'o','color','k','MarkerFaceColor',COLOR(2,:));
errorbar(dif_mean_long(f),6,dif_std_long(f),'horizontal',"LineStyle","none",'color',COLOR(2,:),'linewidth',1)
plot(dif_mean_long(b),7:10,'o','color','k','MarkerFaceColor',COLOR(2,:));
errorbar(dif_mean_long(b),7:10,dif_std_long(b),'horizontal',"LineStyle","none",'color',COLOR(2,:),'linewidth',1)
plot(dif_mean_long(b1),11:16,'o','color','k','MarkerFaceColor',COLOR(2,:));
errorbar(dif_mean_long(b1),11:16,dif_std_long(b1),'horizontal',"LineStyle","none",'color',COLOR(2,:),'linewidth',1)
plot(dif_mean_long(b2),17:22,'o','color','k','MarkerFaceColor',COLOR(2,:));
errorbar(dif_mean_long(b2),17:22,dif_std_long(b2),'horizontal',"LineStyle","none",'color',COLOR(2,:),'linewidth',1)
plot(dif_mean_long(b3),23:28,'o','color','k','MarkerFaceColor',COLOR(2,:));
errorbar(dif_mean_long(b3),23:28,dif_std_long(b3),'horizontal',"LineStyle","none",'color',COLOR(2,:),'linewidth',1)
plot(dif_mean_long(b4),29:33,'o','color','k','MarkerFaceColor',COLOR(2,:));
errorbar(dif_mean_long(b4),29:33,dif_std_long(b4),'horizontal',"LineStyle","none",'color',COLOR(2,:),'linewidth',1)
plot(dif_mean_long(b5),34:36,'o','color','k','MarkerFaceColor',COLOR(1,:));
errorbar(dif_mean_long(b5),34:36,dif_std_long(b5),'horizontal',"LineStyle","none",'color',COLOR(2,:),'linewidth',1)


a3a=plot(dif_mean_strong2(d),1:2,'o','color','k','MarkerFaceColor',COLOR(3,:));
hold on
errorbar(dif_mean_strong2(d),1:2,dif_std_strong2(d),'horizontal',"LineStyle","none",'color',COLOR(3,:),'linewidth',1)
plot(dif_mean_strong2(B),3:4,'o','color','k','MarkerFaceColor',COLOR(3,:));
errorbar(dif_mean_strong2(B),3:4,dif_std_strong2(B),'horizontal',"LineStyle","none",'color',COLOR(3,:),'linewidth',1)
plot(dif_mean_strong2(h),5,'o','color','k','MarkerFaceColor',COLOR(3,:));
errorbar(dif_mean_strong2(h),5,dif_std_strong2(h),'horizontal',"LineStyle","none",'color',COLOR(3,:),'linewidth',1)
plot(dif_mean_strong2(f),6,'o','color','k','MarkerFaceColor',COLOR(3,:));
errorbar(dif_mean_strong2(f),6,dif_std_strong2(f),'horizontal',"LineStyle","none",'color',COLOR(3,:),'linewidth',1)
plot(dif_mean_strong2(b),7:10,'o','color','k','MarkerFaceColor',COLOR(3,:));
errorbar(dif_mean_strong2(b),7:10,dif_std_strong2(b),'horizontal',"LineStyle","none",'color',COLOR(3,:),'linewidth',1)
plot(dif_mean_strong2(b1),11:16,'o','color','k','MarkerFaceColor',COLOR(3,:));
errorbar(dif_mean_strong2(b1),11:16,dif_std_strong2(b1),'horizontal',"LineStyle","none",'color',COLOR(3,:),'linewidth',1)
plot(dif_mean_strong2(b2),17:22,'o','color','k','MarkerFaceColor',COLOR(3,:));
errorbar(dif_mean_strong2(b2),17:22,dif_std_strong2(b2),'horizontal',"LineStyle","none",'color',COLOR(3,:),'linewidth',1)
plot(dif_mean_strong2(b3),23:28,'o','color','k','MarkerFaceColor',COLOR(3,:));
errorbar(dif_mean_strong2(b3),23:28,dif_std_strong2(b3),'horizontal',"LineStyle","none",'color',COLOR(3,:),'linewidth',1)
plot(dif_mean_strong2(b4),29:33,'o','color','k','MarkerFaceColor',COLOR(3,:));
errorbar(dif_mean_strong2(b4),29:33,dif_std_strong2(b4),'horizontal',"LineStyle","none",'color',COLOR(3,:),'linewidth',1)
plot(dif_mean_strong2(b5),34:36,'o','color','k','MarkerFaceColor',COLOR(3,:));
errorbar(dif_mean_strong2(b5),34:36,dif_std_strong2(b5),'horizontal',"LineStyle","none",'color',COLOR(3,:),'linewidth',1)


a4a=plot(dif_mean_strong3(d),1:2,'o','color','k','MarkerFaceColor',COLOR(4,:));
hold on
errorbar(dif_mean_strong3(d),1:2,dif_std_strong3(d),'horizontal',"LineStyle","none",'color',COLOR(4,:),'linewidth',1)
plot(dif_mean_strong3(B),3:4,'o','color','k','MarkerFaceColor',COLOR(4,:));
errorbar(dif_mean_strong3(B),3:4,dif_std_strong3(B),'horizontal',"LineStyle","none",'color',COLOR(4,:),'linewidth',1)
plot(dif_mean_strong3(h),5,'o','color','k','MarkerFaceColor',COLOR(4,:));
errorbar(dif_mean_strong3(h),5,dif_std_strong3(h),'horizontal',"LineStyle","none",'color',COLOR(4,:),'linewidth',1)
plot(dif_mean_strong3(f),6,'o','color','k','MarkerFaceColor',COLOR(4,:));
errorbar(dif_mean_strong3(f),6,dif_std_strong3(f),'horizontal',"LineStyle","none",'color',COLOR(4,:),'linewidth',1)
plot(dif_mean_strong3(b),7:10,'o','color','k','MarkerFaceColor',COLOR(4,:));
errorbar(dif_mean_strong3(b),7:10,dif_std_strong3(b),'horizontal',"LineStyle","none",'color',COLOR(4,:),'linewidth',1)
plot(dif_mean_strong3(b1),11:16,'o','color','k','MarkerFaceColor',COLOR(4,:));
errorbar(dif_mean_strong3(b1),11:16,dif_std_strong3(b1),'horizontal',"LineStyle","none",'color',COLOR(4,:),'linewidth',1)
plot(dif_mean_strong3(b2),17:22,'o','color','k','MarkerFaceColor',COLOR(4,:));
errorbar(dif_mean_strong3(b2),17:22,dif_std_strong3(b2),'horizontal',"LineStyle","none",'color',COLOR(4,:),'linewidth',1)
plot(dif_mean_strong3(b3),23:28,'o','color','k','MarkerFaceColor',COLOR(4,:));
errorbar(dif_mean_strong3(b3),23:28,dif_std_strong3(b3),'horizontal',"LineStyle","none",'color',COLOR(4,:),'linewidth',1)
plot(dif_mean_strong3(b4),29:33,'o','color','k','MarkerFaceColor',COLOR(4,:));
errorbar(dif_mean_strong3(b4),29:33,dif_std_strong3(b4),'horizontal',"LineStyle","none",'color',COLOR(4,:),'linewidth',1)
plot(dif_mean_strong3(b5),34:36,'o','color','k','MarkerFaceColor',COLOR(4,:));
errorbar(dif_mean_strong3(b5),34:36,dif_std_strong3(b5),'horizontal',"LineStyle","none",'color',COLOR(4,:),'linewidth',1)

title('MHWs 2023-2025 Bottom up')
set(gca,'ytick',[1:36],'yticklabel',[ytick2])
ylim([1 37])
xlim([-25 10])
grid on
legend([a1a a2a a3a a4a],{'Current MHW','Long MHW','Moderate MHW','Strong MHWs'})
xlabel('biomass change (%)')


%% long term changes


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

tti=[SPECIES(d);SPECIES(B);SPECIES(h);SPECIES(f);SPECIES(b);SPECIES(b1);SPECIES(b2);SPECIES(b3);SPECIES(b4);SPECIES(b5)];
ytick2=cellstr(tti);

[a b]=find(ttime>=datenum(2022,01,01) & ttime<datenum(2022,12,31));
    [AA BB]=find(ttime>=datenum(2042,01,01) & ttime<datenum(2042,12,31));


dif_mean_mhw=nanmean(rel_mhw(BB,:),1)-nanmean(rel_mhw(b,:),1);
dif_mean_long=nanmean(rel_long(BB,:),1)-nanmean(rel_long(b,:),1);
dif_mean_strong2=nanmean(rel_strong2(BB,:),1)-nanmean(rel_strong2(b,:),1);
dif_mean_strong3=nanmean(rel_strong3(BB,:),1)-nanmean(rel_strong3(b,:),1);

std_mean_mhw=nanstd(rel_mhw(BB,:)-rel_mhw(b,:),0,1);
std_mean_long=nanstd(rel_long(BB,:)-rel_long(b,:),0,1);
std_mean_strong2=nanstd(rel_strong2(BB,:)-rel_strong2(b,:),0,1);
std_mean_strong3=nanstd(rel_strong3(BB,:)-rel_strong3(b,:),0,1);

tti_mhw=tti(abs(dif_mean_mhw)>std_mean_mhw);
tti_long=tti(abs(dif_mean_long)>std_mean_long);
tti_strong2=tti(abs(dif_mean_strong2)>std_mean_strong2);
tti_strong3=tti(abs(dif_mean_strong3)>std_mean_strong3);

% busco los primary producers:
% busco los primary producers:
[a b]=find(CATHEGORY=="Primary producers");
[A B]=find(CATHEGORY=="Microbial community");
%[c d]=find(CATHEGORY=="DOM/POM");
[e f]=find(CATHEGORY=="Corals");
[g h]=find(CATHEGORY=="Sponges");
[a1, b1]=find(CATHEGORY=="Herbivores");
[c d]=find(CATHEGORY=="Detritus");
[a2 b2]=find(CATHEGORY=="Omnivores");
[a3 b3]=find(CATHEGORY=="Low-level predators");
[a4 b4]=find(CATHEGORY=="Mid-level predators");
[a5 b5]=find(CATHEGORY=="Top-level predators");

tti=[SPECIES(d);SPECIES(B);SPECIES(h);SPECIES(f);SPECIES(b);SPECIES(b1);SPECIES(b2);SPECIES(b3);SPECIES(b4);SPECIES(b5)];
ytick2=cellstr(tti);

COLOR=lines(4);

subplot(1,2,2)
a1a=plot(dif_mean_mhw(d),1:2,'o','color','k','MarkerFaceColor',COLOR(1,:));
hold on
errorbar(dif_mean_mhw(d),1:2,dif_std_mhw(d),'horizontal',"LineStyle","none",'color',COLOR(1,:),'linewidth',1)
plot(dif_mean_mhw(B),3:4,'o','color','k','MarkerFaceColor',COLOR(1,:));
errorbar(dif_mean_mhw(B),3:4,dif_std_mhw(B),'horizontal',"LineStyle","none",'color',COLOR(1,:),'linewidth',1)
plot(dif_mean_mhw(h),5,'o','color','k','MarkerFaceColor',COLOR(1,:));
errorbar(dif_mean_mhw(h),5,dif_std_mhw(h),'horizontal',"LineStyle","none",'color',COLOR(1,:),'linewidth',1)
plot(dif_mean_mhw(f),6,'o','color','k','MarkerFaceColor',COLOR(1,:));
errorbar(dif_mean_mhw(f),6,dif_std_mhw(f),'horizontal',"LineStyle","none",'color',COLOR(1,:),'linewidth',1)
plot(dif_mean_mhw(b),7:10,'o','color','k','MarkerFaceColor',COLOR(1,:));
errorbar(dif_mean_mhw(b),7:10,dif_std_mhw(b),'horizontal',"LineStyle","none",'color',COLOR(1,:),'linewidth',1)
plot(dif_mean_mhw(b1),11:16,'o','color','k','MarkerFaceColor',COLOR(1,:));
errorbar(dif_mean_mhw(b1),11:16,dif_std_mhw(b1),'horizontal',"LineStyle","none",'color',COLOR(1,:),'linewidth',1)
plot(dif_mean_mhw(b2),17:22,'o','color','k','MarkerFaceColor',COLOR(1,:));
errorbar(dif_mean_mhw(b2),17:22,dif_std_mhw(b2),'horizontal',"LineStyle","none",'color',COLOR(1,:),'linewidth',1)
plot(dif_mean_mhw(b3),23:28,'o','color','k','MarkerFaceColor',COLOR(1,:));
errorbar(dif_mean_mhw(b3),23:28,dif_std_mhw(b3),'horizontal',"LineStyle","none",'color',COLOR(1,:),'linewidth',1)
plot(dif_mean_mhw(b4),29:33,'o','color','k','MarkerFaceColor',COLOR(1,:));
errorbar(dif_mean_mhw(b4),29:33,dif_std_mhw(b4),'horizontal',"LineStyle","none",'color',COLOR(1,:),'linewidth',1)
plot(dif_mean_mhw(b5),34:36,'o','color','k','MarkerFaceColor',COLOR(1,:));
errorbar(dif_mean_mhw(b5),34:36,dif_std_mhw(b5),'horizontal',"LineStyle","none",'color',COLOR(1,:),'linewidth',1)



a2a=plot(dif_mean_long(d),1:2,'o','color','k','MarkerFaceColor',COLOR(2,:));
hold on
errorbar(dif_mean_long(d),1:2,dif_std_long(d),'horizontal',"LineStyle","none",'color',COLOR(2,:),'linewidth',1)
plot(dif_mean_long(B),3:4,'o','color','k','MarkerFaceColor',COLOR(2,:));
errorbar(dif_mean_long(B),3:4,dif_std_long(B),'horizontal',"LineStyle","none",'color',COLOR(2,:),'linewidth',1)
plot(dif_mean_long(h),5,'o','color','k','MarkerFaceColor',COLOR(2,:));
errorbar(dif_mean_long(h),5,dif_std_long(h),'horizontal',"LineStyle","none",'color',COLOR(2,:),'linewidth',1)
plot(dif_mean_long(f),6,'o','color','k','MarkerFaceColor',COLOR(2,:));
errorbar(dif_mean_long(f),6,dif_std_long(f),'horizontal',"LineStyle","none",'color',COLOR(2,:),'linewidth',1)
plot(dif_mean_long(b),7:10,'o','color','k','MarkerFaceColor',COLOR(2,:));
errorbar(dif_mean_long(b),7:10,dif_std_long(b),'horizontal',"LineStyle","none",'color',COLOR(2,:),'linewidth',1)
plot(dif_mean_long(b1),11:16,'o','color','k','MarkerFaceColor',COLOR(2,:));
errorbar(dif_mean_long(b1),11:16,dif_std_long(b1),'horizontal',"LineStyle","none",'color',COLOR(2,:),'linewidth',1)
plot(dif_mean_long(b2),17:22,'o','color','k','MarkerFaceColor',COLOR(2,:));
errorbar(dif_mean_long(b2),17:22,dif_std_long(b2),'horizontal',"LineStyle","none",'color',COLOR(2,:),'linewidth',1)
plot(dif_mean_long(b3),23:28,'o','color','k','MarkerFaceColor',COLOR(2,:));
errorbar(dif_mean_long(b3),23:28,dif_std_long(b3),'horizontal',"LineStyle","none",'color',COLOR(2,:),'linewidth',1)
plot(dif_mean_long(b4),29:33,'o','color','k','MarkerFaceColor',COLOR(2,:));
errorbar(dif_mean_long(b4),29:33,dif_std_long(b4),'horizontal',"LineStyle","none",'color',COLOR(2,:),'linewidth',1)
plot(dif_mean_long(b5),34:36,'o','color','k','MarkerFaceColor',COLOR(1,:));
errorbar(dif_mean_long(b5),34:36,dif_std_long(b5),'horizontal',"LineStyle","none",'color',COLOR(2,:),'linewidth',1)


a3a=plot(dif_mean_strong2(d),1:2,'o','color','k','MarkerFaceColor',COLOR(3,:));
hold on
errorbar(dif_mean_strong2(d),1:2,dif_std_strong2(d),'horizontal',"LineStyle","none",'color',COLOR(3,:),'linewidth',1)
plot(dif_mean_strong2(B),3:4,'o','color','k','MarkerFaceColor',COLOR(3,:));
errorbar(dif_mean_strong2(B),3:4,dif_std_strong2(B),'horizontal',"LineStyle","none",'color',COLOR(3,:),'linewidth',1)
plot(dif_mean_strong2(h),5,'o','color','k','MarkerFaceColor',COLOR(3,:));
errorbar(dif_mean_strong2(h),5,dif_std_strong2(h),'horizontal',"LineStyle","none",'color',COLOR(3,:),'linewidth',1)
plot(dif_mean_strong2(f),6,'o','color','k','MarkerFaceColor',COLOR(3,:));
errorbar(dif_mean_strong2(f),6,dif_std_strong2(f),'horizontal',"LineStyle","none",'color',COLOR(3,:),'linewidth',1)
plot(dif_mean_strong2(b),7:10,'o','color','k','MarkerFaceColor',COLOR(3,:));
errorbar(dif_mean_strong2(b),7:10,dif_std_strong2(b),'horizontal',"LineStyle","none",'color',COLOR(3,:),'linewidth',1)
plot(dif_mean_strong2(b1),11:16,'o','color','k','MarkerFaceColor',COLOR(3,:));
errorbar(dif_mean_strong2(b1),11:16,dif_std_strong2(b1),'horizontal',"LineStyle","none",'color',COLOR(3,:),'linewidth',1)
plot(dif_mean_strong2(b2),17:22,'o','color','k','MarkerFaceColor',COLOR(3,:));
errorbar(dif_mean_strong2(b2),17:22,dif_std_strong2(b2),'horizontal',"LineStyle","none",'color',COLOR(3,:),'linewidth',1)
plot(dif_mean_strong2(b3),23:28,'o','color','k','MarkerFaceColor',COLOR(3,:));
errorbar(dif_mean_strong2(b3),23:28,dif_std_strong2(b3),'horizontal',"LineStyle","none",'color',COLOR(3,:),'linewidth',1)
plot(dif_mean_strong2(b4),29:33,'o','color','k','MarkerFaceColor',COLOR(3,:));
errorbar(dif_mean_strong2(b4),29:33,dif_std_strong2(b4),'horizontal',"LineStyle","none",'color',COLOR(3,:),'linewidth',1)
plot(dif_mean_strong2(b5),34:36,'o','color','k','MarkerFaceColor',COLOR(3,:));
errorbar(dif_mean_strong2(b5),34:36,dif_std_strong2(b5),'horizontal',"LineStyle","none",'color',COLOR(3,:),'linewidth',1)


a4a=plot(dif_mean_strong3(d),1:2,'o','color','k','MarkerFaceColor',COLOR(4,:));
hold on
errorbar(dif_mean_strong3(d),1:2,dif_std_strong3(d),'horizontal',"LineStyle","none",'color',COLOR(4,:),'linewidth',1)
plot(dif_mean_strong3(B),3:4,'o','color','k','MarkerFaceColor',COLOR(4,:));
errorbar(dif_mean_strong3(B),3:4,dif_std_strong3(B),'horizontal',"LineStyle","none",'color',COLOR(4,:),'linewidth',1)
plot(dif_mean_strong3(h),5,'o','color','k','MarkerFaceColor',COLOR(4,:));
errorbar(dif_mean_strong3(h),5,dif_std_strong3(h),'horizontal',"LineStyle","none",'color',COLOR(4,:),'linewidth',1)
plot(dif_mean_strong3(f),6,'o','color','k','MarkerFaceColor',COLOR(4,:));
errorbar(dif_mean_strong3(f),6,dif_std_strong3(f),'horizontal',"LineStyle","none",'color',COLOR(4,:),'linewidth',1)
plot(dif_mean_strong3(b),7:10,'o','color','k','MarkerFaceColor',COLOR(4,:));
errorbar(dif_mean_strong3(b),7:10,dif_std_strong3(b),'horizontal',"LineStyle","none",'color',COLOR(4,:),'linewidth',1)
plot(dif_mean_strong3(b1),11:16,'o','color','k','MarkerFaceColor',COLOR(4,:));
errorbar(dif_mean_strong3(b1),11:16,dif_std_strong3(b1),'horizontal',"LineStyle","none",'color',COLOR(4,:),'linewidth',1)
plot(dif_mean_strong3(b2),17:22,'o','color','k','MarkerFaceColor',COLOR(4,:));
errorbar(dif_mean_strong3(b2),17:22,dif_std_strong3(b2),'horizontal',"LineStyle","none",'color',COLOR(4,:),'linewidth',1)
plot(dif_mean_strong3(b3),23:28,'o','color','k','MarkerFaceColor',COLOR(4,:));
errorbar(dif_mean_strong3(b3),23:28,dif_std_strong3(b3),'horizontal',"LineStyle","none",'color',COLOR(4,:),'linewidth',1)
plot(dif_mean_strong3(b4),29:33,'o','color','k','MarkerFaceColor',COLOR(4,:));
errorbar(dif_mean_strong3(b4),29:33,dif_std_strong3(b4),'horizontal',"LineStyle","none",'color',COLOR(4,:),'linewidth',1)
plot(dif_mean_strong3(b5),34:36,'o','color','k','MarkerFaceColor',COLOR(4,:));
errorbar(dif_mean_strong3(b5),34:36,dif_std_strong3(b5),'horizontal',"LineStyle","none",'color',COLOR(4,:),'linewidth',1)

title('MHWs 2042-2022 Bottom up')
set(gca,'ytick',[1:36],'yticklabel',[])
ylim([1 37])
xlim([-25 10])
grid on
legend([a1a a2a a3a a4a],{'Curent MHW','Long MHWs','Moderate MHW','Strong MHW'})
xlabel('biomass change (%)')



