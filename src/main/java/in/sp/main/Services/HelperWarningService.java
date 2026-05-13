package in.sp.main.Services;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.stereotype.Service;

import in.sp.main.Entities.Helper;
import in.sp.main.Entities.HelperReport;
import in.sp.main.Entities.HelperWarning;
import in.sp.main.Repositories.HelperWarningRepository;

@Service
public class HelperWarningService {

    private final HelperWarningRepository repo;

    public HelperWarningService(HelperWarningRepository repo) {
        this.repo = repo;
    }

    public void sendWarning(Helper helper, HelperReport report, String message) {

        HelperWarning w = new HelperWarning();
        w.setHelper(helper);
        w.setReport(report);
        w.setMessage(message);
        w.setSentAt(LocalDateTime.now());

        repo.save(w);
    }


    public long warningCount(Long helperId) {
        return repo.countByHelper_Id(helperId);
    }

    public List<HelperWarning> helperWarnings(Long helperId) {
        return repo.findByHelper_Id(helperId);
    }
    
 // ✅ ADD THESE
    public HelperWarning getById(Long id) {
        return repo.findById(id).orElse(null);
    }

    public void save(HelperWarning warning) {
        repo.save(warning);
    }
    
    public List<HelperWarning> reportWarnings(Long reportId) {
        return repo.findByReport_Id(reportId);
    }

}

