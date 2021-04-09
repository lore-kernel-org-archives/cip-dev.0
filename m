Return-Path: <SRS0=Jamk=JG=lists.cip-project.org=bounce+64572+6356+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570FDC433ED
	for <cip-dev@archiver.kernel.org>; Fri,  9 Apr 2021 14:48:35 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2B2961041
	for <cip-dev@archiver.kernel.org>; Fri,  9 Apr 2021 14:48:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2B2961041
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6356+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id F4SZYY4521723xYu2vIfrhZU; Fri, 09 Apr 2021 07:48:34 -0700
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.133])
 by mx.groups.io with SMTP id smtpd.web09.10419.1617979712853687240
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 Apr 2021 07:48:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTvwly1TcJ6lSB1K5Ze94g+vMKfRTYuWg539SomwICCrfB+0x3D3W+kC9yqL8R+JH3P9dd1z/l2usMh+j4n2RnAy+3GU7wirWkE3kT7yyNM6hu8moUG0o2qhQIQl0CjiC7obqn2ZGCKvtqp+euQcq4XG1Zm3qBGnOzHo6/D1UHdkk5qEh31HulP4kB0cOfUAY1RxP1qgp9uT+cQUlan9GrOUWDG2yYjrmW0mAHevBe3119/7pwv6Im764p/KLFOUncaT03nfJfto6BwawAGqBQ6APBvXDTQIbljxj3GHNT0cq2VgU15v7I4/ZGDqf1d00NV8CRwft6Egax1FhW3oBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1jLeS5xVPryyzXAXPpn2Omp6yjFXCaxjGEB1wG1e5s=;
 b=Mv71mYweBxhVGYoGy6w7PgLily99JmKl3BMBE+1epyei/tWD4qvTEgObiC/r/EmHSoF5HGLPWbe9/K13zmKOFrzUufg90xXefZbcbTkka5pZhhlpHGKvwjtrgHWJZKuVMmdVaSXhIrsMEptKIXE4zrueoik+V9FP3ffIG1zIm1kcH2W21VNr/rWXVBqA/ojd6COE69vrVvCDLs7YpU37VqSpG/wTotSmEfKwC3Px12OZwdBAD405yn/bYcY2Zt3v9xmnULhTgJarEAVWgmsCrRy9A8ZyyaxN6RwtvNewL5pD5mMvuITmdWnYTDu7T9tlAl5CS9bwyTbMdE72UXJtqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
X-Received: from OSAPR01MB2385.jpnprd01.prod.outlook.com (2603:1096:603:37::20)
 by OSBPR01MB4470.jpnprd01.prod.outlook.com (2603:1096:604:75::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Fri, 9 Apr
 2021 14:48:28 +0000
X-Received: from OSAPR01MB2385.jpnprd01.prod.outlook.com
 ([fe80::ed73:ed8b:2eb3:2507]) by OSAPR01MB2385.jpnprd01.prod.outlook.com
 ([fe80::ed73:ed8b:2eb3:2507%7]) with mapi id 15.20.4020.020; Fri, 9 Apr 2021
 14:48:28 +0000
From: "Chris Paterson" <chris.paterson2@renesas.com>
To: Pavel Machek <pavel@denx.de>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] gitlab problems: -stable mirring broken, testing broken?
Thread-Topic: gitlab problems: -stable mirring broken, testing broken?
Thread-Index: AQHXLTK3F9vSi5MfHkinjQGC+m4EGKqsQdUw
Date: Fri, 9 Apr 2021 14:48:28 +0000
Message-ID: 
 <OSAPR01MB23856AC5EA12705FF23A62C5B7739@OSAPR01MB2385.jpnprd01.prod.outlook.com>
References: <20210409112257.GA13478@amd>
In-Reply-To: <20210409112257.GA13478@amd>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.219.20]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b1d8c325-3cae-49bc-0899-08d8fb668964
x-ms-traffictypediagnostic: OSBPR01MB4470:
x-microsoft-antispam-prvs: 
 <OSBPR01MB4470533B8A8EE2568874444EB7739@OSBPR01MB4470.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 /1nxyQkODklokEYKhDVQJCGgiGA3ALzIwp8fQLeRtrRlJyUALvma2jo6pn051JGDgKHDsJ2uMVmK++Jaz5qC6Z8XSGe60pFis0xGm4G0JPVAYIQXHIB+mSkUTp/9zR9IuHqiqePNzx7QvIapF4I2hVZjmftgk7vu4B6GIuKpwK4olxuNlcWd2Br24Kq9ZewT1cZsmZL84Rf3BK/1va1SHe38+6tLKRJNfMfrMvAiKGv76jENqIVlHxfAU5+udAcMCm3dfBi91BTIwF5jrG2Bkdx7KOv1HL/LQEpRan4H/Vjchw7Jq5nygU6rCXxDrvH+/NWWe8mCLux6esYiRk+S9ot/5tWYKmGPkxxRiKgrwH7EZiYLpPavO1w2RkAr5slA/2Men5xPhxtLGgW1Au72OUFt6JzzVraGiqurL8WPwQ9AzoqkpKcXqIwuelDohbvPHkZ9sGh3pdwzsajKnosJhDOonpLX7OU094zUJSee64FlhFOneQuV+iZ62Aat+/9oZuTSWObHdfC8HyjXVk5pLsUUytzrUJNwRhqj4lZNqtF3M7iXWNa2AxjvHalhaVtCg48d+foWQ41zgMmcEf69qDYCRolXmv0H3hdJeeSuyloLY06qV8tOjZ/Tg4nfr6J4jbu17BiOdsjsyBdmBt9T9l6hzU5ot6T4k+oiIXTAMelII/rj7jBPW2arKc64jj4OSEX5o2GV6GV7/4p1JvUCrsXnNl1KcifSiRAuxdr1Avan/F27W5ZfqlwRP2ANKlBR
x-ms-exchange-antispam-messagedata: 
 =?Windows-1252?Q?kgRYdvgnI48hbVRPcNVuy+VpVkmuYNDp0ZCwn+SSO9LeI1I4WOQOSvNs?=
 =?Windows-1252?Q?+kw/eihMikSp+BCrJrKHpe0DfEP9dUKY0OwClStXk4vv+5W2fbu2K7Tv?=
 =?Windows-1252?Q?NVDeeLfwfroLiFrCSFgA7nVe0VMBTvPi6jW4tzTFRerFj4W7RCx7KGUy?=
 =?Windows-1252?Q?O6W3R7fpISgQ9bPwtOuAsmSAp/QAvd8e1xQbggEK5Fqrl4mdQhY4SDmw?=
 =?Windows-1252?Q?0R6BWL8el5XtUEYNNjuwsyG65qdLeMY2cwbnPFHetDuZkV6mP3e9bf5n?=
 =?Windows-1252?Q?WN8V3WQYqJyZ5gvpIewdL6KuI4mq4QG5wh+jfpPUs5Q+eHBLVvQgd5w7?=
 =?Windows-1252?Q?2Zw/LFyFv7wbr+bbJheh1EMGCc5Tg2KIQHk7KI/EQdInPLv/ITRCHQ/I?=
 =?Windows-1252?Q?da3CUjmSw8n5mvE0+J0a63cYrbhEL61rtBEOwmbeVeeiwgLUC8Yi7BWZ?=
 =?Windows-1252?Q?NpsV0orDx7eTFjN6tMnYeanRrcFSkB+oVHae8Xn/RT6tP1elV2o54gLB?=
 =?Windows-1252?Q?ezYpfMBvURwEGM8U7Jkb+N2t1Z9u9ITFozusF8a2z5wTy+S8DA+cQ7iD?=
 =?Windows-1252?Q?MbCCdvoAwQU4Gd//f0K3rc0s3cORs5j+OPCh8rV687X/8Dr6cVL8+W8r?=
 =?Windows-1252?Q?MhY5QCKgh2nzmXRJRCcuvu/uOnKWB2AHEHm1w6g7YsAIy4b90DRlzD18?=
 =?Windows-1252?Q?r51U7fXz4NfBvPn4KApGX4b2r3fE8BxqREe5DNBtra2sWMqWPHP9wCTN?=
 =?Windows-1252?Q?xmqK20A3KbHK1wUxxwrhjJWnOOUaGKwub1cEsVYPAXaCU3rvDxLDDaFd?=
 =?Windows-1252?Q?x1ehiwMhC0D63hCMSGT9zqa90PVctp+s267tU79JaZ14NPhOKQZ522oJ?=
 =?Windows-1252?Q?k61CwQGgCKS+eMC133R9SBwhUM5F/CFY/ZCCBpWDJKTPbODkkBIF3XNu?=
 =?Windows-1252?Q?CtmebX56HEqsohwcRMoTUNpYLL+YixA4tM0HRGFUE988koaXP+Nkn5+1?=
 =?Windows-1252?Q?x2wTqcu3KEjD8JdydREl2qMr88qdz+34DEJpfEe2Rklba1xiZJcAaghw?=
 =?Windows-1252?Q?amIqlUvXlJynPMR3KKXkGHbZXKcCdIRbEr+MykAwBwpnlILWto+MZor2?=
 =?Windows-1252?Q?0qkE4l47WouQQOMUukLDZZKMdjk+UR2gKfhH33TGwsAXlUZeZfte4SUE?=
 =?Windows-1252?Q?0aLq2BrhiEBs3v4aWqNLCHrshkzk/75uKNUrpG0hY/H/Nwwohf6AYyKj?=
 =?Windows-1252?Q?GJDZZRy+3Wmfpi4U5IbcaP3zVyTt75xxM8YdGAnx31QIBZGkS6UCJAPm?=
 =?Windows-1252?Q?fha8fWVOcq1WpP6LZCWqBPFKCNlrNHsgFFf5EK3+fjeED6UPYYFYf2w1?=
 =?Windows-1252?Q?/a/JOK8WgkypNFJWDq8YxicBNrrr4EwFPWbEKUI4XJ6BPZNUbK8ZLR1b?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB2385.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d8c325-3cae-49bc-0899-08d8fb668964
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2021 14:48:28.1496
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U5WobnacCjfNksceJZhWFtGJKZO4jDxKYQsksYiKuuFj5DRWJopH4V3Su2XRiwArQge9CAbLRIl26QOgNUoutsM8660TVoedj3Cpb5ex8ZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4470
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: qDloUWhWpQMFxt5xlfUwVT1px4520388AA=
Content-Type: multipart/mixed; boundary="5QThwst43ySPke6x4oY4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1617979714;
 bh=3xwvnQq7PCEGWpJq+iKEHBP9FiyfaLXZjlgq5Anhd9Y=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=AVtqhwh9guiSYainrY0uxIm3ZNu9TeFBwEiyC7DIOUkciEnq3LmiqKXwrCmHWiiAlMm
 MuFefp6E5cNZRDLPvOG40Kua3pOY1FQ26XOa5GHC1fU9APR7Z13SEMoLuFiuKXSByZdLb
 U4wUwkAUwnStw3vgc741WkH2AsZn6f7vJR8=

--5QThwst43ySPke6x4oY4
Content-Language: en-US
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hello Pavel,

> From: Pavel Machek <pavel@denx.de>
> Sent: 09 April 2021 12:23
>
> Hi!
>
> gitlab seems to have some problems. 5.10.29-rc1 is not mirrored in
> gitlab:
>
> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linu=
x-
> 5.10.y

It looks like the webhook from https://gitlab.com/cip-project/cip-testing/l=
inux-stable-rc didn't get through.
I've tried again and hit a 429 error:
"Hook executed successfully but returned HTTP 429 Rate limit exceeded; see =
https://docs.gitlab.com/ee/user/gitlab_com/#gitlabcom-specific-rate-limits =
for more details"

Maybe we've hit one of these rate limits?

>
> And I'm getting strange error while attempting to test 4.4 kernel:
>
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/283833338
>
> Found errors in your .gitlab-ci.yml:
> Remote file
> `https://gitlab.com/cip-project/cip-testing/linux-cip-
> pipelines/raw/master/linux-cip-pipeline.yml`
> could not be fetched because of HTTP code `429` error!
> You can also test your .gitlab-ci.yml in CI Lint

It looks like the same issue as above.
I've kicked off a pipeline for the same branch and it's working now:
https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/284020976

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

--5QThwst43ySPke6x4oY4
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6356): https://lists.cip-project.org/g/cip-dev/message=
/6356
Mute This Topic: https://lists.cip-project.org/mt/81965841/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--5QThwst43ySPke6x4oY4--
