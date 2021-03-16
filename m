Return-Path: <SRS0=cpqx=IO=lists.cip-project.org=bounce+64572+6286+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5BCC433E0
	for <cip-dev@archiver.kernel.org>; Tue, 16 Mar 2021 05:55:29 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A63D650A5
	for <cip-dev@archiver.kernel.org>; Tue, 16 Mar 2021 05:55:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A63D650A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hitachi.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6286+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id m2rsYY4521723xNFGgFOfXKE; Mon, 15 Mar 2021 22:55:28 -0700
X-Received: from esa15.hc514-86.ap.iphmx.com (esa15.hc514-86.ap.iphmx.com [207.54.75.18])
 by mx.groups.io with SMTP id smtpd.web10.4664.1615874123614380846
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Mar 2021 22:55:28 -0700
IronPort-SDR: hSUd0v1pk4R4ZMFzxitsx3z2CZ+yiFrfwmEy3vI+E7dw31fhlwPkeGSLsgzUyh1q3M3HlHQybf
 0Y1qu0E7j8X8vT3nO5ndB6hE2VZ8yGdVkyUtrXRdFBb4zbr/sa7sMSnWS8FSWAEpERd9W5pNAD
 yNubnA5XJYSHbM7LKcYgCTBKe/fd18MPuKm+WnFk8Bq4AkRNRimGEcxQknreQw0/aAXJiV+oG+
 9YXnR3ncVqHApdRi+LWo5LF2rGDadQoIkCiVQqg+wCmP+f0M5E+NZBjybbJX0nZJmGkFaPXBBE
 /2A=
X-IronPort-AV: E=Sophos;i="5.81,251,1610409600"; 
   d="scan'208";a="5992827"
X-Received: from mail10.maildeliv.hitachi.co.jp (HELO mail10.hitachi.co.jp) ([133.145.228.57])
  by ob1.hc514-86.ap.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 16 Mar 2021 05:55:20 +0000
X-Received: from mlsv9.hitachi.co.jp (unknown [133.145.228.43])
	by mail10.hitachi.co.jp (Postfix) with ESMTP id B99E63C004F
	for <cip-dev@lists.cip-project.org>; Tue, 16 Mar 2021 14:55:20 +0900 (JST)
X-Received: from mfgw05.hitachi.co.jp by mlsv9.hitachi.co.jp (8.14.4/8.14.4) id 12G5tKNv027416; Tue, 16 Mar 2021 14:55:20 +0900
X-Received: from GUjpTK3DCemcs56.global.hitachi.net ([158.213.250.57])
	by mfgw05.hitachi.co.jp with ESMTP
	id M2folLdPb0nJkM2fol5MUB; Tue, 16 Mar 2021 14:55:20 +0900
X-Received: from GUjpTKHDCemcs07.global.hitachi.net (2002:9ed5:d274::9ed5:d274)
 by GUjpTK3DCemcs56.global.hitachi.net (2002:9ed5:fa39::9ed5:fa39) with
 Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 16 Mar 2021 14:55:20 +0900
X-Received: from GUjpTKHDCemcs06.global.hitachi.net (2002:9ed5:d273::9ed5:d273)
 by GUjpTKHDCemcs07.global.hitachi.net (2002:9ed5:d274::9ed5:d274) with
 Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 16 Mar 2021 14:55:19 +0900
X-Received: from APC01-SG2-obe.outbound.protection.outlook.com (74.107.156.4) by
 GUjpTKHDCemcs06.global.hitachi.net (158.213.210.115) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2 via Frontend Transport; Tue, 16 Mar 2021 14:55:19
 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0UB9cJfH2pNgezJbRk9G6hLSdzpocVSI2rVowoJMy5CHgajWzMcllZb22IsgWd1+4AQWoqFQk1Y1ScRuzAuSbK6Z56uhvldUYBP4OaLBm/MfVzDINhEjj+A8SgwW4kPl5lm3FwUdKRbELcqFB5HWkATGSRoqGFWfV9KDaPytGEL9noKEZViWjzb571PRGv04oKY11vyVqMrO4nCN8MN7D0y1yS83GwpKoGO3z7f/jW/dbOis/o4/8259ei7QurgYdOSrtnd7F0WOitR34yc3Qs0j4UxJMewy6mhigWOFiIBBafoKi+iFy4hw+tgWlZtb2GQG0kdUDh64D4lshX2WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwrKuJPvYZyyS73FXUX/lSeadeJF6FHGuvIs9JmLa/0=;
 b=dO/xm1GOZs14pU/ICBQoqtAHeqZpL235I7iY7rhYLcD/ysWW6CRlfrx5RGPvheUab1Q3OqkAtqcpyYk7CG2etCs2AGtKB/6LK6cp5PKuMNwTLFuM/ojr5zpcSK93znxagI3a2HoW3NX49M+xx/xF8MzZL+o/9n3niLfwhNPmkj7klUAUxyY7EuJqRYCRT2riYWMXLUcuHR2PtS71ur7byxNoKVRgukN7RPCJLe0EiVy0bfRB27lQAuik1pF+mLcybe1XiqobrZ1MDASm1SFIpGFCmPvlHXU96dVsl26o66aL0YHmnccUl4ODKJtWnEfmdcSpiZWdziHMPGnj700bvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hitachi.com; dmarc=pass action=none header.from=hitachi.com;
 dkim=pass header.d=hitachi.com; arc=none
X-Received: from TY2PR01MB2652.jpnprd01.prod.outlook.com (2603:1096:404:6b::9)
 by TY2PR01MB4650.jpnprd01.prod.outlook.com (2603:1096:404:112::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Tue, 16 Mar
 2021 05:55:18 +0000
X-Received: from TY2PR01MB2652.jpnprd01.prod.outlook.com
 ([fe80::ec98:97f6:1862:ffbe]) by TY2PR01MB2652.jpnprd01.prod.outlook.com
 ([fe80::ec98:97f6:1862:ffbe%5]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 05:55:18 +0000
From: "Takuo Koguchi" <takuo.koguchi.sw@hitachi.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] Is cadence-quadspi working on cyclone V?
Thread-Topic: [cip-dev] Is cadence-quadspi working on cyclone V?
Thread-Index: AQHXGVunJvUQHMbyG0CdjS8GLoLB7qqEhYBAgAGUoCA=
Date: Tue, 16 Mar 2021 05:54:06 +0000
Deferred-Delivery: Tue, 16 Mar 2021 05:56:00 +0000
Message-ID: <TY2PR01MB265226A437983436C55911ADD76B9@TY2PR01MB2652.jpnprd01.prod.outlook.com>
References: <TY2PR01MB26520E38F23C33EB2B59D539D76C9@TY2PR01MB2652.jpnprd01.prod.outlook.com>
 <OSBPR01MB2983A8AF3568F39D2D1DE455926C9@OSBPR01MB2983.jpnprd01.prod.outlook.com>
 <TY2PR01MB2652FC36002EB35C347B19C1D76C9@TY2PR01MB2652.jpnprd01.prod.outlook.com>
In-Reply-To: <TY2PR01MB2652FC36002EB35C347B19C1D76C9@TY2PR01MB2652.jpnprd01.prod.outlook.com>
Accept-Language: en-US, ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [202.246.252.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4525022e-f7c8-4599-1486-08d8e840140f
x-ms-traffictypediagnostic: TY2PR01MB4650:
x-microsoft-antispam-prvs: <TY2PR01MB4650F28FCAA0411691F316ABD76B9@TY2PR01MB4650.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: o961RsuDCgmzJHufz2gW+VY+66gCa83wBsVI9iOKVSoOd4SvIgHI25MQD2UVw599I49BaGozsgmyNT6pW7Av2W8tUnyew18Tlvnnx3q/Lm/ZA3t3AEhdioa+i+RTPLIfn8liO8JCU/UxqflF+ROoS2Gz6M74+yZPsKkREMxIS/PENL7XRCqd1gfmmXGVBLBCvEtbexe3FqjSemP/60h9tYli9ffeVhlsVWKaKJHn7Xs155VToYUaovhCjHqpQbCZAIP7nD4UNs38c9DjkYx3IOMXe1BjBZ6V7QyPhCfvsol4hMOoxEdlhuK8eKIhCG7Y6WMdHJy27eg8WRxYMq9/Y/VLr7W9uN5xHZDBGoNus2E2z6a8ZWt0+8yITngKriHB+2mBqCg2IxA8Fsg3VSXsFJ0okAzvYvhTUxNqSTGVKOrwfRxY4d3tXD+PDtgGHnHDCSrhOQzIRpAAza3oDpNUlb0LuweL/t/L3/NkFcLsTSSJtXfZuuZNSuIpX1Na+E+AGxDN/SGtj6owVAFFhpdfVkRaL6sKzBhnHxjdz1ekumsXLEDpXuIBDj0M5UA+wBt1V8QFWtqUcxJwPZPNkk2gLvAH/MsS/lYLo2ZVb1G7fSQpy2p4q6H3xNqfe0YYLxAUdkgb2Ang1CyjdgVv8ShsvQ==
x-ms-exchange-antispam-messagedata: =?utf-8?B?MmFCOW81QXJLK2pBaXVIQnBEaFJTTnM1RnZVcXlUN3J0MnNhWmRHTlo3K0FU?=
 =?utf-8?B?d1YvLzl5dUF2L1Q5T0JiTTNSdEsrOTN6VTJ0SmVWSTd1U3FjK0Y2aWlSUk10?=
 =?utf-8?B?NHEwK2FscXkzUmtVOVNJcHdhTXRYTS9lZFBreEdxeFhnQ0lhTW8yQ3RJYThp?=
 =?utf-8?B?ejlPMGs3Y2o3ZW1mdFJDWDdHLzdPYlhQY0JnTFFHanhjUmpoK2lCOWRxRlVI?=
 =?utf-8?B?YTZpZ0dkY2FLdWc5bS9xR0JwanI3RURPbEIySE1QKzBUMUJ5NDNUaDB1T2x4?=
 =?utf-8?B?NDI5Wm80eERPSW5TK0dBYVFseWVvMlpKOG5yOHJ3bzNTS1laaFRBYzh4bWRo?=
 =?utf-8?B?cThzOW82dVJoWU11NkxYamRZMzJLMDg1ZklMRE9tU05JV2JpRzZkQ2EzRW5X?=
 =?utf-8?B?NU9qdFQzTFB3cU8yenNzRVgyYkt4Y1N6dC8xeTJuWjNuTUp3NFpJdU5jY2lw?=
 =?utf-8?B?aVdSV0hsSktrNG03ek9KY0ZibW9MR3Y1UUtNR1AxMlZtb1QzK1M3VkgxeFgr?=
 =?utf-8?B?SHFoQUZRUEtUL084N0swT0JMa01LSHBpc1J6RlYrOURIZWIxMk1NVmVIM1Ev?=
 =?utf-8?B?Q3hYa2JiMllvWXVEb09sTTl2Tm1oRXR3SVMrWlZqaVRyYjJERmZpYmREY2tu?=
 =?utf-8?B?K0RhZi9kcVdDaWRKSXpHeG5jemVtMko5YUppdDlDQTFQZjljTWNKY1plVXNn?=
 =?utf-8?B?WkIvWXp5L2FtcGRaOXg5U0lhc3dxZ3lQMXhJMUVIU3pPQVVPRVh5Qnl2RXJY?=
 =?utf-8?B?TDJTVUFOS2JYejBoUWd3c21JQ0lZckZMTThEOHZMMXNjSUFZMjZqQzdLSUN3?=
 =?utf-8?B?YmlFVHBBTVE1MmdnanpIV3hPanc0cFJhNUxqR3psL3YzQlZmNGUwQTFjUndC?=
 =?utf-8?B?RDdwN3lzT28xSmN1Y3ZvaURRTE9CWHhIQkxyTE4zRlRVTlMxTGFwZXN4c1Fs?=
 =?utf-8?B?NHhxSWI1dENkR3hTSmc2ZVZoQTVEZGV5am5PMjg0Vm53Z1U4cmNjSTdaNTJv?=
 =?utf-8?B?Q25qMnRLaXlSWURBaW9HcDRVWlFtRjJvK1VFRWhEaDZkUkU1ZHNjVlU1azI3?=
 =?utf-8?B?V3Y3OWtZZzFaRW5UOC8xOEU3ckUrVDZWV2lXeDYxN3JZZGxDSGVkcnM5Y3RR?=
 =?utf-8?B?cGVERkRRaFg2T0tVajV6b1o5NkF3STFibHgya2haWG5LNXI3OGFSSHN5bHph?=
 =?utf-8?B?bU5zcHBQU1ZTMUdZTG1hTWVMeFhmZTZYWTY2RHZmQy9qVFRHenZlSGRXdFNk?=
 =?utf-8?B?UnVuTUpWOEcrMzFERDYzb1VtU3RnUzhVemFBSnAreUxiZkhBbWRnbW9iUGl4?=
 =?utf-8?B?eXdXK0Vyb3hWTUFtV1hKU2pGUE14YkNNWjZQNWg3QXFZUVBFWGVnTTZQQ2dH?=
 =?utf-8?B?WXhMY2VJMDIwRm4xTXBoTGNtNVZDYmhJQnFCRlNWWnIrOXhJRUlxQzBBWkh6?=
 =?utf-8?B?SGZPckFGSmJkQzMrUFBzSnAySHFLOWFYOVV1OXl2MzM4Q1E5OURBbE9NNi9m?=
 =?utf-8?B?OFA4bU1oZ0pFTS9ya0NUUTB4OXJFR3BkYks1ajhPSkw3UXRSQS90eXNFRHhN?=
 =?utf-8?B?RUw2VWdrdmxvakFmQ1lYU3BieWo2V2ZJSWlvL2VsbVlCZ0ZGTUhaMkFhYm1X?=
 =?utf-8?B?OEwyeGZCTW9zZUV4M20wZnY0c2M2d0NzVk5YQVBvZ3VvNWxoTzVpbTZWbHlS?=
 =?utf-8?B?dFJIM051ZGtidXoxVWVJR21SdHZyTXovK0xIZTZBUmpJWmQ1VlNSMmpwVXRU?=
 =?utf-8?Q?5TgM4wtSx5fe6ZCnHOMHhNa5f92dPt1rah0FTd+?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB2652.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4525022e-f7c8-4599-1486-08d8e840140f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2021 05:55:18.3509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f54277c9-dafe-44aa-85a4-73d5c7c52450
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0/+UjKXGVohiSABuwWjf2S036XZL2tqNtR/66eXp9CiZFX3DKZMDeHJH7IafZh1cas8JrRmcO5wbo9dsbG1patOf0D2Nl3m+itIbJc2MIeI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4650
X-OriginatorOrg: hitachi.com
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: x7iX7jDgiQmQubTWRdu8DFbRx4520388AA=
Content-Type: multipart/mixed; boundary="GxoCbNL3D625zpBXiJUj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1615874128;
 bh=66hGTALHilvysMI9/EJQD6kVbwjjPN/LGbdOuNFoxzs=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=oIG3dgVXUnw3uY8oFpbYm/q3Kq7o9pOM7Ni0oeO/8YZ+KWxqe2VsDAYBBWz+qn8oYKj
 I+OadkGfM2oc64wCop9WBlf9BGtT0DS0NMN64LfLECWyjWgyYiMWVibyqSDONc38OPb2H
 CWNDb8dZyQNnRL/od4tLebbGHSpCrNcNu78=

--GxoCbNL3D625zpBXiJUj
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SXdhbWF0c3Utc2FuLA0KDQo+ID4gSXQgcmVjb2duaXplcyBOT1IgZmxhc2ggaW4gNS4xMC55LiBI
b3cgYWJvdXQgY2hlY2tpbmcgRFRTPw0KPiA+IFNvZGlhIGJvYXJkIHVzZXMgbjI1cTUxMmEgYW5k
IGhhcyB0aGUgZm9sbG93aW5nIERUOg0KPiA+IGBgYA0KPiA+ICZxc3BpIHsNCj4gPiAJc3RhdHVz
ID0gIm9rYXkiOw0KPiA+DQo+ID4gCWZsYXNoMDogbjI1cTUxMmFAMCB7DQo+ID4gCQkjYWRkcmVz
cy1jZWxscyA9IDwxPjsNCj4gPiAJCSNzaXplLWNlbGxzID0gPDE+Ow0KPiA+IAkJY29tcGF0aWJs
ZSA9ICJuMjVxNTEyYSI7DQo+ID4gCQlyZWcgPSA8MD47DQo+ID4gCQlzcGktbWF4LWZyZXF1ZW5j
eSA9IDwxMDAwMDAwMDA+Ow0KPiA+DQo+ID4gCQltMjVwLGZhc3QtcmVhZDsNCj4gPiAJCWNkbnMs
cGFnZS1zaXplID0gPDI1Nj47DQo+ID4gCQljZG5zLGJsb2NrLXNpemUgPSA8MTY+Ow0KPiA+IAkJ
Y2RucyxyZWFkLWRlbGF5ID0gPDQ+Ow0KPiA+IAkJY2Rucyx0c2hzbC1ucyA9IDw1MD47DQo+ID4g
CQljZG5zLHRzZDJkLW5zID0gPDUwPjsNCj4gPiAJCWNkbnMsdGNoc2gtbnMgPSA8ND47DQo+ID4g
CQljZG5zLHRzbGNoLW5zID0gPDQ+Ow0KPiA+IAl9O3QNCj4gPiB9Ow0KPiA+IGBgYA0KPiBJIGFt
IGdvaW5nIHRvIGxvb2sgaW50byB0aGUgZGlmZmVyZW5jZS4NCg0KSSBjb25maXJtZWQgdGhhdCAi
bjI1cTUxMmEiIGluIHRoZSBub2RlIG5hbWUgYW5kIHRoZSBjb21wYXRpYmxlIHN0cmluZyBhcmUg
dGhlIG9ubHkgZGlmZmVyZW5jZS4NCkludGVyZXN0aW5nbHksIGlmIEkgdXNlZCBjb21wYXRpYmxl
ID0gIm4yNXE1MTJhIiBpbnN0ZWFkIG9mIGNvbXBhdGlibGUgPSAiczI1ZmwxMjhzMSIgb3IgInMy
NWZsMTI4cyIsDQp3aGljaCBpcyB0aGUgY3VycmVudCBzZXR0aW5nIGZvciBsaW51eC00LjE5LjE3
Ny1jaXAsIA0KdGhlIGtlcm5lbCBwcmludHMgdGhlIGZvbGxvd2luZyBtZXNzYWdlIGFuZCBpcyBh
YmxlIHRvIGRldGVjdCBzcGktbm9yIGZsYXNoIGFzIGV4cGVjdGVkLg0KDQpbICAgIDIuNzAxMjk0
XSBzcGktbm9yIHNwaTAuMDogZm91bmQgczI1ZmwxMjhzMSwgZXhwZWN0ZWQgbjI1cTUxMmENClsg
ICAgMi43MTEwOTNdIHNwaS1ub3Igc3BpMC4wOiBzMjVmbDEyOHMxICgxNjM4NCBLYnl0ZXMpDQoN
ClByb2JhYmx5IHRoZSBkZXRlY3QgbWVjaGFuaXNtIGhhcyBiZWVuIGNoYW5nZWQgYnkgdGhlIGNv
bW1pdC4NCkFwcGFyZW50bHkgc2V0dGluZyBjb21wYXRpYmxlID0gIm4yNXE1MTJhIiBmb3IgbXkg
Ym9hcmQgZG9lcyBub3QgbWFrZSBzZW5zZS4gIEknZCBsaWtlIHRvIGZpbmQgb3V0IHdoeSANCmNv
bXBhdGlibGUgPSAiczI1ZmwxMjhzMSIgZG9lcyBub3Qgd29yay4NCg0KUmVnYXJkcywNCg0KVGFr
dW8gS29ndWNoaQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IOWwj+WP
o+eQouWkqyAvIEtPR1VDSEnvvIxUQUtVTw0KPiBTZW50OiBNb25kYXksIE1hcmNoIDE1LCAyMDIx
IDI6MzEgUE0NCj4gVG86IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnDQo+IFN1YmplY3Q6
IFJFOiBbY2lwLWRldl0gSXMgY2FkZW5jZS1xdWFkc3BpIHdvcmtpbmcgb24gY3ljbG9uZSBWPw0K
PiANCj4gSXdhbWF0c3Utc2FuLA0KPiANCj4gVGhhbmsgeW91IGZvciB0aGUgaW5mb3JtYXRpb24u
DQo+ID4gSXQgcmVjb2duaXplcyBOT1IgZmxhc2ggaW4gNS4xMC55LiBIb3cgYWJvdXQgY2hlY2tp
bmcgRFRTPw0KPiA+IFNvZGlhIGJvYXJkIHVzZXMgbjI1cTUxMmEgYW5kIGhhcyB0aGUgZm9sbG93
aW5nIERUOg0KPiA+IGBgYA0KPiA+ICZxc3BpIHsNCj4gPiAJc3RhdHVzID0gIm9rYXkiOw0KPiA+
DQo+ID4gCWZsYXNoMDogbjI1cTUxMmFAMCB7DQo+ID4gCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsN
Cj4gPiAJCSNzaXplLWNlbGxzID0gPDE+Ow0KPiA+IAkJY29tcGF0aWJsZSA9ICJuMjVxNTEyYSI7
DQo+ID4gCQlyZWcgPSA8MD47DQo+ID4gCQlzcGktbWF4LWZyZXF1ZW5jeSA9IDwxMDAwMDAwMDA+
Ow0KPiA+DQo+ID4gCQltMjVwLGZhc3QtcmVhZDsNCj4gPiAJCWNkbnMscGFnZS1zaXplID0gPDI1
Nj47DQo+ID4gCQljZG5zLGJsb2NrLXNpemUgPSA8MTY+Ow0KPiA+IAkJY2RucyxyZWFkLWRlbGF5
ID0gPDQ+Ow0KPiA+IAkJY2Rucyx0c2hzbC1ucyA9IDw1MD47DQo+ID4gCQljZG5zLHRzZDJkLW5z
ID0gPDUwPjsNCj4gPiAJCWNkbnMsdGNoc2gtbnMgPSA8ND47DQo+ID4gCQljZG5zLHRzbGNoLW5z
ID0gPDQ+Ow0KPiA+IAl9Ow0KPiA+IH07DQo+ID4gYGBgDQo+IEkgYW0gZ29pbmcgdG8gbG9vayBp
bnRvIHRoZSBkaWZmZXJlbmNlLg0KPiANCj4gVGFrdW8gS29ndWNoaQ0KPiANCj4gPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qu
b3JnIDxjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4gT24NCj4gPiBCZWhhbGYgT2YgTm9i
dWhpcm8gSXdhbWF0c3UNCj4gPiBTZW50OiBNb25kYXksIE1hcmNoIDE1LCAyMDIxIDI6MjUgUE0N
Cj4gPiBUbzogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcNCj4gPiBTdWJqZWN0OiBbIV1S
ZTogW2NpcC1kZXZdIElzIGNhZGVuY2UtcXVhZHNwaSB3b3JraW5nIG9uIGN5Y2xvbmUgVj8NCj4g
Pg0KPiA+IEhpIEtvZ3VjaGktc2FuLA0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPiA+ID4gRnJvbTogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcNCj4gPiA+IFtt
YWlsdG86Y2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmddIE9uIEJlaGFsZiBPZiBUYWt1byBL
b2d1Y2hpDQo+ID4gPiBTZW50OiBNb25kYXksIE1hcmNoIDE1LCAyMDIxIDE6MzMgUE0NCj4gPiA+
IFRvOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiA+ID4gU3ViamVjdDogUmU6IFtj
aXAtZGV2XSBJcyBjYWRlbmNlLXF1YWRzcGkgd29ya2luZyBvbiBjeWNsb25lIFY/DQo+ID4gPg0K
PiA+ID4gSGkgUGF2ZWwsDQo+ID4gPg0KPiA+ID4gPiA+PiBHaXQgYmlzZWN0IGhhcyB0b2xkIG1l
IHRoZSBmaXJzdCBiYWQgY29tbWl0IGlzDQo+ID4gPiA+ID4+IDMxZmI2MzJiNWQ0MyBzcGk6IE1v
dmUgY2FkZW5jZS1xdWFkc3BpIGRyaXZlciB0byBkcml2ZXJzL3NwaS8NCj4gPiA+ID4gPg0KPiA+
ID4gPiA+IFRoYXQncyBzdHJhbmdlLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4+IERvZXMgdGhpcyBj
aGFuZ2UgcmVxdWlyZXMgZGV2aWNlIHRyZWUgbW9kaWZpY2F0aW9uPw0KPiA+ID4gPiA+PiBBbnkg
c3VnZ2VzdGlvbnMgb3IgY29tbWVudHMgd291bGQgYmUgYXBwcmVjaWF0ZWQuDQo+ID4gPiA+ID4N
Cj4gPiA+ID4gPiAuLi5iZWNhdXNlIHRoYXQgcGFydGljdWxhciBjaGFuZ2UgZG9lcyBub3QgY2hh
bmdlIGFueSBDIGNvZGUuDQo+ID4gPiA+ID4gQnV0IGl0IHRvdWNoZXMgS2NvbmZpZyBiaXRzOyBj
YW4geW91IGNoZWNrIHRoYXQNCj4gPiA+ID4gPiBDT05GSUdfU1BJX0NBREVOQ0VfUVVBRFNQSSBp
cyBlbmFibGVkIGluIHRoZSAiYmFkIiBjb25maWd1cmF0aW9uPw0KPiA+ID4gPiA+DQo+ID4gPiA+
ID4gRG8geW91IGhhdmUgYW55IGxvY2FsIGNoYW5nZXMgaW4NCj4gPiA+ID4gPiBkcml2ZXJzL210
ZC9zcGktbm9yL2NvbnRyb2xsZXJzL2NhZGVuY2UtcXVhZHNwaS5jIG9yDQo+ID4gPiA+ID4gZHJp
dmVycy9zcGkvc3BpLWNhZGVuY2UtcXVhZHNwaS5jID8NCj4gPiA+ID4gSSBoYXZlIG5vIGxvY2Fs
IGNoYW5nZXMgdG8gdGhvc2UgZmlsZXMuDQo+ID4gPiA+IE1heWJlIEkgbG9zdCBDT05GSUdfU1BJ
X0NBREVOQ0VfUVVBRFNQSSBhY2NpZGVudGFsbHkgd2hpbGUgYmlzZWN0aW5nLg0KPiA+ID4gPiBJ
IHdpbGwgdHJ5IGJpc2VjdCBhbmQgcG9zdCB0aGUgcmVzdWx0IGFnYWluLg0KPiA+ID4gPg0KPiA+
ID4NCj4gPiA+IEkgcmVkbyB0aGUgYmlzZWN0IGFuZCBnZXQgdGhlIGZvbGxvd2luZyByZXN1bHQ7
ICMgZmlyc3QgYmFkIGNvbW1pdDoNCj4gPiA+IFthMzE0ZjYzNjc3ODdlZTFkNzY3ZGY5YTIxMjBm
MTdlNDUxMTE0NGQwXSBtdGQ6IHNwaS1ub3I6IENvbnZlcnQNCj4gPiA+IGNhZGVuY2UtcXVhZHNw
aSB0byB1c2Ugc3BpLW1lbSBmcmFtZXdvcmsNCj4gPiA+DQo+ID4gPiBJdCBjb250YWlucyBzaWdu
aWZpY2FudCBhbW91bnQgb2YgY2hhbmdlczsNCj4gPiA+DQo+ID4gPiBjYWRlbmNlLXF1YWRzcGku
YyB8ICA0NzYNCj4gPiA+ICsrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQ0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxOTEgaW5zZXJ0aW9ucygrKSwg
Mjg1IGRlbGV0aW9ucygtKQ0KPiA+ID4NCj4gPiA+IFdpdGggdGhpcyBjaGFuZ2UsIGNwc3BpX3By
b2JlIHJldHVybiAwIHdpdGhvdXQgYW55IGVycm9yIG1lc3NhZ2VzLA0KPiA+ID4gYnV0IGl0IGRv
ZXMgbm90IGRldGVjdCBOT1IgZmxhc2ggb24gYSBjdXN0b20gY3ljbG9uZSBWIGJvYXJkLg0KPiA+
ID4NCj4gPiA+IEFueSBpbmZvcm1hdGlvbiB3aWxsIGJlIGFwcHJlY2lhdGVkLg0KPiA+DQo+ID4g
SSBjaGVja2VkIG9uIGEgU29kaWEgYm9hcmQgd2l0aCB0aGUgc2FtZSBTb0MuDQo+ID4NCj4gPiBo
dHRwczovL3NlY3VyZS13ZWIuY2lzY28uY29tLzFDaE9NcktuU0JSNVFaZWVqdnJOczNQZjR4OF9f
TV9RVlVIRXJuQjlzDQo+ID4gbFYtVEFXUDNOVXdlMExFenNpcnZNN3JyLU9xdg0KPiA+IFJLcmd4
Z0kzaVFvNUlUZFVlaEZ5RHBwZDJHbGprRXp4N2l6djE2cEVSbmlYMERlRG16d0U1aDlwVVlxdEl4
TzNXQUZURHUNCj4gPiBIX0VHLVJOaE5GcUs0TFFha1o5MHNFU0Y2DQo+ID4gRE12c19qb3ZONTVY
ajV1OWtOT0NfZXc3NnBMdEFNQU9kTjNCWlNWX2ZSX242dGNXbGh2cUo2T2xVRWZycHo5eHZ5LWd1
MQ0KPiA+IFZIcmdjZ2oxQklDYUJpZDliVlV6YTEtVDdyQmMNCj4gPiBJMkVqRUN0ZDBxQ01jc3ZM
WVpQeHZ6Zlo5LUh1NnJGbGFDUTBydWh4WlZmSHVWV0VCMzdlUW1tMEhMSFlKRzJfUl9vdXNWDQo+
ID4gZVZEazhiSmEyaUEvaHR0cHMlM0ElMkYlMg0KPiA+IEZnaXQua2VybmVsLm9yZyUyRnB1YiUy
RnNjbSUyRmxpbnV4JTJGa2VybmVsJTJGZ2l0JTJGY2lwJTJGbGludXgtY2lwLmcNCj4gPiBpdCUy
RnRyZWUlMkZhcmNoJTJGYXJtJTJGYm9vdCUyRmQNCj4gPiB0cyUyRnNvY2ZwZ2FfY3ljbG9uZTVf
c29kaWEuZHRzJTNGaCUzRGxpbnV4LTUuMTAueS1jaXANCj4gPg0KPiA+IEl0IHJlY29nbml6ZXMg
Tk9SIGZsYXNoIGluIDUuMTAueS4gSG93IGFib3V0IGNoZWNraW5nIERUUz8NCj4gPiBTb2RpYSBi
b2FyZCB1c2VzIG4yNXE1MTJhIGFuZCBoYXMgdGhlIGZvbGxvd2luZyBEVDoNCj4gPiBgYGANCj4g
PiAmcXNwaSB7DQo+ID4gCXN0YXR1cyA9ICJva2F5IjsNCj4gPg0KPiA+IAlmbGFzaDA6IG4yNXE1
MTJhQDAgew0KPiA+IAkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+ID4gCQkjc2l6ZS1jZWxscyA9
IDwxPjsNCj4gPiAJCWNvbXBhdGlibGUgPSAibjI1cTUxMmEiOw0KPiA+IAkJcmVnID0gPDA+Ow0K
PiA+IAkJc3BpLW1heC1mcmVxdWVuY3kgPSA8MTAwMDAwMDAwPjsNCj4gPg0KPiA+IAkJbTI1cCxm
YXN0LXJlYWQ7DQo+ID4gCQljZG5zLHBhZ2Utc2l6ZSA9IDwyNTY+Ow0KPiA+IAkJY2RucyxibG9j
ay1zaXplID0gPDE2PjsNCj4gPiAJCWNkbnMscmVhZC1kZWxheSA9IDw0PjsNCj4gPiAJCWNkbnMs
dHNoc2wtbnMgPSA8NTA+Ow0KPiA+IAkJY2Rucyx0c2QyZC1ucyA9IDw1MD47DQo+ID4gCQljZG5z
LHRjaHNoLW5zID0gPDQ+Ow0KPiA+IAkJY2Rucyx0c2xjaC1ucyA9IDw0PjsNCj4gPiAJfTsNCj4g
PiB9Ow0KPiA+IGBgYA0KPiA+ID4NCj4gPiA+IFRoYW5rcywNCj4gPiA+DQo+ID4gPiBUYWt1byBL
b2d1Y2hpDQo+ID4gPg0KPiA+DQo+ID4gQmVzdCByZWdhcmRzLA0KPiA+ICAgTm9idWhpcm8NCj4g
Pg0KPiA+DQo+ID4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiA+IEZyb206
IOWwj+WPo+eQouWkqyAvIEtPR1VDSEnvvIxUQUtVTw0KPiA+ID4gPiBTZW50OiBTdW5kYXksIE1h
cmNoIDE0LCAyMDIxIDQ6MzcgUE0NCj4gPiA+ID4gVG86IGNpcC1kZXZAbGlzdHMuY2lwLXByb2pl
Y3Qub3JnDQo+ID4gPiA+IFN1YmplY3Q6IFJlOiBbIV1SZTogW2NpcC1kZXZdIElzIGNhZGVuY2Ut
cXVhZHNwaSB3b3JraW5nIG9uIGN5Y2xvbmUgVj8NCj4gPiA+ID4NCj4gPiA+ID4gSGkgUGF2ZWws
DQo+ID4gPiA+IFRoYW5rIHlvdSBmb3IgdGhlIHJlc3BvbnNlLg0KPiA+ID4gPg0KPiA+ID4gPiA+
PiBHaXQgYmlzZWN0IGhhcyB0b2xkIG1lIHRoZSBmaXJzdCBiYWQgY29tbWl0IGlzDQo+ID4gPiA+
ID4+IDMxZmI2MzJiNWQ0MyBzcGk6IE1vdmUgY2FkZW5jZS1xdWFkc3BpIGRyaXZlciB0byBkcml2
ZXJzL3NwaQ0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gVGhhdCdzIHN0cmFuZ2UuDQo+ID4gPiA+ID4N
Cj4gPiA+ID4gPj4gRG9lcyB0aGlzIGNoYW5nZSByZXF1aXJlcyBkZXZpY2UgdHJlZSBtb2RpZmlj
YXRpb24/DQo+ID4gPiA+ID4+IEFueSBzdWdnZXN0aW9ucyBvciBjb21tZW50cyB3b3VsZCBiZSBh
cHByZWNpYXRlZC4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IC4uLmJlY2F1c2UgdGhhdCBwYXJ0aWN1
bGFyIGNoYW5nZSBkb2VzIG5vdCBjaGFuZ2UgYW55IEMgY29kZS4NCj4gPiA+ID4gPiBCdXQgaXQg
dG91Y2hlcyBLY29uZmlnIGJpdHM7IGNhbiB5b3UgY2hlY2sgdGhhdA0KPiA+ID4gPiA+IENPTkZJ
R19TUElfQ0FERU5DRV9RVUFEU1BJIGlzIGVuYWJsZWQgaW4gdGhlICJiYWQiIGNvbmZpZ3VyYXRp
b24/DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBEbyB5b3UgaGF2ZSBhbnkgbG9jYWwgY2hhbmdlcyBp
bg0KPiA+ID4gPiA+IGRyaXZlcnMvbXRkL3NwaS1ub3IvY29udHJvbGxlcnMvY2FkZW5jZS1xdWFk
c3BpLmMgb3INCj4gPiA+ID4gPiBkcml2ZXJzL3NwaS9zcGktY2FkZW5jZS1xdWFkc3BpLmMgPw0K
PiA+ID4gPiBJIGhhdmUgbm8gbG9jYWwgY2hhbmdlcyB0byB0aG9zZSBmaWxlcy4NCj4gPiA+ID4g
TWF5YmUgSSBsb3N0IENPTkZJR19TUElfQ0FERU5DRV9RVUFEU1BJIGFjY2lkZW50YWxseSB3aGls
ZSBiaXNlY3RpbmcuDQo+ID4gPiA+IEkgd2lsbCB0cnkgYmlzZWN0IGFuZCBwb3N0IHRoZSByZXN1
bHQgYWdhaW4uDQo+ID4gPiA+DQo+ID4gPiA+IFJlZ2FyZHMsDQo+ID4gPiA+DQo+ID4gPiA+IFRh
a3VvIEtvZ3VjaGkNCj4gPiA+ID4NCj4gPiA+ID4gPiAyMDIxLzAzLzEzIDg6MDfjgIFQYXZlbCBN
YWNoZWsgPHBhdmVsQGRlbnguZGU+44Gu44Oh44O844OrOg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4g
SGkhDQo+ID4gPiA+ID4NCj4gPiA+ID4gPj4gR2l0IGJpc2VjdCBoYXMgdG9sZCBtZSB0aGUgZmly
c3QgYmFkIGNvbW1pdCBpcw0KPiA+ID4gPiA+PiAzMWZiNjMyYjVkNDMgc3BpOiBNb3ZlIGNhZGVu
Y2UtcXVhZHNwaSBkcml2ZXIgdG8gZHJpdmVycy9zcGkvDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBU
aGF0J3Mgc3RyYW5nZS4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+PiBEb2VzIHRoaXMgY2hhbmdlIHJl
cXVpcmVzIGRldmljZSB0cmVlIG1vZGlmaWNhdGlvbj8NCj4gPiA+ID4gPj4gQW55IHN1Z2dlc3Rp
b25zIG9yIGNvbW1lbnRzIHdvdWxkIGJlIGFwcHJlY2lhdGVkLg0KPiA+ID4gPiA+DQo+ID4gPiA+
ID4gLi4uYmVjYXVzZSB0aGF0IHBhcnRpY3VsYXIgY2hhbmdlIGRvZXMgbm90IGNoYW5nZSBhbnkg
QyBjb2RlLg0KPiA+ID4gPiA+IEJ1dCBpdCB0b3VjaGVzIEtjb25maWcgYml0czsgY2FuIHlvdSBj
aGVjayB0aGF0DQo+ID4gPiA+ID4gQ09ORklHX1NQSV9DQURFTkNFX1FVQURTUEkgaXMgZW5hYmxl
ZCBpbiB0aGUgImJhZCIgY29uZmlndXJhdGlvbj8NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IERvIHlv
dSBoYXZlIGFueSBsb2NhbCBjaGFuZ2VzIGluDQo+ID4gPiA+ID4gZHJpdmVycy9tdGQvc3BpLW5v
ci9jb250cm9sbGVycy9jYWRlbmNlLXF1YWRzcGkuYyBvcg0KPiA+ID4gPiA+IGRyaXZlcnMvc3Bp
L3NwaS1jYWRlbmNlLXF1YWRzcGkuYyA/DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBCZXN0IHJlZ2Fy
ZHMsDQo+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFBhdmVsDQo+ID4g
PiA+ID4gLS0NCj4gPiA+ID4gPiBERU5YIFNvZnR3YXJlIEVuZ2luZWVyaW5nIEdtYkgsICAgICAg
TWFuYWdpbmcgRGlyZWN0b3I6IFdvbGZnYW5nIERlbmsNCj4gPiA+ID4gPiBIUkIgMTY1MjM1IE11
bmljaCwgT2ZmaWNlOiBLaXJjaGVuc3RyLjUsIEQtODIxOTQgR3JvZWJlbnplbGwsDQo+ID4gPiA+
ID4gR2VybWFueQ0KPiA+ID4gPiA+DQo+ID4gPiA+ID4NCj4gPiA+ID4gPg0K

--GxoCbNL3D625zpBXiJUj
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6286): https://lists.cip-project.org/g/cip-dev/message=
/6286
Mute This Topic: https://lists.cip-project.org/mt/81272003/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--GxoCbNL3D625zpBXiJUj--
