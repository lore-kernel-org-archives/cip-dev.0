From: gitlab@mg.gitlab.com (Ben Hutchings)
Date: Tue, 18 Dec 2018 20:51:29 +0000
Subject: [cip-dev] [Git][cip-project/cip-kernel/cip-kernel-sec][master]
 kernel_sec.isssue: Fix sorting of 7-digit CVE IDs
Message-ID: <5c195dd156f92_40fa3f9a0f8462bc229245@sidekiq-asap-02-sv-gprd.mail>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Ben Hutchings pushed to branch master at cip-project / cip-kernel / cip-kernel-sec


Commits:
9f9d7040 by Ben Hutchings at 2018-12-18T20:45:55Z
kernel_sec.isssue: Fix sorting of 7-digit CVE IDs

DWF (Distributed Weakness Filing) assigns IDs with 7 &quot;arbitrary digits&quot;
so we should pad shorter IDs accordingly.

- - - - -


1 changed file:

- scripts/kernel_sec/issue.py


Changes:

=====================================
scripts/kernel_sec/issue.py
=====================================
@@ -295,9 +295,9 @@ def save(cve_id, issue):
 _cve_id_arbdig_re = re.compile(r'-(\d+)$')
 
 
-# Pad "arbitrary digits" to 6 digits so string comparison works
+# Pad "arbitrary digits" to 7 digits so string comparison works
 def get_id_sort_key(cve_id):
-    return _cve_id_arbdig_re.sub(lambda m: '-%06d' % int(m.group(1)), cve_id)
+    return _cve_id_arbdig_re.sub(lambda m: '-%07d' % int(m.group(1)), cve_id)
 
 
 def affects_branch(issue, branch, is_commit_in_branch):



View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/commit/9f9d70405033878c810b65e392d382c674765300

-- 
View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/commit/9f9d70405033878c810b65e392d382c674765300
You're receiving this email because of your account on gitlab.com.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20181218/a271fd56/attachment-0001.html>
