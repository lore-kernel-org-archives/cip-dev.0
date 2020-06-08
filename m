Return-Path: <SRS0=J2zA=7V=lists.cip-project.org=bounce+64572+4749+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03183C433DF
	for <cip-dev@archiver.kernel.org>; Mon,  8 Jun 2020 10:33:40 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DB2D2076A
	for <cip-dev@archiver.kernel.org>; Mon,  8 Jun 2020 10:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="kVJzBcrn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DB2D2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=moxa.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4749+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id hq4xYY4521723xDgw8zx0NWO; Mon, 08 Jun 2020 03:33:39 -0700
X-Received: from APC01-PU1-obe.outbound.protection.outlook.com (APC01-PU1-obe.outbound.protection.outlook.com [40.107.132.72])
 by mx.groups.io with SMTP id smtpd.web10.27116.1591612417765272653
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Jun 2020 03:33:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nChOIXn9frtafWsPCGDV9y9R4Xxkidptw9fn72zmKH1RQK5gbjgEJS2ZdfsXFhiFwPJxZOUJAWlkION2Vipk9vr1oWG86slx8RlSz3XKtlaIoEQEYooB8xhA0m55pYQhNGkpG1YuMhoBuL5CVRni7kCO/QyB17u5J2RdiU/vbrz7sDfBQR04T//8WSDyjiLXNewfwOrIurvTM73Kkk2bDYyAjdj1agYqm3RuCe+IjwpsInQj/I5qcDI9tLSzSipcXTxp2MnONebOUnwKcvH2KEMBLyrbxiIM4siPaRbWUhQvrYejBXSD257eiHuMDLRVrznVgGC76kYce0JP7WRsBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7IJnlHBOpIjsOtEXEZpTUwjYyxLeC/0g8cVKNTTXz7U=;
 b=Bnr3nmTSDvilnp29i55RHHu3VHbNu0hmLdcpIj9+hJ/YFe23tY2+ilAgOqHjv1ppj7Pol0NzsMpPjRnr/3MkCJFaCbzDdZUlMebZq7pstllU6/zKuTmWh5qzWeq3TxL1yWnf5COf5LANhaYyM5AzlC92LSJxT93WwP1N+EoS+SJ5UczFRjZwBAbZFMeGF81+TpwcmUeOdHolJDOwFMH2hnTyNISQonC45h7s8c9jEtVKasUj1x+3IjoriskmMBnjSNYEyTtsdM+YmwHDDWbYU+VZ/Z6vwJhrzPhtA816RvXgADxyiizYQwWjmJx6CsboyqSKhOsINbrkO1z4PM9JWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
X-Received: from HK2PR01MB3281.apcprd01.prod.exchangelabs.com
 (2603:1096:202:22::12) by HK2PR01MB3378.apcprd01.prod.exchangelabs.com
 (2603:1096:202:22::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Mon, 8 Jun
 2020 10:33:35 +0000
X-Received: from HK2PR01MB3281.apcprd01.prod.exchangelabs.com
 ([fe80::712b:170d:f873:68a3]) by HK2PR01MB3281.apcprd01.prod.exchangelabs.com
 ([fe80::712b:170d:f873:68a3%6]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 10:33:35 +0000
From: "johnsonch.chen@moxa.com" <JohnsonCH.Chen@moxa.com>
To: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
Subject: [cip-dev] [PATCH 4.4.y-cip 0/3] ARM: dts: am335x: Replace numeric pinmux address with macro defines
Thread-Topic: [PATCH 4.4.y-cip 0/3] ARM: dts: am335x: Replace numeric pinmux
 address with macro defines
Thread-Index: AQHWPXz3m8Oq8l9Bi06Yy7524OP+nw==
Date: Mon, 8 Jun 2020 10:33:35 +0000
Message-ID: 
 <HK2PR01MB3281084A8DA1542518F65818FA850@HK2PR01MB3281.apcprd01.prod.exchangelabs.com>
Accept-Language: zh-TW, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [123.51.145.16]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 58653609-587f-430f-01c0-08d80b97660c
x-ms-traffictypediagnostic: HK2PR01MB3378:
x-microsoft-antispam-prvs: 
 <HK2PR01MB337828195A859ACC813B00E0FA850@HK2PR01MB3378.apcprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 d0VVYf0kcnve+pbtHeRyRXTikydszqRQoT2+YWFRZsfKrwAQ1ZV6P+I1DQtAB+si/ourSz6HbeV5fDvluOOTqxYoAsN3JfFSHQFlz8UnSjLdzzKNtsdOSzTbL4VIETCUw+HvqgFZFuicp0DqGSL74GZkZUvCcyVt07vhkWc5I4Gy7MT3QFYCrmVsfxwRuR+pgkYu6/5kiGiVHgvoaaDcrIsjH32QYsC8W48SXnm4ELhjce/T45/74F8Xk38pNt7pQ1KxpTlLly+LwYUGm/d6RtETllKPMMed9gJB+7+CRT1x7EmQ6DiR3/Wt+ob8q3/sYvMkio7efuX9eDn9BRyLWQ==
x-ms-exchange-antispam-messagedata: 
 UId3yiBoU2iSJdGM4OK/Ma7a+KLV3puBXopsYiPY7LKEccxkRxX1+VJZiow8twkEplWl32yfBgHyL64BpjTAR0SA/z59+S89Ow4DopItJHpRjb1rcH0NiKtyEJMg3uUkiGBZzSnGsmyj8lnMoTjJTkTDU38sJAZU3E3HHi+2v/ArhcsNXjEGga1ryXK84Wme7ZZ0PZL3fXKvMFBCYDmTQGdLVZNwEqgoMI9W+ps0xz2AlzJeUrx7/1teBgZEwO53ux4wzFaR3GTsOPWlXpR0ECREGtTNWpr13rk458a0TCAyQi5Dh9LNx0Xqw0BRepuynGh5IbAl2KH06b6vuzua0grAU1sWQmzL9Y0ZfUOkE0NQwik608yr+oajbSa7GMITVmcA8nErIwFDveclMv5n/yB7LKNBLUR/D1G1FC8/CxC18isXKdjRCCxkzI6L51ptBB4ERQci/TlybmKqf34nIVjGA/b2P63d/ZEsFLodlx8=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58653609-587f-430f-01c0-08d80b97660c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2020 10:33:35.1855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R/BD8NoDSR8gtQlnOOoNyGhWIJ1oHBwByjXiGh2o27El9WaN6Wq5/V9lvDWJTfUjduGjGpFeExFHbeWb+oxZgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR01MB3378
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 8Xc9dPyVs9lZXRx0jiV7e5y3x4520388AA=
Content-Type: multipart/mixed; boundary="ad3Cq5UTGMuxT0VVyCNI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591612419;
 bh=9eZ4QERxbCkPTiRenO9tlWJl3OOTbKYnFObiYZ/obCc=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=kVJzBcrnACRq59+tI3s9yLS+A4nwwVoYR3izWJyzdMzgtFBCcolcTMdYWP+w8N+aGxn
 WT3egPY1rLA0OU5sHpsGFjVKj/KrDHZ1oiVdLwMWf1Pom4r19k1+ERFvbHJ18Q/ND1j3L
 17YQJh8r/pAh/EJsG9W2PkuX/4p3gaPIVag=

--ad3Cq5UTGMuxT0VVyCNI
Content-Language: zh-TW
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64

SGVsbG8gYWxsLAoKVGhpcyBwYXRjaHNldCByZXBsYWNlcyB0aGUgcmVnaXN0ZXIgb2Zmc2V0cyBm
b3IgYW0zMzV4IHdpdGggbWFjcm8gZGVmaW5lcy4KVGhlIHZhbHVlcyBhcmUgZXh0cmFjZWQgZnJv
bSB0aGUgIkFNMzM1eCBTaXRhcmFUTSBQcm9jZXNzb3JzIFRlY2huaWNhbApSZWZlcmVuY2UgTWFu
dWFsIi4KClVzZSBBTTMzWFhfUEFEQ09ORiB0byB0YWtlIHRocmVlIGluc3RlYWQgb2YgdHdvIHBh
cmFtZXRlcnMgZm9yIEFNMzNYWF9JT1BBRCwgdG8gbWFrZQpmdXR1cmUgY2hhbmdlcyB0byAjcGlu
Y3RybC1jZWxscyBlYXNpZXIsIGFuZCBhZGp1c3QgcGluIGRpcmVjdGlvbiBhbmQgbXV4IG1vZGUg
aW50dWl0aXZlbHkuCgpGb3Igbm93LCBvbmx5IHRoZSBhbTMzNXgtbW94YS11Yy04MTAwLW1lLXQu
ZHRzIGNoYW5nZXMgYXJlIGF0dGFjaGVkLgoKMS4gQWRkIG1hY3JvcyBmb3IgbnVtZXJpYyBwaW5t
dXggYWRkcmVzc2VzLiAKMi4gQWRkIEFNMzNYWF9QQURDT05GIG1hY3JvLgozLiBSZXBsYWNlIHJl
Z2lzdGVyIG9mZnNldHMgd2l0aCBkZWZpbmUgZm9yIG1veGEtdWM4MTAwLW1lLXQuCgpJdCdzIHRl
c3RlZCB3aXRoIGEgTW94YSBVQy04MTAwLU1FLVQgcGxhdGZvcm0uCgpUaGFua3MhCkpvaG5zb24K
CkNocmlzdGluYSBRdWFzdCAoMik6CiAgQVJNOiBkdHM6IGFtMzN4eDogQWRkZWQgbWFjcm9zIGZv
ciBudW1lcmljIHBpbm11eCBhZGRyZXNzZXMKICBBUk06IGR0czogYW0zMzV4OiBtb3hhLXVjLTgx
MDAtbWUtdDogUmVwbGFjZWQgcmVnaXN0ZXIgb2Zmc2V0cyB3aXRoCiAgICBkZWZpbmVzCgpUb255
IExpbmRncmVuICgxKToKICBBUk06IGR0czogYW0zM3h4OiBBZGRlZCBBTTMzWFhfUEFEQ09ORiBt
YWNybwoKIGFyY2gvYXJtL2Jvb3QvZHRzL2FtMzM1eC1tb3hhLXVjLTgxMDAtbWUtdC5kdHMgfCAx
MTYgKysrKysrKysrKystLS0tLS0tLS0tLQogaW5jbHVkZS9kdC1iaW5kaW5ncy9waW5jdHJsL2Ft
MzN4eC5oICAgICAgICAgICB8IDEzMCArKysrKysrKysrKysrKysrKysrKysrKystCiBpbmNsdWRl
L2R0LWJpbmRpbmdzL3BpbmN0cmwvb21hcC5oICAgICAgICAgICAgIHwgICAxICsKIDMgZmlsZXMg
Y2hhbmdlZCwgMTg4IGluc2VydGlvbnMoKyksIDU5IGRlbGV0aW9ucygtKQoKLS0gCjIuMTEuMAo=

--ad3Cq5UTGMuxT0VVyCNI
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4749): https://lists.cip-project.org/g/cip-dev/message=
/4749
Mute This Topic: https://lists.cip-project.org/mt/74749053/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--ad3Cq5UTGMuxT0VVyCNI--
