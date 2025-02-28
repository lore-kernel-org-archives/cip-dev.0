Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EF8C19776
	for <webhook@archiver.kernel.org>; Fri, 28 Feb 2025 07:20:07 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.10530.1740727196623699305
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Feb 2025 23:19:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key3.smx header.b=ljFAerpd;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.131, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key3.smx;t=
	1740727194;x=1741936794;bh=Vp5tMZxsPa9XrG4wSakxipRYmA+JbrnWItpEZSSHYbI=;b=ljF
	AerpdVpbxNMJEkxuw/RPRewTWcb1RlJWX2WjyDVan4wPQuncEhZARnbYdqMrnzAUUfdeHVNSXpACD
	Fp0GLAIx/z2cYNIMNYqV0/awErWqx2XxF+O+MnW3Gzs+/oLm05l2AGWYrpTJdJzuff9Z4fgNQ1g5W
	eSdKN4zwJUjfJXYs/OqHRaVHnLallqB6LI3E6Y9Blfo47qLs/J9y8bcMJcw9csAdmgZRC5+ACHHlH
	9G73BZCt9Hf7/rI2F9yiQFTRqskBQx/TwMi43AMmNKeVdos5voTv2vQVheOYgKyA2Y6dygCJgsHLu
	VDQEdlRq2wKGP67DTd+y45rn5ZJHLgQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 51S7JsNw3249040; Fri, 28 Feb 2025 16:19:54 +0900
X-Iguazu-Qid: 2rWhMjEQIoT9WFzvI5
X-Iguazu-QSIG: v=2; s=0; t=1740727193; q=2rWhMjEQIoT9WFzvI5; m=y2GK0l8pErXpNcXlQoMItVsHtAmso4kgpSq5WecHQR0=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1123) id 51S7Jqti2643311
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 16:19:53 +0900
From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [isar-cip-core][PATCH 1/2] scripts: Add automated recipe updates for LTP
Date: Fri, 28 Feb 2025 16:19:42 +0900
X-TSB-HOP2: ON
Message-Id: <1740727183-24538-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 28 Feb 2025 07:20:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17980

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 scripts/update-ltp.sh | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100755 scripts/update-ltp.sh

diff --git a/scripts/update-ltp.sh b/scripts/update-ltp.sh
new file mode 100755
index 0000000..99b75b0
--- /dev/null
+++ b/scripts/update-ltp.sh
@@ -0,0 +1,29 @@
+#!/bin/bash
+
+REPO_ROOT=$(git rev-parse --show-toplevel)
+pushd ${REPO_ROOT}/recipes-core/ltp > /dev/null
+
+LATEST_VER=$(git ls-remote --refs --tags  https://github.com/linux-test-project/ltp.git | \
+	cut --delimiter='/' --fields=3 | \
+	sort --version-sort | tail --lines=1)
+
+SHA256FILE="ltp-full-${LATEST_VER}.tar.xz.sha256"
+rm -rf ${SHA256FILE}
+
+wget -q https://github.com/linux-test-project/ltp/releases/download/${LATEST_VER}/${SHA256FILE}
+
+SHA256SUM=$(cut -f 1 -d " " ${SHA256FILE})
+RECIPE="ltp-full_${LATEST_VER}.bb"
+
+if [ ! -f ${RECIPE} ]; then
+	git mv ltp-full*.bb ${RECIPE}
+
+	sed -i 's/\(SRC_URI\[sha256sum\] = "\).*/\1'${SHA256SUM}'"'/ ${RECIPE}
+	git add ${RECIPE}
+
+	git commit -asm "recipes-core: ltp: Update to ${LATEST_VER}"
+fi
+
+rm -rf ${SHA256FILE}
+
+popd > /dev/null
-- 
2.45.2



