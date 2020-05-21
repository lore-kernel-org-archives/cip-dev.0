Return-Path: <SRS0=x3Gh=7D=lists.cip-project.org=bounce+64572+4636+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CAEFC433E0
	for <cip-dev@archiver.kernel.org>; Thu, 21 May 2020 00:51:58 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA35220756
	for <cip-dev@archiver.kernel.org>; Thu, 21 May 2020 00:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="fKX8MhkT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA35220756
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4636+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 7awrYY4521723xcbn1D5wyns; Wed, 20 May 2020 17:51:57 -0700
X-Received: from APC01-SG2-obe.outbound.protection.outlook.com (APC01-SG2-obe.outbound.protection.outlook.com [40.107.131.110])
 by mx.groups.io with SMTP id smtpd.web11.2014.1590022315298028676
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 May 2020 17:51:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TfoCxxnhCGMZXJwshA4xK+/EcHNTQxL9txdVbQC8qQctie/GGtYA8lGAzkKMLBQvjLgadqE5ioMWdWwr9LtZbcOXYr3B38Tl4hCZcHLI8SQO5weWJWIy82bSHdRQjMay3D1o1VvhZcz0L3vrg+ttWuoLrwn5qlzF3kPqZG7XpJiR1eqdt978UsZ7JAvs/PJ6nGREzXoNEJNfUUUt4JEZx1fWadFRsQ4d0MpRIbN2vIPbynBjT+XjfinKp/o2AbDyovJe9DnY7H54R6Iw0aT4rdaibXBWNj4A6efwoXAFJVgtc7ZMK4SwdLc1iwUkUC/W7YiIVfZo9XP/CWP7t3xygQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4K6sQq1AwdMNyxF6kFvobqaxVm6w9XyjCYIwSrxQOME=;
 b=C8QI+kuTml0GMWetMhPbLZhr6MlDPsVslnH343wWbnuLyuJgaJ/SOjETpmNbDOsbvV3fGubomUCWNm3Am1Uw4Qfbsma5NDcmGolMw0RHEXRntC3HBFeLWPh3AF6p0thYjnGNSfjHR6SadgYw7sk9yzYiUJoFd4R6sJh4whcU8FOt89hyWXgaSKNV3rV5ovj/zQFlkWfngNRIyNV+UbN0ALNq3S0Tclt/E5twStV0xvE2+d3iLtl+2ggtTJopMY0MBqtXRJZZTBrPSJO84szRmjFc20rGNojNS/F5HPBkgSNqR74rrJHFndL+C4+Mi3d3Jtto7DIl4DnQNyHmyKoVYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TY2PR01MB5196.jpnprd01.prod.outlook.com (2603:1096:404:10f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24; Thu, 21 May
 2020 00:51:51 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::d9d9:60fe:a138:6752]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::d9d9:60fe:a138:6752%4]) with mapi id 15.20.3021.020; Thu, 21 May 2020
 00:51:51 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] Needs of security patches on reference platforms
Thread-Topic: Needs of security patches on reference platforms
Thread-Index: AdYvCCtlcLXwbkOIQ0qYRTqGFX3KBw==
Date: Thu, 21 May 2020 00:51:51 +0000
Message-ID: 
 <TY2PR01MB497299162A4205C540691913A0B70@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 29139a00-bb63-4e65-b5e5-08d7fd21265e
x-ms-traffictypediagnostic: TY2PR01MB5196:
x-microsoft-antispam-prvs: 
 <TY2PR01MB51967C8DF3537BCFDD6328A3A0B70@TY2PR01MB5196.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 Bb2Nf8PRxwVNC4e+zOp7AWnvBVz9zfYfuPwSeh2U33M78fxCuDMI+OtKnL4B9ttMhGux+YdwIUuulsZKGE6s7xi45fL3PUCVot05sNgqrzKd6X7Sw83T2sXeSOSaiCNj2rpn+j4raWqu+j71XaA5wf3eWZgk2toZ0CwH5+qGceh7DYP+cmvrNq6Z3lygqTusSVouicQ6C2odpPP2auRgbRrHrAtuz2EVFPgcWT+Jregw1kLFKx7UC4tZTAAQ82xuzgbit7cf67GPh4SehO4cyQAGUfRi8l0Z6ZnLv3rNvny12NxynDyOzto8jF3LBkuk
x-ms-exchange-antispam-messagedata: 
 d/692uG8WmRszrEj8i4SSKOaYWKtxKEfgHQm7ED8D/sBcPVDfYKCGDt1aUce542HEQT4I0czTKhkC9Tiyga00ifCmMgboshoJirQblDjFHfNbPS6lz0piTbzVgOWirNZmRwKdfajygzezOdA3hwj9FYTPzw++1FulOw1g7O/hq3e8sUI9RJq76ikUbTzr1vvRi8BS91jlBDzNCT64xkDmFZLOAD6c8YhAuA1WWx7DWlVpm7lmtyHFVnmGNje7368yXK8DjbGN1r4ojhpWiD1Q+cNqhWWXiSefx4CU4Czi0DUKHg4TwMhDdd4/XIdxVH+9IdC7dosfH5C1/2rvv8LEeGEqC61czuZzfC1X+pssxxHnLicOnJfDN9X7xfjDSh97GHLi6+bOLi7aMMmH2PII1OLYiOrfbXLx9xl07kF5VNo1R4EzdQeVbki5p+vD+YabETS5bEk+OGDLo/vKUbuRqfZuC1WgzO2/PfR+6rgmT7Mcy5yzKulMk7QNFrcgXD4
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 29139a00-bb63-4e65-b5e5-08d7fd21265e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2020 00:51:51.4614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SdT+qJh3rX5liV/nYwmTqPuiWRnZ+8mI8O9zKGtoOEcEW6EDU6mBLcpZdYdOp78ehFqlwdiPedV0UCQ952pbYp9h/pNAIWGdS/5v/OC3Eqg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB5196
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: poCVc2O9Q8vGTTXewgj69K56x4520388AA=
Content-Type: multipart/mixed; boundary="7j1GeuQAy6cDNMGKChmc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1590022317;
 bh=xHzewCk2kH20PA1z2tBdyh5hL3Soi3hloPH1fAzPM9g=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=fKX8MhkTKs772Crld7DuYS3mTIThwj4gjGGeSlZHr99qbEGFJSCPaIBRcIy1cAxJ6by
 DJuIPbpnsjPQcEW2JzseQf7wY3r7Fp9QYoLddy/9WwPckZ4bzh2QDr7+V04xGLagim4KY
 oP8iV1CxFR1ca2f4hkBqxmq6cstUMJsvuPE=

--7j1GeuQAy6cDNMGKChmc
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi, board owners,
=20
At the IRC meeting (May 14th), the following two security patches were disc=
ussed.=20

 a. CVE related to KVM SVM on x86,
 b. XDP sockets enabled for Cyclone V

They were recently ported to upstream, and we would like to decide whether =
they should be backported to CIP or not.

Regarding a., SVM is for AMD CPUs only, so it might not actually be used.
If it is the case, we would like to ignore this patch.

Regarding b., XDP (express data path) is used for network intensive workloa=
ds to bypass certain parts of the network stack
So, it may be used by big tech / web stuff, not embedded.
If it is the case, we would like to ignore this patch as well.

Please let us know your comments.

Best regards,
--
M. Kudo


--7j1GeuQAy6cDNMGKChmc
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4636): https://lists.cip-project.org/g/cip-dev/message=
/4636
Mute This Topic: https://lists.cip-project.org/mt/74364844/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--7j1GeuQAy6cDNMGKChmc--
