Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABE7CD6E45
	for <webhook@archiver.kernel.org>; Wed, 27 May 2026 16:14:59 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.24211.1779898495679625687
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 May 2026 09:14:56 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=wP+QRk+y;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.41, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VT/aMu337pk1YBQ+MVjdacRGNOZC5j5b4J5orPUdyM0XufIfa5LPvHFJm092/3Y63sYuqDTHwcMsoPuaZr5PUHenHoNS/IY0sFyap15sSyh4UFdzMhMqSQ5TMsfUVvHrs92FsLyLLj5FQB9qkICQNuNvTJRFcCO4wuvwuh5crq4jwP1vvyZMreqgV0EGJdAS5ZKBB5g9Qw0wbBucVjDntw+X5ybDO5pL/41hzXtR+7Bfl1+KN6DGj/nNektde7oRA4bj8oei/ty10LBmDdLPMIhKkhHW4nO88hYP9ZCN1e4YTZBy1ZAMeNewvUauycQeHPC0p25G/m8l7WO3Zz0yAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1KkMJzsvurxHiyoNz//FQLS7FR4IKa2Xx86NRvZObPc=;
 b=irXFRqis5pIXCqKAhRvanZeAy2QiAhEeTUq1KY8zwE9Y5Jz8D3QRIsLbyjv9/RNuEMI7jDl1Cl4azkwM2OOjllpepcaMFsVb9AsKL0YR5/vBiMGVA/jUtx6L+mwfu848U5kTxKw3W4uV9Rxj57m5ATfDOJ2VYWCBfAOXLNskjXF1yMlZ4lr87Byb1Wixi5UgmfNAYpIuu9N1a96NHmEHrspxwiWWQI5qeLkLX7tSR5CJ0vzpnIz3maqrK8trkF759J/178bPXaN3HsxPSmA56EvPRBD6FRfcPhuT2aID+B5oJRgFpO1BUVYuy8T4XFEBSgn5xHBc4p+74G5RFxRQDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KkMJzsvurxHiyoNz//FQLS7FR4IKa2Xx86NRvZObPc=;
 b=wP+QRk+yI98+gvCsdUCjcr8AyEv6Kundp7pcE7yzmYVXDAJbiEXvGDKTgX3DzQrk12nbTI6VATswZEftFOG5+GZWHLmGF9dyomfZCnu+lEp81X5J5I5qd1F9IpdBnXdscPWUvawvC/dhE/eKqASdMufwfAxN7Rxycf0cOZqbI6g=
Received: from TY4P301CA0083.JPNP301.PROD.OUTLOOK.COM (2603:1096:405:36f::11)
 by TYCPR01MB10037.jpnprd01.prod.outlook.com (2603:1096:400:1e9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Wed, 27 May
 2026 16:14:49 +0000
Received: from TYO1EPF00005020.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36f:cafe::82) by TY4P301CA0083.outlook.office365.com
 (2603:1096:405:36f::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Wed, 27
 May 2026 16:14:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005020.mail.protection.outlook.com (10.167.240.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Wed, 27 May 2026 16:14:48 +0000
Received: from Ubuntu-22.. (ree-0065929.diasemi.com [10.24.0.181])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 9A877300025E;
	Thu, 28 May 2026 01:14:47 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 0/9] i2c: riic: Driver enhancements
Date: Wed, 27 May 2026 17:14:34 +0100
Message-ID: <20260527161446.48789-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005020:EE_|TYCPR01MB10037:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e4429c1-07a4-4919-e745-08debc0b136b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|18002099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	VnHWPXSur5s3dd31cA4bM3o7Cfsjgt0a6xFIHcn4R8urgGmZgHy9Er+RYpLiET03cqnTx/jSbSuX7+CICqG+Ur7fKPAvAPBS2mWYttGnZAUOTcWcrQm2S/vV4Qum6CafvbCRb6GxQ5j4tDQza5UwuAOg7gZwnuhjDAko6qpJTFIUsU5ADuydbugnDgz4rt0nncZEbG8Tjpw7KBBLUFEwQLgppgD+XxCHlTMUhDQD5FBcRWNwwd0I+OFLB0ICy7WT2TovvpCNE2kenk5yNBXDj6krek3Cq1DD7SMBCrrwAQKahJiP0jlAKzW1fmYt1tLKrTwN5uHcO69rm6wCWHASjqaCYJ6KmAhOH/y23ebUfW2LLPQYB3gkTZMSVRURUhTUaYkr/Vbdk4JoMztTWag19uclhyTLP3sFnMsszIkg8R5IL1o+6xriPU1uZXU8iMhX5A4pJhZZ6JbnIalTVkrGXa144Nkrt7Cz9lftq+aip9nfDzVX6Y7ElPBH5lgQ7Q3PiiBWHk+mVT0/7k2grmYgeZTeHoW9b/T2MzZlRTgrOXgEBrQCvdkJXCMYUf5pHw8Les+fkU/GpPtHDwI7DvPezPiR/sq9c5j+v/eSbSbOX1C2LuwN1d6m0wuS9qXYXVTDSZjl87qRtqCVaZM0kjIUuE67ruCyP5Unu5fgDZscGaqg67uPCUza1GxJd2hGP0NkI4wv7d9ptW33/TDDmNsGV4U6ME+wJd+/zyj4HaGsXpw=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(18002099003)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	irt3mkQ9lJj3wgezjrPBJ+kbYoxX2hEPjRm9b0vaQmMpytw9OV9xtSoCYoiHPx2WJRjz+vatbYEmGEzqMhEl0OyEuVQLkQj2raIGO387L2uXlROpuNTp0kffFflsCuUu+ZFwESsmRAN7CmZDZNQsfSDlTwkEq9LM0g3zRU+B4Tyoqf6RNWaaI2QRKRi45eTRy3btA51ekNzBvQlMN2RVpqi03HCxAq+0SWPcXxJa/WASCVY0cvqJ47pe0GwTEOvPzvy6rIGL6SbHTE/5EiL0JJMYMDfwFDWs+0b3b2H7bmxjzKYV1pghjF1p8HuznGtw0bXfGOym4P9nbfPuVsp8ThvN4ECmQZvHApZdU6POkSkBjw1y6poRtA6o84qNxln24rCgPxFrT0i77L/g0dZFEjFVByZwK62D8GWpCDfNIEpa0N2iEaH3tSOixI9iKwnO
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 16:14:48.9187
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e4429c1-07a4-4919-e745-08debc0b136b
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005020.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10037
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 May 2026 16:14:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23015

Hi All,

This patch series aims to add I2C bus recovery support to the Renesas
RIIC driver. Along with adding I2C bus recovery trivial cleanup patches=E2=
=80=8B
have also been backported.

All the patches have been cherry-picked from the upstream kernel.

Cheers,
Prabhakar

Lad Prabhakar (9):
  i2c: riic: Introduce a separate variable for IRQ
  i2c: riic: Use dev_err_probe in probe and riic_init_hw functions
  i2c: riic: Use local `dev` pointer in `dev_err_probe()`
  i2c: riic: Use BIT macro consistently
  i2c: riic: Use GENMASK() macro for bitmask definitions
  i2c: riic: Mark riic_irqs array as const
  i2c: riic: Use predefined macro and simplify clock tick calculation
  i2c: riic: Add `riic_bus_barrier()` to check bus availability
  i2c: riic: Implement bus recovery

 drivers/i2c/busses/i2c-riic.c | 172 ++++++++++++++++++++++++----------
 1 file changed, 122 insertions(+), 50 deletions(-)


base-commit: b1d0cf5ac0d2f6deb7687dd190100cb8423d71ff
--=20
2.43.0


