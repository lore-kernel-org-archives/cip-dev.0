Return-Path: <SRS0=8CEy=I7=lists.cip-project.org=bounce+64572+6340+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB05C433ED
	for <cip-dev@archiver.kernel.org>; Fri,  2 Apr 2021 01:02:33 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92CC66112E
	for <cip-dev@archiver.kernel.org>; Fri,  2 Apr 2021 01:02:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92CC66112E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6340+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id KwTgYY4521723xTeytZjY9tG; Thu, 01 Apr 2021 18:02:32 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web11.10105.1617325350395059823
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Apr 2021 18:02:31 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 13212Sk5004586; Fri, 2 Apr 2021 10:02:28 +0900
X-Iguazu-Qid: 34tMPz9vsfo4IirjMa
X-Iguazu-QSIG: v=2; s=0; t=1617325348; q=34tMPz9vsfo4IirjMa; m=TzSfBcgJ5c2Mfxgp4Kt73b/mXVnS/LTHik0v85he7Qk=
X-Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1511) id 13212RQf013300
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 2 Apr 2021 10:02:28 +0900
X-Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id 92213100080;
	Fri,  2 Apr 2021 10:02:27 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 13212RRr030023;
	Fri, 2 Apr 2021 10:02:27 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BxqherdKhMx3u1IvAHDyH7y6OcprkKCfJxFiM3jq0jkHFTqC/kfbEuhXTyMvrSytABRl0IdAR4YY9c3aAT4ZJEaeQl4RYZ4uLU6T2HkXiyXQmf+mlrPBow9hHoyOd3neSQlUdTJA4IE7mT/HWL4fWnTFedEtgTNwVBZVRjPYhnL8g9Z6V1aSzUVvgdjOW87Lqy8OYq2lML40xKzUAJr+nP75N5KdygnYvbxDtmLUGwHpfaj7+wdfp9O3KlHOMZfMBbIHBX7YvE7YubyRw5LlMjKdZBNEsQhpA61kau2JChX4p7LFLq/hqVikDrdzjP28CDuWL5DG9J8b3JuUBieOgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+nbq3iAfadsjX0ZjVYdqi+AONQRs60iOnTaK1Xp+OXk=;
 b=BO0u8RM//vt0nEM1IaL65nNUwD2StcUjquQY0lXvlHqXOYiC9GvcJp+0XK3qSoN5V3M4p9t7sx/8/f40EfHswTKCzxZ7sD4R5TR0NfaPhXlX2kG0sZjOey0JjY11RN7mBdNf6w7fkaERO0uiphZ6jU5aADyyc1zfgDdYsWC/+zazHM0t0bGMzJ/atKWuMU2ulha9wagKH7gSqSignmNy+jtCUfulBOii2yBHyomccVv19fwzZfsbeXd+rKErrlmeepVo+ygYqWz2G95f5yQ/3SeASC11RLGwf6eTicTRuQFks/MZ1hiceg0K9WnKBtNkevZCXGez7QG6jK7CEUsJkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>
Subject: Re: [cip-dev] [PATCH] kas: Add opt/targz-img.yml
Thread-Topic: [cip-dev] [PATCH] kas: Add opt/targz-img.yml
Thread-Index: AQHXJ1q96qVS5p8720iu/58MQRwoGKqgaMPQ
Date: Fri, 2 Apr 2021 01:02:23 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB29830A818B5945ED03B9F207927A9@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <1671E45E13223112.31642@lists.cip-project.org>
In-Reply-To: <1671E45E13223112.31642@lists.cip-project.org>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e4f47b77-c108-487d-3faa-08d8f572f9c4
x-ms-traffictypediagnostic: OS3PR01MB6519:
x-microsoft-antispam-prvs: <OS3PR01MB65193DC06E754888AE1CCB96927A9@OS3PR01MB6519.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KtHxkO+ZYOFv3HtOL+UUHzmxW3r+7DU+Ca0m91xCHlykZSGIJg75VRtEQNub9ncFytd6NhZdSwk/FwaG93YIe5iEM34HSxDhJfubLSBB0DeIovZolD8KWcdqhWPocK4RXCR1C+AfrNjIgsjtCn+KnwBfB8/V1RIEIVGsXUHCeCsfqN2j7Beb1XIJ1y+4zrpkeZov9Tpw+RMv85g5IAK8G1ORVVYILJVocHAJ+rifGv0Ani8uOlWus1ASyGUfupga8i04J0PFDmRL/XMAbjbPgWmPJ4T33QTT2KKVCOQBzuZP7dspVM+I3+pST/T8eCDoNGR22jfkkgeJfQcp9lWUjQplnHp7MVJx/kSfXmlRdj476ADBy/pIN5Yp0kuv23rnG5AcaM0H9/5qehaypj4RCsSK1pX8FTn3Tyiu8qqRF33zHgnDMihkXUdWlZ/UiRmpRXOB1UjbNPLTckt5St/aIOMxXYKhTssljDstd9sYxad8WpP9c6tohEcO0Uj9sE4ur5LXbrDvF4HBB0jYlnf3OlbCzyJx9yNcEiosNbwq/PbaCaDSoDh/8dGboMrwuZs78x5A56zDLtWig/zwlxzgi+B3hKVKkgvgkq39reesOX2YTmuf3NmG4aEs4fuhuUSKANy6XsPW+HSxrLQU8IuwqRQbtpYxivDqC+0L9dSTYsk=
x-ms-exchange-antispam-messagedata: =?utf-8?B?OVNsYlBnYm5maFBrV2preTJ3eEdsbisyRHhtaEpkVWNMbUFITlpLQU9VbDdi?=
 =?utf-8?B?dmpkazhBbTYwT1hoRGdKWllPZCtuU1NBZ1locFpoQm5QZW1Pbnp6RFB3M2ln?=
 =?utf-8?B?cHJvMFJLaHlUcnY0SWJMWDRnQ0ExWmN1RUlMdzArOHJqV0NXaVdxZHdzYUU4?=
 =?utf-8?B?VS81aWducnJVUW5lNGZIbGV6bVVjZllaeHF5R21RT216TDR3SGdLdGEzV0xn?=
 =?utf-8?B?ZmNQMThReVB0VGZ0RW5TVG5lRzArQTF3MzNHQ2JxeERDSUVUWGphWTErMDV1?=
 =?utf-8?B?dW9qRmErV2JiOHR3Y2VyRFk0UERTNmVNaWNTR2l1cnFhMGZIby9xemFQK1V5?=
 =?utf-8?B?QW9ndW5vR3E3Q000M0NmQW1KMUxhOG9UNVdNMlJNTithRVMra2hSZmlzR3dN?=
 =?utf-8?B?Um1BSjIwbkZTbVZBNHdNSFhnaG9iZWRlalRrYmM0bElxRUVrcUs1Qzh6ZHc5?=
 =?utf-8?B?ZUpLZVdkc1ZlK0daVDVJWDBxVGpEajlZdTNWOXdoSmdMK2p1dFIzOE1oMHJY?=
 =?utf-8?B?VkVCNmVVWGttUmR2MVRBN2hCY2gyNHVIb2daK0p6bXhvNXljWFVXZGxOK1JP?=
 =?utf-8?B?T3c4Q2tBRW1yMGY1OUZZS3hQdHBuSFVnSTJENmkzVnl3NjE4K3o0cmFuRTlJ?=
 =?utf-8?B?bFlMaG4vVll6a0NuTHJpcU9Tdkk5SE02YUVjODJBV1FWUzhvMzI4NURXRjEw?=
 =?utf-8?B?S0RuYVJWUy92V3lNWVZ3blNEYkg2MzM0SWVUN3Q5Z0xRci9yZXlKVUM0NXV3?=
 =?utf-8?B?NGRMb0luT2UrZHloeFFDSDQwbk9qRUYwZzRUUkVhWFZRcjVsSlFlWHhRMzR4?=
 =?utf-8?B?eEI0NWRNV3R2TllWbC94cXZBVy93dk1sQ25zdi9Yd3ZaYzV4UXA0bkVqYTJM?=
 =?utf-8?B?eUl0dmNqZ3hmV3lRTU1LcUpjbXhtNGxRMzhWeGRUbDNiSnpERzBCbzR6MUFC?=
 =?utf-8?B?azI0Yzk3aEIyRHQwU3l4akl2aXBtNy9qamdGZVhkN2x5NXp5SXAwb3NKWlhW?=
 =?utf-8?B?WEFnVmNyc2Z3M1h3SG5FTzhGVHdSL0ZhMHFIMmxqZTR3N1RFQTlMOCtFYk5n?=
 =?utf-8?B?bWQzb2lMZFJRZ1A1UkFFNEdiN1A3L01XSDJIOHJoZko3Yis1YUtyd3dxU1Rm?=
 =?utf-8?B?aE9hS1dXMkJrdlJzZThvakpYa0VBZW1iWi9JbElRVHZoNGs0M3F1ZGU1c2lY?=
 =?utf-8?B?M01TTllDeUFnSlFnSE40OC9zUEJyZDhjVFk0aTBSdzB4Z09wUHJZTVA4WCtM?=
 =?utf-8?B?OCtlb2IxSy9LZlRDdk0vOG9JSm5Oa0hPb2dlUU1DelFheDMxWC83Sm44WGVG?=
 =?utf-8?B?ZkhYUW9JNXZKcGJVK0VuN2tOMDJ4Nkx5bjl1dU1ocFQyVnNUOWY2Zi9KTzFv?=
 =?utf-8?B?Q0MyZ0EwdE5waGpIemNCTStMM3pWVSt3YThlUmlvOWpmTlBEN0VVUk4vQkRW?=
 =?utf-8?B?WFY1OHBrcWpEU1VzVTg3YTFJMlAwOUp1QldOdWVNOTRsUHE3VDZCaDJtNjRk?=
 =?utf-8?B?Vnp2ZmRyd1VEZ2NNenRtdE1vMFhKK0F5UW5uZ2xFM3ZHKytsU2tuL0IxeUlK?=
 =?utf-8?B?WEpMZXdrcENxNVEwZkZWWkxyTGFUS3krWmhpbThzQ2NoalVaVFJUWWt3clFm?=
 =?utf-8?B?cHFUaTVqbGxTaEcrendKdzNZWWJTYXI1YWNPS2ZOY1k1dTVxSDk5eGVUc2kr?=
 =?utf-8?B?QXpXUWd6eGRjSVUrbUJUK1ZzNGJ6Y01wUzI0cVpIcUMxb0tocGhPRWlCZ052?=
 =?utf-8?Q?VBjel5hYdP/T9IoRgo=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4f47b77-c108-487d-3faa-08d8f572f9c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2021 01:02:23.5491
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q7hg7kV60PkChRUSflHpE99rSTM82UCA5pjRVMoaxzhQLEHmfXxNFWAYK2DALpiC25FmOx1mYksHTrl3eJPYV5ws1zhe4z4CHJQu29oD8qYTG2wOcyCMjG28KGtJS6ye
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6519
MSSCP.TransferMailToMossAgent: 103
X-OriginatorOrg: toshiba.co.jp
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: yQkScANKRcc8mHuCUoZmfnXlx4520388AA=
Content-Type: multipart/mixed; boundary="hsUiNhDSXXS4mVKAKmhj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1617325352;
 bh=xZBrl+SY3LTa48Vcr6NMXhQJHqViWqTrmUPjunOr5a8=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=HlO3P3cW740XEKJaEzaJl1mLWAntVzQ6euyQP5E5wNcP/Rh7XUmmIo8s0lNzKKskVDf
 ci7hrAX7Hkv8nM2yfycgfRbEYC2NSxCCWxsBFmb8wGlXEL+DHhAGOCkaM++ZMf2/KZRW9
 Rqv3WTGl3pmJLNvZCWjTqB0J1mX6vFj3Dys=

--hsUiNhDSXXS4mVKAKmhj
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNClRoaXMgcGF0Y2ggaXMgZm9yIGlzYXItY2lwLWNvcmUuDQoNCkJlc3QgcmVnYXJkcywN
CiAgTm9idWhpcm8NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBjaXAt
ZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZyBbbWFpbHRvOmNpcC1kZXZAbGlzdHMuY2lwLXByb2pl
Y3Qub3JnXSBPbiBCZWhhbGYgT2YgTm9idWhpcm8gSXdhbWF0c3UNCj4gU2VudDogRnJpZGF5LCBB
cHJpbCAyLCAyMDIxIDk6NTQgQU0NCj4gVG86IGphbi5raXN6a2FAc2llbWVucy5jb20NCj4gQ2M6
IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnOyBpd2FtYXRzdSBub2J1aGlybyjlsqnmnb4g
5L+h5rSLIOKWoe+8s++8t++8o+KXr++8oe+8o++8tCkgPG5vYnVoaXJvMS5pd2FtYXRzdUB0b3No
aWJhLmNvLmpwPg0KPiBTdWJqZWN0OiBbY2lwLWRldl0gW1BBVENIXSBrYXM6IEFkZCBvcHQvdGFy
Z3otaW1nLnltbA0KPiANCj4gVGhpcyBwcm92aWRlcyB0aGUgZnVuY3Rpb24gdG8gc3BlY2lmeSAn
dGFyZ3otaW1nJyBmb3IgSU1BR0VfVFlQRS4gVGhpcyBpcw0KPiB1c2VkIHdoZW4gY3JlYXRpbmcg
YSB0YXIuZ3ogaW1hZ2UgdGhhdCBkb2VzIG5vdCBzdXBwb3J0IHdpYy4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IE5vYnVoaXJvIEl3YW1hdHN1IDxub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5q
cD4NCj4gLS0tDQo+ICAuZ2l0bGFiLWNpLnltbCAgICAgICAgfCAgMyArKysNCj4gIGthcy9vcHQv
dGFyZ3otaW1nLnltbCB8IDIwICsrKysrKysrKysrKysrKysrKysrDQo+ICAyIGZpbGVzIGNoYW5n
ZWQsIDIzIGluc2VydGlvbnMoKykNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBrYXMvb3B0L3Rhcmd6
LWltZy55bWwNCj4gDQo+IGRpZmYgLS1naXQgYS8uZ2l0bGFiLWNpLnltbCBiLy5naXRsYWItY2ku
eW1sDQo+IGluZGV4IGQxNGM3MmYuLjg4MDJhZjEgMTAwNjQ0DQo+IC0tLSBhLy5naXRsYWItY2ku
eW1sDQo+ICsrKyBiLy5naXRsYWItY2kueW1sDQo+IEBAIC02LDYgKzYsNyBAQCB2YXJpYWJsZXM6
DQo+ICAgIGV4dGVudGlvbjogYmFzZQ0KPiAgICB1c2VfcnQ6IGVuYWJsZQ0KPiAgICB3aWNfdGFy
Z3o6IGVuYWJsZQ0KPiArICB0YXJnejogZGlzYWJsZQ0KPiAgICBkdGI6IG5vbmUNCj4gICAgZGVw
bG95OiBlbmFibGUNCj4gDQo+IEBAIC0zMCw2ICszMSw3IEBAIGRlZmF1bHQ6DQo+ICAgICAgLSBp
ZiBbICIke3VzZV9ydH0iID0gImVuYWJsZSIgXTsgdGhlbiBiYXNlX3lhbWw9IiR7YmFzZV95YW1s
fTprYXMvb3B0L3J0LnltbCI7IGZpOw0KPiAgICAgIC0gaWYgWyAiJHtleHRlbnRpb259IiAhPSAi
YmFzZSIgXTsgdGhlbiBiYXNlX3lhbWw9IiR7YmFzZV95YW1sfTprYXMvb3B0LyR7ZXh0ZW50aW9u
fS55bWwiOyBmaTsNCj4gICAgICAtIGlmIFsgIiR7d2ljX3Rhcmd6fSIgPSAiZW5hYmxlIiBdOyB0
aGVuIGJhc2VfeWFtbD0iJHtiYXNlX3lhbWx9Omthcy9vcHQvd2ljLXRhcmd6LWltZy55bWwiOyBm
aTsNCj4gKyAgICAtIGlmIFsgIiR7dGFyZ3p9IiA9ICJlbmFibGUiIF07IHRoZW4gYmFzZV95YW1s
PSIke2Jhc2VfeWFtbH06a2FzL29wdC90YXJnei1pbWcueW1sIjsgZmk7DQo+ICAgICAgLSBrYXMg
YnVpbGQgJHtiYXNlX3lhbWx9DQo+ICAgICAgLSBpZiBbICIke2RlcGxveX0iID0gImVuYWJsZSIg
XTsgdGhlbiBzY3JpcHRzL2RlcGxveS1jaXAtY29yZS5zaCAke3JlbGVhc2V9ICR7dGFyZ2V0fSAk
e2V4dGVudGlvbn0gJHtkdGJ9OyBmaQ0KPiANCj4gQEAgLTY5LDYgKzcxLDcgQEAgYnVpbGQ6cWVt
dS1hbWQ2NC1iYXNlOg0KPiAgICAgIGV4dGVudGlvbjogc2VjdXJpdHkNCj4gICAgICB1c2VfcnQ6
IGRpc2FibGUNCj4gICAgICB3aWNfdGFyZ3o6IGRpc2FibGUNCj4gKyAgICB0YXJnejogZW5hYmxl
DQo+ICAgICAgZGVwbG95OiBkaXNhYmxlDQo+IA0KPiAgIyB0ZXN0DQo+IGRpZmYgLS1naXQgYS9r
YXMvb3B0L3Rhcmd6LWltZy55bWwgYi9rYXMvb3B0L3Rhcmd6LWltZy55bWwNCj4gbmV3IGZpbGUg
bW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMC4uNDNjNTQ1ZQ0KPiAtLS0gL2Rldi9udWxsDQo+
ICsrKyBiL2thcy9vcHQvdGFyZ3otaW1nLnltbA0KPiBAQCAtMCwwICsxLDIwIEBADQo+ICsjDQo+
ICsjIENJUCBDb3JlLCBnZW5lcmljIHByb2ZpbGUNCj4gKyMNCj4gKyMgQ29weXJpZ2h0IChjKSBT
aWVtZW5zIEFHLCAyMDE5DQo+ICsjDQo+ICsjIEF1dGhvcnM6DQo+ICsjICBRdWlyaW4gR3lsc3Rv
cmZmIDxxdWlyaW4uZ3lsc3RvcmZmQHNpZW1lbnMuY29tPg0KPiArIw0KPiArIyBTUERYLUxpY2Vu
c2UtSWRlbnRpZmllcjogTUlUDQo+ICsjDQo+ICsNCj4gK2hlYWRlcjoNCj4gKyAgdmVyc2lvbjog
MTANCj4gKw0KPiArIyBsYXZhIHVzZXMgbmZzIHRvIGRlcGxveSB0aGUgaW1hZ2UuIEZvciB0aGlz
IHdlIG5lZWQgYSB0YXJiYWxsIGluc3RlYWQgb2YNCj4gKyMgZnVsbCBpbWFnZQ0KPiArDQo+ICts
b2NhbF9jb25mX2hlYWRlcjoNCj4gKyAgaW1hZ2UtdHlwZTogfA0KPiArICAgIElNQUdFX1RZUEUg
PSAidGFyZ3otaW1nIg0KPiAtLQ0KPiAyLjMwLjAucmMyDQoNCg==

--hsUiNhDSXXS4mVKAKmhj
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6340): https://lists.cip-project.org/g/cip-dev/message=
/6340
Mute This Topic: https://lists.cip-project.org/mt/81792957/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--hsUiNhDSXXS4mVKAKmhj--
