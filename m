Return-Path: <SRS0=ugZg=HH=lists.cip-project.org=bounce+64572+6165+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3FBC433E0
	for <cip-dev@archiver.kernel.org>; Fri,  5 Feb 2021 02:41:41 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DF3064FA7
	for <cip-dev@archiver.kernel.org>; Fri,  5 Feb 2021 02:41:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DF3064FA7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6165+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id xFLXYY4521723xdz3WrTPjcF; Thu, 04 Feb 2021 18:41:40 -0800
X-Received: from ss11.sbt-mailgate.jp (ss11.sbt-mailgate.jp [202.241.206.54])
 by mx.groups.io with SMTP id smtpd.web12.2950.1612492897701829096
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Feb 2021 18:41:39 -0800
X-Received: from mail.sbt-mailgate.jp (sagproxy-out12.sbt-mailgate.jp [10.16.47.42]) (envelope sender: <masashi.kudo@cybertrust.co.jp>)
	(not using TLS) by ss11.sbt-mailgate.jp (Active!gate) with ESMTP id FLkc14024A;
	Fri,  5 Feb 2021 11:36:28 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jHF6Mv58ghQvL/jvMV/U2yV7EB6hC93ISSFmHJn+ZBXL0ntUSpjKIH8gov++YdZoamNxlIkqJCkHmhtkaUCJspVqTkMMFFlNmgEQu+QCFNMFNthuqeAOF+SLYUyd85hGxvT46GHaNfBwnfJRq9WgrGlmC4TA5UkyipePXFIK1LqFXem9Gn0jR4L5HoxXss/TpE1BMAKfkRE7vYX+rUWrXrailN/WL9LrFWK7OJsqSrLUumkZk0AWEFtLXe9tRxxaNY7OQAR1JWUqfFJneu2AYBeaDBUdn49mfAfwkWdUrBBDaiEUb9JRwA5e4ImoJqPu48+Y26Q+McUzwq3XYRWZWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EIZl0sifvMM3UdsA9HoW3K1AcjrXg5Ul+vinBTBwfB0=;
 b=hb04F8rerGDJ4l5+WeOG2JN9XE83xYeinyeDI7PeoN9HntBsl+1WW/gkWTxi/LL6xDL7hOXJ+ZMCmIOBQuRCz5Qr2f1iGAZcUFhCnQp2dD+ZYknpcx7u26zS2p1GqlJ6HsyF9bbEc43KF7Cq2mMS4gZtcNA/yZaPsWyVEZiXIW4KFZSv6xQ3+/Kn6p8NCCjql9muC+FlFy6eJjmDu8TueKcbXrYENCOd94UjvYEapI+C85GJuX4jzipat6Os8786yU047JUSf2FQER28ALJA1AGc3nxCShpdxbep0dUKbLfUsqg9dqU1z/o1+bvEX7+zU7s1bfaueryMnUSz1CPrdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TYCPR01MB5936.jpnprd01.prod.outlook.com (2603:1096:400:42::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20; Fri, 5 Feb
 2021 02:36:13 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::fc16:7286:28cc:8325]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::fc16:7286:28cc:8325%7]) with mapi id 15.20.3825.023; Fri, 5 Feb 2021
 02:36:13 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <wens@csie.org>, <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: [cip-dev] Cip-kernel-sec Updates for Week of 2021-02-04
Thread-Topic: Cip-kernel-sec Updates for Week of 2021-02-04
Thread-Index: AQHW+rZW2vBerAK1Ok6vN5wjagqyLqpI2OkAgAAA2KA=
Date: Fri,  5 Feb 2021 11:41:32 +0900
Message-ID: 
 <TY2PR01MB497210E5602271A5233C0608A0B29@TY2PR01MB4972.jpnprd01.prod.outlook.com>
References: 
 <CAGb2v664ebkxydSr3f8hHUUFx0t=FyGDpyJjhgwtdNe0OBaL3w@mail.gmail.com>
 <CAGb2v641Q0KowVBJ_srZRdLMXjXi9OaAi43-nGSs9eeOHYqj3A@mail.gmail.com>
In-Reply-To: 
 <CAGb2v641Q0KowVBJ_srZRdLMXjXi9OaAi43-nGSs9eeOHYqj3A@mail.gmail.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6faa7e8a-92cb-4d8e-1e60-08d8c97ecdf3
x-ms-traffictypediagnostic: TYCPR01MB5936:
x-microsoft-antispam-prvs: 
 <TYCPR01MB59362A5021113C8FEE3B6B71A0B29@TYCPR01MB5936.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 4m1XmNnQxvgD6+MNHcUg6z0VBFnqJhX8a3Hyqo5ghzNXVqlIXAavJ++/yjHco7U6s/RpuDlxt+PBKvsqdrdlD4McXbou6RumeyRch+s/w03HzDEM6kDb9hMY7IsUSHPqtO9Yc1RzMHaGWacmZ/gThYFKvoQgWBLj8QmoGm5oPJDXi61sBBUY5JCrBgkSsPDLKxSo9nw/N3fMGPWnYJFVqicrIGbHANCQjHR14vWxCyshgiH/6Q/wpZITwOzSygZrJ3pKecyh9U7Yoej1o9JGe3Od3V0J9BorlymHMN3etZ3D7dbTDlOOrDVUElJB6VluGSFlI4zOoL0CrFo6q4vRZxbLH8MpO6qK85UWfpbOqdMkCmasnnK3xNBQdATSFgGr0f6Dada4Yem5XybNg4A+yyMF5mWQ0lCHuvsayhV70qK8kV8765Yh9yVbMmUjbZrLv/9WZFgj2dDKA/ULNnR0B8lf98h1jQa9Ov6630wh3TTKzg4erd1aHyalZXenvv6l4PmNOMw+OmYM7AH8WarJuo+lL+VDKjJHEVy2k9TfjKm2fP16Zt3uAcEDut+6HF1sSGbw8F9yNJGUC8sKph2fVglDtL/n4HxJdjGveO5lZtY=
x-ms-exchange-antispam-messagedata: 
 =?utf-8?B?SUlmMzFZb0pMODlZRWMyczNZeUFSRmc2NWRwUU5hMnNtWG5COVBMVWhsVlVN?=
 =?utf-8?B?Q1g2OHJTNVdHd203cWJoeEZPTkRDcDhvUHpyQ0NZVDBpT2pvK2lCR3pTUHVH?=
 =?utf-8?B?TmxISHdEaUFaUmk0d2tzb0xOck5iejlVa1JHNm1BMjlFSFRwdnpUNzczYVFy?=
 =?utf-8?B?UHJzVlZxd1VFdDNoci9paTdKY0pqeThoR3lCNjA0V1BnaE4xbFZVU255OXVS?=
 =?utf-8?B?K2lMaGhyRmhQKytvTWlpdTlQMlk5aEszRFc2YkRhRU5uTXVyKzgrTnplUHZ0?=
 =?utf-8?B?NlVucENWTGt1YUtNRitmb0d1RURJQUkzd2Y3eWt0cUp6bDNYbERFOHFkUTBD?=
 =?utf-8?B?YVBrcGJVTXp0cHE0MlA0Z3BNeUpXZVg3WGl2OE1xWHRURVl1aUZPbm5SdlhG?=
 =?utf-8?B?ZDJ4Y3lweEM3REJYVDJWOUwzUE9za24rZkovWGZqVG9tNkcvUm5JVW1LT0xB?=
 =?utf-8?B?WFdNLzU2eHcreW0veFJxRDFQaXhnY3M1c1E4YWRPdEdZbVUxa0w3KzhHM282?=
 =?utf-8?B?eFFLdFN2WmRaekF2RitmQTFhQzBzTVQzNE52VFJnNjZDOGxaWTZWdFNMbkt0?=
 =?utf-8?B?ajdPK1hXaGpwRVh3emtpUVAxNUs1bldyb2FEeVE5Y25QYmk4ajVYSkxzZGM3?=
 =?utf-8?B?MUFvY0diSDBLa2ZBWFhtZWhYc0dGZFBQLzVxcS9hKzN2eVJyUGljejA5Vnk4?=
 =?utf-8?B?UzJvMDkzU2lWU0VQenBPckRSQTEvMStIZVNWRTk2Vmg5L01HUi9BTTgwMVo3?=
 =?utf-8?B?WjY0ZzdrUVJveWFuQXZ3Nkg1UCtnV25Mdi9GL3hyT3dxVVgrdUlWODFCeHho?=
 =?utf-8?B?WWpMeFR3cCtGL2YvclRPSVpra2d0V3VhOFl1SkRZcVhYTzVEcXNSR1h5TDVO?=
 =?utf-8?B?bzVVd1hUVWYxNVNRUkJKK3FkZU1lSEpBOC9zOUJITmYrSXhIT3hkWW1zSjhn?=
 =?utf-8?B?dmFlTUxoenRQbDFEVVJQTDJQK1dkYnRWeWYyTE9IREpIRVdidVVLMnduZG9R?=
 =?utf-8?B?eFBCYmJ0NU0zcHZsb1R6TWdqQmhtMmhVYjFrRXplRWVGdXRSb2x2VVNvdjhF?=
 =?utf-8?B?OWVrWDdPcEVuTXdVeGRYZjU4QndFTytqUXFIckZBcm5sUjN2RGh4Q1lodnZV?=
 =?utf-8?B?K2JzSGpvMWJmNk15c2xRaER3eGRpT25qVWZTamQvN0ZPb0dYLzRtZkpZM2dI?=
 =?utf-8?B?U0tLMlRpVE1OZkhqQ25yaDNJVTRXbVlsZUhoUXJJREZ4NDlaRU9pcTRZMkJJ?=
 =?utf-8?B?Z2w4b2VjZXRtMFAwNjMrQmtndDNRbGNHb1ZnOUJWNkxhRmdmSEVSaGErZVpk?=
 =?utf-8?B?cmVSeUNIUU9PdUx4Y1FKd3JmS2M2NzJndWxIN0VaT2xxOVNBdXJnZzRmNzdD?=
 =?utf-8?B?cXV1WERza0s0YWJYNkRJOHBWN0gwc3p1bmxKYXkyRVM5eU5SU2lWRW16UDZH?=
 =?utf-8?B?MENJMTM1L0FuQ2FJR1lQT1VvNkcrR1R4NGxocmIzVHlNbjZLcE0vZnkwQVVT?=
 =?utf-8?B?ZlZNNmNMTFBWMVRheS9BUE9zam5NcWZ2VEtBMEJ1ZjNTMFl2YlNqa0RpOGNQ?=
 =?utf-8?B?Y3RiaE5HVk5Nc0FIZ2lVRGMwKzVnZjRaT25xcVVQNW1hUXRySjNKVGRNMDlt?=
 =?utf-8?B?b29pOHgyRWtsbHhaWS81K1NMVVZuWldacUhYcktiMkN5Sk0yYnVSak1FU1l0?=
 =?utf-8?B?ZFlEZVkvOFozTEQzUDhmWWJVWUY1OVRwY3Nid01LWHFWdmt0YzRJazN6Szl6?=
 =?utf-8?Q?mSTsadzEM4TIrhSLUj6F7ugAUMqz6ucWTIoCj94?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6faa7e8a-92cb-4d8e-1e60-08d8c97ecdf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2021 02:36:13.0060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e1XdI4CneqPciY76EW2S85eySbmUCPL09bu6pK8mbK4a0Bx+H+NUl1dyIH3ueXQcEYbKTknNHlfJX+z2+mDiY53JaItdw1irKazicEB7VWU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5936
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: uJJFB3KeZ3R4EkV9G60iNwhdx4520388AA=
Content-Type: multipart/mixed; boundary="1Y7wwAiG0HkFKRY3Onjs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1612492900;
 bh=ErQEAOVRqZdIqegTjCvqP9kRl2v4ZiHI3csTY9lJdnI=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=ddJSOrdumx+cnTbswCpmFiN9GnIwLwNIoTZgIozwkbzCpclcr/+0lT/np3i/c9/S2bN
 /TV1Wy7Y/h8r97xxwLpIvZjL1CWI2QFNrVpEuqnZupoEBNp5vVnh7r/gbkJyyKcF13QCR
 0YtXqq/tPv9s+B+tUVgkVLEPC6HlJDJTet0=

--1Y7wwAiG0HkFKRY3Onjs
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksIENoZW4tWXUgc2FuLA0KDQpUaGFua3MgZm9yIHJlcG9ydGluZyB0aGlzIQ0KDQpCZXN0IHJl
Z2FyZHMsDQotLQ0KTS4gS3Vkbw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZy
b206IENoZW4tWXUgVHNhaSA8d2Vuc0Bjc2llLm9yZz4NCj4gU2VudDogRnJpZGF5LCBGZWJydWFy
eSA1LCAyMDIxIDExOjMzIEFNDQo+IFRvOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0K
PiBDYzogUGF2ZWwgTWFjaGVrIDxwYXZlbEBkZW54LmRlPjsgTm9idWhpcm8gSXdhbWF0c3UNCj4g
PG5vYnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpwPjsg5bel6Jek44CA6ZuF5Y+477yIQ1RK
44CAT1NT5LqL5qWt5o6o6YCy5a6k77yJDQo+IDxtYXNhc2hpLmt1ZG9AY3liZXJ0cnVzdC5jby5q
cD4NCj4gU3ViamVjdDogUmU6IENpcC1rZXJuZWwtc2VjIFVwZGF0ZXMgZm9yIFdlZWsgb2YgMjAy
MS0wMi0wNA0KPiANCj4gT24gVGh1LCBGZWIgNCwgMjAyMSBhdCAxOjI2IFBNIENoZW4tWXUgVHNh
aSA8d2Vuc0Bjc2llLm9yZz4gd3JvdGU6DQo+ID4NCj4gPiBIaSBldmVyeW9uZSwNCj4gPg0KPiA+
IFR3byBuZXcgaXNzdWUgdGhpcyB3ZWVrOg0KPiA+IC0gQ1ZFLTIwMjEtMzM0NyBbVUFGIGluIGZ1
dGV4XTogZml4ZWQgZm9yIDQuMTQgYW5kIGxhdGVyIFsxXQ0KPiA+IC0gQ1ZFLTIwMjEtMzM0OCBb
bmJkOiBVQUYgd2hlbiBhZGRpbmcgY29ubmVjdGlvbnMgd2hpbGUgb3BlcmF0aW9ucyBhcmUNCj4g
PiBydW5uaW5nXTogZml4ZWQgaW4gYWxsIGtlcm5lbHMNCj4gPg0KPiA+IEZvciBDVkUtMjAyMS0z
MzQ3LCBiYXNlZCBvbiBbMV0sIG1vcmUgcGF0Y2hlcyBhcmUgbmVlZGVkIGZvciA0LjQgYW5kIDQu
OS4NCj4gPiBUaGUgc2Vjb25kIGJhdGNoOg0KPiA+DQo+ID4NCj4gMTJiYjNmN2YxYjAzZDU5MTNi
M2Y5ZDQyMzZhNDg4YWE3Nzc0ZGZlOS4uMzRiMWExY2UxNDU4ZjUwZWYyN2M1NGUyOGViDQo+IDkN
Cj4gPiBiMTk0NzAxMjkwN2ENCj4gPiBpbmNsdXNpdmUNCj4gPg0KPiA+IGhhcyBub3QgYmVlbiBp
bmNsdWRlZCB5ZXQuIExlZSBKb25lcyBzZWVtcyB0byBiZSBoYW5kbGluZyBpdCBbMl0uDQo+IA0K
PiBGVFIsIGEgc2Vjb25kIGJhY2twb3J0IHNlcmllcyBmb3IgNC40IHdhcyBhbHNvIHBvc3RlZDoN
Cj4gDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3N0YWJsZS8yMDIxMDIwNDE3MjkwMy4yODYw
OTgxLTEtbGVlLmpvbmVzQGxpbmFyby5vcmcNCj4gLw0KPiANCj4gDQo+IENoZW5ZdQ0KPiANCj4g
PiBGb3IgQ1ZFLTIwMjAtMjc4MjUgZnJvbSB0d28gd2Vla3MgYWdvLCB0aGUgZml4IGhhcyBiZWVu
IGJhY2twb3J0ZWQgdG8NCj4gPiBhbGwgc3RhYmxlIGtlcm5lbHMuDQo+ID4NCj4gPiBGb3IgQ1ZF
LTIwMjAtMTYxMjAsIFVidW50dSBtZW50aW9ucyBhIHJlZ3Jlc3Npb24gZHVlIHRvIHRoZSBiYWNr
cG9ydGVkIGZpeA0KPiBbM10uDQo+ID4gV2UgcHJvYmFibHkgZG9uJ3QgY2FyZSBlaXRoZXIgd2F5
IHNpbmNlIHRoaXMgcmVxdWlyZXMgdW5wcml2aWxlZ2VkDQo+ID4gdXNlciBuYW1lc3BhY2UgaXMg
ZW5hYmxlZC4NCj4gPg0KPiA+DQo+ID4gUmVnYXJkcw0KPiA+IENoZW5ZdQ0KPiA+DQo+ID4gWzFd
DQo+ID4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvc3Rh
YmxlL3N0YWJsZS1xdWV1ZS5naQ0KPiA+IHQvdHJlZS9wZW5kaW5nL2Z1dGV4X2lzc3Vlcy50eHQg
WzJdDQo+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvc3RhYmxlLzIwMjEwMjAzMTM0NTM5LjI1
ODM5NDMtMS1sZWUuam9uZXNAbGluYQ0KPiA+IHJvLm9yZy8gWzJdDQo+ID4gaHR0cHM6Ly9idWdz
LmxhdW5jaHBhZC5uZXQvdWJ1bnR1Lytzb3VyY2UvbGludXgvK2J1Zy8xOTAwMTQxDQo=

--1Y7wwAiG0HkFKRY3Onjs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6165): https://lists.cip-project.org/g/cip-dev/message=
/6165
Mute This Topic: https://lists.cip-project.org/mt/80374042/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--1Y7wwAiG0HkFKRY3Onjs--
