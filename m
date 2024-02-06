Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F35CC48297
	for <webhook@archiver.kernel.org>; Tue,  6 Feb 2024 12:27:55 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.20157.1707222466534019812
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Feb 2024 04:27:49 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.05,247,1701097200"; 
   d="scan'208";a="193048686"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 06 Feb 2024 21:27:49 +0900
Received: from Ubuntu-22.. (unknown [10.226.93.78])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id C3AB64005E16;
	Tue,  6 Feb 2024 21:27:47 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH v2 5.10.y-cip 06/44] cacheinfo: clear cache_leaves(cpu) in free_cache_attributes()
Date: Tue,  6 Feb 2024 12:26:56 +0000
Message-Id: <20240206122734.13477-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206122734.13477-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240206122734.13477-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Feb 2024 12:27:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14790

From: Xiongfeng Wang <wangxiongfeng2@huawei.com>

commit e022eac85ecd2140a0829970d923d984356185eb upstream.

On ARM64, when PPTT(Processor Properties Topology Table) is not
implemented in ACPI boot, we will goto 'free_ci' with the following
print:
  Unable to detect cache hierarchy for CPU 0

But some other codes may still use 'num_leaves' to iterate through the
'info_list', such as get_cpu_cacheinfo_id(). If 'info_list' is NULL , it
would crash. So clear 'num_leaves' in free_cache_attributes().

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Link: https://lore.kernel.org/r/1626226375-58730-1-git-send-email-wangxiongfeng2@huawei.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 drivers/base/cacheinfo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index bfc095956dd11..dad2962291614 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -297,6 +297,7 @@ static void free_cache_attributes(unsigned int cpu)
 
 	kfree(per_cpu_cacheinfo(cpu));
 	per_cpu_cacheinfo(cpu) = NULL;
+	cache_leaves(cpu) = 0;
 }
 
 int __weak init_cache_level(unsigned int cpu)
-- 
2.34.1


