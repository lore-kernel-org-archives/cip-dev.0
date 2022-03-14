Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788B4C433FE
	for <webhook@archiver.kernel.org>; Mon, 14 Mar 2022 06:09:50 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.56])
 by mx.groups.io with SMTP id smtpd.web08.23153.1647238188271297165
 for <cip-dev@lists.cip-project.org>;
 Sun, 13 Mar 2022 23:09:48 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com
 header.s=selector2 header.b=uryuNqWG;
 spf=pass (domain: siemens.com, ip: 40.107.22.56,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BaZDBAkiJ5qNLvb5zyOaNyq9zuzaz1f7YsAJ15Vtvj2DjPPze2Ektq1G8FyBsmCrHLaFkvlN+TXP6slGhMxm5slUJSaYQCJ/2GIlWQ4K9PbsYDeMmG9mgPlRMyKwk5CrUW/xumnImxj3OyWvbz1l4Fm2j4FuMQK5Z2EMOdd71zRbwcnXQHzJUJGOqmcO4IyWSR+YMZqTUUzJM+pVAgHU0GOOpFt5eTJhRnWEjrv3dEaH44rMuMvgud62AuJ2V+top6ZA/g1lFq6fi2cDJg+6ADRlqx3qkBsh+zqaEyTXeXULnIMLOBBqUks+khFqHe2iRIgT90AjH+1gMAxRTULpXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hpqdV+mdXGL4ISCfDnCQybGz5lmMrwCIeJQ/0IIITMs=;
 b=EXfz3f1UJz/scdw4WD2RjI+g89zbQ/RL/0ZPvFVqutIsd9nk3I3cR0q0JUi4YfSQpAaCQrfoUrbMedH9PswHZDdc1p9EfEdWxZtIQdEeGFL4syvo8CmUPTVJIiMN/SIJgkMCLjMJcxs2Rz+Ge1SfEIlVRBHHXkL7FEs/h3WunKKmmUdr0vcdZ9zFCQz7kj6ICSfJwanfcBzw1RhEzX61ad1xnrUBP2uq5bNPm3/4akcLeVtJcQR9D0dSOVBWJfPtqgWcTrECW/l3A8V33XzxkUBmoIPMrmSz9clFYii5p/0AKlLEF5wHhvYQWGhQzYAr76W6HBlQrFIORExdEl1JTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hpqdV+mdXGL4ISCfDnCQybGz5lmMrwCIeJQ/0IIITMs=;
 b=uryuNqWGYnzD/pHzGa21Ii/HYpbOuZsSxHqu8Qw3m6EbiUAgtp+r2qEbtsL94hnX4r/0hPtR5aqxOCSkHM5wM+p3HoLu+nSOdUVUk75XlMDsbRthKq9XBZUaDtOi7YxCyUAmM1sIKjmB4a8oF0MJBI1kZxn0oHMyBS8nby76O7bonETEy1F+AlyWs8+APYg8vE7fZMipD9rg+kWDB5uHt28Gz47ix2yHzaXEIPHcy4JsQu4XhB8t4vXDk6vFYMgVY1sGZ2lccxsJ6baj4N6lH1DtAnoucXYE9cksHXbBJ6yiJSuwAPzSfO4WJV6WCafMlFcgWFTb/3ngNKUykjdj2A==
Received: from AM6PR0502CA0063.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::40) by PA4PR10MB4543.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:bd::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Mon, 14 Mar
 2022 06:09:45 +0000
Received: from HE1EUR01FT012.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:56:cafe::df) by AM6PR0502CA0063.outlook.office365.com
 (2603:10a6:20b:56::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26 via Frontend
 Transport; Mon, 14 Mar 2022 06:09:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.71) by
 HE1EUR01FT012.mail.protection.outlook.com (10.152.0.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Mon, 14 Mar 2022 06:09:44 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Mon, 14 Mar 2022 07:09:44 +0100
Received: from md1q0hnc.ad001.siemens.net (167.87.72.30) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Mon, 14 Mar 2022 07:09:44 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
To: <cip-dev@lists.cip-project.org>
CC: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [isar-cip-core][PATCH 5/6] efibootguard: Update to 0.10 release
Date: Mon, 14 Mar 2022 07:09:20 +0100
Message-ID: 
 <8f11e55b3416e6d0ca2192e2e11dc5e623278130.1647238161.git.jan.kiszka@siemens.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1647238161.git.jan.kiszka@siemens.com>
References: <cover.1647238161.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [167.87.72.30]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b17e615f-fb90-47a6-c7b5-08da05813c6d
X-MS-TrafficTypeDiagnostic: PA4PR10MB4543:EE_
X-Microsoft-Antispam-PRVS: 
	<PA4PR10MB454373D0458F4383755F991F950F9@PA4PR10MB4543.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	O0QYsCsV4R+U0btDxDQxb4RAThamPogt2/AyfTQjQ2tp2GrSpnYoLCnFucljYQMwyEMV3dqq0WiSjGZSzEQUgWDTKS/gdwWOcIpbZqPpxG7dcww83O4mwuGu0jkRwxfIoB5ETH2t1tSj5Bgn4VUBiFsTORix4DaI20jLDdFBrxYcchlX68mcWueo1LA1+v7yHwf6H5zhXQAB/b8eXMaa9HkNHK6c+h5u/8DVQJa7KWsWC+Kh89rfNujP8SzQTne3ylOF5dQDPuSXfcrDHi/ggf6hWyBgLS875t7nEH/d7bhMDGGIzXUvPMvA2s8WeQ+OUndTk+wb6zMcNHnj0j3S8IUpMYrfXLt0llw6x1oRxqQZCMztwv+HF5ezEHueg7oc7YPBnHbrvlGa51h9eovi6SAAcJuc6UE+bU/MzMbnJPy0Qq0QwDq1t7cgKMonFNNFGkW/verRxo2YPc5VAgCXDZwr6Wxre3E7gtYfP71RhzxjpWpx/iSYpJuihRE4WfXdhspE1w8pHfpQT64UN9K/Q3rQ23lP2lyKO9l2V72TM1tWN9KyKIIP8994zHMkP7X/Wc9QUHUTlF7YCkjWoD/yYfZfO0L7PrwbqF21PbYq4Kb0PRbtlbwf0T27be91SgMkeEjyT888pzH8W9mADNRLCLdmGrkEA1q0+jQyAwWi306kzUZKwlkGsU89hZ4OGDePpYKILDZew1caQn5c4FU/lnxorv3sAB/ZI7w7Zpe6OatZ1ww00ejuueI31PLy78aWBytvp2Kqznqhb8jNbSZQ5/Tfz8y5EOrk6m8jHZpI8h0=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(316002)(83380400001)(82310400004)(2906002)(86362001)(36860700001)(8676002)(40460700003)(47076005)(4326008)(107886003)(70586007)(70206006)(508600001)(8936002)(6666004)(956004)(2616005)(356005)(44832011)(6916009)(36756003)(336012)(966005)(5660300002)(16526019)(26005)(186003)(82960400001)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 06:09:44.8300
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 b17e615f-fb90-47a6-c7b5-08da05813c6d
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT012.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB4543
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Mar 2022 06:09:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7710

From: Jan Kiszka <jan.kiszka@siemens.com>

This brings the locally fulfilled dependency on python3-shtab to provide
bash completion.

Switch to checksum-protected tarball download at this chance.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...uard_0.9-git+isar.bb =3D> efibootguard_0.10.bb} | 16 +++++++---------
 .../files/debian/efibootguard.install            |  3 +++
 2 files changed, 10 insertions(+), 9 deletions(-)
 rename recipes-bsp/efibootguard/{efibootguard_0.9-git+isar.bb =3D> efiboot=
guard_0.10.bb} (65%)
 mode change 100644 =3D> 100755 recipes-bsp/efibootguard/files/debian/efibo=
otguard.install

diff --git a/recipes-bsp/efibootguard/efibootguard_0.9-git+isar.bb b/recipe=
s-bsp/efibootguard/efibootguard_0.10.bb
similarity index 65%
rename from recipes-bsp/efibootguard/efibootguard_0.9-git+isar.bb
rename to recipes-bsp/efibootguard/efibootguard_0.10.bb
index 171d8d4..7d09c85 100644
--- a/recipes-bsp/efibootguard/efibootguard_0.9-git+isar.bb
+++ b/recipes-bsp/efibootguard/efibootguard_0.10.bb
@@ -16,18 +16,17 @@ LICENSE =3D "GPL-2.0"
 LIC_FILES_CHKSUM =3D "file://${LAYERDIR_isar}/licenses/COPYING.GPLv2;md5=
=3D751419260aa954499f7abaabaa882bbe"
 MAINTAINER =3D "Jan Kiszka <jan.kiszka@siemens.com>"
=20
-SRC_URI =3D "git://github.com/siemens/efibootguard.git;branch=3Dmaster;pro=
tocol=3Dhttps \
-           file://debian \
-          "
-
-S =3D "${WORKDIR}/git"
-
-SRCREV =3D "c01324d0da202727eb0744c0f67a78f9c9b65c46"
+SRC_URI =3D " \
+    https://github.com/siemens/efibootguard/archive/refs/tags/v${PV}.tar.g=
z;downloadfilename=3Defitbootguard-v${PV}.tar.gz \
+    file://debian \
+    "
+SRC_URI[sha256sum] =3D "4d58574a0bb8f1e56056ab0bcc2487d37e49fa147dc991e719=
c2ec8e20f88dd3"
=20
 PROVIDES =3D "${PN}"
 PROVIDES +=3D "${PN}-dev"
=20
-BUILD_DEB_DEPENDS =3D "gnu-efi,libpci-dev,check,pkg-config,libc6-dev-i386"
+DEPENDS =3D "python3-shtab"
+BUILD_DEB_DEPENDS =3D "dh-exec,gnu-efi,libpci-dev,check,pkg-config,libc6-d=
ev-i386,python3-shtab"
=20
 inherit dpkg
=20
@@ -38,4 +37,3 @@ do_prepare_build() {
     cp -R ${WORKDIR}/debian ${S}
     deb_add_changelog
 }
-
diff --git a/recipes-bsp/efibootguard/files/debian/efibootguard.install b/r=
ecipes-bsp/efibootguard/files/debian/efibootguard.install
old mode 100644
new mode 100755
index 462fc1d..910e153
--- a/recipes-bsp/efibootguard/files/debian/efibootguard.install
+++ b/recipes-bsp/efibootguard/files/debian/efibootguard.install
@@ -1,3 +1,6 @@
+#!/usr/bin/dh-exec
 bg_setenv usr/bin
 bg_printenv usr/bin
 efibootguard*.efi usr/share/efibootguard
+completion/bash/bg_printenv.bash =3D> usr/share/bash-completion/completion=
s/bg_printenv
+completion/bash/bg_setenv.bash =3D> usr/share/bash-completion/completions/=
bg_setenv
--=20
2.34.1


