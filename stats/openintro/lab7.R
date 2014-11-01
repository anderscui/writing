
# url <- 'http://www.openintro.org/stat/data/evals.RData'
# file <- 'evals.RData'
# 
# download.file(url, file)

file <- 'evals.RData'
load(file)

# Q3
summary(evals$score)
#sort(evals$score)
hist(evals$score)

# Q4
plot(evals$score ~ evals$bty_avg)

#j_score = jitter(evals$score)
#plot(j_score ~ evals$bty_avg)
m_bty = lm(evals$score ~ evals$bty_avg)
abline(m_bty)

summary(m_bty)


# Q5
plot(evals$bty_avg, resid(m_bty))
abline(0, 0)
hist(resid(m_bty))

# Q6
plot(evals$bty_avg ~ evals$bty_f1lower)
cor(evals$bty_avg, evals$bty_f1lower)

plot(evals[,13:19])

m_bty_gen <- lm(score ~ bty_avg + gender, data = evals)
#summary(m_bty_gen)

plot(resid(m_bty))

multiLines(m_bty_gen)

# Q8
teaching <- subset(evals, rank == 'teaching')
tenure_track <- subset(evals, rank == 'tenure track')
tenured <- subset(evals, rank == 'tenured')


m_bty_rank <- lm(score ~ bty_avg + rank, data = evals)
multiLines(m_bty_rank)

# Q9
m_full <- lm(score ~ rank + ethnicity + gender + language + age + cls_perc_eval
             + cls_students + cls_level + cls_profs + cls_credits + bty_avg, data = evals)
summary(m_full)


# Q10
# - rank -> 0.1417
m1 <- lm(score ~ ethnicity + gender + language + age + cls_perc_eval
         + cls_students + cls_level + cls_profs + cls_credits + bty_avg, data = evals)
summary(m1)$adj.r.squared

# - ethnicity -> 0.132
m2 = lm(score ~ rank + gender + language + age + cls_perc_eval +
          cls_students + cls_level + cls_profs + cls_credits + bty_avg, data = evals)
summary(m2)$adj.r.squared

# - bty_avg -> 0.1174
m3 <- lm(score ~ rank + ethnicity + gender + language + age + cls_perc_eval
             + cls_students + cls_level + cls_profs + cls_credits, data = evals)
summary(m3)$adj.r.squared

# - cls_profs -> 0.1430
m4 <- lm(score ~ rank + ethnicity + gender + language + age + cls_perc_eval
             + cls_students + cls_level + cls_credits + bty_avg, data = evals)
summary(m4)$adj.r.squared

# - cls_students -> 0.1401
m5 <- lm(score ~ rank + ethnicity + gender + language + age + cls_perc_eval
             + cls_level + cls_profs + cls_credits + bty_avg, data = evals)
summary(m5)$adj.r.squared