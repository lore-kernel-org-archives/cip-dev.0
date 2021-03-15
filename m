Return-Path: <SRS0=8rU/=IN=lists.cip-project.org=bounce+64572+6281+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8274C433E0
	for <cip-dev@archiver.kernel.org>; Mon, 15 Mar 2021 04:34:27 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51A8D64E37
	for <cip-dev@archiver.kernel.org>; Mon, 15 Mar 2021 04:34:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51A8D64E37
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hitachi.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6281+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id TsAdYY4521723xtH0JF0K4hq; Sun, 14 Mar 2021 21:34:26 -0700
X-Received: from esa13.hc514-86.ap.iphmx.com (esa13.hc514-86.ap.iphmx.com [207.54.83.110])
 by mx.groups.io with SMTP id smtpd.web12.4533.1615782864657322313
 for <cip-dev@lists.cip-project.org>;
 Sun, 14 Mar 2021 21:34:26 -0700
IronPort-SDR: noYWVjr5PTKs10yiwqfIPcoS/y1HDc/ZgF8xASpZYALTj6haXi6fkPWGlNS17+7CLuf37wswtS
 EpHzgB0OGZJ8jRVC/NzOiUUVYUfWC/PkGuJIHjbxlKz4vLhqymvvPi23S7+7bFh4mpYWa0apni
 LEbXaI0pEdX3J+HquFWGtmWRXMRWmFv5bcFkfxkQxc65xTKvwWnkAnMrCg7XHmSKleFRkDtiFP
 zXUg4HW/e3Hq9qFPVgBkS1mdWRrnHGKpPoxrfrygYRyOFj91p/YIOC4ViVNl372P74iB3v9I3u
 XNU=
X-IronPort-AV: E=Sophos;i="5.81,249,1610409600"; 
   d="scan'208";a="4871805"
X-Received: from mail10.maildeliv.hitachi.co.jp (HELO mail10.hitachi.co.jp) ([133.145.228.57])
  by ob1.hc514-86.ap.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 15 Mar 2021 04:34:20 +0000
X-Received: from mlsv9.hitachi.co.jp (unknown [133.145.228.43])
	by mail10.hitachi.co.jp (Postfix) with ESMTP id 9C0EA3C0093
	for <cip-dev@lists.cip-project.org>; Mon, 15 Mar 2021 13:34:19 +0900 (JST)
X-Received: from mfgw02.hitachi.co.jp by mlsv9.hitachi.co.jp (8.14.4/8.14.4) id 12F4YGQ6020496; Mon, 15 Mar 2021 13:34:19 +0900
X-Received: from GUjpTK3DCemcs26.global.hitachi.net ([158.213.250.27])
	by mfgw02.hitachi.co.jp with ESMTP
	id LevrlLUvexlpKLevrl9CJi; Mon, 15 Mar 2021 13:34:19 +0900
X-Received: from GUjpTKHDCemcs04.global.hitachi.net (2002:9ed5:d24d::9ed5:d24d)
 by GUjpTK3DCemcs26.global.hitachi.net (2002:9ed5:fa1b::9ed5:fa1b) with
 Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 15 Mar 2021 13:34:19 +0900
X-Received: from GUjpTKHDCemcs03.global.hitachi.net (2002:9ed5:d24c::9ed5:d24c)
 by GUjpTKHDCemcs04.global.hitachi.net (2002:9ed5:d24d::9ed5:d24d) with
 Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 15 Mar 2021 13:34:18 +0900
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (74.107.156.4) by
 GUjpTKHDCemcs03.global.hitachi.net (158.213.210.76) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2 via Frontend Transport; Mon, 15 Mar 2021 13:34:18
 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JzpNkaDSckYbY1riIvBlP9QIdiWxN0kXfAfOPGLj4HNWSedKzPqFoO28N52czTGEYHMdGucdZV8eoQDh70e6AWDjy2uKBXYRiHqNxQhwpPIN7PETJ+Vpjz0rbfKSxX+kItePv7LBv/ynDT8/xvm36wmb5exaxi6DsWuwV4+uLKdF9Tp6GcIcheR6JigDr5NhMIugh7lidQTP3XmJnXiDeQoCEhR/p28ISdVqzHsLWWLTaCV0arTXBlaODXEh1gxAwOgSHt3AvQPhsHAP8nRNb+TWsk1NUn88sb792xR2JspAhJs7JkGqg0fhIgFb/tClF0eqJeWUKdbllUESvfb0cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SwxkOt6hPDsq/vZEd/8dY/CwBwXuGioGF86lI3TqQ0M=;
 b=XpTGY/ddy0vEvV+fblyJ8sRVmV61D9T5khWArgq6FlEKnvdSkgpn2n8V5ty6bKI/VM10yH8bJBVhBUc3dKzpkhC7Tj1E4ZUrhx/zPp0HkCWonNV8mxiv46LkrnVha9OimA7uX1qqq8ZBvgOg52LefCysubrjAu7MnFn6BG84wl1vFqctE6dgstbiwW/fNlNBm/TxLvRf38cvCTiSfDW22laHGZqIzI1LF0cB/DwPy9lPA0XtAXzQh50SQl3vZJIJB9sR/mbwLPc04wrntGYN41mPly54hrtgzAxht9Wk+QdzxkUGRtM/sOCRSWxuwXrgQBP0WbelO/AVqIusbuZfhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hitachi.com; dmarc=pass action=none header.from=hitachi.com;
 dkim=pass header.d=hitachi.com; arc=none
X-Received: from TY2PR01MB2652.jpnprd01.prod.outlook.com (2603:1096:404:6b::9)
 by TYAPR01MB5900.jpnprd01.prod.outlook.com (2603:1096:404:8058::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Mon, 15 Mar
 2021 04:34:18 +0000
X-Received: from TY2PR01MB2652.jpnprd01.prod.outlook.com
 ([fe80::ec98:97f6:1862:ffbe]) by TY2PR01MB2652.jpnprd01.prod.outlook.com
 ([fe80::ec98:97f6:1862:ffbe%5]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 04:34:18 +0000
From: "Takuo Koguchi" <takuo.koguchi.sw@hitachi.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] Is cadence-quadspi working on cyclone V?
Thread-Topic: Re: [cip-dev] Is cadence-quadspi working on cyclone V?
Thread-Index: AdcZVD/VSKM4qaEJRM2U/V244oeK/Q==
Date: Mon, 15 Mar 2021 04:32:56 +0000
Deferred-Delivery: Mon, 15 Mar 2021 04:35:00 +0000
Message-ID: <TY2PR01MB26520E38F23C33EB2B59D539D76C9@TY2PR01MB2652.jpnprd01.prod.outlook.com>
Accept-Language: en-US, ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [202.246.252.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b8a0049a-2526-4d34-53f3-08d8e76b98d0
x-ms-traffictypediagnostic: TYAPR01MB5900:
x-microsoft-antispam-prvs: <TYAPR01MB59003D294068367AD445386AD76C9@TYAPR01MB5900.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0lnazXzQ1lZPJUe1f8HVL4ztbkgkgNyDSQ97M7kFNoMhsypka0DJnKt5OlgqzpqPq6wVaLLuzy539ZmqMCftnS1blvvfFr494lCAtXXOrTh3DBpU0bKueBeuBfSRWKG9/1fujoBcHEC2aC4jRDV6uyWBZWgfcSaJrftOZO5UZp1TaxqlNW7MKtZRFEV49/EkiNVyXZog/sDur77+UUXn2rDwkr6X8v5AXbQZIoQXZlySqo7rjQvYwcHxd9Rrv5HyGHJZGTzerON/pbTEYb9zlHj/ciNYADyAELeeAFxsVDM1kzYxP2jx3e1lvJfFHHDDk4uz6axhiJUmvnZ/a30wNcS4zDZm55xbQsGA8/c6cJhXR2sl/xVaGQqsW8R9MO5PkTCR5DqLah/YoGrTYhBqpSSv2BG1WuWHNYbzxg1caylBf7yj1UsKd9yDKHXSEJQ7qMIcm0jzADbi0eQo+1IIu49pypNAX3LluV4bFsl+kSmy3NIqKeRlP9CmqSUgRGNXf8xVSLpwN5yMfu48isPs7Bq2eDoA+iU+BZ1A47luC/GYzTOd/faLQDa3h3Zq8ve2honnI0F3jEw1TVusLFzZr+f8aRCCSksAVSKW0oDt6lugZt0LudqVZXUTb2QI6c2V40ZGZVDuippJ3jO3thM1Iw==
x-ms-exchange-antispam-messagedata: =?utf-8?B?djNEaTV4SFFiMkt2SEtzWDhUTWQyODQyU1VDYU1xc1FTWk5mWEY3QUJsWjlX?=
 =?utf-8?B?dWdQSXRyRlI0NkdHYVAzY0tONUs5NDYyOU0xb1RpdllWckhhUFJpMTNXYTZ5?=
 =?utf-8?B?OUtYc0U3M1F6QTdQaFpIODVkTC9IRVY4TmhPbFVwK1pBMS9raTF1bXdLUFFl?=
 =?utf-8?B?RUNNR0NlbUxyMkdWN05QQTMrbGNMMW5reXRTTDBNU2VyWnd0OGRveEVBdmtB?=
 =?utf-8?B?YzNvbWxGTGxsbVorNlB1UkxsU3F4NFNkaTJSbnVKdFFSU1grcXlPaEdkbXJk?=
 =?utf-8?B?UXo1OFdlMGczV1JORktLZFZiVFB4bHFUeitEaWpTMDJwcDgrdGFuTFNDa3RC?=
 =?utf-8?B?cUNTYkUzaFViU1JWM011K2dOYzZQTk5Pb2RMOFg3K1Yrd2VVZGs2RFZSVVhB?=
 =?utf-8?B?YjFXYXMzL0tUTTl1Q3psMXBrYVVDOXM2T29sM0V3bGcvWDRqZ0ZkN3JPK1da?=
 =?utf-8?B?c2tQMG9za1U3VVVVZ2Q0S3NPQjdDbG5RZXhGT1hGTEMwQUVKMWRmSjBzRE95?=
 =?utf-8?B?ajlhckVLWkxTeW5QN2JESVpyVUcwcWZpc2dld05JTlpnQmZjRG9FWEdoWjM2?=
 =?utf-8?B?NnV0Tit0NnVmc0xTRkcwdC9acWkxWmdVTkJCZEViUmxOM0ZVd0NnYnErMFJl?=
 =?utf-8?B?anhOSjJMa3FkNk0wTlhrUTZIbG9qWGU4cER6N0pvb2FKUDVQdjhlRjY0ZzhK?=
 =?utf-8?B?TXpnZUF5VVlpWUdWVUJiSXpYbGk5UEE2T00xTjVTRjlYY285TnpBS1VucXY2?=
 =?utf-8?B?WHlGcnFScjZyK1lHZVFIaXd3TmFPYTRoaWNKSktkODVaaTBGUGMrZ043WTFi?=
 =?utf-8?B?ZVNWNExNaXpVc3ZFQVRFUjZIR1ZDWE5MemR3d2lzclV4YlNRczVBVDArMk15?=
 =?utf-8?B?d3VzSUdiZExWWmZqSkFJUjRCRDFyWVFpWlBjNjUzQzhPcUNDYllNc1FJYzZZ?=
 =?utf-8?B?QzJaVG13Ti9ReWlvRjZBNGJWSGkrSnRCMTgwL0NMVWNIQ2lGTnB4L2dpZUNP?=
 =?utf-8?B?WjhwR2xuSEYrbnkzMGxlWTlIdEdpT0xKOWpseFFGNHhobE5MeWsxRWllRlFZ?=
 =?utf-8?B?OVFnZ1hRNlRFcGREYzNVbEpWR1BnSERYclRFN0pPSVFwc0RHMkZKZmZIdHVz?=
 =?utf-8?B?Q3RiTG15RjNOUzZHKzMwM0JRdURxenZjc09RM0l2Snc5WnFXaVRoaFdPbzZ5?=
 =?utf-8?B?bVBwRVY0RFFnTDVWUkFpdXR4SXhNczdXTVBMMzNKeW5MbmJXUk45S0l0aW9R?=
 =?utf-8?B?NVd5WHpNZ2lZME0vYncydFgyL3hJaHlld3ZDWW9QMEhEZ0VDU00vNlBYNlFi?=
 =?utf-8?B?YVgwZ1kvY1BpUm9jWFJ5U0lxM2ZoUjIxSDgyL3Y0Kzlibll1bFlYM0ZUUndy?=
 =?utf-8?B?YnoxQ2FCZTJPb0lRZWMxbzV5Q014bUNobFhCRnBDVUREVVo0dklzeVNlZGhZ?=
 =?utf-8?B?UzgwTUN6WUd0YVJSWUZTNmF5UGl2NDZyUmxnVzFBLzRMUS8zUURUS2RSSnBx?=
 =?utf-8?B?K0pmdUxUajVXYy9HaVhxd2VCYktaQzZZanZLdy9Sd1F0ck8rem1GR3FaekFx?=
 =?utf-8?B?a2grMml5a2dDVGlmL3Fhc1p2ZGMzMDM4N3NvaW9nRnp0S2xmZGZzQjNOMkVh?=
 =?utf-8?B?UlRZdDByR2tYbExRRTJacytTQjdMR3gzeE9BN2QwYkFwcEoraCtEbjRFU0tW?=
 =?utf-8?B?dUJuVXVxc0pyR3M2cHhEaTlxeXlSUTZuZkpGQ2FKVGFKWkltZnA4NmRscjVH?=
 =?utf-8?Q?pKnm17n6Aor8r+jo903Hj/ZZ0ob1iSGaFw1myxz?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB2652.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8a0049a-2526-4d34-53f3-08d8e76b98d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2021 04:34:18.2802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f54277c9-dafe-44aa-85a4-73d5c7c52450
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6r/iNiO9U00RWOfC6cPvJq0syH44UVVeRC37cIv7TzaVzScAoLSlZX3/UBdziH1l7UUd0f+sOrsJwN7AFWACi15HX6TKkg9u4gOHc6Teh5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5900
X-OriginatorOrg: hitachi.com
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: uvQMrIyqRdbeFEPqJdiEW7Wdx4520388AA=
Content-Type: multipart/mixed; boundary="5tK9qig9JkBJaU5kSxZD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1615782866;
 bh=EUb4G2a91/WVUtb2t5wTAZyTYjcnVPfNW4QzFD8IexU=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=qLaaJddg4mfBcq3JY72dGj8Hd0oOXYHQ60hdeX5ZivVkTqQItv6xUv3fzdp0Wv5wX+P
 pa6eVTp3ANWeLYNa0yAnzOdjXGQ+vHgvCvhJouMzwxB4mXUkdaWg13iJqi/ABYLmlHC6F
 xN7SH/2RzJM3pgITjJqoghRnPy9Lc2JkiNM=

--5tK9qig9JkBJaU5kSxZD
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgUGF2ZWwsDQoNCj4gPj4gR2l0IGJpc2VjdCBoYXMgdG9sZCBtZSB0aGUgZmlyc3QgYmFkIGNv
bW1pdCBpcw0KPiA+PiAzMWZiNjMyYjVkNDMgc3BpOiBNb3ZlIGNhZGVuY2UtcXVhZHNwaSBkcml2
ZXIgdG8gZHJpdmVycy9zcGkvDQo+ID4NCj4gPiBUaGF0J3Mgc3RyYW5nZS4NCj4gPg0KPiA+PiBE
b2VzIHRoaXMgY2hhbmdlIHJlcXVpcmVzIGRldmljZSB0cmVlIG1vZGlmaWNhdGlvbj8NCj4gPj4g
QW55IHN1Z2dlc3Rpb25zIG9yIGNvbW1lbnRzIHdvdWxkIGJlIGFwcHJlY2lhdGVkLg0KPiA+DQo+
ID4gLi4uYmVjYXVzZSB0aGF0IHBhcnRpY3VsYXIgY2hhbmdlIGRvZXMgbm90IGNoYW5nZSBhbnkg
QyBjb2RlLiBCdXQgaXQNCj4gPiB0b3VjaGVzIEtjb25maWcgYml0czsgY2FuIHlvdSBjaGVjayB0
aGF0IENPTkZJR19TUElfQ0FERU5DRV9RVUFEU1BJIGlzDQo+ID4gZW5hYmxlZCBpbiB0aGUgImJh
ZCIgY29uZmlndXJhdGlvbj8NCj4gPg0KPiA+IERvIHlvdSBoYXZlIGFueSBsb2NhbCBjaGFuZ2Vz
IGluDQo+ID4gZHJpdmVycy9tdGQvc3BpLW5vci9jb250cm9sbGVycy9jYWRlbmNlLXF1YWRzcGku
YyBvcg0KPiA+IGRyaXZlcnMvc3BpL3NwaS1jYWRlbmNlLXF1YWRzcGkuYyA/DQo+IEkgaGF2ZSBu
byBsb2NhbCBjaGFuZ2VzIHRvIHRob3NlIGZpbGVzLg0KPiBNYXliZSBJIGxvc3QgQ09ORklHX1NQ
SV9DQURFTkNFX1FVQURTUEkgYWNjaWRlbnRhbGx5IHdoaWxlIGJpc2VjdGluZy4NCj4gSSB3aWxs
IHRyeSBiaXNlY3QgYW5kIHBvc3QgdGhlIHJlc3VsdCBhZ2Fpbi4NCj4NCg0KSSByZWRvIHRoZSBi
aXNlY3QgYW5kIGdldCB0aGUgZm9sbG93aW5nIHJlc3VsdDsgDQojIGZpcnN0IGJhZCBjb21taXQ6
IFthMzE0ZjYzNjc3ODdlZTFkNzY3ZGY5YTIxMjBmMTdlNDUxMTE0NGQwXSBtdGQ6IHNwaS1ub3I6
IENvbnZlcnQgY2FkZW5jZS1xdWFkc3BpIHRvIHVzZSBzcGktbWVtIGZyYW1ld29yaw0KDQpJdCBj
b250YWlucyBzaWduaWZpY2FudCBhbW91bnQgb2YgY2hhbmdlczsNCg0KY2FkZW5jZS1xdWFkc3Bp
LmMgfCAgNDc2ICsrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxOTEgaW5zZXJ0aW9ucygrKSwgMjg1IGRlbGV0aW9u
cygtKQ0KDQpXaXRoIHRoaXMgY2hhbmdlLCBjcHNwaV9wcm9iZSByZXR1cm4gMCB3aXRob3V0IGFu
eSBlcnJvciBtZXNzYWdlcywgYnV0IGl0IGRvZXMgbm90IGRldGVjdCBOT1IgZmxhc2ggb24gYSBj
dXN0b20gY3ljbG9uZSBWIGJvYXJkLiANCg0KQW55IGluZm9ybWF0aW9uIHdpbGwgYmUgYXBwcmVj
aWF0ZWQuDQoNClRoYW5rcywNCg0KVGFrdW8gS29ndWNoaQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+IEZyb206IOWwj+WPo+eQouWkqyAvIEtPR1VDSEnvvIxUQUtVTw0KPiBTZW50
OiBTdW5kYXksIE1hcmNoIDE0LCAyMDIxIDQ6MzcgUE0NCj4gVG86IGNpcC1kZXZAbGlzdHMuY2lw
LXByb2plY3Qub3JnDQo+IFN1YmplY3Q6IFJlOiBbIV1SZTogW2NpcC1kZXZdIElzIGNhZGVuY2Ut
cXVhZHNwaSB3b3JraW5nIG9uIGN5Y2xvbmUgVj8NCj4gDQo+IEhpIFBhdmVsLA0KPiBUaGFuayB5
b3UgZm9yIHRoZSByZXNwb25zZS4NCj4gDQo+ID4+IEdpdCBiaXNlY3QgaGFzIHRvbGQgbWUgdGhl
IGZpcnN0IGJhZCBjb21taXQgaXMNCj4gPj4gMzFmYjYzMmI1ZDQzIHNwaTogTW92ZSBjYWRlbmNl
LXF1YWRzcGkgZHJpdmVyIHRvIGRyaXZlcnMvc3BpDQo+ID4NCj4gPiBUaGF0J3Mgc3RyYW5nZS4N
Cj4gPg0KPiA+PiBEb2VzIHRoaXMgY2hhbmdlIHJlcXVpcmVzIGRldmljZSB0cmVlIG1vZGlmaWNh
dGlvbj8NCj4gPj4gQW55IHN1Z2dlc3Rpb25zIG9yIGNvbW1lbnRzIHdvdWxkIGJlIGFwcHJlY2lh
dGVkLg0KPiA+DQo+ID4gLi4uYmVjYXVzZSB0aGF0IHBhcnRpY3VsYXIgY2hhbmdlIGRvZXMgbm90
IGNoYW5nZSBhbnkgQyBjb2RlLiBCdXQgaXQNCj4gPiB0b3VjaGVzIEtjb25maWcgYml0czsgY2Fu
IHlvdSBjaGVjayB0aGF0IENPTkZJR19TUElfQ0FERU5DRV9RVUFEU1BJIGlzDQo+ID4gZW5hYmxl
ZCBpbiB0aGUgImJhZCIgY29uZmlndXJhdGlvbj8NCj4gPg0KPiA+IERvIHlvdSBoYXZlIGFueSBs
b2NhbCBjaGFuZ2VzIGluDQo+ID4gZHJpdmVycy9tdGQvc3BpLW5vci9jb250cm9sbGVycy9jYWRl
bmNlLXF1YWRzcGkuYyBvcg0KPiA+IGRyaXZlcnMvc3BpL3NwaS1jYWRlbmNlLXF1YWRzcGkuYyA/
DQo+IEkgaGF2ZSBubyBsb2NhbCBjaGFuZ2VzIHRvIHRob3NlIGZpbGVzLg0KPiBNYXliZSBJIGxv
c3QgQ09ORklHX1NQSV9DQURFTkNFX1FVQURTUEkgYWNjaWRlbnRhbGx5IHdoaWxlIGJpc2VjdGlu
Zy4NCj4gSSB3aWxsIHRyeSBiaXNlY3QgYW5kIHBvc3QgdGhlIHJlc3VsdCBhZ2Fpbi4NCj4gDQo+
IFJlZ2FyZHMsDQo+IA0KPiBUYWt1byBLb2d1Y2hpDQo+IA0KPiA+IDIwMjEvMDMvMTMgODowN+OA
gVBhdmVsIE1hY2hlayA8cGF2ZWxAZGVueC5kZT7jga7jg6Hjg7zjg6s6DQo+ID4NCj4gPiDvu79I
aSENCj4gPg0KPiA+PiBHaXQgYmlzZWN0IGhhcyB0b2xkIG1lIHRoZSBmaXJzdCBiYWQgY29tbWl0
IGlzDQo+ID4+IDMxZmI2MzJiNWQ0MyBzcGk6IE1vdmUgY2FkZW5jZS1xdWFkc3BpIGRyaXZlciB0
byBkcml2ZXJzL3NwaS8NCj4gPg0KPiA+IFRoYXQncyBzdHJhbmdlLg0KPiA+DQo+ID4+IERvZXMg
dGhpcyBjaGFuZ2UgcmVxdWlyZXMgZGV2aWNlIHRyZWUgbW9kaWZpY2F0aW9uPw0KPiA+PiBBbnkg
c3VnZ2VzdGlvbnMgb3IgY29tbWVudHMgd291bGQgYmUgYXBwcmVjaWF0ZWQuDQo+ID4NCj4gPiAu
Li5iZWNhdXNlIHRoYXQgcGFydGljdWxhciBjaGFuZ2UgZG9lcyBub3QgY2hhbmdlIGFueSBDIGNv
ZGUuIEJ1dCBpdA0KPiA+IHRvdWNoZXMgS2NvbmZpZyBiaXRzOyBjYW4geW91IGNoZWNrIHRoYXQg
Q09ORklHX1NQSV9DQURFTkNFX1FVQURTUEkgaXMNCj4gPiBlbmFibGVkIGluIHRoZSAiYmFkIiBj
b25maWd1cmF0aW9uPw0KPiA+DQo+ID4gRG8geW91IGhhdmUgYW55IGxvY2FsIGNoYW5nZXMgaW4N
Cj4gPiBkcml2ZXJzL210ZC9zcGktbm9yL2NvbnRyb2xsZXJzL2NhZGVuY2UtcXVhZHNwaS5jIG9y
DQo+ID4gZHJpdmVycy9zcGkvc3BpLWNhZGVuY2UtcXVhZHNwaS5jID8NCj4gPg0KPiA+IEJlc3Qg
cmVnYXJkcywNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgUGF2ZWwNCj4gPiAt
LQ0KPiA+IERFTlggU29mdHdhcmUgRW5naW5lZXJpbmcgR21iSCwgICAgICBNYW5hZ2luZyBEaXJl
Y3RvcjogV29sZmdhbmcgRGVuaw0KPiA+IEhSQiAxNjUyMzUgTXVuaWNoLCBPZmZpY2U6IEtpcmNo
ZW5zdHIuNSwgRC04MjE5NCBHcm9lYmVuemVsbCwgR2VybWFueQ0KPiA+DQo+ID4gDQo+ID4NCg==

--5tK9qig9JkBJaU5kSxZD
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6281): https://lists.cip-project.org/g/cip-dev/message=
/6281
Mute This Topic: https://lists.cip-project.org/mt/81272003/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--5tK9qig9JkBJaU5kSxZD--
