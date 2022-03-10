Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C033C433FE
	for <webhook@archiver.kernel.org>; Thu, 10 Mar 2022 18:50:44 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.83])
 by mx.groups.io with SMTP id smtpd.web10.582.1646938242386054413
 for <cip-dev@lists.cip-project.org>;
 Thu, 10 Mar 2022 10:50:43 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com
 header.s=selector2 header.b=kr4T5OCC;
 spf=pass (domain: siemens.com, ip: 40.107.13.83,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LHDHPOGlMb35UBpzbsm2NReFwS7yYrCudSyFYFBb3CwKVB9U57mCpJ83PtqKlMbSRhdUh1ccPKunZUZtwb/1WFG69AjbG4Ya6uTj6t/MWw4mNkatO0Al4IkzSLS9p93PqQWqNf+f72cf0ytwaDp168r3GmPl0Bxf97r9c33+vSMYzUVGUdgH8Z4onvrIUTTKDrt2mmtyvLqR0NKJJq64ExeQ2xpbmz248nafVjepRP7H9i+OR+8kk4lm2W6+U9oTZjuYCrmGxfdJbNk2Dno3HZcN6NTnHwZc15VFsyYPfvukSRrkgKByx5waP+EcctumjjNOpyPu0k2YZ/7GFMtpHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+e+ipvCRxR5yHdTIv7gqCGXEOgdMHSHj2ppBwErgqQ=;
 b=hCrf3KNxzcv81FhsE3KVZ+l6h77v5X9oYiFUnTt1RFfF88raES1m7u7YqLxsRTudQgE4wkuUKFpqFH9hBtSLZnzsfdcPeX8P/QablpzxKnd3hqgRGmxHiEFi0hLfyYSxDXBNFRA4WMoFoUK0PnXfSH2wQ0yUu/78vg4vCjwo91nz/zvXJNi8x8immNLNVXH6Iv2TT89+27Za1Ho4yptcGd2blaRdWcTCOvrSgEQoMhpLWz4JJrVnODJohU2uz+ziR2LtxY8+YsjsVIWq7C6+fE/cveB43u3W6wqnODU15vOe8Lz0kW8zq1oiN+L+dSe+lcFd27W7kSEqP/oINb+HPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+e+ipvCRxR5yHdTIv7gqCGXEOgdMHSHj2ppBwErgqQ=;
 b=kr4T5OCC04erB4UwpDAyXcqp9h3EysuQ+z1mAlPPo45VfQpqQKRQ//nC6+wItg0u6lNmPlCebhLKfS0LzX0yRjtdUhPMnPvjNM/P0C9vqArSDJJXfLa0BH9CYL5lB0sgoxBSYYQLPZ4u5tO+BJAU8/1lEZKy07xgY2mIQ9kqzXMVUjk4eVL2x5aTC7m/ifOuJcQVlzzXlaby5qMv7qqc+CFVwRvAZvSCxHM1nF+rxE99RqA9WntQ/L3wZ4oHYjFnxR8nKnKzK2+UHYYj6A+HSlRt6yTDPkp5Dam3DiAG0sihJwJey+uys4pJyhOrMQyfa5f+ReqBJha/ud/1g1ARrg==
Received: from SV0P279CA0043.NORP279.PROD.OUTLOOK.COM (2603:10a6:f10:13::12)
 by VE1PR10MB3949.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:16c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 10 Mar
 2022 18:50:38 +0000
Received: from HE1EUR01FT027.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:f10:13:cafe::c5) by SV0P279CA0043.outlook.office365.com
 (2603:10a6:f10:13::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.21 via Frontend
 Transport; Thu, 10 Mar 2022 18:50:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.72) by
 HE1EUR01FT027.mail.protection.outlook.com (10.152.0.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Thu, 10 Mar 2022 18:50:38 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Thu, 10 Mar 2022 19:50:37 +0100
Received: from md1q0hnc.ad001.siemens.net (167.87.0.196) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Thu, 10 Mar 2022 19:50:37 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
To: <cip-dev@lists.cip-project.org>
CC: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [isar-cip-core][PATCH 0/2] SWUpdate-related cleanups
Date: Thu, 10 Mar 2022 19:50:26 +0100
Message-ID: <cover.1646938228.git.jan.kiszka@siemens.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [167.87.0.196]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4ad811c-9068-4f81-ae03-08da02c6de4f
X-MS-TrafficTypeDiagnostic: VE1PR10MB3949:EE_
X-Microsoft-Antispam-PRVS: 
	<VE1PR10MB3949BD8FB9D28C4F1B1AEA84950B9@VE1PR10MB3949.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	GwgV6+OssqrfsxE8RnlIQPxwJv2GhxfdYWF4cVq95aRXfhVsRrXHbYAVWxG3DzXXoALWnAFNATu216wrO5jrbGcmrlMJhorPKwd1Hf0D7L/s4YejVu2Kig0clgn1boOAVhMjnhrII7J25B5TF5Zp0IluclIM+goFoAM5axMbqR8tiG4ydWHM7YgKVhl4KkOM8RA/TcLftaPA76HIIXJyYyoJzWEJOM0WgWv6ISzBwMZDus3aSTYbwUA79FpkGV+X7GVlwwC5GBy1FnbkBGOnYOcdPIh1KV2G7yNiiKRxoNnsa9VfR67eFQzqqXf9eanboNkubKQyfRrsmq11XcAJbIT27JGw8PndDCIyqSK9HqO2kzRN/ty1SoEP3i2FYeUwA1ivOq1alLMUIKjAJU0HrqVCjf2yY6f1rWVpyQEO7HUo1T9PAW5sNB6M9sdu2pztREc4tcVK8MMxA7YsGaufXycbkQ446GzDVVWoGOXlX5K3DDtqP78ttLXa7ysifn6KRYRku7NsByC9JbJkhCeLOPvDIlnKQmhkAmVLpoT+wBgKf9RmyK8asiZQ+PHQFxX9gjTFEZVsrHT/2HSBo2n/hgkh7UXJIoJNpJQbCBlQ3cTkCY2tloCka4JxpaMjKPF2L6skz3eH1m2pwf8NgW4QAiNLCxu+5FS1DWVrQdTepQtPBxZNKhsMnxrNGQyvb0thxrfi5yLmtg8t+dEdgzlBVA==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(47076005)(44832011)(4326008)(6916009)(4744005)(336012)(83380400001)(36860700001)(86362001)(70206006)(70586007)(5660300002)(8676002)(6666004)(2906002)(316002)(8936002)(36756003)(508600001)(186003)(107886003)(82310400004)(2616005)(16526019)(26005)(956004)(40460700003)(82960400001)(81166007)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 18:50:38.2109
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 b4ad811c-9068-4f81-ae03-08da02c6de4f
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT027.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3949
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 10 Mar 2022 18:50:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7691

Primarily auto-compression for SWU_ADDITIONAL_FILES.

Jan

Jan Kiszka (2):
  Drop redundant SWU_DESCRIPTION_FILE assignment
  swupdate-img: Add support for automatically compressing files

 classes/compress_swupdate_rootfs.bbclass | 21 ---------------------
 classes/secure-swupdate-img.bbclass      |  4 +---
 classes/swupdate-img.bbclass             | 15 +++++++++++++++
 classes/wic-swu-img.bbclass              |  5 +----
 recipes-core/images/secureboot.inc       |  4 +---
 recipes-core/images/swupdate.inc         |  4 ++--
 6 files changed, 20 insertions(+), 33 deletions(-)
 delete mode 100644 classes/compress_swupdate_rootfs.bbclass

--=20
2.34.1


