From: gitlab@mg.gitlab.com (Ben Hutchings)
Date: Mon, 24 Jun 2019 15:41:21 +0000
Subject: [cip-dev] [Git][cip-project/cip-kernel/cip-kernel-sec][master] 2
 commits: Ignore CVE-2019-0157 as it relates to an out-of-tree driver
Message-ID: <5d10ef21e40f4_2bed3fa922b00cec66054e@sidekiq-asap-01-sv-gprd.mail>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org



Ben Hutchings pushed to branch master at cip-project / cip-kernel / cip-kernel-sec


Commits:
fd56a750 by Ben Hutchings at 2019-06-24T15:40:59Z
Ignore CVE-2019-0157 as it relates to an out-of-tree driver

- - - - -
c96dfc60 by Ben Hutchings at 2019-06-24T15:41:17Z
Add description for CVE-2019-12881

- - - - -


2 changed files:

- issues/CVE-2019-0157.yml
- issues/CVE-2019-12881.yml


Changes:

=====================================
issues/CVE-2019-0157.yml
=====================================
@@ -5,3 +5,5 @@ description: |-
 references:
 - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-0157
 - https://www.intel.com/content/www/us/en/security-center/advisory/intel-sa-00235.html?wapkw=cve-2019-0157
+ignore:
+  all: Issue is in out-of-tree driver


=====================================
issues/CVE-2019-12881.yml
=====================================
@@ -1,4 +1,4 @@
-description: ''
+description: 'i915_gem_userptr_get_pages allows local users to cause a denial of service (NULL pointer dereference and BUG)'
 references:
 - https://gist.github.com/oxagast/472866fb2c3d439e10499d7141d0a520
 - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-12881



View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/compare/dc96f854ab41d10385d0c90aae5efc0402d5f9ed...c96dfc60475bb62048934a491a2eda588dbdfe1f

-- 
View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/compare/dc96f854ab41d10385d0c90aae5efc0402d5f9ed...c96dfc60475bb62048934a491a2eda588dbdfe1f
You're receiving this email because of your account on gitlab.com.


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190624/2f373813/attachment.html>
