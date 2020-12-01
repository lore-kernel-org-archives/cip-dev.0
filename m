Return-Path: <SRS0=qKAi=FF=lists.cip-project.org=bounce+64572+5928+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF20EC64E7A
	for <cip-dev@archiver.kernel.org>; Tue,  1 Dec 2020 09:52:37 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D5AE20657
	for <cip-dev@archiver.kernel.org>; Tue,  1 Dec 2020 09:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="PLmSdg8q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D5AE20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5928+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id nSIAYY4521723xFPVCdXDV14; Tue, 01 Dec 2020 01:52:36 -0800
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.118])
 by mx.groups.io with SMTP id smtpd.web10.7976.1606816354885368164
 for <cip-dev@lists.cip-project.org>;
 Tue, 01 Dec 2020 01:52:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q1n+rM3qKtlVXTeuKvtj40PTJaK/I4nxKlF+i+hoUmpGaPQwyRFCcitLPAKb3Wejlcj8t/TIfQvh9yL5uxXf0+3xuXRdkZaL155R2sjZe3OTEXXo/bj8dmiXLYlF1kA2YZ+vN/akYKVHEDfYpBiABmBKVETtt3U7cPDa0e8f3VysuepmdZfrEnCK0fDGahU4eRdjj5Lm5cQKgusB//XR2N+UlYuR25ovZRqk8ndSyQdyYKypteE3HnfGyuaAtwF9dv/U1nTObjXrDCT5MZIpruh3sRLWRlbVh1pTIriWVChqzGqEBXU1P8o461lwCzVdpUl8CmIRGGMU4fdM5WO/3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Znk+EiUvBx89CfXahqk4l9dO/tlJEHTu62fALg60GkU=;
 b=KEPieWoSt54JkNPq7MmUIkkJ3w5r3y5usJxD7CZcxIvnu8XVp5pr5UzOiqYrIAWf6WAfVU7uPB3GpG7naiCgPfKVBs3UCIoeWmZI+dur/BFajM7z3PoJlxcAChA2hO6Md0PVZG+jGykb5Y5CBUwKBYcHwVV+KEd2s61cmDGcpHULxbB5VhebmHZXs+5r02cGlyCm5fJSm1uDxzQxMCGMM+AUIcA3D8OS8ombfN+PRPDkrQDou/tlD3xIFU0BjXa0iRfJf8hPrO8TL0faFuLrFzblq/vayWg0zR1kDu5rocWzBotwsZ3jvSFSwOeOrNE8kWINqg7s2PJRMpHWvW+y1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
X-Received: from OSAPR01MB2385.jpnprd01.prod.outlook.com (2603:1096:603:37::20)
 by OSAPR01MB3459.jpnprd01.prod.outlook.com (2603:1096:604:32::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Tue, 1 Dec
 2020 09:52:31 +0000
X-Received: from OSAPR01MB2385.jpnprd01.prod.outlook.com
 ([fe80::89ef:c893:5ca0:260b]) by OSAPR01MB2385.jpnprd01.prod.outlook.com
 ([fe80::89ef:c893:5ca0:260b%5]) with mapi id 15.20.3611.025; Tue, 1 Dec 2020
 09:52:31 +0000
From: "Chris Paterson" <chris.paterson2@renesas.com>
To: Pavel Machek <pavel@denx.de>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] A lot of compiles failing
Thread-Topic: A lot of compiles failing
Thread-Index: AQHWwcw2bUEFU7gQAk6GvCmlLqJ2gKniC1rg
Date: Tue, 1 Dec 2020 09:52:31 +0000
Message-ID: 
 <OSAPR01MB23853004B735A607C4BEE0C5B7F40@OSAPR01MB2385.jpnprd01.prod.outlook.com>
References: <20201123190940.GA13627@duo.ucw.cz>
In-Reply-To: <20201123190940.GA13627@duo.ucw.cz>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [86.164.55.174]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 50c8563d-b8a8-4233-47b8-08d895ded26b
x-ms-traffictypediagnostic: OSAPR01MB3459:
x-microsoft-antispam-prvs: 
 <OSAPR01MB345914E4B2F2BE63C7010B02B7F40@OSAPR01MB3459.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 kN0z2BM/u519NXdLO8/15ZYJkxzxMGnqRYXxA8An3bUu4wkmlyE8cmwSw0BhRGAhTcLqsLmyvJyPFdiG3EBlCtzg+9JMn/svpJJfeHQ5qZmw1V/TvvB3afSzNPF5X6aBEX6cnJIl2cnOR3gYglaw4oND0BNJfxafTXte8eDhvPHzACzKS+M2odFwZmcGIJ3P+4LOw/koQUde5tBvx0803Sgu4JN0lC4EpohScKEQwgGRzIWnzNgHA2hb2XnyyYKoQeg+HVFIpAXfRmKhMrjBX2r3ko8u+zYDXjG/3SvQ/KN4uVPpaZ6yWsD929tY9ECKh+6Ndmswelm+S+4a0MurCCGA5/Y2QINtfeC6hupw1Lk4nfxNnlEEtJEuKY9SQm0uwgDc8lTSDXCk4s62BOaRBg==
x-ms-exchange-antispam-messagedata: 
 =?Windows-1252?Q?RJ6be0yI3VkuGDm75vKSfXM6C7QIwpVxAsVlSN35ahgzRQKWoi/NVc9Z?=
 =?Windows-1252?Q?boFzPtE4DNiGnh/W9p+rRze906r7cgBW3mQW6Twd+6kGnxCFYUlwRX3y?=
 =?Windows-1252?Q?WpSq1n8BgGkeoc58NDwnvkFBnQUWm6C5EZxu1YxEBWrjbeDzTH0pYWtk?=
 =?Windows-1252?Q?t6mWrYo7jZr1uQF9zI0o9BntOYRvLkd+xxEKfulraa248jNRUk2Wo5OC?=
 =?Windows-1252?Q?fgkET4KTNgU+RwcQb4ZSAug3YZ6ygZx6ib0MWRxFb+MvCg9YDDInrqgI?=
 =?Windows-1252?Q?7rkcv7w+FHnVuAI8tifgXvSNRs5KTc0bYb1UyRLXBvl65c57pZEpQrIp?=
 =?Windows-1252?Q?cMW9MNFvUs+NC3Kn1IofD5LSUfltCx5gzfIoOt6lZtguE1NhOMFf48vd?=
 =?Windows-1252?Q?kocwwOX0mXnHGspkeSt+bbr1mIW/LBNo8EredpK3+aLbyh/eU6MnTE0l?=
 =?Windows-1252?Q?/cE9zWlnehn5YLe+tg+9+GpEMzcrAuqEDkHslc9fPVcS8NeEGp1jm5Ir?=
 =?Windows-1252?Q?rvwX482IHobZJdLW2IYfeh8emUgFSALVjtOfjcwxvYWLdJ7tsrFjv+Iq?=
 =?Windows-1252?Q?44spTEua2aLY/gZrDzBwoN/IZkXBu42AHG2ZJGKvkhofzX8ZvYuqJvWP?=
 =?Windows-1252?Q?ixKz4I7vH/BFM3UdUPi4ZLBR40c2XAxEfxK0igXDz8+KejujwnIn8kw9?=
 =?Windows-1252?Q?MtHLP8birVF8ODEL7QSV7G8sXfF0bPtK4ICKJQWKe1OuyKkcbkOTEsT0?=
 =?Windows-1252?Q?lOC6rDxUP5ZkVg3hChqGXJcMf0rYFAhNmDvOS0AmgtVZnhxurP8digDi?=
 =?Windows-1252?Q?8p0dYYfDnV8Yy+MCeE6EglfwHV/BDdNektXpCqm0e/24oFJCf3vzt17o?=
 =?Windows-1252?Q?1Q/iVr6hL+eh3Fr5YnsRNDZ/GAx0EmfCPpNv8/BXIZzp5CNsy663J8RH?=
 =?Windows-1252?Q?TtDv+QQJav1yYq/OZ9yTaNswnX0AIM9ReWTlZ6eaGWfKWCkFiEJGPYLd?=
 =?Windows-1252?Q?Tx9mXSSgJS4QWfA63J+DufJpS2hSRfWAuLlZk+R2vrkbXpOkwxc=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB2385.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50c8563d-b8a8-4233-47b8-08d895ded26b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2020 09:52:31.7829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: izxvhO/oVFWbZ2tI7RDvft0Lrlv4oFsiSG+htd+xFhb6BDk1EQcvosGaxQn7Ta762UlVrR84eKNk+S+woCFrWy0/saY4b0gY71fH6LR+SlQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3459
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: NB2TTSPbWM3wHXcImuYeHjQGx4520388AA=
Content-Type: multipart/mixed; boundary="UXvYlUez6rioWMB6a1yY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606816356;
 bh=cvW1odnrTwI/06znCUnQbmFYJ2CHyJlgilLUKhF9ghw=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=PLmSdg8qeV5RRtQZ9hawJNG0JFcNPo4kfDCk3slM41wt89Ll+FLR/Q2HjudZe9lCbwM
 998qNiZl++mmpe+X+oLkl7O4YfNSEy4RRMUjW1fjPSU9nuxw8PWz3TwF3JyLN7xhTgyYd
 0CcPe8CRJOtZfeX/DUmrjX7BgLONkFImh6s=

--UXvYlUez6rioWMB6a1yY
Content-Language: en-US
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hello Pavel,

> From: Pavel Machek <pavel@denx.de>
> Sent: 23 November 2020 19:10
>
> *** gpg4o | The signature of this email could not be verified because the
> following public key is missing. Click here to search and import the key
> 30E7F06A95DBFAF2 ***
>
> Hi!
>
> This is going on for a few days now, but today it seems worse than
> usual:

For me things seems to have stabilised now.
Are you still seeing a lot of issues?

Kind regards, Chris


>
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/220169843
>
> builds are failing, 'HTTP 500 curl 22' error, so not a real build
> problem. I can probably just click restart... 6 times. But something
> is not there, and it is getting worse.
>
> Best regards,
> =A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=
=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=
 =A0=A0=A0=A0=A0=A0=A0 Pavel
>
>
> g for pod gitlab/runner-bcrayztp-project-2678032-concurrent-7hmhsr to be
> running, status is Pending
> 74Running on runner-bcrayztp-project-2678032-concurrent-7hmhsr via cip-
> project-v3-gitlab-runner-6dbd79945f-wdqqw...
> 76
> Fetching changes with git depth set to 10...
> 00:18
> 77Initialized empty Git repository in /builds/cip-project/cip-kernel/linu=
x-
> cip/.git/
> 78Created fresh repository.
> 79error: RPC failed; HTTP 500 curl 22 The requested URL returned error: 5=
00
> 80fatal: the remote end hung up unexpectedly
> 82
> Uploading artifacts...
> 00:00
> 83WARNING: output: no matching files
> 84ERROR: No files to upload
> 86ERROR: Job failed: command terminated with exit code 1
> --
> DENX Software Engineering GmbH,=A0=A0=A0=A0=A0 Managing Director: Wolfgan=
g Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--UXvYlUez6rioWMB6a1yY
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5928): https://lists.cip-project.org/g/cip-dev/message=
/5928
Mute This Topic: https://lists.cip-project.org/mt/78460850/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--UXvYlUez6rioWMB6a1yY--
