From: gitlab@mg.gitlab.com (Ben Hutchings)
Date: Tue, 27 Aug 2019 17:28:54 +0000
Subject: [cip-dev] [Git][cip-project/cip-kernel/cip-kernel-sec][master] 2
 commits: scripts/import_ubuntu: Accept new Mitigation field
Message-ID: <5d656856d974a_68e63f8219dd5cf4414057bd@sidekiq-asap-02-sv-gprd.mail>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org



Ben Hutchings pushed to branch master at cip-project / cip-kernel / cip-kernel-sec


Commits:
6080d2a0 by Ben Hutchings at 2019-08-23T17:22:39Z
scripts/import_ubuntu: Accept new Mitigation field

The Ubuntu CVE tracker now records mitigation information in a
specific field instead of in general comments.  The importer
currently fails if it finds an unknown field, so we need to add
this to the list of known fields.

Possibly our own schema should be extended similarly, but I&#39;m
not changing that right now.

Signed-off-by: Ben Hutchings &lt;ben.hutchings at codethink.co.uk&gt;

- - - - -
f487d464 by Ben Hutchings at 2019-08-27T17:28:53Z
Merge branch &#39;bwh/update-import-ubuntu&#39; into &#39;master&#39;

scripts/import_ubuntu: Accept new Mitigation field

See merge request cip-project/cip-kernel/cip-kernel-sec!8
- - - - -


1 changed file:

- scripts/import_ubuntu.py


Changes:

=====================================
scripts/import_ubuntu.py
=====================================
@@ -168,9 +168,9 @@ def load_cve(cve, strict=False):
             affected.setdefault(pkg, dict())
             affected[pkg].setdefault(release, [state, notes])
         elif field not in ['References', 'Description', 'Ubuntu-Description',
-                           'Notes', 'Bugs', 'Assigned-to', 'Approved-by',
-                           'PublicDate', 'PublicDateAtUSN', 'CRD',
-                           'Discovered-by']:
+                           'Notes', 'Mitigation', 'Bugs', 'Assigned-to',
+                           'Approved-by', 'PublicDate', 'PublicDateAtUSN',
+                           'CRD', 'Discovered-by']:
             msg += "%s: unknown field '%s'\n" % (cve, field)
             code = EXIT_FAIL
         else:



View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/compare/4b5919c3988089916da67d940810f6c13c10625e...f487d464ae208e322cfb2a4b95afd84f317f0c71

-- 
View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/compare/4b5919c3988089916da67d940810f6c13c10625e...f487d464ae208e322cfb2a4b95afd84f317f0c71
You're receiving this email because of your account on gitlab.com.


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190827/ad666175/attachment.html>
