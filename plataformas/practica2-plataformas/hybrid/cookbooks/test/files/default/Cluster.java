import edu.rit.pj.Comm;
import java.net.InetAddress;

public class Cluster { 
	
	static 	Comm world;
	static 	long x;
	static 	int size;
	static 	long t1, t2, t3;
	static 	int rank;
	
	private Cluster() {
	}
	public static void main(String[] args) throws Exception {
		String hostname = InetAddress.getLocalHost().getHostName();
		t1 = System.currentTimeMillis();
		Comm.init(args);
		world = Comm.world();
		size = world.size();
		rank = world.rank();
		x = Long.parseLong(args[rank]);
		t2 = System.currentTimeMillis();
		boolean result = isPrime(x);
		String not = "not";
		if (result) not = "";
		System.out.println("[" + hostname + "] " + x + " is " + not + " prime");
		t3 = System.currentTimeMillis();
		System.out.println("rank = " + rank + " call start = " + (t2 - t1) + " msec");
		System.out.println("rank = " + rank + " call finish = " + (t3 - t1) + " msec");
	}
	private static boolean isPrime(long x) {
		if (x % 2 == 0) return false;
		long p = 3;
		long psqr = p*p;
		while (psqr <= x) {
			if (x % p == 0) return false;
			p += 2;
			psqr = p * p;
		}
		return true;
	}
}
