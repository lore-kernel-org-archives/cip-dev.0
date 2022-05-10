Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35248C433EF
	for <webhook@archiver.kernel.org>; Tue, 10 May 2022 09:54:13 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.55])
 by mx.groups.io with SMTP id smtpd.web10.7769.1652176449744300393
 for <cip-dev@lists.cip-project.org>;
 Tue, 10 May 2022 02:54:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=xWrN6TGg;
 spf=pass (domain: siemens.com, ip: 40.107.21.55,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDWMsMQ4oFQTib/cbCbJLjXDAvtcINWp2mUExn9Pm3EEVnQhxykKztfWvP0e5ukzMrj8iJHu3q/m0IYhPsY1tQPsvrw5rZM2xyrc7otxaZnGc3t80wb0X61r9uyDKrqC1Jt/ia19+mj3M5oPjTYIg9xTXJdatS16aO7luHvsS4BFh7fKIYwGRB40ljLe1kwVkt8vjzaouk6mOHmuHXI8YGoxUeosKmSKPUH/4bayv50klYvmd/3B03H6YHE/7orTp8jytqxDU/Y/W3JXYhuBZDyEitCRYHAq3Uh/8puoCb/a7SEsI2//Ym59OpRl6P85lLmfLKa8+3cDLhjFXrfqEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zo4UeuUCKqKxBNDoVK54RBqz0Hm32GRXTwHuQDNQ5QY=;
 b=MSA8v7h51uDSdr5MM+zEp2f3gN3idwQry+1l9lK9fQvT3r6lah+iKYNwnZXgtYhC/8rCpzUR54DTEmT7mh18it4yk1gMqnu2vN5p7/g8ahEJIrQ05sHe14Mb8uQH1lH5CwwSjABdTfRPsM+efPj1TaRGjcT4tecMsJ/VEqPQS2Rr4p2DJpznEEzE2gzixihzdhg3EOdIhZ0peqOeu+LBtAB8tWrSd7X2rxHRIkPh0+780ArtXR9JzdzWJ9ZompNCjezpwHMvueJcfvLt7a3aWzGWKtED0/Fy94fHgDvJvakDlSjywN6vbPi4qy8BoTfLHhk8mHVd1R79C/A7SxQMfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zo4UeuUCKqKxBNDoVK54RBqz0Hm32GRXTwHuQDNQ5QY=;
 b=xWrN6TGgPauOj5XH9UwbPmMBB8kNwiKZ5rvs+45CjCSgNgcpOQxaLF/Q0ItMs95cWghkiLTp1cvKxgG2uEUNapKaMyTHXGAiic3nQt23IOvxmo+xHRaD3d0jbApxHtX0bJGzD1thPPvqc7W7LhmQ5baQFC8UjowkMMtR6XlpmNYN74+nSApUoW2sCHqqeNy9NN6cNAUPleE8pdC4s5gIrDTRYi0sXvKIeUBJZoML5FYm8rJwSIU44omH9SovTZAhT1gEtHYqn44WUdEoBrOBULa8xD4z8LhXtYbflfxnIL/JHj59dhqomDM+hC7uWBn82yc9ItuMGiSuc5J+AeyRDg==
Received: from AM6PR02CA0017.eurprd02.prod.outlook.com (2603:10a6:20b:6e::30)
 by GVXPR10MB5863.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.27; Tue, 10 May
 2022 09:54:06 +0000
Received: from VE1EUR01FT059.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:6e:cafe::1) by AM6PR02CA0017.outlook.office365.com
 (2603:10a6:20b:6e::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23 via Frontend
 Transport; Tue, 10 May 2022 09:54:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.73) by
 VE1EUR01FT059.mail.protection.outlook.com (10.152.3.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 10 May 2022 09:54:05 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 10 May 2022 11:54:04 +0200
Received: from [167.87.72.34] (167.87.72.34) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 11:54:04 +0200
Message-ID: <2f061564-9c1a-d330-ba59-2fdd770f6277@siemens.com>
Date: Tue, 10 May 2022 11:54:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] start-qemu.sh: Fix arm support
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.72.34]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--10.704800-8.000000
X-TMASE-MatchedRID: c0jeHSXaJoFlAsI9woAiJItVz79Lkzv9fVvjf1xNYS8/QdUh6LEl0MRJ
	LE/FNr2DB2QWi8BF5ShpRezoWC5XLQv+uf1yM6WBv9Xp1FP5xUjdYzHHdaOetF67ppG3mtjJUHV
	7v8X++rnW4BShNeq/e5bVGh42G3hF4vM1YF6AJbZFi+KwZZttL7eQq6mF2S4/3QfwsVk0UbtuRX
	h7bFKB7hbH4wMMIbkKuCx3fwo4FjSz8frPgOuNrZG/Ya00i50FSwwcGKLTYEc=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--10.704800-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 1177859F87A0DAFA9794C5C19EA43A27C499E7A544DDB928581AFCCDC9BD5C8D2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 556e9162-5871-450f-9981-08da326b04f3
X-MS-TrafficTypeDiagnostic: GVXPR10MB5863:EE_
X-Microsoft-Antispam-PRVS: 
	<GVXPR10MB58633F271C9CB816C032C20695C99@GVXPR10MB5863.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Tj//5Gee46JnfeZ6RcZC9gEd/SOFZP85w1GCRiHsAVeR2pVhTe19yS3niCwAxVBfaPR8MbqMbft3xkeApR6kD40R8K+VDL0IISGBxwDi+kC0S8mvaCva3at4YvV5c9m2rHkB9j/6W3NRYk7nfUlNZ6jMK2eD/9AEjhydZNMxH3+y28yn/uH5y5/zUFVi6Q6COW+uIqhZ0H75t+JT05v4acr1MgnmyqPxtAGtSN6HINPBORi9Fnl5ZDahQijjPY2CRHS6cuAhOlPEdVVIFeEzsxPCla7tdrWBt0i33mtf769t4d02MVlvWMl6ztUrc+CoNj1RzsoMC8wpeM8iX9db/vePXUtEXjUG9Q9N1bSqMmXZ7+y/s33c8XglkIFDp2eeC2GU1tHXUwdO6yg4dtmsmLeYfzeawnbOfIMt+rjKjtcvHUk2deLhUEOg9XNemWVG63eceNvEy8IZftBM5jxB9WblLmvwfaMlOztfxm56ZTQlIH7M3eGDUEUVHhVzc1YfKslhJjwYfjkOkOXYajMZy+1psBb9xRjgvYdZ5aDlfpO/Mz5J5d3eTT7QC79pRongX60Y3pxmxHkWuoWmahqEXpf+Y26IccRyS3vldAUpSflTVaK2XxcSjd6xX5uiFv7zuuPuGK+0JhmakFneWpDfDz2UZccjDIuUZNfRTs6Xrr8n6cKs6r/qsuQohLqsbTUdOXnkatN8dOQ6EYkSUYYGaiFr1H9xRzSSDIkBkJfKUPH/XobPx+EXv4v4OoEhOE8wdeUNKzIWVC096Zhg1tDRog==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(86362001)(956004)(40460700003)(498600001)(81166007)(2616005)(356005)(82960400001)(8676002)(70586007)(70206006)(31696002)(82310400005)(83380400001)(6916009)(26005)(6706004)(36756003)(31686004)(5660300002)(8936002)(44832011)(2906002)(16526019)(36860700001)(186003)(16576012)(47076005)(336012)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 09:54:05.1840
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 556e9162-5871-450f-9981-08da326b04f3
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT059.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB5863
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 May 2022 09:54:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8278

From: Jan Kiszka <jan.kiszka@siemens.com>

There is no "qemu-armhf", we called it qemu-arm. Therefore, finding its
images failed. Rename DISTRO_ARCH to QEMU_ARCH and set it to "arm" for
the related target.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 start-qemu.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/start-qemu.sh b/start-qemu.sh
index ad4fca5..80c0cd7 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -50,7 +50,7 @@ shift 1
 
 case "${arch}" in
 	x86|x86_64|amd64)
-		DISTRO_ARCH=amd64
+		QEMU_ARCH=amd64
 		QEMU=qemu-system-x86_64
 		QEMU_EXTRA_ARGS=" \
 			-cpu qemu64 \
@@ -70,7 +70,7 @@ case "${arch}" in
 			root=/dev/sda"
 		;;
 	arm64|aarch64)
-		DISTRO_ARCH=arm64
+		QEMU_ARCH=arm64
 		QEMU=qemu-system-aarch64
 		QEMU_EXTRA_ARGS=" \
 			-cpu cortex-a57 \
@@ -84,7 +84,7 @@ case "${arch}" in
 			root=/dev/vda"
 		;;
 	arm|armhf)
-		DISTRO_ARCH=armhf
+		QEMU_ARCH=arm
 		QEMU=qemu-system-arm
 		QEMU_EXTRA_ARGS=" \
 			-cpu cortex-a15 \
@@ -106,7 +106,7 @@ case "${arch}" in
 		;;
 esac
 
-IMAGE_PREFIX="$(dirname $0)/build/tmp/deploy/images/qemu-${DISTRO_ARCH}/${TARGET_IMAGE}-cip-core-${DISTRO_RELEASE}-qemu-${DISTRO_ARCH}"
+IMAGE_PREFIX="$(dirname $0)/build/tmp/deploy/images/qemu-${QEMU_ARCH}/${TARGET_IMAGE}-cip-core-${DISTRO_RELEASE}-qemu-${QEMU_ARCH}"
 
 if [ -z "${DISPLAY}" ]; then
 	QEMU_EXTRA_ARGS="${QEMU_EXTRA_ARGS} -nographic"
-- 
2.35.3

