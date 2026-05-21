Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE22CD5BAB
	for <webhook@archiver.kernel.org>; Thu, 21 May 2026 23:46:50 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6903.1779407201422078604
 for <cip-dev@lists.cip-project.org>;
 Thu, 21 May 2026 16:46:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=udKoSYIr;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.152, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1779407197;x=1780616797;bh=3oqu55Pyo4FTkbitBGaC9gLX8Z339GwZDQ0T3
	Fcl7YY=;b=udKoSYIrX62HjbT6F1ITe4ZKl/0qEzEHJojN5RclyMQHFu7drJ2dWdR6kzQYjpISayt
	P4iAqM9n8Z8zIAMNISmFO6FjrU8oIAkRQK1J0zWziWoTMEVTmtv5TUmtLbLYwLF2M3nzYv9jpFMEV
	3/k13HU3d976tL6I55Zb2/R0PVWkBLgzmVwMQXdZYY4dANSeOvebztDj1mx/sNb/TuOb+W9HyhQVX
	RK9/xh/Ic5rbz8zQgfi/5oHadeH/1WLg5ZgoVgUS8R+ybR0cQXMoto3nTFnjP1qQkmwM7VaEaMo/z
	yfAER+WeDOuxc2BIXFE1DCqB9YyEC1LALY6o3TO1SAmQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 64LNka5S3636821; Fri, 22 May 2026 08:46:36 +0900
X-Iguazu-Qid: 2yAa6mpCiub1oDNTWv
X-Iguazu-QSIG: v=2; s=0; t=1779407196; q=2yAa6mpCiub1oDNTWv; m=Kv7BMyqjEinLVYrLnzNKhVkkGGyYXKwSwmmidUhG6yQ=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4gM4n76CXmzyPZ; Fri, 22 May 2026 08:46:35 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m9uE6p3M3PXV9O6+GO41L6gJSZEX5DHNeTJNkdov5CxsRPciawYeYf49h/Cr6rFUo+pmsnbRNPs///pYtllj+KfmsnCtxrMKKsfGoBExUZmy+tGbOkJ1c1AIIOt/Xp9JhS4sAhxMFuQBv3XcMFglARm20HeOXIHfheY/BRVMJO8j49tUfAS8csNH0cwzPWg4IBMEnfW+evRHh199tSrEx2j1b3yTl2JzSlMwdk52MG3vfXtEzzCOYSXn2Q5Xb14MUZZvJ1V3a7VJve5qywpWvtSEmpbIwUok4gEqPmVHChV4dC6WxCHYgFZB2N+FKEI0K/Qqd/gPPBJA61uA4/NukQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sCsi1FhGSud7T8eLMCvXI4YvaarQ1KeKKSShNRPSi7w=;
 b=kY8RipqYzBiFZqWLBnQCtAf9zQh3xDVdLalvNHYst4JG/Ptmfx+o+4FjHA/OKUr4l+VDIGvSMJsKEGnFt1gwW4ivOktfTRiwggxeOH/nl6Qr8sjedhWaekGscj0KGywOkYPDWcThuYCC+pMqEieTqukHtk+5PmLsRNEFXSYy69qZojjrcQdLeexoRKj7jXcSWw4KIuuY0ChlV14gDvD0bZGvPHR5WFTfDE7frKtujt6KQd6miDdQTTTp1UZzSGxenuAVjaaTPhruyODxSnoipbxFf7kyWobqZDveCNDWsZCpNIN89N3RXglNC4/efmBXTnEv3C/W7pjs53Jd5uKJdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <john.madieu.xa@bp.renesas.com>
CC: <cip-dev@lists.cip-project.org>, <biju.das.jz@bp.renesas.com>,
        <claudiu.beznea@tuxon.dev>, <john.madieu@gmail.com>
Subject: RE: [cip-dev] [PATCH 6.12.y-cip 00/17] PCI: renesas: Add RZ/G3E PCIe
 controller support
Thread-Topic: [cip-dev] [PATCH 6.12.y-cip 00/17] PCI: renesas: Add RZ/G3E PCIe
 controller support
Thread-Index: AQHc44WyQJomp+HXmEqKuSfL2E+kB7YYVZOAgADbQ3A=
Date: Thu, 21 May 2026 23:46:33 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818E0D10F2C8F90938AA105CD0E2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260514093935.2212718-1-john.madieu.xa@bp.renesas.com>
 <ag7hO3Li6M_jYCjK@duo.ucw.cz>
In-Reply-To: <ag7hO3Li6M_jYCjK@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TY3PR01MB10172:EE_
x-ms-office365-filtering-correlation-id: d3e0ffdc-7336-47dc-9c8f-08deb793307a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|11063799006|4143699003|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: 
 iGpsAi/kZHI3GC1Pyl1GMz6HxOdlxZwPsXn5rjYXRUhvHvzZhoxqlo+1VsMoko1iEqrDCbCydfEoZVspL5Rc6DbmB1ZFH5xh0ZvvYU6oqna6ebTae4pH7hial7/K+i/idkMor9fpdffvUj33vVOEB1Ks+LL3MDPu7h4Enme56mTN/YXX9Gu5+oYHcnlGBYQaFoRRCXfsy1bByvS9L14nIC2v77y2sPlF03cRinJCmCh7jjfSLI2RZjb7ov8E2zQePI5zjxPRgfOIHEn0HB6wsn24HEqFLFuX8RWDNZlqD+weoem9s/JZMp9DJ+QhSETPHbogNox4wHSg6e5LAWOTU5kFNZ1raVDDPBqaHsCDo0reYA4JrhTk5zr7es8EXu3M6QdKeZngTBiVOJanyDBxZR/6CB11gs1+nP8BtjAjEZDdlqUCQmdlcx72GGvUQraikkAgFOrqWxxv3nxjB9ofwOPvnHJpKmO5OkUwKKivexXVodi3tFCqUISA+RMEeEj4JNyZPPgvaWMYx6xIyzAyre+X/HaFn1fqsQjVaZxYI8hK+9lIR8KhRXjGDogTknTB1QNg+Qfg2F0BxrUCigmzdRLtGOhRMHdqCQ1KHFs6gSaqMcqCRmmxHoXxbWW1OIJLQtZ9bfZuFub4gX40M/4Xo8qcpE76hTeEbfEl+Ba9JrAskGjZPj4F0GPNevHl4BaBRlB5sv7oPSC7OnkZ1EoniTiDJqDRLwWqopbZwVJkvgq1IdTvbNjKVw+46wM6DW9t
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(11063799006)(4143699003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?Y01IbDEyaDl0dmt6QWRCenN6REVZdUg3MG42Uy9NeG9oWTBxQzhBRDlF?=
 =?iso-2022-jp?B?azQ4VjAzTHF4dHlINVdxRy9qVnQ1NjVmUDBTdFNKbStvbFhGZSt1UzNO?=
 =?iso-2022-jp?B?bzJnM214S0lkZlYrTDd4QkN2MWJUbVU5aDcrblJLanhCYUJPVHRQMjJU?=
 =?iso-2022-jp?B?T3ZENHVpZERTWThQa28xTEdGUkdGdElPSFhGdjlUR2xVQmlybFRmYkk4?=
 =?iso-2022-jp?B?cGdiRHJ6YVk1eXNVRU56NzhHc25ySElNT3ZaVS90RkNhTi9qWXpoVmUx?=
 =?iso-2022-jp?B?YmVyd09HNGQ0MnZHcGVvc2lMUGRrMklNVmhydlZmVWFmWXFuVkZ5Zk1X?=
 =?iso-2022-jp?B?NHAvcTgwRlFjRTRneEZTUWJTZUxnUnBpbDl4K1JvR1ozSE9ZVHRtM1RB?=
 =?iso-2022-jp?B?aE1uOVVCSEpzTkx1cFhpSEVtUXMxb1lONUdpeFR0TW5ibjl0b3dXU3E2?=
 =?iso-2022-jp?B?eUR1YlBlOG5sYzVSSHRLYnZXblBoQmFwQ1pUbDFReWxlVUtoRG5sU3BD?=
 =?iso-2022-jp?B?azUvNkNlUVh6N1hKNDN6Z0lxaHBhOU1ibHBnUjNtU2VDSEVodzdpZGZ1?=
 =?iso-2022-jp?B?WDFEWU12TGRNMEthTFRmdFZ1RlQxTnMrMDB2U25aVlBqaWJrdG1NbXZr?=
 =?iso-2022-jp?B?dWpNOWNzelFMdzZZTDNDdWZOZU9XSGFLVU9FeHMrNlhYMWtEVEs4TGxo?=
 =?iso-2022-jp?B?bXV0OS9WNVJiSnNOdzNpejFoQmg0ZXJYL2Q2Z2pUeEUzZUhlNXBPWlVD?=
 =?iso-2022-jp?B?VXZiWTRrNzRJVDhXaElSandTaFcremt3aDV6Y0pIUjlNeVVUS3A5SHhn?=
 =?iso-2022-jp?B?ODZyL2o3bEphc0xGeHp2ZGthdTFNN2JJalM1Z2VjZGVPOFB5cUNvdVlj?=
 =?iso-2022-jp?B?VS9VQytxNDl2Tkh0eGRaQ3ZlUDluc2RoVFQrYmI5U2lkTHJWNllrancv?=
 =?iso-2022-jp?B?cmwvdVNBUHhUK2tocUtiQnQ2WW1QQmJuY1hLUVh6OXNJdi9ENGFURzdt?=
 =?iso-2022-jp?B?TzBRL2hSSGN4K2NpcENreTBkNFBka3NmaGRxdHN1ZnZ1cjd6SzBPeHpn?=
 =?iso-2022-jp?B?MnZSeEFnOGtvVUpQdi9pSzFzL1VxMUJyZ1ArQVhCaUpPeXRwaHRhemMy?=
 =?iso-2022-jp?B?dUlYZkdVKzdxN3VadThOT0pGdkNTdHpPZkFFSmoxWlIrdXJTSERGR3Uw?=
 =?iso-2022-jp?B?Sm9odXRKVUNZMmxMUDh1NFlDR3h2TzdLcTVLbEtiVVhNaG0zVzF3MVo0?=
 =?iso-2022-jp?B?c1pLeExWT0dVbDFQM2FQdFdFaDVxNytlSVhudVgyY2tKR0xiOGlYOFdt?=
 =?iso-2022-jp?B?VkJ3cHhUdGprOXdPekhHRlVQb01rUEZWTk9Fb25Bb0xILy80RkRaMnR4?=
 =?iso-2022-jp?B?K01ENlFhL3A5eVZSa01oSTZaeC9sWXZ6WUJ6QWtZQURVY0x1MndMdGFN?=
 =?iso-2022-jp?B?a1ZZUTlYdkZLdkRFcHF2R2pScllOazR6UGo0cFduWC9BTjJIeXNXQTdB?=
 =?iso-2022-jp?B?MXpCME5yN09rMGhJVG9iMk9LY25xZVlXMXIyM0J0ZUYzUTYwV05rMko5?=
 =?iso-2022-jp?B?aHF0SGtSQzJmZmhjUlBENGFieE9EY2NQOEpwWXltQ3RxSGo5UHFlUDBP?=
 =?iso-2022-jp?B?SDl2VGVDUmNjNjA0Sm9SR0FLS25vVGJEYm5WSGNiSWhHT0cyRnpCSHRK?=
 =?iso-2022-jp?B?WDZ5NXpydWxSZVJGbXhIeW5FL0VtS3NNUndhODQ0eGFUdWJDbWNrU0ND?=
 =?iso-2022-jp?B?WFptOUNBbngzNmFObjg3SmJnb00vNjlEOTBpNHZhemlBa3JiT3JYbFcx?=
 =?iso-2022-jp?B?dzBjQTVGNHhqSzhXRDRjZXNndlV1U2VSNnhsa0VQWEc2RUF0bTkzdDh6?=
 =?iso-2022-jp?B?b3lJNFZsZ0p0OS82ZmhlN0xwTHNGQmN3VU9vRG5qNWQyTG90cVRWUVVO?=
 =?iso-2022-jp?B?TTRPNFVTdVIzL1NaVDVQMjJmSE42a0VmcUI2c2wxd2thTWkxeUZhZ3ln?=
 =?iso-2022-jp?B?TXhoYWNBb2NWSUdWc0JQRW1JakRrZUE5eWYrZ2c3WDZ2UTN4MUk4S3FZ?=
 =?iso-2022-jp?B?akUrcGRzRSt5V05RaE9NZFNoQjZtKzVTbXpiajlXS1JJOUJPUUVyaUo4?=
 =?iso-2022-jp?B?RFB2aWI4aDFCV2NDU0dqa1p0YnNNd3FMUU5ZMzRDTDVXWVpldk1NMlla?=
 =?iso-2022-jp?B?MVU3VSswa3RRSEJOZ0FuZXo2OXhmQWJwbGljMlpJSzJHMDMrUnRXcjVy?=
 =?iso-2022-jp?B?OUd2VW16UDVYK3B5dnI5ZUxGeTdkMmRVQzEybDd0Mld1cHlWakJYeTRu?=
 =?iso-2022-jp?B?RWI4WnI5ZjVDRXBGQytXYVJIcTQweFRCKzJOWi9uR0d6d2dwT3dBYk85?=
 =?iso-2022-jp?B?eDB6T1hDK09nanNocUlSZU5veVJjaDNqUDdobzVHY0lsRmg2eGVOQ3oz?=
 =?iso-2022-jp?B?UUJLY25DV1NxeS9GVk5WUStCUjBFdC9abXFySXVPVC90bTlQWCtXWXdL?=
 =?iso-2022-jp?B?Y1FtWTBSN3luenNsWHZOVlFaRFpnQUdTcktDME04RjdESUczODFQSG1Y?=
 =?iso-2022-jp?B?TDRiYmoxZz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	fdp8mTWKahFGtDVK62zzoTTrcNCekvDdC31TU6Gh20R7j/+bcYjXrOCVLFWY551vuYF/+q9qjt/3gdfIULGYaC3VyXo73756W4zTRf2e/PFgETGAEdnf1g9tI2O73vXluD5aeysWR4HJi29dWaSbkzpSLRi88YRzcFrfaOdVwC/E1Ey77KLHFKCg6//UrGEyNxVSsLoZkTVVmby3zr7nM42u5+9lx1rajOf7cu2U8o1UZjNhPMeBXZljQA6lmlGIz5fH6I7AvtNEm6y4bgNUIyUNC+PhHd0XapWSBW+TG6/3mIj6TWYvRiRPbyKJB0VVbh8Yh7zsYmTPR/2lcgFkjQ==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3e0ffdc-7336-47dc-9c8f-08deb793307a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2026 23:46:33.3989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +uyoZL9uZjaASGXWRwqu6yaLh3UYLSnFsEx7l3zorYanOgMchk8bSDHMAA0fP4Wn1huGHQ3LEC7WfZMemvBM+M1GWs5FtlcPq29DoA+ppNiPi6fJ0AtDzxW2jhWMphS6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10172
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 May 2026 23:46:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22995

Hi all,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Pavel Machek via lists.cip-project.org
> Sent: Thursday, May 21, 2026 7:41 PM
> To: John Madieu <john.madieu.xa@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel Machek <pavel@nabladev.com>; =
Biju Das
> <biju.das.jz@bp.renesas.com>; Claudiu Beznea <claudiu.beznea@tuxon.dev>; =
john.madieu@gmail.com
> Subject: Re: [cip-dev] [PATCH 6.12.y-cip 00/17] PCI: renesas: Add RZ/G3E =
PCIe controller support
>=20
> Hi!
>=20
> > The Renesas RZ/G3E SoC features a PCIe controller that shares
> > similarities with the existing RZ/G3S PCIe controller, but with
> > several key differences. This series adds support for the RZ/G3E PCIe
> > controller by extending the existing RZ/G3S driver and device tree bind=
ings.
>=20
> Despite minor comments, this looks okay to me.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>

Thank you. I applied and pushed with your Reviewed-by tag.

>=20
> Best regards,
>                                                                 Pavel

Best regards,
  Nobuhiro


