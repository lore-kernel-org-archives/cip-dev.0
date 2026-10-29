Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5041.1793248429767171381
 for <cip-dev@lists.cip-project.org>;
 Wed, 28 Oct 2026 21:33:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=tz6x2FhL;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.132, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1793248418;x=1794458018;bh=tYiSnfcVSVyYIPrTUTunHs2hdKhc2HbU63iS8
	cxkiC4=;b=tz6x2FhLlvvdprGZP+mre9OhkBj55AwksxFr7EPlU1Xs0mBvCJmSqsfNMHoMl73GFr8
	zHGSsBNx+S2T213DzHE2pvTeXmODkHtBl9IhL+x0YXPGwWngHfPmUaC17+DRuxJXiZ7i9Ng+WVcMW
	mRuHBL549TQG89Xsg540KFBY1IP6uGeG1ghxt4U+ppEuVXVDTmR0o2oIsF1EMlHXaamP4zeyPYEUN
	z7L5Y8RjAM76wKB9hqZUUwOChIyZzWBY3biMU80QJIPHy0H8dURDdq64eCqBQup0OpMGnEl5Jz7gi
	2RMAWi+wvdhv2UaFtu/pu1+wmd/3WgGMlkW+zmz2F2hA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 69T4Xbx03516322; Thu, 29 Oct 2026 13:33:37 +0900
X-Iguazu-Qid: 2rWgdSTc1GtF2bvBcP
X-Iguazu-QSIG: v=2; s=1; t=1793248417; q=2rWgdSTc1GtF2bvBcP; m=Vagq4JsAehRgRTYt57/nUYenzNHg/jit8OIvFzZltH0=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jFWZS20gGz1xng; Thu, 29 Oct 2026 13:33:36 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M2/dYLQOScAczpOuAjZYGyLJygFgqzYN72OUzSJYKD7bJd2sT9yGOLkE74yj5Z574q+zIg8A4uDBnW+YyyRCtTxp2hSH425cx0NphFmKNLHKpYnUz2SjJxHvUyFul5EwbhrbqVg3Ij00/aTOHaX5rS807reEtsJ6nRF7PKC8+h77W+CcJqvWdfPxPhC8HQPVsd4IUSITZITLdge0fIHNd6f7EiZQrk2zWLLniiuxn1qkMd8fu+tiSjOoqLfJGMhCQQZdi1t0YlXgBRXwGpD3rrdthHMCmI7OeRDUFSFu2ljFkBjRKQSS0XvZ85Djr1chG7s86xw7hM8XwevGW/t3pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5qxHXzwKesA9BidDGQjKzh9E6ePU1BwlwPL8zCi4NJ0=;
 b=VwYPQwfNID8Qz4rDQV6DjsBSM4t4ldytuNeqI4mFiAfF1XxHfwIPfMRSBmUw8tJ27VCU9VvCjumple10/csDDhDGAaAGqCuX16H5K+DcXaw9oJEYlvbGb6UQoS2UsqaKMonw01yD9tSwgLmSnDDDBJ8LVVOH9GveQ7pHdkR8sjI4/eAls0nJNxENzKEUf5v2ojoSugBoZyO7r10dffna0Rg3xLMaRne9cBrAXaG2mqesIKr4K3zc7Rr0IxWYjAh113NQ22/pYrRaNwT+sY2oHq5tuwf95yfiMYHIf9WElASeNenKYfjiXddXWqTY2NdEE/zI1vcoKkDvPT6pGP6VaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>
CC: <cip-dev@lists.cip-project.org>, <uli@fpond.eu>,
        <claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH 5.10.y-cip 1/1] iio: adc: rzg2l_adc: Set driver
 data before enabling runtime PM
Thread-Topic: [cip-dev] [PATCH 5.10.y-cip 1/1] iio: adc: rzg2l_adc: Set driver
 data before enabling runtime PM
Thread-Index: AQHdZOuhArY0Fn3WekC1pMrJXcY5GbcQCJCAgAPi5xA=
Date: Thu, 29 Oct 2026 04:33:34 +0000
X-TSB-HOP2: ON
Message-ID: <TY7PR01MB1481833F5CB169A124842DCB0CD6E2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <1792979104-32023-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
 <1792979104-32023-2-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
 <at-DUZn8PsBDbxxQ@duo.ucw.cz>
In-Reply-To: <at-DUZn8PsBDbxxQ@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TY7PR01MB17225:EE_
x-ms-office365-filtering-correlation-id: ca57305a-9e72-40d2-130e-08df3575cb20
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|261009220027099003|261009221227099003|261021123027099003|261021121427099003|261022105027099003|261009221727099003|261009223327099003|261009223027099003|10067099003|56012099006|261026140227099003|261028144727099003|6133799003|18002099003|22082099003|261026121527099003|4143699003|11063799006|38070700021;
x-microsoft-antispam-message-info: 7kwjyEoH2eYKWxx9NXw6UYRM+NNt4LiEWx9vESdVqH4MbRoUgpJrPCyR6+Yz6NRZtxOWHtWRCaRiNc9EyLupIlj68VYTYB6seyYb3n5bw5JYS92CEZKgB/+MSJ8AtkoHS762MlLuk0ueB67g2KAhut1wh6nfPomHbqVZchow6YL8+2QpGk8pCCGngcUI6TUEjwSAhfATAGTd66WIFwl/ZQZIHLCrPvRRKst07ILZs1Ky8DzCC4j8NBPbK2Ev3kFyEUIUJVZNFEh58AeDoOqFvwSqd+g8vA0DI5e8hwhdliiRiHcgoF7/WBz0/EWUsvncVVk/TuFyK3/a/S/g7k2Fut6WgfTy495CidAONZngrlSq3R5p7nORJwA+ieTfkKSqepjnO1o0wEtwTOF4z6h8+h05cvqtgA8teaFvCnRzVTMWDMSPDdU70QRid5cqWXBShDM+fXqv39/HaQTo4f/wTm6FijdHTQIlUbCBP6TMuWOLG2y8+Vdyxo8JCO0u3I5Ula2Luqk2p/gfrCSV2qHJMftORhw1+JSg7lLYH+/F1kbxn9AuhHxrGV/zj3sJMh19810EnDRArkNhS7oqvu8h6szBx0OYIgs1PNmiHOkSBL4k0fyoHn4X4imjydw9030gqQQMVluNqA7Ax3H+ZfmC8kQqY+lQuFAO8FLrJp3OFEWN9Yvc1YGE4jC5/1k5V+sSzU5jgq2BR8FfVVOcgwcWNyFSnDuy9KPWOVrDIvX5O4o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(261009220027099003)(261009221227099003)(261021123027099003)(261021121427099003)(261022105027099003)(261009221727099003)(261009223327099003)(261009223027099003)(10067099003)(56012099006)(261026140227099003)(261028144727099003)(6133799003)(18002099003)(22082099003)(261026121527099003)(4143699003)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?ZWR2cnJUOTRHMk84TGlOU0Vlb0hpRGRuZW4veFRmRkdRV1FOa1k1VnRW?=
 =?iso-2022-jp?B?aW11bFk5RHB3bm5Zb1dmUnFNMEdlbFAvU3I5YVQ3Ui9XVjlxN3d2UDhN?=
 =?iso-2022-jp?B?WEQwWkw0cDNuVGZNbFFlZUlsblQ2RkxTRWd1TWpuVkhsbHdSWWl0cTh5?=
 =?iso-2022-jp?B?UktmZTFZYUtMV1ZRUHlxL1lhcHR5cGJpYjBJS3M3OFhoci8rcWljM0o1?=
 =?iso-2022-jp?B?L2laMkdqcXpYN3IwelR4eUdsTWxhL092d2RaWVBWd3FJN25IREl1dFNu?=
 =?iso-2022-jp?B?VW1NRGZOdFZEOGZ2elA4WjZHOFFkUTZlQmlaRnZVR0J2TUMzcWNmRjU1?=
 =?iso-2022-jp?B?bU1kZ3A1cWdKZUR0MzJ2ZDRNUFNtTW1tdnJvZ2ZSZEFoY1ZrUExZU1VT?=
 =?iso-2022-jp?B?QkpqZGlxdDlpQXhXc1QrMDNtWmZsL1VDK1dBTXF3K0FsNGlrY1JjSzNM?=
 =?iso-2022-jp?B?TU1aYms5YjM3dnB6dWdJSmdyVUF1azNUQXZBSkpaNk9UMHY0bS9ta3gy?=
 =?iso-2022-jp?B?enIxLzV1Q1FSTC9UOUllQ1FWOWJGSFJHbkZ2YXFDa0J0dDlBRUcyaHcr?=
 =?iso-2022-jp?B?b04wODB1cytkR2d6QS9VS01vUnQwY2h3Mjd1Nkp3RlRKUjdsVVJkWDBI?=
 =?iso-2022-jp?B?b28xVDZwZUszQUo0WFNSMkZ3S3dyVnM2MHNoWFpscExveFBEKzY4SXhs?=
 =?iso-2022-jp?B?UVc3OGI3dTY2YzI0aVFBWFBFaGhFemZqT1JNR2owd1lBYWtiQzJldjlr?=
 =?iso-2022-jp?B?d2hTRnhWM3l4K2hRVkJaaHNQSjFWeUtXOFpOK2Z4empEMGRIdVBjSWFL?=
 =?iso-2022-jp?B?ZG5GbC84K01IR2RoZ09EYW9ycVYvMjZWbnNMNWx3RUNEWnVKS0tqMGl5?=
 =?iso-2022-jp?B?MWxVVXErZTBvaHZvZjNlWFlLZEd5K2U0ZVh3TGFBUzFmTkIvNWx5SlpG?=
 =?iso-2022-jp?B?dFoxTWF2YkhtZXpTN2FJRDlKNDZQeHlRcWVwUmFWZVRQUENrWHZBVlRx?=
 =?iso-2022-jp?B?dnpYL3RiQStOSSthaHlRc3M1anB3cGx4WTNsT0tZS3g4UWRnVU41emov?=
 =?iso-2022-jp?B?OWNMdTFGZHpuTncva095bndnOVFpMTh2enlheDIyRDBSclRIWUE2U2VQ?=
 =?iso-2022-jp?B?YzNud3p5TEE1aGVUTVRCR1M3UlgyQ3JsbkMrbGpnaHNMbGVickl3eXJu?=
 =?iso-2022-jp?B?ZUhOU2s4RTlJNllHUzJ2dUVwY2d4ZzJvNkVpaHRrODJFUUJKbTh1bFBT?=
 =?iso-2022-jp?B?aG5HUThuQ1JNekZDYXFJVFdlbEc0OXk0WGxwTWRNQmRySURQcUttVnlI?=
 =?iso-2022-jp?B?ZGxVWEpKZmNFWC8xY1hJUWRMeVZxRFA0ZE1ydXFjT3RJU2h6MTBRVzE2?=
 =?iso-2022-jp?B?NVJWUk40VnRUS3hyU2V2YjNINkM2WVpITnI2RTY5Skd5N09HZE5oOHpS?=
 =?iso-2022-jp?B?a0JuOHBDTHpGbEZ2UkZYMXh4Zzc1WDNrWXN1QUIzeWl3N1NMVzJ0Y3E5?=
 =?iso-2022-jp?B?Um5SYTV5Q2UvYTdUSklSdXpGT3dlaENZVGZuaHVWczlobmVZMXUwb3or?=
 =?iso-2022-jp?B?KzF1TXFJeVJkZGxIdWh5OFB1ZGFyNXVBNmYvV3ZjaUdnOVQ4cjR1WENU?=
 =?iso-2022-jp?B?bnlUWjkzY3NRL3lESk1tRUd3Z0xlRkNVTnRydnM3TXhZSGNiSEpJZFlp?=
 =?iso-2022-jp?B?aWRNUzhVS3JZbnhYcytYdEVlTE5Bc2FpaTFKMTY5RWxhTktJeWdsMTUr?=
 =?iso-2022-jp?B?OGJ3bzJkK2lJSC95TVJneElNWXJWWjg2a2pVSnAwd04vaGE2MFd5VVMw?=
 =?iso-2022-jp?B?NGVMMHN3VFIyekNvamw4dmlpYi81NUYzWGprak95TkwvRnBTejg4Wmoz?=
 =?iso-2022-jp?B?eCtXQVZUYkNkTHlnMTIwTlY3YWJ1R1kxMmIwalZhNGZBRkd3VFhndTFW?=
 =?iso-2022-jp?B?dkl5SEt1RUlrWEhVcGFNSXYzNWFJOG9mYnJtVTlDU0t4dlY1eDZGUlNa?=
 =?iso-2022-jp?B?eHVPSmwwYlR1dXJWTlBwZU5pQnZGbzBNczR4RWJRWTkzeEswRTVmMmlO?=
 =?iso-2022-jp?B?Ym02RS9JUXozNjE2akpveHNuVUZCZVl6R0dMMU0wUmxIN3k4OCt6dm1t?=
 =?iso-2022-jp?B?ZHorQm1CTmd3SE1sTXBzRFpmUG1rSUZyaG1hUEYvNFNiclRibDJ4Mms0?=
 =?iso-2022-jp?B?VVNHMElobi96bUZaNjJ2TkNvY1FvK3o5RkdiWStpMDl4MmhkckNPZVhZ?=
 =?iso-2022-jp?B?aFdrZE9IdHRMaUEvWU52UG5LbkJmNzRaWVI1eVV1WVNRZzNQSXVoeTFC?=
 =?iso-2022-jp?B?cnlUVG5NdWNyYzd6cDBDVkhWWnpDS3NMdS91QUZENVJScXNTOWhaUG5r?=
 =?iso-2022-jp?B?SzB0U3VnKzhxNnpVSmx1bTVQYkQwMGdqOE1RZ1ZPbm91Nzdld1cxU3dj?=
 =?iso-2022-jp?B?eThPR3pBdTZMY00rVWJhVHp4YmpEckhqL0hwMjg1Y09JdjRZVTB4Wmdn?=
 =?iso-2022-jp?B?RkxqU0lXaFVZTDRyN2VJbjdUYjU4L2FjVDFWT2Ixcm1vWXJaRTZIVVVV?=
 =?iso-2022-jp?B?V1FOejJtQT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: wBlaXpzSzWbILe1VB0WGuyw5spaaNdgBNaV0Je16SnU8SND71DjWz5+bjN6ly/b75Q5YaFTsWKCLmdZ5BnZbJ38+DAC0Qe5LYxhxE+jtqqtJWDyqMg8OFXQvALoM2H6xVsSYD55srY/XLjxL2QQ+bxoVIGCL9TLOAA6/gMm7OG/C6AE52TuyQAmnBDVxWQvIfEIET9PhTbcm7JT8fA4wOs/bS9DZRISGA/sV68FWDkT8igy1osUWWBpa7G0sLORbALaXHXu5Q3U8JXDN5LxLtdfcZae51qid0N8b+p72Sa1pXlr3x6oG6lwEf1pXKjLIgXmvnvP0ifoKYwugUkbtsQ==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca57305a-9e72-40d2-130e-08df3575cb20
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2026 04:33:34.4901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CoVAGj3JWyQRnjcVeiXkZGjYWUf0JIhywXZZx+zQv4IKZhYKhxdohI9/f+vEVSuZoW+psCVKRKcZ++H/7/Tc248klIpAmRO7AR15pgV4mWhzZAAmVG2t7ANKCaZnhhTY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB17225
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 29 Oct 2026 04:33:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24563

Hi Pavel,

Thanks for your comment.

> -----Original Message-----
> From: Pavel Machek <pavel@nabladev.com>
> Sent: Tuesday, October 27, 2026 1:44 AM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P=
#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>
> Cc: cip-dev@lists.cip-project.org; pavel@nabladev.com; uli@fpond.eu;
> claudiu.beznea.uj@bp.renesas.com
> Subject: Re: [cip-dev] [PATCH 5.10.y-cip 1/1] iio: adc: rzg2l_adc: Set dr=
iver
> data before enabling runtime PM
>=20
> Hi!
>=20
> > From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >
> > commit c69e13965f26b8058f538ea8bdbd2d7718cf1fbe upstream.
> >
> > When stress-testing the system by repeatedly unbinding and binding the
> > ADC device in a loop, and the ADC is a supplier for another device
> > (e.g., a thermal hardware block that reads temperature through the
> > ADC), it may happen that the ADC device is runtime-resumed immediately
> > after runtime PM is enabled, triggered by its consumer. At this point,
> > since drvdata is not yet set and the driver's runtime PM callbacks
> > rely on it, a crash can occur. To avoid this, set drvdata just after it=
 was
> allocated.
>=20
> I'm not sure this was diagnosed properly. Ok, I guess that fixes immediat=
e
> problem.
>=20
> We now publish indo_dev pointer before ->hw_params is initialized, before
> mutex is initialized, and before ioremap is done (and others). If that ra=
ces with
> PM callbacks, bad things are going to happen.
>=20
> Actually I'm not 100% convinced that this patch solves all the problems, =
are
> suspend/resume callbacks fine running while
> adc_hw_init() is running / before irq is initialized?

Since rzg2l_adc_pm_runtime_resume() does not access the IRQ,  I think there=
 is no issue.

>=20
> What happens if PM callbacks are running, then devm_request_irq() fails a=
nd
> device is unregistered racing with callbacks?

As synchronization is handled by `devm` and the Runtime PM core, I think th=
ere is no issue.

>=20
> > diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
> > index d48aec92add9ac..418211c06f1fe2 100644
> > --- a/drivers/iio/adc/rzg2l_adc.c
> > +++ b/drivers/iio/adc/rzg2l_adc.c
> > @@ -436,6 +436,8 @@ static int rzg2l_adc_probe(struct platform_device
> *pdev)
> >  	if (!indio_dev)
> >  		return -ENOMEM;
> >
> > +	platform_set_drvdata(pdev, indio_dev);
> > +
> >  	adc =3D iio_priv(indio_dev);
> >
> >  	adc->hw_params =3D device_get_match_data(dev); @@ -490,8 +492,6
> @@
> > static int rzg2l_adc_probe(struct platform_device *pdev)
> >  	if (ret)
> >  		return ret;
> >
> > -	platform_set_drvdata(pdev, indio_dev);
> > -
> >  	ret =3D rzg2l_adc_hw_init(dev, adc);
> >  	if (ret)
> >  		return dev_err_probe(&pdev->dev, ret,
>=20
> Consider moving platform_set_drvdata() immediately before
> pm_runtime_set_autosuspend_delay().
>=20
> I'm okay with taking this patch, but someone should take second look at t=
he
> mainline.

+1, that proposed change sounds good.
Moving it to just before runtime PM is enabled would be safer.

Best regards,
  Nobuhiro

