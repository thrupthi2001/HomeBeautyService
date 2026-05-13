package in.sp.main.Entities;

import java.time.LocalDateTime;
import jakarta.persistence.*;

@Entity
@Table(name = "helper_warnings")
public class HelperWarning {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    private Helper helper;

    @Column(length = 500)
    private String message;

    private String helperReply;

    private LocalDateTime sentAt;
    
    @ManyToOne
    @JoinColumn(name = "report_id")
    private HelperReport report;

	public HelperReport getReport() {
		return report;
	}

	public void setReport(HelperReport report) {
		this.report = report;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Helper getHelper() {
		return helper;
	}

	public void setHelper(Helper helper) {
		this.helper = helper;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getHelperReply() {
		return helperReply;
	}

	public void setHelperReply(String helperReply) {
		this.helperReply = helperReply;
	}

	public LocalDateTime getSentAt() {
		return sentAt;
	}

	public void setSentAt(LocalDateTime sentAt) {
		this.sentAt = sentAt;
	}

    // getters & setters
}
