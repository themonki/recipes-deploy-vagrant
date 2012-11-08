public class Program1seq
{
	static int n;
	static long[] x;
	static long t1, t2[], t3[];
	public static void main
	(String[] args)
	throws Exception
	{
		t1 = System.currentTimeMillis();
		n = args.length;
		x = new long [n];
		for (int i = 0; i < n; ++ i)
		{
			x[i] = Long.parseLong (args[i]);
		}
		t2 = new long [n];
		t3 = new long [n];
		for (int i = 0; i < n; ++ i)
		{
			t2[i] = System.currentTimeMillis();
			isPrime (x[i]);
			t3[i] = System.currentTimeMillis();
		}
		for (int i = 0; i < n; ++ i)
		{
			System.out.println
			("i = "+i+" call start = "+(t2[i]-t1)+" msec");
			System.out.println
			("i = "+i+" call finish = "+(t3[i]-t1)+" msec");
		}
	}
	private static boolean isPrime
	(long x)
	{
		if (x % 2 == 0) return false;
		long p = 3;
		long psqr = p*p;
		while (psqr <= x)
		{
			if (x % p == 0) return false;
			p += 2;
			psqr = p*p;
		}
		return true;
	}
}

