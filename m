Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7309C4167B
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 07:27:14 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.78283.1701934023936864717
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Dec 2023 23:27:04 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 3B77R0rY3500110; Thu, 7 Dec 2023 16:27:01 +0900
X-Iguazu-Qid: 2rWhQFUwau7OkDbVjx
X-Iguazu-QSIG: v=2; s=0; t=1701934020; q=2rWhQFUwau7OkDbVjx; m=ay4fBzbqvXOEGvFLSeoeuX2uZTWaACZ/1mRbQV6rytA=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1122) id 3B77Qx6p2252714
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 7 Dec 2023 16:27:00 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CzIu/CFqdbEBCZdwFkn3XejuxajXGxo0B/6ONyCG0tvvtkg2aQktgUB0m/OwzSaYaFK3W5UxuDYsUHSVRHdlsNYJReB1gjvFRe9apOdiMo0BWQfcmDLQAbglubBKEWA6uo1Vssy0Cm+7KZq0mt0jO8kXmhgOtVe9oYw/xKXibfvmzPjIug/6E1AL4EL42bqUpVzlNDoXJUfIX7j+2Gg1m+ebBUeLwxuWnFIZu8If47WAYrcJdTxo2wKCRFOpypXwHrDrGx7DqRHkf2RuHs+ne++LXvUSFBtEYLqRL7RHOTY5SpVIQZNOsXb9VIr2MlZdvy4qaZv+/KqpSAZy4BV/YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IDeOfv7ZBhv9lVMtf9Y9vw+MiMviqKq2lCRZ4Ojn8oc=;
 b=jQul7r7QN23k4zMZTeyQqxdQcAZOfvafNmDqs43ynO2RQ5BjTe8/ED5zojy9tK7Zy+gvW//OseVSl3KgnwmCmz2Vk/RvHVsED2bWzL1SVzoxhfrhV7JKpBlHdJyIS8Khg4DVTM3SJnU7+8NJ1HVZCatXvnWgqrDODPCpfutE2L0X3SOjk0hqCGk7LPa1yBYPRSfAXmDInLBOlZbaRVM6jx1bO+1NDtn2dVDJ7uDZbBL0fd48/z9JjabtCWrRanLsTdCtyoVPbqU91nbaSzU+Fg+Tfr1wlVB4vUUumTkGsB/q7w20Xo0GSP2av0tSJp95XWyt/fOL+9dI1VmoKvqDxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Topic: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Index: AQHaKMClJOEPpvCtn06N8FwB5TNXubCda4Ag
Date: Thu, 7 Dec 2023 07:26:56 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYVPR01MB1124553711DEB70B23EDEF814928BA@TYVPR01MB11245.jpnprd01.prod.outlook.com>
References: <2df11e62-6cb3-413e-b72d-3a2f6b3332ec@siemens.com>
In-Reply-To: <2df11e62-6cb3-413e-b72d-3a2f6b3332ec@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYVPR01MB11245:EE_|TYVPR01MB11312:EE_
x-ms-office365-filtering-correlation-id: eee0f673-30fd-4196-d4a8-08dbf6f5e4dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Z/PeHuN3tJzAVE+mYLDXd6c7RznLSEwYVCagToxAFxskxLeG6EatFO16sxYEMZuvy5Xms6Ncyoq2jC4hFD6cZKmqq7xEi+qs0QOIusDC2l9lSbuxAE3cA2YBSGCIXtyv703lFQkevB7CVQJI3cvxwaKzr6qXHHwhK6Geatwm627HfwihXSoY3cE9zV8UNTzaD5VuhxaBB8yc29w/asLcxRl22LA7FpY+SqrrnEBrS+foZkVM8cHWth7inmaDZHd4LAc4L8+2AJO57yTCIDEOnl1OhIhDPgOZKxQ/5L8r84iN3rTBy5e4ltioe/f1FaCYN7ohL8W00MV1fEeZLwVGuRfvsbH45WNniViVsM6Dv2OfUrm1s7JBOREc00MNT9ctxwTFwQvDBLFZznnzV4DzkFjCzH6lpktG+5rHzIN4Cd2f9o8SedSlR4q5LDct1ZTCM6SggkSt+xCGMsog7z41bysxI2nVRBoMma2H7dEdGyBrwpRvKjEId5MPiBQfK7JjEXfSICsq5HUdTwB4blFFBJmcEtFi+5B8niY+KnvRL1DaweInmDdM7CUALUNI5xJbo/7u5PwNmCswPa7aDXB148FU+XYzTlb7vF6SLNMvFig=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYVPR01MB11245.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(136003)(366004)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(6916009)(66946007)(66446008)(66556008)(64756008)(66476007)(8936002)(33656002)(316002)(76116006)(478600001)(966005)(71200400001)(41300700001)(5660300002)(2906002)(38070700009)(38100700002)(4001150100001)(52536014)(86362001)(122000001)(83380400001)(55016003)(8676002)(7696005)(9686003)(53546011)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?QjdxSGMrQ3UyaUg0Q1MvL21aMUk0THlrcHNnSFhhNGJhSDd4Sm5VWDVKOEZ3?=
 =?utf-8?B?OEg2RDlBaHB6MkE0U3NRSkZzS09RZVpOcTFHTjFVVjU1MVdYb2p4RnlPbGRx?=
 =?utf-8?B?R1JSb05vaklVM1FhbVBwaVZlOWEzb3lnN3hxSnQ1U2lmSnAxMWtlVVV4elVO?=
 =?utf-8?B?M3o4MVFMZ3l0WTBJdDBSUlFRbFgxWllkTnVFbVRnSUZIbjVvWE5SSE1jUk9B?=
 =?utf-8?B?NXFreW5ZV2FKVlVwSFRCNHcwdlU3Um4rZnRudURoQ2ZLUjVGcko5MUN5NkZI?=
 =?utf-8?B?SWt6UjBUbXhES2hCL3c3c0ZUY3kyZmtsMmxGUG1WOUJXMjA4NkduS0FFb3c5?=
 =?utf-8?B?b1JXSXZrNUVpcFpqVnhUd09wWFJuR1hKTEFYTkdpQlZMeGJybTJFODFERmpX?=
 =?utf-8?B?aXY1WjFhZmdGQXZiem9qb1ZpYWZqd0pmUkYySHdPUEtJSEFwZWpZU0lBUk1x?=
 =?utf-8?B?c0hjNUJMOURYNHBWQ0U1ZFlvVXRidzRVdUVsVVRIbFkvRmM4MC9WeVJkb0ow?=
 =?utf-8?B?YTBIYkoyY1VSdXoyQ1hqM2NXNnBvSXlJOEozN0lUaFRraU5SdGNNOVdGdGNF?=
 =?utf-8?B?ZGlCbWlWR09UMXNwQ1Z2eWx6U3U3S3AxUFRoc2RtU0VmQkk5TjUzWGV1djBN?=
 =?utf-8?B?b0hTaFdVNEJQczRiR3YzVUNVSkF2ZkhRZG9yQXQ0ZmpLNDJod1dXeXpnODJ1?=
 =?utf-8?B?dE5INC82RlZPS0o4bUhyVUVUbHhLblNHVk9iYTQxZ3NVREU4TWh3ZUlJQ3Z6?=
 =?utf-8?B?c3B5dFAvV1IxTDdTSkx4Qk50M1hId2dHeEpUS3hrZXFKVUdhaDhubkdLSi9E?=
 =?utf-8?B?VlJ0MUdTeG82N25kWVpLN09kUXVWSXp6Z3orMUFoeHhXTmh2ZzA3ZmRsN1BF?=
 =?utf-8?B?bmxWeG1RMzJrSmt1N3Z2eG8wazFTTkd5clVrWHFTTk5UMGIrM2R3dktJdFhG?=
 =?utf-8?B?L2FxMThuNTl3T0lxK2VBZzE0YUxUM0VtODBuQmYreGsvQnArYlNDUVFJUmxl?=
 =?utf-8?B?eGNsSXk0ekd0NXNXOGdjKzhCWWpVa1JDVlQ0MS9lQzc4RWRoemNvNDlMNWVJ?=
 =?utf-8?B?MWt2UWJKNy93aS9WTU1VeU5EdzNpSytLSUtXOThTWnV5eHVZRGEzcHFOS21I?=
 =?utf-8?B?eDYyNnR0RzBYdDdwVGZ6M2RhdUQ2cXVndTVUSk5DSE1ZaGR6MGduUWJxdERL?=
 =?utf-8?B?RFkzTTNabWh5aVduY2pBNFN4RStocVNmWGpES3VmK2twMW0xbk9wbE4vZCs1?=
 =?utf-8?B?TDkrMzRmV20zWUtHUzRJN1JLVm9POXRYSzRVSzFEbHJRZWJjV1h0NzlSanc3?=
 =?utf-8?B?Ri9rRUQza3U2QllnVUxKbUFra3lrejU1NzRZMWlDdzVaL3lDc0YvSTNmZFgz?=
 =?utf-8?B?aC9INE4zdTBQNUpwSFJkOFRhejNjUlpVdlBrbVZBNjVTRGs4OFVDYTdiUndY?=
 =?utf-8?B?WlFNK3ByRkJsVncvMSttMVBVcnd5LytlU05JaG5PSVRFRjVNM3Rhd2xNN1Ay?=
 =?utf-8?B?UHdwOUJwV2RuakJiMm1jQUEyUjFURi9vNFgvZ1U5KzZQMTR5WDNPWEk5T1Ni?=
 =?utf-8?B?QWt6aFpZU1lKSm5FS0pOeTFOeVBQcnRSdmlvQUZoUmZoKzFvbmdSUUMrUnFk?=
 =?utf-8?B?M0YrbkF0WGlDM1BsN3NOZVVocHZUN29IbHJmTG1aak9paldNR2xSRUEzM1ls?=
 =?utf-8?B?a1FuSFE4eTJSTEppOXlDZnhhbS9JeDIxemxkOTJNVzN3NTNZMmtUaVlHU253?=
 =?utf-8?B?NTdtYTJmNVJFUW81MXhFeG5IeW9FKzZBK09adUxoT0hRVXNqVWFZSTZFc2RR?=
 =?utf-8?B?SWJmT2hxQzNNQkY3UmNsZGZiUnpmM1k5WU9WY1dTQjY3UGh4RGpSeFlSR2RJ?=
 =?utf-8?B?YlhnQUdOS1BVYnlFMy9jVWFaS1F0WXU4MGNoSmp5WnRscDhEYjFiZnN3NkpX?=
 =?utf-8?B?alBWRXBzTVc0WHI1U0FWUy8vQWN3VUo1VG9XZkFua09NOVowdUNCQjB4ekh1?=
 =?utf-8?B?dVI1ZTZYSU80dFdNMVA5eTBqaFk1OWJlQTBkYnlTaERMcEM1cW5URW1DZFVl?=
 =?utf-8?B?NHJsLy9XWUlWOHJIZkNuM0twVWV2QngzODJhb0NrMUozd2kyd09Jc2tLc3p1?=
 =?utf-8?B?MmdWNCtjbyt4UXNyOE5tclJGZUdpL2tDY0Y2NEc1R200T3pJN0Q4Rmp6bTQ3?=
 =?utf-8?B?SUhScTZtWmhRVktCWi80dFF2QW8rcXFlNHlZSGxCRDRaNGdQcU5kaXRWd2ho?=
 =?utf-8?Q?gfbnTednvoS+bAaAYdoBHbLIdrzHcrVT62WBwbuSuQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYVPR01MB11245.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eee0f673-30fd-4196-d4a8-08dbf6f5e4dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2023 07:26:56.9669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C9VmVfIl4QID+FtoPHwKIjVrSyIyPolPzEEVHP8uJ0h1u8pbpFo5MRezJDXVQ/cHTQO8MszcfWygxnRd4EZhZid2yWoHgJcKV2cCcv4OEAxgJljwTd5OIM8qZBJ7cAnC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB11312
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 07:27:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13809

SGkgYWxsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGNpcC1kZXZA
bGlzdHMuY2lwLXByb2plY3Qub3JnIDxjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4gT24N
Cj4gQmVoYWxmIE9mIEphbiBLaXN6a2EgdmlhIGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiBTZW50
OiBUaHVyc2RheSwgRGVjZW1iZXIgNywgMjAyMyAxMjo1MSBQTQ0KPiBUbzogY2lwLWRldiA8Y2lw
LWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc+DQo+IFN1YmplY3Q6IFtjaXAtZGV2XSBDSVAgSVJD
IHdlZWtseSBtZWV0aW5nIHRvZGF5IG9uIGxpYmVyYS5jaGF0DQo+IA0KPiBIaSBhbGwsDQo+IA0K
PiBLaW5kbHkgYmUgcmVtaW5kZWQgdG8gYXR0ZW5kIHRoZSB3ZWVrbHkgbWVldGluZyB0aHJvdWdo
IElSQyB0byBkaXNjdXNzDQo+IHRlY2huaWNhbCB0b3BpY3Mgd2l0aCBDSVAga2VybmVsIHRvZGF5
LiBPdXIgY2hhbm5lbCBpcyB0aGUgZm9sbG93aW5nOg0KPiANCj4gICAgIGlyYzppcmMubGliZXJh
LmNoYXQ6NjY2Ny9jaXANCj4gDQo+IFRoZSBJUkMgbWVldGluZyBpcyBzY2hlZHVsZWQgdG8gVVRD
IChHTVQpIDEzOjAwOg0KPiANCj4gaHR0cHM6Ly93d3cudGltZWFuZGRhdGUuY29tL3dvcmxkY2xv
Y2svbWVldGluZ2RldGFpbHMuaHRtbD95ZWFyPTIwMjMmDQo+IG1vbnRoPTEyJmRheT03JmhvdXI9
MTMmbWluPTAmc2VjPTAmcDE9MjI0JnAyPTE3OSZwMz0xMzYmcDQNCj4gPTM3JnA1PTI0MSZwNj0y
NDgNCj4gDQo+IFVTV2VzdCAgICBVU0Vhc3QgICAgVUsgICAgICAgIERFICAgICAgICBUVyAgICAg
ICAgSlANCj4gMDU6MDAgICAgIDA4OjAwICAgICAxMzowMCAgICAgMTQ6MDAgICAgIDIxOjAwICAg
ICAyMjowMA0KPiANCj4gTGFzdCBtZWV0aW5nIG1pbnV0ZXM6DQo+IGh0dHBzOi8vaXJjYm90Lnds
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWVldGluZ3MvY2lwLzIwMjMvMTEvY2lwLjIwMjMtMTEtMzAt
DQo+IDEzLjA0LmxvZy5odG1sDQo+IA0KPiAqIEFjdGlvbiBpdGVtcw0KPiAqIEtlcm5lbCBtYWlu
dGVuYW5jZSB1cGRhdGVzDQo+ICogS2VybmVsIHJlbGVhc2Ugc3RhdHVzDQo+ICAgLSA0LjQNCj4g
ICAtIDQuMTkNCj4gICAtIDUuMTANCj4gICAtIDYuMQ0KDQpGWUk6DQpEYXRlICh0aGUgZGF0YSBp
cyBjcmVhdGVkKTogVGh1IDA3IERlYyAyMDIzIDA3OjIzOjM4IEFNIFVUQw0KbGludXgtNC40Lnkt
Y2lwOiBpbnRlcnZhbCAzMCBkYXkNCiAgbGF0ZXN0IHZlcnNpb24gcmVsZWFzZSBkYXRlOiBUaHUg
MDkgTm92IDIwMjMgMDQ6NTI6MTkgQU0gVVRDDQogIGxpbWl0IGRhdGU6IFNhdCAwOSBEZWMgMjAy
MyAwNDo1MjoxOSBBTSBVVEMNCiAgU3RhdHVzOiBPbiB0cmFjaw0KbGludXgtNC40LnktY2lwLXJ0
OiBpbnRlcnZhbCA2MCBkYXkNCiAgbGF0ZXN0IHZlcnNpb24gcmVsZWFzZSBkYXRlOiBUaHUgMTkg
T2N0IDIwMjMgMDM6MzA6MTggUE0gVVRDDQogIGxpbWl0IGRhdGU6IE1vbiAxOCBEZWMgMjAyMyAw
MzozMDoxOCBQTSBVVEMNCiAgU3RhdHVzOiBPbiB0cmFjaw0KbGludXgtNC4xOS55LWNpcDogaW50
ZXJ2YWwgMzAgZGF5DQogIGxhdGVzdCB2ZXJzaW9uIHJlbGVhc2UgZGF0ZTogTW9uIDA2IE5vdiAy
MDIzIDA0OjIxOjAyIEFNIFVUQw0KICBsaW1pdCBkYXRlOiBXZWQgMDYgRGVjIDIwMjMgMDQ6MjE6
MDIgQU0gVVRDDQogIFN0YXR1czogbGF0ZQ0KbGludXgtNC4xOS55LWNpcC1ydDogaW50ZXJ2YWwg
NjAgZGF5DQogIGxhdGVzdCB2ZXJzaW9uIHJlbGVhc2UgZGF0ZTogV2VkIDE4IE9jdCAyMDIzIDEw
OjAyOjI3IEFNIFVUQw0KICBsaW1pdCBkYXRlOiBTdW4gMTcgRGVjIDIwMjMgMTA6MDI6MjcgQU0g
VVRDDQogIFN0YXR1czogT24gdHJhY2sNCmxpbnV4LTUuMTAueS1jaXA6IGludGVydmFsIDMwIGRh
eQ0KICBsYXRlc3QgdmVyc2lvbiByZWxlYXNlIGRhdGU6IFRodSAyMyBOb3YgMjAyMyAxMTo1MTox
NCBBTSBVVEMNCiAgbGltaXQgZGF0ZTogU2F0IDIzIERlYyAyMDIzIDExOjUxOjE0IEFNIFVUQw0K
ICBTdGF0dXM6IE9uIHRyYWNrDQpsaW51eC01LjEwLnktY2lwLXJ0OiBpbnRlcnZhbCA2MCBkYXkN
CiAgbGF0ZXN0IHZlcnNpb24gcmVsZWFzZSBkYXRlOiBUaHUgMjMgTm92IDIwMjMgMDY6MTI6MzEg
UE0gVVRDDQogIGxpbWl0IGRhdGU6IE1vbiAyMiBKYW4gMjAyNCAwNjoxMjozMSBQTSBVVEMNCiAg
U3RhdHVzOiBPbiB0cmFjaw0KbGludXgtNi4xLnktY2lwOiBpbnRlcnZhbCAxNSBkYXkNCiAgbGF0
ZXN0IHZlcnNpb24gcmVsZWFzZSBkYXRlOiBUaHUgMzAgTm92IDIwMjMgMTI6NDI6NDIgUE0gVVRD
DQogIGxpbWl0IGRhdGU6IEZyaSAxNSBEZWMgMjAyMyAxMjo0Mjo0MiBQTSBVVEMNCiAgU3RhdHVz
OiBPbiB0cmFjaw0KbGludXgtNi4xLnktY2lwLXJ0OiBpbnRlcnZhbCAzMCBkYXkNCiAgbGF0ZXN0
IHZlcnNpb24gcmVsZWFzZSBkYXRlOiBTdW4gMDMgRGVjIDIwMjMgMDc6MjU6MTcgUE0gVVRDDQog
IGxpbWl0IGRhdGU6IFR1ZSAwMiBKYW4gMjAyNCAwNzoyNToxNyBQTSBVVEMNCiAgU3RhdHVzOiBP
biB0cmFjaw0KDQpCZXN0IHJlZ2FyZHMsDQogIE5vYnVoaXJvDQo=


