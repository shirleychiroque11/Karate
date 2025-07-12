package examples.runner;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;

import net.masterthought.cucumber.ReportBuilder;

import static org.junit.jupiter.api.Assertions.*;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import org.junit.jupiter.api.Test;
import java.io.File;
import net.masterthought.cucumber.Configuration;
import org.apache.commons.io.FileUtils;

class TestRunner {

    @Test
    void testParallel() {
        Results results = Runner.path("classpath:examples/users")
                .outputJunitXml(true)
                .outputCucumberJson(true)
                .parallel(1);
        generateReport(results.getReportDir());
        // Generar cucumber.json combinado
        examples.util.Cucumber cucumberUtil = new examples.util.Cucumber();
        cucumberUtil.output(results.getReportDir());
        assertTrue(results.getFailCount() == 0, results.getErrorMessages());
        /* assertEquals(0, results.getFailCount(), results.getErrorMessages()); */
    }

    public static void generateReport(String karateOutputPath) {
        Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[] { "json" }, true);
        List<String> jsonPaths = new ArrayList<>(jsonFiles.size());
        jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
        Configuration config = new Configuration(new File("target"), "runner");
        ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
        reportBuilder.generateReports();
    }

}
