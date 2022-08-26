Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947D9ECAAD4
	for <webhook@archiver.kernel.org>; Fri, 26 Aug 2022 11:00:35 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.115])
 by mx.groups.io with SMTP id smtpd.web08.35856.1661511629191560035
 for <cip-dev@lists.cip-project.org>;
 Fri, 26 Aug 2022 04:00:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=G8HQtwYQ;
 spf=pass (domain: renesas.com, ip: 40.107.114.115,
 mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iRw8XcZZwBdjrkw57a27IePoCNx0sswO1PzitnvrWdK/eIkGcT1Bj3rvCtOKEKK6pOW15r15wObpJDhwmVrV0CZsGufqAblHIvBjl0ozO+Eyhpr4gxw/q/aEvIKviiTCrxtdLvvJneE0/dntzFtxu0kDK/9NArI6xBjjcPDbkP3jny+CqkIgoIh2NL/LFHawuCnMNzLGJq25o67fVIQh8Sbl61qwwEec6vHxkXTfOqZsfJaZeS2f72bH/hzpfGt5/6P6yourVpkf7Wd/A4GJVb26OyT8t9HEzcUKhkIlbuwyqxnyZ2R6RLrDCmkh8CnrjR8v0VX53OrYF9KTOOz0Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=No0mmr0Q98bH2PWcqYLiy223chGktiS0SksdlLrze7g=;
 b=lqsyuhefb8Sw2iYbEz1RTO0SQLv9e1GCkrtGz8XIyK5a9rYvccEQxQk63Bi7vJMZY3MxpTk2jsNAmmm4/usQBCZyAtuGX1TS8rxedHO/fQASn/rPnNlLPjYEqmLoHztbg/Zwynhyu1o6hkaxWsJriYR/H5skS3SRwC2a3imQODf7Yj9zZBRGzCO2iUgVoLT/3grAYwRriZZ+KwP7e+zmNKippbC3P4fKqVNJYl758Dus2HBBMrVKftNwwqGl8rE841l0t+hfAFRDnn3OyUyV44gHHpTu6TBC7E6J/MqQQghEgM65bJZE1vPycYg6o5y2RXV10YKnxuZsN4MzJofIqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=No0mmr0Q98bH2PWcqYLiy223chGktiS0SksdlLrze7g=;
 b=G8HQtwYQe0D+lQjIKk262wYI2Nt2LiLJxk9PbT2TuSTRyFEnUgBqcqTcm/enCV4lNyz0sXBwt/zHH20Wqo+oMNk8YxwmiTOb/61oIquLmcaEEZu41LHNJNYZElIoStCKdaQBjaaXhUoPCeRINOvowDlsb7n6Vwqo2bBzZxSQnuY=
Received: from OSZPR01MB8124.jpnprd01.prod.outlook.com (2603:1096:604:164::6)
 by TY2PR01MB2025.jpnprd01.prod.outlook.com (2603:1096:404:b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Fri, 26 Aug
 2022 11:00:25 +0000
Received: from OSZPR01MB8124.jpnprd01.prod.outlook.com
 ([fe80::1c37:5f36:4f6:74b5]) by OSZPR01MB8124.jpnprd01.prod.outlook.com
 ([fe80::1c37:5f36:4f6:74b5%3]) with mapi id 15.20.5566.015; Fri, 26 Aug 2022
 11:00:25 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Pavel Machek <pavel@denx.de>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
Subject: RE: Root filesystem for risc-v board
Thread-Topic: Root filesystem for risc-v board
Thread-Index: AQHYriSdsw/RBAkMIkCYY3rl4F8dB63BFuMg
Date: Fri, 26 Aug 2022 11:00:24 +0000
Message-ID: 
 <OSZPR01MB8124282CE6E5A0FF01B5A650B7759@OSZPR01MB8124.jpnprd01.prod.outlook.com>
References: <20220812082204.GA16699@duo.ucw.cz>
In-Reply-To: <20220812082204.GA16699@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed46834e-23b5-48f3-7da0-08da87522db7
x-ms-traffictypediagnostic: TY2PR01MB2025:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 awfP5ZRSUQXhtBjmBGFA2jlG0LFQeHbAgqoeyxSYiMItKQOvVz7VDvmuEDB4RqUpRcyyALUxVSbcGYhJLU293lWz08N/SDRfhgmeNa8RUhvOPNlkdoSGpCtigwQLR5WwOSwmFtpZOPAXRHjO92GjjZOcP9BJTaryurS2OXbeX8LDcQtF2l1/odGofmnSWahM3Q7ajx0YZGuexZ/hNigKiOx89JfTAHhirGoAa0VVdayLalAtA7fHiI6Je/zZxWM4wwHQg+GGaa5QftmjgH9SlzlE/LkIx66JuEkNoXbh7tZFd/osb8RoTaKei1TcM88jkj+jdoxM3G9YZMHScHsl1z2b9y7bCqMawkv2K6/PjzRxwXOLnQXFV3jMYeOGsejpyT7FYszB3XgI9LKeOb10TyBV1/yLgFAXas8hpeqolD8mbEGn5jFQMZTyfBUrvVfb+ljHZesotFYnZUayCXpwPw0R5FKxEr1un3fFa31+lB8JUW2STGQba95biuWa2EQN87QV0SNS59UMDkXaeki4oDCWP8ygaC+5bCwXkFVvvgREveuffB/JJRkBLeMTGs3LeBaIVLXC9VJ/bxrckRPNHirlao9/JhahBMvcyYvIG1FDljPgPOiMs4SJmvKyuU0e4Hza1eOcaq4xJtiUPBZPp329isbLv3uVuCzXAEXSQ4Q/1l9k3fxgrAjkg9UMOeeVVH7XOntYsaL/sqLBwXunzdtRu7YWIIiFUBBz0qKnWwqTZTzZWczmx0EnOEEowkDV9pJM67McRvl2PsV2JSGcl9lMCr5KLTkXZJXmUFg27o2YUXpmp3kxzHMirsgiWJ32
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8124.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(366004)(346002)(396003)(376002)(66446008)(41300700001)(2906002)(52536014)(38070700005)(5660300002)(186003)(33656002)(38100700002)(8936002)(86362001)(122000001)(6506007)(76116006)(966005)(8676002)(26005)(478600001)(71200400001)(316002)(55016003)(110136005)(64756008)(7696005)(66476007)(9686003)(66556008)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?+NzIlf8wPO2RzUAD5XXXnIdXQ1PYSJIHwU4w3yqeM9VkSoz2iEVDuN2r?=
 =?Windows-1252?Q?xE/zCjfIlVQ8Uam3PaMYj5KHvPLUJYmk/5ZSeJO4yF+CIyYZLkv5brWz?=
 =?Windows-1252?Q?vVxfhAxTWO/mzdGzeSak6UObWVmlK2AUTfjyhKq0UaF23N7XiV6G4UEf?=
 =?Windows-1252?Q?vt49rpptCR1xo0KCfcgQYzKMKZ54mioQChD9K4KOYLdHyaPQqu/Nc9jk?=
 =?Windows-1252?Q?reDXFaWn4puhMbMKWX96FrUTHqaSltR3+IZJ6TJ5eT5GTqAT1rXYevaR?=
 =?Windows-1252?Q?8Inh3w1k9KEVfI0pi9cEObxPFR/AmzMgQzE3YANsXsrcutOG4LjNrcQe?=
 =?Windows-1252?Q?eRSfRHuRu5r3OrxGVggVNHqazp/0z/m2FRKpf9J0HbIergeYI3qAFsWv?=
 =?Windows-1252?Q?dmgk9/aHsvbSYImeSADyw9OQbaAUsemhny3gEg1UlsPBYwt/1V4z0JXu?=
 =?Windows-1252?Q?4itRg+0LBnxB+Td8nF1NkTTAtosMQz9DgvGkIYqyLy4zEQa2HgSiOn69?=
 =?Windows-1252?Q?VuusgMdaBgWszBe+2se+VheMNrzpl8dY6UJZJGZL/J9QFKg6vzyUdiop?=
 =?Windows-1252?Q?ksY7aiD/KJXtZrTaU4sS6oL0sCEFL9DYoZldVlSWrqbeLsijlVUJz0uL?=
 =?Windows-1252?Q?+3SRlH/6Zs+68CVGupjpLYO9oCC+VkOK5GLVL0DWMm/nCtB0cSZM3egW?=
 =?Windows-1252?Q?de+UqB0AVURjj2rTMTrrvsXhpyDdHCI6bJrbObUTffPIgwllLL3rmjSD?=
 =?Windows-1252?Q?3rGiS1QswSK6818UmUeM65LofYosTsJhzXaFcEZ0Ndt9kTLT/bXTPSVe?=
 =?Windows-1252?Q?D/8KcDS/NROYz8uj/8DwDUNphpmn+Jr309khi1sck7Id6bhMk/SM58TF?=
 =?Windows-1252?Q?QAHNu5BXaChHc3p/Jwq0tD5TdU3o9GGoi0eChtFYXz81pBNckC65cEix?=
 =?Windows-1252?Q?TYteeI6LBHRWZ1OeI2gZLWtpH9EHcGnWZKmoEKJTaSUKlJ3orZDgJDjP?=
 =?Windows-1252?Q?g59X88eafNXwWBD7K3Js3GdNj38GaVnwAif7ZB93ahFRZp/Omz8Q0R8o?=
 =?Windows-1252?Q?sgCPQ1LdZn3IJUQ9aLk/h4ghkSIENa2GvKNweenm43iBxm5JcOJYN0VU?=
 =?Windows-1252?Q?UvBQ9HJlGWSfV6EVZNrDLbAKnrRphQGEnqpfRDLfF3ZT7+SobXF4NPj/?=
 =?Windows-1252?Q?ugm50+avT8o0XMrfOcCqHePmOYuVBd4NTleflHZcgY0o3azmPHVNpIic?=
 =?Windows-1252?Q?qYsqEvn98OMcvx1xf1qPbeweFkLLCaD6teb8gZHC9/uxJcGQfSQ+Npp5?=
 =?Windows-1252?Q?P7FGlyH01W/MnGpw6h0g+guHCcVJvQgnMaGJ4tDyS1JHBYOfZN7dvPy2?=
 =?Windows-1252?Q?R5Zku0zswuA2DDLguIOMxWWx/TJwT44CmQMAGZC2Y0IuhVLu+TVFYZBx?=
 =?Windows-1252?Q?7kmpX9wmPDw0G1H5AeFPA9gQSTFV+rZXQHxXGABK++H4FfPadVfUR5QA?=
 =?Windows-1252?Q?HpOicpG6AZ3ZHwz1+cKdK6WkgAVW7gZ0/TDX76rgRbeevK8W5wcLQqII?=
 =?Windows-1252?Q?4RU/kmoFCb014ziJFyDITNqbbMJidKNQh7tPzVbahVZ68HtBvA8C/6cj?=
 =?Windows-1252?Q?TU7rl75r9Lq5QXCUcea6boohf7UMcxKzJXMjgIx6VgbBUZDQKhsGAKFQ?=
 =?Windows-1252?Q?fj86qWlUa63nRP3LJSQcCjbK+XSPFmQvUM/9malgOgCdXU5Y75oHjA?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8124.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 ed46834e-23b5-48f3-7da0-08da87522db7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2022 11:00:25.0258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 aYWEa+sB+n95bbMKnOHfQdm5+i9GlYU3loJMacIPjnX93K9MCCB3+I3tjmp95uHQa8K0rNnR4VdLj80du8zzwomddWZ8g7zKiNOB0nphuQc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2025
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 26 Aug 2022 11:00:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9320

Hello Pavel,

Apologies for the slow reply, I've been away.

> From: Pavel Machek <pavel@denx.de>
> Sent: 12 August 2022 09:22
>=20
> Hi!
>=20
> So... how do you get root filesystem for RISC-V board? Ideally I'd
> like to get something Debian based.

Renesas' official BSP (v1.0) is Yocto/Poky based and is available on their =
website:
https://www.renesas.com/us/en/products/microcontrollers-microprocessors/rz-=
mpus/rzfive-risc-v-general-purpose-microprocessors-risc-v-cpu-core-andes-ax=
45mp-single-10-ghz-2ch-gigabit-ethernet

But it's in source code form, so it would need building as per the included=
 documentation.

>=20
> Best I could try is debootstrap for Debian testing:
>=20
> sudo debootstrap --no-check-gpg --foreign --arch=3Driscv64 --keyring
> /usr/share/keyrings/debian-ports-archive-keyring.gpg
> --include=3Ddebian-ports-archive-keyring unstable /some/suitable/dir
> http://deb.debian.org/debian-ports
>=20
> Unfortunately, I can't get debootstrap --second-stage to work (I get
> sigsegv in ldconfig, I guess testing may be too experimental?). Is it
> possible to debootstrap stable or testing distributions?
>=20
> I don't think CIP project provides binary images somewhere. What is
> recommended way to get a root filesystem? Is there suitable
> documentation I should follow?

This document describes the build process for the Yocto BSP:
https://www.renesas.com/us/en/document/mas/release-note-rzfive-board-suppor=
t-package-v10

We'll have to work out with CIP how we want to support CIP-Core on the RZ/F=
ive, given the current lack of official risc-v support in Debian.
Something we can discuss in next week's extended TSC.

Kind regards, Chris

>=20
> Thanks and best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

