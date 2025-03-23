# KPAC Configuration

## Setup Instructions

To quickly set up MySQL 5.7 using Docker, run the following command:
```sh
docker run -d --name mysql-container -e MYSQL_ROOT_PASSWORD=rootpassword -e MYSQL_DATABASE=kpacdb -e MYSQL_USER=kpacuser -e MYSQL_PASSWORD=kpacpass -p 3306:3306 mysql:5.7
```
Alternatively, you can configure a database manually according to your preference.

> **Note:** Before launching the application, ensure the database connection is properly configured using one of the following methods:

### Linux
1. Open `~/.bashrc` in a text editor:
   ```sh
   nano ~/.bashrc
   ```
2. Add the following lines at the end of the file:
   ```sh
   export KPAC_DB_URL="jdbc:mysql://localhost:3306/kpacdb?useSSL=false"
   export KPAC_DB_USERNAME="kpacuser"
   export KPAC_DB_PASSWORD="kpacpass"
   ```
3. Apply the changes:
   ```sh
   source ~/.bashrc
   ```

### Windows
1. Open Command Prompt (`Win + R`, type `cmd`, press Enter).
2. Execute the following commands:
   ```cmd
   setx KPAC_DB_URL "jdbc:mysql://localhost:3306/kpacdb?useSSL=false"
   setx KPAC_DB_USERNAME "kpacuser"
   setx KPAC_DB_PASSWORD "kpacpass"
   ```

### macOS
1. Open `~/.bash_profile` (for Bash) or `~/.zshrc` (for Zsh) in a text editor:
   ```sh
   nano ~/.bash_profile  # For Bash
   nano ~/.zshrc         # For Zsh (default shell on macOS)
   ```
2. Add the following lines at the end of the file:
   ```sh
   export KPAC_DB_URL="jdbc:mysql://localhost:3306/kpacdb?useSSL=false"
   export KPAC_DB_USERNAME="kpacuser"
   export KPAC_DB_PASSWORD="kpacpass"
   ```
3. Apply the changes:
   ```sh
   source ~/.bash_profile  # For Bash
   source ~/.zshrc         # For Zsh
   ```

### Apache Tomcat
1. Open the `conf/context.xml` file in your Tomcat installation directory.
2. Add the following configuration inside the `<Context>` element:
   ```xml
   <Context>
       <Environment name="KPAC_DB_URL" value="jdbc:mysql://localhost:3306/kpacdb?useSSL=false" type="java.lang.String"/>
       <Environment name="KPAC_DB_USERNAME" value="kpacuser" type="java.lang.String"/>
       <Environment name="KPAC_DB_PASSWORD" value="kpacpass" type="java.lang.String"/>
   </Context>
   ```
3. Restart Tomcat for the changes to take effect.

---
### Database Schema & Data Initialization
No manual schema or data setup is required. The application will automatically create the necessary tables and populate them with initial data if they do not already exist.

Now your KPAC application is ready to connect to the database with the provided credentials!

Now you can start from
http://localhost:8080/kpac-app/

or check following paths:
 - kpac-app/
 - kpac-app/kpacs
 - kpac-app/sets
 - kpac-app/sets/{id}