## Background Color
US1
This ABtest would track user retention
The idea behind this test is to see whether user like the current look of our application.  It would be better for users to find our app appealing and this may affect user retention.
To test this, an ABtest would be created where a hex value for the background color is different than our current color.  We would probably deploy this to 50% of user (or greater).  the metric we're most concerned with is user retention.


## Text Color Contrast Optimization
- A/B Test Name: Text Color Contrast Optimization
- User Story Number: US1
- Metrics:
    - Engagement: Click-through rates (CTR) on key call-to-action (CTA) buttons.
    - Adoption: Form submission rates and conversions.
    - Retention: Returning user percentage.
- Hypothesis:  We believe that changing the text color to improve contrast will enhance readability, leading to increased user engagement and conversion rates. If users find the text easier to read, they will stay longer on the platform, interact more with key elements, and be more likely to complete desired actions.
- What Problem Are We Trying to Solve?  Currently, we suspect that low-contrast text on our platform is reducing readability, which may contribute to lower engagement and conversion rates. Users may struggle to quickly comprehend the information, causing frustration and increased bounce rates. By optimizing text color, we aim to improve the user experience, reduce cognitive load, and ultimately drive higher engagement and conversions.
- Experiment: We will allocate 100% of our users to the experiment (A/B split) to ensure a statistically significant sample size. The test will be conducted on both new and returning users.
- Tracking Using Firebase Analytics: Page session duration
  - Click-through rates (CTR) on CTA buttons
  - Form completion rates
- Variations:
    - Control (A): Current text color
    - Variant (B): Adjusted text color with higher contrast to improve readability



## Logo Design Optimization
- A/B Test Name: Logo Design Optimization  
- User Story Number:US1  
- Metrics:
  - Engagement: Click-through rates (CTR) on homepage or navigation bar (if applicable)
  - Adoption: Sign-up or onboarding completion rates
  - Retention: Returning visitor percentage and frequency of visits

- Hypothesis:
  We believe that updating our logo to a more modern or visually appealing version will create a stronger first impression, enhancing brand perception and trust. This could lead to increased user engagement, higher sign-up rates, and better retention.

- What Problem Are We Trying to Solve?
  Our current logo may not be as visually appealing or impactful as it could be, potentially affecting brand perception and user trust. First-time users might judge the overall quality of the platform based on branding. A refreshed logo could improve perception and encourage deeper engagement.

- Experiment:
  We will allocate 50% of users to the control group (original logo) and 50% to the variant group (new logo). The logo will appear across key screens including the homepage, navigation bar, and onboarding process.

- Tracking Using Firebase Analytics:
  - Logo impression count (if tracked separately)
  - Click-through rates (CTR) on logo or nearby navigation items
  - Page/session duration
  - Onboarding completion rates
  - Returning visitor percentage

- Variations:
  - Control (A): Original logo  
  - Variant (B): New logo design
 

---
## Jad A
## A/B Test Proposal: Meal Plan Flow Optimization

### A/B Test Name
**Meal Plan Flow Optimization**

### User Story Number
**US3 (Meal Plan Creation and Navigation)**

### Metrics (HEART Framework)
- **Task Success**: Click-through rate from calorie counter to meal plan
- **Engagement**: Frequency of interaction with meal planning features
- **Happiness**: NPS score after completing a meal plan

---

### Hypothesis
We believe that streamlining the transition from the calorie counter to the meal planning screen will improve the user experience by reducing friction and saving time. This improvement will lead to a higher task success rate, more engaged users, and better satisfaction reflected in the NPS score.

---

### What Problem Are We Trying to Solve?
User testing and analytics show a drop-off in engagement between logging calories and proceeding to create a meal plan. The current flow separates these into multiple steps and screens, which may cause confusion or fatigue. Since the meal plan feature is a core value proposition, any friction in this flow has a significant negative impact on both task success and user perception of the app.

By making the meal plan screen more accessible immediately after logging calories—on the same screen—we reduce steps and streamline the process, likely increasing user interaction with the feature.

---

### Experiment

- **Experiment Setup**: Use **Firebase Remote Config** to toggle between the two flows.
- **Audience**: 50% of users will experience the current (control) version, and 50% will see the variant.
- **Duration**: At least 2 weeks or until statistically significant results are collected.

**Tracking via Firebase Analytics:**
- `event_log_calories`
- `event_calorie_counter_to_meal_plan_click`
- `event_meal_plan_created`
- `event_nps_submitted`

**Conversion Funnel Tracked**:
1. Log calories  
2. Click to create a meal plan  
3. Submit NPS feedback after task

---

### Variations

#### Control (A):
- Existing flow: Log calories → tap button to go to separate meal plan screen.

#### Variant (B):
- New flow: After logging calories, the user sees a side panel or embedded section with suggested meals and a button to instantly generate a meal plan—all on the same screen.

---

### GitHub Integration
- **PBI Task Title**: `A/B Testing: Meal Plan Flow Optimization`
- **Labels**: `A/B Test`, `US3`

