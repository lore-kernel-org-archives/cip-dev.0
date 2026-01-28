Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45EAD3F081
	for <webhook@archiver.kernel.org>; Wed, 28 Jan 2026 16:01:21 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.38])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.753.1769616074619039322
 for <cip-dev@lists.cip-project.org>;
 Wed, 28 Jan 2026 08:01:14 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=FU9/qi6F;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.38, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=drBbcSkW7fb/LezYoklQr60dDZwCjihqSxqWumVY3xTqeMM75adqMvhny5s74lIDJvWnwJfpJdGTxtVRWfhdCDiUCVkzN87AmHZ57ZVZZDa2MoW82DMyeToBAwqOhpBNEOFrKpamt1ZLOYolDmUNHtj2CY99p5FAZVRwpG3i0lrnesDN2qMpglUmuqVF/bwdGDElKFaZGbmzarzFZGYGVoRTiXbrlLoLJvW1oes14LSHVU2X0M6wVCwriOVaPy0kCiDigbjCwY8isxMOfqUPTMvwDlyZH5PGQQIXVbD//CK5YD8H18vVTVBLCo68Hrviw/xWcPtcgxQJ+VIfZdCXoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PdqL7iPyuE7peEga8O9zF88LKsuB/svDB9QLD4b+rPo=;
 b=SpgT4SoSq35ki6MgTWk4X0uj0JnrqBOAu9ukC03rL3BIkbExzEsp9WrLDVd+s7LMB2MdwmVqHJy/E2Ihe73yAB9TKhbJBvTMkp9k8CqAaorSNE2okA9EQh5zqsXm+9rIVCM5ze6O71kw2P/7Ms2mHkXdPuks6u09bgntDOm08TAJ9QeRLPt5HLd4WnCiMCdIflt1/tyOO/A991SgAfIaV7oOyUoDgxXio+EO6Psg0EioUXD5pU1eSwaKa3VOTkJDtofcyeq81yn+0bj/s6H7cIJXmPeDpigG4kUFZSN5lNsFv3C8RnO8Kj1AKL6H+/k7ojwWVMkIP0oKcBFRTez8Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PdqL7iPyuE7peEga8O9zF88LKsuB/svDB9QLD4b+rPo=;
 b=FU9/qi6FbgroX0dBcZUSAo8ppYeyMFWln5R5SO8evlt7tOdyfg6HCdoHzMcqpI48u+9mMEHBUK609I9JfDrDTT95gWTnJ0reZemaGHK5/Krn8R7gseV0L6ZXmGYHZTa7UY3UIpy/tmR4pOJA3N2XxUfSQ7MH5Bz7dyyxgIwtJzo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TY3PR01MB11948.jpnprd01.prod.outlook.com (2603:1096:400:409::5)
 by TY4PR01MB15588.jpnprd01.prod.outlook.com (2603:1096:405:28b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 16:01:09 +0000
Received: from TY3PR01MB11948.jpnprd01.prod.outlook.com
 ([fe80::b718:17d0:6c0f:1495]) by TY3PR01MB11948.jpnprd01.prod.outlook.com
 ([fe80::b718:17d0:6c0f:1495%6]) with mapi id 15.20.9542.010; Wed, 28 Jan 2026
 16:01:09 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 0/4] Add RZ/G3E DMAC support
Date: Wed, 28 Jan 2026 17:00:44 +0100
Message-ID: <20260128160048.1445926-1-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0091.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::10) To TY3PR01MB11948.jpnprd01.prod.outlook.com
 (2603:1096:400:409::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3PR01MB11948:EE_|TY4PR01MB15588:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cbbd866-ba06-4b95-db61-08de5e867381
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?hzN5VS3Qbed11Pqb0rqWpgqJQwdx3Tr80XfKlXSrHYyD+9T7z4VLh6CBLDEf?=
 =?us-ascii?Q?HUOxI3qljGdJTIapU5BfV33cYTWdzTDvT9WKfNAJWZrxmqSFMMLJ9LgGvwL5?=
 =?us-ascii?Q?diWfVhArYhy7Q9iX/a06Aig80DbLpjEiKq29Ip+FY4ubUbF/eIRh9xrUKcZn?=
 =?us-ascii?Q?Org3UCbvwgyE3//XpGeNiZmHw3NwNYSubkxmRkHxjOClGCYJs0qPIUNqR8Qc?=
 =?us-ascii?Q?8dAI7QnPUIf7ATuVGsqYu4/dOT+R+sxkb5s2fIrRj8u+xRc8Sqw9h8ZpSuNz?=
 =?us-ascii?Q?E/QNFv8RSvX7B2VxZG/fEgjZI9OkqopB7W3xenhtT9gH/K1nKxwjBOyPEyQg?=
 =?us-ascii?Q?w+p57Y3ZCFRU+yv+WTU/HGG1ZYoa/d9BD3K9GJ4mluTO+hpCr+avSVpYdG0u?=
 =?us-ascii?Q?mJvzsa0S1pmmlSAv5TJ3h0ow6gQMFK/1ymPrysUKNSyiaky5g+8j04exfvbF?=
 =?us-ascii?Q?qtj/xvApkbqLuaiQ6BAhVXQRLRig6cvT7S2f7Uj8A1HuHfdUQB1HU9uasfiP?=
 =?us-ascii?Q?QGCkbqY+1Twa0OMrX+gVWz6TiRdO/6mGAiQx4i7d6FRmPhzC5b83wu9wz37j?=
 =?us-ascii?Q?fyOLnAkioGoLeUKzJUVFOwdB85vua9+CLbeSef35yjpq5LMDDjwmex3W6miG?=
 =?us-ascii?Q?X1r3PFwhiP/6xhwwjckAX7LThUro6pMlrNiJZM+QpX9hQgyqP4rukLuw3Xk9?=
 =?us-ascii?Q?mFb4e9AK2HG76Gt34F6jm/9eMUWQNSFaZl3ghXI8MPeaiWxSJ0frNCSTwbDQ?=
 =?us-ascii?Q?41hVrtJI7ffaSAaU77RxkvDVmTDgVVWZBt7RcUvPvAjY4qjaZPskD0NiWixV?=
 =?us-ascii?Q?lnwa0S2WNrGUwr9pzjpkrvuUz5xyy60gZKN+01Od6d+D+mRbzmZJOSRcKxOn?=
 =?us-ascii?Q?hKR4aIhOr4Fte3zRPt/5ZBoWJAsrsFKJz84ZHCUK6sD83PJdcVCzBdh6sSPS?=
 =?us-ascii?Q?4IvtljTU6XFulNdon8LYlgmJwvYTDLQ7dZc/f8Q3geNML4sOYREQ7jh27Kma?=
 =?us-ascii?Q?YiXHHRgEary6KLC5d6ydwnKTaWnxhn55Ze2i1PBRRMGbD/gY2jqv+xT78w2j?=
 =?us-ascii?Q?UXxBlv8AxmPTf1IR7qoiY7c5xaFUy//h3dWBali/YblhZTl/zC9rtFUjle7W?=
 =?us-ascii?Q?TG0GKUiWZRR7pLI85w22aNS9Np2o8S9GUKSvH2/4Z06sLAodBNKf4m9xpVe0?=
 =?us-ascii?Q?lhFsZWeg9BY62Nu5ru6bFrYSH+01pUjuVGvt36eIZZtb5+R14MABKzE3w0T7?=
 =?us-ascii?Q?B9tncEoaaLJlWPjI8EtuEb6g12Apf1KWTgTtjMxjfa64BB8gL3mTbqOeTyPM?=
 =?us-ascii?Q?rERVB6THRKtjagfgPQcRvBiwu03NRNFwL9o/3TGMijy2Yr67h4ckqN1Zg2Uc?=
 =?us-ascii?Q?J7+8J7XhM7xCb3Ot7s1MSxYyqwAgsonITQzQHwaTc9P7SyWWyARsp0W6joMO?=
 =?us-ascii?Q?NJR3mClJG6miqCLay8Nyd8QxsxQdo0RWjrVRvI9viRucBrcV0IyGCKD2rMF5?=
 =?us-ascii?Q?KygqRZp1KpkAWRAqj+GqFpQtsL9DvxxoeEELINvYDEfDALLKEY+tuboXmcWI?=
 =?us-ascii?Q?+VIxq/VFSNHjk7mh7eHf5AL8USUkuYrB6uq44l+bjRFMzJIi4TkC4QInS/Y+?=
 =?us-ascii?Q?+ks7yyQEo3wIR3QIdFUnMHg=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11948.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?+2aOkR5MoKNBhunTVky2xI25P6ysdmhsylXKpLGBRJHPQiTt1FSmuFABQpRS?=
 =?us-ascii?Q?bsMENujJshR/aPiD/xUt4OpTdogzkwGMNpGqF61X3bRjl1n+TyTKWnbTtEky?=
 =?us-ascii?Q?4yyun3XxKMBtVkHpYMKgFAlMlCvi8M8J+tfy2VltbPGSmKvp/5tbPmkgQgt8?=
 =?us-ascii?Q?gUMqJ9g4NE0T8zqKSyK/FbcDUBZQRTgjGGlvEEaOOzRkE6LtYJSsiJn6s3Y/?=
 =?us-ascii?Q?1dHP8Iu3pHfLZE2n5oXLvGuAFuPU3oiUuPJ3/GWp2chIaNgu1KhZr6U/fwpW?=
 =?us-ascii?Q?3v9kqNWgLgvG8t9fAOeYkYMAPCmjjZ44aHKjfujz/NVrylP82i+GhTzafTz8?=
 =?us-ascii?Q?M0JU7ypx/mVV33i0D7tOc2yHMa8BCPuqPsXZ1lg1GiOx+8jvw9ovISbAKcih?=
 =?us-ascii?Q?Xc5vi0tpX4AdKAWjEI47oCfnhTGIBttrxCHvFxz8HJw3LBnABDxzCPhpXUF/?=
 =?us-ascii?Q?5GTJxvyfUFsdcBhcFZTeTNirVCXVbJCXq1eVsNIP02iYOfTI36/TPa7UY9EO?=
 =?us-ascii?Q?Vw9U4TbaFIo2ZTW7/nIQ7Ei9xQDg8se8eIWTavh34W3CbQFIXZhZ5OSaBLp9?=
 =?us-ascii?Q?XZmYdbluwk9JXPXh3b8O1oyyVfrzGULLfh7L4wpIukr7ua1SCUMFpfaeo4OQ?=
 =?us-ascii?Q?yn/+d0/FXG/PXvAN36s+J/SrxdkfZ0xbOtsjz5CgIA3A7ygk9eVhY+P0U1d1?=
 =?us-ascii?Q?fGlx8AG6g+b8MHEb3PyF9mzBzkE4XM0dS2N5aKl8cCG8TMIuKOwe3h8B9nA0?=
 =?us-ascii?Q?dFjOkxCTigtv/6ER3+QDS86vhexZIM+7VcH7JPIB73KZql6IILxVr2wnbOG3?=
 =?us-ascii?Q?gz3HSWlIFQlLoEtkdd3wUTfZ5MrJ3QhSMBDZ4e1k39KwZTJaO2dP9f+ic5gD?=
 =?us-ascii?Q?JejvfgixAgYJ/1vigjkn/8d7ZfG5+pHLDCZ2UouCzH4ufHQpr3b2qwElhezx?=
 =?us-ascii?Q?DJbmiu8QlqpwN6F+//yfDHNMx2qAV4QE4uzGF8gSvaA65+mpDg0lxa9y9OP/?=
 =?us-ascii?Q?gmJ5x9k9BWOZvGbFNLcSjlidj8tda9TYX2Z8T/VaHjs+wcoTU15mJTk3h5V1?=
 =?us-ascii?Q?RySIQW2QWikhhV5V+3UCd9HPsf0rItVjz7AWv+gcswBXuhiy35FD1zDFXgTR?=
 =?us-ascii?Q?Cg8WtZZAj/WPfsjXibbBrTROROgdniXlVAuOBH60ewf4WkonU/xSekIa/uEP?=
 =?us-ascii?Q?FIIr1BtvgBWlAYF/I1j7hbAGYLvMF/H7Y0AvCznpibQnnR6O9fNemhyc2Yeq?=
 =?us-ascii?Q?TlR62sZ5oQgQaMUVnWSO5F1hXLy9H1t7kDSQS28oUpGWxrPG2kSwQsMZIDpT?=
 =?us-ascii?Q?M3o4dwa2PHnrDAMFJkzXKJyu3YdLjr6YBsBCSK+6KBL4/COcZ5CmFZpB5ts2?=
 =?us-ascii?Q?yrLQDvqFmEUsZMmUHp2/bqK9U5mTfPvuaosF5cz6+tu9eH9KryNAdMnN+nHW?=
 =?us-ascii?Q?Ryatbcgf84/JbRg6xG68+7345gijejzFm1jfiWoxhO8rKk30RJdJvvLnIa9m?=
 =?us-ascii?Q?1kWw3FTeu42zks0q11GIfPFLMgBfxAmbRoVnxVEEKrsXMUMA9EDfT1T9CRId?=
 =?us-ascii?Q?xoEkDXxcNydI7c0LwMjBClBecGCExjswSiZV+kExMXyxvN9fBHblL4wghUHC?=
 =?us-ascii?Q?v1ELAw8nSs3JNnlR+dquzBGw0xAZy7GceKB8SEzr8eNvIQhLiVHtnTo30H3Z?=
 =?us-ascii?Q?8rpiTj5kQbxGwambA03hiMg0RMLIwEFCMgAl9YhvfhkJjY9jKnil/6zMBfoJ?=
 =?us-ascii?Q?7awIg9Fc5Q5fGUENhA2MZvO1zvW1llDlUYeuIDmx+Lz4wqpXQTlB?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cbbd866-ba06-4b95-db61-08de5e867381
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11948.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 16:01:09.3173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0DZ/FWoF9IID56Q1Siuwl9P0BvNZ+RQs/T734akaU2YIpmX6HPW2wf5VRfGwLFESFEHjAjcTJRuyAFbn8RDR1//UeR/h+6JoyeLu1f/Vkz4d1e5jBtQLLL9w9r48z5Jb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB15588
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 28 Jan 2026 16:01:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21773

Dear All,

This series adds DMAC support for the Renesas RZ/G3E SoC into linux-cip
6.12.y-cip kernel. Backported also commit
e57389d5547ee24b472ac5c8f8a7dc21b063ad73 upstream on top of this series.

Patches were cherry-picked from upstream kernel.

Thanks & Regards,
Tommaso

Kuninori Morimoto (1):
  arm64: dts: renesas: r9a09g047: Move interrupt-parent to root node

Tommaso Merciai (3):
  clk: renesas: r9a09g047: Add DMAC clocks and resets
  dt-bindings: dma: rz-dmac: Document RZ/G3E family of SoCs
  arm64: dts: renesas: r9a09g047: Add DMAC nodes

 .../bindings/dma/renesas,rz-dmac.yaml         |   5 +
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi    | 182 +++++++++++++++++-
 drivers/clk/renesas/r9a09g047-cpg.c           |  19 ++
 3 files changed, 200 insertions(+), 6 deletions(-)

--=20
2.43.0


