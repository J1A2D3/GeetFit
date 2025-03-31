# [Google HEART Framework Slides](https://docs.google.com/presentation/d/1yAaY9UlQHKW14W66FLniH8TwqMFjxzwGNPIl9vBd-Tg/edit?usp=sharing)

## How We Collect Each Metric

- **NPS**  
  - **Data Collection**: A survey prompt appears on the fifth login asking: “How likely are you to recommend this app to a friend?” (Scale 1–10).  
  - **Storage**: User’s score is stored in Firebase. A custom function calculates the NPS based on collected scores.
  
- **Adoption**  
  - **Data Collection**: Automatically tracked via Firebase Auth sign-ups and new user account activations.  
  - **Storage**: Recorded in Firebase Auth user database; we query the number of new activations per day/week.

- **DAU (Daily Active Users)**  
  - **Data Collection**: We use default Firebase Analytics tracking for user activity.  
  - **Storage**: Users who have at least one session per day are counted; reported daily in Firebase Analytics.

- **Retention Rate**  
  - **Data Collection**: Default Firebase Analytics “User Engagement” metrics, plus a custom definition (e.g., returning within a 7-day or 30-day window).  
  - **Storage**: Logged automatically in Firebase; we calculate the ratio of returning users over total active users for each period.

- **CTR (Click Through Rate) on the Golden Path**  
  - **Data Collection**: A custom event in Firebase Analytics triggers whenever users follow the path: (1) Login → (2) Calorie Counter → (3) Meal Plan.  
  - **Storage**: We increment counters each time the event is triggered and compare it to the number of logins to generate the CTR.

- **Crash Rate**  
  - **Data Collection**: Default Firebase Analytic  
  - **Storage**: Data is stored in Firebase.

---

## User Story for Metrics Collection

**User Story**:  
“As a returning user, I want to sign in and quickly log my meals so that I can track my daily calories. Meanwhile, as the product team, we need to collect data on sign-ins and how many times users log their meals so that we can measure engagement and optimize the meal logging feature.”

- **Sprint 1 (Signup and Sign-in)**  
  - Ensures new users can create accounts and existing users can sign in.  
  - We will track the adoption metric (new sign-ups) and daily active users (users who sign in).

- **Sprint 2 (The Golden Path: Login → Calorie Counter → Meal Plan)**  
  - Users who follow the Golden Path generate a custom event so we can measure CTR.  
  - NPS and other engagement metrics (like feature usage) also begin in this sprint.
  
