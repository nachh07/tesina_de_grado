from funciones import *

def main():
    try:
        cargarTablas(lista_tablas)
        insertarClientes(df_clientes, connDW)
        insertarProductos(df_productos, connDW)
        insertarSucursal(D_Sucursales, connDW)
        cargarScript(connDW)
    except exception as e:
        print("No se pudo ejecutar el ETL.", e)