#### Reto QA Back SauceDemo con Karate DSL
Descripción:
	- Este repositorio contiene un conjunto de pruebas automatizadas de Backend desarrolladas con Karate DSL para validar la API (https://serverest.dev/). Las pruebas cubren funcionalidades clave como la gestión de usuarios, productos y carritos de compra, incluyendo flujos de autenticación, listado, creación, edición, y eliminación.

Para configurar y ejecutar este proyecto en tu máquina, necesitas tener instalados los siguientes componentes:
	1. JDK 8 o superior: Karate DSL se ejecuta sobre la JVM. Puedes descargarlo desde el sitio oficial de Oracle o usar una distribución OpenJDK.
	2. Apache Maven: Se usa para gestionar las dependencias y ejecutar las pruebas. Descárgalo de la página oficial de Maven.


Operaciones de ejecución y depuración:
	1. Si usas un IDE como IntelliJ IDEA o VS Code (con la extensión de Java Pack), ábrelo y carga el proyecto Maven. El IDE debería reconocer automáticamente el proyecto y sus      dependencias.
	2. Para ejecutar las pruebas, navega a la raíz del proyecto en tu terminal y usa el siguiente comando de Maven: mvn clean test
	3. Después de la ejecución, los informes HTML se generarán en la carpeta target/karate-reports. Abre el archivo karate-summary.html en tu navegador para ver un resumen detallado de los resultados.

Informe QA:
    1. El informe solicitado se encuentra en esta misma raíz con el nombre "informe_reto_qa_back.pdf"