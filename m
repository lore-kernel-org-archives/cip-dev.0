From: gitlab@mg.gitlab.com (Ben Hutchings)
Date: Tue, 05 Feb 2019 14:02:12 +0000
Subject: [cip-dev] [Git][cip-project/cip-kernel/cip-kernel-sec][master] 2
 commits: This issue has been fixed in mainline, kernel 4.4, 4.9,
 4.14 and 4.19
Message-ID: <5c59976426370_2ce3fee4275745053036c@sidekiq-asap-02-sv-gprd.mail>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Ben Hutchings pushed to branch master at cip-project / cip-kernel / cip-kernel-sec


Commits:
9da92a37 by SZ Lin (???) at 2019-01-31T08:53:23Z
This issue has been fixed in mainline, kernel 4.4, 4.9, 4.14 and 4.19

- - - - -
41754e09 by Ben Hutchings at 2019-02-05T14:02:11Z
Merge branch &#39;master&#39; into &#39;master&#39;

Update status of CVE-2019-3701.yml

See merge request cip-project/cip-kernel/cip-kernel-sec!2
- - - - -


1 changed file:

- issues/CVE-2019-3701.yml


Changes:

=====================================
issues/CVE-2019-3701.yml
=====================================
@@ -25,3 +25,9 @@ reporters:
 - Marcus Meissner
 introduced-by:
   mainline: [c1aabdf379bc2feeb0df7057ed5bad96f492133e]
+fixed-by:
+  linux-4.14.y: [39ff087b5c6be2ff0b08e617d334e5bf72a08b44]
+  linux-4.19.y: [8db82a6f2b76d42ec2615f8def6e797e064e7822]
+  linux-4.4.y: [693ae291197429f404e7d9c191e1541f61925278]
+  linux-4.9.y: [d379b338387e3d5a9b5ebe5ab16656a9c65c988d]
+  mainline: [0aaa81377c5a01f686bcdb8c7a6929a7bf330c68]



View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/compare/8624a9e912d7d854e6157ab942adc1132e4e4bfb...41754e091a6b0befc10591ddab56a3c95193773f

-- 
View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/compare/8624a9e912d7d854e6157ab942adc1132e4e4bfb...41754e091a6b0befc10591ddab56a3c95193773f
You're receiving this email because of your account on gitlab.com.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190205/976b82cd/attachment.html>
