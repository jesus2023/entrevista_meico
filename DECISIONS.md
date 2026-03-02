# DECISIONS.md

## 1. Estructura de la solución

- **Modelo Payment**: valida pagos y guarda su estado (approved, rejected).  
- **Controlador API /payments**: recibe los datos del pago y llama al `PaymentProcessor`.  
- **Service PaymentProcessor**: decide el proveedor según `payment_type`, aplica comisión, maneja errores y guarda el pago.  
- **Proveedores simulados** (`app/services/payments/providers`):
  - `FastPayProvider`: tarjeta de crédito, comisión 3%.  
  - `BankioProvider`: transferencia bancaria, comisión fija $2.50.  
- **Tests (RSpec)**:  
  - `spec/services/payment_processor_spec.rb`: tests de la lógica central del processor. Es como el contrato  
  - `spec/services/providers/fast_pay_provider_spec.rb`: tests de simulación del proveedor pago de tarjeta.  
  - `spec/services/providers/bankio_provider_spec.rb`: tests de simulación del proveedor Bankio o pago con monto.
- **Dockerfile + docker-compose.yml**: levantan la API y PostgreSQL en contenedores.

---

## 2. Extensibilidad

- Cada proveedor tiene su clase separada. Para mantener la segregación y principios de unica funcionalidad.
- `ProviderFactory` construye el proveedor según `payment_type`.  
- La respuesta siempre se estandariza (`id`, `status`, `amount_charged`, `provider_reference`) eso signfica que se cumple el json mostrado en la prueba.  
- Agregar un nuevo proveedor solo requiere crear su clase y registrarlo en la factory, lo que lo hace flexible.  
- Cada clase tiene una única responsabilidad, por lo que cumple los principios SOLID.

---

## 3. Cómo ejecutar

### Con Docker

```bash
docker compose build
docker compose up

API disponible en http://localhost:3000.

Probar endpoint

Tarjeta de crédito:

curl -X POST http://localhost:3000/api/v1/payments \
  -H "Content-Type: application/json" \
  -d '{
        "amount": 1000,
        "currency": "USD",
        "payment_type": "credit_card",
        "details": {"card_number": "4111111111111111"}
      }'

Transferencia bancaria:

curl -X POST http://localhost:3000/api/v1/payments \
  -H "Content-Type: application/json" \
  -d '{
        "amount": 1000,
        "currency": "USD",
        "payment_type": "bank_transfer",
        "details": {"account_number": "999999"}
      }'

Nota: Tambien se pueden probar en postman usando el post y colocando en JSON.

Ejecutar tests

Local:

bundle exec rspec

Docker:

docker compose exec web bundle exec rspec

