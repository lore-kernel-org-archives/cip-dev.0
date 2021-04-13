Return-Path: <SRS0=DNlw=JK=lists.cip-project.org=bounce+64572+6375+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,PDS_BAD_THREAD_QP_64,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,WEIRD_PORT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D79C433B4
	for <cip-dev@archiver.kernel.org>; Tue, 13 Apr 2021 22:27:09 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 756AD61155
	for <cip-dev@archiver.kernel.org>; Tue, 13 Apr 2021 22:27:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 756AD61155
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6375+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id PW13YY4521723xgLWC8pPdVW; Tue, 13 Apr 2021 15:27:08 -0700
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.120])
 by mx.groups.io with SMTP id smtpd.web10.4790.1618352826268639852
 for <cip-dev@lists.cip-project.org>;
 Tue, 13 Apr 2021 15:27:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=akfb4wmX9QmXXXUzTyYf6g36CPlrfnldtejpq/w3GUkEyGUX+lHFNvbJ4sS8yVg9SBc6tBRXIwrEzErkqLfABbJ6OgESwS3js8m5o5u8pbdc4WAbhKpNVBuaeyHH/LEF9CTxwAi9JfnsT1nsBElPsbzmXV3YyvfmjYsWWgSwSzW7sO3FadPXtQ35djytzVkzLBOwIBj5l20lJJX9sYUR7dGopM0vKSL0XljoUd8jXjuYlbtAPzX5T9kbkNfMydFqdtACv7nDpwlD6D6HVRcnya9KMVCKGVQuX2PJBTfhW/lVm24w36KAKW6ljmWnaVCaNz/kwkkEHbmQmG3/a19atA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCSkXkkiK9vIlBv0MGHCdyw/OnuCSFr1CckmZpX9g8c=;
 b=BRpMhF8en/jiKhNudqh67hWf+tsAtObeaEYk5FVLZ63bqajYzqctkglXXcz8BJpcMQ/EoPhSt2POwbLhYrfKVuHRM0wkf2vBDK7BrKNMQhogAZv2+XmoocHJP8R3QJ6ItcqR6kNdUjG6io85x4k/mJXSq7UCS+RnlYBPY65vXZka6FgmIbyOU5MCSJh6bv3yFt8GT/XuG8URGeTtpO7Wm8bS5FAdvk6ZnCAgGCs4vDzTlewmKhHytFdWLIFVx/ZNbzrsiNK7lntpECJZqSiSc9DFHa9dixnu2nWBkB/v7t/cPp7QVdDQI89IUyNqNW78WZoSScE1TRC+lawjBc4/lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
X-Received: from OSAPR01MB2385.jpnprd01.prod.outlook.com (2603:1096:603:37::20)
 by OSBPR01MB2166.jpnprd01.prod.outlook.com (2603:1096:603:21::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Tue, 13 Apr
 2021 22:27:01 +0000
X-Received: from OSAPR01MB2385.jpnprd01.prod.outlook.com
 ([fe80::ed73:ed8b:2eb3:2507]) by OSAPR01MB2385.jpnprd01.prod.outlook.com
 ([fe80::ed73:ed8b:2eb3:2507%7]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 22:27:01 +0000
From: "Chris Paterson" <chris.paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"alice.ferrazzi@miraclelinux.com" <alice.ferrazzi@miraclelinux.com>
Subject: Re: [cip-dev] Kselftest implementation
Thread-Topic: [cip-dev] Kselftest implementation
Thread-Index: AQHXMIq2BZ98YueDHE6AhBqfy2SnTaqzAphQ
Date: Tue, 13 Apr 2021 22:27:01 +0000
Message-ID: 
 <OSAPR01MB23856FC69ACA82D31DBE9519B74F9@OSAPR01MB2385.jpnprd01.prod.outlook.com>
References: 
 <CANgtXuP5wVfj7x_ef=oSV6S80zMnAG4JPa_N_W4hNUAE7qmHQA@mail.gmail.com>
In-Reply-To: 
 <CANgtXuP5wVfj7x_ef=oSV6S80zMnAG4JPa_N_W4hNUAE7qmHQA@mail.gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [86.190.96.214]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 91a7c925-249f-414d-b019-08d8fecb422d
x-ms-traffictypediagnostic: OSBPR01MB2166:
x-microsoft-antispam-prvs: 
 <OSBPR01MB2166881F73A67D2F0657EEDFB74F9@OSBPR01MB2166.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 dXjkfYS4f/IP3Me0dvGGpAPhUnhRWv1EADVJVNJf/0wB2ltiq4T38yzsL2WS6GRmHiz1A1N3QNW+H29jFeMHZs8uytVF2ehuqZk9l7MNBQBM/va8MX9ULRwilnzqMCbJiGO4jOnNPAdltPp5XRmhimpJ9fTuJQoR22mHhwnqsk1OkMAsXMcja4H7gahwtJmPzyrXcCfbMkYRhqlSuRbsMsyZ7Gjs+UvlDzDrcVXDtz4pdtvhEGtA6IkLVnsDSGFcgkqqxi78pdYMXV7+PqzJ8nBNKeG/V91WJunXRjpK2Q5GnnvbjFG7zcOzwRV6Ja5b/57RLDfVrquRMM+/tz6FUtdeFyVdDKOnGl1PgTG3TiKXiFr1t1wu8djlP0WAVIlrh5w7NkJ4ErPzTeuo0GN1JVKwpcc2vk8Ic+Zx3KS/XmUgcAFDBPZQuiXIRR+a4Db1WhS7LCzCf5Wim9MKTw1V/bywsGHTPE3vWxUbsnhYAKDv0qHHJC5u0tcVNcSVT2Ti4b0dqrZgpUDUPMqiuUPHo6SMJhy6oHBPChDkfrxBPZJeyjy5ykc1TJkZf8KerdobzxhFKmkn7PP+D+M5Glx9GyagXWh74D4CSXR0UyFIGM/daztwT/sNewL1bUgLUswHhf6TGTIoKwHx0quNqCtSsEB7el4/mBiv84Eu2FMgeSWcEmJJ/2QBTtpLuqfrsvmgYD37Fx7ommmxz6EIMYPR98EOyLO6Z3RIO5J/vWNI6Rs=
x-ms-exchange-antispam-messagedata: 
 =?Windows-1252?Q?MhRz1syBrFmiUEH56mMblANQHyjmamFm+pOgEDVLtp4hKx8IiP49FY17?=
 =?Windows-1252?Q?m/Ley2xn3Vr+12KFFJS5ttC2ZrV3BmnN/G1NZht2/GS7ubA01t4CzyaO?=
 =?Windows-1252?Q?nu+B5u09A7LCsNrXeNv85Jlu2zcHjoyPt7YImFMwyXjFy8ArukLEFKbi?=
 =?Windows-1252?Q?KzFAQF3YN0l90FEQb2d6KesIresn1x9QVd8bcYCCFvYEk7xd7JOum38U?=
 =?Windows-1252?Q?ky31rfhmmT3zTmAb44+dozhEDX3xOEKTGvnRLqtEC3l6W9xRp4TUt12v?=
 =?Windows-1252?Q?x5GCxHmdI5svRQ+q6zsm34qGV9yqRSb0L+Pu2NIpQBTYRA93XI8kly5k?=
 =?Windows-1252?Q?9Fmpzav5lz6+zq2QaA2YGeS2IKLnCOIqYFNxurl9DZAGW5rfjz00ZOnA?=
 =?Windows-1252?Q?ogfw39TaXDk4KvO+6ZFImwNjhBvSUz9JSTf5R2LSQZlkTAhAWP3gD1yE?=
 =?Windows-1252?Q?7wpGMOPIYKkQ+QZP/Y5KtjKu5He8/ZcMVkaVLEIHtQJ5EmKlxO2GQpZZ?=
 =?Windows-1252?Q?XmjwFZW5BDPhLTij1JplrEzt/4ONkMZjjp2HgyVTC6iNam8hju+CA9ZR?=
 =?Windows-1252?Q?6+2u0KF3/Vcn7nmmIKOznGRJZ4hNv43LI6828PSEgSvwrrw2Sai71PB+?=
 =?Windows-1252?Q?SFqxbtbYzxH+wjxYHATf6zCJHxwJN7U9B0U7nzfBxbaR4cRC5Im+14oA?=
 =?Windows-1252?Q?RUSaO9UX2tBBliVeFIPTl3OJ+onIRQIYbr4Pj7bV6AmRSXBvu1fQ3fJX?=
 =?Windows-1252?Q?iqkbj7FeuQ51M26dKKJ244SIQLPO8uZEg9Pe+V8iPGN0bq//+sFH9dKN?=
 =?Windows-1252?Q?gD6WXbz9S2tn4JoaW/HVOBepaCEckzHSCpFQZXEIUkjCguyfVTmLMpLM?=
 =?Windows-1252?Q?ya5iawxYnVUyZmlkfBWduIJZ6+2TWPt8iM5lDW/F56YBpdao9DDAIBjq?=
 =?Windows-1252?Q?IH2FoiQjfLchgq/vOkjnBcM5mvU21Spg9ScGDoHU4ZKxIiiLGRdlKkBA?=
 =?Windows-1252?Q?+Zm7/L2pspJwpANy0EcqG7CfIbeDLnpOeQxsyDNq1GDQIu5WjgZt6Kzs?=
 =?Windows-1252?Q?PNhCUdB0vqpgyeVli3/1LhMX+qnNkVGcfSTsuWAPwGjx7Ab1SK7mYv31?=
 =?Windows-1252?Q?mse3yCmLVRi91jFshDRJ1nOjNBqsqH8aumYtaChuANH912EV+fz71V1E?=
 =?Windows-1252?Q?jmkEJme93g5mW9L+hKmWjErdROwVPFOr1WxasboB+h95GAp+8wEsXG4c?=
 =?Windows-1252?Q?yU4dZ60eUWix3xAmAAXt1Yg4KYY2mHPykzmvLMbQVmMQw5nckfPglnVp?=
 =?Windows-1252?Q?XH6PRJexYLIm+TZOBbiT5iJWwXkfRAxpxI7ehF1SysON7d4c61YXk3Vs?=
 =?Windows-1252?Q?od6MuJpKAFNFLTL68Z7+We3NRZk7Lpxa11lx9Xv6R1oKZ6PX6SBmIRfc?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB2385.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91a7c925-249f-414d-b019-08d8fecb422d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2021 22:27:01.2493
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ecFs2l1EshsR85eIp3YwILB1SlJzWXZ3f5HK+DMKKBdmHdCxg8Uyz1Cq+OElozj9GcRD6x/zjAyN+M4XJ4+yvUjFwVtazHsEqRfuHJ3EFEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2166
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: f4l8oMbar81jkr0beljYlHAAx4520388AA=
Content-Type: multipart/mixed; boundary="wXNU56zGZWjy9oG1EJct"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1618352828;
 bh=NxVLQt0bbGu59Ly6KG8mlWm1BawNwdnIfzsAOVekQHg=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=Fc8JDiJhp+/2Fofl1YA2cvHOtvT0gk8czVpBD9qSCjrchdwZXDuZOKF6EdaCfZQ/yO+
 FuzCIUlVCUQ6naARJGbRbApYtMx3TcCFRVgr1u8b06F3HJv0TlYfvSvz/S8iJ7l+2A/8y
 nNrNFvKGXJmqpwUeiHA4/StwwkkloJIG7Xw=

--wXNU56zGZWjy9oG1EJct
Content-Language: en-US
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hello Alice,

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Alice Ferrazzi via lists.cip-project.org
> Sent: 13 April 2021 18:30
>=20
> Hi everyone,
>=20
> I'm Alice Ferrazzi from Cybertrust Japan.
>=20
> I'm currently working on adding Kselftest to the current CIP CI tests of =
linux-
> cip Kernel

Thank you for your work on this!

>=20
> I made and tested kselftest on a testing instance of lava, currently test=
ed
> only on qemu x86_64

If you'd like to test on a wider range of platforms then get in touch and w=
e'll get you access to the CIP LAVA instance.

> I implemented a simple skiplist in the kselftest envelope for skipping te=
sts
> that are currently not working.
> The usage is similar to how spectre-meltdown-checker-test is currently
> working.
>=20
> Raw log:
>=20
> http://140.211.166.173:10080/scheduler/job/329
> Results list:
> http://140.211.166.173:10080/results/329/1_kselftest

It looks like a great start.

>
>=20
> My idea is to start implementing kselftest tests for at least qemu x86_64
> architecture and expand in the future to other architectures.
> As Iwamatsu-san pointed, we need also to create kselftest binary.
>=20
> I'm currently thinking of implementing kselftest binary creation mechanis=
m
> on linux-cip-ci kernel build script but I still didn't start to work on t=
his yet.
>=20
> Kselftest test code:
>=20
> https://gitlab.com/alice.ferrazzi/cip-kselftest

Is there any work we can leverage from the Linaro test-definitions repo?
https://github.com/Linaro/test-definitions/tree/master/automated/linux/ksel=
ftest

KernelCI also recently implemented kselftest support if that's useful at al=
l, this'll include the build side of things.
https://github.com/kernelci/kernelci-core/tree/main/config/lava/kselftest

>
>=20
> linux-cip Kernel Kselftest implementation (currently in draft):
> https://gitlab.com/cip-project/cip-testing/linux-cip-ci/-/merge_requests

Please assign the MR to me when you're ready for it to be reviewed, or if y=
ou need any help.

Also let me know if you want write access to the linux-cip-ci repo.
If you push your branch to our repo directly the CI will be able to run, ma=
king it easier for you to test.

Kind regards, Chris

>
>=20
> Thanks,
> Alice
> --
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Cybertrust Japan Co.,Ltd.
> Alice Ferrazzi
> alice.ferrazzi@miraclelinux.com <mailto:alice.ferrazzi@miraclelinux.com>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


--wXNU56zGZWjy9oG1EJct
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6375): https://lists.cip-project.org/g/cip-dev/message=
/6375
Mute This Topic: https://lists.cip-project.org/mt/82071182/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--wXNU56zGZWjy9oG1EJct--
