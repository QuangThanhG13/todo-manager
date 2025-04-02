# Todo Manager - Spring MVC Web Application

A feature-rich Todo Management Application built with Spring MVC that allows users to create, manage, and organize their tasks with an intuitive user interface.

## Features

- User authentication with Spring Security
- Create, read, update, and delete todo items
- Toggle completion status with interactive switches
- Form validation for todo creation/editing
- Date picker for setting task deadlines
- Responsive design with Bootstrap

## Tech Stack

- **Backend**: Spring MVC, Spring Security
- **Frontend**: JSP, JSTL, Bootstrap 3
- **Validation**: Hibernate Validator
- **Build Tool**: Maven

## Prerequisites

To run this application, you need:

- JDK 8 or higher
- Maven 3.x
- A servlet container like Apache Tomcat

## Getting Started

### Clone the Repository

```bash
git clone https://github.com/yourusername/todo-manager.git
cd todo-manager
```

### Build the Application

```bash
mvn clean install
```

This creates a WAR file in the `target` directory.

### Run the Application

#### Using Maven

```bash
mvn tomcat7:run
```

The application will start on port 8080 by default. Access it at [http://localhost:8080](http://localhost:8080)

#### Deploy to Tomcat
<img width="357" alt="image" src="https://github.com/user-attachments/assets/a3147de7-5790-4bb4-9e53-5b7ddf732925" />


Copy the generated WAR file from the `target` directory to Tomcat's `webapps` directory.

### Login Credentials

The application uses in-memory authentication:

- Username: qthanh
- Password: 06092004

## Project Structure

```
src/
├── main/
│   ├── java/
│   │   └── com/
│   │       └── qthanh/
│   │           ├── common/
│   │           │   └── ExceptionController.java
│   │           ├── login/
│   │           │   └── LoginController.java
│   │           ├── model/
│   │           │   └── Todo.java
│   │           ├── security/
│   │           │   └── SecurityConfiguration.java
│   │           ├── todo/
│   │           │   ├── TodoController.java
│   │           │   └── service/
│   │           │       └── TodoService.java
│   │           └── welcome/
│   │               └── WelcomeController.java
│   ├── resources/
│   │   ├── messages_en.properties
│   │   ├── messages_fr.properties
│   │   └── static/
│   │       └── css/
│   │           └── main.css
│   └── webapp/
│       └── WEB-INF/
│           ├── todo-servlet.xml
│           ├── web.xml
│           └── views/
│               ├── common/
│               │   ├── footer.jspf
│               │   ├── header.jspf
│               │   └── navigation.jspf
│               ├── error.jsp
│               ├── list-todos.jsp
│               ├── login.jsp
│               ├── todo.jsp
│               └── welcome.jsp
```

## How to Use

1. Log in with the provided credentials
2. The welcome page displays a greeting and options to view todos
3. Navigate to "Todos" in the navigation bar to see your todo list
4. Add new todos using the "Add New Todo" button
5. Edit or delete existing todos using the respective action buttons
6. Toggle completion status using the switch control

## Contributing

Contributions are welcome! Here's how you can contribute:

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## Future Enhancements

- User registration functionality
- Persistent database storage
- Email notifications for upcoming deadlines
- Task categories and filtering options
- Mobile application using RESTful API

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgements

- [Spring Framework](https://spring.io/)
- [Bootstrap](https://getbootstrap.com/)
- [jQuery](https://jquery.com/)
- [Bootstrap Datepicker](https://bootstrap-datepicker.readthedocs.io/)
