package JavaBean;
public class Functions {
    static public String toHtml(String data) {
	    data = data.replace(" ","&nbsp");
		data = data.replace("\n","<br />");
		return data;
	}
}
