Return-Path: <SRS0=Wir0=H3=lists.cip-project.org=bounce+64572+6198+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC367C433E6
	for <cip-dev@archiver.kernel.org>; Thu, 25 Feb 2021 08:59:07 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0076A64EDB
	for <cip-dev@archiver.kernel.org>; Thu, 25 Feb 2021 08:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0076A64EDB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6198+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id gcyYYY4521723xHqEiAKozYb; Thu, 25 Feb 2021 00:59:06 -0800
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web09.8851.1614243544130071196
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Feb 2021 00:59:05 -0800
X-Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 11P8wtiL019739; Thu, 25 Feb 2021 17:58:55 +0900
X-Iguazu-Qid: 2wGr679RaexE4H9oGI
X-Iguazu-QSIG: v=2; s=0; t=1614243535; q=2wGr679RaexE4H9oGI; m=rqjqNIHkJcNtzihqi3C7lQAZAmJZxcEELq6hnhIUUDg=
X-Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1113) id 11P8wsOt004061
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 25 Feb 2021 17:58:54 +0900
X-Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id ED0421000D0;
	Thu, 25 Feb 2021 17:58:53 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 11P8wrcb021465;
	Thu, 25 Feb 2021 17:58:53 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QqFQl5TcMbDxmXqantqT74RR+CCSypewDAn9TBaSKxbQ+4z2H+2AJHzi+RqlK2ES6awXbjV1fFbssjnyGyiE3dqQMV8z/4oWobbwJiiIcl2njy61pMn9wZq+r8i0rebPefwDm4lUL4vTjYeKCeelN6Wq4x8bq3Kkjxn+SsdSMlgx0VKVxp3RZhL6aduI5T1SFxctbl5RHn15ByqVYdfP3AceSxY3xFi4a/lXNl4DaVNdTFPY7BFfYQ7QM1WSQs7GJC+uRXPknGhLTcDieo+Q6ZjtSd4V038eP4sX1lxS5MSyHJX9NwnZC1Aul1pq61JPLdT3zByInIP4ynkXy7ayoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IhtfIhkSDWK9P95kzmm+kUcsUYdQRyUq0xzWgcHnBV4=;
 b=cIejI6YSCUgET18SBOI+fJkdm4hozvkklJXft/QvzrWUwHuEEUtVsh0AA16xe4fuymeJ9at3NDFA0Y58/9wFhtZRZt8OA/SoOtlWIAeaBwPDXQbnmLF5BkOeOEu87nJ4NpIKBN/0PT/H9Bw1S/IHr0QRVSj2GmbNTSdUUugxEFHAoPCZpAJ6Yb/fClGTogza8slvHZkXyLUmp/PY+Z48J5m1WyUA6/6j+6+Im54Pstzmq2+xltXJSqscrfmLkCPvAuEfo0V2HbH6pWWIdYDwhqtoAq0Hb3osdf5GFHc2sfOK0HCNyjL03N+KBK5AB474a7JaML7B4Nq5WrgDZqjpLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>, <pavel@denx.de>
CC: <jan.kiszka@siemens.com>, <henning.schild@siemens.com>
Subject: Re: [cip-dev][cip-kernel-config][PATCH v2 1/2] 4.19.y-cip: Remove XEN guest support for siemens_ipc227e
Thread-Topic: [cip-dev][cip-kernel-config][PATCH v2 1/2] 4.19.y-cip: Remove
 XEN guest support for siemens_ipc227e
Thread-Index: AQHXCqukNiXQVDmcVUO9YI/36nWoWKpokwOQ
Date: Thu, 25 Feb 2021 08:58:41 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2983AC2FC883BA5A10D03349929E9@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <20210218183455.GA22234@duo.ucw.cz>
 <20210224124958.75586-1-florian.bezdeka@siemens.com>
In-Reply-To: <20210224124958.75586-1-florian.bezdeka@siemens.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb5f4116-29e8-45b2-4c33-08d8d96b8c5e
x-ms-traffictypediagnostic: OSAPR01MB3780:
x-microsoft-antispam-prvs: <OSAPR01MB37804AE13B87C2938BF8E428929E9@OSAPR01MB3780.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HmXUYYtPU25x5BYtT7h/6KVZ+lfxfx/3tzGyARdhAB7bXPAdiroKy8WN2kJwws1Jtn9SHXnAeHcWWeE38Z2h6x1vL/m2N4lbTAwSU6GdcSsK5ODzcrGwwLHEonrPotjIlnkpfat9bxQief2pOx9qMz3DPdaeVtSdm7xm1QTfyZDD1Zofnt4a3h0iacudIboIfiHxp69hmXEkLa+FTqVz22dQq4RVDjycGyQ8f0U0STiTFyoER0uUlEUhoYWooiox8Ps1yzRY3JazQEHAb7N8SKPHxbJGxmtZVCq9DLhZRZZKHvykNHlrqfPnASm2d1KHcPJf2L+DpUpwOlgDOBtk5xF6RtTqcHhu5Xh70KXstk4dI78uQOlJBf6wny9+SYoKfDnFht+hub/EPriW7nVnv4xJT+kwqUKxciBRiLmACGn64K14smXA6yJ2TfOIuh/rKg9egaCbM1H8ojRgkKprMzvAgC5ZegnRi4se/xPaRXD6UYnQBjKlbqLZpGn0H2ONXw0se6Cey7l9XfDLzJnP1A==
x-ms-exchange-antispam-messagedata: =?utf-8?B?S2k3YmIrbWc3czV0aVUxWWdyMWNxamZUbDFma0s3eHN5c1QxRmZudWRMcW9Q?=
 =?utf-8?B?bm82OUJmdzRLUDZ4OW8waVBJbldGc0kvUFJaMUlocjc2RG50WUU0Yk9OMG5N?=
 =?utf-8?B?R2JvZHAzdGEveElka0xuQzdkVzBWa0hXenBlNzZYM0RPZ0tqUlhDbjh4eFhQ?=
 =?utf-8?B?aVVLZUJYU2Z2QUdNRlF2OGJmMFhMS2U2T0dqdnlSNlFYZVdIbWVSR3BaMUQw?=
 =?utf-8?B?Vm5oejdsdjhDUG03UGx5QWNISmUvcVFqZmU0Y3Y2d3oyYlZqdkFhN3VTUzBh?=
 =?utf-8?B?T1lMWDAvNWF2UktHbC8xRUhXUUVCSmV3TEc4MnViWU5xK3lrN3ZRRE4xODND?=
 =?utf-8?B?R1dVOGZJZ0pERFZTYUpXRW5wRTlhRXlpYlpPMzliNXhSOVM0eGpVNDJpRE94?=
 =?utf-8?B?SHRkMk1jeTRCNFdzbE5Ed3RiUGRmSlNOTXZVazJ2QlhJbUVkLzFSTCtpTnJz?=
 =?utf-8?B?S2Zrd0krOXJtbGJvUlN6c1RRelIxMGRLY2lNNU5QeGZOcFg5RktCVnFCZzh5?=
 =?utf-8?B?aEJ6UDQ5SWQwZmM2SXI4ZEJ6WEZNa0V2QllxRzFOVXZYNkZNQjFzOWw1OFBS?=
 =?utf-8?B?TlpVK0NQdG1yN1hrdklXbWF4cEdoaFg5YmxVOFV2YXNsei9tSE5OYkExalRK?=
 =?utf-8?B?NWZ5ZEhBSFZ6S1FmUWp0bERLc1VsbjB3VklBUFY4ZHFqVEFWUEVNdzFTa016?=
 =?utf-8?B?SklobE9yVXFFR3M2b1NIcDBlVmp0dmdMcW1rQTV6WjR5cU9KRTVaNEF6LzlE?=
 =?utf-8?B?bjhlTVB2Q0NVT0hnd2JSTERNdXJmUk5yNE5HL0xnS0p5VHpKTmgvMkJrZ1BR?=
 =?utf-8?B?SnBGTkdOY1oxOUUzcWZFb3FqajVrZ2tyRkx6ZnBVM0xZK0FrWTJCUjlNc0Mv?=
 =?utf-8?B?d1JXb2lzcmFoWXZ2RzJiLzArQ2Z0T1ZnelR0V2dyTzlET0FEcURScW9BVXhq?=
 =?utf-8?B?SWZmU0gyMi8xeHhXSU45ay9US1poUzBQQmppQTJEMmRTMlp4WnBNcnE4Zm8r?=
 =?utf-8?B?RTJqOU5hUTdiaSs4ODYvcVdyTHBTWTdDU1lPUlJ1RVoxblBOa1FnSXBQVEIz?=
 =?utf-8?B?bXJpYTJLNEJ0dHdodjd2MWhvUWJJYksrMlcveWxaS1hvWVVtQmZsK2h6RnlR?=
 =?utf-8?B?VitTaWR4Vm1mVFJiTThaN0pTcS9GaUJMWFg5WDArcVFnS3VxcnVuRFJ5WUh5?=
 =?utf-8?B?cVcxV3dCQUZRMjhXOHNtRURTemEwbks0ci93WkRkZSt2ay9CSGMzb3hJRUVx?=
 =?utf-8?B?K1BoSDVwa2l2K0wyVlNWL29RT0FoRTg2aXlON3pDRGdLQy9tcHhvNDhFaWpF?=
 =?utf-8?B?SWwrYWNvL2dObDhlVkJDZGhabHhHazlTY3dxWmI1L3pXSkxQS0hKV2RYY1pO?=
 =?utf-8?B?ejNCbGdFZW9JaGpzb3JzbUh3UGpUeDVlSllkNmJlcThnNzB6MzVCVDd1U1FB?=
 =?utf-8?B?bHlSZWx2YTl1MzBwRkgveG1uR21EVnhvUk8vQ3JqLzh4N2RjQ0Zyc1N2dXpy?=
 =?utf-8?B?MGkyMUFCWUFBVklDcmRzRnQyQTljSTNrdzVyQlFzOG8rMStmRGt2ekx2Z2NX?=
 =?utf-8?B?QXBheVBzMFZTVThnaHh2SUpRVm9VU3JMcDZJR0dNdUtEZU9rZTh5MXp5UVlu?=
 =?utf-8?B?UTdUSlZaM3hKMXRMd3Rza3MyVUtHOWlVNjBaUzFxcjNCUFMwOFZ6WEtLd2pL?=
 =?utf-8?B?ajVkUDZ3VldXNkZCNDNtdVRNdTA2TDZFRWUzRDRNbTROc0IrN1RIekd3MTk2?=
 =?utf-8?Q?ibi2wBl6na67Vwdri0=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb5f4116-29e8-45b2-4c33-08d8d96b8c5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2021 08:58:41.1743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t+ffA5ZaUv5S3ToXp9eL1qiDjtIs/x6EVSXMsPtw1Scf5P6JcKxIng+T6lo7Q6BYkf18oXud0w8JeddU8rQ6SkKAqZciP+hJwhF66pM1Vhljz3sOpAiCBo+veRRPZ4ha
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3780
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 3FN4mX8HFbgZBy5m9zkWCChzx4520388AA=
Content-Type: multipart/mixed; boundary="S9cmwxnRmNYHPF3V3Uqv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1614243546;
 bh=6Fa9qTdCpYEEv+nKa9J9IOW8Hvk1rXgbLHbw0W/0oLQ=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=MYH0qk0ZETmcqpSwKUkiw71bppQCdICU0lpIKVAmM+gCCjFEM7Hel/d9Zd/Fkwwkdmk
 zG1I+0U1ahghSbNRh0m3UcUqihufbADk69O20UAn9jKjNzw19WuHs4LflhS4aa782WYVu
 CrQrMdx2mwESfX/LqKKoTHwi6VL5p5FmtKI=

--S9cmwxnRmNYHPF3V3Uqv
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgRmxvcmlhbiwNCg0KVGhhbmtzIGZvciB5b3VyIHBhdGNoLg0KSSBhcHBsaWVkIHRoaXMgcGF0
Y2ggc2VyaWVzLg0KDQpCZXN0IHJlZ2FyZHMsDQogIE5wYnVoaXJvDQoNCj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcgW21h
aWx0bzpjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZ10gT24gQmVoYWxmIE9mIGZsb3JpYW4u
YmV6ZGVrYUBzaWVtZW5zLmNvbQ0KPiBTZW50OiBXZWRuZXNkYXksIEZlYnJ1YXJ5IDI0LCAyMDIx
IDk6NTAgUE0NCj4gVG86IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnOyBwYXZlbEBkZW54
LmRlDQo+IENjOiBqYW4ua2lzemthQHNpZW1lbnMuY29tOyBoZW5uaW5nLnNjaGlsZEBzaWVtZW5z
LmNvbTsgZmxvcmlhbi5iZXpkZWthQHNpZW1lbnMuY29tDQo+IFN1YmplY3Q6IFtjaXAtZGV2XVtj
aXAta2VybmVsLWNvbmZpZ11bUEFUQ0ggdjIgMS8yXSA0LjE5LnktY2lwOiBSZW1vdmUgWEVOIGd1
ZXN0IHN1cHBvcnQgZm9yIHNpZW1lbnNfaXBjMjI3ZQ0KPiANCj4gRnJvbTogRmxvcmlhbiBCZXpk
ZWthIDxmbG9yaWFuLmJlemRla2FAc2llbWVucy5jb20+DQo+IA0KPiBSZW1vdmUgWEVOIGd1ZXN0
IHN1cHBvcnQgd2hpY2ggaXMgbm90IG5lZWRlZCBhbmQgaGVscHMgdG8ga2VlcA0KPiBtYWludGFu
YW5jZSBzaW1wbGUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBGbG9yaWFuIEJlemRla2EgPGZsb3Jp
YW4uYmV6ZGVrYUBzaWVtZW5zLmNvbT4NCj4gLS0tDQo+IA0KPiAgQ2hhbmdlcyBpbiB2MjoNCj4g
ICAtIHJlc2VuZCBkdWUgdG8gbG9jYWwgdG9vbGluZyBwcm9ibGVtDQo+IA0KPiANCj4gIDQuMTku
eS1jaXAveDg2L3NpZW1lbnNfaXBjMjI3ZV9kZWZjb25maWcgfCAxNSArLS0tLS0tLS0tLS0tLS0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMTQgZGVsZXRpb25zKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvNC4xOS55LWNpcC94ODYvc2llbWVuc19pcGMyMjdlX2RlZmNvbmZpZyBi
LzQuMTkueS1jaXAveDg2L3NpZW1lbnNfaXBjMjI3ZV9kZWZjb25maWcNCj4gaW5kZXggMjczZDIw
ZS4uNWQwNjlmMCAxMDA2NDQNCj4gLS0tIGEvNC4xOS55LWNpcC94ODYvc2llbWVuc19pcGMyMjdl
X2RlZmNvbmZpZw0KPiArKysgYi80LjE5LnktY2lwL3g4Ni9zaWVtZW5zX2lwYzIyN2VfZGVmY29u
ZmlnDQo+IEBAIC00Myw4ICs0Myw2IEBAIENPTkZJR19YODZfQU1EX1BMQVRGT1JNX0RFVklDRT15
DQo+ICBDT05GSUdfSFlQRVJWSVNPUl9HVUVTVD15DQo+ICBDT05GSUdfUEFSQVZJUlQ9eQ0KPiAg
Q09ORklHX1BBUkFWSVJUX1NQSU5MT0NLUz15DQo+IC1DT05GSUdfWEVOPXkNCj4gLUNPTkZJR19Y
RU5fUFZIPXkNCj4gIENPTkZJR19HQVJUX0lPTU1VPXkNCj4gIENPTkZJR19DQUxHQVJZX0lPTU1V
PXkNCj4gIENPTkZJR19OUl9DUFVTPTUxMg0KPiBAQCAtODYsNyArODQsNiBAQCBDT05GSUdfSU5U
RUxfSURMRT15DQo+ICBDT05GSUdfUENJRVBPUlRCVVM9eQ0KPiAgQ09ORklHX0hPVFBMVUdfUENJ
X1BDSUU9eQ0KPiAgQ09ORklHX1BDSV9SRUFMTE9DX0VOQUJMRV9BVVRPPXkNCj4gLSMgQ09ORklH
X1hFTl9QQ0lERVZfRlJPTlRFTkQgaXMgbm90IHNldA0KPiAgQ09ORklHX1BDSV9JT1Y9eQ0KPiAg
Q09ORklHX0hPVFBMVUdfUENJPXkNCj4gIENPTkZJR19IT1RQTFVHX1BDSV9BQ1BJPXkNCj4gQEAg
LTIxOCw3ICsyMTUsNiBAQCBDT05GSUdfREVWVE1QRlM9eQ0KPiAgQ09ORklHX0NPTk5FQ1RPUj15
DQo+ICAjIENPTkZJR19QTlBfREVCVUdfTUVTU0FHRVMgaXMgbm90IHNldA0KPiAgQ09ORklHX0JM
S19ERVZfTE9PUD1tDQo+IC0jIENPTkZJR19YRU5fQkxLREVWX0ZST05URU5EIGlzIG5vdCBzZXQN
Cj4gICMgQ09ORklHX1NDU0lfTVFfREVGQVVMVCBpcyBub3Qgc2V0DQo+ICAjIENPTkZJR19TQ1NJ
X1BST0NfRlMgaXMgbm90IHNldA0KPiAgQ09ORklHX0JMS19ERVZfU0Q9bQ0KPiBAQCAtMjU1LDcg
KzI1MSw2IEBAIENPTkZJR19GRERJPXkNCj4gIENPTkZJR19ISVBQST15DQo+ICAjIENPTkZJR19V
U0JfTkVUX0RSSVZFUlMgaXMgbm90IHNldA0KPiAgQ09ORklHX1dBTj15DQo+IC0jIENPTkZJR19Y
RU5fTkVUREVWX0ZST05URU5EIGlzIG5vdCBzZXQNCj4gIENPTkZJR19GVUpJVFNVX0VTPW0NCj4g
IENPTkZJR19JU0ROPXkNCj4gIENPTkZJR19JTlBVVF9NT1VTRURFVj15DQo+IEBAIC0zNTgsMTQg
KzM1Myw2IEBAIENPTkZJR19ETUFERVZJQ0VTPXkNCj4gIENPTkZJR19JTlRFTF9JT0FURE1BPW0N
Cj4gIENPTkZJR19BU1lOQ19UWF9ETUE9eQ0KPiAgQ09ORklHX1ZJUlRfRFJJVkVSUz15DQo+IC1D
T05GSUdfWEVOX0JBTExPT05fTUVNT1JZX0hPVFBMVUc9eQ0KPiAtIyBDT05GSUdfWEVOX0RFVl9F
VlRDSE4gaXMgbm90IHNldA0KPiAtIyBDT05GSUdfWEVORlMgaXMgbm90IHNldA0KPiAtIyBDT05G
SUdfWEVOX0dOVERFViBpcyBub3Qgc2V0DQo+IC0jIENPTkZJR19YRU5fR1JBTlRfREVWX0FMTE9D
IGlzIG5vdCBzZXQNCj4gLSMgQ09ORklHX1hFTl9QQ0lERVZfQkFDS0VORCBpcyBub3Qgc2V0DQo+
IC0jIENPTkZJR19YRU5fQUNQSV9QUk9DRVNTT1IgaXMgbm90IHNldA0KPiAtQ09ORklHX1hFTl9N
Q0VfTE9HPXkNCj4gIENPTkZJR19TVEFHSU5HPXkNCj4gIENPTkZJR19TVEFHSU5HX01FRElBPXkN
Cj4gIENPTkZJR19DSFJPTUVfUExBVEZPUk1TPXkNCj4gQEAgLTQwNCw4ICszOTEsOCBAQCBDT05G
SUdfTkZTRD15DQo+ICBDT05GSUdfTkZTRF9WM19BQ0w9eQ0KPiAgQ09ORklHX05GU0RfVjQ9eQ0K
PiAgQ09ORklHX05MU19ERUZBVUxUPSJ1dGY4Ig0KPiAtQ09ORklHX05MU19BU0NJST15DQo+ICBD
T05GSUdfTkxTX0NPREVQQUdFXzQzNz15DQo+ICtDT05GSUdfTkxTX0FTQ0lJPXkNCj4gIENPTkZJ
R19OTFNfSVNPODg1OV8xPXkNCj4gIENPTkZJR19OTFNfVVRGOD15DQo+ICBDT05GSUdfUEVSU0lT
VEVOVF9LRVlSSU5HUz15DQo+IC0tDQo+IDIuMjkuMg0K

--S9cmwxnRmNYHPF3V3Uqv
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6198): https://lists.cip-project.org/g/cip-dev/message=
/6198
Mute This Topic: https://lists.cip-project.org/mt/80875472/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--S9cmwxnRmNYHPF3V3Uqv--
