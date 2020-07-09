Return-Path: <SRS0=zDkm=AU=lists.cip-project.org=bounce+64572+4913+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1B4C433E0
	for <cip-dev@archiver.kernel.org>; Thu,  9 Jul 2020 04:38:50 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A74D4206E2
	for <cip-dev@archiver.kernel.org>; Thu,  9 Jul 2020 04:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="BaPYuqQ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A74D4206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4913+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id sP1tYY4521723xJwynhrKzwe; Wed, 08 Jul 2020 21:38:49 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web10.201.1594269525818104481
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Jul 2020 21:38:47 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 0694cYlw012933; Thu, 9 Jul 2020 13:38:34 +0900
X-Iguazu-Qid: 34triqBKSi9mTmAPGk
X-Iguazu-QSIG: v=2; s=0; t=1594269513; q=34triqBKSi9mTmAPGk; m=wiorD3IGkzm8ccpYnP0qprbB2JrBlbzmZzouO5W0HiA=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1511) id 0694cWxq035894;
	Thu, 9 Jul 2020 13:38:32 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 0694cWV8010238;
	Thu, 9 Jul 2020 13:38:32 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 0694cWhc008069;
	Thu, 9 Jul 2020 13:38:32 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AxH6z5rHH1xFEc63NVSfm0zQma6UxXCLeNFUZ1iOYP0BwSeucOWeS8Cb3h1/lubbzR9sd6hPT0q6vpUxahFUjIm71BnwSlFPJFx1TTZj9IKSggOPlJMEGZismYb1skNa+5nPfV1duOlRdM7xHTOFGO7DcO0crRX46xC+ATtv0pv87Zy16frq8CmG3/U8TqSIbBJ0Yd4JFQyHlUzdPyMJ5oKiKlSEy2+AeKqoe2m92T2sMHeMmkvxTQ8i5XshzfmRuO4/N9B7N2ytfZUxUAehT/PXW3T4OAIFgaP8IiNENCP81ee4X6z1n8QshW/RifvHCkCtHUefxtDGRXpe/cQoQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YERm4pFlT6pENl103J90QMBRDImS+iYNynF3ZisD28Y=;
 b=XxtUNmJ8z97JdH/zaP6u6lS4ARegOeN1sw4tS37dwtvZHw/XrxX8hBKY5B1gV56sFzwZtg+STUxxJpXP4aX9wYcWqGsZ6EZJ0/mx9r/W4GT5BvM230vAV4wakUJK/zi8JDJLdImHicz5T3O7th7rqmhr1AhOLvslBHqB4XDffSUZpj4aGi46s5qiOhaFLx3ZvlQRm3IWUQv2SDIgIHpfiHhp7UKn0xq7SQRhpX+Tc5jJVMKUyVzrKej0a95YwmLcPxfJOIQRJGgbak0Vim/BOhNT8hpK32UgqV1LmUlDdCpXlMVaM9NqlJh6mc8posUzxbDasqPAB/aYmtKjrOQRFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <wens@csie.org>, <pavel@denx.de>
CC: <cip-dev@lists.cip-project.org>, <JohnsonCH.Chen@moxa.com>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip 05/23] PM / OPP: Parse clock-latency and voltage-tolerance for v1 bindings
Thread-Topic: [PATCH 4.4.y-cip 05/23] PM / OPP: Parse clock-latency and
 voltage-tolerance for v1 bindings
Thread-Index: AQHWVT7zLD8I0ZHBBEOr9EpLn88ljqj+qt2A
Date: Thu, 9 Jul 2020 04:38:28 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2983907F308D6475B7D29D9D92640@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <20200708154554.26450-1-wens@csie.org>
 <20200708154554.26450-6-wens@csie.org>
In-Reply-To: <20200708154554.26450-6-wens@csie.org>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a4102f00-e31e-4b2b-06af-08d823c1ed4a
x-ms-traffictypediagnostic: OS0PR01MB5299:
x-microsoft-antispam-prvs: <OS0PR01MB529960765414A8F74706F86792640@OS0PR01MB5299.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:221;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2wyt/W8Or13Xs4RrMz5HcWxt464AHfVSD9GW4IcpcvsZDfwJSCFtZNQIBtRihiSwfp5fgS0qf7DAqLZl4HTzPaq2PE6AGBo2OAA6aa/Fj8b/tJ8pYtxRJKV+of1cP4Acr9gdTJ6kLJn70x2USlCrdS3zDveESxJCii/CzlZImWvzh+73gzuGuwEodojYwFngsf8pO5Sa9RoaVVSRuTjsE3UJhQAMncGZPkvAE7sKlcT8l+FXTUTX8WWwDERlC3CIQ1AHkQuKimYWqq/yM/MoG2+xPxFxznmCAzLyb3xrubDNe/AKOYah5XTO+f5IElIYvNMY6dBGTfgnHk5tCI91Yg==
x-ms-exchange-antispam-messagedata: 8ZL6RmTjg8CvmG9yVNiAmVtVK8X6zayGR/ic5yk8WsIKnxlOOaA1bFkunRRF0gtBbKXyiln0LLwFNWsH53QqWZ3YrdIqFOupsP//9wa9VU/PFBk6CXGiEfH3vaWYNArm5HtVku0zOMdISCBBopPTdJBpVvZLhQo/8F3a7zuV2B+1DfRFcTXbqm9/d3t9yrjdWtwzvlAshQNRo3m/69lmddS7nsOirfFWz0yLoq4mjxmRU2cSBrTHpmDE24+M72wgWLl9p8nHLCssqbCniEkJDJrQ8R/n3UW9X7JzZWDPmO1QQYdthCG1wUf9Pt2b+nxwJJAPtX8RTY+QzuC67scfTcBNNNAPOrik3/x+JCxfOjPb6d2bcgmw7JNWLkv/nWEFcTO30UvLlHgIcATF1uuDlFRwE1M46DiTGdm98fCeFgQDQJ6BPHcB4L0Gs4orEVdsH2oM9wA6zk8w3An7oXfz/0vG+Db0AWOxlAbmbJPF4qo=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4102f00-e31e-4b2b-06af-08d823c1ed4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2020 04:38:28.8937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n0VjGDxisU2QSfBe6n2O5zJfInKF/FylrqLsG5ue3NkUGLqoEfjDLfzoc+5IhTb8CkqLwkpMKRcOI0K3gNPfYQTu8a4oyYY+QWcx4CKazt5EYPkFAYQnWS3R/bm0RFnh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5299
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: wJc3vVzjWajOmLFJjsaSPDyJx4520388AA=
Content-Type: multipart/mixed; boundary="LqGm4j0SQAOY03gSAloO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1594269529;
 bh=CI6U1zIUn7neP8XgdJpt32OIfiDRurPzdHPEzyJFFtI=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=BaPYuqQ97o4vQFgT4bXGvG22NQ2pkt8/z3rYu+SEUM8XTt1U1xZjpJr2UU3rOjpWYac
 FkUHwp2mtUjTN75h2YhLHNaSLn265URak1ah00DTSZAed3t2OCOU1u3jl6hQrZ87FlfPh
 CF/NI27MkPXrmFsRL+4I8qrSJyQ8hiyJ7RA=

--LqGm4j0SQAOY03gSAloO
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2hlbi1ZdSBUc2Fp
IChNb3hhKSBbbWFpbHRvOndlbnNAY3NpZS5vcmddDQo+IFNlbnQ6IFRodXJzZGF5LCBKdWx5IDks
IDIwMjAgMTI6NDYgQU0NCj4gVG86IGl3YW1hdHN1IG5vYnVoaXJvKOWyqeadviDkv6HmtIsg4pah
77yz77y377yj4pev77yh77yj77y0KSA8bm9idWhpcm8xLml3YW1hdHN1QHRvc2hpYmEuY28uanA+
OyBwYXZlbEBkZW54LmRlDQo+IENjOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZzsgSm9o
bnNvbkNILkNoZW5AbW94YS5jb20NCj4gU3ViamVjdDogW1BBVENIIDQuNC55LWNpcCAwNS8yM10g
UE0gLyBPUFA6IFBhcnNlIGNsb2NrLWxhdGVuY3kgYW5kIHZvbHRhZ2UtdG9sZXJhbmNlIGZvciB2
MSBiaW5kaW5ncw0KPiANCj4gRnJvbTogVmlyZXNoIEt1bWFyIDx2aXJlc2gua3VtYXJAbGluYXJv
Lm9yZz4NCj4gDQo+IGNvbW1pdCA1MGY4Y2ZiZDU4OTdjYTE4MmQ0M2Y0Y2FmMTk5MzcxNTNmMTdh
NjA0IHVwdHJlYW0uDQoNCnVwdHJlYW0gLT4gdXBzdHJlYW0gPw0KDQo+IA0KPiBWMiBiaW5kaW5n
cyBoYXZlIGJldHRlciBzdXBwb3J0IGZvciBjbG9jay1sYXRlbmN5IGFuZCB2b2x0YWdlLXRvbGVy
YW5jZQ0KPiBhbmQgZG9lc24ndCBuZWVkIHNwZWNpYWwgY2FyZS4gVG8gdXNlIGNhbGxiYWNrcywg
bGlrZQ0KPiBkZXZfcG1fb3BwX2dldF9tYXhfe3RyYW5zaXRpb258dm9sdH1fbGF0ZW5jeSgpLCBp
cnJlc3BlY3RpdmUgb2YgdGhlDQo+IGJpbmRpbmdzLCB0aGUgY29yZSBuZWVkcyB0byBrbm93IGNs
b2NrLWxhdGVuY3kvdm9sdGFnZS10b2xlcmFuY2UgZm9yIHRoZQ0KPiBlYXJsaWVyIGJpbmRpbmdz
Lg0KPiANCj4gVGhpcyBwYXRjaCByZWFkcyBjbG9jay1sYXRlbmN5L3ZvbHRhZ2UtdG9sZXJhbmNl
IGZyb20gdGhlIGRldmljZSBub2RlLA0KPiBpcnJlc3BlY3RpdmUgb2YgdGhlIGJpbmRpbmdzICh0
byBrZWVwIGl0IHNpbXBsZSkgYW5kIHVzZSB0aGVtIG9ubHkgZm9yDQo+IFYxIGJpbmRpbmdzLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogVmlyZXNoIEt1bWFyIDx2aXJlc2gua3VtYXJAbGluYXJvLm9y
Zz4NCj4gUmV2aWV3ZWQtYnk6IFN0ZXBoZW4gQm95ZCA8c2JveWRAY29kZWF1cm9yYS5vcmc+DQo+
IFNpZ25lZC1vZmYtYnk6IFJhZmFlbCBKLiBXeXNvY2tpIDxyYWZhZWwuai53eXNvY2tpQGludGVs
LmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQ2hlbi1ZdSBUc2FpIChNb3hhKSA8d2Vuc0Bjc2llLm9y
Zz4NCj4gLS0tDQo+ICBkcml2ZXJzL2Jhc2UvcG93ZXIvb3BwL2NvcmUuYyB8IDIwICsrKysrKysr
KysrKysrKysrKysrDQo+ICBkcml2ZXJzL2Jhc2UvcG93ZXIvb3BwL29wcC5oICB8ICA2ICsrKysr
Kw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspDQoNCkJlc3QgcmVnYXJkcywN
CiAgTm9idWhpcm8NCg0KDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9iYXNlL3Bvd2VyL29w
cC9jb3JlLmMgYi9kcml2ZXJzL2Jhc2UvcG93ZXIvb3BwL2NvcmUuYw0KPiBpbmRleCBkNTFkZGNl
YmNjYTAwLi5lMWYyMTRmYzc1NTU1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2Jhc2UvcG93ZXIv
b3BwL2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL2Jhc2UvcG93ZXIvb3BwL2NvcmUuYw0KPiBAQCAt
NTgyLDYgKzU4Miw3IEBAIHN0YXRpYyBzdHJ1Y3QgZGV2aWNlX29wcCAqX2FkZF9kZXZpY2Vfb3Bw
KHN0cnVjdCBkZXZpY2UgKmRldikNCj4gIHsNCj4gIAlzdHJ1Y3QgZGV2aWNlX29wcCAqZGV2X29w
cDsNCj4gIAlzdHJ1Y3QgZGV2aWNlX2xpc3Rfb3BwICpsaXN0X2RldjsNCj4gKwlzdHJ1Y3QgZGV2
aWNlX25vZGUgKm5wOw0KPiANCj4gIAkvKiBDaGVjayBmb3IgZXhpc3RpbmcgbGlzdCBmb3IgJ2Rl
dicgZmlyc3QgKi8NCj4gIAlkZXZfb3BwID0gX2ZpbmRfZGV2aWNlX29wcChkZXYpOw0KPiBAQCAt
NjA0LDYgKzYwNSwyMSBAQCBzdGF0aWMgc3RydWN0IGRldmljZV9vcHAgKl9hZGRfZGV2aWNlX29w
cChzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICAJCXJldHVybiBOVUxMOw0KPiAgCX0NCj4gDQo+ICsJ
LyoNCj4gKwkgKiBPbmx5IHJlcXVpcmVkIGZvciBiYWNrd2FyZCBjb21wYXRpYmlsaXR5IHdpdGgg
djEgYmluZGluZ3MsIGJ1dCBpc24ndA0KPiArCSAqIGhhcm1mdWwgZm9yIG90aGVyIGNhc2VzLiBB
bmQgc28gd2UgZG8gaXQgdW5jb25kaXRpb25hbGx5Lg0KPiArCSAqLw0KPiArCW5wID0gb2Zfbm9k
ZV9nZXQoZGV2LT5vZl9ub2RlKTsNCj4gKwlpZiAobnApIHsNCj4gKwkJdTMyIHZhbDsNCj4gKw0K
PiArCQlpZiAoIW9mX3Byb3BlcnR5X3JlYWRfdTMyKG5wLCAiY2xvY2stbGF0ZW5jeSIsICZ2YWwp
KQ0KPiArCQkJZGV2X29wcC0+Y2xvY2tfbGF0ZW5jeV9uc19tYXggPSB2YWw7DQo+ICsJCW9mX3By
b3BlcnR5X3JlYWRfdTMyKG5wLCAidm9sdGFnZS10b2xlcmFuY2UiLA0KPiArCQkJCSAgICAgJmRl
dl9vcHAtPnZvbHRhZ2VfdG9sZXJhbmNlX3YxKTsNCj4gKwkJb2Zfbm9kZV9wdXQobnApOw0KPiAr
CX0NCj4gKw0KPiAgCXNyY3VfaW5pdF9ub3RpZmllcl9oZWFkKCZkZXZfb3BwLT5zcmN1X2hlYWQp
Ow0KPiAgCUlOSVRfTElTVF9IRUFEKCZkZXZfb3BwLT5vcHBfbGlzdCk7DQo+IA0KPiBAQCAtODYx
LDYgKzg3Nyw3IEBAIHN0YXRpYyBpbnQgX29wcF9hZGRfdjEoc3RydWN0IGRldmljZSAqZGV2LCB1
bnNpZ25lZCBsb25nIGZyZXEsIGxvbmcgdV92b2x0LA0KPiAgew0KPiAgCXN0cnVjdCBkZXZpY2Vf
b3BwICpkZXZfb3BwOw0KPiAgCXN0cnVjdCBkZXZfcG1fb3BwICpuZXdfb3BwOw0KPiArCXVuc2ln
bmVkIGxvbmcgdG9sOw0KPiAgCWludCByZXQ7DQo+IA0KPiAgCS8qIEhvbGQgb3VyIGxpc3QgbW9k
aWZpY2F0aW9uIGxvY2sgaGVyZSAqLw0KPiBAQCAtODc0LDcgKzg5MSwxMCBAQCBzdGF0aWMgaW50
IF9vcHBfYWRkX3YxKHN0cnVjdCBkZXZpY2UgKmRldiwgdW5zaWduZWQgbG9uZyBmcmVxLCBsb25n
IHVfdm9sdCwNCj4gDQo+ICAJLyogcG9wdWxhdGUgdGhlIG9wcCB0YWJsZSAqLw0KPiAgCW5ld19v
cHAtPnJhdGUgPSBmcmVxOw0KPiArCXRvbCA9IHVfdm9sdCAqIGRldl9vcHAtPnZvbHRhZ2VfdG9s
ZXJhbmNlX3YxIC8gMTAwOw0KPiAgCW5ld19vcHAtPnVfdm9sdCA9IHVfdm9sdDsNCj4gKwluZXdf
b3BwLT51X3ZvbHRfbWluID0gdV92b2x0IC0gdG9sOw0KPiArCW5ld19vcHAtPnVfdm9sdF9tYXgg
PSB1X3ZvbHQgKyB0b2w7DQo+ICAJbmV3X29wcC0+YXZhaWxhYmxlID0gdHJ1ZTsNCj4gIAluZXdf
b3BwLT5keW5hbWljID0gZHluYW1pYzsNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Jhc2Uv
cG93ZXIvb3BwL29wcC5oIGIvZHJpdmVycy9iYXNlL3Bvd2VyL29wcC9vcHAuaA0KPiBpbmRleCA0
MTYyOTNiN2RhMjM3Li5mZTQ0YmViNDA0YmEyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2Jhc2Uv
cG93ZXIvb3BwL29wcC5oDQo+ICsrKyBiL2RyaXZlcnMvYmFzZS9wb3dlci9vcHAvb3BwLmgNCj4g
QEAgLTEzOCw2ICsxMzgsOCBAQCBzdHJ1Y3QgZGV2aWNlX2xpc3Rfb3BwIHsNCj4gICAqIEBkZW50
cnk6CWRlYnVnZnMgZGVudHJ5IHBvaW50ZXIgb2YgdGhlIHJlYWwgZGV2aWNlIGRpcmVjdG9yeSAo
bm90IGxpbmtzKS4NCj4gICAqIEBkZW50cnlfbmFtZTogTmFtZSBvZiB0aGUgcmVhbCBkZW50cnku
DQo+ICAgKg0KPiArICogQHZvbHRhZ2VfdG9sZXJhbmNlX3YxOiBJbiBwZXJjZW50YWdlLCBmb3Ig
djEgYmluZGluZ3Mgb25seS4NCj4gKyAqDQo+ICAgKiBUaGlzIGlzIGFuIGludGVybmFsIGRhdGEg
c3RydWN0dXJlIG1haW50YWluaW5nIHRoZSBsaW5rIHRvIG9wcHMgYXR0YWNoZWQgdG8NCj4gICAq
IGEgZGV2aWNlLiBUaGlzIHN0cnVjdHVyZSBpcyBub3QgbWVhbnQgdG8gYmUgc2hhcmVkIHRvIHVz
ZXJzIGFzIGl0IGlzDQo+ICAgKiBtZWFudCBmb3IgYm9vayBrZWVwaW5nIGFuZCBwcml2YXRlIHRv
IE9QUCBsaWJyYXJ5Lg0KPiBAQCAtMTU2LDYgKzE1OCwxMCBAQCBzdHJ1Y3QgZGV2aWNlX29wcCB7
DQo+IA0KPiAgCXN0cnVjdCBkZXZpY2Vfbm9kZSAqbnA7DQo+ICAJdW5zaWduZWQgbG9uZyBjbG9j
a19sYXRlbmN5X25zX21heDsNCj4gKw0KPiArCS8qIEZvciBiYWNrd2FyZCBjb21wYXRpYmlsaXR5
IHdpdGggdjEgYmluZGluZ3MgKi8NCj4gKwl1bnNpZ25lZCBpbnQgdm9sdGFnZV90b2xlcmFuY2Vf
djE7DQo+ICsNCj4gIAlib29sIHNoYXJlZF9vcHA7DQo+ICAJc3RydWN0IGRldl9wbV9vcHAgKnN1
c3BlbmRfb3BwOw0KPiANCj4gLS0NCj4gMi4yNy4wDQoNCg==

--LqGm4j0SQAOY03gSAloO
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4913): https://lists.cip-project.org/g/cip-dev/message=
/4913
Mute This Topic: https://lists.cip-project.org/mt/75379083/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--LqGm4j0SQAOY03gSAloO--
