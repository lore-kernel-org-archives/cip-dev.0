Return-Path: <SRS0=XoQu=JT=lists.cip-project.org=bounce+64572+6384+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891B6C433ED
	for <cip-dev@archiver.kernel.org>; Thu, 22 Apr 2021 08:29:49 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C92C26141C
	for <cip-dev@archiver.kernel.org>; Thu, 22 Apr 2021 08:29:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C92C26141C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6384+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id DwgTYY4521723xJxveSASBe1; Thu, 22 Apr 2021 01:29:47 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web11.9495.1619080185348188271
 for <cip-dev@lists.cip-project.org>;
 Thu, 22 Apr 2021 01:29:47 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 13M8Tgmj011287; Thu, 22 Apr 2021 17:29:43 +0900
X-Iguazu-Qid: 34trSOSPtroAEVOvoM
X-Iguazu-QSIG: v=2; s=0; t=1619080182; q=34trSOSPtroAEVOvoM; m=y1CF/ZvyiJl+XRRgruBhHec1F9niyoEyCQzl62Gv6zY=
X-Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1510) id 13M8TfUA028198
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 22 Apr 2021 17:29:42 +0900
X-Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id D32B6100078
	for <cip-dev@lists.cip-project.org>; Thu, 22 Apr 2021 17:29:41 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 13M8TfuX003050
	for <cip-dev@lists.cip-project.org>; Thu, 22 Apr 2021 17:29:41 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lveWLnrXbBfGBHcwFSeHhjur1ggY9VmTEN8Bkq7YuTR4xsAzDXGB8QcoPLi04NRkcyKZ4p5btuKMtTz5vr65r6KkLwAiBArk3uIlDvwuWcRcg98KvuSKfWNnvn0cJjgypZ7Ijk5FB/o4JlpbjXuSflDVTJc4c/i+BRlZQj1yDfxQKevKajpKboPIpSGTuVgpVIGSz1kngT8uljosQIrq8XIHVRne6aPengWoiiPEFDfmvN9NolETmZk/FCSV31G1d9NqYXZ1MQbsDdS3gCL3oHlawA7CXfd/ATABAiXwhDCbSOKW6mgK1SHwxKawp2jtH/Qv9Ha4SZUrVxjmiWt4xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzlN8Dl+qMnhbl8c6u3C/oq/pB1NeV7ApBR4SQMhrJ4=;
 b=TsQKKfL9FODxCE7zYy8YnskD7CWQKm68a83tgOIiFUuN/6OioIt70+eDTgpZ862rCHWel00JzQvOolHfLEoEWv2QHBuSMxAoyHCtrnd3J2l6kUOTtCe5Fm3myEWU2hJxD+gcKdI2SZgZtAbLPkfQAVmSQpqwHgvZQr5vPNAP8YNhygX7c0kIXrbvN29563M0+ja4tlTohD0D66yZgID5tJOOG0guVcXUTExac7xrIVTMiFn8dZO8JOrQEzj9Weg2OdONQhET1SLiEjIOxAJ2+xdit+j77apXmbNRFtfOq4/tGgL9YAP7V122k83UB3kBt4iCBH2oOmX768oByb1F7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: Adc3GkaN/pizAM5hTwGdytUf7xv80AANr0Uw
Date: Thu, 22 Apr 2021 08:29:38 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2983C420417747F937A4F82D92469@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <TY2PR01MB4972607E584418DD16E09CFCA0469@TY2PR01MB4972.jpnprd01.prod.outlook.com>
In-Reply-To: <TY2PR01MB4972607E584418DD16E09CFCA0469@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 74813717-4cbc-4829-0c6f-08d90568c4ea
x-ms-traffictypediagnostic: OSAPR01MB5171:
x-microsoft-antispam-prvs: <OSAPR01MB5171CCE75A35B5948F4E11CC92469@OSAPR01MB5171.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: og0f9cESVFt8DEAqzvk4YeK5nC/sUoRiszk/4hQq+lm1/KNmznwidLF+BEGy2MyGWCh9lGRtw3XNzX/lAt08sbg0gHAPmjzuEfXh/Yvklz/wEv4apDKdLFrqwZA5KCTneQ8WizevmxsmWQ4BpIjuLWD7fi+rkIKj54JKWzwqLPJX5fEdLT16dr39rS1q49RC7EZGg2egvxpir9OeB3oQ0VSBgd+E5+1DPVekqDgiQITIWzfaAWdXwzHDnpzGNA5jyznWxZEcsJKRvvHQBfUDK8q9KrPlaTjqIoIR0VcI5s1t45nzKTm2dDP75VQdqkxarUN68YKwoiscPse0Z9GRWyjWlvxp9oxx7rz+S21KGLL6c+TJP7DADvczJOsIDm7oHUKOB+y9ltIhAa1RnWHftghASme4MG7XHnHTWHZqVINVm/t8TGfty+BZpvlPAMKzIJbFFaZzaPfrxiwy/6oiUrlKvlDnmV5X4Ku59DIX/O0hdIQOWpYEJSoOBN5xrFDiTwjMzKlMMF/a25vpj/b/Md8HrRD+PlMbWIxJtxpf8/cZlSVogYsijqckUiuH3aI1ZQxRJ4X3mxYivB5GfilUu502NNR3Ee24dXVfBpaBuTR9CG/EfSALJ0F+1ikDVnPCMeqAANJzphnxwdYo2EBSlFVN216coTENKSWZJ005Nd6BB7nTkVTj6LqhAhMRWF7CWP49XBm6XlIJ+tL7GAGDZqkgulQ9UptCtDpf6a/QZ0o=
x-ms-exchange-antispam-messagedata: =?utf-8?B?V2M2cktuS2hBNmFDWEZMcjdGTnVhLzNwZXVhSEtzUndrcmk4YklKZ2E0VlBE?=
 =?utf-8?B?Y0xSejRDUlN6Q1RndjlKei94bTdWZDFPSUxoK0ZOWkM3bE1XbithZ3cyckVn?=
 =?utf-8?B?cEFoOWVPNFFMZ1p4eUxQdjdBRGlIZ0NWL0lKSHZqL3VjRm5GZTl4S1dtc3ZV?=
 =?utf-8?B?UmpJSG5ZV0Y3TDNqcnJya0tKVDRkRjFoaGVSSzhEbURKSlZDdmxKbzQwSmV6?=
 =?utf-8?B?UzdGdFNFMDFtOUJuWk96UCtITFZLNFZBeHNCWS9hWlFGakxGdTlYSXVmS2NC?=
 =?utf-8?B?RUhSNDdUY3pOQ2VSTGxzdmkzL2NFU1NCOHBmWWtkYUYySzF6MEU0aDIzMTlr?=
 =?utf-8?B?NHQwMGNOSDFPeTFkVW1DQlhIUFhlaC9sNmZvRTZZUDA2cUE5SWl2L1A5RG1I?=
 =?utf-8?B?UTVSYi9ra205b3FqMmhNaXh4RXFiamVVeDZwWWhNVEpNK0VjNmdERmFYRWt5?=
 =?utf-8?B?dW9VNFpGUHhOZ29oOE1UMmNkU0hWUWxuRi9tU2E3Q0lWMWlwNkt3SkNIejd6?=
 =?utf-8?B?MEIvN1h6bnVXODdnMFBvbkduMXU5UkR5LzlZSytGUXlDc0VQY3FVL3NyK1dS?=
 =?utf-8?B?anpmcnBjZGZJaUVCNGNuaHVvSW1YVENaUGhOUmk3Y3B3K2RhZGh3MjZnME92?=
 =?utf-8?B?N1lnaHBKQ3lRdFJ5c04wNmlGZWVBSDlmNUVsdytyb1VUN3FZV1FpdnlaUnBZ?=
 =?utf-8?B?MXJxVEFnems0UlJqVFpqZlpkVGlQRkNCdGwyZDNEMGNBazlJY2U1RG5oNi95?=
 =?utf-8?B?WnRTcmFRdjBLaEg1cmRzZ0c4dXcyRENEYlFEWktPSzN2aEw3SkdLRGlEdXdS?=
 =?utf-8?B?clQ5SzRLK3pRaVlPSlh6dXJxM3F6aVFpVEhRUWtNdml4WmEyVFU3Vjg3SmJB?=
 =?utf-8?B?Ny84YllmWUN2a3lKdGEvWWgvZ3NqVzMwdjREeEtZcUhtTE5BQXkwMURTaVpX?=
 =?utf-8?B?RHovcFY5dTdUVzZiRHRtdHBWbmhnekloc0huZ0Y2eC9CQzJTN0w0d1lQcFlu?=
 =?utf-8?B?eUYzM3pKMC9mZURidHJnSUJNZTRKdGplbGlQQXpENktyaWc2czVNcW5heTNR?=
 =?utf-8?B?d3E0dHZucGp6VVVwV1UxT1RaR2YzM0Y4THZCK2hKSmFyRUpSVVRiRFN5bXpJ?=
 =?utf-8?B?ODB6YWM5Y29PL0R5UHZSYWYyZCt2Zkt3enJueExOTTRqdzczVlNRYUc4L3NU?=
 =?utf-8?B?dDlpMUcvMUFrZmJISWFHektVSTIyMHBGWnRqVUx4QWVjTW5QYmhHMlowYkRh?=
 =?utf-8?B?K1U2QVFxaWdqV2NwT2tPWjFCVlVsUlkxV0Ixc3lUUFZSYzRDd3lyTjhkMnJ4?=
 =?utf-8?B?OVVBSGd6S0dmNW5neWo1ZjRmMGtuSHJaUE1icjEwZnZiT3ErRjRNcjZnNGhV?=
 =?utf-8?B?QlRDTWlEMExtMmZ2ZmlESm1SUlpwN0dVbEovSXlCYkFMQkxkTFBVNXhvYkVV?=
 =?utf-8?B?cUtyMnlIMzVhTmxxWDl5WHBQQmlyNWZZQlZTdjZMTUt4cEhPZExuYSs2L3cr?=
 =?utf-8?B?UVZiUEpiOERZdSttSEo4bFlDYmdEZEtmZHRXanB1R2dtUGpyRnlSWk4xQnVm?=
 =?utf-8?B?Zlk1Vmgxa0dIQ084bTByaEhCaHd5Z0lMMXQzdWRIUkV4U0hWNHY2b2hVMGZr?=
 =?utf-8?B?Y1RFMU8zUnlvamVYamxlUjB2dDlDWDhUeHZ4VXNkbTd0RFVzSEpBeDVxODV4?=
 =?utf-8?B?aG96UVBNMFlrVU53TkFnTW42M2o3eUZkU3ZIOXgzNmtmVHRpcmFMbTI1WHZw?=
 =?utf-8?Q?aQDgF15ZgYLzpsqz+I=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74813717-4cbc-4829-0c6f-08d90568c4ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2021 08:29:38.7486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RRprFFwVZDPB59Lp0O7ftcYxFg6Uj8w9ru/My0hwFRBu+Ww++XvXbsZPTjP+xv9UUG+j/9vzLr8HT2VEiqMD53TTs9m27I0O4o0nSTxoL1wdV5AjYx6BBkynaZs0QUUJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB5171
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
X-Gm-Message-State: 5AzMFB6v0gzrDoLk8lhDprqex4520388AA=
Content-Type: multipart/mixed; boundary="A4uyvbecYVhV3jFzfizr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1619080187;
 bh=PvwpcHAbo/NKobXlJHsM2kRdHf0/53fzQ7wrWs2YSBg=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=wZgR2aakhieTNFkSUPlIK30IkMjra0l3BkbiNcsEnoLccUKjU9UrAnZUX54JpIKvBkp
 +0fB8dQberwgnQFF1QuWju+RPvzRKhfNx5FNTd9f0QwJj/suM53Iilv3uKunLGWRxSC8U
 Z7QzeIeUI/spznvMOk0arKMz6DEzaFpUFWw=

--A4uyvbecYVhV3jFzfizr
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCkkgbWF5IG5vdCBiZSBhYmxlIHRvIGF0dGVuZCBiZWNhdXNlIEkgYW0gaW4gY29uZmxp
Y3Qgd2l0aCBvdGhlcnMuIEkgYWRkIHRoZSB1cGRhdGVzIGJlbG93Lg0KDQo+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnIFtt
YWlsdG86Y2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmddIE9uIEJlaGFsZiBPZg0KPiBtYXNh
c2hpLmt1ZG9AY3liZXJ0cnVzdC5jby5qcA0KPiBTZW50OiBUaHVyc2RheSwgQXByaWwgMjIsIDIw
MjEgMTE6MDAgQU0NCj4gVG86IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnDQo+IFN1Ympl
Y3Q6IFtjaXAtZGV2XSBDSVAgSVJDIHdlZWtseSBtZWV0aW5nIHRvZGF5DQo+IA0KPiBIaSBhbGws
DQo+IA0KPiBLaW5kbHkgYmUgcmVtaW5kZWQgdG8gYXR0ZW5kIHRoZSB3ZWVrbHkgbWVldGluZyB0
aHJvdWdoIElSQyB0byBkaXNjdXNzIHRlY2huaWNhbCB0b3BpY3Mgd2l0aCBDSVAga2VybmVsIHRv
ZGF5Lg0KPiANCj4gKlBsZWFzZSBub3RlIHRoYXQgdGhlIElSQyBtZWV0aW5nIHdhcyByZXNjaGVk
dWxlZCB0byBVVEMgKEdNVCkgMDk6MDAgc3RhcnRpbmcgZnJvbSB0aGUgZmlyc3Qgd2VlayBvZiBB
cHIuIGFjY29yZGluZw0KPiB0byBUU0MgbWVldGluZyoNCj4gaHR0cHM6Ly93d3cudGltZWFuZGRh
dGUuY29tL3dvcmxkY2xvY2svbWVldGluZ2RldGFpbHMuaHRtbD95ZWFyPTIwMjEmbW9udGg9NCZk
YXk9MjImaG91cj05Jm1pbj0wJnNlYz0wJnAxPTIyNCZwMj0NCj4gMTc5JnAzPTEzNiZwND0zNyZw
NT0yNDEmcDY9MjQ4DQo+IA0KPiBVU1dlc3QJVVNFYXN0CVVLCURFCVRXCUpQDQo+IDAyOjAwCTA1
OjAwCTEwOjAwCTExOjAwCTE3OjAwCTE4OjAwDQo+IA0KPiBDaGFubmVsOg0KPiAqIGlyYzpjaGF0
LmZyZWVub2RlLm5ldDo2NjY3L2NpcA0KPiANCj4gTGFzdCBtZWV0aW5nIG1pbnV0ZXM6DQo+IGh0
dHBzOi8vaXJjbG9ncy5iYXNlcm9jay5vcmcvbWVldGluZ3MvY2lwLzIwMjEvMDQvY2lwLjIwMjEt
MDQtMTUtMDkuMDAubG9nLmh0bWwNCj4gDQo+ICogQWN0aW9uIGl0ZW0NCj4gICAxLiBDb21iaW5l
IHJvb3QgZmlsZXN5c3RlbSB3aXRoIGtzZWxmdGVzdCBiaW5hcnkgLSBpd2FtYXRzdQ0KDQpJdCBp
cyBwcm9ncmVzc2luZyBsaXR0bGUgYnkgbGl0dGxlLiBUaGlzIGlzIGRpc2N1c3NlZCBvbiBNTCBh
bmQgZ2l0bGFiLg0KU2ltcGxlIG9wZXJhdGlvbiBoYXMgYmVlbiB0ZXN0ZWQgYW5kIEkgaGF2ZSBj
b25maXJtZWQgdGhhdCBpdCB3b3JrcyB3aXRoIFFFTVUuDQoNCj4gICAyLiBEbyBzb21lIGV4cGVy
aW1lbnQgdG8gbG93ZXIgYnVyZGVucyBvbiBDSSAtIHBhdGVyc29uYw0KPiAgIDMuIE1vbml0b3Ig
dGhlIHN0YXR1cyBvZiBDVkUtMjAyMS0zNDQ0IGFuZCBDVkUtMjAyMS0yMDI5MiAoMy8yNSkgLSBL
ZXJuZWwgVGVhbQ0KPiAgIDQuIE1vbml0b3IgdGhlIHN0YXR1cyBvZiBDVkUtMjAyMS0yOTY1MCAo
NC8xKSAtIEtlcm5lbCBUZWFtDQo+ICAgNS4gVXBkYXRlIFRlc3RpbmcgdGFibGUgYmVsb3cgd2l0
aCA1LjEwIGluZm8gLSBwYXRlcnNvbmMNCj4gICAgICAgaHR0cHM6Ly93aWtpLmxpbnV4Zm91bmRh
dGlvbi5vcmcvY2l2aWxpbmZyYXN0cnVjdHVyZXBsYXRmb3JtL2NpcHRlc3RpbmcvY2VudGFsaXNl
ZHRlc3RpbmcvY2lvdmVydmlldw0KPiANCj4gKiBLZXJuZWwgbWFpbnRlbmFuY2UgdXBkYXRlcw0K
DQpJIHJldmlld2VkIDQuOS4yNjcgYW5kIAk1LjEwLjMyLg0KDQo+ICogS2VybmVsIHRlc3RpbmcN
Cj4gKiBDSVAgU2VjdXJpdHkNCj4gKiBBT0INCj4gICAxLiBOZXh0IElSQyBtZWV0aW5nDQo+IA0K
PiBUaGUgbWVldGluZyB3aWxsIHRha2UgMzAgbWluLCBhbHRob3VnaCBpdCBjYW4gYmUgZXh0ZW5k
ZWQgdG8gYW4gaG91ciBpZiBpdCBtYWtlcyBzZW5zZSBhbmQgdGhvc2UgaW52b2x2ZWQgaW4gdGhl
IHRvcGljcw0KPiBjYW4gc3RheS4gT3RoZXJ3aXNlLCB0aGUgdG9waWMgd2lsbCBiZSB0YWtlbiBv
ZmZsaW5lIG9yIGluIHRoZSBuZXh0IG1lZXRpbmcuDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQoNCkJl
c3QgcmVnYXJkcywNCiAgTm9idWhpcm8NCg0K

--A4uyvbecYVhV3jFzfizr
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6384): https://lists.cip-project.org/g/cip-dev/message=
/6384
Mute This Topic: https://lists.cip-project.org/mt/82277082/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--A4uyvbecYVhV3jFzfizr--
