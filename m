Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71980C4332F
	for <webhook@archiver.kernel.org>; Mon, 21 Mar 2022 07:59:37 +0000 (UTC)
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (EUR03-VE1-obe.outbound.protection.outlook.com [40.107.5.51])
 by mx.groups.io with SMTP id smtpd.web09.28039.1647849576462765585
 for <cip-dev@lists.cip-project.org>;
 Mon, 21 Mar 2022 00:59:37 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com
 header.s=selector2 header.b=Jj2FRrNo;
 spf=pass (domain: siemens.com, ip: 40.107.5.51,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IyVc5NR+cwz7wgGlIMgpkuVucrMiz0X4gmfdtPA1HOIpHix0EAJYOXdhIWm9T3X4wn4FFshGHA/km3nFpu87RTNEHj1mMlyZhV9VK7fAi6bP71iZP3BhTna1WgqYOTYkwQWJpTQDZQAJqu7EomyOBDknizb3xfqSd9+w4NNSe3YKarrqojzb+px7gqSswCtkxfyeU507FON9M162ucHjURji93JWVxuMgkDsUDYzG8lfad9arvBr+u8GbdjClhhaA3OT8rG1CgqNo10SrlIroCpmrLKWygeQ452AlKV3HUDYmuAK/7gBzXBmYXX3LFuSusjP0uCBdji+kPTBEUjf/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gn9GIbgqttlQLVmmewmxj0+2ND7jxkFcY8T/bQVAS1s=;
 b=lb/SWCiPkYER4jWEAB+IsvdhMBTPfMSDmAYHgbRf0OyrBiLwwsVLJZz98lmGcXNEwF/sphKS0UANnL21y6Qxs7Yfz5WOGb3Winb3FVrJnr+YyoYsvPUqQnXBbgh9yRhwpm0S9kMkU/BXnao24Y6Dii4Iiy1GwBNNMHiMOa9DC+ygclUlAFS/yn5T2ZLoSO4iOP1/H41Pzu25XjTVzIpLlFF5nRg4tGAbkMR3scGIreyiY1WoI7qEosZMe4+R5c/15fm6ItX+n3Uogj+ADZ7nxdUe2M6b1M9H7nMvLj8Pp128OjhI+SWJ5PBZkh0KzPvQYkN01aT+DWZqNZa8ccN1hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 194.138.21.70) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=temperror action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gn9GIbgqttlQLVmmewmxj0+2ND7jxkFcY8T/bQVAS1s=;
 b=Jj2FRrNoh3UFsDC5nTH1SQisu70VPKwszwmPiE0Grp4Hx0Imb6Sxv0Y0EgpuSZCwILn03DloWdclE0WxJxeKRHUbAqbn8Dh5BafWCIOPWZz3qyneqO6zWCGRABHBWlzvvp2IbZwLK0iX24b0SpRETwY0eM3m5iXKE6/vrWugJZtCrSxH9rtDSpWqsbTGDA2di2ypZNk6pkGmJx8l2sYrLFlHUJSeywRr9Q2XUYshsqsgb+YrYTltO/25wR0qfsQ9SkNiQdh3nAdZy+pN03+LWBe2id59hbOUXvGXjFuPmpb7JvyeS+12qBkGrItaYp8GYWg9PRpCBEKlQ202u9Hybg==
Received: from SV0P279CA0041.NORP279.PROD.OUTLOOK.COM (2603:10a6:f10:13::10)
 by DB8PR10MB3674.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:131::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Mon, 21 Mar
 2022 07:59:33 +0000
Received: from HE1EUR01FT076.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:f10:13:cafe::11) by SV0P279CA0041.outlook.office365.com
 (2603:10a6:f10:13::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.22 via Frontend
 Transport; Mon, 21 Mar 2022 07:59:32 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 194.138.21.70) smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=siemens.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of siemens.com: DNS Timeout)
Received: from hybrid.siemens.com (194.138.21.70) by
 HE1EUR01FT076.mail.protection.outlook.com (10.152.0.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.10 via Frontend Transport; Mon, 21 Mar 2022 07:59:31 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 21 Mar 2022 08:59:31 +0100
Received: from md1q0hnc.ad001.siemens.net (167.87.32.40) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Mon, 21 Mar 2022 08:59:30 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
To: <cip-dev@lists.cip-project.org>
CC: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [isar-cip-core][PATCH 3/4] efibootguard: Fix non-x86 builds
Date: Mon, 21 Mar 2022 08:59:19 +0100
Message-ID: 
 <0d3861a36a20b7934d71608a9de4fa210df1b392.1647849560.git.jan.kiszka@siemens.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1647849560.git.jan.kiszka@siemens.com>
References: <cover.1647849560.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [167.87.32.40]
X-ClientProxiedBy: DEMCHDC89YA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4b40780-3f29-4b08-96c5-08da0b10bb5b
X-MS-TrafficTypeDiagnostic: DB8PR10MB3674:EE_
X-Microsoft-Antispam-PRVS: 
	<DB8PR10MB3674B9B94B482820A79CCF8095169@DB8PR10MB3674.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	cXMpwAbhFtUwZWrvMqbsBQY5iC1VIpDp+HLzJzDuF9Rotm+tT5QxCRrt4QfuXwyL0xy/IY4LOj4/AJJhLoDWZze/VTLQApmSn16uCFM0SG7li0kdz1x8g9lCLm42wFxu0vKKF76UBr44jfOU01Iu2B9bskdb2aIf0GmlMooNtb43Pa3elVH6+47v7FzSohIvoBFbiIp404gUdApMsbEqecrRlzr69DQQIor9oqzKhpSgLDyqNUWX8j3DKN2Kl5Q55PY2xdNDqYAjQ4tuOCh+hNdjDPyLv1u0BnQH+YG3WN8lwIe5FcGhiyw7Yz7CH3kiWdsmr53rK9h+Tuwkz7UjtCJwcy83X/2Z2Ramj27B/HmKxD5kahxqDwubNDXc6Q2/MNJipCXRJ9XjvNd6dyU1H9mQnBIXQ2ylsvZtJ6030ryZUaQ72OKrlmPMd+6nw7HnoI4PifZrkEdswVVbGxI2o6pM832LyBJkZbD/dGSq+m5dYKTsKjq7NSJ2H5XgyGEJWaCF8Q8h+0GDgxkc9tBoJyJtb+LIrzjOvMXDZDlldjXVY2nM4SSIUfpZmoP+/D+QDxDZPl/C+6hq+gUieS4WNDhceceMh7RSOgGxHg85LcUMU3xhOTUO71v2+x8PcZtguq1f14r+Py/Huc3KjwIcBUnmH/dLHugn5vbBIdR+oivvo99PYOP6TUhaVSxue9/s
X-Forefront-Antispam-Report: 
	CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(336012)(82310400004)(956004)(2616005)(107886003)(86362001)(16526019)(6916009)(186003)(5660300002)(44832011)(36860700001)(26005)(8936002)(36756003)(63370400001)(63350400001)(40460700003)(47076005)(4326008)(83380400001)(8676002)(70586007)(70206006)(7636003)(356005)(82960400001)(7596003)(2906002)(6666004)(498600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 07:59:31.6289
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 c4b40780-3f29-4b08-96c5-08da0b10bb5b
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT076.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3674
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 21 Mar 2022 07:59:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7783

From: Jan Kiszka <jan.kiszka@siemens.com>

The libc6-dev-i386 package is obviously x86-only.

Furthermore, the installation path must use DEB_HOST_MULTIARCH in order
to drop libebgenv.a in the right folder. This might have been already
broken for i386. As we still support buster, templating is needed to
translate DEB_HOST_MULTIARCH. This would just work with bullseye and
compat level 13 + dh-exec.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-bsp/efibootguard/efibootguard_0.10.bb    | 16 +++++++++++++---
 ...dev.install =3D> efibootguard-dev.install.tmpl} |  3 +--
 2 files changed, 14 insertions(+), 5 deletions(-)
 rename recipes-bsp/efibootguard/files/debian/{efibootguard-dev.install =3D=
> efibootguard-dev.install.tmpl} (50%)

diff --git a/recipes-bsp/efibootguard/efibootguard_0.10.bb b/recipes-bsp/ef=
ibootguard/efibootguard_0.10.bb
index 7d09c85..b0877d0 100644
--- a/recipes-bsp/efibootguard/efibootguard_0.10.bb
+++ b/recipes-bsp/efibootguard/efibootguard_0.10.bb
@@ -26,12 +26,22 @@ PROVIDES =3D "${PN}"
 PROVIDES +=3D "${PN}-dev"
=20
 DEPENDS =3D "python3-shtab"
-BUILD_DEB_DEPENDS =3D "dh-exec,gnu-efi,libpci-dev,check,pkg-config,libc6-d=
ev-i386,python3-shtab"
+BUILD_DEB_DEPENDS =3D "dh-exec,gnu-efi,libpci-dev,check,pkg-config,python3=
-shtab"
+BUILD_DEB_DEPENDS_append_amd64 =3D ",libc6-dev-i386"
+BUILD_DEB_DEPENDS_append_i386 =3D ",libc6-dev-i386"
=20
 inherit dpkg
=20
-TEMPLATE_FILES =3D "debian/control.tmpl"
-TEMPLATE_VARS +=3D "DESCRIPTION_DEV BUILD_DEB_DEPENDS"
+# needed for buster, bullseye could use compat >=3D 13
+python() {
+    arch =3D d.getVar('DISTRO_ARCH')
+    cmd =3D 'dpkg-architecture -a {} -q DEB_HOST_MULTIARCH'.format(arch)
+    with os.popen(cmd) as proc:
+        d.setVar('DEB_HOST_MULTIARCH', proc.read())
+}
+
+TEMPLATE_FILES =3D "debian/control.tmpl debian/efibootguard-dev.install.tm=
pl"
+TEMPLATE_VARS +=3D "DESCRIPTION_DEV BUILD_DEB_DEPENDS DEB_HOST_MULTIARCH"
=20
 do_prepare_build() {
     cp -R ${WORKDIR}/debian ${S}
diff --git a/recipes-bsp/efibootguard/files/debian/efibootguard-dev.install=
 b/recipes-bsp/efibootguard/files/debian/efibootguard-dev.install.tmpl
similarity index 50%
rename from recipes-bsp/efibootguard/files/debian/efibootguard-dev.install
rename to recipes-bsp/efibootguard/files/debian/efibootguard-dev.install.tm=
pl
index 7b45bd8..948019a 100644
--- a/recipes-bsp/efibootguard/files/debian/efibootguard-dev.install
+++ b/recipes-bsp/efibootguard/files/debian/efibootguard-dev.install.tmpl
@@ -1,3 +1,2 @@
 include/ebgenv.h usr/include/efibootguard
-libebgenv.a usr/lib/x86_64-linux-gnu
-
+libebgenv.a usr/lib/${DEB_HOST_MULTIARCH}
--=20
2.34.1


