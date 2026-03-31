
%%
clear all
close all
clc

%% Posizionamento nella directory dei files e carica le immagini


directory = pwd; %cartella generale dove sono contenuti i tuoi dati
folder_path = fullfile(directory,'//'); %cartella specifica dove ci sono dati che ti interesaanto
listdir = dir(fullfile(folder_path,'*.jpg')); %lista di nomi di file jpeg nella directory selezionata

%% Cicla lungo la lista di nomi quindi applica l'"imreducehaze" per
% migliorare la qualità dell'immagine (rimozione effetto nebbia);
for i = 1:numel(listdir)
    disp(listdir(i))
    im = im2gray(imread(listdir(i).name));
    im = mat2gray(im);
    medie_totali = mean2(im);
    saving_dir = fullfile(directory,'//');
    
    im = imreducehaze(im,medie_totali,'method','approx'); %applica rimozione effetto nebbia

    %im_resized = imresize(im, [2000, 2000]); %resize per avere tutte immagini stesse dimensioni
    im_resized = im;
    % questi passaggi serviranno dopo per le immagini molto scure che
    % richiedono ulteriori step di filtraggio
    [counts,hist] = imhist(im_resized);
    conto_grigi = counts;
    istogrammi = hist;
    livelli_medi = find(istogrammi>0.15 & istogrammi<0.3);
    grigi_medi = conto_grigi(livelli_medi);
    grigi_sommati = sum(grigi_medi);

    %FILTRAGGIO
    media_resize = mean2(im_resized);

    if media_resize < 0.25
        media_resize = 1.5; %valori sballati da approfondire ulteriormente
    end

    newim = adjgamma(im_resized,media_resize); %applica gamma correction (valore da migliorare)
    newim2 = adjcontrast(newim,5,mean2(newim)); %applica sigmoid correction (valore da migliorare)

    % clipLimit: tra 0 e 1. Valori elevato --> maggior contrasto
    imer2 = adapthisteq(newim2,'clipLimit',0.001,'NumTiles',[2 2],'Distribution','exponential'); %num tiles valore da migliorare
    imer=imgaussfilt(imer2,2);
    if grigi_sommati>2700000 && max(conto_grigi)>100000 %check con vlori arbitari per correggere immagini scure
        imer=adjgamma(imer,2);
        imer=imadjust(imer,[mean2(newim) 0.85],[]);
    end
     
    saving_dir = fullfile(directory,'//'); %directory di salvataggio
    if ~exist(saving_dir, 'dir')
       mkdir(saving_dir)
       disp('New directory created')
    end
    filename=[saving_dir,listdir(i).name];
    imwrite(imer,filename);
    disp('Saved Successfully')
end
%% IMCOMPLEMENT
% Cicla lungo la lista di nomi quindi applica l'imcomplement e successivamente l'imreducehaze
% per migliorare la qualità dell'immagine (rimozione effetto nebbia);
for i = 1:numel(listdir)
    disp(listdir(i))
    im = imread(fullfile(folder_path, listdir(i).name));
    im = imcomplement(im); % Applica la complementarità all'immagine
    im = im2gray(im);
    im = mat2gray(im);
    medie_totali = mean2(im);
    saving_dir = fullfile(directory, '//');
    
    im = imreducehaze(im, medie_totali, 'method', 'approx'); % applica rimozione effetto nebbia

    % im_resized = imresize(im, [2000, 2000]); % resize per avere tutte immagini stesse dimensioni
    im_resized = im;
    % questi passaggi serviranno dopo per le immagini molto scure che
    % richiedono ulteriori step di filtraggio
    [counts, hist] = imhist(im_resized);
    conto_grigi = counts;
    istogrammi = hist;
    livelli_medi = find(istogrammi > 0.15 & istogrammi < 0.3);
    grigi_medi = conto_grigi(livelli_medi);
    grigi_sommati = sum(grigi_medi);

    % FILTRAGGIO
    media_resize = mean2(im_resized);

    if media_resize < 0.25
        media_resize = 1.5; % valori sballati da approfondire ulteriormente
    end

    newim = adjgamma(im_resized, media_resize); % applica gamma correction
    newim2 = adjcontrast(newim, 5, mean2(newim)); % applica sigmoid correction

    % clipLimit: tra 0 e 1. Valori elevati --> maggior contrasto
    imer2 = adapthisteq(newim2, 'clipLimit', 0.001, 'NumTiles', [2 2], 'Distribution', 'exponential');
    imer = imgaussfilt(imer2, 2);
    if grigi_sommati > 2700000 && max(conto_grigi) > 100000
        imer = adjgamma(imer, 2);
        imer = imadjust(imer, [mean2(newim) 0.85], []);
    end

    % directory di salvataggio
    saving_dir = fullfile(directory, '//');
    if ~exist(saving_dir, 'dir')
        mkdir(saving_dir)
        disp('New directory created')
    end
    filename = fullfile(saving_dir, listdir(i).name);
    imwrite(imer, filename);
    disp('Saved Successfully')
end

%%
% Definisci il nome dell'immagine da processare
image_name = ''; % Nome dell'immagine che desideri processare

% Controlla se l'immagine esiste
image_path = fullfile(folder_path, image_name);
if ~exist(image_path, 'file')
    error('L''immagine %s non esiste nella directory: %s', image_name, folder_path);
end

% Imposta la directory di output per l'immagine processata
output_directory = fullfile(folder_path, '/fixed_img/'); % Cartella per salvare l'immagine processata
if ~exist(output_directory, 'dir')
    mkdir(output_directory); % Crea la cartella se non esiste
    disp(['Creata la cartella: ', output_directory]);
end

% Leggi e preprocessa l'immagine
disp(['Processing: ', image_name]);
im=imread(image_name);
%im = imcomplement(imread(image_path)); % Applica la complementarità all'immagine
im = im2gray(im); % Carica l'immagine e la converte in scala di grigi
im = mat2gray(im); % Normalizza l'immagine
medie_totali = mean2(im);

% Applica la rimozione effetto nebbia
im = imreducehaze(im, medie_totali, 'method', 'approx');

% Mantieni le dimensioni originali
im_resized = im;

% Analizza l'istogramma
[counts, hist] = imhist(im_resized);
conto_grigi = counts;
istogrammi = hist;
livelli_medi = find(istogrammi > 0.15 & istogrammi < 0.3);
grigi_medi = conto_grigi(livelli_medi);
grigi_sommati = sum(grigi_medi);

% Applica filtraggi in base alle proprietà
media_resize = mean2(im_resized);

if media_resize < 0.25
    media_resize = 1.5; % Valore arbitrario da regolare
end

newim = adjgamma(im_resized, media_resize); % Correzione gamma salvare immagine
newim2 = adjcontrast(newim, 5, mean2(newim)); % Correzione sigmoide

% Correzione con CLAHE
imer2 = adapthisteq(newim2, 'clipLimit', 0.001, 'NumTiles', [2, 2], 'Distribution', 'exponential');

% Filtraggio Gaussiano
imer = imgaussfilt(imer2, 2);

% Ulteriore regolazione per immagini scure
if grigi_sommati > 2700000 && max(conto_grigi) > 100000
    imer = adjgamma(imer, 2);
    imer = imadjust(imer, [mean2(newim), 0.85], []);
end

% Salva l'immagine processata
output_filename = fullfile(output_directory, image_name);
imwrite(imer, output_filename);
disp(['Immagine salvata con successo: ', output_filename]);