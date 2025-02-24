Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B900C021B3
	for <webhook@archiver.kernel.org>; Mon, 24 Feb 2025 08:53:15 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web11.85320.1740387187152113221
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Feb 2025 00:53:07 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 51O8r5492495151; Mon, 24 Feb 2025 17:53:05 +0900
X-Iguazu-Qid: 2yAb5TJlfGnakxiyX7
X-Iguazu-QSIG: v=2; s=0; t=1740387184; q=2yAb5TJlfGnakxiyX7; m=/sdzyQ23Mnend5dtMXbk1dKR5UfuQRAc1yCoOwCNAM0=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1802) id 51O8r48n3622743
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 24 Feb 2025 17:53:04 +0900
From: Adithya.Balakumar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Adithya Balakumar <adithya.balakumar@toshiba-tsip.com>,
        shivanand.kunijadar@toshiba-tsip.com, sai.sathujoda@toshiba-tsip.com,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][PATCH v1 2/2] scripts/repro-tests.sh: Update script to check wic file reproducibility
Date: Mon, 24 Feb 2025 04:00:52 -0500
X-TSB-HOP2: ON
Message-Id: <20250224090052.260495-3-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224090052.260495-1-Adithya.Balakumar@toshiba-tsip.com>
References: <20250224090052.260495-1-Adithya.Balakumar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 24 Feb 2025 08:53:00.0495 (UTC) FILETIME=[81E505F0:01DB8699]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Feb 2025 08:53:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17889

From: Adithya Balakumar <adithya.balakumar@toshiba-tsip.com>

Running diffoscope on the full wic image can be problematic as diffoscope
has issues with high memory consumption and jobs could fail in the CI [1]

Instead check the hash values of the wic files and if found
non-reproducible then run diffoscope on the individual partition images

[1] https://salsa.debian.org/reproducible-builds/diffoscope/-/issues/383

Signed-off-by: Adithya Balakumar <adithya.balakumar@toshiba-tsip.com>
---
 scripts/repro-tests.sh | 92 +++++++++++++++++++++++++++---------------
 1 file changed, 60 insertions(+), 32 deletions(-)

diff --git a/scripts/repro-tests.sh b/scripts/repro-tests.sh
index 8bdb34b..7249204 100755
--- a/scripts/repro-tests.sh
+++ b/scripts/repro-tests.sh
@@ -14,11 +14,12 @@ set -e
 
 usage()
 {
-	echo "usage: repro-tests.sh [--release RELEASE] [--target TARGET] artfacts1 artifacts2"
+	echo "usage: repro-tests.sh [--release RELEASE] [--target TARGET] artifacts1 artifacts2"
 	echo ""
 	echo " Optional arguments:"
-	echo "  --release RELEASE: debian distro releases e.g. buster, bullseye, etc. (default: buster)"
+	echo "  --release RELEASE: debian distro releases e.g. buster, bullseye, etc. (default: bookworm)"
 	echo "  --target TARGET: e.g. qemu-amd64, qemu-arm64, qemu-arm (default: qemu-amd64)"
+	echo "  --extension EXTENSION: e.g. security (default: "")"
 	echo ""
 	echo " Mandatory arguments:"
 	echo "  artifacts1 and artifacts2 paths to test the artifacts reproducibility"
@@ -29,7 +30,7 @@ RED='\033[0;31m'
 NC='\033[0m'
 GREEN='\033[0;32m'
 IMAGE_BASE="cip-core-image-cip-core"
-RELEASE="bullseye"
+RELEASE="bookworm"
 TARGET="qemu-amd64"
 EXTENSION=""
 DIFFOSCOPE="diffoscope"
@@ -72,35 +73,62 @@ if [ "${EXTENSION}" = "security" ]; then
 	IMAGE_BASE="cip-core-image-security-cip-core"
 fi
 
-# Define files in the artifacts for checking the reproducibility
-set -- \
-	"${IMAGE_BASE}-${RELEASE}-${TARGET}.swu" \
-	"${IMAGE_BASE}-${RELEASE}-${TARGET}.wic.p0" \
-	"${IMAGE_BASE}-${RELEASE}-${TARGET}.wic.p1" \
-	"${IMAGE_BASE}-${RELEASE}-${TARGET}.wic.p2" \
-	"${IMAGE_BASE}-${RELEASE}-${TARGET}.wic.p3" \
-	"${IMAGE_BASE}-${RELEASE}-${TARGET}.wic.p4" \
-	"${IMAGE_BASE}-${RELEASE}-${TARGET}.wic.p5" \
-	"${IMAGE_BASE}-${RELEASE}-${TARGET}.wic.p6" \
-	"${IMAGE_BASE}-${RELEASE}-${TARGET}.wic.p7"
+run_diffoscope() {
+    local file="$1"
+    local artifacts1="$2"
+    local artifacts2="$3"
+    local label=""
+    local fstype=""
+    local res=0
 
-# compare artifacts
-res=0
-for file in "$@"; do
-	if [ -f "${artifacts1}/${file}" ] && [ -f "${artifacts2}/${file}" ]; then
-		label=$(blkid -s LABEL -o value ${artifacts1}/${file} || true)
-		fstype=$(blkid -s TYPE -o value ${artifacts1}/${file} || true)
-		if $DIFFOSCOPE --text "${file}.diffoscope_output.txt" \
-			--html-dir diffoscope_output \
-			--html "${file}.diffoscope_output.html" \
-			"${artifacts1}/${file}" \
-			"${artifacts2}/${file}" > /dev/null 2>&1; then
-			echo "${file}($label,$fstype): ${GREEN}Reproducible${NC}" | tee -a diffoscope_output.txt
-		else
-			echo "${file}($label,$fstype): ${RED}Not-Reproducible${NC}" | tee -a diffoscope_output.txt
-			res=1
-		fi
+    # Get partition label and filesystem type
+    label=$(blkid -s LABEL -o value ${artifacts1}/${file} || true)
+    fstype=$(blkid -s TYPE -o value ${artifacts1}/${file} || true)
+
+    # Run diffoscope comparison
+    if $DIFFOSCOPE --text "${file}.diffoscope_output.txt" \
+        --html-dir diffoscope_output \
+        --html "${file}.diffoscope_output.html" \
+        "${artifacts1}/${file}" \
+        "${artifacts2}/${file}" > /dev/null 2>&1; then
+        echo "${file}($label,$fstype): ${GREEN}Reproducible${NC}" | tee -a diffoscope_output.txt
+    else
+        echo "${file}($label,$fstype): ${RED}Not-Reproducible${NC}" | tee -a diffoscope_output.txt
+        res=1
+    fi
+
+    return $res
+}
+
+# compare swu file
+res_swu=0
+swu_file="${IMAGE_BASE}-${RELEASE}-${TARGET}.swu"
+if [ -f "${artifacts1}/${swu_file}" ] && [ -f "${artifacts2}/${swu_file}" ]; then
+	swu1_sha256sum=$(sha256sum "${artifacts1}/${IMAGE_BASE}-${RELEASE}-${TARGET}.swu" | awk '{ print $1 }')
+	swu2_sha256sum=$(sha256sum "${artifacts2}/${IMAGE_BASE}-${RELEASE}-${TARGET}.swu" | awk '{ print $1 }')
+	if [ "$swu1_sha256sum" != "$swu2_sha256sum" ]; then
+		run_diffoscope "$swu_file" "$artifacts1" "$artifacts2"
+		[ $? -ne 0 ] && res_swu=1
+	else
+		echo "${IMAGE_BASE}-${RELEASE}-${TARGET}.swu: ${GREEN}Reproducible${NC}" | tee -a diffoscope_output.txt
 	fi
-done
+fi
 
-exit $res
+# compare wic files
+res_wic=0
+image1_sha256sum=$(sha256sum "${artifacts1}/${IMAGE_BASE}-${RELEASE}-${TARGET}.wic" | awk '{ print $1 }')
+image2_sha256sum=$(sha256sum "${artifacts2}/${IMAGE_BASE}-${RELEASE}-${TARGET}.wic" | awk '{ print $1 }')
+if [ "$image1_sha256sum" != "$image2_sha256sum" ]; then
+	echo "${IMAGE_BASE}-${RELEASE}-${TARGET}.wic: ${RED}Not-Reproducible${NC}"
+	res_wic=1
+	echo "Running diffoscope on individual partitions..."
+	for part_num in $(seq 0 7); do
+		file=${IMAGE_BASE}-${RELEASE}-${TARGET}.wic.p${part_num}
+		if [ -f "${artifacts1}/${file}" ] && [ -f "${artifacts2}/${file}" ]; then
+			run_diffoscope "$file" "$artifacts1" "$artifacts2"
+		fi
+	done
+else
+	echo "${IMAGE_BASE}-${RELEASE}-${TARGET}.wic: ${GREEN}Reproducible${NC}" | tee -a diffoscope_output.txt
+fi
+exit $(( res_swu || res_wic ))
\ No newline at end of file
-- 
2.39.5



