Return-Path: <SRS0=/MV+=IM=lists.cip-project.org=bounce+64572+6279+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F61AC433E0
	for <cip-dev@archiver.kernel.org>; Sun, 14 Mar 2021 07:37:15 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CF6064EC0
	for <cip-dev@archiver.kernel.org>; Sun, 14 Mar 2021 07:37:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CF6064EC0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hitachi.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6279+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id HFXBYY4521723x8yf6KY858T; Sat, 13 Mar 2021 23:37:13 -0800
X-Received: from esa10.hc514-86.ap.iphmx.com (esa10.hc514-86.ap.iphmx.com [207.54.83.27])
 by mx.groups.io with SMTP id smtpd.web08.3602.1615707431548385715
 for <cip-dev@lists.cip-project.org>;
 Sat, 13 Mar 2021 23:37:13 -0800
IronPort-SDR: ySaERTLcrwrMy5b4UEF6cZ/JvKo/krUikLTZYpDC0wRRc7BVfiDSyL45nGij3eThi7oeS5SisH
 fXLpn3+2bqrp4Rp+KMS+TaVgqCd1W/1gef2ybKIzOe9NK0al0bs1zWemCowiNxUF5eGVqPscP4
 AVDBv+vlXAZbsgIfP7lHdBqvvwca8/+gMGfY70SNcZkKEPViOodEoLeDu0EGKT9u3XRIAKnsQ7
 SklSdRTqKFZXTaQLGW+H6JYWOMciMXSxy/wy5uBKJIDsB7F2dmxYrU9r+/aynUwx3uPT4KO6Ok
 4NY=
X-IronPort-AV: E=Sophos;i="5.81,245,1610409600"; 
   d="scan'208";a="4730930"
X-Received: from mail10.maildeliv.hitachi.co.jp (HELO mail10.hitachi.co.jp) ([133.145.228.57])
  by ob1.hc514-86.ap.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 14 Mar 2021 07:37:06 +0000
X-Received: from mlsv12.hitachi.co.jp (unknown [133.145.228.43])
	by mail10.hitachi.co.jp (Postfix) with ESMTP id D47053C0043
	for <cip-dev@lists.cip-project.org>; Sun, 14 Mar 2021 16:37:05 +0900 (JST)
X-Received: from mfgw02.hitachi.co.jp by mlsv12.hitachi.co.jp (8.14.4/8.14.4) id 12E7b0l9022941; Sun, 14 Mar 2021 16:37:05 +0900
X-Received: from GUjpTK3DCemcs26.global.hitachi.net ([158.213.250.27])
	by mfgw02.hitachi.co.jp with ESMTP
	id LLJBlnDnDVVacLLJBlRSQO; Sun, 14 Mar 2021 16:37:05 +0900
X-Received: from GUjpTKHDCemcs04.global.hitachi.net (2002:9ed5:d24d::9ed5:d24d)
 by GUjpTK3DCemcs26.global.hitachi.net (2002:9ed5:fa1b::9ed5:fa1b) with
 Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 14 Mar 2021 16:37:05 +0900
X-Received: from GUjpTKHDCemcs06.global.hitachi.net (2002:9ed5:d273::9ed5:d273)
 by GUjpTKHDCemcs04.global.hitachi.net (2002:9ed5:d24d::9ed5:d24d) with
 Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 14 Mar 2021 16:37:05 +0900
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (74.107.156.4) by
 GUjpTKHDCemcs06.global.hitachi.net (158.213.210.115) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2 via Frontend Transport; Sun, 14 Mar 2021 16:37:04
 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GroNADDKY2OD22cCjyLKmrT80lj6rkjtL68oVURHenZ+02Vqxb2VOZy89Qah7xejgRJZsMGwOyVD+SC51Vmu8OAPRxUM/Ycn7YvnMWH1m4YN2gU3GajtzLDfHIs74qdIHE+yYoitrtdZ/e6WV+EwXlNzQBEA5hNIkWUztNQZDWU3ZFwMBYeRpQgbVMgtpuIPIhyAR7CgiNu2ZqbsU/4ICTmDdnHRHEEFCsds9Z32LrbjaK4ly+qzttOFa8n0NCWrPJELma3owmkmRgLys/qk1ueTGp2tMksMMfPefmxJDIgWSwCVtM8qwjAoOWuE9RdJaIMsyohldc+HctFFldjNQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87l/rLLLn/q4rzpczcBlOyOOapNoYW8Kg7b5PfuwYPQ=;
 b=BSzMR8UF8IQv7idtfBJ57cV70Lr/Vx9GTqwLaL9jZyVV+dlR+6cO455WB4ekECRgGyWp+bl6huQLe8ZCJBnSlxLUWJ1yOpnNRfV5+7dV2MQ2xY4mVeHzL3vrRwO73wUppRAoz3JPt2sM9wlXR+voBHn1fC/pTEjEoYmZ/sYIAWLriQYxtOfCCCgDlwOqIwUgYpfFm4+1ZgixIv11ttPgvZ0FCOaHaAQZYS0tuJZUOwS7SOEYpGY+1Mt0p3ofGun1kqewH3tjprzQcnIeZHXIdupqXXcm/Eih8Om+rwP2Likho9aLIYQ2N+EVPTC+Ll2HAckg6tDe9r1vrzvEQDZokw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hitachi.com; dmarc=pass action=none header.from=hitachi.com;
 dkim=pass header.d=hitachi.com; arc=none
X-Received: from TY2PR01MB2652.jpnprd01.prod.outlook.com (2603:1096:404:6b::9)
 by TYAPR01MB5756.jpnprd01.prod.outlook.com (2603:1096:404:8055::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Sun, 14 Mar
 2021 07:37:04 +0000
X-Received: from TY2PR01MB2652.jpnprd01.prod.outlook.com
 ([fe80::ec98:97f6:1862:ffbe]) by TY2PR01MB2652.jpnprd01.prod.outlook.com
 ([fe80::ec98:97f6:1862:ffbe%5]) with mapi id 15.20.3933.032; Sun, 14 Mar 2021
 07:37:04 +0000
From: "Takuo Koguchi" <takuo.koguchi.sw@hitachi.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] Is cadence-quadspi working on cyclone V?
Thread-Topic: [!]Re: [cip-dev] Is cadence-quadspi working on cyclone V?
Thread-Index: AdcW6N7w+/NxEPWCRLqEbIuKn5CiwwAq33aAAEQdsPk=
Date: Sun, 14 Mar 2021 07:37:03 +0000
Message-ID: <5A75B71E-992F-4DF1-B1AC-9EDF091BDDA5@hitachi.com>
References: <TY2PR01MB26522E5CC577EC60BD354085D76F9@TY2PR01MB2652.jpnprd01.prod.outlook.com>,<20210312230641.GA17701@amd>
In-Reply-To: <20210312230641.GA17701@amd>
Accept-Language: en-US, ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [133.145.233.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: efbc3cc8-ecef-4973-ee7f-08d8e6bbf68e
x-ms-traffictypediagnostic: TYAPR01MB5756:
x-microsoft-antispam-prvs: <TYAPR01MB575698EC096AE70071788BABD76D9@TYAPR01MB5756.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hpExUFdPTkaqxRZRXkRmCyhrAb6anEmwQ6uc0DPrt3/WzVEb8FJ+s9LwUHxyL+2r2R1ZmzGUkeXmO+faHRfsh4Lp7jaYoN7nmfKY8Z1pfRs566tSJxMJvj+BxdjvK/5iai60Z3vm8odbUTAbf06BL7tQgxeWmMMiUsmlwye1iFw66mu6PbdTrOaDJzJ7UxqotLMewx+/YJayqdQPCk0XQLsmFfn84PXo4/fv83BuupInfkkmFRnXuszyWlwMbcxBeMAi09Ii28UaBR56+44fPtXV4NxpdbW520ikmWTh0gAwy62qlOssTokDyRkddgZllSOVU8VWzfleoQUMczItzPbqWJQi/QrXkzS4O8tPbxH+uhCu5xT8fFjC0Tx3yh03RjvqRIcBETM3WOtxR2lnCnEgUsJ+uehG4KS/Ncvo7ZfcTLPDoIns6JW/M5/mlS0yvxszgR7ycuIAoaqs9TMYPSBP/nEWJMYI9ihOIqnXdrbxez23v9/VgmgiYsJMmtfgdjFKCufdVkPaYhpY8/srFXWWDB9oOZLIddd0J8ee7FwCwzoUYh0g7mfKstkW2o/xoQK9e4dKwjYDXeb/oexBguRGtx6E9UZd8J13yb8U5yt3ziFXD1prQz5oblcnIeKhcT2rtEnrhl6JoWy3C50gqAhKxjk/6C5+KABWv/SMnJJF9KpYnAlQRMXaaeT9lWJwycR6+NYXBNLxo2LQSO+ezw==
x-ms-exchange-antispam-messagedata: =?utf-8?B?WDNnUGFjZW43Zkw5cHRmVkpBKzZ6aGs4L2I1aFBrVm13SzV2ZWRxUWhoWFBw?=
 =?utf-8?B?ajI1ZUVwa210cEV2Tjd0UzlXS3lwT25GV2RFTjRsN1NqQys0ZEIydEUxQmov?=
 =?utf-8?B?VTMySFIyMU5XUU1XSGdyYnV5RUJxZnF4UTRsUlpNNzhwK1drcnd6L3RFUjll?=
 =?utf-8?B?cnl5ZEpEakREZEhBVWR4NFR4UmIrV2g2R2JrWTRFM3hqNW9vZWdFejZPV3Fh?=
 =?utf-8?B?OCtTNXMvWEhtcW9sNHR5WDBhUjJDOHd3WFdjdExSckVxL1FDTHNSOGhiTjdB?=
 =?utf-8?B?eFYzcTZLaHdMQktuT1FCL0NiVEswbkhwdFFlNk9XU0hUSkxZc1VLZ2xIRUFO?=
 =?utf-8?B?VFdZdDdaZTFGSmFnTFE3aWxCTnJ1aGpmY28vRVBXWFpmQzk1bWtudGVHZkVG?=
 =?utf-8?B?ejA1a2VCMi9LWkhHS245ZGpIek9TQUNlaEVTcG03Qm5uTEVuUWZGYktBc05k?=
 =?utf-8?B?T3BjM1QwdldhMmhSNk92RjJGTk5XWS9aejB3TnNZS2Q4NTZxcThvR0FqcVZF?=
 =?utf-8?B?ZHdJdDNWa2ttT1dwMnNnbU91VDNvemtGODBLSHN6VVd2S2hZVUpocHFGaFFC?=
 =?utf-8?B?VVdjRG1DWEhOOEttd0RmMVVhZjk1YUNVYkpEZFB4VFdiK0xuNGZjLzh3V2Jm?=
 =?utf-8?B?Wnp6TmtmUUQ1bEtVcDBSd2ZNLzJVRXBrT08vOTh1WVZDME9jRmZ3eXd4S2xK?=
 =?utf-8?B?K2Q1TkpFRm5ZUzR0Ujl5eGJraS9iQ1Z5N25kN1B6cGZuSXZBSjdnR3UyWVZi?=
 =?utf-8?B?MW9ybGI1UkZIdmJSZHl0OGcxbDJoRGsxRXdhTlB1UElobE9zSnhnTVpZckxl?=
 =?utf-8?B?WmkrYVdmQ0hPREVlZWxjK2RKd2tqL3cvU1ZqRGxUdk96WVYwNzZ6aDZ2WEhs?=
 =?utf-8?B?eGppZC9KU3ZlM1ppUmRhTFRuUFlvSWtYZW14MGhxRkV4V21xQU9EVC9qZDNN?=
 =?utf-8?B?MVhreHczMHVxR29uaGZOWllJN3VNdHFEZkx0R2VNSE45R2kzY0FzSWFjbEZu?=
 =?utf-8?B?Z29KRGlySW8wWFBHT0dnYkFnUnY4UUU1MkFFV0tvSjlrN1N2K281bFZaOVk1?=
 =?utf-8?B?LzBnanVPNEd4b1d5M3Q3VmFVQVplYmlXbjM3TXN6WWdjS09xYzVsM25VU05n?=
 =?utf-8?B?eFRBeklsUk5Ma2RyZnV1b2s5dmlyaHh0NWQ1Wk5uL0o3b01WNG0rckRwWHBp?=
 =?utf-8?B?NEwwM2tDWCt1SnErcWRTNmtDVFNOeGpnVE9MbmE3YktFS1BnMVEzTWo4bUxx?=
 =?utf-8?B?OFJFYlcrVlFJWlpzWTdMS1dtKy9wOHdxSGFpa1hUU2RKMVN2OHFjYms0djZV?=
 =?utf-8?B?OC9LSGxPQXRldzIrZzFoRFNZSHQ3T3hOTjVXYWlFUG9lMFR2NkFvL2dhNytO?=
 =?utf-8?B?Wm1EcXpYZ1lLSlJXMy9JUHRFeWcwZHVSdmFPNTYwNFR4STk1MDZZZy9NT0ZV?=
 =?utf-8?B?WTU3dUtqeXpNNkQ5aGdOTEJOeWFoUUxsQmdjMXZFWE1kSTgyWnBvK0NKU3Nz?=
 =?utf-8?B?VGpNSmhjcmg1czRYOEd0WkdWYU5oVG5mTzF5VndCSTl4dmcrWGZaYzJiMWx3?=
 =?utf-8?B?UHUrMGNLTFR2RDR6TlovN3V6aGNTTTFUaFhNbjVnT08xRFhaQnk0cXJXVHc0?=
 =?utf-8?B?L2xKMUh5QUNzSFBCdWdCZm1vYjViSE83TFRDMEZqMTFLRkdqRXF2K1JadEJw?=
 =?utf-8?B?anVLTFpwaTF1bDl1YXlSeHVKdERhekpCUDBQT0lYNGdWQWxFNXIvcUpFVFh4?=
 =?utf-8?Q?GaXHaGEc+QbBk/3HPnT1LLpl8SJf5iy9Ea/wzHf?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB2652.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efbc3cc8-ecef-4973-ee7f-08d8e6bbf68e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2021 07:37:04.2110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f54277c9-dafe-44aa-85a4-73d5c7c52450
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IUbWHAZemIqgSvEkK1AY2VmWAzQOCG9uTMXImK1a2dkw5AjtykLFeq+4guPt07e1aCbDHbGHYJ8i8XAj8CyzATCLUz8kXMHb8pSrTvL12ng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5756
X-OriginatorOrg: hitachi.com
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 5647TGQdjVy7N0KYzITELwA6x4520388AA=
Content-Type: multipart/mixed; boundary="5MTtDOWfZgxs9qZhzkYZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1615707433;
 bh=PS2qEwJ9X3ZemTwr1+wmqPFJkCdcLsceDQI/gAKSOOQ=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=snI4JnBLBcEFR44RbgaV5vtGrU1hfIfMpq2AudkkBoYRm7x9+HiU1tj5FBABFOwztzI
 FC73lKE/h5mb1VLrT2ZQndnjZz4RrAJgjpsxfAroY8qDUw8McUewB8y7XHk7OWB+lZfgV
 6NNSDwsuXtR7+PK9nZz6N775yVrs19wxaes=

--5MTtDOWfZgxs9qZhzkYZ
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgUGF2ZWwsDQpUaGFuayB5b3UgZm9yIHRoZSByZXNwb25zZS4NCg0KPj4gR2l0IGJpc2VjdCBo
YXMgdG9sZCBtZSB0aGUgZmlyc3QgYmFkIGNvbW1pdCBpcw0KPj4gMzFmYjYzMmI1ZDQzIHNwaTog
TW92ZSBjYWRlbmNlLXF1YWRzcGkgZHJpdmVyIHRvIGRyaXZlcnMvc3BpLw0KPiANCj4gVGhhdCdz
IHN0cmFuZ2UuDQo+IA0KPj4gRG9lcyB0aGlzIGNoYW5nZSByZXF1aXJlcyBkZXZpY2UgdHJlZSBt
b2RpZmljYXRpb24/DQo+PiBBbnkgc3VnZ2VzdGlvbnMgb3IgY29tbWVudHMgd291bGQgYmUgYXBw
cmVjaWF0ZWQuDQo+IA0KPiAuLi5iZWNhdXNlIHRoYXQgcGFydGljdWxhciBjaGFuZ2UgZG9lcyBu
b3QgY2hhbmdlIGFueSBDIGNvZGUuIEJ1dCBpdA0KPiB0b3VjaGVzIEtjb25maWcgYml0czsgY2Fu
IHlvdSBjaGVjayB0aGF0IENPTkZJR19TUElfQ0FERU5DRV9RVUFEU1BJIGlzDQo+IGVuYWJsZWQg
aW4gdGhlICJiYWQiIGNvbmZpZ3VyYXRpb24/DQo+IA0KPiBEbyB5b3UgaGF2ZSBhbnkgbG9jYWwg
Y2hhbmdlcyBpbg0KPiBkcml2ZXJzL210ZC9zcGktbm9yL2NvbnRyb2xsZXJzL2NhZGVuY2UtcXVh
ZHNwaS5jIG9yDQo+IGRyaXZlcnMvc3BpL3NwaS1jYWRlbmNlLXF1YWRzcGkuYyA/DQpJIGhhdmUg
bm8gbG9jYWwgY2hhbmdlcyB0byB0aG9zZSBmaWxlcy4NCk1heWJlIEkgbG9zdCBDT05GSUdfU1BJ
X0NBREVOQ0VfUVVBRFNQSSBhY2NpZGVudGFsbHkgd2hpbGUgYmlzZWN0aW5nLg0KSSB3aWxsIHRy
eSBiaXNlY3QgYW5kIHBvc3QgdGhlIHJlc3VsdCBhZ2Fpbi4NCg0KUmVnYXJkcywNCg0KVGFrdW8g
S29ndWNoaQ0KDQo+IDIwMjEvMDMvMTMgODowN+OAgVBhdmVsIE1hY2hlayA8cGF2ZWxAZGVueC5k
ZT7jga7jg6Hjg7zjg6s6DQo+IA0KPiDvu79IaSENCj4gDQo+PiBHaXQgYmlzZWN0IGhhcyB0b2xk
IG1lIHRoZSBmaXJzdCBiYWQgY29tbWl0IGlzDQo+PiAzMWZiNjMyYjVkNDMgc3BpOiBNb3ZlIGNh
ZGVuY2UtcXVhZHNwaSBkcml2ZXIgdG8gZHJpdmVycy9zcGkvDQo+IA0KPiBUaGF0J3Mgc3RyYW5n
ZS4NCj4gDQo+PiBEb2VzIHRoaXMgY2hhbmdlIHJlcXVpcmVzIGRldmljZSB0cmVlIG1vZGlmaWNh
dGlvbj8NCj4+IEFueSBzdWdnZXN0aW9ucyBvciBjb21tZW50cyB3b3VsZCBiZSBhcHByZWNpYXRl
ZC4NCj4gDQo+IC4uLmJlY2F1c2UgdGhhdCBwYXJ0aWN1bGFyIGNoYW5nZSBkb2VzIG5vdCBjaGFu
Z2UgYW55IEMgY29kZS4gQnV0IGl0DQo+IHRvdWNoZXMgS2NvbmZpZyBiaXRzOyBjYW4geW91IGNo
ZWNrIHRoYXQgQ09ORklHX1NQSV9DQURFTkNFX1FVQURTUEkgaXMNCj4gZW5hYmxlZCBpbiB0aGUg
ImJhZCIgY29uZmlndXJhdGlvbj8NCj4gDQo+IERvIHlvdSBoYXZlIGFueSBsb2NhbCBjaGFuZ2Vz
IGluDQo+IGRyaXZlcnMvbXRkL3NwaS1ub3IvY29udHJvbGxlcnMvY2FkZW5jZS1xdWFkc3BpLmMg
b3INCj4gZHJpdmVycy9zcGkvc3BpLWNhZGVuY2UtcXVhZHNwaS5jID8NCj4gDQo+IEJlc3QgcmVn
YXJkcywNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFBhdmVsDQo+IC0tIA0KPiBE
RU5YIFNvZnR3YXJlIEVuZ2luZWVyaW5nIEdtYkgsICAgICAgTWFuYWdpbmcgRGlyZWN0b3I6IFdv
bGZnYW5nIERlbmsNCj4gSFJCIDE2NTIzNSBNdW5pY2gsIE9mZmljZTogS2lyY2hlbnN0ci41LCBE
LTgyMTk0IEdyb2ViZW56ZWxsLCBHZXJtYW55DQo+IA0KPiANCj4gDQo=

--5MTtDOWfZgxs9qZhzkYZ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6279): https://lists.cip-project.org/g/cip-dev/message=
/6279
Mute This Topic: https://lists.cip-project.org/mt/81272003/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--5MTtDOWfZgxs9qZhzkYZ--
