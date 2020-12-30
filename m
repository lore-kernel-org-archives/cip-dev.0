Return-Path: <SRS0=DKgm=GC=lists.cip-project.org=bounce+64572+5984+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F14FC433DB
	for <cip-dev@archiver.kernel.org>; Wed, 30 Dec 2020 23:49:04 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 102BD207A6
	for <cip-dev@archiver.kernel.org>; Wed, 30 Dec 2020 23:49:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 102BD207A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5984+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id uz9fYY4521723xlSutgiRRkc; Wed, 30 Dec 2020 15:49:01 -0800
X-Received: from APC01-SG2-obe.outbound.protection.outlook.com (APC01-SG2-obe.outbound.protection.outlook.com [40.107.131.115])
 by mx.groups.io with SMTP id smtpd.web12.14760.1609372139899544614
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Dec 2020 15:49:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ahp1oA+8rUpHZebwq9NeOMGojiviQKE52CO+gL5FX8SguQDgiE82hf0OmwOAQnP7M6zF4OZJojFBLtrjqRq4pVqiH7vu3Kw7VcONOcPfB9+L0+f80ADLn6uzhzg83si4YSbFR5oYZETI2H+VcmSgjxTxfmOXUeoJQsAhmx5vcxxwei0jQRS1Zp9ZTYoyW2qmSbaASIT5LLUyoVjgTDyHwV4PWVmsW2RdMDHLgFLuU/YzDM6dAZZUk3gEyb6j23tZ4yevG4lYNmA1lf65Y1X9/s3MG2YIhcCA4730J1UpNvqA0kP8C4PiAt17TjcxT2RMiinYHtIrWpiv3F/NvYJO1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Ez69Wjj0bwvVqzKW0v+EjRdcgjRp/bK5wkAursh+Ro=;
 b=V1dJhv0aSFRDNT3As51Ct9LWqTf4wWsxfnHB4H63dcAUsGzw40XeYgUBMVJNvN53JiHzXSXMaHf512lMIAYpPX1Tmvk9SfEkMo9ZqZm1GoOWgzHnYg+Bzmwf2Dh0gGBOqKdQ89qaM/760IdUbURTjtWMpVvQhOPy5tdls2b5+nTGhTm1Y0kpwNzXbdXx9ebFHJXJl3t7H4aJBV1I1wqfDB5rNC9RX7BBqLLvZbApqK2dX42o5A68kbrVt/Ar1Lpf/Z20ZLAx36Q1Rz3rxreCeQbev3Z4anyIsoAq+nCXVX9d7HUK8aUfWzWZ1wpjfnpmfthWbTo8X7+qGUjufcaDug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TY2PR01MB3786.jpnprd01.prod.outlook.com (2603:1096:404:de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20; Wed, 30 Dec
 2020 23:48:41 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::caa:c807:5f07:795e]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::caa:c807:5f07:795e%7]) with mapi id 15.20.3721.020; Wed, 30 Dec 2020
 23:48:41 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] NO IRC MEETING TODAY
Thread-Topic: NO IRC MEETING TODAY
Thread-Index: AdbfBhrd8R0hTCDaSbW9ruNlKp6MGQ==
Date: Wed, 30 Dec 2020 23:48:40 +0000
Message-ID: 
 <TY2PR01MB497279E4125E99432E20B7AEA0D70@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 42a0ea68-0dbf-40c8-9e76-08d8ad1d6fa3
x-ms-traffictypediagnostic: TY2PR01MB3786:
x-microsoft-antispam-prvs: 
 <TY2PR01MB37861B76EB91C4D98AED1AA1A0D70@TY2PR01MB3786.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1148;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 3DCqg3518x7GICoDcc01q1vXSTQpVj6uVa17pD486CLMWvhqWqMbbff2XV8MezxdKOtg2ipK90VpEw/brLjZuWaZvpdpjkPxyVDVVFMIlX85pNx/ZRVPMrHiObXHEvh/8axZ4LiNjHFv3AEicLlmQzGKoiBZWxDEP9uRc63h4foSuEQg80BNbB/s8N1/UvY3/rXRXPUmnVG8qZ9FmotWBA7TRfb50C8LkJF7/InwqaYZbSvtQTS0SnHDVvemsusIPCJV73aHFkFbZ87rq0IRA81LlOrzU9Q0y60RnmFPWKxXj1CxExwK9WuRPJc5+7btidtWgCZFjdJG7imEgFZfaRgIzHFmvYbNRJFg1NqFs4qMWYQrYnnEDIxFdiHmpbFYBOVdcQivrbZaCWAPCCZeuQ==
x-ms-exchange-antispam-messagedata: 
 =?iso-2022-jp?B?TXJqbzd5UUJacW9aQ0Yva1ZiOTVQc1dhL1E5bGQvTUZ5SVlreVUwNlZ4?=
 =?iso-2022-jp?B?ZVBCVFVucExZdDFsY2c2VkpWeU9wQUZGVmpZd0g2ZHc2QlhQdWE2L3pz?=
 =?iso-2022-jp?B?VE9Lek5NZlorZ1lzYm9GbGVYYzRBak5xYUQ1V1RLb0c0WGsyZzFQRWhL?=
 =?iso-2022-jp?B?VU5vOUg5UDRkNVlKZEQ5bWowc2EzZ2xhbkVqWUJSYk4zRHdKUG1KUENz?=
 =?iso-2022-jp?B?NHdUT0RoUEliNSt0SXV6ZGdETWNYS0FRYk5yYTAxZGM5MDRwajErV3Z4?=
 =?iso-2022-jp?B?b0U0eGRXdmxKMGo0ZnM0cDF1VkxkaFcwckZ6bE93OTBHRDdQNUZ1Y2Jr?=
 =?iso-2022-jp?B?SzhLek1QQWNQbGhmaHZzOE9tTmNSZ1RtUXVTUDRvV1ppbGZ4Q1hCeVJn?=
 =?iso-2022-jp?B?S0QvTzJ3TUtqem9tNjdKZ05ONTFrRlpxaGF1bERGTXBvaTd5amo4NmN2?=
 =?iso-2022-jp?B?SmpDaVc5OXFVQ1ZsamJ5d3NJSFZYRG84WC94ZzlnNGJQWHVuQjJLVGlx?=
 =?iso-2022-jp?B?OGRHVTRHNnRYd1RNNThtUzFnTzBieVh5SlJycHBjVHNUK1JVditNQXlE?=
 =?iso-2022-jp?B?TStYc3NBcURXa2g5MXdDT01uMnBXd3RLaHR4YjY0NzBrcWJoVzlWWXZM?=
 =?iso-2022-jp?B?VUtmM2pTcjk0T2xKeHFVSmwvdzQvVS9PejF6bWpsT21ycFRNdmpOb3Rk?=
 =?iso-2022-jp?B?aGluK2E5cUJ1ck1UYXhLYkFtcS9SU3NTVnBuMTJSNmMvUGdub0hMMWg2?=
 =?iso-2022-jp?B?WFVxcDhBeVBJTU1DRTZpNlpDcnorcGc1NFh1L0NoNDU2SGpwNTB2RmtX?=
 =?iso-2022-jp?B?SkdBdXRKN3NwVkNpVWxZeGZBU2thcDMxTkRLdEF5WVNaa096cnI2QXVV?=
 =?iso-2022-jp?B?UnhRbFg2eHFsWlJxYjJpODBDdWVwWllPMi9OZDhyYWw0UUNNbjIwcDFw?=
 =?iso-2022-jp?B?TDBkeGtCUmsxZlc2azFqMytXQlphWFJON0dyTUN6VC9QRVZsSDdsQ2ZR?=
 =?iso-2022-jp?B?aVNpaXc4aVBaQ1NCZTFVZFFWZDJ4MHpLdE1Sb1NZVUY0T3BXOTVGL3ZU?=
 =?iso-2022-jp?B?cGFYRnA1QzFRWDhMRGltUnpMQnpCSUE2T0lTbmk5L3paVHRObDM3aVZI?=
 =?iso-2022-jp?B?SE95elc1eHRoYWd5b0t0dzhON3dSVUZNTkt3bXo2VVphblNpUTVWczg0?=
 =?iso-2022-jp?B?dTlTeHRWeVhDT213d0FySlpsOVJyRWVMSFBLZkdWT3AvR2I3TU9qMENU?=
 =?iso-2022-jp?B?WStCNkJaZlBrZ0E0NmZySjJtbGNTVXI2NWJRUEx5Qi9zR3ZOcHdJRUdk?=
 =?iso-2022-jp?B?eUlQZi94d0pYV1dDU3FBQS94bVNpY3hYU0V6RVcwbG4zNVBtOFllR3ZR?=
 =?iso-2022-jp?B?dS9TbEozblVuanFHM0I2WFkwZ2YyT053V1FyQkRrZzlic0ZJZz0=?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42a0ea68-0dbf-40c8-9e76-08d8ad1d6fa3
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2020 23:48:41.0326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P5YtvFOkNQ3MSOZ0m5kLbk2J6x6E/Ch9N+K3q9kwYY5FZ8zQPpD972gLHVOvbVXMHH7P2sRoS2UDDwkQ9Z7OpSrDJAbGmIBfNxI6eD3s+mU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3786
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: KiUpa2fVaRMTmeGMM6g2tZ7dx4520388AA=
Content-Type: multipart/mixed; boundary="6msb3X6aBnvVMtnbqsga"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1609372141;
 bh=zw6aX527E70wdT0E0847WizgNt9OJg7+KLVhRCYAPj8=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=sP7ypsl+BrXZcKxRu/uAC/pQEFOp3nd5oSlTZCdcunF2lMycsqoTzJBvZVA3GMgXhfA
 K3z76RXsUSRkoYtphUskkiRvdf0FZd8kIDBGi+eNJpu9XW55y/5vp8mdLS0PqoC3gEMo/
 622BPN30cDMW7tMgmHl/3Vq9px7xUSgM1BM=

--6msb3X6aBnvVMtnbqsga
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi, All,

As we discussed, there is NO IRC meeting today.

See you on 7th January, and have a happy new year!
--
M. Kudo


--6msb3X6aBnvVMtnbqsga
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5984): https://lists.cip-project.org/g/cip-dev/message=
/5984
Mute This Topic: https://lists.cip-project.org/mt/79324902/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--6msb3X6aBnvVMtnbqsga--
