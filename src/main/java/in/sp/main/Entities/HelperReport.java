package in.sp.main.Entities;

import java.time.LocalDateTime;
import java.util.List;

import jakarta.persistence.*;

@Entity
@Table(name = "helper_reports")
public class HelperReport {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    private Helper helper;

    @ManyToOne
    private User user;

    @OneToOne
    private Review review;

    @Column(length = 500)
    private String reason;

    private LocalDateTime createdAt;
    
    @OneToMany(mappedBy = "report", cascade = CascadeType.ALL)
    private List<HelperWarning> warnings;
    
    public List<HelperWarning> getWarnings() {
		return warnings;
	}

	public void setWarnings(List<HelperWarning> warnings) {
		this.warnings = warnings;
	}

	@PrePersist
    public void onCreate() {
        this.createdAt = LocalDateTime.now();
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

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Review getReview() {
		return review;
	}

	public void setReview(Review review) {
		this.review = review;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public LocalDateTime getCreatedAt() {
	    return createdAt;
	}

	public void setCreatedAt(LocalDateTime createdAt) {
	    this.createdAt = createdAt;
	}


    // getters & setters
}
