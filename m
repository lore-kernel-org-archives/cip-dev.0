Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBF1CA0EDC
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:08:34 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.4])
 by mx.groups.io with SMTP id smtpd.web11.1008.1755706111176882380
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:08:31 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=H78TabX9;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.4, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SZT4D9qQE0/mFhL6YYFxRK9fa8PGET/pERfCCNFUM444rln1uY5TFLaNHWYX1ZH7hXQTWRPUopWGYaRmz1DWo3a2sQViD2oXz4p0IqRI4jcPJmEvitO8TCTpkKfx03J2DDJHYpQAyNNyR5n3/hr1OyZX8hBnbNncJ95VA20jmpt7JAOnaQK4Mnex6zWuTEbokR/bbcBpbP4Bh1dHYFxSuwOuGu3tXe3ZZ7WJ3bM6AGt7g/0ZHTZ3eBAu5PJ0XurdE9NXUWA+9I66OMBd2Iy3N0wOAUx8loQv/ynzkahl0Np8Hm+wiu0Y+UEIx3RQTKz0ngOBJg2N/UPgiJDJZlvseQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8TpfW2uDtBXyeeMuCo+nLUbs5mMOX0zMuf+mCi1zcdY=;
 b=EkJR8emND7GF0zB+xXydMz2YN7UcDIT0ge9VBbHoSFmC6kmaFjm2JmNLUS86w6rj94bAM4JtN/DadvFSQEK9HmZX7Nwcs2EqgXJt/bbUEaoYfZmohDNcq+eSnJDfkLEytMoNGhv6Q5Lr53AOoSMfZALdWFl19wBGoOauae3dmUukDphsM3k9+QnbHGDHO6BsffnRwAqXLpelPbDHwYtAdyfXOuFTVEY7UOTmVKq7kb14Mi6/DR07IvorzLSfqK8kHt0cel51W+y7NO3bUH0g9zvsYqN/yyGWh3reC8k632w8boAkZIy3Itj549c1AVrKYJzO+anhOOWMLEj9+PiouQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8TpfW2uDtBXyeeMuCo+nLUbs5mMOX0zMuf+mCi1zcdY=;
 b=H78TabX9PIT9qA4ZOMzbYv1CsDtNtMiYOSaV1gOqosaHapmgliBoD7TMxriqcmKmFLMYHi/PUBqPY4xqVWYkm7/DSPRkqFZdAeeHtcJwiD425/PO4PppkQ9SKMJhxVFNJ/Tb7irHIqN3JNl74T+L5MzAoPdM8KqRVjKlNXNwvPo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSCPR01MB15595.jpnprd01.prod.outlook.com (2603:1096:604:3c1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 16:08:29 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:08:29 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 02/55] media: dt-bindings: renesas,rzg2l-csi2: Document Renesas RZ/G3E CSI-2 block
Date: Wed, 20 Aug 2025 18:07:03 +0200
Message-ID: <20250820160758.801813-3-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820160758.801813-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250820160758.801813-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::11) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OSCPR01MB15595:EE_
X-MS-Office365-Filtering-Correlation-Id: 17701e56-2250-408d-0984-08dde003cd41
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?o5eYle9E/HswZxXUwQND8m1CIT2Kj89DQ72d5zaKOKEjP3R3GM1Bu3Fidl8d?=
 =?us-ascii?Q?YFvzBjQJWkV3h0CP7cVZRM/scm+T1kuVTDvpGwoMKhB9fHKLsNne9p4F2T6d?=
 =?us-ascii?Q?YvR6uESgMepaU6HHbvandtay4kSFc8DwwqplznCejfAsa1bil0xkE1RC9kAx?=
 =?us-ascii?Q?ugq5RjhNvfMbtdmn80GvhwLIkE+BTxunL9AgZQYAeKzVtDrNLkTUkIrwmluq?=
 =?us-ascii?Q?HLf6Obnl1brnRcHXsWRjHhV0FieEOxOjfPTFMkxZ7evCu6MT2ng5Kn39plpz?=
 =?us-ascii?Q?ta+W8KqbwmizMbuoz4hZ23thZAy2SWmLo/K5sYQ7l/vmnS8uZb4o+h0vug5A?=
 =?us-ascii?Q?WSRyOnA83X8hxZz8WM0PAS0FLzUKiA9UEys1jpI3nHPhBTryXfZq1rsmpTHF?=
 =?us-ascii?Q?hgNPD2N/XMwNS6viFBbfX75KI3Wd4f/E4Zvb+2/QTuKYfsV37fz2/ZYroSJx?=
 =?us-ascii?Q?ZimGJ8UkrHHUp2QiyCqbtyFQ373YS4N5N/wODgT2LU8+xZAjAq/ZxZub/ZYE?=
 =?us-ascii?Q?P801Ovv3bIx33go+qR4KHUw48kx67teMwgmxxDwHUBzxbUcG26weKXjjYk9u?=
 =?us-ascii?Q?vjqJtLL86xByWeETB7IT0HvVs0EsAVe45pIEk+PPTBBf+N1TEyeI3t/VsCkg?=
 =?us-ascii?Q?LU5VHmkjvpbrWfzMIl+5mzd/10WHNjVG9Dmgi7wCzB4y3x3PFlaakdveD7nC?=
 =?us-ascii?Q?3iEzewy2RosJP+P4K2cvkH0v44Xc4NNPQ0pJIu6nEC/yxERC80JFMGbF/FkK?=
 =?us-ascii?Q?AFTpwXpuxJDxkER6ZYoA1/e+2wg3Zn50B/BKbmkHvvkd/M4TDUVysHk2zDeD?=
 =?us-ascii?Q?+qjet6J0k9UYVybLyD/EX1pEjxBW63wQVPheJ42CdyWWp7zdQZs/PuGPINuJ?=
 =?us-ascii?Q?Io79B8CZ8djbCcJ+YsJooFqFqwxI29pzm0KVPjdxIkYCjUdB5sPNW5rJhAHe?=
 =?us-ascii?Q?GNYmQTDfU0fWaz3zICgqRar07DaH9tr/Xq8Q1846oegEsOg4ma3syBeKdKYR?=
 =?us-ascii?Q?Gd3w0qdmeFWD3eGLVZRgjrnVXpwS/gEr3XKQTGM8TnjMk+Jm0UN3DwGdveOg?=
 =?us-ascii?Q?WHIWpylLqcSuRlUXKMcDpz0vmATDWEGR536I6+VphI5GK8yHwO+UAZzUAFS0?=
 =?us-ascii?Q?+s5jILHoUT+gWYkxP5WrZo5QIQg92rKMiEJuLDD+RjOaudbimY2edslKPGa+?=
 =?us-ascii?Q?YQmxkudqGvvJhEpdMaq/gwRIgVgHADEmnotCf8J6EaqHnq+yKKfbAIqOtc9f?=
 =?us-ascii?Q?WIQMcHrcjSQjR5qH7TK+EWWKqBw8Pylan23X8A5Xm+BXgn/jWPv9jmkTV3P7?=
 =?us-ascii?Q?aP0H3vo8ZMBImWWOhUNExx/eRoEPBNAUdVRy8qstCIjesc2Wk0EbM8S1ncGx?=
 =?us-ascii?Q?WDtfJpODJhMfZcrghpiLQkERSzOKVFD1l3vutvpQ+OyPmsnfkUmwXooh7Cyg?=
 =?us-ascii?Q?v2U1NgRxmyGOx+p9Nmxsws5lEbjhElAvQgH5LD3EKbKaZmHb1I69KG0MVA3X?=
 =?us-ascii?Q?d9NdEMEFWQtN01k=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?xUW61hO3s6vJ1uAtPIWxrtcpBUQeC5fCBl8XX/Ck6S1SzYuqJO+pZCXJfPe3?=
 =?us-ascii?Q?gdmPKvAtVxAkkmhWoT4YBkJRKuHv84nrEMlL+qSVZUETWiDgxPtEXGsN9BfP?=
 =?us-ascii?Q?NRoFZXBnAk3oNiDcAW0ltODZd/onEMhnpykn4c+zR2E/xKOyz3sO/tL1WLHo?=
 =?us-ascii?Q?UBFjQzKWg9jBaYsdvTL3Cm6lQEehlDCtFHCJc0mZQ8Dhc7iDKf1NW/yTJsfM?=
 =?us-ascii?Q?mOElrqMHm5aVdwJR2iryMl/dQXSPh/yckZakqac0v28JO2iTgH0/K5YNov9B?=
 =?us-ascii?Q?qgusIHIeMGE9xDqvbU0aUE8xnclPANiytx1w4U/21jt4inKCNZ6kt/2Q/dpA?=
 =?us-ascii?Q?VCQmFaRcMQed7mCInoEKdWqAVGwRZhQ0/q3QCfhTLNR4xbw4wJE1kfIDH7AB?=
 =?us-ascii?Q?SbQ7uRlo88yH8hNeXyY12uBkpbH+/sC4r5SsWvWNkXwvDjBKXVKLILWCMY3n?=
 =?us-ascii?Q?ahIyt/nZUngKtYk1byIIpNJZ0LEXX+0ISMRQxvC36YW3Kn64SN2zERWl83CG?=
 =?us-ascii?Q?X+XrH2TyvIRl0w0PA8mqEgZoJJw5Ot+jIFFKfZOsr519Xv6CWnKLnKN/jbbI?=
 =?us-ascii?Q?BuVb8uGbpBrO+9zvlxLlETOtewqFDoqHJnSyHDSnL2gzd2QVRKXgCOGLWIVm?=
 =?us-ascii?Q?Bjj2abbw6x4H5kpGRl2y11Kd5LP/MqYZfK0DYCsZewk9nUqVulzPElHq0syo?=
 =?us-ascii?Q?PZi54juSjZBRynxmr1py3DAxSAYxrMSqIx71ymHo2fwsbZpmuJjBrJ2wsb4+?=
 =?us-ascii?Q?fD5Iv8nzPXJ4IbJRmzY1JXVX9TByCy1ogb/Ab56bCe0/oXUThvzhyEoZNrto?=
 =?us-ascii?Q?0KO8qM7VPluyOjKRC7vbIspQ59Us9+0UZW9nFnuv2xDJ/y7Gymi06MFml0U3?=
 =?us-ascii?Q?K14C+y3K4v+o5yJWInd03q7n1307rp1feYY7NBCkcSXHYM6Nc0+Q7JEJK5Ii?=
 =?us-ascii?Q?11lpZjKrdzdJMmzmQxlFMqX1Z9P16y33HhZgoXq92dF0BimhtUFTxDo65X3x?=
 =?us-ascii?Q?01LeAM7g5+OSQ0PyMD7d4avz8q9+G0rmgC4m53ePjLVtuNNCSEZt5vjVviRO?=
 =?us-ascii?Q?JD27SZWaOz4RKIItrk58rNJ1SWy+nUQ3HeKXZ4XnabKzBjC5FRgCpZCouf4r?=
 =?us-ascii?Q?aOIDT134fW9t4C5Y6KEBHTPxrfsTI1+c4boiHbhm1t4Pj3iajvnYHd/LitPC?=
 =?us-ascii?Q?gxH5rWBfyN1dzxfs68AHFnJ3+yYsIJpO0FZlht3Atul378wcPLy29/9P1LZe?=
 =?us-ascii?Q?4w0dt89NwQayVPFFF3e3tjnL2aGTlhEJw6Y0TYWHMZEqicirqk+4q8aQ5kwh?=
 =?us-ascii?Q?ADAgnvAIXhS3jJqd5llGUE/ukggLfqQJowCkCGYsrQHLnzjqdSBj9q4OjbQS?=
 =?us-ascii?Q?Q+w46f8T+3/2LF3qX2BZedThdmrf8wfBVQNxCquwqBQ0tBzLWMIjPMVDr7nO?=
 =?us-ascii?Q?lSbl0MQfXrBJUWQ193+DcCUadnKXeD0X2XxYvCQ4+WFtfsIuvYRnqknm5dIR?=
 =?us-ascii?Q?sq/sjlfewwJHY8p4Y8f69yglGjTQX7MhLGiqqAk9pMgK3v1Qw8b3u2Cku9XI?=
 =?us-ascii?Q?BEO8Rrg3GudoVuqJZ4Fi4s3M1fLoB1R67jTP4Grd/kByIfRbctQZZx/u9kN8?=
 =?us-ascii?Q?F9TI9Q9Rih5yoqn9x+9M7IE=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17701e56-2250-408d-0984-08dde003cd41
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:08:29.0490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gcZgsfptAYJP5WzOa80lO2vmprIJ3G+KPJoM2buuEwswxRQ62rienHYNZDWn2AFluSpF4Z8AdpKSXd7rk2H3NXCiMMgGPQsRCPVJeKWhsAP+CQEiEfgsH7hqcl1/nWNL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB15595
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:08:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19883

commit f1c83d2f2841e99f884104e912aa20fcc32b9c2d upstream.

Document the CSI-2 block which is part of CRU found in Renesas RZ/G3E
SoC.

The CSI-2 block on the RZ/G3E SoC is identical to one found on the
RZ/V2H(P) SoC.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://lore.kernel.org/r/20250411170624.472257-3-tommaso.merciai.xr@=
bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../devicetree/bindings/media/renesas,rzg2l-csi2.yaml          | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/renesas,rzg2l-csi2.yam=
l b/Documentation/devicetree/bindings/media/renesas,rzg2l-csi2.yaml
index 1f9ee37584b3..c5c511c9f0db 100644
--- a/Documentation/devicetree/bindings/media/renesas,rzg2l-csi2.yaml
+++ b/Documentation/devicetree/bindings/media/renesas,rzg2l-csi2.yaml
@@ -24,6 +24,9 @@ properties:
               - renesas,r9a07g044-csi2 # RZ/G2{L,LC}
               - renesas,r9a07g054-csi2 # RZ/V2L
           - const: renesas,rzg2l-csi2
+      - items:
+          - const: renesas,r9a09g047-csi2 # RZ/G3E
+          - const: renesas,r9a09g057-csi2
       - const: renesas,r9a09g057-csi2 # RZ/V2H(P)
=20
   reg:
--=20
2.43.0


