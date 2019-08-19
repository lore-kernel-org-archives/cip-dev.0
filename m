From: gitlab@mg.gitlab.com (Ben Hutchings)
Date: Mon, 19 Aug 2019 13:45:44 +0000
Subject: [cip-dev] [Git][cip-project/cip-kernel/cip-kernel-sec][master] 7
 commits: Import more data
Message-ID: <5d5aa80885ce7_2e583f9813e7d26412099456@sidekiq-asap-03-sv-gprd.mail>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org



Ben Hutchings pushed to branch master at cip-project / cip-kernel / cip-kernel-sec


Commits:
459fd073 by Ben Hutchings at 2019-08-14T18:28:58Z
Import more data

Signed-off-by: Ben Hutchings &lt;ben.hutchings at codethink.co.uk&gt;

- - - - -
79ccb47e by Ben Hutchings at 2019-08-14T18:29:49Z
Delete duplicate of CVE-2017-18509

This issue was assigned CVE-2017-18509 and renamed in Debian&#39;s
kernel_sec repo, but import_debian.py isn&#39;t smart enough to handle
name changes.

Signed-off-by: Ben Hutchings &lt;ben.hutchings at codethink.co.uk&gt;

- - - - -
36b13fa6 by Ben Hutchings at 2019-08-14T18:42:23Z
Record stable fixes for CVE-2019-1125

The stable commits don&#39;t correspond 1:1 to the upstream fixes:

- The documentation update coulddn&#39;t be applied to some branches, and
  isn&#39;t strictly needed
- In some backports the JMPQ?JMP fix was squashed into the patch that
  it fixes

Signed-off-by: Ben Hutchings &lt;ben.hutchings at codethink.co.uk&gt;

- - - - -
c2f5ee8a by Ben Hutchings at 2019-08-14T18:45:35Z
Record introduced-by commits for the TCP reconnect use-after-free

This is a stable-only issue so import_stable.py can&#39;t handle it
automatically.

Signed-off-by: Ben Hutchings &lt;ben.hutchings at codethink.co.uk&gt;

- - - - -
efde8891 by Ben Hutchings at 2019-08-14T18:53:14Z
Update fixed-by commits for CVE-2019-10638

As I understand it, the complete fix for weak randomisation of IP ID
generation was to switch from jhash to siphash.  The previously
identified commits improved it a bit but not enough to consider this
fixed.

Signed-off-by: Ben Hutchings &lt;ben.hutchings at codethink.co.uk&gt;

- - - - -
e0079ecc by Ben Hutchings at 2019-08-15T19:49:05Z
Record fixed-by commit for CVE-2019-14763

Signed-off-by: Ben Hutchings &lt;ben.hutchings at codethink.co.uk&gt;

- - - - -
a0b90b8d by Ben Hutchings at 2019-08-19T13:45:42Z
Merge branch &#39;bwh/update-issues&#39; into &#39;master&#39;

Update issues

See merge request cip-project/cip-kernel/cip-kernel-sec!5
- - - - -


30 changed files:

- issues/CVE-2017-ipv6-mroute-type-check.yml ? issues/CVE-2017-18509.yml
- issues/CVE-2018-10322.yml
- issues/CVE-2018-13053.yml
- issues/CVE-2018-13093.yml
- issues/CVE-2018-13096.yml
- issues/CVE-2018-13097.yml
- issues/CVE-2018-13098.yml
- issues/CVE-2018-13099.yml
- issues/CVE-2018-13100.yml
- issues/CVE-2018-14609.yml
- issues/CVE-2018-14610.yml
- issues/CVE-2018-14611.yml
- issues/CVE-2018-14612.yml
- issues/CVE-2018-14613.yml
- issues/CVE-2018-14614.yml
- issues/CVE-2018-14615.yml
- issues/CVE-2018-14616.yml
- issues/CVE-2018-14617.yml
- issues/CVE-2018-16862.yml
- issues/CVE-2018-20169.yml
- issues/CVE-2018-20511.yml
- issues/CVE-2018-20836.yml
- issues/CVE-2018-20856.yml
- + issues/CVE-2018-20961.yml
- issues/CVE-2019-0136.yml
- issues/CVE-2019-10126.yml
- issues/CVE-2019-10207.yml
- issues/CVE-2019-10638.yml
- + issues/CVE-2019-1125.yml
- issues/CVE-2019-11599.yml


The diff was not included because it is too large.


View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/compare/3c031569f053f87070fd40d8c1020efc775b4480...a0b90b8daa35d484414f7b75e98a1a712a072cb5

-- 
View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/compare/3c031569f053f87070fd40d8c1020efc775b4480...a0b90b8daa35d484414f7b75e98a1a712a072cb5
You're receiving this email because of your account on gitlab.com.


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190819/ec4fc677/attachment.html>
