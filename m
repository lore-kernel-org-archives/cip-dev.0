Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34048C433F5
	for <webhook@archiver.kernel.org>; Tue, 15 Mar 2022 14:09:48 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (EUR01-DB5-obe.outbound.protection.outlook.com [40.107.15.78])
 by mx.groups.io with SMTP id smtpd.web09.11305.1647353387052788088
 for <cip-dev@lists.cip-project.org>;
 Tue, 15 Mar 2022 07:09:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=pK6YyUW8;
 spf=pass (domain: siemens.com, ip: 40.107.15.78,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOs6wKHQ9t0ru8/3IRM5Qt0029GMc1OMFhSkt7IlOUYH9VlsqDUJEv7rSZSJdU5JqUTDytqOkgwFz/1UMl5t7Pb9BNjcC6TnLBJazJpuLodk+VlB/QXOK8pElutTtGcSom6+CsyNbklK5kuaFqymo6sFEE+vwBmbOp+f/3N1RiOz7mf3faovdV7wVzSDEXCLcm/aLUri1n12NkOSDO3q22U1APaWYLijd+Om8VPRuOfFnX4lqG41vL5LPEPxMZnZ27Ezc4isSU2Fctnt5hIcu+sHsQ5NV4D3rHrhkdb0ybb+J2BTo7PKTxrFeBwXuRVmNd9smQJC9dlCFpJKeXG5lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/f/l6kDLb1HmSYPS85axerIeQnbyBvNe2c6EUUi2Dg=;
 b=XVDJ9/Lc/stB13LGvshoncNVsV7/pJNwegwKTWlI7sQ4eBqneyyhMFeZUUAf4hsLy+cl7G3myQuAQ+iw4mIcGrJYd3YW2fNGxLUC9Ik7ghRkE3ctKW5FacOhOOwnEa6LlaKuVnEfnYSlG2WaWStgzua4FjWtgq+FC64ZMKTQxQKhaFeK1xuWRrCj/U1doQ3YOtcuMECOY6OuHadE0mXEsVi7AAT2Rc4beCzbYrDi3dLmV4xM2hQUP3BL/6ut/2s0MHRbv5TOqVpg0m97HK3X6xqa5ADPlOos8xtd95TShb2GaItp7xvGLLqf0LXiwy3OnX8NAvtD4jyQFtY/2Hv3Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/f/l6kDLb1HmSYPS85axerIeQnbyBvNe2c6EUUi2Dg=;
 b=pK6YyUW81Zap7VJj8h5FV/TvWfV6DIE18FxWHq0Sip513QnUcDbvGLvMixYNqZYBkHXk3biq7/bSfgjDTAgjDGbSeAFl0UMrttcACb1GbVBeEUpkDkItvJQLxmvKjPs0OsjFEeaQlQ1RqBTtX2huWRSCe3hGNJA12kx2FJOICOBupcb2k578YepFEUs2tBafdBHt2Y4bAqMaH0X55DB7a769Tn77xm+Z6O6zAV7XYD4Zw5/GCKjH7X5Ox9u4sCsBV7UldaxNZ4YRkCcVAqO8TqR4hLLSswJ9mlNIgGzk7xdV8bjjaUQvd0XWA+sM1TTNaC6Apfw0SPIQ4CCCRBAsAA==
Received: from DB6P192CA0006.EURP192.PROD.OUTLOOK.COM (2603:10a6:4:b8::16) by
 AM5PR10MB1746.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:206:1f::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5061.25; Tue, 15 Mar 2022 14:09:44 +0000
Received: from DB5EUR01FT041.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:b8:cafe::97) by DB6P192CA0006.outlook.office365.com
 (2603:10a6:4:b8::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.13 via Frontend
 Transport; Tue, 15 Mar 2022 14:09:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.72) by
 DB5EUR01FT041.mail.protection.outlook.com (10.152.5.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Tue, 15 Mar 2022 14:09:43 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Tue, 15 Mar 2022 15:09:43 +0100
Received: from [167.87.0.35] (167.87.0.35) by DEMCHDC8A0A.ad011.siemens.net
 (139.25.226.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 15 Mar
 2022 15:09:43 +0100
Message-ID: <b7989765-922f-c4e6-bdb9-30c773c33513@siemens.com>
Date: Tue, 15 Mar 2022 15:09:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] linux-cip: Update to v4.19.233-cip69-rt24
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.0.35]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d03fc12-0219-43fd-554a-08da068d7447
X-MS-TrafficTypeDiagnostic: AM5PR10MB1746:EE_
X-Microsoft-Antispam-PRVS: 
	<AM5PR10MB1746E1CD5C22A534D21E270795109@AM5PR10MB1746.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	9Ak07dHg/nOSFiEumC8q4jX63ZsyQ/DGFRzfA89TnoBe3J1v2l1V5Z+XyxsNxiWg6LxLjOW6V6fWWad9ZUZvieuDzdO7lBUSHXaPl/zJvhi5t5gdnt6Gug/mezkfasKIk+NB9FNe1rhsto4BnYz4ziXD8Vzu6DHyKF2eiNef+gI5N6RGVtxMyxSWX5EesALoxmRE4/jgBCHuB+NGHWPKggT2RLDq/5kIK6kX4vTsgITA5/IUOyQsIc8rNzMlUQAuKjnkMFCe+31fH8FHdn+x6ktopgP3+hIZ4xXECAP5yEFbq24Vw3NeFoEyLbJ0fQ8bvfnRivPCfOb9mevgppoA/6IaZySpH3dydCWRhMmRsx4n8GIK3UqoC0FbquTA8CqNzx7Tw66yA6tZ6whdSDChn6rCCbbADYmMvLAd78IC7kMIPvBweY1fv6nY8j0Pfv4I7iPgjAFO8x4jyTCMMv2s+7LKTxItQ1xIt4uTW44kTl01COGVAG9JxGbbqJSlli8HkditDputHqyBAYB5GGPvr+ER9Tn+um66dhCZ6P9kRTdKhR4HF5CCNryFEI8XA+2Aewzqf64C6rzehj9W9Lx6cnUI7lRHCSko1juzhoirI1395Ub51TBUcK3xaQ2N5DKGSvph0L6nWOx7aTvVOseJu9QoBNzs3T9ksNRMey2XmoUSmgM5m3Ar3l/QLYDEWvQjEHGS4WQhyJz6BRM4f5xnHq8+XyD4F8XgIWFPMJGE8lHoVs5WPSelfVyfW2urrxaC7rxmFr1cn9AyoahTo70fDA==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(6706004)(6916009)(16576012)(8676002)(70586007)(31696002)(70206006)(498600001)(86362001)(31686004)(40460700003)(47076005)(5660300002)(36756003)(36860700001)(44832011)(8936002)(356005)(81166007)(82310400004)(83380400001)(2616005)(16526019)(26005)(82960400001)(336012)(186003)(956004)(2906002)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 14:09:43.6552
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 2d03fc12-0219-43fd-554a-08da068d7447
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT041.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR10MB1746
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 15 Mar 2022 14:09:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7740

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...19.217-cip62-rt23.bb => linux-cip-rt_4.19.233-cip69-rt24.bb} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename recipes-kernel/linux/{linux-cip-rt_4.19.217-cip62-rt23.bb => linux-cip-rt_4.19.233-cip69-rt24.bb} (72%)

diff --git a/recipes-kernel/linux/linux-cip-rt_4.19.217-cip62-rt23.bb b/recipes-kernel/linux/linux-cip-rt_4.19.233-cip69-rt24.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip-rt_4.19.217-cip62-rt23.bb
rename to recipes-kernel/linux/linux-cip-rt_4.19.233-cip69-rt24.bb
index 2eefbdc..6d1a97a 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.19.217-cip62-rt23.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.19.233-cip69-rt24.bb
@@ -13,4 +13,4 @@ require linux-cip-rt-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "4.19.y-cip"
 
-SRC_URI[sha256sum] = "f7584d79132ad99ed5b7ce7430c79a08cb9b81ad40b5982464f95859a00ceb6f"
+SRC_URI[sha256sum] = "ba959c6591e114d85a0ae9bfe60d4e4eb4bf1b2b02c3b9f3de2dfc692cca112e"
-- 
2.34.1

