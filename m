From: gitlab@mg.gitlab.com (Ben Hutchings)
Date: Fri, 30 Nov 2018 18:44:01 +0000
Subject: [cip-dev] [Git][cip-project/cip-kernel/cip-kernel-sec][master] 3
 commits: Import data from stable
Message-ID: <5c0184f1ce95c_6e003fcb03d521f0695824@sidekiq-asap-05-sv-gprd.mail>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Ben Hutchings pushed to branch master at cip-project / cip-kernel / cip-kernel-sec


Commits:
8c40df68 by Ben Hutchings at 2018-11-22T19:41:46Z
Import data from stable

- - - - -
3da94bb0 by Ben Hutchings at 2018-11-22T20:10:29Z
webview: Abbreviate link text for references

We don&#39;t have any description of what each reference is specifically
about, so currently we use the URL as the link text.  This can be
quite hard to read.

Generally the most significant parts of the URL are at the beginning
(hostname) and end (query part or last path part).  Add a &quot;urlabbrev&quot;
filter that drops the scheme and replaces any other insignificant
part with an ellipsis.  Use it in the issue template.

- - - - -
cfd826db by Ben Hutchings at 2018-11-30T18:43:37Z
Fill in and correct commit lists for various issues

- - - - -


8 changed files:

- issues/CVE-2017-18261.yml
- issues/CVE-2018-1094.yml
- issues/CVE-2018-1128.yml
- issues/CVE-2018-18710.yml
- issues/CVE-2018-18955.yml
- issues/CVE-2018-5391.yml
- scripts/templates/issue.html
- scripts/webview.py


Changes:

=====================================
issues/CVE-2017-18261.yml
=====================================
@@ -15,6 +15,6 @@ comments:
     "arm64: arch_timer: Allows a CPU-specific erratum to only affect a
     subset of CPUs".
 introduced-by:
-  mainline: [96b3d28bf4b00f62fc8386ff5d487d1830793a3d]
+  mainline: [6acc71ccac7187fc0ef85f10bd09c2058f21fab5]
 fixed-by:
   mainline: [adb4f11e0a8f4e29900adb2b7af28b6bbd5c1fa4]


=====================================
issues/CVE-2018-1094.yml
=====================================
@@ -20,6 +20,8 @@ comments:
     but the issue reported for CVE-2018-1094 does not apply to 4.9.
 reporters:
 - Wen Xu
+introduced-by:
+  mainline: [dec214d00e0d78a08b947d7dccdfdb84407a9f4d]
 fixed-by:
   linux-4.14.y: [26dbb30c58ffb85bc015bd5e58831483d50f7d18]
   linux-4.16.y: [114c42aaa63152d31d3c18d5b750de9560f38a63]


=====================================
issues/CVE-2018-1128.yml
=====================================
@@ -14,3 +14,8 @@ fixed-by:
     6daca13d2e72bedaaacfc08f873114c9307d5aea]
 ignore:
   linux-3.16.y: Protocol change is too difficult
+fix-depends-on:
+  0dde584882ade13dc9708d611fbf69b0ae8a9e48: |-
+    Avoids textual conflicts when picking 6daca13d2e72.
+  b3bbd3f2ab19c8ca319003b4b51ce4c4ca74da06: |-
+    Simplifies backporting of 262614c4294d.


=====================================
issues/CVE-2018-18710.yml
=====================================
@@ -1,3 +1,7 @@
 description: 'cdrom: fix improper type cast, which can leat to information leak'
 fixed-by:
+  linux-4.14.y: [a8c254d8e96032d5bb235cb2e777203d9acda09d]
+  linux-4.19.y: [c8099dbf492b565a4f75ae7b8c08b76ca18c4c3f]
+  linux-4.4.y: [661aa0b46dfb23700b569ac319b95e0b0154832f]
+  linux-4.9.y: [8dd745a8799ee01fc67b64fd33cdb44d04eb7e4c]
   mainline: [e4f3aa2e1e67bb48dfbaaf1cad59013d5a5bc276]


=====================================
issues/CVE-2018-18955.yml
=====================================
@@ -3,3 +3,5 @@ fixed-by:
   linux-4.18.y: [bbfed258eb08070e051a1c086282623cc562ff24]
   linux-4.19.y: [9a7a80fb02cc7515b273dbb4249374d6e6a35b70]
   mainline: [d2f007dbe7e4c9583eea6eb04d60001e85c6f1bd]
+introduced-by:
+  mainline: [6397fac4915ab3002dc15aae751455da1a852f25]


=====================================
issues/CVE-2018-5391.yml
=====================================
@@ -31,6 +31,21 @@ comments:
     The commits backported to 4.9.134 are complete and are not introducing
     thus CVE-2018-14641.
 fixed-by:
+  linux-4.14.y: [6093d5abcf5ada86d2bb61bd5154bc144bf5a3aa, 673220d6417de8812b20bfeb4d2f809e05a82463,
+    0cbf74b9519d8f73dd27cc6fad6e03851788f956, 0512f7e93504386cd1223990d9692c20a878d2d9,
+    eb1686ae5e20b4455b80be571e7e41f1c9d7b2ac, 266da0fb83f32e26470017d3eb32cb092b2210ed,
+    11be675bf0aaf4a6dcde817126168b9cbd8ba90e, 33dc9f7c5d127bfc203a17f7a31d4dcc754376df,
+    9aee41eff751e4c789ff785c561d7bf7ad72c286, bd3df633f17d64523828d0ef5d74e4f1a768683c,
+    5b1b3ad46dd100932925e979562aeefaf9ef189e, caa4249eca082c5954ea377aa3ef86b5fc5c1ac1,
+    990204ddc5f67530b2ac616767a5c6937c9fc2af, 085a0147447a4f82138825b6a3a329b997c2fb13,
+    3226bdcb044862084c3bfc3278d148948600ebc4, bd946fb5226e205530bea2581d867642e4b457ed,
+    8291cd943a9b4e2d764a4a294999bbb2f94f153c, 48c2afc16888873da727f9ed7102a620a178fad8,
+    5fff99e88a1f4b4e62fd07bf3eb87305c88f3400, 1c44969111cc68f361638b6e54f5a176609aa05a,
+    7750c414b89bd8204901855bda21c512e269be35, 3bde783eca23d5d3019c220752f5a29083dea27c,
+    5123ffdad65954b3c308e055b388db08987a13ff, 6bf32cda46ebfbaf13da3c48a0a009adae925703,
+    37c7cc80b1d7de36a6ed54796ae30ee091d05eab, 6b921536f1707a240e6f53843f1f26231016fda5,
+    04b28f406e86512a3592664553b5e17efe663ece, c91f27fb571666a176e1446646726f78d4657ddb,
+    b3a0c61b73699b3764a6568e85c67f599158c541, 08fb833b40e361ce927c64d40e348af96996d9eb]
   linux-4.9.y: [7fca77153c5c2a2c59e70720332bce7088aef8e8, 2ffb1c363dfa89858dded0b291f005faf1b72adc,
     bbf6d8604475f36279c7b2d9a1f425654bc24588, dae73e7d73fce8d8d5132ec3c94de16280653fc6,
     1b363f81f38f28bd69ec90837da0f65161f36325, 620018dd713da51daac7ec4cd0ae54b0f0fa0f75,


=====================================
scripts/templates/issue.html
=====================================
@@ -14,7 +14,7 @@
     <td/>
     <td>
       {% for url in issue.references %}
-      <a href="{{ url }}">{{ url }}</a>
+      <a href="{{ url }}">{{ url|urlabbrev }}</a>
       {% if not loop.last %}|{% endif %}
       {% endfor %}
     </td>


=====================================
scripts/webview.py
=====================================
@@ -8,6 +8,7 @@
 
 import argparse
 import os
+import re
 
 import cherrypy
 import jinja2
@@ -16,9 +17,27 @@ import kernel_sec.branch
 import kernel_sec.issue
 
 
+# Match host part and either query part or last path part
+_URL_ABBREV_RE = re.compile(
+    r'^https?://([^/]*/?)(?:([^?]*)(\?.*)|(.*?)(/[^/]*/?))$')
+
+
+def _url_abbrev(value):
+    match = _URL_ABBREV_RE.match(value)
+    if not match:
+        return value
+    elif match.group(2) and match.group(3):
+        return match.expand(r'\1?\3')
+    elif match.group(4) and match.group(5):
+        return match.expand(r'\1?\5')
+    else:
+        return match.expand(r'\1\3\5')
+
+
 _template_env = jinja2.Environment(
     loader=jinja2.FileSystemLoader('scripts/templates'),
     autoescape=True)
+_template_env.filters['urlabbrev'] = _url_abbrev
 
 
 class IssueCache:



View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/compare/2ec5ed1d0367830be1b673d9f05754e98054dd31...cfd826db2fb01bbdc297234e20a6e0add27bffca

-- 
View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/compare/2ec5ed1d0367830be1b673d9f05754e98054dd31...cfd826db2fb01bbdc297234e20a6e0add27bffca
You're receiving this email because of your account on gitlab.com.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20181130/98a7ce87/attachment-0001.html>
