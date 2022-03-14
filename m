Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747EBC4332F
	for <webhook@archiver.kernel.org>; Mon, 14 Mar 2022 06:09:37 +0000 (UTC)
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (EUR03-DB5-obe.outbound.protection.outlook.com [40.107.4.80])
 by mx.groups.io with SMTP id smtpd.web09.23593.1647238175998254405
 for <cip-dev@lists.cip-project.org>;
 Sun, 13 Mar 2022 23:09:36 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com
 header.s=selector2 header.b=d88gNDr6;
 spf=pass (domain: siemens.com, ip: 40.107.4.80,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZBR44U1BZUBS1rjvEEnbpfiCGrtDrqyp9CHXtycDl4K+jnQIPx+T2O3EckjoINsB5TzU5BKRuUb908d9kM1iYFOTWMd+BarXa9iAkEctG3s0EN8O77sOv8SU5T0Pet7jMVDLpUbml7syJ91EmnPkyaa7n3bisgp4I7okPKD1IL7jBEMTTcm2oekrieFhNKZlFVz3yxnxFpMW/tUr38Yj4LSE79lU/e8ii9gTtvMzYkX6WsGQXsIYYWo3Y9sjBoUE2TZLawBwGkTWnko28jCrJSv/pAHLfeZc1IPs8fujT+I//TQTkPF54gzJ+e4TP0K9jccm9azZEriT4Cur0ybKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ZzyPitxfeo8Rb2NJEJjzUet/PjwD5UxTPv5+lTZmBw=;
 b=cCL4Qcremy9KDWLJlfvu3gxuN/Mtl2AGVyI19+zY+VS+0rFmyTB3b+ytT1RZqLACriXVKoHu5HsRlAJgbwQIBeY953cZeeOYdJOWEwTAfDwHmhpHbGh9mm22ejwzdzz6oXPHv2oAQsmqWZHUTadjFX0iWZwmqYqzAP6mgWOrQPqHejrbqiTRJbXl9ruH76OaJ96RCIvtyrRUnp8kcQrETwSLhlPf/2mbN1zhZ1H5zw1DFeqBNir9J8au1XuqkWre95cMJ4MKmnnq/yymoIYvaIicXzOstv4uT6Aam41l9RucnPqhnm6NL+dBVMB7wlZLaJFdQrDyf7UJ57+FbJs/Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ZzyPitxfeo8Rb2NJEJjzUet/PjwD5UxTPv5+lTZmBw=;
 b=d88gNDr6XZGvwfEDtz98BB0OGDsrfiZcqS8yoUlzp8CEMlESeaJr5jw10Coi2eCJv5GLWWgrh/FcLH9oVEBwCyjMEAQOD55zcj0Frw/aEZB+qLdiKcYCT5qYC/+oyYr40TujmL/BRWuGZie/8ypYDOX+nlUhp5+NDkXg6bgcIuQeEo3bDj31SJ7fpSXdmYEr0BhpXo/JUFKVihtK64715KKHE9x/iRh0W3PBx6PD05BDzSRvUYI6q3gHIrXrtnhiDjimdXzkHehvKYEkuwVtpMXKvpTXRZk5quZq//zBxe1KdKPBdbi9mYaacPHm4MSTmNileCdVwS83MOljrUaI4Q==
Received: from SV0P279CA0047.NORP279.PROD.OUTLOOK.COM (2603:10a6:f10:13::16)
 by VI1PR1001MB1229.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:e4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.24; Mon, 14 Mar
 2022 06:09:32 +0000
Received: from HE1EUR01FT018.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:f10:13:cafe::66) by SV0P279CA0047.outlook.office365.com
 (2603:10a6:f10:13::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22 via Frontend
 Transport; Mon, 14 Mar 2022 06:09:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.72) by
 HE1EUR01FT018.mail.protection.outlook.com (10.152.0.175) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Mon, 14 Mar 2022 06:09:31 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Mon, 14 Mar 2022 07:09:31 +0100
Received: from md1q0hnc.ad001.siemens.net (167.87.72.30) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Mon, 14 Mar 2022 07:09:30 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
To: <cip-dev@lists.cip-project.org>
CC: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [isar-cip-core][PATCH 0/6] EFI Boot Guard 0.10,
 improvements for start-qemu, kernel update
Date: Mon, 14 Mar 2022 07:09:15 +0100
Message-ID: <cover.1647238161.git.jan.kiszka@siemens.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [167.87.72.30]
X-ClientProxiedBy: DEMCHDC89YA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f010150a-019e-4888-82e7-08da05813489
X-MS-TrafficTypeDiagnostic: VI1PR1001MB1229:EE_
X-Microsoft-Antispam-PRVS: 
	<VI1PR1001MB122940411A56672359EC2858950F9@VI1PR1001MB1229.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	VXRdWaVknr2LnKkhO1RHhgypgpAvg6b4Vgcbh5H+ttOYbjuF12rXNrwMP8cJ6XLFZ+/T8NnZSHMSHydogg67t+OwJEh0MszexYzBCS6KpO3vE7c20T2tPJqBJu46o6R20FP03zibhnA8sLf2xHGwNJ5rNIkQRwtF+fAe8/NaFkjHDmXwgsL4gF3pB+LvQXXxMAeknTIVjwtUzxxM93xsEyjc5U1y7Dvcu2UXgz0X62Beu//8+KQLCZocBPOGFh6RFu5hsxgYudGMHtYH2SnfLHsKJ9HlgMUO00+R/fCrfoY9V3L4P4YICe7yzpJtDkHqTYweoTRZR49N67WF15unRvZQ63bIYyu/e1xSWtdQRQvqtyx/y6Q6YZmmv2huboy+yCqnAhw26MI7Lz5lTTIr1syJ2LjiG2wdeVHawH1M/wQPdom/mtlfNliWdYMhYvJxeyQpiP8BuLNAu1LwHdH4kcWYXn/kYsTwB13/PVkrMI5eGpDCsnCOyrYEgm5JmPGe18hFfbaI5idnzCpB52e9KqWAYJDQ1ko0Wma1LgPLezDBkbfrccFmtwFvJsVpItublRgrJW/PO3o8C+YId10Xs7qfmOTRAfWmFSHbkazYHPmiVZvAkTWMOcKRYj19948fSRY2m+ueXR0uKYGtKceGv0+T2v3YsAm5N/pz+z1y3FM4pWIgp8b96LtNM5ZxfDI0JnzmiZ6Y21d2vXLBVFXQMw==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(26005)(186003)(81166007)(336012)(16526019)(15650500001)(356005)(107886003)(956004)(2616005)(82310400004)(86362001)(6666004)(2906002)(508600001)(47076005)(82960400001)(4326008)(8676002)(70206006)(70586007)(5660300002)(36756003)(36860700001)(44832011)(8936002)(83380400001)(6916009)(40460700003)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 06:09:31.5905
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 f010150a-019e-4888-82e7-08da05813489
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT018.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR1001MB1229
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Mar 2022 06:09:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7708

See patches for details.

Jan

Jan Kiszka (6):
  ovmf-binaries: Disable sstate caching
  start-qemu: Use Debian's OVMF also for SWUpdate mode
  start-qemu: Update usage
  Add python3-shtab package
  efibootguard: Update to 0.10 release
  linux-cip: Update to 4.19.233-cip69 and 5.10.104-cip3

 kas/opt/ebg-secure-boot-snakeoil.yml          |  4 +--
 kas/opt/efibootguard.yml                      |  3 ++
 ...d_0.9-git+isar.bb =3D> efibootguard_0.10.bb} | 16 ++++-----
 .../files/debian/efibootguard.install         |  3 ++
 .../ovmf-binaries/ovmf-binaries_0.1.bb        |  1 +
 ....231-cip68.bb =3D> linux-cip_4.19.233-cip69} |  4 +--
 ...100-cip2.bb =3D> linux-cip_5.10.104-cip3.bb} |  4 +--
 recipes-python/shtab/files/rules              | 21 +++++++++++
 recipes-python/shtab/python3-shtab_1.4.2.bb   | 35 +++++++++++++++++++
 start-qemu.sh                                 |  8 +++--
 10 files changed, 81 insertions(+), 18 deletions(-)
 rename recipes-bsp/efibootguard/{efibootguard_0.9-git+isar.bb =3D> efiboot=
guard_0.10.bb} (65%)
 mode change 100644 =3D> 100755 recipes-bsp/efibootguard/files/debian/efibo=
otguard.install
 rename recipes-kernel/linux/{linux-cip_4.19.231-cip68.bb =3D> linux-cip_4.=
19.233-cip69} (60%)
 rename recipes-kernel/linux/{linux-cip_5.10.100-cip2.bb =3D> linux-cip_5.1=
0.104-cip3.bb} (60%)
 create mode 100755 recipes-python/shtab/files/rules
 create mode 100644 recipes-python/shtab/python3-shtab_1.4.2.bb

--=20
2.34.1


