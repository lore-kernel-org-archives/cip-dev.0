Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4AEC25B6F
	for <webhook@archiver.kernel.org>; Thu, 26 Oct 2023 08:56:55 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.66153.1698310608231167315
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Oct 2023 01:56:49 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 39Q8ujWT2415468; Thu, 26 Oct 2023 17:56:45 +0900
X-Iguazu-Qid: 2rWgaNhqoSH9QYJIZu
X-Iguazu-QSIG: v=2; s=0; t=1698310604; q=2rWgaNhqoSH9QYJIZu; m=xVe7UHvNGesuUwNDOPQ4BJR6M6N3JfO6pZQh/VsQvA0=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1122) id 39Q8uhuU3618469
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 26 Oct 2023 17:56:44 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aBdTsvGPnKgJVPhdR2LZxHjOsO+vL6mXRMnyZoccAKmTsBNyA2hcKXv6Cs3s61fw8V5fkpuMWW4YTBhRmP5XLGOfHDS8v9c4AaI7vfra7YFpsBLMicK4Pu56vjgVJ5xLuKgI7YXW7HnIlCRCwz3B/+99TZArvnGeXe9b96PJtFwMN4gaUq6FQok+J8MVCUWD9R4NTipAxxWMfG2RbKN8GpWIkDbo2DCWafenzNOGGE2dRwstW6ZMvd7fkmJNsX7UE+urQiNl7rI/56vvhLuyqA9DmubNHuKxDFmueEgP9fS1x+aOc2ga16VvPsCLd3ZOJ95RznjOBsVOCPDMv1PcCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ho+KJYBzG/QTfjEYw2En5pDaA7eCLFa7544SsLLQhBE=;
 b=eWl5y+kIkygC4N0ik4ULkGivE0Js4FsH0eKdo4rVoNimyOeT+uEirVp2S6zgEbtarklfE8lFd7xKkgAG+tL0B3FcnjUclcRRRJRA3dovdUM+Cy7E3bD29jyEcPP+4Q9sTzFh3S6czijuLDWmwRrdjpZsR4HSwLkObCD2fP5ESuoPJfuOaPeo7auKRPkp/2EbtJodvjL/S9Y1bziLATJEIhJIPycJmnS/daaHxDBuyMBpxQka0BJhP7nP4UKdgZiWi//x/r+ziDriy1ppBswGZVGYsTMR3tJNuLeHw+uzbEME8iyZ2NGMLXfLev4bW1dqQ2KITl5ZVStSIWVtip8ZUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [isar-cip-core 2/2] README_version-release-policy.md: Add product
 description details
Thread-Topic: [isar-cip-core 2/2] README_version-release-policy.md: Add
 product description details
Thread-Index: AQHZ3K0R/NWd0/zpEkSBOxIQR7HOIbAFx9IAgCiIKCA=
Date: Thu, 26 Oct 2023 08:56:40 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OSAPR01MB49456019A81DE8EA4D79E820C2DDA@OSAPR01MB4945.jpnprd01.prod.outlook.com>
References: <20230901081943.1816811-1-Sai.Sathujoda@toshiba-tsip.com>
 <20230901081943.1816811-2-Sai.Sathujoda@toshiba-tsip.com>
 <03e48c84-2497-49fe-a61e-2e1fe6b95251@siemens.com>
In-Reply-To: <03e48c84-2497-49fe-a61e-2e1fe6b95251@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB4945:EE_|TY3PR01MB9996:EE_
x-ms-office365-filtering-correlation-id: cc9fa062-2f35-4977-db6b-08dbd601789a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 0jtqhXLSZE2urgM15QJEt6Wj/K9IuK1nBjOYVksK8Fzev5b/Yl7LFWfjXuHBIELVBrI8Eo2/46y315sLby1Y+K1EuRABkCPRwPmYGZNfuYxbnPqrpCSfn1kMym1HcpXnbBoFq/KQtoXuZlOeg87V6Pr5UjQ9YDUoOddTKrMUegasHn/GtLfh6v8P9f9gljoTBEuI9lvjSlK7mHMJOfvunZTVNv8Xu8fvokBe0CzecjW5UzyKKMIp+piHBQYwbe2KIjCnZ2/9S1FlD7x9DcCxqjwy31l7mvYwZJWyaejpMRYSkkkXVyDNgYjiEm+fdI/y07Px8p3XwoxOuKVjzKgZpEkLwW9Zv9oFdL2uvj8YBr1BcBB98OJzd4ZKHZJBe+AygDm4TwfE0dc6+1Cl7jtQzJwAi20SQBtbl3+HoxdJC0vCG4iKfS/WZc6KI70Ew7E9DDbkk9CvUG+fV79tOxphpaSFJBQALutPt53Pk9X5pYpmSI9dPKC+JswCX965e3mXF69/XHysCpbRU08QS2mW7VeKgJ9mMo9nZ77p5N0kKEElRYHIPeKkLZ3Zs5nhIszP+0TLJYu30Lo+Q4m8MIZvP0vvWhprbJR5aQCgsP+nhEc=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB4945.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(39860400002)(366004)(396003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(38070700009)(4326008)(33656002)(41300700001)(5660300002)(55016003)(2906002)(52536014)(8936002)(86362001)(85182001)(8676002)(38100700002)(6506007)(71200400001)(9686003)(53546011)(7696005)(26005)(83380400001)(478600001)(122000001)(316002)(107886003)(66556008)(64756008)(66446008)(66946007)(110136005)(76116006)(54906003)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?NEUwVW15ZFdadmVuWDV2N1hNdVR2eWozQUFlNzAwNFlLbGN0ejFPNFFSS3BK?=
 =?utf-8?B?VUpFazQ0QkxjcDM3LzVjRTVVQVpKQmJhQzRtQ2dwV21obDR5dDJ1UUNjUVR5?=
 =?utf-8?B?TWJpNURqczh5QUllOHh3YnozdkFjTnIrWXdUdTlMRkd2Rk9zUk54bjFUTmtp?=
 =?utf-8?B?L3VLZldENE5TczhNOWZpaHRySXN5aHBWWXNtL0pUZWt1cGdCSFozeTZ2NU9s?=
 =?utf-8?B?enBmLzNDY2cxM25CRXVIcWlINGZRN2J0UTMyMm5TUjRwaWtYNU8vaGhadE5l?=
 =?utf-8?B?UzQzQWMxOHhaQUJMQ3FQK0JsZVVXT2c0UjhGdnBGYkdkSGxDWmFhR0kxa1c2?=
 =?utf-8?B?UUc0UHp4VFRpbDVlUWxVQXBXbExtUm5WRjVrMzltR2oyOHBOb3hhWkZFU0hv?=
 =?utf-8?B?cFhGbzllTVRVSHdFSEZHcE1vamhiajFZYVZhQThxNUV3c0RPTy83S05wSGhZ?=
 =?utf-8?B?S1A3dmxrVFIwZ3JkdU91bnNxb0JUYlJmK1BrN0NxU0FqbUhvcUp0MFhaYW9L?=
 =?utf-8?B?TExRY3pvd1NpQ2U3MTdRajlwSi9KdUZvZEpBZ2lvTnVOMk1BaGtSNjVwcloz?=
 =?utf-8?B?NTErWENFeEM1YkZwQzZoQXhXOGhETjg5RzhNeW93ZXJUMWlZYktGSTVBdi9D?=
 =?utf-8?B?SkJzZnI0OEJwNW1TTGhtelpJQ1hVdkh0dkNHTEZZR3o1M0VrT0ZmUzdlcEcy?=
 =?utf-8?B?K3dwTW1vdjdWdmRPTml1ZEJ1bnZOb0FkWTVvS2JZeGx0V0xBeGZFRDhvOXlW?=
 =?utf-8?B?bWEvaHdjTHJmMkJUZjM1STVTUlIwd0ZsdGlYZmdwUFY0TmZTb2I2NjV0bmNn?=
 =?utf-8?B?U0h4NksxcDJvOGJRRDVDRXVLcndoSEk2MFlVSUZYTkk5ck9uK3ZOZjVPZFlZ?=
 =?utf-8?B?cGVHcllKUzFsaHdqRGwwQkErSGh4MmdkVTUvTmkwT05id3l3dGFqaWlEUjEx?=
 =?utf-8?B?WkZYQ3A2Q0FkOXRwa042YUNma1hiYWFDTUZaTkliZnNiSzUxLzIzQUtIZnF6?=
 =?utf-8?B?UGlJbnNSeHo0ZGpHdExGYzQrNFlVZWJlOThudGYrelNuQmlRall3aGdLVmpB?=
 =?utf-8?B?RUx5K2xFdlJFdFFWaVEyYjV1WWViRFAwWnN3ZjB5b0ovckgxTUVLVFRnT2VB?=
 =?utf-8?B?MXVoUUlaT252OG5HNHFLL0tyZ0lkUVJLNkNOdFdDYktiWHZCUEMzVVVzaU81?=
 =?utf-8?B?aXJWWUdoSis0aWpSSFdNMzgzTE8xc213L3llL1pyenk0WDlpc3EzdWNQTTh5?=
 =?utf-8?B?U3I5ZzlFQzlmbzVaQ3JZejdFYTNkZ2x4VnVLcm56L0djVXJPM3d3Rkpidkdm?=
 =?utf-8?B?amFwcVFNODlMakVSdk95T2VVNjBqeHlGbjBiVFkxT2dVeXc2M1plSW1DY0Rm?=
 =?utf-8?B?RWVoNXE1clRUeWNXMlQ4UFh3d1MzVjNaWldoUlM2ZndyL1o0MGJCN1J0K2Fl?=
 =?utf-8?B?T01HS3NyQWY4M3dSS3JKS2xYTndiTjRhWU1yWGVBTXBuYWg5ZmtLZ2JZbnV2?=
 =?utf-8?B?TUNhTDY3ZmxNdm8rQ2NBMEhkUUdObTBreE0wMTBBMUpjWTBRQ0dMaFpMMlVy?=
 =?utf-8?B?b2NZenF6eDZydjF1Y3cyeFVkSkZ6Z1djNjYyaFhhR1RILytRc3kxaFgvRmVv?=
 =?utf-8?B?T1JCeTZuQ1V2NzIyUmhBMVBMQjdrcTlYMzRPSXhLUkt5M3BmK2l6cFRLWmxP?=
 =?utf-8?B?N2FtRld4cHorVkRaMXdhVlZhTERnMUNGVjd5UzIxSFFKTDlhNCtGbmNZVTRP?=
 =?utf-8?B?YnBaQnVPUFFrYlFKRDczRW1lUVIya1czekhiSndyam85eVVsazBDQ0hpUms5?=
 =?utf-8?B?RzhxOXpRSUJUMFo0SWUzRm9UY1ZlWmNRVFhIbFUwSjE0TVIyeGRUQXI3RGF1?=
 =?utf-8?B?MGVrM0s2clFRRlRsZnl4N2MySit5NW5scXVtc1R6QklUN25PclgxNHF3WTJx?=
 =?utf-8?B?ckMvcWpPMFFOYm1oRnA0MXNiYWJlcjBhU2w1YUxoUkVZSktpMFhPUThkNkRt?=
 =?utf-8?B?N1c4Ni9NWHhUQ253N3ZGSlhjQ2hkNGE4eXNGNUl3dHVycWY2TUtKT2xoS3Nm?=
 =?utf-8?B?ajNvaEU0cU1ySHZ0YytLNGhGcDMxNTJCSVBOU1VTUEtTS05iN3dCcXUxc2Jy?=
 =?utf-8?B?VUxuZmphaWh2WkNoeHVFdStta0RUelZwdVo2aUZOMUd6a0QzVUlVcThvMFpV?=
 =?utf-8?B?a3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB4945.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc9fa062-2f35-4977-db6b-08dbd601789a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 08:56:40.9552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1u6PnHvdVWOV3XK8IAoOTa5hMAJHPznXFYDIIodVpY2YhYxHNAR0Txsjq0vicjtfKX0gqybm9MUN+HVCX/fLCYENvI9XX/W0gn/Mm6WsVP8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9996
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Oct 2023 08:56:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13461

SGkgSmFuLA0KDQpXZSBhcmUgdGhpbmtpbmcgdGhhdCB0aGlzIGRlc2NyaXB0aW9uIHRhYmxlIHdp
bGwgaGVscCBpbiBDb25maWd1cmF0aW9uIG1hbmFnZW1lbnQgYXMgd2VsbCBhcyBpbiBmdXR1cmUg
d2hlcmUgb25lIGNhbiByZWZlciB0aGlzIHRvIGtub3cgdGhlIGZlYXR1cmVzIGZvciBzcGVjaWZp
YyByZWxlYXNlLiBUaGlzIHdpbGwgaGVscCB0byBjcmVhdGUgaW1hZ2VzIG9mIHRoZWlyIGNob2lj
ZS4NCg0KRS5nLiB2ZXJzaW9uIHYxLjEgbWV0YS1kYXRhIGlzIHVzZWQgdG8gY3JlYXRlIGV2YWx1
YXRpb24gaW1hZ2VzIHdpdGggc29tZSBzcGVjaWZpYyBmZWF0dXJlcyB3aGljaCBtaWdodCBoYXZl
IGJlZW4gZGVwcmVjYXRlZCBpbiBmdXR1cmUgcG9pbnQgb2YgdGltZS4gTGF0ZXIgd2hlbiBzb21l
b25lIGluIGZ1dHVyZSB3YW50cyB0byBnZW5lcmF0ZSBhbiBpbWFnZSB3aXRoIHRob3NlIHNwZWNp
ZmljIGZlYXR1cmVzLCB0aGVuIHRoZSBpbmZvcm1hdGlvbiBpbiB0aGlzIHRhYmxlIHdpbGwgaGVs
cC4NCg0KUGxlYXNlIHByb3ZpZGUgeW91ciBvcGluaW9uLCBKYW4uDQoNClRoYW5rcyBhbmQgUmVn
YXJkcywNClNhaSBBc2hyaXRoLg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTog
SmFuIEtpc3prYSA8amFuLmtpc3prYUBzaWVtZW5zLmNvbT4gDQpTZW50OiBGcmlkYXksIFNlcHRl
bWJlciAxLCAyMDIzIDQ6MTAgUE0NClRvOiBhc2hyaXRoIHNhaSjvvLTvvLPvvKnvvLApIDxTYWku
U2F0aHVqb2RhQHRvc2hpYmEtdHNpcC5jb20+OyBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9y
Zw0KQ2M6IGRpbmVzaCBrdW1hcijvvLTvvLPvvKnvvLAgVE1JRUMgT0RHIFBvcnRpbmcpIDxkaW5l
c2gua3VtYXJAdG9zaGliYS10c2lwLmNvbT47IGhheWFzaGkga2F6dWhpcm8o5p6XIOWSjOWujyDv
vKTvvK3vvKUg4peL77yk77yp77yn4pah77yt77yw77yz4peL77yt77yw77yUKSA8a2F6dWhpcm8z
LmhheWFzaGlAdG9zaGliYS5jby5qcD4NClN1YmplY3Q6IFJlOiBbaXNhci1jaXAtY29yZSAyLzJd
IFJFQURNRV92ZXJzaW9uLXJlbGVhc2UtcG9saWN5Lm1kOiBBZGQgcHJvZHVjdCBkZXNjcmlwdGlv
biBkZXRhaWxzDQoNCk9uIDAxLjA5LjIzIDEwOjE5LCBTYWkuU2F0aHVqb2RhQHRvc2hpYmEtdHNp
cC5jb20gd3JvdGU6DQo+IEZyb206IFNhaSA8U2FpLlNhdGh1am9kYUB0b3NoaWJhLXRzaXAuY29t
Pg0KPiANCj4gVGhlIERlYmlhbiByZWxlYXNlcywgS2VybmVsIHZlcnNpb25zIGFuZCBpbWFnZSBm
ZWF0dXJlcyBzdXBwb3J0ZWQgZm9yIA0KPiByZXBzZWN0aXZlIGlzYXItY2lwLWNvcmUgcmVsZWFz
ZSBpbmZvcm1hdGlvbiBpcyBhZGRlZC4NCg0KcmVzcGVjdGl2ZQ0KDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBTYWkgPFNhaS5TYXRodWpvZGFAdG9zaGliYS10c2lwLmNvbT4NCj4gLS0tDQo+ICBkb2Mv
UkVBRE1FX3ZlcnNpb24tcmVsZWFzZS1wb2xpY3kubWQgfCA4ICsrKysrKysrDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgOCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZG9jL1JFQURNRV92
ZXJzaW9uLXJlbGVhc2UtcG9saWN5Lm1kIA0KPiBiL2RvYy9SRUFETUVfdmVyc2lvbi1yZWxlYXNl
LXBvbGljeS5tZA0KPiBpbmRleCA5MThlNzdhLi5mOGRkZTM4IDEwMDY0NA0KPiAtLS0gYS9kb2Mv
UkVBRE1FX3ZlcnNpb24tcmVsZWFzZS1wb2xpY3kubWQNCj4gKysrIGIvZG9jL1JFQURNRV92ZXJz
aW9uLXJlbGVhc2UtcG9saWN5Lm1kDQo+IEBAIC00LDYgKzQsNyBAQA0KPiAgMS4gW09iamVjdGl2
ZV0oI29iamVjdGl2ZSkNCj4gIDIuIFtWZXJzaW9uaW5nIHN5c3RlbV0oI3ZlcnNpb25pbmdzeXN0
ZW0pICAzLiBbUmVsZWFzZSANCj4gcG9saWN5XSgjcmVsZWFzZXBvbGljeSkNCj4gKzQuIFtQcm9k
dWN0IERlc2NyaXB0aW9uIGZvciBtZXRhZGF0YSByZWxlYXNlXSgjcHJvZHVjdGRlc2NyaXB0aW9u
KQ0KDQpXZSBhcmUgbm90IGJ1aWxkaW5nIHByb2R1Y3RzIGluIHRoZSBDSVAgcHJvamVjdC4NCg0K
PiAgDQo+ICAjIyBPYmplY3RpdmUgPGEgbmFtZT0ib2JqZWN0aXZlIj48L2E+DQo+ICANCj4gQEAg
LTI4LDMgKzI5LDEwIEBAIFRoZSBpc2FyLWNpcC1jb3JlIG1ldGFkYXRhIGZvbGxvd3Mgc2VtYW50
aWMgDQo+IHZlcnNpb25pbmcgc3lzdGVtIGkuZSAqKngueS56KiogZm9ybSAgQW4gYXBwcm94aW1h
dGUgdGltZSBnYXAgb2YgMyBtb250aHMgaXMgdGFrZW4gYmV0d2VlbiBjb25zZWN1dGl2ZSByZWd1
bGFyIHJlbGVhc2VzLiBEdXJpbmcgZXZlcnkgcmVsZWFzZSwgQ0lQLUNvcmUgcGxhbnMgdG8gZ2l2
ZSBvdXQgcmVjaXBlcyAoaXNhci1jaXAtY29yZSBtZXRhZGF0YSkgdXNpbmcgd2hpY2ggdGhlIHVz
ZXIgY2FuIGJ1aWxkIHRoZSBmbGF2b3Igb2YgdGhlaXIgY2hvaWNlLg0KPiAgDQo+ICBBbGwgdGhl
IHJlbGVhc2VzIGNhbiBiZSBmb3VuZCBbaGVyZV0oaHR0cHM6Ly9naXRsYWIuY29tL2NpcC1wcm9q
ZWN0L2NpcC1jb3JlL2lzYXItY2lwLWNvcmUvLS90YWdzKS4NCj4gKw0KPiArIyMgUHJvZHVjdCBE
ZXNjcmlwdGlvbiBmb3IgbWV0YWRhdGEgcmVsZWFzZSA8YSBuYW1lPSJwcm9kdWN0ZGVzY3JpcHRp
b24+PC9hPiINCj4gKw0KPiArfCAqKk1ldGFkYXRhIHZlcnNpb24qKiB8ICoqU3VwcG9ydGVkIERl
YmlhbiB2ZXJzaW9ucyoqICAgfCAqKlN1cHBvcnRlZCBLZXJuZWwgdmVyc2lvbnMqKiAgICAgICAg
ICAgICAgICB8ICoqRmVhdHVyZXMqKiAgICAgICAgICAgICAgICAgICAgICB8DQo+ICt8IC0tLS0t
LS0tLS0tLS0tLS0tLS0tIHwgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS18IC0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLXwgLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tIHwNCj4gK3wgdjEuMCAgICAgICAgICAgICAgICAgfCAgQnVzdGVy
IDxicj4gQnVsbHNleWUgICAgICAgICAgICAgICB8ICAgNC40LngtY2lwIDxicj4gNC4xOS54LWNp
cCA8YnI+IDUuMTAueC1jaXAgPGJyPiA2LjEueC1tYWlubGluZSAgfCBGbGFzaGFibGUgaW1hZ2Ug
PGJyPiBTZWN1cml0eSBleHRlbnNpb25zIDxicj4gVGVzdGluZyBleHRlbnNpb25zIDxicj4gU1d1
cGRhdGUgc3VwcG9ydCBmb3Igcm9vdCBwYXJ0aXRpb24gPGJyPiBTZWN1cmUgYm9vdCA8YnI+IEVu
Y3J5cHRpb24gb2YgZGF0YSBwYXJ0aXRpb25zICB8DQo+ICt8IHYxLjEgICAgICAgICAgICAgICAg
IHwgIEJ1c3RlciA8YnI+IEJ1bGxzZXllIDxicj4gQm9va3dvcm0gfCA0LjQueC1jaXAgPGJyPiA0
LjE5LngtY2lwIDxicj4gNS4xMC54LWNpcCA8YnI+IDYuMS54LWNpcCB8IEZsYXNoYWJsZSBpbWFn
ZSA8YnI+IFNlY3VyaXR5IGV4dGVuc2lvbnMgPGJyPiBUZXN0aW5nIGV4dGVuc2lvbnMgPGJyPiBT
V3VwZGF0ZSBzdXBwb3J0IGZvciByb290IHBhcnRpdGlvbiA8YnI+IFNlY3VyZSBib290IDxicj4g
RW5jcnlwdGlvbiBvZiBkYXRhIHBhcnRpdGlvbnMgIHwNCg0KVGhpcyBpcyBsaWtlIGEgbWluaSBj
aGFuZ2Vsb2csIGluIGFkZGl0aW9uIHRvIHRoZSBmdWxsIGNoYW5nZWxvZyAoZ2l0DQpoaXN0b3J5
KSBhbmQgdGhlIHJlbGVhc2Ugc3VtbWFyaWVzLiBXaGF0IGlzIHRoZSBwdXJwb3NlIGlmIHRoaXMg
dGFibGUsIHdobyBpcyBleHBlY3RlZCB0byByZWFkIHRoYXQ/DQoNCkphbg0KDQotLQ0KU2llbWVu
cyBBRywgVGVjaG5vbG9neQ0KTGludXggRXhwZXJ0IENlbnRlcg0K


