Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CC4C4321E
	for <webhook@archiver.kernel.org>; Fri,  8 Apr 2022 17:09:35 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.72])
 by mx.groups.io with SMTP id smtpd.web09.3133.1649402891409358047
 for <cip-dev@lists.cip-project.org>;
 Fri, 08 Apr 2022 00:28:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=R73nyUCi;
 spf=pass (domain: siemens.com, ip: 40.107.22.72,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EeVNJjmTD2F5UANhoEsQEpoL5JatP5iYeZzpU5WG41VvfNFEf05UJy+khO2PJfs56ex4IQA717eTw+0kTlQ0e9WDNa3WYI/9/XANuT75/k8LbGZAC4C/qpcYYKWwfDXF1tz0f0W+GqWF07gII89mV94AMK90bXf6s2JoxtiKDQsinLKJvaY5Cxp/gGHkkkvJtDDkvmv8Qs4qMdoJD7kHfC8whEeoS/Yctu0H6emm8Q84hXeb8OER7bEaXezYpBkqJwu5Az3oDs7kUYWq9mib+YoMh/FZlFiDJUI0L/iHEv6GzMIZdQL5kBMPcCqzTVDRPVG8u7DefalC/5y4lI4/oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sHLXVqqDF5LtPv2YevF+JJv5jC3w09ovjZMCdqftuCQ=;
 b=BYml4Cjm93F3ntLfqUihOo55mc55zrHMX9rZmoE+M+zj9XpLrPtkVQF2hdrSK3h5gNNJ3d8msmPePGZ7vzNx0XzfkT5r05BD6Dq+jMtvIjKL7kRz+SBxzXy3hSYjHaxQHd62Bpytu15+TjFpqcT7rNx8QPvMgMasw+eKlKxG2axbvIR2I+fEbI5dchx1bHr3Erwyj7jJhctzLwAztTbOMEL6M/05grKZxItv4cWGsWAWdQ+VNjozz+s8PcLkjkf7FYzer8t0qKsRVI/37f4YT8zg/DodRHTrnEqAaHko42HVI8vc4JbuXrA6xHzjiLtqVaSHeN9+xUyN6zVFHXXfPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHLXVqqDF5LtPv2YevF+JJv5jC3w09ovjZMCdqftuCQ=;
 b=R73nyUCiIDnijItjB4I7RZADEJgARQVsahj3QDsCADMEtE9iEl4WzEq40Fr0gBTaxIVlFbhe7mYOFb5q+SpjTdIGQ36SCQNOYJIrzE++omT1z6NsUKdADxY6ad9Zu2FxaMLS/r8DnWVYBkzUTj1Qp1bYyM56HEQl12xGebwk9I1iTQYq+U75o80BxoWRg4M0FB6inACZ9AXxQ3PWDlqA58/+f/blY8ZNCb7py+QRE1Q3U514+mOQpmCCeVQyKKficb3qVn/29ZG2wlq3BGfeZPgkCpHpweCdruihtY+iBeUoIiCyB+miFCHn2jncVuw0AmGO8zBKI9vfCaQauRMJ1A==
Received: from SV0P279CA0069.NORP279.PROD.OUTLOOK.COM (2603:10a6:f10:14::20)
 by AM9PR10MB4482.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:270::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.25; Fri, 8 Apr
 2022 07:28:08 +0000
Received: from HE1EUR01FT033.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:f10:14:cafe::c7) by SV0P279CA0069.outlook.office365.com
 (2603:10a6:f10:14::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.21 via Frontend
 Transport; Fri, 8 Apr 2022 07:28:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.70) by
 HE1EUR01FT033.mail.protection.outlook.com (10.152.0.178) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Fri, 8 Apr 2022 07:28:07 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 8 Apr 2022 09:28:07 +0200
Received: from [167.87.32.126] (167.87.32.126) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 8 Apr 2022 09:28:07 +0200
Message-ID: <3ebfa607-276b-a3c6-9611-90c62c33ed08@siemens.com>
Date: Fri, 8 Apr 2022 09:28:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] Fix OVMF binary installation for buster
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.32.126]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--9.323800-8.000000
X-TMASE-MatchedRID: wpn4rEuVxjD0pNNnNZfFBHeN0mnGN7GalbmMg20CDU7HrhS+VKSDcUtc
	8DbogbSE31GU/N5W5BAfCc2qxvTTOfcShiYRuCKfQNUOvn+6fK+tK/5xK9tOno9Ha73XaFhEfS0
	Ip2eEHny+qryzYw2E8Jkw8KdMzN86KrauXd3MZDVau/Gkfjk+cLKL0boprCuhQRLo7OV5ZwIika
	wM6PjG/HA4fhTu35Ko
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--9.323800-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 DA24C6455E0A4A0BA1C638E1FBF034E46B2D0837780279A38435F73C116A3D162000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a52496f-9f6d-41cb-b6c3-08da1931540d
X-MS-TrafficTypeDiagnostic: AM9PR10MB4482:EE_
X-Microsoft-Antispam-PRVS: 
	<AM9PR10MB44822043220DD88A53B4795595E99@AM9PR10MB4482.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	oYDtqrtWDGnhk5BGcrqZoEu9cIUD4qEsPIJN5x2KOdvTAib/0uA9TsInyzhWqF1rO8NOMJIMjgM0rgyfeqMH1JQC/CPA7tyMZ2fWCT9K/MBx1hWoKYPKpgEXYo7ZmitHUmPOG3OURsgfMg5KK+YgU+FXV1IYaPtnTzq4WN6X/6aK1anXiMvsbu4YeC/O8Ck7F+YQ9yeEKebIx5JXu56pAAUumleWjNQV77gpb6kP6SB98JRRAtfPcUqA4UgChRqWKnR+QIftqwrcq2pGm2uF2eiVXdxa2LjrbiVx4C8hPJnrYZ2qibisYH6aqQPofo6DtHON20OJRVsbgzDidLUIH3htioBXhI5/2cJTM69m2Ox93KYQHGSAw8lanjgIXtyxsLc2e+mw4MxLRTTmREAQHpYx46uNafRtQA2wrbFWeXKkvirnS+p5RyEs1eksE5z2fIUInzjnm5nviGz/t5ArAKrwVjuivbFXX+fXGmRATm2ZsJ8r8Z+PFOHWzoMCmxnLiahsXeUjqzayWVShKUpOEkEU+T4RWzy6lREvuwsopP/nkTGjh562+hhv6SPoNo4Owl7Dj/j+yvydKiSEDaFnZYa72GeUGwFJmwj/p+eTmR4M5w2ellpXRJ3fFER+hvC3DsSpmKRNL6J0U5LWPi/VRx9EqJvX4LctXtCWNl+TjRLpM/n9YPH4skEiOmjcWB6VXnN+qLqyluJKz2xQSyiqoC3xu4BarVDiX+/AZkU2tivIaaQ+/fHkXrVLrW6wYwgS
X-Forefront-Antispam-Report: 
	CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(47076005)(40460700003)(31686004)(36860700001)(70206006)(70586007)(36756003)(336012)(83380400001)(26005)(186003)(8676002)(31696002)(5660300002)(86362001)(2906002)(6916009)(6706004)(16526019)(956004)(44832011)(316002)(16576012)(8936002)(82310400005)(356005)(2616005)(7596003)(7636003)(82960400001)(508600001)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 07:28:07.9842
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 7a52496f-9f6d-41cb-b6c3-08da1931540d
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT033.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4482
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Apr 2022 17:09:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8023

From: Jan Kiszka <jan.kiszka@siemens.com>

We have to use the backports version for buster unconditionally because
start-qemu.sh relies on files from that package since f65269cdbeb9.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kas/opt/ebg-secure-boot-snakeoil.yml | 6 ------
 kas/opt/efibootguard.yml             | 4 ++++
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/kas/opt/ebg-secure-boot-snakeoil.yml b/kas/opt/ebg-secure-boot-snakeoil.yml
index d404df5..a7d644b 100644
--- a/kas/opt/ebg-secure-boot-snakeoil.yml
+++ b/kas/opt/ebg-secure-boot-snakeoil.yml
@@ -31,9 +31,3 @@ local_conf_header:
     # Add snakeoil binaries for qemu
     IMAGER_BUILD_DEPS += "ebg-secure-boot-snakeoil"
     IMAGER_INSTALL += "ebg-secure-boot-snakeoil"
-
-  ovmf: |
-    # snakeoil certs are only part of backports, for Debian 11 and later the are not necessary
-    OVERRIDES_append = ":${BASE_DISTRO_CODENAME}"
-    DISTRO_APT_SOURCES_append_buster = " conf/distro/debian-buster-backports.list"
-    DISTRO_APT_PREFERENCES_append_buster = " conf/distro/preferences.ovmf-snakeoil.conf"
diff --git a/kas/opt/efibootguard.yml b/kas/opt/efibootguard.yml
index 9624584..0502b9c 100644
--- a/kas/opt/efibootguard.yml
+++ b/kas/opt/efibootguard.yml
@@ -30,3 +30,7 @@ local_conf_header:
   ovmf-binaries: |
     # Add ovmf binaries for qemu
     IMAGER_BUILD_DEPS += "ovmf-binaries"
+    # not needed Debian 11 and later
+    OVERRIDES_append = ":${BASE_DISTRO_CODENAME}"
+    DISTRO_APT_SOURCES_append_buster = " conf/distro/debian-buster-backports.list"
+    DISTRO_APT_PREFERENCES_append_buster = " conf/distro/preferences.ovmf-snakeoil.conf"
-- 
2.34.1

