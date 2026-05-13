package in.sp.main.Repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import in.sp.main.Entities.HelperReport;

public interface HelperReportRepository
extends JpaRepository<HelperReport, Long> {

List<HelperReport> findByHelper_Id(Long helperId);

long countByHelper_Id(Long helperId);
}
