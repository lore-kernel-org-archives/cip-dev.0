Return-Path: <SRS0=DQmT=IN=lists.cip-project.org=bounce+64572+6280+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC8BC433E0
	for <cip-dev@archiver.kernel.org>; Mon, 15 Mar 2021 02:06:49 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F310A64E46
	for <cip-dev@archiver.kernel.org>; Mon, 15 Mar 2021 02:06:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F310A64E46
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6280+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id D3goYY4521723xb8ysigKZXJ; Sun, 14 Mar 2021 19:06:48 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web10.3343.1615774006221613762
 for <cip-dev@lists.cip-project.org>;
 Sun, 14 Mar 2021 19:06:47 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 12F26hui026881; Mon, 15 Mar 2021 11:06:43 +0900
X-Iguazu-Qid: 34truhM3DVTF8FOJtG
X-Iguazu-QSIG: v=2; s=0; t=1615774002; q=34truhM3DVTF8FOJtG; m=k6QNjZmSnt9vhaxnszzeiRPFilJRkYkvlGlWvckAXR0=
X-Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1511) id 12F26gs0003240
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 15 Mar 2021 11:06:42 +0900
X-Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id 44DFA1000AA;
	Mon, 15 Mar 2021 11:06:42 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 12F26fr3014701;
	Mon, 15 Mar 2021 11:06:42 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BTn000p/qV/eXbaJNUpvnJNzADJTF+kJlVa3bWhLnJNk/3ZAND4k82Vm3L8ZXlpilvbDMbo6bWbzaB6KTR3LmuqtmemXfPvu/yh3Wo9yUK0vVV1DWcfiZ7GeAjoOAC5Jp+FN7gi5J4ts2+CUcDYlTqkslO5ANSlbB61+VLoCLWRsnvLEVMCAqBEV7cpZ6SpYgO9FDIx+Sbz7DbWnLBMu/caKEfw5VRR5ByIqo/wlZG4V8AMq+d25edWqdglH/d2HA/f2ZkS26ZJ0s0s1awaON46c8yaDYSNkzrAlKqlcKwEnYL4HbeWbuRbbGCJw1MmcA5kkkU8dFSOVXu6dorexZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkmawoETp7QOBXnUB2n7gnTZQeFKkaBep1Up+O3eThE=;
 b=SCpT0TG7eFy2QJ6Susu9g1dxyloFem0vy7kda3N0qkJkWAOFOfMIakL+pkeC+LeV5eDWlDI4ujZpEHb+QMCdA2TqLU/qSZg/bgvhWTGSsq+VZVvU6aT2ooYuY1sZvZWyR+lejwJSdSCw/n4vnVVCIYj8ohMxKqo4NC1/8GLQ3wgKbUyOR0UKkTLm/tG36e8OStixWqc6O0uy/v/2VabAvHRO6cIikeMaDfcnRDMlZC77UCFuFaSSK6Cm22yrZWHSwKahopB8QS7bCqtkGCDHJvR09EUqz0eWIg0JbYsmmtGAuMeIwrcMI4OPrHb9MKMTh5nqxkHwhHDR+krutZJ0nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>, <Chris.Paterson2@renesas.com>
Subject: Re: [cip-dev] master branch at git.kernel.org/...cip
Thread-Topic: [cip-dev] master branch at git.kernel.org/...cip
Thread-Index: AQHXFnQWwbwCg37FIU2bqXXuE+BRnKqET+HA
Date: Mon, 15 Mar 2021 02:06:39 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB29837731DA0D7EA8C45D17F5926C9@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <20210311124248.GB32725@amd>
In-Reply-To: <20210311124248.GB32725@amd>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c57f63c2-6b06-410c-6b37-08d8e756f8b3
x-ms-traffictypediagnostic: OS3PR01MB6243:
x-microsoft-antispam-prvs: <OS3PR01MB624319BB40EC0DF1948C6B7F926C9@OS3PR01MB6243.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8K/l30gh1Fnaqwifuh4NU7j9YPjI0blzE+FWDdkrtr2JPmVd06oKjD6s3GTEODrVb2rkrU2+UWocQ4fgAaLxa7A1qZ03Q/u9Csw+oXknS/CN2ROjawqfKviVc8cQyyf0qKQbDo4Bt0+am9k6dyGCQpDryP0mt8qaSn92aMB1TQTo6XCHc+qBENMFT364vvOTt+BT3TvdcqcoKXvYXgkvo33UmZXEbsD3tDHYhdfUK0Uvd30gkjmtNt1qYMBxeFckVfPLpE4MmBuc3ibWHKMmLsi37FLe1IrCLZFrQ7TEw9JfXc9XtjzLu0HsFHg6FptDzq/LbTDhDiFy4DExX4PAncs7K2PaqHoUtt1IrHN3XlyRzJgioTSWH8uPm3nayczz+1v012OgYD7xJ0Bgy2Q5/8Glgupuk2rnPW7BPUlr+44w2aqimxz6pvAMzP9RoN+GwGRSJIv0CX60FARX2gMG/SInGoinkWeb2EGEgQr2+Wi3mdes36/VrEUYI5OAbVx9zqwbvpRx8a9LC6KRM6gIKNGh0/uxsY5QHj0FKCN+VccJGhy/bOMRy6Y6VD/aqT1droRNVgfRe4gZGyqw04F+rVBNMDKTnSm8A4+kNhXmczm5lIsnpsZuSTvngCLLbaW0ki3qZ3S5nlQpdUVJfdBOrQ==
x-ms-exchange-antispam-messagedata: =?utf-8?B?VHp2dnJlYjYrM1Jvb05GbHowZUFoNGY5MDhYdGhuZnZlbXNaa1Y0NEorYUNV?=
 =?utf-8?B?Q1JWOEgwWUUzOVNUU1BJb1RtSHE2bnVXQXhrcUYvWGs3T2FhdlVJVXZia0tN?=
 =?utf-8?B?Rk9EamdTZXVZeHVpU093RmxNTDhkc2FJNk9pU2RucjlMbmFIZm9iY29EWTdK?=
 =?utf-8?B?bzZHN0hnY0NkbE9obVc2RVV5d1pFdmUzMmtKdlBnYmFzTzFJbUpQS25DdFpX?=
 =?utf-8?B?QkYrTEFIVGE0YzBEbnZqOGhMZ3VRNVVKSnpScWZGd3Rnb2o5QVBCdzAvZ1Rq?=
 =?utf-8?B?M2RkanhUQnhxR29uNE5uZE5aa2hneVpUQmQ2cWsyV3NkZXBBZEw3OU8zU2d1?=
 =?utf-8?B?QzBIS2c1NnlVUmtkSDBLdGxCMkRZYklNcEtRalU4dzBzWUVWRko5RzNoZkMr?=
 =?utf-8?B?UUdMSHRHWEV2akRqamlNT3h4cWxTOTA3WlgrZFFHdWdmZDVDTEs1K1FBNlVw?=
 =?utf-8?B?cjY1NXRGL1kyZlFRZjlhbXZGbjBIT2JjZ0hXcGl2VFMvOWJ3TE1rbjlaT041?=
 =?utf-8?B?c1A5ckRyS01LWlQ2NkZ2L3Q3TGNZSzVZbG9iS0VSUG8rMEsybUFsVHdWR1VU?=
 =?utf-8?B?L2p5TGpHQkxKMUN3MS9yVUxmNkIxQVNNazhyV1ZkSDIraVZiUk9LNi9nMVky?=
 =?utf-8?B?cEN1a1dTd2l6UEN6TnZqb3dtRTE2bXRDSkFYdDFONEJjbGpKUGo0SFV6NW9n?=
 =?utf-8?B?ZUYyWFN3Qmg3M1JGNWRDVjd1MnpoK0xzSmNtM2xJTXp1YUJaNi8ybFQ0VG9G?=
 =?utf-8?B?Z3ZhTm9zb3RqalZXbmNqVjhEaW15cVRNWFNuWDN0a1VKbUUvU2duOUNhblZV?=
 =?utf-8?B?ejQ3L0V2V2QyWGQvT1FwajNLMjlvL1Q3K2Q2RkhtMm1BYitOa2hMOUFpa0dS?=
 =?utf-8?B?TmR3d0Z3NFFHWjlYOTdydGF0TkFXRmRYajMrZ0Y3dzV5ZzBHQ3VrejN3dmR2?=
 =?utf-8?B?Rm1wZFhFZEl1TVlZNnRTeTZCTURHbFY0Y3cyTE10N3hnbUFEVmpDeE9ub2RL?=
 =?utf-8?B?dk5FeTg2KzdxMWg4cTdGV1VUYWR0WmM2OFBQamE5U3g3YWMxTnkzNmI0ZVJ6?=
 =?utf-8?B?SEJuWGtiMG8vRmJkTndDQWZXSWxKdU0xYUZMQ2ZSTWFOTHNKd0JSNjBCVlZD?=
 =?utf-8?B?YVlaOW41S3ZYZVFFWDZoUUxwMG5qREhGa3lpTytvN0RKN1I2Y3JWZlYvVVhF?=
 =?utf-8?B?YUNYTUdpUW50SmRLbmJROWhmWVNnS3F1MHkyanIyUEVqVWtJZ2Y2TWhWWFpY?=
 =?utf-8?B?ZlhHRmpzVEpvSkJLNy9McUtVc1NDdWxKUUNzT2JBV2VrQjhUWDNJc2E1RkRv?=
 =?utf-8?B?M1FBYXZPUkNucXNpYVNWQ3l3cC90clc2cWNPMzJ3a0FDWnpVWHFLK3M5NHdZ?=
 =?utf-8?B?NGdaSFBwa2VHaTJRQXJ1emdweEZ2OUhOeWM2VEU3cmt4czdSSE5PdUNKOW9z?=
 =?utf-8?B?emI5a21KKzFtSjVlSVIzakRaN0J1QXBCWXl4akx0aStISDNyS1c2YjFQTnlN?=
 =?utf-8?B?dFlrbHpRRTVYaUdlOUV4Yml1c0hSR2Q2cUJnYm9SMkNkdzBpWDBteUM1UTNK?=
 =?utf-8?B?WDFaOXVoemV4NjcwUHkyQng5OTlsbnE0WXhTVlhMdmdqakdCMmc5VjZVNDFs?=
 =?utf-8?B?Nk1iY0ViU1kxRERLNFJYeGdJbDRFUEd0bDRJcEJrSTArNk1GZkNGR2c5WktB?=
 =?utf-8?B?dXUrdllBZDBKRG01UG9VelhkdCt1dHhpbEo3R1BrVW4vWEFXckdKMUNBMzV2?=
 =?utf-8?Q?COtU+zRMNyvmsmqCxw=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c57f63c2-6b06-410c-6b37-08d8e756f8b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2021 02:06:39.8177
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vcmBXgqNa5ADXJ8b/9R2SlLnF6YePHUCPvgduXSKhDy4pMiNumZV4HL9Od08LlDcsGMkmGG4PO/UZNzm7pR5MqWPWmEFujd8mUafworF5T70Mp1q0gkWTJdBjNHayaJU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6243
MSSCP.TransferMailToMossAgent: 103
X-OriginatorOrg: toshiba.co.jp
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: o5I7qhZZhBpTMZRc9LWyJkZjx4520388AA=
Content-Type: multipart/mixed; boundary="VDSVpkLGf1vJDVzHTZzl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1615774008;
 bh=LBKeYh2HQcS6nM6Li0/53Da9Y49ptvByc6iK82O57b0=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=qwwYWJpbuBtgdy4K0xFEK6sG18aUzlJBDCmSKREkJqwwJRW68KQJvY2prDpFKaOLUPt
 NfMXdferpSDj5Tj/8S+WcNqSHHB/EPQw2o/rO/HYmRtIR99kQbRLs3GxuZOsWyF8eIx2x
 2/ZC+q3sHF8O6+EQUK07OuarMbKvDXD5JZM=

--VDSVpkLGf1vJDVzHTZzl
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogY2lwLWRldkBsaXN0
cy5jaXAtcHJvamVjdC5vcmcgW21haWx0bzpjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZ10g
T24gQmVoYWxmIE9mIFBhdmVsIE1hY2hlaw0KPiBTZW50OiBUaHVyc2RheSwgTWFyY2ggMTEsIDIw
MjEgOTo0MyBQTQ0KPiBUbzogQ2hyaXMuUGF0ZXJzb24yQHJlbmVzYXMuY29tOyBjaXAtZGV2QGxp
c3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiBTdWJqZWN0OiBbY2lwLWRldl0gbWFzdGVyIGJyYW5jaCBh
dCBnaXQua2VybmVsLm9yZy8uLi5jaXANCj4gDQo+IEhpIQ0KPiANCj4gQ2hyaXMgcG9pbnRlZCBv
dXQgb3VyIG1hc3RlciBicmFuY2ggYXQgZ2l0Lmtlcm5lbC5vcmcgaXMgcmF0aGVyIG9sZDoNCj4g
DQo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2NpcC9s
aW51eC1jaXAuZ2l0L3JlZnMvaGVhZHMNCj4gDQo+IG1hc3RlcglDSVA6IEJ1bXAgdmVyc2lvbiBz
dWZmaXggdG8gLWNpcDI4IGFmdGVyIFJlbmVzYXMgcGF0Y2hlcyBCZW4gSHV0Y2hpbmdzCSAgMiB5
ZWFycw0KPiANCj4gDQo+IE1hc3RlciBicmFuY2ggaXMgcmVhbGx5IG5vdCB0b28gYXBwbGljYWJs
ZSBmb3Igb3VyIHdvcmtmbG93LiBZZXMsIDINCj4geWVhcnMgb2xkIHZlcnNpb24gb2YgNC40IGxv
b2tzIG91dCBvZiBwbGFjZS4NCj4gDQo+IEkgc2VlIHRoZXNlIG9wdGlvbnM6DQo+IA0KPiAxKSBs
ZWF2ZSBpdCBhbG9uZS4gKCspIEl0IGlzIHF1aXRlIG9idmlvdXMgZGV2ZWxvcG1lbnQgaXMgbm90
DQo+IGhhcHBlbmluZyB0aGVyZSAoLSkgSXQgbG9va3Mgc3RyYW5nZS4NCj4gDQo+IDIpIGRlbGV0
ZSBpdC4gKC0pIEknbSBub3Qgc3VyZSB0aGF0IGlzIHBvc3NpYmxlIG9yIHdoYXQgcHJvYmxlbXMg
aXQNCj4gbWlnaHQgY2F1c2UuDQo+IA0KPiAzKSB1cGRhdGUgaXQgdG8gTGludXMnIDUuMTItcmMx
IGFuZCBrZWVwIGl0IHVwZGF0ZWQuICgtKSBFeHRyYSB3b3JrIHRvDQo+IGtlZXAgaXQgdXBkYXRl
ZCwgKC0pIHdlIGRvbid0IHJlYWxseSBkbyBhbnl0aGluZyB3aXRoIG1haW5saW5lIGNvbW1pdHMN
Cj4gbmV3ZXIgdGhhbiA1LjEwDQo+IA0KPiA0KSB1cGRhdGUgaXQgdG8gTGludXMnIDUuMTAsIGFu
ZCBvbmx5IHRvdWNoIGl0IHdoZW4gdGhlIGxpbnV4LTUuMjEtY2lwDQo+IGlzIGJyYW5jaGVkIG91
dC4NCj4gDQo+IEFueSBvdGhlciBpZGVhcz8NCj4gDQo+IE15IHByZWZlcmVuY2Ugd291bGQgYmUg
KDEpIGFuZCAoNCkuDQoNCkkgd2FudCB0byBjaG9vc2UgMSBvciAzLg0KV2UgaGF2ZSBtdWx0aXBs
ZSByZWxlYXNlIGJyYW5jaGVzLCBzbyBzZXR0aW5nIHRoZSBicmFuY2ggdGhhdCBtYW5hZ2VzIGEg
cGFydGljdWxhciB2ZXJzaW9uIHRvDQp0aGUgbWFzdGVyIGJyYW5jaCBjYW4gYmUgYSBiaXQgY29u
ZnVzaW5nLiBIb3cgYWJvdXQgbWFuYWdpbmcgYSBicmFuY2ggc2ltaWxhciB0byBMVFMgdHJlZT8N
Cg0KQmVzdCByZWdhcmRzLA0KICBOb2J1aGlybw0K

--VDSVpkLGf1vJDVzHTZzl
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6280): https://lists.cip-project.org/g/cip-dev/message=
/6280
Mute This Topic: https://lists.cip-project.org/mt/81251519/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--VDSVpkLGf1vJDVzHTZzl--
