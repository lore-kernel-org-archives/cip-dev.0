Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA2FFD4601
	for <webhook@archiver.kernel.org>; Fri, 27 Feb 2026 06:50:39 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.89592.1772175030367123590
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Feb 2026 22:50:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=stBPKhdC;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.135, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1772175021;x=1773384621;bh=gY5/NvmnrnABK3i8Lp/bIaKOWN0z700zqswqQ
	rAmAeM=;b=stBPKhdCX4qtk/GDLcwEm4T9jUXS6LPV2MNgAYcMdIRVm9GpmBNQLJosZMb7fEm5jPm
	wgM0ndvWL/GpRQqQXDh3qcUJsATAIwZ5YBtAR2Yo85zoJdE5DZsf/TrkpIc6AcgLILDgiJM3HAII5
	xX4PVrF1gZCFOuKQ34j2I1DcfyJHg9euN4dcIO8yUV9MyMXY2AMb1RS0IQWLEV5b3roKT2b+k8DQh
	vOj/cahkklPtcL5GHHK/VJ5XoUcO3i3piRWCIG09impB0s3DWub8zvIC19Nnii8DAANS6C2FgGwTO
	U503R4lJ8Uz2/80mrQ/QXtMZagrRQ/gdlfM7HCfH7gjw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 61R6oKeC4129152; Fri, 27 Feb 2026 15:50:20 +0900
X-Iguazu-Qid: 2yAbS7rJmFAFrliD0Z
X-Iguazu-QSIG: v=2; s=0; t=1772175020; q=2yAbS7rJmFAFrliD0Z; m=fzrnB00iEvb2YzTY+Cd3DowqECKBP1WRuNPGhdVC9iM=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4fMf8r0rNGzyPZ; Fri, 27 Feb 2026 15:50:19 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wAqhvbEFBuMcVqThBIX/frxlzct0xxb/mubBkaiHlk6bHFpgmKTO9fxz5kDQsYeh6I4iOBALNW2fyG10/rBKucp+hdZVHG/T03hfHg+hMcY9jzTU8CZTfSO9fDE7WgNtKHEYFB7muHcWz7aOwRoZvFKHPFmWR7J1znRzvI0eaHmg3m84CxSNRMVMg8vpkouPdk5oNXBG6mqHabO8jUOhK2oE/WbD0nwE6Fe4N7stUotjlCR/9708dIGweDjk4yzmwP7ewcwJbM45BXYHMKpsupmUWibTsTzw9QNTBGEglI86JfSPhw/YUTME/op4lq47M+sREfCdPYPWQGMKzZEz1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gY5/NvmnrnABK3i8Lp/bIaKOWN0z700zqswqQrAmAeM=;
 b=bYRgjKYh9M7c/XXQ5gODKcn5NgD7gDcPzYmCOmjkQB46WMTQF9L782Xz84TKQUjTkTuqAkDEa3AMZ21rULEhelxFgJpNn58V108paomBV/cTqhCBxIcK8tn8Ij++Hh7UVAe2PRC1ugyCth0EkGLpe1OO/89J8p1JuVIN/loWuj72PzMtZUF9ldxEL84JZ6fka7HUsvyJhZgVsBHOa6QycZUnvLUTaKED2tPnLJ49l1bzzrU12j6C2KNB6L6rMMDdV0I8oRvtjkCuT6jnpjN7Ybq8bAx+Yx0sRvWstVdJQw5rva/rF7kNtkl0lXSVelk9UjckEcFtoS0h7mKAaD8wqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <uli@fpond.eu>, <cip-dev@lists.cip-project.org>, <pavel@nabladev.com>
Subject: RE: Request for review for 4.4-st73, 4.4-cip108
Thread-Topic: Request for review for 4.4-st73, 4.4-cip108
Thread-Index: AQHcphg/pk5OuNPPakOkHMxwpW0XArWWHf5Q
Date: Fri, 27 Feb 2026 06:50:16 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818DD597D56F7A2D852F929CD73A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <440487134.6462.1771997574376@webmail.strato.de>
In-Reply-To: <440487134.6462.1771997574376@webmail.strato.de>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYCPR01MB10525:EE_
x-ms-office365-filtering-correlation-id: ab3485bb-07e0-44d3-8d6e-08de75cc7757
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|14052099004|38070700021;
x-microsoft-antispam-message-info: 
 QrxI3QmOVEgamP0tUSqbeiIy9Kq/9XHGFCGQTWI3CD5oWPDrcNzUvTFHoZ6IVjV0qShujovxr9/g6TONr6p5UNm6pVkAD+a0ab2Bq5NYvZmp2/nwJ/b8kmelAI+6RAQcoCTT2jjUcneNbZTHyvBgnLipyJ32lM5LkOH4gDVz1ovYbVwonxRTAujdhyj9tHufaa5OetcqHH2q0GZcwNNDTFhXtEG6O2Sy7Ch1YC+m9nNUak+sF6xc0/eOJZgntLWGVj14BM4zXN71kJiV5AjRgJL+H8N2J5yVAYsAeHanCwaJQYMk7EhViNqb5JRoyhE/uMH5RirT1qS4sNo5ZVo4TFSGl8O31wd23xRI0SNZa7++TDcZkCs+lLJXwmzpvQ4JIcp8sBi87xF+LbO7ZvGTJF8vRzmz3dRt8rynoKZ51KdSYNwCSJN25jdRCO7b4e3HmnBSvZcU9eUXSZWLBzSHiQ8WD0f2HMTqWxpsTBYnNTtqaACWZryb8UWa/1W2m8XOZcSD0kGcYhM0xvxUI4BWXQGixI8Ns/1Ied4ouBCIxK3nndBv/BS1EZx2yQBr0yZrn3nCCJgTIbO87EJqr7T1easfEW9/bKdREZoLIUwYY4GBdDjgXX4z2rCgsYMEx06HT1SHszbZi4w8G178VAyfrdf3FSD/E7NPSfnmX+wJGhN/u4JDfi29fVEDC8thpD4t5EhyLECQigH5Z0TTo+sL+Zcu0OwE0cubyH5EvyCWFjChOx8q9RSto7FgNczkVqxoYOUW1hBKrJDvO31N1ZG6TBQMD9DkA0gGbfPVt8X0R/Q=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(14052099004)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?aFF3TlhFOGlOZzNjMitFd08zMndsUm95UlRwNVBjMDdYMTZLSW95c1lzU2NU?=
 =?utf-8?B?VG12OFl3SmFlSXJITGJCMmtYSjA5NTJrclQwbWFJb3JJTS91LzNHOWdpQWY2?=
 =?utf-8?B?QWhCZTB4dkpZdWtqQUdsWVdLempiOHVZU3p2NnJya1B0b0dVc1B3YmRYZGVq?=
 =?utf-8?B?Y1pic05JajZPV05kYUdLRlMrWE8vc0VsNk5IWGIremM2QlNoRm4vcGFUS1VW?=
 =?utf-8?B?TGNtdnZ5eGU3alg0WVpyamRRcjRGNVZ2amp2alRGRkF1MXYweVh3UUNHSHN6?=
 =?utf-8?B?K0VveTA5WHNIL2JMRTJQY3dQVndmR2MvU09qNmpLS1MwU0tGOWZMR0pMNUFP?=
 =?utf-8?B?NHVvNFJIMi9qQlcyS0FLVHlTVGhyVEk3TUpCcGFod1M0VElEYWowOFhabDBt?=
 =?utf-8?B?ZktiTVVldzZEbmVUU29uT0pna1NOdUxEY2JreXhrYWlqQ05CcmZaUmRYdFV5?=
 =?utf-8?B?RWZySnladXBLOHhSazdXajV6dHFHdjl3T1B2Z1JJcmpZZVBOM1RSVmlCcmtW?=
 =?utf-8?B?eElIdTRyVXVBbGlXblUyVXFyaEpzc2J1akdJbHFleVNTcDIweWpQeExUQWl0?=
 =?utf-8?B?M0p3M2w4M1RmZWxGVHd6b2sreGQ1aEZBd25xK2V0d0FNSWpZOEFTNkNJK0xw?=
 =?utf-8?B?WDVVY0s5ZmJXUk8raytvUXdOZFBvZmNGUEc5M3g5SkkvbDNmM2IwdWhZU3Bu?=
 =?utf-8?B?S25qQWFKcnVPV2NBb3k4YmdvMUZXZlZLNkJINWdoZ0NlU2laa2tsZUxTVVhp?=
 =?utf-8?B?a0NxRU5Tcm9iazk4MHYxNkpYSVpMWk53c1duSVdjaUpjV0ppS0lxcW00UGNv?=
 =?utf-8?B?ZWdaNzNpRU9yMnVtdHlFMzVhNFc0dkZFSWJ4QTdhZ1FnUWxVVXZFWVU2eVR4?=
 =?utf-8?B?eDJWNUtiMVZGRUJjQlRobUcwRkxmamd1SUdMQUJDam5OMXJHNHppT2xJdlZL?=
 =?utf-8?B?dDBCVHpxQjNnZVFxalVqZzQ1aDhPQmNkNXRya1hSUkw0YjJURWVlaTlmK3cv?=
 =?utf-8?B?RXd2eFVWME1CdEFnVHJPMnd4b3BIU2FkaktDanVIekhKNlg1QzRwalI4OU9I?=
 =?utf-8?B?dks4WlhYYlNLQUZWTFZTWlJ6dWc0MHdrTmtNK2s0ek8xdHQyeXlDYVo5Rzl1?=
 =?utf-8?B?MWxzOHhucjNubDBuSm9xR0xYOFp1WHo4aHl6THdCMktlMHhRSVd1UDl4U3Mz?=
 =?utf-8?B?SzF3T1FpaUY5cXlJM3JIUmMyQkkzUUdIUU10ZUFzWU1jbnhwanJTZlVqcDI2?=
 =?utf-8?B?UUR2bGZXN29Nb2Z5N2hMZTRiRkhSS2VnZzZvQkJZZndRWmZORHFlbk9SRW02?=
 =?utf-8?B?dkhGUnFYZ2Z5WXh1ek9veTAvRTZmMTNJMnFYdnFEUHRwWlFFUkZaMzBySlAx?=
 =?utf-8?B?U2dYeXZySDBNNE9pRGFEZmlaZGJ2Q1hYUmhXQ2U2VjBGb3g0WlIzdVk4aVgx?=
 =?utf-8?B?V1ZReWJIQXpaT25tVUJBenBCTER3dnFId0l2MjZXNVBlNFVYTGM5ZDY2ODBV?=
 =?utf-8?B?UUxmbjNzN1NJYzFtT2wxVkZzbTRaM2Q2d2l6QmJGS3hyNVIzd3JtUGtqNlFN?=
 =?utf-8?B?RDIweiszcWJNcFBweW5tajZtZGJUM3VQQ0FpaGZXOXZXWldoVEVIK0RXcFd5?=
 =?utf-8?B?RWx4MThSMzVkVTNiNE0vQU82TEd0NXh5WWtQRmtsZDFvTmhGamVUMmE1ZkFZ?=
 =?utf-8?B?M1B1MWgza3RiQUI1ME5sNjFCZmhKcTdGRVBPK3NtODBES1ppMUcyOEhBeGFy?=
 =?utf-8?B?YlRPODhhb0ZrK1paQWt5L2doWk1EVlpycHdQbTVHb1dtdktURTc0NFhiV1JJ?=
 =?utf-8?B?WWNVNnJWN2ZjcmpQWjJZaEUvdTFLcDlDb1lpb1NTcWNNSGkrS2FIMFh1MmQz?=
 =?utf-8?B?NHhLN3MzL2EvMDBuTWtGNG9FcVJuNnRYbGZLL25XVU1SQVpFWE1Sc1lJWlJG?=
 =?utf-8?B?UERkYysrRWpaK1R4ZWNVQ0N0NkhKQjFkdEJNOU5KQ08wdTl6M3Y0QWZFMEda?=
 =?utf-8?B?RkZEWXdqZDJVazgyTU1lU056R3ZsUC9OeU0xRHIvYUorY3ZkcWFkWmtiRkZD?=
 =?utf-8?B?aC9USkY0MSt1ckxHN2d6aW5VMlZyN2pscDdORWJIa3NWeHJXSEpmM2FyUjFX?=
 =?utf-8?B?OXRkSnlRVG9ubXhCZjBHYnZON0xCV214N1FKNGJXdWtENFBXK0krM0hTMEta?=
 =?utf-8?B?WjJCNTJxOFBDeG9lWVJtSDBQTERJVlQzSHB3MnlGZlB0YVh0WFM3NTBqSWha?=
 =?utf-8?B?cGpoK3JsUk5yb2RZTGx3SUdLZmRxTStWa2l2NkM4YXgrMmVFQ1Z1Sys3eWR3?=
 =?utf-8?B?bkx4NkI5Y3VOeHFuak5qWXFxZ0JiMnRyRDdSMlhCaTlIakllUy9EWEtPbHQ5?=
 =?utf-8?Q?Ntz5/auSKHv07W1U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab3485bb-07e0-44d3-8d6e-08de75cc7757
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 06:50:16.9159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: haBuR5AtjGSxww6mrWLFlmyx4ptkMO+vYOKd1mAqnbdJuQBd6D1CUaF6CN+FeR9LNf6/hTRTBc32sHoG47w4WBMTlN01mYrg41MVMcOEAk8TC7GDotNn/XBSZ2I9XkJz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10525
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 27 Feb 2026 06:50:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22021

SGkgVWxpLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFVscmljaCBI
ZWNodCA8dWxpQGZwb25kLmV1Pg0KPiBTZW50OiBXZWRuZXNkYXksIEZlYnJ1YXJ5IDI1LCAyMDI2
IDI6MzMgUE0NCj4gVG86IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnOyBwYXZlbEBuYWJs
YWRldi5jb207IGl3YW1hdHN1IG5vYnVoaXJvKOWyqeadviDkv6HmtIsg4pah77yk77yp77y077yj
4peL77yj77yw77y0KQ0KPiA8bm9idWhpcm8uaXdhbWF0c3UueDkwQG1haWwudG9zaGliYT4NCj4g
U3ViamVjdDogUmVxdWVzdCBmb3IgcmV2aWV3IGZvciA0LjQtc3Q3MywgNC40LWNpcDEwOA0KPiAN
Cj4gSGkhDQo+IA0KPiBIZXJlIGFyZSB0aGUgbWFudWFsIGJhY2twb3J0cyBmb3IgdGhlIHVwY29t
aW5nIDQuNCBrZXJuZWwgcmVsZWFzZS4gQXMgYWx3YXlzIHRoZXkgY2FuIGJlIGZvdW5kIGluDQo+
IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2NpcC9saW51
eC1jaXAuZ2l0L2xvZy8/aD1saW51eC00LjQueS1zdC1yYw0KPiANCj4gZGQyYWYxZmYxNWJhYSBt
YWN2bGFuOiBmaXggcG9zc2libGUgVUFGIGluIG1hY3ZsYW5fZm9yd2FyZF9zb3VyY2UoKQ0KPiA2
ZTdmOTY4NWI5ZDM1IHdpZmk6IHdsY29yZTogZW5zdXJlIHNrYiBoZWFkcm9vbSBiZWZvcmUgc2ti
X3B1c2gNCj4gMWI4NDcwMDZlNzE0MSBzY3RwOiBtb3ZlIFNDVFBfQ01EX0FTU09DX1NIS0VZIHJp
Z2h0IGFmdGVyIFNDVFBfQ01EX1BFRVJfSU5JVA0KPiBiZjNjNjUwZGZkZGYzIGJ0cmZzOiBmaXgg
ZGVhZGxvY2sgaW4gd2FpdF9jdXJyZW50X3RyYW5zKCkgZHVlIHRvIGlnbm9yZWQgdHJhbnNhY3Rp
b24gdHlwZSA5ZGJjMjUzMDliZTFjIG5ldC9zY2hlZDoNCj4gc2NoX3FmcTogZG8gbm90IGZyZWUg
ZXhpc3RpbmcgY2xhc3MgaW4gcWZxX2NoYW5nZV9jbGFzcygpDQo+IA0KPiBQbHVzIG9uZSBmaXgg
Zm9yIG15IGNvbnZlbmllbmNlOg0KPiANCj4gZTBlODljZmNmMDhkZiBhcm02NDogcmVwbGFjZSBT
dW4vU29sYXJpcyBzdHlsZSBmbGFnIG9uIHNlY3Rpb24gZGlyZWN0aXZlDQo+IA0KPiBUaGFua3Mg
Zm9yIGhhdmluZyBhIGxvb2shDQo+IA0KDQpUaGFua3MgZm9yIHVwZGF0ZSA0LjQueSB0cmVlLg0K
SSByZXZpZXdlZCB0aGlzLCBsb29rcyBnb29kIHRvIG1lLg0KDQpSZXZpZXdlZC1ieTogTm9idWhp
cm8gSXdhbWF0c3UgPG5vYnVoaXJvLml3YW1hdHN1Lng5MEBtYWlsLnRvc2hpYmE+DQoNCj4gQ1UN
Cj4gVWxpDQoNCkJlc3QgcmVnYXJkcywNCiAgTm9idWhpcm8NCg==


