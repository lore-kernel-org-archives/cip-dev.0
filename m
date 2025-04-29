Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673D3C3ABA8
	for <webhook@archiver.kernel.org>; Tue, 29 Apr 2025 04:29:54 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web10.7899.1745900986173900675
 for <cip-dev@lists.cip-project.org>;
 Mon, 28 Apr 2025 21:29:46 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.135, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 53T4TiXh1109883; Tue, 29 Apr 2025 13:29:44 +0900
X-Iguazu-Qid: 2yAb5TJlh1GEMgcq06
X-Iguazu-QSIG: v=2; s=0; t=1745900983; q=2yAb5TJlh1GEMgcq06; m=R1eSnVJNJN54QkHolLU95zmvlx2j/Ls0cXS/DxafKnc=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1801) id 53T4TgR02035743
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 13:29:43 +0900
From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: sai.sathujoda@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][PATCH v1 1/3] submit_lava.sh: Update script to prepare job for amd64 secure boot keys mismatch case
Date: Tue, 29 Apr 2025 09:50:26 +0530
X-TSB-HOP2: ON
Message-Id: <20250429042028.3579304-2-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250429042028.3579304-1-Shivanand.Kunijadar@toshiba-tsip.com>
References: <20250429042028.3579304-1-Shivanand.Kunijadar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 29 Apr 2025 04:29:39.0975 (UTC) FILETIME=[527D0170:01DBB8BF]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 29 Apr 2025 04:29:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18704

Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
---
 scripts/submit_lava.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/scripts/submit_lava.sh b/scripts/submit_lava.sh
index 98e5a2b..6eca70c 100755
--- a/scripts/submit_lava.sh
+++ b/scripts/submit_lava.sh
@@ -118,6 +118,15 @@ create_job_qemu () {
 		if [ "$2" = "qemu-arm" ]; then
 			sed -i "s@bootx64.efi@bootarm.efi@g" "${job_dir}/${1}_unsigned_bootloader_${2}.yml"
 		fi
+	elif [ "$1" = "secure-boot-mismatch-keys" ]; then
+		if [ "$2" = "qemu-amd64" ]; then
+			cp $LAVA_TEMPLATES/secureboot_negative_test.yml "${job_dir}/${1}_mismatch_keys_${2}.yml"
+
+			sed -i "s@#END_MONITOR#@BdsDxe: failed to load Boot@g" "${job_dir}/${1}_mismatch_keys_${2}.yml"
+			sed -i "s@#START_MONITOR#@Access Denied@g" "${job_dir}/${1}_mismatch_keys_${2}.yml"
+			sed -i "s@#ARTIFACT#@keys@g" "${job_dir}/${1}_mismatch_keys_${2}.yml"
+			sed -i "s@#POSTPROCESS_STEPS#@- echo 'no postprocess steps'@g" "${job_dir}/${1}_mismatch_keys_${2}.yml"
+		fi
 	elif [ "$1" = "swupdate-corrupt-swu" ]; then
 		cp $LAVA_TEMPLATES/swupdate_negative_test.yml "${job_dir}/${1}_corrupt_swu_${2}.yml"
 		cd $LAVA_TEMPLATES
@@ -154,6 +163,11 @@ create_job_qemu () {
 	sed -i -e "s@#distribution#@${RELEASE}@g" -e "s@#project_url#@${PROJECT_URL}@g" "${job_dir}"/*.yml
 	sed -i -e "s@#architecture#@${2}@g" -e "s@#imageargs#@${image_args[$2]}@g" "${job_dir}"/*.yml
 
+	if [ "$1" = "secure-boot-mismatch-keys" ]; then
+		sed -i "s@/usr/share/OVMF/OVMF_CODE_4M.secboot.fd@/root/keys/trixie-ovmf/OVMF_CODE_4M.snakeoil.fd@g" "${job_dir}/${1}_mismatch_keys_${2}.yml"
+		sed -i "s@/usr/share/OVMF/OVMF_VARS_4M.snakeoil.fd@/root/keys/trixie-ovmf/OVMF_VARS_4M.snakeoil.fd@g" "${job_dir}/${1}_mismatch_keys_${2}.yml"
+	fi
+
 	# Target is recieved from gitlab job in form of qemu-"architecture"
 	# In the template context field needs only architecture excepting the device type
 	local arch
-- 
2.39.2



