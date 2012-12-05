import edu.rit.pj.Comm;
import edu.rit.pj.ParallelRegion;
import edu.rit.pj.ParallelTeam;
import java.net.InetAddress;

public class Cluster { 
	
	static 	Comm world;
	static 	long []x;
	static 	int size;
	static 	long t1, t2, t3;
	static 	int rank;
	static int splitArgs;
	
	private Cluster() {
	}
	public static void main(String[] args) throws Exception {
		String hostname = InetAddress.getLocalHost().getHostName();
		t1 = System.currentTimeMillis();
		Comm.init(args);
		world = Comm.world();
		size = world.size();
		//dividir el numero de argumentos de acuerdo a la cantidad de nodos
		splitArgs = (int)Math.ceil((double) ( (double)(args.length) / (double)(size)));
		rank = world.rank();
		x = new long [splitArgs];
		for(int i =0; i < splitArgs; i++){
			try{
			x[i] = Long.parseLong (args[rank*splitArgs+i]);			
			}catch(Exception e){
			x[i] = 1;
			}
		}		
		t2 = System.currentTimeMillis();
		boolean[] result = smpProgram(x);
		for(int i = 0 ; i < result.length ; i++){
			String not = "not";
			if (result[i]) not = "";
			System.out.println("[" + hostname + "] " + x[i] + " is " + not + " prime");
			t3 = System.currentTimeMillis();
			System.out.println("rank = " + rank + " call start = " + (t2 - t1) + " msec");
			System.out.println("rank = " + rank + " call finish = " + (t3 - t1) + " msec");
		}
		
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
	static int n, processLength, cores;
	static long[] xvalues;
	static boolean[] respuesta;
	static long time1, time2[], time3[];
	private static boolean[] smpProgram(long[] args) throws Exception{
		
		time1 = System.currentTimeMillis();
		n = args.length;
		cores = Runtime.getRuntime().availableProcessors();
		processLength = (int)Math.ceil((double) ( (double)(n) / (double)(cores)));
		xvalues = new long [n];
		respuesta = new boolean [n];
		for (int i = 0; i < n; ++ i)
		{
			xvalues[i] = args[i];
		}
		time2 = new long [n];
		time3 = new long [n];
		new ParallelTeam().execute (new ParallelRegion()
		{
			public void run()
			{
				for(int k = 0; k < processLength; k++ ){
					int i = processLength*getThreadIndex()+k;
					if(i < n){
					time2[i] = System.currentTimeMillis();
					respuesta[i] = isPrime (xvalues[i]);				
					time3[i] = System.currentTimeMillis();
					System.out.println
					("i = "+i+" call start = "+(time2[i]-time1)+" msec, core "+getThreadIndex());
					System.out.println
					("i = "+i+" call finish = "+(time3[i]-time1)+" msec, core "+getThreadIndex());				

					}
				}			
				
			}
		});
		return respuesta;
	}
}

