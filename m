Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27971C36007
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:33:16 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.69])
 by mx.groups.io with SMTP id smtpd.web10.34483.1741778783021478400
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:26:23 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=JgSZ5bJ3;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.69, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b/aQxVXDnq62UC6z3HSoQX1Wm+AqoWOXXWCswzHA2Jb63MIJJojvy/nTYM/k7acX7swZWchOKkFhY2wLbjIF+jOrawNBCwQht4CBzquVZ6rC1V3mo9J7nKivaOpsEzMn/h5qGk6IzM6Am9sYui4jglF1NQYlIv9gHfChW1tO5BALAptqKuu1Fpy4WlryT4t40diGaoOmdIOF+ewyl4u/1dH/NJ/z5OYE9GN8YybXERe/+m/WR9ILqeBzZf2dzo7TqYzgZI5vOICVQ7FGImMfAZxuxmU0FlYIP4CdK/d3Ymgzg7XmA1w4vG/cRAn0rvW5sS9DdyE7l9wPRoHZSacTGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BA0INZgx3ZTSXWvHgTCLS2tqlmgWRx1HU3j+MjI6aP4=;
 b=ffs0Lrk1toikX5NGNkWvaw1sekSPYwcsD/pCSZTJamp0YHIu/2Dss3AGPB/hHqwcWIpEV0BDRSBAUcLKlxxWcDBng+Wrd7WHnko1TnFLvtIEwAjRFHfNHLg3c6jj/2fs2SHk+pgnvyJwcnzfJEUrCULdC0XjfNzOMiXfNaCGECFcvR3UD74JimzPHB8GM7E/uA5ZxC83+X79cKNXnz6YdnyKzm2blVwkd0+FZzbBVNMP3YwBZk/gArZgsr5wDvA3g8v//cEguYmVzhMVtxOY5L6vwHYUlkgD0c1+HmUza3VquVnUaq8iSdaXTiJnB0fdCfABPAa+hK25Tf41D9W1Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BA0INZgx3ZTSXWvHgTCLS2tqlmgWRx1HU3j+MjI6aP4=;
 b=JgSZ5bJ3eavqToTaUhOMXDbilRFlVhFxYs3su3A9RYIwt2LBrPduffy6RDcPaI7QC80LMvKXvTkWAa8SzJ+m/eOlXiAAqZHz3p9W+26Gfi1Jm14qH3HApd3aqafZz89LPGyGDsFVgIqu5xq6W3B7T1y3f85LVq4DT6Z0NoXuM3g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYWPR01MB10982.jpnprd01.prod.outlook.com (2603:1096:400:397::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 11:26:21 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:26:21 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 56/85] pinctrl: renesas: rzg2l: Remove RZG2L_TINT_IRQ_START_INDEX
Date: Wed, 12 Mar 2025 12:22:33 +0100
Message-ID: <20250312112302.1605750-57-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYWPR01MB10982:EE_
X-MS-Office365-Filtering-Correlation-Id: 107479f5-d594-4f62-b158-08dd6158b6ba
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?30htjhLV1J8v/L6ChusUKX0oUbh9J9jVpFVzeBz9eG6/7eYK9BcfRVKRfVYR?=
 =?us-ascii?Q?vM6SapUJR7zhNHNU8oObopGOg73sg46n+o8ytny4I4WC4Y9zpMrClI9ZiBr3?=
 =?us-ascii?Q?5kINohsdQV1DQUPvKbTCh2NpU7lzwOetquxuuP7qMqYa0fdV5vFPFQ44nLfu?=
 =?us-ascii?Q?AMn3Q2aa7R8Kzyj4f2mOtwfdEIXgb491bF8DJ50ypEqQc+w+QUN6N4acZspN?=
 =?us-ascii?Q?2SwCCqe4M6EcHnbw+UL1vIx27DnfWKyd12hPakNqjnFQbRLwbc1vOgRVS+y6?=
 =?us-ascii?Q?UDvuoGk+tkTmnCPDiq+0VWWPRoDOErADMl4cXyc1niGKznZ4xvcGxwRoKIWc?=
 =?us-ascii?Q?vikfmXAwJNgza5Y5btfOgV7mggVB0KEvyzryORSdbh5jUm82d44+WU+5WBmp?=
 =?us-ascii?Q?eRm5KuMUQqfakPlLnLLiJ/Htb7GbwgJ8Sbd0aFm0K/nXp6Pv4/t/Igx+FKp7?=
 =?us-ascii?Q?umXx+1IVcbSCPEFH5FA5T5Xh8CkYjeLDKv1dE5CltPk/a8TLgnF3bRWy2UN5?=
 =?us-ascii?Q?g468VVUR3KZ2Yr1OsV0d+rVbQToBe9LmLqiP6m4lVkJFRAXMLuh/kIQCHtD7?=
 =?us-ascii?Q?Ecz6vlYL/U95+zT53iBF94SY4VsSHU73h6s0gIQg/B5yXKe/+lxqsJ+Tbv7l?=
 =?us-ascii?Q?8JMsGSs6s2PlZvgSGYwsOp34+T4oyyjsMwXN8IaqpjgXuEEBMMQLexLL6Z31?=
 =?us-ascii?Q?fIprsA3BhnS450z5+F5a4n9tiE47U1V9x6HxYzcqg+g7+4JOoJRXmMMoT6Gg?=
 =?us-ascii?Q?oUc1VcOJzmGP0lLxFDqG8/Q9mNeZwfIMlTzsKTsafo8ACBbxWLZCAg2X37pw?=
 =?us-ascii?Q?KNkR747Dearleqobls19mjIub7C1Dmm4GZnTqCBC1excdht/3bQtgindaRlL?=
 =?us-ascii?Q?L9VODciuPL4XPyl52AeoREm/LqdaTnRA2MPbiUFEQLlk7UIBo5/cW7He5M2o?=
 =?us-ascii?Q?zuj7qoLP/dlGJEozELhmIYWkKb2ej6UXiGVxJh7AdZY6j4BFkBYJg+GFnoSh?=
 =?us-ascii?Q?2YBH0w5P0TL62vIEDZTCfmM+w6CaoCYoIhsGCYqGm/rJM/iKy4cT9/J4xcFJ?=
 =?us-ascii?Q?EkXPeM3fzX+t41oV22cUSWNe47cuwlgIP/PcERNvsxLIjyfdrMFGGffOg/FO?=
 =?us-ascii?Q?TLuFUalydJbXUMh51rYM1stKdivXtBIGbnbfGPQgeKpZWIoY+69R9G9XL5Ly?=
 =?us-ascii?Q?XmvYJz3ScCgfLNSw95csu6m+mRMeftmlCASgHeMnqJGOMhI9C1yI+edw0Ain?=
 =?us-ascii?Q?zRVf62UPL0u+t3AKTb6yDNP0Gm9SrzrSwZ0j2KKkLS2x++6xzAcSNeike2q6?=
 =?us-ascii?Q?J76Y0qHFY+7C+n9vOn4QTJNme2kPdmpdoxLLACJOF2MvzykyIPHuivsDliIe?=
 =?us-ascii?Q?6xt2P3svLMsKTXcXkEB/Fkjt93SG0ScjoHUJb5xI1kRnxzGLytr0uhvW7zDm?=
 =?us-ascii?Q?8Q0G9xv7JddU8W4YXmcp5GPP9T0SwlvO?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?OZN4PTqFK0tI4jNUJhmrF6BJtP8oYEVlg61Wklj35LqW+q+kocYsuquIVuj/?=
 =?us-ascii?Q?ddEIHaqWHitHBwib5NGvQJH/u0LI6PKy0C+gj4y3jWGxRlDufi3eLVGhDIIB?=
 =?us-ascii?Q?g7wE29aKhrWAQg6eQTMyUqalyiGokCLPWtLlrRlX42uW8cIxIi4sOQdpTJuZ?=
 =?us-ascii?Q?XhUe/iEVAeTBNsGazS0z7bb9MaQP5PbF+1JrU5/m3L/BkrsB/IDtSIfXI6mZ?=
 =?us-ascii?Q?mxi7y5FrGAsEd4e5k9d8oepN2/8JARqfjO9GRCCJFYnxf9i4RFiznGwtES0F?=
 =?us-ascii?Q?lwpeLwChJoNSnwAsXYYA0PYEHy28QHZNczCuHXG22tF2xdQY+5/ENtTS1J6j?=
 =?us-ascii?Q?fS8j5L9e3Jc6ZJtaOXAft2aPJqrww8jeZBnyCI9GAucj9HXaF/ENRzNCtNHx?=
 =?us-ascii?Q?kIJnMkmjWzObdgF8vqLifDbMSNSUw/ycOWS06lKPPaWF1Rhtni2XzhSltW6l?=
 =?us-ascii?Q?p5Af1Py/L1wX1uyZbNA8ZTE9g1TDueCHZvpMyTAW5VfsleJ/NuORKWKUqkzo?=
 =?us-ascii?Q?x8EnC6kW/mlfV/ksZka4or0u/LBF5U0/XYkYgZZ+HIEvtN3Ul0w3xUDKOElQ?=
 =?us-ascii?Q?C8gi6noYfyWKpPUXItNUsgN3siRbSDTIbfxQnF/nsRGHFStb9kSaIxe3RLBz?=
 =?us-ascii?Q?KW862RxIF3T19a0PcYZMyaOSwIDl2v/QaTMMduffVzWUf0/+8UrtV9dzM26N?=
 =?us-ascii?Q?algUgdNpiOj9IjD3NPtB4KEbRk8P15ZQ/YHatjB+cO/wOkPy9X32VhNVo8Eg?=
 =?us-ascii?Q?JZXgw3Yng9kK/iEZTbr+9kxLaiNwuaTO1HJ4jO5BjZJWeCJZSHfRDz1jUjXj?=
 =?us-ascii?Q?k0rrDjoGpIQLDYAKdTv8Xur+XsN2BaHMjdNXrlMlkBxsQWw1rGAePADS08GP?=
 =?us-ascii?Q?4QLIteFyz5w4cRgwHa8D2g4wENb7LVAY4So4AKDF3I/O2bio06y3TyzUNhUk?=
 =?us-ascii?Q?Nx7qFDEiOVpA7UiJgh/BobweHU5NvO9ga14Kx4iM/jyqStB5wZWEl8YjAnx7?=
 =?us-ascii?Q?F8weqgUastn8A9QgJuT6XtTMxUzDZ5Rge0WbXS/gkns0ZZPRF4wAR5Qs+Kmw?=
 =?us-ascii?Q?21aZFwO7DMYMiZCH17CHFXWVySpKlidfW9Mp+n+gyfio4lswdLcEvYmr1qEf?=
 =?us-ascii?Q?zjvbDNKt4POaIKqJbGC72sEZ1WeJnPoMIr4PyiCUy8BQcCqrIZEgQEc319IE?=
 =?us-ascii?Q?VqR1GHMTaMDe6gMFaz9Sn5K8HjSKttwJKLA104jVCqQHaY3NwAKlwII6o2aI?=
 =?us-ascii?Q?SuC2phdpuB68pUgfNo5eh4J7cWHWHggHrXFKBhLExlCUEgAHhUr9GXcbdtMB?=
 =?us-ascii?Q?zSJAlm7hwIuYll8SskIXzcljhkw5a98lTsgS7aWUZrbr2HGrZssS+ou9+tPI?=
 =?us-ascii?Q?Njydn5+hRI4Q3Yr10sMsYC4MMZgRrIiygJpBlPyz0Ack/wIICR0cccRLGIMl?=
 =?us-ascii?Q?DVTL/fnk0I6PCDGYcXXoU/jovbe9nX0CXf0ue9Cw60Zo6x9y6GucLWVPtPqM?=
 =?us-ascii?Q?HHZMJRbFaU5nUKsdVQ82sJ7oX7r95OP/mm/EQPmsPUj7dnnwIG2AqKNOmp15?=
 =?us-ascii?Q?toh6FAxd93UNs7r9/iC6mwc3qFxx4jdelTgWuSEUsnDgfRrL79PpjKtqJ6Ku?=
 =?us-ascii?Q?geq+NTBVJU1l9/jLwpGh818=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 107479f5-d594-4f62-b158-08dd6158b6ba
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:26:21.0436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ABMttA+PJi0GtyeXSYlyPRlC3od3/HKAkTvLaQzoN5u2SBL2Xvhppf0ldnbM6bKCNFSUxd5NGs25uAarwTFUHXiugbIysyrjXoKeYoHUjayhf4SYOxa44D6gN5P3ktZ4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10982
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:33:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18148

From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

commit 1d930d4bf8e68c2a7122a6d0899a99f0370c45b1 upstream.

The RZ/V2H(P) SoC has 16 IRQ interrupts, while every other SoC has 8,
and this affects the start index of TINT interrupts (1 + 16 =3D 17, rather
than 1 + 8 =3D 9).
Macro RZG2L_TINT_IRQ_START_INDEX cannot work anymore, replace it with a
new member within struct rzg2l_hwcfg.

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/20240930145244.356565-2-fabrizio.castro.jz@re=
nesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index 5919a9c441be..4ccdcb145704 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -167,7 +167,6 @@
 #define RZG2L_PIN_ID_TO_PIN(id)		((id) % RZG2L_PINS_PER_PORT)
=20
 #define RZG2L_TINT_MAX_INTERRUPT	32
-#define RZG2L_TINT_IRQ_START_INDEX	9
 #define RZG2L_PACK_HWIRQ(t, i)		(((t) << 16) | (i))
=20
 /* Custom pinconf parameters */
@@ -246,6 +245,7 @@ enum rzg2l_iolh_index {
  * @iolh_groupb_ua: IOLH group B uA specific values
  * @iolh_groupc_ua: IOLH group C uA specific values
  * @iolh_groupb_oi: IOLH group B output impedance specific values
+ * @tint_start_index: the start index for the TINT interrupts
  * @drive_strength_ua: drive strength in uA is supported (otherwise mA is =
supported)
  * @func_base: base number for port function (see register PFC)
  * @oen_max_pin: the maximum pin number supporting output enable
@@ -257,6 +257,7 @@ struct rzg2l_hwcfg {
 	u16 iolh_groupb_ua[RZG2L_IOLH_IDX_MAX];
 	u16 iolh_groupc_ua[RZG2L_IOLH_IDX_MAX];
 	u16 iolh_groupb_oi[4];
+	u16 tint_start_index;
 	bool drive_strength_ua;
 	u8 func_base;
 	u8 oen_max_pin;
@@ -2379,7 +2380,7 @@ static int rzg2l_gpio_child_to_parent_hwirq(struct gp=
io_chip *gc,
=20
 	rzg2l_gpio_irq_endisable(pctrl, child, true);
 	pctrl->hwirq[irq] =3D child;
-	irq +=3D RZG2L_TINT_IRQ_START_INDEX;
+	irq +=3D pctrl->data->hwcfg->tint_start_index;
=20
 	/* All these interrupts are level high in the CPU */
 	*parent_type =3D IRQ_TYPE_LEVEL_HIGH;
@@ -3034,6 +3035,7 @@ static const struct rzg2l_hwcfg rzg2l_hwcfg =3D {
 		[RZG2L_IOLH_IDX_3V3] =3D 2000, 4000, 8000, 12000,
 	},
 	.iolh_groupb_oi =3D { 100, 66, 50, 33, },
+	.tint_start_index =3D 9,
 	.oen_max_pin =3D 0,
 };
=20
@@ -3063,6 +3065,7 @@ static const struct rzg2l_hwcfg rzg3s_hwcfg =3D {
 		/* 3v3 power source */
 		[RZG2L_IOLH_IDX_3V3] =3D 4500, 5200, 5700, 6050,
 	},
+	.tint_start_index =3D 9,
 	.drive_strength_ua =3D true,
 	.func_base =3D 1,
 	.oen_max_pin =3D 1, /* Pin 1 of P0 and P7 is the maximum OEN pin. */
@@ -3073,6 +3076,7 @@ static const struct rzg2l_hwcfg rzv2h_hwcfg =3D {
 	.regs =3D {
 		.pwpr =3D 0x3c04,
 	},
+	.tint_start_index =3D 17,
 };
=20
 static struct rzg2l_pinctrl_data r9a07g043_data =3D {
--=20
2.43.0


