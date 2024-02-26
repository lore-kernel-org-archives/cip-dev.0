Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE28FC48BF6
	for <webhook@archiver.kernel.org>; Mon, 26 Feb 2024 10:06:58 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.52])
 by mx.groups.io with SMTP id smtpd.web11.17112.1708942013703708338
 for <cip-dev@lists.cip-project.org>;
 Mon, 26 Feb 2024 02:06:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=Y4xEjchp;
 spf=pass (domain: renesas.com, ip: 40.107.113.52, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gJM7hDkNARF9gNZimkLcjb7ObL7LakiERtkNnlMiVj0toaxPLnEzj8AHEetuxLCI95GNKC+INh4RVHUgFSdc067PPobzA5Hj/tNytnKPHpiUlfSuwff/adDfRPZM4hAaGK/G5cWpEg61zP76veiwA3Wv0SPCMkKH1lAbzFdSBkD7UwD/HjPlFUWEGHlem8LIOpdRZ2ECcslu2gH8nIO+u1q9bC3jDW+kkttPD0orijxMVFPCNzcgeQonbPxkeIMFmPBu+KgeC/3mWxhA+q7f9N+4r7bs3ENA6Wck6MyFEbYWNEXxaglebQOSEPehN6DxKmI2hSkhAfpDmSkPvV2fJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wcihdohOxexafuVsghRjMT5OV+GvYvj7Ew0rvRnUINs=;
 b=Xigb14j6VjvE+HsEovmTbwsSjfA3rsksYQ+wmmozON63F0fGzNVAp1Ua4Irc+oyh3tVvQjauIPexzieUGKMNfR5y/a1wahUb5T0VbxRxu2IZvGFSABTlWno/zXgFJZq6jlbQ5DfQlt7Tm2jSpaiTVhtDJU/9wiI5vEYS+ue/6lbw+xeeGIyvdIOQvJTLSt+4j0V7dpPzgdqt5yUT3D3RY+XFuXrzJfYOhDctQkz+I/Tz+myl7rgZLT0sxz1/JaFOtuOIIhEEDIRKMvFNxiHQrwJtVyOC9d6DbEwVMYgPqUsjJtqSkgPTmiV6dtZzhUoH2DRb3jPfNArPZ0TPBhsnRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wcihdohOxexafuVsghRjMT5OV+GvYvj7Ew0rvRnUINs=;
 b=Y4xEjchp/56JYo9CyPNZdaSGFnvCd1zmYIPSfpLrHnoPlodY5kH256m0yJsTtWj4LZjxTvKdLDE9eqH4J2b2Y57IzYKFGDQa5eYGOdNDcpTHrSaEFSFM2B//lz0gXD6WVoLhFKxd+Jp1nJ1WGp4CodHFRVIGqQrkKGKc4wkmJeo=
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com (2603:1096:400:3fc::6)
 by TYCPR01MB8613.jpnprd01.prod.outlook.com (2603:1096:400:152::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Mon, 26 Feb
 2024 10:06:49 +0000
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::e2dc:b904:635f:ba5f]) by TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::e2dc:b904:635f:ba5f%4]) with mapi id 15.20.7316.034; Mon, 26 Feb 2024
 10:06:49 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "pavel@denx.de"
	<pavel@denx.de>, "uli@fpond.eu" <uli@fpond.eu>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>
Subject: RE: [ANNOUNCE] Release and and v6.1.78-cip15
Thread-Topic: [ANNOUNCE] Release and and v6.1.78-cip15
Thread-Index: AdpoQf4KVYZKcHo4TqmVXGd1zVw9KAAWP8jQ
Date: Mon, 26 Feb 2024 10:06:49 +0000
Message-ID: 
 <TYWPR01MB11862EE8B1050FA1EC2B312B4B75A2@TYWPR01MB11862.jpnprd01.prod.outlook.com>
References: 
 <OS0PR01MB638897353A24F4F48F8E0819925B2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS0PR01MB638897353A24F4F48F8E0819925B2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB11862:EE_|TYCPR01MB8613:EE_
x-ms-office365-filtering-correlation-id: d14077bd-2337-4eb3-3d7a-08dc36b2a5ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 OCkO7IpFH62N9xB/hQD5ERghgB86hkllv96FqHXOIjiseGN2Wp6mgti7U5jrbGZNtCvV0KJPlqS9/pwk+NXXO3+xwPnd53r4orSujqK6KylDQmGpC3tWCNnu5jIkCVhY4SWdvadqQCtNtGnPjueouFYXQqMX7fEKZ0B83h+lfuB8XlIy3386+uXXhBeVio3TG6Bt1ITd/Gg1bDhNDS9w5hpyinCC2E1CDJ47HDhK0KBzEsxSmLGDNhcczicdTxIJlzagTQwKpNUHUqn7pf17hiRsmBf0TQcEeK2T59s/P/Vl5Kt+cy06htPSSSPlV0nx3CHYM+lwI6tB2RhYXhIt0bvCjAJWyJrNgC6hVws80K+EElgNc4zqG+TN/LJkzuivMMxytQr+kI+nM/utKoQ+hF5vIIadSww/rnxtrG4f9adGhfjwq80ADUz0esW8IcTmxUUPQ4csvEKh+Y8TRkpeLJwdCt4tpi7O8qmC4wGbyoDD1Q5xM8OIItAUOc3YlD6OJBhfFC41AeEf1ixpuLxwjttBd75cMOVQq/e2r7MZh5njfBL7aI8vcfo51P1G5crnAH2J6h5gfryty5UjvRVgVUqI1qKA2wPdQlaJDx1E52E4oFFklixnrlIZ7GwMxyu/tiDa2K5OdRM8H7X+MSWSHXJqk79mRYy9KErS6ARmm9LMnC3XgDlEG6UhbTOQmI9J9fTwDJr+79ZSbOBazXjnxg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB11862.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?SNNiGyqSYsfHtLVDdbwOjvkX/F4GhzUBp9A9jxzY6bFgDUiQN9IzmvYu?=
 =?Windows-1252?Q?j1GWURo6aCNf+hmUnxcHTARMsuwYF5yAbpHhzG6zvp3X0FyRfxbtiFIv?=
 =?Windows-1252?Q?7mMm96+IJ7Jf7kCmaiDZNISIJ8yad87gPgd9ntJJwFtOvaUtDvHfV9Dd?=
 =?Windows-1252?Q?VJxWBQWvtiSODu4zVBrSQ5w+OyVqqpO/520Vmn9/e9yRuoEvhsZ3en/M?=
 =?Windows-1252?Q?xtPb1Vu0IaK/K/wUXMBriaXiDgV/zvhDtdt4cD+ZgIwhqMBHX66VqCS/?=
 =?Windows-1252?Q?SL/IsZx4SlrOPwr2WJI7H1257ykmGjxuL5+R0znjPiiwzsfqorrpRPGT?=
 =?Windows-1252?Q?cbGZJnj/ZBj/VS+vmQ+yqD9A+AoBjX/53LSPNcxpRzK62o8jDLvhk3nG?=
 =?Windows-1252?Q?s0yTIajBmaXe9jGWPb+PHli7WQAxAaJG5ST5YWevzorkcxGKjLSpT0Dy?=
 =?Windows-1252?Q?QUzSx10kQGcfmaTS5jR5+ZN1MzLE9gS515L5ORUz9ilWjvpNERdlJwQX?=
 =?Windows-1252?Q?WqVyIA+VwSbJVAN1GBVvTM4njM7f7aSA5GI+FWZazfynGY9IQu2jyJwL?=
 =?Windows-1252?Q?+8x2V5zjdMH0IqkNGvcQiNnSA21KvGVpUOKquWlKZzLkIjnaAuF3dTGy?=
 =?Windows-1252?Q?MrwTeFKJh1N2gub879WomzRz2BfUbCoOaJ0ieeRWIDpcrOe5rvJhJ0yL?=
 =?Windows-1252?Q?O09ZuMsipyfQoyVyx8lLBffQEQF3KkLTnOWfSckZ9hc65X6MfbODJje/?=
 =?Windows-1252?Q?w53aRXFvjAgjr7uVKv0curPFLE/gUyH/sWS342oOKgwhXJ3Zvq0vDUKu?=
 =?Windows-1252?Q?M+fXuDvlN4fmR856B79LznNKvM8k2qQWnqZDczNhMiwaqZhAlFCK9hfD?=
 =?Windows-1252?Q?vTQLT9Rp9cIMXnxOnPDNKXl+FSBBIAbkvaU45d7GjYRal3uNVvPFKaHu?=
 =?Windows-1252?Q?+0BjxiBDNPXoGCSTOCYw52IzBH/PBbb70EEM3T0/vZfdo3SPWloqHwhK?=
 =?Windows-1252?Q?jWX+8/GpPwrVIEaULjAnz16D1BL9sXxuwWV5wZjuTPfGjauFPU81g7my?=
 =?Windows-1252?Q?xVOdllCHq+PXEYhvgmoK6N3E2HYiZ/HhppBE3gn1X0A0rBxTxtEpm994?=
 =?Windows-1252?Q?tw9Z2j1bO7D9W5+NA0AEWpmjXSuCK7Ar4PlGsSfN2+3sqk4D5P/Q1RKo?=
 =?Windows-1252?Q?IcMWlt87jQAZkbw01D1YEWvpe19hh1rW9oQ47ZifsVmZf/g5IsKA2oNq?=
 =?Windows-1252?Q?QlWl0SFyArA+em1V+12v4qhTxhuoGu9vrfee174dV872uHD0Ht8rqstW?=
 =?Windows-1252?Q?k3i4YS5x3SMFjZ1/l8siQfqr0Tf3PJpCJ6GgM4Hr3wYPq0lf7pNsFi8y?=
 =?Windows-1252?Q?uJHFlCXz2LaeA9qAqx+sJfsBilA3eglQItvNzgJfsw1U+ZpWV/Nooj9g?=
 =?Windows-1252?Q?mq73MIOPVgmIaGQ+ZbRR0w60NSvMyy8SDS4J0gmy3dHruWcenaGbPRNH?=
 =?Windows-1252?Q?GcPRPgSEty066pmK8fsyrt84cwGGn18f913DcTKL+1QSqJKVjMVeMwTe?=
 =?Windows-1252?Q?Gj08IkrT4FL7J582Me2ooJdZGrVrTcD4X9SrAdh8Au2Wf/Lv01oX5d9x?=
 =?Windows-1252?Q?etTFDxTufRVVXxu7v6eeVbaEeY4mop4MJTl/9K0pQ4SFAjmdxBo5CT3F?=
 =?Windows-1252?Q?1jwK9p/PB5KG2MDl9t16YRUp6CsYNoV5hAVJU9ADpkBm/VSTDn2nxA?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB11862.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d14077bd-2337-4eb3-3d7a-08dc36b2a5ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2024 10:06:49.0790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5jnMdFzbsFGh9+KSBdlwpRS3WPypbhml6S0hHwklTcZ82QBBdAavuZL8yZgt8fbfjZD4pUeAFSWK5yViKdxq6hR8QDNtHOWDlLNHNYAt1Lo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8613
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 26 Feb 2024 10:06:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15087

Hello,

> From: nobuhiro1.iwamatsu@toshiba.co.jp
> <nobuhiro1.iwamatsu@toshiba.co.jp>
> Sent: Sunday, February 25, 2024 11:27 PM
>=20
> Hi,
>=20
> CIP kernel team has released Linux kernel v6.1.78-cip15.
> The linux-6.1.y-cip tree has been updated base version from v6.1.75 to
> v6.1.78.
> And this release adds device versaclock3 fixes for Renesas ARM SoCs.
>=20
> You can get this release via the git tree at:
>=20
>   v6.1.78-cip15:
>     repository:
>       https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git=20
>     branch:
>       linux-6.1.y-cip
>     commit hash:
>       8e0cf035f64a98ea0d7ed2527a547f39866c37ba
>     Fixed CVEs:
>       CVE-2024-26581: netfilter: nft_set_rbtree: skip end interval elemen=
t
> from gc
>       CVE-2024-0340: vhost: use kzalloc() instead of kmalloc() followed b=
y
> memset()
>       CVE-2024-1086: netfilter: nf_tables: reject QUEUE/DROP verdict
> parameters
>       CVE-2024-23849: net/rds: Fix UBSAN: array-index-out-of-bounds in
> rds_cmsg_recv
>     added commits:
>       CIP: Bump version suffix to -cip15 after merge from stable
>       clk: versaclock3: Drop ret variable
>       clk: versaclock3: Add missing space between ')' and '{'
>       clk: versaclock3: Use u8 return type for get_parent() callback
>       clk: versaclock3: Avoid unnecessary padding
>       clk: versaclock3: Update vc3_get_div() to avoid divide by zero
>       arm64: defconfig: Enable Renesas VersaClock 3 clock generator confi=
g

Test results:=20
- Dashboard: https://squad.ciplatform.org/linux-cip/linux-6.1.y-cip/build/6=
.1.78-cip15_8e0cf035f/
- Results comparison with previous release: https://squad.ciplatform.org/_/=
comparebuilds/?project=3Dlinux-cip/linux-6.1.y-cip&baseline=3D6.1.75-cip14_=
f555c0a7f&target=3D6.1.78-cip15_8e0cf035f&comparison_type=3Dtest
- Summary: No new regressions

Kind regards, Chris

>=20
> Best regards,
>    Nobuhiro


