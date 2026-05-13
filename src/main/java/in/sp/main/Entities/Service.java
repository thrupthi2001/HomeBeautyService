package in.sp.main.Entities;

import jakarta.persistence.*;

@Entity
@Table(name = "services")
public class Service {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String title;
    @Lob
    @Column(columnDefinition = "TEXT")
    private String description;

    private double price;
    private String image;
    @Column(nullable = false)
    private String status; // PENDING, APPROVED
    
    @Column(length = 500)
    private String rejectReason;
    
    @ManyToOne
    @JoinColumn(name = "helper_id")
    private Helper helper;

    public Helper getHelper() {
        return helper;
    }

    public void setHelper(Helper helper) {
        this.helper = helper;
    }


    public String getRejectReason() {
        return rejectReason;
    }

    public void setRejectReason(String rejectReason) {
        this.rejectReason = rejectReason;
    }

    public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public ServiceCategory getCategory() {
		return category;
	}

	public void setCategory(ServiceCategory category) {
		this.category = category;
	}

	@ManyToOne
    @JoinColumn(name = "category_id")
    private ServiceCategory category;
	
	@OneToMany(mappedBy = "service", cascade = CascadeType.ALL, orphanRemoval = true)
	private java.util.List<ServiceImage> images = new java.util.ArrayList<>();

	public java.util.List<ServiceImage> getImages() {
	    return images;
	}

	public void setImages(java.util.List<ServiceImage> images) {
	    this.images = images;
	}


    // getters & setters
}
