Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6791CA0EEB
	for <webhook@archiver.kernel.org>; Fri, 22 Aug 2025 15:09:18 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.51])
 by mx.groups.io with SMTP id smtpd.web10.126.1755875356468411527
 for <cip-dev@lists.cip-project.org>;
 Fri, 22 Aug 2025 08:09:17 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=XpgfTBiL;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.51, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hi0L0sps+iNV40/SE7wHmHLAM6XlmkZoQNd39LKK6CkP55otLeUzJqBlA3mdOXT5TSYSZSgxIZsJRqx0T0RZoFeQDNvrYxaSmrXRkjWUGxqXkdPFH6Vdm4eGGBrB+49MIm2lP+6qL0dRf8A3d+Zl04j3ExbbvnDAjfrZCmGLv8aPtkapG5D/iYohqeOTFcTD3+Of/96VOo+yozEK3TU/O10S0Ttd3Y3RBzuLSAtdUVPsFxTS3CqXVd4a7ohnp488nQL6DY9OS/9V/GIfySVCa8QrJPRgyPOAtJc3/wS9vmTYYSn8Htmqe1gfW7bww5BnFQtAK3/NGGL011FEkW+T1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KsDbsGDlHLepPgSogiDH6WxT2/FBlJAVtANH6JZsmD0=;
 b=mZ5WJAyLpMiSillGoQaIVRNorhTqR0KH+lqYDrUsS7TMmiERgVzuH0+5/7GHbiisFC5+g4EJB2yndeS0kuh8WriY7l5UHbTEY0iA5PvAVxqFm3/3zYiL0UFMFbKjiLOSXmX+cjY7C+/KgBi2QDQ7JFNxwhg0nqFFHE7yxtI0ixx+g8Jr+NdHqtvDfuGC0wI+R9cCZo8gEyhaqBPiNhdRgZSIWY6wU0OncEIGyHn44lC6k9/EBrQhL2C4PiUJ5MBA9HW57Y4Sg9cESbzJ+UrffaYHg9LdOZo1P+pvIdjv59nwEdXxy9dD5xRwWJI25lDMMpPfcOdd/lb2NMbhO+CjvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KsDbsGDlHLepPgSogiDH6WxT2/FBlJAVtANH6JZsmD0=;
 b=XpgfTBiL7dBshAH65rXMSqUZ3z9ur1whGKHptWnxzNrv871Xcuf0ic8Ivh7zTj876/OBI7svdDn4qyn1LN665W8sm7+ls4XAfEVhcYpqtSvfDuUpEtOouvG22TvuJpyxxEHxhJrRFcTUMALVsvaX6rgir3i7oR0mv6bDb7OIDyM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY4PR01MB13854.jpnprd01.prod.outlook.com (2603:1096:405:1f9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Fri, 22 Aug
 2025 15:09:02 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 15:09:01 +0000
Date: Fri, 22 Aug 2025 17:08:48 +0200
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>, tomm.merciai@gmail.com
Subject: Re: [PATCH 6.1.y-cip 00/55] Add support for CRU/CSI2 on Renesas
 RZ/G3E
Message-ID: <aKiIABuK1Y7J6GjH@tom-desktop>
References: <20250820160413.801341-1-tommaso.merciai.xr@bp.renesas.com>
 <aKhWdzCUHPWzUnNB@duo.ucw.cz>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <aKhWdzCUHPWzUnNB@duo.ucw.cz>
X-ClientProxiedBy: FR2P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::9) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TY4PR01MB13854:EE_
X-MS-Office365-Filtering-Correlation-Id: dcb918e0-acdb-4a0d-b36e-08dde18dd392
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Bp/tykiYhPr/1s6qQCNcjk6QjVvMrKNNu49G9IhMOdLpyBz1+kRcqUveZSJy?=
 =?us-ascii?Q?N/ayJMDHa6tUtHIoJ/ou67OD1GBUzvv1t4Mcl+yCO0ohECxpRocm0dtGi/Nd?=
 =?us-ascii?Q?83GAHP6GYQSbxMwQ+1jld5HclhsgMOAIKMAaHzTPw1HGreNwxlaQ1tjS8cmW?=
 =?us-ascii?Q?J0e8PlX33Y0VRRGPq4tQ0JIGbVB968Rp04M2L/2DCqOywNMgOzM8NQlmdkQq?=
 =?us-ascii?Q?U3QouUsZDcVstGT+boP3mp72BUjvte0GLfrfbpScT4i9WY88WLMfA6BbOvln?=
 =?us-ascii?Q?PRK8eo1nsgEdPfu77nuueF+2OULPD6Ju1Z8hOb9RQ0mF/dLIgWC3liKreiQs?=
 =?us-ascii?Q?RJt+q1fMv2FlQMbq59rDToSezU4hxz6NzfTPX7OkE3V3BeU2oN9zgXl9lMAx?=
 =?us-ascii?Q?o5pTqDxDHN4Yicg/EUufqewbNmXJuQuKnaRB1aZ/gwSuYOF/po0q2mOnXfDZ?=
 =?us-ascii?Q?/Q2Aypxwq0cUOL5c+VOGPWLVO3gUtZPWS+h9qjdNPoGDfzhZLbxoWMzt/c0/?=
 =?us-ascii?Q?oYt2i0/WXokTCVWiUgpFW7bEG0UrFgVxj8MPQnRDeMgwTUrj2an6PXSt8vb8?=
 =?us-ascii?Q?t+viu0Xl3buist5RhHj1AiwOQG2ZFcuLZOb2YwSUHFqjYEhjl4WE3aBk+PEp?=
 =?us-ascii?Q?jptIjjKt1QOPQsMg4EbtzqGGPl+GtHJbGsjn7ccpffRRBeJT/mImd4yIlvjp?=
 =?us-ascii?Q?is2Wd9Wqi6wi8sXIxLSvbVdaB4/gIaBbT5QRWKhCevbDL2zFE+njWnGT4LXP?=
 =?us-ascii?Q?GpSlCbfQtggHsAmnOCh5oKAFoydL3beGz/BE44RNPvAN7lwbW4/2VHSniLlX?=
 =?us-ascii?Q?PTefCy6aCG5vZecdONn8KrLJRwGQ4GmNSdAqMQu08zyTIimsbGUDYGA1JXqd?=
 =?us-ascii?Q?tsTlxLzUHobICbvhO44FlB8WWGrHVRNkyf9/PhOec6Ig4tTj0Zmg6dPZ5G4r?=
 =?us-ascii?Q?NT8TQ24byS8PTMrIcwiCOdrMzkR5ELgkor5KpW+zmcs1JpFZrtECgwJJIYuB?=
 =?us-ascii?Q?m36vXYz6HAkzc4p1SGtn0NOT6j9pC+ugTTKTAnZ3YpGKZVp6AO3mtmLm19qt?=
 =?us-ascii?Q?t6GsxmfdlT01EzkuOy7vvgbCT8TWg088xOQ0VXaXo3ygwTitWq1OWZAtBWgL?=
 =?us-ascii?Q?5K0OusFXuZXyroc70N3/vYg2cr7t/J614/GKhkZoyBPKLgVnbbc1oJ/GICou?=
 =?us-ascii?Q?gsQ50dI1m3Cj+ePZk9Z7G/cTHQW2ZgRPVooVMzkHlzdCmJJXlRaSqQu/90DI?=
 =?us-ascii?Q?CJrW1V6X0Il3jGIOKNSK3Cccp4m6NALDNf8+CVR6lqdFPt95WFzZZo39KSli?=
 =?us-ascii?Q?6bDqIhUWjkF2qP4nzgS5U+ZrldEkbELkNQ4vX9ggtvEDbwmeSwnGwQMmrsv4?=
 =?us-ascii?Q?7RjDvHUJaZPui0DCOZix79kulUePdb3MfzOENTzS2iyT/9VFxKU9HQqbrXC1?=
 =?us-ascii?Q?9gx+5juD4nIuTzHaJfphL7qOC5ObroVWKDGg5lPVGTV8wO8kjgMWrQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?3vSB8vTqeQJq9v7q6AhFw+Jhj46NYAqnFjaMKGuVJrQ9FdwAZzXy1DOJSKi4?=
 =?us-ascii?Q?GjfsJbtAjVk0ycnS+9WMiWtgV5ff7uHOMoh1u/6O5omrZFkHVfzHJRMJlpAD?=
 =?us-ascii?Q?hw2jfuteArco/lG6oBooAB45K3M8tBN13N17Bp1MEWkwZcybUs8wN/pA7SEv?=
 =?us-ascii?Q?hW8bd5MUM+XdKpIDIe75kl3UYYiyGQS3GMCUN5EJT8GMPNkK4DKs4PRge8PC?=
 =?us-ascii?Q?uBZ+pzoMbJUryKufLTc6UR38+Urd7eN/JYmEKIB270yLq0AYuLKWNo+t9HY+?=
 =?us-ascii?Q?9/Q5YywFilgvvcHyQLHKrj8aqqX7aDqVThUJByjVpm+ATMfALYYD70c9Q6nY?=
 =?us-ascii?Q?vEQSXjbmq3SK2EN+IBEBAmbo/PT4oupLs5P9XA50GTReDRIkpDdi++zEIXxM?=
 =?us-ascii?Q?qi6V7Nr6CqxNNPAst1uFJGA+UUq9rl2eoT0u49hbgW8g52RMVijhnKtkEl7l?=
 =?us-ascii?Q?pX2pHuFiKVjdy87Eg2lFPW+MctvJSfDMBaZhJ6/FiQqXvM5nC7uJW51dt7SA?=
 =?us-ascii?Q?GWmIOsQ0sclCTE+wY9C5AAMtEN3i4A527KOWD5qLfKy2IN1Hqx+W4Gka/XaZ?=
 =?us-ascii?Q?MD+rbNFuZebkkpff/8+U435KTNcPzJDurATo8xKeTK6MehKiY3+a/+L2X4ux?=
 =?us-ascii?Q?oadFmOybgnliuGcPuaGV12wxJB8/ZmKyckDgFP4vFz1DsUP5/k16sMzBdug0?=
 =?us-ascii?Q?x24R6wx0mkiriYbGbF18/Eg+WTZwGaDsN6OgkC7lgCymzZa8r4NZOr3IEiz+?=
 =?us-ascii?Q?uAYGPYnOd5ieuGfFGIHaV+WMw8hN1QGFzAcQw279Pk3PyDQYUM2Arunebv7P?=
 =?us-ascii?Q?kzP9tWJ+yk2m6KED5Q/2mA3QkrOrt+RAEJGvEQWN6hcRiJdL8FRim1yi6/z2?=
 =?us-ascii?Q?15D3sXJiZQVhLFPQIz5yFZIcGX4paW9C73pPXHT6HogkQHKANMdE+t9MLZ9D?=
 =?us-ascii?Q?yik/D2Ze/Z376jHyoG2BfK7NjLacr5h92c0RPgBrtyUvEotlV9VRY7je3kg1?=
 =?us-ascii?Q?FlibqYWU1MeeFrMWlUgWWWGmoDPUc+X6wYQmql3n2g5SQh007R59JQJTV0zh?=
 =?us-ascii?Q?dGep0Ll5oKfz0qTfADvLPJXt0TcRHGYeqmzIHXvEaMOGD3dgWtFyvYoiOsui?=
 =?us-ascii?Q?zx4SmEbtAgUZFcJ3w0rTDggQ01r6LiREpaorCgsJbLJ2FF5RhJfhJNhcsech?=
 =?us-ascii?Q?vlY41PXnEG6VCjwWkMCxrQVQSCrC1mmj/aTDfWt/W1YsNNdyXKBRcFJiTjVf?=
 =?us-ascii?Q?t0d58FLZjdqwWhX7LohjwK0FHDukTNAHDOhiMJ9UpQaKHh80Z+UrHM7K8VjH?=
 =?us-ascii?Q?PAXqBJlrIA8S3x+uAh/VO+62Yqwf2a+XXJ3o1FoKhC1utMBVnI7ttGssyRDR?=
 =?us-ascii?Q?2zGkSwIc9aSIn+14L5siOsdfqBxJKboPHdISC7bhScvrMJsvgeKBunoLbVgZ?=
 =?us-ascii?Q?gQyOgCqbhqxo13I7DsK94AUpxS1IkA8Kc8NDpq58mCjvSg/jNSuGe0CdOmnZ?=
 =?us-ascii?Q?dk7xQDuwsRdU1D3e89XjlMVZeIURJD3rlGApJfQkrVpODOPVOZ239SzyCf2d?=
 =?us-ascii?Q?sHyK8UdPabXpqiszpeVQ6GhL7fuZVmC9Kmw2xwoixOhnJgHwHoQCgwIWeCVb?=
 =?us-ascii?Q?Y2TGUBZ3AJA4a9Pkn/4Gg70=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcb918e0-acdb-4a0d-b36e-08dde18dd392
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 15:09:01.6571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oZuykpNHXStCzS5RqRfVXCCeKnzwV7dtWWo5AKu+sE9O7w/3wlKgGurc3uvZqrI14JQXwntoeoPymVdiqZYwahq1ZXu0zsIWKf2/0Y2S9M/fWta8hRtZoVjZq+FRaYsJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13854
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 22 Aug 2025 15:09:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19950

Hi Pavel,
Thanks for your review!

On Fri, Aug 22, 2025 at 01:37:27PM +0200, Pavel Machek wrote:
> Hi!
>=20
> > Dear All,
> >=20
> > This series adds support for the CRU/CSI2 IPs found in the Renesas RZ/G=
3E in
> > Linux 6.1.y-cip. These IPs are similar to those found on the RZ/V2H(P).
> >=20
> > In addition, it includes patches required to successfully run the v4l2-=
compliance
> > tests against the OV5645 and the entire media pipeline.
> >=20
> > This series has been tested on the following hardware setup:
> >=20
> > OV5645 image sensor (Coral Camera) =E2=86=92 RZ/G3E CSI2 =E2=86=92 RZ/G=
3E CRU
> >=20
> > The series applies on top of [1].
> >=20
> > [1] https://patchwork.kernel.org/project/cip-dev/list/?series=3D993368&=
state=3D%2A&archive=3Dboth
>=20
> I'm okay with Renesas patches, but perhaps we can skip ov5645 changes?


Patches for the OV5645 image sensor have been added to pass the v4l2-compli=
ance test.
However, if this is not important, I=E2=80=99m okay with dropping those pat=
ches.

Using:
	v4l2-compliance --version
	v4l2-compliance 1.26.1-5142, 64 bits, 64-bit time_t
	v4l2-compliance SHA: 4aee01a02792 2023-12-12 21:40:38

We can always add them later if needed.

Thanks,
Tommaso

>=20
> Best regards,
> 								Pavel
> --=20
> In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
> Office: Kirchenstr.5, D-82194 Groebenzell, Germany



