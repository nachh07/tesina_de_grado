from librerias import pyodbc
server = 'DESKTOP-TS5PPCK' 
database = 'DW_Ventas' 
connDW = pyodbc.connect('driver={SQL SERVER};server='+server+';database='+database+';trusted_connections=YES')

