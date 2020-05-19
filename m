Return-Path: <SRS0=0saf=7B=lists.cip-project.org=bounce+64572+4632+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2377C433E0
	for <cip-dev@archiver.kernel.org>; Tue, 19 May 2020 03:11:56 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D35B20758
	for <cip-dev@archiver.kernel.org>; Tue, 19 May 2020 03:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="YjC/2g1W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D35B20758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4632+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id YXl2YY4521723xnGcqPbQ4IY; Mon, 18 May 2020 20:11:55 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web12.5652.1589857912962898152
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 May 2020 20:11:54 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 04J3Bof3001284; Tue, 19 May 2020 12:11:50 +0900
X-Iguazu-Qid: 2wHHmtTgmCCyIzXMsF
X-Iguazu-QSIG: v=2; s=0; t=1589857909; q=2wHHmtTgmCCyIzXMsF; m=94mjNHwz11XwdrvuO6MwuHwTnPjz7d74MpzweID/Jc4=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1111) id 04J3BmP0017670;
	Tue, 19 May 2020 12:11:49 +0900
X-Received: from enc01.localdomain ([106.186.93.100])
	by imx2.toshiba.co.jp  with ESMTP id 04J3Bm3s014141;
	Tue, 19 May 2020 12:11:48 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.localdomain  with ESMTP id 04J3BmUI008099;
	Tue, 19 May 2020 12:11:48 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aOAJByia5zcGE7U8vXow3+G4ytrdCU3AV3391hyKdKwopO11MMPU5bSVKe/NzcVNgQsH79edbQazSztfi0e0QGDOzMTnS6y+kYpagjSbnhl+hPgiOucp+zzqTWejV7gMip2VZ1rFj+T1PPS1loTINp6fYhrUBC7f3zN2hsOjtFx1vnJr+bdytJw9v4xBbmzg3jRl2It4NvB7Nuh9uq9ulFIKXw8Oo/tgXiejJv+lMwObI/pHZuoc6YNPApSMBzTUyvvbp559o9AWN+vKXObLHqNUKmvfoLmK9ROowaOpAyYWSNvkocaVpQ46qhDtArh19NPLZ2JOiwsM2Sh2E2RIRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Lb/srb0imBh4NyhzedU4yt5RkPTBjsK/xEbyBTh/TE=;
 b=dZ/40T78mrB+V6N7OkzKDZS80DC2SO9VsIgZ99EEgwBNKGi3pLik99k8dciZBPcw5XhDwc6mqgAxOVbj8ujfoZ4+lJx3ATsATqhISnw97fUrRLN5lx2bCuDvlN8b02G2Rt6Q2yOj25f35z1hVmn3+pe8ZJqP7m0h4L5q8RZToxe+UejaQXrJXqfbQ5S3qSOZbnfaipI9hoZMZx1AYNm1KAaRCKeFmaq9f4vto9LMgWVGYjILTVPc+5csG12QnLmnwmLL8dHQkWhBl2wWNNSvSIm/hJ4OyKyUbS0SMbxDVV+hQ1a5kC2IeALeyfIcuKQrvCQlaaqzeOfUoDupaMgOGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Daniel Sangorrin" <daniel.sangorrin@toshiba.co.jp>
To: <dinesh.kumar@toshiba-tsip.com>, <jan.kiszka@siemens.com>
CC: <cip-dev@lists.cip-project.org>
Subject: [cip-dev][isar-cip-core] version management
Thread-Topic: [cip-dev][isar-cip-core] version management
Thread-Index: AdYthqu0kcefdkDOSNuvyCjETy2KPA==
Date: Tue, 19 May 2020 03:11:46 +0000
X-TSB-HOP: ON
Message-ID: <TYAPR01MB2064041238490898AD56BF62D0B90@TYAPR01MB2064.jpnprd01.prod.outlook.com>
Accept-Language: en-US
x-originating-ip: [103.91.184.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9188b9a4-9feb-4936-5263-08d7fba25d7d
x-ms-traffictypediagnostic: TYAPR01MB5133:
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr
x-microsoft-antispam-prvs: <TYAPR01MB5133E04EC22EE39390044BCAD0B90@TYAPR01MB5133.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XdexFcqwVvvplrJOgQ/de9gXDAUATdZE0Mheke1GucQkyw16FhQeMMUtiLh4nSJd79wiX3JQhhb+1AUxnY0dK31riLVBnbD32juDpV6G0KVfiEjFfru/K1fj9WLcbSh7okvnn86z8KFeSe4Or53BHajTAgwFUosbNv3AvQQdhCnQdnxc1+Ly+11yU0O6m6f5AftSo52G7zynV7/e06rW2K0y0Vf7d6raqGNe/euiK7tNSZTNxwTdow9HKMXGdp/WhXQIJ4mGk4VTfvBO7tp27KDUDBxAy5gcXeZmrWdYVDftOzDpptWdUtLH06BDppLXTc74y54mwhjlk+saqMs3XH+qKQVVZqh08ZrVF9cNcF8hzrFfsaxvvBNpTaSI02OGIe4xhTA4ChDgX/U7DjiX6+5dK8DYwoTgKyZIIMD8jc5u2Fg8bsnjTUBJInHYW/jL
x-ms-exchange-antispam-messagedata: 6B2aRy+CpTVvQuVLwFHMqH/EBWAO0ncHSG23BCguY/k/JlnFyjYkbQu8yWAuBU51miBWG96N7uJL/LtX7O8hk57JEgwP4zQMxLpv72MLS6fRTRFJSYo+txw2raQc3Fzu+XqjwKkE2wdRYS/hKFJ39hPJoPzriKpW543/ZQ+lDhb0JF6yDwc+6+HX0aNqQ09sttPU0ZqRT0EzTxXGfQ9tKsw4XZwWpt04zwXyF9lHaGdc23bMjfW4fWTDdiA17jA6X0oUUTSELswXntfNcOpY2kVbRvw2bkCTYFwkTtHZ5jNZJJj+9CRGkOMsZMUebrxWBvuSK13/lYu4OdQm0+bkrCy+APr6NbGqqN/mQ6AETXTHvWOUbWJxthHLdiohN/wVAaTNWKTRLucH90qmz0KBMyyjDXNg/tc09T3HUzk7iqPp0JVoBZNBBiiG42BWdQdGE7NKLjMYoG+sYH4uSlEix0gSkMozWISK1q4X/kLOIdg=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9188b9a4-9feb-4936-5263-08d7fba25d7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2020 03:11:46.6663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SXHw2dXlIHTefQSGMG05aNjOVE8iFZcYontF0/1VCkLgYFxSmKIT7cxeKC9y+r5+n1+PRQSoxxqQ4HpmoSCr+yUFirhu7twTFXgosvTzrb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5133
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: BtdPgf5Gyqeq2tYgj5Tc6zWUx4520388AA=
Content-Type: multipart/mixed; boundary="QcjNwdvsqdoPB90njisP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1589857915;
 bh=dmKxVyQyRPnZg34+Rf7SbzhDCbi+4A3i8aZQgl1omD4=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=YjC/2g1WLOEmIZxfyjnQB5ATEvDM9qvK0M8W0P8zCh5UPd+ii5SS2dNSus7bPITSXyw
 R02g7XHXyJj/KkPuRAU1Q2HHOdtJYsbFReg2U0a9gU8CJLr5fjSe4wzN3jl7McDUSBnMK
 2dJyXsITAiowZimigCpUNhrncoYjw6ZAZhw=

--QcjNwdvsqdoPB90njisP
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGVsbG8gRGluZXNoLCBKYW4sIGFsbA0KDQpEaW5lc2ggcmFpc2VkIGFuIGltcG9ydGFudCBpc3N1
ZSBvbiBhbm90aGVyIHRocmVhZC4gSSBjcmVhdGVkIGEgbmV3IHRocmVhZCB0byBkaXNjdXNzIGFi
b3V0IGl0Lg0KDQo+IEZyb206IERpbmVzaCBLdW1hciA8RGluZXNoLkt1bWFyQFRPU0hJQkEtVFNJ
UC5DT00+DQpbLi4uXQ0KPiBJIGhhdmUgYSBxdWVzdGlvbiwgd2hpbGUgcGxhbm5pbmcgdGhpcyBh
Y3Rpdml0eSBjYW4gd2UgZGVmaW5lIHNvbWUgdmVyc2lvbiBmb3IgQ0lQIENvcmUgaXRzZWxmPyBB
cyBjdXJyZW50bHkgd2UgaGF2ZQ0KPiBDSVAgS2VybmVsIHZlcnNpb25zIGFuZCB2ZXJzaW9ucyBm
b3IgaW5kaXZpZHVhbCBhcHBsaWNhdGlvbiBwYWNrYWdlcy4NCj4gZS5nLiBJZiB3ZSB3YW50IHRv
IHNoYXJlIENJUCBLZXJuZWwgYW5kIENJUCBDb3JlIHZlcnNpb24gZm9yIElFQyBhc3Nlc3NtZW50
IHdlIGxhY2sgQ0lQIENvcmUgdmVyc2lvbi4NCj4gTWF5IGJlIHdlIGNhbiBkaXNjdXNzIGl0IGlu
IHVwY29taW5nIENJUCBDb3JlIG1lZXRpbmcuDQoNCkkgYWdyZWUgdGhhdCB3ZSBuZWVkIHRvIHZl
cnNpb24gb3VyIHJlbGVhc2VzLiBJbiBEZWJpYW4gdGhlcmUgYXJlIHBvaW50IHZlcnNpb25zLCBi
dXQgSSBkb24ndCB0aGluayB3ZSBuZWVkIHRvIGZvbGxvdyB0aGF0LiBNYXliZSB3ZSBjYW4ganVz
dCB1c2UgYSBudW1iZXIgc3VjaCBhcyB0aGUgZGF0ZSBvZiB0aGUgcmVsZWFzZSAoZWcuIDIwMjAw
NTE5IDwtLSB5ZWFybW9udGhkYXkpLg0KDQpTb21lIHF1ZXN0aW9ucyByZWdhcmRpbmcgdmVyc2lv
bmluZzoNCiAgICogc2hvdWxkIHdlIGFsc28gc3RvcmUgbWV0YWRhdGEgYXNzb2NpYXRlZCB3aXRo
IGEgcmVsZWFzZT8NCgkqIGEgcGFja2FnZSBsaXN0IG1hbmlmZXN0IGZvciBlYWNoIHJlbGVhc2Ug
KGRwa2cgLWwpPw0KICAgICAgICAqIHRoZSBjaXAtY29yZSBicmFuY2ggYW5kIGNvbW1pdA0KICAg
ICAgICAqIHRoZSBjaXAta2VybmVsIGJyYW5jaCBhbmQgY29tbWl0DQogICAgICAgICogbWQ1c3Vt
IG9mIHRoZSBpbWFnZQ0KICAgKiBkbyB3ZSBuZWVkIHJlcG9zaXRvcnkgbWFuYWdlbWVudCBpbmZy
YXN0cnVjdHVyZT8NCiAgICAgICAqIG1pcnJvciBwYXJ0IG9mIHRoZSBkZWJpYW4gcmVwb3NpdG9y
eSAob25seSB0aGUgcGFja2FnZXMgdGhhdCB3ZSBuZWVkKQ0KICAgICAgICogY3JlYXRlIHNuYXBz
aG90cyBmb3IgZWFjaCByZWxlYXNlIGluY2x1ZGluZyB0aGUgc291cmNlIGNvZGUgcGFja2FnZXMN
Cg0KU3RvcmluZyBtZXRhZGF0YSBzaG91bGQgbm90IGJlIHRvbyBkaWZmaWN1bHQsIGp1c3QgYWRk
IHNvbWUgc2NyaXB0IGNvZGUgdG8gZ2l0bGFiLWNpLg0KDQpLZWVwaW5nIHNuYXBzaG90cyB3b3Vs
ZCByZXF1aXJlIG11Y2ggbW9yZSB3b3JrIGFuZCByZXNvdXJjZXMuIEkgdGhpbmsgdGhpcyBpcyBu
b3QgbmVjZXNzYXJ5IHNpbmNlIHdlIGFyZSBub3QgZ29pbmcgdG8gcmVidWlsZCBpbWFnZXMsIGFu
ZCBpZiB3ZSB3YW50ZWQgd2UgY291bGQgZG8gaXQgc29tZWhvdyBmcm9tIHRoZSBwYWNrYWdlIGxp
c3QgbWFuaWZlc3QgYW5kIHRoZSB1cHN0cmVhbSBEZWJpYW4gZnRwIHNlcnZlcnMuDQoNClRoYW5r
cywNCkRhbmllbA0KDQo=

--QcjNwdvsqdoPB90njisP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4632): https://lists.cip-project.org/g/cip-dev/message=
/4632
Mute This Topic: https://lists.cip-project.org/mt/74318282/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--QcjNwdvsqdoPB90njisP--
