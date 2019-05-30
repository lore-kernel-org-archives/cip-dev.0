From: gitlab@mg.gitlab.com (Ben Hutchings)
Date: Thu, 30 May 2019 21:25:02 +0000
Subject: [cip-dev] [Git][cip-project/cip-kernel/cip-kernel-sec][master] 5
 commits: Generalise mapping of git remote names
Message-ID: <5cf04a2ec64d4_27803ffd01513504183863d@sidekiq-asap-04-sv-gprd.mail>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org



Ben Hutchings pushed to branch master at cip-project / cip-kernel / cip-kernel-sec


Commits:
4f7cd5fd by Ben Hutchings at 2019-05-30T17:19:46Z
Generalise mapping of git remote names

Use a dictionary subclass to handle arbitrary name mappings for
remotes.  This is preparation for supporting additional remotes and
branches.

- - - - -
0d1b27bb by Ben Hutchings at 2019-05-30T21:02:01Z
Generalise branch support

We currently identify branches only by name and assume that
everything except &quot;mainline&quot; is a stable branch and follows
the naming scheme used for stable.

Before we can support tracking of CIP&#39;s branches, we need
to remove this assumption.

Replace branch names in most places with dictionaries that
specify a short_name (the name used in issue files and in UI),
git_remote, git_name, and base_ver (the stable version that
the branch is based on).  For mainline there is no base_ver
and we will still need to treat it specially in various
places.

- - - - -
ffdb2bcd by Ben Hutchings at 2019-05-30T21:21:10Z
kernel_sec.branch: Add support for config file listing extra branches

- - - - -
d39e424b by Ben Hutchings at 2019-05-30T21:24:45Z
conf/branches.yml: Add CIP stable branch definitions

This finally fixes issue #2.

- - - - -
f15ee18b by Ben Hutchings at 2019-05-30T21:24:55Z
Import data from stable and CIP branches

- - - - -


30 changed files:

- + conf/branches.yml
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
- issues/CVE-2016-2847.yml


The diff was not included because it is too large.


View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/compare/31bbcd8b5ea445976a596fc539b126eb499dc957...f15ee18b75f5e73fad630f261c92d7219c103fee

-- 
View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/compare/31bbcd8b5ea445976a596fc539b126eb499dc957...f15ee18b75f5e73fad630f261c92d7219c103fee
You're receiving this email because of your account on gitlab.com.


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190530/161f12ba/attachment.html>
