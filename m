Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98518CA5FA5
	for <webhook@archiver.kernel.org>; Mon, 28 Sep 2026 22:31:20 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.71367.1790634673772822843
 for <cip-dev@lists.cip-project.org>;
 Mon, 28 Sep 2026 15:31:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=hkID2Omc;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.134, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1790634670;x=1791844270;bh=0YY+gH4H2SrDxwjAzYEf4UOtJNsmg+9tWWI3C
	PdBzt8=;b=hkID2OmcAelF6gvoVJFh6RD/A5C7snOlMOBgcz0UeclaQKAo0KAcS0NnsIkh5TAFCis
	IjlZLaD5/5tFbP4Ei1JHFOQaxA9JXWTF2/iR4WQ3DFeonzk2VEhfYreC3ykAzs5VXf5klZBr+TYE0
	+CvhYPc+p0TAWRGr71QR+XbJqTAp5q1ed0cGFL/4LWRgXiV7nG13VmTNKBiAzTSYzrQdb676TtbrH
	KlIijxrl3jfTx8uy6/TecXUlsfCefX3cyRH+dUOQb2jC4GPLybpqDlFz3VJianMfjogQOZGP/INDG
	cJoH77Cj7hVhVzQ2CX7w0OmeA/t34tTYsatYGH76/IFw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 68SMVAHa417114; Tue, 29 Sep 2026 07:31:10 +0900
X-Iguazu-Qid: 2yAaQEjZEvWghDHta5
X-Iguazu-QSIG: v=2; s=1; t=1790634670; q=2yAaQEjZEvWghDHta5; m=isEsuPfrHyOMTmrf61wy0UkN0h3dZ9/Gb6zuOuBBllc=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4htwy54gKpz1xnZ; Tue, 29 Sep 2026 07:31:09 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WFGxRpiMiaBstuCYa0HQGuG9DRIVCdshGCoQMfWOLS3yyGd8tFcdTZyWJYcw0JuJCujIweCwPqblYQ8hUVpHnW3P/F83xv2MVAndfx3ocrWBSqqfp4mQD3+v5OtRk930mjMh2NNkK3tZ9mqF+G2Kc2TrEwnA+ULD82hOB0IKBs+4EXaGgfsl5Y/Kekf3LL/FOca7uV/miomH8RPsCEyyZWIuKhP92+aYP4YBS3t1rfYi94DRiROh3hYiRoFvuzXOtwec9zQCOZ9JySxsimVttMC2U402I4uJE2sxhP/nCOSdq6M857n0Ak6UJD3QZyC43j34D7NT9gDKfvWx3RekOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TX/hnFP3kVNVrmjfbg3vxWB+UY2cYmeyfHpgrsjWaLQ=;
 b=GPCVNHJRzXYu87wAX1qy4HvqHxnQp8otmCZsXYDC6k4JaXhRpckf2gUj+bIf/wNiL2JjxxSF4h+JwJxwoviJAbOsTg9RnER9GYdoypsJAFJUZhzEUP1SGlN5HwPxm7a4lcZzER+7S3T2F0elngVNPcl4OIwYw7qm7iikVAV7u/mfA+NKkttEFceeQJ9QFCLg9HpFn7gu0ZpHteiEqYbX9Alv+9rkIn1UmIlSzrY83qf9EnXrcaE5XJq2IlinA+zAGov8DxtrUvGqfPChIADCI/mo1B7IT6nv+9bjWXu1YXBTLQKEhPFBJQuI90o+OiyNLBSvBvysMGyqLd1OJ5WP+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>
CC: <prabhakar.mahadev-lad.rj@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <biju.das.jz@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH 6.12.y-cip 00/10] Add RTC support to RZ/V2N SoC
Thread-Topic: [cip-dev] [PATCH 6.12.y-cip 00/10] Add RTC support to RZ/V2N SoC
Thread-Index: AQHdRoU8W/KcNieYG06hs/ObTUyBCbbfAKfggABHCACABV0y8A==
Date: Mon, 28 Sep 2026 22:31:07 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148189BD9DDB1CEEF1D760919CD8D2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260917091621.18551-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <TY7PR01MB14818BBA6AF0337F57A84D1F9CD802@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <arZqmPVYmmmUvwd6@duo.ucw.cz>
In-Reply-To: <arZqmPVYmmmUvwd6@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS3PR01MB8441:EE_
x-ms-office365-filtering-correlation-id: da913a3b-862a-4997-1fcc-08df1db0309b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|38070700021|4143699003|10067099003|56012099006|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: 
 w5pbPFIHxmCybEkHVWDxboXl1tvNERaqtbNHWV+yb/oTid9V2BJfyvTce1kvSAw4cKmihJR1vr5ikum5afhRmBIuNwniFQ5iEy4yOZ1hwPNysDXf6p7iLsSAeh664XZp1UNaG4g2Zh96reMueG6iHNe+EXzj7kJ90h86o3ZFrNDMPa/TuF4UqVPOgJ0pwjx2xL2//YtFfQRGWkijGChBHdCDf+iXLKSQWN2WL01SzW373zH7zPGoO8Pk2tJndQ7+/ouismj0gJHyYYgecY6tIu1q90FW+NqI6r/Te/gfcROiBE8qWaM26cMkf0K4vl8XHtx1z7hf8S6UB6j5Gz41tnc/ywbEy0N2m7Eht1HaHi7OpnTzaImg4fhnivLlxM8w9kqexByl3RcK+o7/BDgFjGS9gKDO4XIfOrINmfPlODUSEGWFJ2Ef+G7uKg3pR4no/OHiKfJ0c+Q/CejM1927ymcXdXta0X1klIen8o6znPvTxYj/0OL9VN6+hhF+vAVv3YfFJJvCfdagMY6jBrF66RIMAz1jAqRWh0K+M8sNJMMoXfH11Mr7DyQKcEorpoztn4kOVihm84bhlj3CNlfQHpe/es6hTg2nFRdJvaUSDuWPtI54raLtjmb0WLDR+pXPfYB02AJIJNN2dJ/zewJXt4JMwq6NkTQc6zOhVgTS0jo=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(38070700021)(4143699003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?UVJ5VysxQkZTRm5WSWNEaTloaEg0Q05UTklpZUZCc1g4Z0g1Mk85cmJ0?=
 =?iso-2022-jp?B?NEdvUFViRU9uUSs1QWw2d1FCSEh4b3kxUjB1cjBVUEw5MDN1a0YyTFZR?=
 =?iso-2022-jp?B?aEdUM1dHTVZlbkdpSEpZQ3BGWGZNZGpDRXlLcUFSZFNzV2Y4cUsxNDgv?=
 =?iso-2022-jp?B?NHhaUGJQcFZJbnVmVXozUTBrbkMvTVNtcEFMWTFlSkkwUStPQmtTRmEy?=
 =?iso-2022-jp?B?SEZLNGczdGRBMlhxZDZYemtQQWROblpsSHdBalFRYjd4ZUVIb3JILyt2?=
 =?iso-2022-jp?B?UDV4bmtreUdUM0VYZ0JLTldUaFk3bGV5UTRoRHdpL3JaZG1qbC9pYnh3?=
 =?iso-2022-jp?B?bFl1MXo4RzRETnZaMXhIQVp1a1VqVnkzSFVEZC9iaXlDVkEyOWJldHNs?=
 =?iso-2022-jp?B?aUFFL285aC9EaHMreGhDKytlWUl1OG5qejJPSkZIRjIrdWF3c3k5dXVx?=
 =?iso-2022-jp?B?Zm15VStPRjF2dkhaWkxGODJkc0NtdWhrWFhRTFBYWUltMVhXUGFKbXEv?=
 =?iso-2022-jp?B?UkR2QUVPcHpOaDE3TzNpZUFpOVRzaElBMUJOMGRyNDZwT2ZQZzk2aE5Y?=
 =?iso-2022-jp?B?bHBqaGQyZjNLT091ZHIwY0JqakpLL3BwdlN6NGplVkhXUFJNSFVKVWU3?=
 =?iso-2022-jp?B?ZXRZemRhNktmM0VqSkJQRTZPeFljenhIUVNCbHdGc3RIRUpGbTRINmtl?=
 =?iso-2022-jp?B?N1Z1NmxXRE9OWmpQSHFsdU90VHZnQUFQaTlzbVBFZUxrM3I2SzI4ckZ1?=
 =?iso-2022-jp?B?RnRBemN2L2xZZm5qL0NlOTlBaVYwMk0zUkhXbGh0NXhzV3dXWGNuS0Rh?=
 =?iso-2022-jp?B?T3dWOTM3SXB3OW54TjV6ZUIwalpFM0N2bk1iWWVyamRVZlJGQ2orZ2RS?=
 =?iso-2022-jp?B?MENHVXlQM1Vsd2Y2KzFqVzlUUk93Y3p2dndQblBnK0FUeDdCYWdxYUlO?=
 =?iso-2022-jp?B?ek4rSWlwZjBlOHFKbm5HaGVlaWlIYmxzWk1vcnZldW4wbU9EdUdkdWt4?=
 =?iso-2022-jp?B?eW1PcytLNEU4TFNxMkVxUjBGM3MwOW45T2lZbnBtLzBTM0ozNEFueU9Q?=
 =?iso-2022-jp?B?VnZrMzM1UmpNVFQ2eVlQMVF0R2l2cC9nUElONklKdlh3K0xTMXJuQzkz?=
 =?iso-2022-jp?B?TEsvU3JNclpraThtU0FCZStSSDZhSlNvQVNkZEE4aldEMXpBc2d6OGZD?=
 =?iso-2022-jp?B?YzJWVkQ4OW0xcmx3M20wdndZcTJUV1pZMjFKSXY2S0hXMVE5b2VWck95?=
 =?iso-2022-jp?B?L2kxanM0Q0EyUnZ2eWJDRGRRRTRZREJIWEwwSkRncUNiTmlKREFvbVFh?=
 =?iso-2022-jp?B?dE9ucEo3OGNOREREckZqVVUwVkQzS3U3SVVwMTE3S0hleHZGaUl1bnlC?=
 =?iso-2022-jp?B?R0RUeVRSTXFUMkNZLzFhcWp4VkorVDBXS0FobWFXOU5sV0Nhem5nODZt?=
 =?iso-2022-jp?B?MGFkcUMvK1NjMmsvRmlZMUlBV21GNnlSbDFVWFhuN0d5dXJEQWFMcm5B?=
 =?iso-2022-jp?B?dmtYQiswT1R2WUg4UHRDN3VDUVV4MDRTRDNJMlJYTTd1aExKSWdEQ2Zn?=
 =?iso-2022-jp?B?ZmtYYWd2L3E0bVdWSjBGM3ZHclllT2Y1Mjloc0ZFL0VqcmhLTmdMSmxh?=
 =?iso-2022-jp?B?YjNLdkVhSlZDNlhoMWJ1c0FnVjZiaEl6WXYxSVpXa1h6YWJZdWVmUWFS?=
 =?iso-2022-jp?B?bHhta2dLeU9ucTZOU2lPM2xGcXFlRmdqZmRtN3ZQT3h5cjdKYldDOGEy?=
 =?iso-2022-jp?B?ZFdHYU1wN2hWbTVhYVkvQ09IZW9ESnVwWXc0Y3B2REhsMEp3YjN1VnZv?=
 =?iso-2022-jp?B?a2dyK1V1OHV3LzJCaVlFWEV3V0lneFM2TkpMZUZjak5BM2tCUzhUdkMr?=
 =?iso-2022-jp?B?T0VHY1FBMWlQT1ptTmZlMGZMTlVQdFJiYlNUUXdSdVc5TndwZ0dET2N2?=
 =?iso-2022-jp?B?R01KdnUybDFXM0tzOEJJUFFJSFpsQ0RmMUpiVFMxdDA4QS90dXljdC9K?=
 =?iso-2022-jp?B?Um9CazQ2eUdqZUxlQ0kxRmlwSGlaNnNudFRwSURzajk2TFRNQWNhK3FH?=
 =?iso-2022-jp?B?MkQzSmpiTG05UTd3SEp6c0U4eVhDN05vbjA4YTh0NmNsa3A0bWUvYXNV?=
 =?iso-2022-jp?B?ekZhT3IxdnliY1Bjcm9JbHNnYWNHVWFmczVhK0szZE5FWXV5Nzl6ZmZJ?=
 =?iso-2022-jp?B?Y045ZytSTmdNTlBYRjVubWFsMllCaGJqcTAxZUFvQU5NK1RWb2JOUHcr?=
 =?iso-2022-jp?B?dG0ybDdMbS8xNk5EMWpFRllLTmd3SWNrNG9mUGp1ZGlIUmpQdDVlVDFW?=
 =?iso-2022-jp?B?NUYwcjNVemxBOW9EeklCdXdsWVUxVEQrWFZDT2EwWUR2UGpjQm45cmw3?=
 =?iso-2022-jp?B?alBLMGVOdUhUUU81aUltQUl6MUFVWHRRVGdKZ1dFUkF4VTgxWDk3Zlhs?=
 =?iso-2022-jp?B?dkc1L0tTOUhqaWVSQmpkRENvejU0WFpobFhrQVFHcEF1ZCtFWW5oOVo3?=
 =?iso-2022-jp?B?NHp0bUdGWENmK0FIRU12QUZGTW9OQmtJY2ZEWExjRVpJOEpXWERIZS9r?=
 =?iso-2022-jp?B?Ujg4ejJycz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	tRxnD8BGiMc+yV5P+Nuf7/egiWVmW5k2PAKeddAIQVLzzTliWyInzsDktspKefFa4mftEIvSdv6i8/LGvmfxcKRtLHv6zlnzA9813ijth6/sC5RMBsSiNWe5Vgu9IT56q3jq1WScSAVN6bw7Ovf7FmoT7gozMC6b/3Xw3cZoyRrP5kncm95MVVTVTGWAxBhuTEO0rcTgJvp7SXFojUUGWgVWEshxFYskOAjbALM9v8S/sgjSsLQtjRQYpbpUS2UOeIdDJ2aCTZnh2/CjpNsZigdDuTgPdPVHpshOEp/G/z+avX4gW8Zqu7I+br4PaOvwjKwgSFS9VIj7C8gcL5z8zQ==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da913a3b-862a-4997-1fcc-08df1db0309b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 22:31:07.6219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iM6nM9ofHzAef8mcyt4kxUzWUe+3Zayidz5hnXF23VhLinYeA31iG9JykP+MGZLHEPhrcv5lCTtBKRm5OAQCY+FdYYUtmKMP+IiuCoWzbEBJzwd2Bifa5R/Mbl7WjRuy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8441
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Sep 2026 22:31:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24370

Hi all,

> -----Original Message-----
> From: Pavel Machek <pavel@nabladev.com>
> Sent: Friday, September 25, 2026 9:36 PM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P=
#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>
> Cc: prabhakar.mahadev-lad.rj@bp.renesas.com; cip-dev@lists.cip-project.or=
g;
> pavel@nabladev.com; biju.das.jz@bp.renesas.com
> Subject: Re: [cip-dev] [PATCH 6.12.y-cip 00/10] Add RTC support to RZ/V2N
> SoC
>=20
> Hi!
>=20
> > > This patch series aims to add RTC support to RZ/V2N SoC. The RTC IP
> > > on RZ/V2N SoC is identical to one found on the RZ/V2H(P) SoC for
> > > which patches have been already backported.
>=20
> > I reviewed this series, looks good to me.
> > I can apply this if tests are no issues and there are no other comments=
.
> >   Test:
> > https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/288156
> > 6985
> >
> > Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
>=20
> Looks good to me, too.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>=20
> As you are already running the tests, I'll let you apply the series.
>=20

Thank you. I applied with Pavel's Reviewed-by tag.

> Thank and best regards,
>                                                                 Pavel

Best regards,
  Nobuhiro


