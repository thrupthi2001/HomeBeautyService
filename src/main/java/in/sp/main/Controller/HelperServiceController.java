package in.sp.main.Controller;

import java.io.IOException;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import in.sp.main.Entities.Helper;
import in.sp.main.Entities.Service;
import in.sp.main.Entities.ServiceImage;
import java.util.List;
import in.sp.main.Services.FileUploadService;
import in.sp.main.Services.ServiceCategoryService;
import in.sp.main.Services.ServiceService;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/helper/services")
public class HelperServiceController {

    private final ServiceService serviceService;
    private final ServiceCategoryService categoryService;
    private final FileUploadService fileUploadService;

    public HelperServiceController(
            ServiceService serviceService,
            ServiceCategoryService categoryService,
            FileUploadService fileUploadService) {

        this.serviceService = serviceService;
        this.categoryService = categoryService;
        this.fileUploadService = fileUploadService;
    }

    // 🔹 LIST SERVICES ADDED BY HELPER (for now showing all – filter later)
    @GetMapping
    public String list(Model model, HttpSession session) {

        if (session.getAttribute("helper") == null) {
            return "redirect:/helper/login";
        }

        Helper helper = (Helper) session.getAttribute("helper");
        model.addAttribute("services", serviceService.getByHelper(helper.getId()));

        return "helper/service-list";   // 🔁 REUSE ADMIN JSP
    }

    // 🔹 ADD SERVICE PAGE
    @GetMapping("/add")
    public String addPage(Model model, HttpSession session) {

        if (session.getAttribute("helper") == null) {
            return "redirect:/helper/login";
        }

        model.addAttribute("categories", categoryService.getAll());
        return "admin/service-add";   // 🔁 REUSE ADMIN JSP
    }

    // 🔹 ADD SERVICE (STATUS = PENDING)
    @PostMapping("/add")
    public String add(
            @ModelAttribute Service service,
            @RequestParam("mainImage") MultipartFile mainImage,
            @RequestParam("portfolioImages") MultipartFile[] portfolioImages,
            HttpSession session
    ) throws IOException {

        Helper helper = (Helper) session.getAttribute("helper");
        if (helper == null) {
            return "redirect:/helper/login";
        }

        if (mainImage != null && !mainImage.isEmpty()) {
            service.setImage(fileUploadService.saveFile(mainImage, "services"));
        }

        if (portfolioImages != null) {
            for (MultipartFile img : portfolioImages) {
                if (!img.isEmpty()) {
                    ServiceImage si = new ServiceImage();
                    si.setImagePath(fileUploadService.saveFile(img, "services"));
                    si.setService(service);
                    service.getImages().add(si);
                }
            }
        }

        service.setHelper(helper);
        service.setStatus("PENDING");

        serviceService.save(service);

        return "redirect:/helper/services";
    }
    
    
    // 🔹 EDIT PAGE
    @GetMapping("/edit/{id}")
    public String editPage(@PathVariable Long id, Model model, HttpSession session) {

        if (session.getAttribute("helper") == null) {
            return "redirect:/helper/login";
        }

        model.addAttribute("service", serviceService.getById(id));
        model.addAttribute("categories", categoryService.getAll());
        return "admin/service-edit";   // 🔁 REUSE ADMIN JSP
    }

    // 🔹 UPDATE SERVICE (STAYS PENDING AFTER EDIT)
    @PostMapping("/edit")
    public String edit(
            @ModelAttribute Service service,
            @RequestParam("mainImage") MultipartFile mainImage,
            @RequestParam("portfolioImages") MultipartFile[] portfolioImages,
            HttpSession session
    ) throws IOException {

        if (session.getAttribute("helper") == null) {
            return "redirect:/helper/login";
        }

        Service existing = serviceService.getById(service.getId());

        existing.setTitle(service.getTitle());
        existing.setDescription(service.getDescription());
        existing.setPrice(service.getPrice());
        existing.setCategory(service.getCategory());

        if (mainImage != null && !mainImage.isEmpty()) {
            existing.setImage(
                    fileUploadService.saveFile(mainImage, "services")
            );
        }

        if (portfolioImages != null) {
            for (MultipartFile img : portfolioImages) {
                if (!img.isEmpty()) {
                    ServiceImage si = new ServiceImage();
                    si.setImagePath(
                            fileUploadService.saveFile(img, "services")
                    );
                    si.setService(existing);
                    existing.getImages().add(si);
                }
            }
        }

        existing.setStatus("PENDING");
        serviceService.save(existing);

        return "redirect:/helper/services";
    }

    
 // 🔥 DELETE SERVICE (HELPER)
    @GetMapping("/delete/{id}")
    public String deleteService(@PathVariable Long id, HttpSession session) {

        if (session.getAttribute("helper") == null) {
            return "redirect:/helper/login";
        }

        Service service = serviceService.getById(id);
        if (service != null) {
            serviceService.delete(id);
        }

        return "redirect:/helper/services";
    }


}
