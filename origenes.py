from librerias import pyodbc, pd, exception
from querys import productos
server = 'DESKTOP-TS5PPCK' 
database = 'BDVentas' 
df = pd.read_csv("C:\\Users\\SID\\Downloads\\clientes.csv", sep=";")
df_clientes = df.drop_duplicates(subset=['codigo','nombre','apellido','localidad'])
try: 
    conn_dbventas = pyodbc.connect('driver={SQL SERVER};server='+server+';database='+database+';trusted_connections=YES')
    cursor = conn_dbventas.cursor()
    query = cursor.execute(productos)
    data = cursor.fetchall()
    df_productos = pd.read_sql(data, conn_dbventas)
    cursor.close()
except exception as e:
        print(f"Error: '{e}'")




