Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 737D11076369
	for <webhook@archiver.kernel.org>; Wed,  1 Apr 2026 05:23:12 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6092.1775020984582484741
 for <cip-dev@lists.cip-project.org>;
 Tue, 31 Mar 2026 22:23:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=elAe8bYD;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.158, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1775020981;x=1776230581;bh=t0UMUHZMRaSf1IiO7fFKKAyzhJemnYvBPxoXq
	E9LOzk=;b=elAe8bYDFO42wtWvPbcwliO/toxDcdy+mUZhI7ITrTNWSa77VBnG865s8LYyVz66vgE
	GJKgRyvAs5WoAG9jxe8Ax989pL92bywYesJxlN77LHnd6jSCdc+je1gYkoM1P5GQY4pt9H5C16j2t
	86m7vTFkzmDvfWh0/0BQ40zRVn3GH+CoMsqWttBy34mn95x5Yc33PD9VAUg5WnS1JIbdyIqlX/I7f
	XUymjRI+usvvZyQEc4UQP25gvtWHBfrxGbEzVkol2rlL9UhshsSS0dH+qgExOkpwaukiNd0cSR3dR
	WYFJZ3BbXLgAE7EcEAvPIJf8BFU/WLJ0NucUXk/d5CPw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 6315N1Lv794835; Wed, 1 Apr 2026 14:23:01 +0900
X-Iguazu-Qid: 2rWh3Ooo9Kju2ddsua
X-Iguazu-QSIG: v=2; s=0; t=1775020981; q=2rWh3Ooo9Kju2ddsua; m=h2RCeUqB0fuTeLSYbI+yQBgcsgd3EyRgkeIxMWHtRjA=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4fltfr5Jjtz4vyh; Wed,  1 Apr 2026 14:23:00 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V+bpEaqTbMqlrS19aTTANzq/ZZ1cE0Lcl48wBzp266g8w1tlr6o5Ts7eaMBcBY7LDE4eekimZPjpBtOXkaAkcvcZUwDthL+MxK/bm4BJN7T2Q18Jfh92BRsGrg57v0myQizj92IVrI1N56DKAWICaqmnAto+RnqdfDZPF00DM63Q/L0HAe/SxqdmEeAIMFluFxCvJayxGAfc/BsHSy+R1x09oZl8Hu8DKhInIb/6YQ1P1uhBm1gb3dIbX/n5g1Bug1iIlFHwopzjNZYFjpoHDXQso5mN196lghHBrndzd1mULwFid3/TpD40ETsgZm4IPscfh8vXZpcPcj0OxzFbKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t0UMUHZMRaSf1IiO7fFKKAyzhJemnYvBPxoXqE9LOzk=;
 b=ISHDlNZJNYbJih4ZU+7tFb3uvcdSvIaALuA5okpz0s9/FrbzMXDMdR1xj+1s2JWm3yYqK7bshd2Ug+fE3g7PIpW88RzutgTlCPtdpkuZldHEuRZFY4YmGIP4AERfRecd6qmSkci09GDgkC6hBZIf2B2xFHkRCOy49u3y/PHfKp1oOtykoFtWaaEjb0aqgQ0g2y7vrAKIAkke1/7NzpUIUTPCxr1ht8g72LnNw3PUkI8e5nmn4t8edXA11ww0IwTJwgL2WXNvBkcLWikCUh474gzcJzS1X6MiM7GDO+EK/E0XRDLPtiAGgOCfpW1N4nciSAygONjhiC6sjIUWCD31Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <claudiu.beznea@tuxon.dev>, <pavel@nabladev.com>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [PATCH 6.1.y-cip 00/17] Add RZ/G3S PCIe support
Thread-Topic: [cip-dev] [PATCH 6.1.y-cip 00/17] Add RZ/G3S PCIe support
Thread-Index: AQHcurUEgTGpo9U8nkK25AEyWq+DcbW9ZYJQgAwYGpA=
Date: Wed, 1 Apr 2026 05:22:58 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB1481826DE218BA77D5551C3F0CD50A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <189BC4ACC53FCB81.1328210@lists.cip-project.org>
 <69b5da97-4fa2-4ce6-a1f7-74b9bce6712f@tuxon.dev>
 <TY7PR01MB14818E4EF12163C4F09CDE5AECD48A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TY7PR01MB14818E4EF12163C4F09CDE5AECD48A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYWPR01MB11363:EE_
x-ms-office365-filtering-correlation-id: 20c13cc0-1752-4488-fc0a-08de8faebc99
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 
 7cKe7UjlSkgcLWPXrT3knmsFQQq2u0d7OLE5/jkLT7Jcb9IPxImM+1G90bbJxiOeW72qADy3jtQU/o59jhK1/ZgVzHNLmD5MVXF/PEi9EgCfO29v1u9fAkHJ/rA2dG/YXJJ9OiQd7cA78VRJra0HuU7cpNw2wQVoLKTueM4tDMxBADHCwRZTBiEveXey3tPzTUE5zdS/nai7MC1NjDTCtEcmfDMcTIljnrGJm9Xv2JskaaXGV0LHFGUW7ggT9oKjpuRFqMPvkz1HWSdrjHGLzODC1pVCx6JALpXOGUqoBGvTPrviI1+OHy8Is/sqtzsN2cQ8W7Z+hDbIqssTdKBKbNdhtrVeBeyUBgTi5xI8HTrGROpTcxpQjySHw1igrtG8wsWSXJXWlU26VkGqSr0RHlv7+TyNlbcJi0G4emAcY8RtBagRiV+LR6BJkjNcuJNSglSmucp8yGnOFpnQnRqq9WWwq6xl3WVB8DgXtLvZqZAiAOQcak4Z59cze1wjhOjuGDRGaQMABhtxz/lsRG0XjjfrA6/MEK6L1zpTWPRkU9XHJx4vj0gnMKmkG8Af4dF9j0l18AeEakSJXQMJxDrj0YTNNFwBHnH/Vnu5mgO+pWXoj3j0yA90tfxTjbqyYpTUzgaezA9BpHYWygrQtzjWEOnCBE8+7CU22VOTpoKf5V1dfv0uL3mEtVa2+gw84JDD8C6SRWaFHLQDuQbxhCtXxKTHdgq2xOzAXdASSdc0VYJdAnF7dgl9fC3EuzMI75ogx8hg5o1D5BrDiAbjMi6fJfXwH5gACiiNvD7x0X+WSXk=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?a2hmSU9Na0IxWElzZE1RcmVsOTBaTFZiY2FJSFNMRlJxS3NEU0ptVGZLS3lF?=
 =?utf-8?B?ditMR05zVzM1cmh3YkJlc1huUWVnSlBYSjFsb2xaNFRDdVlYakFuMDE0Q01j?=
 =?utf-8?B?UStmYUw0MzNpM0dJdTRjeWJOSFhkZWtZdmtCUVBLYndRb3hQNUZab1o2WjF0?=
 =?utf-8?B?V3FvZ0dTWkQ2N0ZzQ2drR3p6Y2pqSmZVWEpqM1VkR1FRZnpJR1VFY3pDMVU1?=
 =?utf-8?B?bHM0bFI0TDNIUTYvU0RTTVNoakVhQ1YxMG1QZHcxZ0Qyc0ZoQUY3NjB2aWh4?=
 =?utf-8?B?S011ckpMS1I2Q0ozZnQ0ZmFLK0Uwb1hPQU9lcEJOQmwwbTBseUN3RDlNQjRR?=
 =?utf-8?B?ejN6NTE1SGlMYkZFTTFyNWpoMzA4V1JnV2tqZDN5MzRibWF0QVpHWjh3SkF4?=
 =?utf-8?B?amdBYnNWNlQwRmo2R0V3TjAvMFE5cnhrUGRnd0NMSkk0V3ZrT1ZJNDd0MG1u?=
 =?utf-8?B?N1k5bVFmeURlcnYyeCtYMkI3eS9yMWd1WEI1NWIwTERVZmsyLzIzSFgxS3Bi?=
 =?utf-8?B?aUdnZXZyOUlaaFM3RkwzM1ZkclpNR0lKZGo1WnZhRFB6Vis5VTB2MnNjZnBq?=
 =?utf-8?B?Ymd4dmFoSW82d28wRVR3ajJxcHYvekZialh0QjNCNHNuVzBwWVBxcTFSNFdH?=
 =?utf-8?B?SXMyNDNUL0xhMUlqSWRxK0p0UmpGR3NUMDg0d2JJcm02NHpUeXlZdTBjTGdt?=
 =?utf-8?B?a0FxbVhzTTB5cVp0eUFnTTFIMkhRMDlzcGp0cXREbmFtR1RtdW1NTndaY1Rm?=
 =?utf-8?B?NkpOa2lvanhOK2E5K09uWG5XODYwNUxZb1gwWG8yV01JQWxENUFlY29ISkkr?=
 =?utf-8?B?NU52SElHYlhSQm9wd2lsYS9VYnh3dW9vSXEvRk9MQ0ZZazkvMGRUdGk5Z0t2?=
 =?utf-8?B?ZmlPbXJJVUcxWlZxbTRLcFp1WXFCZ0tncC9VMUxGb0lvK0t0bjdlQ0FDaTFV?=
 =?utf-8?B?S1YvV1NRTEl4b0RTeFBXdUVCZUpzZmU0elNZMUtqdXNhRlFKSDhHMVphaHQ4?=
 =?utf-8?B?VXZWMCtCVnJVejZTRnhCVGE0ZWxmV1JXSnc2MitTR3RjMjlDeVBXZzhoUmNG?=
 =?utf-8?B?bm11eVpKQWp4b0F2NmkyeENFUmcweU83dnlKbFkxc2czeFFpWEJLSnJkTGF5?=
 =?utf-8?B?UTVPOEhyWG1Pb2JQejV5cVkrSEpWS3ROL1NrbmNDK2xGcDl3dVd6SHZ0M3lL?=
 =?utf-8?B?VVhjdktFdTR1aXN0M0phbkZnYU5BczMrZUpXQjdoaU5LTnFpR09POEsrM3V3?=
 =?utf-8?B?blFLWTdoU0pYSUZPNjkzbkxmT1FNWlAzN1d2K0sxbDZKVUgwVStCRWRrcFRI?=
 =?utf-8?B?MWRVc3A0d1Vqb1QxQUIxVzR6eVFtM2RHY3VIQ1FnVmtIN1d5VUZoMlI5UGo2?=
 =?utf-8?B?a0c2SFZNckdmWXhna1RLbmhRWDJGdWR3d2s5bkRMdmtWcTFMNGYxYXQ1R053?=
 =?utf-8?B?MnlKdlEvVFNlcVIxUjVkakFVNGZES1QyMVhWQ2ExOTg1WlN6MGRiYXQ0NWdS?=
 =?utf-8?B?QVVBaDhsWWVyUytHMXVMdmNWWElBQUNRODU2SVdkQmgvZWRiQUxCNWNjUEU0?=
 =?utf-8?B?ZTRmWXB2ZEpDMDdXd05nbGxCU29wYy8veHF5U0FHcGNLdFl2eFpSc25JTXow?=
 =?utf-8?B?S0RpYTJQbEh0VVpiL1RKQjI3bDFXZ3Vqb2J5UFZ0K3B0UTMwcEJtSjVrNFEy?=
 =?utf-8?B?Z0lmNUxRWHlPNFlXR3p4OGJNM2xMeVk3SWkxaTRkQURXWFR2YlJCYytyV09s?=
 =?utf-8?B?RTQ3b1NBaHY0L000dXZOU3V4YW43SGJvZUgydDBVcnYxT2YrdnRJRGpCT1Yr?=
 =?utf-8?B?Q1lqeU5DR3VDS3ZIWWI0eThCUmw5Z0FWOFRtK1YvRDBZYVYzNnlTVmgzUXVh?=
 =?utf-8?B?QVV0UjNuMVA0Wk5LZCtrL2svdlpwWVEzWDdrblNYRGtIeEJ4QVkvU2dJT0Uv?=
 =?utf-8?B?Z1drWGwzUmtmb3N1d2MxeUdtWFhjMjV4WGhsOXArL01Tc3ZINVBVZTN1ZGxY?=
 =?utf-8?B?Q3JPelo0eE5KTHZ6MUQ5Rm9BekVac05CZmhjekhUeFgxVGJqaWFucmRKc3A3?=
 =?utf-8?B?SlJGcHNwVGdLTy9sRmZ0WU5LdWVGRlY3UGIrOXRmK05sZTZRLzk5c29UL0pj?=
 =?utf-8?B?ZHU1anpkd3NKTEJkZDcwWEFWcHlsb1pYaHBSdlA4M1VqUHhrZ3JTT2VBMGNY?=
 =?utf-8?B?LzN2NHRLYkZLakhDY05EVEp0T3BaVXJWRGRvL29lZkNpazFvVDMrUE5kR1NP?=
 =?utf-8?B?V3VkK1V6eTdQT092ME1yT2VieHU5azJiTjhIWEROM3hWWlhsbTRiM2NraUVa?=
 =?utf-8?B?K01NZ0x2QzFSS2JOcmRyYm1DTUZOejhNZXo3VHlJbHpRNkJJbnJKMXZwMGJz?=
 =?utf-8?Q?9gZwESRJDAKAREsY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	mIOyX41F27qh42zKBzX/oVahpFmeq23+VjFAALMB1gRNBM+QMKP9DNJKUyhFql09XFPD2z3FT/C43seb8CESkquEHez66A7IqRz8aUElajnVON2uOmcXCmVnRvGAYu/THyprKrZUf4v+GYu62jEXm2K360/jEB8z9nhIKsnB7OHDeCOEkeFQdWMuOOTcoXD+Z4gKAtUme4CV9kWE3lnVhi3twgZsfHdLFY6ux1cpDfM1J2FdTevsaMXjVknxmTGfd/ccbJ9t/SB2uImMTJFAzjbtQ/Wdqb8VxC2DkWxPr5xQCW/cDmgtvtrih7qkFVGxDnrGcrquSl2H3DZncf6T6g==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20c13cc0-1752-4488-fc0a-08de8faebc99
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 05:22:58.4049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3NKvMinh5m9ycG+8gfrVQQUn/SMYuB2MoNQTAhj/ONYFw+0mEVq9AlgA+gxT3kJ84fO8X+RqQ9lh0jXpaFYjhg+LNE23vQR2bOm8HivW97Xmha0Y+FRkrMuA9c7oAbf8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11363
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 01 Apr 2026 05:23:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22612

SGkgYWxsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGl3YW1hdHN1
IG5vYnVoaXJvKOWyqeadviDkv6HmtIsg4pah77yk77yp77y077yj4peL77yj77yw77y0KQ0KPiBT
ZW50OiBUdWVzZGF5LCBNYXJjaCAyNCwgMjAyNiA2OjEwIFBNDQo+IFRvOiAnQ2xhdWRpdSBCZXpu
ZWEnIDxjbGF1ZGl1LmJlem5lYUB0dXhvbi5kZXY+OyBwYXZlbEBuYWJsYWRldi5jb20NCj4gQ2M6
IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnDQo+IFN1YmplY3Q6IFJFOiBbY2lwLWRldl0g
W1BBVENIIDYuMS55LWNpcCAwMC8xN10gQWRkIFJaL0czUyBQQ0llIHN1cHBvcnQNCj4gDQo+IEhp
IENsYXVkaXUsDQo+IA0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTog
Q2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQHR1eG9uLmRldj4NCj4gPiBTZW50OiBNb25k
YXksIE1hcmNoIDIzLCAyMDI2IDg6MDYgUE0NCj4gPiBUbzogaXdhbWF0c3Ugbm9idWhpcm8o5bKp
5p2+IOS/oea0iyDilqHvvKTvvKnvvLTvvKPil4vvvKPvvLDvvLQpIDxub2J1aGlyby5pd2FtYXRz
dS54OTBAbWFpbC50b3NoaWJhPjsgcGF2ZWxAbmFibGFkZXYuY29tDQo+ID4gQ2M6IGNpcC1kZXZA
bGlzdHMuY2lwLXByb2plY3Qub3JnDQo+ID4gU3ViamVjdDogUmU6IFtjaXAtZGV2XSBbUEFUQ0gg
Ni4xLnktY2lwIDAwLzE3XSBBZGQgUlovRzNTIFBDSWUgc3VwcG9ydA0KPiA+DQo+ID4gSGksIENJ
UCBtYWludGFpbmVycywNCj4gPg0KPiA+IEdlbnRsZSBwaW5nIG9uIHRoaXMgc2VyaWVzIGFuZCB0
aGUgdjYuMSwgdjYuMTIgYmFja3BvcnRzLg0KPiANCj4gU29ycnkgZm9yIHRoZSBkZWxheSBpbiBt
eSByZXZpZXcuDQo+IEkgY2hlY2tlZCBlYWNoIHZlcnNpb24sIGFuZCBldmVyeXRoaW5nIHNlZW1z
IHRvIGJlIGZpbmUuDQo+IElmIHRlc3RzIGFyZSBPSyBhbmQgdGhlcmUgaXMgbm8gY29tbWVudCwg
SSBjYW4gYXBwbHkuDQo+IA0KPiBSZXZpZXdlZC1ieTogTm9idWhpcm8gSXdhbWF0c3UgPG5vYnVo
aXJvLml3YW1hdHN1Lng5MEBtYWlsLnRvc2hpYmE+DQo+IA0KPiA+IFRoYW5rIHlvdSENCj4gDQoN
CkkgYXBwbGllZCBhbmQgcHVzaGVkLCB0aGFua3MuDQoNCkJlc3QgcmVnYXJkcywNCiAgTm9idWhp
cm8NCg0KDQo+IEJlc3QgcmVnYXJkcywNCj4gICBOb2J1aGlybw0KPiANCj4gPg0KPiA+IE9uIDMv
MTEvMjYgMTM6MDUsIGNsYXVkaXUgYmV6bmVhIHZpYSBsaXN0cy5jaXAtcHJvamVjdC5vcmcgd3Jv
dGU6DQo+ID4gPiBGcm9tOiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWEudWpAYnAucmVu
ZXNhcy5jb20+DQo+ID4gPg0KPiA+ID4gSGksDQo+ID4gPg0KPiA+ID4gU2VyaWVzIGFkZHMgUENJ
ZSBzdXBwb3J0IGZvciB0aGUgUmVuZXNhcyBSWi9HM1MgU29DLg0KPiA+ID4gUGxlYXNlIGhhdmUg
YSBsb29rLg0KPiA+ID4NCj4gPiA+IFRoYW5rIHlvdSwNCj4gPiA+IENsYXVkaXUNCj4gPiA+DQo+
ID4gPiBDbGF1ZGl1IEJlem5lYSAoMTEpOg0KPiA+ID4gICAgY2xrOiByZW5lc2FzOiByOWEwOGcw
NDU6IEFkZCBQQ0llIGNsb2NrcyBhbmQgcmVzZXRzDQo+ID4gPiAgICBkdC1iaW5kaW5nczogUENJ
OiBBZGQgUmVuZXNhcyBSWi9HM1MgUENJZSBjb250cm9sbGVyIGJpbmRpbmcNCj4gPiA+ICAgIFBD
STogQWRkIFJlbmVzYXMgUlovRzNTIGhvc3QgY29udHJvbGxlciBkcml2ZXINCj4gPiA+ICAgIFBD
STogcnpnM3MtaG9zdDogSW5pdGlhbGl6ZSBNU0kgc3RhdHVzIGJpdG1hcCBiZWZvcmUgdXNlDQo+
ID4gPiAgICBQQ0k6IHJ6ZzNzLWhvc3Q6IFVzZSBwY2lfZ2VuZXJpY19jb25maWdfd3JpdGUoKSBm
b3IgdGhlIHJvb3QgYnVzDQo+ID4gPiAgICBQQ0k6IHJ6ZzNzLWhvc3Q6IERyb3AgdGhlIGxvY2sg
b24gUlpHM1NfUENJX01TSVJTIGFuZA0KPiA+ID4gICAgICBSWkczU19QQ0lfUElOVFJDVklTDQo+
ID4gPiAgICBhcm02NDogZHRzOiByZW5lc2FzOiByOWEwOGcwNDU6IFVzZSBzeXNjb24gY29tcGF0
aWJsZSBmb3IgdGhlIHN5c3RlbQ0KPiA+ID4gICAgICBjb250cm9sbGVyDQo+ID4gPiAgICBhcm02
NDogZHRzOiByZW5lc2FzOiByOWEwOGcwNDU6IEFkZCBQQ0llIG5vZGUNCj4gPiA+ICAgIGFybTY0
OiBkdHM6IHJlbmVzYXM6IHJ6ZzNzLXNtYXJjLXNvbTogQWRkIFBDSWUgcmVmZXJlbmNlIGNsb2Nr
DQo+ID4gPiAgICBhcm02NDogZHRzOiByZW5lc2FzOiByemczcy1zbWFyYzogRW5hYmxlIFBDSWUN
Cj4gPiA+ICAgIGFybTY0OiBkZWZjb25maWc6IEVuYWJsZSBQQ0llIGZvciB0aGUgUmVuZXNhcyBS
Wi9HM1MgU29DDQo+ID4gPg0KPiA+ID4gRmVsaXggR3UgKDEpOg0KPiA+ID4gICAgUENJOiByemcz
cy1ob3N0OiBGaXggZGV2aWNlIG5vZGUgcmVmZXJlbmNlIGxlYWsgaW4NCj4gPiA+ICAgICAgcnpn
M3NfcGNpZV9ob3N0X3BhcnNlX3BvcnQoKQ0KPiA+ID4NCj4gPiA+IEtldmluIFhpZSAoMSk6DQo+
ID4gPiAgICBQQ0k6IEFkZCBQQ0lFX1JFU0VUX0NPTkZJR19ERVZJQ0VfV0FJVF9NUyB3YWl0aW5n
IHRpbWUgdmFsdWUNCj4gPiA+DQo+ID4gPiBNYXJlayBWYXN1dCAoMSk6DQo+ID4gPiAgICBnZW5p
cnEvbXNpOiBTaWxlbmNlICdzZXQgYWZmaW5pdHkgZmFpbGVkJyB3YXJuaW5nDQo+ID4gPg0KPiA+
ID4gTmlrbGFzIENhc3NlbCAoMik6DQo+ID4gPiAgICBQQ0k6IFJlbmFtZSBQQ0lFX1JFU0VUX0NP
TkZJR19ERVZJQ0VfV0FJVF9NUyB0bw0KPiA+ID4gICAgICBQQ0lFX1JFU0VUX0NPTkZJR19XQUlU
X01TDQo+ID4gPiAgICBQQ0k6IE1vdmUgbGluayB1cCB3YWl0IHRpbWUgYW5kIG1heCByZXRyaWVz
IG1hY3JvcyB0byBwY2kuaA0KPiA+ID4NCj4gPiA+IFN5ZWQgTmF5eWFyIFdhcmlzICgxKToNCj4g
PiA+ICAgIGxpYi9iaXRtYXA6IGFkZCBiaXRtYXBfe3JlYWQsd3JpdGV9KCkNCj4gPiA+DQo+ID4g
PiAgIC4uLi9iaW5kaW5ncy9wY2kvcmVuZXNhcyxyOWEwOGcwNDUtcGNpZS55YW1sICB8ICAyNDkg
KysrDQo+ID4gPiAgIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB8ICAgIDggKw0KPiA+ID4gICBhcmNoL2FybTY0L2Jvb3QvZHRzL3JlbmVzYXMvcjlhMDhnMDQ1
LmR0c2kgICAgfCAgIDY3ICstDQo+ID4gPiAgIC4uLi9ib290L2R0cy9yZW5lc2FzL3J6ZzNzLXNt
YXJjLXNvbS5kdHNpICAgICB8ICAgIDUgKw0KPiA+ID4gICBhcmNoL2FybTY0L2Jvb3QvZHRzL3Jl
bmVzYXMvcnpnM3Mtc21hcmMuZHRzaSAgfCAgIDExICsNCj4gPiA+ICAgYXJjaC9hcm02NC9jb25m
aWdzL2RlZmNvbmZpZyAgICAgICAgICAgICAgICAgIHwgICAgMSArDQo+ID4gPiAgIGRyaXZlcnMv
Y2xrL3JlbmVzYXMvcjlhMDhnMDQ1LWNwZy5jICAgICAgICAgICB8ICAgMTkgKw0KPiA+ID4gICBk
cml2ZXJzL3BjaS9jb250cm9sbGVyL0tjb25maWcgICAgICAgICAgICAgICAgfCAgICA5ICsNCj4g
PiA+ICAgZHJpdmVycy9wY2kvY29udHJvbGxlci9NYWtlZmlsZSAgICAgICAgICAgICAgIHwgICAg
MSArDQo+ID4gPiAgIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1yemczcy1ob3N0LmMgICAg
ICB8IDE3NjQgKysrKysrKysrKysrKysrKysNCj4gPiA+ICAgZHJpdmVycy9wY2kvcGNpLmggICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAxOSArDQo+ID4gPiAgIGluY2x1ZGUvbGludXgv
Yml0bWFwLmggICAgICAgICAgICAgICAgICAgICAgICB8ICAgNzcgKw0KPiA+ID4gICBpbmNsdWRl
L2xpbnV4L21zaS5oICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAyICsNCj4gPiA+ICAg
a2VybmVsL2lycS9tc2kuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgMiArLQ0K
PiA+ID4gICAxNCBmaWxlcyBjaGFuZ2VkLCAyMjMyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25z
KC0pDQo+ID4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvcGNpL3JlbmVzYXMscjlhMDhnMDQ1LXBjaWUueWFtbA0KPiA+ID4gICBjcmVhdGUg
bW9kZSAxMDA2NDQgZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLXJ6ZzNzLWhvc3QuYw0KPiA+
ID4NCg0K


