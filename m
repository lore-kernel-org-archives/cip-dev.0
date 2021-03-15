Return-Path: <SRS0=SgyP=IN=lists.cip-project.org=bounce+64572+6282+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D480C433E0
	for <cip-dev@archiver.kernel.org>; Mon, 15 Mar 2021 05:25:32 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB8A164E46
	for <cip-dev@archiver.kernel.org>; Mon, 15 Mar 2021 05:25:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB8A164E46
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6282+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id XoVcYY4521723xeIECIHBFeR; Sun, 14 Mar 2021 22:25:31 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web10.4778.1615785928876760130
 for <cip-dev@lists.cip-project.org>;
 Sun, 14 Mar 2021 22:25:30 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 12F5PPem029452; Mon, 15 Mar 2021 14:25:25 +0900
X-Iguazu-Qid: 2wHHmPJ15XsFdcoPzj
X-Iguazu-QSIG: v=2; s=0; t=1615785925; q=2wHHmPJ15XsFdcoPzj; m=q9Qz/QpqBO1jpAQ1ZHfu0SdCWHfhG0sGw55+AE2rnT0=
X-Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1113) id 12F5POLC029963
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 15 Mar 2021 14:25:25 +0900
X-Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id 412271000C8
	for <cip-dev@lists.cip-project.org>; Mon, 15 Mar 2021 14:25:24 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 12F5POA9010242
	for <cip-dev@lists.cip-project.org>; Mon, 15 Mar 2021 14:25:24 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZoBjDd88vJ01WjyeKolOuGK7OW8RHif8TDM83Wa5VrfAxnKju/UaUUsh24biwYHu+KMaMz9COIxk1YUxQtemPmrkLXn4o/A9QK9LDvFqfj+zImv2F1SBiWg84IL77cH/Ly9HvEpkewvj2Vh+B5B6b/7vWUPw7UxY2zJawzU/sIOhTKGxU85UGxYGK2fh1MeysrwVEeg7ecM9XBpSJ8MFnZxKuXbkgNK8JR5QtOgZGu5SS60xCFllpyppHqSdaMNUWREyRg8+q0nH/dugxwnOka6X67OEzzSl7zBLQJ93arKa8jS50fc64QwVJWzVM+ysJ18PiiB4NlT8tlHCvCPx1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ikPUa7qeDxaM3Umg2/4cDfCv21gh9DSSBxjGVhxTUJg=;
 b=Tc36X/BmiO4TdyQK8M/+6bsDuMUh+tGOCVsb+c0QbUt7yF6baQQFw2x0k6rxfWLJiUEnaDpbl/K+A3RT2C3p0/Dpy4G3sis6tM/2gjauzrw2FNfe0mPq5u5zuR0DFdBUc6+dSAfpgSlf3RjNNLdXynQbiG8EJpoutRGuyxtY3cIBLrr/q3N2o48nl0fusRXC40oSreKz9bJ7RsKy2JZ6W1vRRXUVPDGW8bZRtjP2Fa51kbgWxx6V+3Zx5/ys9hSxlDciHajqOIKmQkHM+S+UhqGamrWRPJlI9iSK6lQh0uJdpvuVhOUH4CmqtR5PYgw7EWxkR2EvWGY6dtAaN5BWMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] Is cadence-quadspi working on cyclone V?
Thread-Topic: [cip-dev] Is cadence-quadspi working on cyclone V?
Thread-Index: AdcZVD/VSKM4qaEJRM2U/V244oeK/QABhavQ
Date: Mon, 15 Mar 2021 05:25:19 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2983A8AF3568F39D2D1DE455926C9@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <TY2PR01MB26520E38F23C33EB2B59D539D76C9@TY2PR01MB2652.jpnprd01.prod.outlook.com>
In-Reply-To: <TY2PR01MB26520E38F23C33EB2B59D539D76C9@TY2PR01MB2652.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9cb5763a-0f11-4123-6c37-08d8e772b9e2
x-ms-traffictypediagnostic: OSBPR01MB4039:
x-microsoft-antispam-prvs: <OSBPR01MB4039671DAA6307D4B75A28E7926C9@OSBPR01MB4039.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WWUKS1Xxw8n7Gd5lOhtgCoPGjll+TLQCzD93Bn7XxqJNqNwC75Kn19EGUNcFrvR4+/nDQnI7MfQ/RXtGiKg/LP6AKDtMnPK36mqgQyfgH/cOOlYPuatRi/Wy2fOTZ64P5Hn8oLww9zGDgEe9V5SoGHh8F2bzsMaU/MVoIinA4M19w8O8kWRhCZbPzwOqzZyFV6YKttvsA64D6z+tEMY2SkLPD1ti7PTxIiLzitjBF7D3yKoxvxVFdcf3/9UL1yFVOsvACBILPd8LFS3x6JGDvw8KnHxqMet9tJPFdVUpErQUZts9B8eusE8xwosDusQIs4R0PScL0S4BUc4ihhyGXTI9TmuxwlSPNscQL0tgeRO1157bsCn+uWyXn+V15pGt3IOjPTg2fwwNrq/2O99cxroIZeYpYUJsIKXBmiAOIqI73//fwToiLZrxO231YSLohf461cLLwWPnh0LiAQd71EXhrdePbTxKi9CvgmkRbDuqEdVhk2O7xcD+0TpxOaUqG/6Zzzk49OINm0Vtdj+D2ki4GzKOi905RO0ZNa6KxdW+HXG8EoWKYQ/VSygMMSVLkIleQSzQCqgRSLdciIGGMC4I4wMlUVchSVDbn+98fhj5NJulSAmTTEjVfycM/W+BdhFy1+JDBEB5JZFuk17vMg==
x-ms-exchange-antispam-messagedata: =?utf-8?B?OXlEYWZJeFpzc09XaFg3NmNHN2ZxOWhCWUVKdFNmcm9GNis0cjc5Q1lDN09n?=
 =?utf-8?B?amNqL2dpc0tRczVrZWFYWk9VUTZNM3ZOaFpLd3pzS2pjakIrOWFWbFlpaVAx?=
 =?utf-8?B?ZnN4MDczRmJqTTQ1ZitReFYzNitkTU43MDZQZXNEeGZ1ejIyTnhYRnhKN3Nl?=
 =?utf-8?B?bE8xVERzWTVRTEt5TFhpVGYwZlB6T3JVZWtydmp0REJQb0ZtZzVtSks4V00y?=
 =?utf-8?B?UU1sVG0vUEp5VWt6dW11QU13N1B1MWQ4Rm8yRVcvbm0yRnZzSHlNT1hFSDhp?=
 =?utf-8?B?ZWFOM0NoN3A2aTMzbzNsRFh6TkhXdXl3NVVJTzlxZ085VExzc2J6Z29wblJn?=
 =?utf-8?B?TktaaTBCU3NpNVpQaDNyTmhiNVBDOFZBV1l4QTlJVDU1LzBDSXJMcHlHRmxy?=
 =?utf-8?B?Ulp4cEhGU2d3amMxUGpOR2JNeFp4RHd6UE0yclg5enIwb3ZzdmMrazZDaG1N?=
 =?utf-8?B?bmdlSTVrcFM3aDNMRTlRZEdJcTJBN0FRVWVIWklqQ3h5bXVWSDZhWmZpeHdt?=
 =?utf-8?B?R2pDQmJRdWJzZ3BOSkw3eENSTENzaWNNL1NtN05BSXl4WUNSUWtKaVB0UnhY?=
 =?utf-8?B?ZklzRmVIRm80RDk3QXErSGNvUGE1RlZrWGlhVU1uY1FtWXJYeGk0bURHV1gr?=
 =?utf-8?B?UmpJU0Y2aGVxMUQ0OURWVjZoWkkvRjRZV3FMS2UxaDlTeVA4ZnF1QVE5STlM?=
 =?utf-8?B?dTRPWWdLRmFwbnIxelFBTTZ0d1hTUzVSRENqeFZaSU43RjZ6dGhIL0hXWnZW?=
 =?utf-8?B?elh2RnRZWDJnOG43aFlCSC9hTElPN3NIQUJ5bkY2Uk5BazJ2aWtOalhxcU9o?=
 =?utf-8?B?V2xFM0NXNzlGMHVsb3VoWjRrcFk1NzA2eGR5TE1Na0tveUt4ejU2SEtUWStI?=
 =?utf-8?B?WVBXUW1vamNzZllZWSs0MnBNMGdGQlZ4eVk0akhzQld0T2tpdTBiY3pINytw?=
 =?utf-8?B?bG45V3g2ejFtc0ZybWs5ZThZVW9DemYrcnlrNmozcHZ3eTh0aXFOQmxqNkxN?=
 =?utf-8?B?TUg4aEJ5cWhWMGYrNEpkS3BHY1pCMENvOGhCYkIwdHVHdGF4c0tBdFFOT3Rn?=
 =?utf-8?B?MUZUbjVVRFpVbnM5NTM3QURhL1pUWTFnSjFic2hSM2pSdENzR2g2RXhIUUdq?=
 =?utf-8?B?VDl4Q1M5UTFPQlJtMWFSNm00TkZ6TlpadXI5Y1VyRU9TbnhrVG4wMXE5RjVl?=
 =?utf-8?B?Z1BiWGpQSWpkMUZ6S2JPZXpXa0IrVWhlSzFqazNjcytUbmoxS2hPaVBucitR?=
 =?utf-8?B?dGZoOVlxV1diUHMvb3o0Ti9yVG00NVRtV3crM3R2U1BYaXFkcU1YSG10cHhG?=
 =?utf-8?B?clJHZzRJSjR0RTVRczJUdmtBeHBBdWNSenVzNDIwd3hCSi9jeG9JdG5qVU45?=
 =?utf-8?B?K1V1N09CZWdmclFIcUpQcjJmT3pLM1M1S1MrRWpja1pQcFkwdjVkUVlLb0Ro?=
 =?utf-8?B?VTYya2VqN1FUNmQvQlQ4U3pJM0h6SFYvdW83ZEV1OE4zRkpNOFdEWGMrY3Ew?=
 =?utf-8?B?OGhhYUdmMWhKc04waDVwZXFyWjhzbTFWNXdVbHdzaThYR1NwZFduTHNyVmNF?=
 =?utf-8?B?Z3B0TjE0V0FZMmNPd2VNMWIxVGg5bDBtaXR2QjhEbis5SnA0a1JBZkxacURj?=
 =?utf-8?B?RzE3akxXaXhNUVFnc0ZIeUhmTG1pSDIyUkJxWExjb3Y4SllCWUorT0kvRG9p?=
 =?utf-8?B?a3VhWFNsUklka0cxR3QxYmR6WWNrbm1HQmZvbWFoWkxxS1ZSOC91Smh1MUpl?=
 =?utf-8?Q?MrpCfIRjN5jLRHNWDE=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cb5763a-0f11-4123-6c37-08d8e772b9e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2021 05:25:20.2917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: obPrdTn2NFRiCvXl14LF+ktHZxTXXgsTjPCJck8V3to+ZM6DBNiZn3VtSXlTgT7L/aeTykVeFIafkQohgxxLcR/ngZ4thGkghoCW8bz4KPkpEyyUtGxC5Uh7Pd/2vxHO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4039
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: LRz7AE9KQLDCDk7pOkQwmUiwx4520388AA=
Content-Type: multipart/mixed; boundary="FqoFvncrHPGGKzedSnyh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1615785931;
 bh=FD/8PViVPDFPaAqrES7lxjbgflNPBGiijBqcLwQdP2E=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=t7DCEGEiXszfF2EkGyewD8suhuE5YeuhbE3k1XyAE7fNAexbsDVllGqf87rsZPiHvJY
 x8I7haUNoXV7jS73CMD49cXIVBu0I3Zc3E5Vi+VUFHvtWK3xAbay4Nd/90p8hB9GoSX5y
 cIzn2KO1hQfg+wA7tfUxUloii57Z9erqTdM=

--FqoFvncrHPGGKzedSnyh
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgS29ndWNoaS1zYW4sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog
Y2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcgW21haWx0bzpjaXAtZGV2QGxpc3RzLmNpcC1w
cm9qZWN0Lm9yZ10gT24gQmVoYWxmIE9mIFRha3VvIEtvZ3VjaGkNCj4gU2VudDogTW9uZGF5LCBN
YXJjaCAxNSwgMjAyMSAxOjMzIFBNDQo+IFRvOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9y
Zw0KPiBTdWJqZWN0OiBSZTogW2NpcC1kZXZdIElzIGNhZGVuY2UtcXVhZHNwaSB3b3JraW5nIG9u
IGN5Y2xvbmUgVj8NCj4gDQo+IEhpIFBhdmVsLA0KPiANCj4gPiA+PiBHaXQgYmlzZWN0IGhhcyB0
b2xkIG1lIHRoZSBmaXJzdCBiYWQgY29tbWl0IGlzDQo+ID4gPj4gMzFmYjYzMmI1ZDQzIHNwaTog
TW92ZSBjYWRlbmNlLXF1YWRzcGkgZHJpdmVyIHRvIGRyaXZlcnMvc3BpLw0KPiA+ID4NCj4gPiA+
IFRoYXQncyBzdHJhbmdlLg0KPiA+ID4NCj4gPiA+PiBEb2VzIHRoaXMgY2hhbmdlIHJlcXVpcmVz
IGRldmljZSB0cmVlIG1vZGlmaWNhdGlvbj8NCj4gPiA+PiBBbnkgc3VnZ2VzdGlvbnMgb3IgY29t
bWVudHMgd291bGQgYmUgYXBwcmVjaWF0ZWQuDQo+ID4gPg0KPiA+ID4gLi4uYmVjYXVzZSB0aGF0
IHBhcnRpY3VsYXIgY2hhbmdlIGRvZXMgbm90IGNoYW5nZSBhbnkgQyBjb2RlLiBCdXQgaXQNCj4g
PiA+IHRvdWNoZXMgS2NvbmZpZyBiaXRzOyBjYW4geW91IGNoZWNrIHRoYXQgQ09ORklHX1NQSV9D
QURFTkNFX1FVQURTUEkgaXMNCj4gPiA+IGVuYWJsZWQgaW4gdGhlICJiYWQiIGNvbmZpZ3VyYXRp
b24/DQo+ID4gPg0KPiA+ID4gRG8geW91IGhhdmUgYW55IGxvY2FsIGNoYW5nZXMgaW4NCj4gPiA+
IGRyaXZlcnMvbXRkL3NwaS1ub3IvY29udHJvbGxlcnMvY2FkZW5jZS1xdWFkc3BpLmMgb3INCj4g
PiA+IGRyaXZlcnMvc3BpL3NwaS1jYWRlbmNlLXF1YWRzcGkuYyA/DQo+ID4gSSBoYXZlIG5vIGxv
Y2FsIGNoYW5nZXMgdG8gdGhvc2UgZmlsZXMuDQo+ID4gTWF5YmUgSSBsb3N0IENPTkZJR19TUElf
Q0FERU5DRV9RVUFEU1BJIGFjY2lkZW50YWxseSB3aGlsZSBiaXNlY3RpbmcuDQo+ID4gSSB3aWxs
IHRyeSBiaXNlY3QgYW5kIHBvc3QgdGhlIHJlc3VsdCBhZ2Fpbi4NCj4gPg0KPiANCj4gSSByZWRv
IHRoZSBiaXNlY3QgYW5kIGdldCB0aGUgZm9sbG93aW5nIHJlc3VsdDsNCj4gIyBmaXJzdCBiYWQg
Y29tbWl0OiBbYTMxNGY2MzY3Nzg3ZWUxZDc2N2RmOWEyMTIwZjE3ZTQ1MTExNDRkMF0gbXRkOiBz
cGktbm9yOiBDb252ZXJ0IGNhZGVuY2UtcXVhZHNwaSB0byB1c2Ugc3BpLW1lbQ0KPiBmcmFtZXdv
cmsNCj4gDQo+IEl0IGNvbnRhaW5zIHNpZ25pZmljYW50IGFtb3VudCBvZiBjaGFuZ2VzOw0KPiAN
Cj4gY2FkZW5jZS1xdWFkc3BpLmMgfCAgNDc2ICsrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDE5MSBpbnNlcnRp
b25zKCspLCAyODUgZGVsZXRpb25zKC0pDQo+IA0KPiBXaXRoIHRoaXMgY2hhbmdlLCBjcHNwaV9w
cm9iZSByZXR1cm4gMCB3aXRob3V0IGFueSBlcnJvciBtZXNzYWdlcywgYnV0IGl0IGRvZXMgbm90
IGRldGVjdCBOT1IgZmxhc2ggb24gYSBjdXN0b20gY3ljbG9uZQ0KPiBWIGJvYXJkLg0KPiANCj4g
QW55IGluZm9ybWF0aW9uIHdpbGwgYmUgYXBwcmVjaWF0ZWQuDQoNCkkgY2hlY2tlZCBvbiBhIFNv
ZGlhIGJvYXJkIHdpdGggdGhlIHNhbWUgU29DLg0KICBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1
Yi9zY20vbGludXgva2VybmVsL2dpdC9jaXAvbGludXgtY2lwLmdpdC90cmVlL2FyY2gvYXJtL2Jv
b3QvZHRzL3NvY2ZwZ2FfY3ljbG9uZTVfc29kaWEuZHRzP2g9bGludXgtNS4xMC55LWNpcA0KDQpJ
dCByZWNvZ25pemVzIE5PUiBmbGFzaCBpbiA1LjEwLnkuIEhvdyBhYm91dCBjaGVja2luZyBEVFM/
DQpTb2RpYSBib2FyZCB1c2VzIG4yNXE1MTJhIGFuZCBoYXMgdGhlIGZvbGxvd2luZyBEVDoNCmBg
YA0KJnFzcGkgew0KCXN0YXR1cyA9ICJva2F5IjsNCg0KCWZsYXNoMDogbjI1cTUxMmFAMCB7DQoJ
CSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KCQkjc2l6ZS1jZWxscyA9IDwxPjsNCgkJY29tcGF0aWJs
ZSA9ICJuMjVxNTEyYSI7DQoJCXJlZyA9IDwwPjsNCgkJc3BpLW1heC1mcmVxdWVuY3kgPSA8MTAw
MDAwMDAwPjsNCg0KCQltMjVwLGZhc3QtcmVhZDsNCgkJY2RucyxwYWdlLXNpemUgPSA8MjU2PjsN
CgkJY2RucyxibG9jay1zaXplID0gPDE2PjsNCgkJY2RucyxyZWFkLWRlbGF5ID0gPDQ+Ow0KCQlj
ZG5zLHRzaHNsLW5zID0gPDUwPjsNCgkJY2Rucyx0c2QyZC1ucyA9IDw1MD47DQoJCWNkbnMsdGNo
c2gtbnMgPSA8ND47DQoJCWNkbnMsdHNsY2gtbnMgPSA8ND47DQoJfTsNCn07DQpgYGANCj4gDQo+
IFRoYW5rcywNCj4gDQo+IFRha3VvIEtvZ3VjaGkNCj4gDQoNCkJlc3QgcmVnYXJkcywNCiAgTm9i
dWhpcm8NCg0KDQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiDlsI/l
j6PnkKLlpKsgLyBLT0dVQ0hJ77yMVEFLVU8NCj4gPiBTZW50OiBTdW5kYXksIE1hcmNoIDE0LCAy
MDIxIDQ6MzcgUE0NCj4gPiBUbzogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcNCj4gPiBT
dWJqZWN0OiBSZTogWyFdUmU6IFtjaXAtZGV2XSBJcyBjYWRlbmNlLXF1YWRzcGkgd29ya2luZyBv
biBjeWNsb25lIFY/DQo+ID4NCj4gPiBIaSBQYXZlbCwNCj4gPiBUaGFuayB5b3UgZm9yIHRoZSBy
ZXNwb25zZS4NCj4gPg0KPiA+ID4+IEdpdCBiaXNlY3QgaGFzIHRvbGQgbWUgdGhlIGZpcnN0IGJh
ZCBjb21taXQgaXMNCj4gPiA+PiAzMWZiNjMyYjVkNDMgc3BpOiBNb3ZlIGNhZGVuY2UtcXVhZHNw
aSBkcml2ZXIgdG8gZHJpdmVycy9zcGkNCj4gPiA+DQo+ID4gPiBUaGF0J3Mgc3RyYW5nZS4NCj4g
PiA+DQo+ID4gPj4gRG9lcyB0aGlzIGNoYW5nZSByZXF1aXJlcyBkZXZpY2UgdHJlZSBtb2RpZmlj
YXRpb24/DQo+ID4gPj4gQW55IHN1Z2dlc3Rpb25zIG9yIGNvbW1lbnRzIHdvdWxkIGJlIGFwcHJl
Y2lhdGVkLg0KPiA+ID4NCj4gPiA+IC4uLmJlY2F1c2UgdGhhdCBwYXJ0aWN1bGFyIGNoYW5nZSBk
b2VzIG5vdCBjaGFuZ2UgYW55IEMgY29kZS4gQnV0IGl0DQo+ID4gPiB0b3VjaGVzIEtjb25maWcg
Yml0czsgY2FuIHlvdSBjaGVjayB0aGF0IENPTkZJR19TUElfQ0FERU5DRV9RVUFEU1BJIGlzDQo+
ID4gPiBlbmFibGVkIGluIHRoZSAiYmFkIiBjb25maWd1cmF0aW9uPw0KPiA+ID4NCj4gPiA+IERv
IHlvdSBoYXZlIGFueSBsb2NhbCBjaGFuZ2VzIGluDQo+ID4gPiBkcml2ZXJzL210ZC9zcGktbm9y
L2NvbnRyb2xsZXJzL2NhZGVuY2UtcXVhZHNwaS5jIG9yDQo+ID4gPiBkcml2ZXJzL3NwaS9zcGkt
Y2FkZW5jZS1xdWFkc3BpLmMgPw0KPiA+IEkgaGF2ZSBubyBsb2NhbCBjaGFuZ2VzIHRvIHRob3Nl
IGZpbGVzLg0KPiA+IE1heWJlIEkgbG9zdCBDT05GSUdfU1BJX0NBREVOQ0VfUVVBRFNQSSBhY2Np
ZGVudGFsbHkgd2hpbGUgYmlzZWN0aW5nLg0KPiA+IEkgd2lsbCB0cnkgYmlzZWN0IGFuZCBwb3N0
IHRoZSByZXN1bHQgYWdhaW4uDQo+ID4NCj4gPiBSZWdhcmRzLA0KPiA+DQo+ID4gVGFrdW8gS29n
dWNoaQ0KPiA+DQo+ID4gPiAyMDIxLzAzLzEzIDg6MDfjgIFQYXZlbCBNYWNoZWsgPHBhdmVsQGRl
bnguZGU+44Gu44Oh44O844OrOg0KPiA+ID4NCj4gPiA+IO+7v0hpIQ0KPiA+ID4NCj4gPiA+PiBH
aXQgYmlzZWN0IGhhcyB0b2xkIG1lIHRoZSBmaXJzdCBiYWQgY29tbWl0IGlzDQo+ID4gPj4gMzFm
YjYzMmI1ZDQzIHNwaTogTW92ZSBjYWRlbmNlLXF1YWRzcGkgZHJpdmVyIHRvIGRyaXZlcnMvc3Bp
Lw0KPiA+ID4NCj4gPiA+IFRoYXQncyBzdHJhbmdlLg0KPiA+ID4NCj4gPiA+PiBEb2VzIHRoaXMg
Y2hhbmdlIHJlcXVpcmVzIGRldmljZSB0cmVlIG1vZGlmaWNhdGlvbj8NCj4gPiA+PiBBbnkgc3Vn
Z2VzdGlvbnMgb3IgY29tbWVudHMgd291bGQgYmUgYXBwcmVjaWF0ZWQuDQo+ID4gPg0KPiA+ID4g
Li4uYmVjYXVzZSB0aGF0IHBhcnRpY3VsYXIgY2hhbmdlIGRvZXMgbm90IGNoYW5nZSBhbnkgQyBj
b2RlLiBCdXQgaXQNCj4gPiA+IHRvdWNoZXMgS2NvbmZpZyBiaXRzOyBjYW4geW91IGNoZWNrIHRo
YXQgQ09ORklHX1NQSV9DQURFTkNFX1FVQURTUEkgaXMNCj4gPiA+IGVuYWJsZWQgaW4gdGhlICJi
YWQiIGNvbmZpZ3VyYXRpb24/DQo+ID4gPg0KPiA+ID4gRG8geW91IGhhdmUgYW55IGxvY2FsIGNo
YW5nZXMgaW4NCj4gPiA+IGRyaXZlcnMvbXRkL3NwaS1ub3IvY29udHJvbGxlcnMvY2FkZW5jZS1x
dWFkc3BpLmMgb3INCj4gPiA+IGRyaXZlcnMvc3BpL3NwaS1jYWRlbmNlLXF1YWRzcGkuYyA/DQo+
ID4gPg0KPiA+ID4gQmVzdCByZWdhcmRzLA0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIFBhdmVsDQo+ID4gPiAtLQ0KPiA+ID4gREVOWCBTb2Z0d2FyZSBFbmdpbmVlcmluZyBH
bWJILCAgICAgIE1hbmFnaW5nIERpcmVjdG9yOiBXb2xmZ2FuZyBEZW5rDQo+ID4gPiBIUkIgMTY1
MjM1IE11bmljaCwgT2ZmaWNlOiBLaXJjaGVuc3RyLjUsIEQtODIxOTQgR3JvZWJlbnplbGwsIEdl
cm1hbnkNCj4gPiA+DQo+ID4gPg0KPiA+ID4NCg==

--FqoFvncrHPGGKzedSnyh
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6282): https://lists.cip-project.org/g/cip-dev/message=
/6282
Mute This Topic: https://lists.cip-project.org/mt/81272003/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--FqoFvncrHPGGKzedSnyh--
