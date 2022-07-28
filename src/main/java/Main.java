import org.jpl7.Atom;
import org.jpl7.Query;
import org.jpl7.Term;
import org.jpl7.Variable;

import java.io.IOException;
import java.util.Map;

public class Main {

    public static void main(String[] args) throws IOException {
        ArrayReader ar = new ArrayReader("./Prolog/rand.txt");
        ar.saveNewArray();
    }
}
