Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9921EC35FFC
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:33:05 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.17])
 by mx.groups.io with SMTP id smtpd.web11.34818.1741778709308065634
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:25:09 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=VKikbhkL;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.17, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EXAqu+i0MpSCg9Q9ku0Zgqx+cEovySfQ+WosJ7wkmY7Oj/B/fB001tHcfjL8ShlnKSm8SVEYpwOaqZBScxaKvbuI6IZoAHLzizBGzairl7nVl1PeQO3otulSdxemoSjAUdRq4o374zgFo9pZyDibcYKvbhj9ArJ3gHt7+46/GDS+/PBzXUMFO10haAXG80T+f0I+EUl6w6VZqIogi+WDJ6g+HhPbFNL2cgIJZMb1hZY48PsyGM0TKiLrQtnLntOCCKqY/o/bsiIJqdRKdSJ38xE3E+D5mwj8IAFM6d6z5v+IxznU9xHF1GtFnJgIhfAxrfa86W3UhrOVgLqCIwU6zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zyq6cj90zx6FSV5y20BibsI15bm55kfLVBHiAvJ4jJ8=;
 b=Ke23m2PlAPCmX0glhJVeFszC8KhaJP8dlaH/DEUJfgSe0wqN0JmVtdpN1aqm3zSPvwJJS1aZ8bL1ZbQKIr9T9Genu0VwUl+oVtoeMJkwYO/WPEgCeEoR6XCoALmCBav17frP6uP3KYFJ6vCKImvwGrkXSsZyEKWrm9qxrnQtUUckScMSQc8tvjtvGF+vtx1kww403x/biGc22dR0R28IyU4rF8BJuIJvQX0CWBtChUNEw4E7bSgJ/JYMMqBgmfK1dVNFbdauHtiWhbvGqO3vOGHBbbbP6dqXkRhUz4olTvG//DmbRIFfQPwaWBsJsjDI0cwMKAuTQFFK8rp07kNj8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zyq6cj90zx6FSV5y20BibsI15bm55kfLVBHiAvJ4jJ8=;
 b=VKikbhkLxbQm4SA7UMyts0wQdbOS6RXeEnKivKsTdxbpbI2f5r9fzVMnmDgokLy3jQh23xwp2wzc8nGEremLERf2NPgcvjlfUG4LZV9foQGUkIsU/TgD8XsjFeu8XbdD+KpdtYC/uZjeD+uiLEWXpxM/XXzo+fsPh3EEeCeUiPA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSCPR01MB12752.jpnprd01.prod.outlook.com (2603:1096:604:33e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Wed, 12 Mar
 2025 11:25:07 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:25:07 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 31/85] pinctrl: renesas: rzg2l: Enable variable configuration for all
Date: Wed, 12 Mar 2025 12:22:08 +0100
Message-ID: <20250312112302.1605750-32-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OSCPR01MB12752:EE_
X-MS-Office365-Filtering-Correlation-Id: 827c8dd0-43bc-4fae-dce5-08dd61588ada
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?X7QPli+ldHhtxDJGpbYENWYzCb02LxZjhsBxRhOTWC19eiygAasnraYiK3ZD?=
 =?us-ascii?Q?cctvHV3Ld3UDFTUJMPUhZjHhQuMcZdMrqSxfVV3aDYqOq6HzIqKQWPaaDkSO?=
 =?us-ascii?Q?1gMEMJVDnlC6uEJA98ARxf92BE2gOEmk2qWlYnvPCpXa//JJ0TKnp0F09TMy?=
 =?us-ascii?Q?WbvxoYoIMWWmftPtPUngxnQYSSRGMPnt2K307hAiYjHZwV7rshs2bsdUYg2d?=
 =?us-ascii?Q?b61Blk25+8gcy3MZAsHkeCl/6C8J5d4X/11aljSOLb6yAZeQ12FqNKV/B97Z?=
 =?us-ascii?Q?eMAq6vsxXyQxqc1tfKohfx4gNLktMlaDC1mvBWboFDIQQqk6ClZdpLFq4e8L?=
 =?us-ascii?Q?2VdmVkuvvYfN0WtJSK2qtQHYQDGjXd63GhowKJQs51X1ixNTrG6DsJkwKFfn?=
 =?us-ascii?Q?eYvlbMq3XSjxyg5DM1J2xgv/18ehy+ZoMA0N2eP11CcYbCUDVv3zYnxi/ap6?=
 =?us-ascii?Q?ImeUENqEGxZodGuT9VZQCabiZnhzylTYjdkMc+VZogsyjy2hGFADymlRd4hA?=
 =?us-ascii?Q?Fk/vRA9oO8Ji27buYwUTZ3Xz15HFUWMpdM4jQurx1Qt1QSxEhQmILeMwq1jS?=
 =?us-ascii?Q?GPVZLZYGm4VGrRn2JWbarhW6WbTwIN01cruIY+GoERNL5tm09N7aCL2rZrzP?=
 =?us-ascii?Q?av04HRxuq1iG8VYNOyVGDi9a8DB2/6s6pb27+BqjzBriF4/P1/YEKCRKnx51?=
 =?us-ascii?Q?e5m7VDU78hyw0o8poeh6ltGsdGVUzFtYAXuOjBGY1HUiHDKzTFbEs1edl8CY?=
 =?us-ascii?Q?vPVg8ePgHls3aEw4jQ27RCPzOsAELvd6wm16/0cGm61b30iDF6vlvhibCEPo?=
 =?us-ascii?Q?/oe6hkh4ZFZ+ER2bJSq9Kwq2oxLObsWlneM7vPWZV3eCltIjVQ6SK3kVpU/o?=
 =?us-ascii?Q?mMfLNVQanRtllFPEqxnmt9DKgDkc5oCM0JAjuSCQ/IaOAv7WM+btL1V4IisG?=
 =?us-ascii?Q?DISXM8qMH/h5mp0tSgGXNpW0+/hBV/QSHKfDjLdWg62LzidNaCW/O6FUQnHl?=
 =?us-ascii?Q?Wm6EdxEBGa71OqnWjHjEbRLR5nzIJu0ttVNQNKL1GFwgmWKnwzfoBMYax75B?=
 =?us-ascii?Q?FVjbE1KYBcPkTbXPJNDuOf6UkuO+QEXCdKu5Fj2MsDnZQ+VuIYjN6LXkmPLG?=
 =?us-ascii?Q?8EX2giL+4wHKD5dmjeKL+wxMI6FQRThbCfSxCHWPA8ExduYLJVaxlAEI4C5T?=
 =?us-ascii?Q?9cSZnmQqwcUU9CtoIF/I7RfMq8fApEgpOhipoW993acVukasBYnprD4iZSs0?=
 =?us-ascii?Q?Le2PpcSDTN+yKnkAsRWcc2Ke2+NwJBpNwLgnYuPcFQUMCgpbtlw/Bjs5h68C?=
 =?us-ascii?Q?MiOTGozK6PbcUCfCQ5CCEbPWyxwrZ+yaJ0JkDq8auuzAjpKHVeS4Q2GE89X2?=
 =?us-ascii?Q?W9QCQJuySp4/1yzlO+/lGM9BtVE/K05SBIJklYkpqJZn6wYOCVu74+u9RJCt?=
 =?us-ascii?Q?/t3tphMCcslzQPLQ/YiXbFUS+aFUOm37?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?qGA1IPbRiIQkqD5vr7W/Juf0WwzZRHtbWLAhgOiae1WuqVKRXBQTdgqT4o6n?=
 =?us-ascii?Q?f8BvT9cqeOnqfLFkDIF8aJOjoi14D8Dvx/LGPXq1ue/0ROnAbH7K+eWcTiFf?=
 =?us-ascii?Q?0+qxac/j+zaVNtZrexWzy6FPlhVx63vLFTR263p+GccZh5/C7VXdfTjLmpYQ?=
 =?us-ascii?Q?hcTTGZM9/WY7q/Qg5g1j1XrBdR+FXvj+Ext0rh0ellMvCxZDn1V0rJxKX7Uy?=
 =?us-ascii?Q?b8bn+UGifecP5tERnFyXhtRrjmvxT5zk9CrsHI6sCl4iasY7ruJMuu3vohUp?=
 =?us-ascii?Q?1Fki9Zom6piRcqPl91JyZn6UDD/U0LTHUPWtyNr1FKxpnbFFllIa5eW30COG?=
 =?us-ascii?Q?pThe6ZtYiGDyUX2GfVq6LqlHqm4BrEuNgCs0IRc/SbF4HmDmMEZzwKdORtcZ?=
 =?us-ascii?Q?NXYLqQD4FntdpZZM0bxYuBknh1uvRO7d7biCEyYM5gbk4WbtO9WYtjo1iLbe?=
 =?us-ascii?Q?mbbw+pPvp9nCdXUMCDncco2hO3sdCr7Bno3ryvTg4v+Xq5P4MywMOMhZNAH6?=
 =?us-ascii?Q?QMtfhU2cY0eb5lXGRq07cQwOXLo+/dEuo4+oAlhapNTXh7958MV61ePXJ5KC?=
 =?us-ascii?Q?XVRF6cmzjL024oXInWoD6UQH64pb83o6O2zBkPUixStRPtxsQpJqeZmA9UZG?=
 =?us-ascii?Q?R7CJqLUCz6U4Plqc8bdav0eTWB2wECTCv8u9yeVuINFyLER4FLRVr1X9N+1d?=
 =?us-ascii?Q?x7rbtFvpZiSUYirDaBZZq5JBU3H8A+MiOSjb2+lbPk3wBkn5ZH47BiJFDIhD?=
 =?us-ascii?Q?GvjwJPCoiUs/j/bJt34YgQho/XBDwZhhKn68qjBj5XNUicxDG4jdgjOvkVgK?=
 =?us-ascii?Q?56nSO1J3HZecv5hzryCETPqbQdbf4GIHHwQXWAWjrdsuy4Sq3YThgtw3iexz?=
 =?us-ascii?Q?ukHwNRH7OoJdP6b+fDyEK7t7ev7wvnTS3u1p75TqlrDe/piEhrfa/xDp8mBr?=
 =?us-ascii?Q?eWnfe2UHYdLJf7VQbDmTlciWj4TjPcm10CPBevjGYkDrum0p31+HRMNzHTjs?=
 =?us-ascii?Q?vqZX0+3832B2XmDojdXX0R3guS+k82SsSptwe3CZMI2G59aOXw8pHqLNWXpH?=
 =?us-ascii?Q?2CjLxWnS8BnUdn4JYVlQt2o6P/bYV0ONCtcjn9Ct2Ch5ydV9NIAqU5VDt4BV?=
 =?us-ascii?Q?8FKnNbJRAtS6eXz7b89Ns75LQ6bBzSXicx4GyGeefn3c0BNvFK0SVkfBNcYG?=
 =?us-ascii?Q?qlxGWh5e+R7HqPUl/iGTbMPIuhAvagHx2I/rXZJRLtsog3nL3d9jQEgSus0e?=
 =?us-ascii?Q?dQYb6QrzVLXBP+d4QqRJqn8qR7gWI9juqNg74c/ltIFeAHPnJjsapvQCKuno?=
 =?us-ascii?Q?1amFP8rF65GcUkjQwTE84Pj2WOrNYpewplEc5Qam/Dme8KJoGPxlCmonOYr7?=
 =?us-ascii?Q?xqKtZsdRK7IKuhFLPM/i6TYK7Cpkp9AU1Kh5wGW6y2JEtma9/uZv8hxaZgKn?=
 =?us-ascii?Q?aNlZmA2YCeFJ/pwuboOC3wZkp2CsULNtCA5W86kgtVwFxkcdw0OcVeG+VDCt?=
 =?us-ascii?Q?GqZIO/zJbBtKprXJ7iU3Ue9TGRuIi8b6TXWMXY1+pLof2wXq1tREQftduROc?=
 =?us-ascii?Q?HaSJuSMKqYUBzmGNPqj6FJfmYSgVpM26+xOV7p20Qqfmzzfje7aUN8ULlVZX?=
 =?us-ascii?Q?EC7UiMGri2AQ5QueiOs5u8s=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 827c8dd0-43bc-4fae-dce5-08dd61588ada
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:25:07.4521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: evQ6SWv6m8z1wUR3BnqzI+IVBNn2W/Vmb8dwXyjWN9L0bLoG3rVCQgkpK1CfarMRPB+hZMqfrLfSOg+ZFFqAy9mdlEKshrqMEBpj8x2bf488ZOUGFI7fMFEnvVn5U665
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12752
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:33:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18123

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 08b68ae5a0276f293c8da602f963f6de68b3599b upstream.

Enable parsing of variable configuration for all architectures. This
prepares for adding support for the RZ/V2H SoC, which utilizes the ARM64
architecture and features port pins with variable configuration.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com> # on RZ/G3S
Link: https://lore.kernel.org/r/20240530173857.164073-6-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index 24eb4a375ce5..0d3ffd761762 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -316,7 +316,6 @@ struct rzg2l_pinctrl {
=20
 static const u16 available_ps[] =3D { 1800, 2500, 3300 };
=20
-#ifdef CONFIG_RISCV
 static u64 rzg2l_pinctrl_get_variable_pin_cfg(struct rzg2l_pinctrl *pctrl,
 					      u64 pincfg,
 					      unsigned int port,
@@ -335,6 +334,7 @@ static u64 rzg2l_pinctrl_get_variable_pin_cfg(struct rz=
g2l_pinctrl *pctrl,
 	return 0;
 }
=20
+#ifdef CONFIG_RISCV
 static const u64 r9a07g043f_variable_pin_cfg[] =3D {
 	RZG2L_VARIABLE_PIN_CFG_PACK(20, 0, PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_=
PUPD |
 					   PIN_CFG_FILONOFF | PIN_CFG_FILNUM | PIN_CFG_FILCLKSEL |
@@ -2219,13 +2219,11 @@ static int rzg2l_pinctrl_register(struct rzg2l_pinc=
trl *pctrl)
 		if (i && !(i % RZG2L_PINS_PER_PORT))
 			j++;
 		pin_data[i] =3D pctrl->data->port_pin_configs[j];
-#ifdef CONFIG_RISCV
 		if (pin_data[i] & PIN_CFG_VARIABLE)
 			pin_data[i] =3D rzg2l_pinctrl_get_variable_pin_cfg(pctrl,
 									 pin_data[i],
 									 j,
 									 i % RZG2L_PINS_PER_PORT);
-#endif
 		pins[i].drv_data =3D &pin_data[i];
 	}
=20
--=20
2.43.0


