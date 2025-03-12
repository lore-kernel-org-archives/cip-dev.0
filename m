Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BEDBC35FFF
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:32:55 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.63])
 by mx.groups.io with SMTP id smtpd.web11.34799.1741778674151300535
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:24:34 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=hSoppAjM;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.63, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o5cHxZWFg1365mmE9n3MS3bEHbDv6dBw0oGGC2Ux5j1jQXpMiP6hvczOoVn//65nInZQmgIiKWpUFrhnPlRl6ACE1vQYtYdWgzwDBfFbJCCu4d4pYrrzPeMnNv+Dok3ug5i0UM1UKIuLT3sSiEIR/ibLjmVvY2hZzFJ7L2cYWVD1NnsOD0Xhj4CSIISypJQsGd922cTZY348tQ+3ovPG4wz0mtZynOA8pSfyjZQylbjfddb48JmLBR7vIFkItcNFofbCEcZ0WDx6H8kdOpUoUyF3qBgZ/r3hPlGq7Mi6F5hRvaLUwrOZ02Ez4wXKEo2LIfPRMJJmyTyiiYDcHiRkkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PlDd70zXgWsO/Uefmgxmn0DCFw0XgliXbTzBGsL8YM=;
 b=ZuNZCqXE9o1MuJJ/FByNRbxuUnh25FpewN2hvOPDS/81qS6XGJFDpfK2OY7jDb1pXBRtkSqasQF/QudegW7dT3WWmz44rU8cgEmZ9Vzi6Oc/FLrhB0wIwSlWqQsDyY05nA1hiZHcdVmykc25K5P3kS8Q1FG0nO33yEuS9UgX8vsWWUemvXUuLGyCObaOAdIRIYroCHYomFSZ9NYqNL56VQLPdixNJECusBvbuh5pjjP8Fo1craczxP5brc/d8nV0g0hgxCK9o3BO0cRgrsIrWN2NDyDvljZuKJR2IH3Lih887x8rzjhPxM0kQOnD5LPq/CwpW7PpEXbVJhQx1IB5bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0PlDd70zXgWsO/Uefmgxmn0DCFw0XgliXbTzBGsL8YM=;
 b=hSoppAjMcTI0rXVfcqnY3lx+gf/CHAUDhj7l6E+yuszLpYpzyh1pm6Q/Wj8Hr1F8N9Sr2EMGD8yVWG2/AJ1pUb8IleiJBAxdGSkfgK8iF94OqDUbC1gc8WCv4+VhspmecsgznLWcxptHoxHf2HmfBq4hT/TgaP8oIoOxL8XdnVg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSZPR01MB8767.jpnprd01.prod.outlook.com (2603:1096:604:15a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 11:24:32 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:24:32 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 19/85] arm64: dts: renesas: Add initial support for RZ/G3E SMARC SoM
Date: Wed, 12 Mar 2025 12:21:56 +0100
Message-ID: <20250312112302.1605750-20-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OSZPR01MB8767:EE_
X-MS-Office365-Filtering-Correlation-Id: edcc087b-1225-4383-e2f9-08dd61587604
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?uLlA0xTiwoJGcM359DScvXXzkGUYCS9T7o0jnYZ7sYmPSFk34Y8hU1dsmTSJ?=
 =?us-ascii?Q?PhOYVPJunlenGioxjMBY0x8zYY9iTg1/gtXq+SDf6822PMNQNoMtMPgX1Esz?=
 =?us-ascii?Q?lxyTQaTyyQ9J8s/6O0cyBRwpz92KOSzv2yiDIpfSo6PkLIgdKVn0mAjzxZ1+?=
 =?us-ascii?Q?DcHb7t3rxiEpfcj+sogSKXUOvfNPzlhRXKyz1bKLqIkg9QkvftWLC4FhMON7?=
 =?us-ascii?Q?Sko4IJY1APWyCe+6UAkLGJ4w0f3+nBcpLRm8Jjdgr3HOeXOPEmvfE4A3ekUF?=
 =?us-ascii?Q?n8HsSqpkkehUDAKaKXjY7bvJ9WcV4fIGcz29Ms9v3xvuxPIND5WnpfdMlxdP?=
 =?us-ascii?Q?RLDfs4iFrz3KbzlNGexrQ2HKOWEv4AVn+icl8BSAYBM+jpXsebT0KjnXGV7c?=
 =?us-ascii?Q?82p94+B1RDm9nMdMAHDBdiI6yDMHUDeRJMJsS4z9RRsSTwO7msgPi0pr3R90?=
 =?us-ascii?Q?ZFmTzdnZOjAPgIfy3vINWdZ1wK+87R/4V8TxJ9Er1VmSaKupPq64iqrw4Yy0?=
 =?us-ascii?Q?NWT1JDw+I8m4/1ImS6Zk34iq3fBnIPAqMv6LWn3Ab1e2skAUnfrhgaqYrQgy?=
 =?us-ascii?Q?oEXvKMLawS8nZDZDwS2Uzh7KcuqyIs2Wx7pCWrn9VXdxHGRFUtWwV56kaMn+?=
 =?us-ascii?Q?D3mhB0utuRJEmb9yd433HRrcHxTLTOHxkDWiuF75NLm9/Zg2N3lg6HJ40zzA?=
 =?us-ascii?Q?uvH8zL/7moQwh69g27w1ZxwCIU/v56v3x7i4Hy9ERKez6SbLE3sqJz8DGHNd?=
 =?us-ascii?Q?yLYiUN8wdAGKLw+i5Z1mAV8D4L6P+IpghQuCcnvyJ52H81f3YgVzW/pbYNn0?=
 =?us-ascii?Q?6hNEpv457wm3EaefbwFcXwCkAm18CX4d34Tu4S0RSHwe67Oeqy7ai3jUpd+V?=
 =?us-ascii?Q?CO78wP967MyUL7kaMfnkRljB7pbF/8wtdZZqkug5sgLIF2nIw1iBTwGX5B5Z?=
 =?us-ascii?Q?mHWXuha0tMPvecul9+VRZlQuGABtlpRD5xkf99KV0yHhK0gKlS7hgnDA8hAl?=
 =?us-ascii?Q?Jq5KSHIkbpzBPY2oa85DHuAlUHSK1YPWv6GprMlpNwVhqVWHgdRm3Im+LXoJ?=
 =?us-ascii?Q?dUgfe8OraPaYgMZzj7taODOwmOYNvbg+iaw/E9Y8hIgwmIra+XK7XIZzEjm/?=
 =?us-ascii?Q?ezjfpv2zEX4/TRUbChrZL50zi+WbFewaQs1FsQNWkh+JoGszovooRiSoLZJq?=
 =?us-ascii?Q?qkhV0+wWxuCXyFIzENqHa1CR+LOWSYGL32UavmK+nN9Pis60TlXvZ0qt1Mkx?=
 =?us-ascii?Q?xv1fG0/roF+YiSDX9LDLHoeu8ARbn/DB9yr6l5ti1KM8xLZefbShkuSYmTyL?=
 =?us-ascii?Q?9HRp9y1ZsIR8D9c0uuJBzn57WVKqoKn8XcF1Vi8h9EKqkbPJV9h5RqbI+lYb?=
 =?us-ascii?Q?bROvNmvpoAV5fu8XQlyNjp5psAYfyKRQDpFhzPaOTBfKAhDvUm/fNIchiH/c?=
 =?us-ascii?Q?d4H21s9FgbipsPgnN2qyAwkYUTqbf/BH?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?448CIOBz1ry3Z0BmdpZwT0xCT5i8DeCcf5ev/GwJ+vjUyTQjUZeINMV4yVkt?=
 =?us-ascii?Q?PfpPW9xeBVrhuPkJ/Sd0TZUBN2s6FPaGmzNAYhNsGZZRtQiuWt16Q441Vhsv?=
 =?us-ascii?Q?KZxWuw9oQDY85z686VA0xT8HoicVkwomtzT4s1mPLoMMcrZ4wMrnc/vOLRXU?=
 =?us-ascii?Q?27HC6QeeEWnXj9hMoBQ5PJ/qCHC8HUTFmuZ3FCDO1Sfq1vAaggDS+lXY2i5J?=
 =?us-ascii?Q?peuEaShlxsmIpnW7Os49NvzGhN4q4V1D/AViDTGGMvREPl6MU+UFgcQmlIbE?=
 =?us-ascii?Q?GW1/t1u2woKHXZfuwKnh8ApXh/o48L00bwUrZ6IU5mI9Io8GYw2V2khEFfum?=
 =?us-ascii?Q?J+su+k7Tp3UnkQfCKtKYfQu66jPf0b95T/RdxvOaT2sEXMKjB9V3ymJ7Lnus?=
 =?us-ascii?Q?HNe/L7fAAFB5XBcgl67kVDPjt0CEjMjCd4E9xHTJZnSrMxm71VCCgX6Wf0R0?=
 =?us-ascii?Q?bd6oM7Cus2tZxEKixtdsVNrm3crvP0dwyLNZXUMScDcaMEyChzpG8A9OqGGg?=
 =?us-ascii?Q?6nETAb0+SIf/IaRnKXbe1/8fAjw4y9bHN6YHNpAtQyP9qRhkZ26XJ+XI6n8B?=
 =?us-ascii?Q?RfJcAS9xmQPII00f6VztMiq96xq+kk2PFv85twOGZfx+vGMNRt1vzm0hgWjQ?=
 =?us-ascii?Q?aAIWQ+Qv14jlRWRK64x5v7fteETPVQs7e2pQ16zchUAu4jCjSyr57x2Fn6+X?=
 =?us-ascii?Q?E3khyhzi1LNBk8XQapc4HCZObi4uBFGKXvCIrOb6J25Tjth8YjRN1MtuU9wN?=
 =?us-ascii?Q?ASrvtwn35qEsclhnLDApwuzJb7UFlfcmcZIIPtYbdTgCYvUnyBKkq4ApDOyG?=
 =?us-ascii?Q?qyzOBTk3m+AoCOpCg9AF0/S49s6MHhYWMwCj9sqUJ50NFiQbYYybYmKx9UT7?=
 =?us-ascii?Q?Uzix40JujQ5zQsp4qIeUSf3uJbmHr5lwaGfx9dsP5bX7L/CWY7UdssvvFm6j?=
 =?us-ascii?Q?IrJdqJjutKfo/nvz8qVbFYYyOnMQFVNOao9TMPrsexBaMPg+iVs8pt0zafzq?=
 =?us-ascii?Q?D6+sezJYl5hn/FogfWj5prJZ3ldmu16h6IMxRk5K6vIL3a6zkv5JauNdmcdd?=
 =?us-ascii?Q?AKigon4ZdgJc8zqNrWDMTgFGNQSgUHI7B7g0GY3VHZMB4Tnnp3b/D6BMaxTF?=
 =?us-ascii?Q?cnWMu60CryNGrml21YcxfI2nGgbafItlaLYuvXH4ITUgCASAW6OpjUP8ajNW?=
 =?us-ascii?Q?CtBRU3jIrmYfSpY0xcmyOG+t+R9PhmHnBKsbCF3+re+vRav9ybsjZgzEHGAp?=
 =?us-ascii?Q?fTJ5hEy6MqR3rcXfXz/bd5MCMy1ya/lKCtVydXC7JlUPALO1A8Aa6ocMFEJO?=
 =?us-ascii?Q?STu56P/58bzRkpYFypvSmOI+LfsIp/ESXEUi/4EheOwfX+pzpv1Rqskhdi/Q?=
 =?us-ascii?Q?HfgpiF+6i7gsyXVAqly0kyS1tWqLllOFoyfHPQMHLQswAIMNEaceJGSn3CfU?=
 =?us-ascii?Q?VcqKB1wme8C2yeX0xE1NWOD9JnzP4nkhfMe/5qkrFefyyDuW0gqMl97hO4fO?=
 =?us-ascii?Q?l7oWhLXN6ZM9wlCKegTgJr3tDuJuJXDCSnXYJtWeZ/a2tCp/xM5iMyPBCP0T?=
 =?us-ascii?Q?hYHLmdVKFFQm/LaBpfxAFusU2c96xIyG8I+7q5sD8Ez1ftRRCmFW3qubCykd?=
 =?us-ascii?Q?tmHdhGmY5mvZaCvaWFr+8vs=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edcc087b-1225-4383-e2f9-08dd61587604
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:24:32.2576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dmji/K+pyKFwpI+Q+XweHIBk5r0Li29GUbBe3sAKty44gSnjD/M9+U6Sa4Nor+GLibcv3p1Drz2awC95h6678c6hXwm78DrhuRo4gweVo2sKl2kSupTHRFweN1xduEGj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8767
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:32:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18111

From: Biju Das <biju.das.jz@bp.renesas.com>

commit e0379695728b0d79c20bc1a904bb4168d4f117c0 upstream.

Add initial support for the RZ/G3E SMARC SoM with 4GB memory,
audio_extal, qextal and rtxin clks.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20241203105005.103927-12-biju.das.jz@bp.renes=
as.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 .../boot/dts/renesas/rzg3e-smarc-som.dtsi     | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi

diff --git a/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi b/arch/arm64/=
boot/dts/renesas/rzg3e-smarc-som.dtsi
new file mode 100644
index 000000000000..6b583ae2ac52
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Device Tree Source for the R9A09G047E57 SMARC SoM board.
+ *
+ * Copyright (C) 2024 Renesas Electronics Corp.
+ */
+
+/ {
+	compatible =3D "renesas,rzg3e-smarcm", "renesas,r9a09g047e57", "renesas,r=
9a09g047";
+
+	memory@48000000 {
+		device_type =3D "memory";
+		/* First 128MB is reserved for secure area. */
+		reg =3D <0x0 0x48000000 0x0 0xf8000000>;
+	};
+};
+
+&audio_extal_clk {
+	clock-frequency =3D <48000000>;
+};
+
+&qextal_clk {
+	clock-frequency =3D <24000000>;
+};
+
+&rtxin_clk {
+	clock-frequency =3D <32768>;
+};
--=20
2.43.0


