Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068AECD5BC9
	for <webhook@archiver.kernel.org>; Tue, 26 May 2026 02:03:06 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.28790.1779760980029482792
 for <cip-dev@lists.cip-project.org>;
 Mon, 25 May 2026 19:03:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=nVvjbvCM;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.134, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1779760971;x=1780970571;bh=gyR423nCbuIU0rTGZp2gNVa9RPUE6ztxzN6ob
	0Ie4T4=;b=nVvjbvCM03eoystevwABO+lCWHKNHQJzKmX6146/vrobP1Q5DnJ1Hh7WgYxUawlf7o0
	PfEkCHKhCYHaoQxvqQDQSNohFxIkI8xh+oFTRmZApSEPRJkBc73GLi3O8uRGtwe+PpXcOE8icgwJ/
	nEUnxVnyVt0kn3HVCry/2pFAkcl0PhTQFAlAazKaD4paM6lgqWBKG/wNifL9TJFhaZuXgyLxAB3El
	sXTH3FHzL5eG2sgn9vwtODujir4KG0x/stoxhDks408ureQ7WDwDkbqLerWwSux3tlgh7O3m7lrz8
	b8yDeoQ3JgLl2VGjoeVICMktBLJsqBmZ13pNsjr+bONw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 64Q22oWc053249; Tue, 26 May 2026 11:02:50 +0900
X-Iguazu-Qid: 2yAateNeuRtWXTW4mW
X-Iguazu-QSIG: v=2; s=0; t=1779760970; q=2yAateNeuRtWXTW4mW; m=tGYiQG/qVUQYntPWJ290cA4OWNQyKGpViGgV4nQfv4U=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4gPbcT2rSLz1xnZ; Tue, 26 May 2026 11:02:49 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lc8PeerJrsfoxe0zMzm1yX0EiIBrC9MHKzRA+I8U8OA7miJqlZqVX3nbf2VIGordW+ne3CDGefU4DpB62jWoGO3RqLNgXcGSxzD3yi8FUS57JfQ5ZW+A4EhglXmOQCoij0c2UAxvuaaiLZt8JRUJmkmm19XKcGTBTwLudIAtTJG/Qm2RjjHcDN2Bw1R9x7426xHa8h4aTcm0zFcI8GJiLsmch1VG+co+q0VsH4uTbtrrQ9eQUa8hXZauy9vUIJea+ZZ2oSWp2qBqp2UwOqlnpphaRXfAgayDiQNAPPvvabIaouy4O4nJjtX5BrUBOcJjpm2+BMPnBa0NqDLVpEcafw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CE2wesxC81mk/1amSA59DYkChd8krGVh9+RyY/Ibk0s=;
 b=UL9yrqFKjwPh9eJ8rssDJ9RHUeo+k+m/FL97zi/2+TLXmGsTEsjDlOeeuQpJW2kFB9Cikbt2WY8YENr4L5OaR5qIUofo2AOYKYdsLF5EX+Xl88Sj6dRxmTbCjgFWSw1JE/UefcA5ks9mWSUntxmZoScj2oncRN59OBh5NNknq9y/OSR6PW7RJRZM+8g4s6jQbc/l41VR8G/GncvfFh942jIM+kJ+7gSjXVOe5ADK8HRAO4GYZZ+QTgs6vUzwjGMTLUXaUADGeokyYV0DSDkzq68c/GWp05QMXH5Oqfw9xOUOvguQrcAM2Hc8bEZjFzM59cobIrcaBfBoYr3uyQimog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <uli@fpond.eu>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] Request for review for 4.19-st17, 4.19-cip133
Thread-Topic: [cip-dev] Request for review for 4.19-st17, 4.19-cip133
Thread-Index: AQHc6QcxxQUf9vfQQEqDgfdx0upeTrYehmkAgADuP8A=
Date: Tue, 26 May 2026 02:02:46 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB1481859E0B2FB49D324490575CD0B2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <516262162.225768.1779356981051@webmail.strato.de>
 <ahQb7MAc-usvN_Yc@duo.ucw.cz>
In-Reply-To: <ahQb7MAc-usvN_Yc@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYYPR01MB7878:EE_
x-ms-office365-filtering-correlation-id: c4e1c958-fe46-487b-8e93-08debacae178
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|56012099003|18002099003|22082099003|11063799006|6133799003|4143699003;
x-microsoft-antispam-message-info: 
 4alvrPKlisNVtqfqPIDlcYe8x5OJtTlCn73tE5u+eVv7TLhOhrlOeyVNTKqwA+xmTGi/sHAUzM2+co2v91UzP2yW9P76y0IxPZ27HxjQV5LiEEP+JPNj0GdkyF28YV8Sp8lGFe5yn/H2SSQIKPUA6Q7CGloztq5F1YdPV/qGuApvPKMof1zxD7qD7YaRzLpcOwj7gi7c5rECCKQY/nzEdKs9UI/ZfdbjC/dBL/bLQmLYBD9s/r2d/+01MwA/qmdFyAJrLinNB1sx9vdzigoNeLrEe94hiJYqcwsiUuLsLecdRtKbMVSRurVU9mTZIQ01mJ4zMAoDGIOq0zntbcJ3UUTyXhZW6+tjRcDRywiaheDkbukMKOvKEl/wZBfwlsrezZYXcNHrXY/OVfvgil4tGJ5pgZZSPr7LK+BNboYkwM8yvP58ZW3/nltG7EoeAkaBAoy/3/kGVB+eGHmMf3wOIkIOYbLu4pcxem9cmreN7cpmlhjN43XwMgOCseEZAjaTpcKd5svcf9Qcy/NFcLZNu0YEhzQeNI/iS9b60mUADTBq8EmmMDWHx7x8OAxXyLftCRLjdc+8Nk31NYo4pjRBmdDiB5LHlviAQP5WEx98i4fUVUjv9X73fD0PFq5kkcZPPr+gDdOugYe4TLAva1iWco82rVaeCqX5lGEINV48nTH4jXFcnh25+HfUKPk6BWCdG9ToHf8ACxbKCO9R2IQP68Fv6/aSxRCsiTO4vzOi0jHVH37jaheOtF4J0GqqJks8
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003)(11063799006)(6133799003)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?UXM0bXNoSTVVbkEwbko3QlhUUWlKZ2ZVTUgvTzNjRkJrZVpTOS9KRlIy?=
 =?iso-2022-jp?B?S0RQYXhQT3JKWWFhUnFMb1NURGZta1VMRlliY2M1S3FYZmtSSEJpZTVM?=
 =?iso-2022-jp?B?NWhLamgrMWtYbHYxdW94dS9kTHZ6VWwydXd4NEttOTdOU3VtVjY3Wk1D?=
 =?iso-2022-jp?B?YXUyNGdycWZZMkN2eVRRUHJhTXZaSE90Y3k2ZS9lWlBTTkVPTlV0R1RG?=
 =?iso-2022-jp?B?VHJ3ZWNGcWp3cDRzcEhxV2lqaEd2Zk1UZTA4V0FTOGh0bUpob1hPeEU1?=
 =?iso-2022-jp?B?a0x0c1dSTnRlS29JbjRCRlVzTGdTV1pPdWdnTjBoemppNzVSQ1gwMmlW?=
 =?iso-2022-jp?B?bzVQZjdxbE5TTVlSTEZ5NHc0c213WmlOVXk5cnBTN1YyR2JrdGF3SUky?=
 =?iso-2022-jp?B?M29RVGV1WVI3QTRORTJjTU5ueTBlRzNTdG5yckxZdzF0Q3FFRXFDNU5S?=
 =?iso-2022-jp?B?K2xyaEZYZ3hkVG4rdWNvQW5RSGEyTUdiVlFuQ2swMWZuYk13dWZOekpv?=
 =?iso-2022-jp?B?RW0rY05KcVBwcS85dmd5MnpaQTdmbkd4bWd4MkZtY2JzM05xSlRaUzhv?=
 =?iso-2022-jp?B?YjRJY0N2eitXbVpQNXZhaTFuZVcrTFdMdnRISUN4Wnd4c2FmR3g0ekNp?=
 =?iso-2022-jp?B?UHBiVWQ4c0RVcHh2bVl5WVBGazJsNVA0SmZOenFlMjZTQytOdDNvZzYz?=
 =?iso-2022-jp?B?cGw3bDNQRTMwRUhuamU2eWR1WDVlQWlSSDhhOE13bU0xaCtCTitXUm5M?=
 =?iso-2022-jp?B?cnA4d1FiMGN2cm5GR1d0WXFwZnl3eWVMS2ZrTnFHL2ZtTERhZFM5SmJC?=
 =?iso-2022-jp?B?OGU4VFVFRDhFY1VOdUg2eFlrS2JWOFdKMWpFb3RmT2xvaTFWZ3BpdkdI?=
 =?iso-2022-jp?B?a2ovN054L29XMTJGKzExdkZTUTdyT2RUS2RvTnE3UGx4YTlUQ1JkU3lU?=
 =?iso-2022-jp?B?bU9lM0FEeUdNUkptcnE4a2o5UlQ0ci9vZm9ub1E3aS93cXhpVDhFQ2Vy?=
 =?iso-2022-jp?B?RzBxNlhQbk5mbVpnSFJBRUFlNDdIZUdYd1RMM2dhbVpwaWltUkRjM3My?=
 =?iso-2022-jp?B?S3ExcVJNbUlWWnZLOE9DR3UvYUNkUGdYNlZacjlpZVpmUndPbWRxS04y?=
 =?iso-2022-jp?B?dEhuU2hUNytuYUVjOS83SFh0VmYwc3c0K2Q1TEJ1aFpxcDdUZDAxRFZ6?=
 =?iso-2022-jp?B?WHpUMFJtUzIxQnJYdFU5eUp0ZFQ1SjRHVzFaQ29sRHVGRnI4QXN0T29j?=
 =?iso-2022-jp?B?bkpDRjZGY3IyRFd1dUhyaFJvVTZGczNxUlhvWS8vRGh0TlFndzBiZ0tx?=
 =?iso-2022-jp?B?b0t0bU5vKzc3NVNrZmk1NmN2dm9USGxaYnp6TmhBdDQwaFlxMUkwQUJv?=
 =?iso-2022-jp?B?YmpMWXJ1SGkyTVM3UXNJamRIM0FHK1Q1U3FQY2xGaloyWDlLRHZtT1Y2?=
 =?iso-2022-jp?B?d1dUMlhHQmxzSWQ2d01OU05rMUZSdHhqaVVDZjlBUGliQlFVQ1NoUUpR?=
 =?iso-2022-jp?B?RWZRWE9TdmdkSzZKUkx5a3RtRFBpanpiM21zTWRxdVVKOWdMWmZ0REp6?=
 =?iso-2022-jp?B?TWwzazc4dzVkVmJjTGhHSWgxd2RSd3k2UGF4ekVGaUN4R0lyOGlDbmU5?=
 =?iso-2022-jp?B?RjN6YUpTQWlnOTQrUGpuSjdZQ1NSK1RqU0ZyZEtXUzZRRDBCL0syNHJY?=
 =?iso-2022-jp?B?aFAzeEhIaUpSNW14NnoxOGdkSk9ob09sTjkreWRWcDJvaXpQb1FUcXhE?=
 =?iso-2022-jp?B?b1IvMGpHeC9aWWphRDA4MjdoOTJjZzdFb3A0VXJ1RDB5WTcvRHZXMGl1?=
 =?iso-2022-jp?B?V1g3S2Z2ZjJNYXp6Tm5IMkVRSFQ2NWszMTk3Ry93M1VQZ1dwL0NvRGFx?=
 =?iso-2022-jp?B?cy9qTUgzRzlwNXRpWUlnZnI1SU1tMDVmODJUa0wweG1CT1d0RWlVZ2xD?=
 =?iso-2022-jp?B?akU0T3BsMTFPZHYxbS9Ib0VENHVIWkcwbDVzb0ZlSmdUT0oxYjBXcjBM?=
 =?iso-2022-jp?B?WVE2Ky8yN2NRbFR0YzFxd3RySUdGK05aTlhBcDV0Y0dSR2dzU3UzQnhy?=
 =?iso-2022-jp?B?QmhmTmdWblMwQ3djd2lkd1EzZmxRa1prSmxBVUp6MzY0M0Q1NGEyYjlL?=
 =?iso-2022-jp?B?c3JWbmx6bDd3STg3K2hVR2JhQ1lua1JYMyswbUJPMU9EUWJadm5VTCts?=
 =?iso-2022-jp?B?YkxGR2NNUlJxa3Zsb1l2YlU2eGxaeE1JcGhsMzR1QUgzRUJqdlhLdVpw?=
 =?iso-2022-jp?B?aFNDNGZaT2tWTjJqd1ltbkdQNERJcDcrcjdZMzY4UFcvYTdnN3JuOVVM?=
 =?iso-2022-jp?B?VE9FelU0VVNET2gycFdSV3JCWUVDSUNmbTZYc28rT2x3V1lacHRNVlBQ?=
 =?iso-2022-jp?B?cy82ZFowVGxyKy8rd1RJT05lUm1YeHJlUHc5QlBYYVR6ZlE3NDVQMmQr?=
 =?iso-2022-jp?B?RHBSU2M1cGJYMklIczVVY2VtdzU5WGxoMEszbzZBSVA5T2NKMXU0MTJC?=
 =?iso-2022-jp?B?V1EvNDg5ajNQcW5rc2FabXhUZTNXUlZkeXN2QlJuMTVYb0R5a3BXMGVs?=
 =?iso-2022-jp?B?SXNqcExIOD0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	BCOKfIvvJT6UDUXatXcIwlKzXnpZJjuH0mIn07yvaoTYGkW17qE25JMnYKPvi/FTn5IOxWovBfzHazFCicCRZ5se9GiwXMy9+hhh8OUOhvtyZkX53pkUAhdSJpwRAOUcKLpZxksmloHTGJiaUIRSg9ZvKIipyVEviiz+EtyzQUAm6yXiwPSksFsCoC7x12O1q1MsqJQv5YnPDtk6abpqQkCLQyziDpxA8j52z49F8onYuD1TGG7cUEdDPLoffwJq2P3sv8jk/sezl4jaRznqw48s1wSUnE2XzmXAKHVj2g4nsV5yOBurPEaTv6RQaU6wtokowhJj5bQEO8vMq9Cu6A==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4e1c958-fe46-487b-8e93-08debacae178
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 02:02:46.1868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vc+xLRJm8vCIFZgSOI/lhOVuxQkBqz/iA80H2nh4FbdAstuJGLfIjWgETy1SSVbe0HJ/CVJKUlINOoNf+U9NoLVG536RIG+jkQb0481UsfRaqjhb0lxVS6ouky0Zt9+3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB7878
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 26 May 2026 02:03:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23011

Hi,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Pavel Machek via lists.cip-project.org
> Sent: Monday, May 25, 2026 6:53 PM
> To: Ulrich Hecht <uli@fpond.eu>
> Cc: cip-dev@lists.cip-project.org; pavel@nabladev.com; iwamatsu nobuhiro(=
=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>
> Subject: Re: [cip-dev] Request for review for 4.19-st17, 4.19-cip133
>=20
> Hi!
>=20
> >
> > Here are the manual backports for the upcoming 4.19 kernel release. As
> > always they can be found in
> > https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/
> > ?h=3Dlinux-4.19.y-st-rc
> >
> a just a hw bug workaround > b7885f23ff4c9 x86/CPU/AMD: Prevent improper =
isolation of shared resources in Zen2's op
> cache a just a preparation > da51b237e7bbd x86/CPU/AMD: Add X86_FEATURE_Z=
EN1 a just a preparation >
> e49d8098895b4 x86/CPU/AMD: Rename init_amd_zn() to init_amd_zen_common() =
a just a preparation > f7c75253044df
> x86/CPU/AMD: Add ZenX generations flags a > 874e7cb1436fc ptrace: slightl=
y saner 'get_dumpable()' logic
> >
>=20
> Looks good to me.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>=20

Thanks for updating 4.19.y tree.
Looks good to me too.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

> Best regards,
> 								Pavel

Best regards,
  Nobuhiro


