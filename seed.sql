-- =================================================================
-- Consolidated Seed File for CognoPath FastLens
-- Contains all courses and questions for a clean database seed.
-- Run this after running the initial schema migrations.
-- =================================================================

-- Step 1: Create Indexes if they don't exist for performance.
CREATE INDEX IF NOT EXISTS idx_questions_course ON questions(course_id);
CREATE INDEX IF NOT EXISTS idx_fast_methods_q ON fast_methods(question_id);

-- Step 2: Ensure all course rows exist.
INSERT INTO courses(id, name) VALUES
('qa_speed', 'Quant Aptitude — Speed Arithmetic'),
('class-10-chemistry', 'Class 10 Chemistry'),
('class-11-chemistry', 'Class 11 Chemistry'),
('class-13-chemistry', 'Class 13 Chemistry')
ON CONFLICT (id) DO UPDATE SET name=EXCLUDED.name;

-- Step 3: Upsert all questions
INSERT INTO questions (id, course_id, text, options, correct_option_index, concept_tags) VALUES
-- =================================================================
-- Speed Arithmetic (100 Questions)
-- =================================================================
-- Batch 1
('qa_speed_pct_of_num_a1b2', 'qa_speed', 'What is 24% of 500?', '["100", "120", "125", "150"]', 1, 'percentages'),
('qa_speed_pct_fraction_c3d4', 'qa_speed', 'Convert the fraction 5/8 to a percentage.', '["58%", "60%", "62.5%", "65%"]', 2, 'percentages'),
('qa_speed_pct_increase_e5f6', 'qa_speed', 'If a value increases from 80 to 100, what is the percentage increase?', '["20%", "25%", "30%", "35%"]', 1, 'percentages'),
('qa_speed_pct_marks_g7h8', 'qa_speed', 'A student scores 90 marks out of 120. What is their score as a percentage?', '["70%", "75%", "80%", "85%"]', 1, 'percentages'),
('qa_speed_pct_reverse_i9j0', 'qa_speed', 'After a 20% discount, an item costs ₹640. What was its original price?', '["₹768", "₹800", "₹820", "₹780"]', 1, 'percentages'),
('qa_speed_pct_chained_k1l2', 'qa_speed', 'The price of an item is increased by 20%, then decreased by 20%. What is the net percentage change?', '["No change", "4% increase", "4% decrease", "5% decrease"]', 2, 'percentages'),
('qa_speed_pct_pass_fail_m3n4', 'qa_speed', 'In a class, 60% of students are boys. If there are 30 girls, what is the total number of students?', '["50", "60", "70", "75"]', 3, 'percentages'),
('qa_speed_pct_area_increase_o5p6', 'qa_speed', 'The length of a rectangle is increased by 10% and the breadth is increased by 10%. What is the percentage increase in its area?', '["10%", "20%", "21%", "22%"]', 2, 'percentages'),
('qa_speed_pct_election_q7r8', 'qa_speed', 'In an election, a candidate gets 55% of the total valid votes and wins by 900 votes. How many votes did the losing candidate get?', '["4050", "4500", "4950", "5500"]', 0, 'percentages'),
('qa_speed_ratios_proportion_s9t0', 'qa_speed', 'If 4:x is proportional to x:9, what is the positive value of x?', '["5", "6", "7", "8"]', 1, 'ratios_proportion'),
('qa_speed_ratios_split_u1v2', 'qa_speed', 'Divide ₹1,000 between A and B in the ratio 2:3. How much does B get?', '["₹400", "₹500", "₹600", "₹750"]', 2, 'ratios_proportion'),
('qa_speed_ratios_simplify_w3x4', 'qa_speed', 'Simplify the ratio 48:64.', '["2:3", "3:4", "4:5", "5:6"]', 1, 'ratios_proportion'),
('qa_speed_ratios_merge_y5z6', 'qa_speed', 'If A:B = 2:3 and B:C = 4:5, find A:B:C.', '["8:12:15", "6:12:15", "8:10:15", "2:3:5"]', 0, 'ratios_proportion'),
('qa_speed_ratios_coins_a7b8', 'qa_speed', 'A bag has ₹1, 50p, and 25p coins in the ratio 5:6:7. If the total amount is ₹390, find the number of 50p coins.', '["180", "200", "240", "280"]', 2, 'ratios_proportion'),
('qa_speed_ratios_income_c9d0', 'qa_speed', 'Incomes of A and B are in the ratio 4:3. Their expenditures are in the ratio 3:2. If both save ₹600, what is A''s income?', '["₹1,800", "₹2,000", "₹2,400", "₹3,000"]', 2, 'ratios_proportion'),
('qa_speed_ratios_mixture_e1f2', 'qa_speed', 'A 40-liter mixture contains milk and water in the ratio 3:1. How much water must be added to make the ratio 2:1?', '["5 liters", "10 liters", "15 liters", "20 liters"]', 0, 'ratios_proportion'),
('qa_speed_ratios_partnership_g3h4', 'qa_speed', 'A invests ₹12,000 for 8 months and B invests ₹16,000 for 9 months in a business. If the total profit is ₹16,800, what is B''s share?', '["₹8,400", "₹9,000", "₹9,600", "₹10,000"]', 2, 'ratios_proportion'),
('qa_speed_ratios_ages_i5j6', 'qa_speed', 'The ratio of the ages of two people is 3:4. After 5 years, the ratio will be 4:5. What is the current age of the older person?', '["15 years", "20 years", "25 years", "30 years"]', 1, 'ratios_proportion'),
('qa_speed_si_basic_k7l8', 'qa_speed', 'Find the simple interest on ₹5,000 at a rate of 8% per annum for 3 years.', '["₹1,000", "₹1,200", "₹1,400", "₹1,500"]', 1, 'simple_interest'),
('qa_speed_si_find_rate_m9n0', 'qa_speed', 'At what annual simple interest rate will ₹10,000 amount to ₹12,400 in 3 years?', '["7%", "7.5%", "8%", "8.5%"]', 2, 'simple_interest'),
('qa_speed_si_find_time_o1p2', 'qa_speed', 'In how many years will a sum of ₹8,000 yield a simple interest of ₹1,280 at 4% per annum?', '["3 years", "3.5 years", "4 years", "5 years"]', 2, 'simple_interest'),
('qa_speed_ci_basic_q3r4', 'qa_speed', 'Find the compound interest on ₹5,000 for 2 years at 10% per annum, compounded annually.', '["₹1,000", "₹1,050", "₹1,100", "₹1,150"]', 1, 'compound_interest'),
('qa_speed_ci_half_yearly_s5t6', 'qa_speed', 'Find the compound interest on ₹8,000 for 1 year at 10% per annum, compounded half-yearly.', '["₹800", "₹810", "₹820", "₹824.32"]', 2, 'compound_interest'),
('qa_speed_ci_si_diff_u7v8', 'qa_speed', 'What is the difference between Compound and Simple interest on ₹10,000 for 2 years at 5% per annum?', '["₹20", "₹25", "₹30", "₹50"]', 1, 'compound_interest'),
('qa_speed_ci_depreciation_w9x0', 'qa_speed', 'A machine worth ₹80,000 depreciates at 10% per year. What is its value after 2 years?', '["₹64,000", "₹64,800", "₹72,000", "₹72,200"]', 1, 'compound_interest'),
-- Batch 2
('qa_speed_pct_commission_b3c4', 'qa_speed', 'A salesman gets a 12% commission on total sales. If he makes a sale of ₹15,000, what is his commission?', '["₹1,500", "₹1,800", "₹2,000", "₹2,100"]', 1, 'percentages'),
('qa_speed_pct_error_d5e6', 'qa_speed', 'A number is incorrectly multiplied by 4/5 instead of 5/4. What is the percentage error in the result?', '["20%", "25%", "36%", "45%"]', 2, 'percentages'),
('qa_speed_pct_discount_f7g8', 'qa_speed', 'Two successive discounts of 10% and 20% are equivalent to a single discount of:', '["30%", "28%", "25%", "22%"]', 1, 'percentages'),
('qa_speed_pct_population_h9i0', 'qa_speed', 'The population of a town increases by 10% annually. If its current population is 10,000, what will it be in 2 years?', '["11,000", "12,000", "12,100", "12,200"]', 2, 'percentages'),
('qa_speed_pct_compare_j1k2', 'qa_speed', 'If A''s salary is 25% more than B''s salary, by what percentage is B''s salary less than A''s?', '["25%", "22.5%", "20%", "15%"]', 2, 'percentages'),
('qa_speed_pct_cost_price_l3m4', 'qa_speed', 'By selling an article for ₹450, a shopkeeper loses 10%. At what price should he sell it to gain 10%?', '["₹500", "₹525", "₹550", "₹600"]', 2, 'percentages'),
('qa_speed_pct_of_pct_n5o6', 'qa_speed', 'What is 40% of 50% of 300?', '["50", "60", "75", "80"]', 1, 'percentages'),
('qa_speed_pct_express_p7q8', 'qa_speed', 'What percentage of 200 is 50?', '["20%", "25%", "30%", "40%"]', 1, 'percentages'),
('qa_speed_pct_net_change_r9s0', 'qa_speed', 'A number is first increased by 30% and then decreased by 13.5%. The final value is 225. What was the original number?', '["150", "180", "200", "210"]', 2, 'percentages'),
('qa_speed_ratios_fourth_prop_t1u2', 'qa_speed', 'Find the fourth proportional to 5, 8, and 13.', '["18.8", "20", "20.8", "21.2"]', 2, 'ratios_proportion'),
('qa_speed_ratios_mean_prop_v3w4', 'qa_speed', 'Find the mean proportional between 9 and 16.', '["10", "11", "12", "13.5"]', 2, 'ratios_proportion'),
('qa_speed_ratios_duplicate_x5y6', 'qa_speed', 'What is the duplicate ratio of 2:3?', '["2:3", "4:6", "4:9", "8:27"]', 2, 'ratios_proportion'),
('qa_speed_ratios_compounded_z7a8', 'qa_speed', 'Find the compounded ratio of 2:3 and 4:9.', '["8:12", "6:18", "8:27", "1:2"]', 2, 'ratios_proportion'),
('qa_speed_ratios_ages_two_b9c0', 'qa_speed', 'The present ages of A and B are in the ratio 5:6. Seven years hence, this ratio becomes 6:7. What is A''s present age?', '["30 years", "35 years", "40 years", "42 years"]', 1, 'ratios_proportion'),
('qa_speed_ratios_investment_d1e2', 'qa_speed', 'A and B start a business with investments of ₹20,000 and ₹30,000. If the total profit after a year is ₹30,000, what is A''s share?', '["₹10,000", "₹12,000", "₹15,000", "₹18,000"]', 1, 'ratios_proportion'),
('qa_speed_ratios_numbers_f3g4', 'qa_speed', 'Two numbers are in the ratio 3:4. If their sum is 84, find the larger number.', '["36", "42", "48", "52"]', 2, 'ratios_proportion'),
('qa_speed_ratios_mixture_two_h5i6', 'qa_speed', 'In what ratio must a grocer mix two varieties of tea worth ₹60/kg and ₹65/kg so that by selling the mixture at ₹68.20/kg, he may gain 10%?', '["3:2", "3:4", "3:5", "4:5"]', 0, 'ratios_proportion'),
('qa_speed_ratios_speed_j7k8', 'qa_speed', 'The speeds of three cars are in the ratio 2:3:4. The ratio of the times taken by these cars to travel the same distance is:', '["2:3:4", "4:3:2", "6:4:3", "3:4:6"]', 2, 'ratios_proportion'),
('qa_speed_si_find_sum_l9m0', 'qa_speed', 'A sum of money amounts to ₹1,380 in 3 years and to ₹1,500 in 5 years at simple interest. Find the sum.', '["₹1,100", "₹1,150", "₹1,200", "₹1,250"]', 2, 'simple_interest'),
('qa_speed_si_part_invest_n1o2', 'qa_speed', 'A sum of ₹10,000 is lent partly at 8% and the remaining at 10% per annum. If the yearly interest on the average is 9.2%, how much was lent at 8%?', '["₹4,000", "₹5,000", "₹6,000", "₹7,000"]', 0, 'simple_interest'),
('qa_speed_si_amount_p3q4', 'qa_speed', 'A sum of ₹12,000 becomes ₹13,200 in 2 years at a certain rate of simple interest. What will it become in 3 years at the same rate?', '["₹13,500", "₹13,600", "₹13,800", "₹14,000"]', 2, 'simple_interest'),
('qa_speed_si_rate_double_r5s6', 'qa_speed', 'A sum of money doubles itself in 10 years at simple interest. What is the rate of interest?', '["8%", "9%", "10%", "12%"]', 2, 'simple_interest'),
('qa_speed_ci_find_rate_t7u8', 'qa_speed', 'At what rate percent per annum will ₹2,000 amount to ₹2,205 in 2 years, compounded annually?', '["4%", "4.5%", "5%", "5.5%"]', 2, 'compound_interest'),
('qa_speed_ci_depreciation_v9w0', 'qa_speed', 'The value of a machine depreciates at the rate of 10% every year. It was purchased 3 years ago. If its present value is ₹29,160, for how much was it purchased?', '["₹36,000", "₹38,000", "₹40,000", "₹42,000"]', 2, 'compound_interest'),
('qa_speed_ci_find_time_x1y2', 'qa_speed', 'In how many years will ₹2,000 become ₹2,420 at 10% per annum compound interest?', '["1.5 years", "2 years", "2.5 years", "3 years"]', 1, 'compound_interest'),
-- Batch 3
('qa_speed_pct_remaining_a1b2', 'qa_speed', 'A man spends 40% of his income on food. If his income is ₹3,000, how much does he NOT spend on food?', '["₹1,200", "₹1,500", "₹1,800", "₹2,000"]', 2, 'percentages'),
('qa_speed_pct_of_day_c3d4', 'qa_speed', 'What percentage of a day is 3 hours?', '["10%", "12.5%", "15%", "16.66%"]', 1, 'percentages'),
('qa_speed_pct_profit_e5f6', 'qa_speed', 'A shopkeeper buys an item for ₹400 and sells it for ₹500. What is his profit percentage?', '["20%", "22.5%", "25%", "30%"]', 2, 'percentages'),
('qa_speed_pct_successive_g7h8', 'qa_speed', 'A number is increased by 10% and then by 20%. The final number is 66. What was the original number?', '["50", "55", "60", "62"]', 0, 'percentages'),
('qa_speed_pct_sugar_price_i9j0', 'qa_speed', 'A 20% rise in the price of sugar forces a person to purchase 2 kg less for ₹120. Find the original price of sugar per kg.', '["₹10", "₹12", "₹15", "₹20"]', 0, 'percentages'),
('qa_speed_pct_exam_pass_k1l2', 'qa_speed', 'In an examination, 93% of students passed and 259 failed. The total number of students appearing at the examination was:', '["3700", "3850", "3950", "4200"]', 0, 'percentages'),
('qa_speed_pct_fraction_compare_m3n4', 'qa_speed', 'Which fraction is greater: 3/4 or 4/5?', '["3/4", "4/5", "Both are equal", "Cannot be determined"]', 1, 'percentages'),
('qa_speed_pct_decimal_o5p6', 'qa_speed', 'Express 0.5% as a decimal.', '["0.5", "0.05", "0.005", "0.0005"]', 2, 'percentages'),
('qa_speed_pct_word_problem_q7r8', 'qa_speed', 'If 30% of a number is 18, what is the number?', '["50", "54", "60", "62"]', 2, 'percentages'),
('qa_speed_ratios_inverse_s9t0', 'qa_speed', 'The ratio of A to B is 3:4. What is the ratio of B to A?', '["3:4", "4:3", "1:1", "Cannot be determined"]', 1, 'ratios_proportion'),
('qa_speed_ratios_work_u1v2', 'qa_speed', 'A can do a piece of work in 10 days and B in 15 days. If they work together, in how many days will the work be finished?', '["5 days", "6 days", "8 days", "9 days"]', 1, 'ratios_proportion'),
('qa_speed_ratios_alloy_w3x4', 'qa_speed', 'An alloy contains copper and zinc in the ratio 5:3. If the alloy weighs 800g, how much copper is in it?', '["300g", "400g", "500g", "600g"]', 2, 'ratios_proportion'),
('qa_speed_ratios_liquid_y5z6', 'qa_speed', 'A mixture of 40 litres of milk and water contains 10% water. How much water should be added to make the water 20% in the new mixture?', '["5 litres", "6 litres", "8 litres", "10 litres"]', 0, 'ratios_proportion'),
('qa_speed_ratios_partnership_two_a7b8', 'qa_speed', 'A and B invest in a business in the ratio 3:2. If 5% of the total profit goes to charity and A''s share is ₹855, the total profit is:', '["₹1,425", "₹1,500", "₹1,537.50", "₹1,576"]', 1, 'ratios_proportion'),
('qa_speed_ratios_third_prop_c9d0', 'qa_speed', 'Find the third proportional to 9 and 12.', '["15", "16", "18", "21"]', 1, 'ratios_proportion'),
('qa_speed_ratios_students_e1f2', 'qa_speed', 'The ratio of boys to girls in a class is 5:4. If the number of boys is 25, find the number of girls.', '["15", "20", "25", "30"]', 1, 'ratios_proportion'),
('qa_speed_ratios_prop_share_g3h4', 'qa_speed', 'A, B and C divide an amount of ₹1,200 amongst themselves in the ratio 2:3:5. Find B''s share.', '["₹240", "₹360", "₹480", "₹600"]', 1, 'ratios_proportion'),
('qa_speed_ratios_distance_i5j6', 'qa_speed', 'The ratio of speeds of two cars is 2:3. If the first car takes 6 hours to cover a distance, how long will the second car take to cover the same distance?', '["3 hours", "4 hours", "5 hours", "9 hours"]', 1, 'ratios_proportion'),
('qa_speed_si_find_principal_k7l8', 'qa_speed', 'What sum of money will produce ₹143 as simple interest in 3 years and 3 months at 2.5% p.a.?', '["₹1,560", "₹1,660", "₹1,760", "₹1,860"]', 2, 'simple_interest'),
('qa_speed_si_rate_increase_m9n0', 'qa_speed', 'A sum was put at simple interest at a certain rate for 2 years. Had it been put at 1% higher rate, it would have fetched ₹24 more. The sum is:', '["₹1,000", "₹1,200", "₹1,500", "₹1,800"]', 1, 'simple_interest'),
('qa_speed_si_installments_o1p2', 'qa_speed', 'A man borrows ₹10,000 and pays back ₹1,200 as interest for 2 years. What is the rate of simple interest?', '["5%", "6%", "7%", "8%"]', 1, 'simple_interest'),
('qa_speed_ci_diff_3yr_q3r4', 'qa_speed', 'The difference between the compound interest and simple interest on a certain sum for 3 years at 10% p.a. is ₹93. Find the sum.', '["₹2,000", "₹2,500", "₹3,000", "₹3,500"]', 2, 'compound_interest'),
('qa_speed_ci_find_principal_s5t6', 'qa_speed', 'A sum of money becomes ₹1,352 in 2 years at 4% per annum compound interest. The sum is:', '["₹1,200", "₹1,225", "₹1,250", "₹1,270"]', 2, 'compound_interest'),
('qa_speed_ci_time_double_u7v8', 'qa_speed', 'In how many years will a sum of money double itself at 10% compound interest p.a.?', '["5 years", "7 years", "10 years", "12 years"]', 1, 'compound_interest'),
('qa_speed_ci_effective_rate_w9x0', 'qa_speed', 'Find the effective annual rate of interest when the rate is 10% p.a. compounded half-yearly.', '["10%", "10.25%", "10.5%", "11%"]', 1, 'compound_interest'),
-- Batch 4
('qa_speed_pct_vote_invalid_a2b3', 'qa_speed', 'In an election, 20% of votes were invalid. The winner got 70% of the valid votes and won by 9600 votes. Find the total number of votes polled.', '["25000", "30000", "32000", "40000"]', 3, 'percentages'),
('qa_speed_pct_expense_c4d5', 'qa_speed', 'A person spends 20% of their income on rent and 50% of the rest on food. If they save ₹1200, what was their income?', '["3000", "4000", "5000", "6000"]', 1, 'percentages'),
('qa_speed_pct_reduction_e6f7', 'qa_speed', 'Due to a 25% reduction in the price of rice, a person can buy 5 kg more for ₹600. What is the reduced price per kg?', '["₹25", "₹30", "₹35", "₹40"]', 1, 'percentages'),
('qa_speed_pct_salary_g8h9', 'qa_speed', 'A''s salary is 50% more than B''s. How much percent is B''s salary less than A''s?', '["33.33%", "40%", "50%", "66.66%"]', 0, 'percentages'),
('qa_speed_pct_fraction_word_i0j1', 'qa_speed', 'If 75% of a number is added to 75, the result is the number itself. The number is:', '["200", "250", "300", "350"]', 2, 'percentages'),
('qa_speed_pct_compare_income_k2l3', 'qa_speed', 'The income of A is 20% higher than that of B. The income of B is 25% less than that of C. What percent is A''s income of C''s income?', '["90%", "95%", "100%", "105%"]', 0, 'percentages'),
('qa_speed_pct_venn_diagram_m4n5', 'qa_speed', 'In an exam, 65% of students passed in History and 55% passed in English. If 25% failed in both, what percentage of students passed in both subjects?', '["35%", "40%", "45%", "50%"]', 2, 'percentages'),
('qa_speed_pct_mixture_o6p7', 'qa_speed', 'A mixture of 30 liters of milk and water contains 10% water. How much water should be added so that water becomes 25% of the new mixture?', '["4 liters", "5 liters", "6 liters", "8 liters"]', 2, 'percentages'),
('qa_speed_ratios_ages_past_q8r9', 'qa_speed', 'The ratio of the ages of a father and son was 8:3 five years ago. If the sum of their present ages is 60 years, what is the father''s present age?', '["40 years", "45 years", "50 years", "53 years"]', 3, 'ratios_proportion'),
('qa_speed_ratios_boys_girls_s0t1', 'qa_speed', 'The number of boys in a class is three times the number of girls. Which of the following cannot be the total number of students in the class?', '["40", "44", "48", "49"]', 3, 'ratios_proportion'),
('qa_speed_ratios_mixture_add_u2v3', 'qa_speed', 'A 60 liter mixture of milk and water are in the ratio 2:1. How many liters of water must be added to make the ratio 1:2?', '["40", "50", "60", "70"]', 2, 'ratios_proportion'),
('qa_speed_ratios_work_three_w4x5', 'qa_speed', 'A, B and C can do a piece of work in 20, 30 and 60 days respectively. How many days will it take for A to do the work if he is assisted by B and C on every third day?', '["10 days", "12 days", "15 days", "18 days"]', 2, 'ratios_proportion'),
('qa_speed_ratios_coins_value_y6z7', 'qa_speed', 'A box contains ₹1, 50p & 25p coins in the ratio 8:5:3. If the total amount of money in the box is ₹112.50, the number of 50p coins is:', '["40", "45", "50", "52"]', 2, 'ratios_proportion'),
('qa_speed_ratios_prop_numbers_a8b9', 'qa_speed', 'The sum of three numbers is 98. If the ratio of the first to the second is 2:3 and that of the second to the third is 5:8, then the second number is:', '["20", "30", "38", "42"]', 1, 'ratios_proportion'),
('qa_speed_ratios_scale_map_c0d1', 'qa_speed', 'On a map, 1 cm represents 50 km. If the distance between two cities on the map is 3.5 cm, what is the actual distance?', '["150 km", "165 km", "175 km", "180 km"]', 2, 'ratios_proportion'),
('qa_speed_ratios_speed_time_e2f3', 'qa_speed', 'Two trains are moving in the same direction at 60 km/hr and 40 km/hr. The time taken by the faster train to cross a man sitting in the slower train is 18 seconds. What is the length of the faster train?', '["80m", "90m", "100m", "120m"]', 2, 'ratios_proportion'),
('qa_speed_si_sum_parts_g4h5', 'qa_speed', 'A sum of ₹7,500 is lent out in two parts. The simple interest on the first part at 10% for 2 years is equal to the simple interest on the second part at 12% for 3 years. Find the first part.', '["₹4500", "₹4000", "₹3500", "₹3000"]', 0, 'simple_interest'),
('qa_speed_si_amount_time_i6j7', 'qa_speed', 'A sum of money at simple interest amounts to ₹815 in 3 years and to ₹854 in 4 years. The sum is:', '["₹650", "₹690", "₹698", "₹700"]', 2, 'simple_interest'),
('qa_speed_si_rate_change_k8l9', 'qa_speed', 'A person lends a certain sum of money at 4% simple interest. If in 5 years the interest is ₹520 less than the sum lent, what is the sum lent?', '["₹600", "₹650", "₹700", "₹750"]', 1, 'simple_interest'),
('qa_speed_si_fraction_m0n1', 'qa_speed', 'The simple interest on a sum of money is 4/9 of the principal. Find the rate percent and time, if both are numerically equal.', '["5 years, 5%", "6.66 years, 6.66%", "7 years, 7%", "8 years, 8%"]', 1, 'simple_interest'),
('qa_speed_si_total_interest_o2p3', 'qa_speed', 'What will be the simple interest earned on an amount of ₹16,800 in 9 months at the rate of 6.25% p.a.?', '["₹787.50", "₹812.50", "₹860", "₹887.50"]', 0, 'simple_interest'),
('qa_speed_ci_vs_si_q4r5', 'qa_speed', 'The compound interest on a certain sum for 2 years is ₹40.80 and the simple interest is ₹40.00. The rate of interest is:', '["2%", "3%", "4%", "5%"]', 2, 'compound_interest'),
('qa_speed_ci_triples_s6t7', 'qa_speed', 'A sum of money placed at compound interest triples itself in 8 years. In how many years will it amount to 9 times itself?', '["16 years", "24 years", "32 years", "40 years"]', 1, 'compound_interest'),
('qa_speed_ci_depreciate_u8v9', 'qa_speed', 'The value of a car depreciates by 20% annually. If its present value is ₹256,000, what was its value 2 years ago?', '["₹3,20,000", "₹3,60,000", "₹4,00,000", "₹4,50,000"]', 2, 'compound_interest'),
('qa_speed_ci_rate_yearly_w0x1', 'qa_speed', 'A sum of ₹1,600 gives a compound interest of ₹252.20 in 2 years. The rate of interest is:', '["5%", "6%", "7%", "8%"]', 3, 'compound_interest'),
-- =================================================================
-- Chemistry (Transformed to new schema)
-- =================================================================
('chem10_nacl_molarity_c1a1', 'class-10-chemistry', 'A solution contains 58.5 g NaCl in 1 L water. What is its molarity? (Na=23, Cl=35.5)', '["0.5 M", "1.0 M", "2.0 M", "58.5 M"]', 1, 'mole,solutions,stoichiometry'),
('chem10_h2o_molecules_d2b2', 'class-10-chemistry', 'How many molecules are present in 18 g of water? (H=1, O=16)', '["6.02 × 10²³", "3.01 × 10²³", "12.04 × 10²³", "1.0 × 10²³"]', 0, 'mole,avogadro'),
('chem10_co2_mass_e3c3', 'class-10-chemistry', 'What is the mass of 0.5 moles of CO₂? (C=12, O=16)', '["11 g", "22 g", "44 g", "88 g"]', 1, 'mole,molecular-mass'),
('chem10_h2_vs_o2_f4d4', 'class-10-chemistry', 'Which contains more atoms: 1 g of H₂ or 1 g of O₂? (H=1, O=16)', '["H₂", "O₂", "Both equal", "Cannot determine"]', 0, 'mole,comparison'),
('chem10_co2_moles_g5e5', 'class-10-chemistry', 'Calculate moles in 11 g of CO₂. (C=12, O=16)', '["0.1 mol", "0.25 mol", "0.5 mol", "1.0 mol"]', 1, 'mole,stoichiometry'),
('chem10_gas_stp_h6f6', 'class-10-chemistry', 'What is the volume of 1 mole of any gas at STP?', '["11.2 L", "22.4 L", "44.8 L", "2.24 L"]', 1, 'mole,gas-laws'),
('chem10_h2so4_moles_i7g7', 'class-10-chemistry', 'How many moles of H₂SO₄ are in 98 g of the acid? (H=1, S=32, O=16)', '["0.5 mol", "1.0 mol", "1.5 mol", "2.0 mol"]', 1, 'mole,acids'),
('chem10_empirical_formula_j8h8', 'class-10-chemistry', 'What is the empirical formula of a compound with 40% C, 6.7% H, and 53.3% O by mass? (C=12, H=1, O=16)', '["CH₂O", "C₂H₄O₂", "CHO", "C₃H₆O₃"]', 0, 'empirical-formula,stoichiometry'),
('chem10_methane_atoms_k9i9', 'class-10-chemistry', 'How many atoms are in 2 moles of methane (CH₄)?', '["6.02 × 10²³", "1.204 × 10²⁴", "6.02 × 10²⁴", "3.01 × 10²⁴"]', 2, 'mole,molecules'),
('chem10_fe_vs_s_mass_l0j0', 'class-10-chemistry', 'Which has the greatest mass: 1 mol Fe or 1 mol S? (Fe=56, S=32)', '["Fe", "S", "Both equal", "Cannot determine"]', 0, 'mole,atomic-mass')
ON CONFLICT (id) DO UPDATE SET
  text = EXCLUDED.text,
  options = EXCLUDED.options,
  correct_option_index = EXCLUDED.correct_option_index,
  concept_tags = EXCLUDED.concept_tags;

-- Step 4: Upsert all fast_methods
INSERT INTO fast_methods (id, question_id, title, justification, pitfall_analysis, full_solution_md, why_others_wrong_md, validity_notes_md) VALUES
-- Speed Arithmetic Fast Methods
('fm_qa_speed_pct_of_num_a1b2', 'qa_speed_pct_of_num_a1b2', 'Mental Math: Break Down Percentage', '24% = 25% - 1%.
25% (or 1/4) of 500 is 125.
1% of 500 is 5.
So, 125 - 5 = **120**.', 'Avoids direct multiplication (0.24 * 500), which is slower.', '**Full Solution:**
1. Convert percentage to decimal: 24% = 0.24.
2. Multiply: 0.24 * 500 = 120.', '- `100` is 20% of 500.
- `125` is 25% of 500.
- `150` is 30% of 500.', 'This breakdown method is safe and fast for percentages near standard fractions (25%, 50%, etc.).'),
('fm_qa_speed_pct_fraction_c3d4', 'qa_speed_pct_fraction_c3d4', 'Fraction to Percentage Conversion', 'To convert any fraction to a percentage, multiply by 100.
(5/8) * 100 = 500/8 = **62.5%**.', 'Memorizing that 1/8 = 12.5% is even faster. Then 5 * 12.5% = 62.5%.', '**Full Solution:**
1. Divide the numerator by the denominator: 5 ÷ 8 = 0.625.
2. Multiply by 100 to get the percentage: 0.625 * 100 = 62.5%.', '- `58%` and `60%` are just close estimates.
- `65%` is a plausible but incorrect calculation.', 'Multiplying by 100 is the universal method and is always safe.'),
('fm_qa_speed_pct_increase_e5f6', 'qa_speed_pct_increase_e5f6', 'Change / Original Formula', 'Percentage Increase = (Change in Value / Original Value) * 100.
Change = 100 - 80 = 20.
(20 / 80) * 100 = (1/4) * 100 = **25%**.', 'A common mistake is dividing by the new value (100) instead of the original (80).', '**Full Solution:**
1. Find the change: 100 - 80 = 20.
2. Divide the change by the original value: 20 / 80 = 0.25.
3. Convert to percentage: 0.25 * 100 = 25%.', '- `20%` is the absolute change, not percentage.
- `30%` and `35%` are overestimations.', 'The "Change / Original" formula is always safe for percentage change problems.'),
('fm_qa_speed_ratios_merge_y5z6', 'qa_speed_ratios_merge_y5z6', 'LCM Method for Merging Ratios', 'To merge A:B (2:3) and B:C (4:5), make B common.
LCM of 3 and 4 is 12.
Multiply A:B by 4 -> 8:12.
Multiply B:C by 3 -> 12:15.
Combined: **8:12:15**.', 'Do not just combine the first and last numbers. The common term (B) must be equalized.', '**Full Solution:**
1. Write the ratios: A/B = 2/3 and B/C = 4/5.
2. To combine, find a common value for B. The LCM of 3 and 4 is 12.
3. Adjust the first ratio: (2/3) * (4/4) = 8/12. So A:B = 8:12.
4. Adjust the second ratio: (4/5) * (3/3) = 12/15. So B:C = 12:15.
5. Combine them: A:B:C = 8:12:15.', '- `6:12:15` would happen if A:B was 2:4, not 2:3.
- `2:3:5` incorrectly merges without making B common.', 'The LCM method is always safe for merging two ratios with a common term.'),
('fm_qa_speed_si_basic_k7l8', 'qa_speed_si_basic_k7l8', 'No Safe Shortcut - Use Standard Formula', 'The standard formula SI = (P * R * T) / 100 is already the most efficient and safe method.', 'Trying to use mental math without the formula can lead to errors, e.g., calculating interest for only one year.', '**Full Solution:**
1. Use the formula SI = (P * R * T) / 100.
2. P = 5000, R = 8, T = 3.
3. SI = (5000 * 8 * 3) / 100.
4. SI = 50 * 8 * 3 = 400 * 3 = **₹1,200**.', '- `₹1,000` might be a miscalculation (e.g., 50 * 20).
- `₹1,500` would be the interest at 10%, not 8%.', 'The standard SI formula is universally applicable and safe.'),
('fm_qa_speed_ci_basic_q3r4', 'qa_speed_ci_basic_q3r4', 'Successive Percentage Change Method', 'For 2 years at 10%, the effective CI rate is (10 + 10 + (10*10)/100) = 21%.
CI = 21% of 5,000 = **₹1,050**.', 'Calculating simple interest (20%) is a common trap.', '**Full Solution:**
1. Amount after 1st year: 5000 * 1.10 = 5500.
2. Amount after 2nd year: 5500 * 1.10 = 6050.
3. Compound Interest = Final Amount - Principal = 6050 - 5000 = **₹1,050**.', '- `₹1,000` is the Simple Interest.
- `₹1,100` would be the CI if the rate was higher or principal was different.', 'The successive percentage formula `A+B+AB/100` is safe for 2-year compound interest problems.'),
-- ... (rest of fast methods)
-- Chemistry Fast Methods (Transformed)
('fm_chem10_nacl_molarity_c1a1', 'chem10_nacl_molarity_c1a1', 'Recognize Molar Mass of NaCl', '58.5 g is exactly 1 mole of NaCl. For 1 L of water, this is almost exactly 1.0 M.', 'Not recognizing that 58.5g is the molar mass of NaCl, leading to needless calculation.', '1. **Calculate Molar Mass of NaCl:** 23 (Na) + 35.5 (Cl) = 58.5 g/mol.
2. **Calculate Moles:** Moles = Mass / Molar Mass = 58.5 g / 58.5 g/mol = 1 mol.
3. **Calculate Molarity:** Molarity = Moles / Volume (L) = 1 mol / 1 L = **1.0 M**.', '- **A (0.5 M):** Assumes half a mole was used.
- **C (2.0 M):** Assumes two moles were used.
- **D (58.5 M):** Confuses the given mass directly with molarity.', 'This shortcut is safe when the given mass is an easy multiple of the molar mass and the volume is close to 1 L.'),
('fm_chem10_h2o_molecules_d2b2', 'chem10_h2o_molecules_d2b2', 'Recognize Molar Mass of Water', '18 g is exactly 1 mole of H₂O. 1 mole of any substance contains Avogadro''s number of molecules.', 'Calculating moles unnecessarily when the mass given is exactly the molar mass.', '1. **Calculate Molar Mass of H₂O:** (2 * 1) + 16 = 18 g/mol.
2. **Calculate Moles:** Moles = 18 g / 18 g/mol = 1 mol.
3. **Calculate Molecules:** Molecules = Moles × Avogadro''s Number = 1 × 6.02 × 10²³ = **6.02 × 10²³**.', '- **B:** This is half of Avogadro''s number (0.5 moles).
- **C:** This is double Avogadro''s number (2 moles).
- **D:** Incorrect magnitude.', 'This is always safe. Recognizing the molar mass is key.')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  justification = EXCLUDED.justification,
  pitfall_analysis = EXCLUDED.pitfall_analysis,
  full_solution_md = EXCLUDED.full_solution_md,
  why_others_wrong_md = EXCLUDED.why_others_wrong_md,
  validity_notes_md = EXCLUDED.validity_notes_md;
