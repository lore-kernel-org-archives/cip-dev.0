Return-Path: <SRS0=pGcS=BI=lists.cip-project.org=bounce+64572+5052+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C542C433DF
	for <cip-dev@archiver.kernel.org>; Wed, 29 Jul 2020 23:52:03 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B70B0207E8
	for <cip-dev@archiver.kernel.org>; Wed, 29 Jul 2020 23:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="mi2iiN4P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B70B0207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5052+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id NKJCYY4521723x58YorFw6H0; Wed, 29 Jul 2020 16:52:02 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web10.3608.1596066719690720981
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Jul 2020 16:52:01 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 06TNpvZV025627; Thu, 30 Jul 2020 08:51:57 +0900
X-Iguazu-Qid: 2wHI1scKI4FIuKaOMj
X-Iguazu-QSIG: v=2; s=0; t=1596066717; q=2wHI1scKI4FIuKaOMj; m=bqFx5ZQXMPnSiWveoxQwcoAEBYO+lfOBvQz1IrUIYA4=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1111) id 06TNpud9006979;
	Thu, 30 Jul 2020 08:51:57 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 06TNpu6L008968
	for <cip-dev@lists.cip-project.org>; Thu, 30 Jul 2020 08:51:56 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 06TNpt4b014498
	for <cip-dev@lists.cip-project.org>; Thu, 30 Jul 2020 08:51:56 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/GQ71QQmOjspf8wc0c0dYx4Gg6XCrGJ3ZWAWtdgegBGXDUmQf84nYEw6rMqn7Kg/CAvQ/q70s42G1olR2/239p8IO41ULaLG1whxcgqRKqirQrvWIRC2poiGzB1AIycxQ4VsdEqB2kPjs+ta8mbV0obbDRxVUe4IkkW9gqy0a1+SRAd1vgYVmcDSvBmnwdXiM8z44h/z7JoYO3etYGSf1BCiU0nkRJEFhOxlqjWypw2AcJakEydpJZWcn748bsHryi47RLbv9EHrZd0xeHjD6UyoyxeKhI+7Uf6uSfqpwjoBQC0pN9vX1fcYg4dOhcKM2l8Ae0vu9cxs0iY9OqOsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FY0vdLJSf39k5SmAIvl/gclBTmYc7ab5OB3juQfBzb4=;
 b=l0agrMaR6YZX4p2o0N47xdrllNKycSM057xuH4b4lbL1TfNMH4BNTLl6elI+dpVJZu1xkFJyoTkJjJiu+rtGjRguObyNZF1dG3kEiBs7YXvXe6YcuOr0+3pyiPOaNvTowPmkrjb0hMXfgMenQt66HMIYqqa+IB8CHnQ52Fm+1T6uATCCuIVCvXw20ayTvnw0V30bEt/0443ClB6qBXKShh+K/sZQ291CRhy4ibsX5FZhHJtwx0bYZP3SR5FwXFB/nus+h9bLP1w0P83LLGjwmLO4d1NgZ7L6PifGvLJt3SJdLpRAc9RynkQfOP1ICqfdj51IMYdtFQIiUzHYmvf4DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Daniel Sangorrin" <daniel.sangorrin@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] CIP embedded platform Internet connection?
Thread-Topic: [cip-dev] CIP embedded platform Internet connection?
Thread-Index: AQHWZCHR+PciwJN7zEaBe4rK2sN6pqkfPm7g
Date: Wed, 29 Jul 2020 23:51:54 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2053279D1019303875CB7767D0700@OSBPR01MB2053.jpnprd01.prod.outlook.com>
References: <CALkjhPpZKd_qwAJhSdNTND_pLUv1LhnzKzRRRYxLCKP0-e+QpA@mail.gmail.com>
In-Reply-To: <CALkjhPpZKd_qwAJhSdNTND_pLUv1LhnzKzRRRYxLCKP0-e+QpA@mail.gmail.com>
Accept-Language: en-US
x-originating-ip: [103.91.184.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d3d2c782-eca8-41c2-6b06-08d8341a5f11
x-ms-traffictypediagnostic: OSAPR01MB1602:
x-microsoft-antispam-prvs: <OSAPR01MB1602E362798314914CD0448AD0700@OSAPR01MB1602.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FsszWDgh5IeMiB/okgrKEcXaCxyJs2cZWvqc5C44uxTdyBj/GKjR0e26XhZLmXaZ7+/0WerIYcvb1yCVMJ9g0ZKbDQfDkVV5hIeZKEKzRi9Mm0Ss/NapdG3ezLwQglpdFwOD2rSIi0M+PffMRDMKPihPg6bWD/+dL1eW4MkDxi+hTVCxV/bKRNf5Y9FSGcKo9E1M6HcHgGpRBCNGhQQZFPrxYJvXEWdVo+ZdQwTl8UBYEPueV1mraxwV9EVB+AFD4stirym73WW8lZmDfRR28bqJ4GvXsoPa+NotX2uJlsdcy+xMvKONtHtRapVecGy8o4d03JEO+TQtqWoIWgT2pw==
x-ms-exchange-antispam-messagedata: W+1Hufipt8nRS+jwUjDJbUYyULEbhiX9rge8NFsn4AZFdMBnrTY7ZgILx3YT96fpZMAXwo1iXCb8WQ8TXq6Ceo/o2iBGxoP1++9Q67yvWv4V+bY+CQUPzzu1EvUGGQ2/Ce0EqRxsJjguVtvPWOTWgwn2bkPWiZ/Qj8mgbx3fubF3LVFJ8aVEXWmkvnx6hi5f/eVAgKcufwMalpoEfj0ltfA/oMMV8cjRybSXp2RZu7t9k18pP1jrzKs0x/T2zZl2y9/xGOlRrQgU4chDLkT7mFm2t+W85tE6nGAL6b4Es/qorsDLgSusNzy/ggTJtemED7EowXON0EkjFXqERCaZUQInIHRMN9960+d0MFAhsvGFo43xuVrEO8GEmkdHQMq4qSp0JuzI7CmYW9tR4gTzvDQRhsYDEBYq5wVjrQt19P/FWjNOgwpS06F2NZD2vGvmQyDzss7q87v6+6DEUcWx+lgJdfa+5ud5iwlkSjpJhbQ=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2053.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3d2c782-eca8-41c2-6b06-08d8341a5f11
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2020 23:51:54.0966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dBkylgseJxQVWb5xFDbMtMk+Nd69McF2fmjTq1xpJODO7fwXW1ShIG2H1b50vnXLklJERIV0lJZbtvGbkIH09DqxyToAMi29ZJpP8o0vEa4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB1602
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: PawKbnQAAPJ9O4SaltHbPG3yx4520388AA=
Content-Type: multipart/mixed; boundary="GeXCWnzURed5tGmHnFxu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1596066722;
 bh=Xx4kBxydaK87ZZNsbw+TdHjgWO6ZcvbhebE/gCDDvqw=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=mi2iiN4P/4067T9JzgUIzI9mXEVGIZ81s9RBrUM9uK93DVU1FmoY+H0E9SCx6BDDEh2
 I4d2TupnilisuW3pLHob3gSFAR7rWUUoNzDK74C6aLQy48IAVd7o8NmElPA8U6Rf93iZs
 pctpuHIuSeiWMxRLqnnn3dCG+eD/SnG7loQ=

--GeXCWnzURed5tGmHnFxu
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgTW9oYW1tZWQsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogY2lw
LWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcgPGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3Jn
PiBPbiBCZWhhbGYgT2YgTW9oYW1tZWQgQmlsbG9vDQo+IFRoaXMgcXVlc3Rpb24gc3RlbXMgZnJv
bSB0aGUgdGhyZWFkIHRpdGxlZCAiVGhlIHNlY3VyaXR5IG9mIE5UUCIuIElmIHdlIGRvIGdvIHdp
dGggTlRTLCBpdCBsb29rcyBsaWtlIHdlJ3JlIGdvaW5nIHRvIG5lZWQgYW4gSW50ZXJuZXQNCj4g
Y29ubmVjdGlvbiB0byB0aGUgZW1iZWRkZWQgcGxhdGZvcm0uIElzIHRoYXQgYWNjZXB0YWJsZT8g
VGhlIHdvcmsgdGhhdCBJJ3ZlIHNlZW4gc28gZmFyIHJlbGF0ZWQgdG8gQ0lQIFNXVXBkYXRlIGhh
cyBhc3N1bWVkIHRoYXQgdGhlDQo+IEhhd2tiaXQgc2VydmVyIGlzIG9uIHRoZSBsb2NhbCBuZXR3
b3JrLiBJdCBpc24ndCBvYnZpb3VzIGlmIHRoYXQgaGFzIGJlZW4gYW4gaW50ZW50aW9uYWwgZGVj
aXNpb24gKGR1ZSB0byBzZWN1cml0eSByZXF1aXJlbWVudHMpIG9yIGp1c3QgdG8gZWFzZQ0KPiBk
ZXZlbG9wbWVudC4NCg0KVGhlcmUgaXMgbm90aGluZyBpbiBDSVAgU1dVcGRhdGUgdGhhdCBhc3N1
bWVzIHRoZSBIYXdrYml0IHNlcnZlciBpcyBvbiBhIGxvY2FsIG5ldHdvcmsuDQpQZXJoYXBzIHRo
ZSBSRUFETUUgaXMgdXNpbmcgYSBsb2NhbCBzZXJ2ZSBmb3IgZGVtb25zdHJhdGlvbiBwdXJwb3Nl
cz8NCg0KVGhhbmtzLA0KRGFuaWVsDQo=

--GeXCWnzURed5tGmHnFxu
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5052): https://lists.cip-project.org/g/cip-dev/message=
/5052
Mute This Topic: https://lists.cip-project.org/mt/75823534/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--GeXCWnzURed5tGmHnFxu--
