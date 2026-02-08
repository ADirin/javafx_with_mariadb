import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;

public class TemperatureUtilTest {

    @Test
    void testCelsiusToFahrenheit() {
        double result = TemperatureUtil.celsiusToFahrenheit(0);
        assertEquals(32.0, result);
    }

    @Test
    void testNegativeTemperature() {
        double result = TemperatureUtil.celsiusToFahrenheit(-40);
        assertEquals(-40.0, result);
    }

    @Test
    void testDecimalTemperature() {
        double result = TemperatureUtil.celsiusToFahrenheit(36.6);
        assertEquals(97.88, result, 0.01);
    }
}
