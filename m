Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30566C5DF66
	for <webhook@archiver.kernel.org>; Thu, 13 Aug 2026 10:39:49 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.36])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16258.1786617575466080224
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Aug 2026 03:39:39 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=C/wIHIAz;
 spf=pass (domain: siemens.com, ip: 52.101.83.36, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u/iFYupVAKP1qkuhQevNdbBvQnTvREDyeAOg+SFqe8vDWKRY4RoZDYaE1QnIQ6Z7CiMgQPm2l9UiDU/uEg2vePMveMFxd3tbx6HbHt2lP8w5ZSaEYrrMpjlGovLvYHkT0DM1yEJ2VVSVp8OlU2dyrMVfVp9nzNZvTvkBgGiZNKX3tdqR2Ks++d7urntTG2N3EbEM48jgFvw3II4asrFj2bei2HsNBlSILt0AZNdc8bRWG0bhgLig9g0vuFnLQ8+ZRkmDvBPMg2cLmRAqdDmgC4ch3BFItX+zv4JTFveRXiN1fzzjTSepGJlGxlRLv59KZlc+7dejmT3X0WAJrRJ4xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r80Qa+tC8IpJ0AtrA5KnxJ7nOm7FtC3xUyz4r6FUYrQ=;
 b=wa2CbPr6NraQk4if/4Uw26lo8fihkhWSCSPcm4rd5imAc5UR/wTsTGx1NrFt6SzRca1MdLnPWP3K7GIXBjoaxLarehXDaxqCRpFn9cASLnBsTDcCgR0gGEKsUPe50mB9XeJS/FdJvMaj7bqL7D2xpw2GHL29gG+43Ebq1oNAg5NoZfu3tJeX7eMzrGXmHE++jcI4ZgaLXIbwXOB8OjwtJ8f9SzECn+1TVdDfJS1vFhu7kqVmWYqgoWW/PKJuxKDf+82retPSNV4nvzMrEcugxRBHYXmXp85f9ras65YSw6zZb7+Pnfu1ld7michaJxFlmid7dBwuwRk4bu24M1LNuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r80Qa+tC8IpJ0AtrA5KnxJ7nOm7FtC3xUyz4r6FUYrQ=;
 b=C/wIHIAzMr1C2DBhkGDXj2eQQqwRRiiDs1+29ymtOq9dr0fLfXE6NMxDgJRMhcFLh8ogxT2iGAhTsCuMn8SQw1BeWdZ7z9fA5eHjHPMtFS9se4lWxjtuJLfvfJi5P/Qmqg331eCV0+sIYlrGL0Ze8BeU1ASnlZ6WaY5hhJgLeNVuFS4pMx3C1mlyQOno2tSzMU/Xccv3F6yRPG3QoPIZ8ZIEc66qILqqUZyG8nU2lhaW3txeBMesCil9vZNiKqrvsqLQZs79OsQlZNFkIxK4K/b6ilvxyE7suzfd9dk84WfLDJikt/uZMtz5O7bjEkgAndjKxw7v28qVwSVmvTJC4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by VI0PR10MB8693.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:23a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 10:39:33 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%5]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 10:39:33 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	clara.kowalsky@siemens.com,
	christoph.steiger@siemens.com,
	dinesh.kumar@toshiba-tsip.com
Subject: [cip-dev][isar-cip-core][PATCH v2 09/12] layer.conf: use variables to control path of hardening config
Date: Thu, 13 Aug 2026 12:38:59 +0200
Message-ID: <20260813103919.184402-10-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813103919.184402-1-quirin.gylstorff@siemens.com>
References: <20260813103919.184402-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0220.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::15) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|VI0PR10MB8693:EE_
X-MS-Office365-Filtering-Correlation-Id: 5759c2ff-483b-40c2-9402-08def92729e2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|55112099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 
	dy8zk5OJ4NVxMTn531EUJ33UDrxqAMyqMQKD0fJnZJ+blSt7MOteCxihzrtKkGhKILSUE0K2R2HkSCIfnQZRdE7/VlU3kKJ2S0ojiCmWzDMvJq9ohAF379RO7y1eReYScUzTowLOSCcHOopzgoFdrO7CWqgL1nSkm/ldMI19GaniSk0ZXzGk2roHvvMFz9MKZTHNkZMbK6aldbxUO+TkKJ/+8f39W6oZzrBVS8m9I8U6NhZmyCrhr7qrcjE8GawV6xRcNB+Ofe23od/J/bQa9ehjxJbFObxx4BcjhqpYUkceUUQEwsrosd8L6DWN0U0yLGcpBa8XYvq6gaH0J14eiJscLs2XH2Dppx2YK78drXPkoh6N2/QRaSQ7Nyee9RhcYB0sUrkvOCJXCZ+3q+V0qA7IHcc4hi4+lY57Bge4fxAYIf9uYKcJA7rzJtFcyuxn2ZCrdSW3miNg0mnO6AGp2c2C9CWMl6eoyna+0URTH/orTFVmtN5L+M6aupBlRBVzfiWAt/RqhQH3Tpx9C05XV2byeIgaB33RLpSbdpwCn5eXC0QepzyDrAGe5/cawYHbZOuMGnFLno5gDS5z5hPdLJ3SJzrEY9vzomnpuMPG3mgBM9Q1Lr6TXBomLP3lL24eyNjFVYwyoaSVVJ5yuDi9ZzpaF7QjCmvszIK04T5CtTg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(55112099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?TUpvWRVdrcQtiJXfuQBBsPpl6cYEoTzrxgzPz3LYGUqAv6G4FBiel1QSMw1e?=
 =?us-ascii?Q?JZwIUxW37Cr9Y7/TSJVuMa6r/7k+K3NSFG/mpmgrLag4Tt8BsTKWV4zmS7P3?=
 =?us-ascii?Q?y+I1N9a5Gs8J83mJ+lPO7YX95p5RDwEZ5v1vakpZpMiwdmMq9NHsRec3rMEB?=
 =?us-ascii?Q?w414J95D5YhfSoBDjYvCnZ2kxnkCG3wWmowQCloET3vYATccx8jE2DGRZm7x?=
 =?us-ascii?Q?XMMH0s/yFcq6AukMlG9WN0tfkABEHctK/RDqvrQ1BkP/bkG/lwecEjixTQWa?=
 =?us-ascii?Q?ZVxIjR0knawdL9IGaxN+Ho4TOK1JMRtbhoRH5Hhs/HFlZJka9mS9vtwIcXw4?=
 =?us-ascii?Q?sVvdoq0D9/f2Z+qm7T4UvfY4FQ8rXqYvS6D0VTyXcx+Mym2hgPBqaw5JVZ5k?=
 =?us-ascii?Q?IaKkB4p3QyAJF+ho529m4lPAqoMIsHf/YpHd2yB7HNKNuVscsvD1g5uQcrCW?=
 =?us-ascii?Q?okbKQT/3qYRAtBNJ2Negcl+fn3droaXhbvZmSqo62mpHab/tMfdIfDyspz7b?=
 =?us-ascii?Q?cf0Po+R5fvC64eDmtMLW/V78WRJgMRnS5gNW1wK3+zHQ3Z2WyF/+/VrbyBtT?=
 =?us-ascii?Q?WIK4U50zts1aPJPl1K/amHgEiWB+ze5n/zEOm8SdrW/7Ca+sTeLZ/4kMOXdJ?=
 =?us-ascii?Q?xlvuECIf0gVyXX0ZX9yB1iNw/iJptrTW5z3+xXZQMbMFcRKkowkyLehuM+tl?=
 =?us-ascii?Q?3TMWoCoei8PCf6qpF9rmUoRugsv7YEUp+w2J8r4LY0RLU2SfAp/q42movHoD?=
 =?us-ascii?Q?Il5gCHIzjB979Xz2RAT+IMaY6+cs2fNRc57fGCBRallUxhvyh8tMlfYg+dH1?=
 =?us-ascii?Q?ZJDUjWe4WdvsLSHLDMTJBpzhjwdaKOR2sW7PyxXYpsEh6GHrXCP8IidNZMUA?=
 =?us-ascii?Q?gU0B4thgdns/RI1b0+vpqTatI2DEBq0CS8U+7jZHedNIS4z7HA5dwzDWnnKZ?=
 =?us-ascii?Q?CE75aRQdC75rUQuqpMfQBPPulqex0PU6v2XBoWSpH0WvKBm9i6T0euduDn/I?=
 =?us-ascii?Q?lFkkMRB0H+Er5uuJAiMmUjZAR5LL7ATkIYRjQBSR++yFoRVomyvwddh9p0Zh?=
 =?us-ascii?Q?SoxFAjh7TU6tfIas/OV4BFA6hbJ00XKkWZRus0Atj/q27PWOLtk8sibzIL+4?=
 =?us-ascii?Q?hh2OTT1hwXfVjZUfa+tvOEMTM/SNcIS6W7o0oTkvtSbbVfmGbd7WXAtQhW/1?=
 =?us-ascii?Q?vHwvePf20TlPLi4pkpy454jWwcqoxYcxgoVKbkL2MP2Ev7t0MImc+i0mQFQP?=
 =?us-ascii?Q?/ScMVQeqA8f6ze9XxY/Qd9n1MuQCqv1NU47AqdR9fRspCm+9Sg6R4g16titw?=
 =?us-ascii?Q?ay8eFas1l8bAvS1NRAf9Mksqes2N4+suENNdvT9iW2tkL6RP+c9M315x7iY4?=
 =?us-ascii?Q?Pa5P+7mUuTvXbH41DOkMo/QNjNQqfeMMHPS5pUt4xhQj11y4aCoCM4pHDKWz?=
 =?us-ascii?Q?+ujNxFX6euBmkvQ5efZPoCRHCh9OY4LCAG0fSxNabczhzn1Wk9okhKeV9XtM?=
 =?us-ascii?Q?J6tMchPtQwALxZm4mxsDeAMvW9K/dQeLtWEoF+JWFvZba4LcXtZfb/x0vUgj?=
 =?us-ascii?Q?O3razpaCEu/Xlu1EAZarva2SwCT+t0xVprVu7vSORllOf13GhKBfLoIRe/w5?=
 =?us-ascii?Q?/3PBJU566/TH5OEHxw0lpTXFMP42u2tvW5cQT8INUUBViszRPW3hESO151Y/?=
 =?us-ascii?Q?5id4CT3Lp5pxp88qJq0YU2dvgxqRuD31tvRMCvcoIP618IiBYgTwR6W4vdXf?=
 =?us-ascii?Q?Ew3ckqvGRb58lhdehrgDPFlQlywGOCw=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5759c2ff-483b-40c2-9402-08def92729e2
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 10:39:33.6649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nR9wxzXGLzCQblHHpIWinmsz8878WDBeNsDMcCbaB1EIs9FPnVaK4bvFyJxB30x3yHLu78hkyYnpTfuvD5Htc1toiv6dAHGOnGfnl3GrVOo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8693
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Aug 2026 10:39:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23924

Co-Authored-by: Felix Moessbauer <felix.moessbauer@siemens.com>
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 conf/layer.conf | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/conf/layer.conf b/conf/layer.conf
index c51c3af1..61e25b22 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -23,4 +23,7 @@ LAYERSERIES_COMPAT_cip-core =3D "next"
 LAYERDIR_cip-core =3D "${LAYERDIR}"
 LAYERDIR_cip-core[vardepvalue] =3D "isar-cip-core"
=20
+CIP_CIS_HARDENING_CONFIG ??=3D "${DISTRO}-hardening.config.json"
+CIP_CIS_HARDENING_KCONFIG ??=3D "${DISTRO}-hardening.kernel.cfg"
+
 IMAGE_CLASSES +=3D "squashfs erofs verity swupdate delta-update qemu-emmc"
--=20
2.55.0


