Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14EA3F94CC1
	for <webhook@archiver.kernel.org>; Wed, 22 Apr 2026 21:51:51 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.93815.1776894707882769203
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Apr 2026 14:51:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=VOUxSrKc;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.152, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1776894705;x=1778104305;bh=S/dLyZWrc3+yERFUaw4wCB7+X4Y2zgwmmiTik
	e+6mas=;b=VOUxSrKcRv0s6aCHV8xcG+1UlEZJsua4fqkeMXngm22bVhP7ZcrMYfOyJuA34r0rpc2
	ofGxPzD/MIpX4UX2+T0vrAwzkYwzfw+42kbTfYytom8oDAI/WH6idSH8CEYBTm6dxiVjdH/9PsnMp
	MOZGui3x1rLw4MeI9BcJliVmVqFk8Wd3GRy8KExsCFef0s2wmcpWrkf7T996Kr1252CywtALC21jZ
	SinlnsAoe3NbGybmbMfj0nOfOgrs7baU/Wc8oYdqBygpuDD0yMV3g6bBciWetzDdYnlNAsueZLORj
	jH6TeGYUxbk50WNUE3+qrN9zJA1ESoXqQ424EpDhCyRQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 63MLpj2Z1923157; Thu, 23 Apr 2026 06:51:45 +0900
X-Iguazu-Qid: 2yAbslxpJYni8YodxA
X-Iguazu-QSIG: v=2; s=0; t=1776894705; q=2yAbslxpJYni8YodxA; m=uOqfFVwa+G7vlhk5wkLmsCuv+dNbKHuEnLNb4OuX55I=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4g1Cc05RLnzyPZ; Thu, 23 Apr 2026 06:51:44 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J43Wej7u3eUeMdLoOsvYNtnDF4idznpoSunsOmGlim+kcgtmGF6GdS1kixKGOAsisK0PrxRiwUNIJc64eUM151qqEWefBhZfVg84sF4ls72pQQR9sIi2wLPv1S2xXnNoVtth2z0ZBt1kJ30apFKk4ZXNtVoknsxmX6ol0OswhM2P8qfeIosqdbdupAyYJkx84YogLGi/jKEJO7TfX9adxm9F0uRY/Ax12TYEKZgTsmpPxW67TfIGWFjqreL+/FEJcuj/KGHxLLXJC4VezSMZPX4E9FEjXyHcDTjgTeH7HvpAPwtKy0TuTrawARq5SbhfWjB3wl1CvYXdzzoyX/i4bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aayot9n9T/OUIPFyab/7xGqjVNBayKPkQTeVS9IODO8=;
 b=cUlg0ijWNfnvyjiwv0/Pc7hQevFjZxJCu0RsqXn36dxi3PppggSozAjjiPyCs/UmAeXX3mVJ7NaRI5V/Tvs7TCYA+RNyvJsAHWy+0MjkF4HoSTPAdY1LVxTigmdMw3bBu1e8gllJn4kqMqXlatp7CAby9HDAhvVhiZpA8Hq/qf7BrYTxON2Z2JnOtcuTTPMvJdXR3o0zy37JLIcuV5AEYOFg+0cVHSBPWk/qtLWtw2by6DYS4kI1QX3U2EcPpJFuG9rWrCcMwRnemLnRD/t9YyKdDgWafXG9doen+YeQQd8u1W5cVbLrZFPk+642sKBxrsopTlQrvA+kd7M0/NJGZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <chris.brandt@renesas.com>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [PATCH 6.1.y-cip 1/7] drm: renesas: rz-du: Add atomic_pre_enable
Thread-Topic: [PATCH 6.1.y-cip 1/7] drm: renesas: rz-du: Add atomic_pre_enable
Thread-Index: AQHcy2mUEugTRw7q/0iDz9/5aDirlLXiMH6AgAl8vaA=
Date: Wed, 22 Apr 2026 21:51:41 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818D943D405D42CEE803F91CD2D2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260413171831.3091144-1-chris.brandt@renesas.com>
 <aeFNQ-qnm-GNv7jW@duo.ucw.cz>
In-Reply-To: <aeFNQ-qnm-GNv7jW@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TY3PR01MB11005:EE_
x-ms-office365-filtering-correlation-id: f73025dd-e4d1-47e4-7e55-08dea0b9565b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: 
 wMA0MNtYt/73PN4HXMeclTyiCh2VH4rrNQQpFNHcg1wBU6RGv3ammcHR4ju+SGpIR7xSYnBTwHeSRi7ABUZZTn5UR0vWak7YYKkAqtfNZTh8Su0+VfuC8y1HATB78QnREPkqPC2bYxCbKjqeZJEH8pU4bE7nRRfDDWdRC4pBDjy17q8suvfLkG0LWB5p9NJL1LXwgsor34rDEb2CLk0gl5DNF10E6c3ZaBJi0IN1MkE9LqDlR2i+0tVhppX6FKSW8ydoi08yW1he3ZkukafzKpdzWer4ArK98fjAVNg6K1TI2TfjsFqA2BFkuS8Au/s7NyhWnkitcNX2I1sk7IPuMUL2p7jgXDntMq29//vO8eqgKvAR01lMxGuAiVCrpoCSwd4qhjdHyFDhhB7M9Y6nF4ue0cxYZG1p9QnlA5KnFm+Rrdgb1bAFS0sm/0642ursapkG3sMlgvbarYz6DMP2IW6l9ctngimU5zPvgdFgvdBiur5uFcjg1Iqbam6K/VpXxmZRb2uQw0ajuh/vH32GDLOELaUtvOgqYFOfC1nSQwJfnuvzmTmRlDFD9eymhviGaaAy6SgceKLBnGqaIQ/dPdJ/Oj2B7izkwAj8vj1hdSxUuYU0f7BDmHT6pJTZVOwlliGX1Covhu0hAWkS95KT7fpva4SpHO2CLNBS3G412qe/yui651wkiS0ZW44DTEJdtGFXen9nX/4SNsy90sysYNC9Ng1t4jNRUKIKeOCmUrQvLcjQYCZCLjNX/2CgKWg1T4r87EcNpMzYKCMi7unLv5eev4X84/blDvdwYQpvjxc=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?cUR5RG5NNEdBeHNIbXZUMnNCREtCMjZQNGQxOUxZdzhYc0l3djZLckVP?=
 =?iso-2022-jp?B?TVFmN3NEQW9kM0ptSTZtQVpVNTBveHdmbzhtckl3NWExaTlxREtVRW5o?=
 =?iso-2022-jp?B?STZOaVphUnBKS1pIdGpsSDNqK2xWMUJPU1lua0pwSW43ZjBOMmdrbjNz?=
 =?iso-2022-jp?B?S0lxU0RXNWVSdGFnemJ1L2JoY1l3SWdMOEtvN1VLVk8rR3ZiRUhYU1lR?=
 =?iso-2022-jp?B?T2VvMnU4eWREUTlIcXltYjUwbC9rUDB3NnEraGdOamlSdDgwZ1l1T0RD?=
 =?iso-2022-jp?B?ejZ2TFcvRHg4M096MG5FbWxaemtlcnYvcFlSb1BIaW9rRVp4a1Z2RjQx?=
 =?iso-2022-jp?B?MVpNaEQ4aHBCak1GVWoxSEZLU014a3J2cjNRTVl6QUwvdVpwUHJpUDFl?=
 =?iso-2022-jp?B?LzhHNnhLOFAvMmpKTFZLOUVNUCsvRXR6dzIzVS9kcUU5MVp4WkFjQTg5?=
 =?iso-2022-jp?B?bkhweUZmVnRkWEFqY3Q3Uk9vQjhXK0dNcXFTRTBZVzB5d2RLOE1pNkpy?=
 =?iso-2022-jp?B?b3VINjNlMjRjWjVDTW1GQ051VXVYMVY0ZDlBV1JvcTJ5Q0hQQXg4L3pT?=
 =?iso-2022-jp?B?TllibXNYbitsdlZySjY4V0JtRE1ubnhsQ2dPTFYxb3ZWQ3p1UEFSZzRH?=
 =?iso-2022-jp?B?cGFZQzNvYnMxQ05vRmJpQm9WOW00T0VubzdsaW1LL1RYUDU2V3MwMldy?=
 =?iso-2022-jp?B?ajJLVWp1N2FCamRidm4zK1lCOE5NNmR0dnVWMS9CSVRoc0xRWjJ4TzJO?=
 =?iso-2022-jp?B?V0JVL0RUaWc0ZzRWUVdHbHJ4aC93aVZPTkxOS2ZMNTlLRDdweGVYczVR?=
 =?iso-2022-jp?B?Mm53TFlkTlN4L0RwY29XVzkvNkFEM2d3N3hPRFA4TEllaDFZbmZ5RHdK?=
 =?iso-2022-jp?B?eGx4elNJYWN2aDc3VFRQaEYrcmJnREt6YzVSM3NNaVAzVkd2Z2hWTlMr?=
 =?iso-2022-jp?B?NTZ5OWpicjV1MzN4Y3N6U3REZjBVSlVLcTF3UnRjVFdrVytFQlY0aXlr?=
 =?iso-2022-jp?B?U1F5b05FTUY1UFFzOVZaSDNvLzhTeVJsZWtmOWlQYVJJM3FNcm4ycnUr?=
 =?iso-2022-jp?B?Q05Dc0RHb3dldm5UZThxanRoOUhxb3loQ2pBc2pTNitIZFVGMjdES1lU?=
 =?iso-2022-jp?B?VzMrTjhNOFVxNjlMVkYxRURIRnYybWlIbWc3YUNxWWhYK3JBd3NXMUZu?=
 =?iso-2022-jp?B?WUl0K1d5Z0NCTHVlWTZsTVlCbm0wZXJOSUpuNm41RklUWXRRTC9kRmdo?=
 =?iso-2022-jp?B?bEpzQ1RFU1N0aS83N3JDNE1PVmd2VmNKaFhWQUdWTDl5djlLOWFLU0dn?=
 =?iso-2022-jp?B?YVdzR0JHWCtZL0duMlU3MDZ0UEFaajd2MmJSd0w4cDlCV2Z4SU9RbXpT?=
 =?iso-2022-jp?B?TzNXTmV0VDRSWDdwU2U1bDZycjV1NGVYS2NHU0hrLzIxZGN2Um1ld3Q2?=
 =?iso-2022-jp?B?VHgxdC9rdjJjQXZoaG5COTVSNXgrMWdkeWwraEovNWREaFRRSTFyWTRo?=
 =?iso-2022-jp?B?VEZOczc2ZEMzRFRjcEhFeC9tLzdUM25TeTNYTmxucWx2TFNBTXd0NlRk?=
 =?iso-2022-jp?B?V0g3Y2ZRbmpXNUt1YmcrSzBacHowSURmRlFDSTVtMzc3Rnl4bXZMZjlQ?=
 =?iso-2022-jp?B?Z05KVXBuR1JtL1lvellza1dZS05IRjRwMFlaWjVwMGdwUDFUUGhtT2ZL?=
 =?iso-2022-jp?B?a3dhUDFVTEExZmJjMWxEcXVsMVF6MklaT3d2Zk9HUVJNK3g4SHQ1dmVl?=
 =?iso-2022-jp?B?LzUwUUN4NGdqWWhFem1sL3dHTUJndG9rNFFudVFPMHVWZHJTcGI5UUZO?=
 =?iso-2022-jp?B?TFhjd3VxR0ZRQ0VOaDJ2d1p3U0ZKdm41OUg5dk5JNzdzWlU2U1hQd1dE?=
 =?iso-2022-jp?B?eVozWWR6bVE2bVVUb1hYZ09kM0VqbDVadW1nWnJXUzRZSmY3Slo5R013?=
 =?iso-2022-jp?B?bFJiTmxsa1lMd25MZnUrVGpTQ0Q4bTRSLzdZVWJQV1dGUWlTU0U5WFhD?=
 =?iso-2022-jp?B?WmpKdkpxVEpiQ2FoODk1V05wSUVFeThuWjc2MGZla2tNY3J6QzlubW5I?=
 =?iso-2022-jp?B?SnZUME5mZ05BbFk5NHhXZjRYSHdmeW4wdXRFNmNzemREY3VwWS9NaXFx?=
 =?iso-2022-jp?B?V1d5VVpKbFJLUUxsbTcwZ2h5R1JJOVFINTR5L0RkTGFKUVFldmtlVVZV?=
 =?iso-2022-jp?B?aFEzNWFQdno3T3NTYUhGOU90SWRXS1NPS2FCOWVIbUJGTnZCL2hncmxu?=
 =?iso-2022-jp?B?aW1xWk5PVXMwYlNBL3RXTlNkWEMyN1pPTlhzcm9qNU5ZODNTdGQrUE0y?=
 =?iso-2022-jp?B?bGFXdlRTazVodVJZcUpBWFRRbnBlRUNVa2NKNmgzMjY4WDM4azgrUEln?=
 =?iso-2022-jp?B?VUVZRjZHNHowRFJJN0gvZDZxVWJjQnVrb3BHU0xtUnhzRU5Cd09mRlpH?=
 =?iso-2022-jp?B?ZnNrVzhHUS9kaDBCSzlCUFNMNnVPKzVHalVkbyt6ZmFJS3dYSWxKaHBk?=
 =?iso-2022-jp?B?N0NsTmVWWHJXSFlhRHk2YkIreHZCdGZabFBxMUpsMk1pZWhqMnAyTW1y?=
 =?iso-2022-jp?B?ajdNTHpLMD0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	UVNYoE+l9ujwr8BGJoghqDIdVuLVGuXWB7Z72kuDDZCef05xwHVB/YsivX0pDdTXM4uHLMQIY3LH2H/WMpIBAg7D9AUKiE67RywOt/UEEfwN51X3pscSf8mIKOrlvtp72yKNi3ZUmAgQRw4NaV6mMPyJWNd2/+muAAV+MdklSJZyURTgGeJ//quJXarmol/6RZXgPpA7SryKl4KWJcwS8xa/Q5LmMrOb2hz7sLMlfN/evLsYpL0KGU62LD4wVNiNBYSr3JL3Cb9wLnJntLOrYltPh8vIE8OLtbIT0NlFBCJOAg7bRavZZD3QWPUaqq9DfiB+mzf19JD/zMiLyKBU1A==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f73025dd-e4d1-47e4-7e55-08dea0b9565b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2026 21:51:41.1081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sfonH3Xi/m1qhCmjusYtOESMr+R7fkKDbD5+fdmBH1aREUEoFzOJ75Xp1lczBgY5zp/B1WiRH/yFxnitKyWLSQ1POPWwwGTxK+mHa8izXsgJtDjpCQIxy45xY8HPyscl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11005
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Apr 2026 21:51:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22787

Hi al,

> -----Original Message-----
> From: Pavel Machek <pavel@nabladev.com>
> Sent: Friday, April 17, 2026 5:58 AM
> To: Chris Brandt <chris.brandt@renesas.com>
> Cc: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel Machek <pavel@nabladev.com>
> Subject: Re: [PATCH 6.1.y-cip 1/7] drm: renesas: rz-du: Add atomic_pre_en=
able
>=20
> Hi!
>=20
> > commit 5ce16c169a4cb8ffceabfd48853d0bf605ce785a upstream.
> >
> > When drm_panel.prepare_prev_first is set to true in a panel driver,
> > the panel expects the MIPI DSI hardware to be already configured
> > before the panel's prepare function is called because it might need to
> > send DCS commands.
>=20
> For whole series: I had some minor comments here, but those should be fix=
ed in mainline, first, so they should not block
> the merge.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>=20
> I can apply the series if it passes testing and there are no other commen=
ts.

I reviewed this series. It seems to be fine.
I applied and pushed with Pavel's Reviewed-by tag.

>=20
> Best regards,
>                                                                 Pavel

Best regards,
  Nobuhiro


