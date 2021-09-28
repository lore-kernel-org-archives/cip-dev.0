Return-Path: <SRS0=OVhk=OS=lists.cip-project.org=bounce+64572+6755+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD85C4332F
	for <cip-dev@archiver.kernel.org>; Tue, 28 Sep 2021 12:30:11 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 297FB611CC
	for <cip-dev@archiver.kernel.org>; Tue, 28 Sep 2021 12:30:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 297FB611CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id mwY2YY4521723x6oLYt1CpFU; Tue, 28 Sep 2021 05:30:10 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web09.13025.1632832209195098994
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Sep 2021 05:30:10 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 18SCTwYb026376; Tue, 28 Sep 2021 21:29:59 +0900
X-Iguazu-Qid: 2wHHhCFIIzI8rfZxY1
X-Iguazu-QSIG: v=2; s=0; t=1632832198; q=2wHHhCFIIzI8rfZxY1; m=tkePXlD/kNkBb1Su9gMXyIqphaKqEFWYE+Nipc9uRUw=
X-Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1111) id 18SCTvXP039366
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 28 Sep 2021 21:29:57 +0900
X-Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id 1292B100101;
	Tue, 28 Sep 2021 21:29:57 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 18SCTu8S020279;
	Tue, 28 Sep 2021 21:29:56 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hBdzJ0tz//jDOXLPocif+BINJ07xx3zwImUk4BycjUKbO8daiPtuBoNlA/TzDLLX2EyctBspTU4rxp8xNX26EB8XHzkJw68tzEunicgdkEUrJk+OdiOxD87ew2v2V6Zi4ZxSeOClpJw5dMc8m8Y6Y+5nqgDBU2aJpoI+Rf22wCOIAHqSu/NlcxYqG/LigmaTsCPLcqMDDvsEy+6IUdc8ZrAx0e+uiOkzmi//qhvEOX5INs9J7AM+4VJ+oBciYVgkN4m4yx5OPBiC6nn4NU/+8fRb3JG8/PtXJBVjYd9fzSS0CZ/rSNS3WWSC4lKXOUfltdYTJrhAnuy0nl64zLa8TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Gh0ZLSpGGcJNDG6SxZ2maOzDvz5pD/e4hy6L7D6Lzgk=;
 b=DE3nrWwV75HNnVnKiRLx0qWxZzmQyfhIZQ7zkgWM+Mv4PSHNW7cQ4NQQaC6VI3JZCODEs1s4Yhpjytz9qiuFF27oae19aixl987l5vNKWKgdh5usp/MMn3RTq6PihTEUH1ULtYjtikiH7QTVQuJpDuoIH3qoa8KxGS/MRWobPxgH3hkIiETuURgLTA9qifWl9cBEmdWar1qy0qFGyfNgA7pu0CWnl7wbT3aNxpaqlKfvBD+LyMLutylDAeXPzZPWxBJd5Il5fO2bhLpvRs5QXVUS4DU0QgKtRcYyjSynRCgdioGdV8+3JLBDqmhGFgXp5QOkzfQnKQgxoBC75yzunQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>, <uli@fpond.eu>
Subject: Re: [cip-dev] Coordinating stable reviews
Thread-Topic: [cip-dev] Coordinating stable reviews
Thread-Index: AQHXs4fkjPn8h9fuX0agG6cSu/Jqn6u5XLZA
Date: Tue, 28 Sep 2021 12:29:54 +0000
X-TSB-HOP: ON
Message-ID: <TYAPR01MB625208335CBDF511529323C492A89@TYAPR01MB6252.jpnprd01.prod.outlook.com>
References: <20210927100950.GA11971@amd>
In-Reply-To: <20210927100950.GA11971@amd>
Accept-Language: ja-JP, en-US
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c698f497-2b73-49e4-5946-08d9827bad56
x-ms-traffictypediagnostic: TY2PR01MB3034:
x-microsoft-antispam-prvs: <TY2PR01MB30349A49087E4D84D54E7D3392A89@TY2PR01MB3034.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam-message-info: 9ReokQ3I4Bzp7P+FFzF3GQHtzpzzQkuESuWAsXEE7Wcf0mzw8CLjANRX5Hee9HzvnniKRU17zRXRZ+QxrVy3CBesw9VL7G/i16g2SgTmHEjykC8YW+oTEvGEzCda1JpF+jqO7iPY5q3Yts/JbRw2C3DVCoToRJyDPMDq+5xEYtNI8DOIwFJCi5adlErWO4QVdq3spysQImJeRUJMgz9udsxCQHXwBM8x6iMGX7qBM/mRbJ8ArcShNpmod1SCEf2ybpeWP2rnp0GRby3iYovXGJiShCKmPzVAvMR2Uo9ZcuXiFbAXeXxODENu+iCUN6iUVu/Srxo+Xs4uVUOfXqUA7jv6KxjBIViMQUbuTWG6ufCzRRtnY6pdeYlMR98fwxVSQbWYaIzUT0CBkuqj5W3Jssxff86IBF74As8QA+6b/RTWW0Av8cNuD/9E+ttQWGC1KUFArVkwmxE5DaUBCv/i4Z8ILWvdG5qC/EIUFhUFvbqOOQiW68ZfwVr/GrF2ErBiux8YGE498QUaKA/bNjUi7SVygQ8qdRyctrW8XYBCF8pFa+RpgAuBhnlii9kPcgOgrYQuxzVOfy6fsZY4PnkRgsz3L5anRofeSBrHaDBdxSEY75oCZf5ihjMftGj8C3FWg6ZXyV9mj1prsmcPiETBNwdB7FGh/wBmJ2GeKJYfBsSs9LOhoWDgiHB7nZsC0jbcq8rGzzCJosco8mT0wg0o0830cIDcFbMTmjayhDhT+shK1Igy+3RMFUot3brY7RUNoL6WCP94rk6gxxf9hrZ4wMulRUFX4QvgWpPze/aD9UU=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QjV0enlkU3RtSUtHQ01qZVJmcW4xQ3FYZ0NrcTdWbkdRYVpvMDN5N1k2MGRS?=
 =?utf-8?B?VVRoazlnaG9keTBwV0NuanB1b1Zna2xybWdVall4Rm1xRGlJT3VVWDVEM1JN?=
 =?utf-8?B?Wmo0S1RRVmRBZk4vQ2NYYTNlUDVWR2hwYTBNYUU1S3ZqQ1RNY1paUlFXZHNx?=
 =?utf-8?B?QlJCeGNDZWZTWnB6OEg5WWNTQ2tlRFdRbldzTVlVS2VwTFR5OXNVQzFQUHhp?=
 =?utf-8?B?MGdXQUl6aGdLT2Vvd1NKeWtLYkZrYURyaUo4dERSejc0ZzcvZ211MXhIQ2d6?=
 =?utf-8?B?cVYyeUk3YWFZOC9KeWJDS1krVjM5ZGEwYURjd1orSlFkN0lwSlJXK2lvRHRr?=
 =?utf-8?B?azk2cVBON1ZObDdOY0t6WGFjbUo2UURoR3FuU08wczE0N2N5ZGNpWEJZNHJR?=
 =?utf-8?B?d3puMmFjYkN3ZzBEclVSc0JNNWpxcHFOTDd2VkxraDYxSzBLQSt4WUFuNlZv?=
 =?utf-8?B?SENWZys1SXZweTVmTndvY1lpdXAzNUdHajVxMUdzdGxnVmpwbmRXMm1pVXFM?=
 =?utf-8?B?U1lZTXBPNlJzcWI1am1kZjRWUFZkR21KYWE1MzBJODkrT3RlYVh0UkRaelp1?=
 =?utf-8?B?VGMyZnNuaHNmcjZyWTBnOElLOWkwbVprbkZWdGo0cWRsTjcyaVJUVE4rVmpn?=
 =?utf-8?B?b25YRU1ZK3IwOVZSeEV6emJCOC9jQWlabXZqNU1wd1E3Znp2MjVzVjk5VXhs?=
 =?utf-8?B?N01Ud0RzNUVpTUd6QUJEUnUrdzBOUDBzbWZ4YUlrYnlRcXFScGJRYmZ5YXRO?=
 =?utf-8?B?bFd0NTVDSjhYWUtjU0EydHU2VW94T0JJeS9KQUQvU2U2bDBhM2NnbFJXWjNu?=
 =?utf-8?B?RlFwTkNDUU5nTFkrb0ZsU0JpN0lOYm1HVzEzSHhVUkd3SExNU09iNUhvd0VL?=
 =?utf-8?B?QUFXQXdqTVdsZDJWalVLT2tEWWVvV0o4SVB5ZXNyZGV2UlYwUXFyU0lubWlB?=
 =?utf-8?B?VjFSN2t1NDZUd0R2K1U3K2xuN3hZUWlSTTJVRjhlSWpDa0o5Q3VRNzBDUSsy?=
 =?utf-8?B?Y3c4dnczakV2cnpzVm5zTzlrLzJnMURXUUxkT0FBSWpUcnZhdkxOcEVBU0Fj?=
 =?utf-8?B?QndPSnpCV2tuTHBjdE5qYVY5SXc2M09uQU5WZ3dEd2R1T3FmOXplQmZZUURZ?=
 =?utf-8?B?a2p0c1pkc2tqWWxjOWRrNEZlZXNjSVJQU2ZLWXNKSkRvcUZtS3p5L2w5UDNK?=
 =?utf-8?B?aTRCdkVqM2JGSmFYN2lITTZuOW1mbHlOSWhIMXN0bmVGT25aYXgwK1lIWWda?=
 =?utf-8?B?NkRsWFdsRVBNZDZLRzhyN2V0UldQU2tvSW9ZckdTVDZZNDBEeTl4V1RUVzBX?=
 =?utf-8?B?YkRrNkhNUVE3alJHSkh3cGNuZ251bEtsNzZEcTNPeU5xZGdkY1lNaWJvM204?=
 =?utf-8?B?TFMyNVB3aDloZFA5cmF6cWFjOWFBdFFRQVN2UWRuRndMVXpYZjVvUnpOMG5l?=
 =?utf-8?B?MkR4YTFiNDVJZmY3MUhiZjJIb1NGTFdVdnlPeXdsaEdVRkFxalQvemtXbHkw?=
 =?utf-8?B?SWlMaE5DS1ZlbXlaR283czl2eVYvMUk3ak8xTE1DdVRZMUFDR0paR0NMczA4?=
 =?utf-8?B?ckpLTzVlMU5zZkRKdjhqZCt2MURXbXY1U1Bsc0RzZVo2WnQvL3d4eWgyMlFQ?=
 =?utf-8?B?YlhLVUFHQ2xnUlN6SVI2VGVNM1lSRzlwTjVwSHJUNGVtaHRDR1VIc0JKbGZQ?=
 =?utf-8?B?ODhiZlRVSXNMN0dkUitRNmZtTkU2VEVVWkI0MllLdDhTU2hicEIwS0JYNndO?=
 =?utf-8?Q?2R+3+tTv4BDG3mnj5RmKvxxwzIFiy2D4jZZpRIM?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c698f497-2b73-49e4-5946-08d9827bad56
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2021 12:29:54.9724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m+8ZxiGunno5uOqJa90wrwjYBxTX6M/jnZJlSTCdVPiRzKYjjiMDatMzAuMx4pweIBdrcu7GcBVotkm/YLI6uO6XSskSOMm67hb/kEan7W8U2oxisojAaIy2zcPqgxzX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3034
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: dO4drb2qQIcsdexVOuIwQBqtx4520388AA=
Content-Type: multipart/mixed; boundary="1Z7JlVPQvuwqnZg99WJI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1632832210;
 bh=tLxWhXF2GB3mvZCb029soReof27zivEw4xREgu/hTOo=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=cI6u5RcJfaR8Xi1Xewy1c4U6GXwuC1iCNRRYCHGxW37ab+0SCGioOsDqh9F3Dib06QP
 qKD20Df/9qKPwkcAO4FGRig5p5EOyIpp+8QDHpi+0IeZPRjVGStNWfrZhWpC9dn+FJGjP
 i+AyAmiGEvHN1AvCjSUp/p0frmz5pkXoTp8=
Message-ID: <20210928122954.QV3NQ2fPySsxtm-rZYdul2gVSJEGImsutafVV5i44bI@z>

--1Z7JlVPQvuwqnZg99WJI
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogY2lwLWRldkBsaXN0
cy5jaXAtcHJvamVjdC5vcmcgW21haWx0bzpjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZ10g
T24gQmVoYWxmIE9mIFBhdmVsIE1hY2hlaw0KPiBTZW50OiBNb25kYXksIFNlcHRlbWJlciAyNywg
MjAyMSA3OjEwIFBNDQo+IFRvOiB1bGlAZnBvbmQuZXU7IGNpcC1kZXZAbGlzdHMuY2lwLXByb2pl
Y3Qub3JnDQo+IFN1YmplY3Q6IFtjaXAtZGV2XSBDb29yZGluYXRpbmcgc3RhYmxlIHJldmlld3MN
Cj4gDQo+IEhpIQ0KPiANCj4gSXQgaXMgZ29vZCB0byByZXZpZXcgInN0YWJsZSIgcGF0Y2hlcyBz
b29uLCBiZWNhdXNlIHN1Y2ggcmV2aWV3cyBhcmUNCj4gbW9yZSB1c2VmdWwgZm9yIHRoZSBzdGFi
bGUgY29tbXVuaXR5LCBhbmQgYmVjYXVzZSB3aGVuIGJ1ZyBpcyBzcG90dGVkLA0KPiBpdCBpcyBl
YXNpZXIgdG8gZ2V0IHBhdGNoIGRyb3BwZWQgaW4gdGhlIDUuMTAuWC1yYyBwaGFzZSB0aGFuIHdh
aXRpbmcNCj4gZm9yIDUuMTAuWCByZWxlYXNlIGFuZCB0aGVuIGhhdmluZyBwYXRjaCByZXZlcnRl
ZCBpbiA1LjEwLlgrMS4NCj4gDQo+IFVuZm9ydHVuYXRlbHksIHdlIGRvbid0IGhhdmUgZ29vZCBz
eXN0ZW0gZm9yIGNvb3JkaW5hdGluZyByZXZpZXdzIGluDQo+IC1yYyBwaGFzZS4NCj4gDQoNCkl0
J3MgZGlmZmVyZW50IGZyb20gdGhlIGN1cnJlbnQgc3lzdGVtLCBidXQgaG93IGFib3V0IHVzaW5n
IHBhdGNod29yaz8NClNvbWVob3cgZm9yd2FyZCB0aGUgcGF0Y2ggcG9zdGVkIHRvIHN0YWJsZUBr
ZXJuZWwub3JnIGFzIC1yYyB0byANCmNpcC1kZXYgYW5kIHJldmlldyBpdCBhdCBwYXRjaHdvcmsu
a2VybmVsLm9yZy4gSXQgZG9lc24ndCBtZWV0IGFsbA0KcmVxdWVzdHMgYmVjYXVzZSBpdCBjYW4n
dCBiZSBvcGVyYXRlZCBmcm9tIHRoZSBjb21tYW5kIGxpbmUuDQoNCkFsc28sIGFzIFVscmljaCB3
cm90ZSwgSSB0aGluayBpdCdzIGEgZ29vZCBpZGVhIHRvIHVzZSBnaXRsYWIuDQpJIHN1Z2dlc3Qg
YSB3YXkgdG8gY29tbWVudCBvbiB0aGUgY29tbWl0IGluc3RlYWQgb2YgdXNpbmcgdGhlIGdpdGxh
YiB3aWtpLg0KZm9yIGV4YW1wbGUsIHdlIGNhbiBjb21tZW50IG9uIHRoZSBmb2xsb3dpbmcgVVJM
IChjb21taXQpLiBXZSBuZWVkIHRvIGludmVzdGlnYXRlLCANCmJ1dCBJIHRoaW5rIGl0IGNhbiBi
ZSBtYW5pcHVsYXRlZCBmcm9tIHRoZSBjb21tYW5kIGxpbmUgdXNpbmcgR2l0bGFiJ3MNCkFQSSBv
ciBsaWJyYXJpZXMuDQoNCiAgaHR0cHM6Ly9naXRsYWIuY29tL2NpcC1wcm9qZWN0L2NpcC1rZXJu
ZWwvbGludXgtY2lwLy0vY29tbWl0L2QyNWI0OGQ0ZDNlZjFjZTc1Y2U1NjI4YThhM2JhNjBhMjQy
NzA5MGYNCg0KPiBUaGVyZSdzIGEgc2NyaXB0IChjb21taXQucHkpIHRoYXQgcHJvZHVjZXMgb25l
LWxpbmUtcGVyLXBhdGNoIG91dHB1dA0KPiBzdWl0YWJsZSBmb3IgcmV2aWV3LiBPbmUgcG9zc2li
aWxpdHkgd291bGQgYmUgdG8gaGF2ZSBzaGFyZWQgcGxhY2UNCj4gc29tZXdoZXJlIHJldmlld2Vy
cyBjb3VsZCB0YWcgIkknbSB3b3JraW5nIG9uIHRoZXNlIHBhdGNoZXMiLg0KPiANCj4gSSBkb24n
dCBiZWxpZXZlIGx0cy1jb21taXQtbGlzdC5naXQgcmVwb3NpdG9yeSBpcyBzdWl0YWJsZSBmb3Ig
dGhhdDsNCj4gZm9ybWF0IHN1aXRhYmxlIGZvciByZXZpZXcgaXMgZGlmZmVyZW50IGZyb20gd2hh
dCB3ZSBoYXZlIGluDQo+IGx0cy1jb21taXQtbGlzdCwgYW5kIHRoZXJlIGlzIGdvaW5nIHRvIGJl
IG11bHRpcGxlIHVwZGF0ZXMgcGVyIGRheSBpbg0KPiBidXN5IHBlcmlvZHMuDQo+IA0KPiBXZSBk
b24ndCByZWFsbHkgbmVlZCBjb21taXQgbWVzc2FnZXMgZm9yIHRoaXMuIEFjdHVhbGx5LCB3ZSBk
b24ndA0KPiByZWFsbHkgbmVlZCB0byBrZWVwIGhpc3RvcnksIGVpdGhlci4gSXQgd291bGQgYmUg
Z29vZCBpZiBzeXN0ZW0gY291bGQNCj4gYmUgY29udHJvbGxlZCBmcm9tIGNvbW1hbmQgbGluZSBm
b3IgZWFzeSBzY3JpcHRpbmcuDQo+IA0KPiBBbnkgaWRlYXMgd2hhdCBraW5kIG9mIHNlcnZpY2Ug
Y291bGQgYmUgdXNlZCBmb3IgdGhpcz8NCj4gDQpCZXN0IHJlZ2FyZHMsDQogIE5vYnVoaXJvDQo=


--1Z7JlVPQvuwqnZg99WJI
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6755): https://lists.cip-project.org/g/cip-dev/message/=
6755
Mute This Topic: https://lists.cip-project.org/mt/85896746/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--1Z7JlVPQvuwqnZg99WJI--
