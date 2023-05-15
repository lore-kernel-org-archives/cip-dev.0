Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C8B4C7EE22
	for <webhook@archiver.kernel.org>; Mon, 15 May 2023 07:26:51 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.118])
 by mx.groups.io with SMTP id smtpd.web11.82734.1684135607758568523
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 May 2023 00:26:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=pjtHzaUs;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.118, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C5A5Ndkbnq87gLTb97N/TaTqkb7p0Eajmjfq4LSyhl8wG6G5jHN0XE5LGFtVnZ/jMEi71hPq+bHqVqjg0Aj+dFNylYSYWEBPXmUMQGte9QqBQSJpIKNN64Mm7bvOE4+UaHZwADfCKNHT/QRMFUlVT9xn7kc33If70pGeaTvWYGG9yy1WL56jR9QElTze6Xmj6cGj5KHRvFlECRLSrhtvUZ+QfN+W3fvZk9XQNYvRjNx8fGvPs3uwWgKgG0tB6YexGoGZ8KzOo+CvgrB8CjhRiPPxGuJ4r6K5tty9kN4QVWDB+vEowNR9sDoa+aaH6jQYRHx0ZIiNTy22oucpJAPGrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Eq8EIZ8LzsUEFZViVwLVqC3GxYVOuIqQL0/VkClw9o=;
 b=f1P/xbWLFi5yMP0kJVN3NzWfCVNa2DTAwXc1N4+XJrXmBtwbGNA8QLsFYcTjk22I0TjhViLitEu6rKEx1ePfUMIQIYzv6ehWqFwiEWQSCv+TEfsUYMv+F3lm/WJOFuewVq+EI9S6bmiVMskEaEAW3o+xEuPMY5+xYla3rgjWuvvI+X1lBGXcXh+bPTVSVLyY+jgjzDK4sZ0edA7+EhvdI0qEPgGSuCjLl+ALej49DGALXXTfiJCShxRLS1HrE6Dz71mjYaQU8ZAcM19FXuf/herkwFBhOxWlRmMhE3w9Nk3u+5geyvq0uAldRS53dyiCn2nphOEGNcawZkydz5VZnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Eq8EIZ8LzsUEFZViVwLVqC3GxYVOuIqQL0/VkClw9o=;
 b=pjtHzaUsNt7+D2bp4PL+wAg6RKB1GEMdUJ7SogWx0FuZr0VpZzTEGDxaOAc3sqw/kr/vlQ9ZeYsKlW2K3Qg/j5ADGbN2Wj94UQDauzk8x8VgjI5LqeDvyO6quDH+K1ZSDdjRJYE44vHhaCXcK7yHJXF9GlD/majJeu6eTiLKzIk=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TY3PR01MB10015.jpnprd01.prod.outlook.com (2603:1096:400:1dc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 07:26:44 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2%6]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 07:26:43 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Backporting MTU3a counter driver to linux-5.10.y-cip
Thread-Topic: Backporting MTU3a counter driver to linux-5.10.y-cip
Thread-Index: AdmG/WaLeUipv7+wQD+BoBNa122sUw==
Date: Mon, 15 May 2023 07:26:43 +0000
Message-ID: 
 <OS0PR01MB5922AA46B8F8C695943085FB86789@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TY3PR01MB10015:EE_
x-ms-office365-filtering-correlation-id: a4ea786f-7324-4d3b-0252-08db5515bbfd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 dU/LdMk8RG6UH8k53wzVAtt/rQ045CW7KlVbTmavmtOOe91qeeXKfM8IVr4ChagwQiHOAlDYLVazFCG0wUrKfh0ZDLXeDnJ6F/CSjAYXRI9juiFdbDKezi1MRoVLAjX1WBkqhoOqKWdrLcdCzrlK/06nPIA0eRJP8903q5FiTRQ/DHGbn9vaXQUEvEaBQ3Z6zXL+sm0H5dcZfuSflxVaYmdYTsHXq2lEA75+yuXXeV0EST2pT0Oj9lXZB1sKfEJiAuudWaRS5yvpK4PZBVYgmyt0BIxZRn5qWwgBtFdv8PVWQ2gockL7T7ijJ0GnibgvEOZKVsf5eO7OSXpmqCSlMcnUyBf03J0DrM1krgzjAdUfa+++3TIbHlif5HUuceLQc9d3jtfVv1muxMbfPew/yvN+5tobUm5UXyMc2IBjv8QJCNkV1uzsAJdmIvEhQ2n+IZJQQ5WjdLvEwy7OY1Xnm/+VRvrH+13n1nFOBxzxZSsfvowTjqAOqKJlQFln1kBwux/91wqKz+yX0E7V4dzDHeBufHZ2SxKBDtVij79E38NGxThRaH6e87qOSkyvBDQhZyGMwvq0r4bRkgGBDk2YYLqoMfCUxktJqmRx4ezFY7qAx8CKgyZaZiJSqCGiC1IkX/9kRuwsqa7Y66l5HTIMhGClobH+y2IsCA/z39wzQWc=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39860400002)(346002)(136003)(376002)(451199021)(66556008)(478600001)(66476007)(66446008)(64756008)(6916009)(66946007)(76116006)(71200400001)(966005)(7696005)(316002)(2906002)(55016003)(8936002)(8676002)(41300700001)(5660300002)(4744005)(26005)(52536014)(122000001)(33656002)(86362001)(38070700005)(38100700002)(83380400001)(186003)(9686003)(6506007)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?hxCxzx20GSje9gsu/KmiUW5BzjyQTQo+XQCGm3qD9EDHeDHsybXwarJJF6HL?=
 =?us-ascii?Q?ZpYAmhTnzdUQ088ii4djgpxcVlMK4Ec7KIUA4fuP8DxxP81gxyiFfZIFUky7?=
 =?us-ascii?Q?4GrCA+KFEBkoR97BhylYcWoD+hYSHSfSp5jOY1i7jeoZDzInTi+y7ZVJdZ0s?=
 =?us-ascii?Q?4ENK8GmaW/5NzVpPqNbr38bixv/RA8rtSYG0PPnT3SxhN+li+H5wv9ePhfPr?=
 =?us-ascii?Q?xCJJa0oq0XC/Nn64W/eKzP2Xjvifs8VNpRgZOK+880fGnMYFOiGMqGu4CRRL?=
 =?us-ascii?Q?8oj15VCIaodr0Ev0t/7Vdup+MjlqzaEz3ZTQwaZnebo+XcTRj8OLACDkHIuC?=
 =?us-ascii?Q?QL9+PgjWGOT6DCZGRpps9goDUi9rDqk3WmtVV5OWGHHQfigIsHIwfKajMuSZ?=
 =?us-ascii?Q?RWg37BpuXHLc8h+O9IIWMj1+GSh4F7R3Ws6Yfmauf23tV9/IErPSPhNx6G4M?=
 =?us-ascii?Q?KF3vHsEmElo3W6I/qILg6roA55F0f9dvDr6VmOQf5yxXePLdveL+9UPUViXA?=
 =?us-ascii?Q?ftlmd6405NEexSg+38PsxOX8BnH0KN4RKG6khe+gMfu/0xHC/Yx6hb91rf/0?=
 =?us-ascii?Q?P18yuSOKKSPyTsAdP60K6QJc5Hh56CVFzdxPFysy4kF47PLpVxm9PczzDUMp?=
 =?us-ascii?Q?Cxqf35ipFuJ0EESW97YQI0q2K6s6o1xOC4pf2EKgqA/HRsKwzPqZ6eVDJSyy?=
 =?us-ascii?Q?JP1XnhHdulHyg4Dvi8/Kylu2jMz6nxkVeJyL8kJTPfhkGYiiMrmp3/R1t6Ba?=
 =?us-ascii?Q?TZ1XczzTlI7Yw6mecVOGxzmsB5GO4G8fbQITOWXmlTUnaOqBVzuobtdv0+hu?=
 =?us-ascii?Q?lepEPxSCtvlVEbxYuD9K+WCkcTQoWJ9HYkYef0yrnS7tQeeSr5BqahRoz8oM?=
 =?us-ascii?Q?0bbp9yN7IWtHLuUFwYNgpu+SkOlhk1dZegxi9TA4cfj9NYWcz3hORb0E3afx?=
 =?us-ascii?Q?mHjPpfZy6SoDgju3wmgpEVSTdzrB99wTvYEQnnKuBo3pFIBV5l7TEHVHaetY?=
 =?us-ascii?Q?lcpdFdeweDqOgsH2YIwKjIdpHrPccp72BTii6GkX9kF6oOigoBpRdI2RYhHi?=
 =?us-ascii?Q?oEzG4bd2ZSrupDu7WnHqkWRg+CgDY1nHQOQLvjhQihy8xrQPTMk9iyhli5u+?=
 =?us-ascii?Q?YDnGTxTQua0BCvwwjLwerZU0uFP1f1Rv1FGfedHDohaMSGenhO7b1xU3EZKi?=
 =?us-ascii?Q?x6z0q2LU5LfnHUWMZBjF12xx4csxaa3T8+lRpCco3QdAhZkVIe7we/y+8qdd?=
 =?us-ascii?Q?3i/QPCcqc+ARb979xIC0cj/Gnc3AEBPUtUFCnWmIWJS0yb/ThUmqI+xC38R5?=
 =?us-ascii?Q?0titI8Xvy6kLfcEJ/2Yj9oVn86/8M1dzSTZ/QYOzy4EyMeJztPxJYJO4iLUl?=
 =?us-ascii?Q?tMw2cfKrDBHuNPMhjkSX/3enuHxi8vTLAAqixv018LpS/GoMCySKgvO/2jUI?=
 =?us-ascii?Q?gdy3jQty2TfIDUGZby4eT3ytUapwIt8JBrRpqC1GQSrWjLnUAt7HRjzQ8ynJ?=
 =?us-ascii?Q?F9q+9JYntasFCHmgzDAQWnoikwo1tu9J3W2Wj9JsScxO5uA5zJweWtRHSzsq?=
 =?us-ascii?Q?2pX4FrMyMUpmA+OluQcmSHRYZ1sh9Ot4QSQkYP8t?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4ea786f-7324-4d3b-0252-08db5515bbfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 07:26:43.9088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6EVmY1y5ZwdAwGQsVScZp3vdQq5UjIcWLurY4lS31B1sEI7HDCMSr11C8F9SNVsyGwEuHiPlZDpuxRIRznFLYFAXOoF3LphZhfA7UMPJFqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10015
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 May 2023 07:26:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11443

Hi All,

RZ/G2L MTU3a counter driver support is added to 6.4 mainline kernel [1].

Counter framework restructure happened from 5.15 along with that
all vendor specific driver code is also updated[2] and [3]

Other than that lot of sysfs entries added after 5.10 see [4]

Q1) Do you have any suggestion how to support counter driver in 5.10.y-cip?


[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?h=3Dv6.4-rc2&id=3D0be8907359df4c62319f5cb2c6981ff0d9ebf35a

[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/drivers/counter?h=3Dv6.4-rc2&id=3Daaec1a0f76ec25f46bbb17b81487c4b0e1c318=
c5

[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/drivers/counter?h=3Dv6.4-rc2&id=3Db6c50affda5957a3629b149a91c7f6688ffce7=
f7

[4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/=
Documentation/ABI/testing/sysfs-bus-counter?h=3Dv6.4-rc2


Cheers,
Biju

