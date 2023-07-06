Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5494EB64DA
	for <webhook@archiver.kernel.org>; Thu,  6 Jul 2023 00:34:06 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.10961.1688603646142418082
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Jul 2023 17:34:06 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 3660Xvpq3898873; Thu, 6 Jul 2023 09:33:57 +0900
X-Iguazu-Qid: 2rWhJyZQY9LXUe0bj9
X-Iguazu-QSIG: v=2; s=0; t=1688603637; q=2rWhJyZQY9LXUe0bj9; m=J7NXz+ZwGgssj2XfvgFPmKNrDJvD+8BSf9ZeRbCm5io=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1121) id 3660Xuqi1967918
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 6 Jul 2023 09:33:56 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F1TuMHRVqXDgZIKnBsobU/7fDbCMYCYCIHWjLX8uOJ1ZoKi0qEWS9m1oI5Unk1j5uC8ZuGI7kaeledPOqC2/l3+POtMw48CtcwDpSCTBsYn/KZllWcYxCVtOrk1m5zy2FudSf/aPdjS2GyfVtcihf+KzulLsXHszTpfGicHGQ73GfLChUUpawbU7216O83Z9DSfR4w8QdnWLTJanernpZdwwCmUyziqa033WGNZ7Q75lfzOpO1nkI3dEfRLr0roLvc+6YwZXdY4WCoHSibbTUfKWwunq+lF15sZnaLYy+dbGRLsc24i0+QzszotcDtQD4Abo2Q+wtkn623CTykw1eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EYDTrHxbmXWKg5XKzD1Dv4AOJurCdrZ6vF3MRnNpj7g=;
 b=eY2OzbzBIullsEQlA0wUw2gjRJ3QRyBVnJrG+OsNGjv25dAXInBeuKcxIieY+owjYnsFELI1vhtYOUMFzZyJ5Q8FUpcAOt9cVxPrTCpHPiFKft9Y7bLL4cB3FqE6ImIVVrvngM4l8tL0iYygibT74tYngTBMpBnuvmGCh1XoOF6QOv+pn7X2sU8mH3SnTjifjRkl9FHAIKzINU4fcu9bzqv3+zY2tZMukM8rBFLAmofuuMUKue9p3TaN/vtn7iL97ABY+k1vVew2MMMHDJPHm4vzGS0FFroKo0+e4x2IHI+W17cYNQPg/Ngtv42xVSwsbmEKPZTxMBhZC8S/MjjHfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <fabrizio.castro.jz@renesas.com>
Subject: RE: [PATCH 6.1.y-cip] usb: gadget: udc: renesas_usb3: Fix RZ/V2M
 {modprobe,bind} error
Thread-Topic: [PATCH 6.1.y-cip] usb: gadget: udc: renesas_usb3: Fix RZ/V2M
 {modprobe,bind} error
Thread-Index: AQHZrbEScEqUxmKO+0Cnz73DqPuGQa+r50Ag
Date: Thu, 6 Jul 2023 00:33:53 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB9420E53A4E9D48F6D85FD3D6922CA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20230703131944.353224-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230703131944.353224-1-biju.das.jz@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|OS3PR01MB9483:EE_
x-ms-office365-filtering-correlation-id: 3156fd61-dc4b-4417-7fa7-08db7db8ad15
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 p9WQvJ5JQQiS46k7KSmNWBrOokl4/FON8NsjbG7uD1DHoOZIgBV4u+4gF8Av5l1u4JsI/c/BDDzbhX44oYWSI7uXUZAXtWtuc1jju0hWf+XKejmnqCmjvtzykXngV0bzcowAox6NO0gqz66RWdi31CPHZly7E8nXlTUUm6FkJ495Sb98cU1EOD1FddJbFlduf0GN8YyabRHJC4eQ2GY21YuRS4AJ89dK23O6S1wYmvQzm+IL99JjiwcILwNMYSb7/Fq+n5atQhenL7O9Z47w3M0y00+wCqUTW0y+gDF/E0ZSgtnjDiw2forslkZfjXaK0uJFwJkwzzWCmxgDNoBaXpbIbQVpF2MKpEsMjPOeJKgoKMHnG7SQcrdv1iarOUOLK9wK8uAPKcDNJQdnG0tKSHbXzx3d+FsF17lr0zJ/imOYtIPGR1Q6EUBJiayzHbKw2ArlWdb45xcOoAwswo+GdiwD7/LjvgENm9yY/a2xBhbqMAoZgYOirORHGJphdDS1P6M02jHCZ3JmDXKoiQajxWt08BlJzi9/s9KQ/oaAlkV3PKrbgjowbujMwi6H/SwmcvxeIX60O6VtHUJoW4GzcTbPszD4XamhAkFS10J9dTQJXBs6xr7VEa6d/HYA/3j3YxieRrvxaKA2v2uCvdk0vQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(366004)(396003)(136003)(451199021)(7696005)(9686003)(110136005)(478600001)(86362001)(38070700005)(55016003)(83380400001)(2906002)(186003)(71200400001)(53546011)(26005)(6506007)(122000001)(66946007)(316002)(76116006)(66446008)(38100700002)(41300700001)(33656002)(66476007)(64756008)(5660300002)(8936002)(4326008)(52536014)(66556008)(8676002)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?SXVyU3BjVy9ncjZuR1R0SjNGU3pKNHIyNXB1MWJVdWN3NFNZby93SnY3?=
 =?iso-2022-jp?B?ZnJsV2htaXZNVDRYbWhHeEovYXZFZXkzVVhhVXBzZkVhb0ZWenBXQ3pZ?=
 =?iso-2022-jp?B?VkRKdndvc0E2ejRRR0Z5YXA5dnhtYkdMVTZ1K2JlQ3Nwc2tqeWRnN3NH?=
 =?iso-2022-jp?B?ZUNZRHE4bEVUV3B6THdHRDJ6d2tVdWRhdFNrTTdUeU5PZ3ZjYUdHZUMz?=
 =?iso-2022-jp?B?WXZLbHV1dFRMWUdmdnhyb2lDcjEwQVVBVjIzOTlFalBWS29kWENIcG5L?=
 =?iso-2022-jp?B?UkRXM1lpalFFQzM0WXRvTTRsTkJtdEdIenNUWnN2UjZzVHVXNXVOS3Bm?=
 =?iso-2022-jp?B?eU95ZjRxNjVXVzk1a0xOSGM5Tll6RUltRE9aTDhwNUtIWTAycGZWeGUx?=
 =?iso-2022-jp?B?TDBOL3NaOFcyYlQwVVpVVHhIbytKenkrN2FEUDNGQzkyUnh3V2UwZmdP?=
 =?iso-2022-jp?B?bENtYXF6MDNpbzU1YUZhWktoV3Y2V2NpbmdXVFhKdWZJSUxkMzMrZUFN?=
 =?iso-2022-jp?B?U2FRMjBtMldJOUp0cXh6OFQ4VU9yNXJsZTZ6WHYxSVl0cHE3MEV0TWtU?=
 =?iso-2022-jp?B?elJhemdJakJtV0J2bDgwZGhtY2o2UkZlRjMvZXA5NFN5YXFoWlZxWm1P?=
 =?iso-2022-jp?B?Ym1haE9sMWV4OEVFZUhSYTFUYUhVRzlVR0pCOUNzYnBESTFldHlMQkJz?=
 =?iso-2022-jp?B?RGpRNTRLVGNPcW4rcit3eWg0QS8ra1NBRWl5Qko1VDBIZU92Y2VLMVRN?=
 =?iso-2022-jp?B?SmJERlRIWnZEeW1MUm9MRnVhL3IzTWxlWlNLd3YxN2xCUkVsejI2TzY5?=
 =?iso-2022-jp?B?SjVxZVMvSkxtNldKOVd0MVJBV2krQnpoQTlxcDhpL25ybTdFdXBib0xo?=
 =?iso-2022-jp?B?S0J6bWU0eUt2SFk4ckM2M0R1a3hDa3BJT2FSaWtPMndrdll5Uis5OGpz?=
 =?iso-2022-jp?B?Y2Fwek1aTi9lN3ptWFlIVm1LT2NZaXM0dWtheEFnNUlTeGY1VWR6NFBn?=
 =?iso-2022-jp?B?U2pUUjNweEQ1RkhuTXZGdXU0aTJQajdjM0s4VmVrdkZhc3BJbkNCS3Zi?=
 =?iso-2022-jp?B?YU8yWXB0Z0ZqMmVWa2lGMitaSkVleW16SzBiOUZKQ2U2S1o2V0tLZUdl?=
 =?iso-2022-jp?B?NEMxVjR3cjlOTTNlREN5Mmp4Y1Fma0MvWTVSQU9jbGJ3SENXQmRoaEdj?=
 =?iso-2022-jp?B?VHMva2VZOVlvVzNLemRpeEtabWFKK2pMY1lsbHFNWDkyYzZMT1QyTDE5?=
 =?iso-2022-jp?B?Z1E5bjluYXBIUnU2aWd4NWpUcWRoVkZXS1FzOWhkSDhKSFFkUE1kWkdr?=
 =?iso-2022-jp?B?S2V3VDZRK0VXS3hhbkdmWlltbGRFMko5ZjJuUHptUWFKQmZrVVg5WjB5?=
 =?iso-2022-jp?B?TDVLUDlYNjh3RDVlOVRzU1BxNzBVZFhOTnNqUXBvNExRajRkazVNL3Ny?=
 =?iso-2022-jp?B?SFVtV0xRSHdYUnA1aHFoYjh4UVgrTnBiSEtIUTRBVENxQnJLQWo0R3RZ?=
 =?iso-2022-jp?B?WDlOUVhYQTRqY0VpRUFZU2Y2b3c0bmVYazkvV2JLa3JxMmU0dTJLUmgy?=
 =?iso-2022-jp?B?N1VmMGJVV2FOd2ZUd0FvYjBoMUxkZDZrc3Y5WUVhUytQSjN4L1BMazlW?=
 =?iso-2022-jp?B?WUNxZ2tJY3dkdXRoUUplNHpnb2lOdHBNRkt0NkVXd1d1MTNCQXhvVDFm?=
 =?iso-2022-jp?B?TmxORFdnRWVZVldTeWN2UTBYVHh0bmVUZmxoWlgvZ0RFMEJ3WnZodzhC?=
 =?iso-2022-jp?B?c3o5WWh1YnZkQ3BLY1ZwbU1iZm96c2Y3a0hSblFGdVpLS1lqQXkySEdx?=
 =?iso-2022-jp?B?L2d1UERwVTVwbHRtTHRWVUk3U2NOTlJEM3k3b0xnN3pBalRCOTVNWHlS?=
 =?iso-2022-jp?B?V2VVQksyaEZRY05IdDl6ZjV2bmVkdGw3Yy9BazhtWitQSEdMTis4bDF6?=
 =?iso-2022-jp?B?QWtmS3UrTjdVRmhPQ1RpZnBpbG14TXZJWUliam93emtFWTJsRlg0azJG?=
 =?iso-2022-jp?B?ckRjVXZ0WURmSytpbHRoWmV2cm9zZ202SzBzRkZYUUhNVVdBMUZEUTVZ?=
 =?iso-2022-jp?B?OTZQamp6cmYzdWhrNnBjY1dNM2w1L1pqVUNSWlVZMHlEbzdHdnBrNkhl?=
 =?iso-2022-jp?B?Q2pSRGpBT1ZmY3NxU1NqbHJsTld3SUVJWEpINFczZXBIQ0E4RlZna3Y0?=
 =?iso-2022-jp?B?ZzhVMm9ydWdFaXh0MU8yL3hZT2JOcjA5elV5UUh0SFZpWWgxOHcyRThC?=
 =?iso-2022-jp?B?STd1UzFBMEVUK3Q1dW04OHYxcWIvMTJWVXBsZ09pSnJyejNob2FrWm80?=
 =?iso-2022-jp?B?VXdyWllYN3AwaUxlVGZsVDZhSWtvVG0zZ3c9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Nd5BmN3lYAX1EiCns4P1BzCb70XIUSdw3cKGg3MCZfsftg4ue5mLQ0Ood2zcSMu5U0PAJJf4Yvl5VoRaOyhiRPsOunFqJy31dNYwKYhnOkVEdpPGjxxnmOgo8LLb9cPXV1Immz5w2PYLvyuoiwrW5p1exGbSrTFl3CVhw3fH+Y+H4SxKAcVlHIGrzp5mYZR0LKqVhYdbo5KELbgQ2BwHQciGPfvGq9vLNqOP+XLFKJuMliPN2wnKlEJs00P/j/57KrsXHZzBTkBCi1YTIQDzWyFcU2LRDvrjYa2e/1m1KSqixtlSJ/WD7htr02VwNh+zLn6Aw+UcBuTRNlEngJaukMkvGPiyNSsmU3ozpn5B2xU+67k0BOHj79gu8h0lAgfMssM02KPo4tGfzZBFhpc+BwUf1Xdp+H2qL0BQn1GlbJha35tTEmdZ+p0DAt2pX0nfuGem6n5C6RgULRgOnwB32yZlIVOq6BtgfvZ3wLDfY+dj6JiyZv7s7pZtHeC26KIk4YNQT9qaOZE3d6nlAEStyuECh/4UA7f9a6wuO824YlTgJaeSUuL7/Se8queCC6d9cJX5ctE9ZcEk9noNIoLBc6Ah6L/N/KXoipf2ebg9O5O+XehjOZpJB5iTN2PVynkufIo451bA1xRw8P3HvvbvLBp7VGgP6KoA3PkP65OhIURbDA7HyqDmon5ew7i0N5yBBX0MLbydUpfKxFHndo05TBy0B5aJTydZ54BKjmimCnNCyWsMsyFw7FY6lJmh6A0Bt/cFLeRq8K8lX0k1Rx6FrNMI91GWGYRWH4oVvszVjMa6hni1z1P+IQtDOENi8adfGjBCuPZbwyk55gyXqjF9f+9fYyMd53GAohuauFXq/cRgdtpR77ScRbKJIpR6MnweG5ETFkXUfy1o4ZHzUWWstQ==
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3156fd61-dc4b-4417-7fa7-08db7db8ad15
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 00:33:53.4228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NxEHlWe9HN0/MXfj1sSNSwtfur6eQPxbYt2PkyUPRzQgtBZWE8xRE/28rab5wSvpYsFMuiXYTtJIXIAhQqaXHFqGAEH+BpQi8z75Slchpg/6S8cUpkwlvyInhYcc8mTO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9483
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Jul 2023 00:34:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12240

Hi Biju,

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Monday, July 3, 2023 10:20 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mache=
k
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Fabrizio Castro
> <fabrizio.castro.jz@renesas.com>
> Subject: [PATCH 6.1.y-cip] usb: gadget: udc: renesas_usb3: Fix RZ/V2M
> {modprobe,bind} error
>=20
> commit 3e6ac852fbc71a234de24b5455086f6b98d3d958 upstream.
>=20
> Currently {modprobe, bind} after {rmmod, unbind} results in probe failure=
.
>=20
> genirq: Flags mismatch irq 22. 00000004 (85070400.usb3drd) vs. 00000004
> (85070400.usb3drd)
> renesas_usb3: probe of 85070000.usb3peri failed with error -16
>=20
> The reason is, it is trying to register an interrupt handler for the same=
 IRQ twice.
> The devm_request_irq() was called with the parent device.
> So the interrupt handler won't be unregistered when the usb3-peri device =
is
> unbound.
>=20
> Fix this issue by replacing "parent dev"->"dev" as the irq resource is ma=
naged
> by this driver.
>=20
> Fixes: 9cad72dfc556 ("usb: gadget: Add support for RZ/V2M USB3DRD driver"=
)
> Cc: stable <stable@kernel.org>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Message-ID: <20230530161720.179927-1-biju.das.jz@bp.renesas.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  drivers/usb/gadget/udc/renesas_usb3.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/usb/gadget/udc/renesas_usb3.c
> b/drivers/usb/gadget/udc/renesas_usb3.c
> index a301af66bd91..50d3d4c55fac 100644
> --- a/drivers/usb/gadget/udc/renesas_usb3.c
> +++ b/drivers/usb/gadget/udc/renesas_usb3.c
> @@ -2898,9 +2898,9 @@ static int renesas_usb3_probe(struct
> platform_device *pdev)
>  		struct rzv2m_usb3drd *ddata =3D
> dev_get_drvdata(pdev->dev.parent);
>=20
>  		usb3->drd_reg =3D ddata->reg;
> -		ret =3D devm_request_irq(ddata->dev, ddata->drd_irq,
> +		ret =3D devm_request_irq(&pdev->dev, ddata->drd_irq,
>  				       renesas_usb3_otg_irq, 0,
> -				       dev_name(ddata->dev), usb3);
> +				       dev_name(&pdev->dev), usb3);
>  		if (ret < 0)
>  			return ret;
>  	}
> --
> 2.25.1

Looks good to me. I can apply, if there are no comments.
Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro


