Return-Path: <SRS0=DD+/=IQ=lists.cip-project.org=bounce+64572+6294+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C47C433DB
	for <cip-dev@archiver.kernel.org>; Thu, 18 Mar 2021 09:33:11 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A262664F38
	for <cip-dev@archiver.kernel.org>; Thu, 18 Mar 2021 09:33:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A262664F38
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6294+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 6q2TYY4521723xKFzQiXqxFf; Thu, 18 Mar 2021 02:33:10 -0700
X-Received: from ss11.sbt-mailgate.jp (ss11.sbt-mailgate.jp [202.241.206.51])
 by mx.groups.io with SMTP id smtpd.web10.6516.1616059987774325129
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Mar 2021 02:33:09 -0700
X-Received: from mail.sbt-mailgate.jp (sagproxy-out12.sbt-mailgate.jp [10.16.47.42]) (envelope sender: <masashi.kudo@cybertrust.co.jp>)
	(not using TLS) by ss11.sbt-mailgate.jp (Active!gate) with ESMTP id SSbb09895A;
	Thu, 18 Mar 2021 18:27:27 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kQTSWg4V0sHaU2/qL45jqSgraXP4OFDbs1hXWO4V3sNB+K7SpEJgAEMhGBo3yqQlm9O3uZi4eMLTOgQQ9oodBrK/QmEfT9WAAFobOcp2PuACOelyqdLcwPAY3rLMcK1KQzYOUKdDOF3jGxDkn0YS1FbKBU+rZvlaxbkh6HLXYg0JmqAlp3lF0rkzy2p7onvXy4oNymQiyShm26oa7CYUBy+QRRcV49v0flqHnUAcmUQBCHLzeMaUHJ7IDMjZluPBdY4RQFuQ60i7BqUwk2d7BQeebQnkPVXD05JnNhwSUfTpzRdKQdnNW7zoeA5uot5X5ZkhkBEYs/za4Hm+aqHSyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CK9SEZxBxLC3fnV+0Awp46YROGUzPdwhlzPFXhNVge8=;
 b=Th95C0TWuoW/82QqNCbhtoO2TyYcgm58qbD0sI4JpFHA1GBLF2uGahrbSF4WxKtp8R/4qGjhFJ+NrFRVbZHkX89wfwgdCLX155dzYoFFgPRZwXjgW3xQcNVBJthFKX5wIoDRFlDds33DVydInPKsJg3++oUK20KIH1guANSrEwpp4kuOuZPumpJe1VFDvNq3tOTTxNgm7Fyv2Y4zfR/5hKwb2kjO2hHYphRIyNbgCDYSJatgUFHwJR6AFeFqSoofbkDkkNA/07+IqAYiDj1MlVd2+zFtUXEMeAT3JpECvh4eOD7tbkFQofiU01WPlTyrYT9XHo8XiAETcRMVO1ldgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TYAPR01MB5833.jpnprd01.prod.outlook.com (2603:1096:404:8055::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Thu, 18 Mar
 2021 09:27:25 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::fc16:7286:28cc:8325]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::fc16:7286:28cc:8325%7]) with mapi id 15.20.3955.018; Thu, 18 Mar 2021
 09:27:25 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <jan.kiszka@siemens.com>, <minmin@plathome.co.jp>,
	<cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <nobuhiro1.iwamatsu@toshiba.co.jp>, <wens@csie.org>
Subject: [cip-dev] [Feedback Requested] RE: Cip-kernel-sec Updates for Week of 2021-03-18
Thread-Topic: [Feedback Requested] RE: Cip-kernel-sec Updates for Week of
 2021-03-18
Thread-Index: Adcb155JKC5WxfCIQN+IRDjOQ0ZrGg==
Date: Thu, 18 Mar 2021 18:33:02 +0900
Message-ID: 
 <TY2PR01MB4972E1E07AE85D162237E83CA0699@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e2e34c29-49eb-4b3c-fa20-08d8e9f00aed
x-ms-traffictypediagnostic: TYAPR01MB5833:
x-microsoft-antispam-prvs: 
 <TYAPR01MB5833FA1211FF585F9FA3C567A0699@TYAPR01MB5833.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 qI3k3NiXrJyxfOQupdOWyj0hVG7YjS6wfDIayfepx8TrRnYox4jC3cWeLzXgBo91aVu7tt/OVqFFKPKbVEollReEWzTmPFcZTHq4yboU+muuD4KPbxlkIZ6PjJtS6t8TM6QfLOyltgnv0iA5OPZz/I9EfbW4BVQD6eaZyKQz0zzC0UNZyduiR2xh1kaV8wsNxEoRFHc4MnZkTU06bVAAhb9+zuk50eY7NMa26isvOU89iAmlj6YkQCYSfYsbs6riuVpJCJEC0WjIW7ZO063zhMDA7dHeyj+w74u1paB4BQkVCEugCkW7zxR35WTVVSJl5wBbXxWH6YO2nJCNu47E8phDj7NS12jA4RAgt2TUKLsQf9H7uKxmWKZNNPUENxg9es+bcs0nsNcoNlZ5IlwvOzeccPWd5vQMlYn68N2PeNtsz94LTtt5n6QMthGOhu2cdAk0NwUn1CkpYZnKrWyBPbvHpMAc+lutslpTDrBuKHUJnBZVqAGpq7vH7jsOoxQwkq27S9qMgjK64lkyC3trgasi00X1zmfju1ikufbRTwJ3ekVj8wMOIUZhHwsoLNCJEmTDDVIvrZ/gDhOovfNCSDd3m6SZJNWnZBbahqQKixRLGUeZy8t2u+CEL/BLSnb/t148AzY8C9W8pygOqC3gyyw+yy+gwp3q17D7ZadsWy48MRntur0adA6pIVryZoBp
x-ms-exchange-antispam-messagedata: 
 =?utf-8?B?RmdkeUdnRTdPeDc5U2Z5TnN5UzNFOTNGYk1ZbFhDN0l1U2VMZDE0ZHp1WlR6?=
 =?utf-8?B?QVYraFN1Ym5uMXZ5VWxZaGxvVnFmZldIVXVSWDlKaDJkdklaUWNTQzcyckNP?=
 =?utf-8?B?R0d2ZXl4dU9IRTVFWFAyWU9qRWovUkFhTjBabnl5Q3NvaE8wSVljb28zNzdR?=
 =?utf-8?B?REpERjRsMHpiY05kSFBydEhDQ3FHbThzU1g0UWtaK3FqZ1RYRU9oZG9LRkJa?=
 =?utf-8?B?K05nRXhEbXJxK0pic1FCK2E2cnV5YzEwdVM2Q3RhSTFtNUJRL0ZTWkp1RlM3?=
 =?utf-8?B?OC9kWUhRcHowQXdSUGR5RnhoaFgzS1ZmanR4QzViRGtwNExOdHJTanB4aVJv?=
 =?utf-8?B?ZVFLVTZBbVIrTHJQNTRLZlBRcTdqV2xTd20zTUp0akVlZldia1FySWJIREs2?=
 =?utf-8?B?UTJLbjIyUEFQQi9IelRqQU5vUHpTMzA0YkFFOTUxTWhSRnFZeURjM0FhbEMr?=
 =?utf-8?B?SnB0c3hGS0dFdmYwamtiRHlVVHBxRVMydkxsdm5IUGlvdTVKQkJUR2tHckFq?=
 =?utf-8?B?WjNXV1ZudWFCUUNrZlY1VWVyc1JlSnVqRG1rNEtHUEdCdFU0OU9xa1h3dHBj?=
 =?utf-8?B?Y1Bob0h1QVVhd3Y2cUgvdklvbTZTTWpQTWRLZFdhSFdHTjFmMkp4VmRJd2ZI?=
 =?utf-8?B?U3dJazF2bWVBYmNtVko2MHlMaHlJb2pENjk0M2pTMC9yU1lvMUZTUFUybExS?=
 =?utf-8?B?NXdXVm9tU0J3MXJiYnpZNWVqelkrWHkyK1NJMmQ4SmlPT2Vka3prRzhHOGFm?=
 =?utf-8?B?dnBxSkEyN2s5am5OMHdOVFVXcVFIbDR4clFSWTBVMGdtQ2VMay90NU5Ndm94?=
 =?utf-8?B?Z0IxQjlzSGVQSVlwTUc4UTFDVzk2cXpuTmdHcW1NWkFveDFCWXVpekZwaFF0?=
 =?utf-8?B?R0V1QTBFajRzWUNjVjhYdXJJc250RU9HWnYyeloyUkdYV1ZTSU5ZcFVNREQ3?=
 =?utf-8?B?QlArK1Z6RVlHTnAwQzJQWUhsNHBOTHB1eTBKUW1EOTdaMkdmWjhER0JWWThQ?=
 =?utf-8?B?Y3NUQmIzckJaazRlb0pFdTVWQjExa3Y2ZmNweW5xRmREdWxNMzRUNVVhenQ1?=
 =?utf-8?B?MjJ2TXlrSm5sTE5WbUpMMktwNGcvektWMGFoSXpnMlBLc0p6bHlsd3d0bkIr?=
 =?utf-8?B?RTRtWlJ2OWptZko4ckVHTHVLREl4WVJxTjRnNDNVaWJaWHJXeDdmQU4vTjJU?=
 =?utf-8?B?dnd2VlQ3cHVQcG5GVDRTVGROcklsT2JQM1F3cHk2Y0xjdFNuaGZ0OU1sU0NK?=
 =?utf-8?B?VlV0Z2N2emZSV3RDbUgvMC9pUVNrS29uandGbkR2cWJrS04zUjRHOE12Z0pK?=
 =?utf-8?B?S0x6WFg3YkRtSTE5cnVqQTJ4dXhVM1VZNGcrOTVQd1JHWjdKeFZydWRON3or?=
 =?utf-8?B?dG1oQVh2dDBsdWYrS3V5bDA5dDNRMzd1c1NuSmhmemtOYUJpMlVFWWtKanFW?=
 =?utf-8?B?aENBWU5ndUxab0RnZGpsUWlnbjh5TXdkQU01d2RrTk4xSU1QWHRkWmNzOHJS?=
 =?utf-8?B?bkwyNm9xOW5jd0MvMWxyL1dNWVRZNzlzRXQ0SGdIallNVXViWCt6R3R2NzNK?=
 =?utf-8?B?cENVVHBtZGd6c2ZJOUY2VUJEM3VpSU51a2F4WURZYkFFQ1VJcExFem5JeGtH?=
 =?utf-8?B?RmY4QS9VeENXcnpZQklRNHYwNGMrL1F4NnFNa0xURHU4aEFjRmdIekVCQUtq?=
 =?utf-8?B?VXNXeDVtVm54QTd3a3dkRnZXd1RWckpBeHlwck5xblBQVzMxWWhRbDlhb05Q?=
 =?utf-8?Q?mWtFhtUpWLQOyNWFWrmoGzNk0k5JwNGPhUAznvL?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2e34c29-49eb-4b3c-fa20-08d8e9f00aed
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2021 09:27:25.7146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qTWsQofoRuP2O3qVkBjppiKimptvOGN8evzCZ+jrRhEaVmtkjsbHYiN8jA33ojGWc2svbB8y3lKcHRts4cfv5jgOhs16FhPCx6fvPTQUVBk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5833
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 3jvEa08gHOPaz9gT31Gsd9fox4520388AA=
Content-Type: multipart/mixed; boundary="XBnmhg2Ql2qrJ5nYyTW1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1616059990;
 bh=rzjLdzhh2n8gj6Iqec2uNyu+mSbBtWz7tby1EQxEY7U=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=HfeC3HVmslghPrnu5YY7vMOqvZav1g6KxTbItKaDZdGWplxG4c3TCM3p773Unkuqc6g
 Obkm0hNQHSx2tja7cZh+kezj4n2IBYQGPhKZK+YeIFKSKea/lyovymIMLe1/WtOlsl0bj
 1mv7W2NKNdjLPYBcSuq82lMkqNpGXvCP3u0=

--XBnmhg2Ql2qrJ5nYyTW1
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksIEphbi1zYW4sIE1pbmRhLXNhbiwNCg0KUGxlYXNlIGZpbmQgdGhlIENWRSByZXBvcnQgYXMg
Zm9sbG93cy4NCkluIHRoZSBhbmFseXNpcyBvZiB0aG9zZSBDVkVzLCB3ZSBmb3VuZCBzb21lIGRv
dWJ0cyBhYm91dCB0aGUgY29uZmlncy4NCg0KLSBDVkUtMjAyMC0zNTUxOSBpcyByZWxhdGluZyB0
byBYLjI1Lg0KWC4yNSBpcyBlbmFibGVkIGFzIGZvbGxvd3MsIGJ1dCB3ZSB3b25kZXIgd2hldGhl
ciBYLjI1IGlzIHJlYWxseSB1c2VkIG9yIG5vdC4NCj4gICAgIDQuNC55LWNpcC94ODYvcGxhdGhv
bWVfb2JzdngxLmNvbmZpZzpDT05GSUdfWDI1PW0NCj4gICAgIDQuMTkueS1jaXAtcnQveDg2L3Np
ZW1lbnNfaTM4Ni1ydC5jb25maWc6Q09ORklHX1gyNT1tDQo+ICAgICA1LjEwLnktY2lwLXJ0L3g4
Ni9zaWVtZW5zX2kzODYtcnRfZGVmY29uZmlnOkNPTkZJR19YMjU9bQ0KDQpQbGVhc2UgY29uZmly
bSwgYW5kIGxldCB1cyBrbm93IHdoZXRoZXIgWC4yNSBzaG91bGQgYmUgZGlzYWJsZWQuDQoNCi0g
Q1ZFLTIwMjEtMjAyNjEgaXMgcmVsYXRpbmcgdG8gZmxvcHB5Lg0KSXQgaXMgZW5hYmxlZCBhcyBm
b2xsb3dzLg0KPiAgICAgNC40LnktY2lwLXJ0L3g4Ni9zaWVtZW5zX2kzODYtcnQuY29uZmlnOkNP
TkZJR19CTEtfREVWX0ZEPW0NCg0KUGxlYXNlIGNvbmZpcm0gdGhhdCB0aGlzIGNhbiBiZSBhbHNv
IGRpc2FibGVkLg0KDQpCZXN0IHJlZ2FyZHMsDQotLQ0KTS4gS3Vkbw0KDQo+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IENoZW4tWXUgVHNhaSA8d2Vuc0Bjc2llLm9yZz4NCj4g
U2VudDogVGh1cnNkYXksIE1hcmNoIDE4LCAyMDIxIDU6NDggUE0NCj4gVG86IGNpcC1kZXZAbGlz
dHMuY2lwLXByb2plY3Qub3JnDQo+IENjOiBQYXZlbCBNYWNoZWsgPHBhdmVsQGRlbnguZGU+OyBO
b2J1aGlybyBJd2FtYXRzdQ0KPiA8bm9idWhpcm8xLml3YW1hdHN1QHRvc2hpYmEuY28uanA+OyDl
t6Xol6TjgIDpm4Xlj7jvvIhDVErjgIBPU1Pkuovmpa3mjqjpgLLlrqTvvIkNCj4gPG1hc2FzaGku
a3Vkb0BjeWJlcnRydXN0LmNvLmpwPg0KPiBTdWJqZWN0OiBDaXAta2VybmVsLXNlYyBVcGRhdGVz
IGZvciBXZWVrIG9mIDIwMjEtMDMtMTgNCj4gDQo+IEhpIGV2ZXJ5b25lLA0KPiANCj4gU2l4IG5l
dyBpc3N1ZXMgdGhpcyB3ZWVrIGZyb20gdGhlIFVidW50dSB0cmFja2VyOg0KPiANCj4gLSBDVkUt
MjAyMC0zNTUxOSBbbmV0L3gyNTogYnVmZmVyIG92ZXJmbG93XSAtIGZpeGVkDQo+ICAgTG9va3Mg
bGlrZSBhIGZldyBjb25maWdzIHN0aWxsIGhhdmUgWC4yNSBlbmFibGVkOg0KPiAgICAgNC40Lnkt
Y2lwL3g4Ni9wbGF0aG9tZV9vYnN2eDEuY29uZmlnOkNPTkZJR19YMjU9bQ0KPiAgICAgNC4xOS55
LWNpcC1ydC94ODYvc2llbWVuc19pMzg2LXJ0LmNvbmZpZzpDT05GSUdfWDI1PW0NCj4gICAgIDUu
MTAueS1jaXAtcnQveDg2L3NpZW1lbnNfaTM4Ni1ydF9kZWZjb25maWc6Q09ORklHX1gyNT1tDQo+
ICAgTWF5YmUgdGhleSBzaG91bGQgYmUgcmV2aXNpdGVkPyBjaXAta2VybmVsLWNvbmZpZyBhbHNv
IGdpdmVzIHdhcm5pbmdzDQo+ICAgZm9yIENPTkZJR19YMjUuDQo+IA0KPiAtIENWRS0yMDIxLTIw
MjE5IFtpbXByb3BlciBzeW5jaHJvbml6YXRpb24gaW4gZmx1c2hfdG9fbGRpc2MoKV0gLSBsaWtl
bHkgUmVkSGF0DQo+IG9ubHkNCj4gICBSZXBvcnQgbWVudGlvbnMgaW5jb3JyZWN0IGJhY2twb3J0
IGluIFJlZEhhdCBrZXJuZWxzLg0KPiANCj4gLSBDVkUtMjAyMS0yMDI2MSBbZmxvcHB5OiByYWNl
IGNvbmRpdGlvbiBkYXRhIGNvcnJ1cHRpb25dIC0gZml4ZWQNCj4gICBObyBtZW1iZXIgZW5hYmxl
cyB0aGlzIGV4Y2VwdDoNCj4gICAgIDQuNC55LWNpcC1ydC94ODYvc2llbWVuc19pMzg2LXJ0LmNv
bmZpZzpDT05GSUdfQkxLX0RFVl9GRD1tDQo+ICAgd2hpY2ggc2hvdWxkIHByb2JhYmx5IGJlIHR1
cm5lZCBvZmYuDQo+IA0KPiAtIENWRS0yMDIxLTI4Mzc1IFtmYXN0cnBjOiBhbGxvd3Mgc2VuZGlu
ZyBrZXJuZWwgUlBDc10gLSBmaXhlZA0KPiAgIE5vIG1lbWJlciBlbmFibGVzIHRoaXMuDQo+IA0K
PiAtIENWRS0yMDIxLTI4NjYwIFtydGw4MTg4ZXU6IGFycmF5IGFjY2VzcyBvdXQtb2YtYm91bmRz
XSAtIGZpeGVkDQo+ICAgTm8gbWVtYmVyIGVuYWJsZXMgdGhpcy4NCj4gDQo+IC0gQ1ZFLTIwMjEt
MzQyOCBbaW50ZWdlciBvdmVyZmxvdyBpbiBleHQ0X2VzX2NhY2hlX2V4dGVudF0gLSB1bmNsZWFy
IFsxXQ0KPiAgIFJlcXVpcmVzIGEgc3BlY2lhbGx5LWNyYWZ0ZWQgZXh0NCBGUyBpbWFnZSwgc28g
d2UgbGlrZWx5IGRvbid0IGNhcmUuDQo+IA0KPiBVbmZvcnR1bmF0ZWx5IERlYmlhbidzIFNhbHNh
IHNlcnZpY2UsIHdoZXJlIHRoZSBEZWJpYW4ga2VybmVsIHNlY3VyaXR5IGlzc3VlDQo+IHRyYWNr
ZXIgaXMgaG9zdGVkLCBpcyBjdXJyZW50bHkgZG93biwgc28gd2Ugb25seSBoYXZlIG9uZSBzb3Vy
Y2Ugb2YgZGF0YSB0aGlzIHdlZWsuDQo+IA0KPiANCj4gUmVnYXJkcw0KPiBDaGVuWXUNCj4gDQo+
IA0KPiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvc3RhYmxlLzIwMjEwMzE3MTUxODM0LkdF
MjU0MUBxdWFjazIuc3VzZS5jei8NCg==

--XBnmhg2Ql2qrJ5nYyTW1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6294): https://lists.cip-project.org/g/cip-dev/message=
/6294
Mute This Topic: https://lists.cip-project.org/mt/81425316/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--XBnmhg2Ql2qrJ5nYyTW1--
