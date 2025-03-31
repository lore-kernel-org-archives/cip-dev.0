Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409EAC3600B
	for <webhook@archiver.kernel.org>; Mon, 31 Mar 2025 09:55:01 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.34])
 by mx.groups.io with SMTP id smtpd.web10.48358.1743414896852300786
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Mar 2025 02:54:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=GrV9LN2E;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.34, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=flteZ/AKMfXkWFErPkub3PrvArO3uLlyp2dffi5k8DyjSdkBCqXGryyTo/UyDzk3bvIUxRxUUhSZInekgQX7zpQLay64pYtdlJsaEEWSoQbR+AjzHNGuDyPAzzlW5Wsd4OMp/tY/br4ItEAF+HAbRNeRh2STNBsZBTZF8ev/O/eYkIW4/je7rmSjtEb/Ckyqha4t66aIOhBg5yXxGHVZHV3ElF+sP6osd8mt3XDbI0vthUpKPR6NC4mGuE71GV3KdGoeLjjBg5xesR6q5AwmgpyjGlcy8uJS0k3RaRtKSHfEvJ6vFa/UUnuGVDim6dZIESDjIml6t3Z9BTbZRV3efg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gzVOL8mJf/hxnswMagwyeZNR4JC9xuNVjUPRJP2DngQ=;
 b=aYzV3YGy4G5b4OFYtP4o/8DByTQiWAu7bqjPqfogGY+yLwyAbxCFnJYyCJ/PbogNMY4CzbI0lMV0HldpEbLmouqx3nXRvG+mnieUIOS23b8SIDtaK10Q0fmYYXY2e1X/Ed4uh3gfJnfeKBOMnNGiDvS2vLcNhGtxmAOMj76rGdhlpRoIaNsU8RMg1upSFUNKPt7i2y5IauRg128Sa07DSBcApNUjP510YLpRlSQwdEMZN7ncaGcVC6SXGOg5JINUM9bYUjdatNBo2tJJ4LabHYZ/weDn4ThvNll86Lae+IU70PCPj0faoER0uWZjDm3JznaGTJ+OKQZknLFGEPZi3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzVOL8mJf/hxnswMagwyeZNR4JC9xuNVjUPRJP2DngQ=;
 b=GrV9LN2EutLMP3N9ftKeugCcE/lO67tkBrBJofZYb4G+goIdmoVoHiqUUaRdaF8A7JsgJxX1CcB7fQeamBssE41Bs1deOkLFgfikmS6LEhrXwqLuKmNX7BQDVRccrX7CZub2pURkw8Kpr11XpxHKWczG73KxMrS7oBim9+2ObJY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TY3PR01MB11445.jpnprd01.prod.outlook.com (2603:1096:400:375::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.29; Mon, 31 Mar
 2025 09:54:52 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.036; Mon, 31 Mar 2025
 09:54:52 +0000
Date: Mon, 31 Mar 2025 11:54:43 +0200
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.1.y-cip 00/21] Add support for Renesas RZ/G3E SoC and
 SMARC-EVK platform
Message-ID: <Z-pmYzDjgWQwJoGL@tom-desktop>
References: <20250321110021.3612805-1-tommaso.merciai.xr@bp.renesas.com>
 <Z+P5EcmP5S5leD9O@duo.ucw.cz>
 <Z-QEcdrAz23PkN7h@tom-desktop>
 <Z+pbPvuQ8jcpDAwX@duo.ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z+pbPvuQ8jcpDAwX@duo.ucw.cz>
X-ClientProxiedBy: FR0P281CA0062.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::23) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TY3PR01MB11445:EE_
X-MS-Office365-Filtering-Correlation-Id: e99a6596-4149-4436-791f-08dd703a14fe
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?UG4V7DjTtl3eXh3qez5j7BDf7hZKzXfR5CM7fsrbjOkLCHgpubt7EfhBDq+U?=
 =?us-ascii?Q?3HYiZN50K5NOwveNIRya+aw1sKijq4AkNtc4ww/KJRSC++hgqCSRSYNammp2?=
 =?us-ascii?Q?EjQI6PihMiWrygqo7OZaSKlHYJ6VXT+B03n+u2alb4IkZQCAkdVrzlp25zwQ?=
 =?us-ascii?Q?psME1UPpUfBHwDodLSIuxBcm7t+f0QaBj47LF5ek/xTyZOD2PXzSmeNio7sZ?=
 =?us-ascii?Q?BguzOw0+6ZlpquZmzFlzfW/Ee692dO9qWvyRJgDaCxLjS9O+ElcSV8PyPnBH?=
 =?us-ascii?Q?Y9WTo7EHA3XnoP6MlsySjJg17M928iHmuWS0tn5FeFznNcAnMKsHjKUWvzbj?=
 =?us-ascii?Q?hYIp7BKN/PfzmdPZ6NC68Xd24elLDyTtXzCoM4pSIvctw1K40k+MxgQe/26F?=
 =?us-ascii?Q?5rbzCpv4T9GioD2WJN+q95jsa8mRnOe1/jz07X4F+BxDv/XJEc4JehkX221u?=
 =?us-ascii?Q?jICii6p6QFRHJ7KiddxCgPEKPApw7cIm8Ict+q90JaBkdBOuNI01Nt50xU06?=
 =?us-ascii?Q?pZdd1pyTitFZFQioIsPAg3/9Yv6w48GdYjl5qt2Sl7lb6szoOaYyfCbrhOaq?=
 =?us-ascii?Q?I7+Rf8lhUMWj3dO3fuGqsZi36GGg8mT2C0IjlEh89npd3yYSApe6HsY6Xobz?=
 =?us-ascii?Q?cBDZ7PJj3OI6stx7KQytNo14Q4pvE3GM0XTnei3DQ+FHa0I5AqO0SKc+KZSD?=
 =?us-ascii?Q?RrcRHvQzxTOzTigepKfGMV7dBUZMsmBv2sgQeTsOEn6XyiHXdQeczagoTw6+?=
 =?us-ascii?Q?8/n86n/kYaj+bXhB1ehqZYGuPqdiA7h4dh3fi/zPIZDMINuoJTckenhShJ2U?=
 =?us-ascii?Q?/uQOyky8Ggn2t1XBe6Mwk6DA8G+Vuartb9tNQNS6JGFUWNNhXn+/3BlyapHy?=
 =?us-ascii?Q?t1Ul9+tQowFFpIGT/7XTAuVPh/Ev1fofy9gnJMEHJN5AhmTWRxvoXW6ziJTg?=
 =?us-ascii?Q?pOvf7tDeGwO02aIVJKyR0Ry+pR1Ie6BX572wviu1LPVU8rmW5FQpG/TZJ7JD?=
 =?us-ascii?Q?x8gKKENorLzrNwdPaPmEjOBlU8nCFgtnWAwOAEGFD9u5q46A9xvqa6j4eIru?=
 =?us-ascii?Q?hC2sEJULOGQqfuB3RNbg0aKWFSjJ3uKHDSixcbjTdmutqLssrCL4BErtNZ1W?=
 =?us-ascii?Q?0hUG6CtWcyrjVyFQVwfcio86YeNfCVYW+Cyo0ZTFHNH3onrYLJwoVI74cPg/?=
 =?us-ascii?Q?Sw6Ezv36NObzkSMFA+24Ew8K6topzuwTUF4q4GReghIVqZELSOvhU8qPj1+i?=
 =?us-ascii?Q?BqZ8nzWrtL226VT+hZP5BlXqnbFv/60ivdNUEVVTFpU6AYrbGxQuGrTof+K/?=
 =?us-ascii?Q?ReHz236hO1/7VnVR3xkdjkX0+LnPvgnOhuGwsAJK2VU+d+KVP0fH+XViIqoL?=
 =?us-ascii?Q?ALgZCCsKx21HMYQy0JLDhPtOgW7dd+rSVFBX0TuJSeILhTvluBOh2nT/3XVb?=
 =?us-ascii?Q?FBsg8jajP+7ddrPvi2KyZQ2xrleKRs1p?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?DxjlziN0s/KQti7DOsOk7dzs1xfZi6YDhGZkfkSWf5gcbbHOrrTGSEddNxe3?=
 =?us-ascii?Q?5O9bcZaUxqD9JqDXYdsZe6s6ZIn+3rMDzhfPCrCGfxxHB2Z8IRM87eNeS8Zr?=
 =?us-ascii?Q?7dvQ1s4sI3RxeqReXMhgazEQrbQ6dy8vPoZ9EOLikv/Et5v78SGJ3EnybDcs?=
 =?us-ascii?Q?gKSwGatFTyTOo6U/7P9xrpzAD3KTbO79JAvy+tlWKNz33qJ8BiSvnzX5rhff?=
 =?us-ascii?Q?RgHPFdVPGrA929Eta/xFkmkjL9sPnXWS0+24a8Vit/ykxhHuA6sjO06Uh2OO?=
 =?us-ascii?Q?qSk1ltCG9BZFueJO5jLO2jA4IevWqLlaLHmwC0OxPsko1mSIIRmd44AHGpI1?=
 =?us-ascii?Q?4byuNplw6MaxPELzMQV8L0exmCqwO1BWxl3ogN3WlKywm+ev3kU/iWX39rw0?=
 =?us-ascii?Q?6j5V2RFTUPWT6OZDVHgWPOY0V3m0yOqXXq8ZZlpY/zcXfTu+zYFmr7URC5ER?=
 =?us-ascii?Q?poHhmIUjT/y6ZR9VG6i0EtQM4MiLIiiNe0rd4ISmNaNqRCmEaZ5205expzl9?=
 =?us-ascii?Q?bQzVyi7c6rEJOS9tlYcNLdNEymoa65pXvMGArfu7UJv7Poe0D0ma0gnd4RU2?=
 =?us-ascii?Q?gzLUmEBqNOK/5Ql/7OmLj/rZRnAUOltMLPbJZ3wlZldm9sWfRIcSfX2gHqEe?=
 =?us-ascii?Q?3I2fsD+IXOP2ARLk9NvgX9BRWDn5FmgYntl+0QI7xiAlRnhU6PLt5rRP9L/2?=
 =?us-ascii?Q?WbqvpADQ+R4eLrJPSMnBitfo7AqpvfU06JlXUhB0XGYXvJnBdl9PbM6HYcd9?=
 =?us-ascii?Q?7sn4tsUCIBfrVFFKcbWh0mU5YUxUh6kYPowGl/OClQPFEML2vWSxwqK414zh?=
 =?us-ascii?Q?umlPi0oVqBEgWsKdgXB7VrCpjmMOzhZxoDvhxDdzF/q21XVg1Yya4kmi1boS?=
 =?us-ascii?Q?d8haT6XXzIrj8cJmdS5n6qCoatH61fTYa7UWJc/tEaEENlgVt9jA8roH9JMI?=
 =?us-ascii?Q?oRXSo3D7iJDJ6hcUNfoQJK02cnlqgokDHS7lOAfwKlWA62B57hOZQqnFjJE5?=
 =?us-ascii?Q?NDFD3OV+scRrmYHsXjqEBvUpQJOnf5UXXH+KC6ZoPhkKaLIavJMTKzmjA+Yp?=
 =?us-ascii?Q?vefkCkNNboFWYUeRKzgDs7NmhkIjx2SF51Ruaa9KYi3teRAJDQoI6llfpOmH?=
 =?us-ascii?Q?jhqCKbPiWFGGulA4KBON9ab2tTPOQopT00VuAKoPCmm4RIbg+JinHx224hp4?=
 =?us-ascii?Q?bZN6H+l58EgN9F0jNCjmHeUCgxy2d8m8uKBEhC02yX7mMi0nFHUbybO7s0Px?=
 =?us-ascii?Q?rHP4oHKM/XBDw4dAOquBZ8A/eiQsG7JuXzRnewLudgNRuutIlqjGPoqyS1Ux?=
 =?us-ascii?Q?C+dE2D2xTRnqCTuxlznxZzBqC1I4Cs0pgk6K0o2Mmbu1wU3qdkNtMmvNCm+i?=
 =?us-ascii?Q?LCDYPP47A2o5rOIalZI/x9NeDcrkjnLk0qzh1lW1aEXTrQdZ9xaOjBccXIwv?=
 =?us-ascii?Q?wBaZIMHBX2tHBd5IFFPNhLdYb6icjFhAETbadc8rpqqHF8yeIWZLQZUlF8Da?=
 =?us-ascii?Q?yF+ZX5Sa6jkPnH2hosjIYtoowS5+K8/+VIMic3YrgsTp6J7nxsr8AcFSwY+7?=
 =?us-ascii?Q?K67GfCfJGQAtRebc3nXjr9lgXnUCYOJx/Gi134NrHHe/i96mQ1Yu4YLIeRRK?=
 =?us-ascii?Q?uKG+CfynIYzrgPT/fiJpoKo=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e99a6596-4149-4436-791f-08dd703a14fe
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 09:54:52.2610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N4alM7lOKlnQ+ON+N8r7iYc1RW/ujBsU/RFSBgm8uDx3WooBv1USIVcH0pAZxJ9IJlm937lni+2Ar18qCrL7n0vdxpkFHymrykzyVEZKerdoYFaMZxaDe/ep+UrVF3s4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11445
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Mar 2025 09:55:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18387

Hi Pavel,

On Mon, Mar 31, 2025 at 11:07:10AM +0200, Pavel Machek wrote:
> Hi!
> 
> > > > This patch series adds initial support for the Renesas RZ/G3E SoC and
> > > > RZ/G3E SMARC EVK platform to linux-6.1.y-cip kernel. The RZ/G3E device is a
> > > > general-purpose microprocessor with a quad-core CA-55, single core CM-33,
> > > > Ethos-U55 NPU, Mali-G52 3-D Graphics and other peripherals.
> > > > 
> > > > All patches are cherry-picked from mainline kernel.
> > > 
> > > Thank you, applied.
> > 
> > Thanks for the update! :)
> > 
> > Next step will be: pinctrl support
> > 
> > This for 6.1.y-cip will be a patchset from:
> > 
> > [6.1.y-cip,23/85] dt-bindings: pinctrl: renesas: Add alpha-numerical port support for RZ/V2H
> > ..
> > to
> > [6.1.y-cip,64/85] arm64: dts: renesas: r9a09g047: Add pincontrol node
> > +
> > [6.1.y-cip,77/85] arm64: dts: renesas: r9a09g047e57-smarc: Add SCIF pincontrol
> 
> Series of 40 patches is still a bit big, but if you can't split them
> more... just submit, we'll likely deal with them eventually. Both 6.1
> and 6.12 versions, please.

Will do. Thanks for your feedback.

> 
> Best regards,
> 								Pavel
> -- 
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

Regards,
Tommaso

