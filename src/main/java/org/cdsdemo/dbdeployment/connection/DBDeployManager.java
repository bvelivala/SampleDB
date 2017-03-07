package org.cdsdemo.dbdeployment.connection;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.FileReader;
import java.io.Reader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

import com.ibatis.common.jdbc.ScriptRunner;

public class DBDeployManager {
	public DBDeployManager() {
		
	}
	
	public void runSqlScript() {
		String sqlScriptFilePath = "script.sql";

		try {
			// Create Postgresql Connection
			Class.forName("org.postgresql.Driver");
			System.out.println("Loaded postgresql driver");
			
			Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/postgres", "postgres", "postgres");
			System.out.println("Connection established : "+con);
					
			// Initialize object for ScripRunner
			ScriptRunner sr = new ScriptRunner(con, false, false);
			System.out.println("Initialized script runner object for established connection");
			
			// Give the input file to Reader
			InputStream is = getClass().getResourceAsStream("/script.sql");
			System.out.println("Initialized input stream for script.sql");
			
			Reader reader = new InputStreamReader(is);
			System.out.println("Initialized reader object for input stream");
			
			// Exctute script
			sr.runScript(reader);
			System.out.println("Executed SQL commands of script.sql successfully");
		} catch (Exception e) {
			System.err.println("Failed to Execute" + sqlScriptFilePath+ " The error is " + e.getMessage());
		}
	}
}
