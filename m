Return-Path: <SRS0=itbX=NY=lists.cip-project.org=bounce+64572+6718+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73339C433F5
	for <cip-dev@archiver.kernel.org>; Thu,  2 Sep 2021 20:59:19 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C07F060249
	for <cip-dev@archiver.kernel.org>; Thu,  2 Sep 2021 20:59:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C07F060249
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id EIZhYY4521723xKiKNtqRmCA; Thu, 02 Sep 2021 13:59:18 -0700
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.121])
 by mx.groups.io with SMTP id smtpd.web09.3030.1630616356028707628
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Sep 2021 13:59:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HbdA4BEsfyKhP2CNgfRMQw5vKMVDc37SXj6ijn7twwmEfZpv/AMdhemo5L75KAl0ltBC5pVPQeM3bcW+KEeU96exnlmJdAZGV6iW0QmpPaJeXbjPnoS1BEvBA5DX5RlxDh/N3eh8AI4YcooeYHjA+QzY3bnh6sDLf06GYtofaLtKgUdA1ogpe4PIobbz/kplfKvELV0llhY7DRzsJbSvBeCPEx6P9cuctmTC/eokquQbBssdjw2oSFns7siWNbfLigVFHBeqzmj/AuT1Nto8uNy31CO7Qiy3WHDyvRFXOUQKKIna+eLDfUQlztf38VLt1hFANHAeC0i8y1SOApm03g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gi+K2XQxrsDhb13dsmHwbTDshsr6c4klPHemDLWT8Gw=;
 b=WTvg5EeVMTR7uJnqDYdpmXZxo9vgZ/cz+4r+diYMmkGOzMjaTuyL6IE4ntURbF+L9Jezqjuw023OA3X/CDp8cIWvcdhr1yAaHx04TZSMEZfK5/hXGp5xiXKizkQD3e/hKeZAkoT0zFEWhq2DVSH6SIpB0ivOckvqUpsV3e7Jk2QC1BjHUbGJO3NgEJSxii4/TPc7cUbtL8gRmPwA/ewQJ1FAT1UrLd96BjfMm5e6MD/e/8g6OXHapUvwitKWBouppjj7zttNphNvQ5fmFrLxhIeDwMGlpLvwFwrSEq7YXkl62kFnSvk5FAF8U3rFiAwzEuCtkFL5ATFg2eVDXZ804g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
X-Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com (2603:1096:604:13d::6)
 by OS0PR01MB6482.jpnprd01.prod.outlook.com (2603:1096:604:e7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Thu, 2 Sep
 2021 20:59:12 +0000
X-Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::3c89:5065:e852:bbdf]) by OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::3c89:5065:e852:bbdf%6]) with mapi id 15.20.4457.026; Thu, 2 Sep 2021
 20:59:12 +0000
From: "Chris Paterson" <chris.paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: [cip-dev] FW: KernelCI Hackfest #2 - Sept 6-10 2021
Thread-Topic: KernelCI Hackfest #2 - Sept 6-10 2021
Thread-Index: AQHXoDhgvswo8FC6pEG8qQrAoRngOauROYDg
Date: Thu, 2 Sep 2021 20:59:12 +0000
Message-ID: 
 <OSZPR01MB6877C09B5E6A2846A5D0C4F6B7CE9@OSZPR01MB6877.jpnprd01.prod.outlook.com>
References: <169771B791E5E075.25031@groups.io>
 <259a2ea9-63da-b5df-3496-676c2b76700b@collabora.com>
In-Reply-To: <259a2ea9-63da-b5df-3496-676c2b76700b@collabora.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8c9f181b-25a8-411b-7fbc-08d96e548439
x-ms-traffictypediagnostic: OS0PR01MB6482:
x-microsoft-antispam-prvs: 
 <OS0PR01MB6482EDC8121ACB3888DB2742B7CE9@OS0PR01MB6482.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam-message-info: 
 aUwxyFXXBQTG7HAJXmiiuG73G6zWgIMjAFrdMaXLrK8vveP/sPoE6YHynPq8DwT7Mme+SnrS8uPT0aFxieV0/6jZkyGtI/rZjuGZQJhU6yysTZ8WdKX6n1cfmRwtrmTstfOJ2LzvuKl8kTxZIlVXd402BPHnAnTNnk9xAzugDXdZxhIBRfYicvKoLLWlI4CRjif+6FWfw9Rzf4lyGpbwbSZUWExvcK4XaDY/cV/4P/oGBgnXySDCS+mCYFw3BWDNSsfjmBwf/DnND0gUrEWwYQEfsTo/4vQtuIdoOSEXIDiu5kvg/guu3LwvMJYMoBNLN4chfYAl3/0unsrZdbtUoX4jsdzmu+h3hDaziojtyqCt/qUcpb/fVm4vz9b2E/HgWlS+oFTH2Mg6gZMYxJweqia51KnXrY9vleFd25f4V2WYc5druY9PRVW4ulEddyKgf+ZRd99joCaLWNChtb4Rg8wgJdtI0gnOeKCYkkgN1YWNCZveFqh6zE27VWFSOj+eQ1lpMdFT/K/lm0PY1Zh2gEVv/bGojsJzhqasZnSMZFIgBUy+VKDt4k2tU0wp6KXotR7dm9P5G+YBasXDJ3cGgNxcCScpdszotSwag+DFRGdZRwIQiggOShhtVoaMagts8yVbSDdM0bFxUI2SgDHdcsIvTAFN0B5MjTdDCNz8AQFQrTnDNpAwAKR91oDzB+bSDGJGNZbPO1cXItngHsh2vtO7Cd0AoW6WZt5r1nFbCW1S4/UO98djf26XDDJuhdWxBskMAvF9LzAaFAkPsAeFOZXc15mVD4apFap8hfSObyNHAR1gkS/J9KqEr/1L7ztrhkEfWdNrJ3lw8UGByA/c0g==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?jgV4KKWkNEMSG9vacS3SHK+dPvbW+rdPbUGdBtgXtQmvQP7CgAQs6CKB?=
 =?Windows-1252?Q?7vDUVi6h8Fg/kl5MVAJFm8n1INVea8WfIx704qxf6Hz4yAieCTiuykBi?=
 =?Windows-1252?Q?rwI3yhYVz+yJXPHtkOUPZAaI3hPdPi99ZemFtXaeeW2gB0bgW3h8gx4A?=
 =?Windows-1252?Q?LCyJqQx8S4Scoxx4ySOEcN41rbYsFxx3/Mg22ykrNQ+6QL4DVbWSTPkT?=
 =?Windows-1252?Q?1Famfogvpd7tXRfXU4BnwMEYqh7IzHq8NaM1yTqlZ/OIpp0nDvjZqS1E?=
 =?Windows-1252?Q?z0+PUW2e2v7ygowP+1Kl7zs5gxglK+4FvC1SJaxu8FBphW4wdUjGzcr2?=
 =?Windows-1252?Q?7+s/dxlY4vmRHr7HdHUR/PyFoNWGUBMGlKo5Rmb75Gekq58TbqWg6Q8/?=
 =?Windows-1252?Q?RtuswQTLQb4gTat1QKaGuaUz8LOzWaLnSHpeaCGOQXwonh6n630J/uzA?=
 =?Windows-1252?Q?OPnw2qxWqpqoNClUrklUs81ax2Io4iult0zuYQLr7s/bBRQVIM4qbpfE?=
 =?Windows-1252?Q?g0rya0vODzrizSf7ef6Z+zU1i7uqtt5vvLOdAeBiVV03NBwWaTWjGGDb?=
 =?Windows-1252?Q?RwJ7YjCG4KXaKnnVl3rjRQW2HfQoQ5AW5XAFnGrMXZy0WpnIvQAqTZQG?=
 =?Windows-1252?Q?adL584k5EV2wN2PjlXv/VEvbFHRwvAG2nabSnopFIzz9oe97RgVTae5b?=
 =?Windows-1252?Q?66xTZZQa30ujrc9DRDwmITpZTcNWPraLU6JpzmIIMioJiSHhCCTwl1Ux?=
 =?Windows-1252?Q?wJ/p94yQ1U0wf94v4HOMhdRz7fKrFKpjh+1JjkfjuKcE+y/8Bsu2N4GX?=
 =?Windows-1252?Q?r8SlmwberIP0dJhbkeAAjjUVfXIF1wWl6bTVRk+mYTgO65JKQK9/hRnO?=
 =?Windows-1252?Q?Bs870CWqzXcVhTLlSDOg5J9MvKI0m3R/bvh10ov+inZ50kWdOKARBEdb?=
 =?Windows-1252?Q?vXHBinazJb5A/4r1yYmLyoOeA5D3T+K6gDMD+wMhA3kD0Q48OPT9OkCG?=
 =?Windows-1252?Q?M+vkE4u4rn4Lpasvw68VKpxd3EGyIphM6UdjymKY4etPUa5wmwlVSkgN?=
 =?Windows-1252?Q?ZnQVluv/C6i51ZPZmTvth0WqXxCK/pUvoITvU/x/5u3CjSv7q1b9pEjQ?=
 =?Windows-1252?Q?llm0+VsN17crUvNm5uYJIlZ9rilmjCYrS6t2zW/ptABBU2GVQUPrBjxC?=
 =?Windows-1252?Q?7BYxvXoH3rsnaErZXQDqTPNzQDXUtdtyUR11wgeDPKrBxFVD8zjMsSGz?=
 =?Windows-1252?Q?CJMWXJTZ0wSfzx+bfcnY+QxQYqfO0bSeXeNaoMZz90xhN+2myYx5ituS?=
 =?Windows-1252?Q?vONGb+C3bIgaDFBaFh8ahkv2f7ZgITahiQb0oeYNVvhziDjnCf5xN6t9?=
 =?Windows-1252?Q?y1VzGo1Y36j90UpbHrLvtatj6AEXjWLpDlW2Ma4JkG0Jx09LOwX2gLdj?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6877.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c9f181b-25a8-411b-7fbc-08d96e548439
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2021 20:59:12.2721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yt6xlpOJyMBCmQbHd7Eh6Bb4nIoYFxjb59dicG5Zet7aHyhHpxxGI7NQY6Bm0eoRDlbr9Y+BWKSSZVe+O+VFsrzSSUFvNyDc+xd3QGgfJZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB6482
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Y8lpFnNS6W64LFBpiiIXkc8Gx4520388AA=
Content-Type: multipart/mixed; boundary="l9KgkelsRpsOl4UfX0x3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1630616358;
 bh=UPC8octUEJcpjab0bqD3q8baAdwwrZJ1C+j3kAInVps=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=NJb5zzAv72PWFkw3uvTk4qiWFF5DU3J1A9vMV+yUSKnAbGWRSbE6EGsHgrG4sa0z5pz
 evRB7cNLDHlJiU2KCdG7moMrYv7DcyLKAc6MSi01lcZVFXtIwThlCwLjlOKXaSTkXMZnE
 pfPxHQDRkKO+HgJygbz+kx5XqZYh6RALA2Q=

--l9KgkelsRpsOl4UfX0x3
Content-Language: en-US
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

FYI

Link to original message without annoying safelinks: https://lore.kernel.or=
g/lkml/259a2ea9-63da-b5df-3496-676c2b76700b@collabora.com/

Kind regards, Chris

-----Original Message-----
From: kernelci@groups.io <kernelci@groups.io> On Behalf Of Guillaume Tucker=
 via groups.io
Sent: 02 September 2021 21:23
To: kernelci@groups.io
Cc: kernelci-members <kernelci-members@groups.io>; automated-testing@lists.=
yoctoproject.org; Collabora Kernel ML <kernel@collabora.com>; linux-kernel@=
vger.kernel.org; Jesse Barnes <jsbarnes@google.com>; Summer Wang <wangsumme=
r@google.com>; linux-kselftest@vger.kernel.org; workflows@vger.kernel.org; =
kunit-dev@googlegroups.com; clang-built-linux <clang-built-linux@googlegrou=
ps.com>
Subject: Re: KernelCI Hackfest #2 - Sept 6-10 2021

On 02/08/2021 10:00, Guillaume Tucker wrote:
> The first KernelCI hackfest[1] early June was successful in getting
> a number of kernel developers to work alongside the core KernelCI
> team.  Test coverage was increased in particular with kselftest,
> LTP, KUnit and a new test suite for libcamera.  We're now improving
> documentation and tooling to make it easier for anyone to get
> started.  Find out more about KernelCI on https://jpn01.safelinks.protect=
ion.outlook.com/?url=3Dhttps%3A%2F%2Fkernelci.org%2F&amp;data=3D04%7C01%7Cc=
hris.paterson2%40renesas.com%7C40b772cad9334f95da9b08d96e4f817e%7C53d82571d=
a1947e49cb4625a166a4a2a%7C0%7C0%7C637662110028350236%7CUnknown%7CTWFpbGZsb3=
d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000=
&amp;sdata=3DiIHFXGomNuCK3P0HrOhisyVXHrdtecW8wKCxl5pR20M%3D&amp;reserved=3D=
0.
>=20
> The second hackfest is scheduled for the 6th-10th September.  It
> should be a good opportunity to start discussing and working on
> upstream kernel testing topics ahead of the Linux Plumbers
> Conference[2].

Please find below some extra information for the KernelCI
Hackfest which is taking place next week.  We're expecting at
least some contributors from the Civil Infrastructure Platform
project, the Google Chrome OS kernel team, Collabora kernel
developers and a few more from the wider Linux kernel community.

If you need any direct support, please reply to this email or ask
on kernelci.slack.com or IRC #kernelci (libera.chat).


> Here's the project board where anyone can already add some ideas:
>=20
>   https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
hub.com%2Forgs%2Fkernelci%2Fprojects%2F5&amp;data=3D04%7C01%7Cchris.paterso=
n2%40renesas.com%7C40b772cad9334f95da9b08d96e4f817e%7C53d82571da1947e49cb46=
25a166a4a2a%7C0%7C0%7C637662110028350236%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC=
4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=
=3DcaRm3FAsB7Dbgr9eQrFvPIOG0NIVJgg%2BUOh5Jxh%2F5Dg%3D&amp;reserved=3D0

In order to add an issue to the workboard, please first create
one in a KernelCI GitHub repository such as kernelci-core:

  https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithu=
b.com%2Fkernelci%2Fkernelci-core%2Fissues&amp;data=3D04%7C01%7Cchris.paters=
on2%40renesas.com%7C40b772cad9334f95da9b08d96e4f817e%7C53d82571da1947e49cb4=
625a166a4a2a%7C0%7C0%7C637662110028350236%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiM=
C4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=
=3DtbQmPdA4sJrRLpDSp3ExMS9ZiEVYgk%2BoPdylxe7zCNU%3D&amp;reserved=3D0

Each contributor to the hackfest should be added to the
KernelCI "hackers" team, which has permission to edit the
workboard.  If you aren't part of this team yet, please ask and
you'll be invited.

Note: Having a GitHub account is not mandatory for taking part in
the hackfest.  It's mainly there to facilitate coordination, even
though it is required in order to contribute to the KernelCI
GitHub repositories.  Contributions as part of the hackfest may
also be in the kernel tree such as improvements to kselftest,
KUnit or bug fixes, or other test suites such as LTP etc.


> The hackfest features:
>=20
> * Daily open hours online using Big Blue Button to discuss things
>   and get support from the KernelCI team
>=20
> * KernelCI team members available across most time zones to provide
>   quick feedback
>=20
> * A curated list of topics and a project board to help set
>   objectives and coordinate efforts between all contributors

Please see the table below with the proposed daily open hours to
accommodate most time zones:

Region        Zone    Time 1       Time 2
East Asia     GMT+10  17:00-19:00  03:00-05:00
Europe        GMT+2   09:00-11:00  19:00-21:00
              UTC     07:00-09:00  17:00-19:00
West America  GMT-7   00:00-02:00  10:00-12:00


They will be held as a Big Blue Button virtual conference with
the same URL as the last hackfest.  It's not being shared
publicly to avoid any potential abuse, so please ask if you don't
have it already.

On Monday, the focus should be put on getting started and
reviewing the backlog on the hackfest workboard to distribute
things among people or help new contributors find topics suitable
for them.  Open hours are otherwise opportunities to get more
direct support from the KernelCI team or discuss any topic.

See you there!

Best wishes,
Guillaume

> [1] https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Ff=
oundation.kernelci.org%2Fblog%2F2021%2F06%2F24%2Fthe-first-ever-kernelci-ha=
ckfest%2F&amp;data=3D04%7C01%7Cchris.paterson2%40renesas.com%7C40b772cad933=
4f95da9b08d96e4f817e%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C637662110=
028350236%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBT=
iI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DOVrrOfoO%2B2nR9RKQpw30D54Dq%2F=
1Ucyof9fC9sPwbcLI%3D&amp;reserved=3D0
> [2] https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fw=
ww.linuxplumbersconf.org%2Fevent%2F11%2Fpage%2F104-accepted-microconference=
s%23cont-test&amp;data=3D04%7C01%7Cchris.paterson2%40renesas.com%7C40b772ca=
d9334f95da9b08d96e4f817e%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C63766=
2110028350236%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiL=
CJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D%2F3TpKlnnvfOnK6laB1pwXsJH=
L6lycG4wMg03Ar%2BIYJ0%3D&amp;reserved=3D0






--l9KgkelsRpsOl4UfX0x3
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6718): https://lists.cip-project.org/g/cip-dev/message/=
6718
Mute This Topic: https://lists.cip-project.org/mt/85338103/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--l9KgkelsRpsOl4UfX0x3--
