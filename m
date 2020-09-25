Return-Path: <SRS0=ba7Y=DC=lists.cip-project.org=bounce+64572+5475+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5190EC4727E
	for <cip-dev@archiver.kernel.org>; Fri, 25 Sep 2020 04:00:08 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 912FB20EDD
	for <cip-dev@archiver.kernel.org>; Fri, 25 Sep 2020 04:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="oDWqmyjG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 912FB20EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5475+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id LvC0YY4521723x63lL5bnGyS; Thu, 24 Sep 2020 21:00:07 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web12.85.1601006406174083716
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Sep 2020 21:00:06 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 08P3xXUW022885; Fri, 25 Sep 2020 12:59:33 +0900
X-Iguazu-Qid: 34treJ7jSnpoXH9OnQ
X-Iguazu-QSIG: v=2; s=0; t=1601006373; q=34treJ7jSnpoXH9OnQ; m=g6PnKhSUfYGc7TW5Tpophxb6FtmQO0izFVpe4IfvarM=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1510) id 08P3xWWC039282;
	Fri, 25 Sep 2020 12:59:32 +0900
X-Received: from enc01.toshiba.co.jp ([106.186.93.100])
	by imx2.toshiba.co.jp  with ESMTP id 08P3xWns013343;
	Fri, 25 Sep 2020 12:59:32 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 08P3xVEs029834;
	Fri, 25 Sep 2020 12:59:32 +0900
From: "Daniel Sangorrin" <daniel.sangorrin@toshiba.co.jp>
To: sz.lin@moxa.com, ben.hutchings@codethink.co.u, wens@csie.org
Cc: cip-dev@lists.cip-project.org
Subject: [cip-dev] [cip-kernel-sec 3/3] issues: fill in the description field of remaining CVEs
Date: Fri, 25 Sep 2020 12:59:27 +0900
X-TSB-HOP: ON
Message-Id: <20200925035927.1958987-4-daniel.sangorrin@toshiba.co.jp>
In-Reply-To: <20200925035927.1958987-1-daniel.sangorrin@toshiba.co.jp>
References: <20200925035927.1958987-1-daniel.sangorrin@toshiba.co.jp>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: bFP2C5XV3T2JzdqJnLZEdtmBx4520388AA=
Content-Type: multipart/mixed; boundary="TwoZketa7AMdG7QfTl5x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1601006407;
 bh=JpkwQ/HWa+gFIiwdPDUqotPW5z0GE91ax23hcNUaXcM=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=oDWqmyjGmpfypEdFvEKf9Igon5jW96Rqr4ZQAjVqWwozgmA+1NWeNYAc9S83PAkB2e1
 kxGkLca9lQMcO67AM2ShVzS4Oa2sq3iizl8JtT5qWhQz9xKBjGBvGnPvF1pwyh6yB/Rqi
 6wgLfdqI2EfItxD/qiUHi9peIVZiYplkjx0=

--TwoZketa7AMdG7QfTl5x
Content-Transfer-Encoding: 8bit

From: nguyen van hieu <hieu2.nguyenvan@toshiba.co.jp>

I noticed that some issues have the description field empty
when using the --show-description option.

Signed-off-by: nguyen van hieu <hieu2.nguyenvan@toshiba.co.jp>
Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
---
 issues/CVE-2016-6213.yml    | 5 ++++-
 issues/CVE-2017-1000364.yml | 5 ++++-
 issues/CVE-2017-1000365.yml | 6 +++++-
 issues/CVE-2017-1000379.yml | 5 ++++-
 issues/CVE-2017-16538.yml   | 5 ++++-
 issues/CVE-2019-15214.yml   | 6 +++++-
 issues/CVE-2019-20794.yml   | 6 +++++-
 issues/CVE-2020-11725.yml   | 8 +++++++-
 8 files changed, 38 insertions(+), 8 deletions(-)

diff --git a/issues/CVE-2016-6213.yml b/issues/CVE-2016-6213.yml
index 31762df..58bf472 100644
--- a/issues/CVE-2016-6213.yml
+++ b/issues/CVE-2016-6213.yml
@@ -1,4 +1,7 @@
-description: ''
+description: |-
+  fs/namespace.c in the Linux kernel before 4.9 does not restrict how many mounts may exist in a mount namespace,
+  which allows local users to cause a denial of service (memory consumption and deadlock) via MS_BIND mount system calls,
+  as demonstrated by a loop that triggers exponential growth in the number of mounts.
 references:
 - http://www.openwall.com/lists/oss-security/2016/07/13/6
 - https://lkml.org/lkml/2016/8/28/269
diff --git a/issues/CVE-2017-1000364.yml b/issues/CVE-2017-1000364.yml
index 8841754..c566c5b 100644
--- a/issues/CVE-2017-1000364.yml
+++ b/issues/CVE-2017-1000364.yml
@@ -1,4 +1,7 @@
-description: ''
+description: |-
+  An issue was discovered in the size of the stack guard page on Linux, specifically a 4k stack guard
+  page is not sufficiently large and can be "jumped" over (the stack guard page is bypassed),
+  this affects Linux Kernel versions 4.11.5 and earlier (the stackguard page was introduced in 2010).
 references:
 - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1000364
 - http://www.ubuntu.com/usn/usn-3324-1
diff --git a/issues/CVE-2017-1000365.yml b/issues/CVE-2017-1000365.yml
index 6cbae0b..f87ca53 100644
--- a/issues/CVE-2017-1000365.yml
+++ b/issues/CVE-2017-1000365.yml
@@ -1,4 +1,8 @@
-description: ''
+description: |-
+  The Linux Kernel imposes a size restriction on the arguments and environmental strings passed through
+  RLIMIT_STACK/RLIM_INFINITY (1/4 of the size), but does not take the argument and environment pointers
+  into account, which allows attackers to bypass this limitation. This affects Linux Kernel versions 4.11.5 and earlier.
+  It appears that this feature was introduced in the Linux Kernel version 2.6.23.
 references:
 - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1000365
 - https://www.qualys.com/2017/06/19/stack-clash/stack-clash.txt
diff --git a/issues/CVE-2017-1000379.yml b/issues/CVE-2017-1000379.yml
index 93258d8..2ae11b1 100644
--- a/issues/CVE-2017-1000379.yml
+++ b/issues/CVE-2017-1000379.yml
@@ -1,4 +1,7 @@
-description: ''
+description: |-
+  The Linux Kernel running on AMD64 systems will sometimes map the contents of PIE executable,
+  the heap or ld.so to where the stack is mapped allowing attackers to more easily manipulate the stack.
+  Linux Kernel version 4.11.5 is affected.
 references:
 - https://www.qualys.com/2017/06/19/stack-clash/stack-clash.txt
 - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1000379
diff --git a/issues/CVE-2017-16538.yml b/issues/CVE-2017-16538.yml
index 793db3f..c466041 100644
--- a/issues/CVE-2017-16538.yml
+++ b/issues/CVE-2017-16538.yml
@@ -1,4 +1,7 @@
-description: ''
+description: |-
+  drivers/media/usb/dvb-usb-v2/lmedm04.c in the Linux kernel through 4.13.11 allows local users to cause a denial of service
+  (general protection fault and system crash) or possibly have unspecified other impact via a crafted USB device,
+  related to a missing warm-start check and incorrect attach timing (dm04_lme2510_frontend_attach versus dm04_lme2510_tuner).
 references:
 - https://patchwork.linuxtv.org/patch/44566/
 - https://patchwork.linuxtv.org/patch/44567/
diff --git a/issues/CVE-2019-15214.yml b/issues/CVE-2019-15214.yml
index c92091b..cb6006d 100644
--- a/issues/CVE-2019-15214.yml
+++ b/issues/CVE-2019-15214.yml
@@ -1,4 +1,8 @@
-description: ''
+description: |-
+  An issue was discovered in the Linux kernel before 5.0.10.
+  There is a use-after-free in the sound subsystem because
+  card disconnection causes certain data structures to be deleted too early.
+  This is related to sound/core/init.c and sound/core/info.c.
 references:
 - https://syzkaller.appspot.com/bug?id=75903e0021cef79bc434d068b5169b599b2a46a9
 - https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-15214
diff --git a/issues/CVE-2019-20794.yml b/issues/CVE-2019-20794.yml
index 43e3ccf..8f30e12 100644
--- a/issues/CVE-2019-20794.yml
+++ b/issues/CVE-2019-20794.yml
@@ -1,4 +1,8 @@
-description: ''
+description: |-
+  An issue was discovered in the Linux kernel 4.18 through 5.6.11 when unprivileged user namespaces are allowed.
+  A user can create their own PID namespace, and mount a FUSE filesystem. Upon interaction with this FUSE filesystem,
+  if the userspace component is terminated via a kill of the PID namespace's pid 1, it will result in a hung task,
+  and resources being permanently locked up until system reboot. This can result in resource exhaustion.
 references:
 - https://github.com/sargun/fuse-example
 - https://sourceforge.net/p/fuse/mailman/message/36598753/
diff --git a/issues/CVE-2020-11725.yml b/issues/CVE-2020-11725.yml
index ca2b80d..3cae05d 100644
--- a/issues/CVE-2020-11725.yml
+++ b/issues/CVE-2020-11725.yml
@@ -1,4 +1,10 @@
-description: ''
+description: |-
+  ** DISPUTED ** snd_ctl_elem_add in sound/core/control.c in the Linux kernel through 5.6.3 has a count=info->owner line,
+  which later affects a private_size*count multiplication for unspecified "interesting side effects."
+  NOTE: kernel engineers dispute this finding, because it could be relevant only if new callers were added
+  that were unfamiliar with the misuse of the info->owner field to represent data unrelated to the "owner" concept.
+  The existing callers, SNDRV_CTL_IOCTL_ELEM_ADD and SNDRV_CTL_IOCTL_ELEM_REPLACE,
+  have been designed to misuse the info->owner field in a safe way.
 references:
 - https://twitter.com/yabbadabbadrew/status/1248632267028582400
 - https://lore.kernel.org/alsa-devel/s5h4ktmlfpx.wl-tiwai@suse.de/
-- 
2.25.1


--TwoZketa7AMdG7QfTl5x
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5475): https://lists.cip-project.org/g/cip-dev/message=
/5475
Mute This Topic: https://lists.cip-project.org/mt/77073076/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--TwoZketa7AMdG7QfTl5x--
