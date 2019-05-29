From: gitlab@mg.gitlab.com (Ben Hutchings)
Date: Wed, 29 May 2019 23:10:56 +0000
Subject: [cip-dev] [Git][cip-project/cip-kernel/cip-kernel-sec][master] 6
 commits: Import more data
Message-ID: <5cef1180adb32_540c3fa625d3e9c86476a@sidekiq-asap-01-sv-gprd.mail>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org



Ben Hutchings pushed to branch master at cip-project / cip-kernel / cip-kernel-sec


Commits:
8769119d by Ben Hutchings at 2019-05-27T20:33:11Z
Import more data

- - - - -
2442ae80 by Ben Hutchings at 2019-05-29T23:06:37Z
Mark CVE-2019-9500 as not fixed in linux-3.16.y

CVE-2019-9500 didn&#39;t affect Linux 3.16, but the stable branch has an
incorrect backport of the fix for it that has now been reverted.
Since import_stable.py doesn&#39;t (yet) recognise and take account of
reverts, explicitly mark this as never fixed in linux-3.16.y so that
the next run won&#39;t re-add the incorrect backport here.

- - - - -
fc2cff50 by Ben Hutchings at 2019-05-29T23:09:25Z
Delete CVE-2019-3892 which was rejected as a duplicate

- - - - -
b5494a69 by Ben Hutchings at 2019-05-29T23:09:25Z
Add or correct fixed-by and introduced-by commits for several issues

- - - - -
a05ead70 by Ben Hutchings at 2019-05-29T23:09:25Z
Mark CVE-2018-20509 to be ignored

- - - - -
31bbcd8b by Ben Hutchings at 2019-05-29T23:09:26Z
Note other fixes related to CVE-2018-20510

- - - - -


30 changed files:

- issues/CVE-2017-5967.yml
- + issues/CVE-2018-12126.yml
- + issues/CVE-2018-12127.yml
- + issues/CVE-2018-12130.yml
- issues/CVE-2018-16884.yml
- + issues/CVE-2018-20509.yml
- + issues/CVE-2018-20510.yml
- + issues/CVE-2018-20836.yml
- issues/CVE-2018-5995.yml
- + issues/CVE-2018-7191.yml
- + issues/CVE-2018-ebpf-filter-dos.yml
- issues/CVE-2019-10125.yml
- + issues/CVE-2019-10142.yml
- + issues/CVE-2019-11085.yml
- + issues/CVE-2019-11091.yml
- issues/CVE-2019-11190.yml
- issues/CVE-2019-11191.yml
- issues/CVE-2019-11486.yml
- issues/CVE-2019-11487.yml
- issues/CVE-2019-3892.yml ? issues/CVE-2019-11599.yml
- + issues/CVE-2019-11683.yml
- + issues/CVE-2019-11810.yml
- + issues/CVE-2019-11811.yml
- + issues/CVE-2019-11815.yml
- + issues/CVE-2019-11833.yml
- + issues/CVE-2019-11884.yml
- + issues/CVE-2019-1999.yml
- issues/CVE-2019-2024.yml
- issues/CVE-2019-3459.yml
- issues/CVE-2019-3460.yml


The diff was not included because it is too large.


View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/compare/2d32b073ebe4de60a4208ab0d449ff0c60c51537...31bbcd8b5ea445976a596fc539b126eb499dc957

-- 
View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/compare/2d32b073ebe4de60a4208ab0d449ff0c60c51537...31bbcd8b5ea445976a596fc539b126eb499dc957
You're receiving this email because of your account on gitlab.com.


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190529/6d131e6d/attachment.html>
