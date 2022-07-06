Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840E7CCA473
	for <webhook@archiver.kernel.org>; Wed,  6 Jul 2022 09:28:42 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.74])
 by mx.groups.io with SMTP id smtpd.web09.4195.1657099712676414339
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Jul 2022 02:28:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=L4liZAeQ;
 spf=pass (domain: siemens.com, ip: 40.107.20.74,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KrsPLKGYA9kSfWmmK4+IFuV/MVRhXarva05cscUgUn+30ezp8PG0IKZV43ACqJzHuJpIaZfgSsse0bdybx80STGfSUs06LNT6SCkNg6nY0HSHUZiilDu1V89t6UjRF8rUeKLAH9o14nlQ2ywzAyYEXXZmcSH//lKJCXHUlafFRc5t07yeGgXbt6FSXduO/abtWi9bE/+85cErkWZD5QKYr9sYP9T7ok+SkRhsKxeRFVmIN9seYKVWoWUXZCEMTSeQ8XJ4sy2m6VlsEWg2H+++pqIHc6v10ApJAI0fy8gmvTBlspX5T3ESQUjs0zSp6+sonDvE38rD9ovI6kRNFiHxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BwoLaR7Td9UD1opu9BfPKot/Hq7zgt/ha2xKcigplU8=;
 b=HRxx+fDPcMA4bmliSoFklqydnHzsH+XNUHmg6+eZ+BuC4hInspql689L5px20UiArtqBXEVMbuuNthsDdqhj9BPM+ZAn4tZyBzesfsprisj4vsbx1ig42QbsN74FPjvGWy3aReie9R3qtKrRWysCQVNNEw17/7sX8+vF5t+oK9h3xVaWgxjDdaw/I2AQNhGCgQOdLBirotwvGlzOYQNDTcbSBllUs4A40WNCo75XoKwZirSLGd0xcKmZRhbHVoMWIlG1sPtZaKLmAjdW4Lgdd3UVrq8QSr6ZeiE/mYKAJisUxhWcPR6UO/hQ65dqT+7i+Rxbenl0RC5viYnZNUt4sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwoLaR7Td9UD1opu9BfPKot/Hq7zgt/ha2xKcigplU8=;
 b=L4liZAeQPHnpIRD4fkFzdombFKAmTL2/Bdc/0czxadqNmJ+v/gNC4By4Rq1O26AB1zMEEiqb44G74ncDTkqv2cRfteXBBTrzWPLNjNbsdoiU2MIjWRdkVgtXbIvdSLUvYkA9uEaiHPDn+YDLCahjTkvq4PAAFm4NJH1Ih5sKw5SFOn9WeBVLPC7ZkaQPBeoUZZo8HR+oP4hnhV6HaHcA08ZfmgsMrP+dzAn7rfUeKXDzP7u2L01Qu3SbPx5xdKhyMxEGhiu9VyNTYw1lzRsUoVbd2IOjneg5AVrhGef/s9KI+ESEXAOPtG9e2UMGcGgtr4v0ZBkUpyxOFKqoQGEkAw==
Received: from OS6P279CA0056.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:31::11)
 by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 6 Jul
 2022 09:28:30 +0000
Received: from HE1EUR01FT013.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:31:cafe::9c) by OS6P279CA0056.outlook.office365.com
 (2603:10a6:e10:31::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15 via Frontend
 Transport; Wed, 6 Jul 2022 09:28:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.72) by
 HE1EUR01FT013.mail.protection.outlook.com (10.152.0.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.15 via Frontend Transport; Wed, 6 Jul 2022 09:28:29 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Wed, 6 Jul 2022 11:28:28 +0200
Received: from [139.22.133.252] (139.22.133.252) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Wed, 6 Jul 2022 11:28:28 +0200
Message-ID: <395a150d-058f-d629-3b5c-6524fbb1b5f6@siemens.com>
Date: Wed, 6 Jul 2022 11:28:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH isar-cip-core] start-qemu: Mark rootfs read-write
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.133.252]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--10.645100-8.000000
X-TMASE-MatchedRID: wpn4rEuVxjDuYXvnz2w+vDotgZ1vDY/XU+cj0D/bbuMD2WXLXdz+AQKf
	lB9+9kWVWXZfkVm7qxsmZXuPVZCqh4g8OHABsAhy0iPH6ydsJOGaVzGETDUtnJ7TfrurW5DUfS0
	Ip2eEHny+qryzYw2E8Jkw8KdMzN86KrauXd3MZDVtYeInNJpWkX7NMTXQwQNtZek3kEUpWiG5Vp
	0/4BpM+nzTQwGnYhUb
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--10.645100-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 C0CE7C5A034D466BE046E2FDBE0960D5B6BCBD52291A2B8EC43CE42E1198A4352000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28c6d64b-799f-4a50-4550-08da5f31e2f9
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	DvBlWZB1vb9yisq8/nQ+E4Dt4Wc7uk5NOa3UWS51OnUjlVz3WG+4d1DgNb7V1XU+uGhgcVIDHoFWOHPhjiY9CxCt4dfFZcF9hxvqKclIAoVDh4vdgmu/XLumdpk3IRNoaYJPHi56KODQINKVI+1gTt8kQMe6nwqhemMVGplg6jPhkQLotLAnrKdb927m0Ag4VvHua639lu5SYE4tAZCrUXohGB+AJyl21e5XYEZlkbUO0hmnZTem6tkwIFSUHH924OvzwvfOm+1SaJh6QFS9PeFwzq0H2ISc1ePtAp0Ozsfi4j8baI3AZBQuO0Fk2V08lSK0v5YAOXmthZXjoMs2GB1l5/4dLZl4StuJjHV9zS7YHvz3JCXTPNC+C9Gto6le/Qa6FUTFOCBlmQzJJpxBXMyxJIWICqLvqtx5ppYVFFIFiBe0nkQKSGfMLlQkeq4elxhzCCy62ekHj3g+a4Nt9gevinDMEQlWpLdTtR0cOOAUFl2q+XNzQlR9E0XQp7znVaqWyaru3MiUHYXDUK2Sfh1WOJdrHahh3yLA3Ys7abatCZ1XeRJlRHnrwAdm7vzcMh7gHTm5fhp9W4ZivaiD+uQ97RIF0Rn8Kr4kqkJZZJltJmOZoGEnUC+vbNm44U2QBGqxoJFjauA380Tuvo3Jx/UHjl7EAWCaQ9UP852bYDkDiDklMIhUOzQ/6YVea546vipqEEytWJ8EeO0k18NLWq9mHx+jOPh89dcssSNjEUulg0p1TRqeRFAZx54uoM3oZplJrhue5VbnYrmyKxgWnrEPuT/cqXdiHyyJVZKCCJIaI+w6AX9V+3HdqTSP8ckxcZxBZpMYHMzF68wA79vIBJXDteXu2NoEkUrVthHEm6/+SNdjkaQlVQUVRcyuw+dQ2KM+QOplRvDM4R9JVT5AektzUuhH5wWqKFAM4sB6qvY=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(39860400002)(136003)(346002)(36840700001)(40470700004)(46966006)(41300700001)(16576012)(316002)(36860700001)(26005)(16526019)(186003)(82310400005)(2616005)(956004)(6916009)(6706004)(83380400001)(47076005)(336012)(86362001)(81166007)(5660300002)(31686004)(2906002)(8936002)(44832011)(478600001)(4744005)(8676002)(356005)(40480700001)(40460700003)(31696002)(82740400003)(82960400001)(70586007)(70206006)(36756003)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 09:28:29.1432
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 28c6d64b-799f-4a50-4550-08da5f31e2f9
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT013.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4085
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Jul 2022 09:28:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8697

From: Jan Kiszka <jan.kiszka@siemens.com>

This ensures that early systemd work such as machine ID generation finds
a writable rootfs.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 start-qemu.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/start-qemu.sh b/start-qemu.sh
index f066209..2350612 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -67,7 +67,7 @@ case "${arch}" in
 			${QEMU_EXTRA_ARGS} -device ide-hd,drive=disk"
 		fi
 		KERNEL_CMDLINE=" \
-			root=/dev/sda"
+			root=/dev/sda rw"
 		;;
 	arm64|aarch64)
 		QEMU_ARCH=arm64
@@ -81,7 +81,7 @@ case "${arch}" in
 			-device virtio-blk-device,drive=disk \
 			-device virtio-net-device,netdev=net"
 		KERNEL_CMDLINE=" \
-			root=/dev/vda"
+			root=/dev/vda rw"
 		;;
 	arm|armhf)
 		QEMU_ARCH=arm
@@ -95,7 +95,7 @@ case "${arch}" in
 			-device virtio-blk-device,drive=disk \
 			-device virtio-net-device,netdev=net"
 		KERNEL_CMDLINE=" \
-			root=/dev/vda"
+			root=/dev/vda rw"
 		;;
 	""|--help)
 		usage
-- 
2.35.3

