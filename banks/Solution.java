import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class Solution {

    public static void main(String[] args) throws IOException {
	BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        String s = br.readLine();
        String[] q = s.split(" ", 2);
        int n = Integer.parseInt(q[0]);
        int d = Integer.parseInt(q[1]);
        int i, money, b1 = -1, b2 = -1, prevoffset = 0, nowmoney = 0;
        int index[] = new int[n];
        int bestindex[] = new int[n];
        int bestmoney[] = new int[n];
        for (i = 0; i < n; ++i) {
		s = br.readLine();
		q = s.split(" ", 2);
		index[i] = Integer.parseInt(q[0]);
		money = Integer.parseInt(q[1]);
		
		if ((i == 0) || (money > bestmoney[i - 1])) {
			bestindex[i] = i;
			bestmoney[i] = money;
		} else {
			bestindex[i] = bestindex[i - 1];
			bestmoney[i] = bestmoney[i - 1];
		}
		
		while ((i != prevoffset) && (index[i] >= index[prevoffset + 1] + d))
			++prevoffset;

		if ((bestmoney[prevoffset] + money > nowmoney) && (index[i] >= index[prevoffset] + d)) {
			b1 = bestindex[prevoffset] + 1;
			b2 = i + 1;
			nowmoney = bestmoney[prevoffset] + money;
		}
        }
        System.out.println(b1 + " " + b2);
    }
}
 
