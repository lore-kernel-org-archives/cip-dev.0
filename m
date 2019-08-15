From: gitlab@mg.gitlab.com (Ben Hutchings)
Date: Thu, 15 Aug 2019 19:49:51 +0000
Subject: [cip-dev]
 [Git][cip-project/cip-kernel/cip-kernel-sec][bwh/update-issues] Record
 fixed-by commit for CVE-2019-14763
Message-ID: <5d55b75fe1a2e_243f3fa0eb9924d054151fe@sidekiq-asap-04-sv-gprd.mail>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org



Ben Hutchings pushed to branch bwh/update-issues at cip-project / cip-kernel / cip-kernel-sec


Commits:
e0079ecc by Ben Hutchings at 2019-08-15T19:49:05Z
Record fixed-by commit for CVE-2019-14763

Signed-off-by: Ben Hutchings &lt;ben.hutchings at codethink.co.uk&gt;

- - - - -


1 changed file:

- issues/CVE-2019-14763.yml


Changes:

=====================================
issues/CVE-2019-14763.yml
=====================================
@@ -20,6 +20,8 @@ comments:
     c91815b59624.
 reporters:
 - Tuba Yavuz
+introduced-by:
+  mainline: [15b8d9332b927d76a0b26cf70c564756d1648133]
 fixed-by:
   linux-4.14.y: [59d3a952e4f3d505f9444e86db069081323351c7]
   mainline: [c91815b596245fd7da349ecc43c8def670d2269e]



View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/commit/e0079eccbca56651ecf4f5e112451d22ecfe11d7

-- 
View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/commit/e0079eccbca56651ecf4f5e112451d22ecfe11d7
You're receiving this email because of your account on gitlab.com.


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190815/f8e8740d/attachment.html>
