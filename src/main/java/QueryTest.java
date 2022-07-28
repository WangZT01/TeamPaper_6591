import org.jpl7.Atom;
import org.jpl7.Query;
import org.jpl7.Term;
import org.jpl7.Variable;

import java.util.Map;

public class QueryTest {

    public static void main(String[] args) {
        // write your code here
        Query q1 = new Query("consult",
                new Term[] { new Atom("./Prolog/a2fact51.pl")
                });
        System.out.println("consult " + (q1.hasSolution()? "succeeded" : "failed"));

        Variable Id = new Variable("Id");
        Variable Title = new Variable("Title");
        Query q2 =
                new Query(
                        "print_all", new Term[] {Id, Title}
                );

        Map<String, Term> solutions;
        while ( q2.hasMoreSolutions()) {
            solutions = q2.nextSolution();
            System.out.println(solutions.get("Id") + " " + solutions.get("Title"));
        }


    }
}
