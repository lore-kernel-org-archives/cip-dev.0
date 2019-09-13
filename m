From: gitlab@mg.gitlab.com (Ben Hutchings)
Date: Fri, 13 Sep 2019 21:15:17 +0000
Subject: [cip-dev]
 [Git][cip-project/cip-kernel/cip-kernel-sec][bwh/update-issues] Add comment
 about likely un-exploitability of CVE-2019-16089
Message-ID: <5d7c06e588f60_7dac3f9b65c12150134061@sidekiq-asap-04-sv-gprd.mail>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org



Ben Hutchings pushed to branch bwh/update-issues at cip-project / cip-kernel / cip-kernel-sec


Commits:
7390255e by Ben Hutchings at 2019-09-13T21:14:59Z
Add comment about likely un-exploitability of CVE-2019-16089

Signed-off-by: Ben Hutchings &lt;ben.hutchings at codethink.co.uk&gt;

- - - - -


1 changed file:

- issues/CVE-2019-16089.yml


Changes:

=====================================
issues/CVE-2019-16089.yml
=====================================
@@ -4,3 +4,10 @@ references:
 - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16089
 introduced-by:
   mainline: [47d902b90a32a42a3d33aef3a02170fc6f70aa23]
+comment:
+  bwh: |
+    nla_nest_start() will only fail if there is insufficient space in
+    the given skb.  This does seem to be possible in theory, as the
+    size nbd_genl_status() requests does not account for the size of
+    nested attribute headers.  In practice skb sizes are cache-line-
+    aligned and that will probably avoid failure at this point.



View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/commit/7390255eca6fabbaba6f471f4203224937287ff0

-- 
View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/commit/7390255eca6fabbaba6f471f4203224937287ff0
You're receiving this email because of your account on gitlab.com.


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190913/6a1aca85/attachment-0001.html>
