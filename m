Return-Path: <SRS0=nbiu=BG=lists.cip-project.org=bounce+64572+5025+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E20C433EA
	for <cip-dev@archiver.kernel.org>; Mon, 27 Jul 2020 12:41:57 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C3752072E
	for <cip-dev@archiver.kernel.org>; Mon, 27 Jul 2020 12:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="KKQuTaTA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C3752072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5025+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id A5kTYY4521723xK9RQ6rji8E; Mon, 27 Jul 2020 05:41:56 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web10.54597.1595853713259878092
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Jul 2020 05:41:55 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 06RCfpfG008008; Mon, 27 Jul 2020 21:41:51 +0900
X-Iguazu-Qid: 34trpDa8NkraPUe3jF
X-Iguazu-QSIG: v=2; s=0; t=1595853711; q=34trpDa8NkraPUe3jF; m=GqPXzMNdzp4fdvV31xJXddZc79KCzyYMr/+RZIUCaAk=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1512) id 06RCfokp012136;
	Mon, 27 Jul 2020 21:41:51 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 06RCfoUs012144
	for <cip-dev@lists.cip-project.org>; Mon, 27 Jul 2020 21:41:50 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 06RCfoH6030626
	for <cip-dev@lists.cip-project.org>; Mon, 27 Jul 2020 21:41:50 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AD793ZGVeyxe14an0FI99UzVmW3ccToEy1IWBH3V9+8BLVeLbO3a86WUNmfMG/9TR5lC0/8Kx2jI2TrA4Enuh6ESbO7tipvvMCs0nGgDSVR9R3rg6tyI5SV9xenNdh++p5q/9i1ALscCm1Awx41uZxZ6FOtjkHhHIUAB7I8IHkZYUA+urbYAFyZ8bgOnZieJIFDhb8syP3LHP+VGY9OuQJN9Pevx1Pi8eSi/5/noPA6tfofVeJiczvnt9BNdpVTWiR0NtXhd+AFTw9x23k8UGkHX+qb4GTvLXTPO8erIR4JT2aJo+bQT+0g1Sh3q1u4X5+gL16iDEB/pJnCxTS3t/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wE9B20JeJllxF1dyXrlBZdiZ4Z061DP71fePkFI3fMA=;
 b=W57aVGZvcqIEObkIs5foeNp6kqh3tCYyXP2Q8dgaylNiigmfpo0QOacgzMLOdoBXfpuIcUvP++Xud1BPs+QofRUFE5+VqK0KJwQELpomLydXz9u7i62yt5O1pgToYnHp7yXH0ZIQoNBGLh9o95gw1ladGqWbs1T+skJYjxK7GF8pmeVx7Z5vLPtXjcsP2Trex2G3Nj3eV2ZOhkztTwquE4eGsbmR00BFP2J5kkW0kDHZKvcFnogfqz8GQp7WGGYqDhBiLWm9hofwt29YZggwqDFZY9PpBxU2l+x8m833GMzWYC1d/gqR8MGnI09yGxHRYFKsrNCfGX2QWJaK4392ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Daniel Sangorrin" <daniel.sangorrin@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] The security of NTP
Thread-Topic: [cip-dev] The security of NTP
Thread-Index: AdZjtVn+GEKdZ28XRvayTupQL0QETAAVEF8AAAG2C0A=
Date: Mon, 27 Jul 2020 12:41:48 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB20538C134703474587A50658D0720@OSBPR01MB2053.jpnprd01.prod.outlook.com>
References: <OSBPR01MB2053682B08257AC2230531FDD0720@OSBPR01MB2053.jpnprd01.prod.outlook.com>
 <7438.1595849548430257093@lists.cip-project.org>
In-Reply-To: <7438.1595849548430257093@lists.cip-project.org>
Accept-Language: en-US
x-originating-ip: [126.194.221.15]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e0f368a-f23a-4a78-b956-08d8322a6e14
x-ms-traffictypediagnostic: OSBPR01MB3126:
x-microsoft-antispam-prvs: <OSBPR01MB312691D16869A82372614244D0720@OSBPR01MB3126.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wfVUNFQgWZoI0UCHDs9iSFgxdXLRNU1c0S3FZ9u1kpt1KD8ZZzPSwmOxxDUGM566BJSvfzWeMNiCUOZWN3Dr80UwODeKvcnvZk4BkWXvRzzJyhMdhB9IQls8uDE1/xuF5eCXMcKunAtpGgEM6bSA6+VqWj0htPS8/gY3SWyEIjT7jqVSvFztJefIUVr+6QzibOddUDyjDAI/zMM3B+VYcPl2DzUaLXsaXXW3qe6+iSJzWe22ZCb/E7EtqrmfKm+3nKty8umhv4soxidMVMdmzGpDJLLrxmCQ4pxsssbn4JMiskSajzJR2EKaVpqpZYDta/nTogIIE2dR0vbD2Kl7GBTTzdwCq/mU0rh7AfSXUBn+zc/7F+anuieuBLMO5MgK0i+699B60tTdPTTCuF17XC3pXIUIhbA4CGCk2eZk8y6xjzW/pK8VDJ3BJfPE59NsAvkgJgiV9F+sJLd4cSPNJw==
x-ms-exchange-antispam-messagedata: YyJrR43bU+iRplr4oW4e2/b7dgAOiXqHBwwV89AjBNKoRNQ0PXMSesdzRA9O7tEr19FuHrjCaRU/bSw8ZLMPkHwooOtKXsFd4zOZRwEos6q4xPZRjUaon8X1FZzml4IXDMLW+vfOdDkENC0ux70itZu2Ik6gOuGAVix7maob3lCsEoJyhC3ywgw+FX6WFBO/0Dr1pfjKRDVfFeo6mGtOZ90zu/8vbUM+7+RyZHOCH46COC54uXOxKTSgw8/EffkbWJMMQF079JU4UMl2MGFGg3YGDt19rI7NgKZ1bBinGHNWCkvAlBywyTAv+bGO8kHLZ1OKTW6bXsVrrQoKrwuk2GWnaUtcRhqdiiErFGk1p+7BM8q9OYUS8ALx/K16/UCBedUXegpw21HEDxCiV+4q15wradVEP/D9DhzgZZnyky9dAiJmg/v83cYm066iWggI0C0Tl4eUc2qfrx69co8Wc5Kkso78m/MGBYrZFIeS0cel2Ts0ryuJLrSF0eUWamYh
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2053.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e0f368a-f23a-4a78-b956-08d8322a6e14
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2020 12:41:48.8882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AtzgiribGMrpAsRhFSsjm7kXm1+Qd7gWbrJB6SJjw2IVNSc6EROzxZGPdTXswlWcItEiFXE5OmU9fBO8Gb2EZP0OiX+rcef+2sOeQR36W4g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3126
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Rsz4RLnskM4A5AzaA3jVHjaSx4520388AA=
Content-Type: multipart/mixed; boundary="nh0YzBBEEcZiltgng6XO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595853716;
 bh=P8H884JdcRS5IJ+nBJVnkuHR8JkWTecG9P/eMpw636A=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=KKQuTaTACIKmPthREJZIu+oHR7ixcFZ4tMGD4PVovaf+b5SfEooTXwAbMshtUIU7XTR
 syQCTZucoDCl7+UxfNTgdAcZL/aNrUXY5ZzNAqBR3I/q+Topxi2Mli+eYvwyKYhPmxqi/
 2KCjkgwkRXUouW1U4hT3WMnCLeyuOirDvHM=

--nh0YzBBEEcZiltgng6XO
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGNpcC1kZXZAbGlzdHMuY2lw
LXByb2plY3Qub3JnIDxjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4gT24gQmVoYWxmIE9m
IE1vaGFtbWVkIEJpbGxvbw0KPiBTZW50OiBNb25kYXksIEp1bHkgMjcsIDIwMjAgODozMiBQTQ0K
PiBEYW5pZWwsIFBhdmVsOg0KPiANCj4gVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suIElzIHRsc2Rh
dGUgYSBiZXR0ZXIgYWx0ZXJuYXRpdmUgKGh0dHBzOi8vZ2l0aHViLmNvbS9pb2Vycm9yL3Rsc2Rh
dGUvKT8gVGhlIG9ubHkgY2F2ZWF0IGlmIHVzaW5nIHRsc2RhdGUgKG9yIGFueSBzb3J0IG9mDQo+
IHRpbWUgbWVjaGFuaXNtIHRoYXQgcmVsaWVzIG9uIGEgIndlbGwta25vd24iIHNlcnZlcikgaXMg
dGhhdCBhbiBJbnRlcm5ldCBjb25uZWN0aW9uIGlzIG5lY2Vzc2FyeS4gSXQgaXNuJ3Qgb2J2aW91
cyB0byBtZSB3aGV0aGVyIHRoaXMgaXMNCj4gYWNjZXB0YWJsZSBvciBub3QuIENhbiBzb21lb25l
IGNoaW1lIGluPw0KDQpJdCBzZWVtcyB0aGF0IHRoYXQgcHJvamVjdCBpcyBkZWFkLCBidXQgdGhl
cmUgaXMgYSBmb3JrIGZvciBDaHJvbWl1bU9TIHJlbWFpbmluZyB0aGF0IHNlZW1zIHRvIGJlIHdl
bGwgbWFpbnRhaW5lZCAoZm9yIENocm9taXVtT1MpDQpodHRwczovL2dpdGh1Yi5jb20vaW9lcnJv
ci90bHNkYXRlL2lzc3Vlcy8xOTkNCmh0dHBzOi8vY2hyb21pdW0uZ29vZ2xlc291cmNlLmNvbS9j
aHJvbWl1bW9zL3RoaXJkX3BhcnR5L3Rsc2RhdGUNCg0KVGhlcmUgYXJlIHNvbWUgcGFja2FnZXMg
aW4gRGViaWFuDQpodHRwczovL3BhY2thZ2VzLmRlYmlhbi5vcmcvc2VhcmNoP2tleXdvcmRzPXRs
c2RhdGUNCmJ1dCBub3QgZm9yIEJ1c3Rlci4NCg0KVGhhbmtzLA0KRGFuaWVsIA0KDQoNCg0KPiAN
Cj4gVGhhbmtzDQo+IC0tDQo+IE1vaGFtbWVkIEJpbGxvbw0KPiBNQUIgTGFicywgTExDDQo+IHd3
dy5tYWItbGFicy5jb20NCg==

--nh0YzBBEEcZiltgng6XO
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5025): https://lists.cip-project.org/g/cip-dev/message=
/5025
Mute This Topic: https://lists.cip-project.org/mt/75814887/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--nh0YzBBEEcZiltgng6XO--
