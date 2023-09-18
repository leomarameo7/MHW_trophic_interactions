close all
clear all

load('ecosimoutputsjuly2023.mat')
ecosimoutputs=ecosimoutputsjuly2023;



v2=load('rel_mhw_vulenrability2_v5');
v2_long=load('rel_mhw_long_vulenrability2_v5.mat');
v2_strong2=load('rel_mhw_strong2_vulenrability2_v5.mat');
v2_strong3=load('rel_mhw_strong3_vulenrability2_v5.mat');

ttime=datenum(2012,01:372,01);


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


for i=1:length(SPECIES)
A=find(species == SPECIES(i));

CATHEGORY(i)=unique(cathegory(A));
end

%% short term
    [a b]=find(ttime>=datenum(2023,01,01) & ttime<datenum(2025,12,31));



v2.dif_mean_mhw=nanmean(v2.rel_mhw(b,:),1);
v2.dif_mean_long=nanmean(v2_long.rel_long(b,:),1);
v2.dif_mean_strong2=nanmean(v2_strong2.rel_strong2(b,:),1);
v2.dif_mean_strong3=nanmean(v2_strong3.rel_strong3(b,:),1);

v2.dif_std_mhw=nanmean(v2.rel_mhw_std2(b,:),1);
v2.dif_std_long=nanmean(v2_long.rel_longmhw_std2(b,:),1);
v2.dif_std_strong2=nanmean(v2_strong2.rel_strong2mhw_std2(b,:),1);
v2.dif_std_strong3=nanmean(v2_strong3.rel_strong3mhw_std2(b,:),1);




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
a1a=plot(v2.dif_mean_mhw(d),1:2,'o','color','k','MarkerFaceColor',COLOR(1,:));
hold on
errorbar(v2.dif_mean_mhw(d),1:2,v2.dif_std_mhw(d),'horizontal',"LineStyle","none",'color',COLOR(1,:),'linewidth',1)
plot(v2.dif_mean_mhw(B),3:4,'o','color','k','MarkerFaceColor',COLOR(1,:));
errorbar(v2.dif_mean_mhw(B),3:4,v2.dif_std_mhw(B),'horizontal',"LineStyle","none",'color',COLOR(1,:),'linewidth',1)
plot(v2.dif_mean_mhw(h),5,'o','color','k','MarkerFaceColor',COLOR(1,:));
errorbar(v2.dif_mean_mhw(h),5,v2.dif_std_mhw(h),'horizontal',"LineStyle","none",'color',COLOR(1,:),'linewidth',1)
plot(v2.dif_mean_mhw(f),6,'o','color','k','MarkerFaceColor',COLOR(1,:));
errorbar(v2.dif_mean_mhw(f),6,v2.dif_std_mhw(f),'horizontal',"LineStyle","none",'color',COLOR(1,:),'linewidth',1)
plot(v2.dif_mean_mhw(b),7:10,'o','color','k','MarkerFaceColor',COLOR(1,:));
errorbar(v2.dif_mean_mhw(b),7:10,v2.dif_std_mhw(b),'horizontal',"LineStyle","none",'color',COLOR(1,:),'linewidth',1)
plot(v2.dif_mean_mhw(b1),11:16,'o','color','k','MarkerFaceColor',COLOR(1,:));
errorbar(v2.dif_mean_mhw(b1),11:16,v2.dif_std_mhw(b1),'horizontal',"LineStyle","none",'color',COLOR(1,:),'linewidth',1)
plot(v2.dif_mean_mhw(b2),17:22,'o','color','k','MarkerFaceColor',COLOR(1,:));
errorbar(v2.dif_mean_mhw(b2),17:22,v2.dif_std_mhw(b2),'horizontal',"LineStyle","none",'color',COLOR(1,:),'linewidth',1)
plot(v2.dif_mean_mhw(b3),23:28,'o','color','k','MarkerFaceColor',COLOR(1,:));
errorbar(v2.dif_mean_mhw(b3),23:28,v2.dif_std_mhw(b3),'horizontal',"LineStyle","none",'color',COLOR(1,:),'linewidth',1)
plot(v2.dif_mean_mhw(b4),29:33,'o','color','k','MarkerFaceColor',COLOR(1,:));
errorbar(v2.dif_mean_mhw(b4),29:33,v2.dif_std_mhw(b4),'horizontal',"LineStyle","none",'color',COLOR(1,:),'linewidth',1)
plot(v2.dif_mean_mhw(b5),34:36,'o','color','k','MarkerFaceColor',COLOR(1,:));
errorbar(v2.dif_mean_mhw(b5),34:36,v2.dif_std_mhw(b5),'horizontal',"LineStyle","none",'color',COLOR(1,:),'linewidth',1)

a2a=plot(v2.dif_mean_long(d),1:2,'o','color','k','MarkerFaceColor',COLOR(2,:));
hold on
errorbar(v2.dif_mean_long(d),1:2,v2.dif_std_long(d),'horizontal',"LineStyle","none",'color',COLOR(2,:),'linewidth',1)
plot(v2.dif_mean_long(B),3:4,'o','color','k','MarkerFaceColor',COLOR(2,:));
errorbar(v2.dif_mean_long(B),3:4,v2.dif_std_long(B),'horizontal',"LineStyle","none",'color',COLOR(2,:),'linewidth',1)
plot(v2.dif_mean_long(h),5,'o','color','k','MarkerFaceColor',COLOR(2,:));
errorbar(v2.dif_mean_long(h),5,v2.dif_std_long(h),'horizontal',"LineStyle","none",'color',COLOR(2,:),'linewidth',1)
plot(v2.dif_mean_long(f),6,'o','color','k','MarkerFaceColor',COLOR(2,:));
errorbar(v2.dif_mean_long(f),6,v2.dif_std_long(f),'horizontal',"LineStyle","none",'color',COLOR(2,:),'linewidth',1)
plot(v2.dif_mean_long(b),7:10,'o','color','k','MarkerFaceColor',COLOR(2,:));
errorbar(v2.dif_mean_long(b),7:10,v2.dif_std_long(b),'horizontal',"LineStyle","none",'color',COLOR(2,:),'linewidth',1)
plot(v2.dif_mean_long(b1),11:16,'o','color','k','MarkerFaceColor',COLOR(2,:));
errorbar(v2.dif_mean_long(b1),11:16,v2.dif_std_long(b1),'horizontal',"LineStyle","none",'color',COLOR(2,:),'linewidth',1)
plot(v2.dif_mean_long(b2),17:22,'o','color','k','MarkerFaceColor',COLOR(2,:));
errorbar(v2.dif_mean_long(b2),17:22,v2.dif_std_long(b2),'horizontal',"LineStyle","none",'color',COLOR(2,:),'linewidth',1)
plot(v2.dif_mean_long(b3),23:28,'o','color','k','MarkerFaceColor',COLOR(2,:));
errorbar(v2.dif_mean_long(b3),23:28,v2.dif_std_long(b3),'horizontal',"LineStyle","none",'color',COLOR(2,:),'linewidth',1)
plot(v2.dif_mean_long(b4),29:33,'o','color','k','MarkerFaceColor',COLOR(2,:));
errorbar(v2.dif_mean_long(b4),29:33,v2.dif_std_long(b4),'horizontal',"LineStyle","none",'color',COLOR(2,:),'linewidth',1)
plot(v2.dif_mean_long(b5),34:36,'o','color','k','MarkerFaceColor',COLOR(1,:));
errorbar(v2.dif_mean_long(b5),34:36,v2.dif_std_long(b5),'horizontal',"LineStyle","none",'color',COLOR(2,:),'linewidth',1)


a3a=plot(v2.dif_mean_strong2(d),1:2,'o','color','k','MarkerFaceColor',COLOR(3,:));
hold on
errorbar(v2.dif_mean_strong2(d),1:2,v2.dif_std_strong2(d),'horizontal',"LineStyle","none",'color',COLOR(3,:),'linewidth',1)
plot(v2.dif_mean_strong2(B),3:4,'o','color','k','MarkerFaceColor',COLOR(3,:));
errorbar(v2.dif_mean_strong2(B),3:4,v2.dif_std_strong2(B),'horizontal',"LineStyle","none",'color',COLOR(3,:),'linewidth',1)
plot(v2.dif_mean_strong2(h),5,'o','color','k','MarkerFaceColor',COLOR(3,:));
errorbar(v2.dif_mean_strong2(h),5,v2.dif_std_strong2(h),'horizontal',"LineStyle","none",'color',COLOR(3,:),'linewidth',1)
plot(v2.dif_mean_strong2(f),6,'o','color','k','MarkerFaceColor',COLOR(3,:));
errorbar(v2.dif_mean_strong2(f),6,v2.dif_std_strong2(f),'horizontal',"LineStyle","none",'color',COLOR(3,:),'linewidth',1)
plot(v2.dif_mean_strong2(b),7:10,'o','color','k','MarkerFaceColor',COLOR(3,:));
errorbar(v2.dif_mean_strong2(b),7:10,v2.dif_std_strong2(b),'horizontal',"LineStyle","none",'color',COLOR(3,:),'linewidth',1)
plot(v2.dif_mean_strong2(b1),11:16,'o','color','k','MarkerFaceColor',COLOR(3,:));
errorbar(v2.dif_mean_strong2(b1),11:16,v2.dif_std_strong2(b1),'horizontal',"LineStyle","none",'color',COLOR(3,:),'linewidth',1)
plot(v2.dif_mean_strong2(b2),17:22,'o','color','k','MarkerFaceColor',COLOR(3,:));
errorbar(v2.dif_mean_strong2(b2),17:22,v2.dif_std_strong2(b2),'horizontal',"LineStyle","none",'color',COLOR(3,:),'linewidth',1)
plot(v2.dif_mean_strong2(b3),23:28,'o','color','k','MarkerFaceColor',COLOR(3,:));
errorbar(v2.dif_mean_strong2(b3),23:28,v2.dif_std_strong2(b3),'horizontal',"LineStyle","none",'color',COLOR(3,:),'linewidth',1)
plot(v2.dif_mean_strong2(b4),29:33,'o','color','k','MarkerFaceColor',COLOR(3,:));
errorbar(v2.dif_mean_strong2(b4),29:33,v2.dif_std_strong2(b4),'horizontal',"LineStyle","none",'color',COLOR(3,:),'linewidth',1)
plot(v2.dif_mean_strong2(b5),34:36,'o','color','k','MarkerFaceColor',COLOR(3,:));
errorbar(v2.dif_mean_strong2(b5),34:36,v2.dif_std_strong2(b5),'horizontal',"LineStyle","none",'color',COLOR(3,:),'linewidth',1)

a4a=plot(v2.dif_mean_strong3(d),1:2,'o','color','k','MarkerFaceColor',COLOR(4,:));
hold on
errorbar(v2.dif_mean_strong3(d),1:2,v2.dif_std_strong3(d),'horizontal',"LineStyle","none",'color',COLOR(4,:),'linewidth',1)
plot(v2.dif_mean_strong3(B),3:4,'o','color','k','MarkerFaceColor',COLOR(4,:));
errorbar(v2.dif_mean_strong3(B),3:4,v2.dif_std_strong3(B),'horizontal',"LineStyle","none",'color',COLOR(4,:),'linewidth',1)
plot(v2.dif_mean_strong3(h),5,'o','color','k','MarkerFaceColor',COLOR(4,:));
errorbar(v2.dif_mean_strong3(h),5,v2.dif_std_strong3(h),'horizontal',"LineStyle","none",'color',COLOR(4,:),'linewidth',1)
plot(v2.dif_mean_strong3(f),6,'o','color','k','MarkerFaceColor',COLOR(4,:));
errorbar(v2.dif_mean_strong3(f),6,v2.dif_std_strong3(f),'horizontal',"LineStyle","none",'color',COLOR(4,:),'linewidth',1)
plot(v2.dif_mean_strong3(b),7:10,'o','color','k','MarkerFaceColor',COLOR(4,:));
errorbar(v2.dif_mean_strong3(b),7:10,v2.dif_std_strong3(b),'horizontal',"LineStyle","none",'color',COLOR(4,:),'linewidth',1)
plot(v2.dif_mean_strong3(b1),11:16,'o','color','k','MarkerFaceColor',COLOR(4,:));
errorbar(v2.dif_mean_strong3(b1),11:16,v2.dif_std_strong3(b1),'horizontal',"LineStyle","none",'color',COLOR(4,:),'linewidth',1)
plot(v2.dif_mean_strong3(b2),17:22,'o','color','k','MarkerFaceColor',COLOR(4,:));
errorbar(v2.dif_mean_strong3(b2),17:22,v2.dif_std_strong3(b2),'horizontal',"LineStyle","none",'color',COLOR(4,:),'linewidth',1)
plot(v2.dif_mean_strong3(b3),23:28,'o','color','k','MarkerFaceColor',COLOR(4,:));
errorbar(v2.dif_mean_strong3(b3),23:28,v2.dif_std_strong3(b3),'horizontal',"LineStyle","none",'color',COLOR(4,:),'linewidth',1)
plot(v2.dif_mean_strong3(b4),29:33,'o','color','k','MarkerFaceColor',COLOR(4,:));
errorbar(v2.dif_mean_strong3(b4),29:33,v2.dif_std_strong3(b4),'horizontal',"LineStyle","none",'color',COLOR(4,:),'linewidth',1)
plot(v2.dif_mean_strong3(b5),34:36,'o','color','k','MarkerFaceColor',COLOR(4,:));
errorbar(v2.dif_mean_strong3(b5),34:36,v2.dif_std_strong3(b5),'horizontal',"LineStyle","none",'color',COLOR(4,:),'linewidth',1)

title('MHWs 2023-2025 mixed trophic control')
set(gca,'ytick',[1:36],'yticklabel',[ytick2])
ylim([0 37])
xlim([-40 30])
grid on

legend([a1a a2a a3a a4a],{'Current MHW','Long MHW','Moderate MHW','Strong MHWs'})
xlabel('biomass change (%)')

%% long term changes
[a b]=find(ttime>=datenum(2022,01,01) & ttime<datenum(2022,12,31));
    [AA BB]=find(ttime>=datenum(2042,01,01) & ttime<datenum(2042,12,31));



v2.dif_mean_mhw=nanmean(v2.rel_mhw(BB,:),1)-nanmean(v2.rel_mhw(b,:),1);
v2.dif_mean_long=nanmean(v2_long.rel_long(BB,:),1)-nanmean(v2_long.rel_long(b,:),1);
v2.dif_mean_strong2=nanmean(v2_strong2.rel_strong2(BB,:),1)-nanmean(v2_strong2.rel_strong2(b,:),1);
v2.dif_mean_strong3=nanmean(v2_strong3.rel_strong3(BB,:),1)-nanmean(v2_strong3.rel_strong3(b,:),1);



v2.dif_std_mhw=(nanmean(v2.rel_mhw_std2(BB,:),1)+nanmean(v2.rel_mhw_std2(b,:),1))/2;
v2.dif_std_long=(nanmean(v2_long.rel_longmhw_std2(BB,:),1)+nanmean(v2_long.rel_longmhw_std2(b,:),1))/2;
v2.dif_std_strong2=(nanmean(v2_strong2.rel_strong2mhw_std2(BB,:),1)+nanmean(v2_strong2.rel_strong2mhw_std2(b,:),1))/2;
v2.dif_std_strong3=(nanmean(v2_strong3.rel_strong3mhw_std2(BB,:),1)+nanmean(v2_strong3.rel_strong3mhw_std2(b,:),1))/2;



std_mean_mhw=nanstd(v2.rel_mhw(BB,:)-v2.rel_mhw(b,:),0,1);
std_mean_long=nanstd(v2_long.rel_long(BB,:)-v2_long.rel_long(b,:),0,1);
std_mean_strong2=nanstd(v2_strong2.rel_strong2(BB,:)-v2_strong2.rel_strong2(b,:),0,1);
std_mean_strong3=nanstd(v2_strong3.rel_strong3(BB,:)-v2_strong3.rel_strong3(b,:),0,1);


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


%initfigpaysage;
subplot(1,2,2)
a1a=plot(v2.dif_mean_mhw(d),1:2,'o','color','k','MarkerFaceColor',COLOR(1,:));
hold on
errorbar(v2.dif_mean_mhw(d),1:2,v2.dif_std_mhw(d),'horizontal',"LineStyle","none",'color',COLOR(1,:),'linewidth',1)
plot(v2.dif_mean_mhw(B),3:4,'o','color','k','MarkerFaceColor',COLOR(1,:));
errorbar(v2.dif_mean_mhw(B),3:4,v2.dif_std_mhw(B),'horizontal',"LineStyle","none",'color',COLOR(1,:),'linewidth',1)
plot(v2.dif_mean_mhw(h),5,'o','color','k','MarkerFaceColor',COLOR(1,:));
errorbar(v2.dif_mean_mhw(h),5,v2.dif_std_mhw(h),'horizontal',"LineStyle","none",'color',COLOR(1,:),'linewidth',1)
plot(v2.dif_mean_mhw(f),6,'o','color','k','MarkerFaceColor',COLOR(1,:));
errorbar(v2.dif_mean_mhw(f),6,v2.dif_std_mhw(f),'horizontal',"LineStyle","none",'color',COLOR(1,:),'linewidth',1)
plot(v2.dif_mean_mhw(b),7:10,'o','color','k','MarkerFaceColor',COLOR(1,:));
errorbar(v2.dif_mean_mhw(b),7:10,v2.dif_std_mhw(b),'horizontal',"LineStyle","none",'color',COLOR(1,:),'linewidth',1)
plot(v2.dif_mean_mhw(b1),11:16,'o','color','k','MarkerFaceColor',COLOR(1,:));
errorbar(v2.dif_mean_mhw(b1),11:16,v2.dif_std_mhw(b1),'horizontal',"LineStyle","none",'color',COLOR(1,:),'linewidth',1)
plot(v2.dif_mean_mhw(b2),17:22,'o','color','k','MarkerFaceColor',COLOR(1,:));
errorbar(v2.dif_mean_mhw(b2),17:22,v2.dif_std_mhw(b2),'horizontal',"LineStyle","none",'color',COLOR(1,:),'linewidth',1)
plot(v2.dif_mean_mhw(b3),23:28,'o','color','k','MarkerFaceColor',COLOR(1,:));
errorbar(v2.dif_mean_mhw(b3),23:28,v2.dif_std_mhw(b3),'horizontal',"LineStyle","none",'color',COLOR(1,:),'linewidth',1)
plot(v2.dif_mean_mhw(b4),29:33,'o','color','k','MarkerFaceColor',COLOR(1,:));
errorbar(v2.dif_mean_mhw(b4),29:33,v2.dif_std_mhw(b4),'horizontal',"LineStyle","none",'color',COLOR(1,:),'linewidth',1)
plot(v2.dif_mean_mhw(b5),34:36,'o','color','k','MarkerFaceColor',COLOR(1,:));
errorbar(v2.dif_mean_mhw(b5),34:36,v2.dif_std_mhw(b5),'horizontal',"LineStyle","none",'color',COLOR(1,:),'linewidth',1)

a2a=plot(v2.dif_mean_long(d),1:2,'o','color','k','MarkerFaceColor',COLOR(2,:));
hold on
errorbar(v2.dif_mean_long(d),1:2,v2.dif_std_long(d),'horizontal',"LineStyle","none",'color',COLOR(2,:),'linewidth',1)
plot(v2.dif_mean_long(B),3:4,'o','color','k','MarkerFaceColor',COLOR(2,:));
errorbar(v2.dif_mean_long(B),3:4,v2.dif_std_long(B),'horizontal',"LineStyle","none",'color',COLOR(2,:),'linewidth',1)
plot(v2.dif_mean_long(h),5,'o','color','k','MarkerFaceColor',COLOR(2,:));
errorbar(v2.dif_mean_long(h),5,v2.dif_std_long(h),'horizontal',"LineStyle","none",'color',COLOR(2,:),'linewidth',1)
plot(v2.dif_mean_long(f),6,'o','color','k','MarkerFaceColor',COLOR(2,:));
errorbar(v2.dif_mean_long(f),6,v2.dif_std_long(f),'horizontal',"LineStyle","none",'color',COLOR(2,:),'linewidth',1)
plot(v2.dif_mean_long(b),7:10,'o','color','k','MarkerFaceColor',COLOR(2,:));
errorbar(v2.dif_mean_long(b),7:10,v2.dif_std_long(b),'horizontal',"LineStyle","none",'color',COLOR(2,:),'linewidth',1)
plot(v2.dif_mean_long(b1),11:16,'o','color','k','MarkerFaceColor',COLOR(2,:));
errorbar(v2.dif_mean_long(b1),11:16,v2.dif_std_long(b1),'horizontal',"LineStyle","none",'color',COLOR(2,:),'linewidth',1)
plot(v2.dif_mean_long(b2),17:22,'o','color','k','MarkerFaceColor',COLOR(2,:));
errorbar(v2.dif_mean_long(b2),17:22,v2.dif_std_long(b2),'horizontal',"LineStyle","none",'color',COLOR(2,:),'linewidth',1)
plot(v2.dif_mean_long(b3),23:28,'o','color','k','MarkerFaceColor',COLOR(2,:));
errorbar(v2.dif_mean_long(b3),23:28,v2.dif_std_long(b3),'horizontal',"LineStyle","none",'color',COLOR(2,:),'linewidth',1)
plot(v2.dif_mean_long(b4),29:33,'o','color','k','MarkerFaceColor',COLOR(2,:));
errorbar(v2.dif_mean_long(b4),29:33,v2.dif_std_long(b4),'horizontal',"LineStyle","none",'color',COLOR(2,:),'linewidth',1)
plot(v2.dif_mean_long(b5),34:36,'o','color','k','MarkerFaceColor',COLOR(1,:));
errorbar(v2.dif_mean_long(b5),34:36,v2.dif_std_long(b5),'horizontal',"LineStyle","none",'color',COLOR(2,:),'linewidth',1)


a3a=plot(v2.dif_mean_strong2(d),1:2,'o','color','k','MarkerFaceColor',COLOR(3,:));
hold on
errorbar(v2.dif_mean_strong2(d),1:2,v2.dif_std_strong2(d),'horizontal',"LineStyle","none",'color',COLOR(3,:),'linewidth',1)
plot(v2.dif_mean_strong2(B),3:4,'o','color','k','MarkerFaceColor',COLOR(3,:));
errorbar(v2.dif_mean_strong2(B),3:4,v2.dif_std_strong2(B),'horizontal',"LineStyle","none",'color',COLOR(3,:),'linewidth',1)
plot(v2.dif_mean_strong2(h),5,'o','color','k','MarkerFaceColor',COLOR(3,:));
errorbar(v2.dif_mean_strong2(h),5,v2.dif_std_strong2(h),'horizontal',"LineStyle","none",'color',COLOR(3,:),'linewidth',1)
plot(v2.dif_mean_strong2(f),6,'o','color','k','MarkerFaceColor',COLOR(3,:));
errorbar(v2.dif_mean_strong2(f),6,v2.dif_std_strong2(f),'horizontal',"LineStyle","none",'color',COLOR(3,:),'linewidth',1)
plot(v2.dif_mean_strong2(b),7:10,'o','color','k','MarkerFaceColor',COLOR(3,:));
errorbar(v2.dif_mean_strong2(b),7:10,v2.dif_std_strong2(b),'horizontal',"LineStyle","none",'color',COLOR(3,:),'linewidth',1)
plot(v2.dif_mean_strong2(b1),11:16,'o','color','k','MarkerFaceColor',COLOR(3,:));
errorbar(v2.dif_mean_strong2(b1),11:16,v2.dif_std_strong2(b1),'horizontal',"LineStyle","none",'color',COLOR(3,:),'linewidth',1)
plot(v2.dif_mean_strong2(b2),17:22,'o','color','k','MarkerFaceColor',COLOR(3,:));
errorbar(v2.dif_mean_strong2(b2),17:22,v2.dif_std_strong2(b2),'horizontal',"LineStyle","none",'color',COLOR(3,:),'linewidth',1)
plot(v2.dif_mean_strong2(b3),23:28,'o','color','k','MarkerFaceColor',COLOR(3,:));
errorbar(v2.dif_mean_strong2(b3),23:28,v2.dif_std_strong2(b3),'horizontal',"LineStyle","none",'color',COLOR(3,:),'linewidth',1)
plot(v2.dif_mean_strong2(b4),29:33,'o','color','k','MarkerFaceColor',COLOR(3,:));
errorbar(v2.dif_mean_strong2(b4),29:33,v2.dif_std_strong2(b4),'horizontal',"LineStyle","none",'color',COLOR(3,:),'linewidth',1)
plot(v2.dif_mean_strong2(b5),34:36,'o','color','k','MarkerFaceColor',COLOR(3,:));
errorbar(v2.dif_mean_strong2(b5),34:36,v2.dif_std_strong2(b5),'horizontal',"LineStyle","none",'color',COLOR(3,:),'linewidth',1)

a4a=plot(v2.dif_mean_strong3(d),1:2,'o','color','k','MarkerFaceColor',COLOR(4,:));
hold on
errorbar(v2.dif_mean_strong3(d),1:2,v2.dif_std_strong3(d),'horizontal',"LineStyle","none",'color',COLOR(4,:),'linewidth',1)
plot(v2.dif_mean_strong3(B),3:4,'o','color','k','MarkerFaceColor',COLOR(4,:));
errorbar(v2.dif_mean_strong3(B),3:4,v2.dif_std_strong3(B),'horizontal',"LineStyle","none",'color',COLOR(4,:),'linewidth',1)
plot(v2.dif_mean_strong3(h),5,'o','color','k','MarkerFaceColor',COLOR(4,:));
errorbar(v2.dif_mean_strong3(h),5,v2.dif_std_strong3(h),'horizontal',"LineStyle","none",'color',COLOR(4,:),'linewidth',1)
plot(v2.dif_mean_strong3(f),6,'o','color','k','MarkerFaceColor',COLOR(4,:));
errorbar(v2.dif_mean_strong3(f),6,v2.dif_std_strong3(f),'horizontal',"LineStyle","none",'color',COLOR(4,:),'linewidth',1)
plot(v2.dif_mean_strong3(b),7:10,'o','color','k','MarkerFaceColor',COLOR(4,:));
errorbar(v2.dif_mean_strong3(b),7:10,v2.dif_std_strong3(b),'horizontal',"LineStyle","none",'color',COLOR(4,:),'linewidth',1)
plot(v2.dif_mean_strong3(b1),11:16,'o','color','k','MarkerFaceColor',COLOR(4,:));
errorbar(v2.dif_mean_strong3(b1),11:16,v2.dif_std_strong3(b1),'horizontal',"LineStyle","none",'color',COLOR(4,:),'linewidth',1)
plot(v2.dif_mean_strong3(b2),17:22,'o','color','k','MarkerFaceColor',COLOR(4,:));
errorbar(v2.dif_mean_strong3(b2),17:22,v2.dif_std_strong3(b2),'horizontal',"LineStyle","none",'color',COLOR(4,:),'linewidth',1)
plot(v2.dif_mean_strong3(b3),23:28,'o','color','k','MarkerFaceColor',COLOR(4,:));
errorbar(v2.dif_mean_strong3(b3),23:28,v2.dif_std_strong3(b3),'horizontal',"LineStyle","none",'color',COLOR(4,:),'linewidth',1)
plot(v2.dif_mean_strong3(b4),29:33,'o','color','k','MarkerFaceColor',COLOR(4,:));
errorbar(v2.dif_mean_strong3(b4),29:33,v2.dif_std_strong3(b4),'horizontal',"LineStyle","none",'color',COLOR(4,:),'linewidth',1)
plot(v2.dif_mean_strong3(b5),34:36,'o','color','k','MarkerFaceColor',COLOR(4,:));
errorbar(v2.dif_mean_strong3(b5),34:36,v2.dif_std_strong3(b5),'horizontal',"LineStyle","none",'color',COLOR(4,:),'linewidth',1)

title('MHW 2042-2022 Mixed trophic control')
set(gca,'ytick',[1:36],'yticklabel',[])
ylim([0 37])
xlim([-40 30])
grid on

legend([a1a a2a a3a a4a],{'Current MHW','Long MHW','Moderate MHW','Strong MHWs'})
xlabel('biomass change (%)')


