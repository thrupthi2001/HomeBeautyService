package in.sp.main.Entities;

import jakarta.persistence.*;

@Entity
@Table(name = "helpers")
public class Helper {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;
    private String phone;
    private String password;

    private String profilePhoto;
    
    @ManyToOne
    @JoinColumn(name = "category_id")
    private ServiceCategory category;

	private boolean available = true;

    // getters & setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getProfilePhoto() { return profilePhoto; }
    public void setProfilePhoto(String profilePhoto) { this.profilePhoto = profilePhoto; }

    public boolean isAvailable() { return available; }
    public void setAvailable(boolean available) { this.available = available; }
    
    public ServiceCategory getCategory() {
		return category;
	}
	public void setCategory(ServiceCategory category) {
		this.category = category;
	}
}
