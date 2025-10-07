Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E537DCCD184
	for <webhook@archiver.kernel.org>; Tue,  7 Oct 2025 07:20:41 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web10.13259.1759821639090584793
 for <cip-dev@lists.cip-project.org>;
 Tue, 07 Oct 2025 00:20:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=ajhSGIEo;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.132, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1759821625;x=1761031225;bh=kfTp9PCB+Z+QpPrr/SIkqviY/rH0J2AU8GK0b
	5+AH/M=;b=ajhSGIEogD1ZWnXYvubD9ds1qyL/ADAuA2x0V1AauaWJJz8pL4LsDRyPwWOA8Tj4nYp
	WYo03VJN50urHs/cv3cdm4YKcJVuGukrNe3cammmdeBZcnIBfA2egEduEp0sjQPDbuc+sXAoBmmSq
	QwBb3M1Ag9xH7D3KFMCzLhMPcAAUkliXak9jQYT8ijMlBEb04hd6Z5idYMOstQKInjR2PZrI4UU5u
	H33L1pLCx0FnlknasgHp5f45YrmyOWrhGlmoW0U7vOGPw1YVEnh8G9GFMFqSVPq4DRFnIyCQYP2G0
	AqpR/06zIvK1EJcpvPigcEdX4mcN+xZnyLGRb5Z5xAXQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 5977KP684075201; Tue, 7 Oct 2025 16:20:25 +0900
X-Iguazu-Qid: 2rWghmkuOSQjqvhOZu
X-Iguazu-QSIG: v=2; s=0; t=1759821624; q=2rWghmkuOSQjqvhOZu; m=luInr6XP/iVEHDBFB/Mvuxqq4MhZnxI/iT1pqBBo9yY=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4cgnbX1ndTz1xnl; Tue,  7 Oct 2025 16:20:24 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WlMYvBjtE6h7HDNWD/KryNdNxmbERGxlNaX7p4dqpDTqRyvAETgm/2B5AJ7sSaLLi5kMUiITAfReytCrOLIA7BWE1y5iY4VYGfQtPpbpdhvbJvfVbDAExpYLGR3fD8OXNnY9Uqx3suc3BzMiEo5G/N+E8ybkljVpPt/sd89la2mull9wMY1zmsJyBQF5HHafiiBz5+z1HEsc5/VL4y5sppRWd0L2YS9BbqyymYIfjoZrBQeK3+/QGLTfR0/pWXLTAVlA+NfhFiDNUm5Z7/Rlo8zDnCKkWl/3Jb7jZEOLUSSnFJXGz8uefWwfT8vph2S251+IPeZlT4LaluVj5FcUwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kfTp9PCB+Z+QpPrr/SIkqviY/rH0J2AU8GK0b5+AH/M=;
 b=yfEyauDhWZkKhSQfF9863LPBktV8rqQY+YY+9Db91yMc0BOOMkGv5vwJZM866gtgtUMfTXjgivNQMjNVtqbFhqFLNpWCQgks4mZbxMODca4ISZP9TN5VLTT5d32wabHazkaTu+OdzGeYlRuhVXcUr5+6NO3+8KFWT5UnOjsWCYCo4MXERxiHmOI6Eb4t+jK+2S9bYCnRqhyrt5ezAXccSXaT8mf9UsrO/FA1SRXrBu1GZVBYDN5GKqQDYeVzdQmCWETwY3gfDvX7C/IE6tRCneFFaGfYZv34KUZRUU7tw30E6oW/M5S5lWa0CnpHbXI+v4zKAVnzt6w8YRbhx/hRAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <florian.bezdeka@siemens.com>, <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <jan.kiszka@siemens.com>, <quirin.gylstorff@siemens.com>
Subject: RE: [cip-dev] Question about git history - linux-5.10.y-cip-rt branch
Thread-Topic: [cip-dev] Question about git history - linux-5.10.y-cip-rt
 branch
Thread-Index: AQHcNrwSS9ZkjA8A3E2JZS3o0weKG7S2RqMQ
Date: Tue, 7 Oct 2025 07:20:21 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB1481824F36B087FC812BE2C12CDE0A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <a4d4c0af30fac7d969772bc80f8bfc1163c8d0d1.camel@siemens.com>
In-Reply-To: <a4d4c0af30fac7d969772bc80f8bfc1163c8d0d1.camel@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS3PR01MB8538:EE_
x-ms-office365-filtering-correlation-id: 5d09cb53-5706-4abb-b362-08de0571f9b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: 
 =?utf-8?B?bDNka0YxTU1TN05WOVFiTHgyRnlsTGhGUlNWRHJqTTBzeFJOUnRtTVBXNCtW?=
 =?utf-8?B?ektSbjh5MHFHV2dSdmhFY3JiSnJ4YVp1cDhiTjV6WGJzNVNuZUgySk5tS0dI?=
 =?utf-8?B?S2NsTlUzNHZPT09aUmJrYmRnOElJKzNsMDVQR0hVZ2ovNS9aWVhqS0N3YTNx?=
 =?utf-8?B?cWRKcWdRK25rRjFOZXFGTkJRcVJENk8wUXhQUWo1cHlGZTdLVkhWR3hQSVJl?=
 =?utf-8?B?YVlqY241d0l1cDU3WlAwV2R1ektvbkFoWnNKT1lPSmpWb242d3I5RmdEN0xi?=
 =?utf-8?B?VHk3U0RsVlpEaXRZckh5cHhxWVdFeXQyNEY4bWdLSEJjYVprU2h0VlE0YjNU?=
 =?utf-8?B?V1BVeXlVQmJibkhxK21CNUNjcUlTSlZnTFlOc1hLcE8rOFZZRzAzZFJuMXlP?=
 =?utf-8?B?NFJLckxZQ1NkL0VSMTNiODFWakRhS1pGNlNsdit3VGxBVDk1SDdKUDdmSTdB?=
 =?utf-8?B?UkRYOXh0QjZTZjQxLzdUdVNGMzZka1NTN0hDN2N4V3dDVmo1OGlqWWp0WEdn?=
 =?utf-8?B?YXNDbVdFTURBZk9tc0xucDJhNG9nL1ZLV1o0S1NOSnp6Vjg3L3d2Wi82QXRM?=
 =?utf-8?B?NUdVNHpXVGFGUjc0WjR0TDRYUi83MGdXeTh6ZTlFTWlaWDY0YnJ1aVBvb0V3?=
 =?utf-8?B?Y1RGSGtIKytuUEtZYWRLRG0xN1JuS3RyeTEzZno1LzJxTDVRcWN5b2krNVhl?=
 =?utf-8?B?SHZqTUMyTmwwWVNsTFNnV1MxZ2VGNTFaZGN4aHpWcGdHWSs1cnFNWmZhNWVD?=
 =?utf-8?B?dTAxUWI0WVNYRkpLWjV0L3h0TjFscUluMWxrUjZMMXExZXdIaVdUT01sRTEz?=
 =?utf-8?B?TVdqTDJOcEI3SFAwakdML1BrNlNKQWFjSWlmNkIxbEZBL0IvTjNpSUdOVFRv?=
 =?utf-8?B?Mi9udVdvWHlzbGwwdDUxZWFVVGJ2SUh1NXdac243VGU3QnRxa0E5RjhRb1RY?=
 =?utf-8?B?Mlh4aFVaVEhtbmdJNk8rUDhBeXdZZmd2T2hUS0lNQ3Ywd1lUYlFVS2FMLzJj?=
 =?utf-8?B?OEVnSEpIamc0d2NtUVdBVEpPUWUveHVNTFBVWkVaSk5DOW5YYm9RUnc0dVBN?=
 =?utf-8?B?RzFLK0QzdUtxTWVRRlQ1ellhZE1iYTVhYkQvaERQeExFVVcxeVZrMS81VXlh?=
 =?utf-8?B?bU4yWmRDQmxDc29oUEhGWFhidWRUeWRBSVZMQmN0SU5lbllZelBoZkI2L1du?=
 =?utf-8?B?RDZHMUZ0c1FxWEtDM0xJaHFJNzQvR3lSbEtjNEU5R0twUERvR3hoWmZlUFdQ?=
 =?utf-8?B?bmJYanY2R1A2Zm1YNWx1SjVrOEJaSFFObnlCSWlVRkN1cXprSXZZbFhKeVE2?=
 =?utf-8?B?bEROZmoxTEpIU2paRk9MekQ1MWJXeXpvQVJHb01uZnIyc0ZWemo1blJrdzBw?=
 =?utf-8?B?Y0NtaWxDUmR2Y2FHQVkrWHZ3WndMRjI2a25MUEJ1L0F2Z3ZpSlV5ZnZjL29l?=
 =?utf-8?B?ZEp4ZU1mR3pyY2k3UTlJVDl3SFFNK1JJMWVzbzNUcHpKNXQxa2EraXJZek9s?=
 =?utf-8?B?VEZLR05UMkFoRDc3Y2RCSlJnWHlPRmR6b1FVRVlQUHBxVVVxVEI4UzU1WjQ3?=
 =?utf-8?B?R0VmeWtzN0VjYUpRZXdBYzhFcU9JY285Vy9MOG1kN1pOYXg4S2xycE0vWmFQ?=
 =?utf-8?B?NjB5SGNORUtCTDBnWDlzNmtWSWFvRDVQRDY4UXErRWJpMEdJS25aWkNjeFJ0?=
 =?utf-8?B?elFUeER3WEtYUUhpMmxNV2Q5WGI4SDRQdkZkSFNiWTVYV3RDYmgvc3puT1A4?=
 =?utf-8?B?dDFUVnBNQ1phU0JZNi9GNmpLVFUzSnBhRVU4bXV0bURXK0tRTUltem5QVjZQ?=
 =?utf-8?B?NW9jakhmR1VoQWdwYUZ1SDFkNGk0WUZQR0R2MjNsUnhDSUdDSHo4MC9YQVVH?=
 =?utf-8?B?T1NUTWxQQ0VGY2cxeXZZRHg1MEd2aWRpK0J5bHFEZnZSZUNrQndER0VrbTRJ?=
 =?utf-8?B?VkV2cG1PMk45UWR3WEo3SU9JdzhyVlhkOFlOcnRyZnNGeEx4QXZHV054Rm9H?=
 =?utf-8?B?K1lEeVBlSVZweE9ZU0JsV0lGNGt4RUMwcEtiYXlYc2Vmb1ZMZktFbzJ5RnAr?=
 =?utf-8?Q?2SliGq?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?SXRmbGFzY3BLdjFXNm15dEdFWCs5RSs5T1ljaEZKNVU4cTQ2QVdUUzJyUmFM?=
 =?utf-8?B?dU1KK2MvUWRjd2hVOEd3bURUZWdUUjdLdHUvMkZrK2ZLYTZTS0pvb1ZJdDc0?=
 =?utf-8?B?UjNtVldUTTlaRkJjQXBKS0lHdjdzN2dXaTFYUllVTXpmeGZERVJra0dDa2Yw?=
 =?utf-8?B?eVl0SGhVS1A1Z0tTRzhmbVpsYjJJN0lEUWFMVWZIRkdaUzN1TmlrYlhYQWlv?=
 =?utf-8?B?YW90bk5vMWp3YkphMktnRWtwUStCbzlMUk53dHBPOFVqRzRnaEt2aHFzck9N?=
 =?utf-8?B?REk4dlEyM3R0TkZTVEZxZm9WZ1NNam5sRmo2Mk1yeWRlRmpIdUpRL0FkeUxv?=
 =?utf-8?B?bnJLUndBdGFrWDRTU2JjbU5JVFVXckcwV1ZGUVMvMElINlFnSlJLbXcxS3Y3?=
 =?utf-8?B?aU9YZXgxWDY0eG8wUnhSTlgyR290YXdRMkdoYVpCbllucFNkK3cxWDk2ZHZI?=
 =?utf-8?B?UW40ZVZWMzZkSU14L0RocVROK3V6ckowN1VISjNWWDh3d2tEMDhKeE9KUTNu?=
 =?utf-8?B?KzJ1aHc3TkJsYzhhQTR3WWYwNEZIOHBLOE1ZV05lTFFPWnZzZHB5NEZiSTdN?=
 =?utf-8?B?QWRXOHBBdWIyeHBZeWRsMGlnTXduUEF1MWdvd0k0Um9lY1VpTmtEYnRaekFl?=
 =?utf-8?B?cm43b2VYMEdsMTdzKzlQUURHZUlZbW9SR0oxTTBOK1lBSWN1eURaL2dvdTQw?=
 =?utf-8?B?UTNSU0NBeTV5VGlGVElCSWdSRk92a2VqbmhBUzNjdzZoRDJ6RHVjUkxqUlM1?=
 =?utf-8?B?SUN0bEdSSjBWK3FQeFdRSmRPa3pOYkI1QW13azR0RWh2K1lMNlVQTCt2NzQz?=
 =?utf-8?B?TUlMc2hzR1FCVDdGTUVkOHBLeEJJbWlZTlBXK1k5dGZEU2JQVDdDVjg1Y1dE?=
 =?utf-8?B?UVcvQzVWNzFUc0krN3FoUjF1dDFLRkplaC9CbmE0ZkVjbGZ4MzhsR05UQ09F?=
 =?utf-8?B?bEFXSDBCU0pMUytlNTl3dEpCM3pSMm5VeUo5YjVtRUl5UmV0WldraVp4b0Ez?=
 =?utf-8?B?MG5JbVB1d3Job1lNaW5GQVNsNkZMTFlrTzNlaUZjeE9VTG82TjJ6a0hQRGNC?=
 =?utf-8?B?ZXF4WHllNDNNYy92UUZhTy95dy9YRkl4T25ZendWZ2E5Z0dtWExsTmJIYVNK?=
 =?utf-8?B?QUdweWhjNFFwRFRLcE1wS0c0VlRPQUVneUlibEwzdnlDMlBDWU5IU2xiLzgx?=
 =?utf-8?B?c0pQU0RWbWNqS1l5NDBIYUxxeXF1ZnJycUtZWGNESWhySUYrWFkwYXVwL21B?=
 =?utf-8?B?TlVocnNPSlI3UmdOdm9CZ1NjendKZUxydnBvVDUzcnVRRkF0Sis1QXR6M2Fw?=
 =?utf-8?B?dHBLRmkrUmFwSmVqNnM5blhKbWZDSmlMclpKdmZQN0xBOXBUMzR2YlQwK0s1?=
 =?utf-8?B?akYydkFoYXZNYkhUeU5NUTRmbVpiTkZzandOU3J0ZWJ6RDR1SzhFUzU5bThQ?=
 =?utf-8?B?UWFaekdyWllUT0N5STRhQnBSM2MwRlcybnNJQ205NXFFaDU4cXZsQ0hKSVds?=
 =?utf-8?B?R20yYTZhRWVsUHRoZUFDVDI5ekx0QnMvZGZMR1lPTkJEMjBYNWwyWktEUWVD?=
 =?utf-8?B?dGVPUFZGY29tQ09UZStaK082SGRiQklHUGFMNFlIM0FqbE9ZM3pxOVBYejBn?=
 =?utf-8?B?cll6TzJzd1puaExRMWhMZ3Q4eHVqNTluUW5HdjlmbVJYU2JxcWFaTWRzOFo0?=
 =?utf-8?B?anJPYmd0QmlnTmZVVi9lNWFucUtqdnlkdHlLRVI1SmdaYkJQNTB3cUFocHVE?=
 =?utf-8?B?TFRNWmFoVzRRVzVVL0UzalF2dkpmU09YbWM0ZjZxc3ZFMWM4a0U3c1FsV2po?=
 =?utf-8?B?bndJeTF4aTI0N2pMdkg0eVhJWDRwakJKNDZJMmxyeDRDWldkMDY2T3NmSVpU?=
 =?utf-8?B?MkppQ0tqWVV0WkM1bHU0R1V0YkhMZUdaaG0xaXg4RnRnVDhvMGE3c1BPb0lM?=
 =?utf-8?B?ZllSVFZQZXZmV2Zad3BQL1hibDlOR0Y1S1JqUml3c0JBaVZ1SHpiUjR0VmlS?=
 =?utf-8?B?WW8yYlBGMCtEMUljYUNlelIyaFRoQTQ3SktSZUFhM0RnM1NSVXYzSldKL2Jq?=
 =?utf-8?B?L3haMitTTzByKytBNnp5OWF6NHo5WU85dXZUQTZONGpCYjNzenp1TlAxRE9s?=
 =?utf-8?B?cG9Db3FEQkpqUW83Z1hkTDU1UXVGRHBJODBXUXpoN2tNckoyclVLdWpjU2wv?=
 =?utf-8?B?dUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d09cb53-5706-4abb-b362-08de0571f9b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2025 07:20:21.1811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dT28/w9LIJ/IZNqBsG4xnJbtjr281lLPw16+d6RjHJQix+ZBFuc7fU1G7bACthri7tgn0+rybLc3EJOG5adwLgOmZGn1AezBD6aBnZveo4rp+9zEWo4dQ+jX1W0SGDVV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8538
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 07 Oct 2025 07:20:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20161

SGksDQoNCj4gV2h5IGlzIHRoZXJlIGEgLjIzOSB0YWcgYmV0d2VlbiAuMjQwIHRhZ3M/IElzIHRo
YXQgcmVhbGx5IGludGVuZGVkPw0KDQpUaGUgb3JkZXIgb2YgZ2l0IHRhZ3MgY2hhbmdlcyBiYXNl
ZCBvbiB0aGUgZGF0ZSB0aGV5IHdlcmUgY3JlYXRlZC4NClBsZWFzZSBjaGVjayB0aGUgZGF0ZSBl
YWNoIGdpdCB0YWcgd2FzIGNyZWF0ZWQuDQoNCkJlc3QgcmVnYXJkcywNCiAgTm9idWhpcm8NCg0K
PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBjaXAtZGV2QGxpc3RzLmNpcC1w
cm9qZWN0Lm9yZyA8Y2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc+IE9uDQo+IEJlaGFsZiBP
ZiBGbG9yaWFuIEJlemRla2EgdmlhIGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiBTZW50OiBNb25k
YXksIE9jdG9iZXIgNiwgMjAyNSA5OjIzIFBNDQo+IFRvOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9q
ZWN0Lm9yZw0KPiBDYzogcGF2ZWxAZGVueC5kZTsgSmFuIEtpc3prYSA8amFuLmtpc3prYUBzaWVt
ZW5zLmNvbT47IFF1aXJpbiBHeWxzdG9yZmYNCj4gPHF1aXJpbi5neWxzdG9yZmZAc2llbWVucy5j
b20+DQo+IFN1YmplY3Q6IFtjaXAtZGV2XSBRdWVzdGlvbiBhYm91dCBnaXQgaGlzdG9yeSAtIGxp
bnV4LTUuMTAueS1jaXAtcnQgYnJhbmNoDQo+IA0KPiBIaSBhbGwsDQo+IA0KPiBpbiB0aGUgZ2l0
IGhpc3Rvcnkgb2YgdGhlIGxpbnV4LTUuMTAueS1jaXAtcnQgYnJhbmNoIEkgc2VlDQo+IA0KPiAN
Cj4gSEVBRA0KPiAuLi4NCj4gNTAyYjU0NGMgKCJMaW51eCA1LjEwLjI0MC1ydDEzNCIpDQo+ICAg
ICAgICAgIHRhZ2dlZCBhcyB2NS4xMC4yNDAtcnQxMzQNCj4gDQo+IGZmMDExNmNkICgiTWVyZ2Ug
dGFnICd2NS4xMC4yNDAnIGludG8gdjUuMTAtcnQiKSBkZjYzOWVkZSAoIk1hcmsgdGhpcyBhcw0K
PiA1LjEwLjIzOS1jaXA2Mi1ydDI3IChydDEzMykgcmVsZWFzZS4iKQ0KPiAgICAgICAgICB0YWdn
ZWQgYXMgdjUuMTAuMjM5LWNpcDYyLXJ0MjcNCj4gDQo+IGM5ZWUzNWEzICgiTWVyZ2UgdGFnICd2
NS4xMC4yMzktY2lwNjInIGludG8gbGludXgtNS4xMC55LWNpcC1ydCIpDQo+IDA4MTg4OGQ4ICgi
TWVyZ2UgdGFnICd2NS4xMC4yMzktcnQxMzMnIGludG8gbGludXgtNS4xMC55LWNpcC1ydCIpIGQ1
ZWNhN2ViDQo+ICgiTGludXggNS4xMC4yNDAiKQ0KPiAgICAgICAgICB0YWdnZWQgYXMgdjUuMTAu
MjQwDQo+IC4uLg0KPiANCj4gDQo+IFdoeSBpcyB0aGVyZSBhIC4yMzkgdGFnIGJldHdlZW4gLjI0
MCB0YWdzPyBJcyB0aGF0IHJlYWxseSBpbnRlbmRlZD8NCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4g
Rmxvcmlhbg0KPiANCj4gLS0NCj4gU2llbWVucyBBRywgRm91bmRhdGlvbmFsIFRlY2hub2xvZ2ll
cw0KPiBMaW51eCBFeHBlcnQgQ2VudGVyDQo+IA0KDQo=


