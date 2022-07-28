import java.io.*;
import java.util.ArrayList;

public class ArrayReader {
    private String filePath;
    private int[] intArray;
    private String[] strArray;

    public ArrayReader(String filePath) throws IOException {
        this.filePath = filePath;
        ArrayList<Integer> array = new ArrayList();
        BufferedReader br = new BufferedReader(new FileReader(filePath));
        String line = br.readLine();

        while (line != null) {
            array.add(Integer.parseInt(line));
            line = br.readLine();
        }
        br.close();
        int length = array.size();
        intArray = new int[length];
        strArray = new String[length];
        int j = 0;
        for (int i = 0; i < length; i++) {
            intArray[i] = array.get(i);
            strArray[i] = String.valueOf(array.get(i)).substring(0,6);
        }
    }

    public void printStats(){
        System.out.println("length of input integer array: "+ intArray.length);
    }

    public String getFilePath() {
        return filePath;
    }

    public int[] getArray() {
        return intArray;
    }

    public void saveNewArray() throws IOException {
        System.out.println("Saving array...");
        FileWriter out = new FileWriter(new File(filePath));
        int length = strArray.length;

        for (int i = 0; i < length; i++) {
            out.write(strArray[i] + "\n");
        }
        out.close();
        System.out.println("Sorted array saved");
    }
}
