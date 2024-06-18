Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425B2C2BA18
	for <webhook@archiver.kernel.org>; Tue, 18 Jun 2024 16:10:54 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web11.90419.1718727046425880578
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Jun 2024 09:10:46 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 45IGAihr3077118; Wed, 19 Jun 2024 01:10:45 +0900
X-Iguazu-Qid: 2yAbfjWam4hjIFhTIO
X-Iguazu-QSIG: v=2; s=0; t=1718727044; q=2yAbfjWam4hjIFhTIO; m=KTbKf3gu98qhcH95aQqe6evUXx2oHHyU9uDiMI/6olk=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1801) id 45IGAhOl1686267
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 01:10:43 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v1 2/3] submit_lava.sh: Rectify the ustate value in case of a rollback scenario
Date: Tue, 18 Jun 2024 21:40:34 +0530
X-TSB-HOP2: ON
Message-Id: <20240618161035.1810237-3-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240618161035.1810237-1-Sai.Sathujoda@toshiba-tsip.com>
References: <20240618161035.1810237-1-Sai.Sathujoda@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 18 Jun 2024 16:10:34.0256 (UTC) FILETIME=[0CABC900:01DAC19A]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Jun 2024 16:10:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16286

From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>

In the rollback test cases, ustate should be 3 after reboot. But currently
the definition is checking for 0. This error is not caught because the sleep
time was covered inside the timeout leading the job to be complete.

Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
---
 scripts/submit_lava.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/submit_lava.sh b/scripts/submit_lava.sh
index b2810e0..ee8dd37 100755
--- a/scripts/submit_lava.sh
+++ b/scripts/submit_lava.sh
@@ -58,11 +58,12 @@ create_job () {
 
 	elif [ "$1" = "swupdate" ]; then
 		cp $LAVA_TEMPLATES/swupdate_template.yml "${job_dir}/${1}_${2}.yml"
+		sed -i "s@#updatestate#@2@g" "${job_dir}"/*.yml
 
 	elif [ "$1" = "kernel-panic" ] || [ "$1" = "initramfs-crash" ]; then
 		cp $LAVA_TEMPLATES/swupdate_template.yml "${job_dir}/${1}.yml"
 		sed -i "s@software update testing@${1}_rollback_testing@g" "${job_dir}"/*.yml
-		sed -i "s@) = 2@) = 0@g" "${job_dir}"/*.yml
+		sed -i -e "s@#updatestate#@3@g" -e "s@) = 2@) = 3@g" "${job_dir}"/*.yml
 		if [ "$1" = "kernel-panic" ]; then
 			sed -i "s@kernel: C:BOOT1:linux.efi@Kernel panic - not syncing: sysrq triggered crash@g" "${job_dir}"/*.yml
 			sed -i "s@#branch#@maintain-lava-artifact@g" "${job_dir}"/*.yml
-- 
2.30.2



