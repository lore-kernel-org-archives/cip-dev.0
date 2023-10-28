Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C35BC0032E
	for <webhook@archiver.kernel.org>; Sat, 28 Oct 2023 10:04:16 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.107])
 by mx.groups.io with SMTP id smtpd.web10.15503.1698487451530956609
 for <cip-dev@lists.cip-project.org>;
 Sat, 28 Oct 2023 03:04:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=e8KJ4FSR;
 spf=pass (domain: renesas.com, ip: 40.107.114.107, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WDd+Bq46QhHUH+Vrm8ui82KB+tKJjHs2pWZK6HEzwsL6jWTtokk8KOSO28mOrny13/hWvKNp8Q/N64/WUwH6kVMPTsixkIHVQH0TxGGgs04a4BLJq0YfYPrB82b5xJqtUtF0FyvfosUs8eexrYnrn+8H3AP5mGdGmMWpVgUH6kN0Ibvq7/55NILWUDnsNWZekuznPTyNiLQMagLhzl6ee11VeCK55qS1d8ZOfH9+in5wiKxd7S0VMyv6ig9WuliEjxv6KYhL71YXBCciWHJWoHuATFvY6DQ+VWxM/th2jv8CPBYGkLmDbU2oFBlo/CxJbuOmgJ7ds71a/W47nFKQgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vsQ6ztehD/FzLmE+N7aOOWkYj4kJOjuKSAhD2e5YVbQ=;
 b=KrmwNTznPePqjS1+nLT8ZZ0JvynCpt38QFC6yDgsZ9E1LLjBqnk847bMRUwPYzosZdEIjpTnnUZgB0PzRQXQt6oEols7dAfjn1ZIJMD0EusvkKGeJVZRrG8T6WFJabKHx59TsYVsrjCw8ObP1p6tpMm4Dk4kiaXwsrprdlJzdPbUJgTCZ7saVvkHLVGFfo9NqYhcm5tGQm7FehZKpRebDM1a/9tPUx0wI9/ocI4W8AgC1NdfuAtlPtC1Ux5pgWVF6EmPYbPQigFVw05yx/lS23xWEEFCi2EuXbASk3negE+hKX21DkmZCxOkifmDKag3xeABh0jqRfpBNkbjyO55nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vsQ6ztehD/FzLmE+N7aOOWkYj4kJOjuKSAhD2e5YVbQ=;
 b=e8KJ4FSROUoMpMZXkUucDpymKv8riBQ6f29tmCVGOTzMeDg4hf+jT4yGA+uRGDTVSIV7FAXwQDaTVtF6FmjeSyobn5hPB2NJbwHSq/mKyjEfTuJwUy11Z4AH5iLTIJkAyHbE2KM21J5W3aKyDWYrMheIdWLpdsoIKzZ1TtbTXlM=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by TYCPR01MB10381.jpnprd01.prod.outlook.com (2603:1096:400:241::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.24; Sat, 28 Oct
 2023 10:04:05 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::f482:894b:998b:9f3d]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::f482:894b:998b:9f3d%5]) with mapi id 15.20.6933.023; Sat, 28 Oct 2023
 10:04:04 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Pavel Machek <pavel@denx.de>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
Subject: RE: Testing 4.4.302-cip80-rt46 fails at
 test:x86_cip_qemu_defconfig_release
Thread-Topic: Testing 4.4.302-cip80-rt46 fails at
 test:x86_cip_qemu_defconfig_release
Thread-Index: AQHaCMv30qdikQfiYUWNFyLkW2ZIqrBe9SZA
Date: Sat, 28 Oct 2023 10:04:04 +0000
Message-ID: 
 <TY2PR01MB3788E055CD522974A376F0DEB7A3A@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <ZTukTXjiIS2M4t3c@duo.ucw.cz>
In-Reply-To: <ZTukTXjiIS2M4t3c@duo.ucw.cz>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|TYCPR01MB10381:EE_
x-ms-office365-filtering-correlation-id: eecb2e20-7518-46a7-2eea-08dbd79d376e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 kjOVbXUNQB4ejBWhhcXlLGNi3kX6e050Jkv7MH4BVyGuKv8zGmbDNUmBk8Am2uuh0mZZpX6hFiajZs86b4gEIan7iO15Raa/2lNkAxifna7nv2bGlSYEUtKcVkUo1MHtyuAj6Tc0COTvIyv+vpjPU4NydfHEPpyFT3t0/tT8NbYLn64IeOlEUrOmYIDaBkbz1f2FII4NU8lI+R6tn7+CxaTGvM8mBWGkQB9qAW2JXz74Kf1Q5enWYEhbVjzGzJnanASeQcXfcC1lHTSPznzYuChk878vAtSgALJUj/MB9HXC35/bATw41verBS4j+tuMZXhrrOADkO9hGkiK9RwnLzaZphAvK+aOHXqXnT2R+EZuiMnRPhGnD/+Zeb2URHFEGRSDJXOO7Z660v/Q7sJCWX77HGSRCxRriSiLW5rLM/E3HpUY9bI4P0l8sqqAKOQc0kTKsQwM1DGe8miSNUQAj3BJ9nLgaVYvjifi5e8CdpQInvoLEKiuCG9sNRwoztSmIauSalJlZLT+hLijsmMsciVg3E/fPjkE2OOqsFTuN3aVL2shUN4VGAMesC8BpXr6ptbxXFSXjbpA1Bd0eLsaitHTlh1eJybEZdojYW/wkY8=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(346002)(376002)(396003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(55016003)(71200400001)(26005)(7696005)(6506007)(9686003)(83380400001)(5660300002)(41300700001)(52536014)(8936002)(8676002)(966005)(2906002)(478600001)(64756008)(66476007)(110136005)(66946007)(76116006)(66446008)(66556008)(316002)(122000001)(86362001)(33656002)(38100700002)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?2zO1729wZwVe2d03ykKi1HcFML6fOeGtxzYNm7HsU4kL9KkBlCB72Qxe?=
 =?Windows-1252?Q?LAAEmq8FvOY0WR2QUKKadbfeZoHaGWSy6wPuoAFzeLev28ERfin8Xt1p?=
 =?Windows-1252?Q?Gk72mlV0GT11FdPbbXpwBorum/Nq4HHiyd5+nIg/+OTCIAHR9WM3VuUc?=
 =?Windows-1252?Q?/dpaHquMB129sI2dYUROYhFoNicfTogFUVQ66F9LZqYgvnANIhkQsrZB?=
 =?Windows-1252?Q?H4DwLNWy+anOoujZDkEVOdNVeHmMjmGTlpHC90IuMwmrDi82maf8In+r?=
 =?Windows-1252?Q?Ymv1Wg0MIoaOGFuNzRj6fkfsKt8fo1HH/92ON92AfTUrygrMp7wGhmyA?=
 =?Windows-1252?Q?ZJWgoOlIdFObLCeLJHkvOOy6fdg9SnF68OhKwe/7P4ZBx5OhMN3KlI72?=
 =?Windows-1252?Q?9iMT+aTtbH9cdBm5/Y69zTpmhPDlbxbXK2pvBkx1/CpjyIgeWwMbI8Gb?=
 =?Windows-1252?Q?ixVwMKzGyTzKB/R0xSescln8Ulxt/XXZSk1PHM70eV2nSJJxmBKKcFbm?=
 =?Windows-1252?Q?wc5lYXqhZBsTLG9XkIsU39hAf3J1ux7CoinXzF/k4fpqhtR3l2Ifb98K?=
 =?Windows-1252?Q?7PvIcpyDlGGvGqFWeLru7UCaJS49JMzSVtr5BINqMJbR9gI4CBQVap59?=
 =?Windows-1252?Q?ozOiqTKGEs4p2iIk4h80bYLxMPDRuOvbSBtOg0X0r3wn7fc+KvznqStL?=
 =?Windows-1252?Q?UMyYNbRmAzatthaNinj4U73J0YGoAYgFEHjzgNiGcfq5+UI+ujkbNAQ9?=
 =?Windows-1252?Q?36v0v+mJSjY0hJPf6JqpAw5ZBedw+p0CtWo0QmRIpNF5ViYuPY2yzMMj?=
 =?Windows-1252?Q?gaG2U1NB6ZXFLc7R+2f+3hJK5jyw06mrLyvtvvrla7NjPCKK2QZLwk9E?=
 =?Windows-1252?Q?rhXGezjAviwEbErc2QKaEi3MGFdxtEVbGsr9+IoEZcGNFUwteP7ZPryX?=
 =?Windows-1252?Q?eQ9eBYx6qcTelm73eKELsiX7eGkgkc2O4xMC7g93zN6KK3D1mhuLo8Nb?=
 =?Windows-1252?Q?sw1tImquDeyIv1ryPitoQ0bmxQvZqwdOZJIrVt9+7zQVK0YnyeAfghEB?=
 =?Windows-1252?Q?M7GXSOA/Q9kLkPxJg/OjMz4p6XYP7/vrTliygTPv/v9dH4XUj2jDn+dp?=
 =?Windows-1252?Q?su18BbJpcIbJ06mN7sfOcob0uGpKMN1Fg17kNRY6VWVpCLnoleJLB8fS?=
 =?Windows-1252?Q?3X/mhvBgP8UQkQNghCw+QzO+njdFc9EDnxV0oeczxcz6x/ne4hniGvPH?=
 =?Windows-1252?Q?sZrots0/yigL0tVM01Y1vnSPRbRec+ycUtnt88DGj3G/cs2fA2rN/swq?=
 =?Windows-1252?Q?SvKBi7jI04t0LgqUdqowX70FfKuO02Z+TOHip+UkUYnWQV3PwdAJH5jc?=
 =?Windows-1252?Q?dxfasMiSiS8mEO8Pfj56ZLquO2w+QxJHYaTctng7qt78ogH9Wl/4ZtcQ?=
 =?Windows-1252?Q?zyVwRMC9pv1q8heKZMAZez3/Qn/CubIf9XOca6C+kEFahx9n/XnyEAA9?=
 =?Windows-1252?Q?f13KzP06C2SJuqqvDSZYJKaetwfUeRFFPXXlOgPPPZF1gQ2u/Qgg+j53?=
 =?Windows-1252?Q?JY7ScS9K7O4l9ZyicmAUiKiy0EL75hb5fI61l6AfStOpedpwZcbu/zId?=
 =?Windows-1252?Q?ycOu8n3ee2ZPSc0Fl8L08iSXSxkt/eZ1P09JqAFUyUmqEQ5G3IsdcR5/?=
 =?Windows-1252?Q?LVdpFvXGA+oZPBn+o0VV629ad+RCDzCoA3bRyAitpVuqN/yHPNdHFg?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eecb2e20-7518-46a7-2eea-08dbd79d376e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2023 10:04:04.2491
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SjHau29rFs0CaWlAtWQ8vAZdxhnkodNVC0+W5n96Vs7BDJDRrBmbILGqbleLmtUUWtMewAFqXPGX+fjeLUxI4fPpdTENPJvULHSPG8qu0+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10381
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 28 Oct 2023 10:04:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13487

Hello Pavel,

> From: Pavel Machek <pavel@denx.de>
> Sent: Friday, October 27, 2023 12:52 PM
>=20
> Hi!
>=20
> I'm preparing 4.4-cip-rt release, and I'm getting test failure:
>=20
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/105043846=
8
>=20
> Has anything changed recently w.r.t. testing? I don't seem to remember
> test:x86_cip_qemu_defconfig_release variant.

Nothing relevant has changed recently,
and looking at the GitLab pipeline definition this job shouldn't have been =
run as it checks
for branches containing /^.*-rc$/ in the name (see [0]), which "ci/pavel/li=
nux-test" doesn't.
Maybe it's a glitch in the matrix.
Is it happening every time?

[0] https://gitlab.com/cip-project/cip-testing/linux-cip-pipelines/-/blob/m=
aster/linux-cip-pipeline.yml?ref_type=3Dheads#L59

On another note, because you're using the "ci/pavel/linux-test" branch, the=
 RT tests aren't being run - do you want them to?
You need to push a branch name ending with "-rt" to pick the RT tests up au=
tomatically.
e.g. ci/pavel/linux-test-rt
See [1] for the regex it uses.

We did it like this so we didn't have to change the .gitlab-ci.yml file in =
the RT branches to point to a different pipeline definition
compared to the non-RT branches.

[1] https://gitlab.com/cip-project/cip-testing/linux-cip-pipelines/-/blob/m=
aster/linux-cip-pipeline.yml?ref_type=3Dheads#L54

>=20
> Could someone look at the tests and help me analyze the failure?

It failed to log in before a timeout. I'm not sure why.
It looks like it failed to mount the rootfs.
It seems fine on a retry: https://lava.ciplatform.org/scheduler/job/1028621

Kind regards, Chris


>=20
> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

