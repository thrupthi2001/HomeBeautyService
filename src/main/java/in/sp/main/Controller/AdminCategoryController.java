package in.sp.main.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import in.sp.main.Entities.ServiceCategory;
import in.sp.main.Services.ServiceCategoryService;

@Controller
@RequestMapping("/admin/categories")
public class AdminCategoryController {

    private final ServiceCategoryService categoryService;

    public AdminCategoryController(ServiceCategoryService categoryService) {
        this.categoryService = categoryService;
    }

    @GetMapping
    public String list(Model model) {
        model.addAttribute("categories", categoryService.getAll());
        return "admin/category-list";
    }

    @GetMapping("/add")
    public String addPage() {
        return "admin/category-add";
    }

    @PostMapping("/add")
    public String add(@RequestParam String name) {
        ServiceCategory category = new ServiceCategory();
        category.setName(name);
        categoryService.save(category);
        return "redirect:/admin/categories";
    }

    @GetMapping("/delete/{id}")
    public String delete(@PathVariable Long id) {
        categoryService.delete(id);
        return "redirect:/admin/categories";
    }
}
