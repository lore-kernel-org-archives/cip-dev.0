Return-Path: <SRS0=0JaA=F2=lists.cip-project.org=bounce+64572+5972+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4635C433DB
	for <cip-dev@archiver.kernel.org>; Tue, 22 Dec 2020 13:10:15 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 273572312E
	for <cip-dev@archiver.kernel.org>; Tue, 22 Dec 2020 13:10:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 273572312E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5972+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id AyElYY4521723xQgWjjnCNBY; Tue, 22 Dec 2020 05:10:14 -0800
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web10.11233.1608642611554318929
 for <cip-dev@lists.cip-project.org>;
 Tue, 22 Dec 2020 05:10:13 -0800
X-Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 0BMDA127004056; Tue, 22 Dec 2020 22:10:01 +0900
X-Iguazu-Qid: 2wHHipuwAVmaN5dTDl
X-Iguazu-QSIG: v=2; s=0; t=1608642601; q=2wHHipuwAVmaN5dTDl; m=b329OcsY1FISj15STZkSeDWWSkS9G5+8+fgZ/xjL4uI=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1113) id 0BMD9x7N036705;
	Tue, 22 Dec 2020 22:10:00 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 0BMD9x9S026310;
	Tue, 22 Dec 2020 22:09:59 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 0BMD9xhQ013707;
	Tue, 22 Dec 2020 22:09:59 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bu+0vRR9xwduOw2kc3OTCD9mN1pH8S3IYMkQehqnshD9Gx0N5GPs6kkgiQCFRTGz0UJ7rD6Ys4HeEonAxF/lt1Dljs69d+Gx8vWvpZTD1cw0lLEObQw994p4CuMAvuomCcouc+ULjpYqvocudR3P9CTCPhnvDF3jBmcupIyCoprdGw3HZoOHz136gH83zp0tZG375+VHDPV6pHU4BMLeQ7vvPjxucpHbBDq3sXlWPvG/Wa9Ftrjewqpb115U4C58z0xDpcImC9yUdAysBkwaiiCpnZMjT5OPTzVj2+QBEAQ5EAnGDt3hhC5rWOa38P5CJxadt0ep1gRbadMZxP7ggQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9V3vr/wRS32TdeUQmPn/k2zlNy1DQ/y4nB45f2z8c08=;
 b=mqs3N58oV/bfDEH2JBfwuzlBKmHzkO0MKkADvN1xu1hM1tJ2XDrF1t97PdQHqUKHtJ6P5QoowcT0HkaMkTuDuUANV3OUEtIjWrTxcjIuuMka5tna4r6yeEzTxFRrAswKc/7ZRCVhgDw58Giv67AQ/ktdxCbz9nkFWUYhU9wo5SmsU7zQHrAoxCiHPVD1i/m/CcXLZ6n4h9jM4QugqpR2qHzJOaQxDhcN6UjqNWxOj15Kn6pSFIM9XPDWsjisYayVCzCSMHVYWypi03qBSep+ZKHpO9yS2ll7PKaJo1S/vueFL2dcXbD6dD40L8KNrnuLABv1ZDvca/YvU0YnQd901w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <prabhakar.mahadev-lad.rj@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip] ARM: dts: iwg22d-sodimm: Fix dt nodes sorting
Thread-Topic: [PATCH 4.4.y-cip] ARM: dts: iwg22d-sodimm: Fix dt nodes sorting
Thread-Index: AQHW2FVtUndXrVbsPE64tTwhiXn27KoDFi6g
Date: Tue, 22 Dec 2020 13:09:56 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2983379E4CA85512AEABC16B92DF0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <20201222112714.24595-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201222112714.24595-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d1e1d052-d6cf-4c6d-ecb7-08d8a67ae10e
x-ms-traffictypediagnostic: OSAPR01MB4052:
x-microsoft-antispam-prvs: <OSAPR01MB405243EA75235AD6BDEFE57E92DF0@OSAPR01MB4052.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:989;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UCLMhTHTfLVVCf/RMXozJ9fUCqwjaXOVyaXnwifZAAkCwDvyR/CGG4Kk1xfGz16wjVZvp157wFyyNkSgKOeVIJD6RcKrTyGVxFSa+A/nDE/5l+RDKXshBqpcbF8xqSjKzszHVliCWeLaqBFAu1c1tAFAaTDJpFnB6N97a7+4fEECKtaQnmcV/txXTph3wOuZozYEJqfKYxw2lea+aa8zIUhbd5Y1RQfv3HArnacKA3x1CDj6QODDLdpfEEaoQ6GyE4cPLNhAr8gWr6TcwdBNLOdAuwi++VVJVfRHK4puS8bU7ovYNl2PSYIYF4uKSIB2BQ3d3Wd58ZrAl3TKNpBxdMKhS0bhqKxhnKzEO8rWE8aZaiJSRQPwfmr5yB815Kwm6olJPH79FdipVCiDyN8DWqKrgw5t+a0/nb1jxzquZ3QKN7NtyrxLCuZwxNY0cuvy+r6IEuLRrxJZi3fInDQdYw==
x-ms-exchange-antispam-messagedata: =?utf-8?B?cURGY0lOZXhpU2NDNTJScnRkV2dQSjJ3bGdiL2RITm9BdnlIam5kY2EwMVJl?=
 =?utf-8?B?eDNxV0RXZUVtSFkxa01vb216aFllSHNDbTVoRlVBQXVDZW1kd3RiVVBDRU1k?=
 =?utf-8?B?VUhzNnhHcGluVUllMHF0MXlnMnByMU9jOHlpZHJOamNxaFhUNTlVY2dPVk5H?=
 =?utf-8?B?ZHRncDlsbmdTNTNQZzc4V1h3THEyWE5UM211RWN4OGEzRER3em01TjRHdUdq?=
 =?utf-8?B?cHlYOHZ1RmcwK2xISDFXeG9JVS9nWFFTUmZUOWQ5ZDh3YVJoRVZRU3hqYlgr?=
 =?utf-8?B?cjlLbnBCMUZ0TkZSY0owWnBRQjV6NkgxVWVDWm0xTnlETDVEQ1JKbTJNcjRl?=
 =?utf-8?B?QjYzYkV3ZVlkT29XSUlyRXhYRFR4VEFOZUgrNEZZSVl3ajJFZUpEQms5UUZJ?=
 =?utf-8?B?M21uK2ZVcXlXZVdUNkRpWVEvRmkvQkpFajNyK0JMRHRUa2U1Z1lHN2Zoandj?=
 =?utf-8?B?TGVLZmhXdXkrK3JETWgxSWFWakJXRWFTNi9nZHVBMTdITWdtb2xrM3Q1WEY4?=
 =?utf-8?B?SzRMbDhCS3hKaVRMdzJROXcrY1A0SnVaOVAxTW9JQmx1VmJpNEJKVFpQanZo?=
 =?utf-8?B?RXFIeVduM0tubks0RE1iUGpLZWRtcHRQckpwUUpud0tYdHVyMlR6UEh3YmhV?=
 =?utf-8?B?QVhsRUVua01Cc0xPRTRRMDBFZXZKd1RmWW9sdjQ5Vmo2c3VHeEdCSEVLUWd2?=
 =?utf-8?B?eUc1RUtFTGZWc0tzb2VhRVkzN3VwM2M2Q3IxeWp2bGREYmJha21sNW4rM2JC?=
 =?utf-8?B?ekRuOFhtVXlIaHRsZ28wOHNHOW9KU1pwY0JQNDZ4NDZxYzdmaEVHOXlhZlFF?=
 =?utf-8?B?NzM5aDBiZk5tMEtPMzUrS0k5VTM1NkxzdytKMnE3YnVwL0hhRExkN1QwckN4?=
 =?utf-8?B?Rm1MQ3pJOEhwOHJLUFhoaFF0eUVXU0R2L0JsajJBRkY2TTBaVHd1ckVEMFBs?=
 =?utf-8?B?ZTlSbVN3TVNYTEkrRlBnZyt4bllneGxFbDd3YURqeHkrM3dKZ3lJeVBBYUwx?=
 =?utf-8?B?UFcxWHZoZ2drUVFvOUYvYjBZd3dudFlpa1NSemNPZWJWT0x6dmgxcTY2aGVW?=
 =?utf-8?B?MEN3WU1kYnU5WkpuN1g2b3dRWDVETTROWU50TmRiUUlxb2ZFZ3RBTXdjaW1C?=
 =?utf-8?B?ZmVGV2JmQnB5ZWRYaGM3N2xHK0RwOVlNNlVXd1JYbEx5SUZwemRMRHJYZDZW?=
 =?utf-8?B?bTFDOStBalAyQ1dtZTJzODBxK1ZYNlhZeGlCUWhQNU1oVk91T29sRUdkazdl?=
 =?utf-8?B?d2xCdWhwalY1NDhpbkZyaU92dkgzZVI1NTJtNll0WFY4bUFFQ3cxSkU3bG81?=
 =?utf-8?Q?q3z4Y2lG6m62o=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1e1d052-d6cf-4c6d-ecb7-08d8a67ae10e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2020 13:09:56.3958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pXldEXSiLYTWylvpD69R2FEWcuVECINkyu6ryoeQuvU2BuVXA7WX+8L6z+utBU+yTtwFmT8JgUI7OP5TO0ZoeNEQQqcHv/p2BJ7V8JR1iwnuxVgYH65CJZcoFXvruxMx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4052
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: ZJXtHsWYR8V84vQzsxBPf0zOx4520388AA=
Content-Type: multipart/mixed; boundary="GR9j6g6sTPc1q0cLwkqH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1608642614;
 bh=FETEex+Ep/9Y7AwLAJW2KBT++2oL5v0rnkm/U5cilwU=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=WOwQATOS+9/45DrGG79RbtbYxo+h3FFRtxEmUjE4yOIk7O17ej/JdAsakoLNmnmxF8G
 draEUR0FGI8JMa0fNo6wUpXGU9ZabJlGpNbLpBXkhN1jrtVJ8eGZw2pZSKzrAxWZt3/c2
 7oFwrx50JE57OTevyulzFu8HF/8qjCz+O3k=

--GR9j6g6sTPc1q0cLwkqH
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGFkIFByYWJoYWth
ciBbbWFpbHRvOnByYWJoYWthci5tYWhhZGV2LWxhZC5yakBicC5yZW5lc2FzLmNvbV0NCj4gU2Vu
dDogVHVlc2RheSwgRGVjZW1iZXIgMjIsIDIwMjAgODoyNyBQTQ0KPiBUbzogY2lwLWRldkBsaXN0
cy5jaXAtcHJvamVjdC5vcmc7IGl3YW1hdHN1IG5vYnVoaXJvKOWyqeadviDkv6HmtIsg4pah77yz
77y377yj4pev77yh77yj77y0KQ0KPiA8bm9idWhpcm8xLml3YW1hdHN1QHRvc2hpYmEuY28uanA+
OyBQYXZlbCBNYWNoZWsgPHBhdmVsQGRlbnguZGU+DQo+IENjOiBCaWp1IERhcyA8YmlqdS5kYXMu
anpAYnAucmVuZXNhcy5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCA0LjQueS1jaXBdIEFSTTogZHRz
OiBpd2cyMmQtc29kaW1tOiBGaXggZHQgbm9kZXMgc29ydGluZw0KPiANCj4gRnJvbTogQmlqdSBE
YXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiANCj4gY29tbWl0IDczYWE1YjdjOTQx
MTQ1YjdhMWE1M2YzMWI2YTcxZGZlOTgwMDc4NzAgdXBzdHJlYW0uDQo+IA0KPiBTb21lIHI4YTc3
NDUtaXdnMjJkLXNvZGltbS5kdHMgZGV2aWNlIG5vZGVzIGFyZSBub3Qgc29ydGVkIGFscGhhYmV0
aWNhbGx5Lg0KPiBUaGlzIHBhdGNoIGZpeGVzIHRoZSBzb3J0aW5nIG9mIG5vZGVzIGFuZCBhbHNv
IGZpeGVzIGEgdHlwbyBpbiB0aGUgc3RtcGUNCj4gbm9kZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4gTGluazogaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvci8yMDIwMDgwNTE0MjYzNC4xMjI1Mi0xLWJpanUuZGFzLmp6QGJwLnJl
bmVzYXMuY29tDQo+IFNpZ25lZC1vZmYtYnk6IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnQrcmVu
ZXNhc0BnbGlkZXIuYmU+DQo+IFtQTDogTWFudWFsbHkgYXBwbGllZCB0aGUgY2hhbmdlc10NCj4g
U2lnbmVkLW9mZi1ieTogTGFkIFByYWJoYWthciA8cHJhYmhha2FyLm1haGFkZXYtbGFkLnJqQGJw
LnJlbmVzYXMuY29tPg0KDQpMb29rcyBnb29kIHRvIG1lLiBJIGNhbiBhcHBseSBpZiB0aGVyZSBh
cmUgbm8gb3RoZXIgY29tbWVudHMuDQoNCkJlc3QgcmVnYXJkcywNCiAgTm9idWhpcm8NCg0KPiAt
LS0NCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL3I4YTc3NDUtaXdnMjJkLXNvZGltbS5kdHMgfCA5OCAr
KysrKysrKysrLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA0OSBpbnNlcnRpb25zKCsp
LCA0OSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9y
OGE3NzQ1LWl3ZzIyZC1zb2RpbW0uZHRzIGIvYXJjaC9hcm0vYm9vdC9kdHMvcjhhNzc0NS1pd2cy
MmQtc29kaW1tLmR0cw0KPiBpbmRleCA1Y2Q5ODk1NTZiNjAuLjVhMTg1OTQ0NjA0NiAxMDA2NDQN
Cj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvcjhhNzc0NS1pd2cyMmQtc29kaW1tLmR0cw0KPiAr
KysgYi9hcmNoL2FybS9ib290L2R0cy9yOGE3NzQ1LWl3ZzIyZC1zb2RpbW0uZHRzDQo+IEBAIC01
NiwyMSArNTYsMzMgQEANCj4gIAkJY2xvY2stZnJlcXVlbmN5ID0gPDI2MDAwMDAwPjsNCj4gIAl9
Ow0KPiANCj4gLQlyc25kX3NndGw1MDAwOiBzb3VuZCB7DQo+IC0JCWNvbXBhdGlibGUgPSAic2lt
cGxlLWF1ZGlvLWNhcmQiOw0KPiAtCQlzaW1wbGUtYXVkaW8tY2FyZCxmb3JtYXQgPSAiaTJzIjsN
Cj4gLQkJc2ltcGxlLWF1ZGlvLWNhcmQsYml0Y2xvY2stbWFzdGVyID0gPCZzbmRjb2RlYz47DQo+
IC0JCXNpbXBsZS1hdWRpby1jYXJkLGZyYW1lLW1hc3RlciA9IDwmc25kY29kZWM+Ow0KPiArCWJh
Y2tsaWdodF9sY2Q6IGJhY2tsaWdodCB7DQo+ICsJCWNvbXBhdGlibGUgPSAicHdtLWJhY2tsaWdo
dCI7DQo+ICsJCXB3bXMgPSA8JnRwdSAzIDUwMDAwMDAgUFdNX1BPTEFSSVRZX0lOVkVSVEVEPjsN
Cj4gKwkJYnJpZ2h0bmVzcy1sZXZlbHMgPSA8MCA0IDggMTYgMzIgNjQgMTI4IDI1NT47DQo+ICsJ
CWRlZmF1bHQtYnJpZ2h0bmVzcy1sZXZlbCA9IDw3PjsNCj4gKwl9Ow0KPiANCj4gLQkJc25kY3B1
OiBzaW1wbGUtYXVkaW8tY2FyZCxjcHUgew0KPiAtCQkJc291bmQtZGFpID0gPCZyY2FyX3NvdW5k
PjsNCj4gLQkJfTsNCj4gKwlsY2RfcGFuZWw6IGxjZCB7DQo+ICsJCWNvbXBhdGlibGUgPSAiZWR0
LGV0bTA0MzA4MGRoNmdwIjsNCj4gKwkJcG93ZXItc3VwcGx5ID0gPCZ2Y2NxX3BhbmVsPjsNCj4g
KwkJYmFja2xpZ2h0ID0gPCZiYWNrbGlnaHRfbGNkPjsNCj4gDQo+IC0JCXNuZGNvZGVjOiBzaW1w
bGUtYXVkaW8tY2FyZCxjb2RlYyB7DQo+IC0JCQlzb3VuZC1kYWkgPSA8JnNndGw1MDAwPjsNCj4g
KwkJcG9ydCB7DQo+ICsJCQlsY2RfaW46IGVuZHBvaW50IHsNCj4gKwkJCQlyZW1vdGUtZW5kcG9p
bnQgPSA8JmR1X291dF9yZ2IwPjsNCj4gKwkJCX07DQo+ICAJCX07DQo+ICAJfTsNCj4gDQo+ICsJ
dmNjcV9wYW5lbDogcmVndWxhdG9yLXZjY3EtcGFuZWwgew0KPiArCQljb21wYXRpYmxlID0gInJl
Z3VsYXRvci1maXhlZCI7DQo+ICsJCXJlZ3VsYXRvci1uYW1lID0gIlBhbmVsIFZjY1EiOw0KPiAr
CQlyZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDwzMzAwMDAwPjsNCj4gKwkJcmVndWxhdG9yLW1h
eC1taWNyb3ZvbHQgPSA8MzMwMDAwMD47DQo+ICsJCWdwaW8gPSA8JmdwaW8xIDEzIEdQSU9fQUNU
SVZFX0xPVz47DQo+ICsJfTsNCj4gKw0KPiAgCXZjY3Ffc2RoaTA6IHJlZ3VsYXRvci12Y2NxLXNk
aGkwIHsNCj4gIAkJY29tcGF0aWJsZSA9ICJyZWd1bGF0b3ItZ3BpbyI7DQo+IA0KPiBAQCAtODQs
MzQgKzk2LDI5IEBADQo+ICAJCQkgIDE4MDAwMDAgMD47DQo+ICAJfTsNCj4gDQo+IC0JdmNjcV9w
YW5lbDogcmVndWxhdG9yLXZjY3EtcGFuZWwgew0KPiAtCQljb21wYXRpYmxlID0gInJlZ3VsYXRv
ci1maXhlZCI7DQo+IC0JCXJlZ3VsYXRvci1uYW1lID0gIlBhbmVsIFZjY1EiOw0KPiAtCQlyZWd1
bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDwzMzAwMDAwPjsNCj4gLQkJcmVndWxhdG9yLW1heC1taWNy
b3ZvbHQgPSA8MzMwMDAwMD47DQo+IC0JCWdwaW8gPSA8JmdwaW8xIDEzIEdQSU9fQUNUSVZFX0xP
Vz47DQo+IC0JfTsNCj4gLQ0KPiAtCWJhY2tsaWdodF9sY2Q6IGJhY2tsaWdodCB7DQo+IC0JCWNv
bXBhdGlibGUgPSAicHdtLWJhY2tsaWdodCI7DQo+IC0JCXB3bXMgPSA8JnRwdSAzIDUwMDAwMDAg
UFdNX1BPTEFSSVRZX0lOVkVSVEVEPjsNCj4gLQkJYnJpZ2h0bmVzcy1sZXZlbHMgPSA8MCA0IDgg
MTYgMzIgNjQgMTI4IDI1NT47DQo+IC0JCWRlZmF1bHQtYnJpZ2h0bmVzcy1sZXZlbCA9IDw3PjsN
Cj4gLQl9Ow0KPiArCXJzbmRfc2d0bDUwMDA6IHNvdW5kIHsNCj4gKwkJY29tcGF0aWJsZSA9ICJz
aW1wbGUtYXVkaW8tY2FyZCI7DQo+ICsJCXNpbXBsZS1hdWRpby1jYXJkLGZvcm1hdCA9ICJpMnMi
Ow0KPiArCQlzaW1wbGUtYXVkaW8tY2FyZCxiaXRjbG9jay1tYXN0ZXIgPSA8JnNuZGNvZGVjPjsN
Cj4gKwkJc2ltcGxlLWF1ZGlvLWNhcmQsZnJhbWUtbWFzdGVyID0gPCZzbmRjb2RlYz47DQo+IA0K
PiAtCWxjZF9wYW5lbDogbGNkIHsNCj4gLQkJY29tcGF0aWJsZSA9ICJlZHQsZXRtMDQzMDgwZGg2
Z3AiOw0KPiAtCQlwb3dlci1zdXBwbHkgPSA8JnZjY3FfcGFuZWw+Ow0KPiAtCQliYWNrbGlnaHQg
PSA8JmJhY2tsaWdodF9sY2Q+Ow0KPiArCQlzbmRjcHU6IHNpbXBsZS1hdWRpby1jYXJkLGNwdSB7
DQo+ICsJCQlzb3VuZC1kYWkgPSA8JnJjYXJfc291bmQ+Ow0KPiArCQl9Ow0KPiANCj4gLQkJcG9y
dCB7DQo+IC0JCQlsY2RfaW46IGVuZHBvaW50IHsNCj4gLQkJCQlyZW1vdGUtZW5kcG9pbnQgPSA8
JmR1X291dF9yZ2IwPjsNCj4gLQkJCX07DQo+ICsJCXNuZGNvZGVjOiBzaW1wbGUtYXVkaW8tY2Fy
ZCxjb2RlYyB7DQo+ICsJCQlzb3VuZC1kYWkgPSA8JnNndGw1MDAwPjsNCj4gIAkJfTsNCj4gIAl9
Ow0KPiAgfTsNCj4gDQo+ICsmY2FuMCB7DQo+ICsJcGluY3RybC0wID0gPCZjYW4wX3BpbnM+Ow0K
PiArCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+ICsNCj4gKwlzdGF0dXMgPSAib2theSI7
DQo+ICt9Ow0KPiArDQo+ICAmZHUgew0KPiAgCXBpbmN0cmwtMCA9IDwmZHUwX3BpbnM+Ow0KPiAg
CXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+IEBAIC0xMjcsMTMgKzEzNCw2IEBADQo+ICAJ
fTsNCj4gIH07DQo+IA0KPiAtJmNhbjAgew0KPiAtCXBpbmN0cmwtMCA9IDwmY2FuMF9waW5zPjsN
Cj4gLQlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPiAtDQo+IC0Jc3RhdHVzID0gIm9rYXki
Ow0KPiAtfTsNCj4gLQ0KPiAgJmhzY2lmMSB7DQo+ICAJcGluY3RybC0wID0gPCZoc2NpZjFfcGlu
cz47DQo+ICAJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4gQEAgLTE0OSw2ICsxNDksMTUg
QEANCj4gIAlzdGF0dXMgPSAib2theSI7DQo+ICAJY2xvY2stZnJlcXVlbmN5ID0gPDQwMDAwMD47
DQo+IA0KPiArCXNndGw1MDAwOiBjb2RlY0BhIHsNCj4gKwkJY29tcGF0aWJsZSA9ICJmc2wsc2d0
bDUwMDAiOw0KPiArCQkjc291bmQtZGFpLWNlbGxzID0gPDA+Ow0KPiArCQlyZWcgPSA8MHgwYT47
DQo+ICsJCWNsb2NrcyA9IDwmYXVkaW9fY2xvY2s+Ow0KPiArCQlWRERBLXN1cHBseSA9IDwmcmVn
XzNwM3Y+Ow0KPiArCQlWRERJTy1zdXBwbHkgPSA8JnJlZ18zcDN2PjsNCj4gKwl9Ow0KPiArDQo+
ICAJc3RtcGU4MTFANDQgew0KPiAgCQljb21wYXRpYmxlID0gInN0LHN0bXBlODExIjsNCj4gIAkJ
cmVnID0gPDB4NDQ+Ow0KPiBAQCAtMTU3LDcgKzE2Niw3IEBADQo+IA0KPiAgCQkvKiAzLjI1IE1I
eiBBREMgY2xvY2sgc3BlZWQgKi8NCj4gIAkJc3QsYWRjLWZyZXEgPSA8MT47DQo+IC0JCS8qIEFE
QyBjb252ZXJzdGlvbiB0aW1lOiA4MCBjbG9ja3MgKi8NCj4gKwkJLyogQURDIGNvbnZlcnNhdGlv
biB0aW1lOiA4MCBjbG9ja3MgKi8NCj4gIAkJc3Qsc2FtcGxlLXRpbWUgPSA8ND47DQo+ICAJCS8q
IDEyLWJpdCBBREMgKi8NCj4gIAkJc3QsbW9kLTEyYiA9IDwxPjsNCj4gQEAgLTE4MSwxNSArMTkw
LDYgQEANCj4gIAkJCXN0LHRvdWNoLWRldC1kZWxheSA9IDw1PjsNCj4gIAkJfTsNCj4gIAl9Ow0K
PiAtDQo+IC0Jc2d0bDUwMDA6IGNvZGVjQGEgew0KPiAtCQljb21wYXRpYmxlID0gImZzbCxzZ3Rs
NTAwMCI7DQo+IC0JCSNzb3VuZC1kYWktY2VsbHMgPSA8MD47DQo+IC0JCXJlZyA9IDwweDBhPjsN
Cj4gLQkJY2xvY2tzID0gPCZhdWRpb19jbG9jaz47DQo+IC0JCVZEREEtc3VwcGx5ID0gPCZyZWdf
M3Azdj47DQo+IC0JCVZERElPLXN1cHBseSA9IDwmcmVnXzNwM3Y+Ow0KPiAtCX07DQo+ICB9Ow0K
PiANCj4gICZwZmMgew0KPiAtLQ0KPiAyLjE3LjENCg0K

--GR9j6g6sTPc1q0cLwkqH
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5972): https://lists.cip-project.org/g/cip-dev/message=
/5972
Mute This Topic: https://lists.cip-project.org/mt/79146851/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--GR9j6g6sTPc1q0cLwkqH--
