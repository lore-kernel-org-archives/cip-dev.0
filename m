Return-Path: <SRS0=qv+o=HU=lists.cip-project.org=bounce+64572+6185+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5FFC433E0
	for <cip-dev@archiver.kernel.org>; Thu, 18 Feb 2021 16:29:00 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF33F64D92
	for <cip-dev@archiver.kernel.org>; Thu, 18 Feb 2021 16:28:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF33F64D92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6185+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id vXJ0YY4521723xCk6ePlPAk7; Thu, 18 Feb 2021 08:28:59 -0800
X-Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.57])
 by mx.groups.io with SMTP id smtpd.web11.9648.1613665737924386375
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Feb 2021 08:28:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A1wTGT5PBx7uqg8p8Fy+8Uudf+S1h8+avNks+iW3rtpN/GyNWDwsfvPTy0zMb/DpxdpwPopN+oicejCb0Tmly/yXJpmd71cEHKPXPC1FAfykwOT/ZMa3fK2YfPj+d1kQ1w26bzydKl1QH/8tWBPdvsjzvF8B3BX4w/3Wu4fEl4cDlW+HDktpkoBYgt38zga4OVkYvVvn8RGS9NrQCXCv8jDHxh/049l/ukxwVZoJ+vpP2PPaEnylkRU5+gjm7pJLx9gXAgOiUaM8fvLV1z5K5+Na38s+hYz3hRoN8BtLxUuCd8iblkrgbPTmL++LI94relUOMiG+eekFNXkfs6bapQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vl3kCoifNCJn4oQybdVR2UjfPsE549sUbaU0RjKOhk8=;
 b=BDKlY9/TJkA3rSiLKVwListNNAcOHc9onrpIQN1R63aU9nysAHHkAVQUaR1KsN0SWsJtpk82cRhSFuSOX+TTDGDya1Djog95PHwl43+7HqbVSq6KQ4kP8OGXiduY2fFeX3lKDBw/8HM1+I9P9bTQnwKjP6roUdW1U42Z6TK89c9fZ9SgDWqhKGMq0gyA0+VmP2UIwZxUFvB1xQU4tZuLbIBpEhukjlRR0/KV+TWeqP0hpKxWYno7Md4S47oyQvyj3K6FaKLe5NnB+nPX+BZNChT3J0iIJeUtu482XKoVJDPipld7lWuIiqcqEWYcIN912nS1v+kI3Yv/7p9V8hE1PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
X-Received: from AM0PR10MB1906.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:49::10)
 by AM0PR10MB3490.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:154::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.29; Thu, 18 Feb
 2021 16:28:55 +0000
X-Received: from AM0PR10MB1906.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dc9b:2590:a1cf:3301]) by AM0PR10MB1906.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dc9b:2590:a1cf:3301%7]) with mapi id 15.20.3868.028; Thu, 18 Feb 2021
 16:28:55 +0000
From: "florian.bezdeka@siemens.com" <florian.bezdeka@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>
CC: "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
Subject: Re: [cip-dev] Cip-kernel-sec Updates for Week of 2021-02-18
Thread-Topic: [cip-dev] Cip-kernel-sec Updates for Week of 2021-02-18
Thread-Index: AQHXBdeRM9oWxL1rBkaKV/mwud1DLqpdqvyAgAAA6QCAAG63AA==
Date: Thu, 18 Feb 2021 16:28:55 +0000
Message-ID: <d5665f714ddfbe257446b9bc3d6dcda18e86f67d.camel@siemens.com>
References: 
 <CAGb2v67v7o16fV4s7GTgO96P5=g3icjNUNGNs0mDdcm2BZYm=w@mail.gmail.com>
	 <20210218094923.GA28023@amd>
	 <CAGb2v66RODCVTdiway7SiNVQHDcgFiVHH0XYJmktQSa+_hdFnQ@mail.gmail.com>
In-Reply-To: 
 <CAGb2v66RODCVTdiway7SiNVQHDcgFiVHH0XYJmktQSa+_hdFnQ@mail.gmail.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2a02:810d:82c0:38fc:30d6:ec3a:bc18:37f5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b3cc9377-6a4f-4d75-6bed-08d8d42a4948
x-ms-traffictypediagnostic: AM0PR10MB3490:
x-ld-processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <AM0PR10MB3490D8578E0A87866AA3E262F6859@AM0PR10MB3490.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 WF4usy2ltgCD1fGSFMS74RIDsovvRpPR/pDQ7aSYzSI/fefM2gYaG4QvJmdRKxfmWucPGgY8uTW0ojnrXYh5kcprWgHhrToarEvTUZE/wwkqvoaEAJzJrbcBPQkz8t8E1zeMq47xB5RiJgfl8HlPPfgsEWedFOwDw/EGvuOkWkrv6OIxhfQTonbT35NbL328FXj6M9GxiemaXOQz+4iaFr0m550vvyRPwbNWDn1SnaPVx+KOAeDKQZVZ1GdkmdxggCF5Bkj22IOIn0Kkm/1Xmgm+xHZzu9u0IoGw5fSAg3+47kiDN0o5qad9Z4o8nnlaDUOHBDzayv9YRaOOfvXMeCxrx7aV8Ggw9AhABCW1cdZnBq9iAeSt7XPncoiYEGgR0VKBQoB+lVD2xnuAxlb9jDotWHJ39cr11hM53fuU6pXV+QgorJOMOwROCfk0VAiDv40QA5FSqZW7G0VQkbXXm+YFDxwLx3ydYEXYHy0a5cmDpAQWPdQK+KB3sw8HqevOQR4j+lGsEnEtE7kr0U/RV+//k6ybcGvhSFPtrLl4ZC1IiJTLrEbo7C3Hd8pCwAeGd2uvNU2/oY1dVFbyLa7+H7QyQg+HwIkT/fcNs5A7MF0=
x-ms-exchange-antispam-messagedata: 
 =?utf-8?B?R3l6UmVGR2tnMzFTQ3NQVEl5dUdoVU9Pa3piYWVBZ3h1dHM4YXRZVmNvMWls?=
 =?utf-8?B?bG9pR3B3NWNSaDJDSEtJeGQwN0tRbDdVOElOaVRyWGpndy90cjlscHFIUE0v?=
 =?utf-8?B?aHowc2lDbUJlb2FEd1pzV1Ztd0tsa3BXQkxkNVNPZERIK3lVOU0yZWg1NXFM?=
 =?utf-8?B?NFhKSTRWWDJ1NjJlQmRGbkZiYnFOc2lQV2JPbnUzbm9iZUdDU3BZdzljY0NK?=
 =?utf-8?B?WEJUVW80c2YxM2ZTck9oQmI4Z3VHWjdjTFVSMjl6UTZPWG5qM1liU1hqY0sz?=
 =?utf-8?B?ZnFIRUNqejc5dEVMTldjNTMvL3J4N2JQUVZ1TzZ0dGdWNFZYRkFTT0xqSlhU?=
 =?utf-8?B?bWVPeElrTWJpcFF2dDFxdHczV3poU0d1TmV0c2hTNkNYQk9CVjRDc0dURDRq?=
 =?utf-8?B?WEdiUFgvRmQ0cmFtdWpBSWZoc2JJWmcrK2U2UmxNaXNxRE1JWE16c055bnZE?=
 =?utf-8?B?M0w5YmVib0RKQVdWYTdsMHBmbWk1aFJUQVZEVDFnSHphWUxHaGtmaFNwdHcv?=
 =?utf-8?B?Nmw2clVVSUpXMFdMbVJZOENHNVBZN3hTUEIvZjZGbnBTeDJTRTVNSERiNHV4?=
 =?utf-8?B?cERzTnNPYjNVRjdpbUtsQXp4c2o4UHdIYXNlallHRGJHZWRCbXJuU0NsU2hp?=
 =?utf-8?B?VEtxWk9RODYvL2VuTExCZkxTdk1aUVNQZlVzZDFCWE9wOHozSi9PcWNiTU9n?=
 =?utf-8?B?QVVadFh4NFk4eGpxTXZWQ2FhQkQxRnd3RnBVWjdzZTFHNWE3K21JVy80NVNo?=
 =?utf-8?B?N3EvK0llbjdNRXNseWF2RXpUclVuenoxQUhOMWNwdDNiOXZ5OW85cmlFWXIz?=
 =?utf-8?B?TEFuUHd3dlZMemlHVFlLdnNaRSsvb2VQMFJ5UFFXU1YzRDZlTnc3TkRVNkw3?=
 =?utf-8?B?L0VFK3NXMjdxVzEzRTk4bWJOSHpiMWoxdUFmMGhIQ1A2RDhrZEtROTJvbHJE?=
 =?utf-8?B?WlNRMjkxcjI0dFE5bkFMUW5PN20rMzJuM0FndlFSZzJhSEd5ditucGZjTG80?=
 =?utf-8?B?cllQanhEMENoaVRNcnp0OVJVQUFYMWNtOEQvRy9wMFl3SmIyellETWxpZm42?=
 =?utf-8?B?bEduajlGc3hheU9xdWtTMks3RTE3THJOdlpJcERSZVNlR3VhNGxrSVdKYjZY?=
 =?utf-8?B?OE54YlkxMWJsOTlJR0FvR2M1NGVNSFA4MFhSL0FyK2R5VlMrK3gvUXhTMzU5?=
 =?utf-8?B?YTF3SXpiZWpVYzVrZ3IxV2E3SGN5OW5OM0tORGhDektmSFI4RDd3VTdqR00r?=
 =?utf-8?B?R2VvYllKaGY2dkkrMkVscnFVU1J0eFpibDNkclJCWmJLVGU1SjJEbTR3dVYr?=
 =?utf-8?B?QUNxUXpMZkxzRURCUFBoT2xhd0NsbTI2YVBlbVFERUtpVG9KaVRMWnd6QzlT?=
 =?utf-8?B?dGlxb2tmaXNtcmdGaExZclpoY0J6WXJZSmo2NGwrNVQ5bUl1NTRobFExQzRm?=
 =?utf-8?B?YWF4bnN6MnBzdi9JUk5pSUFJeDFWemVXOEY5ZFdWdm40d1hsREhJQ3U0bE0z?=
 =?utf-8?B?bVQxWGZJVDVWR1pLSFFVdm8xYmtvUWxSMVRHSjRHQ1F3RFBoT1BUMFhEUUla?=
 =?utf-8?B?R0E3MENSZGNIV1gxNmhaR1hOZ0daNWpCRWRXTTMzVUhtREZxVzI1Sk1BN203?=
 =?utf-8?B?SC9yL0RMMFBrNFVpVXlaSEc3ektsOFFQOXJlR3l0b0Q5ZTNZNG5SaTJZcndo?=
 =?utf-8?B?MTJubkEyUTZaSFN3UmRLU3pBVXZLRE9UVklkYllGNnZmTnlRdVYzekNVUzVM?=
 =?utf-8?B?K1U0ZG5PWWVVR3NnQlA1OXVKZWdZSFVkbkg3Wi9WRXZEemVNSFRkSGQ5SmxC?=
 =?utf-8?B?WTM5WFJic3RBdk5NcU1abG1HZFU4M1pWbkR0enhqNGIvT1RkZjhHVnRwVFpr?=
 =?utf-8?B?YSszOHEwSElsbkpRYit4SnhxSjdjL2xNQ3BmK1plRjZTVWc9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB1906.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b3cc9377-6a4f-4d75-6bed-08d8d42a4948
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2021 16:28:55.4683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nxVHdx/pQfKATiS82w7uGmBAwbbTiI4gFoYg5FXW7Iu2PyBSUiy9/6bao9GDPChJMdWLdoxjPRASgqjV7irIU33hieYEmkUDghQrP52ccEc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3490
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 8YAPkOkEQH3DM3vpJf3o6NfHx4520388AA=
Content-Type: multipart/mixed; boundary="GU1baPJtM3FD4vMcwotu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1613665739;
 bh=hwV03Pw1aWoOetjQklbL01N7abagDTZEJPgYMe79gcg=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=RuEdhzbzVwwqDBii9HEDzJ02HEPOOb/MVxfCnHTXdT+5iNXlxACGmTF/vY/Y0VHzzwx
 8b5zjapnbgI0fntz5urwEQoMzo0Q53P4IckZROxl9KGyHj2x+k6W1jW3PNh8fzfQMEKcJ
 CjoYNNLIPynVxTRmyGSchtiYlKwHC2PXSLw=

--GU1baPJtM3FD4vMcwotu
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <091179DA23A01F4B86E2FFC605A19D05@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64

T24gVGh1LCAyMDIxLTAyLTE4IGF0IDE3OjUyICswODAwLCBDaGVuLVl1IFRzYWkgKE1veGEpIHdy
b3RlOg0KPiBPbiBUaHUsIEZlYiAxOCwgMjAyMSBhdCA1OjQ5IFBNIFBhdmVsIE1hY2hlayA8cGF2
ZWxAZGVueC5kZT4gd3JvdGU6DQo+ID4gDQo+ID4gT24gVGh1IDIwMjEtMDItMTggMTc6MjE6NTcs
IENoZW4tWXUgVHNhaSB3cm90ZToNCj4gPiA+IEhpIGV2ZXJ5b25lLA0KPiA+ID4gDQo+ID4gPiBG
aXZlIG5ldyBpc3N1ZXMgdGhpcyB3ZWVrOg0KPiA+ID4gDQo+ID4gPiBDVkUtMjAyMS0yMDIzOSBb
c2V0c29ja29wdCBjb3B5X2Zyb21fdXNlciBlcnJvcl0gLSBmaXhlZCBpbiA1LjQgYW5kDQo+ID4g
PiByZW1vdmVkIGZyb20gNS4xMA0KPiA+ID4gQ1ZFLTIwMjEtMjY5MzAgW3hlbi1ibGtiYWNrIGVy
cm9yIGhhbmRsaW5nXSAtIFBSIHNlbnQNCj4gPiA+IENWRS0yMDIxLTI2OTMxIFt4ZW4gYmFja2Vu
ZHM6IEJVR19PTiBpbiBlcnJvciBoYW5kbGluZ10gLSBQUiBzZW50DQo+ID4gPiBDVkUtMjAyMS0y
NjkzMiBbeGVuIGdyYW50IG1hcHBpbmcgZXJyb3IgaGFuZGxpbmddIC0gUFIgc2VudA0KPiA+ID4g
Q1ZFLTIwMjEtMjY5MzQgW3hlbiB1bnN1cHBvcnRlZCBkcml2ZXJdIC0gWGVuIGRvY3VtZW50YXRp
b24gY2hhbmdlDQo+ID4gPiBzdGF0aW5nIGJlLWFsbG9jIGRpc3BsYXkgZHJpdmVyIGlzIHVuc3Vw
cG9ydGVkDQo+ID4gPiANCj4gPiA+IExpbnVzIGRvZXNuJ3Qgc2VlbSB0byBiZSBwcm9jZXNzaW5n
IFBScyBmb3IgdGhlIG5ldyBtZXJnZSB3aW5kb3cgeWV0LA0KPiA+ID4gc28gd2UgbWlnaHQgaGF2
ZSB0byB3YWl0IGEgd2hpbGUgYmVmb3JlIHRoZSBYZW4gb25lcyBhcmUgZml4ZWQgYW5kDQo+ID4g
PiBiYWNrcG9ydGVkLg0KPiA+IA0KPiA+IFdlbGwsIFhlbiBpcyBub3QgYSB0eXBpY2FsIHRoaW5n
IHRvIHJ1biBvbiBlbWJiZWRlZCBoYXJkd2FyZSwgYnV0IEkNCj4gPiBkaWQgbm90IGNoZWNrIHRo
ZSBjb25maWdzLg0KPiANCj4gSSBzZWUgUmVuZXNhcyBhbmQgU2llbWVucyBoYXZlIGl0IGVuYWJs
ZWQuIElzIFhlbiBzdGlsbCByZWxldmFudD8NCj4gT3IgaGFzIGV2ZXJ5b25lIHN3aXRjaGVkIG92
ZXIgdG8gS1ZNICsgUUVNVT8NCg0KV2hlcmUgaXMgdGhlIG1lbnRpb25lZCBrZXJuZWwgY29uZmln
IGxvY2F0ZWQ/IEkgd2Fzbid0IGFibGUgdG8gZmluZCB0aGUNCmNvcnJlY3QgZ2l0IHRyZWUuIA0K
DQpXZSBhbHJlYWR5IGhhZCBhIHNob3J0IGludGVybmFsIGRpc2N1c3Npb24gYW5kIGFyZSBxdWl0
ZSBzdXJlIHRoYXQgd2UNCmRvbid0IG5lZWQgaXQuIEp1c3QgcG9pbnQgbWUgdG8gdGhlIGNvbmZp
Z3VyYXRpb24uIFdlIHdpbGwgcmV2aWV3IGFnYWluDQphbmQgY29tZSB1cCB3aXRoIHRoZSBuZWNl
c3NhcnkgcGF0Y2ggdG8gZGlzYWJsZSBpdC4NCg0KPiANCj4gPiBJdCBzZWVtcyBMaW51cyBpcyBo
YXZpbmcgcG93ZXIgcHJvYmxlbXM6DQo+IA0KPiBJIHJlYWQgdGhlIGhlYWRsaW5lIG9uIFBob3Jv
bml4LCBidXQgZGlkbid0IGtub3cgaXQgd2FzIHRoaXMgYmFkLg0KPiBUaGF0IGFsc28gZXhwbGFp
bnMgd2h5IGxrbWwub3JnIHdhcyBjb21wbGV0ZWx5IGVtcHR5IHllc3RlcmRheS4NCj4gDQo+IA0K
PiBDaGVuWXUNCj4gDQo+ID4gQmVzdCByZWdhcmRzLA0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgUGF2ZWwN
Cj4gPiANCj4gPiBEYXRlOiBUdWUsIDE2IEZlYiAyMDIxIDEyOjI1OjA2IC0wODAwDQo+ID4gRnJv
bTogTGludXMgVG9ydmFsZHMgPHRvcnZhbGRzQGxpbnV4Zm91bmRhdGlvbi5vcmc+DQo+ID4gVG86
IEtvbnN0YW50aW4gUnlhYml0c2V2IDxrb25zdGFudGluQGxpbnV4Zm91bmRhdGlvbi5vcmc+DQo+
ID4gQ2M6IHVzZXJzQGxpbnV4Lmtlcm5lbC5vcmcNCj4gPiBTdWJqZWN0OiBSZTogW2tlcm5lbC5v
cmcgdXNlcnNdIFBhcnRpYWwgcG93ZXIgb3V0YWdlIGluIHRoZSBQRFgNCj4gPiBkYXRhY2VudHJl
DQo+ID4gDQo+ID4gWy0tIEF0dGFjaG1lbnQgIzEgLS1dDQo+ID4gWy0tIFR5cGU6IG11bHRpcGFy
dC9hbHRlcm5hdGl2ZSwgRW5jb2Rpbmc6IDdiaXQsIFNpemU6IDIuMksgLS1dDQo+ID4gDQo+ID4g
U2FkbHksIHRoZSBwb3dlciBhdCBteSBob3VzZSBpcyBzdGlsbCBlbnRpcmVseSBvdXQsIGFsdGhv
dWdoIGNlbGwNCj4gPiBzZXJ2aWNlDQo+ID4gaGFzIG5vdyBiZWVuIGZpeGVkIHNvIGF0IGxlYXN0
IEkgY2FuIHJlYWQgc29tZSBlbWFpbCB3aXRob3V0IHdhbGtpbmcNCj4gPiBvdXRzaWRlLg0KPiA+
IA0KPiA+IEJ1dCB3aXRoIG5vIHBvd2VyIGZvciBteSBsYXB0b3Agb3Igd29ya3N0YXRpb24sIEkg
d29uJ3QgYmUgc3RhcnRpbmcNCj4gPiB0aGUNCj4gPiBtZXJnZSB3aW5kb3cgdW50aWwgcG93ZXIg
aXMgYmFjayBtb3JlIHdpZGVseSBpbiB0aGV5IFBvcnRsYW5kIGFyZWEuDQo+ID4gDQo+ID4gTXkg
bmVpZ2hib3Job29kIGlzIGxpa2VseSBub3QgYSBwcmlvcml0eSwgc28gaXQgdmVyeSBwb3NzaWJs
eSB3aWxsIGJlDQo+ID4gYSBmZXcNCj4gPiBtb3JlIGRheXMgKHNvIGZhciB3aXRob3V0IHBvd2Vy
IHNpbmNlIFN1bmRheSBldmVuaW5nKS4NCj4gPiANCj4gPiBFdmVuIHRoZSBsb2NhbCBoaWdod2F5
IDQzIChvaywgbm90IGEgYmlnIGhpZ2h3YXksIGJ1dCBzdGlsbCkgaXMgc3RpbGwNCj4gPiBjbG9z
ZWQgZG93biB0d28gZGF5cyBsYXRlciBkdWUgdG8gZG93bmVkIHRyZWVzLg0KPiA+IA0KPiA+IMKg
wqDCoMKgwqDCoMKgwqBMaW51cw0KPiA+IA0KPiA+IA0KPiA+IC0tDQo+ID4gREVOWCBTb2Z0d2Fy
ZSBFbmdpbmVlcmluZyBHbWJILCAgICAgIE1hbmFnaW5nIERpcmVjdG9yOiBXb2xmZ2FuZyBEZW5r
DQo+ID4gSFJCIDE2NTIzNSBNdW5pY2gsIE9mZmljZTogS2lyY2hlbnN0ci41LCBELTgyMTk0IEdy
b2ViZW56ZWxsLCBHZXJtYW55DQo+IA0KPiANCg0K

--GU1baPJtM3FD4vMcwotu
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6185): https://lists.cip-project.org/g/cip-dev/message=
/6185
Mute This Topic: https://lists.cip-project.org/mt/80725760/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--GU1baPJtM3FD4vMcwotu--
