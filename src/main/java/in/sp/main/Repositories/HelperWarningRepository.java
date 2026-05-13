package in.sp.main.Repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import in.sp.main.Entities.HelperWarning;

public interface HelperWarningRepository
extends JpaRepository<HelperWarning, Long> {

List<HelperWarning> findByHelper_Id(Long helperId);

long countByHelper_Id(Long helperId);

List<HelperWarning> findByReport_Id(Long reportId);

}