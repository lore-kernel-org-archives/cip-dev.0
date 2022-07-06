Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DBCC43334
	for <webhook@archiver.kernel.org>; Wed,  6 Jul 2022 09:28:42 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.62])
 by mx.groups.io with SMTP id smtpd.web11.4107.1657099721581782473
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Jul 2022 02:28:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ugS1Dbp7;
 spf=pass (domain: siemens.com, ip: 40.107.20.62,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYE8d9hrACFl3xzQJk/m29lRSlfppxDsCexO7QsFruXmCRyySa4EhzlSYVpSUQ/BJhHUlnT6tYaxCNj5D9fCzIF7rHoPYva7ZbB5EsEulURKe0Dwsv/YI7JJf7e5438X3yZ5DVBcjw+DSdry22mTKGizNfitZlE3p83QtxOoE81xgNmI4slxmreW2W3O9ac7SJPBJ/+eSMDAMjV4ncHvT4tWivw90/m3h1E7Dyp6p69hLry8pqUXCdNb5maXQGlz+ZzyCw9DyRuPU6jj0hnpDY+xZy0d9YfB/Qp5LraMdk+xtXfFzbfFV0fGUsIm4z4yhpSZkwAIrvcYnD7wC0s4xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=igzKONYP3j/xf3VL74mdjqRyz2mGTfgO/qfTM7UnXXQ=;
 b=FKRYBB51bDX1a+RzU+AtsbR83s4QVASHH+yYUJnrZNL6jm/jTrbfzHYg2tQVkv1Az+/k/D+/1x9LProPMhYL9q1xHeZC5oZWfNve5egRB39UB1Nj8yPvpMMzft70EL0d3CBM5NrtcdWU4fvcbZ5mIonkRoie2FU/yxNLWmxFW1YdgcWWU4VRv9aRfNHaDYOJAxO+rqR44gtrdMnRft+C67XPDu5Ca34l1lkKYSRx/0zzLmzJp0RHz/pX9kgrMjTJ7iW9v0tki1smdvld9DJmmtraKG1QP1UVZlZkmG7JIIXS+obACQWF8gB91SbIZxCW3IwWnlbO8JAbh07z6A+Mew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=igzKONYP3j/xf3VL74mdjqRyz2mGTfgO/qfTM7UnXXQ=;
 b=ugS1Dbp7rLDu0SP3J0Mo83hYc6ZwqJlXM7UKLFFxO3Ueb9fUukqBzGad9n9bUBbPX+hhulEcSn7ez5CHX3+TAjuSaj+prWy0WJgZ+FoIHsdzAcNLLbNlWXOicU0Y6q6PNTpoauUN5fk8Z4v3/2W96qIEomjjbVZvUjoeC38JwmvIHXjllSDFtD0Xc9BbdTKMawvbdXvomj9Fit6p17PdJi8zAd/BLxfob+6P8l62KRVYLk7LXEfPsFuwrjdNHRXQF6uod7aC9cLhM1+6Q6CFngyBbdmcM1Tfi777pYPHuATlf1DQ+vTQ3+3TN/14veo3j2R+qkzSlNui1WEKTiuTdA==
Received: from BE1P281CA0065.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:26::11)
 by VE1PR10MB2912.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:111::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Wed, 6 Jul
 2022 09:28:37 +0000
Received: from HE1EUR01FT019.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:b10:26:cafe::19) by BE1P281CA0065.outlook.office365.com
 (2603:10a6:b10:26::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.8 via Frontend
 Transport; Wed, 6 Jul 2022 09:28:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.71) by
 HE1EUR01FT019.mail.protection.outlook.com (10.152.0.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.15 via Frontend Transport; Wed, 6 Jul 2022 09:28:37 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Wed, 6 Jul 2022 11:28:35 +0200
Received: from [139.22.133.252] (139.22.133.252) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Wed, 6 Jul 2022 11:28:35 +0200
Message-ID: <5a55d3e4-60d3-b16d-24f7-95ee5c59a2f7@siemens.com>
Date: Wed, 6 Jul 2022 11:28:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH isar-cip-core] start-qemu: Use only 2 cores with armhf
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
CC: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.133.252]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--10.763300-8.000000
X-TMASE-MatchedRID: WeFhSxvsApM56UleuofCzRcHHrR1LkjnHyalOoLosZE/ApMPW/xhXkyQ
	5fRSh265BCzD0Dc8iUtfuSTIKFlR4qFXTsKoLSDkjD7FJFrrh+tzrmBVcTb6HJ4CIKY/Hg3AtOt
	1ofVlaoJlgn288nW9IJewQMipl48j5MIx11wv+CM7AFczfjr/7DIGcrxoauSxUE9/XJCijCjWfu
	UxhPP8T3VpsTdkp2Abyep10OQSfWM=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--10.763300-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 F8730C4AF2AE5705E15191F0A520B631FE76F94EAEF2597475BDC0231C505E232000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f23683a4-96fc-4c3e-abde-08da5f31e7d0
X-MS-TrafficTypeDiagnostic: VE1PR10MB2912:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Hhnh9OcfYR6EJUt4aIXrJU9oB+xkevOdNTXYfRUA18r1P/ydG2bOSriW8KO1AowmCP8uV8pUSEvRwZ/LU69Fb2/+mZukanhgn3RMs7AfzO/eyPGS35jI2J/CYNT0mlgrRyhgpVlTO23zM1GrxzEwGOBP4nA7d7mkKR4RJEmF11IIpFATc9iT+IZOdChtpmHQmsDZZQOVW7ZRA/vViKhVFlFm2gpcKzqTRxjGCV8LETE5fx8rPd0pwDAnnfqwmTKDhEFlRQOTd3aB5j3D/+5oGfRsnvB5V2dyhaYOPMBIel/v9HG6WW//Sm9rjck6pTx0Yuya8pOB/2Nh0YcIDr2yP31izmiOSc+WM/Z2TqbbtQCLCS0KgEOvhJEc/iSBSV5QccIrnytDZ38WY1kjNcaijDBLjSxvDcWrQZ6o87VS0JNK5o1Vxn0C/Y0d+PNOgEElR9aI3xgLgvdCHremaW+Pw9I9EoFpE3tt4TjLOCTvX8l8bhR7SsEA/wl3a5+9ANcI93O0IgWiHnFWV8UNg00CD6I29HeUQSRZ5xFfIk9heqzi53/W8ujxlHC4zqJL7XZc77AXc3M9gkQEx8quAFwF6FCtu+juoLlO86TJ4CLIfWW213FAjuYyv/gdwi8WwL7DfFJDq8lsZKJoO+zB4jXoBOepXHXV0NcA0DsRwfksCPUq4RseTfbMOAeh1usEWhLPqY/x2e/SaLqKSzIRwYXKxdzeSrati29B9In9CEEiVgb+O/mXIUZltSkDJCVRRN1+ciE76X8EcA7GbN1V6jPQbDfHMt3oTPlseBJODYE1St9mDb7ogaH74po9CDuo6iLumnMFbaJXkeWiCpYJu9FLKGK56HWFlTKQDvN8w1ML4uq8hN5UdjVTM+mhHvq9aWBum535mk/KfQPdelmbSlzxrbKBKetuzzmTzW1y4AhxdZU=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(396003)(346002)(136003)(36840700001)(40470700004)(46966006)(186003)(16526019)(2906002)(26005)(336012)(956004)(2616005)(83380400001)(36860700001)(40480700001)(31686004)(36756003)(82310400005)(41300700001)(6916009)(6706004)(356005)(44832011)(82960400001)(4744005)(8936002)(478600001)(5660300002)(81166007)(8676002)(70206006)(70586007)(4326008)(47076005)(316002)(16576012)(40460700003)(31696002)(86362001)(82740400003)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 09:28:37.2657
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 f23683a4-96fc-4c3e-abde-08da5f31e7d0
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT019.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB2912
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Jul 2022 09:28:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8698

From: Jan Kiszka <jan.kiszka@siemens.com>

This is what our configs set as upper limit.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 start-qemu.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/start-qemu.sh b/start-qemu.sh
index 2350612..f7ca87f 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -88,7 +88,7 @@ case "${arch}" in
 		QEMU=qemu-system-arm
 		QEMU_EXTRA_ARGS=" \
 			-cpu cortex-a15 \
-			-smp 4 \
+			-smp 2 \
 			-machine virt \
 			-device virtio-serial-device \
 			-device virtconsole,chardev=con -chardev vc,id=con \
-- 
2.35.3

