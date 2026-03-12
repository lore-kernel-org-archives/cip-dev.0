Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5E7FED2C6
	for <webhook@archiver.kernel.org>; Thu, 12 Mar 2026 03:35:34 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13929.1773286528263158417
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 20:35:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=IpznWLid;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.135, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1773286526;x=1774496126;bh=lJ8jo/a3E9Y1R/Gz3r3iZU3bhYvcDvsJ6l2MA
	Z76NF0=;b=IpznWLidcGHBJUgrMa8gEnnTZ1581hrEzoCN/aVUhDYr4dEQRedqxHlwtPQK1b1nKlp
	FOVSwVECDfQrWmDdWIVZWt21Fl9Nn9cqT3kQFsP+MfzKYD2IUbkP2W6s2BZKUcQ3ZHEv6DXRjNUOW
	QhX4ahwyssKq9abIbsxiqw9ODAKSc+iNaXQXrmkX5+uhMySbdxQhw07l5SazcJ/4ITOS0LA1jNxCf
	IHgRO1DsS9ZdkOV1KZKVARJIcQOMIyil9Teq41onYqyR+ZOhZaYMzeIIwlyqjn00Kd6X60S7FV0tj
	etGjmfTjPqzfa89B/vdpkYz9SU3gSmgh3DFtG/PXW++w==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 62C3ZQ0m1296144; Thu, 12 Mar 2026 12:35:26 +0900
X-Iguazu-Qid: 2yAaH9EEFbgBlbh6bT
X-Iguazu-QSIG: v=2; s=0; t=1773286526; q=2yAaH9EEFbgBlbh6bT; m=hlF9A0B2+Kq/L9hT9qKaKY4VmlQAZGP7i0tVrh93ng0=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4fWYCx6hYrz1xnZ; Thu, 12 Mar 2026 12:35:25 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rM96cvE3wN/Ot2ieLpw7Vc8zoO1M4mTEvsqJRt8tRfE11sQpOqPkJRyKXMFQ4dufjJ43HEjL65L+1J6bzMWiBoSrU2ncwTVwFE5MaannmKanE12k8JA9qAYQscYPukKEy9t6dSbe1Nd1pUpJY6kSuheidSC7aGgvlW+iLZbNk+/Mokpy7HN+W4TLq6yfWOhxz5vBfm3BJYPXTKwUZL1M4DHEcSv1dwyDjdi0BX+ICnYUDjyihM7l+iw8W4X9SxXe9CzucW2btx6BlrKObfJ+MRvz/O0Gx6/gEMhJNpv2UwkJ+t2z7jRkoexX74LkaDvxHxX0LFWbyFlDGPG9DkpY1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/7N+2KSeE70l9HMF4xQd+wavFxFYwaxcsBZCOK40rw=;
 b=iXqDpYGfKxwRRznZgQp2F4Y1laQvAw6I/nrExd26mbBUlgrFiYHWAKqxh09f/WhmEN4czzxuRwrgD/1Wfx29fth7be3Q6Oq04WVpjpGKyHYANYiw4RUmnCtfd7Ex40kxT0bobmcUvSv2ZaKsTGBQgM506xbzkZ9lx9WYdaCQXURpCOhY4iCTz8VqGI6U5s0OQ21TdE1FDgFXWVwjilnAix16dUD6JmlF+lOXQNYNwl11n/p1UYopENu+K3MYdIdUVcDjVGOy3FurdhP/NUnT1EtG1evNIo8PzIhrWYo+tuyqc5xWa/Y4Grv/fEpTqiS1BqmvobBK6lThc56/B5N/jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <ovidiu.panait.rb@renesas.com>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [PATCH 6.1.y-cip 0/5] Add RZ/V2N Interrupt Controller
 Unit (ICU) support
Thread-Topic: [cip-dev] [PATCH 6.1.y-cip 0/5] Add RZ/V2N Interrupt Controller
 Unit (ICU) support
Thread-Index: AQHcsKWzmUzi5jFb40eL2iSy9F4KEbWpI9cAgAEdREA=
Date: Thu, 12 Mar 2026 03:35:20 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818464128408AD131CF20F1CD44A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260310155050.39087-1-ovidiu.panait.rb@renesas.com>
 <abFFFqQp78B8reP5@duo.ucw.cz>
In-Reply-To: <abFFFqQp78B8reP5@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYYPR01MB13281:EE_
x-ms-office365-filtering-correlation-id: 20b73213-71d9-445d-a195-08de7fe8631c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|22082099003|7053199007|56012099003|18002099003|14052099004;
x-microsoft-antispam-message-info: 
 t/WGDJW4XxuY3ezSjG/MlOAqmplsmYxS6KYGvVjOcofwY39bdRHkbjLnDMtOZ4YMnM8WdVccyiRfIhtmQ4bUZtqkgwnKmi7VUVi5K90DlyOytxq8ffitvhGsWLw84ZmH504mcPL8h1UKpkzPtaLibXYVWiI+BLklS1oghtVBO6OxKHUtsKgYd/wCc/CE0wLr1OLe/c0VKSX26kx6Z0tOi4POcr7uwZ1Y6MDpQCrthX9cJwF6NjbZdNjhYvV91WlumxlCxrjV84qh4lt4uAPVDJakuIzTQchtTlvpmiAPUYgEwVCKkpoOhvV+fn7uFa+b+0zFKAEJxcPYIKIVGaAN5RXRMU289rSgb2LeXC/DGxWzXlagCCyrlARaBWXvuJhEvTmWyyJpEn6CTeJff9qLgVTG8lftrz2MUl4s9x0jpdfEls1Qq2o7ChgD2TRK+TOHDcbENwEq5bFUgct8t64NhDoZRi7pocoGhE0BQbhslps9tipGi0WlK8DOHuIQWiPMaFcgUCl6/66OK6dGzFZ+kM+lLf4jnUl3jSQbZ9UZJhH8bOyPlV2Sp/onYf2nCT1YalWWQMaav6+b6WpSAQU/N+fLkVWkuCCmr3yoEw4VRtpsuWa5LYGG19hGyKPUo2eS5Da5jPfTz9vyPoo8FL+HdmLyDJq3/gBh33ezbDqP85QfD9qEPT8d0we8T/WI8OD4MpZoCQJnC2BMhiJ8Z9kHtkjnK++MvmTiRqYSc6k7liM8V77me39nT435OkYK5zQ7B/vPBqdsFrsSQ7TiUZMaxcY71kKzR1QVGPWc4hp2pmw=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(22082099003)(7053199007)(56012099003)(18002099003)(14052099004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?R0N5MFhKS0tkb2FoeGh3WVZCSmNyQkdrK2UzaGVBVVZQZkYxdjR4WGlK?=
 =?iso-2022-jp?B?eEptUENySzJ2RkZxUXc3UUVIWU9FWnRRVUFSZ2x3VjM1TUFPaXA0ai82?=
 =?iso-2022-jp?B?Ti9Benl1ZHlack5HbzkyYTkyYXNqOFR5cVFLZjA1bXhpeDZKeE4wTDR3?=
 =?iso-2022-jp?B?K2dZTXBjRGRaRENXMUQ0cDFnUXFVbWlKM24zTFdWbEYyQUZHTUdBN29j?=
 =?iso-2022-jp?B?RUlUYjZOTlI0OWw0cndrTk10Y25kNkFiSi8xUllPSHpwVVAvcDFHQ0Zn?=
 =?iso-2022-jp?B?RnJzTW1HUWszc2oyNHNjYnZLM3BUUUZpMkpEV25MemczZ29NMHljdGlO?=
 =?iso-2022-jp?B?NVE0Y0RBd0pSYUlwT0ZVc002QUhuTjNzeFhuN3IyU1lBWGxmWTJFMUQ1?=
 =?iso-2022-jp?B?ZWNHOFl6eVE1aWw0MXZqR0w3ZkplV2tvb29vMWRrSWZqZVV0ZWpPVGlu?=
 =?iso-2022-jp?B?Y1E5RGFWQ3c3dmNWQ2xVV2tUQmdWN2VuVzRRVzBERG11NG0waFh0ZzBS?=
 =?iso-2022-jp?B?NVh4SzVRdEUxNjBTeDNPV0w2OURFdmtqaVpBcjJaU0ZpdXhYYzRTdndB?=
 =?iso-2022-jp?B?RW9hNUY3TXdMVkxLNnl6c3pWcnFVQVJSQWNORUtNMXhZRG1MNzlWMTNo?=
 =?iso-2022-jp?B?ejhyaVlpN01uakEzWTdldWJnd0F1NXU4bFhYcCtRZjUzT0l0emZOS2xp?=
 =?iso-2022-jp?B?ZCt6VVozd0ZRVFlFK2t6MXFVMExhVUhkNEs5bnhid0Z1TisySndwcmEw?=
 =?iso-2022-jp?B?TTZlYmRvYlEydUlpZWIwcWdlMk40bHdOZVQxTW9yRnBpR0NFcmwzeXBV?=
 =?iso-2022-jp?B?ZmZNY2t0eEN3ak92eXhPKzE1bW95NmFKcGRhNWVjSnVhYVZxU3l1aktq?=
 =?iso-2022-jp?B?SzJJZXAxanhYRk9aZ0Vsd2pQT1ZXc3E2d0lERm1OK0ZBLzl4V2ZQS3RY?=
 =?iso-2022-jp?B?TWpYNzduMmhldmRndm4zWE5hQzNtSnBMQkhlN1FmME1pNXhXd0VEaDQv?=
 =?iso-2022-jp?B?SmFDKzUrNkM2U0FndFh0ZjdraDJDWTV0c2s1aWhQMEFtZC8xd3dkVXgr?=
 =?iso-2022-jp?B?Tkptd3d5QzFLS2M0dnBwNHJxYXg4ZEQ1M0o2bGRIRTZ5WmpGamdueWdV?=
 =?iso-2022-jp?B?VU9Xdk9Nak5Ib0ZFc1g4NXdodWgwRXkzV0l4WGRLdXROeXdYSXhIM3NM?=
 =?iso-2022-jp?B?MFoyZ21SZCt3TGs5RzR5ZzhITU5aS0syT3JwOE1LQzJwSTlQZlduQ1l0?=
 =?iso-2022-jp?B?ZEpGUGsxcU16TS9WaFN4SjBNd0RrdkFlKy9neGpHT080MmhOVlE4OU9s?=
 =?iso-2022-jp?B?WGZSN0RmNk9vSjlZZnRQTEFCeDFkbGR4OE5hT2dIVUxpaFNDcFIwNjkr?=
 =?iso-2022-jp?B?UFZ6RnFYYVd2MG01QXFPV2J5OXZVSy9LM0w5WEU3YlpER2F0UTZDaytZ?=
 =?iso-2022-jp?B?Z2p3VVpRTzc0MmlFYi9Db01JOE1OU0JOdjBqOVVmK2RQOWNDMkhQclM3?=
 =?iso-2022-jp?B?MnMyRDJ1Vm5NNTJQSXFVZUlqKy9QR2UwUDVDMnlETmQzaDFCWW40ZGg3?=
 =?iso-2022-jp?B?SUF5MzZPNXd3Y3o5TTQ4YmJYOWgvNTJ5bXdqU0RiZS8yTVpONU55SnRi?=
 =?iso-2022-jp?B?TEsreEFKdlR2VXhkNEVmMWg3ci9nL2tTL1JXTkNLWktTdjhEVXpKdUsz?=
 =?iso-2022-jp?B?NFlOd0hSNEJ4Y2hscngwNDk4dnpxZFdEM2ErNjA0WFA3Z0lheVltQ09K?=
 =?iso-2022-jp?B?dStlTmpjMTh1YjBScXI0a0VNUEg4WVJFbzcvajhHOEVjUEdRa3FRT1Mr?=
 =?iso-2022-jp?B?dFAwTHp6QmU2S2g4NVI4aW8xUjhqc2U5NWV5OVI3Nk1MMnU2VjZvaFJi?=
 =?iso-2022-jp?B?MEcwVlBSK3FJbkc5YjhHYnpnd09ua0NobC9rUGJkRmRROVFiK2xuM2tI?=
 =?iso-2022-jp?B?YVJvQW9lbDRRVVZWeHZrRWtUcHp2RlN0TVRVdG5wdlVoRkxNMWg5OXFj?=
 =?iso-2022-jp?B?RlVLNER0dEtEdEgyMFBib2g3cVlWUjg5ajM3SVJWYXRXZXoyOTRpdHRS?=
 =?iso-2022-jp?B?RGIrMzVNMzExUUhlYWh0V0FoVjZBTHJXeUEyak9IaG0vMXNsZTZmanVQ?=
 =?iso-2022-jp?B?OVhRSEo4QXVpTmdSeU94V0tOazhtRWFhK1NuOHhjTVRFNTVIdFlNeDIy?=
 =?iso-2022-jp?B?Q1BYVmNubWk0SGxnbjJhV2QvTUxFS3EwZHpHVFRvUVR5emUvR1lOWjg0?=
 =?iso-2022-jp?B?bHJFallscWorbWNYNEZTUGM1dVJ6eEdnL2w2d0k3U21SUVRmVDNHUXhN?=
 =?iso-2022-jp?B?QWdNTzNZZkZIbjI5cDN2NXZyU2V0WEVvaDZML2xzZDF5ek9QamVkdG8x?=
 =?iso-2022-jp?B?VElJUFBjWEVmRWhTNE9rRmhHWjNUcnB1NHI2eG5KK0g1WXk3MUc4dHhT?=
 =?iso-2022-jp?B?R0Q0cjVMSFRQNEsrZTd0Y1M3Nm5FOFFsWWFMaHRLdFMyczk1anFTWGV3?=
 =?iso-2022-jp?B?Q1JyQXVTMUVqSi9TL1ppTjlLajRCNm14Y1YwNTJwckFWZ3VVWFBXcW1w?=
 =?iso-2022-jp?B?b1UybTNBST0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	lhkHDQNsx4f+eD34hhirsiP/avMYFkSL48VzKc9LI3T3RYTOIdBKAB0LB92D+BWJJEytsuTcKFcJrYHMpLRsiRTEFgMPfsYrPbhWw4sah3Zz97/aJRZmxjh8cpp5E7ozJaSXwy9WaAg1h1Q/EHc4d5MU79xgzyeh0Iu2MS3CH2ggg+mmifAN1ITvlP7MKA9yVbNlu//mOWKitGxmb2atzfuZfNIRbrxz2gskWrCdFyH4FH+3lUTpqMTckwEGj+45zV7xFUoCLrmGahakYKHuO+7AzKn0XHNuI11gZA1n+3/05Wwe7D/dSnt1fwa2qFtAlJK1ao2gPYO21e/acfDGEg==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20b73213-71d9-445d-a195-08de7fe8631c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 03:35:20.4899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nvdJ2J3/SUFhplKvmpifWeJJDy1KuF8LnFV7m54peNU1NrTJqm46K+jTkRid32x21J3uqYZRDSHBnONI2MFdV0MBfT57TAuVnUB9cmJn4psKSRXzLpZURzfQs3eF2YgY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB13281
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 12 Mar 2026 03:35:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22352

Hi all,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Pavel Machek via lists.cip-project.org
> Sent: Wednesday, March 11, 2026 7:34 PM
> To: ovidiu.panait.rb@renesas.com
> Cc: cip-dev@lists.cip-project.org; pavel@nabladev.com; iwamatsu nobuhiro(=
=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>
> Subject: Re: [cip-dev] [PATCH 6.1.y-cip 0/5] Add RZ/V2N Interrupt Control=
ler Unit (ICU) support
>=20
> Hi!
>=20
> > This series adds Interrupt Controller Unit (ICU) support for the
> > Renesas RZ/V2N SoC.
> >
> > Patches were cherry-picked from mainline kernel.
>=20
> This looks okay to me.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>=20
> I can apply the series if it passes testing and there are no other commen=
ts.
>=20

I reviewed this series, looks good to me too.
I will apply with Pavel's Reviewed-by tag, and push.

> Best regards,
>                                                                 Pavel

Best regards,
  Nobuhiro


