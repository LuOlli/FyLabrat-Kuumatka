%Fysiikan perusopintojen laboratoriotyöt I,
%Kuumatka
%Työn tarkoituksena on kuvata matkustaminen kuuhun laskennallisesti
%Määritellään työssä tarvittavat vakiot:
ME=5.972e24;%kg, maan massa
MM=7.346e22;%kg, kuun massa
REM=384400e3;%m, kuun ja maan välimatka
RM=1737.4e3;%m, kuun säde
RE=6371e3;%m, maan säde
G=6.674e-11;%Nm^2kg^-2, gravitaatiovakio
%asetetaan lähtöpaikka r0 noin kymmenen kilometrin korkeuteen maan pinnasta:
r0=RE+10000;%m
r=r0;
rm=REM-r+RM;%etäisyys kuusta
DT=0.01; %Numeerisessa ratkaisussa käytetty aika-askel
%Asetetaan alkunopeuden etsinnässä arvo nollaan ja lähdetään etsimään
%minimialkunopeutta ensin 1000 m/s tarkkuudella ja sitten 100,10,1 ja 0.1 m/s
%tarkkuuksilla.
v0=0;
v0min = -1;
vmin = -1;%voi olla mielivaltaiset negatiiviset arvot, 
%kunhan while-silmukka käynnistyy

while vmin <= 0
    v=v0;
    r=r0;
    a=-9.7887; %kiihtyvyydelle annettava myös mv neg arvo joka silmukalla
    i=1;
    while (v > 0 && a < 0)
        rm=REM-r+RM;
        a=-G*((ME/r^2)-(MM/rm^2));
        v=v+a*DT;
        r=r+v*DT;
        i=i+1; 
    end
    vmin = v;
    if v > 0
        v0min = v0;
    end
    v0=v0+1000; %kasvatetaan joka silmukalla alkunopeutta tarkkuuden verran
end

v0=v0min-2000; %uusi alkunopeuden alkupiste parempaa tarkkuutta varten
v0min=-1;
vmin = -1;
while vmin <= 0
    v=v0;
    r=r0;
    a=-9.7887;
    i=1;
    while (v > 0 && a < 0)
        rm=REM-r+RM;
        a=-G*((ME/r^2)-(MM/rm^2));
        v=v+a*DT;
        r=r+v*DT;
        i=i+1; 
    end
    vmin = v;
    if v > 0
        v0min = v0;
    end
    v0=v0+100;
end

v0=v0min-200;
v0min=-1;
vmin = -1;
while vmin <= 0
    v=v0;
    r=r0;
    a=-9.7887;
    i=1;
    while (v > 0 && a < 0)
        rm=REM-r+RM;
        a=-G*((ME/r^2)-(MM/rm^2));
        v=v+a*DT;
        r=r+v*DT;
        i=i+1; 
    end
    vmin = v;
    if v > 0
        v0min = v0;
    end
    v0=v0+10;
end

v0=v0min-20;
v0min=-1;
vmin = -1;
while vmin <= 0
    v=v0;
    r=r0;
    a=-9.7887;
    i=1;
    while (v > 0 && a < 0)
        rm=REM-r+RM;
        a=-G*((ME/r^2)-(MM/rm^2));
        v=v+a*DT;
        r=r+v*DT;
        i=i+1; 
    end
    vmin = v;
    if v > 0
        v0min = v0;
    end
    v0=v0+1;
end

v0=v0min-2;
v0min=-1;
vmin = -1;
while vmin <= 0
    v=v0;
    r=r0;
    a=-9.7887;
    i=1;
    while (v > 0 && a < 0)
        rm=REM-r+RM;
        a=-G*((ME/r^2)-(MM/rm^2));
        v=v+a*DT;
        r=r+v*DT;
        i=i+1; 
    end
    vmin = v;
    if v > 0
        v0min = v0;
    end
    v0=v0+0.1;
end
disp(' Alkunopeus 0.1 tarkkuudella:')
disp(v0min)



%alustetaan paikka-, nopeus- ja kiihtyvyystaulukot
rr=zeros(100000000,1); 
vv=zeros(100000000,1);
aa=zeros(100000000,1);
v=v0min; %asetetaan alkunopeus löydettyyn arvoon
r=r0;
i=1;
while (r > RE && rm > RM) %iteroidaan kunnes ollaan joko kuussa tai takaisin maassa
    rm=REM-r+RM;
    a=-G*((ME/r^2)-(MM/rm^2));
    v=v+a*DT;
    r=r+v*DT;
    rr(i)=r; %tallennetaan arvot plottausta varten
    vv(i)=v;
    aa(i)=a;
    i=i+1; 
end
rr=rr(1:find(rr,1,'last'));
vv=vv(1:find(vv,1,'last'));
aa=aa(1:find(aa,1,'last'));
disp('-----------------------------')
disp(['Alkunopeus:' num2str(v0min) ' m/s^2'])
disp('-----------------------------')
disp('Etäisyys maan pinnasta alussa')
disp([num2str(r0) ' m'])
disp('-----------------------------')
disp('Miniminopeus matkalla:')
disp([num2str(min(vv)) ' m/s'])
disp('-----------------------------')
disp('Kiihtyvyys lopussa')
disp([num2str(aa(end)) ' m/s^2'])
disp('-----------------------------')
disp('Nopeus lopussa')
disp([num2str(vv(end)) ' m/s'])
disp('-----------------------------')
disp('Etäisyys maasta lopussa')
disp([num2str(rr(end)) ' m'])
disp('-----------------------------')
disp('Kulunut aika:')
disp([num2str(i*DT) ' s'])
disp([num2str(i*DT/3600) ' h'])
disp('-----------------------------')
figure
hold on
subplot(3,1,1)
plot(linspace(0,i*DT/3600,length(rr)),rr,'g')
xlim([-5,195])
ylabel('Etäisyys maasta r (m)')
xlabel('Aika (h)')
subplot(3,1,2)
plot(linspace(0,i*DT/3600,length(vv)),vv,'b')
xlim([-5,195])
ylabel('Nopeus v (m/s)')
xlabel('Aika (h)')
subplot(3,1,3)
plot(linspace(0,i*DT/3600,length(aa)),aa,'r')
xlim([-5,195])
ylabel('Kiihtyvyys a (m/s^2)')
xlabel('Aika (h)')
%%
%lasketaan vielä matka-aika tilanteessa jossa alkunopeus on 10% suurempi
i=1;
rr=zeros(100000000,1);
vv=zeros(100000000,1);
aa=zeros(100000000,1);
v=v0min*1.1;
r=r0;
rm=REM-r+RM;
while (r > RE && rm > RM)
    rm=REM-r+RM;
    a=-G*((ME/r^2)-(MM/rm^2));
    v=v+a*DT;
    r=r+v*DT;
    rr(i)=r;
    vv(i)=v;
    aa(i)=a;
    i=i+1; 
end
rr=rr(1:find(rr,1,'last'));
vv=vv(1:find(vv,1,'last'));
aa=aa(1:find(aa,1,'last'));
disp('Kun alkunopeus on 1.1*v0:')
disp('Kulunut aika:')
disp([num2str(i*DT) ' s'])
disp([num2str(i*DT/3600) ' h'])
disp('-----------------------------')
disp('-----------------------------')
figure
hold on
subplot(3,1,1)
plot(linspace(0,i*DT/3600,length(rr)),rr,'g')
xlim([-0.5,20.5])
ylabel('Etäisyys maasta r (m)')
xlabel('Aika (h)')
subplot(3,1,2)
plot(linspace(0,i*DT/3600,length(vv)),vv,'b')
xlim([-0.5,20.5])
ylim([0,12000])
ylabel('Nopeus v (m/s)')
xlabel('Aika (h)')
subplot(3,1,3)
plot(linspace(0,i*DT/3600,length(aa)),aa,'r')
xlim([-0.5,20.5])
ylabel('Kiihtyvyys a (m/s^2)')
xlabel('Aika (h)')
