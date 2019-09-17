From: gitlab@mg.gitlab.com (Ben Hutchings)
Date: Tue, 17 Sep 2019 15:46:21 +0000
Subject: [cip-dev] [Git][cip-project/cip-kernel/cip-kernel-sec][master] Fix
 wrong field name in CVE-2019-16089
Message-ID: <5d80ffcdeccea_68983fd7bc1ff7ec2735a@sidekiq-asap-02-sv-gprd.mail>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org



Ben Hutchings pushed to branch master at cip-project / cip-kernel / cip-kernel-sec


Commits:
fd9cebc2 by Ben Hutchings at 2019-09-17T15:46:15Z
Fix wrong field name in CVE-2019-16089

Signed-off-by: Ben Hutchings &lt;ben.hutchings at codethink.co.uk&gt;

- - - - -


1 changed file:

- issues/CVE-2019-16089.yml


Changes:

=====================================
issues/CVE-2019-16089.yml
=====================================
@@ -4,7 +4,7 @@ references:
 - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16089
 introduced-by:
   mainline: [47d902b90a32a42a3d33aef3a02170fc6f70aa23]
-comment:
+comments:
   bwh: |
     nla_nest_start() will only fail if there is insufficient space in
     the given skb.  This does seem to be possible in theory, as the



View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/commit/fd9cebc286cd842458d7024ab40e3a64c902130d

-- 
View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/commit/fd9cebc286cd842458d7024ab40e3a64c902130d
You're receiving this email because of your account on gitlab.com.


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190917/c7486f40/attachment-0001.html>
