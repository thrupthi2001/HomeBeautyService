package in.sp.main.Entities;

import jakarta.persistence.*;

@Entity
@Table(name = "reviews")
public class Review {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private Integer serviceRating;  // 1–5
    public Integer getServiceRating() {
		return serviceRating;
	}
	public void setServiceRating(Integer serviceRating) {
		this.serviceRating = serviceRating;
	}
	public Integer getHelperRating() {
		return helperRating;
	}
	public void setHelperRating(Integer helperRating) {
		this.helperRating = helperRating;
	}
	private Integer helperRating;   // 1–5

    private String comment;
    
    private String reviewPhoto;

    
	@Column(length = 500)
    private String helperReply;


    @OneToOne
    private Booking booking;

    @ManyToOne
    private Service service;

    @ManyToOne
    private User user;

    // getters & setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getComment() { return comment; }
    public void setComment(String comment) { this.comment = comment; }

    public Booking getBooking() { return booking; }
    public void setBooking(Booking booking) { this.booking = booking; }

    public Service getService() { return service; }
    public void setService(Service service) { this.service = service; }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }
    
    public String getReviewPhoto() {
		return reviewPhoto;
	}
	public void setReviewPhoto(String reviewPhoto) {
		this.reviewPhoto = reviewPhoto;
	}
	public String getHelperReply() {
		return helperReply;
	}
	public void setHelperReply(String helperReply) {
		this.helperReply = helperReply;
	}
}
