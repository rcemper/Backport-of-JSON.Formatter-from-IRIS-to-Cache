# Backport-of-JSON.Formatter-from-IRIS-to-Cache
Have in Caché same formatting available as in IRIS  

IRIS brought us an excellent %JSON.Formatter class. 
This backport makes it available also in Caché.   

### content ###  
2 elements: %ZJSON.Formatter.cls + %ZPVA.inc  
Packed into %ZJSON.XML for installation from Studio.  

### examples ###  
~~~
USER>read jsn
{"Name":"Cunningham,John C.","SSN":"294-11-9150","DOB":"1933-01-08","Home":{"Street":"4249 Ash Street","City":"Tampa","State":"MD","Zip":"30176"},"FavoriteColors":["White","Red","Green"]}
USER>
~~~~  
##### straight to device #####   
~~~
USER>do ##class(%ZJSON.Formatter).%New().Format(jsn)
{
  "Name":"Cunningham,John C.",
  "SSN":"294-11-9150",
  "DOB":"1933-01-08",
  "Home":{
    "Street":"4249 Ash Street",
    "City":"Tampa",
    "State":"MD",
    "Zip":"30176"
  },
  "FavoriteColors":[
    "White",
    "Red",
    "Green"
  ]
}
USER>
~~~

##### to string #####   
~~~
USER>do ##class(%ZJSON.Formatter).%New().FormatToString(jsn,.out)
USER>write out
{
  "Name":"Cunningham,John C.",
  "SSN":"294-11-9150",
  "DOB":"1933-01-08",
  "Home":{
    "Street":"4249 Ash Street",
    "City":"Tampa",
    "State":"MD",
    "Zip":"30176"
  },
  "FavoriteColors":[
    "White",
    "Red",
    "Green"
  ]
}
USER>
~~~

##### to stream #####   
~~~
USER>do ##class(%ZJSON.Formatter).%New().FormatToStream(jsn,.stream)
USER>do stream.OutputToDevice()
{
  "Name":"Cunningham,John C.",
  "SSN":"294-11-9150",
  "DOB":"1933-01-08",
  "Home":{
    "Street":"4249 Ash Street",
    "City":"Tampa",
    "State":"MD",
    "Zip":"30176"
  },
  "FavoriteColors":[
    "White",
    "Red",
    "Green"
  ]
}
USER>
~~~

### note ###
This works of course also in IRIS.

