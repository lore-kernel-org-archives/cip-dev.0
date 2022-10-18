Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5518C4332F
	for <webhook@archiver.kernel.org>; Tue, 18 Oct 2022 12:51:10 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.44])
 by mx.groups.io with SMTP id smtpd.web11.6213.1666097461763790252
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Oct 2022 05:51:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=FWqW3cy8;
 spf=pass (domain: siemens.com, ip: 40.107.6.44, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UL6Pr7YqQ9Q10RJYf/ZqY8hCj3W0jxAa0Od18wVwgcVWdS1wmlWN4zyUt9p08B1F7R27EW+mS9zMCfQ2KuiK8hLvTfEwOJ13FqvitiJyWY9nuVPsfG7Sx2QHj4pMXQx5YU09hdqnJTVT1KfDmrNF0fV35h4LKh86ssCAT5hrgEm7AabhwwneeVl5dAAiQFdkH37k4UXyK6KHjjz44f6wYJY2Rrsa2Iyji/W476Uyyrdb6yqVJLpcO7JPFZrOnfK7+0vEVZhcWOC64yRbRQ+7N5w/ORbhv9YPp65mQsIzvA8j/fH2bFMMNVcVGF9mjmJcbFOH8OT6svBZDzZV2gTHqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hJAijfuR5oTcmz1BHupGNY8yDzvCf21Z7BP6+wL2FP8=;
 b=I9e5iN9bPVc45bHU+48w89B1xE3alGdgr9yCZxb3Cf31yq+7UjS/VPhWiI8spEifHDmd9ctYtnlEz6lZlJ/zDJYjfsq9aoMDoGBuBck3XeQBfP1b/XP+QCD61J/09+go64d/tgGcgdEEfCjiCgkmCMsG6gIReGZGv1cWqFBqUYWSn+3BBfcjhtpIDxoKMl0Fo110gLBpVOp34eHF8vG1llQgwU3870HKPsAMXGL3MrM79ZRKzA0gSCw7gy96ohWBarDorKcQHPw/eSDbMwUx21E1kC78y33Xee5Kj61XDeIAmBRNbWP6jipPWXqtT9ghi2c10K4i/67I9DHw0OCdtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 194.138.21.74) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJAijfuR5oTcmz1BHupGNY8yDzvCf21Z7BP6+wL2FP8=;
 b=FWqW3cy8aLWECpjvYmWQ/u1/gg//lltkFNSX3K08pBDNGTyl1mUhPCTToSm0D9xJX51ubMMJnhHGDvpNqFJ3XJZgpoVYJdhUmMT2NfkpH9laA6Wlp16IOj1swaGDrAy/XbVxvd9UpISk9nyFUDQRIDzOCGOeFU0Z1IiFsG+vg8uJqKNEP0vT7AHgBs6NgYtrZPPjQnywaKEfY1HjAZrDox0bBlxK1XGKgbbf8diyugVNNPd8dqQuwoQwY0zLWgw5IFpyM06tkqTI241LP9kwyDr8UftKMaMEuoSybTD/K0wwJadzExRa91nqu2ELg2zC05G11dIBxZV4jd+qv1CUAA==
Received: from DB6PR0801CA0049.eurprd08.prod.outlook.com (2603:10a6:4:2b::17)
 by PAVPR10MB7380.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:31f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.28; Tue, 18 Oct
 2022 12:50:59 +0000
Received: from DB5EUR01FT033.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:2b:cafe::8c) by DB6PR0801CA0049.outlook.office365.com
 (2603:10a6:4:2b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29 via Frontend
 Transport; Tue, 18 Oct 2022 12:50:59 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=siemens.com;
Received-SPF: Fail (protection.outlook.com: domain of siemens.com does not
 designate 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.74) by
 DB5EUR01FT033.mail.protection.outlook.com (10.152.4.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Tue, 18 Oct 2022 12:50:58 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Tue, 18 Oct 2022 14:50:56 +0200
Received: from [139.25.68.37] (139.25.68.37) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.12; Tue, 18 Oct
 2022 14:50:56 +0200
Message-ID: <2a3d6b67-7771-b068-f030-3bb0becfe10b@siemens.com>
Date: Tue, 18 Oct 2022 14:50:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] secureboot: Move IMAGE_TYPEDEP_wic out of
 verity class
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.25.68.37]
X-ClientProxiedBy: DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--10.837100-8.000000
X-TMASE-MatchedRID: IIyI5q76PIWKjhO49WcRv+TPp2ifBOJBBqQ9/FkvES/4AIbmhYnu0lSM
	dQR/r3EeTJDyHMXec/Z1id5dQW4+te5V0cRQF/C90vwQHJ9bAGIsaaYlMvaOHAPZZctd3P4BQon
	mLI1gY+loe+v2w6RhK/lgF+Kg8U8R4LgSdO8exMnrixWWWJYrH01+zyfzlN7ygxsfzkNRlfJlVd
	RvgpNpe/oLR4+zsDTt9Ss5ONHRGPViBBM30ri2/kzG1K2hOK0IaRHQfLKn++Vl4e4xJlCNJg==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--10.837100-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 39BFAE62F96448DEF0774EBB791ECAF413E30E8CE0E8F95D2D1FE05116095CFF2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT033:EE_|PAVPR10MB7380:EE_
X-MS-Office365-Filtering-Correlation-Id: 139281ef-ee84-4387-b419-08dab10767b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	254bD6dEmA/iItGEIeKtK9dTISoC+HfGtgG6uspTs8Rj4QHBzyHPGPMorVsBvZklLH7G0w7/ZyMeh5Zpx1sX1X0bbcwFG1M0fNOFQ5T9H9J3f9v1DfCmRGfPyi7a4XiQY2eT2kOso1Flaxl1vjK1avLwRXWxADq2LCbOa0upFvHuJjziCO21wTW+u7SG5A0umDFmr+U7FIq514aLgKkVtU2K2fzGmsQVjNyEfrjzA4ttv1qrDmKV6nCdPNZq4Yn0QGal/Y4q1/iwnSYmSiZSFWPWWBbD6giKyQU5OD5fpdu5vktMOSH73f1YPlvZZ2Ksh+q/T+l9I+Ez7iDr4wN1Qw3Pz/XjB6msdvaBXN09RLnQti5Fcs+c78odfCu9hJ6Omx+LTBEco091EUzASOr3aZbYM9ozhOi0K/jbakRyoqRYcxwXh7tzRGRITU3eJUiBUFVzlcTYLEeHOUSic6zt6UuS2H5e6asMhQp4zA8in8fC96qW0eNAsGt3PuKpfHB/NT3WvG8VvG4XBw3zTV4Xj4n8NknAwPhOXcH4/4phBPotuZYo4Byoj2OB5GmgAsTcAQRtJfz/sVI7SO8NyRK3LsFiweNtJgd+h0iOSWn/hyVruQD/9NDdoYK+G4uq4hjg1u3ue92HxdtsuVndZHzpQ/SYMmNhlOj5qkaKOsiF6LPfVaYbE9MZWBgperTvZdXutJEFepalpfwkQ0lR48IzkrOOFY9wVS5jvzMxKVQh9oZIjI4GBJuND4PLAIMxdcCsrQJC8TSZ3NZP+rSHMNtboW57hTOEtCcg5cCMM0TEsIkLwWddZAzbbeCO8tzMZDcLmIFlBZdsuLil2FOzqPgiH///0vZ1NBVY0kANPUWgKQN6YphuRcgQ4+LC8QwQHlh+W3/vf1SZ6SkR6UEUXs9m4Q==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199015)(36840700001)(46966006)(40470700004)(6916009)(31686004)(44832011)(8676002)(6706004)(316002)(16576012)(478600001)(26005)(41300700001)(186003)(2906002)(16526019)(336012)(5660300002)(956004)(8936002)(2616005)(82960400001)(36756003)(82740400003)(356005)(7596003)(7636003)(82310400005)(47076005)(36860700001)(83380400001)(70586007)(70206006)(6666004)(31696002)(86362001)(40460700003)(40480700001)(34020700004)(403724002)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 12:50:58.8386
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 139281ef-ee84-4387-b419-08dab10767b4
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT033.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7380
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Oct 2022 12:51:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9774

From: Jan Kiszka <jan.kiszka@siemens.com>

The usage of class is not bound to wic, thus we should not declare any
dependency of wic on it. This makes the verity pattern analogous to the
squashfs one (for non-secure booting).

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 classes/verity.bbclass               | 1 -
 kas/opt/ebg-secure-boot-snakeoil.yml | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/classes/verity.bbclass b/classes/verity.bbclass
index 0f154fb6..b6b06f41 100644
--- a/classes/verity.bbclass
+++ b/classes/verity.bbclass
@@ -14,7 +14,6 @@ VERITY_IMAGE_TYPE ?= "squashfs"
 inherit ${VERITY_IMAGE_TYPE}
 
 IMAGE_TYPEDEP_verity = "${VERITY_IMAGE_TYPE}"
-IMAGE_TYPEDEP_wic += "verity"
 IMAGER_INSTALL_verity += "cryptsetup"
 
 VERITY_INPUT_IMAGE ?= "${IMAGE_FULLNAME}.${VERITY_IMAGE_TYPE}"
diff --git a/kas/opt/ebg-secure-boot-snakeoil.yml b/kas/opt/ebg-secure-boot-snakeoil.yml
index f756ceea..e92ea5e0 100644
--- a/kas/opt/ebg-secure-boot-snakeoil.yml
+++ b/kas/opt/ebg-secure-boot-snakeoil.yml
@@ -18,6 +18,7 @@ local_conf_header:
   secure-boot-image: |
     IMAGE_CLASSES += "verity"
     IMAGE_FSTYPES = "wic"
+    IMAGE_TYPEDEP_wic += "verity"
     WKS_FILE = "${MACHINE}-efibootguard-secureboot.wks.in"
     INITRAMFS_INSTALL_append = " initramfs-verity-hook"
     # abrootfs cannot be installed together with verity
-- 
2.35.3

