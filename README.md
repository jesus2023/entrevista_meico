# Payment Routing API

Este proyecto implementa una API REST en Ruby on Rails que simula un sistema de enrutamiento de pagos entre distintos proveedores externos.

Actualmente el sistema permite:

- Procesar pagos con tarjeta de crédito
- Procesar pagos por transferencia bancaria
- Aplicar comisiones según el proveedor
- Estandarizar la respuesta sin importar el proveedor utilizado

El diseño está pensado para permitir agregar nuevos proveedores sin modificar la lógica principal del sistema.

---

## Cómo ejecutar el proyecto

### Con Docker (recomendado)

```bash
docker compose build
docker compose up