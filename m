Return-Path: <SRS0=z6pP=MZ=lists.cip-project.org=bounce+64572+6646+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E83C432BE
	for <cip-dev@archiver.kernel.org>; Mon,  2 Aug 2021 20:59:37 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0EA460F58
	for <cip-dev@archiver.kernel.org>; Mon,  2 Aug 2021 20:59:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D0EA460F58
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 8SveYY4521723xnlqsu8zyIL; Mon, 02 Aug 2021 13:59:36 -0700
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.102])
 by mx.groups.io with SMTP id smtpd.web11.566.1627937970127223646
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Aug 2021 13:59:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M4K8cBetEx4e0LRd0s2zIMAysnnhK5m+LPcqU6VH12ma7v0tBfaXKxx+8kipcNLiGWtLFTnvn2NPajDjfKTcd9oio4hIJc56/Z6oftX1UaR2ZBq7eBXIPUPnymsKFVOCXYAHeLY0HHAOW1ZZ6BrfBf51HP657uPXtf1gmQpAaEQ42S482SJRnkqR0uwooR9llHnC1wKC4Xw+1msU8ATVkdBQoYUsqX3tO49rUCyos8eMgb5r80fSOIEj6Q3KT4e0M1qRUqn7jx+48+gEblkPy9n5C7rvYP5DnWfrqzDgJv+Mcil0V2bjQErN1FPem83dPVqAlUZpkBTg9AqVAU2RLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3hxa8+a97LuGt0bsdmHQpQqAWrLi2so2N5fs8rMbMl4=;
 b=EaDD25fBtW4p4EaMUuxMKzbVMyjNQouUmr9yTfqeSYybwYWe+D0FYGAknqdE5X47L/HNmOKpt00YilWiR+ZFLNLwfTttZWE9hBWori9gWvx0C2nKmBKJOVTb6g0rdI/hRkTongOfi+YuiJvvAjXPdeMe8sWF1phFeeuEWibEKAq+6eIGcIkl8HLb+fJNqeCrmHH0sq3mjwodL+hruaAWfpol8sh/avZoktgBL1Ti1OQpo3bNXzjATShWwqU9asnuwvm6aqZPfuwIC9eBlx7pO12U8QXHl9okU09iHKa8SAyFaCQuUdifraKZea7K+CSTfWW0Iz6BnhbhvY3xT30DHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
X-Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com (2603:1096:604:13d::6)
 by OSBPR01MB4088.jpnprd01.prod.outlook.com (2603:1096:604:40::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Mon, 2 Aug
 2021 20:59:26 +0000
X-Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::4ced:b063:48d5:4a2b]) by OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::4ced:b063:48d5:4a2b%8]) with mapi id 15.20.4373.026; Mon, 2 Aug 2021
 20:59:26 +0000
From: "Chris Paterson" <chris.paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"cip-members@lists.cip-project.org" <cip-members@lists.cip-project.org>
CC: "alice.ferrazzi@miraclelinux.com" <alice.ferrazzi@miraclelinux.com>
Subject: [cip-dev] FW: [kernelci-members] KernelCI Hackfest #2 - Sept 6-10 2021
Thread-Topic: [kernelci-members] KernelCI Hackfest #2 - Sept 6-10 2021
Thread-Index: AQHXh3zW9rSeX/k4oEq4EIVv1f2AsatgsaGg
Date: Mon, 2 Aug 2021 20:59:25 +0000
Message-ID: 
 <OSZPR01MB6877A873F8EEFA24CC8D7331B7EF9@OSZPR01MB6877.jpnprd01.prod.outlook.com>
References: <74f7b4cf-926f-d8bd-19c2-375cfe7a12b2@collabora.com>
In-Reply-To: <74f7b4cf-926f-d8bd-19c2-375cfe7a12b2@collabora.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 69234c7e-8729-4771-dd29-08d955f86983
x-ms-traffictypediagnostic: OSBPR01MB4088:
x-microsoft-antispam-prvs: 
 <OSBPR01MB4088DC8EC69992769FF5AB0AB7EF9@OSBPR01MB4088.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam-message-info: 
 7pIFplxYUgUwjwkGWxQUQvZdt19mgPtrB4UDPgMaXdjeWEabKnlCCxIWmRRa149mtZxy/SI06s13KInK6RzvL1M9CLCs4wxS06WD+glmBY+WGNvukFVsU044uOZkrZTNlvodrGjzWeCsTlUGE1a9Z+aXV2KHnb2YSUk10pIIx9IvclTLoJVlhcySmyC2AoWkPZmzDQFOejVeeiNh6goPAXx6fLHiRU+eZFwFMauDmiubQBuzA5Co81Usb4Z7QvHP/W41Bbc7ALiLK/vFhtuJF9f1LyfeRlmKOgV/hDS5T2zeIwHt7E7YP8khoJ6GaIHQBepjRG4+b4CCWdSN8r76YkFFlk5RLQkkdjVnk2zbsdNcp6f6HQ4eBC3pz/7VlJMW2iYCpaDS5nMEfZ8Q5RqbjKVReviex9iDiWmGKbv94chDE7ukNfXEj++jZVNQwcE0TKOnUNEGVBF8QQrSn2oMTx5dSQ3YBXmpYTemAPoeCLrmQj93v8Wj3VbuDV1hyqvtgD1cOkt3Myqi67KQciAK+TtqwpNh0XDDwHTn4uWKCL7w2lDcJWfOdBoZx/wrEBwb28fMufSgFvifSEK7kPSW30Y4hgJqu3zsHuOLQuuUTKrSGRnkO8n75U88/xaFBmOnlrQ4KI/K+G/XM7BTWHQF+odMO2ma2mjY9uAqKoOyGENbDHYZ85sdM3ZDObxr+nKYXB4irqzlOadV2LP8u+ffGWA+ZSHq7peiXLaQ/JU2sIF/bvkFexmzbRLsMOxYo6sgNPPIr8P0Ovrd2Rd8IT4mNCw1OfpDx0lSWFddY/Nba7R78HRkdt9DQIbFzI8pTHcaoilOxOF+Xt8wB9+vDeB+xiyUI4FEVKJR5jmmsBEt7Jw=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?FMBZua0WpR1hiTNcwC072zQ5YuWzt48CBSmrh/W4IfEo/RoGVGXQXE7V?=
 =?Windows-1252?Q?X9rsEWH74nQcPj/JCtXaVSWeMpLy5hgGVG3Zk3xWnjlDxjl4vAqJ+rko?=
 =?Windows-1252?Q?JLsarFb/ldBGc78DOlrIWGM9hcJCD7cgfgFWS3vCLFeI2txcbL6XHudt?=
 =?Windows-1252?Q?0UUOFpmd8S67MOnbRXcQP9+zAA1gT8r0C4K0NlxOYMljhtBg9WT4Jk9f?=
 =?Windows-1252?Q?bHR7oyEhcPlwD5Q9Hcvcz6qHzDa3kAWjSfBstX1/EvUdi+75pf5VhLJT?=
 =?Windows-1252?Q?G8bd+sEjWStGq4C+sY80xIGvr9g4SHYRa4WQnRxty9L0w1DBH6VxPgzF?=
 =?Windows-1252?Q?n7NwszzZYjjFTWZx13Rw1SKuBqcWLRhdjH6ey7c0cGpkWpzTLkPUvLC8?=
 =?Windows-1252?Q?QfvtFz8XOw283HMB209W1aO/MvBmiTCatFTc3smqzR+No5F/CVv6snhV?=
 =?Windows-1252?Q?PEJgaFA/gT0uZInDRPVSpfdKoHN/O3eGDcSOZcLnxo0rP3eeqBPlxk9Y?=
 =?Windows-1252?Q?SZY+Kb2Mcznns+JUR4F3v8x38yHHBI4r4TKy5X4OZi1Gii76G28DL5QH?=
 =?Windows-1252?Q?oNCBaZj1FwOsKhSGbtIF78fBR5qtqZUl+5KZwPf3+/oPD2YR1vQ11d39?=
 =?Windows-1252?Q?IS2HaQ2iPcWrRHxMnF7aIrZNv9B7qqEiU4yAQSp5zwHIKaoAukiXl/gU?=
 =?Windows-1252?Q?SaomWcC3bmyTRlQOFDSgKFpyLj3bNBRYrhSVGBYCSpHjk/hEkn2nxo0b?=
 =?Windows-1252?Q?Vt1DfW/aIL0O2izPlXwFqLR5s4gcv4c8WgbcwLhFlqMZ93jsF6Ym5M09?=
 =?Windows-1252?Q?nk+PCXYb6e6VfMKM/zkKphOsqE3pc/oc6WG/LYhx2UvzBg7/y/BxXspC?=
 =?Windows-1252?Q?Cs7PyPxWfrSwEKtIUvbYeorWu3Q71vHdfPwc/TJAuWYLAJFrssehZYZA?=
 =?Windows-1252?Q?lFv3do1WOQesli2zFyGPuN0XfBS82MqsEYLBQblyWfwANSMnSJpkXRY2?=
 =?Windows-1252?Q?SIyLrpzVctI04KwLKG3pNGoHe/8uG8R4BbXki9pGMPfTmCJsgQw9UqNI?=
 =?Windows-1252?Q?MxAOq6zbiAsGo02n2U8kNZn+CZqoheA6/PAuDztg5vhW9edAzVNyFYca?=
 =?Windows-1252?Q?tyhAkvOaDJAx6RnOlHReRMqQh6sdTNY7jaaqyjFx4FKc8N5m0JdJebIM?=
 =?Windows-1252?Q?VaXMw0y8abb7nwdSXsE9C+RrRqMpiKtUaqT/FEOjDLNChdsZ+AY0fsfr?=
 =?Windows-1252?Q?Wkk0fkHQnsbAMxGMxulZO1H2hWHLJ2HzmpQyT21wrH5L6ILj/5gjv4Eo?=
 =?Windows-1252?Q?iyRK5b1/wd0kLnuFuX1QSSfm/9KMFKb71Lx2izfBquK6Heny2P7yiG/S?=
 =?Windows-1252?Q?oEF1w/efCLWz090f23hZwg+5al44tN0oAI/1FHKBlh0IPkXdoGODVeac?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6877.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69234c7e-8729-4771-dd29-08d955f86983
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2021 20:59:25.7467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iQEtNYdR1xG74/5buEWISn6lgecAiwu/ZtrCIcuXxoD8dhKfEW9IwVI2AXtXiC5BiFdF9tDzFpnnnhggRAvMAvKWiTbaR+lqJ3P6KsUTOmE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4088
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: uOwqkf8Z1tdWx9FFUoCalceix4520388AA=
Content-Type: multipart/mixed; boundary="xH7byBzj6wg6Z4vRgj7S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1627937976;
 bh=ifPMOMQB6MN0tg/P+nYmWF+Ui3OF7vkXnFMoyrpcWSU=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=iq+Bt1u7xSjKkYArCw4rJQ4fbgvepvN+SDpRhbwzBWs+yXFya89SsrPykdUdI+FJyPc
 1H3oXj+CSDATeZtAjIGhBr+pZhRIDJVyZ+SKJ1p2p3YRXRQlDCnX+pJoCYUZN8pljrgJo
 U3ffnbDPaQCAVbC8Cd0952jAQ3KtCLpnV4c=

--xH7byBzj6wg6Z4vRgj7S
Content-Language: en-US
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hello all,

The KernelCI project has announced it's second hackfest in September.
The first one was pretty successful in getting some new features added to K=
ernelCI, and the hope is the same will happen next time as well.

One hope from Alice and I is that we can get some CIP members involved to t=
ry and advance KernelCI + CIP integration/collaboration.
If you have any time available during the hackfest and would like to get in=
volved, please let me and/or Guillaume know.

Kind regards, Chris


-----Original Message-----
From: kernelci-members@groups.io <kernelci-members@groups.io> On Behalf Of =
Guillaume Tucker via groups.io
Sent: 02 August 2021 10:00
To: kernelci@groups.io
Cc: kernelci-members <kernelci-members@groups.io>; automated-testing@lists.=
yoctoproject.org; Collabora Kernel ML <kernel@collabora.com>; linux-kernel@=
vger.kernel.org; Jesse Barnes <jsbarnes@google.com>; Summer Wang <wangsumme=
r@google.com>; linux-kselftest@vger.kernel.org; workflows@vger.kernel.org; =
kunit-dev@googlegroups.com; clang-built-linux <clang-built-linux@googlegrou=
ps.com>
Subject: [kernelci-members] KernelCI Hackfest #2 - Sept 6-10 2021

The first KernelCI hackfest[1] early June was successful in getting
a number of kernel developers to work alongside the core KernelCI
team.  Test coverage was increased in particular with kselftest,
LTP, KUnit and a new test suite for libcamera.  We're now improving
documentation and tooling to make it easier for anyone to get
started.  Find out more about KernelCI on https://kernelci.org/.

The second hackfest is scheduled for the 6th-10th September.  It
should be a good opportunity to start discussing and working on
upstream kernel testing topics ahead of the Linux Plumbers
Conference[2].

Here's the project board where anyone can already add some ideas:

https://github.com/orgs/kernelci/projects/5

There is no registration system, but please reply to this email or
send a message on IRC (#kernelci libera.chat) or kernelci.slack.com
if you would like to take part so you'll get email updates and
invitations to the meetings and open hours sessions online.  You
may just drop in and out at any point during the hackfest as you
see fit.

The hackfest features:

* Daily open hours online using Big Blue Button to discuss things
  and get support from the KernelCI team

* KernelCI team members available across most time zones to provide
  quick feedback

* A curated list of topics and a project board to help set
  objectives and coordinate efforts between all contributors


As always, KernelCI is at the service of the kernel community so
please share any feedback you may have to help shape this upcoming
hackfest in the best possible way.

Thanks,
Guillaume


[1] https://foundation.kernelci.org/blog/2021/06/24/the-first-ever-kernelci=
-hackfest/
[2] https://www.linuxplumbersconf.org/event/11/page/104-accepted-microconfe=
rences#cont-test


--xH7byBzj6wg6Z4vRgj7S
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6646): https://lists.cip-project.org/g/cip-dev/message=
/6646
Mute This Topic: https://lists.cip-project.org/mt/84623431/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/452038=
8/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--xH7byBzj6wg6Z4vRgj7S--
