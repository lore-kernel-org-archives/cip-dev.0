Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB79BC282EC
	for <webhook@archiver.kernel.org>; Fri,  7 Mar 2025 01:52:25 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web10.1936.1741312335526122266
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Mar 2025 17:52:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key3.smx header.b=LtLgAuu8;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.132, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key3.smx;t=
	1741312333;x=1742521933;bh=sHj28lwxwM5pcTod5agkZmW3sCliCsIcC9AcVs0QISs=;b=LtL
	gAuu8gYRqnxHZrDj7L1ps5SIaADtMXK0DTMIgmU7GHBAVWC3E5WAy3jd2nQafW8IS2mqh/1azBas/
	8cehULrgU6WjzFkDwN47lV+sbhvKunsiCR2vYZ1XiNzDbXIz+lpQCj5tZqgleOdWTQFmnxZzCcJIe
	McUlhGxCXYkKCeUTp7+pHetVZeGok9rpn8FMOTygnHALYv1HqZOkLF3y6zdttGlnqFCwwI3GYNAAW
	p9U/8V5i5tytI9WvuHP10yGJgfBsI2NynPyB0vvIo+kvraXrLJSyQDvwDVmn7/PzGWpZz4tWFROM6
	cPBThq7AZkzNlCzVMDe+3GMRBjBQfAA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 5271qCq72372824; Fri, 7 Mar 2025 10:52:12 +0900
X-Iguazu-Qid: 2rWhWAeBkDBacRFclG
X-Iguazu-QSIG: v=2; s=0; t=1741312332; q=2rWhWAeBkDBacRFclG; m=wbA6cTampCmAcXvUzszk9lYwxjOOUkvlw27NQdxsCe4=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1123) id 5271qAH52348063
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 7 Mar 2025 10:52:11 +0900
From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [isar-cip-core][PATCH v2] scripts: Add automated recipe updates for LTP
Date: Fri,  7 Mar 2025 10:51:55 +0900
X-TSB-HOP2: ON
Message-Id: <1741312315-25979-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Mar 2025 01:52:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18062

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

---

v2:
  - Update with shellcheck

 scripts/update-ltp.sh | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100755 scripts/update-ltp.sh

diff --git a/scripts/update-ltp.sh b/scripts/update-ltp.sh
new file mode 100755
index 0000000..dc8b947
--- /dev/null
+++ b/scripts/update-ltp.sh
@@ -0,0 +1,29 @@
+#!/bin/bash
+
+REPO_ROOT=$(git rev-parse --show-toplevel)
+pushd "${REPO_ROOT}"/recipes-core/ltp > /dev/null || exit
+
+LATEST_VER=$(git ls-remote --refs --tags  https://github.com/linux-test-project/ltp.git | \
+	cut --delimiter='/' --fields=3 | \
+	sort --version-sort | tail --lines=1)
+
+SHA256FILE="ltp-full-${LATEST_VER}.tar.xz.sha256"
+rm -rf "${SHA256FILE}"
+
+wget -q "https://github.com/linux-test-project/ltp/releases/download/${LATEST_VER}/${SHA256FILE}"
+
+SHA256SUM=$(cut -f 1 -d " " "${SHA256FILE}")
+RECIPE="ltp-full_${LATEST_VER}.bb"
+
+if [ ! -f "${RECIPE}" ]; then
+	git mv ltp-full*.bb "${RECIPE}"
+
+	sed -i 's/\(SRC_URI\[sha256sum\] = "\).*/\1'"${SHA256SUM}"'"'/ "${RECIPE}"
+	git add "${RECIPE}"
+
+	git commit -asm "recipes-core: ltp: Update to ${LATEST_VER}"
+fi
+
+rm -rf "${SHA256FILE}"
+
+popd > /dev/null || exit
-- 
2.45.2



