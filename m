Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999FBD1D485
	for <webhook@archiver.kernel.org>; Fri,  9 Jan 2026 12:08:27 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.27])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8669.1767960506383461024
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 Jan 2026 04:08:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=KkE3ZPy1;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.27, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mPEGwRBqv5ZxAJte0YTXsT98DGIFyaIn0EbopjrZsFyC3D/PuQ9S5pJH16rMsUePz7uRKlerckjMp5wdl3b034l6O0ibN50jUlR9hEZpA+3D/0RCvu4CH5hE/KF4DkwTpdk2hca9PTMkhkEv/Fz5SDy3UycaGwP60ATFyx87l6+QSoXh+5bjN8CI0vmrT76E19Ocyjgbe8qgulaXZuRpY97DDYBKZNmDVBa/Z0wsopodMPcPFfPzi7gcLYaxZOFqWUdZUfi0xFHHkzJeI05EBa3SJtMjhaGA9xM2hiQ4IsCEHtxSKVJAR+sdbULucedY6vC6y3aM31zfWf1wh8M4JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5fK/YYZeWIDv8dE2dIRx2ShSuvRZMfeapBEhhue0Cf4=;
 b=QwX/VwRajOByVO0WNlzAZeIWqEvTX2Rn1KSzymZPhWzKTxbeHr3F5bMO3QBCUIjPktgSrMefYAMXsvJal7O8oWhPFx+lf9QYqSlrnBedNR+Ud/8ogxwA2o+rgmw6U12JOxMuBo1IvAyebGC83ixL8TVkXzMqQjddOn7PEw66+/gytpmJvjLipwYNYaUgcNgmjc0qTFIzOfltOEwVqqTAYZa4+xt7l/9wcS6pR9R/CJDo0JSzHP34BeBODyNJL8j/NyjpRJfbxaP2iWMaq3np/S3vAJm2729xqIzmbOu39Uoz9EKlzyydiRDg6WGFJGDSgs1DN6lKZrMWrnrqcWvXYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5fK/YYZeWIDv8dE2dIRx2ShSuvRZMfeapBEhhue0Cf4=;
 b=KkE3ZPy1Ahke4Vsw3XU4WWsDxH3V3E2BeF5BBcH19UDtDOK8ezXZ6PKTMlOUxVYEId3x34BwNv7d4y6AzyigiTRmNI//tfXzN6wxLA/ilwflVNrHQSHVMOI/gBZJqIaT+rHCvtTbeWskknofwnLu8tPqw55F9NfKYKmRoU8CkNQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OS7PR01MB15043.jpnprd01.prod.outlook.com (2603:1096:604:386::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.1; Fri, 9 Jan
 2026 12:08:20 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9520.001; Fri, 9 Jan 2026
 12:08:20 +0000
Date: Fri, 9 Jan 2026 13:08:07 +0100
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: Pavel Machek <pavel@nabladev.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 00/22] Add I3C support for RZ/G3E
Message-ID: <aWDvp3CFQIiO52v9@tom-desktop>
References: <20260108092823.489287-1-tommaso.merciai.xr@bp.renesas.com>
 <aWDa/P7QVLdqjKrA@duo.ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWDa/P7QVLdqjKrA@duo.ucw.cz>
X-ClientProxiedBy: FRYP281CA0002.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::12)
 To TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OS7PR01MB15043:EE_
X-MS-Office365-Filtering-Correlation-Id: 02bcebaa-ba6f-4d5b-98f2-08de4f77c7b1
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?SJwqxGP7CZJZ5YjJr/xCIJ962ww9oHmTuUkHMLmZz8kvuFL/sUQJk9an+Wo9?=
 =?us-ascii?Q?+A+olPvj8DTfrAxYCBvtwI7viVac4fJX3Z30O1RFaU+WniImp2mgeLlUTIRI?=
 =?us-ascii?Q?sv/3NEsOMKYzmv9GbFDQMdEUdylY4BFOgFgD02Wch2cd4OHvoSJc2RDi5gv4?=
 =?us-ascii?Q?FJroht3n9mCwt+mlMaCMMa6zXrFGoRh7jw11XKf/ICHjddEcoSfBPskDZTN6?=
 =?us-ascii?Q?mncjHAjROVbx2qH3bxZwXEuHJ9PgLpHFuytCnYBRpPCZ6OKl063tKTS7pUdF?=
 =?us-ascii?Q?ZeWnTwTK3iDLxgph5uGKWGcfMdBA+S0xs/mdsNZKA5Y9OneUR2k97+Byh0Y1?=
 =?us-ascii?Q?TGS8pVihY8ucZpVt3cRlTPSDjWtSBMWeNmJ0SoCAL0dy83Si9B+B1JZds9GQ?=
 =?us-ascii?Q?W53pDJOE9ffwDWMNlinGsN7mrquq8VHmH5SUbo3vqNB6pe3BebgcvJa42Alk?=
 =?us-ascii?Q?bdbDmrJofCt0HqQVobCfYwuV/93bhwxT4b1qpWzt2U799C4TpcZe/iCAWpRu?=
 =?us-ascii?Q?XcXlFooc3n9dYsRWu6PNMJYMxDpL8N1xufIpAelhI9InjYx43Ts11T+3lpaq?=
 =?us-ascii?Q?5UGyp9vRTgc/GFlRh4WpRbJLHbrOy8gniN19nCD3sSWRbiBhGhpmaBat92fi?=
 =?us-ascii?Q?zCtYyFJ4Q7QJULLcRz2aLsKzakeyzs17HZ7YD9g0oZWGmFek8llSZzkskyPJ?=
 =?us-ascii?Q?6cBx5eJw6H3kCFTWzvHUhfCPVRVY2L6pwRkA7IzouZHk4ZEeFuOKor+sOzEk?=
 =?us-ascii?Q?U29R0f8eWntgZjCJr2bz4fvXTS11IfMclrtnzPdycDsrpemsTciVrBAz5VNK?=
 =?us-ascii?Q?qO3h3pWm+UvYKbKZDD1h0XFbranfRcSFU3+l25Jf/ndpFlrSF8CVCEa7VfNw?=
 =?us-ascii?Q?GhV0CyMyXFgPUKtzyZkS1H4IhDb4N91ZXt0830xP9hna1QuoBuGZknwF5xvi?=
 =?us-ascii?Q?Ttn0fAqV3OAuIaAoxqQ9VHa3pc6UhCabNg7EwKKiEbyt5aNY7hOgGjLW40Zv?=
 =?us-ascii?Q?1OjiE4C7DwqDnjDGjvFIWqMMX/vPPrVrfnJQjQfjPh9rPbpwdiEvYvsm3V7B?=
 =?us-ascii?Q?u1bMrdtFrYefpTJxV1VJa2T6iVZIbJv4+16P7JA3MNjNbTuZmbIIYM7On8mQ?=
 =?us-ascii?Q?XnyspmuqDwDufLyLIo0HpB9KFhnYW1I9ph2OxheMX6pbpC9Ppo1KTpo5VLJ5?=
 =?us-ascii?Q?dt/GqZYVN6DeaaOfrQ1Bm8u5nM3Uv376uqCpKhlTBYNcDfRDCKey3vk/lwqH?=
 =?us-ascii?Q?gPNduoRvSuOVRLvQQd/8ZOLYAdy7oqPS9AmNrsx1GdvCbiPg6m9ae5bWmFaW?=
 =?us-ascii?Q?MW8Rei+oXkMttEjuwXOSFdPDzm+gUZlS0n77tmme2c1PKvyS/6+1LAsz6tPY?=
 =?us-ascii?Q?8J4H01FVNZmo6THRdeGdejp1YyjHqQRtgRMNXmNPGZHSg1FJt9jmIbRTc8EL?=
 =?us-ascii?Q?S6TGMkvqrxe4cBpNUJ9YIzs7cLdLQrRhPkoJanTL3pyMA7LTuiEzrux12SSF?=
 =?us-ascii?Q?1DVrsq3Z5EcXdLWCLLOhI84QEcWvXzDC8rJv?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?0YCEpJTH2FEGpnSpacMZl/NS3RSaJa9hqy8xWykkUbdY9rbUtY2f2bNDuPaD?=
 =?us-ascii?Q?pwCrbie7NyE7fZAfaecfSX3Iapy1N86e/44sgDYp9Khes48PdFOJ/dZckinD?=
 =?us-ascii?Q?lHrXcVGubXOJWYRoWY5V4pUwFVc2WDOXxNXRye4YQFZiqgeZUu+CDW586v9a?=
 =?us-ascii?Q?Pn4NmmwxV9Xf485TIxsBIFxd0RakUa0FZ6V+dWFxxIwI7Sc8JJRp6SkH1tpk?=
 =?us-ascii?Q?ExiXo8EgQ1Gx+5MhcIgd5crIRZCSolNJaVNxeGiAt3iHJoI0OR1a/ZHPckN+?=
 =?us-ascii?Q?qEO0zA1VbbFBYVl8jvtT3UIjaLFWmJ5DN891FzKuuS8D9oI+8hvKzkYGRPU2?=
 =?us-ascii?Q?yNtX9JWLbG+6K4RDJ4Bmd9xzV2+MVKn42Lkh3NQlZfJexB9skSUE3yjXJ7rC?=
 =?us-ascii?Q?b/51uRhlCN3+GDHwIXc+xsViOkVgIjEStH5xkuWJ+pTRA0ineq6n0Q2iMgZL?=
 =?us-ascii?Q?lEArzppxcfPWUtpCrVxsjjyUe26nzOFBxfQfJM4J7OV+pv3qqFBMc4SaS8iT?=
 =?us-ascii?Q?Ho9F1n7xMVgsQQ7bO/Ej7gk+aOFJHGUbsBg00I/nwB1xmmUz0Te7MGE/oDw2?=
 =?us-ascii?Q?hZnGcvJdqJNZN9ExvNKq3lBZ9ZA12aPWfBjAua0WXmqwlD/fPpAC/A0OVlL/?=
 =?us-ascii?Q?+N1fDOhV1gSMij5eNYHTahv72fQhYhk/9JYNCvUj1gYyRSZMR8ZLSlSybygU?=
 =?us-ascii?Q?PPNYHMx+kgfELoY0fN2j5Rowpo57O+DvIgg1I5u+1+7SfeOkqOxh67eZdCbA?=
 =?us-ascii?Q?RQNAJ9lrErYU6iBwLxJphHug9gbyvjOxnK7bj/fOSZTkl+47gZev+LAGxM/b?=
 =?us-ascii?Q?XLsT/f5JjO2eKQCXQQqeUfinK7CA32hDp8BmDO2AhrMJCOB3Thl2U0uxyjsK?=
 =?us-ascii?Q?HaCEp/jkbLDP4SBFJOT41dXhK3C8XBpgx1v6l5KWVNhgW0cSlaIFVYx8lWZO?=
 =?us-ascii?Q?7PiOMVLzAzcLAIPDNGpRFDkyqMdfqTRrmi6+SiGwgQ3t1o2i6K+kDEZnfG2+?=
 =?us-ascii?Q?m1YDpkyCLhdRnPFZMnuhF84b0KuHX8iIRXZJHdZHl8iCtwFyd7fCVtEwcAmj?=
 =?us-ascii?Q?MIn2IQta7NHVa9BD80RztIG9UswsRdDSqcDE5MKVCLy7+Xdl7Jf28PJQ3Ld6?=
 =?us-ascii?Q?4RFbSfNonpud/TK/nI1Q8yKXI9AW9mK68GJGI1VqzykCI8tXxsbFEhZePINY?=
 =?us-ascii?Q?3FOK3yBA/XQklskMM65Hb3DhhrEi59iZquq4YjrawehNCLCnEDAXpuZ1Q52s?=
 =?us-ascii?Q?SYrS4Vca9H9ePoktFA8w/n1Gwy54/ykmZrgQEElmx3jBOHZjmhvDprVYT7w1?=
 =?us-ascii?Q?5IDPpibygGDmraGJt44cnWCYoTmHtci/52vP3xxi2hKIiMS1UKSDV6Et7kpr?=
 =?us-ascii?Q?y2Vgnc5K/GzmRWqj97IuzTmLwttObxtJd+8g9nXRTtvFTeOLDDfKVdlU8WTi?=
 =?us-ascii?Q?b4125MFI5LkCDmyQja5H9R4Jp39cZ8Wi9pEmq5PRWKR4vn8/GCypPzYyuXWN?=
 =?us-ascii?Q?PwIVOUSWqa9Q1QXKQL6w+nDqDE5y+jZSAEko1fQHaSlMYRkNcfLjBmpBXG+w?=
 =?us-ascii?Q?C2TDx9hZd2oHt7GzK7eHU7dA3CIqmi3kXbD7SPCIwfN6U4IyckzqQ4yAHKLS?=
 =?us-ascii?Q?vpVtuawuEPiXo5aOOjNeeJlUdsMzBADLfNGrhGk8odQYfbvpC+65/04c9QVt?=
 =?us-ascii?Q?Hs/Z2uDPTB5CkZI2YK8yelx54FDnEmlTL27t9KS4hSKDe3pJmtd8B9CELFNx?=
 =?us-ascii?Q?fuSZZDJdXF5xvDufaA3iNdHgVowoAzyxW+CrTVDXQCvRHeBgwogr?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02bcebaa-ba6f-4d5b-98f2-08de4f77c7b1
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 12:08:20.6163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sQY8/2J0uBPRNaYoq5cHXTZ0ehDOh+KWE8/SUXmCBObGAm7aShJ4GIBtL6HAhUmZNYLar8EpXfdGTTQzaiw/U8NV4dEtuLGXctvSuAc++E+Pz8IeF8pFmooEEpDBwEfM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB15043
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 Jan 2026 12:08:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21506

Hi Pavel,
Thanks for your review!


On Fri, Jan 09, 2026 at 11:39:56AM +0100, Pavel Machek wrote:
> Hi!
> 
> > This series adds I3C support for the Renesas RZ/G3E SoC into
> > linux-6.1.y-cip kernel. This includes also nxp,p3t1085 I3C backporting
> > for testing purposes.
> 
> > Tested using the NXP P3T1085UK-ARD connected to the RZ/G3E SMARC SoM
> > via the RZ/G3E SMARC BREAKOUT board.
> 
> Do we really need to add nxp,p3t1085 ? AFAICT people would need
> special hardware, and then would have to patch their dts anyway.
> 
> I'd propose not to include these in -cip, as we could test them in the
> test farm, and it is just for testing anyway.

Just FYI for testing on RZ/G3E I used this series + [0] + configs
i3c related enable.

> 
> I had some minor comments, but those should not block the merge.
> 
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
> 
> I can apply the series after 6.12 version, if it passes testing and
> there are no other comments.
> 
> Best regards,
>                                                                 Pavel
> -- 
> In cooperation with Nabla.

Kind Regards,
Tommaso

[0] https://patchwork.kernel.org/project/linux-renesas-soc/patch/9d1cf2cdb1c11f24378404142e4c8aff680c6961.1763638659.git.tommaso.merciai.xr@bp.renesas.com/


