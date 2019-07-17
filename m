From: gitlab@mg.gitlab.com (Ben Hutchings)
Date: Wed, 17 Jul 2019 19:27:25 +0000
Subject: [cip-dev] [Git][cip-project/cip-kernel/cip-kernel-sec][master] 2
 commits: Import more data
Message-ID: <5d2f769dd505f_25593fce469ef4a46274a9@sidekiq-asap-04-sv-gprd.mail>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org



Ben Hutchings pushed to branch master at cip-project / cip-kernel / cip-kernel-sec


Commits:
8289dcc5 by Ben Hutchings at 2019-07-17T19:14:35Z
Import more data

- - - - -
71a51636 by Ben Hutchings at 2019-07-17T19:27:12Z
Add linux-4.{4,19}.y-cip-rt branches to config and issue status

The -cip-rt branches may (and currently do) lag behind the other -cip
branches and therefore may be affected by a different set of security
issues.

Add them to the branch config, and fill in the status of these
branches in all issues.

Closes #5.

- - - - -


30 changed files:

- conf/branches.yml
- issues/CVE-2015-8553.yml
- issues/CVE-2015-8709.yml
- issues/CVE-2015-8839.yml
- issues/CVE-2016-0723.yml
- issues/CVE-2016-10044.yml
- issues/CVE-2016-10088.yml
- issues/CVE-2016-10147.yml
- issues/CVE-2016-10200.yml
- issues/CVE-2016-10208.yml
- issues/CVE-2016-10229.yml
- issues/CVE-2016-10318.yml
- issues/CVE-2016-10741.yml
- issues/CVE-2016-1583.yml
- issues/CVE-2016-2069.yml
- issues/CVE-2016-2085.yml
- issues/CVE-2016-2184.yml
- issues/CVE-2016-2185.yml
- issues/CVE-2016-2186.yml
- issues/CVE-2016-2187.yml
- issues/CVE-2016-2188.yml
- issues/CVE-2016-2384.yml
- issues/CVE-2016-2543.yml
- issues/CVE-2016-2544.yml
- issues/CVE-2016-2545.yml
- issues/CVE-2016-2546.yml
- issues/CVE-2016-2547.yml
- issues/CVE-2016-2548.yml
- issues/CVE-2016-2549.yml
- issues/CVE-2016-2782.yml


The diff was not included because it is too large.


View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/compare/d202dc5b8e2a3b2e9a8c196891b8667d964a662f...71a5163608b30bff51cdf39f2a4f8b8ae261ac36

-- 
View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/compare/d202dc5b8e2a3b2e9a8c196891b8667d964a662f...71a5163608b30bff51cdf39f2a4f8b8ae261ac36
You're receiving this email because of your account on gitlab.com.


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190717/2ea49d4e/attachment.html>
