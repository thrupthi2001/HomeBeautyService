package in.sp.main.Controller;

import java.time.LocalDate;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import in.sp.main.Entities.SubscriptionPlan;
import in.sp.main.Entities.User;
import in.sp.main.Repositories.SubscriptionPlanRepository;
import in.sp.main.Services.UserSubscriptionService;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/user/subscriptions")
public class UserSubscriptionController {

	private final SubscriptionPlanRepository planRepo;
    private final UserSubscriptionService userSubscriptionService;

    public UserSubscriptionController(
            SubscriptionPlanRepository planRepo,
            UserSubscriptionService userSubscriptionService
    ) {
        this.planRepo = planRepo;
        this.userSubscriptionService = userSubscriptionService;
    }


    /* ================= VIEW ALL PLANS ================= */

    @GetMapping
    public String viewPlans(Model model, HttpSession session) {

        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/user/login";

        List<SubscriptionPlan> plans =
                planRepo.findByStatusWithItems("ACTIVE");

        model.addAttribute("plans", plans);
        model.addAttribute("activeSubscription",
                userSubscriptionService.getActiveSubscription(user.getId()));

        return "user/subscriptions";
    }


    /* ================= CONFIRM PAGE ================= */

    @GetMapping("/buy/{planId}")
    public String confirmPage(@PathVariable Long planId,
                              Model model,
                              HttpSession session) {

        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/user/login";

        if (userSubscriptionService.hasActiveSubscription(user.getId())) {
            return "redirect:/user/subscriptions";
        }

        SubscriptionPlan plan = planRepo.findById(planId).orElseThrow();

        model.addAttribute("plan", plan);
        model.addAttribute("startDate", LocalDate.now());
        model.addAttribute("endDate",
                LocalDate.now().plusDays(plan.getDurationDays()));

        return "user/confirm-subscription";
    }

    /* ================= FINAL PURCHASE ================= */

    @PostMapping("/buy")
    public String purchase(@RequestParam Long planId,
                           HttpSession session) {

        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/user/login";

        userSubscriptionService.activateSubscription(user, planId);
        return "redirect:/user/subscriptions";
    }
}
