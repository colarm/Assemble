public class Assemble {
    public static void main(String[] args) {
        int[] array = { 3, -6, 27, 101, 50, 0, -20, -21, 19, 6, 4, -10 };
        int size = 12;
        int negsum = 0;
        int pzcount = 0;
        int oddcount = 0;
        boolean overflow = false;

        // Calculate negsum
        for (int i = 0; i < size; ++i) {
            if (array[i] < 0) {
                negsum += array[i];
                if (negsum >= 0) {
                    overflow = true;
                }
            } else {
                ++pzcount;
                if (array[i] % 2 != 0) {
                    ++oddcount;
                }
            }
        }

        System.out.println(negsum);
        System.out.println(pzcount);
        System.out.println(oddcount);
        System.out.println(overflow);
    }
}
