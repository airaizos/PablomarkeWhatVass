# WhatVass Forked

Fork del repostorio WhatVass del usuario [Pablomarke](https://github.com/Pablomarke), con el objetivo de refactorizar el proyecto.

El repositorio original está hecho en UIKit con arquitectura **VIPER** y el modelo de asincronía y concurrencia Combine, y utiliza las librerías Firebase, UserNotifications, [IQKeyboardManagerSwift](https://github.com/Kilograpp/IQkeyboardManager), [KeychainSwift](https://github.com/evgenyneu/keychain-swift) y Alamofire. El proyecto es una prueba de concepto de una app de mensajería. Tiene un Login con usuario y contraseña, una registro de nuevos usuarios y apartados de mensajes y contactos.

### El refactor consiste en lo siguiente:
* Añadir Test unitarios y de integración para asegurar que el refactor no afectaba en funcionalidad.
* Sustitición de las librerías de terceros por código nativo en Swift. Comenzando por sustuir Alamofire por URLSession-
* Sustitución gradual de vistas de UIKit por vistas hechas SwiftUI. Comenzando por las celdas de las tableview y posteriormente ViewController por UIHostingController.
* Cambiar los endpoints del servidor de pruebas original por endpoints en Mocky.io
* Sustituir Combine por métodos Async Await
* Sustituir AppDelegate (UIKit) por App (SwiftUI). 
* Cambiar los endpoints en Mocky.io por endpoints en de un proyecto en Vapor (no publicado)
