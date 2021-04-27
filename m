Return-Path: <SRS0=yLHo=JY=lists.cip-project.org=bounce+64572+6397+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA108C433ED
	for <cip-dev@archiver.kernel.org>; Tue, 27 Apr 2021 00:31:59 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F530611ED
	for <cip-dev@archiver.kernel.org>; Tue, 27 Apr 2021 00:31:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F530611ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6397+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id tEVWYY4521723xaNf1uoNjU9; Mon, 26 Apr 2021 17:31:58 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web08.1964.1619483515716149315
 for <cip-dev@lists.cip-project.org>;
 Mon, 26 Apr 2021 17:31:57 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 13R0Vn2w002086; Tue, 27 Apr 2021 09:31:49 +0900
X-Iguazu-Qid: 2wHHzBsWLDbLi7riLt
X-Iguazu-QSIG: v=2; s=0; t=1619483509; q=2wHHzBsWLDbLi7riLt; m=NqgJ2NlmuOwmD1/9nig0MGwkFJSbiiH311Ppco5Gttg=
X-Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1112) id 13R0VmZp028622
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 27 Apr 2021 09:31:48 +0900
X-Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id 2FE851000C0;
	Tue, 27 Apr 2021 09:31:48 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 13R0VlKH031965;
	Tue, 27 Apr 2021 09:31:48 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZLoZIzWk6Tqtv6Mj8jpusgBJ7X6MqzYmtoaKg2U6qwxPRCTxFZlkDA/DYFsXPfYpku/b5FKXj5Vl9s54RpadBGgNS+U/d66ZMsafKXuApfA3bINu4p4CPqk6P7u4El4bQnl4fiJXFEwof8+bF2AWkwTzn5qR/iNDGZO7a19BiDnw5b/MypsBikSWmFg1kpPcUmcyoQm1OMNkui2n4DchWcDAgqb4WpA5dwCpEIrrXovVwGt7Wv9mac5NWwGvNrZk5UVDXjPsFHk6nuaNYU06BoYwZn7MTPDg5Pq3uw62IGE/cOHoXSnaPZjlcvn8KDQme9rvjPHt8ZMVfeJnfSxVCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXK6quNCkJhHXzJvT8bXzAM1rtJPyO1MgLlzA9R2G78=;
 b=dQWifh38LymjAkCOQuf+ZlAtdsLGzk4UrCWL74PmFID8xcCDYeTsU1Q4wtnKQKoS4FDDm9m72CEH6X22XzqMM3kgRJlawgY8ZgfwmBwmHAdDWqvGEHl24bTQkS85jgH1qkpDyJXj04ob9dzSKjYuxgZX0LNuUn7AeXjBDLVyZgZwJRqgKT79DxvhekdNR0zC9WiVNBnecIejTNszUFdI51gNYpcViijKxcR3KRZR4GLC++T4C9QqCxOoElBcocCQF8KXBAuf37oxDMtQIIm1GUYakynxMHxoTvJaQtGOzriJ4FWDMh02pXuUi7j90TSUQFhTAILQWQ83K5kzO11gcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>, <masashi.kudo@cybertrust.co.jp>,
        <minmin@plathome.co.jp>
Subject: Re: [cip-dev] [Inquiry for CVE-2021-23133] -- necessity of the backporting
Thread-Topic: [cip-dev] [Inquiry for CVE-2021-23133] -- necessity of the
 backporting
Thread-Index: Adc6XySnLTu+cWedTlKOJgoSIwGVRwAPiYmAABefKdA=
Date: Tue, 27 Apr 2021 00:31:45 +0000
X-TSB-HOP: ON
Message-ID: <TYAPR01MB6252FBA097F34080E4A2C49C92419@TYAPR01MB6252.jpnprd01.prod.outlook.com>
References: <OSAPR01MB496166751E93E55A64756505A0429@OSAPR01MB4961.jpnprd01.prod.outlook.com>
 <070cfa43-dc83-b3a9-366c-e07b122b6d34@siemens.com>
In-Reply-To: <070cfa43-dc83-b3a9-366c-e07b122b6d34@siemens.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4722e957-1fcf-4f79-7491-08d90913d63d
x-ms-traffictypediagnostic: TYAPR01MB3311:
x-microsoft-antispam-prvs: <TYAPR01MB3311F1DE1B2F6DE158F237FC92419@TYAPR01MB3311.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UZov6PDfLoolPbvsE+SQiQTXSLmn3piWywdC/su59YsqhVs4TVTmuvPTSpCfWLLFBX+a5sIFnEX1PioyKEGBAziAhqC2DQCLn9KYn85abQUGoxhcPOHlixqdWSeIETFi8ck5WoEY4VBbX4u2y20lvIApPz0tTYNNCeE5rWn69+/CFW69c9YiFzoQ4JVNRo4FqEWaEnFMG7TTsY6To1fijJ9B9LTAOQCpmwOaGqus2RHrX+4BfoDSn5Lbm+cDBnApbEf+1FwErlSKT8GXgB7e6lL5SGbC3xueoWtPZreG8mvWDQ3tj7IdnoeKcjeX+0OxGdEcnw8tdy88waiWv1bt3ofeX5yRLnH58DqXtyrclb4zJ1bs5vEt9Yw0scI5efkn7YUoWl69ADQQ0lpNBs1YRVkRwEMK37ybDMeJVW3ZlJtlGBwTUg8tsPARdEMBt3ZasyU/CvGXxSg3acyw/g0ZHpAcaRzDmspPhzmKtYXIYb6AyXMAJcivt5O3sb5eVNWHpwYwStIJRWNlYuB9PlVZV1IK9YZedadgcPR6J2D0/icEr4eSy2lu8w9bjakaYJeU68d9PtOQo/P6aLdbWfzBYNZGfqXp0CTBOwuo8+/RGd6tFPRtZmkWCb2PR4qL7lkjr0dt+SpbFi4IlOpkOh4BnDvxWf/oPVKpVIMcD+KrsZM57cTS0f7nEvF+a387+O7I
x-ms-exchange-antispam-messagedata: =?utf-8?B?a0cwWlU1Mm9ENElaMm5rUVl6cnZ5TVBlKzZRUk5MUmVpM3NlSHJnNVNQL003?=
 =?utf-8?B?eUZvUVZIWWtLdVl4N21JVE1JM1ZDMUswK3RHbzdxcjB6akV0eEkzd3V3QnMz?=
 =?utf-8?B?bWs0cm5sdWtFTUJZclRtYUtEeUhqK0Faa3dGUXo2SW84MDJaNEVNaUM0QmFR?=
 =?utf-8?B?UmMydmJxUHA2bUNRUmhaMUpTZEQyME5EWVBvV1J5aG1nUHVXZU5wZWlBOHdn?=
 =?utf-8?B?RTNyeUIvM2drOHdtQXJRMTBiRmJRbWtDclFqZHA0MVRGNGtldGRoUllwN3ht?=
 =?utf-8?B?L0dOUnhOK0FOQjRUT2JrN0RVMFBDOFltTjByZFBpNjlDOXVqNmNBeEV3Z1BZ?=
 =?utf-8?B?b0FONGxnMzFVdmZvRUZJMHVhcEkxL21GSWRCcU9aeGx2L1BDUWlBbmMwZERF?=
 =?utf-8?B?eUhzVXVNMTZRTkFwM0JZSC83T1FabGtnOElTL254SmhkTG9xN3gxYzZtNmJW?=
 =?utf-8?B?ZDhaenhLSHoySndiSEUyV1pTdE15a1VlUmtkdGhTOW1TVUhsT3RhemNuM0xn?=
 =?utf-8?B?Sy85dnNOK21pWlAwR1VLOVp4N29iTmxSTUl6Um1hYmlUWmUvcDZ5RnBqMXZ6?=
 =?utf-8?B?RTl0UmY3aFdyRkNUbGdEWVFEQS9JekNkdmVrd3lRcWxsWWFkYTdPMVk3aklO?=
 =?utf-8?B?WWdPVkdUNTVaOE81c05rc0hPdEtOOURseWpqendsVVRIbXRxL0JUSnpldVNE?=
 =?utf-8?B?OHdFRjN3QWpkek9aeHFwaE9HRHVTTG0vRXJNZ014U0VhY21iVEpyZzFQRkUy?=
 =?utf-8?B?aUVqeGltNXNUQndKY3Z2UXFjZVU1OE9LYlRWNGJVSkJPY3FmbTJYT1J4NzB5?=
 =?utf-8?B?dnF0RFI3RUtBeXlwZkY0Q2xQRnUxQkVjZ0VHSWIzQkpHNVhuMmFRUGhxNk5N?=
 =?utf-8?B?Z3ltbjYxcFBucVNKTERYMUpscXFjU21acW1aS202MFF0a2NhRUQyZjkzN3RI?=
 =?utf-8?B?aUFVWnM4cEw4K3lWOUJnOGRCT3dXbm96Y1hqVS92K1pyRXJCZGFNNkRMOTh0?=
 =?utf-8?B?S1dGU1FRQkd5UmNPMUlVQnlHY1RxNUg3YUhMV1dPdDJvRWxBWnFvNkNtYkEx?=
 =?utf-8?B?YzJyM3JOQkFuUDQwZlpjNExXUnZEMHB1dWo2U2J4dU1ScWtiZTZ2MmlWS1NU?=
 =?utf-8?B?NHpDc21GQk8vcnIzVk16N0N5Z1RyNXByd0p2OGY0MW1XV0NWQ0RUZjd5enZK?=
 =?utf-8?B?bTVrMmNlckxtcnBoS2xqMVlYU01LeWNRSHpyUmwreUZGaG8zd2V5S09TN3Mv?=
 =?utf-8?B?a2VXb0gzK0ZqYzVzNURTV3RNY0ZXdzlkY1BTYXA1cW93bXJvclRsR3dQcHRJ?=
 =?utf-8?B?RUQxWGRxU0s1aFlzTG5yWDQxbzF0c1pmSGJwR1o2QlBhRmlyZFMwaUZSNW1W?=
 =?utf-8?B?ZVd6UHdEdDRVNU90VVF4OGNXbitFQUk5aU9hRDdyUTQ2WnVyOHo3d0U0a3U2?=
 =?utf-8?B?N3JocEZkcng3aTJVWjZxa2lyM3ZxYkZNdGZBdGx5bjlrUUdMWVduQU8vTTZH?=
 =?utf-8?B?UDNYT3MzTkQ2UCtVbjBDZ0dlQnBmWXhPVnhCL3daeUx5L25sd2FoVm01YVFM?=
 =?utf-8?B?Z1kzNlkyWWo1UWlxbHRqT3VIRU56Wi80ZzZQenFCeVdFV0pxWnF0b28vbUtl?=
 =?utf-8?B?c1BnOFZMN2s5elk5d3BIR0RYajJ5dUJ4QTMvYmg4RTVwdDJ4VjhaWUlTMFBm?=
 =?utf-8?B?bjFVZTdvbW1qdEd5QTIycFVZbWQ4bnpid3lBMlcyNTJyd0o0TmJLODZpdVpx?=
 =?utf-8?Q?yAjWSxQkDu+qmEo2ww=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4722e957-1fcf-4f79-7491-08d90913d63d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2021 00:31:45.2657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G6zp7XfIG4/Hqkx+JCl6FdV8157w342l7A7/nqq5EWUPQ61VJanQDJeqQ8hVCN0ZGDKY2R55vfyKHTlljF5vuiupsDRyT9c4A4wN/ky3uJQ0h5mC1ZL+YcGYXkDOiApE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3311
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
X-Gm-Message-State: mW3rOEsGohMTZwEtgipoGL38x4520388AA=
Content-Type: multipart/mixed; boundary="hIfE6RX85xKO1U6AeCV4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1619483518;
 bh=PrqZIgFzK7kqSWvzteCPP7i2uPJz2gRsQgW06v1/NCc=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=s9IVEL83aiNm16FcuVeCl2xzCHqF8E3XiWrJckxI89nX52FEcKvFNEBuy6STQVbapy+
 Z5Rfn8VMEvDbZOYWuwhdEa+uXRN4VaexOvXPDYtL8MFXyZmkrrMn91tO2FdIT7sftsagH
 5qqcrMTM0uXuaqhgdBOeBlqgb9UlA9WCed8=

--hIfE6RX85xKO1U6AeCV4
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogY2lwLWRldkBsaXN0
cy5jaXAtcHJvamVjdC5vcmcgW21haWx0bzpjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZ10g
T24gQmVoYWxmIE9mIEphbiBLaXN6a2ENCj4gU2VudDogTW9uZGF5LCBBcHJpbCAyNiwgMjAyMSAx
MDowOSBQTQ0KPiBUbzogbWFzYXNoaS5rdWRvQGN5YmVydHJ1c3QuY28uanA7IG1pbm1pbkBwbGF0
aG9tZS5jby5qcDsgY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcNCj4gU3ViamVjdDogUmU6
IFtjaXAtZGV2XSBbSW5xdWlyeSBmb3IgQ1ZFLTIwMjEtMjMxMzNdIC0tIG5lY2Vzc2l0eSBvZiB0
aGUgYmFja3BvcnRpbmcNCj4gDQo+IE9uIDI2LjA0LjIxIDA3OjQ5LCBtYXNhc2hpLmt1ZG9AY3li
ZXJ0cnVzdC5jby5qcCB3cm90ZToNCj4gPiBIaSwgSmFuLXNhbiwgTWluZGEtc2FuLA0KPiA+DQo+
ID4gaHR0cHM6Ly9saXN0cy5jaXAtcHJvamVjdC5vcmcvZy9jaXAtZGV2L21lc3NhZ2UvNjM4Mg0K
PiA+IEFzIHdhcyByZXBvcnRlZCBieSBDaGVuLVl1IHNhbiBsYXN0IHdlZWssIHRoZSBmb2xsb3dp
bmcgQ1ZFIHNlY3VyaXR5IHBhdGNoIGlzIG5vdCB5ZXQgYmFja3BvcnRlZCB0byBrZXJuZWxzIGJl
Zm9yZQ0KPiA1LjQuDQo+ID4gCUNWRS0yMDIxLTIzMTMzIFtuZXQvc2N0cDogcmFjZSBpbiBzY3Rw
X2Rlc3Ryb3lfc29ja10NCj4gPg0KPiA+IEF0IHRoaXMgbW9tZW50LCBzY3RwIGlzIGVuYWJsZWQg
b24gUGxhdEhvbWUgYm9hcmRzIGFuZCBTaWVtZW5zIGJvYXJkcy4NCj4gPiBXZSB3b25kZXIgd2hl
dGhlciBzY3RwIGlzIHJlYWxseSB1c2VkIG9yIG5vdC4gSWYgbm90IHVzZWQsIHdlIHdvdWxkIHJl
Y29tbWVuZCB0byBkaXNhYmxlIHNjdHAgZm9yIHRob3NlIGJvYXJkcywgYW5kDQo+IHdlIHdvbid0
IHdvcmsgb24gYmFja3BvcnRpbmcgdGhpcyBwYXRjaC4uDQo+ID4NCj4gPiBXZSBhcmUgbG9va2lu
ZyBmb3J3YXJkIHRvIGhlYXJpbmcgYmFjayBmcm9tIHlvdS4NCj4gPg0KPiANCj4gSSBjYW4gdHJ5
IHRvIGxpc3RlbiBhcm91bmQsIGJ1dCBJIHNlZSB3YXkgbW9yZSB1c2VycyAoYmFzZWQgb24gY29u
ZmlncykgdGhhbiB1czoNCj4gDQo+IGh0dHBzOi8vZ2l0bGFiLmNvbS9zZWFyY2g/dXRmOD0lRTIl
OUMlOTMmc2VhcmNoPUNPTkZJR19JUF9TQ1RQJmdyb3VwX2lkPTI3NDg4MTQmcHJvamVjdF9pZD02
MDUyNzk4JnNjb3BlPSZzZWFyY2hfDQo+IGNvZGU9dHJ1ZSZzbmlwcGV0cz1mYWxzZSZyZXBvc2l0
b3J5X3JlZj1tYXN0ZXImbmF2X3NvdXJjZT1uYXZiYXINCj4gDQo+IEluIHRoYXQgbGlnaHQsIGEg
YmFja3BvcnQgbWlnaHQgYmUgcmVxdWlyZWQuDQoNClRoaXMgQ1ZFIHBhdGNoIGhhcyBhbHJlYWR5
IGJlZW4gYmFja3BvcnRlZCBhbmQgd2lsbCBiZSBpbmNsdWRlZCBpZiB0aGVyZSBhcmUgbm8gaXNz
dWVzLg0KDQogNC4xOS4xODktcmMxOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9zdGFibGUvMjAy
MTA0MjYwNzI4MjAuNjIxNTgwMjIzQGxpbnV4Zm91bmRhdGlvbi5vcmcvDQogNC40LjI2OC1yYzE6
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3N0YWJsZS8yMDIxMDQyNjA3MjgxNi42MzEyMDE5ODhA
bGludXhmb3VuZGF0aW9uLm9yZy8NCg0KQW5kIDUuMTAueSBoYXMgYmVlbiBmaXhlZCBpbiA1LjEw
LjMyLg0KDQo+IA0KPiBKYW4NCg0KQmVzdCByZWdhcmRzLA0KICBOb2J1aGlybw0K

--hIfE6RX85xKO1U6AeCV4
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6397): https://lists.cip-project.org/g/cip-dev/message=
/6397
Mute This Topic: https://lists.cip-project.org/mt/82371605/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--hIfE6RX85xKO1U6AeCV4--
