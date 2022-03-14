Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95974C433EF
	for <webhook@archiver.kernel.org>; Mon, 14 Mar 2022 06:09:50 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (EUR01-DB5-obe.outbound.protection.outlook.com [40.107.15.50])
 by mx.groups.io with SMTP id smtpd.web09.23592.1647238175820996817
 for <cip-dev@lists.cip-project.org>;
 Sun, 13 Mar 2022 23:09:36 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com
 header.s=selector2 header.b=afhuZf1T;
 spf=pass (domain: siemens.com, ip: 40.107.15.50,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NSXF4ghgt6R5dciSMuuQbwtArkAEQ/yBixua953ir7DoHthLU6EfAzuvowZ682L6gmKdezp9SUaYcmz3zguyhSpPP9PnTpRRqyT2lvFiEu5YcL7Krtra9RkZgPj+ziVh0gfPRim5F17lA3t/da0pd7DyfyZRQp/mZJHP6FFPstHQwG9Kyz97sVNLyP3jwRGyrV9MNJfLHWhrVmWk0oQcoTK/3ZbCG6Ldt6ATWI5zrg2+NbBKn9JzS56VJDjkCgtRc0zb/qPa6UVp8c/kMQTdahUVOwiMJA3eG/oTNWE0yH813DiPUWifCjjGRaTz0F0QF/jiWCA0P7BZRWABWwgzkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6cOovZORzonHZCk7bj5i1PwJgDZ1KsKLPL3oac2x8sw=;
 b=j5ruawgo3s35krzGFZApEw+IvUTIEGWB4BZN7wbQr+XOtuIhsJlUwAAydxSnLRydXFubvEyufFY4V1drQbli7vMg41YFS8YoQ+Tm44nwPmbQrSjnCnA2l/Mfew1UqLSMS5lyhlYx1D8QOWkDOgv9Le+cJztbeh+P4N1xzesU8cTvHx5pUbxI3Ag+V2Zv0KxrMKdwzotaTfXFTlcfQNFq9JYocuX13zclvd+8w2OfdqfZc+g/uQ119Ex3SavvpOuyMn6vorXgxs8YOdN+Jw1HlLl86IC0S8X7bTlDVCPRjr5IkhJNhOC04IzPLPOFK9A4hdGTe70NWuHr43TNZY6u4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6cOovZORzonHZCk7bj5i1PwJgDZ1KsKLPL3oac2x8sw=;
 b=afhuZf1Tjw6CuGS83KRiK7m6om+tNHXY6z7QZ4pTHq2jAHvQG+QOEu7dTHNoThyKdPspM6bPDtaKmZfqC0jcxrX/QfQBkxBTPKzxedh0KdCgzd/DH/GVxcanXduFfcytxGvS5h0UtAZqWedYfNso/perDLXFNeUl4ucrt3Mk+ZkXX4DJziSbmhhzcxgq9zTJuYSpJ0UPpbaQKO74nfNoEaoKh5/SF7D6yWwV0VkJ+vr+/2bPG8D0TcJoaX4gjWkaIqP5gCdQAfBXeMcJK8ltwk891Fc0aG+9YHHLwAr0bok+UivExV4w3qCt+yLcK7WH7rHhy0p19yCpOPlbKzSQEw==
Received: from SV0P279CA0070.NORP279.PROD.OUTLOOK.COM (2603:10a6:f10:14::21)
 by PA4PR10MB4413.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:bf::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Mon, 14 Mar
 2022 06:09:32 +0000
Received: from HE1EUR01FT053.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:f10:14:cafe::41) by SV0P279CA0070.outlook.office365.com
 (2603:10a6:f10:14::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26 via Frontend
 Transport; Mon, 14 Mar 2022 06:09:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.71) by
 HE1EUR01FT053.mail.protection.outlook.com (10.152.1.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Mon, 14 Mar 2022 06:09:31 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Mon, 14 Mar 2022 07:09:31 +0100
Received: from md1q0hnc.ad001.siemens.net (167.87.72.30) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Mon, 14 Mar 2022 07:09:31 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
To: <cip-dev@lists.cip-project.org>
CC: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [isar-cip-core][PATCH 1/6] ovmf-binaries: Disable sstate caching
Date: Mon, 14 Mar 2022 07:09:16 +0100
Message-ID: 
 <22fc47fd0545c89547d065a33853195b29a80da2.1647238161.git.jan.kiszka@siemens.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1647238161.git.jan.kiszka@siemens.com>
References: <cover.1647238161.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [167.87.72.30]
X-ClientProxiedBy: DEMCHDC89YA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66dcdc0c-f9e5-4c41-d530-08da058134b3
X-MS-TrafficTypeDiagnostic: PA4PR10MB4413:EE_
X-Microsoft-Antispam-PRVS: 
	<PA4PR10MB441317B932910911B7B5E8AA950F9@PA4PR10MB4413.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	j1oCABErTs+Q/ie6JNNwZs9a1U0JRqRgyLEu/2tYgy/aBKesbXFM1lhHKm+7CO1Nx/4qBoQTHfo/JQRE8Kzts4OXEf4zkJBK6wPLpaMk+SiUaSAKntftMhrZgo4PWMn8PYaWeOlBIYOa23QJKhBE4lyV34n2s7zHikANfPRgwyemVvdrY1uzbvNk/w8hfeK+Dmy2cBSKJMyX0001WAsA+CvED4s74zJJS45jUchQvYTXU/OAVli4xgCSPBrSVcqOfAsk+5JstmvWhN9bMtz/J0d+fWYbCm247bgay74UjWHeR+jy2o6yCYKlKYw5Yw14Nmg9BYfaYswZvGoP4Z7gcfSUTLzY8E2v+65zww+qWKhBGHY8AkH5bRWi4GmPJe5psSXBaYHA9t+xwKBCAqm/2IWdD3b0ZP6vZf3fN642VTFqyZ7mnYXU0YCK0F6ldb6Pgp2xvqXf53yKOQcM+FL54hG1wjAOYw9/gv15kQH6Su4oM9JaLFERdl/qcnQUj4gAOspHSjlYf3J6OEYsApGN0PRuFLnjBbms2Vvt+YNWZR8G96wESELpIfOQodzcew0sGsHJ6+fWTwgEUmM4EYHgu2ci8aY8+jvlM74Wn0lGG8V+gbpLPq9n/h6YfgwFOlLSkxvFIb26GEsQn+JSoOlPXeHRnqEWUKhpgvAR8NU42sS5m22x9Gk4ZhZINcoHnwY6J8t7wkmzFXnc9DZ23NpDeQ==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(4744005)(6916009)(8936002)(36860700001)(5660300002)(336012)(316002)(8676002)(70206006)(70586007)(4326008)(86362001)(26005)(16526019)(186003)(107886003)(956004)(2616005)(6666004)(82960400001)(356005)(81166007)(47076005)(36756003)(2906002)(83380400001)(40460700003)(82310400004)(508600001)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 06:09:31.8686
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 66dcdc0c-f9e5-4c41-d530-08da058134b3
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT053.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB4413
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Mar 2022 06:09:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7706

From: Jan Kiszka <jan.kiszka@siemens.com>

Not compatible with the deployment process with uses content of the
buildchroot. In order to be present there, we need to run the build
unconditionally.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-devtools/ovmf-binaries/ovmf-binaries_0.1.bb | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-devtools/ovmf-binaries/ovmf-binaries_0.1.bb b/recipes-=
devtools/ovmf-binaries/ovmf-binaries_0.1.bb
index 025b970..6524300 100644
--- a/recipes-devtools/ovmf-binaries/ovmf-binaries_0.1.bb
+++ b/recipes-devtools/ovmf-binaries/ovmf-binaries_0.1.bb
@@ -20,6 +20,7 @@ DEBIAN_BUILD_DEPENDS =3D "ovmf"
 TEMPLATE_FILES =3D "control.tmpl"
 TEMPLATE_VARS +=3D "PN DEBIAN_DEPENDS MAINTAINER DESCRIPTION DPKG_ARCH DEB=
IAN_BUILD_DEPENDS"
=20
+SSTATETASKS =3D ""
=20
 do_extract_ovmf() {
     install -m 0755 -d ${DEPLOY_DIR_IMAGE}
--=20
2.34.1


