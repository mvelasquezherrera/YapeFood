# YapeFood

Reto para Yape

# Ambientes

Por ser un proyecto demo y sin ambientes, no vi necesario crear schemes para ambiente dev, uat y prod.

# Patrón de arquitectura

Se utilizó el patrón MVC debido a la poca complejidad y dimensión del proyecto. Para proyectos más robustos se hubiera usado VIPER, y escenarios en el que se necesite la data cuando ha sufrido cambios se puede aplicar MVVM.

# Dependencias

Para este caso utilicé SPM debido a que al ser nativo tiene mayor ventaja al descargarlo e implementarlo de forma más rápida. Solo instalé SDWebImage para la descarga de imágenes en línea. En cuánto a los servicios, al solo ser un endpoint no vi necesario integrar Alamofire, solo usé URLSession que es la base por la cuál se creó Alamofire.
