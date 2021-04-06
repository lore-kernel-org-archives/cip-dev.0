Return-Path: <SRS0=h/tx=JD=lists.cip-project.org=bounce+64572+6342+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7031DC433B4
	for <cip-dev@archiver.kernel.org>; Tue,  6 Apr 2021 07:48:34 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B552613B7
	for <cip-dev@archiver.kernel.org>; Tue,  6 Apr 2021 07:48:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B552613B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6342+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id dZq9YY4521723xmuPTCakhlY; Tue, 06 Apr 2021 00:48:33 -0700
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.123])
 by mx.groups.io with SMTP id smtpd.web08.8830.1617695311859203258
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Apr 2021 00:48:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H8RzBKrg009G99Ts2fRednUMcSkh1ecwZhsR/RVPsjePzo7VncJ0xMKQVru3DTW4jYJzQaoJc1/KH6hgnpSnqBq4GYk9y8ANpMmWgvj+OraUUgtE5mHKwHegHlbm+xUp9/jabPJmOW/HsyGo4riYtivstLbTiM+TFaDnYXPOZ3CHNuwmQgb8Ue8ZMy4LFe+4y4Z5aibS7zn/yEKEoZc9+IkzS5l7tOjt+b4kG41LAbMQrkxZ5o6XM+4eEx2XA+Su3oTRFjXr0M4QcpZ9ujyspENHWhYmBv4J7PFdZgHupaweFnpotEpEkW+VPvyZiZ+Ypjxzu1YSB2fP/Hq5oSnwdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrDoZEwfE9OtI04y7RR+mm7kxUVM7NFiAAoflm71rWU=;
 b=D/07YcC3zIN8OsAbg4W9NQ+vNwOIGyxZEC1eV0tdsj9PLPMnip4fo8OtySIUVIBKclnJJLcGWytK4SBg2Bcyleu2VrUVNtk90Khtf6GAhhVezFl0sdgyNgAv303cG4e25tOifaelXrzSdX6eo0akda2bo3+1GsHXAtTsMSSFPpPMZxj2wChwSHb1QoTz/wPlyAw0mE+WJdk7d5/Y3/+dhGg3Q9fNabylBrhW6Ein9RhOJPn9YY0RDKmWb3QiYD2F54hp77B9LckOEwB690VX84irKfQTF9g5SDM68JKKxwfdiePB8f06RvUVmMSDr04TG6G+VwINqLVbtKGnwXySgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
X-Received: from OSAPR01MB2385.jpnprd01.prod.outlook.com (2603:1096:603:37::20)
 by OSBPR01MB2535.jpnprd01.prod.outlook.com (2603:1096:604:22::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Tue, 6 Apr
 2021 07:48:27 +0000
X-Received: from OSAPR01MB2385.jpnprd01.prod.outlook.com
 ([fe80::6064:8513:28e:374e]) by OSAPR01MB2385.jpnprd01.prod.outlook.com
 ([fe80::6064:8513:28e:374e%7]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 07:48:27 +0000
From: "Chris Paterson" <chris.paterson2@renesas.com>
To: Pavel Machek <pavel@denx.de>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] -stable-rc tests failing
Thread-Topic: -stable-rc tests failing
Thread-Index: AQHXKim90QtEV4hm1kmRsm2uxgSD0aqnHYdg
Date: Tue, 6 Apr 2021 07:48:27 +0000
Message-ID: 
 <OSAPR01MB2385B88B981CFF4D86C43F3BB7769@OSAPR01MB2385.jpnprd01.prod.outlook.com>
References: <20210405144110.GA29465@amd>
In-Reply-To: <20210405144110.GA29465@amd>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.46.105.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3fef7c27-f22e-426d-aa47-08d8f8d05d77
x-ms-traffictypediagnostic: OSBPR01MB2535:
x-microsoft-antispam-prvs: 
 <OSBPR01MB2535EA91D1039F213649CC41B7769@OSBPR01MB2535.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 Y6x6ehvxD9u7s/Sv1ESj3HbcFTVUQjo49xX18sAJ5XOd9dV7kq67pyuK0rBGMKXEu4BBcl/i9icvO34xJvM87/A/pOB0MQLPeuNE2xxIp4rlMTMx3cY7rn02PFbgF38/M1+L4wDXPSiSVmJGpIwxzkufZgD3YlH4yrLFbi4Udqut0G+B0f+6uxLy7yPrY9vSEhGIc6OoxvsV8OeRzp9ljVVFj8b5GLofs55xYNyDfvmB+ktt7sF2ykRkXSSTKp/3fvafJZ8toiXTeUdpkk6TIctVJVLTHyM+8938xxKWNRmtlAeUyjNVULHJpYBSwxYvA9rhEbNsjBbIfH3cHZn34NLiya2xU431jtnmJNkIUqSy8YjGl2M61OIjEqTlJXswOuege/4wLh2dLNQWrXCAufZZM5A04yj6UZEZstU3WebLROXex0ImZ1MCNMj04PraUXYoC7AJKePkxeXg52l0CIws6FL1q53/VsqRhd205HWntcLOvnqpabQvbJ2N9+sv/HvBfhFjs1+oVo1SSYcLP1ppabi+uUXW3YWlffhKBazWMx8He3fNqy26AnxJ3MQ7F0xeAy0t/3KmRZU0UVuLXoXszShENUaCSnMxsG8E175bmEE46RybDbXNH7GtrwjEHng5E5IESxfvOL8fOFrCnex0CagcsnQsgeQUYA5uqjHbSRadUfzO+tx7xK7+GlhytM+aIQdKXm3RJ4SHQ+D4W18Ku9b4tOVB+am1OJDqvsQ=
x-ms-exchange-antispam-messagedata: 
 =?Windows-1252?Q?x0Sff+LduL9bxqbHE9d9rZJFd4Xt/wcAgAVXr/DYyT7T75f9WjdaWiv1?=
 =?Windows-1252?Q?+9mWs+sO9jGxn4B2fJXAt9rt6DbpPWmLGOAHcDEeoAhwzAiUDB1Fpdkm?=
 =?Windows-1252?Q?R/ZjN/LZDdCl/LWz6A+iLneXyFoV9Ye+rTEUSz02GFqQ3stbajyv/7eK?=
 =?Windows-1252?Q?RFAaJuSTugunMjPKvyNXVoKEdtK4aUEe73FbwwPnmaVmRFjCgXBTf6ZV?=
 =?Windows-1252?Q?dTvxKxzceC9cZ0KpSgbbfkhTjTfDo3mWgwxbrCKoES+HBAskzfvYAuNa?=
 =?Windows-1252?Q?GPBqdKMI91egLHdKHYv56cNU653Nor0GWFS5SjwDzfP/HHvhBug08iuP?=
 =?Windows-1252?Q?DtZlvxjpaMVJQkFhmZvjoFbIB9wxY5LQ/pBZtNbwBEkmOlPWK6ZUSrdh?=
 =?Windows-1252?Q?gvbvtMxlAin622lG1R3VGsAlSJe9xqs0YaB3XrxaDwzAwyAZ6L3XE8Cz?=
 =?Windows-1252?Q?e9lY8XrMHGprLdtq/cyAMY4aofgpuQKjOBhrjKetlBmR2KlgINu4/7fV?=
 =?Windows-1252?Q?xPqvEhxDabAe/ei5MT1pkncoxxkjq3JIWwve/Iz9texpYKwfA2lkDiNT?=
 =?Windows-1252?Q?9lMJPbH6zQRGAwhRvmDcj/pv+yUCpyTKQ6cb+TX7/RuKPVQpPZqv/o5p?=
 =?Windows-1252?Q?hyHveh7+Hzp7jKGc8u4VANKB+MCEfmfxHbmp0o9oZHFuCqXIvAr3t2Db?=
 =?Windows-1252?Q?qylwbbh/094ukd+zpj9Pr7mJg9JkHGprI1inaIXCEeC2OaNjeoTylFEX?=
 =?Windows-1252?Q?LGvUNhb6jaEiPpe465NGKTwczg0np1AMlPRMbeyQgRkZzNm8aZL3gjIE?=
 =?Windows-1252?Q?sacSA1fF7fU3R/nZU8R1fdIDiD68Kcy+TXFYVc7HZol+FmfJiurmzEbP?=
 =?Windows-1252?Q?YP51agcORIp0fRpcqkchqpfENlvCGqGIbP6A/EJzcE0YpMWehwrKQVsE?=
 =?Windows-1252?Q?tMrv4e9R2/I0+odATn9PuxYwjce9XPuAnkeb4XmelQnm/LcXN7UKn6W3?=
 =?Windows-1252?Q?x49gpDxXKfhX8x5lx6peUd448jtV2vx3y4tjtqOj6HH0nd8Zanhq5yCc?=
 =?Windows-1252?Q?f77+62hsElJAW21iZ1Bzfb8DIu+ad/agQYcU1GcZy4PAGo0i0RxbCsz5?=
 =?Windows-1252?Q?lAZVmdLn8eZeKipocfFu/YlzJVQp3+g06fzKTgjn0nnjh8zTmkrfoGxK?=
 =?Windows-1252?Q?nwQxQyxElYgbPc18lhEEtYaoFqFySRguI/6sCJhdFzNjxvkhuv7Yu3Ar?=
 =?Windows-1252?Q?CoY6/RWAqoAcryZTVJSyOG71g6/3lUkxiqnln2LBZNj+in2eOOhrVsET?=
 =?Windows-1252?Q?E5SU+i9garOJEw/OiYCVbvXe9H8kwhTosrH2eZYw8inDytIXeV1nGL1+?=
 =?Windows-1252?Q?niBUxiGmdjLEmKRByOAN/z5EN90Wj2+Vzrc=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB2385.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fef7c27-f22e-426d-aa47-08d8f8d05d77
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2021 07:48:27.6465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s0ZPUd/9qyhSWL5XzoXUPjc45WUX4gCILp4SD6hDJV2Zc0jUWOJmCf/BDgNzELcgY2UjyGPwGmEpWgPv2Z2tKuiGhSbLZX2a0JKq2yYrDzI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2535
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 4SBQ3mjJskd46WjKCT7BMBdvx4520388AA=
Content-Type: multipart/mixed; boundary="lCcdHlM9oSPe94iYehQE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1617695313;
 bh=2PyXyYRgc7eVGoRV/OqatBMVS5KosLWNVy//XmH5wxI=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=b7bCcz4SgPabtHk7iQReDAZbHqpvI1u6mwweX/2YigILw3opiKY0E9lPRLc6b2Ak6Yv
 L+3KBkq+vlzBZt+1ztZqlR9MfgaIDEzsM+6ptOm7JxN6291tlb+E2NpwhL1wgHVMRy832
 0oyBDFcKi8ZEHbKWzLUnKIIiYxfHK6C75kc=

--lCcdHlM9oSPe94iYehQE
Content-Language: en-US
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hello Pavel,

> From: Pavel Machek <pavel@denx.de>
> Sent: 05 April 2021 15:41
>
> Hi!
>
> Every single test in -stable-rc series fails:
>
> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linu=
x-
> 4.4.y
> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linu=
x-
> 4.19.y
> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linu=
x-
> 5.10.y
>
> I attempted to re-run a few, but I don't think it will fix
> anything. IIRC LAVA labs should be up now, so it would be cool if
> someone could investigate.

It looks like the server isn't processing any new jobs - they just stay in =
the queue.
I'll investigate, sorry for the disruption.

Kind regards, Chris

>
> Best regards,
> =A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=
=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=
 =A0=A0=A0=A0=A0=A0=A0 Pavel
> --
> DENX Software Engineering GmbH,=A0=A0=A0=A0=A0 Managing Director: Wolfgan=
g Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--lCcdHlM9oSPe94iYehQE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6342): https://lists.cip-project.org/g/cip-dev/message=
/6342
Mute This Topic: https://lists.cip-project.org/mt/81865407/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--lCcdHlM9oSPe94iYehQE--
