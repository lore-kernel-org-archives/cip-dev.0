Return-Path: <SRS0=sEG4=IX=lists.cip-project.org=bounce+64572+6329+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547B7C433E0
	for <cip-dev@archiver.kernel.org>; Thu, 25 Mar 2021 06:52:13 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98C1861A1F
	for <cip-dev@archiver.kernel.org>; Thu, 25 Mar 2021 06:52:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98C1861A1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6329+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id RXkOYY4521723xjCogM6WJyv; Wed, 24 Mar 2021 23:52:12 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web12.4393.1616655130228707347
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Mar 2021 23:52:11 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 12P6q645019763; Thu, 25 Mar 2021 15:52:08 +0900
X-Iguazu-Qid: 34tKBH9CW24GnNniR7
X-Iguazu-QSIG: v=2; s=0; t=1616655126; q=34tKBH9CW24GnNniR7; m=VvRNiQaamDTNp4GwFvIgt/g+G5ZmeTS5G3AjDud1+Bk=
X-Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1511) id 12P6q58N024027
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 25 Mar 2021 15:52:06 +0900
X-Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id D2DCD1000F3
	for <cip-dev@lists.cip-project.org>; Thu, 25 Mar 2021 15:52:04 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 12P6q4Vu032713
	for <cip-dev@lists.cip-project.org>; Thu, 25 Mar 2021 15:52:04 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EccMaSw8lXYKeI8QjUSStAPmmls3jj87q+P/+A5mMUzLAfKz/5tMpVnNU3bPQnvFFbpa6CYG9XuzaMxtPTJ0UrC/6LIRQwOKx2mj58XZmJE93JdNrQ1Fe1dYZflyYqbu55Nnvql4WCOlnxPp+fYnrIv4grqezISgpm/TwUVHkNVaFnYFxb8jjGB5EPU1lKGDyWheXsls3EhXZTaA6FYhv1pkcT+DdYnj0GSu4LSD6unnNM7+7VKKsmZaDEtRBBCbfV9TDF/A3HhISFyxdLUjrjrEAs4UN2ILKiGJC+eJxlzVyTpin7Le0kIQxOFb1+Y0WG1iLGuh0QM2cPkFTghdkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4S+jucDSS5ansFYTZrk7PKn7sd2ZffXVcWbuFM+Sl4=;
 b=oHHmCVQjyfYLEioBYYIA1jrgydOFDm/VYMuSiQwcyHrfI5ybZ3bYrssE8lSY9L5HRfUB9DI14wEzREyldE4LQ7iA7n7zwJp0cf5+anxvEfyt7NlvJsju5e5CzMetJRU86qmXp4aVlrAOSCIZpnObhcSut0AlxYsNoPCmwby+qLcAUw3OljBaYzcSGF/UwrPpt+fQhfmA+XkprBod2iHy0sTPRTqPBOhMy57zCZMQ+XY3ReP38Nc6bqx3e8TQp04kgM8AO7+k7NifERNwKSXJGnKSVQb2jSABxKI20/vqvcz0EnNRLn4ZTH5c9G0njrs0voyCT2jlkYS4zzO1EB9/1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdchCVKfQyu1k3CfQgmkqnvUCa7AVwAOOhXw
Date: Thu, 25 Mar 2021 06:52:02 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2983D3561B627443DD89880692629@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <OSBPR01MB4967EF41D9A0D69E6E46FCE4A0639@OSBPR01MB4967.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB4967EF41D9A0D69E6E46FCE4A0639@OSBPR01MB4967.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 077e880d-ec23-4b67-f107-08d8ef5a7ee4
x-ms-traffictypediagnostic: OSBPR01MB3143:
x-microsoft-antispam-prvs: <OSBPR01MB3143B4224D2AFB4A3A05E92792629@OSBPR01MB3143.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: huOOhL++qB4WS86lCBli8YYSVYu6ARC6jnzDy5N+RkXHSDe9tYqdDpLAxBhNl3BlhwB3i8iAqSMt0cyVbNa4er0qHY5i0wALfNcLh1/NMPbQrcpif0Hg8Qsnv2bWBFGPe6tOarPTTJm7NlFTde4/fa/iqkdyx3PUKUOJrDZFXRbCpX2uyM2W8znVE38IGd7L7lg636cSvaoZljHAu14kWB4dxztyxGLa0FKwr8msMFiVchS/nwDWI3sR5Ly7Q0ZgdgkxolfrYzWaRr3NMs4GKIPbH6ArfI0ohLny8B3/g0Fa6V4aTCmQLq0Ysrt0mqeeD0TAXKDaA7lh5Khpuqw1rRf7CLof0sWYzqGPIojMFfu7Ld54MtMOL3wzS8Y074/x0pp/4A57nuql6zaWWI4C+kUY75eGd3HfpubZuPNztmcnTsXNsPmYy9YY1tuQEVX7Ur2jxV7qCuG58bD3ZoQY3q2ldM1VwGeUDNGb7h6tbvDKh2L94ZtQtdQ8m/EHcupYALvUl+GHcvu79xpV1l0R4BFbFu6iz4FsNgNiJ3gpfvUYUBWPYoYV9up0/DqFM8enFB1AVBSWthoTLUrK0K3BYPvjlskwQFi4oPgbQkfj4ODakAQ/idDgKhklmrpfTh5y8DjYWI2mcvZMDWPBh9tpn2YL5xeZCkXQX6vit9Hk/UI2ac1euHRr3k/L+84RIgEP8glBq1b8pqhP5Z4Qifo9z5lauvRVCQ8sepNi+AN7aUaD0nYr72D5xvNazb8WZdlC
x-ms-exchange-antispam-messagedata: =?utf-8?B?ZWdubm1HVVJFQ2NqejdabzJzL2FRNm9QR3gwZERNYWs4TjQ3TEgzVTcyUU5x?=
 =?utf-8?B?QzNtNUo1cEd6TUUzQWhYM0lwdkVUb2tqczZQNjV3TzVyQWl2bW1GYjNFZFdW?=
 =?utf-8?B?bm5EWnhBVU1rS000N245ZHluYmgxWGJaVkRBRG04RHoxd1phUFEvenRTcHI1?=
 =?utf-8?B?VnN5YkpDZUQwY0hCTHVTR1RTTyt4Y29MSlUycDdMMVQ4SjF5NGRmRVVBS01O?=
 =?utf-8?B?dnpyNFMxZnh1Q2FTOW9qZXhyMEI5ek93SHBpUm9ta1prcG9XZzA0OXNJdEo1?=
 =?utf-8?B?T1RMWE5seXlQK1JvMHdUZktlWjhmRkh3a2U4S0dyZTBDNnE2Z0tQbm44TDB5?=
 =?utf-8?B?L3hKRjJrVy9YWG44MW1ZMlVqQnBhSFZpVWNkWk1YOFVmT3FpWGlFMm0vMkQw?=
 =?utf-8?B?cG1TaiswT2kwTjZBUmZTN0hzeXdFV3cyUHBBVFFxV3daU25FYlprV2ptcjB6?=
 =?utf-8?B?NG1Zb3FFN3gxczNtSTJTRERrTHlFNDM4OUtwaU9VQ29Mck5pd29la3NsdGZj?=
 =?utf-8?B?ZElUYkZwL0dSdHFCdVRvY1NYeVZFQk91ZS9lOEM1ZnQyQ2RHdnphL3pCbVV3?=
 =?utf-8?B?QjVBMWdZcS9LZDFtU09XU0o4OURCTmZCVW1mNGZOSmVYVjBjWFA3NVBYVURI?=
 =?utf-8?B?YzcvcXhadCtQR1NQUGFsazVmcDBKVWlPK1NaLytibW9YVjZ1RXdNVlNlTUdY?=
 =?utf-8?B?YmowRFBGT0dDV0tyNnVzcEsvb0tnTGY2aWhhV1NrdjR3YVkrLzRjdG1HaG54?=
 =?utf-8?B?V1J2RnhhdEl4OXpLdWhmd2cxUjZZZUlTYW9qcy9pZGtZNzR5OXIrbXNtbEp3?=
 =?utf-8?B?RW1rL3RINkRkNzFycXpXaHo4TVhKUU1FTXNLL3ZSSTFqSFFIL3ZtSkVYZWEr?=
 =?utf-8?B?K0JMbDN5b2lnMzZpdzJYL0xiL1VEWHAzNlVRYTJRTm1OdGFROGFnQTd3aW1F?=
 =?utf-8?B?dlArK3BkSnhBTk1sWlg2d1VldTE0NWx6bkNWZmd0endZOEtwcUtXTGRZVUMz?=
 =?utf-8?B?dHk0UGdoVmNDOHR3Z2s2eFZmQ29qekxFMkxXTWUzSmpsVlhDNzQzLzYyYnBp?=
 =?utf-8?B?cVV4R2pNMmttMFpNSjVleWErSXZwbUQ4WXRUaU94c1djclkvT1kzYVRybkly?=
 =?utf-8?B?MmdjQlFjaTkvbGQrMndzaEJvR3FVcmFJOThCU1l6cDY4NnR5S3BUN01hTGRn?=
 =?utf-8?B?NlVHMGE5L3NwOE9RMWNRSWJKSXVZMktDcEJObForNnpLRG5MaTcxYVAvNW01?=
 =?utf-8?B?MHB4aWpPV1NFL0VhbUwzcldNOXY4T1FyWVlnQ1g2dUF1SVdsYWUyU0NaeVNx?=
 =?utf-8?B?WGMxVWd4YVFkaVZZQ04rMGJJQnFsWW9nd1QzMEJOVm5zRngwQ2dWYnJRRzFt?=
 =?utf-8?B?ZkpDME05eVRtcmVPSDkwRWh5SXJyNWlyNFBqMWxtcklVY09QNmxPWHlOTURS?=
 =?utf-8?B?SURqdGtReVFiVGNrMm1ITHVBd1VHeFpDMXlLaGVnQ3NYSjUwZXlxUE9xZ1Zp?=
 =?utf-8?B?TVNScEh3aGYyMVpDQ0hiZmVnekRXZmxzWkFhV29SMDdjcTF6Y0Q1MjdRSk1m?=
 =?utf-8?B?b1o1Nnd5dTBBRFZPbXovK0RPTFVQcGQzbFFkNXpvL0YvWjRVT0lTdEFVTDAv?=
 =?utf-8?B?a2pFNXI2Y0ZrQTZPMk5OckFjRHExMXFtTlhwRmYvNyttRW43Ynk2Y0FKT3Yx?=
 =?utf-8?B?LzNMd2FLZnFHSDd4NFRWOUlHdzNialJhL0hwSHNlTndyaU40S1FGYkxMSkgz?=
 =?utf-8?Q?JmAmigwdv/jgSUrTvg=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 077e880d-ec23-4b67-f107-08d8ef5a7ee4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2021 06:52:02.7033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qr2LAyw1mYWyu0mc7o87dKy7L10r/7fgpZgkXLkf9hoV6YX+uUML15jD75h3aNF0y6ZnEctXEsksP734u6Y5ijikL1DTqoqazrGoLrDuw+8t7t9Ivkvb4329iD9qjW21
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3143
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: QLBxQCZ5oVWO8eAJ5jCr10YKx4520388AA=
Content-Type: multipart/mixed; boundary="Dwxk5nudDEjduAYYLoHw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1616655132;
 bh=E1uJv5tgN0dka4K4TVrVhd1a4xaQ0tv8N/v5bKKnWpY=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=tjIJTznusILXWfh0lBsPDWQiXNa74SvPKKqT1yVLHp8LAYIW3uF1ah0IgPlEDNUc8VQ
 LICqgIKnBiEOOBE9hJFfb5zYwveqh7Rh4lyHu+2xcZPlVcRJ86k0S7FTC3r8Cx9zNqvaM
 4P183z8Px+ifcQYAEC9Z8mp+XOVFwUNXFBQ=

--Dwxk5nudDEjduAYYLoHw
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgYWxsLA0KDQpJIGNhbiBub3QgcGFydGljaXBhdGUgSVJDIG1lZXRpbmcgdG9kYXkuDQoNCj4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogY2lwLWRldkBsaXN0cy5jaXAtcHJv
amVjdC5vcmcgW21haWx0bzpjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZ10gT24gQmVoYWxm
IE9mDQo+IG1hc2FzaGkua3Vkb0BjeWJlcnRydXN0LmNvLmpwDQo+IFNlbnQ6IFRodXJzZGF5LCBN
YXJjaCAyNSwgMjAyMSA5OjAzIEFNDQo+IFRvOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9y
Zw0KPiBTdWJqZWN0OiBbY2lwLWRldl0gQ0lQIElSQyB3ZWVrbHkgbWVldGluZyB0b2RheQ0KPiAN
Cj4gSGkgYWxsLA0KPiANCj4gS2luZGx5IGJlIHJlbWluZGVkIHRvIGF0dGVuZCB0aGUgd2Vla2x5
IG1lZXRpbmcgdGhyb3VnaCBJUkMgdG8gZGlzY3VzcyB0ZWNobmljYWwgdG9waWNzIHdpdGggQ0lQ
IGtlcm5lbCB0b2RheS4NCj4gDQo+ICpQbGVhc2Ugbm90ZSB0aGF0IHRoZSBJUkMgbWVldGluZyB3
YXMgcmVzY2hlZHVsZWQgdG8gVVRDIChHTVQpIDA5OjAwIHN0YXJ0aW5nIGZyb20gdGhlIGZpcnN0
IHdlZWsgb2YgQXByLiBhY2NvcmRpbmcNCj4gdG8gVFNDIG1lZXRpbmcqDQo+IGh0dHBzOi8vd3d3
LnRpbWVhbmRkYXRlLmNvbS93b3JsZGNsb2NrL21lZXRpbmdkZXRhaWxzLmh0bWw/eWVhcj0yMDIx
Jm1vbnRoPTMmZGF5PTI1JmhvdXI9OSZtaW49MCZzZWM9MCZwMT0yMjQmcDI9DQo+IDE3OSZwMz0x
MzYmcDQ9MzcmcDU9MjQxJnA2PTI0OA0KPiANCj4gVVNXZXN0CVVTRWFzdAlVSwlERQlUVwlKUA0K
PiAwMjowMAkwNTowMAk5OjAwCTEwOjAwCTE3OjAwCTE4OjAwDQo+IA0KPiBDaGFubmVsOg0KPiAq
IGlyYzpjaGF0LmZyZWVub2RlLm5ldDo2NjY3L2NpcA0KPiANCj4gTGFzdCBtZWV0aW5nIG1pbnV0
ZXM6DQo+IGh0dHBzOi8vaXJjbG9ncy5iYXNlcm9jay5vcmcvbWVldGluZ3MvY2lwLzIwMjEvMDMv
Y2lwLjIwMjEtMDMtMTgtMDkuMDAubG9nLmh0bWwNCj4gDQo+ICogQWN0aW9uIGl0ZW0NCj4gICAx
LiBDb21iaW5lIHJvb3QgZmlsZXN5c3RlbSB3aXRoIGtzZWxmdGVzdCBiaW5hcnkgLSBpd2FtYXRz
dQ0KDQpDVEogYW5kIEkgYXJlIHdvcmtpbmcgb24gYW4gZW1haWwgYmFzaXMuDQpXb3JrIGlzIHBy
b2dyZXNzaW5nLCBidXQgaXQgaGFzIG5vdCB5ZXQgYmVlbiBpbXBsZW1lbnRlZCB0byBvdXIgTEFW
QS4NCg0KPiAgIDIuIERvIHNvbWUgZXhwZXJpbWVudCB0byBsb3dlciBidXJkZW5zIG9uIENJIC0g
cGF0ZXJzb25jDQo+ICAgMy4gQXNrIGJvYXJkIG93bmVycyhzaWVtZW5zX2kzODYtcnQvcGxhdGhv
bWVfb2JzdngxKSB3aGV0aGVyIFguMjUgYW5kIGZsb3BweSBjYW4gYmUgZGlzYWJsZWQgLSBtYXNh
c2hpOTEwDQo+IA0KPiAqIEtlcm5lbCBtYWludGVuYW5jZSB1cGRhdGVzDQoNCkkgcmV2aWV3ZWQg
djQuNC4yNjMuDQoNCj4gKiBLZXJuZWwgdGVzdGluZw0KPiAqIENJUCBTZWN1cml0eQ0KPiAqIEFP
Qg0KPiANCj4gVGhlIG1lZXRpbmcgd2lsbCB0YWtlIDMwIG1pbiwgYWx0aG91Z2ggaXQgY2FuIGJl
IGV4dGVuZGVkIHRvIGFuIGhvdXIgaWYgaXQgbWFrZXMgc2Vuc2UgYW5kIHRob3NlIGludm9sdmVk
IGluIHRoZSB0b3BpY3MNCj4gY2FuIHN0YXkuIE90aGVyd2lzZSwgdGhlIHRvcGljIHdpbGwgYmUg
dGFrZW4gb2ZmbGluZSBvciBpbiB0aGUgbmV4dCBtZWV0aW5nLg0KPiANCj4gQmVzdCByZWdhcmRz
LA0KPiAtLQ0KPiBNLiBLdWRvDQo+IEN5YmVydHJ1c3QgSmFwYW4gQ28uLCBMdGQuDQoNCkJlc3Qg
cmVnYXJkcywNCiAgTm9idWhpcm8NCg==

--Dwxk5nudDEjduAYYLoHw
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6329): https://lists.cip-project.org/g/cip-dev/message=
/6329
Mute This Topic: https://lists.cip-project.org/mt/81591241/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--Dwxk5nudDEjduAYYLoHw--
