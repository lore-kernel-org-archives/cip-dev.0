Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD6ACD98C6
	for <webhook@archiver.kernel.org>; Thu, 11 Jun 2026 01:42:17 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.36280.1781142126586962032
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 Jun 2026 18:42:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=CogfKWxD;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.131, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1781142115;x=1782351715;bh=0OQeTBFcpZDc7YGG4Veg44jiV8GE4Y5WrIqLT
	+T49dc=;b=CogfKWxDjEDZ+eXGmH1cy+AEEDqFDxCcSKKdUGmAXo+ss64sOtArS6ZWp13fkr6ivL2
	y014PE0PF/jtKcmPiwmzthUjL4KQVyh1sD+zIz1ppZ5uZeD8bCQnGwKEROuhN2IBmhKBJel6Q0Mwz
	xoqKUwA2Rymer7OOBtZDBHS8tW9kBWW7awUbZyZtJ1pAGUQ/fGBupN0qghPPq2+Q7AUMmXVFO8n9N
	feAT6fMkJBQh+jSgitZ8Izh/rNSdUI41hVIsqcG9f/tB/yRnTHUt6aiFbwQvJbLZdUpI31wF0FZlx
	9/b3T8WbW1fF3DF/UqndLKbNA9DdaUaXJ9o8zx322GfA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 65B1fsZx3788817; Thu, 11 Jun 2026 10:41:54 +0900
X-Iguazu-Qid: 2rWhVaVmIeYZhBBlhg
X-Iguazu-QSIG: v=2; s=0; t=1781142113; q=2rWhVaVmIeYZhBBlhg; m=0yL/x+mxOx/0ZhbfOb50S8Oo8zJIWpYAg7hY5mYQlds=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4gbQNw5QjJz4vym; Thu, 11 Jun 2026 10:41:52 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lNmhfme1RnX7ePxGJYXarpSKRiVRXsuu0w7N8y3WDMc6ZcXkT1EgLhWcZVTqWqjY7PbUxCYeiEppWcTDX/4ehdqCj4uY9FOkW+j6Xpt+IhYJbaW0EYgDCH8k4EXXKLQiU/fXIRYu2cOFpNIVG62pPlvWudgkYH8lDSgLiG0jKLhn9TAMw/Ji9MS21rfi5HaIE9tpNIRHOY4GHQ79Dz1JXOSwn71BWGOnzC1bTmVWO0tis42l9FoQMQOaRKLWSkN8MkdsGZFTlazQK5SAw5TaBWCzSlXsYYtdacfrw39lcTySiwTTZgc5Cvt4hEGAATkAQPW+LCD003zrhn1oTajXzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0OQeTBFcpZDc7YGG4Veg44jiV8GE4Y5WrIqLT+T49dc=;
 b=TXxcBcQMPoyZOvw0ZbCjn1jUCiue8tlYxGL/JXpl0DQHck0fqE6CSOJpEMMoARiGM+lHUXzna75kia6p1R/qb99UD0Pxj6qQO5HU7vltiA5B76qXgCIC9PN09Um736lLqkrNA3zNERd/Q7FUngaNnidb978LZiM2H7MQNYsQi6eijSOUeW0JxMpuAtCsrwLkx+fZg1KEK557RLivyrJQKfBI9Ch+MfkZeI5KunpOiWjNNJU4emamxWvaluFfVVDOsRnn9Zp/jEvyTUyzZQ7YicZrgQk7hbFmEi/TAc8PZKVwPsDAaA5pgt/ePbKybH9R4qHviTtskRhZBHbuVy1PBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <uli@fpond.eu>, <cip-dev@lists.cip-project.org>, <pavel@nabladev.com>
Subject: RE: Request for review for 4.4-st77, 4.4-cip112
Thread-Topic: Request for review for 4.4-st77, 4.4-cip112
Thread-Index: AQHc91q7YEOVT1hfyE+0O3kMs/KXm7Y4lvxw
Date: Thu, 11 Jun 2026 01:41:49 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148185F38028777C951415B32CD1B2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <1985872946.840508.1780932177008@webmail.strato.de>
In-Reply-To: <1985872946.840508.1780932177008@webmail.strato.de>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYWPR01MB9524:EE_
x-ms-office365-filtering-correlation-id: 36cb7e4a-80df-4ad4-d5e8-08dec75a9ad0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|18002099003|22082099003|38070700021|6133799003|11063799006|56012099006;
x-microsoft-antispam-message-info: 
 AJYsKnTOjcLmFsHnWnybrAHq5a1YTGjGVw1JNRtOPkuyOnxOPiIEYdKl9R//+8c10OjMojpi85Qx6CTsoewIbVn7d5+YB+OM48XMDiuOmAhiDg64Yazl8VqdxePmGRO8fKhM940uKaSQMS1qoZS7GpqZij6OIXOvhh+0G9lY9dplYYgC3Wv4YQob8v0YQYlBUlZfA2C5A7lMFeBbugW8MM7WAZC2NStCIFB6ygqRuhRuXhhMm6/2M0sOS+hQd5WPa+W+93F/lkTU719ekeHVxPX2F7FXqxgsoPSa8IFfKSDAD3+G0AtVTL6AnNdcB4FfXdOef/hbcWKKWzff9496tC6NqdpDVp8bTbwdgNfDS/jzRKZ7EY3jWQUD/IOTdz5jwd9Ou1ZKYR9gUa1UF7l8Bf07IAQtHdEX8C6a7DhGACNV3CS/4FVG5M/3ozkdsxbZ4N4hHvgloO1y8vVLhmja19bqGmjGMTn3BiWogutWQd+qkzXf2aU/OgY30vwom8qe6Y0Bdvc+m4Ne/42dwCxsKLoQGUMviYhEeKpgNLyDTEQs7Xd+Z9qVRzqGAJgabvhQg850nJvkzSZf7aj95+ai6L48DFq2g3ZLKuKOUyxaE9iAcNMQ27OYEaBi22peizx5EW0d/pxVAoru2uh131fGzHi/xegYZDpwAYrDffjfBJFTgZD3B5OsTlAgEuhUBikXooVmXyB4RW6zh11/7y6r7ewe1oJLTPeBWo4/Z+IDQgRGzjz6LAUqP+OpilkRZ0Lu
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(18002099003)(22082099003)(38070700021)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?aVpsa1llampnMTI1OFRxMHJ5ZlFzMnBmaDMyb1lzRjN6ZDgrd1AyWE1TY3hD?=
 =?utf-8?B?NitTaUgyZjlwMFY5T0Z5VWV4NUl4OU50VnBubWFXdDFwNVV3RG1FUmpoeTQv?=
 =?utf-8?B?NUdjTkxJU2xrL1dSbGVDK2I1QVZtK3k0R3A3SnhKcFdiOHluOThPbzVGL3ZX?=
 =?utf-8?B?L3hVWmozL2ZuQkttZmFkaXdRa210OVM5MklrQnBQSThSWVRKYzJjUFJlaEtw?=
 =?utf-8?B?WkR4NmhxVlZ6aFZQRUdoWlZSVTI4clJ0VFdua05ZNXE4UG00SytqSGtDdG5C?=
 =?utf-8?B?VWxFTmNFbVJUUE9qZmFXSTAzRmxhdngrYURUZjExc2NlUDJNMDdlSWtURmlG?=
 =?utf-8?B?TUlZU1kyMG56R0dsSVRjNlprY1NQMFhnQnZzSUpaN2dGLy8vQWh3dFdzUCtx?=
 =?utf-8?B?ZUNVWG55bUsraGtTalpYTzFPdFUwMzc0djhjN25lTGRXdW0yV0Y2d01BcFUx?=
 =?utf-8?B?M0JZT1ZxYlZEeEdGdVE1bHZhQW1NTVorQjVJZjdFVmNNekZpdGt5d2RKcGQz?=
 =?utf-8?B?WGNWdzhidE9SN3c3M3U4eXdWRUNSTSthb3B4aHI5TUMwMThYQUdNbGdwOHpp?=
 =?utf-8?B?aVRZVno3R2pldVd5Q29NbjF1M3RkTXFVN0tNZzBlRmRoUTVIWG9JOW9OeHJR?=
 =?utf-8?B?WkZPb0hHL1NzaGNvMmp6QUswZkU0c1FhN1Z5U0toWFBCNHdFOEhxZ2Y3Nkhk?=
 =?utf-8?B?UkJpRHNxREh1VnQ1OVBIWnl4dmwrbmRlVlpMTzZCdU8zNGxrMjRtem9iWFJO?=
 =?utf-8?B?ckFuQWRBYXBqTnN2QjY2Z0lIV1VGVklwR2pQU2hUUzJXWFVrU0ZRakVabzly?=
 =?utf-8?B?QnRNbUdHdlNoRXRhZWtQWlliMG1GRHR5UjZjSjJiZnpkN0ZiUGxtWi95R3lI?=
 =?utf-8?B?Yjlqb2U4THdmZzFLRlFtS2RLamp4d2F5ckFFeXFvNi9YanhtYzNZL29udCth?=
 =?utf-8?B?c25WYjUzeDZvVzNwQXNkM1RweUd4TEo0RmJqMTUxV3RkSEl0bnZ5YW0wcVU4?=
 =?utf-8?B?cEJKNjM2WWF1aExvOFFZTUk5UHJiQ1lJeGRQOCs4VDhwWGpPWllRZHk2Y3da?=
 =?utf-8?B?TUoxQ0Z1dXV3VTIycWRKV0dMQXE1NDFLS2JVUU1hQjJZUVcxeWhwUUlQVDNw?=
 =?utf-8?B?SngvZXZzejBPL0didzM0RkxFM2ZNUW10azJpWm5BWWh0U0ErT09VVEpYbHF6?=
 =?utf-8?B?ZEcrS1NiR2FEYjc2em85NGV2YWJscjRYbm1vVzNqYXdxODd6dllVeURsNUw5?=
 =?utf-8?B?Mkw5SCswM3VPUEF3VTdmOFJ5TDRXd3puQ2hEcjBKbU5haWkwUlBXNWlVVXFT?=
 =?utf-8?B?UHArODRoSjJYQXZLOXl4V0VQcEVxK3BsQnN4RXF6Y1pTd1MzaEQyTEFOc3c0?=
 =?utf-8?B?bno5ZnZUUHBaSVk1VVJPQmxwcXlsck9rUnZxM2Nnc1VMVVZxcTAzdDQxUWh5?=
 =?utf-8?B?V1U4T2xYUUtkdDdjQkt5TmhjUlFuSlJFK2pJZFNRTHQ2QXN2VTZ4dWhIN3NN?=
 =?utf-8?B?d0N2bGNoRzBGTnRLenpnb2JtZHFyL2padUFvSHMxeHN4RU5VTlJXZkVjajdy?=
 =?utf-8?B?TkFjM0ZOOFdqNFV0Mk9VK0Z4ZVVjREtZQnRzNjdjZm1yRDNRblI4T3l3RUNy?=
 =?utf-8?B?elBwUFc0MzB0UURHcWdXRlF0eUJ3bkFzZ2xnMGNUZmlTWEU5TjhGU0d5ajdp?=
 =?utf-8?B?QVFEU2krbTlKYll2Z0M1UzA3SkNySmo2aituVGRNOTcvbndKRzN5WDVQK3BO?=
 =?utf-8?B?K0daaG0xeG50L0Nmbk51WTRSWVoyMENkRWxNakZwL3JBZ3Y5WkdTYTZwT01t?=
 =?utf-8?B?cG9KbzZEam5xNm9KQ2c2MTRXQ0RTWFJjbXBIR3IrV2wrNi8weEN4NkRqRmNj?=
 =?utf-8?B?UHNTNGJMLzV2K2p1QWEzdm92a05vZ04vRFpORUZXemZJY0RqT2kxa1RRKzVu?=
 =?utf-8?B?aUZwQzFkV1lQeVBTNUcwOHM4UHVUK2RoMEdMbms5RWhoUkNFcmtDK1lIemJl?=
 =?utf-8?B?NmlFempvSHlMZS8zU0QvQVJPbEtxRzlXVWZydjVzVm5wWENzeHhaaHRkS3RQ?=
 =?utf-8?B?bkhSR3VVbUVZTTlaRUFoYzR6SkJaSkM5amdwZTVCc211cjd5ZWNuSHRCb2N1?=
 =?utf-8?B?K0VlWXk3SWxpdktUeG1adWVDRnFLUGdWM0UzZjZOTHFMcUI0ZjdzNnpZcE5S?=
 =?utf-8?B?NUpjbjhtL2g0blNEbnk4VlRWeGVMelJNOVFFRmFjQ2oydlYrWFNwUC9FbWxa?=
 =?utf-8?B?b3pvdFFSQzBCanYwajVqSmdFMGcyNkthNUE4TldwSVp2T3NYbTBDU3ovSDVB?=
 =?utf-8?B?N0JhN0NHR0Fud0l0R0NVUEgxSlk5aEYwQ3I1amNDL1hLVFRhc0svNWsvY254?=
 =?utf-8?Q?gbSZ+3o/nT0W54DA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	N74lJuFcYuiW2TnA53FL8YWlGVoftUBlX0PXgLh39ht+lkSIOBNmn750drEuehKK0joddiKM/q8FOn9ms+Q8l/shIG8jJ5R/W6Mg4ZskTbXdZA0Q5sDGRaTL6MJVJ9/FOsmowujTDHsxQ18KbEBYTycxQXP/Tw56Udpy3c0atoYvrMG5ejwaRSDTLkgiuuAn0jyUhN5+E9V1G6M+Y8ftgBr1k0pTojOZzIwZP3oB3u7yxT0pwX4825cojiaeoEqG4yBc+00U8qYExn2bmPDh8UMUsfuVPniBqML63bRyMRqUTp9PvMUFU/l1bBufG8hbNyHd10TvQ+G0ZpbzT4VSXg==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36cb7e4a-80df-4ad4-d5e8-08dec75a9ad0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2026 01:41:49.1429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BDn04E2cjvCKkffHdlluATtxgxz/EC2i7KtOFjMR4eyfVBMEeoNBGIlm0wmexgQpUHLH1vbZ5eCQzjDA60l3SxdN8tGvmApMw8YaCx7Y2FyeNXaeV5PsN2J+Q7d+Ln2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9524
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Jun 2026 01:42:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23056

SGkgVWxpLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFVscmljaCBI
ZWNodCA8dWxpQGZwb25kLmV1Pg0KPiBTZW50OiBUdWVzZGF5LCBKdW5lIDksIDIwMjYgMTI6MjMg
QU0NCj4gVG86IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnOyBwYXZlbEBuYWJsYWRldi5j
b207IGl3YW1hdHN1IG5vYnVoaXJvKOWyqeadviDkv6HmtIsg4pah77yk77yp77y077yj4peL77yj
77yw77y0KQ0KPiA8bm9idWhpcm8uaXdhbWF0c3UueDkwQG1haWwudG9zaGliYT4NCj4gU3ViamVj
dDogUmVxdWVzdCBmb3IgcmV2aWV3IGZvciA0LjQtc3Q3NywgNC40LWNpcDExMg0KPiANCj4gSGkh
DQo+IA0KPiBIZXJlIGFyZSB0aGUgbWFudWFsIGJhY2twb3J0cyBmb3IgdGhlIHVwY29taW5nIDQu
NCBrZXJuZWwgcmVsZWFzZS4gQXMgYWx3YXlzIHRoZXkgY2FuIGJlIGZvdW5kIGluDQo+IGh0dHBz
Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2NpcC9saW51eC1jaXAu
Z2l0L2xvZy8/aD1saW51eC00LjQueS1zdC1yYw0KPiANCj4gNmU2ZGFmY2I3M2Q3ZiB4ODYvQ1BV
L0FNRDogUHJldmVudCBpbXByb3BlciBpc29sYXRpb24gb2Ygc2hhcmVkIHJlc291cmNlcyBpbiBa
ZW4yJ3Mgb3AgY2FjaGUgOGU5ODU0NTE3MGMxYg0KPiB4ODYvQ1BVL0FNRDogQWRkIFg4Nl9GRUFU
VVJFX1pFTjEgNWUwZjg4N2FkNzY0ZCB4ODYvQ1BVL0FNRDogUmVuYW1lIGluaXRfYW1kX3puKCkg
dG8NCj4gaW5pdF9hbWRfemVuX2NvbW1vbigpDQo+IDZmMmEwMzYzOTllOTAgeDg2L0NQVS9BTUQ6
IEFkZCBaZW5YIGdlbmVyYXRpb25zIGZsYWdzDQo+IGUzNzlmMTBiZDhmYjUgcHRyYWNlOiBzbGln
aHRseSBzYW5lciAnZ2V0X2R1bXBhYmxlKCknIGxvZ2ljDQo+IA0KPiAoQWxsIG9mIHRoZXNlIHBh
dGNoZXMgaGFkIHRvIGJlIG1hbnVhbGx5IGJhY2twb3J0ZWQgdG8gNC4xOSBhbmQgYWdhaW4gdG8g
NC40LikNCj4gDQo+IFRoYW5rcyBmb3IgaGF2aW5nIGEgbG9vayENCg0KSSByZXZpZXdlZCB0aGlz
IHVwZGF0ZSwgbG9vayBnb29kIHRvIG1lLg0KDQpCZXN0IHJlZ2FyZHMsDQogIE5vYnVoaXJvDQoN
Cg==


