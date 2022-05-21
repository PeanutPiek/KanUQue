clear;
home;
close all;

% Anzahl der Samples
N = 5000;
% Anzahl der Klassen (Jede Klasse entspricht einem Symbol)
nBins = 256;

% Gleichverteilung
r_ = rand(N, 1);
% Erzeuge Normalverteilung zum Test
% !!! Ist Normalverteilung eine gedächtnisabhängige Quelle?
% Normalverteilung 
rn_ = randn(N, 1);

% Plot Zufallszahlen (Samples)
figure('Name', 'Zufallszahlen')
subplot(2, 1, 1);
h = histogram(r_, nBins);
ylabel('N(k)')
xlabel('Klassen k')
subtitle('Einheitsverteilung')
subplot(2, 1, 2);
hn = histogram(rn_, nBins);
ylabel('N(k)')
xlabel('Klassen k')
subtitle('Normalverteilung')

% Entscheidungsgehalt der Quelle
% H0 = Maximalwert der Entropie (Hmax)
H0 = log2(nBins)

% Entropie der Einheitsverteilung
[H, E_] = entropie(h.Values, N, nBins);
% Entropie der Normalverteilung
% Hn < H0 :
% Bestätigung, dass Normalverteilung eine gedächtnisabhängige Quelle ist.
[Hn, En_] = entropie(hn.Values, N, nBins);
% Klassenwerte der Einheitsverteilung
b_ = h.BinEdges;
% Klassenwerte der Normalverteilung
bn_ = hn.BinEdges;

% Plot Schätzwerte für Wahrscheinlichkeiten
figure('Name', 'Wahrscheinlichkeiten')
subplot(2, 1, 1)
% Stellt die Wahrscheinlichkeiten dar, dass ein Wert aus der Klasse
% eintritt.
plot(b_(1:nBins), E_, '.');
xlabel('Klasse k')
ylabel('E(k)')
subtitle('Einheitsverteilung')
subplot(2, 1, 2)
% Stellt die Wahrscheinlichkeiten dar, dass ein Wert aus der Klasse
% eintritt.
plot(bn_(1:nBins), En_, '.');
xlabel('Klasse k')
ylabel('E(k)')
subtitle('Normalverteilung')

% Mittlere Codewortlänge
L_ = zeros(nBins, 1);
for u = 1:1:nBins
    v = h.Values(u);
    if isnan(v)
        v = 0;
    end
    L_(u) = E_(u) * log2(v);
end
% Untere Codewortlänge: H0 = ld(M) => Entscheidungsgehalt

l = sum(L_);
% Redundanz
Rc = l - H


%
% Analyse von Bildquelle.
%
%



% Lade Bilddatei
im0 = imread('Laboruebung 1/s2201.ppm');
% Umwandlung in Grayscale für Intensität
img0 = rgb2gray(im0);

figure('Name', 'Bildanalyse: Histogram / Verteilungsfunktion')
subplot(3, 2, 1)
hi0 = histogram(img0, nBins);
title('s2201.ppm');
sim0 = size(img0);
[Him0, Eim0_] = entropie(hi0.Values, sim0(1)*sim0(2), nBins);
subplot(3, 2, 3)
plot(Eim0_, '.');
title(sprintf("Entropie=%.3f", Him0))
subplot(3, 2, 5)
ecdf(gca, Eim0_);

% Lade Bilddatei
im1 = imread('Laboruebung 1/s2202.ppm');
% Umwandlung in Grayscale für Intensität
img1 = rgb2gray(im1);

subplot(3, 2, 2)
hi1 = histogram(img1, nBins);
title('s2202.ppm');
sim1 = size(img1);
[Him1, Eim1_] = entropie(hi1.Values, sim1(1)*sim1(2), nBins);
subplot(3, 2, 4)
plot(Eim1_, '.');
title(sprintf("Entropie=%.3f", Him1))
subplot(3, 2, 6)
ecdf(gca, Eim1_);

[v0_, x0_] = ecdf(Eim0_);
[v1_, x1_] = ecdf(Eim1_);

figure('Name', 'Empirische Verteilungsfunktion')
subplot(2, 1, 1)
plot(x0_);
title('s2201.ppm')
subplot(2, 1, 2)
plot(x1_);
title('s2202.ppm')