From: gitlab@mg.gitlab.com (Ben Hutchings)
Date: Fri, 14 Jun 2019 13:16:41 +0000
Subject: [cip-dev] [Git][cip-project/cip-kernel/cip-kernel-sec][master] Add
 fixes on CIP branches that import_stable missed
Message-ID: <5d039e3944560_30d53f8fae0bd8e4330101b@sidekiq-asap-01-sv-gprd.mail>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org



Ben Hutchings pushed to branch master at cip-project / cip-kernel / cip-kernel-sec


Commits:
62cfaf0f by Ben Hutchings at 2019-06-14T13:16:12Z
Add fixes on CIP branches that import_stable missed

In these cases the stable fix commits didn&#39;t exactly correspond to the
upstream commits.

- - - - -


5 changed files:

- issues/CVE-2018-12126.yml
- issues/CVE-2018-12127.yml
- issues/CVE-2018-12130.yml
- issues/CVE-2019-11091.yml
- issues/CVE-2019-5489.yml


Changes:

=====================================
issues/CVE-2018-12126.yml
=====================================
@@ -111,6 +111,18 @@ fixed-by:
     f223c10cf17689353a41e052bfc16c9ac4758132, adef560d1ef8ab84aceee8b6ebae6f515c2b7a66,
     179adc415f947eb64eb12a15c90d0d8da09418b9, 8be7f1183d2f113d82c0c68a5e23a44d7fb8a8b6,
     683f9fba8c27817b6c2f7320a4095ca353022651]
+  linux-4.4.y-cip: [a50e2ca5757f54fc5b0eabbb77a509209cbcc40d, 31a2c5f7a25b1cf4739ccd0244b0b270c42dab89,
+    71041afe26a30d8a5bfb75ff5699c9cfdee5250a, 693eb3bdaf19dd58aea99a5ed088dd6319ecc098,
+    0f961ec593057bad865d3a9f6834c0ca1582d486, 3092ad5c4f2ed6925847273a65c5598a73ee88d8,
+    2b26dff34698b8f4b57c5492c17a3fcf71e32de6, 0144cbc1247411f6fa07447ce9a4ae204903031a,
+    e2896d6b1e485605b5c436f11abc2016a60c083a, 06deb655ae265b397cd013db5cb77aa442a68617,
+    48204fd98023ff7d05166c7ddb9d8afd2c5006e9, e0e64cdc7fd9eb3dbcf670e8c3dd9dfd0501d104,
+    9fe26a407f0eca058829dec41a4de71c70bfc3ec, 3fb41b4e2d389f2b187e2e12a7c8611d6c4b0e30,
+    8c7398befdf1ecb163b5d0f6f5ba27b45c63211e, d4c1e6cbbcdca0f4688a58092ecbb81a58fe4421,
+    a41a2dee403d99e6c13d35b935a310b0609b8e6a, 7a6c2a6c4235e68472d1924b2d3f6f808ee5d39a,
+    f223c10cf17689353a41e052bfc16c9ac4758132, adef560d1ef8ab84aceee8b6ebae6f515c2b7a66,
+    179adc415f947eb64eb12a15c90d0d8da09418b9, 8be7f1183d2f113d82c0c68a5e23a44d7fb8a8b6,
+    683f9fba8c27817b6c2f7320a4095ca353022651]
   linux-4.9.y: [ffe8cffc8be1ae47c08cbc3571bed6b5b0fa53ad, 192d1975450e51c1abb725343a7e19a4d61e30bd,
     626743f43da44598076019a82193caf49dca1fde, 2a099011de8abebac475a90dad1835c60dfca88c,
     da360f1f5eb43e0d71009bab3be53c7a06d40caf, 96c06cda5b4bdc6a3a9a8f8adc46c86077a70ee0,


=====================================
issues/CVE-2018-12127.yml
=====================================
@@ -109,6 +109,18 @@ fixed-by:
     f223c10cf17689353a41e052bfc16c9ac4758132, adef560d1ef8ab84aceee8b6ebae6f515c2b7a66,
     179adc415f947eb64eb12a15c90d0d8da09418b9, 8be7f1183d2f113d82c0c68a5e23a44d7fb8a8b6,
     683f9fba8c27817b6c2f7320a4095ca353022651]
+  linux-4.4.y-cip: [a50e2ca5757f54fc5b0eabbb77a509209cbcc40d, 31a2c5f7a25b1cf4739ccd0244b0b270c42dab89,
+    71041afe26a30d8a5bfb75ff5699c9cfdee5250a, 693eb3bdaf19dd58aea99a5ed088dd6319ecc098,
+    0f961ec593057bad865d3a9f6834c0ca1582d486, 3092ad5c4f2ed6925847273a65c5598a73ee88d8,
+    2b26dff34698b8f4b57c5492c17a3fcf71e32de6, 0144cbc1247411f6fa07447ce9a4ae204903031a,
+    e2896d6b1e485605b5c436f11abc2016a60c083a, 06deb655ae265b397cd013db5cb77aa442a68617,
+    48204fd98023ff7d05166c7ddb9d8afd2c5006e9, e0e64cdc7fd9eb3dbcf670e8c3dd9dfd0501d104,
+    9fe26a407f0eca058829dec41a4de71c70bfc3ec, 3fb41b4e2d389f2b187e2e12a7c8611d6c4b0e30,
+    8c7398befdf1ecb163b5d0f6f5ba27b45c63211e, d4c1e6cbbcdca0f4688a58092ecbb81a58fe4421,
+    a41a2dee403d99e6c13d35b935a310b0609b8e6a, 7a6c2a6c4235e68472d1924b2d3f6f808ee5d39a,
+    f223c10cf17689353a41e052bfc16c9ac4758132, adef560d1ef8ab84aceee8b6ebae6f515c2b7a66,
+    179adc415f947eb64eb12a15c90d0d8da09418b9, 8be7f1183d2f113d82c0c68a5e23a44d7fb8a8b6,
+    683f9fba8c27817b6c2f7320a4095ca353022651]
   linux-4.9.y: [ffe8cffc8be1ae47c08cbc3571bed6b5b0fa53ad, 192d1975450e51c1abb725343a7e19a4d61e30bd,
     626743f43da44598076019a82193caf49dca1fde, 2a099011de8abebac475a90dad1835c60dfca88c,
     da360f1f5eb43e0d71009bab3be53c7a06d40caf, 96c06cda5b4bdc6a3a9a8f8adc46c86077a70ee0,


=====================================
issues/CVE-2018-12130.yml
=====================================
@@ -115,6 +115,18 @@ fixed-by:
     f223c10cf17689353a41e052bfc16c9ac4758132, adef560d1ef8ab84aceee8b6ebae6f515c2b7a66,
     179adc415f947eb64eb12a15c90d0d8da09418b9, 8be7f1183d2f113d82c0c68a5e23a44d7fb8a8b6,
     683f9fba8c27817b6c2f7320a4095ca353022651]
+  linux-4.4.y-cip: [a50e2ca5757f54fc5b0eabbb77a509209cbcc40d, 31a2c5f7a25b1cf4739ccd0244b0b270c42dab89,
+    71041afe26a30d8a5bfb75ff5699c9cfdee5250a, 693eb3bdaf19dd58aea99a5ed088dd6319ecc098,
+    0f961ec593057bad865d3a9f6834c0ca1582d486, 3092ad5c4f2ed6925847273a65c5598a73ee88d8,
+    2b26dff34698b8f4b57c5492c17a3fcf71e32de6, 0144cbc1247411f6fa07447ce9a4ae204903031a,
+    e2896d6b1e485605b5c436f11abc2016a60c083a, 06deb655ae265b397cd013db5cb77aa442a68617,
+    48204fd98023ff7d05166c7ddb9d8afd2c5006e9, e0e64cdc7fd9eb3dbcf670e8c3dd9dfd0501d104,
+    9fe26a407f0eca058829dec41a4de71c70bfc3ec, 3fb41b4e2d389f2b187e2e12a7c8611d6c4b0e30,
+    8c7398befdf1ecb163b5d0f6f5ba27b45c63211e, d4c1e6cbbcdca0f4688a58092ecbb81a58fe4421,
+    a41a2dee403d99e6c13d35b935a310b0609b8e6a, 7a6c2a6c4235e68472d1924b2d3f6f808ee5d39a,
+    f223c10cf17689353a41e052bfc16c9ac4758132, adef560d1ef8ab84aceee8b6ebae6f515c2b7a66,
+    179adc415f947eb64eb12a15c90d0d8da09418b9, 8be7f1183d2f113d82c0c68a5e23a44d7fb8a8b6,
+    683f9fba8c27817b6c2f7320a4095ca353022651]
   linux-4.9.y: [ffe8cffc8be1ae47c08cbc3571bed6b5b0fa53ad, 192d1975450e51c1abb725343a7e19a4d61e30bd,
     626743f43da44598076019a82193caf49dca1fde, 2a099011de8abebac475a90dad1835c60dfca88c,
     da360f1f5eb43e0d71009bab3be53c7a06d40caf, 96c06cda5b4bdc6a3a9a8f8adc46c86077a70ee0,


=====================================
issues/CVE-2019-11091.yml
=====================================
@@ -106,6 +106,18 @@ fixed-by:
     f223c10cf17689353a41e052bfc16c9ac4758132, adef560d1ef8ab84aceee8b6ebae6f515c2b7a66,
     179adc415f947eb64eb12a15c90d0d8da09418b9, 8be7f1183d2f113d82c0c68a5e23a44d7fb8a8b6,
     683f9fba8c27817b6c2f7320a4095ca353022651]
+  linux-4.4.y-cip: [a50e2ca5757f54fc5b0eabbb77a509209cbcc40d, 31a2c5f7a25b1cf4739ccd0244b0b270c42dab89,
+    71041afe26a30d8a5bfb75ff5699c9cfdee5250a, 693eb3bdaf19dd58aea99a5ed088dd6319ecc098,
+    0f961ec593057bad865d3a9f6834c0ca1582d486, 3092ad5c4f2ed6925847273a65c5598a73ee88d8,
+    2b26dff34698b8f4b57c5492c17a3fcf71e32de6, 0144cbc1247411f6fa07447ce9a4ae204903031a,
+    e2896d6b1e485605b5c436f11abc2016a60c083a, 06deb655ae265b397cd013db5cb77aa442a68617,
+    48204fd98023ff7d05166c7ddb9d8afd2c5006e9, e0e64cdc7fd9eb3dbcf670e8c3dd9dfd0501d104,
+    9fe26a407f0eca058829dec41a4de71c70bfc3ec, 3fb41b4e2d389f2b187e2e12a7c8611d6c4b0e30,
+    8c7398befdf1ecb163b5d0f6f5ba27b45c63211e, d4c1e6cbbcdca0f4688a58092ecbb81a58fe4421,
+    a41a2dee403d99e6c13d35b935a310b0609b8e6a, 7a6c2a6c4235e68472d1924b2d3f6f808ee5d39a,
+    f223c10cf17689353a41e052bfc16c9ac4758132, adef560d1ef8ab84aceee8b6ebae6f515c2b7a66,
+    179adc415f947eb64eb12a15c90d0d8da09418b9, 8be7f1183d2f113d82c0c68a5e23a44d7fb8a8b6,
+    683f9fba8c27817b6c2f7320a4095ca353022651]
   linux-4.9.y: [ffe8cffc8be1ae47c08cbc3571bed6b5b0fa53ad, 192d1975450e51c1abb725343a7e19a4d61e30bd,
     626743f43da44598076019a82193caf49dca1fde, 2a099011de8abebac475a90dad1835c60dfca88c,
     da360f1f5eb43e0d71009bab3be53c7a06d40caf, 96c06cda5b4bdc6a3a9a8f8adc46c86077a70ee0,


=====================================
issues/CVE-2019-5489.yml
=====================================
@@ -53,6 +53,8 @@ introduced-by:
 fixed-by:
   linux-4.14.y: [212c5685825c1ed45ac3a191dd7ada6e5889bfa2]
   linux-4.19.y: [f580a54bbd522f2518fd642f7d4d73ad728e5d58]
+  linux-4.19.y-cip: [f580a54bbd522f2518fd642f7d4d73ad728e5d58]
   linux-4.4.y: [b614485b6b93dbb2f6202341c60594fcdc110d5c]
+  linux-4.4.y-cip: [b614485b6b93dbb2f6202341c60594fcdc110d5c]
   linux-4.9.y: [fef85fb00224cb22f9efec262e9ffe8970e555ee]
   mainline: [574823bfab82d9d8fa47f422778043fbb4b4f50e]



View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/commit/62cfaf0fa51dff06993025feac2328f20d3a264e

-- 
View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/commit/62cfaf0fa51dff06993025feac2328f20d3a264e
You're receiving this email because of your account on gitlab.com.


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190614/30387865/attachment-0001.html>
