Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7043C433F5
	for <webhook@archiver.kernel.org>; Mon, 10 Oct 2022 07:02:52 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web10.3622.1665385362897430266
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Oct 2022 00:02:43 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.156,
 mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 29A72e8c006208;
 Mon, 10 Oct 2022 16:02:40 +0900
X-Iguazu-Qid: 2wHHOH6CCgO9mKelGa
X-Iguazu-QSIG: v=2; s=0; t=1665385360; q=2wHHOH6CCgO9mKelGa;
 m=1Z/9aElWlkoQWm4DKhkMulDbnqg++hatf9Q8z2Cn7RU=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1113) id 29A72dNq026528
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 10 Oct 2022 16:02:40 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Sai <Sai.Sathujoda@toshiba-tsip.com>, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core 3/3] start-efishell.sh : Use default OVMF files with
 '4M' size
Date: Mon, 10 Oct 2022 12:32:32 +0530
X-TSB-HOP2: ON
Message-Id: <20221010070232.10478-4-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221010070232.10478-1-Sai.Sathujoda@toshiba-tsip.com>
References: <20221010070232.10478-1-Sai.Sathujoda@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 10 Oct 2022 07:02:34.0888 (UTC)
 FILETIME=[462AA080:01D8DC76]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Oct 2022 07:02:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9705

From: Sai <Sai.Sathujoda@toshiba-tsip.com>

Make changes in the OVMF keys to be in sync with changes made
in da0ff6630c7f6e48fc82b3766a04992bee7fcafe

Signed-off-by: Sai <Sai.Sathujoda@toshiba-tsip.com>
---
 scripts/start-efishell.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/start-efishell.sh b/scripts/start-efishell.sh
index 0831f83..980b9cc 100755
--- a/scripts/start-efishell.sh
+++ b/scripts/start-efishell.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
-ovmf_code=${OVMF_CODE:-/usr/share/OVMF/OVMF_CODE.secboot.fd}
-ovmf_vars=${OVMF_VARS:-./OVMF_VARS.fd}
+ovmf_code=${OVMF_CODE:-/usr/share/OVMF/OVMF_CODE_4M.secboot.fd}
+ovmf_vars=${OVMF_VARS:-./OVMF_VARS_4M.fd}
 DISK=$1
 qemu-system-x86_64 -enable-kvm -M q35 -nographic \
                    -cpu host,hv_relaxed,hv_vapic,hv-spinlocks=0xfff -smp 2 -m 2G -no-hpet \
-- 
2.20.1



