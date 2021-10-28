Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEDF7C433F5
	for <webhook@archiver.kernel.org>; Thu, 28 Oct 2021 06:13:55 +0000 (UTC)
Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web08.7719.1635401633787856497
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Oct 2021 23:13:54 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 194.138.37.40, mailfrom: jan.kiszka@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 19S6Dplt030104
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Oct 2021 08:13:51 +0200
Received: from [167.87.0.189] ([167.87.0.189])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 19S6DoHS015454;
	Thu, 28 Oct 2021 08:13:50 +0200
Subject: Re: [isar-cip-core][PATCH 0/2] kas update and menu support
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
        cip-dev@lists.cip-project.org, venkata <venkata.pyla@toshiba-tsip.com>
References: <cover.1634924446.git.jan.kiszka@siemens.com>
 <149e6d13-9472-8a5a-ca37-b16416a9fd6f@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <a8b2ad8e-d7b7-744b-37e4-7f2ca63ca42d@siemens.com>
Date: Thu, 28 Oct 2021 08:13:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <149e6d13-9472-8a5a-ca37-b16416a9fd6f@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: base64
X-MIME-Autoconverted: from 8bit to base64 by gecko.sbs.de id 19S6Dplt030104
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 28 Oct 2021 06:13:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6843

T24gMjYuMTAuMjEgMTA6MjEsIEd5bHN0b3JmZiBRdWlyaW4gd3JvdGU6DQo+IEhpLA0KPiAN
Cj4gT24gMTAvMjIvMjEgNzo0MCBQTSwgSmFuIEtpc3prYSB3cm90ZToNCj4+IFdpdGgga2Fz
IDIuNiBiZWluZyByZWxlYXNlZCwgdGhpcyBub3cgYWxsb3dzIHRvIGFkb3B0IHRoZSBuZXcg
Im1lbnUiDQo+PiBmZWF0dXJlIGFuZCBtYWtlIHRoZSB2YXJpb3VzIGltYWdlIGZsYXZvcnMg
YW5kIG9wdGlvbnMgbW9yZSBhY2Nlc3NpYmxlLg0KPj4NCj4+IFF1aXJpbiwgcGxlYXNlIGhh
dmUgYSBsb29rIGlmIEkgbW9kZWxlZCB0aGUgZGVwZW5kZW5jaWVzIGZvciBzZWN1cmUgYm9v
dA0KPj4gYW5kIFNXVXBkYXRlIGNvcnJlY3RseSwgZXhwb3NlZCByZWFzb25hYmxlIGNvbWJp
bmF0aW9ucyBhbmQgZGlkbid0DQo+PiBmb3JnZXQgc29tZXRoaW5nIHVzZWZ1bC4NCj4gDQo+
IEkgY2hlY2sgaXQgYW5kIGFsbCBvcHRpb24gYXJlIHRoZXJlLg0KPiANCg0KVGhhbmtzIGZv
ciBjaGVja2luZywgUXVpcmluLg0KDQpJdCBsb29rcyBsaWtlIHdlIHN0aWxsIGhhdmUgc29t
ZSBpc3N1ZXMgYXJvdW5kIHRoZSBzZWN1cml0eSBpbWFnZS4gRm9yDQp3aGljaCBEZWJpYW4g
cmVsZWFzZXMgaXMgdGhpcyBzdXBwb3J0ZWQsIFZlbmthdGE/DQoNCkphbg0KDQo+IFF1aXJp
bg0KPiANCj4+DQo+PiBAYWxsOiBQbGVhc2UgcGxheSBhIGJpdCB3aXRoIHRoZSBvcHRpb25z
IGFuZCBjaGVjayBpZiB5b3UgZmluZCBhbnl0aGluZw0KPj4gdGhhdCBkb2VzIG5vdCB3b3Jr
IChjcm93ZC1zb3VyY2VkIHJhbmRjb25maWcuLi4pLg0KPj4NCj4+IFRoYW5rcywNCj4+IEph
bg0KPj4NCj4+IEphbiBLaXN6a2EgKDIpOg0KPj4gwqDCoCBVcGRhdGUgdG8ga2FzIDIuNg0K
Pj4gwqDCoCBBZGQga2NvbmZpZyBtZW51DQo+Pg0KPj4gwqAgLmdpdGxhYi1jaS55bWzCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAyICstDQo+
PiDCoCBLY29uZmlnwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB8IDE0NiArKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+
IMKgIFJFQURNRS5tZMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB8wqAgMzkgKysrKy0tLQ0KPj4gwqAga2FzL29wdC9lYmctc2VjdXJl
LWJvb3QtYmFzZS55bWzCoMKgwqDCoCB8wqDCoCAyICstDQo+PiDCoCBrYXMvb3B0L2ViZy1z
ZWN1cmUtYm9vdC1zbmFrZW9pbC55bWwgfMKgwqAgMiArLQ0KPj4gwqAga2FzL29wdC9lYmct
c25ha2VvaWwtc3d1LnltbMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgNCArLQ0KPj4gwqAga2Fz
L29wdC9lYmctc3d1LnltbMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKg
wqAgNCArLQ0KPj4gwqAgNyBmaWxlcyBjaGFuZ2VkLCAxNzcgaW5zZXJ0aW9ucygrKSwgMjIg
ZGVsZXRpb25zKC0pDQo+PiDCoCBjcmVhdGUgbW9kZSAxMDA2NDQgS2NvbmZpZw0KPj4NCj4g
DQo+IA0KPiANCj4gDQo+IA0KDQoNCi0tIA0KU2llbWVucyBBRywgVCBSREEgSU9UDQpDb3Jw
b3JhdGUgQ29tcGV0ZW5jZSBDZW50ZXIgRW1iZWRkZWQgTGludXgNCg==

