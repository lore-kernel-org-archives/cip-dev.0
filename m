Return-Path: <SRS0=YYZ+=IR=lists.cip-project.org=bounce+64572+6301+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB32C433E0
	for <cip-dev@archiver.kernel.org>; Fri, 19 Mar 2021 08:47:42 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD0C564F40
	for <cip-dev@archiver.kernel.org>; Fri, 19 Mar 2021 08:47:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD0C564F40
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6301+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id VF7uYY4521723xTmw1jh3c03; Fri, 19 Mar 2021 01:47:40 -0700
X-Received: from ss11.sbt-mailgate.jp (ss11.sbt-mailgate.jp [202.241.206.52])
 by mx.groups.io with SMTP id smtpd.web11.3584.1616143657322317560
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Mar 2021 01:47:39 -0700
X-Received: from mail.sbt-mailgate.jp (sagproxy-out11.sbt-mailgate.jp [10.16.47.41]) (envelope sender: <masashi.kudo@cybertrust.co.jp>)
	(not using TLS) by ss11.sbt-mailgate.jp (Active!gate) with ESMTP id TRpa22690A;
	Fri, 19 Mar 2021 17:41:28 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FwCv+TGePzsFHD66TdEqiW+M0ESul+g1HBLJnqBnzp5dAyVEv+2SHIsv3fkOPUaSabS9qHynXb6Dn2jamy1dw9/b0pUaeY0SJV0T7j+EVHaBAx/cCrRxILMV66R1ZMiazRvtZbjBSM9jumKkkjqTbXh+3PfLHIZRTGsaTVyS5Se8EQayOrKoiOWWaZqd/ubfchbSFRcRiAIxA4kKX2iACq7obcvw7Oe0jn9fWAKwq0e+529sE+XhXizy1k77R0ucZY9KcLzveT7v1fCwhNspa5n2KSGagiFNxnKkhL3gmwEWOPdLQssZCE/3rRah/ZZfrEQFJ7qLsrAscAhAw+6Ukw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Zta/h0n2MCsTpR28HCM0Ur90xtSRkw9PmxQNS+CrGs=;
 b=cwo8tPbz4m8+hluY4nO139JVDpt6hQb7kUcVl1Md5IYPXOqC2sQtcgPlnKYsl+4Px10YzgRPlElxW810YhqxLC65JvGzlTubHz+XTT5IR6vXNMORrISgAWTK2iHXtdmHx8KhkZLcvI9mqAKQOamtEYuArfOXKya7I6VvjhDJNPDW7DRiNYDZTj847rt98tXPDpVoDau9fprOwBvTV7ou5rPm2qEHFozfZMLiu5vCb2nKbvg0mEdYCLQudtNaRKpUD2Ajjd1V5nxRXwIgR8P3Shgb7wFZwMpOi40OgV17k1lzAXbrrmXpKaWlK7OOyDwZrS0egyySbbn3YeYrxD/fag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TYAPR01MB3824.jpnprd01.prod.outlook.com (2603:1096:404:c0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Fri, 19 Mar
 2021 08:41:24 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::fc16:7286:28cc:8325]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::fc16:7286:28cc:8325%7]) with mapi id 15.20.3955.018; Fri, 19 Mar 2021
 08:41:24 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <jan.kiszka@siemens.com>, <minmin@plathome.co.jp>,
	<cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <nobuhiro1.iwamatsu@toshiba.co.jp>, <wens@csie.org>
Subject: Re: [cip-dev] [Feedback Requested] RE: Cip-kernel-sec Updates for Week of 2021-03-18
Thread-Topic: [Feedback Requested] RE: Cip-kernel-sec Updates for Week of
 2021-03-18
Thread-Index: Adcb155JKC5WxfCIQN+IRDjOQ0ZrGgAvwuCAAAEsNoA=
Date: Fri, 19 Mar 2021 17:47:31 +0900
Message-ID: 
 <TY2PR01MB4972F52002A1794994A0EEF6A0689@TY2PR01MB4972.jpnprd01.prod.outlook.com>
References: 
 <TY2PR01MB4972E1E07AE85D162237E83CA0699@TY2PR01MB4972.jpnprd01.prod.outlook.com>
 <d111661c-cdda-3031-66e3-054a5cdcc943@siemens.com>
In-Reply-To: <d111661c-cdda-3031-66e3-054a5cdcc943@siemens.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8b4a05e4-2fa9-44e0-471c-08d8eab2c791
x-ms-traffictypediagnostic: TYAPR01MB3824:
x-microsoft-antispam-prvs: 
 <TYAPR01MB3824EB6BCF9288D58AD5B44BA0689@TYAPR01MB3824.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 h0ICFXgszlS0Qz6mZGwAEeq+SmNS/JIuyLugBquFBKG4nYY7lU4YPRnat2zUQLzO0ByZexDftEUIyBeIOv01vjghbDKJuXr66p+hQgfAe1D18a8HgFtD1YTaCZrWs1F5i6ibbvR5uVHJ93AsXc6VVt8W8JqWkRVSJ4EqLocpE2FFF5OLSwSchNS1Uh4VhEY1R6z3cuREdAg3MSDgy+y/WHpsblA9yFHIYvdeIS5PaDWzZhAs/MdgMLJ00/ZPwG7EjR816kzPYz2Ufx4Gz+io9SElcF6h5Vvo7aC+835tMT4l2GoVfRgJgGnlUsTybLmxIAEykhwzoebslxaTKVloKMxgAKsXIVzEkyZy4HsNnQ5uJazZ6p5qqMoopMJAutL5VccUUzFmY3kfvm1a5Q0+q5qsG3Ojrfshq2LNYXQh0zWI23rbUA6BStQNeBlNRO9er30O8OLQcHpFHY7HPT6stTS0YLUrl7VO3tW1wRw5K0B6hyIL0Kdg/4PqKcTIFxsoEPMBLFMlKS396M08ruk8meTmVmQIuexBcDPXnwtDyWWSUfR+Gc49iD/pukpVxdgWG9IRbYGjCTBk4GBq/nqWHoklyMNTPCp0IFzlJjU1I8ssGW3P+bRg7iucRCjZ1GYk6I9zZnU6c7cCOtcQw6JxvSqunSZTVrQKaI6XCAPWKXuKxOKkYo64mgGN7Rn4a4F4Uyg0KBcHs8J1lXeqEpCa91Mm8pGLwanERnnZ5+pkBuITZNbzAj1umFhVN7eB8tGX
x-ms-exchange-antispam-messagedata: 
 =?utf-8?B?a0dOQkk3dGwxQThUanNPS2d2MFliQVlvL0s1SnJ1aFBDSWZlY3pub2J6OTIx?=
 =?utf-8?B?b2xkV1c3Nm1ORHdCcnJoTjQwY3RRamdMRFJCVXJ0N0pncjVER1FBajNqdDMz?=
 =?utf-8?B?bmV6QTJPdExXeHJZRHBneFJNcWVtNUdiVFBFeG5wd0g2cWxsUTZpSGJhN0hN?=
 =?utf-8?B?QU80QVh4OW5wZDNxOFovL2FNbEU0Q1dBeXJZL0JmemFubUtjUHpFdzlpRUV5?=
 =?utf-8?B?em93OEdwWWNZekJSVUlPalRDK0RXTFFBeDFIVjJxZlVhVzNLVEwzeWErN1VN?=
 =?utf-8?B?UkdrV1ZNUlIxMVFHamVsUkhDK1Q4L1VRVjN0eEk1TFBqMDk4T2xHb0NJaWZv?=
 =?utf-8?B?bUROV1gvT2Jac291YStHQitBcGhjdTV5K01iRHB2SFI0cStkWWVpWFlDTXFT?=
 =?utf-8?B?dlZpV3ZPS2tvM2YrSlpZU0pEZkVONmdBU1RaT0NubTZMNHJtS0RGb3pBYTUx?=
 =?utf-8?B?VE5DK0hMaE1uQ2tHdFBhekpyWGxPMEg1cHpLLzNDU2RvSjRRdEx1c2ROZjFv?=
 =?utf-8?B?enpZWW02Wi9DY0tTYXdYR1pYMlpvaHFLRFZLc0k0MmIxR0VEbFNzMTJ3RXhu?=
 =?utf-8?B?T0FpeWZYS1lhc2FPVDZHN0xJNDI3akxTc3hPS0x0Mk0xdGZQRXZ5NDlCcmF4?=
 =?utf-8?B?SXVFWkR3ZisxSGlJbnR5LzZjZ2d1bGJuczlxK0VSZDF4b0NSQWVidEVJTVN1?=
 =?utf-8?B?M1NsVFZQSXBpa0VDbkpaQkhjL3RoL1ltcy9nQmtZOU02UHM1QzdiUDRpTEJX?=
 =?utf-8?B?Q01sUHpGREY1QVpzUGVIM1VqYjgrcnZCeDg5aU1qeEtMb2dXc01HY2V5Yi93?=
 =?utf-8?B?Tm5CSWpxMDBKZnRmTkh1VlJrN0Vlc3A3b2k3eGxHRzVjYXcwUEtTZFVhak1y?=
 =?utf-8?B?MXlkRnZaY0MrNFpYa1RySW9xMnA0OENwUTRiZGNkU1YyQk1EQ1k1RjgzZTUx?=
 =?utf-8?B?Vk50ZHE3OVdiRlZzTDh5dGIzcWlhUXdJMjVteEdDd2RBTjJxZHBrRktDdlgx?=
 =?utf-8?B?OE03ZjE2RkpNV21Na0lNRWN1Z1FocDlvZkM0UExva0RJaFIyaWgrNUNsdmxH?=
 =?utf-8?B?a25WY0lsU3pOYWNHSS8reDZOVTByZmR4YnRtTStGZGVNbVp6RmVHNlhQUmVk?=
 =?utf-8?B?QnNPVEhid01HWFB6bjRLdUxuOGJVNlVSbUFrVkVhOVNrNDVnMEZ1SUFDcWZl?=
 =?utf-8?B?bmp3cVF2dmEzcy91cTZMalVyam5GU013ZDhJb3RJT1d6eTBVRXphMjRHNWo5?=
 =?utf-8?B?dVFnMUl6Qkg4dzZYdUZMZnB6cHRqd0x0SHNIRExqc0NUQ0dEeXJwRHk3Tm1I?=
 =?utf-8?B?VHY5K2U2aFFMTEM1bWxJR2xzSmZyL3U2SHFOT2o0WnFkTU9IS1VXd0RuVmhU?=
 =?utf-8?B?cCtZT1VLaXdNNE8wbjNvcFU3czhvcGtneGlYQWJtUDJLa0JmVUpCMW12TlJP?=
 =?utf-8?B?a2RwVlVjSmJwSVdlcE1CeFU3S1pFSUtjZ01IamhrM2dmSUVIUE0yaUtTZWNt?=
 =?utf-8?B?NndkQSs2YkdZR1JSOWt5OEhlLzR1NUFZdHZGY3dlZjVPMFRFajdHcnN2SlBC?=
 =?utf-8?B?R1hsMEwyZXFTdUpab1FnRFpubDZ1RVVWMHdIYlZIVXJ1WXY1MitZYTkxWlJq?=
 =?utf-8?B?Ym8rOUxiWENYMHFiZU9mNFR4N0ltbHZWTVE3c21WcFBQbGN0OVFTZkVrRklk?=
 =?utf-8?B?Z1FxbDZRTk9tdVZ1cEFmQ0d6aDVrZFMrV0paUm1hUDk4TmZVQ093T0lSZFcz?=
 =?utf-8?Q?WFq+tRyKNUYnNwsz4R9xWIOVDR679UjkEiz6kMN?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b4a05e4-2fa9-44e0-471c-08d8eab2c791
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2021 08:41:24.5650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hPIPi14ulGruK1xuKkr4valuY/sLITEj+r6472HUr6XoqPKwBBLIwUVrJFF5Cm0cafwGi1h5MrIV5zPei4hxOwQdROMnsIctKsc1ofRD1Jg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3824
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: v9AjUi43mzqPSTWlzJBlHugHx4520388AA=
Content-Type: multipart/mixed; boundary="gMe4basUYneDlB5CIGpJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1616143660;
 bh=XmsliJ2fueCDLu/5EyFXyyTqoXNHk8WmLM065nUp300=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=W0/1Uyjol4HZAWCVAf0xlFxJdaCENDHKlfvDLXI4cXqwg/2UWSAvHqVh69Y7C38z06/
 1ALYx7tZUf2HQcInbZKYfBfYbr/4iyD7fi1NLVCyBGkYbf74uZbSsKJNQ2T/CvNiuMdB+
 2GJcAJaPQHfOvPFe2bVr2XK8QW+lKk2xiWQ=

--gMe4basUYneDlB5CIGpJ
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksIEphbi1zYW4sDQoNClRoYW5rcyBmb3IgeW91ciBjb25maXJtYXRpb24hDQoNCkl3YW1hdHN1
LXNhbiwNCg0KQ291bGQgeW91IHR1cm4gb2ZmIGJvdGggZmVhdHVyZXMgZnJvbSB0aGUgZm9sbG93
aW5nIGNvbmZpZ3M/DQoNCj4gPiAtIENWRS0yMDIwLTM1NTE5IGlzIHJlbGF0aW5nIHRvIFguMjUu
DQo+ID4+ICAgICA0LjE5LnktY2lwLXJ0L3g4Ni9zaWVtZW5zX2kzODYtcnQuY29uZmlnOkNPTkZJ
R19YMjU9bQ0KPiA+PiAgICAgNS4xMC55LWNpcC1ydC94ODYvc2llbWVuc19pMzg2LXJ0X2RlZmNv
bmZpZzpDT05GSUdfWDI1PW0NCj4gPiAtIENWRS0yMDIxLTIwMjYxIGlzIHJlbGF0aW5nIHRvIGZs
b3BweS4NCj4gPj4gICAgIDQuNC55LWNpcC1ydC94ODYvc2llbWVuc19pMzg2LXJ0LmNvbmZpZzpD
T05GSUdfQkxLX0RFVl9GRD1tDQoNCkJlc3QgcmVnYXJkcywNCi0tDQpNLiBLdWRvDQoNCj4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFuIEtpc3prYSA8amFuLmtpc3prYUBz
aWVtZW5zLmNvbT4NCj4gU2VudDogRnJpZGF5LCBNYXJjaCAxOSwgMjAyMSA1OjA2IFBNDQo+IFRv
OiDlt6Xol6TjgIDpm4Xlj7jvvIhDVErjgIBPU1Pkuovmpa3mjqjpgLLlrqTvvIkgPG1hc2FzaGku
a3Vkb0BjeWJlcnRydXN0LmNvLmpwPjsNCj4gbWlubWluQHBsYXRob21lLmNvLmpwOyBjaXAtZGV2
QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiBDYzogcGF2ZWxAZGVueC5kZTsgbm9idWhpcm8xLml3
YW1hdHN1QHRvc2hpYmEuY28uanA7IHdlbnNAY3NpZS5vcmcNCj4gU3ViamVjdDogUmU6IFtGZWVk
YmFjayBSZXF1ZXN0ZWRdIFJFOiBDaXAta2VybmVsLXNlYyBVcGRhdGVzIGZvciBXZWVrIG9mDQo+
IDIwMjEtMDMtMTgNCj4gDQo+IE9uIDE4LjAzLjIxIDEwOjMzLCBtYXNhc2hpLmt1ZG9AY3liZXJ0
cnVzdC5jby5qcCB3cm90ZToNCj4gPiBIaSwgSmFuLXNhbiwgTWluZGEtc2FuLA0KPiA+DQo+ID4g
UGxlYXNlIGZpbmQgdGhlIENWRSByZXBvcnQgYXMgZm9sbG93cy4NCj4gPiBJbiB0aGUgYW5hbHlz
aXMgb2YgdGhvc2UgQ1ZFcywgd2UgZm91bmQgc29tZSBkb3VidHMgYWJvdXQgdGhlIGNvbmZpZ3Mu
DQo+ID4NCj4gPiAtIENWRS0yMDIwLTM1NTE5IGlzIHJlbGF0aW5nIHRvIFguMjUuDQo+ID4gWC4y
NSBpcyBlbmFibGVkIGFzIGZvbGxvd3MsIGJ1dCB3ZSB3b25kZXIgd2hldGhlciBYLjI1IGlzIHJl
YWxseSB1c2VkIG9yIG5vdC4NCj4gPj4gICAgIDQuNC55LWNpcC94ODYvcGxhdGhvbWVfb2Jzdngx
LmNvbmZpZzpDT05GSUdfWDI1PW0NCj4gPj4gICAgIDQuMTkueS1jaXAtcnQveDg2L3NpZW1lbnNf
aTM4Ni1ydC5jb25maWc6Q09ORklHX1gyNT1tDQo+ID4+ICAgICA1LjEwLnktY2lwLXJ0L3g4Ni9z
aWVtZW5zX2kzODYtcnRfZGVmY29uZmlnOkNPTkZJR19YMjU9bQ0KPiA+DQo+ID4gUGxlYXNlIGNv
bmZpcm0sIGFuZCBsZXQgdXMga25vdyB3aGV0aGVyIFguMjUgc2hvdWxkIGJlIGRpc2FibGVkLg0K
PiA+DQo+ID4gLSBDVkUtMjAyMS0yMDI2MSBpcyByZWxhdGluZyB0byBmbG9wcHkuDQo+ID4gSXQg
aXMgZW5hYmxlZCBhcyBmb2xsb3dzLg0KPiA+PiAgICAgNC40LnktY2lwLXJ0L3g4Ni9zaWVtZW5z
X2kzODYtcnQuY29uZmlnOkNPTkZJR19CTEtfREVWX0ZEPW0NCj4gPg0KPiA+IFBsZWFzZSBjb25m
aXJtIHRoYXQgdGhpcyBjYW4gYmUgYWxzbyBkaXNhYmxlZC4NCj4gPg0KPiANCj4gWWVzLCBib3Ro
IGZlYXR1cmVzIGNhbiBiZSB0dXJuZWQgb2ZmLg0KPiANCj4gVGhhbmtzLA0KPiBKYW4NCj4gDQo+
ID4gQmVzdCByZWdhcmRzLA0KPiA+IC0tDQo+ID4gTS4gS3Vkbw0KPiA+DQo+ID4+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IENoZW4tWXUgVHNhaSA8d2Vuc0Bjc2llLm9y
Zz4NCj4gPj4gU2VudDogVGh1cnNkYXksIE1hcmNoIDE4LCAyMDIxIDU6NDggUE0NCj4gPj4gVG86
IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnDQo+ID4+IENjOiBQYXZlbCBNYWNoZWsgPHBh
dmVsQGRlbnguZGU+OyBOb2J1aGlybyBJd2FtYXRzdQ0KPiA+PiA8bm9idWhpcm8xLml3YW1hdHN1
QHRvc2hpYmEuY28uanA+OyDlt6Xol6TjgIDpm4Xlj7jvvIhDVErjgIBPU1Pkuovmpa3mjqjpgLLl
rqTvvIkNCj4gPj4gPG1hc2FzaGkua3Vkb0BjeWJlcnRydXN0LmNvLmpwPg0KPiA+PiBTdWJqZWN0
OiBDaXAta2VybmVsLXNlYyBVcGRhdGVzIGZvciBXZWVrIG9mIDIwMjEtMDMtMTgNCj4gPj4NCj4g
Pj4gSGkgZXZlcnlvbmUsDQo+ID4+DQo+ID4+IFNpeCBuZXcgaXNzdWVzIHRoaXMgd2VlayBmcm9t
IHRoZSBVYnVudHUgdHJhY2tlcjoNCj4gPj4NCj4gPj4gLSBDVkUtMjAyMC0zNTUxOSBbbmV0L3gy
NTogYnVmZmVyIG92ZXJmbG93XSAtIGZpeGVkDQo+ID4+ICAgTG9va3MgbGlrZSBhIGZldyBjb25m
aWdzIHN0aWxsIGhhdmUgWC4yNSBlbmFibGVkOg0KPiA+PiAgICAgNC40LnktY2lwL3g4Ni9wbGF0
aG9tZV9vYnN2eDEuY29uZmlnOkNPTkZJR19YMjU9bQ0KPiA+PiAgICAgNC4xOS55LWNpcC1ydC94
ODYvc2llbWVuc19pMzg2LXJ0LmNvbmZpZzpDT05GSUdfWDI1PW0NCj4gPj4gICAgIDUuMTAueS1j
aXAtcnQveDg2L3NpZW1lbnNfaTM4Ni1ydF9kZWZjb25maWc6Q09ORklHX1gyNT1tDQo+ID4+ICAg
TWF5YmUgdGhleSBzaG91bGQgYmUgcmV2aXNpdGVkPyBjaXAta2VybmVsLWNvbmZpZyBhbHNvIGdp
dmVzIHdhcm5pbmdzDQo+ID4+ICAgZm9yIENPTkZJR19YMjUuDQo+ID4+DQo+ID4+IC0gQ1ZFLTIw
MjEtMjAyMTkgW2ltcHJvcGVyIHN5bmNocm9uaXphdGlvbiBpbiBmbHVzaF90b19sZGlzYygpXSAt
DQo+ID4+IGxpa2VseSBSZWRIYXQgb25seQ0KPiA+PiAgIFJlcG9ydCBtZW50aW9ucyBpbmNvcnJl
Y3QgYmFja3BvcnQgaW4gUmVkSGF0IGtlcm5lbHMuDQo+ID4+DQo+ID4+IC0gQ1ZFLTIwMjEtMjAy
NjEgW2Zsb3BweTogcmFjZSBjb25kaXRpb24gZGF0YSBjb3JydXB0aW9uXSAtIGZpeGVkDQo+ID4+
ICAgTm8gbWVtYmVyIGVuYWJsZXMgdGhpcyBleGNlcHQ6DQo+ID4+ICAgICA0LjQueS1jaXAtcnQv
eDg2L3NpZW1lbnNfaTM4Ni1ydC5jb25maWc6Q09ORklHX0JMS19ERVZfRkQ9bQ0KPiA+PiAgIHdo
aWNoIHNob3VsZCBwcm9iYWJseSBiZSB0dXJuZWQgb2ZmLg0KPiA+Pg0KPiA+PiAtIENWRS0yMDIx
LTI4Mzc1IFtmYXN0cnBjOiBhbGxvd3Mgc2VuZGluZyBrZXJuZWwgUlBDc10gLSBmaXhlZA0KPiA+
PiAgIE5vIG1lbWJlciBlbmFibGVzIHRoaXMuDQo+ID4+DQo+ID4+IC0gQ1ZFLTIwMjEtMjg2NjAg
W3J0bDgxODhldTogYXJyYXkgYWNjZXNzIG91dC1vZi1ib3VuZHNdIC0gZml4ZWQNCj4gPj4gICBO
byBtZW1iZXIgZW5hYmxlcyB0aGlzLg0KPiA+Pg0KPiA+PiAtIENWRS0yMDIxLTM0MjggW2ludGVn
ZXIgb3ZlcmZsb3cgaW4gZXh0NF9lc19jYWNoZV9leHRlbnRdIC0gdW5jbGVhciBbMV0NCj4gPj4g
ICBSZXF1aXJlcyBhIHNwZWNpYWxseS1jcmFmdGVkIGV4dDQgRlMgaW1hZ2UsIHNvIHdlIGxpa2Vs
eSBkb24ndCBjYXJlLg0KPiA+Pg0KPiA+PiBVbmZvcnR1bmF0ZWx5IERlYmlhbidzIFNhbHNhIHNl
cnZpY2UsIHdoZXJlIHRoZSBEZWJpYW4ga2VybmVsDQo+ID4+IHNlY3VyaXR5IGlzc3VlIHRyYWNr
ZXIgaXMgaG9zdGVkLCBpcyBjdXJyZW50bHkgZG93biwgc28gd2Ugb25seSBoYXZlIG9uZSBzb3Vy
Y2UNCj4gb2YgZGF0YSB0aGlzIHdlZWsuDQo+ID4+DQo+ID4+DQo+ID4+IFJlZ2FyZHMNCj4gPj4g
Q2hlbll1DQo+ID4+DQo+ID4+DQo+ID4+IFsxXQ0KPiA+PiBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9zdGFibGUvMjAyMTAzMTcxNTE4MzQuR0UyNTQxQHF1YWNrMi5zdXNlLmN6Lw0KPiANCj4gDQo+
IC0tDQo+IFNpZW1lbnMgQUcsIFQgUkRBIElPVA0KPiBDb3Jwb3JhdGUgQ29tcGV0ZW5jZSBDZW50
ZXIgRW1iZWRkZWQgTGludXgNCg==

--gMe4basUYneDlB5CIGpJ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6301): https://lists.cip-project.org/g/cip-dev/message=
/6301
Mute This Topic: https://lists.cip-project.org/mt/81425316/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--gMe4basUYneDlB5CIGpJ--
