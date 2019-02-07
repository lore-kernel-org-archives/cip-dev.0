From: gitlab@mg.gitlab.com (Ben Hutchings)
Date: Thu, 07 Feb 2019 20:27:19 +0000
Subject: [cip-dev] [Git][cip-project/cip-kernel/cip-kernel-sec][master] 6
 commits: Import more data
Message-ID: <5c5c94a7162d6_46ed3f91332592446691b5@sidekiq-asap-03-sv-gprd.mail>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Ben Hutchings pushed to branch master at cip-project / cip-kernel / cip-kernel-sec


Commits:
3fffafb3 by Ben Hutchings at 2019-02-07T16:42:05Z
Import more data

- - - - -
5f1bf29e by Ben Hutchings at 2019-02-07T17:46:29Z
scripts/import_stable.py: Simplify regexp construction using named substitution

Also switch to using format().

- - - - -
e1956732 by Ben Hutchings at 2019-02-07T17:46:31Z
scripts/import_stable.py: Simplify extraction of commit hash from regexp match

Exactly one group must match, so if we substitute &#39;&#39; (instead of None)
for non-matching groups we can get the right result by concatenate all
the group matches.

- - - - -
6ea4c540 by Ben Hutchings at 2019-02-07T17:46:31Z
scripts/import_stable.py: Add yet another form of upstream commit reference

- - - - -
47d0ae41 by Ben Hutchings at 2019-02-07T17:48:19Z
scripts/import_stable.py: Add debug output to get_backports()

- - - - -
2673ace4 by Ben Hutchings at 2019-02-07T20:26:17Z
Mark several issues as fixed or ignored

- - - - -


30 changed files:

- + issues/CVE-2016-10741.yml
- issues/CVE-2017-18249.yml
- issues/CVE-2018-1066.yml
- issues/CVE-2018-10876.yml
- issues/CVE-2018-10877.yml
- issues/CVE-2018-10878.yml
- issues/CVE-2018-10879.yml
- issues/CVE-2018-10880.yml
- issues/CVE-2018-10882.yml
- issues/CVE-2018-10883.yml
- issues/CVE-2018-13096.yml
- issues/CVE-2018-13097.yml
- issues/CVE-2018-13099.yml
- issues/CVE-2018-13100.yml
- issues/CVE-2018-14614.yml
- issues/CVE-2018-14616.yml
- issues/CVE-2018-14625.yml
- issues/CVE-2018-16862.yml
- + issues/CVE-2018-16880.yml
- issues/CVE-2018-16882.yml
- issues/CVE-2018-17972.yml
- issues/CVE-2018-18281.yml
- issues/CVE-2018-18690.yml
- issues/CVE-2018-19407.yml
- issues/CVE-2018-19824.yml
- issues/CVE-2018-19854.yml
- issues/CVE-2018-20169.yml
- + issues/CVE-2018-20669.yml
- issues/CVE-2019-3459.yml
- issues/CVE-2019-3460.yml


The diff was not included because it is too large.


View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/compare/f97cfc8c21d00e91e0a96b230f6a39a04c45c1b0...2673ace439e64574f09d38e7fcd8e87b2b673ce5

-- 
View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/compare/f97cfc8c21d00e91e0a96b230f6a39a04c45c1b0...2673ace439e64574f09d38e7fcd8e87b2b673ce5
You're receiving this email because of your account on gitlab.com.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190207/28259332/attachment.html>
