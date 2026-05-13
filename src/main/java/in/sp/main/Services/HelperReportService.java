package in.sp.main.Services;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.stereotype.Service;

import in.sp.main.Entities.HelperReport;
import in.sp.main.Repositories.HelperReportRepository;

@Service
public class HelperReportService {

    private final HelperReportRepository repo;

    public HelperReportService(HelperReportRepository repo) {
        this.repo = repo;
    }

    public void report(HelperReport report) {
    	report.setCreatedAt(LocalDateTime.now());
        repo.save(report);
    }

    public List<HelperReport> getReports(Long helperId) {
        return repo.findByHelper_Id(helperId);
    }

    public long countReports(Long helperId) {
        return repo.countByHelper_Id(helperId);
    }
    
    public HelperReport getById(Long id) {
        return repo.findById(id).orElse(null);
    }
}
