# Zion

Zion is the church manager system.

#### Reasons why
Churches works like enterprise. Has people, roles, hierarchy, money, departments, organization and etc.
It's really works like an enterprise and, because of it, has the same problems.
When I searched systems like Zion I was found nothing free. 
So, with the community power this system will be the most church system ever.

##### Dependencies:
* Ruby 2.5.1
* NodeJS
* PostgreSql 11.5
* Rails 5.1.6
* pg_dump 11.5

#### How to contribute
**open an issue** -> **commit** -> **git push** -> **CI passed** -> **require code review** -> **if all ok merge**

#### CI/CD
Today we use Wercker for while. 
https://app.wercker.com/josuehenrique/zion/runs

#### Link to "production" APP
http://zion.herokuapp.com/users/sign_in

**Obs.:** 
1. MERGES ON MASTER STARTS **AUTOMATICALLY** PRODUCTION DEPLOY
2. IF YOU CHANGE DATABASE **COMMIT** THE SCHEMA AND THE ANNOTATE
