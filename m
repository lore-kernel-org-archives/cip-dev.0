Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF398C88E50
	for <webhook@archiver.kernel.org>; Mon, 14 Sep 2026 06:04:16 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13976.1789365850000322353
 for <cip-dev@lists.cip-project.org>;
 Sun, 13 Sep 2026 23:04:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=a61FmbUa;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.135, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1789365848;x=1790575448;bh=Wb2lVLNhA9EkdiNmO/IOeM6nlVtLKCH22Oeu0
	xuWMBo=;b=a61FmbUa1EoPgwSyDe0hfwP/Ik/rJ1bHrhL8uOrjqqx2dt6SfjFDLVFMJd5ldhIfay+
	t72IOIp7SxFMXDn6xqdMQQHGJF7qt20U1ESJotJpr7wT/v6YUdNollsm8UXfLE+/4yNukrfmbPw8y
	TaxWh0E27MkzPqTWKbVQFEq+JKGRFfB25Wzpz4Rtt8WMd7zQtUxcs2MaW79enL79h+w/kpuqWLqnL
	OqhA0+fA78ulu2AyTkf99DTWxEPEZKPpX6cjQhhgueIRb/lA4/t8//FW+tP1XXx/giOmoijHNTqlp
	5izQOYn9yNnPzQC7AQepsO1Djdxo076SS95C45RNak9w==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 68E648sR2261014; Mon, 14 Sep 2026 15:04:08 +0900
X-Iguazu-Qid: 2yAasLCAnsW0YNcHRp
X-Iguazu-QSIG: v=2; s=1; t=1789365848; q=2yAasLCAnsW0YNcHRp; m=ZcPqnosz7hgqm6UZzVjdLa5uQOQqN6eiVbEI8w5jmnU=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4hjvjg6zrdz1xnk; Mon, 14 Sep 2026 15:04:07 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=raLa5bhYVlxY8/2xHn6e9PZZI57FACAU6XDBlE1MN9RWP4jGcLFz2ocj/xnXXrWyHdZ72n0DWD45lYakssD2ge9pQ7ob60yxU6vjorjDdSa/BNvPUqce2FppJ82qbHWJkWt8OA6neimOLN0jGpNu/0+AS24SneFhztgbQBborkky5z27UsWnfP+03p1vw/YyQqmhH48QIEf1RGO0hSxCiKHhF+MDS1ns7tp5I39cDM82hkeSRWuoZKbcemkmJzBsbLytpJEuGhLfbFRdy4EDVTEAeRjgR5UfgRP4kMOUHIfsEMQMtqlM2pcoHD8PtlYhyPuQ3B7q8CdXSlz45OV3qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JDxw+/ffCZYi9IfZr/vBar58eZW0qMMy6khpGUGWHPM=;
 b=U5qV/3G8iRpzbWXPLMG+lQWg/GWnPvflF3MUpQQRafK7tRJAjE+yiRMj8BOQb3JgVm2c6j34AHujYmoMVzXqRO1uedtLCLIz0c5OOcpLYakhlIZAfmjcVS02CmtIL6eGXP6iZsbnI9fyZtupPCCpgTbAmZzfUZa/BjweVTg34XAv9UITTFvxfCfkWa/5hJNvqePYAbefZUDJsJOOLhoCW5DjnHEdzPwyFRrc0smF0o1FcC2unRCpSnolf0ZRRtN9nn14VScBjFMVU9Urc+9T62CkGRbneB66D9x7CKR8HzNaYn1MUsZc4+uJZPyfZY5xH2agGCmJ+CdR8uCZNWs98g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <ovidiu.panait.rb@renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@nabladev.com>
Subject: RE: [PATCH 6.12.y-cip 0/2] Add RSPI DMA support for RZ/V2H and RZ/V2N
Thread-Topic: [PATCH 6.12.y-cip 0/2] Add RSPI DMA support for RZ/V2H and
 RZ/V2N
Thread-Index: AQHdQ54dYkJtuHLN5U6sjva/iIpBybbNllcg
Date: Mon, 14 Sep 2026 06:04:05 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818DE7C584C2C09A6AE14B6CDBB2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260913163634.77803-1-ovidiu.panait.rb@renesas.com>
In-Reply-To: <20260913163634.77803-1-ovidiu.panait.rb@renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYWPR01MB9574:EE_
x-ms-office365-filtering-correlation-id: 7e963355-b427-47fb-c5f2-08df1225fbe3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|38070700021|11063799006|56012099006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: 
 nvQ8X47Y2rTe/1d2etwHFjpGk8/0vZIG0xQM7+5Wwrce1rmyQCjJnkKOoPy2Xe4w+Fr2GxBMbJLsHMN4t7Kk6mMvOf29tstCZFoZ2cmZB1DhD2mMDgnkFY7R2gJzIOOuaTcrfIm2Fr+FZE3wlcdkpj9jESK87HACgV5q5buWI0SPpnCQ6UkArQZ2GVy0iAHa4AdliPPzZlJYlAVF3e+kW7Y1r793Zz0IgzMGTcIRtuTxqJ9PFsEp4HcOO50XuCe+bMOnHJ3psRi3ngE9siCPAad/TMsmYHgtMG2Tl5+2EDzKuWuCBle1WwSCKCLjIDA948y18yrEmHiUZ5P7Sda+x/A8C0nSezRsd7crkXDyo3ej0Iw2ddKfqwY/2n3nGNRl8NMR10vNJd0QiY4s/d5b0w/+juQ9gObjit6nrJdDccVpmKsvjUdKTI1KuYN4RpXnBYdHSkFcCWenwex1CaYEwuS/nD6cIus49gC7wtpDCUsueo/kxLfIpmwqnC/yJTOEIc7M5mUzJrY6l2S39ge791rStWqSEZVOM7pW8TA7tNTtPNvpl5Pz90ugxENvQCeYRkjJFQedm66Im+o5VSpdrin+yagYyIIvkLloKRaR+G/Ty1aF2zMnF6M/yW291kv22kN+J23ak5VxGFUall0oR6+VSu3h+ZrdA/FcdN/z7Tj49iyyKBsqcdeB/TGfwGtvhF34LR/wfqX4sB+3q9EbvH1VbKhdCwSpaWdsfdi6SI8=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(38070700021)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?d2sra1l5R1RDU0FTSkZWRnlJWmNDZGdEd0orTzFtaGVwVVVqTXBMcXZC?=
 =?iso-2022-jp?B?SzJzbmxPVThlTXBIVEdRL1UxSTVKY1Z3R2hLNGszMU1uUFlnNVBhZDRo?=
 =?iso-2022-jp?B?KzJWVThxK2hvSzcyL3U4ZG1vemhWSGhFUGxCbXhORkxjT2dPVWxPREFa?=
 =?iso-2022-jp?B?RjVjeTF4TlNUU2U3VE9vNTU1b3BDRkVHYVoxY003UEc3eDhjQk1CdXU5?=
 =?iso-2022-jp?B?S1B6WXVITGZicGlCWnNxZXcyTS81U3c2UW9UUEVxTVlkV0ljeGcwY2t2?=
 =?iso-2022-jp?B?OGUzQlFINzFpaS9PZ1lNVDdyODV0WlhTNDZaYktVS2V1dm5OZENsVm4w?=
 =?iso-2022-jp?B?RHB6cmtIM0tDT05acGdwTzQ5NWY2UlMrd3V2bTlZajRDdE5peThMbzkw?=
 =?iso-2022-jp?B?N0dIdEM0b3p0UGFEcUtTdGVaWHNSSlNrU1A0YW1WcE1CbDY1SW9ZSkRa?=
 =?iso-2022-jp?B?UGNybzZUUmdObkFUeDlKUGFQRDBQVk9iNEdRZ2tnNWI5RU5yUFFkcVFM?=
 =?iso-2022-jp?B?U1BlOXhxTkJOTDRzTDl6end0c0wrWHd4bjhDRW40SHFEVWVpUzVZMmJG?=
 =?iso-2022-jp?B?UEpqNjJuak9XSUVzd3R3N29jL0tQK2U0d2dxWGdOL25DekY0WDZQZTJS?=
 =?iso-2022-jp?B?YkpqQ1VqbTk3Rmc0aTVybVdLOGUreFFlamRmMFZ4N25pSzIyVmtmTE1n?=
 =?iso-2022-jp?B?cE04c09qem95S3o3ZVRVOExXcENpVks4VW0xMVlaYnZpSHlrZXBqY05I?=
 =?iso-2022-jp?B?ZDhkbUhtcmQxbllYRThMUm1OamxJU1ArVDNCY1pIbE02Sk83aTZycGZS?=
 =?iso-2022-jp?B?anlBYmZTQVErbzlUamQxUnQwaEZ3UGJzVjNERjZtWDZuU1dmVE83VlJq?=
 =?iso-2022-jp?B?MlpmWHZ4aFN2SjV6M0xTZThvVHNSQnE2MVVjZW1kYld2bllGZ2dpWERh?=
 =?iso-2022-jp?B?Q0lkZmRLTkJ4YldqSjZjU2VaTnVkMFVSQXpkOVhpaXM1UHNvMng4cjBo?=
 =?iso-2022-jp?B?YUQxdk5QUzVrNzFWUk9zQm5CamNrN0tJd3M0Zy9VbEg2NXFoNzV1YTJF?=
 =?iso-2022-jp?B?ZWU2UmMzdVFwemJHdDVJZ085bjg5N3FweFV3eFVZOGxLeG9yeFg5MUtz?=
 =?iso-2022-jp?B?WTRCZEwydThBcy9xT2JwdVBPWXorMmF2YVdHOGhsd2xLN1g0VU43SFhw?=
 =?iso-2022-jp?B?ZnFlRHp3OUFKQXdoRGZZdURLbEdvWU5LYlBtc2FSNFRRN1ZKdHNIZWxX?=
 =?iso-2022-jp?B?TUNsWk8rQ25pQ084eVFCQUVMWnRCYVBjZlcrMS9pYzAzajQ1Z0dPb0Mw?=
 =?iso-2022-jp?B?bW1ZQmJ3L2c4QzVjaVhFeWFIWjE3KzBBSWNtc1prZzROOUhEWlFuOGor?=
 =?iso-2022-jp?B?RnVrNDBhVk9XQmozL0FPM1oyWi96V3I5K1UwZXFNdGRqdHY1eEk5bFBt?=
 =?iso-2022-jp?B?ZDliK29Kcklib3N6QmdWTEt2Z29YY1N0eVBlMWRnaWFDa3gyYjJodkZn?=
 =?iso-2022-jp?B?KzFtenVFL3JHd2wrV0NCd2NzNmZydjAreDU2ZWt5M242bXlwcEErVnJ6?=
 =?iso-2022-jp?B?OEpaREgwNjBDOEh4eEtKdVcvR3BpTURCY2Z2and1SXkvZThhSk4rSXd0?=
 =?iso-2022-jp?B?T3E1a3QydTBLeG5yWCtsUmlrbmFUMlFmQjVXRGtBZXZTeXQ3TlczdVA1?=
 =?iso-2022-jp?B?NnAvanFFU1lCT0tQUVZHQmlMWlovTDRQNHpxbnE4UXgwYm1nV1ozTFFQ?=
 =?iso-2022-jp?B?SU1VVXNwNzlqTlB4UlRuSlF4TlFUa0s2Y1FsbThTWEM1REhqTklWOUVC?=
 =?iso-2022-jp?B?SmhpU2MwWFhBbU9NVmhjeUh4aXdQa2RqRFdLWWc5amR0UGo0cmpOMWMy?=
 =?iso-2022-jp?B?MFN3a08ySkxJc1RzenYrYktZMjg1dEUvbzErU0xRbDhXT1VVdGpXUC9X?=
 =?iso-2022-jp?B?SXh5c1d5cDI5OGQzVWxxQWdZYmMrcFpkSVpRZ0RiV083dEoyM3RPZTRB?=
 =?iso-2022-jp?B?OUg0Q3YwQjRUZkpkVzg1WnNCOW1IUDhHL09TZnQ0UnZRbm45b1ZtU3Ex?=
 =?iso-2022-jp?B?aE5kZklTaDFkK1NsQWZtY2M1ajFtMEZxK1hMMG1URmlScTRGOVAvT0tE?=
 =?iso-2022-jp?B?ZjZVb1FxM0hHdXRVZTRMQ08yVExnb0tMNjVuV0dIQmNZUHdhRWI0WVBI?=
 =?iso-2022-jp?B?L1hISUw1YU93WUx2cldYRVdENThVVmN2eXY4TnAxYUVXR051dFNzOExv?=
 =?iso-2022-jp?B?bEgyczMwd0pRNW9aSTNnemhiQzFGSlJjNVkyYVF0UUdieUZEQnZVVWI0?=
 =?iso-2022-jp?B?ZlZHbTdycGUveE1ibGV2cGtDdmhEcWdrNURWMFc3UEFrdE0yU1E3WTk4?=
 =?iso-2022-jp?B?WmlJVm10Z1UrcEFtQ29hS2dxQjJmUjJKZWt0WStXaWhhYU5qWDU4d29D?=
 =?iso-2022-jp?B?WEZpaGt1UEdRUDB0L0NaOUx3UWJ6QjRPQzhKaHJUVVRWajhicjhkUEpP?=
 =?iso-2022-jp?B?SHNpZ0V5a3R4VnF0Q0d2VE15bVFqS1NvWEpVZWNVdVMvWGREekpuS0dN?=
 =?iso-2022-jp?B?Wk5pNUs3OD0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	UCZvD+YM5Kyut8oahO8VyAfXNvuf00IJy/yecdbZw3ApZ2sBJH2SBwNiEldmJZaox7YfWWXzFuAfwuy1LaVDL5GSa+zTVm4xh84FpBHsO/3PTK7PmJFbnh1RGfj/9CDEiXwbCSHM0fS0u2HeTnHvZkPYXpOQTrM1sjnrr6bp50+pQDqZZUk+7K8qvrO9U87viFdJFLUkiOIcpn13l+7gt0OJr1NI3QWoYgFtuF4wxw+IxkSRmns8gA0/4Bb2cokiMCOjYjSrfjgnNStQdEhx9jnZR7XckIczN3yoU5YYPTQ2+H0C8Ei9Kld1PthznJiliN8nZEoHaZHZF+YiSm8/BA==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e963355-b427-47fb-c5f2-08df1225fbe3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2026 06:04:05.8941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wCVOaeumUhahCv69newjTEJ97Y8y/bloq4npl6Y1Yqja2L4AiQu7/lckCjP2Zokt5J8k3ozQKitbd9av3dXayRFXGFtRBL3pFxQ4BLjPK71KBEQMzE9ba3lVUbB5XHvL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9574
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Sep 2026 06:04:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24163

Hi all,

> -----Original Message-----
> From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
> Sent: Monday, September 14, 2026 1:37 AM
> To: cip-dev@lists.cip-project.org; pavel@nabladev.com; iwamatsu nobuhiro(=
=1B$B4d=1B(B
> =1B$B>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B) <nobuhiro.iwama=
tsu.x90@mail.toshiba>
> Subject: [PATCH 6.12.y-cip 0/2] Add RSPI DMA support for RZ/V2H and
> RZ/V2N
>=20
> Hi,
>=20
> This series enables DMA for the RSPI controllers on the Renesas RZ/V2H an=
d
> RZ/V2N SoCs.
>=20
> Patches were cherry-picked from mainline kernel.
>=20
> Best regards,
> Ovidiu
>=20
> Lad Prabhakar (2):
>   arm64: dts: renesas: r9a09g056: Add DMA support for RSPI channels
>   arm64: dts: renesas: r9a09g057: Add DMA support for RSPI channels
>=20
>  arch/arm64/boot/dts/renesas/r9a09g056.dtsi | 21
> +++++++++++++++++++++
> arch/arm64/boot/dts/renesas/r9a09g057.dtsi | 21
> +++++++++++++++++++++
>  2 files changed, 42 insertions(+)
>=20

I reviewed this series, looks good to me.
I can apply this if tests are OK and there are no other comments.
  Test: https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/284=
5750901

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Best regards,
  Nobuhiro


