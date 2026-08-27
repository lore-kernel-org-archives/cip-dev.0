Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB234C61DC4
	for <webhook@archiver.kernel.org>; Thu, 27 Aug 2026 06:23:05 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.30125.1787811781513335269
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Aug 2026 23:23:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=XSfWysoY;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-294854-202608270622596879a670b600020726-rvkoho@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202608270622596879a670b600020726
        for <cip-dev@lists.cip-project.org>;
        Thu, 27 Aug 2026 08:22:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=is3LL3ZvKjpJeErsMIupXj2u+Qr7D2Brn4Wpg0TzfkQ=;
 b=XSfWysoYWdbWoibdPmZUFImJf2RGEojpjBlOf4/Ue3KWHQK5fbfIxR8ZHBVebNJPm+9yy2
 ROfVPPMpJIUZDXX6LYcgmj/bNFOUhqs/eK47DKuRKQkHanhJPjImym1S+08bzDKnni5W8H/u
 mgkPs+wMHig2vrBCnVfhtoUWK+Qm+/UcfeOqkTIJ+LVkNtBj2IgHqn+WHuswl22AnQf2xTJV
 1hI0I/KdYE/Rgrqcyd5/WqTkOEQhhbeqnIShGeYhYWuzAtJS3GqOcIZYYu+VUD+Mc6CPPrVR
 WezHtpQKcF3s2BMZW9zFoK4uaAG3r9XQMYksp3SBEJivB4TuIa+FjPcg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Felix Moessbauer <felix.moessbauer@siemens.com>,
	Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Michael Adler <michael.adler@siemens.com>
Subject: [isar-cip-core][PATCH v3 2/5] Update Isar revision
Date: Thu, 27 Aug 2026 08:22:54 +0200
Message-ID: <f820f8db5a93fde837ee9e85c9c6d3b2faa76c15.1787811777.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1787811777.git.jan.kiszka@siemens.com>
References: <cover.1787811777.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Aug 2026 06:23:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24038

From: Jan Kiszka <jan.kiszka@siemens.com>

One not-yet-merged patch is needed to make Isar compatible with
gitlab-cloud-ci in rootless mode.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...map-nobody-nogroup-as-dedicated-bloc.patch | 68 +++++++++++++++++++
 kas-cip.yml                                   |  6 +-
 2 files changed, 73 insertions(+), 1 deletion(-)
 create mode 100644 isar-patches/0001-rootless-always-map-nobody-nogroup-as-dedicated-bloc.patch

diff --git a/isar-patches/0001-rootless-always-map-nobody-nogroup-as-dedicated-bloc.patch b/isar-patches/0001-rootless-always-map-nobody-nogroup-as-dedicated-bloc.patch
new file mode 100644
index 00000000..6c58c194
--- /dev/null
+++ b/isar-patches/0001-rootless-always-map-nobody-nogroup-as-dedicated-bloc.patch
@@ -0,0 +1,68 @@
+From ea8f6d883a494430ff7db4ee95a875edee23c020 Mon Sep 17 00:00:00 2001
+From: Felix Moessbauer <felix.moessbauer@siemens.com>
+Date: Thu, 20 Aug 2026 17:10:29 +0200
+Subject: [PATCH] rootless: always map nobody/nogroup as dedicated block
+
+The nobody/nogroup ids were mapped as part of the linear id range,
+with an extra single-id mapping added only if the range was too small
+to contain them. The extra mapping was guarded by "uid_cnt < nobody_id",
+but the linear range ends at uid_cnt-2, so it covers nobody only for
+uid_cnt >= 65536. For a count of 65534 or 65535 neither the linear range
+nor the guard mapped nobody.
+
+Relying on the linear range to cover nobody is unsafe in general. If that
+range covers the outer id that --map-root-user maps to, unshare punches a
+hole out of the mapping, and per unshare(1) this "may result in the
+highest user ID of the mapping not being mapped". That highest id is
+exactly nobody. This happens whenever the subid range overlaps the id of
+the calling user, e.g. with
+
+  builder:0:65536
+
+where the mapped block 1..65534 contains the builder's own uid. The
+resulting namespace then silently lacks a nobody mapping, while a range
+like 100000:65536 is unaffected and hides the problem.
+
+Map nobody/nogroup as a separate block at the top of the range and cap
+the linear range at nobody_id-1. The separate block does not overlap
+--map-root-user, so it survives, and a hole now at most costs id 65533.
+
+Fixes: 4fedb1ae ("add support for fully rootless builds")
+Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
+---
+ meta/classes-global/base.bbclass | 16 ++++++++++------
+ 1 file changed, 10 insertions(+), 6 deletions(-)
+
+diff --git a/meta/classes-global/base.bbclass b/meta/classes-global/base.bbclass
+index d96ebef4..8f81ab70 100644
+--- a/meta/classes-global/base.bbclass
++++ b/meta/classes-global/base.bbclass
+@@ -470,15 +470,19 @@ def run_privileged_cmd(d):
+         nobody_subid = uid_base + uid_cnt - 1
+         gid_base, gid_cnt = get_subid_range('/etc/subgid', d)
+         nogroup_subid = gid_base + gid_cnt - 1
++        # nobody/nogroup need a dedicated block at the top of the range. As part
++        # of the linear range they are lost whenever that range covers the outer
++        # id of --map-root-user, because unshare then punches out a hole and
++        # drops the highest id of the range.
++        uid_linear_cnt = min(uid_cnt - 2, nobody_id - 1)
++        gid_linear_cnt = min(gid_cnt - 2, nobody_id - 1)
+         cmd = 'unshare --mount --pid --uts --ipc --user' \
+               ' --kill-child' \
+               ' --setuid 0 --setgid 0 --fork' \
+-              f' --map-users  1:{uid_base+1}:{uid_cnt-2}' \
+-              f' --map-groups 1:{gid_base+1}:{gid_cnt-2}'
+-        if uid_cnt < nobody_id:
+-            cmd += f' --map-users  {nobody_id}:{nobody_subid}:1'
+-        if gid_cnt < nobody_id:
+-            cmd += f' --map-groups {nobody_id}:{nogroup_subid}:1'
++              f' --map-users  1:{uid_base+1}:{uid_linear_cnt}' \
++              f' --map-groups 1:{gid_base+1}:{gid_linear_cnt}' \
++              f' --map-users  {nobody_id}:{nobody_subid}:1' \
++              f' --map-groups {nobody_id}:{nogroup_subid}:1'
+         cmd += " --map-root-user"
+     else:
+         cmd = 'sudo -E'
+-- 
+2.47.3
+
diff --git a/kas-cip.yml b/kas-cip.yml
index 97b333a1..61cc9225 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -22,9 +22,13 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    commit: 481db3b2e8949336576e50a78aaf5d101f52c8d2
+    commit: 436bc96f3869b4a139357afbabb039caf4df7c5c
     layers:
       meta:
+    patches:
+      p1:
+        path: isar-patches/0001-rootless-always-map-nobody-nogroup-as-dedicated-bloc.patch
+        repo: cip-core
 
 bblayers_conf_header:
   standard: |
-- 
2.47.3


