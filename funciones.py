from querys import * 
from db import * 
from origenes import df_clientes, df_productos
from librerias import *

def cargarTablas(lista_tablas, conn):
    try: 
        cursor = connDW.cursor()
        for tabla in lista_tablas:
            cursor.execute(tabla)
        cursor.commit()
        cursor.close()
    except exception as e:
        print(f"Error: '{e}'")


def insertarClientes(df, conn):
    try:
        cursor = connDW.cursor()
        cursor.execute("TRUNCATE TABLE D_Clientes")
        for i, row in df_clientes.iterrows():
            cursor.execute(insert_Clientes, row.codigo, row.nombre, row.apellido, row.localidad)
        connDW.commit()
        cursor.close()                       
    except exception as e: 
        print(f"Error: '{e}'")


def insertarSucursal(query, conn):
    try:
        cursor = connDW.cursor()
        cursor.execute("TRUNCATE TABLE D_Sucursales")
        cursor.execute(insert_sucursal)
        cursor.commit()
        cursor.close()
    except exception as e:
        print(f"Error: '{e}'")

    

def insertarProductos(df, conn, query):
    try:
        cursor = connDW.cursor()
        cursor.execute("TRUNCATE TABLE D_Productos")
        for i,row in df_productos.iterrows():
            cursor.execute(insert_productos, row.COD_PROD, row.NOM_PROD, row.MARCA)
        cursor.commit()
        cursor.close()
    except exception as e:
        print(f"Error: '{e}'")

#Carga el script que llena la Dim tiempo y la F ventas    
def cargarScript(conn):
    cursor = connDW.cursor()
    try:
        for archivo in os.listdir():
            if archivo.endswith('.sql'):
                fd = open(archivo, 'r')
                sqlFile = fd.read()
                fd.close()
                sqlCommands = sqlFile.split(';')
                for command in sqlCommands:
                    try:
                        cursor.execute(command)
                    except OperationalError, msg:
                        print("Error: ", msg)
        cursor.commit()
        cursor.close()
    except exception as e:
        print(e)



