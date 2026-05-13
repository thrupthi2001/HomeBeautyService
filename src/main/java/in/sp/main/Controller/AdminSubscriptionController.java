package in.sp.main.Controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import in.sp.main.Entities.Service;
import in.sp.main.Entities.SubscriptionPlan;
import in.sp.main.Entities.SubscriptionPlanItem;
import in.sp.main.Entities.UserSubscription;
import in.sp.main.Repositories.SubscriptionPlanItemRepository;
import in.sp.main.Repositories.SubscriptionPlanRepository;
import in.sp.main.Repositories.UserSubscriptionRepository;
import in.sp.main.Services.ServiceService;

@Controller
@RequestMapping("/admin/subscriptions")
public class AdminSubscriptionController {

    private final SubscriptionPlanRepository planRepo;
    private final SubscriptionPlanItemRepository itemRepo;
    private final ServiceService serviceService;
    private final UserSubscriptionRepository userSubRepo;

    public AdminSubscriptionController(
            SubscriptionPlanRepository planRepo,
            SubscriptionPlanItemRepository itemRepo,
            ServiceService serviceService,
            UserSubscriptionRepository userSubRepo
    ) {
        this.planRepo = planRepo;
        this.itemRepo = itemRepo;
        this.serviceService = serviceService;
        this.userSubRepo = userSubRepo; 
    }

    /* ================= LIST ================= */
    @GetMapping
    public String subscriptions(Model model) {
        model.addAttribute("plans", planRepo.findAllWithItems());
        return "admin/subscriptions";
    }

    /* ================= CREATE ================= */
    @GetMapping("/create")
    public String createPage(Model model) {
        model.addAttribute("services", serviceService.getByStatus("APPROVED"));
        return "admin/create-subscription";
    }

    @PostMapping("/create")
    public String create(
            @RequestParam String name,
            @RequestParam double price,
            @RequestParam int durationDays,
            @RequestParam Long[] serviceIds,
            @RequestParam int[] allowedCounts
    ) {
        SubscriptionPlan plan = new SubscriptionPlan();
        plan.setName(name);
        plan.setPrice(price);
        plan.setDurationDays(durationDays);
        plan.setStatus("ACTIVE");

        planRepo.save(plan);

        List<SubscriptionPlanItem> items = new ArrayList<>();

        for (int i = 0; i < serviceIds.length; i++) {
            if (allowedCounts[i] <= 0) continue;

            Service service = serviceService.getById(serviceIds[i]);

            SubscriptionPlanItem item = new SubscriptionPlanItem();
            item.setSubscriptionPlan(plan);
            item.setService(service);
            item.setAllowedCount(allowedCounts[i]);

            items.add(item);
        }

        itemRepo.saveAll(items);
        return "redirect:/admin/subscriptions";
    }

    /* ================= EDIT ================= */
    @GetMapping("/edit/{id}")
    public String editPage(@PathVariable Long id, Model model) {

        SubscriptionPlan plan = planRepo.findById(id).orElseThrow();

        model.addAttribute("plan", plan);
        model.addAttribute("services", serviceService.getByStatus("APPROVED"));

        return "admin/edit-subscription";
    }

    @PostMapping("/edit")
    public String update(
            @RequestParam Long planId,
            @RequestParam String name,
            @RequestParam double price,
            @RequestParam int durationDays,
            @RequestParam Long[] serviceIds,
            @RequestParam int[] allowedCounts
    ) {
        SubscriptionPlan plan = planRepo.findById(planId).orElseThrow();

        plan.setName(name);
        plan.setPrice(price);
        plan.setDurationDays(durationDays);

        // 🔴 REMOVE OLD ITEMS
        itemRepo.deleteAll(plan.getItems());

        List<SubscriptionPlanItem> items = new ArrayList<>();

        for (int i = 0; i < serviceIds.length; i++) {
            if (allowedCounts[i] <= 0) continue;

            Service service = serviceService.getById(serviceIds[i]);

            SubscriptionPlanItem item = new SubscriptionPlanItem();
            item.setSubscriptionPlan(plan);
            item.setService(service);
            item.setAllowedCount(allowedCounts[i]);

            items.add(item);
        }

        planRepo.save(plan);
        itemRepo.saveAll(items);

        return "redirect:/admin/subscriptions";
    }

    /* ================= STATUS ================= */
    @PostMapping("/toggle/{id}")
    public String toggleStatus(@PathVariable Long id) {
        SubscriptionPlan plan = planRepo.findById(id).orElseThrow();

        if ("ACTIVE".equals(plan.getStatus())) {
            plan.setStatus("INACTIVE");
        } else {
            plan.setStatus("ACTIVE");
        }

        planRepo.save(plan);
        return "redirect:/admin/subscriptions";
    }

    /* ================= DELETE ================= */
    @PostMapping("/delete/{id}")
    public String delete(@PathVariable Long id) {
        planRepo.deleteById(id);
        return "redirect:/admin/subscriptions";
    }
    
    /* ===== VIEW USERS BUTTON PAGE ===== */
    @GetMapping("/users")
    public String allSubscriptionUsers(Model model) {

        List<SubscriptionPlan> plans = planRepo.findAll();
        model.addAttribute("plans", plans);

        return "admin/subscription-users-plans";
    }
    
    /* ===== USERS FOR ONE PLAN ===== */
    @GetMapping("/{id}/users")
    public String usersForPlan(@PathVariable Long id, Model model) {

        SubscriptionPlan plan =
                planRepo.findById(id).orElseThrow();

        List<UserSubscription> users =
                userSubRepo.findBySubscriptionPlanId(id);

        model.addAttribute("plan", plan);
        model.addAttribute("users", users);

        return "admin/subscription-users";
    }


}
