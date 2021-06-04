clear all
clc


SQIDnum = 3367; %select sq id
k=1;
filelist = dir('DatasetTest\*.txt');

for f = 1 : size(filelist,1)
    
    opts = detectImportOptions(['DatasetTest\' filelist(f).name]); 
    opts.VariableNames = {'Square_Id','Time_Interval','Country_Code','SMSin'...
    'SMSout','Callin','Callout','InternetTraffic'};
     T = readtable(['DatasetTest\' filelist(f).name],opts); 
     
     T_first=table2array(T);
     
     Square_Id=T_first(:,1);
     Time_Interval=T_first(:,2);
     Country_Code=T_first(:,3);
     SMSin=T_first(:,4);
     SMSout=T_first(:,5);
     Callin=T_first(:,6);
     Callout=T_first(:,7);
     InternetTraffic=T_first(:,8);
     
    f
    
    for i = 1 : size(Square_Id,1)
        if ( Square_Id(i,1) == SQIDnum )
            sqid_a(k,1) = Square_Id(i,1);
            timestamp_a(k,1) = Time_Interval(i,1);
            countrycode_a(k,1) = Country_Code(i,1);
            smsin_a(k,1) = SMSin(i,1);
            smsout_a(k,1) = SMSout(i,1);
            callin_a(k,1) = Callin(i,1);
            callout_a(k,1) = Callout(i,1);
            internet_a(k,1) = InternetTraffic(i,1);
            k = k + 1;
        end
    end
end

clear sqid timestamp countrycode smsin smsout callin callout internet SQIDnum k filelist f i
save('DataTest\DQID_2', 'sqid_a', 'timestamp_a', 'countrycode_a', 'smsin_a', 'smsout_a', 'callin_a', 'callout_a', 'internet_a');
b=fillmiss(internet_a);