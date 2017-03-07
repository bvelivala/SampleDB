package org.cdsdemo.dbdeployment.connection;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

public class MyServlet implements ServletContextListener {
	private ServletContext context = null;

    @Override
    public void contextDestroyed(ServletContextEvent event) {
        log("Context destroyed");
        this.context = null;
    }

    @Override
    public void contextInitialized(ServletContextEvent event) {
        this.context = event.getServletContext();
        log("Context initialized");
		
		DBDeployManager dbMgr = new DBDeployManager();
		log("Initialized DBDeployManager to execute sql script");
		dbMgr.runSqlScript();
    }

    private void log(String message) {
        if (context != null) {
            context.log("MyServlet ContextListener: " + message);
        } else {
            System.out.println("MyServlet ContextListener: " + message);
        }
    }
}
