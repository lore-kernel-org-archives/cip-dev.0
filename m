Return-Path: <SRS0=jeEJ=5Y=lists.cip-project.org=bounce+64572+4567+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E94C2D0EA
	for <cip-dev@archiver.kernel.org>; Wed,  8 Apr 2020 09:24:16 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C174120747
	for <cip-dev@archiver.kernel.org>; Wed,  8 Apr 2020 09:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Z0A/Pl5L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C174120747
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4567+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id QykEYY4521723xSyo40Zlc2U; Wed, 08 Apr 2020 02:24:15 -0700
X-Received: from APC01-SG2-obe.outbound.protection.outlook.com (APC01-SG2-obe.outbound.protection.outlook.com [40.107.131.138])
 by mx.groups.io with SMTP id smtpd.web10.8182.1586337853592601811
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Apr 2020 02:24:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nX9nvGJNfUZS0lgfMnYH4p02iXNmm8RH0ZkOLd4q/Z1l+tohs42sC1wQEQY9qsiQqDmWRbp1g6sx9ze9YVUqw8Nxl6Btmn63qpQBuYJM/meY2YyFVh3vR5q/upeiWUyISUFu1TIyKTG9Ky2pthZSk3UF2AdRZBXsUyt+9txs0+45ECS0AjHGPwa4kZ4vf1i8/51TA8PAMRuP3yS0nIqcsNBpV7fDxEOmlVCWR2kypVSEh+fbE7lnXsf2F8gQMW1XBpvVmJOYx6IaQdzfkEyRvcLxin5Zl/U6bme7EPWn77sGhs5GsEFPQrKk0VDZ2HB8jaN0mGpKNh/U/dFTYSqEjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBYvPPTdZKT//eQGIfCV0sSOAG2La3g2OrVU4ehgLCU=;
 b=O/kPnsk1cRzzy0LF2DPqJr/pfIvDv7bTrFVtyjbfOjeYndaXjBJbrFxTVZjWRjDUmWMXOnGLYAEemk2YRTAXAIUIUZKVx+VEn3iAa2jQo+56gs+2HXLgaNCxaHh8k/8PVn8e7Iq+4fk1B/fuP8p1UyMXBZdHrLwDHjRagrLf3Lrpitm0y+MXaVlVo5kjK4BlLOSa7uvZ3gHfpGGRC1HimN255anIHaVy7D7tOUqfs7Iwmp1x4SxNZBdt1dL8ALKbmEo91iuY9SJj0n0Mpry3bLKzXra9y6Dp8wZGnAsRRLpEhpKuvAWuGlA3g1qQC7af1D7LefZOf58Pb18bVxy2Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (20.179.172.148) by
 TY2PR01MB3033.jpnprd01.prod.outlook.com (20.177.99.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.19; Wed, 8 Apr 2020 09:24:05 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::e845:c7d4:4f:c3cc]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::e845:c7d4:4f:c3cc%7]) with mapi id 15.20.2878.021; Wed, 8 Apr 2020
 09:24:05 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-security@lists.cip-project.org>, <pavel@denx.de>,
	<jan.kiszka@siemens.com>
CC: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-security] [cip-dev] Python 3.x vs 2.7
Thread-Topic: [cip-security] [cip-dev] Python 3.x vs 2.7
Thread-Index: AdYI0Y7wF02Ds+P+SQqCBlZlaiG5IABL904AAH62CgAAGFYHgAAR8NGQADgryrA=
Date: Wed, 8 Apr 2020 09:24:05 +0000
Message-ID: 
 <TY2PR01MB4972F1FB23E46E7D2DA46482A0C00@TY2PR01MB4972.jpnprd01.prod.outlook.com>
References: 
 <TYAPR01MB2399241EB327E673BD6F48EFDFC60@TYAPR01MB2399.jpnprd01.prod.outlook.com>
 <20200403214708.GA32080@duo.ucw.cz>
 <8d490687-c9fb-239e-5d01-55fec493168f@siemens.com>
 <20200406215205.GA14162@amd.ucw.cz>
 <TYAPR01MB2399CAF8B56C489427E7A791DFC30@TYAPR01MB2399.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYAPR01MB2399CAF8B56C489427E7A791DFC30@TYAPR01MB2399.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 38bb4290-e6c2-4446-a082-08d7db9e9558
x-ms-traffictypediagnostic: TY2PR01MB3033:
x-microsoft-antispam-prvs: 
 <TY2PR01MB303377BEFFC05766DEA61204A0C00@TY2PR01MB3033.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
received-spf: None (protection.outlook.com: cybertrust.co.jp does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 Hd5W1C16bKJpp/c6/91jh0EgLOV+TA07n60nSY1/n+CSBDbtycN8+Kp1Jm3SLFHBdMb6vyDfw/yDlPNnQTAs4EBT6nPJRLrMeC8GVWcErkjvlah4XphjKYK/YZILFEJTWmmTnXlPfCU5vgHc6JWjIMxT7clNlMDK2HsT80ugVR1y3/6JgzTTYUPvX7rsQm+6X+hM+LRnTEs/wjommXTmrByQhzYf+JwufB1wnqr8UXeuqrKfrtmCvG57rL8oE1YJIeGR6sNsThVdmhcatjG5IchNyz+hVzWRx1Uq6qgdI1xTXHi8QvWaW1nc4ZP2LG7bkeO8kepcS6lJVWlaCZ5cLvExNvv2/mmHsv3ZDj4QYFAjiYUgS1+IM2lWlVZZnytCjcJfhqMwJbQpG/4U2QdI3IU1b5GTC2gfeQA49Tm8ciezUTjBcarAt+rQ0W0nC1TEEc3NKNPeJ94xguA4PO3+HnItvTYGpopGljtCLhHtCyS8pRWqviK5mZKJgGeSyMScLFCkoEPLKNcCRz3LqZ657g==
x-ms-exchange-antispam-messagedata: 
 D7fuztIFhWqqaxkzjiIwMmA/5O5jO+mMCfQAucV3qaeRQQVj+Geh5R8zu7e0y+GYvo5t8vyvvMlKpxsn72r0ZLqLcePgxurZ3LAmda4dv5G/8QigU1rWiWFYZ15MkABfzF/1i7HrdSKAAi6QwjvxCQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 38bb4290-e6c2-4446-a082-08d7db9e9558
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2020 09:24:05.2414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DsgAoamyCfsTzecxM42UlZhzFrR7N/jzJOD1FcLkkNc4x/pEbnUMjj2PjCyZsRgqBNE9ctvy6vzWUaIDgtDahp7dal9CHxnJtIPIAunXvVA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3033
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: VEvm3zODTbsSA9DfjUPeyExEx4520388AA=
Content-Type: multipart/mixed; boundary="aQ8UPz8cQyvHjQvuQZi5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1586337855;
 bh=bHKfoufeMDWoRK22cH73X3nk2qAV0ZddcXbOIWkMFQ8=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=Z0A/Pl5LHf34Xjo19obyX9NzZmmBKSZ2gNkH1UQvOs+t0IvJkMNEu3hLpWOxHm7/+Oc
 1qJswTvMhIQ6hp58ZYb/eJrn6QBW6MBev3zEJoyUVjgAJo6eY/0ZoCd8xgiO5REkAZcjx
 Kf+rCMJb3WfhEnQuyZ5y3sJl16S8om4py0c=

--aQ8UPz8cQyvHjQvuQZi5
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksIA0KDQpUaGUgc2VjdXJpdHkgV0cgbm9taW5hdGVkIGR1cGxpY2l0eSBhcyBhIHNvbHV0aW9u
IGZvciAiQ29udHJvbCBzeXN0ZW0gYmFja3VwIiAoQ1I3LjMpLg0KT25lIG9mIHRoZSBjb21tb24g
cmVxdWlyZW1lbnRzIG9mIHN1Y2ggYmFja3VwIHNvZnR3YXJlIGlzIGNoZWNrLXBvaW50IHJlc3Rh
cnQgY2FwYWJpbGl0eS4NCkR1cGxpY2l0eSBwcm92aWRlcyB0aGlzIGxpa2UgdGhlIGZvbGxvd2lu
Zy4NCmh0dHBzOi8vbGlzdHMubm9uZ251Lm9yZy9hcmNoaXZlL2h0bWwvZHVwbGljaXR5LWFubm91
bmNlLzIwMDktMDYvbXNnMDAwMDAuaHRtbA0KDQpJTUhPLCBJIHRoaW5rIHRhciBpcyBub3QgbWV0
IElFQzYzNDQzLTQtMiByZXF1aXJlbWVudCwgYmVjYXVzZSB0YXIgaXRzZWxmIGRvZXMgbm90IGhh
dmUgdGhpcyBjYXBhYmlsaXR5LA0KDQpCZXN0IHJlZ2FyZHMsDQotLQ0KTS4gS3Vkbw0KDQotLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogY2lwLXNlY3VyaXR5QGxpc3RzLmNpcC1wcm9q
ZWN0Lm9yZyA8Y2lwLXNlY3VyaXR5QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4gT24gQmVoYWxmIE9m
IEtlbnRvIFlvc2hpZGENClNlbnQ6IFR1ZXNkYXksIEFwcmlsIDcsIDIwMjAgMzo0OSBQTQ0KVG86
IFBhdmVsIE1hY2hlayA8cGF2ZWxAZGVueC5kZT47IEphbiBLaXN6a2EgPGphbi5raXN6a2FAc2ll
bWVucy5jb20+DQpDYzogY2lwLXNlY3VyaXR5QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZzsgY2lwLWRl
dkBsaXN0cy5jaXAtcHJvamVjdC5vcmcNClN1YmplY3Q6IFJlOiBbY2lwLXNlY3VyaXR5XSBbY2lw
LWRldl0gUHl0aG9uIDMueCB2cyAyLjcNCg0KSGksDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPkZyb206IFBhdmVsIE1hY2hlayA8cGF2ZWxAZGVueC5kZT4NCj5TZW50OiBUdWVzZGF5
LCBBcHJpbCA3LCAyMDIwIDY6NTIgQU0NCj5UbzogSmFuIEtpc3prYSA8amFuLmtpc3prYUBzaWVt
ZW5zLmNvbT4NCj5DYzogUGF2ZWwgTWFjaGVrIDxwYXZlbEBkZW54LmRlPjsgS2VudG8gWW9zaGlk
YSANCj48a2VudG8ueW9zaGlkYS53ekByZW5lc2FzLmNvbT47IGNpcC1zZWN1cml0eUBsaXN0cy5j
aXAtcHJvamVjdC5vcmc7DQo+Y2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcNCj5TdWJqZWN0
OiBSZTogW2NpcC1kZXZdIFB5dGhvbiAzLnggdnMgMi43DQo+DQo+T24gTW9uIDIwMjAtMDQtMDYg
MTI6MTU6MTYsIEphbiBLaXN6a2Egd3JvdGU6DQo+PiBPbiAwMy4wNC4yMCAyMzo0NywgUGF2ZWwg
TWFjaGVrIHdyb3RlOg0KPj4gPiBIaSENCj4+ID4NCj4+ID4gPg0KPj4gPiA+IEZZSSwgdW5mb3J0
dW5hdGVseSB3ZSBjb3VsZG4ndCBmaW5kIHRoZSBhbHRlcm5hdGl2ZSBwYWNrYWdlIGZvcg0KPnN5
c3RlbSBiYWNrdXAuIFRoZSBkdXBsaWNpdHkgaXMgdGhlIGJlc3QgcGFja2FnZSBmb3IgdXMgZnJv
bSB0aGUgDQo+bGljZW5zZSBhbmQgbnVtIG9mIGRlcGVuZGVuY2llcyBwb2ludCBvZiB2aWV3Lg0K
Pg0KPj4gPiA+IFNlZSB0aGUgZm9sbG93aW5nLg0KPj4gPiA+DQo+PiA+DQo+PiA+ID4gPGR1cGxp
Y2l0eT4NCj4+ID4gPiBFbmNyeXB0aW9uOiBZZXMNCj4+ID4gPiBTY2hlZHVsZSBiYWNrdXA6IE5v
DQo+PiA+ID4gSW5jcmVtZW50YWwgYmFja3VwOiBZZXMNCj4+ID4gPiBMaWNlbnNlOiBHUEwgdjIN
Cj4+ID4gPiBEZXBlbmRlbmNpZXMgY291bnQgKGFwcm94KTogODANCj4+ID4gPiBSZWZlcmVuY2U6
IGh0dHA6Ly9kdXBsaWNpdHkubm9uZ251Lm9yZy9mZWF0dXJlcy5odA0KPj4gPg0KPj4gPiBJJ20g
bm90IHN1cmUgd2hhdCB5b3VyIGV4YWN0IHJlcXVpcmVtZW50cyBhcmUsIGJ1dCBoYXZlIHlvdQ0K
PmNvbnNpZGVyZWQNCj4+ID4gInRhciI/IEl0IHNob3VsZCBiZSBwb3NzaWJsZSB0byBwaXBlIGl0
cyBvdXRwdXQgdG8gYWVzcGlwZSAoYW5kIA0KPj4gPiBwb3NzaWJseSBvdGhlciB0b29scykgdG8g
Z2V0IGVuY3J5cHRpb24sIGFuZCBpdCBzaG91bGQgYmUgYWJsZSB0bw0KPmRvDQo+PiA+IGluY3Jl
bWVudGFsIGJhY2t1cHMuLi4NCj4+DQo+PiBJIHN1cHBvc2UgdGhlcmUgaXMgdGhhdCBjb25jZXJu
IGFib3V0IEdQTHYzIGFnYWluIChhcyB3aXRoIGJyb2FkbHkNCj51c2VkDQo+PiByc3luYykgLSB3
aGljaCBpcyBnZW5lcmFsbHkgb3ZlcnJhdGVkLiBUaGVyZSBleGlzdHMgbGVnYWwgdmlld3MgdGhh
dA0KPmFscmVhZHkNCj4+IEdQTHYyIHJlcXVpcmVzIHRvIGtlZXAgc3VjaCBsaWNlbnNlZCBjb21w
b25lbnRzIHJlcGxhY2VhYmxlIG9uIHRoZQ0KPnRhcmdldC4NCj4+IFdoYXQgdGhlbiBlZmZlY3Rp
dmVseSByZW1haW5zIHdpdGggdjMgaXMgaXRzLCB3ZWxsLCB3b3JkaW5nDQo+Y29tcGxleGl0eS4N
Cj4NCj5Eb2VzICJ0YXIiIG1hdGNoIHRoZSByZXF1aXJlbWVudHM/DQo+DQo+QW5kIEkgYWdyZWUg
dGhhdCBiZXN0IG9wdGlvbiB3b3VsZCBiZSB0byBhY2NlcHQgR1BMdjMuDQo+DQoNClNvbWUgb2Yg
dGhlIHNlY3VyaXR5IG1lbWJlcnMgZGlkbid0IGFjY2VwdCBHUEx2Mywgc28gY3VycmVudGx5IHdl
IGRyb3BwZWQgR1BMdjMgcGFja2FnZXMgZnJvbSB0aGUgY2FuZGlkYXRlcy4NCg0KQlRXLCBJJ20g
bm90IHN1cmUgYnV0IGlzIHRoZSBDSVAgcG9saWN5IG9uIGFjY2VwdGluZyBHUEx2MyBzdGlsbCB0
byBiZSBkZWNpZGVkPw0KDQo+SWYgdGhhdCdzIG91dCBvZiBxdWVzdGlvbiwgSSdtIHByZXR0eSBz
dXJlIHdlIGNhbiBnZXQgR1BMdjIgdGFyIA0KPmltcGxlbWVudGF0aW9uIHNvbWV3aGVyZS4gYnVz
eWJveCBoYXMgaW1wbGVtZW50YXRpb24sIGFuZCBJJ20gcHJldHR5IA0KPnN1cmUgdGhlcmUncyBH
UEx2MiBmb3JrIG9mIGJ1c3lib3guIE9sZCB2ZXJzaW9uIG9mIHRhciBzaG91bGQgYmUgR1BMdjIu
IA0KPlN0aWxsIGJldHRlciB0aGFuIHBvcnRpbmcgZHVwbGljaXR5IHRvIGRpZmZlcmVudCBweXRo
b24gdmVyc2lvbi4uLg0KPg0KDQpUaGFuayB5b3UgZm9yIGludHJvZHVjdGlvbiBhYm91dCAidGFy
Ii4NCkkgd2lsbCBpbnZlc3RpZ2F0ZSB3aGV0aGVyIGl0IG1lZXRzIHRoZSByZXF1aXJlbWVudHMu
DQpBbmQgYWxzbyBJJ2xsIHNlYXJjaCBHUEx2MiBpbXBsZW1lbnRhdGlvbiBpZiBpdCBtZWV0cyB0
aGUgcmVxdWlyZW1lbnRzLg0KSWYgaXQncyBub3QgZGVjaWRlZCB5ZXQgYWJvdXQgdGhlIENJUCBw
b2xpY3kgb24gYWNjZXB0aW5nIEdQTHYzLCB3ZSBjYW5ub3QgYWRvcHQgR1BMdjMgcGFja2FnZXMu
DQoNCkFueXdheSwgSSBhZ3JlZWQgaXQgaXMgZGlmZmljdWx0IHRvIHN1cHBvcnQgcHl0aG9uIDIg
Zm9yIGEgc3VwZXIgbG9uZyB0ZXJtLiBBbmQgZXZlcnlvbmUgYWdyZWVkIG9uIHRoaXMgcG9pbnQu
DQpTbywgd2UgY2Fubm90IHN1cHBvcnQgZWFjaCBsaWJyYXJpZXMgdXNpbmcgcHl0aG9uIDIsIGF0
IGxlYXN0Lg0KDQpCZXN0IHJlZ2FyZHMsIEtlbnQNCg0KPkJlc3QgcmVnYXJkcywNCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
UGF2ZWwNCj4tLQ0KPkRFTlggU29mdHdhcmUgRW5naW5lZXJpbmcgR21iSCwgICAgICBNYW5hZ2lu
ZyBEaXJlY3RvcjogV29sZmdhbmcgRGVuaw0KPkhSQiAxNjUyMzUgTXVuaWNoLCBPZmZpY2U6IEtp
cmNoZW5zdHIuNSwgRC04MjE5NCBHcm9lYmVuemVsbCwgR2VybWFueQ0KDQoNCg0K

--aQ8UPz8cQyvHjQvuQZi5
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4567): https://lists.cip-project.org/g/cip-dev/message=
/4567
Mute This Topic: https://lists.cip-project.org/mt/72870644/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--aQ8UPz8cQyvHjQvuQZi5--
