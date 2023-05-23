Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43154C77B75
	for <webhook@archiver.kernel.org>; Tue, 23 May 2023 13:56:20 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web11.23353.1684850177380798518
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 May 2023 06:56:17 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.153, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 34NDuFhH004492; Tue, 23 May 2023 22:56:16 +0900
X-Iguazu-Qid: 34tr9ZSP7F8z6rNERc
X-Iguazu-QSIG: v=2; s=0; t=1684850175; q=34tr9ZSP7F8z6rNERc; m=LcXM35kwCPOj8Yb+KQdosTv00R8tiD+ELknSsZ3u+hg=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1513) id 34NDuEgC003263
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 23 May 2023 22:56:15 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core 1/2] scripts: Add script to test different artifacts in the image are bit identical
Date: Tue, 23 May 2023 19:26:10 +0530
X-TSB-HOP2: ON
Message-Id: <20230523135611.31234-2-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230523135611.31234-1-venkata.pyla@toshiba-tsip.com>
References: <20230523135611.31234-1-venkata.pyla@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 23 May 2023 13:56:12.0763 (UTC) FILETIME=[55B792B0:01D98D7E]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 May 2023 13:56:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11614

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

This script helps to check the reproducibility of different artifacts in
the target build like vmlinuz, initrd, rootfs, squashfs, ext4, swu files.

It uses diffoscope tool to check the artifacts are bit by bit identical.

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 scripts/repro-tests.sh | 91 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)
 create mode 100755 scripts/repro-tests.sh

diff --git a/scripts/repro-tests.sh b/scripts/repro-tests.sh
new file mode 100755
index 0000000..f767839
--- /dev/null
+++ b/scripts/repro-tests.sh
@@ -0,0 +1,91 @@
+#!/bin/sh
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Toshiba corp., 2023
+#
+# Authors:
+#  Venkata Pyla <venkata.pyla@toshiba-tsip.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+set -e
+
+usage()
+{
+	echo "usage: repro-tests.sh [--release RELEASE] [--target TARGET] artfacts1 artifacts2"
+	echo ""
+	echo " Optional arguments:"
+	echo "  --release RELEASE: debian distro rleases e.g. buster, bullseye, etc. (default: buster)"
+	echo "  --target TARGET: e.g. qemu-amd64, qemu-arm64, qemu-arm (default: qemu-amd64)"
+	echo ""
+	echo " Mandatory aguments:"
+	echo "  artifcats1 and artifacts2 paths to test the artifacts reproducibility"
+	echo ""
+}
+
+RED='\033[0;31m'
+NC='\033[0m'
+GREEN='\033[0;32m'
+IMAGE_BASE="cip-core-image-cip-core"
+RELEASE="bullseye"
+TARGET="qemu-amd64"
+DIFFOSCOPE="diffoscope"
+
+while [ "$1" != "" ]; do
+	case $1 in
+		-r | --release )
+			RELEASE="$2"
+			shift 2
+			;;
+		-t | --target )
+			TARGET="$2"
+			shift 2
+			;;
+		-h | --help )
+			usage
+			exit
+			;;
+		* )
+			remaining_vars="$remaining_vars $1"
+			shift
+			;;
+	esac
+done
+
+set -- $remaining_vars
+artifacts1="$1"
+artifacts2="$2"
+if [ -z "$artifacts1" ] || [ -z "$artifacts2" ]; then
+	echo "artifact folders are missing"
+	usage
+	exit 1
+fi
+
+# Define files in the artifacts for checking the reproducibility
+set -- \
+	"${IMAGE_BASE}-${RELEASE}-${TARGET}-vmlinuz" \
+	"${IMAGE_BASE}-${RELEASE}-${TARGET}-vmlinux" \
+	"${IMAGE_BASE}-${RELEASE}-${TARGET}-initrd.img" \
+	"${IMAGE_BASE}-${RELEASE}-${TARGET}.tar.gz" \
+	"linux.efi" \
+	"${IMAGE_BASE}-${RELEASE}-${TARGET}.swu" \
+	"${IMAGE_BASE}-${RELEASE}-${TARGET}.squashfs" \
+
+# compare artifacts
+res=0
+for file in "$@"; do
+	if [ -f "${artifacts1}/${file}" ] && [ -f "${artifacts1}/${file}" ]; then
+		if $DIFFOSCOPE --text "${file}.diffoscope_output.txt" \
+			"${artifacts1}/${file}" \
+			"${artifacts2}/${file}" > /dev/null 2>&1; then
+			echo "${file}: ${GREEN}Reproducible${NC}" | tee -a diffoscope_output.txt
+		else
+			echo "${file}: ${RED}Not-Reproducible${NC}" | tee -a diffoscope_output.txt
+			res=1
+		fi
+	fi
+done
+
+exit $res
\ No newline at end of file
-- 
2.20.1



