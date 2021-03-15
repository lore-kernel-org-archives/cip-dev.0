Return-Path: <SRS0=q2LS=IN=lists.cip-project.org=bounce+64572+6283+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7127EC433DB
	for <cip-dev@archiver.kernel.org>; Mon, 15 Mar 2021 05:32:54 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB76461481
	for <cip-dev@archiver.kernel.org>; Mon, 15 Mar 2021 05:32:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB76461481
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hitachi.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6283+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id cSzqYY4521723xjg2JEhnhi2; Sun, 14 Mar 2021 22:32:53 -0700
X-Received: from esa7.hc514-86.ap.iphmx.com (esa7.hc514-86.ap.iphmx.com [207.54.75.17])
 by mx.groups.io with SMTP id smtpd.web09.4906.1615786371709681823
 for <cip-dev@lists.cip-project.org>;
 Sun, 14 Mar 2021 22:32:53 -0700
IronPort-SDR: 4cIovGXMhlyj5VcEqQWEKY0O9JRMutbRaK1tjaXIgk43vPSO447skOru0+alVwdioJylSqD/5F
 SBLr53aPTxoy28ZlQCXEfSntqjmLSCHk7pHK1ece11Mpu7nIjhpBdPTxOetpZEFTv4udp6Vyt0
 OJxY0VtzVrHQCnXWuVlfoUBdjuiyri+RwU0SdQQbt9nOUycGEjfnW2boFfeJGOi5H6V9Wnl4pK
 1XmqM5w8/Jhtodaa2l/Xz7m2xIkZ/ihLtbP+N9cjQv+E/LzH/V6fRap+tVbTWp0e3nGZJ8CTzH
 quM=
X-IronPort-AV: E=Sophos;i="5.81,249,1610409600"; 
   d="scan'208";a="5616095"
X-Received: from mail12.maildeliv.hitachi.co.jp (HELO mail12.hitachi.co.jp) ([133.145.228.59])
  by ob1.hc514-86.ap.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 15 Mar 2021 05:32:50 +0000
X-Received: from mlsv8.hitachi.co.jp (unknown [133.145.228.43])
	by mail12.hitachi.co.jp (Postfix) with ESMTP id 75BF91E002C
	for <cip-dev@lists.cip-project.org>; Mon, 15 Mar 2021 14:32:49 +0900 (JST)
X-Received: from mfgw02.hitachi.co.jp by mlsv8.hitachi.co.jp (8.14.4/8.14.4) id 12F5Wmlq007296; Mon, 15 Mar 2021 14:32:49 +0900
X-Received: from GUjpTK3DCemcs01.global.hitachi.net ([158.213.250.10])
	by mfgw02.hitachi.co.jp with ESMTP
	id LfqTlsadsNOj4LfqTlmx6C; Mon, 15 Mar 2021 14:32:49 +0900
X-Received: from GUjpTKHDCemcs07.global.hitachi.net (2002:9ed5:d274::9ed5:d274)
 by GUjpTK3DCemcs01.global.hitachi.net (2002:9ed5:fa0a::9ed5:fa0a) with
 Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 15 Mar 2021 14:32:49 +0900
X-Received: from GUjpTKHDCemcs04.global.hitachi.net (2002:9ed5:d24d::9ed5:d24d)
 by GUjpTKHDCemcs07.global.hitachi.net (2002:9ed5:d274::9ed5:d274) with
 Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 15 Mar 2021 14:32:49 +0900
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (74.107.156.4) by
 GUjpTKHDCemcs04.global.hitachi.net (158.213.210.77) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2 via Frontend Transport; Mon, 15 Mar 2021 14:32:49
 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HhmXN9C1WZq2OyubYoUbIFIFvc/Uh7vjl4oqtCgUL8UwfcC42Mchc2iUtzhfXxn6YTV7owJx0mNa8alQUL/5P/c7p/8+svgGjxlFDZrWCC6btFhLKJrZan9eCfZsUXw8k2XvRI6ZaQAgXSVD8GxifTUA4rsyGpSKB3XCud5wuRt1QJopORz8UVY6xOZss/wQyHnQfmRysMjEO9E/ZO/w8nteeLupZ5B9sfQwIi5ClqrX2jcRV/n1UEuZgQlBYm0lPaaBU1G8moQNH+ERdvMxuMA4Ly8TBfSS6JcwXUOLVRg7fqsUWc+gwTtUt/RhE/8mpXJdFyD7tUEXH5EBtGGKCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgMJj3d2o5In5zZOLza1QZN52JQ76AnC+TNQX9sXUVE=;
 b=lPNuF6dnQ+ONfHjFyUS9xN5tOWWstvbupfGyMcwj3FPFNPlRefm84KawqgLihYus/0/alpkT6FU3x8I/EYHxWQogFCCA0aXxHJNn83p/94UkNPOKVVT/JdUGjwtV4ttNDDm64p9UxrmgAL3qVRj3w4em7E+Fq8OcxRjAU9dNsUrSKyp9ZuOPtdJnKADrL5KNqJLgrndpZtjb2itdxx0SChJdl6VBU3lBRQVLPcv1pdwCQpdNJosr44W+wMRxwmXA+hrlU29fSBc1UK8HAHTeo10vgp0sj4rMM1ZFIgP4g5fXiB2IwyewDnuusMOGIAe7PpVX6uDHR5BlUnAIg9ymzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hitachi.com; dmarc=pass action=none header.from=hitachi.com;
 dkim=pass header.d=hitachi.com; arc=none
X-Received: from TY2PR01MB2652.jpnprd01.prod.outlook.com (2603:1096:404:6b::9)
 by TYAPR01MB4061.jpnprd01.prod.outlook.com (2603:1096:404:c9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Mon, 15 Mar
 2021 05:32:48 +0000
X-Received: from TY2PR01MB2652.jpnprd01.prod.outlook.com
 ([fe80::ec98:97f6:1862:ffbe]) by TY2PR01MB2652.jpnprd01.prod.outlook.com
 ([fe80::ec98:97f6:1862:ffbe%5]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 05:32:48 +0000
From: "Takuo Koguchi" <takuo.koguchi.sw@hitachi.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] Is cadence-quadspi working on cyclone V?
Thread-Topic: [cip-dev] Is cadence-quadspi working on cyclone V?
Thread-Index: AQHXGVunJvUQHMbyG0CdjS8GLoLB7qqEhYBA
Date: Mon, 15 Mar 2021 05:31:21 +0000
Deferred-Delivery: Mon, 15 Mar 2021 05:33:00 +0000
Message-ID: <TY2PR01MB2652FC36002EB35C347B19C1D76C9@TY2PR01MB2652.jpnprd01.prod.outlook.com>
References: <TY2PR01MB26520E38F23C33EB2B59D539D76C9@TY2PR01MB2652.jpnprd01.prod.outlook.com>
 <OSBPR01MB2983A8AF3568F39D2D1DE455926C9@OSBPR01MB2983.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB2983A8AF3568F39D2D1DE455926C9@OSBPR01MB2983.jpnprd01.prod.outlook.com>
Accept-Language: en-US, ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [202.246.252.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 36470aaf-9542-4d60-cc1f-08d8e773c4e4
x-ms-traffictypediagnostic: TYAPR01MB4061:
x-microsoft-antispam-prvs: <TYAPR01MB4061A06737222A7EAFFFF113D76C9@TYAPR01MB4061.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iBrFxHTCwsAc/S6bEuFbFWsLfrs/NaWID7risXtIR2eY32s+CYblKhKmqQq9kPkeo+WNjEEf1PGRkn9iXZuYxlMaAB5uOfE0cJ3zm7hdpSLWkqVR7OgTD5p0evkbzjMNWyV58VT+UD7kikwsqrgmdxswBleRCPsK13B6RoiFbylctJu0j9hDzP6nmHmizji8YsD8hylirtADqgDLDg+9vvZDjqyMt81g2TPjAjqvtqPGaPhsQN1FTerWvlACkmCtvcYfpVTVgJpzhBdUpYEh4DoluZoA6jCh2j3ODeZ5vfryUn9VjknOR2g7P/PmpsaqkfyPBdcW697wBlsncXzcZ+sp4JSzIz2RoCqwVVYc1s2mPNWEYs/LHQD0vr7L+wEBiW/dWIJdDvwuoYNh7n/6yQ2nHn4KNj2gJmO9evzcZ1N5LLnSEZ8ftygSWVmIDBQiCeOO0BJSqs8a8StiY/U8cB1t8tqIS3oxsQxDYNTjb91TfzMRi4MF7vbdeLpTAQgGbkQ7o1LZeEvf2xgBBR1OdNH6nk2gEQuJtfV8EX/eIUJcBjp+Xp4jXhfnNyG/aYGIDC2L5KCZjUJZM2zwFywGG4pMyVuTOcd4uX9NN6xBJHEwCvWqlPxc/xo6+SbkEzaL9xXKWBEIwMUCj6cUTMdpLg==
x-ms-exchange-antispam-messagedata: =?utf-8?B?aVNmR3Y0c0ZtZ3pMdUtUTU5mOW5NRGRxNnNWRzFlSWxsSVNCR2pVYW9lUThp?=
 =?utf-8?B?WWpNS3NDWU1nVFREbVBUelV0cW5rU3l4Y01SWi9MMnBzRXl3dkF5OC92ajI0?=
 =?utf-8?B?ZDVUKzFPTHpEZzFIQ1J4Z2ZwazlSZlgwNkdBcUpIZjJXbm5kd0xiYzR2UXAr?=
 =?utf-8?B?SCtlMkV1VWs5OTNjb0wzc1o5WTBJTVMwK3p4RWNCODlwMlppN1lCUDFTL1U0?=
 =?utf-8?B?Q1VvUGh5dFpVK3NEeFIxK1k3dmEvL2hUVUdKeWlIaDZJV1YySnpqWVR3d1Z4?=
 =?utf-8?B?WS9FNFFmdkFXZXJERENicGQ0U3Bzb2JKTTVNaTNiMWZZSGorWmlOUW9vMHFV?=
 =?utf-8?B?N0xnZlMwTGdKR1c4MUQ4WXJCYlFMa0R5Uk5UdDlWZTJSaWwrK1E3NXgySEFH?=
 =?utf-8?B?QlhCSjJlZDNvZGNVOXI1YUgraGtpTDJlMzlaSi9OUURBMHYxYWNNakhpTFln?=
 =?utf-8?B?aUZnbGNXMm51VDIwNllZQnV2emUwUktKSDBpeWR4WkdjeGdWenFuNnRsL1JX?=
 =?utf-8?B?OERFcFZFTGhMbjBXK3ljT21HRzN3SlRRbGpqSjBmMEw0eEFZbDR2V1BTdTZz?=
 =?utf-8?B?VGJjWm8zSENUZzcyR0xZZ1haRXowZlhMSHJKSWRPdC90S1JKMDk0azFYVzI0?=
 =?utf-8?B?OXpNNVpUem1MZEhmSzBWYlRkRXd0Q2cyUVdqc20vcm5vOG40bkZ3cHBkNUNp?=
 =?utf-8?B?b29TbHV1bmdUcGxIVWI0VHZUcm5hUEFlMjI4Z1Jzd3hRMTVrbndtaENNUG5U?=
 =?utf-8?B?K2VNVGRDSUh6SFJHeFlseXd3Rm92eWdtS1ltYXRWaldhWlVIR1lQRytWZ2dF?=
 =?utf-8?B?RmhMRUZ1cTNhYzJKdllPUmdQY05ESjA0clEzYk40ZDlGRjhJUGZrelRYZkk2?=
 =?utf-8?B?N1YrTGxFZFBtTkdQcVErS1lTWktMaTZYRituT0xyMGJybjBvbDJ1RXBTb25u?=
 =?utf-8?B?MEd6RFdkUnRZanpnQzI2cmx3S1c5dCtpRWd4bnhaYklmTlVlWUgwM3JoczVK?=
 =?utf-8?B?bmtCem5aVUs4Q0xBa3dqcklxWk1aVmlXSWwvUHUzejI2cDRnUzF2RE5iZnBj?=
 =?utf-8?B?cm5temhqRjZ6RU0zQ3NCeWdxTTBud0VEQ2RJRlhJQnQ1TWU2TTR6SEF2TDNV?=
 =?utf-8?B?My9lZE1qSVVuZERYMDNTcVUwRzlxTGxnL3NsMEUrWkduR2c0M2FlSjk3ZnM3?=
 =?utf-8?B?RkhYTjZtU3pvYnVQZGR5dWl1L0l0N2M3YmFPaU90WExtT215bVZ5cU9CY0tT?=
 =?utf-8?B?b1NkeGt6V2orS3RLY2VreE1hNTl2TEcrQWNTMzhkVjZJaTZJM2xVYlhsdlNQ?=
 =?utf-8?B?U3BKVVd3dEJpZ3RsUTlBeS81VXQ0dFNncU5PVk9CN2tQaHNOR2g1Nlk4RFFK?=
 =?utf-8?B?QVkwbk5KUHRKbzc1OU9wZ0hGRTlXeVJmYzNGK09XUTBxMFpTUmJmRzh3K1BH?=
 =?utf-8?B?Y3k5VFJ5eXkxVi92TUsvc1MwNmkxQStpZSthd3lGa0U1RjdwWlRZM2c2K2pP?=
 =?utf-8?B?Q21xS2Z2VndZTzJoOTBqRXRaYURlQ2ZQTW5LRk9ZMnZQTFJIOExUR3Q4WEhY?=
 =?utf-8?B?RU9PcUMwUG9FSzl4L3h1Q2ZoV2VCekhvYnRUVGo2ZGpoM2FhYmdwbnBLSlRN?=
 =?utf-8?B?eVBhMnB2dDNoNVNEZUVhTEpLRXVIRWJTRXpXQ3Rsd0xLTDBpamZXejhSbVRZ?=
 =?utf-8?B?VEtSS2F6N1VWeTZDcGVOUHZoWHNHQzczdWFUVmp0ZHVWbzdoQXVTRHQ0ZXVE?=
 =?utf-8?Q?fLQCbQzsHioYYKhte2BjEAx7cX25A5WW2W5SGZz?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB2652.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36470aaf-9542-4d60-cc1f-08d8e773c4e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2021 05:32:48.2929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f54277c9-dafe-44aa-85a4-73d5c7c52450
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k/BYYhMIxUPX3YqHrccDWFAKIZjBWAoYZIuq8NHPpfkwkfY5uad7r44Ya0cXVXHUQ1gOXRSP7VikmEM+D1NdsWmx8eep25qeUEasPEgDCls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4061
X-OriginatorOrg: hitachi.com
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: PLmxbYp0TMdqzj1b1Wv4ndOQx4520388AA=
Content-Type: multipart/mixed; boundary="7XtVDy22fwjqFXt9MZKl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1615786373;
 bh=MCDnvcm8OSoFnGed/3y2SEibmVregF4/5IsfKeuiRrc=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=FAyBN/2xOkpX8XAR8LX1eNTz8Etb0zPEhXrzbSQZZK9w7iYRwYS5a8x5AtrbGYQgc1n
 sVRGU+zetgGXGaGs0XSKdE59JHYUjM4nDylvBFnBSZZBYLXUC71/H+nXKi8GdUGjmQrA+
 J8xc47Jg/7Iz7VIPosxQ4jAcQzOw8Bog2Ds=

--7XtVDy22fwjqFXt9MZKl
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SXdhbWF0c3Utc2FuLA0KDQpUaGFuayB5b3UgZm9yIHRoZSBpbmZvcm1hdGlvbi4gDQo+IEl0IHJl
Y29nbml6ZXMgTk9SIGZsYXNoIGluIDUuMTAueS4gSG93IGFib3V0IGNoZWNraW5nIERUUz8NCj4g
U29kaWEgYm9hcmQgdXNlcyBuMjVxNTEyYSBhbmQgaGFzIHRoZSBmb2xsb3dpbmcgRFQ6DQo+IGBg
YA0KPiAmcXNwaSB7DQo+IAlzdGF0dXMgPSAib2theSI7DQo+IA0KPiAJZmxhc2gwOiBuMjVxNTEy
YUAwIHsNCj4gCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4gCQkjc2l6ZS1jZWxscyA9IDwxPjsN
Cj4gCQljb21wYXRpYmxlID0gIm4yNXE1MTJhIjsNCj4gCQlyZWcgPSA8MD47DQo+IAkJc3BpLW1h
eC1mcmVxdWVuY3kgPSA8MTAwMDAwMDAwPjsNCj4gDQo+IAkJbTI1cCxmYXN0LXJlYWQ7DQo+IAkJ
Y2RucyxwYWdlLXNpemUgPSA8MjU2PjsNCj4gCQljZG5zLGJsb2NrLXNpemUgPSA8MTY+Ow0KPiAJ
CWNkbnMscmVhZC1kZWxheSA9IDw0PjsNCj4gCQljZG5zLHRzaHNsLW5zID0gPDUwPjsNCj4gCQlj
ZG5zLHRzZDJkLW5zID0gPDUwPjsNCj4gCQljZG5zLHRjaHNoLW5zID0gPDQ+Ow0KPiAJCWNkbnMs
dHNsY2gtbnMgPSA8ND47DQo+IAl9Ow0KPiB9Ow0KPiBgYGANCkkgYW0gZ29pbmcgdG8gbG9vayBp
bnRvIHRoZSBkaWZmZXJlbmNlLg0KDQpUYWt1byBLb2d1Y2hpDQoNCj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gRnJvbTogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcgPGNpcC1k
ZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnPiBPbiBCZWhhbGYgT2YgTm9idWhpcm8gSXdhbWF0c3UN
Cj4gU2VudDogTW9uZGF5LCBNYXJjaCAxNSwgMjAyMSAyOjI1IFBNDQo+IFRvOiBjaXAtZGV2QGxp
c3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiBTdWJqZWN0OiBbIV1SZTogW2NpcC1kZXZdIElzIGNhZGVu
Y2UtcXVhZHNwaSB3b3JraW5nIG9uIGN5Y2xvbmUgVj8NCj4gDQo+IEhpIEtvZ3VjaGktc2FuLA0K
PiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IGNpcC1kZXZAbGlz
dHMuY2lwLXByb2plY3Qub3JnDQo+ID4gW21haWx0bzpjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0
Lm9yZ10gT24gQmVoYWxmIE9mIFRha3VvIEtvZ3VjaGkNCj4gPiBTZW50OiBNb25kYXksIE1hcmNo
IDE1LCAyMDIxIDE6MzMgUE0NCj4gPiBUbzogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcN
Cj4gPiBTdWJqZWN0OiBSZTogW2NpcC1kZXZdIElzIGNhZGVuY2UtcXVhZHNwaSB3b3JraW5nIG9u
IGN5Y2xvbmUgVj8NCj4gPg0KPiA+IEhpIFBhdmVsLA0KPiA+DQo+ID4gPiA+PiBHaXQgYmlzZWN0
IGhhcyB0b2xkIG1lIHRoZSBmaXJzdCBiYWQgY29tbWl0IGlzDQo+ID4gPiA+PiAzMWZiNjMyYjVk
NDMgc3BpOiBNb3ZlIGNhZGVuY2UtcXVhZHNwaSBkcml2ZXIgdG8gZHJpdmVycy9zcGkvDQo+ID4g
PiA+DQo+ID4gPiA+IFRoYXQncyBzdHJhbmdlLg0KPiA+ID4gPg0KPiA+ID4gPj4gRG9lcyB0aGlz
IGNoYW5nZSByZXF1aXJlcyBkZXZpY2UgdHJlZSBtb2RpZmljYXRpb24/DQo+ID4gPiA+PiBBbnkg
c3VnZ2VzdGlvbnMgb3IgY29tbWVudHMgd291bGQgYmUgYXBwcmVjaWF0ZWQuDQo+ID4gPiA+DQo+
ID4gPiA+IC4uLmJlY2F1c2UgdGhhdCBwYXJ0aWN1bGFyIGNoYW5nZSBkb2VzIG5vdCBjaGFuZ2Ug
YW55IEMgY29kZS4gQnV0DQo+ID4gPiA+IGl0IHRvdWNoZXMgS2NvbmZpZyBiaXRzOyBjYW4geW91
IGNoZWNrIHRoYXQNCj4gPiA+ID4gQ09ORklHX1NQSV9DQURFTkNFX1FVQURTUEkgaXMgZW5hYmxl
ZCBpbiB0aGUgImJhZCIgY29uZmlndXJhdGlvbj8NCj4gPiA+ID4NCj4gPiA+ID4gRG8geW91IGhh
dmUgYW55IGxvY2FsIGNoYW5nZXMgaW4NCj4gPiA+ID4gZHJpdmVycy9tdGQvc3BpLW5vci9jb250
cm9sbGVycy9jYWRlbmNlLXF1YWRzcGkuYyBvcg0KPiA+ID4gPiBkcml2ZXJzL3NwaS9zcGktY2Fk
ZW5jZS1xdWFkc3BpLmMgPw0KPiA+ID4gSSBoYXZlIG5vIGxvY2FsIGNoYW5nZXMgdG8gdGhvc2Ug
ZmlsZXMuDQo+ID4gPiBNYXliZSBJIGxvc3QgQ09ORklHX1NQSV9DQURFTkNFX1FVQURTUEkgYWNj
aWRlbnRhbGx5IHdoaWxlIGJpc2VjdGluZy4NCj4gPiA+IEkgd2lsbCB0cnkgYmlzZWN0IGFuZCBw
b3N0IHRoZSByZXN1bHQgYWdhaW4uDQo+ID4gPg0KPiA+DQo+ID4gSSByZWRvIHRoZSBiaXNlY3Qg
YW5kIGdldCB0aGUgZm9sbG93aW5nIHJlc3VsdDsgIyBmaXJzdCBiYWQgY29tbWl0Og0KPiA+IFth
MzE0ZjYzNjc3ODdlZTFkNzY3ZGY5YTIxMjBmMTdlNDUxMTE0NGQwXSBtdGQ6IHNwaS1ub3I6IENv
bnZlcnQNCj4gPiBjYWRlbmNlLXF1YWRzcGkgdG8gdXNlIHNwaS1tZW0gZnJhbWV3b3JrDQo+ID4N
Cj4gPiBJdCBjb250YWlucyBzaWduaWZpY2FudCBhbW91bnQgb2YgY2hhbmdlczsNCj4gPg0KPiA+
IGNhZGVuY2UtcXVhZHNwaS5jIHwgIDQ3Ng0KPiA+ICsrKysrKysrKysrKysrKysrKysrKy0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTkxIGlu
c2VydGlvbnMoKyksIDI4NSBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IFdpdGggdGhpcyBjaGFuZ2Us
IGNwc3BpX3Byb2JlIHJldHVybiAwIHdpdGhvdXQgYW55IGVycm9yIG1lc3NhZ2VzLCBidXQNCj4g
PiBpdCBkb2VzIG5vdCBkZXRlY3QgTk9SIGZsYXNoIG9uIGEgY3VzdG9tIGN5Y2xvbmUgViBib2Fy
ZC4NCj4gPg0KPiA+IEFueSBpbmZvcm1hdGlvbiB3aWxsIGJlIGFwcHJlY2lhdGVkLg0KPiANCj4g
SSBjaGVja2VkIG9uIGEgU29kaWEgYm9hcmQgd2l0aCB0aGUgc2FtZSBTb0MuDQo+IA0KPiBodHRw
czovL3NlY3VyZS13ZWIuY2lzY28uY29tLzFDaE9NcktuU0JSNVFaZWVqdnJOczNQZjR4OF9fTV9R
VlVIRXJuQjlzbFYtVEFXUDNOVXdlMExFenNpcnZNN3JyLU9xdg0KPiBSS3JneGdJM2lRbzVJVGRV
ZWhGeURwcGQyR2xqa0V6eDdpenYxNnBFUm5pWDBEZURtendFNWg5cFVZcXRJeE8zV0FGVER1SF9F
Ry1STmhORnFLNExRYWtaOTBzRVNGNg0KPiBETXZzX2pvdk41NVhqNXU5a05PQ19ldzc2cEx0QU1B
T2ROM0JaU1ZfZlJfbjZ0Y1dsaHZxSjZPbFVFZnJwejl4dnktZ3UxVkhyZ2NnajFCSUNhQmlkOWJW
VXphMS1UN3JCYw0KPiBJMkVqRUN0ZDBxQ01jc3ZMWVpQeHZ6Zlo5LUh1NnJGbGFDUTBydWh4WlZm
SHVWV0VCMzdlUW1tMEhMSFlKRzJfUl9vdXNWZVZEazhiSmEyaUEvaHR0cHMlM0ElMkYlMg0KPiBG
Z2l0Lmtlcm5lbC5vcmclMkZwdWIlMkZzY20lMkZsaW51eCUyRmtlcm5lbCUyRmdpdCUyRmNpcCUy
RmxpbnV4LWNpcC5naXQlMkZ0cmVlJTJGYXJjaCUyRmFybSUyRmJvb3QlMkZkDQo+IHRzJTJGc29j
ZnBnYV9jeWNsb25lNV9zb2RpYS5kdHMlM0ZoJTNEbGludXgtNS4xMC55LWNpcA0KPiANCj4gSXQg
cmVjb2duaXplcyBOT1IgZmxhc2ggaW4gNS4xMC55LiBIb3cgYWJvdXQgY2hlY2tpbmcgRFRTPw0K
PiBTb2RpYSBib2FyZCB1c2VzIG4yNXE1MTJhIGFuZCBoYXMgdGhlIGZvbGxvd2luZyBEVDoNCj4g
YGBgDQo+ICZxc3BpIHsNCj4gCXN0YXR1cyA9ICJva2F5IjsNCj4gDQo+IAlmbGFzaDA6IG4yNXE1
MTJhQDAgew0KPiAJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiAJCSNzaXplLWNlbGxzID0gPDE+
Ow0KPiAJCWNvbXBhdGlibGUgPSAibjI1cTUxMmEiOw0KPiAJCXJlZyA9IDwwPjsNCj4gCQlzcGkt
bWF4LWZyZXF1ZW5jeSA9IDwxMDAwMDAwMDA+Ow0KPiANCj4gCQltMjVwLGZhc3QtcmVhZDsNCj4g
CQljZG5zLHBhZ2Utc2l6ZSA9IDwyNTY+Ow0KPiAJCWNkbnMsYmxvY2stc2l6ZSA9IDwxNj47DQo+
IAkJY2RucyxyZWFkLWRlbGF5ID0gPDQ+Ow0KPiAJCWNkbnMsdHNoc2wtbnMgPSA8NTA+Ow0KPiAJ
CWNkbnMsdHNkMmQtbnMgPSA8NTA+Ow0KPiAJCWNkbnMsdGNoc2gtbnMgPSA8ND47DQo+IAkJY2Ru
cyx0c2xjaC1ucyA9IDw0PjsNCj4gCX07DQo+IH07DQo+IGBgYA0KPiA+DQo+ID4gVGhhbmtzLA0K
PiA+DQo+ID4gVGFrdW8gS29ndWNoaQ0KPiA+DQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+ICAgTm9i
dWhpcm8NCj4gDQo+IA0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZy
b206IOWwj+WPo+eQouWkqyAvIEtPR1VDSEnvvIxUQUtVTw0KPiA+ID4gU2VudDogU3VuZGF5LCBN
YXJjaCAxNCwgMjAyMSA0OjM3IFBNDQo+ID4gPiBUbzogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVj
dC5vcmcNCj4gPiA+IFN1YmplY3Q6IFJlOiBbIV1SZTogW2NpcC1kZXZdIElzIGNhZGVuY2UtcXVh
ZHNwaSB3b3JraW5nIG9uIGN5Y2xvbmUgVj8NCj4gPiA+DQo+ID4gPiBIaSBQYXZlbCwNCj4gPiA+
IFRoYW5rIHlvdSBmb3IgdGhlIHJlc3BvbnNlLg0KPiA+ID4NCj4gPiA+ID4+IEdpdCBiaXNlY3Qg
aGFzIHRvbGQgbWUgdGhlIGZpcnN0IGJhZCBjb21taXQgaXMNCj4gPiA+ID4+IDMxZmI2MzJiNWQ0
MyBzcGk6IE1vdmUgY2FkZW5jZS1xdWFkc3BpIGRyaXZlciB0byBkcml2ZXJzL3NwaQ0KPiA+ID4g
Pg0KPiA+ID4gPiBUaGF0J3Mgc3RyYW5nZS4NCj4gPiA+ID4NCj4gPiA+ID4+IERvZXMgdGhpcyBj
aGFuZ2UgcmVxdWlyZXMgZGV2aWNlIHRyZWUgbW9kaWZpY2F0aW9uPw0KPiA+ID4gPj4gQW55IHN1
Z2dlc3Rpb25zIG9yIGNvbW1lbnRzIHdvdWxkIGJlIGFwcHJlY2lhdGVkLg0KPiA+ID4gPg0KPiA+
ID4gPiAuLi5iZWNhdXNlIHRoYXQgcGFydGljdWxhciBjaGFuZ2UgZG9lcyBub3QgY2hhbmdlIGFu
eSBDIGNvZGUuIEJ1dA0KPiA+ID4gPiBpdCB0b3VjaGVzIEtjb25maWcgYml0czsgY2FuIHlvdSBj
aGVjayB0aGF0DQo+ID4gPiA+IENPTkZJR19TUElfQ0FERU5DRV9RVUFEU1BJIGlzIGVuYWJsZWQg
aW4gdGhlICJiYWQiIGNvbmZpZ3VyYXRpb24/DQo+ID4gPiA+DQo+ID4gPiA+IERvIHlvdSBoYXZl
IGFueSBsb2NhbCBjaGFuZ2VzIGluDQo+ID4gPiA+IGRyaXZlcnMvbXRkL3NwaS1ub3IvY29udHJv
bGxlcnMvY2FkZW5jZS1xdWFkc3BpLmMgb3INCj4gPiA+ID4gZHJpdmVycy9zcGkvc3BpLWNhZGVu
Y2UtcXVhZHNwaS5jID8NCj4gPiA+IEkgaGF2ZSBubyBsb2NhbCBjaGFuZ2VzIHRvIHRob3NlIGZp
bGVzLg0KPiA+ID4gTWF5YmUgSSBsb3N0IENPTkZJR19TUElfQ0FERU5DRV9RVUFEU1BJIGFjY2lk
ZW50YWxseSB3aGlsZSBiaXNlY3RpbmcuDQo+ID4gPiBJIHdpbGwgdHJ5IGJpc2VjdCBhbmQgcG9z
dCB0aGUgcmVzdWx0IGFnYWluLg0KPiA+ID4NCj4gPiA+IFJlZ2FyZHMsDQo+ID4gPg0KPiA+ID4g
VGFrdW8gS29ndWNoaQ0KPiA+ID4NCj4gPiA+ID4gMjAyMS8wMy8xMyA4OjA344CBUGF2ZWwgTWFj
aGVrIDxwYXZlbEBkZW54LmRlPuOBruODoeODvOODqzoNCj4gPiA+ID4NCj4gPiA+ID4gSGkhDQo+
ID4gPiA+DQo+ID4gPiA+PiBHaXQgYmlzZWN0IGhhcyB0b2xkIG1lIHRoZSBmaXJzdCBiYWQgY29t
bWl0IGlzDQo+ID4gPiA+PiAzMWZiNjMyYjVkNDMgc3BpOiBNb3ZlIGNhZGVuY2UtcXVhZHNwaSBk
cml2ZXIgdG8gZHJpdmVycy9zcGkvDQo+ID4gPiA+DQo+ID4gPiA+IFRoYXQncyBzdHJhbmdlLg0K
PiA+ID4gPg0KPiA+ID4gPj4gRG9lcyB0aGlzIGNoYW5nZSByZXF1aXJlcyBkZXZpY2UgdHJlZSBt
b2RpZmljYXRpb24/DQo+ID4gPiA+PiBBbnkgc3VnZ2VzdGlvbnMgb3IgY29tbWVudHMgd291bGQg
YmUgYXBwcmVjaWF0ZWQuDQo+ID4gPiA+DQo+ID4gPiA+IC4uLmJlY2F1c2UgdGhhdCBwYXJ0aWN1
bGFyIGNoYW5nZSBkb2VzIG5vdCBjaGFuZ2UgYW55IEMgY29kZS4gQnV0DQo+ID4gPiA+IGl0IHRv
dWNoZXMgS2NvbmZpZyBiaXRzOyBjYW4geW91IGNoZWNrIHRoYXQNCj4gPiA+ID4gQ09ORklHX1NQ
SV9DQURFTkNFX1FVQURTUEkgaXMgZW5hYmxlZCBpbiB0aGUgImJhZCIgY29uZmlndXJhdGlvbj8N
Cj4gPiA+ID4NCj4gPiA+ID4gRG8geW91IGhhdmUgYW55IGxvY2FsIGNoYW5nZXMgaW4NCj4gPiA+
ID4gZHJpdmVycy9tdGQvc3BpLW5vci9jb250cm9sbGVycy9jYWRlbmNlLXF1YWRzcGkuYyBvcg0K
PiA+ID4gPiBkcml2ZXJzL3NwaS9zcGktY2FkZW5jZS1xdWFkc3BpLmMgPw0KPiA+ID4gPg0KPiA+
ID4gPiBCZXN0IHJlZ2FyZHMsDQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBQYXZlbA0KPiA+ID4gPiAtLQ0KPiA+ID4gPiBERU5YIFNvZnR3YXJlIEVuZ2luZWVyaW5nIEdt
YkgsICAgICAgTWFuYWdpbmcgRGlyZWN0b3I6IFdvbGZnYW5nIERlbmsNCj4gPiA+ID4gSFJCIDE2
NTIzNSBNdW5pY2gsIE9mZmljZTogS2lyY2hlbnN0ci41LCBELTgyMTk0IEdyb2ViZW56ZWxsLA0K
PiA+ID4gPiBHZXJtYW55DQo+ID4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+DQo=

--7XtVDy22fwjqFXt9MZKl
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6283): https://lists.cip-project.org/g/cip-dev/message=
/6283
Mute This Topic: https://lists.cip-project.org/mt/81272003/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--7XtVDy22fwjqFXt9MZKl--
