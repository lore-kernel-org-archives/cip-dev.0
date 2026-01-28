Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E194D3F084
	for <webhook@archiver.kernel.org>; Wed, 28 Jan 2026 16:00:12 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.69])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.738.1769616010238785375
 for <cip-dev@lists.cip-project.org>;
 Wed, 28 Jan 2026 08:00:11 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=gKjCzqZq;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.69, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=boC/M+km8DM8vf24aplW+v56TSI41SF6+wnPixiHN2WrFZRgZE4+sOL6xtPkhL+YvWHwfCXSRE7xtNXsmnW8upuXyZ5dxwRRSIb69Z3ovG+rzd68RPH5n0XpTJSO7ryY/iGzWSLsx83A/6cJGIth+AM0jHkTgNoS2omA88teDx1kkryIAnP+F9P0FxCA5kGWgHuf2rdnxPeQYI6rrFy5fJZtvCQMX1dHz4tJMKQOJ14c2zOoU5eD7AqSHyBSyyC8BvuH0FqUNJxXE2dDiNd/E1Ik+jcmn3VCLCoY9S801a6IFI4wLs3DJgYRPqFWtqUMADZJ1VSLbIS2y6MWRektHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8VRfc9ihTtNVwo4eEbmU9ke6+OxBi3OiPMksdC9BnWY=;
 b=qifihKzpETBNlJZf6bUGpdPSHlxxu5SfdHJMeloHxAn562y0MuGO3Yo/T8iOf+lU0pqurIiE4VFsr3r2Db5aetS9Nlrexo83kyk0j4uGGyHEH8T5W6CG2+FZZ+M5hkskQje8bdK3pQ1azShevlNnIcika6pX1It000euikIoszliTapskSo3Yj9lvbqDXAMwIJ2P4Fk2iCmXCUckDuxH5kmkDqNrxqrP0AnUR44Zkfnff2j3IntHjyZOrXVsfXRIs8D8InxPe1KpA//e82ZPWGpSnLoPtAaEmaVZ99LtXJsUzuLgvCxUmeIy9yo9LyqfxkH86EqW1/R1ASF+Kv2dtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8VRfc9ihTtNVwo4eEbmU9ke6+OxBi3OiPMksdC9BnWY=;
 b=gKjCzqZq96O+rvL/QNEuPmX+xe3Y7PZkDeccolm/kZ8cVtmoKTAsYH/hNIdv8QUnO7RfKyIEaTF+iisRCqbwR3hvKGSTGx/6s+vbwHisgbg6H/TGPxmBZlgXbCAIPD8jOLgldQlWNHWbCSzMJl8savEfhoTJ4cfI7u/Iqiy6oVY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TY3PR01MB11948.jpnprd01.prod.outlook.com (2603:1096:400:409::5)
 by OS9PR01MB12487.jpnprd01.prod.outlook.com (2603:1096:604:2f7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 16:00:06 +0000
Received: from TY3PR01MB11948.jpnprd01.prod.outlook.com
 ([fe80::b718:17d0:6c0f:1495]) by TY3PR01MB11948.jpnprd01.prod.outlook.com
 ([fe80::b718:17d0:6c0f:1495%6]) with mapi id 15.20.9542.010; Wed, 28 Jan 2026
 16:00:06 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 0/4] Add RZ/G3E DMAC support
Date: Wed, 28 Jan 2026 16:59:36 +0100
Message-ID: <20260128155940.1445842-1-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0089.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::15) To TY3PR01MB11948.jpnprd01.prod.outlook.com
 (2603:1096:400:409::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3PR01MB11948:EE_|OS9PR01MB12487:EE_
X-MS-Office365-Filtering-Correlation-Id: c4202db3-c723-49b8-f8d7-08de5e864def
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?kAjbv8/nXJUjuXy9Fvea2tkXwCUWkdzcC7UtH8rPf1Pz262mOqLCcUJJYIpX?=
 =?us-ascii?Q?dnOTJZ9Rp9wITmFCSxPfq3DZsVtL1kms5SCq9+Kfk7zWFJmGdzeTZhBXmiV3?=
 =?us-ascii?Q?nOb1mTskTnUGgRIrJdzsQOixg+wSspYkEsrocU5/WNdK2ac5e8g+5itkpKkR?=
 =?us-ascii?Q?7ZqtqUXyY1e3iKwdX1dcKKfLRYydCkjOnGoaeBCpkaOCPEDq8XJVOP3i0T+W?=
 =?us-ascii?Q?R0gAgNjWHV8p8+c0HTlL1urCGP83brKK9+uZtHCE7b4tE9R/mmLlg11mJyOA?=
 =?us-ascii?Q?PJHeiqcaY6yB8PMmIIGyleJhET0/Zw57xXwHqycL+Saj8Ah9h/vQoAXfueRI?=
 =?us-ascii?Q?q84nHdIBf8kNGr7V0v4kkkfyov+BPNNxfTvMYHLfC2WqaKw8f50HaLRr9ZxC?=
 =?us-ascii?Q?Dd5w8+mOHtYWAxyQHmF8ZGpJWDA6OZucD3v20OAh3NK49Ume5PidaR65ingk?=
 =?us-ascii?Q?NVDrXOch56LJLCJAgKLOrr76B6V24WQpgEWeIJ9HD0MVrElutA7+iLRNWydi?=
 =?us-ascii?Q?K+Z8uEJMnLEX6086lzL0Wu83ZyTWz8NlADGBJWjcIJRj7J+pPi1ipqMZPrRX?=
 =?us-ascii?Q?gZXe+bbr/cl7bA6KMfT0nYEVwcvrIg5BQqquRR6666qibQa6s1G+oRJjmyNa?=
 =?us-ascii?Q?amFisGP3HRiACREF4aRieQPnANnVleuohdBKzigeMddRifpsfnhsxlTFUMRo?=
 =?us-ascii?Q?3Uy7WVWlB+sbVb6SZjzBV3/whKv673pCvpvdba07rq63HnbhUgATThLNaQYR?=
 =?us-ascii?Q?uwWttMDHDXVvIcXvOsF0m3j9dmn/Zlh17o1+OS4KC6k3tPAkZcpLCnfHtdX/?=
 =?us-ascii?Q?rTZLDdsUIJHhZmWaocntKIWj6fD11D9clv50NEd7JO+6l0/boH1shh8iVb1p?=
 =?us-ascii?Q?IidNMyAYvmEXW0yoKlM6fWP02af9Ix6lHzpGciZcXPU5DicIk+l+iZGG03wc?=
 =?us-ascii?Q?SsB4r8y90tAPc9teqEoYD3uykzRfJpaWbUihZo6chHIinrZQ/Ol9MhJDl6PE?=
 =?us-ascii?Q?ubWuAkRY9q6k/kk64gbqkdAGpck/RfclN06NXbHzGcOOzJMimhL8nPpodwB9?=
 =?us-ascii?Q?ObXDjpSx75a8PsQOy0rruJbXIJSsx3XSMQcQNuYu6naN3mGolLMHgP7wvBhr?=
 =?us-ascii?Q?a8PruObg01phf2kDf+jULHVzsE6NUfQtjyzPLISYmDE0DuwACzI9w4UZt0kV?=
 =?us-ascii?Q?4qKIOc6uQBDhxwZsqRZZOUavBSUPxLgIf+DroaxlSH4UoP/s42oP6QK7jzeL?=
 =?us-ascii?Q?VB0Hg75yD3k9zKqfWZSpwUZQmtAvt9BTHQ9OuoXNHWOdCxMWBOcsGTDOvc5v?=
 =?us-ascii?Q?9JTwyeTe+SW4uPH/KvEKjkjmunhz2xwZE32kPAWW8dU3loBVOFecamaT5evK?=
 =?us-ascii?Q?at8xIKkt1l/Ts05mtkuIdzKH6NPR1mzwWiRtNue2TWaUg8gp9xpxKndRhKfo?=
 =?us-ascii?Q?Mb9CWYuhXhnFkaqFeXD1NKZH2nXUozPWYJTKMh76g9Zk7JibfCgwIcNsK0gx?=
 =?us-ascii?Q?kJ3JqsnXUqb5bpSN0IF/GALYGjNkCpKPj7FuMuunnudpHrtvcpDKSmcH1JBp?=
 =?us-ascii?Q?9v1xOCHoyqypv3vdMZ1JFH9oUh2g6wahg7wWkC5NkIFNxEhID6E50pnBLLLi?=
 =?us-ascii?Q?JYgDbrXingIvnAlq1hpTo5g=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11948.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?dm8t6Z2MQW/6YIUk10qXOyrALDn1oOZrfx60ilF11HlCCmK6xp2UK18Bg5eK?=
 =?us-ascii?Q?25Z3dwIzznYjwrGs5oT9/qCk+HGRWnp+sxJO03X2hAY8EE03plkaxVJs5y8e?=
 =?us-ascii?Q?Rka4a//dzD+fci1b0Z17ZDmQcJxu5/9iW2+RDfnWNyX19vZFOCn4lApIHKFk?=
 =?us-ascii?Q?y2LLVgfBNoTJ1LHC/Mf4nC+2VSE/BWk4qXxCXUvHQqoEcRqup2tptm5tQXJF?=
 =?us-ascii?Q?a6ShjY9+LOwPXj+O7Y4ce4U6nf+aXN8arydxPfJXSiYpN5l75nUpGeGgGEVm?=
 =?us-ascii?Q?j+ip2L3FbzfU6/EC5EkzohxXfFgHGGzaCed6yX/BlqVRyaC79QqWthanaKDO?=
 =?us-ascii?Q?XJWn1k+JT5VjZLfAOmxv6NeKIO4mYKkdUewqjFAfg7No/PMdD0+lDJIZ1Gs0?=
 =?us-ascii?Q?GtsiKBSPd1w7wrS+iLPkrnj8ZStiDDKDt+7408n5WUq9dZzUYjQrg3qV47zz?=
 =?us-ascii?Q?pEKBsnqz2Dh2G2Z0Ord3afRpB/WAm4NJbcGIlTkU552HfXfbjZ3+6+mIpTeB?=
 =?us-ascii?Q?dM6y+uS64YnLb7HurD5CeiPAap/BoxwJWv4e1aHqiuNCdbTzISeRd/eQAbhp?=
 =?us-ascii?Q?Eyz4SLvATyL4oAP6/tUSYgEbLEohb7PwaAwnVt3aNWpQEak251DDHH1Hr5G/?=
 =?us-ascii?Q?h6tvkHyJgsBUuyteG3H3ReX2dAl145NkOGBmb1+vE6rudGsoDIWgqZ74VHoO?=
 =?us-ascii?Q?ElZ4DmLqM1bR2bavB1RMl/yZ1FD0pbz8oJht1GqjwZrVPusRvNF4nik248lG?=
 =?us-ascii?Q?KWStO77I60y66k9oFz+RJeFN573Iioztmr+rJXpO8QGcd7HCOEMBIGhW6GqY?=
 =?us-ascii?Q?LWceOtQfsAa8YVcTZy3T4o/bMNXfxrg0lA4mCBW8+9is3sdZeV/SLs9uShBk?=
 =?us-ascii?Q?p2xEZrhCtljDtXW79QNIYtegRqlj8EPiJRWuPrjTqeg66dFPDQn/0WeUU5YY?=
 =?us-ascii?Q?bnA8yL4Zrf5FpYf9WoTtGi0CEKCNXJZxR5tztODioXuukP1bnParXvyAdca1?=
 =?us-ascii?Q?IrrHz6z/gyWVoVi0wFVa/5tN4eSDkSoDeJcRWdBEoDMOzzowYKGGU+1cAwUa?=
 =?us-ascii?Q?8Y1RF67ntdc2Nbp3GbE/rk59eU/FHzyzf3LVtokJ0dY/HZ37beu7QbZHjzSc?=
 =?us-ascii?Q?kD2TUtPdu3DDsGeeobxnM0ks9Npvl68Ak88g+OLHs7kwuN3rm6gpkm1m26uf?=
 =?us-ascii?Q?b5oBTqtRQZuTBLvLaZ30Nvnh/oqDgQM3TnAqSecrsiRAi6ee3EpXdRZ9pzsT?=
 =?us-ascii?Q?WONS6i1b+kJzW7v9Oe8cbF50tP8ga47aSpAtHeE9i97xGoE3csT0rEKef3Ts?=
 =?us-ascii?Q?G0+d1JfZ7qpiOabm4g4VGonMrwFLh9YptEvjfc6y/Q+YGzmlkaeSL5pNUJbe?=
 =?us-ascii?Q?RIzR5fQF5PaVqSFQbUz0UPwKZgjjBpOZnWJ3dir4c+vKizrZn0R2Jx9PeL3i?=
 =?us-ascii?Q?dnY68zF8T/ChU9K1WUW6hdXm5ZWFoqxHOl0dsWnaLezVlsHcuPOo2ykt6SJU?=
 =?us-ascii?Q?MtcHYiZkDtA0X4ib4QJTgi1ItgfpAnzB50poZAq6izgJ2+b2gI14m1j2jUt4?=
 =?us-ascii?Q?Xg1U2XQ5BMEBVBx7xcsiL4rgHqozfIsbV9gAnDia4+9QBPtZZkZaNFEzKv80?=
 =?us-ascii?Q?OZ4pBsnhNPbAikhznFvE8xl28viBppZCJHm8lyweHZoJe79IHAEB6E14Nxje?=
 =?us-ascii?Q?r0WhRBXS6mfmXW3796xqkDrKNAfFAGvnCbNhvT4i7De47ap5/f4V9rrPDgk1?=
 =?us-ascii?Q?VsXLw2sz+YTVynhjoXgwORiv7sTnKdHDJuFvHdoPfShlh2F5wXXa?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4202db3-c723-49b8-f8d7-08de5e864def
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11948.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 16:00:06.2987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Um+BnDOZe/6mhuIk8YG1RBEHllMAiDOGfga8Ah3AFh/ntLlwhh5LRb37MNpSCuJRRNJw8I1D2T/NTVPWWtEZKHBto7CddNAmNeRJw0WLgmuyswdz/6oTyY9biImIuSY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB12487
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 28 Jan 2026 16:00:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21768

Dear All,

This series adds DMAC support for the Renesas RZ/G3E SoC into linux-cip
6.1.y-cip kernel. Backported also commit
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


