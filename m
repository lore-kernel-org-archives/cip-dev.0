Return-Path: <SRS0=NVrx=7Q=lists.cip-project.org=bounce+64572+4666+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B017BC433E0
	for <cip-dev@archiver.kernel.org>; Wed,  3 Jun 2020 13:24:11 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D44320678
	for <cip-dev@archiver.kernel.org>; Wed,  3 Jun 2020 13:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="bZ9xky05"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D44320678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4666+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id KkJ1YY4521723x5vGqBYM3Vw; Wed, 03 Jun 2020 06:24:10 -0700
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.111])
 by mx.groups.io with SMTP id smtpd.web12.13452.1591190648708487448
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Jun 2020 06:24:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mnv1eW0xT0gIOuUTTG9wsrmB5nF5xch4X7CgT0O9CDlvGCgaVGZE1l5Mcv5QlGRLduwzRxo1kWiRz3x4gYyjF1j+D63DXmgbyIwITDMlHXgOd2+VegnFEnPPF2lx2d0VUNFSyUVyt0sL97JCo0qjyNAWxTLtxiRKDfxuytGfuXpokBZ5io/WEq7FH6e81/I1AsMXDnPW/hO1x2ysg3iBo5tvDxSKea9E4l41NNIHCNDtfRm6dLBlpN+h/Ji23URkquSPI2sH2bOuIquis8wsIex0jglXzLCI7uMhh0XuwlKR5vnEpk6QsBkWNYZ/iX4zRHS3cJweGKBEbrmcdQdNYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HaP9Qtp8/qBcNHtZMH+J4RCDWmAY+D8ymJTg1Y7PGrg=;
 b=YIipQTYuG72ZWRCOqIy+yotGh9i2JFlpKk9P//7yVq1zbtIUPxcTvLyHlL/3RcXdQlXCmlB10llJnxhz34AMoWUuXK++Ofc5UcN2v8fUQt7chmpu2AEUODGZgqSZ5ohKEGMDr7+RSg2DQ2NmaqpQKporMI8ToTY+Zss1b+s6opvE55OYypg3hk1I9vrE9ICXDlKI/nfbPGz60bP11rj2C2ZqgTKBlGLywVkH5e3PL0AV8JbOO4YH8c+z8o8zHDYIydX+hkNbo1YxhV/BT5L3Pm7OePTr36T28WZlblF4axQzit1fopdDbhQOejOwziApDMHPWoggREzDZB5xhScljA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
X-Received: from OSAPR01MB2385.jpnprd01.prod.outlook.com (2603:1096:603:37::20)
 by OSAPR01MB3491.jpnprd01.prod.outlook.com (2603:1096:604:32::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Wed, 3 Jun
 2020 13:24:05 +0000
X-Received: from OSAPR01MB2385.jpnprd01.prod.outlook.com
 ([fe80::c44c:5473:6b95:d9fd]) by OSAPR01MB2385.jpnprd01.prod.outlook.com
 ([fe80::c44c:5473:6b95:d9fd%6]) with mapi id 15.20.3066.018; Wed, 3 Jun 2020
 13:24:05 +0000
From: "Chris Paterson" <chris.paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: [cip-dev] FW: KernelCI Community Survey
Thread-Topic: KernelCI Community Survey
Thread-Index: AQHWOSPlfQNKh3Piy0e66gX+nlOJZ6jG4eEA
Date: Wed, 3 Jun 2020 13:24:05 +0000
Message-ID: 
 <OSAPR01MB2385D2E831BD6BAFE63F95EBB7880@OSAPR01MB2385.jpnprd01.prod.outlook.com>
References: <4e70209b-e637-abdf-d72a-7cb978956f9d@collabora.com>
In-Reply-To: <4e70209b-e637-abdf-d72a-7cb978956f9d@collabora.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d239389a-b146-4241-8210-08d807c163e0
x-ms-traffictypediagnostic: OSAPR01MB3491:
x-microsoft-antispam-prvs: 
 <OSAPR01MB3491B570F84FDC9342DF6A8AB7880@OSAPR01MB3491.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 2J/AjaAJUSFhYJxVhKBpAZ7nGZdAZOlUJhXlI2l6kqeZUO0r9tkkWD3EQNSGUje9lmagX+p92/G2VLr1gRX5S0SMKnYtUZX3RJytzQSNEE0qITPDuou1B3ttp2Jqk4iq1uO1byMhw4pXM0SvPfGb1mBbXYsVLdvDOoT+o60OauTOyprsS/rD9x2LKCoZox9AN+jM0MlHhRu/nUiWW8iQqflJ+Wb7mRtJbi4VHhIpOyIoQoD1/i4KwZHsaIzlzvRXR/39H2APo2Ob5opKkEh8ZQ1hSIAQDH2NMxNtAfG0di5GP0w2UVp2tqQIjm4y+VLKJGpIx0SuAkcb2VZ1VjsLf7iFoh+q5dcvc5GZypY01GIggbALVmI21rxpPXhOYO++UwKoZIfx2rfHhH7fEAk83w==
x-ms-exchange-antispam-messagedata: 
 tlwBiAWPLognBYe46URwTYpIa8T6I4LX0Efjy085A4Ar+zzsORBeyQHIXe193jhDX5v5xpLZFbG8iDDvySbq3aN+bepBMHezjEWxF5gGT+659dOjeqMk170eDGw4k5UZSjZmrglry0Ryj4Rz5zlFL42xXf/toU+TTzuMFIz0VIbiEWJViTgZs6i5+PCcP6UgGGsMhEKkq+ebCDgpbFPzJFLYepkkAT96wMnR4aWG0n0uwgcldwP4Kvmrxhjk6gt6rCFbiv/TpYB/WpWJNgFgX68BP/2gICT/WdBuwaw8QhD6Z3k8oEQndsUZIoypWNbNEfKt/J6ybEuDm6i2f4ofi9Kcmts15P7FOLr05cbNg5Dz/XrrHFi9cqFinNnL5abVIruCNPKi8UBm1d87nbWQMNBW0cOsTJdEgQlbf8aPBLGbOwKJihRFzpJOoG2zApjUAVbcct+xlfMyrr/VQQLSMXDvb2sWu1mSBM/3R5WVV4fvdog3dL72MIFHcnxJOnJk
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d239389a-b146-4241-8210-08d807c163e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2020 13:24:05.6796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vs9naHhrtdjmRWJhXCIKtuBdGLA79GoJjcSmMMF2slVNX7fJIsQjodylBDsizkQAY/QizEtkNv4e6h9k5k+m21HWjwdWaA2KUsuZD3xvxno=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3491
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: MUOexcCBvUgx1SfIYBx0pukIx4520388AA=
Content-Type: multipart/mixed; boundary="wOE1zL2A4ERJ8ceY7nOD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591190650;
 bh=+MOTjs1PZTewkzzuPIVEmj+cSz48td7SJj/OMrLtHTs=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=bZ9xky05xI1YmRgdHlRTKqryDCHngGeYXommIiB5XeY3CZHl1k7L+/supZ2KH4UqClj
 9CukbrHneH9kMSWWF/RISNiydVXcvE1ifU55JmAkrPkE8DoBtrLFlDXqJn/188/DHpnvE
 SdxtJTvBFYMBKZG9qIkhSPDnuiS6IBjGgPs=

--wOE1zL2A4ERJ8ceY7nOD
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

RllJDQoNCktpbmQgcmVnYXJkcywgQ2hyaXMNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
CkZyb206IGtlcm5lbGNpQGdyb3Vwcy5pbyA8a2VybmVsY2lAZ3JvdXBzLmlvPiBPbiBCZWhhbGYg
T2YgR3VpbGxhdW1lIFR1Y2tlciB2aWEgZ3JvdXBzLmlvDQpTZW50OiAwMiBKdW5lIDIwMjAgMjI6
MjINClRvOiBrZXJuZWxjaUBncm91cHMuaW87IGF1dG9tYXRlZC10ZXN0aW5nQGxpc3RzLnlvY3Rv
cHJvamVjdC5vcmc7IGtlcm5lbC1idWlsZC1yZXBvcnRzQGxpc3RzLmxpbmFyby5vcmcNClN1Ympl
Y3Q6IEtlcm5lbENJIENvbW11bml0eSBTdXJ2ZXkNCg0KQXMgdGhlIEtlcm5lbENJIHByb2plY3Qg
a2VlcHMgZ3Jvd2luZywgd2UgbmVlZCB0byBrbm93IGEgYml0DQpiZXR0ZXIgd2hhdCB0aGUgTGlu
dXgga2VybmVsIGNvbW11bml0eSBuZWVkcyBpbiB0ZXJtcyBvZg0KYXV0b21hdGVkIHRlc3Rpbmcu
ICBXZSB3b3VsZCByZWFsbHkgYXBwcmVjaWF0ZSBpZiB5b3UgY291bGQNCnBsZWFzZSBzcGFyZSBv
bmUgbWludXRlIHRvIGZpbGwgdGhpcyBzdXJ2ZXkgZm9ybToNCg0KICBodHRwczovL2Zvcm1zLmds
ZS9ZNWl1eUxYZ1FyMnkzU3JGNg0KDQpUaGlzIGlzIGZvciB5b3VyIG93biBnb29kIQ0KDQpUaGFu
ayB5b3UsDQpHdWlsbGF1bWUgJiB0aGUgS2VybmVsQ0kgdGVhbQ0KDQoNCg0K

--wOE1zL2A4ERJ8ceY7nOD
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4666): https://lists.cip-project.org/g/cip-dev/message=
/4666
Mute This Topic: https://lists.cip-project.org/mt/74649019/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--wOE1zL2A4ERJ8ceY7nOD--
