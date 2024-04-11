Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE57CD128A
	for <webhook@archiver.kernel.org>; Thu, 11 Apr 2024 12:28:36 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.9])
 by mx.groups.io with SMTP id smtpd.web10.16570.1712838513127979611
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Apr 2024 05:28:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=DkADfUv/;
 spf=pass (domain: renesas.com, ip: 52.101.228.9, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aae/ZiwOQwdVfd/S3t1gKV9RVutR2t0agYXUX4VfjFInQXNMAr5UhFuE1z7vmHzD+r7GYbHbriPzBHZOQIcCePOlLCMQRs1zw+5e2QxZC+osE4Kbd1XTXhOof1stoJKk91VM61tT0k0G3gjIVUseGUx8XbUJkw5c4UZS+/3rdDYGcKR4OYmdj98pAEQ/EvHKNbXoSyP/rwhuqJ/vG2CSdoKzHi7ydAd6B9C96Xm6wDciYZTNT43k5Ks3Rlf7ulnWTVbxvqNJfYA+M55OCCPGYH3JQs/MMtbfv6twaWs/uXEHkdDf+yqbfRN6+j/iuuHutNizmWvld4GQOVoB3AXPwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m7mDzoNbeF0i45L0dPG6/hurtx7NjKJhr/D06W3nDNI=;
 b=RsuHMa/sEMzL1rxTdeacMYkqYDgxPmKogpD3DiHZiR606kY288fEWWXxCP44jMEE6xtldYJAsckaZvUlyiwLferY52JVGS6odNsOgQp4q47Y1jYv1vUPYrbkrzsGEyPlGj5lfEbeLvGnON1aQ/dSdhagWXrr8m3Pv6b/XtZTDjcSk/CI5LF99WwKPpQTV4ATI0Uf3oaFyKrNSAugIQlRoBjVJtoZCbZdEpL+5c6UadMzi7ZTWmZsgLG2fzUywk1QNxY9cGx/+fo4nhCDKOhHKBXeWmZeGiDZmyAI21BP3s/wO0hSCfH2sr3INHXuiZhac0IGwUcRjeX7HQvi4xcwQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7mDzoNbeF0i45L0dPG6/hurtx7NjKJhr/D06W3nDNI=;
 b=DkADfUv/uluEfRgMz1eiNYjKpzqTEM8HWWPhMQxAagaZK3YJLFQFn1mk9dzlYCiRn8HmJ8MwwJj46zMVPuepJBFnEZ0UO2vcCSjK9OLjf79f2zrVZDq96qKhDk8L4F9HpZB75JrSyCv3/4wrqTg4fmxwRkOLqdRe689uGU2+J28=
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com (2603:1096:400:3fc::6)
 by TYAPR01MB5962.jpnprd01.prod.outlook.com (2603:1096:402:35::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Thu, 11 Apr
 2024 12:28:30 +0000
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::fbad:9a9e:9e5:7cfa]) by TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::fbad:9a9e:9e5:7cfa%6]) with mapi id 15.20.7409.053; Thu, 11 Apr 2024
 12:28:30 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Pavel Machek <pavel@denx.de>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
Subject: RE: stable-rc tests failing in squad
Thread-Topic: stable-rc tests failing in squad
Thread-Index: AQHajAjfFw8yP97vXU6NqejUb60EWLFi/eFg
Date: Thu, 11 Apr 2024 12:28:30 +0000
Message-ID: 
 <TYWPR01MB11862ECCC93AA258CCB698EE2B7052@TYWPR01MB11862.jpnprd01.prod.outlook.com>
References: <ZhfSkDGKBRR+p/Bs@duo.ucw.cz>
In-Reply-To: <ZhfSkDGKBRR+p/Bs@duo.ucw.cz>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB11862:EE_|TYAPR01MB5962:EE_
x-ms-office365-filtering-correlation-id: 3d60366d-f2a5-4199-20a4-08dc5a22e542
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 feBqm/qvyNvSnjbIn3o091tjIf45gpqZFdHgB8w2+tRx0C9MraFsu9QPFLYxH3gM6OUAiiMd+HTdsnmkDYu+CCADld0e0s9sjlO+CSNLl1sQ7RfaX0ifJKAjyiGW+eMpJ7OMtdsE6EzTbKUmLBnlCfO8+ddFJ9zTxANj3Hev2bgriS1pg5K5ZRCn6EMnpcEEL68cpQrKpSRG1i6qEfHy41rKV8LOQQXpQHzcSgt8GlPgCCugRHaXKX1gI09RwIDhUWo5J3edNHzDdxGyPj44MwlhwCJ1AADwYEwnj6ECHQ7cfs73WhRjzaDH2depVgBMe8JWT2gwbUOl9Fy1C7cWxj0X5N1cJN4aRAUB2kN263iehypaiXfnA6FxUVTkAH2MEgyTrjv//b1Te//npSkO7YmG0K5q62u6IbRuC/sz66nVJJlJSMbm3b8jIXl4bYH6YrykIAjozc2HlsVxn3kMmdUeeigWaxDVhGH6JMC8a6PlH2J+ZqT1k7awJXsXflOzhznzp86ceDyyl59LqHk5jP9CsqFFAkkch4C3bM4GqeeCxB2Usu9ZkEfoBL2Ulwgv5tVqZHZFAMDB8SL9kwYYSLYmXU2rNgANxV5tY5Q1uOBvsFwGypToKVXDlW0J0+wWXz8w/t1IluRhCuvEqZavxSFWLyKgFx0QfxA6CQWz67U=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB11862.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?fROoadKN9neLQl+uVdDs5Xr1YBVltyfirc7CPtDDea54G+rpKf6cr3cd?=
 =?Windows-1252?Q?a76yJVVMR5yceAFKAf5bWBnRDYfAUMwlChxXL5EologFd6tLZFo44OCZ?=
 =?Windows-1252?Q?Huz2fKOpmD4t68xCtUqyKb+zE3MCvuY4QmpQeyoYTyyNDgQHHTDBGmaH?=
 =?Windows-1252?Q?EuVcFgC+zwDZ2Wu51c7E+Gx5Jey1Vnj9yYHUKMY5IcqoCkyuMEEi0uQc?=
 =?Windows-1252?Q?lKPeuteguvfd2zA1IDAFklWXjb4wb4XAlXF+lhBgNm2Fmnu+03pZB1QC?=
 =?Windows-1252?Q?uf5cKosuQIJVQ2dzxqhlMW+ssjQqfwPad92SjXa+sEvJsqlhpkElsWoK?=
 =?Windows-1252?Q?1qciFXhiOtG0VEESx2yiqaccLjomPY1WGVtkqHRLS0uEU33DyPbDPpRw?=
 =?Windows-1252?Q?buoNmfsoU5CEjlmbmJv6g8W7mXo32Jk5hXmT6juDzpNQ7+ANSd2qnqup?=
 =?Windows-1252?Q?hQX0k77D4Bgqe/SZ7FwvZeFbhpnFY9diQVgthCY4MUa5lT22weo+MfAq?=
 =?Windows-1252?Q?NCKeYQ++wSNFKP4fplAvBfWvzqOQUESZf+7ADNigMG8dcfvm2G/Wfcnb?=
 =?Windows-1252?Q?c3Q+8lM7mQU/Ozp7CLz/5y48Roo+9PTLKwLL23bYk8fTS69o56y6dtgK?=
 =?Windows-1252?Q?uzl7Xzt/HFuccGQWTOvLWN3AcN3LNQvaR4Mqh86eqbcxZ9PMs90ZWsiw?=
 =?Windows-1252?Q?vygjHwQ0nl0Tmr5eD/Ceq6FFmrdPbFdmvv6ihUyCxceoWwZT5Uxlfjha?=
 =?Windows-1252?Q?fyD4tVqnjIa50sJxFAFSwaDHWc5sCAeEKcXlHtXh6sMjbH/OQdTE3gKe?=
 =?Windows-1252?Q?/uUOBPaRweF5LqKOaSF95G5rX0G+f1VJMlgzL3rv8IpUVXSnac/wbuS/?=
 =?Windows-1252?Q?c6KQtDLbttcl22sB0AupTpkHLAxhNVRB3SbAKVWbkWHWcTcbXMvWVVQE?=
 =?Windows-1252?Q?SlNkGiPyo4rci2E5MZmWlpD5A+wM3ZdiB8gQu9gEt/wgKYcJsZSJOYN9?=
 =?Windows-1252?Q?BjL+gy3Pki/xmy12ikmx9ECHLmLvrMrdxQaJi6aouRn8yAM/wSX8bn3f?=
 =?Windows-1252?Q?9wAS/0GYlEewt9RTOVY6VgvMLjyRZ1zsKW01+jMxZnlV+kLQKpdGDD+n?=
 =?Windows-1252?Q?tEOFibn2UnDFxP8Hsm/ijbilzC06zC04GsAjQO9btzEkg/WLAjU+FmSa?=
 =?Windows-1252?Q?M5WCMG3gZn8xPTYTyjle0frCWhe7+QwToCB7j472UDJBjKTlzJmmb87e?=
 =?Windows-1252?Q?n6FJXDWcbYlen1sbDJi8pvJofbSoPmzQfc7tjyWJP1xIU84LpAE+gu5E?=
 =?Windows-1252?Q?KoS+nNo/24GxWVHK6zn3aKguHnEPeQY9Ibx6pW/tBGY+dNHNvdhWMKw3?=
 =?Windows-1252?Q?knG6l3i6FLposNqT2BIDwiM4IzQV1tC5Qz/Ta74p4XfEkXwKKw1Wb9Tt?=
 =?Windows-1252?Q?XFYkOA0f/Hovf8gYDKNYma1Xo2o8qMJYsQYur1uevybPvjmD9b4bqElw?=
 =?Windows-1252?Q?8cWiUQmHyeLTCihWfXvJlW4edyEdM8C6Ter6KKU6QarVJX+VE45hQJzL?=
 =?Windows-1252?Q?rmTDR0ZgBDGp97C6VSNW1i+LCZlIVbKwiwMgo3NV76DYk6oLN4JHFZwT?=
 =?Windows-1252?Q?6b0KlB7lOXD1KHpINAPL9Ifq091EPoHy6SBf9uHeW38LakUHSHZhhCNu?=
 =?Windows-1252?Q?ZM3uzK3pD/9/yTa6cGA78+Jhf9CEXhukzAtAXGktebSBm78/9Gl6kg?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB11862.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d60366d-f2a5-4199-20a4-08dc5a22e542
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2024 12:28:30.1267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BWQamz3995NC9utBzlZOrttJxNyKFmCxYngDykV+r4glnQAh47/GPRXxdcDKMyM0Je2Qs+mxm1zbPcJLrUgjYC3c9m6DlVHukxEpGjrtJsE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5962
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Apr 2024 12:28:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15544

Hello Pavel,

> From: Pavel Machek <pavel@denx.de>
> Sent: Thursday, April 11, 2024 1:08 PM
>=20
> Hi!
>=20
> First, I had to retry a lot of builds in gitlab, in 6.1.84 and 6.1.85
> testing. I'd not mind someone investigating what went wrong them.

We had some runner issues over the last day or so.
I believe they are resolved now, sorry for the inconvenience.

>=20
> Second, squad still reports broken tests in 6.8.6-rc1 (and
> others). Can someone investigate?

These are the same SMC known issues we have on most builds.
We have to tag them as known issues on a per-project basis in SQUAD, which =
wasn't done.
I've now done this, so any future builds will mark them as xfails.
Thanks for the heads up.

Kind regards, Chris

>=20
> https://squad.ciplatform.org/linux-stable-rc/linux-6.8.y/
>=20
> Thanks and best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

