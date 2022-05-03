from librerias import pyodbc, pd, exception
from querys import productos
server = 'DESKTOP-TS5PPCK' 
database = 'BDVentas' 
df = pd.read_csv("https://datasets.datos.mincyt.gob.ar/dataset/06ae9728-c376-47bd-9c41-fbdca68707c6/resource/8ab77b16-f1a8-4d3f-b664-67becf83a9b9/download/personas.csv", sep=";")
conn_dbventas = pyodbc.connect('driver={SQL SERVER};server='+server+';database='+database+';trusted_connections=YES')

#Añadimos la columna cod_cliente al dataframe para insertar los datos de COD_ID de la tabla clientes de la base de datos
df = df.assign(cod_cliente='')

#Filtramos por género 
df.loc[df["sexo_id"] == 1, "sexo_id"] = "M" 
df.loc[df["sexo_id"] == 2, "sexo_id"] = "H"

#reacomodamos las columnas del df clientes
df_clientes = df['cod_cliente','nombre','apellido','provincia', 'sexo_id', 'edad', 'edad', 'provincia']

#Borramos duplicados en caso que existan 
df_clientes = df.drop_duplicates(subset=['cod_cliente','nombre','apellido','provincia', 'sexo_id', 'edad', 'edad'])

try: 
    cursor = conn_dbventas.cursor()
    query = cursor.execute(productos)
    data = cursor.fetchall()
    df_productos = pd.read_sql(data, conn_dbventas)
    cursor.close()
except exception as e:
        print(f"Error: '{e}'")
