Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69E5C433EF
	for <webhook@archiver.kernel.org>; Thu, 27 Jan 2022 17:13:00 +0000 (UTC)
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (EUR03-VE1-obe.outbound.protection.outlook.com [40.107.5.53])
 by mx.groups.io with SMTP id smtpd.web10.675.1643303579427979472
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Jan 2022 09:13:00 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com
 header.s=selector2 header.b=Nf3CLqIu;
 spf=pass (domain: siemens.com, ip: 40.107.5.53,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLvEn/sAVrETlfDmXmgbaYar4lwoVNi1/ZzA3YOokkFckDt91WJ6waA1NYt7wbWqh23tiaC2TzGKv5AiqYPxKIkRUn9cgSiJYZ6ZlssT2k9sPkyjbu/VuGuUlF/S4cE5WTAPtgBviAG15cKKO9str4sO6yhJPOjdjTmws2AQO+HO75i7T8fm8PE6xD+Dj7VCqamK/T8mPO6PvWQCY8FEwOClZE7F0W2Z6BilppZG2bctI9m/wqMb2vtHgAXdsCfBFXMDVs+DpLqbqBQY+XhOmIEhlCFxQRrufQIt7s1+20ccZpBS1vhnPG2HkhmiaZXXwK0Mzsl9AhwKT/p9UjthVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TmtYgXvjJr4lbJ9x3x23MucHOTCemPPbjVpr1BkEfOc=;
 b=V42GNT3RlW8B4+PfFbvTXHLvGgmU0hvrJ2xc6SiXPt135YfkjLXLYcar46xX7ADwilllnTWmBIqrylIncchj6LQr0qjAzACCTvSoZfPpKFlPEv1KapB1MIqs+KyxYpPz2Kd9yTZEnYnm1NADZl5RKxXYHwvJiIvKib62x/KF/FvLWSRDoujgqEQrS0HBT2KNtLQb8BNnmHVvDzDJ54pSLdZ+Q0x0y8S8T1iy/6SFerW3ZXrMgS/IoVzCwpmguE1wRBQQrRYS5U5S4onEFIQWbEbyJaDUomrIGYZ7SksWpiiXuThJetFUL5dw5w4WtUJzNlisohXK0U+6U6uu84llCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TmtYgXvjJr4lbJ9x3x23MucHOTCemPPbjVpr1BkEfOc=;
 b=Nf3CLqIugTV0ecndJ2UoS7OtpeqZx+jRcn4iYwj8q061norkeLUedK6Dt9UHLCvCuc8alGcPjftzXQ9Edsk4jyyqDSzQ+mTqW0oxzVHW11K5GQVuomgYW9XjUIorYYts6g5UmT1o4dCZfajYXZ9KNeaCV5ut5O7lN1t4Wc4Ip9ORJr5zbioyhP2sLmzPu9uWpNDu59OP5gQ3tXuoZffFdq3ld2enqe5hxlWSjqrQ0/6jtCWS2JW8WglK4YOQGoXz8mtbET1SlEGEMGZkSyXo0sQNEh1pY/h5Me9n9+5/Je2Widtt52HmJi8TSJ+T5zHbyLqzXpHt78x+BzepU8zC8g==
Received: from DU2PR04CA0273.eurprd04.prod.outlook.com (2603:10a6:10:28c::8)
 by DB9PR10MB4877.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2c5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 27 Jan
 2022 17:12:56 +0000
Received: from DB5EUR01FT037.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:28c:cafe::2d) by DU2PR04CA0273.outlook.office365.com
 (2603:10a6:10:28c::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17 via Frontend
 Transport; Thu, 27 Jan 2022 17:12:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.72) by
 DB5EUR01FT037.mail.protection.outlook.com (10.152.4.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Thu, 27 Jan 2022 17:12:56 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Thu, 27 Jan 2022 18:12:55 +0100
Received: from md1q0hnc.ad001.siemens.net (167.87.73.11) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 27 Jan 2022 18:12:55 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
To: <cip-dev@lists.cip-project.org>
CC: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Subject: [isar-cip-core][PATCH v3 2/6] Add dmesg filter needed for lava test
 result
Date: Thu, 27 Jan 2022 18:12:39 +0100
Message-ID: 
 <ba98e2dc304e8bb7d8abe1510c6e04bcc4ae3962.1643303563.git.jan.kiszka@siemens.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1643303563.git.jan.kiszka@siemens.com>
References: <cover.1643303563.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [167.87.73.11]
X-ClientProxiedBy: DEMCHDC8A1A.ad011.siemens.net (139.25.226.107) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc6903a4-6c0a-4f65-9510-08d9e1b842e4
X-MS-TrafficTypeDiagnostic: DB9PR10MB4877:EE_
X-Microsoft-Antispam-PRVS: 
	<DB9PR10MB48770A77DB3BD7C88865832995219@DB9PR10MB4877.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	kdnzhZbTevv7X6KPzI47iuzBMhDrG1uMrdiWUaW6qt4yksBGVAximtxu9VIJYk63C44zicXyoS3O5QdL8Fs3litQj+CF1Pu30AI8sfyUDbNK3Tgb8O/2ueYe/30TMPBkwSt3NRUiVr/7IL67u/uTMz6Zc8jR6wm4ulIAkC15WzbzSEejrJVEIRp6EnmA+eOMJLwSNQEs47PfmETYcm74Nc0lB4vTuUt2yVieLsuaF5H3vOOUgerLBdqt+9yifnZjMbP/Y8gqK0nABKLsqSK3eclojh+1NNSv3McpQNhSuMExlwo7rzEkxRT8tTNDwoE/pRICA0NDUWz9vkcL6X0Ti8PIH5Ubh7MAjmNo6Nfcv/yFyPJ9tI5pAgTOKnG940T00FsXNF0pAJLuNRsLwASp0AZwO1r+Yf67bHmpdleIUi59Am2+8YbqLpd0uOVnvs5hySBw/5mmRoTbyZ33Jw8KwVvjkcn3MCo1dF2mbLaXl1VDtmwbV4i1FS1RPZy2oGFMb1umPBZLAvVdssYWf/Gs1olZK0WTdhYTSNAFVhnIWhI8HihRVeV2oevehzjRFwhblEmEiHTN7BVuhRWdT/wwW25+f1dzOZ6WXKo2EteNAGzxhYLYDQV0K06A9pSMqiNfmbVYZIgrtTtqKn6v4EIEcHeswHf7E6ps148OgJS99pT+iZE2rBDp6ZLLG4TM0/dx4Kh2zYuzBAPVfEqSdKQfwg==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(336012)(356005)(81166007)(36756003)(36860700001)(40460700003)(47076005)(5660300002)(44832011)(2906002)(508600001)(83380400001)(82960400001)(16526019)(86362001)(6916009)(70586007)(70206006)(4326008)(6666004)(8676002)(8936002)(82310400004)(2616005)(186003)(26005)(956004)(316002)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 17:12:56.1363
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 dc6903a4-6c0a-4f65-9510-08d9e1b842e4
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT037.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB4877
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Jan 2022 17:13:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7511

From: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>

KernelCI is using a dmesg filter script for checking dmesg
logs result with lava.
Adding the script to the cip-core-image-kernelci.

Signed-off-by: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
[Jan: restore actual installation]
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../kernelci-customizations/files/dmesg.sh    | 23 +++++++++++++++++++
 .../kernelci-customizations.bb                |  4 ++++
 2 files changed, 27 insertions(+)
 create mode 100644 recipes-core/kernelci-customizations/files/dmesg.sh

diff --git a/recipes-core/kernelci-customizations/files/dmesg.sh b/recipes-=
core/kernelci-customizations/files/dmesg.sh
new file mode 100644
index 0000000..3b096e1
--- /dev/null
+++ b/recipes-core/kernelci-customizations/files/dmesg.sh
@@ -0,0 +1,23 @@
+#!/bin/sh
+
+set -e
+
+if [ "$KERNELCI_LAVA" =3D "y" ]; then
+    alias test-result=3D'lava-test-case'
+else
+    alias test-result=3D'echo'
+fi
+
+for level in crit alert emerg; do
+    dmesg --level=3D$level --notime -x -k > dmesg.$level
+    test -s dmesg.$level && res=3Dfail || res=3Dpass
+    count=3D$(cat dmesg.$level | wc -l)
+    cat dmesg.$level
+    test-result \
+        $level \
+        --result $res \
+        --measurement $count \
+        --units lines
+done
+
+exit 0
diff --git a/recipes-core/kernelci-customizations/kernelci-customizations.b=
b b/recipes-core/kernelci-customizations/kernelci-customizations.bb
index dca0891..df4257c 100644
--- a/recipes-core/kernelci-customizations/kernelci-customizations.bb
+++ b/recipes-core/kernelci-customizations/kernelci-customizations.bb
@@ -18,6 +18,7 @@ DESCRIPTION =3D "CIP Core image demo & customizations"
 SRC_URI =3D " \
     file://postinst \
     file://ethernet \
+    file://dmesg.sh \
     file://99-silent-printk.conf"
=20
 DEPENDS +=3D "sshd-regen-keys"
@@ -31,4 +32,7 @@ do_install() {
=20
   install -v -d ${D}/etc/sysctl.d
   install -v -m 644 ${WORKDIR}/99-silent-printk.conf ${D}/etc/sysctl.d/
+
+  install -v -d ${D}/opt/kernelci
+  install -v -m 744 ${WORKDIR}/dmesg.sh ${D}/opt/kernelci/
 }
--=20
2.31.1


