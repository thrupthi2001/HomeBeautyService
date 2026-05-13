package in.sp.main.Controller;

import java.io.IOException;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import in.sp.main.Entities.Service;
import in.sp.main.Entities.ServiceCategory;
import in.sp.main.Services.FileUploadService;
import in.sp.main.Services.ServiceCategoryService;
import in.sp.main.Services.ServiceService;

@Controller
@RequestMapping("/admin/services")
public class AdminServiceController {

    private final ServiceService serviceService;
    private final ServiceCategoryService categoryService;
    private final FileUploadService fileUploadService;

    public AdminServiceController(
            ServiceService serviceService,
            ServiceCategoryService categoryService,
            FileUploadService fileUploadService) {

        this.serviceService = serviceService;
        this.categoryService = categoryService;
        this.fileUploadService = fileUploadService;
    }

    @GetMapping
    public String list(Model model) {
        model.addAttribute("services", serviceService.getAll());
        return "admin/service-list";
    }

    

    

   
    
    

    
    
    


}
