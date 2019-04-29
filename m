From: gitlab@mg.gitlab.com (Ben Hutchings)
Date: Mon, 29 Apr 2019 19:06:23 +0000
Subject: [cip-dev] [Git][cip-project/cip-kernel/cip-kernel-sec][master] 5
 commits: Import more data
Message-ID: <5cc74b2f40322_67f13fa64a5d6b98178774d@sidekiq-asap-01-sv-gprd.mail>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org



Ben Hutchings pushed to branch master at cip-project / cip-kernel / cip-kernel-sec


Commits:
99533ea4 by Ben Hutchings at 2019-04-29T14:38:50Z
Import more data

- - - - -
74f0225b by Ben Hutchings at 2019-04-29T15:25:21Z
webview: Consistently refer to issues under /issue/ path

The template for the per-branch list of issues uses URL paths starting
with /issues/ whereas other views use /issue/.  Both work but we
should be consistent so that browser history works.

- - - - -
0bddd67a by Ben Hutchings at 2019-04-29T16:50:21Z
Remove obsolete comment on CVE-2018-3639

- - - - -
4ddb2948 by Ben Hutchings at 2019-04-29T19:05:38Z
Fill in introduced-by for many issues

- - - - -
2d32b073 by Ben Hutchings at 2019-04-29T19:05:42Z
Triage two issues

- - - - -


30 changed files:

- issues/CVE-2015-8553.yml
- issues/CVE-2016-10150.yml
- issues/CVE-2016-10741.yml
- issues/CVE-2017-1000379.yml
- issues/CVE-2017-1000410.yml
- issues/CVE-2017-18241.yml
- issues/CVE-2017-18249.yml
- issues/CVE-2017-9725.yml
- issues/CVE-2018-10087.yml
- issues/CVE-2018-10124.yml
- issues/CVE-2018-1120.yml
- issues/CVE-2018-11987.yml
- issues/CVE-2018-12929.yml
- issues/CVE-2018-12930.yml
- issues/CVE-2018-12931.yml
- issues/CVE-2018-13097.yml
- issues/CVE-2018-13099.yml
- issues/CVE-2018-13100.yml
- issues/CVE-2018-14610.yml
- issues/CVE-2018-14611.yml
- issues/CVE-2018-14612.yml
- issues/CVE-2018-14613.yml
- issues/CVE-2018-14614.yml
- issues/CVE-2018-14616.yml
- issues/CVE-2018-14678.yml
- issues/CVE-2018-16880.yml
- issues/CVE-2018-16884.yml
- issues/CVE-2018-18021.yml
- issues/CVE-2018-18397.yml
- issues/CVE-2018-19824.yml


The diff was not included because it is too large.


View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/compare/8c45b2e3c8bfcab3413ff0b727a62a689ff7c1b8...2d32b073ebe4de60a4208ab0d449ff0c60c51537

-- 
View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/compare/8c45b2e3c8bfcab3413ff0b727a62a689ff7c1b8...2d32b073ebe4de60a4208ab0d449ff0c60c51537
You're receiving this email because of your account on gitlab.com.


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190429/9510af91/attachment-0001.html>
