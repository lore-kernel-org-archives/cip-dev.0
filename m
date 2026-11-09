Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9484.1794191430313674232
 for <cip-dev@lists.cip-project.org>;
 Sun, 08 Nov 2026 18:30:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=o9puKlOT;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.131, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1794191426;x=1795401026;bh=KyLjQoeLd2kaS/kW3ca/1YGmOky0O/CmFe9NO
	3iaGk4=;b=o9puKlOTvt0dEBQDnH+fQ49T7QvxWxV7hxwQexSk3Tknl0iD31txo+QielfEXfNMZK8
	wHtZ6V0ltzg0+0zh8jWycaQ4CN8YaeGAM9cFcgPjHS50t6d90dEVEVjhXi634jOUkkV18LXdiwbMe
	7uf+gX9cicx6Xy0Lbyqc9GUCjWrxkbjRXXY5caLEAIK7C+oiRCxushGVgdevffSu7e3D+QOIzaRcz
	tH0JET555DW1cDZDZEKeRSIzpcW69PAon3MwPOT034OpmHmMfw6tOphGsCRhNln5IHm2JVq22SGVC
	K2/rVA32xrWAP1RZZnisNDEHcgLtHrBc9aBHmmcQ4atQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 6A92UQPP2747324; Mon, 9 Nov 2026 11:30:26 +0900
X-Iguazu-Qid: 2rWgkynaFYIvEH6iax
X-Iguazu-QSIG: v=2; s=1; t=1794191426; q=2rWgkynaFYIvEH6iax; m=Soobqn17O/JZWHw8XLXMRY4hvi/7CP9K0UAOYJLFlmY=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jNDKG1nq7z4vys; Mon,  9 Nov 2026 11:30:26 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YXvDNYPJLcUS8ty54QiSDpOYbaiMoigjPE2pWpJIkwWO5r5Mo+0uj6MOEOmbyF8pxTd9kkqnq2PiqQvBoa5eMfuIgGV4tFYydp3izaRgRqlD1MqfjpCQjWQk69coeBzi8Y2r5pDGv4DQ1ySKOGuwY1XNVsZvJ2fgngwu68PHEY3oR/o6E72MvL+D7ljP4Qx0dK3g/LnpD0A9wzVvKYbiUpS46lQNgOc1eeDTiwa3VCKqbpVP1JFTVTjhj9BrMljYEcOb0lbKjw9qyiIUdP77uo8yx/LqVlhqdmr8tNV4mi45yzmhHnvlQscJ8RyFpiugbqiyQ7ZWcRRcInhjYY/qAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8JeqZx8ClvPhJ/a32Yiti2Enpoijp0ILgO82VUhTHY=;
 b=GxkaL567TMtkSeSCSJHxqqnTn+/ybG9+TFv9ZHPH+ETOLJEBNES6fzEgPiWem5vVj/F5wrLqSSgMOBcLaCUrfj3v4nZP4IKI+6O5XOOKaP8i7uwmogZa49GymCg524TZvTFQ75ncSQDWAN8ginRZ9Tl7gXQ3PH1m4RxiyHwaVT4jMByuei4YmJhG9NwRABOlbvhyLr+vKKcdiQHsJYPX88RJi7TjU331JX5yzJHeWw0cvyYogY0WwyMo/W4ndPqD/18Qorj/pN2CQVWEktx9bBq6aDB7NkVXLkAwCXXEgVNWK+Y+nR4U+0Dk7S2tFNkjUi89kllPPoWYYd23dp674w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <prabhakar.mahadev-lad.rj@bp.renesas.com>
CC: <cip-dev@lists.cip-project.org>, <biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 6.12.y-cip 0/8] memory: renesas-rpc-if: Improve xSPI
 transfer handling
Thread-Topic: [PATCH 6.12.y-cip 0/8] memory: renesas-rpc-if: Improve xSPI
 transfer handling
Thread-Index: AQHdaw7EjmJ6L2yIWU28mjYlWi1Iybcfqg+AgAVkFgA=
Date: Mon, 9 Nov 2026 02:30:23 +0000
X-TSB-HOP2: ON
Message-ID: <TY7PR01MB148189670952C6D503955C568CD732@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20261102211132.22646-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <auyqT5z7SD8GDuq8@duo.ucw.cz>
In-Reply-To: <auyqT5z7SD8GDuq8@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSZPR01MB9297:EE_
x-ms-office365-filtering-correlation-id: ea522f50-9061-48ee-9366-08df3e096839
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|38070700021|11063799006|4143699003|56012099006|261021121427099003|261022075727099003|261102123227099003|10067099003|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info: o7RnYx4qz4RFpLDthEo7rc/RVUhIGSAeo3uhtn5M0NgVpmEEQFg0WCpKoGcoMdwv8/uxINYLxu5s9i3V6MQwopbMa1e9I9KQyZyJkC+abbZsMYw9rmsbLvnEraBHyBjCLtajVsiupoxfKB60bUjpKQ81ybz3KdzysAhkcmGtqd/ht5Ad433/wuXxyNY9xfKg27GNGUxpjQNA3IdsseqWFQqyybgdQbLSLcM50DwRlSCPV1eNKaaaKgSQycujGS2qXIqUl2/+6F7P2E3EEyOTIsR3lsNC0xI+t1bMafWYoPo6jgdLmBeUe2XqcGiI11nX2YkvgZA5Zm9y2N5RtQex2Lh+Ro3KY6zEdR3EWF34iJESzfcAEGtUQ0EPScfpP0O5L0snA7R/dUMGwCTyq4ByOPyorbFZUKSTI8FH1ycSNa5ckj0Hm22KdZeEtW8kRUHLEzauosXT+rysTjp92J4a/ieOHfprGc0SLwqrbaNrOwGo91/n4lxJ/vKPRmf0mAc5C0VKmVkR4efta7dqyrO4uSLtY+Wox4MttjDN/zbkKQykrcB846r2Jq5YQRUQIJrSYVHiiECSXFpZfC0tOc2fEBb2VaUF0uMnLhJNXXFOI3DHQFZlrgX8tHcxa+LLskkCYCSV21A/X9FcubfcDEYS8/jL89tS5YC+mT4O/pnxPaQ6GeMP9pvoA7SDJHTCYRBl72ccWWLUn/uZAnBx3Omf0RUeKaEZwjVBIP/nG1uD9dY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(11063799006)(4143699003)(56012099006)(261021121427099003)(261022075727099003)(261102123227099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?OEEwajlmd09BWU5lTDlLbkZUREhKM1FXM0hQd2dYaFZ3SUFUb0lnSVhH?=
 =?iso-2022-jp?B?N1lFeVZtN1R5Y2N3UERnSHlWdGJhLy8rQTM1WVdUWW84MitPbDBXcHMv?=
 =?iso-2022-jp?B?TFduQ251MVNNK0Y4dU03K3gvbTVBQmRROUhhT01mMmVKeHZJSVFnU1dX?=
 =?iso-2022-jp?B?V1pBMy9KUUFWMWRFbU9haVM3Z1hYNCtvL1RaQXUvSi8wVFdVVWNMcHpZ?=
 =?iso-2022-jp?B?MGFpYWx5WUhKZXlaMTBlVmpkMGJZQTRINWp5UGY5WktoWTFSZ2xLWFlL?=
 =?iso-2022-jp?B?MDk2SlMyRzNDeW41SGVza3RRczkwUTVVRVE0WEdiVDhtbHhGYjBYaWdL?=
 =?iso-2022-jp?B?TzJRU1hkNkI2SnJrNi9INHUxNTdqNVZ0SStnRFZ3R0xMRjRlM2IydTIr?=
 =?iso-2022-jp?B?bnBOc3RMUkJBQU5lRFNIOHBGVmUzNGRxbDlDcUpLSVp2SlNNdzg1Rjkx?=
 =?iso-2022-jp?B?N0JtT3pGdjl3RzQ1VkZpVEdTUGFZZGMwd2V4WTIrZnNvb3hiVHFYTFBG?=
 =?iso-2022-jp?B?dUdNNDQyQjJteUtjdU5WdnpRZHhkaHh3eTViMThoNmhuQTRsNDFZOTdJ?=
 =?iso-2022-jp?B?aTlESFB4VUl2R0FEQTFtZkJ4NFdDZzZZUmw5SEtDc1lYcmtwK2F4dHFn?=
 =?iso-2022-jp?B?cTJRUjdjbmk3UFlCQk1BQUZJQmVWN1ZIR0hZYjhYYXlsSktNbHYwd0NZ?=
 =?iso-2022-jp?B?Vk9PcklxMkl1aHpxcTV5SFVEUXpLYmZ6MTlwcS9xM0FmWU5wdFJ1cVhz?=
 =?iso-2022-jp?B?TlZqV2QvdnAxR3M2ZGJ5V1JSWmhOUVNSS1JHbkEzN1llWlZjL3JwcElw?=
 =?iso-2022-jp?B?by9hN3grQkNkekpZd1NXRFpEei9Pd0IyeVgwMDdxaE5qOEJMQ0QvZ2VC?=
 =?iso-2022-jp?B?bGRtOHJXWUpWazlXUXhCUW13bUM2c09UbjZ0NzZVL2hDVlM1RlR4ZVR5?=
 =?iso-2022-jp?B?YnJOamFQT01FNkxjTnZWUC9jV2F4MC9vN2RncjVWK1BPYnNVZEtoZVVC?=
 =?iso-2022-jp?B?R3grc3lMSkFRSFJQTGhmWHJCMjVhTllPWlJQdjBrQ3U3MWMvUHJLMUF4?=
 =?iso-2022-jp?B?ZWR0WFhDQnZ1aXZJVEZYN0EvSnpxNFJ4UEMybnorTTczWlM4bm9HYzJo?=
 =?iso-2022-jp?B?WUpIdEE5TGpuWlFUVFAzMGdiWFNWOHY4K0NseW1WbkZhbDBnbmhEUUJj?=
 =?iso-2022-jp?B?d3JORFFLN044ZkYydURVMGw3cElsVGU0RDRVSXNFRzNZWENvbjVzVlNk?=
 =?iso-2022-jp?B?VzFVRFR0WlpCeHhjNTU4cE16RFFYT0VKWkFCNllEMXI2dExxOUxvKzZu?=
 =?iso-2022-jp?B?ZTFwSDRDZ2NsMEJjY25SYTlwcU1ZRTBXZDI4K0hyNU4xSUZGdUNuQ1E0?=
 =?iso-2022-jp?B?YTk3Ynl1YXlLT0h0TVU1RC84SWVSNXNjUjROSzYzYk5mTmRXamNiU0lm?=
 =?iso-2022-jp?B?YjVpRUZsNHNsOGN0aHJ5MG4yUE4vV1kvWnRhTm9HUTlDQUNSTEhYbFZO?=
 =?iso-2022-jp?B?VFBTeEkxc2dhdnRHLzQvY1F3OE1MYmNyMlYwcnBKSTEzUkVXa29GdjI0?=
 =?iso-2022-jp?B?eThjaVlmenF1emw4YWthRlU0bW1kUDJwRVpCMXFhbmlhS3U0L0xBOFkx?=
 =?iso-2022-jp?B?cERMME84TXFhUkVnVjdOUTlMM2tkejNtMU1yaW9tSXZ1TnRhNW9pT0Fm?=
 =?iso-2022-jp?B?OHNRaERjdEZQaWthdXNDTElUWThXcjRNUjFLTmxCN0YyVmkydm5ZUEdr?=
 =?iso-2022-jp?B?b1U0RDJLaVYyZmZhenV1SnhGb2dkcGg1ZEV4NjVnM1dRRDlXTUxTY20y?=
 =?iso-2022-jp?B?UHNFenU3Yk9wTjcvTGp1Nm1UMWtYeW9FczlWR1NWNzNwQ1c4V1dOaE9O?=
 =?iso-2022-jp?B?ckdDaE1oOGd3Q1BjbHB2dFJaZW9uckxGU2RrdUJjMllVdmEzdGRIdWlR?=
 =?iso-2022-jp?B?SlR3M3NuRlRhQ1JxUXIyUWpYckRwNVdvWkozYkFHRnRudFhRbW9RbXBY?=
 =?iso-2022-jp?B?c1BKRzlSQ2dqZmxoZ0I0WHhSZ3V2ZlNxSndjUTN6Skd4MkxIM0h5aUlv?=
 =?iso-2022-jp?B?eTlRSWk2aUdYakJEblhLaGg5LzlqbjYvSld2VXRWRklVU0lBb1hwWUpI?=
 =?iso-2022-jp?B?R1RPYmMzWEVCOVhiaW1EeW5rT2R1bFovOFV2M1RLYWFrN0ZDZ1NFZXRi?=
 =?iso-2022-jp?B?WUl5VnFxakp5akl6THhSWjlRV09ycnpEYjdTeTB2T01YZkNMM05tQjFT?=
 =?iso-2022-jp?B?ZGFnczczdjNRSjl3SktxMjBYZ1c2TGx2VGNMbVkyZEZnTW9rVzVvbWxX?=
 =?iso-2022-jp?B?Nk83MUdsMENQc2xDR2IyZVFuZzk2eWhXcEMvdXVoSFg4azZOaVhqd0No?=
 =?iso-2022-jp?B?WEJLTU5hQlFpNXdsMzZ1TEU4dUd1ci9vK3RDUmQ2MXFCV0psQTlYY2NJ?=
 =?iso-2022-jp?B?VjZoZ1JyYVpKT3RJTmRJYVZYT2pjY3RycWxVUG1JWmt0RG1EbGQvQXl0?=
 =?iso-2022-jp?B?bmx2SklTV2FvSGVQRWZpbEJXejgwMXNna0FwVFYvd2RNRXpxdzRRZzhD?=
 =?iso-2022-jp?B?MlcvQmV3VT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: XeOgAMTRz6QLNI4Wvtv6F1WnKCdDCxJMPO1ThocCOTN9BdNdAkjZeQnCfWydCnUNHB0LbHcWKVmuYzuKr0i5QnaOp1TuXYIg59e/l9Y99MnBQzLUYBvAm34HmLuDySjpJLvnuDVF0mHZ/iZyzXc4ZdioCX2v1JIbz3bkGzbSK2Yk4RGwVSN/96y1y189qarWgAxS1+pZcXrIBGVO8YCbNOwqOXEeoOdqdTy3cySeJC1kCJuQ0N0v7HZWayka/nHRqJVPdK2ea43xZPFTOJDrZNjaRVMwtpj3+a4Un+1Rpr+BQp76pXApZuDyFteeVL3cgAQtFM2VYo8SiAXjpXRndQ==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea522f50-9061-48ee-9366-08df3e096839
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2026 02:30:23.3647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iK+2iburfenUneXagFWFQbTD+WpJHhm3/RavGdkeMLQfd8jRfLRxSIccKsg0C7uy49LgDqVqOeAg8pAgk0B2CiWRhf79KiavuUXPxjhJ+teTfhWtTzMkdTXDAmv0jxue
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9297
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 09 Nov 2026 02:30:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24670

Hi all,

> -----Original Message-----
> From: Pavel Machek <pavel@nabladev.com>
> Sent: Friday, November 6, 2026 1:10 AM
> To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#D#I#T#C!{=1B(B
> =1B$B#C#P#T=1B(B) <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel Machek
> <pavel@nabladev.com>; Biju Das <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 6.12.y-cip 0/8] memory: renesas-rpc-if: Improve xSPI
> transfer handling
>=20
> Hi!
>=20
> > This series improves transfer handling and runtime PM for the Renesas
> > xSPI controller.
> >
> > The first patch configures runtime PM autosuspend in the SPI driver.
> > The following patches reduce redundant register accesses in the RPC-IF
> > transfer paths, move static bridge configuration out of the dirmap
> > paths, and ensure the data buffer register is not cached. A further
> > patch uses autosuspend after transfers to avoid unnecessary
> > suspend/resume cycles during closely spaced operations.
> >
> > The final patch marks the XSPI1 boot partitions on the RZ/T2H-N2H-EVK
> > read-only, consistent with the existing XSPI0 partitions.
> >
> > Note all the patches have been cherr-picked from v7.4-rc1 kernel.
>=20
> This looks okay to me.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>=20
> I can apply the series if it passes testing and there are no other commen=
ts.

I reviewed this series, looks good to me too.
I applied this series with Pavel's reviewed-by tag.

Best regards,
  Nobuhiro

