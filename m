Return-Path: <SRS0=XXtj=6R=lists.cip-project.org=bounce+64572+4610+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F8AC28CBC
	for <cip-dev@archiver.kernel.org>; Sun,  3 May 2020 19:11:37 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D05220721
	for <cip-dev@archiver.kernel.org>; Sun,  3 May 2020 19:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="KJQLHb3u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D05220721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4610+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id WRPGYY4521723xcw3z8ZjHFz; Sun, 03 May 2020 12:11:36 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web10.29095.1588533093973655919
 for <cip-dev@lists.cip-project.org>;
 Sun, 03 May 2020 12:11:35 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 043JBMfI032535; Mon, 4 May 2020 04:11:22 +0900
X-Iguazu-Qid: 2wHHWzHtOwqcUONLsG
X-Iguazu-QSIG: v=2; s=0; t=1588533082; q=2wHHWzHtOwqcUONLsG; m=ner0W4bCqe+VUMMsw9fVJM/O/juel0PEOvVQthC9ECQ=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1110) id 043JBKC0003603;
	Mon, 4 May 2020 04:11:21 +0900
X-Received: from enc01.localdomain ([106.186.93.100])
	by imx2.toshiba.co.jp  with ESMTP id 043JBKp2003488;
	Mon, 4 May 2020 04:11:20 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.localdomain  with ESMTP id 043JBK5p014187;
	Mon, 4 May 2020 04:11:20 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UE0mypy6fscBejmoc0dimUCaSJbvBd7/ygTi54d+x8lb+Cy2NlB32o8n69hMiAFDkfGsA7ICvPmMy5RUOczaS64iunTpmSTI8j895v0QAu9UAXT3fsAmj5BghQ0UKT3r6/1R4By3vlkscHg368Usu6o7WV78ewfxExU1mkLoN2YlTvDybOJiIOBVa5xfzPDLG80DrMwgOVhvUOtE6YKbNGCFtZIOFnNAVvMnWTJR0uNyGSr19Jb0TQI6Vs/123+YOgjkgXGGCSsSgMSll57Eb0Otno+vCzPkp+s6it3ihS/MOdiWyf58hpLIKP8tOjV4NOuiLtWCR9e8tmYzKWC3rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XSlCX3WmmPSnjMaO0wutCqmx8o8M8gNeyd1XZXtNlIY=;
 b=IHsOxZVYheRUDf+v97ofKPQNxBIQp4BfBVqm5dO6v7QHYGO8gJ6HA3OnMsYkhr5luAiECsb1cli6roreQhXWjjTX7JUQqXnYdRAdfIW9Si5YKJbl3tqUkBJ1DonTs3S2t00R9of4o5V3d8MuU3TC8gxe+rr1/ycDDc82bY6K8s6EjLRgxbUq0fGpJ5OV8jGzTYmNCkZ8YTFv5AiT8fcskrZJVTYK7jDo+ZQh+HOKc6dvVlDDcjVM6gKkgMfxS1MKwDEhqtGxqf+Rlkm4ZWU8k8/qv2AzgIYjh+cZwiqSC4Ou3BxXpfYFVKZxZpnYwE02g4eclJOC9YmY47WzTJ7bxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>, <JohnsonCH.Chen@moxa.com>
CC: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip 3/3] cpufreq: ti: Add cpufreq driver to determine available OPPs at runtime
Thread-Topic: [PATCH 4.4.y-cip 3/3] cpufreq: ti: Add cpufreq driver to
 determine available OPPs at runtime
Thread-Index: AdYelqlUPJYYZ9pGSFeLKUKE4WiSEwBBKnaAAHhQLrA=
Date: Sun, 3 May 2020 19:09:57 +0000
X-TSB-HOP: ON
Message-ID: <OSAPR01MB366796B3E21B6E23A8B394E592A90@OSAPR01MB3667.jpnprd01.prod.outlook.com>
References: <HK2PR01MB3281A0A027BAB0F4F036AC7AFAAA0@HK2PR01MB3281.apcprd01.prod.exchangelabs.com>
 <20200501093143.GB11782@amd>
In-Reply-To: <20200501093143.GB11782@amd>
Accept-Language: ja-JP, en-US
x-originating-ip: [2405:6581:5360:1800:f3:e40:e161:9a2a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 588ccd1e-82f3-45bf-f6af-08d7ef959229
x-ms-traffictypediagnostic: OSAPR01MB3714:
x-microsoft-antispam-prvs: <OSAPR01MB371444D3EC780C84AFC90AE492A90@OSAPR01MB3714.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7uulWcvkBopjM9IescFP/be+xOoRWFgI1bqW48Xzit/efhgXG2pjq1i7oGuympoJ0N3eQ2N126/iiuUnJBOWQ05vH+bgetLggu73FIfk19uOBSjeD/eEw8LiJpbpFsyPoDXCjiepWhvll8/yeq294d3y3SPQ/g1lqVuWLPylSxCHuVVWCEYuExVGHIYngOeG0j5e/zBVPa6qgHwp/ifaqyMU5cItW0QmpzrpgjIbKQ5Nc0wWxfDswLm4/p25vyMiWOhTOoCZ9MLDMlxMPUBKda2htca6pXlGjZ34kg45mqZA/Gh0UCkTkohgjwC/IU+Bz9XfRWLeP2B/haAKQFbYjIGyDZsGeyt9Z4dJyqep04/F/j8+UxmMpmtDRcAp3A5hsBRlP7TuqKXXsVGmMGKUczwSWQkz10mPUwDv+sYshW8weM7fpcksqGX/TnmeomrIvuu3I5DBGSPjhr75RWhqUYZEoVHSmfBqAYi9HnljHPQ=
x-ms-exchange-antispam-messagedata: ezFtiG1SVCUy+Uf8uUQQboZB+IrDWJUfrfsdK/RAbhvaYtf7UNYsZ7pBFgwIGDb+G0t+pd23oQp2LpQB8WRLfkxY5nBaJByz5uupKiHW7HGqh6XjcWE2dHzDf4hldur8XP9itVc1T7HuwmsyCT6r4cg2BLIUHn1NdQsHM56l4RgqirsgST0hoTWBnFIT4mWbYZkz7OelrGJXpaiqENkyuGHol9tnGbJBjNsYKQIGq5r3+WLgqSzX89ta0zhnwm77FxJ0jbnf3LkVHTK2gJi8X0K9Y7wX8V5c//aGEquDtQmdjYW5zTYaHuy3B+0QnOQQZLN5uRTkPcwsCHHZZ16g2vf6B1aIS5uTRIcf1do9fKVHF4DVjC3VC3BB9+JxFtynsnoCMiCPhJ6zvvvPbWltkJcSlKICEcM7OjkodrTxtFzPvZLMaJGL9ryMvTeHfejOl43ZAivWUe6uPf6PMa7OEyabIc5bPU+TXLJYBvosEFJCv6xIkSCj4913yGMWwdpRbv2VdUJUa0WHFeetw6zUx/JOabb/8OI9hMEy3zWw6eRHaJYtJjxpFQ6Y3dN0hOB9T9gUxMFOTLar1tSMZ/JRg/RY59UgWXNv2ZeaMrr4wgCOQGmT1SZYIfevY5i8T1i0nBcpmJOPmwN3pHyGQCAvT2aTgVrnBU7oouo/UZtCoUvDtQVn+Tada7sJfVsdSv6L6ZXCSq+ElXmM8enyeYwm8TdcNITGQ30VF48ZtCXS0F4DmFtchSOSjer5pcwPt61sWPoaql/6QCdYHLD6ykT/ZRIQ17mC7ItSPop0xiFtHOMuwZNlC6JpZ2v7vhgsOobd8EYqjjuWZG1oUZv5WLJJTkEDqSRiezDvAY92t8Jw09Q=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 588ccd1e-82f3-45bf-f6af-08d7ef959229
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2020 19:09:57.6984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wRu7JEdUJYVG9HrZlacfCnEhNgD0zEzAuFRSTgZAcHVKEk2q39Bi35Y1b/wtxL6IthbNAwLKDLvIld//PLWb+zG8uyxIbAFevxP2YivUtWk15ajD8GOKw+S1MNPIZ8co
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3714
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 0LN1bHKGt6f3uVQLXQq6giWUx4520388AA=
Content-Type: multipart/mixed; boundary="xLTE8QUfmLWO4LI2lYzG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1588533096;
 bh=tLNvdaDw14gkOONjiMvWl4CNFIr79tKwwuEz7qSoqfM=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=KJQLHb3uB/dl1RDoGV7HBWci6uII6KyqdOIqT5UTOLZ1HB6r9dYFBInd2QvkHRCknKk
 h+obEpF1nRpVaX9BNvQTmKC0IDdXLm1vQmTHa8WVvykHb4piAMtCQ3dThfvyZ6wv3D26Q
 zHAimgAlUw5EEpDYJ6j7cKLNYzYJL6YJF6g=

--xLTE8QUfmLWO4LI2lYzG
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGF2ZWwgTWFjaGVr
IFttYWlsdG86cGF2ZWxAZGVueC5kZV0NCj4gU2VudDogRnJpZGF5LCBNYXkgMSwgMjAyMCA2OjMy
IFBNDQo+IFRvOiBKb2huc29uIENIIENoZW4gKOmZs+aYreWLsykgPEpvaG5zb25DSC5DaGVuQG1v
eGEuY29tPg0KPiBDYzogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc7IGl3YW1hdHN1IG5v
YnVoaXJvKOWyqeadviDkv6HmtIsg4pah77yz77y377yj4pev77yh77yj77y0KQ0KPiA8bm9idWhp
cm8xLml3YW1hdHN1QHRvc2hpYmEuY28uanA+OyBwYXZlbEBkZW54LmRlDQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggNC40LnktY2lwIDMvM10gY3B1ZnJlcTogdGk6IEFkZCBjcHVmcmVxIGRyaXZlciB0
byBkZXRlcm1pbmUgYXZhaWxhYmxlIE9QUHMgYXQgcnVudGltZQ0KPiANCj4gSGkhDQo+IA0KPiA+
IEZyb206IERhdmUgR2VybGFjaCA8ZC1nZXJsYWNoQHRpLmNvbT4NCj4gPg0KPiA+IGNvbW1pdCBl
MTNjZjA0NmNkNzA4OTQzOTNhMTA4NWNhMzlkYTdlZjc1MTM1M2ZiIHVwc3RyZWFtDQo+ID4NCj4g
PiBTb21lIFRJIFNvQ3MsIGxpa2UgdGhvc2UgaW4gdGhlIEFNMzM1eCwgQU00Mzd4LCBEUkE3eCwg
YW5kIEFNNTd4IGZhbWlsaWVzLA0KPiA+IGhhdmUgZGlmZmVyZW50IE9QUHMgYXZhaWxhYmxlIGZv
ciB0aGUgTVBVIGRlcGVuZGluZyBvbiB3aGljaCBzcGVjaWZpYw0KPiA+IHZhcmlhbnQgb2YgdGhl
IFNvQyBpcyBpbiB1c2UuIFRoaXMgY2FuIGJlIGRldGVybWluZWQgdGhyb3VnaCB1c2Ugb2YgdGhl
DQo+ID4gcmV2aXNpb24gYW5kIGFuIGVGdXNlIHJlZ2lzdGVyIHByZXNlbnQgaW4gdGhlIHNpbGlj
b24uIEludHJvZHVjZSBhDQo+ID4gdGktY3B1ZnJlcSBkcml2ZXIgdGhhdCBjYW4gcmVhZCB0aGUg
YWZvcm1lbnRpb25lZCB2YWx1ZXMgYW5kIHByb3ZpZGUNCj4gPiB0aGVtIGFzIHZlcnNpb24gbWF0
Y2hpbmcgZGF0YSB0byB0aGUgb3BwIGZyYW1ld29yay4gVGhyb3VnaCB0aGlzIHRoZQ0KPiA+IG9w
cC1zdXBwb3J0ZWQtaHcgZHQgYmluZGluZyB0aGF0IGlzIHBhcnQgb2YgdGhlIG9wZXJhdGluZy1w
b2ludHMtdjINCj4gPiB0YWJsZSBjYW4gYmUgdXNlZCB0byBpbmRpY2F0ZSBhdmFpbGFiaWxpdHkg
b2YgT1BQcyBmb3IgZWFjaCBkZXZpY2UuDQo+ID4NCj4gPiBUaGlzIGRyaXZlciBhbHNvIGNyZWF0
ZXMgdGhlICJjcHVmcmVxLWR0IiBwbGF0Zm9ybV9kZXZpY2UgYWZ0ZXIgcGFzc2luZw0KPiA+IHRo
ZSB2ZXJzaW9uIG1hdGNoaW5nIGRhdGEgdG8gdGhlIE9QUCBmcmFtZXdvcmsgc28gdGhhdCB0aGUg
Y3B1ZnJlcS1kdA0KPiA+IGhhbmRsZXMgdGhlIGFjdHVhbCBjcHVmcmVxIGltcGxlbWVudGF0aW9u
LiBFdmVuIHdpdGhvdXQgdGhlIG5lY2Vzc2FyeQ0KPiA+IGRhdGEgdG8gcGFzcyB0aGUgdmVyc2lv
biBtYXRjaGluZyBkYXRhIHRoZSBkcml2ZXIgd2lsbCBzdGlsbCBjcmVhdGUgdGhpcw0KPiA+IGRl
dmljZSB0byBtYWludGFpbiBiYWNrd2FyZHMgY29tcGF0aWJpbGl0eSB3aXRoIG9wZXJhdGluZy1w
b2ludHMgdjENCj4gPiB0YWJsZXMuDQo+ID4NCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLjNkYmY1
NzE2NGRlZA0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9kcml2ZXJzL2NwdWZyZXEvdGkt
Y3B1ZnJlcS5jDQo+ID4gQEAgLTAsMCArMSwyNzIgQEANCj4gPiArLyoNCj4gPiArICogVEkgQ1BV
RnJlcS9PUFAgaHctc3VwcG9ydGVkIGRyaXZlcg0KPiA+ICsgKg0KPiA+ICsgKiBDb3B5cmlnaHQg
KEMpIDIwMTYtMjAxNyBUZXhhcyBJbnN0cnVtZW50cywgSW5jLg0KPiA+ICsgKgkgRGF2ZSBHZXJs
YWNoIDxkLWdlcmxhY2hAdGkuY29tPg0KPiA+ICsgKg0KPiA+ICsgKiBUaGlzIHByb2dyYW0gaXMg
ZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yDQo+ID4gKyAqIG1v
ZGlmeSBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNl
DQo+ID4gKyAqIHZlcnNpb24gMiBhcyBwdWJsaXNoZWQgYnkgdGhlIEZyZWUgU29mdHdhcmUgRm91
bmRhdGlvbi4NCj4gDQo+IEkgZ3Vlc3MgU1BEWCB3b3VsZCBiZSBiZXR0ZXIgdGhhbiB0aGlzLg0K
PiANCj4gPiArc3RhdGljIGludCB0aV9jcHVmcmVxX2luaXQodm9pZCkNCj4gPiArew0KPiAuLi4N
Cj4gPiArCS8qDQo+ID4gKwkgKiBPUFBzIGRldGVybWluZSB3aGV0aGVyIG9yIG5vdCB0aGV5IGFy
ZSBzdXBwb3J0ZWQgYmFzZWQgb24NCj4gPiArCSAqIHR3byBtZXRyaWNzOg0KPiA+ICsJICoJMCAt
IFNvQyBSZXZpc2lvbg0KPiA+ICsJICoJMSAtIGVGdXNlIHZhbHVlDQo+ID4gKwkgKi8NCj4gPiAr
CXJldCA9IHRpX2NwdWZyZXFfZ2V0X3JldihvcHBfZGF0YSwgJnZlcnNpb25bMF0pOw0KPiA+ICsJ
aWYgKHJldCkNCj4gPiArCQlnb3RvIGZhaWxfcHV0X25vZGU7DQo+ID4gKw0KPiA+ICsJcmV0ID0g
dGlfY3B1ZnJlcV9nZXRfZWZ1c2Uob3BwX2RhdGEsICZ2ZXJzaW9uWzFdKTsNCj4gPiArCWlmIChy
ZXQpDQo+ID4gKwkJZ290byBmYWlsX3B1dF9ub2RlOw0KPiA+ICsNCj4gPiArCW9mX25vZGVfcHV0
KG9wcF9kYXRhLT5vcHBfbm9kZSk7DQo+ID4gKw0KPiA+ICsJcmV0ID0gZGV2X3BtX29wcF9zZXRf
c3VwcG9ydGVkX2h3KG9wcF9kYXRhLT5jcHVfZGV2LA0KPiA+ICsJCQkJCQl2ZXJzaW9uLCBWRVJT
SU9OX0NPVU5UKTsNCj4gPiArCWlmIChyZXQpIHsNCj4gPiArCQlkZXZfZXJyKG9wcF9kYXRhLT5j
cHVfZGV2LA0KPiA+ICsJCQkiRmFpbGVkIHRvIHNldCBzdXBwb3J0ZWQgaGFyZHdhcmVcbiIpOw0K
PiA+ICsJCWdvdG8gZmFpbF9wdXRfbm9kZTsNCj4gPiArCX0NCj4gDQo+IFRoaXMgc2hvdWxkIGJl
ICJyZXR1cm4gZXJyIiwgd2UgaGF2ZSBhbHJlYWR5IHB1dCB0aGUgbm9kZSBmZXcgbGluZXMNCj4g
YWJvdmUuDQoNCk9oLCB0aGFua3MgZm9yIHlvdXIgcG9pbnRpbmcuDQp3ZSBhbHNvIG5lZWQgdG8g
YmFja3BvcnQgdGhlIGZvbGxvd2luZyBwYXRjaGU6DQogIDlhNmU5MWQwOGU3NzA3YmFhMmY4MjQy
NTczNDJjYTdlZmNiMTk5YmMNCg0KQW5kIHRoZXJlIGFyZSBvdGhlciBpc3N1ZXMgdG9vLCBzbyBJ
IHRoaW5rIHRoZSBmb2xsb3dpbmcgcGF0Y2hlcyBhcmUgYWxzbyBuZWVkZWQuDQowNTgyOWQ5NDMx
ZGYxYmY2ZGU5ODY3OWZiY2ZiYWQyODJjMWM1NWE0DQplNWQyOTViMDZkNjlhMTkyNDY2NWExNmE0
OTg3YmU0NzVhZGRkMDBmDQoyNDhhZWZkY2MzYTdlMGNmYmQwMTQ5NDZiNGRlYWQ2M2U3NTBlNzFi
DQoNClBsZWFzZSBjaGVjayB0aGVzZS4NCg0KPiANCj4gPiArcmVnaXN0ZXJfY3B1ZnJlcV9kdDoN
Cj4gPiArCXBsYXRmb3JtX2RldmljZV9yZWdpc3Rlcl9zaW1wbGUoImNwdWZyZXEtZHQiLCAtMSwg
TlVMTCwgMCk7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gKw0KPiA+ICtmYWlsX3B1dF9u
b2RlOg0KPiA+ICsJb2Zfbm9kZV9wdXQob3BwX2RhdGEtPm9wcF9ub2RlKTsNCj4gPiArDQo+ID4g
KwlyZXR1cm4gcmV0Ow0KPiA+ICt9DQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IAkJCQkJCQkJUGF2
ZWwNCg0KQmVzdCByZWdhcmRzLA0KICBOb2J1aGlybw0KDQo=

--xLTE8QUfmLWO4LI2lYzG
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4610): https://lists.cip-project.org/g/cip-dev/message=
/4610
Mute This Topic: https://lists.cip-project.org/mt/73369237/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--xLTE8QUfmLWO4LI2lYzG--
