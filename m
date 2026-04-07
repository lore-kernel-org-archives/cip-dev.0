Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A549FFB5178
	for <webhook@archiver.kernel.org>; Tue,  7 Apr 2026 00:39:34 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.69260.1775522368161174840
 for <cip-dev@lists.cip-project.org>;
 Mon, 06 Apr 2026 17:39:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=sc+GxyJc;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.132, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1775522364;x=1776731964;bh=7QrXrC2jUCRyBi0T32ikNk49pFDDpMACBQrk3
	cX8TJE=;b=sc+GxyJcoBUByUwV5fzVpzR0ZtZAE6RVgguTsKV9zw65UYlfyYmMHBO3FnV17lLr2Oc
	STo9BEtX9h/O4kZRIUBAqTBxWalCRNmYjam/rCvSTNCZpC9mNiEVrMyCSNgf3zvpGlr4gb4wbkLDP
	eic5rqj7GRXasoGBZrL4Js6LF9VEl6rmcBziNfbiYfhBfvaA1r2nNkWEPR8Zu26lRhEyVYUiI3XmN
	9xCNjHn5iiNRgGHHw9YEKqNYVi3AGwjUGEnihSnJuZ7+3zAPYuxLQH5VP7zlNpH1Gq352yJQ2UM/C
	Q2RadOeDH3iwMdnUtVOSq3mryhvFOvXFmAcPU/5sV3KQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 6370dOHJ2152855; Tue, 7 Apr 2026 09:39:24 +0900
X-Iguazu-Qid: 2rWhZwovGlkozcoPrO
X-Iguazu-QSIG: v=2; s=0; t=1775522364; q=2rWhZwovGlkozcoPrO; m=uIm/l39WQGewwHy/p0NU/qg01t+q5PIaKcyL773Ep1Y=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4fqS4q4sKFz1xnf; Tue,  7 Apr 2026 09:39:23 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U3zeaElycmA+Xje3jGEFq1SLVlhCh2cnyUmYCqP8C6+56ejWZ8i+O0TjC6rb2+t5Ldnk6112WLJdLVwMAmcdLURQQOVO5rhZnNwx3fsQEXTFePOsKzeh6MCGpUv1tIlmNnFPwjIuqOYs4h+z78QZGBj8lsLi4HomO7EQkJxjMV/J3AdmY5AubNNAuAKWyh/1ZexjjVjO+6+agl1eIbvJG7oQaM+XOFADd4l+iBB2YZRXZsCCNO2aJpKCAPGILBoPoJr0M97A7f+XDkkg1gP7HSe1YgJNI+yfbij1baYb2Q4lXP7Wb3Pul8e9954YUbbkmmn0wg9rdaCMrAbHmTHnOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fgUUSrOYGyPJHfEqdNKD/lpPftpB1nX/d0NLA2xACWA=;
 b=bGanvmMnU6qRPex38FrlclQ7QM/0Qi5Hd0NfRO0p29D0o2W6EihXICyGa+xfxETrJ7ZHwFImiK1veGDO2BInXKVJWY/dUFoFn8y5JWDQjiSTfDkhplNpxMs0GJpjMpThHsZnBlI8/Tzq1O5dgLjMRB7wJbk9dO9y9zE1XR3/PM6XEwRrFNG02HhAEvAvbpcWBAeidmn639XxljhEHne9VGmCtS93QUZNv3OI0THTC3httDgeMbjH8NlTp76SLJkAAi3vNQ8hfB6u2MG3aNNaiZjuwBM5qUEf6cC0A/tT2+vQJbKvx7MRNB7OdMl0qbPGsM6DUdaKPneVT1uvTG3wVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <claudiu.beznea@tuxon.dev>, <pavel@nabladev.com>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [PATCH 6.1.y-cip 1/1] arm64: dts: renesas: rzg3s-smarc-som: Set
 bypass for Versa3 PLL2
Thread-Topic: [PATCH 6.1.y-cip 1/1] arm64: dts: renesas: rzg3s-smarc-som: Set
 bypass for Versa3 PLL2
Thread-Index: AQHcwrsk4bgLoXg6LkGNf00OktvHIrXSw+Yw
Date: Tue, 7 Apr 2026 00:39:20 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818351766CF1AF2A8D2C3BECD5AA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260402160937.2002534-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20260402160937.2002534-1-claudiu.beznea.uj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYCPR01MB10697:EE_
x-ms-office365-filtering-correlation-id: e648f6f4-8101-4550-ba0f-08de943e1b6f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: 
 ZHm73JPmHyX0rG+ixi3v16EftyVzSo/23P9zW/Wcjzxf3JvRjwmfN/5J0rpvCWhjC3JA3cR275PHQdvYYR8UsbGO2X+EO0O/RbmLPhwyACm4jMyuOmmuMXCefMiaZs1ii+vJiYyrBaj0lOPqN4TaOwPR/N7tfSAhCUbrSbAEM5eNJq11qXDTKxJN6dFaDl2cyx4JZoKRxN85YdFHFrid2V1SHh/rsVJdtUgErm6QIyfCNU/nN+BzarrsaLN6mkQOTqJqYUKxOE+TSr3n6PpIt4CKgvz6IRM+t985TcePMpE5XfcvFVaiNfLWwdN3273boqNWHNHUkBtxpoKrvykvlGOnyLv1BMJFUUHsHCSHJADtUOfdRy6FWitCKatVVFKMvOXpeOdsmIyN+8AhYapZ9+AY8NpoLKTlZh6rJNGu/6QLcPQ8fmHGJPRdCqYO5zvYKuzordRjrydtmVTwgdUv6WcdbdYZ3TNTUPb7sCnlr5LLytlzA3V4ZKA5Gob6/gEmqh27+6F357lnvAtx7UqGqaCwdaweeUhnz4m5NhtKef2WkGLuNPSadSMA+ypSHQehKPX2DHovxyJK7tsRSejsqD+EE4eF5c6wwU/eT0s9oGDNKYI4e2HeH95UXOWWKMoU3NV9tkRECbRHIDtYaKuNwSN8iQyAZWJ9yEJIb2EjR8hpI/4kqVAE6Pte1VYht3MHXYZIztFz5AxC0dS/8GIgHlcIXj02hVNnRBAtDnW1vL7nsqJCC6TKw9MkKWbBh7JW
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?aDI0aTlOc3RGOXFnay8zZUVEK0ZNK3NsNmwyTVJpTHIwcFBKb3UwTHF0?=
 =?iso-2022-jp?B?VkFrd2ZFdTIyQ1p6a2pFVUN6NjcvSWRWS3pJSzNmRk9ZVmd0a05PUjlV?=
 =?iso-2022-jp?B?b2ZOSUIyRzJaSlJHWU9reEp1THlyNXozV1ZCbjhRTkQ1NTJNaDZOUVYz?=
 =?iso-2022-jp?B?R0hLVDRvUDVKTUN6V2h2eGZOODVmSVI4YTBiamt2V0lNTUpJZ0VESWJ1?=
 =?iso-2022-jp?B?YVlkczhnZUhVU2dZTDhXSkpVdkhLZWRGZGRzM1lacnJ6QjM3dFFMdkhv?=
 =?iso-2022-jp?B?c3lPblpIRUg5SWZYdmVOK1Rrb0ZSeklvSzhLUUUxUndZQjM5czI4RGt2?=
 =?iso-2022-jp?B?Tzl2blpLSUpoVGY5YXplbTFtamg0cnp6T2RvWlNSSEFLNlFTNVRjUllH?=
 =?iso-2022-jp?B?T0U4TkRnWEpPOVZ1dE9FUDd6OU5uVzFPVFkyQ2VKY3FYVEhzQURRbC9M?=
 =?iso-2022-jp?B?Y1EycWJqajVOSkxEcHh1MnZkVE84ZTJDc3ZqQzY3S2V1MC9UeCt2czJo?=
 =?iso-2022-jp?B?UUlTZTU3blVqeGZ6MFBFOTJpcWoySStYQVkvaDBJRzZWVFpTRW5XNlNv?=
 =?iso-2022-jp?B?Vk4yRlpSdGRqVURIUG1JMDBZUVdzZUdkZG85elBHU3FkUEI0UngrSE43?=
 =?iso-2022-jp?B?SmJMZnNOb2VCZWEvYTEzOHM0R0twbFpLNDJqclB4a3JZTThMRFpaYm4z?=
 =?iso-2022-jp?B?QnNheWVqVEQ0UTB6ZkhEcDg3ZU5GYk04Q1FlNXV2NGRvS2FKL0hxUnpr?=
 =?iso-2022-jp?B?TnJjWHFaSFNMTHdPZkcwdE91NE0vTlZpM0lrMWtsRWYwV1lnaXI0ZS9L?=
 =?iso-2022-jp?B?QkR1RmNvN2RnNDZRY1dKVzhtVXRxL09MTkhzUGJHRk96WDdRUG5kYU9v?=
 =?iso-2022-jp?B?NkZ6VzNvaFd6Q3ZZWUJkemY1WWZuSDNNNDVIWUJyRmFlUkJTRUg2c0xv?=
 =?iso-2022-jp?B?NjdDZXIwZWxUeUtnUUMrSy9XSlpQZ1Y4alMrYVlDYTlHM2Nia1ZMeEwv?=
 =?iso-2022-jp?B?b3VhVjY3ZnJtaFNEdU5oakFHV0VTanVXSjg3MWdOcUFqNldzdFdaM3lP?=
 =?iso-2022-jp?B?bkdEYzRBSDRyTG5DTzdUOUtqeHkrRkMvblBmejVVbzhveDBpV2NvQnkx?=
 =?iso-2022-jp?B?N2lCci9ONFdLb1RPYUxFczRlanB2UXZObUpNU1pQbkdTN1Z6Zk5aS1lw?=
 =?iso-2022-jp?B?ZWxBVGtiRXd1U1FwVGEyaHJEQXBkeE9ESkRiWmZvMGxRcnAvL3oxUGov?=
 =?iso-2022-jp?B?NWVWQ1ZTekdycjNVbVNyS3JTZXhwcWpRNDdPb3BXRGJUK1RiT0pSVkFw?=
 =?iso-2022-jp?B?UmJwYU9BSjdjVzBORW80Z2dOa29EcGQ1Y2txOW03cDBva29Ka3VlRnAy?=
 =?iso-2022-jp?B?eGcxNW9jZVBZRmU2eFZTVURCTkdVbk1pNVBTN3RDQkdMcnNCTE1COW5R?=
 =?iso-2022-jp?B?UDJzNDlsY2JDcDNqLzd3TGVVN2hXdGt1MG03OGlKLy9ZNmtpWFR4ZWRu?=
 =?iso-2022-jp?B?VWZUZ2ZCbFh6Q2FWQTA0K3BwU25UQ09hSFFBcDZ4ZXBKd3lKODZFL0Nn?=
 =?iso-2022-jp?B?MHNIOFJxMk9Rc1BrQXJaR0RJWFU5U2VEY0hFbEVZcUo0eGk2eTFEZU5Z?=
 =?iso-2022-jp?B?aU50RU9pZmorWEtyRXMyQy8ya2JYSWtGdjVQWGZJRGRPTEdZdWRuM0RZ?=
 =?iso-2022-jp?B?b05MczE1QWZOS3FXc0xWdjFjOHp5VExwMkhEMFpCaG5Gc3JwT2M0MGxJ?=
 =?iso-2022-jp?B?RXJMQjJLN1ovYnQ3MU1MSnc2OVBRV3F1NDB0OTlQOFd2VzBxSFpzVmR1?=
 =?iso-2022-jp?B?a3hvY0pOQmRSVGhCV2t6dDlZMVRPd1p2aFFCb2pTY0NMdzJuR0hpRTFt?=
 =?iso-2022-jp?B?a3g0NmRIeUJMeDdBTzhmNkFUOHM3WFlCNHZTTnF4aDc3bi9ncnVLemxZ?=
 =?iso-2022-jp?B?eERxTHNhanVFdkhqNGpIOXdDeUtReEZmUFZHSVJjSFdiU2pyQTlkTnVj?=
 =?iso-2022-jp?B?TzhCcUNFNWxEK1kvcVNWemJDTXlBaFE4Ui8xam1KbGVJKzlHT2M1WmJL?=
 =?iso-2022-jp?B?K2wxaWgyVjVwTWRQM2c0TmJnZVNOQmVYMk5DbEo2OXJVWHJzRXFNV1Vh?=
 =?iso-2022-jp?B?N2UwVE1RZWZpcUJrLysxdzB6YTVzaFhKMTY0SzhrazMyYXN0NW5VYlg2?=
 =?iso-2022-jp?B?K3pyVWlvaFo1Umg3Nk5mTDRRL2ViM0NiVWF2TklpMVhKUGo2VG16Wmoz?=
 =?iso-2022-jp?B?M3JiNjRCNHNzU1dQOGtSeWRMQkp0TGV2YlhSdXB3cFhyTlljK0ZMV0xF?=
 =?iso-2022-jp?B?U1dOdGk0Slo0RHZHbWtnU1dsbXVSeTdzdU9rcGZRdkZRbkNXZlE4alE4?=
 =?iso-2022-jp?B?Z0xUbzVoeElpeXgrbSttV2FIQTMxclVvQmdvSDQyMmtTUDVjQllYVmh5?=
 =?iso-2022-jp?B?SW9GbHlobGVJZDU2RGpiL2U4aUVOY3MxODdRMXJpN1FoUFdKc2Nheitk?=
 =?iso-2022-jp?B?QnVjYkNLUVhVMDJWZDlEMmtBMEU2VithdUtnV0xFTktTbkxUeDZWb2Ex?=
 =?iso-2022-jp?B?bGRNbkFZbz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	A4mG62hjLvJEX1VoI0BK9YpB1eZxJrfqHFqfPJ5HTr1Mp2ovAFM1FzUHFYP5+QmQUyGX1x1X19liqE8iegJ4rwV4HWIT674hiHvukEC4MIkW6uyM0GXKhOIvU/K+51Y8fIxZLTZJtPsXGfrBEDdgjGudpnfgnnhrsaXQqW1b7XjX/NxJSPHE9aPNXrKaosLjmWBhYynyu0AARXTjwcwSVt3sjCi0RsqIJIIm+xaXZyQ5tn8UVu9RwyeQ44rMQGXgsY1X/NskTo9dNJvgxi1xSc5W38f9/9EVU+BxagsmysLtGN9/Xgxbtnw4ME06CsY1Pjt0PMEWNtprxmaDU30Bsg==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e648f6f4-8101-4550-ba0f-08de943e1b6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2026 00:39:20.1960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vulo8P2UyTM1O/800VLvM4B85ZvZPErHlo8qpZnmltFOIzSSObPPvrAO3dtnpnz9DEnYwuzR1G8y3S9lhUzfmcg8gHlQT3fTmEKA+4yMEEpLch98cSZAyrJVV/kB/Y+y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10697
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 07 Apr 2026 00:39:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22620

Hi all,

> -----Original Message-----
> From: Claudiu <claudiu.beznea@tuxon.dev>
> Sent: Friday, April 3, 2026 1:10 AM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P=
#T=1B(B) <nobuhiro.iwamatsu.x90@mail.toshiba>; pavel@nabladev.com
> Cc: cip-dev@lists.cip-project.org
> Subject: [PATCH 6.1.y-cip 1/1] arm64: dts: renesas: rzg3s-smarc-som: Set =
bypass for Versa3 PLL2
>=20
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> commit 6dcbb6f070cccabc6a13d640a5a84de581fdd761 upstream.
>=20
> The default settings for the Versa3 device on the Renesas RZ/G3S SMARC So=
M board have PLL2 disabled. PLL2 was later
> enabled together with audio support, as it is required to support both 44=
.1 kHz and 48 kHz audio.
>=20
> With PLL2 enabled, it was observed that Linux occasionally either hangs d=
uring boot (the last log message being related
> to the I2C probe) or randomly crashes. This was mainly reproducible on co=
ld boots. During debugging, it was also noticed
> that the Unicode replacement character ( ) sometimes appears on the seria=
l console. Further investigation traced this to
> the configuration applied through the Versa3 register at offset 0x1c, whi=
ch controls PLL enablement.
>=20
> The appearance of the Unicode replacement character suggested an issue wi=
th the SoC reference clock. The RZ/G3S
> reference clock is provided by the Versa3 clock generator (REF output).
>=20
> After checking with the Renesas Versa3 hardware team, it was found that t=
his is related to the PLL2 lock bit being set
> through the renesas,settings DT property.
>=20
> The PLL lock bit must be set to avoid unstable clock output from the PLL.
> However, due to the Versa3 hardware design, when a PLL lock bit is set, a=
ll outputs (including the REF clock) are
> temporarily disabled until the configured PLLs become stable.
>=20
> As an alternative, the bypass bit can be used. This does not interrupt th=
e
> PLL2 output or any other Versa3 outputs, but it may result in temporary i=
nstability on PLL2 output while the configuration
> is applied. Since PLL2 feeds only the audio path and audio is not used du=
ring early boot, this is acceptable and does not
> affect system boot.
>=20
> Drop the PLL2 lock bit and set the bypass bit instead.
>=20
> This has been tested with more than 1000 cold boots.
>=20
> Fixes: a94253232b04 ("arm64: dts: renesas: rzg3s-smarc-som: Add versa3 cl=
ock generator node")
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Link: https://patch.msgid.link/20260302135703.162601-1-claudiu.beznea.uj@=
bp.renesas.com
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

I reviewed each version, looks good to me.
If tests are OK and there is no comment, I can apply.
  https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/243310108=
8
  https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/243310239=
4
  https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/243310316=
4

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

> ---
>  arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
> b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
> index b11f2e49748b..990adea09799 100644
> --- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
> +++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
> @@ -164,7 +164,7 @@ versa3: clock-generator@68 {
>  				       <100000000>;
>  		renesas,settings =3D [
>  		  80 00 11 19 4c 42 dc 2f 06 7d 20 1a 5f 1e f2 27
> -		  00 40 00 00 00 00 00 00 06 0c 19 02 3f f0 90 86
> +		  00 40 00 00 00 00 00 00 06 0c 19 02 3b f0 90 86
>  		  a0 80 30 30 9c
>  		];
>  	};
> --
> 2.43.0

Best regards,
  Nobuhiro


