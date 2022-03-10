Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E881C433F5
	for <webhook@archiver.kernel.org>; Thu, 10 Mar 2022 18:50:43 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.44])
 by mx.groups.io with SMTP id smtpd.web12.590.1646938241868373318
 for <cip-dev@lists.cip-project.org>;
 Thu, 10 Mar 2022 10:50:42 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com
 header.s=selector2 header.b=wX5rEWOb;
 spf=pass (domain: siemens.com, ip: 40.107.20.44,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQbceGLGmwk212IOpxgLskLywqpyQdDSDsvZs0z6ZtA27G8PsKCGFTT+Y7f/caeN/j/WL54Gj1hYjBtAEq8tz1SIaT8gwEf5PYmWG9Bj1eIfzapuqhP+J9jscfguJXishaNeT7Z/ca7n4atN2f6iFQ/yf89O8CSw6yq7JOtVH4JlgldvDXaiEbQKH53iqihPkBzcXwRu+L4QC/CfHZ60lUoVmKnfmCHXv4wRwdZkDQPErNe0rri+L+83dusJRqa1zKzhXMMkoZXxTusg4mv+9jaEhVGvSs4cPt482R87z0J6Tn/54XBS6Gx4qbpvIAJdb/J96PsYz0JRcHcooSiZcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=svvcICe51JimtmP8y7tthZhAOCIbmO973wUYGuQzL3M=;
 b=dQYDrveZE+CEkzsKPswsNQGuZca5mv9WZBfq9coN06beo9N7d+rePLJ4B4hIwfVhVccx52Zob3ADaWZFJM8n2loUI0bFcfwR0UIe6HnriNGp0YPdcX86VH/0fAHLqiO637dL7zLSwT/Hcmru6oXop82S/yRDnabvmZbF2sUWVVbwOzPSjztqVd6wv1zdKUwl9q8V4AWPFML9KQgS01pPqHb3OKDKrP4ExW0DiNJbfWTdxZm/quHcwOqr68fnzCum1dKJToBQmRWDmYx3rCSmOVOosNZLxy1wSalZF+z5io+6uvB8o6pLaRKLrrPZbIavICvm5smP6vaQq596aQ9R8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=svvcICe51JimtmP8y7tthZhAOCIbmO973wUYGuQzL3M=;
 b=wX5rEWOb5KdAa6LCgZesAxSBsGeB7EuvB2y10ipmwy9OYHfufBSiXH4exEiXZvQzDJpdNlEkqt5KnAovVV6/EHyhZ79otvcrc6cln+bHBiJUIP//cCh2TwN7CzXBtSijiUgTBi7KNfH93ABtCvaud15LQz/u1OBZoZNWoBUDspyl2XcPF5l1tkdRdaA4W6eC9lkgJLpE+YQUAq9SInyGKTNqt1kHYTS1YJTkXLN+YXm0ajrJpnMGttYqANj/sY7FvW0mpCL0BT8U1HpxhlPuXT86d8InOOzEMVET+gTT/LhD3NVZUAsYl+LEpRI/B03iKckWE9joFmzpcPVrlgTQYg==
Received: from AS8PR07CA0010.eurprd07.prod.outlook.com (2603:10a6:20b:451::8)
 by VI1PR10MB1776.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:802:33::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 10 Mar
 2022 18:50:38 +0000
Received: from VE1EUR01FT018.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:451:cafe::bc) by AS8PR07CA0010.outlook.office365.com
 (2603:10a6:20b:451::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.7 via Frontend
 Transport; Thu, 10 Mar 2022 18:50:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.71) by
 VE1EUR01FT018.mail.protection.outlook.com (10.152.2.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Thu, 10 Mar 2022 18:50:38 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Thu, 10 Mar 2022 19:50:37 +0100
Received: from md1q0hnc.ad001.siemens.net (167.87.0.196) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Thu, 10 Mar 2022 19:50:37 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
To: <cip-dev@lists.cip-project.org>
CC: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [isar-cip-core][PATCH 1/2] Drop redundant SWU_DESCRIPTION_FILE
 assignment
Date: Thu, 10 Mar 2022 19:50:27 +0100
Message-ID: 
 <f88c51fd557fa549c6154fc61870568e95808ad3.1646938228.git.jan.kiszka@siemens.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1646938228.git.jan.kiszka@siemens.com>
References: <cover.1646938228.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [167.87.0.196]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42dd2746-742f-4e02-1979-08da02c6de60
X-MS-TrafficTypeDiagnostic: VI1PR10MB1776:EE_
X-Microsoft-Antispam-PRVS: 
	<VI1PR10MB177632AA6B678D2431C80364950B9@VI1PR10MB1776.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	gCxXUW7I75wjEtYn2LTx66eJF8J3iLCZic/onSeYcnR71abgrxKxqZAjdnXJ+4XvN52ZCuZ1OAR+HmVhFCL8+U811chMbbCxZ5Pqly1u90XqVbaMGk5eGSt2YaH9MtE0J7ANeT5dC2rotLieo6p059FacFUPQJ0/m4P4pkxVJNijqvUn3hi4p53I9vAVbGkbE7/nn3pXQgPT5ghi1iTGwrEVsD31CJNLg9jxGLFyLjJext6seqGliAyZqqCiAnaWS/905L2+hL0WJ6pRd3KaJZpzCcc1L41cf4lQ4vHuALM/R7YOVvYwY5Ka7OWx00BKdOUl1y/6yJaDgfAkDhHuWsZdy25nYrdzB/YXH4WD6381KLIqpycEjdhzOuZZyYTb8T8NL5egLUD7HQ3K3Ya6P6sSdDKQIqspsOk3eJLbA49ImVGRjafjZbFPfYka/s13CqWkKFiG9tvDTibWf0kyTxBdymRhZC0B8WdMgBsoLKhmc4x5iEzP4BnGRivEh0TJrm2ibgMjKWohZFI3GSl5K9yubR37Gk6j31ia9LsJgseI8zClBfb2VO7lchMJd+4fE5LQQDm9gJCii3xAfJ/1aJQJHppNdydTGDT1iEut37hNq/cRg7igGeaISQq/0gDuwF0sVlpvou6e9kJXmYyKvzvcjuwY+wGNaC7/53DbV8UgK4P257pH2q4XjNRXJpS3BPimhO/D9TZk4y41zNlEQA==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(8936002)(2906002)(4744005)(6916009)(86362001)(70586007)(44832011)(6666004)(82960400001)(508600001)(316002)(36860700001)(16526019)(956004)(2616005)(26005)(186003)(336012)(47076005)(356005)(82310400004)(70206006)(36756003)(8676002)(5660300002)(4326008)(83380400001)(107886003)(81166007)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 18:50:38.3497
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 42dd2746-742f-4e02-1979-08da02c6de60
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT018.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB1776
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 10 Mar 2022 18:50:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7690

From: Jan Kiszka <jan.kiszka@siemens.com>

Already set as default in swupdate-img.bbclass.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-core/images/secureboot.inc | 1 -
 1 file changed, 1 deletion(-)

diff --git a/recipes-core/images/secureboot.inc b/recipes-core/images/secur=
eboot.inc
index b619b50..950b41a 100644
--- a/recipes-core/images/secureboot.inc
+++ b/recipes-core/images/secureboot.inc
@@ -19,5 +19,4 @@ TEMPLATE_FILES +=3D "sw-description.tmpl"
=20
 TEMPLATE_VARS +=3D "PN ROOTFS_PARTITION_NAME"
=20
-SWU_DESCRIPTION_FILE =3D "sw-description"
 SWU_ADDITIONAL_FILES +=3D "linux.signed.efi ${ROOTFS_PARTITION_NAME}"
--=20
2.34.1


