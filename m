Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2961C433EF
	for <webhook@archiver.kernel.org>; Mon, 21 Mar 2022 07:59:36 +0000 (UTC)
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (EUR03-VE1-obe.outbound.protection.outlook.com [40.107.5.58])
 by mx.groups.io with SMTP id smtpd.web09.28038.1647849575067297233
 for <cip-dev@lists.cip-project.org>;
 Mon, 21 Mar 2022 00:59:35 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com
 header.s=selector2 header.b=Nb7k2YuP;
 spf=pass (domain: siemens.com, ip: 40.107.5.58,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jfTzqCYH1KUEDFnCcy+5UT/0RT5Vc4x7DNThEBTWnkvK5kBHKWTxVlvSKC9Z9I0a0Xs1HgSTTOd/5gkxjXnit5r3+wyE3H+IO5cleLca7XRg3IKRxzKb+R7mnALetFZmhkWrGdsD2gvOvtBeTIdS9Y7Tq+i3MLGbNAvSOFYFyxKhWC1LHPiwyHOPcF947+kemDdM1PQQtNbirMTCN8FTTtEpb7F35kZwBo+wgRnUwEWqgCkirCXs/jgg176bIIWA6eAkLYcA2598cAhF+L0Zbfo/kNtEHxfSPbIp1VgeUdw2oP7povU29x7coG1UDTpxrcd3LFtOE1Lw3Syu8rfOkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mrxTBDpP1gKCKZ8mag7hEp9qvnS1DYaoFozbk1a8UNg=;
 b=gLwzJ694wrnkQt30j4LinmjJTgblE0Thx9cBGVI4tLSSX63UtWSz2t/XkHDxxD0QMD4uMOsqUpm6ikyLBu3E6IxZQWBG2ZMKx5gDtg7BgydsJk0PxOQWdSI3qG8EDhGzyBtdFCpaBNeaw9oD8soOrnqcSBxZSG2xcqKuSvGuXwVeLVGMNcqURXqCbgbAlmI4ROZn3MqWL9NdNilRTfLq6DJeA089CpwnrIlVyYb2BP8bqpqjH5P1RyNmEL0ikets9dReEV6+fmJAHe6ydhAR94n+2HCyd/0U73hHUK+67HyE3uMDd959h8+4XHNB3MaweiGrj2WmCjnderWNOeqChg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrxTBDpP1gKCKZ8mag7hEp9qvnS1DYaoFozbk1a8UNg=;
 b=Nb7k2YuPFwI9b0JihNe6nGw1HJSpXwV+KP8akFVodxN1Z9boarpB8JasoiC8WhCHqKFtMGM9dPLafjvpdmckYlvP+32VmAwaJSztOSDJycUINP5jFQY0VGS+rbdECeOnOyF43Ft7KsViCoyUU0z9VZA8iAnoIsWyeU0Ah7dwybmY/92vj9jBEV/RG9uPicPiGDJVxXiT8bE9//hhjiamNloD2mPTegAfnoP9o6VdFegeILbKjU7pLYmqc66IsBTKkTfLo09OS+VkzKF7dnxOMaSrlkh+b8qhP80wyMfmJKvyciznbtMHFHYjQTLrk92bXXENIhfCmvEYuyHI1qyf8A==
Received: from SV0P279CA0039.NORP279.PROD.OUTLOOK.COM (2603:10a6:f10:13::8) by
 AM8PR10MB4130.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1ea::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.15; Mon, 21 Mar 2022 07:59:32 +0000
Received: from HE1EUR01FT057.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:f10:13:cafe::19) by SV0P279CA0039.outlook.office365.com
 (2603:10a6:f10:13::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.19 via Frontend
 Transport; Mon, 21 Mar 2022 07:59:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.72) by
 HE1EUR01FT057.mail.protection.outlook.com (10.152.0.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.15 via Frontend Transport; Mon, 21 Mar 2022 07:59:30 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 21 Mar 2022 08:59:30 +0100
Received: from md1q0hnc.ad001.siemens.net (167.87.32.40) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Mon, 21 Mar 2022 08:59:30 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
To: <cip-dev@lists.cip-project.org>
CC: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [isar-cip-core][PATCH 1/4] shtab: Fix cross build
Date: Mon, 21 Mar 2022 08:59:17 +0100
Message-ID: 
 <14a5ec84e49fe4d3dfd22f9c6bb26d63075a497b.1647849560.git.jan.kiszka@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: fe682df8-e83e-4022-c1a8-08da0b10baf8
X-MS-TrafficTypeDiagnostic: AM8PR10MB4130:EE_
X-Microsoft-Antispam-PRVS: 
	<AM8PR10MB41308DDD0A7216CCD144C50495169@AM8PR10MB4130.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	mcBfgUV2q2qhDBKR00LLog3bguiYZZmg1i2C2Lv+2W08TltlqrbVNpuvp9+4LDuStkQGmbLLTkcSJ0KLbO83E6mt6ctYAI2NBl25VAzfHwHFylibKpG25bsYkdAt54d0g0xwAQ7C7RM5/7km+F8Qatpwj9Z/MYRkfdr/+OW+URFeSP/XrWGpC0LNKsxvo+aQDJu/L0ImDHXlDCM6uvGXwjSPPiOWKZaugo6EcD3XJTrWu8cm5p7dqVI072Lbc7+fDAIT8/7Z8OFkFqrj560grNQRS9LXIsXpDa6TPuitRu937NbNbUGBn//n3K+JbNY0LyMLlovOH+iPXG2VrOvTsOhH7BoJ6gXSZQfF0JGo2CMr9DYO+yEeUxS63QOGaVHVPmhxcvGo09hbGEFbNjHmeZkWyp4h4JWzH2D76Kgu6LcKVwc0I2HrRT2g4heqS5aE2E/o3dflw1jTWucVUc10ev9z5sOhdWco+vfd6XGs2dKxlKrPMj6i2/woxC5NTL1j9tO4N6bhWiJyS5oqB5VDKWL9ZnWzuqy+EXZMC47pvGA9kM2hrZeDnyJbrNvAD8PLdzYWX1xSyIPtUccT+yOuck81Yc9AwiQhU8G5oN8rd5ZmE1WPPatpudgctLGrR3G8TlyAbDcp6VYRupGMnEO7jnVltj+y81sKKLrjCYotLTkocYep7uaNSVophSNW+6qI3saKvO5vLmnclTlZ60T4qg==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(70586007)(6666004)(47076005)(86362001)(8936002)(70206006)(4326008)(498600001)(82310400004)(36860700001)(8676002)(40460700003)(36756003)(956004)(2616005)(6916009)(186003)(16526019)(44832011)(336012)(356005)(4744005)(26005)(83380400001)(82960400001)(107886003)(81166007)(5660300002)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 07:59:30.9812
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 fe682df8-e83e-4022-c1a8-08da0b10baf8
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT057.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4130
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 21 Mar 2022 07:59:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7781

From: Jan Kiszka <jan.kiszka@siemens.com>

Not tested via isar-cip-core yet: When building python3-shtab cross, one
dependency needs a ':native' suffix due to transient dependencies on a
arch-specific package.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-python/shtab/python3-shtab_1.4.2.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-python/shtab/python3-shtab_1.4.2.bb b/recipes-python/s=
htab/python3-shtab_1.4.2.bb
index eb5feda..ce83d6b 100644
--- a/recipes-python/shtab/python3-shtab_1.4.2.bb
+++ b/recipes-python/shtab/python3-shtab_1.4.2.bb
@@ -24,7 +24,7 @@ DEBIAN_BUILD_DEPENDS =3D " \
     dh-python, \
     python3-all, \
     python3-setuptools, \
-    python3-setuptools-scm, \
+    python3-setuptools-scm:native, \
     "
=20
 DEB_BUILD_PROFILES =3D "nocheck"
--=20
2.34.1


