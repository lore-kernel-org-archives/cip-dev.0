Return-Path: <SRS0=L4Z9=7V=lists.cip-project.org=bounce+64572+4751+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3755C433DF
	for <cip-dev@archiver.kernel.org>; Mon,  8 Jun 2020 10:33:42 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94A2D2076A
	for <cip-dev@archiver.kernel.org>; Mon,  8 Jun 2020 10:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="pcw/phit"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94A2D2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=moxa.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4751+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id fBg3YY4521723xfbBit1jvwK; Mon, 08 Jun 2020 03:33:42 -0700
X-Received: from APC01-PU1-obe.outbound.protection.outlook.com (APC01-PU1-obe.outbound.protection.outlook.com [40.107.132.82])
 by mx.groups.io with SMTP id smtpd.web11.27104.1591612421379108806
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Jun 2020 03:33:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nMA/TtXopk5OlzjdtLMx0g4mi6QV9RubU9xQqhTJw6f/PnuZJr1fsPUkAQFmDZl78DNqc0eEWgZ7CrKXRFpb3bZLOBb+52lTb/Ec4Bw+6ybKxAGouggZgVERBa9az2XgrJVVOw1HbgtL5A4vFMbhLvpayQtNv4uLpcDnk/tL2YwVB/tptbAnJVq8MocBknMh2M5P0vSAvOh7JytNSXowFPmZlZYlagz1tRi9yxQabVC3YLMQF3dKbPqheGysxAa2MRda1xbBy6pJOLLRDwGTLjJVQZiCCWrbEMOol++xr0e8Z62kPXpcnxRs1ftpP5QCSIudkWO7NKGkR1nSSQwXhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UUguAPiPNSxjc/zZJWZK8+QKtErMdZnQZxhGIixICmQ=;
 b=VNPN+JXbXJpK/YSjuKe9WHCSFVI10RHiq22DFXOWrSlc2GH8pQ4wDr9v4mAJdO1LRE14Af3zOa0/zWliFEjpOMC6Vmm62KtBsca5H8MvczLhiI1B6FraygboxKweR5J0yIFJe8r0qRPzrfOVEN0/LRO0kJdjD7j994unZuAUfAdBBR3OKxtCC4JWnICcMzNOmbWSeXrAnVyX9RWEPbB2/l8USsD4/Yjf7ncbQNsTxcJoSslK2+kthuTmfu45e2DRaXyKBsqE78x53XpT1NQiYe+r7JNAjeQQeSa40zcJHo1yLaHGQUvGTLRr2RiSiy8DqBOQKffeupjWbWTRI/Kq5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
X-Received: from HK2PR01MB3281.apcprd01.prod.exchangelabs.com
 (2603:1096:202:22::12) by HK2PR01MB3378.apcprd01.prod.exchangelabs.com
 (2603:1096:202:22::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Mon, 8 Jun
 2020 10:33:39 +0000
X-Received: from HK2PR01MB3281.apcprd01.prod.exchangelabs.com
 ([fe80::712b:170d:f873:68a3]) by HK2PR01MB3281.apcprd01.prod.exchangelabs.com
 ([fe80::712b:170d:f873:68a3%6]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 10:33:39 +0000
From: "johnsonch.chen@moxa.com" <JohnsonCH.Chen@moxa.com>
To: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"pavel@denx.de" <pavel@denx.de>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
Subject: [cip-dev] [PATCH 4.4.y-cip 2/3] ARM: dts: am33xx: Added AM33XX_PADCONF macro
Thread-Topic: [PATCH 4.4.y-cip 2/3] ARM: dts: am33xx: Added AM33XX_PADCONF
 macro
Thread-Index: AQHWPX1AbNhuIBb9TE+IN2PHlH9zxQ==
Date: Mon, 8 Jun 2020 10:33:39 +0000
Message-ID: 
 <HK2PR01MB3281EBB9EF88BA737213BBD5FA850@HK2PR01MB3281.apcprd01.prod.exchangelabs.com>
Accept-Language: zh-TW, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [123.51.145.16]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 25065d99-8f96-4de2-0c62-08d80b97686c
x-ms-traffictypediagnostic: HK2PR01MB3378:
x-microsoft-antispam-prvs: 
 <HK2PR01MB3378B56DD7676816246F3471FA850@HK2PR01MB3378.apcprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:336;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 0Vx1UCLyvn2rsr3S4zbH08QV9ySFdX4TfpVR7Gv0GAbaO4e6LBXDDAStlkfT2ZZwRwVabvHL2b2K6qL3rw6xkSia19Mf/RmnZjLG1V+FNTlNxXxHH2rzOaaAejRzW79aSzZEZ0jKYDMk3Qe1pe+dxCKvtCnyzIn29WT39TM3Y/UDQSde6eO/S6344PH4GqW0Epwo6KvNp1DUAD4epVo0idRdk4MA77xeuPiaFLZZSinllxJlGoSvg+QB3DpIpE221VQ0h9EFkiIcJZsCBQwY0EMt1t+wbl5x3av11XJSjWez7kuhyLIaWbz9UnhZ4cn9LxJPgFze44FP0eP9VNc5Lw==
x-ms-exchange-antispam-messagedata: 
 8A85wl+8o7MHygBDtpjemJqFjdtn59u4CUqd/EIxuMuKwd3VsFUJlYalTdMocCOPDusQIox0X1WlxHNXwZrsuVi7tUN4hrrGLvLhu2KMw5xSqAePmUBMi+si5AEiAsw6hz505kKeo0hn/r2MJBUdyrNcmMEFGfrhrthJ9+3HnTiGs90We3vx0lbl478QzHRCzHAdBh6q6mrmusAVVRwa71E3bpNPNcKKnAEzthv28kgjsWDngJHOZTktkvDvSz0nZ/F9fVGYN3Rt9DMOvdXSR5NTIWdWt1LICITg2j/BNWoIT6C9tzrYyhdF8Xr+rQ8VqFliFbL3dHJGDss/7gCeGngkQ3S8PN98LoBSO6UA/gHXZM6J7JlfMIntrjYnXvL/Xl5Oj7GJLMQ+MCyHhIZ62iG3//ead13f6rmzRc33IycfPechO1OHUtJqSpJyPHRyvfZGnbiiAamEEOgBgRIc6eQq4c9q8LoBMvCQZDi2dUA=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25065d99-8f96-4de2-0c62-08d80b97686c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2020 10:33:39.1644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h+lWyz+5qe1miPH9Qvu8TfcmGZpStrxMr7U5FoF1ZsYuSVkae9GZtdW5pOhFvGHSF0lTYbxsQcIU6hhwEzv6CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR01MB3378
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: FGx1xegOxBVcpufdXkv0od02x4520388AA=
Content-Type: multipart/mixed; boundary="zZbeVNkFYvM7igU3swCx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591612422;
 bh=mv4YPbR6EtpTX4mHO3GJhmEdnG5D4YNVeshVpenPaCc=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=pcw/phitOh538BUodqCHcW7bKogMt+uwKIR9xi447/W1r+i2Ktaa0i+DkJEf4RXuUjb
 Upkg7S1Jqvh+oy1lDEHYGggGGvtATH8IJMMM/ODKb6mta5kmwvwI3r5hjBIskwXagKE/0
 3eK9QBCII3Vsb1aj1YuRmn5UO59UltUwSOw=

--zZbeVNkFYvM7igU3swCx
Content-Language: zh-TW
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64

RnJvbTogQ2hyaXN0aW5hIFF1YXN0IDxjcXVhc3RAaGFub3ZlcmRpc3BsYXlzLmNvbT4KCmNvbW1p
dCBmMWZmOWJlNzY1MmI3MTZjN2VlYTY3YzljYTc5NTAyN2Q5MTFmMTQ4IHVwc3RyZWFtLgoKQU0z
M1hYX1BBRENPTkYgdGFrZXMgdGhyZWUgaW5zdGVhZCBvZiB0d28gcGFyYW1ldGVycywgdG8gbWFr
ZQpmdXR1cmUgY2hhbmdlcyB0byAjcGluY3RybC1jZWxscyBlYXNpZXIuCgpGb3Igb2xkIGJvYXJk
cyB3aGljaCBhcmUgbm90IG1haW5saW5lZCwgd2UgbGVmdCB0aGUgQU0zM1hYX0lPUEFECm1hY3Jv
LgoKU2lnbmVkLW9mZi1ieTogQ2hyaXN0aW5hIFF1YXN0IDxjcXVhc3RAaGFub3ZlcmRpc3BsYXlz
LmNvbT4KUmV2aWV3ZWQtYnk6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+ClNpZ25lZC1v
ZmYtYnk6IFRvbnkgTGluZGdyZW4gPHRvbnlAYXRvbWlkZS5jb20+CltKb2huc29uOiBBZGQgU1BE
WCBMaWNlbnNlXQpTaWduZWQtb2ZmLWJ5OiBKb2huc29uIENoZW4gPGpvaG5zb25jaC5jaGVuQG1v
eGEuY29tPgotLS0KIGluY2x1ZGUvZHQtYmluZGluZ3MvcGluY3RybC9vbWFwLmggfCAyICsrCiAx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9kdC1i
aW5kaW5ncy9waW5jdHJsL29tYXAuaCBiL2luY2x1ZGUvZHQtYmluZGluZ3MvcGluY3RybC9vbWFw
LmgKaW5kZXggMGQ0ZmUzMmIzYWUyLi5mMGQwZTc1N2ZkOWMgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUv
ZHQtYmluZGluZ3MvcGluY3RybC9vbWFwLmgKKysrIGIvaW5jbHVkZS9kdC1iaW5kaW5ncy9waW5j
dHJsL29tYXAuaApAQCAtMSwzICsxLDQgQEAKKy8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBH
UEwtMi4wICovCiAvKgogICogVGhpcyBoZWFkZXIgcHJvdmlkZXMgY29uc3RhbnRzIGZvciBPTUFQ
IHBpbmN0cmwgYmluZGluZ3MuCiAgKgpAQCAtNjMsNiArNjQsNyBAQAogI2RlZmluZSBPTUFQM19X
S1VQX0lPUEFEKHBhLCB2YWwpCU9NQVBfSU9QQURfT0ZGU0VUKChwYSksIDB4MmEwMCkgKHZhbCkK
ICNkZWZpbmUgRE04MTZYX0lPUEFEKHBhLCB2YWwpCQlPTUFQX0lPUEFEX09GRlNFVCgocGEpLCAw
eDA4MDApICh2YWwpCiAjZGVmaW5lIEFNMzNYWF9JT1BBRChwYSwgdmFsKQkJT01BUF9JT1BBRF9P
RkZTRVQoKHBhKSwgMHgwODAwKSAodmFsKQorI2RlZmluZSBBTTMzWFhfUEFEQ09ORihwYSwgZGly
LCBtdXgpCU9NQVBfSU9QQURfT0ZGU0VUKChwYSksIDB4MDgwMCkgKChkaXIpIHwgKG11eCkpCiAj
ZGVmaW5lIEFNNDM3Ml9JT1BBRChwYSwgdmFsKQkJT01BUF9JT1BBRF9PRkZTRVQoKHBhKSwgMHgw
ODAwKSAodmFsKQogI2RlZmluZSBEUkE3WFhfQ09SRV9JT1BBRChwYSwgdmFsKQlPTUFQX0lPUEFE
X09GRlNFVCgocGEpLCAweDM0MDApICh2YWwpCiAKLS0gCjIuMjAuMQo=

--zZbeVNkFYvM7igU3swCx
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4751): https://lists.cip-project.org/g/cip-dev/message=
/4751
Mute This Topic: https://lists.cip-project.org/mt/74749055/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--zZbeVNkFYvM7igU3swCx--
