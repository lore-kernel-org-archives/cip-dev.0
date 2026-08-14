Return-Path: <gouravsingh@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88679C5CFDB
	for <webhook@archiver.kernel.org>; Fri, 14 Aug 2026 12:07:16 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11391.1786709231748160623
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Aug 2026 05:07:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=gouravsingh@siemens.com header.s=fm2 header.b=OjjENVOP;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-1333022-2026081412070777ea92ff850002072f-gwku4x@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2026081412070777ea92ff850002072f
        for <cip-dev@lists.cip-project.org>;
        Fri, 14 Aug 2026 14:07:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=gouravsingh@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=sMU+s1rFTIBMRj8OBPavqD8coeXpwBOXSZV2fgKyhxk=;
 b=OjjENVOPMAzDLtTC0TqJ8/+rr2VgJIIw7uT/batg6/ynOhounNNRPTUXTqYk8vbc9hcyNR
 yjjJelgyS2TeBcyAyu5bxfUq1qcmGydvSePeQa6aaW+XnXGWMwXmfeI+yErNgOVCDzxNpOpu
 tuH2P2TKVMdKeik+nHw/o+/2zkfrEJrh2BPLUV2KgtQwYRjUAk+TX+mnkjSS0ikZhfIooIc4
 WcrGXnqo5baa+R+C7ejTNTBro8DA7XJ8ZeiEUHWdzCZb6VVmDGszq4nGZH6jBHi9AvyrjMby
 VWEEv03pDioSte2JEJ0KOwD1oXKelSrDIiTjVSi21gB76hr4Qe0iKppA==;
From: Gourav Singh <gouravsingh@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	Gourav Singh <gouravsingh@siemens.com>
Subject: [isar-cip-core][PATCH v2] recipes-core: ltp: Update to 20260529
Date: Fri, 14 Aug 2026 17:36:49 +0530
Message-Id: <20260814120649.905245-1-gouravsingh@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1333022:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Aug 2026 12:07:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23936

Update LTP to release 20260529.

With this release, runltp is deprecated and kirk is the recommended
runner. Kirk is Python-based, so python3 is required to execute
/opt/ltp/kirk. jq is required for parsing/inspection of JSON reports
produced by kirk. Add both as runtime dependencies so LTP/kirk usage
works out of the box without manual package installation on targets.

Debian buster compatibility is preserved: buster provides Python 3.7,
while kirk requires Python >= 3.6.

The listmount04.c compatibility patch is no longer needed, as the fix
is now included upstream in this release; drop it.

The patch was originally added in:
2647471156b128bf8b0fb1d726bd05099fbbe1bd

Signed-off-by: Gourav Singh <gouravsingh@siemens.com>
---
 ...date-struct-mnt_id_req-support-for-k.patch | 195 ------------------
 recipes-core/ltp/files/debian/control.tmpl    |   2 +-
 ...-full_20250930.bb => ltp-full_20260529.bb} |   4 +-
 3 files changed, 2 insertions(+), 199 deletions(-)
 delete mode 100644 recipes-core/ltp/files/0001-listmount04.c-Update-struct-mnt_id_req-support-for-k.patch
 rename recipes-core/ltp/{ltp-full_20250930.bb => ltp-full_20260529.bb} (54%)

diff --git a/recipes-core/ltp/files/0001-listmount04.c-Update-struct-mnt_id_req-support-for-k.patch b/recipes-core/ltp/files/0001-listmount04.c-Update-struct-mnt_id_req-support-for-k.patch
deleted file mode 100644
index aecfe54..0000000
--- a/recipes-core/ltp/files/0001-listmount04.c-Update-struct-mnt_id_req-support-for-k.patch
+++ /dev/null
@@ -1,195 +0,0 @@
-From 2d066ead3d6ef504c82551b12306e751d23ddb45 Mon Sep 17 00:00:00 2001
-From: Wei Gao <wegao@suse.com>
-Date: Sun, 14 Dec 2025 02:15:20 +0000
-Subject: [PATCH] listmount04.c: Update struct mnt_id_req support for kernel >=
- 6.18
-
-Kernel change from v6.18-rc7
-78f0e33cd6c93 ("fs/namespace: correctly handle errors returned by grab_requested_mnt_ns")
-causes the test failure with following error message:
-listmount04.c:128: TFAIL: invalid mnt_id_req.spare expected EINVAL: EBADF (9)
-
-The fix require following changes:
-
-* struct mnt_id_req got new member mnt_ns_fd in v6.18-rc7.  That is
-fixed in a fallback defintion in lapi/. If the fallback is used is now
-done via typedef (that requires also update in statmount.h).
-
-* New kernels (>= 6.18) have also different errno. This is fixed by
-runtime check.
-
-Link: https://lore.kernel.org/ltp/20251214021541.3256-1-wegao@suse.com/
-Reviewed-by: Petr Vorel <pvorel@suse.cz>
-Reviewed-by: Li Wang <liwang@redhat.com>
-Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
-Signed-off-by: Wei Gao <wegao@suse.com>
-[ pvorel: Shorten TCONF, rewrite commit message ]
-Signed-off-by: Petr Vorel <pvorel@suse.cz>
----
- configure.ac                                  |  2 +-
- include/lapi/mount.h                          | 10 +++--
- .../kernel/syscalls/listmount/listmount.h     |  2 +-
- .../kernel/syscalls/listmount/listmount04.c   | 37 +++++++++++++++++--
- .../kernel/syscalls/statmount/statmount.h     |  2 +-
- 5 files changed, 44 insertions(+), 9 deletions(-)
-
-diff --git a/configure.ac b/configure.ac
-index 0480f46ca..a0ebbb34d 100644
---- a/configure.ac
-+++ b/configure.ac
-@@ -262,7 +262,7 @@ AC_CHECK_TYPES([struct cachestat_range],,,[#include <sys/mman.h>])
- AC_CHECK_TYPES([struct cachestat],,,[#include <sys/mman.h>])
- 
- # Defined in <linux/mount.h>, but include/lapi/mount.h includes <sys/mount.h> */
--AC_CHECK_TYPES([struct mnt_id_req],,,[#include <sys/mount.h>])
-+AC_CHECK_MEMBERS([struct mnt_id_req.mnt_ns_fd],,,[#include <sys/mount.h>])
- AC_CHECK_TYPES([struct statmount],,,[#include <sys/mount.h>])
- AC_CHECK_MEMBERS([struct statmount.mnt_ns_id],,,[#include <unistd.h>
- #include <linux/mount.h>])
-diff --git a/include/lapi/mount.h b/include/lapi/mount.h
-index 0f7bb5e43..3b296fc9c 100644
---- a/include/lapi/mount.h
-+++ b/include/lapi/mount.h
-@@ -45,14 +45,18 @@
- # define MS_NOSYMFOLLOW 256
- #endif
- 
--#ifndef HAVE_STRUCT_MNT_ID_REQ
--struct mnt_id_req {
-+struct mnt_id_req_fallback {
- 	uint32_t size;
--	uint32_t spare;
-+	uint32_t mnt_ns_fd;
- 	uint64_t mnt_id;
- 	uint64_t param;
- 	uint64_t mnt_ns_id;
- };
-+
-+#ifndef HAVE_STRUCT_MNT_ID_REQ_MNT_NS_FD
-+typedef struct mnt_id_req_fallback mnt_id_req;
-+#else
-+typedef struct mnt_id_req mnt_id_req;
- #endif
- 
- #ifndef HAVE_STRUCT_STATMOUNT
-diff --git a/testcases/kernel/syscalls/listmount/listmount.h b/testcases/kernel/syscalls/listmount/listmount.h
-index aad927f71..e7ef375d7 100644
---- a/testcases/kernel/syscalls/listmount/listmount.h
-+++ b/testcases/kernel/syscalls/listmount/listmount.h
-@@ -15,7 +15,7 @@
- static inline ssize_t listmount(uint64_t mnt_id, uint64_t last_mnt_id,
- 			 uint64_t list[], size_t num, unsigned int flags)
- {
--	struct mnt_id_req req = {
-+	mnt_id_req req = {
- 		.size = MNT_ID_REQ_SIZE_VER0,
- 		.mnt_id = mnt_id,
- 		.param = last_mnt_id,
-diff --git a/testcases/kernel/syscalls/listmount/listmount04.c b/testcases/kernel/syscalls/listmount/listmount04.c
-index a6921a249..2b8b49101 100644
---- a/testcases/kernel/syscalls/listmount/listmount04.c
-+++ b/testcases/kernel/syscalls/listmount/listmount04.c
-@@ -14,14 +14,18 @@
- 
- #define _GNU_SOURCE
- 
-+#include "config.h"
- #include "tst_test.h"
- #include "lapi/mount.h"
- #include "lapi/syscalls.h"
- 
- #define MNT_SIZE 32
-+#define BEFORE_6_18 1
-+#define AFTER_6_18 2
- 
--static struct mnt_id_req *request;
-+static mnt_id_req *request;
- static uint64_t mnt_ids[MNT_SIZE];
-+static int kver;
- 
- static struct tcase {
- 	int req_usage;
-@@ -34,6 +38,7 @@ static struct tcase {
- 	uint64_t flags;
- 	int exp_errno;
- 	char *msg;
-+	int kver;
- } tcases[] = {
- 	{
- 		.req_usage = 0,
-@@ -79,6 +84,18 @@ static struct tcase {
- 		.nr_mnt_ids = MNT_SIZE,
- 		.exp_errno = EINVAL,
- 		.msg = "invalid mnt_id_req.spare",
-+		.kver = BEFORE_6_18,
-+	},
-+	{
-+		.req_usage = 1,
-+		.size = MNT_ID_REQ_SIZE_VER0,
-+		.spare = -1,
-+		.mnt_id = LSMT_ROOT,
-+		.mnt_ids = mnt_ids,
-+		.nr_mnt_ids = MNT_SIZE,
-+		.exp_errno = EBADF,
-+		.msg = "invalid mnt_id_req.mnt_ns_fd",
-+		.kver = AFTER_6_18,
- 	},
- 	{
- 		.req_usage = 1,
-@@ -113,7 +130,12 @@ static struct tcase {
- static void run(unsigned int n)
- {
- 	struct tcase *tc = &tcases[n];
--	struct mnt_id_req *req = NULL;
-+	mnt_id_req *req = NULL;
-+
-+	if (tc->kver && tc->kver != kver) {
-+		tst_res(TCONF, "Test not suitable for current kernel version");
-+		return;
-+	}
- 
- 	memset(mnt_ids, 0, sizeof(mnt_ids));
- 
-@@ -122,7 +144,7 @@ static void run(unsigned int n)
- 		req->mnt_id = tc->mnt_id;
- 		req->param = tc->param;
- 		req->size = tc->size;
--		req->spare = tc->spare;
-+		req->mnt_ns_fd = tc->spare;
- 	}
- 
- 	TST_EXP_FAIL(tst_syscall(__NR_listmount, req, tc->mnt_ids,
-@@ -130,8 +152,17 @@ static void run(unsigned int n)
- 		"%s", tc->msg);
- }
- 
-+static void setup(void)
-+{
-+	if (tst_kvercmp(6, 18, 0) >= 0)
-+		kver = AFTER_6_18;
-+	else
-+		kver = BEFORE_6_18;
-+}
-+
- static struct tst_test test = {
- 	.test = run,
-+	.setup = setup,
- 	.tcnt = ARRAY_SIZE(tcases),
- 	.min_kver = "6.11",
- 	.bufs = (struct tst_buffers []) {
-diff --git a/testcases/kernel/syscalls/statmount/statmount.h b/testcases/kernel/syscalls/statmount/statmount.h
-index d21d7f8da..4217a82d8 100644
---- a/testcases/kernel/syscalls/statmount/statmount.h
-+++ b/testcases/kernel/syscalls/statmount/statmount.h
-@@ -16,7 +16,7 @@
- static inline int statmount(uint64_t mnt_id, uint64_t mask, struct statmount *buf,
- 		     size_t bufsize, unsigned int flags)
- {
--	struct mnt_id_req req = {
-+	mnt_id_req req = {
- 		.size = MNT_ID_REQ_SIZE_VER0,
- 		.mnt_id = mnt_id,
- 		.param = mask,
--- 
-2.51.0
-
diff --git a/recipes-core/ltp/files/debian/control.tmpl b/recipes-core/ltp/files/debian/control.tmpl
index a7d0087..039c6d0 100644
--- a/recipes-core/ltp/files/debian/control.tmpl
+++ b/recipes-core/ltp/files/debian/control.tmpl
@@ -11,7 +11,7 @@ Homepage: https://linux-test-project.github.io/
 
 Package: ltp-full
 Architecture: any
-Depends: ${shlibs:Depends}, ${misc:Depends}
+Depends: ${shlibs:Depends}, ${misc:Depends}, python3, jq
 Description: A collection of tools for testing the Linux kernel
  The Linux Test Project is a joint project started by SGI,
  developed and maintained by IBM, Cisco, Fujitsu, SUSE,
diff --git a/recipes-core/ltp/ltp-full_20250930.bb b/recipes-core/ltp/ltp-full_20260529.bb
similarity index 54%
rename from recipes-core/ltp/ltp-full_20250930.bb
rename to recipes-core/ltp/ltp-full_20260529.bb
index 42a9632..994bd73 100644
--- a/recipes-core/ltp/ltp-full_20250930.bb
+++ b/recipes-core/ltp/ltp-full_20260529.bb
@@ -11,6 +11,4 @@
 
 require recipes-core/ltp/ltp.inc
 
-SRC_URI += "file://0001-listmount04.c-Update-struct-mnt_id_req-support-for-k.patch"
-
-SRC_URI[sha256sum] = "048fa4d69ddbe8a94aa15da9bdc85713ab07a0abbc3de2b8bdd9757644aef1e4"
+SRC_URI[sha256sum] = "685d83c6e370ac09201fb79593412f868fe031ee2890e204b5727fedcf51fb47"
-- 
2.39.5


