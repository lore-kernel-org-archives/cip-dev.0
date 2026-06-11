Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676B0CD98C6
	for <webhook@archiver.kernel.org>; Thu, 11 Jun 2026 05:47:18 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.39148.1781156828653275084
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 Jun 2026 22:47:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=IuVqAX/3;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.131, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1781156817;x=1782366417;bh=O4qBohkE0I8hPKlve5cjaoElZaRsqNITbD1gU
	kP7+m0=;b=IuVqAX/3NDQOlsypB6iVdtvkoZUuKAE/nJ5OUkVxKFV2cy1h8u6OpsGsgMK8v1dsSAg
	3vjtjHX5exN189FnR6nhjoG7WsuaXQ8BvDmoulq0LwhdUxbUiTer4xj4CUNEtm+iFu+qP5FSOoYFw
	pIphuRGtMac5bLqP9Ac4LdihULBSbO30SrjCLT8Kg7ozawaQt9H4BkmHC+mqyvY//GGFBocRCYm7I
	8JUhd//R35mc/kFRfpCcF5j5rPO++JR5cptCkCO2+A0ZDaASYEHzBaBvyMQL2dGHk9NMHwLCY67KF
	y3Hni4kOXy8rCk3ryszG1luhjp/+zRApFZyj/Yqx9+uQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 65B5ku7e521595; Thu, 11 Jun 2026 14:46:57 +0900
X-Iguazu-Qid: 2rWhVaVmIeqVT2G5kB
X-Iguazu-QSIG: v=2; s=0; t=1781156816; q=2rWhVaVmIeqVT2G5kB; m=h5BCPwoyY3Wq/TwvqagJf8RoJob/ixuEbXFjwXH8/AI=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4gbWqh0wN3z4vym; Thu, 11 Jun 2026 14:46:56 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iLQ2juTBQ/OnV23TfJCTlIrfD8g8lo3ziyzL4PCVka7taH6DeZ285r1d2yCt5/Wwc0s0X6bLv2OBQxFghhozbFUFCH7f0eAxSTRmFRi3A4MkVUctJOR8neO/z7xM5S1Hkkaf7x3Uz2oOCv9IA5kH+lV2mVUVj7h9dT7ZVRvflCkr0UsJP1dW9qMkgc+Sk11FnlgmrTzTeYQbbMCouEdQReA/0CK8Mak6InUF06iEetItCoDvELvp7Bziu/bkh/A0BYB0kVxyYFugUORocZcXeQWoyK+1e1ztwf1HsOUuubw+0yCFudodTKBegKkQVX70oN7ZtLJLSIHKv7s1mERmAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xWhLHHkSJJ6EojHuju70OmNK4Vef6ec6Et+FB8Yzc2M=;
 b=oPWIZ2PkxcZw8LlUeOzmJUqv7G7bwnfAt/U9cOMHM2l2eACQEB5Slsj5nbTF25mFX6lya9MXMu50KSL6+eGsc43hYXnmbkcxg9tkffVFGqdWUKXK+8jtSssYUva8zN0Lwc4C4+FLQY8Ou6hDVwkDnN5AhmUd3QPcVrfTso8XPpdRAbT9hywnvPhS6pIqPRSN+HkVK3bMbL4x/Pkin5/1Il55a6f9/jBQqR05pTyurG94FpxCP+0SKypcsE/qaJnL5y1IRIJA3PBxL7jXr+zDU/PjLcU2bmpXcsmKDkJuW9+sNIVNIdbyQJAgCWPKp6oimExGY9YYNJc5K9y1BzL1fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <claudiu.beznea@kernel.org>, <pavel@nabladev.com>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [PATCH 6.12.y-cip 00/17] Backport RZ/G3S USB support
Thread-Topic: [PATCH 6.12.y-cip 00/17] Backport RZ/G3S USB support
Thread-Index: AQHc+RIwKFPPVjUeikSpa+v7h7aK+LY413Qg
Date: Thu, 11 Jun 2026 05:46:53 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB1481870E0F531E41AE63C8462CD1B2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260610194849.2502517-1-claudiu.beznea@kernel.org>
In-Reply-To: <20260610194849.2502517-1-claudiu.beznea@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TY3PR01MB9792:EE_
x-ms-office365-filtering-correlation-id: cae0ef30-0a9e-479e-57ed-08dec77cd749
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|38070700021|22082099003|18002099003|11063799006|56012099006;
x-microsoft-antispam-message-info: 
 EXGlb4+cN3/4Vvlv6RMNE8zE9XoD3P7LQUNcVrr26JapTZoQO0U3Pd6lSVVtWjdlrJoc+6PUUDvYH8fR0sYvkyKZgRLcj8hd7ntkR4MyLBt7j/TiIo0B7syfdYn01s5CJ6jrPT05lwX3mMYYeZX5XouIofNlPcmFdSrP8Mber4dX5AicIgXbd7CskCFf2xma3uHHJZ+kIH87beR91bvpH9aFkdkSalB2KSsDv27jM6FVRdAY6DN8lzZc6HmMFDSJvYaIlnkH8EYsCn97uBGuaBK5QS1Z2NkGtsjkV/ifwSPacheWT0GQSkRaGYulscE/jkvUB7TjmF3qoTj8rshup34UsFXqUiAvDUuHm24NuWjH2a1pAkzcgscCIS18DJ0hIsbG67V/rjQVhfujEQ41IwS2kA3bJ826e91uJpe319WxNF2zFtACRQ1th0f8GjXH0A4Z7npvA74RJq1VjEP4qKPASI+1jv+bXYnm6fXyhAZGhulYApT9l1cfQptx8xcVHqClrJjiL0YfnsPps00s0SNLdT8b2G01tOawf+ZWbmwek11h7ivkLS68ojw2zHOrN/4hWCt9aw+AxDmsrLHprK/Uv5L4TprHW9kQUsUsCyk+1i6kR49wLVozn4uzF6pYKbe8snivsFGkcFa/Em0p2bMfrlGnIbns94hzaFNjBLZ2klwicD6uRAPaq0GiPWjrvabmR5J4/u2AYoEeB9qLXGtidggIH2m57GkzRVDt/nvuy+3LyZRLjzhQX8RpuHeJ
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(38070700021)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?NWVyVEVTNzVRZ3cyUkM1cjVqditoTUJJazRxNHZubFlUSEgvTlAzdUFZ?=
 =?iso-2022-jp?B?aTZWeVFxMFUxbi92UnRHSEtqZ1pYN3V0cjc5YVBsMmtvUTlyaTQ2UzA1?=
 =?iso-2022-jp?B?a1YvU3pVNVJJL2V3cVN2dmRxUEdVWXJhK1BvalJqRjkrbkFGYkt1WVRv?=
 =?iso-2022-jp?B?NS9CcmRYLzJXejl0Q3hsQ1l4WXdiZ09JMjZUZGNQRyt4ZERxSnAySTRx?=
 =?iso-2022-jp?B?KzNpYXMvdVNzU2xPMlEvVnVWNEVITTczck5uM2lxTFFVT2s3WGtHYWlG?=
 =?iso-2022-jp?B?VWhpR1VHVHdOTE1pSklpMG9KUm9HVjY4QmtNT1VwbUltVkpQTHJjWkhK?=
 =?iso-2022-jp?B?QTIxMjQvTWVMZ29hOTFMMmRxSm5vTG5td2ZiMlNHRjFENERNZnJKSEE5?=
 =?iso-2022-jp?B?cnJSdFM0ZmMrRlluV1V3WDBNclRaWnlFNGlXbTIwVGJ4MTlRL2g3Qmc0?=
 =?iso-2022-jp?B?UlR5MXlPbXVXaEdFdjR4ZjJQUnVCRGFJMjNCQ3hLenRlT1FWWXBqNUM5?=
 =?iso-2022-jp?B?NEs5dGNyU2I3UnRIaDNHR1BxdTZscXZ0MmR1ZklLT1h6VGhGR1BRMFl6?=
 =?iso-2022-jp?B?UlpLYWFJZ1NLRmpWUGpWbkZTSUE5MkQxLyswOUo3Z1pOTzZaUXVGYWRj?=
 =?iso-2022-jp?B?cnhlRWE5Ny9zNE9td1lPS05sRUNZNml4ajRQZUZ1MW9leHBrZDVMSFln?=
 =?iso-2022-jp?B?dDB5b25WVEFRdS8wZVZKL3BqNjllYjNqU0w3d2Z2ZFNUQmpnVlRuUzZL?=
 =?iso-2022-jp?B?Rmc5RCtINlk1TlRWU2UrN2twZGR0TWU3M1hKQ2RjWUxycWhPQ0o3SXpv?=
 =?iso-2022-jp?B?T2RmVjVyMmRHbTJMRHZERzFkYmZLNDdZdDBZazQwWFJxZ1RHWVlSVmlh?=
 =?iso-2022-jp?B?TUwwVlhiNXJLRVc1dWNmRkE5alBjQklkay84czRjTkMwTFh3akd2bUxV?=
 =?iso-2022-jp?B?VGZTLytiVXJCdFBva2tYMUMvV1FqcVJrSzJNTVBEa0hFdEdCVHg3aWpr?=
 =?iso-2022-jp?B?RjU2eHliTUFRZ2Y3a3NtdVV6UkI4VVQ3ZmltSUtNVVRGME9STldDRisy?=
 =?iso-2022-jp?B?M1lBZzFoSFY3OEx2QkFtL3ljaUc0TzNEUE9aQzNNaDhRNDRBZXh5enVM?=
 =?iso-2022-jp?B?NkY5ODJIYVVZYXZxdEN5bWxNemhLN1JGdW9YaHZ3aWY1K0RDOHlnbnND?=
 =?iso-2022-jp?B?VHcyUDFMaWtsVHZqbFkvMit4N2VIQ3YxaCtoYk1FeEt4NUQ5LzFZMk5B?=
 =?iso-2022-jp?B?Q2Z1RDBWVnVMRWp2UnphVzRiSG5jVTBJZStjN0VaR3RZRkplS1VQRlYw?=
 =?iso-2022-jp?B?ZlFHdHJpWjBNeDUxSEJwLzJMSEZKVXNEWGJJbVNub0cvNm1pZVQ0SVRB?=
 =?iso-2022-jp?B?NFoxSVhWeEplb2RHeTFOdUhmczB5bXZIZW5iV3V6NUxjNENGZEhNbnNz?=
 =?iso-2022-jp?B?amVCYkNvdzJVVXBpNitHRzZxeTBEVVA5Y25DdXZuL0Z1em9PcEJOeTh6?=
 =?iso-2022-jp?B?aDBYWkFKTE4zbnl6QUwyODRMOTltLzEybGhsSVZxQmlGQ1dKWldUUS9W?=
 =?iso-2022-jp?B?cjNBbVhiQ1VKbE4zTnk5cWlJZEUrM0hLcnJKaS82eFZyTWw3N3FXc1U2?=
 =?iso-2022-jp?B?dnM4aHNUMXVlQ3c1ZWVzN040QXJ2TlZrcS9BLyt2Zyt3S0g3ZWdsT2E5?=
 =?iso-2022-jp?B?VDBWRC9sclhQdjF4T2VKNFc0RjlrUUcrakxybUVvRVhWQnFuanlNR2p5?=
 =?iso-2022-jp?B?YXA1MjVPWGZCWUpieENoUVZ1UlNOTHlqbVRRME42dnd2SFdPV2F5eFJZ?=
 =?iso-2022-jp?B?ckZEdnRhY0M1MTllODlLUzB1QU91M3IxbHAyK2h3OUNBRXFFYzJMbjlD?=
 =?iso-2022-jp?B?UlNOcnlubnZvVENLdHJ1Z1kzd0VFV0JNQWoyM1B2SlZVRWdsOUpldm1C?=
 =?iso-2022-jp?B?NkhSUnRmMTFsNG1VOVBscVAxUVJ0QVJhOTRhZEtOSVplcUhpMnBRdllC?=
 =?iso-2022-jp?B?ZXBaWnplWDM0WkVONGJ1VUJpWmc2SVJ3cU1OZklGcTAvNEZjdW4vZHRn?=
 =?iso-2022-jp?B?c0tkQklZSGJQNUwxQUIvTzVxdWFZMVAvUHZMRHN6UUJmQ1BZRzBabUpI?=
 =?iso-2022-jp?B?Y0VYQUhnMW92c3BNVmJnQ1U0SUxXbVRmVktpU2ZwWXp5MkhYMTZNbHFn?=
 =?iso-2022-jp?B?V295V1JHeWNsTzNmVFdPbXR0SVU5S3k5TTU3MWtQK1UzVlRpMEZHVTdy?=
 =?iso-2022-jp?B?elBOS0Z3b3Y0bzdCSGxsY0txVFBiR1pVQ3pTd3pMYmpFejFlQWx5M2R5?=
 =?iso-2022-jp?B?bHBmWDhrUm5rTHJ4dnJNaHNFdXVhenBQeG9tV2RCY0pPa2lmMDM1Q3Qv?=
 =?iso-2022-jp?B?OWVyOHc2SkJnSnBSaFVBMm1qSExvNVNOS0N6UUZ0aTg1RVprbWpwM05E?=
 =?iso-2022-jp?B?U1h6aENHa0VLMGRsb0sxTEpzbnRYWm9keTVTclk1SW8vckpJSWIwVHVx?=
 =?iso-2022-jp?B?a0dYMzlyZ1MvWEVGVWp2V1hSN2FGVXU5YWgxZ3lodklxbktxUGt4RlJs?=
 =?iso-2022-jp?B?WWtZbGJ0dz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	YmQrJlXAJjleKBbfIiIjHSD+gSeoRe55Q7IrACDYCocRCAPGTnvKdzGcryiPR4WyS8K3ADt8gBwGeb2BweR5c7dnkOM8lI1oCjdCRYOh+eTEVGZwGGWh3Na5iDQYzZCnHIxqv5pZLoKva3f+GmfNDVCLKjFhB+d9QCnZ28PaWUkBzZuLeIoB1n++7NvZGmgw2Rf+ncfniQ18hFs3PDNMBTt72DYvb2NfI5QtQ3+4pPVghxZNQOFzK8UjzyBjVLrX8r25+mIjuzo6vhEK7jBQtgVxzCaJXTFUTIxv+GxMEm+s6zEp8+/8js5MFy+Q38vZmyBdFha6mka676pPtBM4CA==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cae0ef30-0a9e-479e-57ed-08dec77cd749
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2026 05:46:53.4893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rRptTVeSXcNwNGbLuCnPxQJQP7tDKhjntfsI0S2fN4kiufw9f8oJyW2vggG34dXiAqUPzJMblY4wTQ9e0r7WnUQ3SuJdj+zcv+REKVOfE6aBxgEdIBdGGiCz3qMjuQf/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9792
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Jun 2026 05:47:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23057

Hi Claudiu,

Thanks for your patch.
I reviewed this and other series, these seems to be fine.
I can apply this if tests are OK and there are no other comments.
  Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

BTW, it seems your patches hasn't been posted to cip-dev ML yet. (Maybe bec=
ause the email address is at kernel.org?)
Could you check it?

Best regards,
  Nobuhiro

> -----Original Message-----
> From: Claudiu Beznea <claudiu.beznea@kernel.org>
> Sent: Thursday, June 11, 2026 4:49 AM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P=
#T=1B(B) <nobuhiro.iwamatsu.x90@mail.toshiba>; pavel@nabladev.com
> Cc: claudiu.beznea@kernel.org; cip-dev@lists.cip-project.org
> Subject: [PATCH 6.12.y-cip 00/17] Backport RZ/G3S USB support
>=20
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> Hi,
>=20
> Patches backport the Renesas RZ/G3S USB support.
>=20
> Thank you,
> Claudiu
>=20
>=20
> Claudiu Beznea (16):
>   reset: rzg2l-usbphy-ctrl: Add support for USB PWRRDY
>   dt-bindings: reset: renesas,rzg2l-usbphy-ctrl: Document RZ/G3S support
>   reset: rzg2l-usbphy-ctrl: Add support for RZ/G3S SoC
>   reset: rzg2l-usbphy-ctrl: Propagate the return value of
>     regmap_field_update_bits()
>   reset: rzg2l-usbphy-ctrl: Add suspend/resume support
>   reset: rzg2l-usbphy-ctrl: Check pwrrdy is valid before using it
>   usb: host: Do not check priv->clks[clk]
>   usb: host: ehci-platform: Call reset assert/deassert on suspend/resume
>   usb: host: ohci-platform: Call reset assert/deassert on suspend/resume
>   dt-bindings: usb: renesas,usbhs: Document RZ/G3S SoC
>   usb: renesas_usbhs: Assert/de-assert reset signals on suspend/resume
>   dt-bindings: phy: renesas,usb2-phy: Mark resets as required for RZ/G3S
>   phy: renesas: rcar-gen3-usb2: Move phy_data->init_bus check
>   phy: renesas: rcar-gen3-usb2: Add suspend/resume support
>   arm64: dts: renesas: r9a08g045: Add USB support
>   arm64: dts: renesas: rzg3s-smarc: Enable USB support
>=20
> Dan Carpenter (1):
>   reset: rzg2l-usbphy-ctrl: Fix a NULL vs IS_ERR() bug in probe
>=20
>  .../bindings/phy/renesas,usb2-phy.yaml        |   1 +
>  .../reset/renesas,rzg2l-usbphy-ctrl.yaml      |  41 ++++-
>  .../bindings/usb/renesas,usbhs.yaml           |   1 +
>  arch/arm64/boot/dts/renesas/r9a08g045.dtsi    | 118 ++++++++++++++
>  arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi  |  57 +++++++
>  drivers/phy/renesas/phy-rcar-gen3-usb2.c      |  66 +++++---
>  drivers/reset/Kconfig                         |   1 +
>  drivers/reset/reset-rzg2l-usbphy-ctrl.c       | 151 +++++++++++++++++-
>  drivers/usb/host/ehci-platform.c              |  25 ++-
>  drivers/usb/host/ohci-platform.c              |  24 ++-
>  drivers/usb/renesas_usbhs/common.c            |  35 ++--
>  11 files changed, 470 insertions(+), 50 deletions(-)
>=20
> --
> 2.43.0



