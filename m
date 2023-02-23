Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D8B8C636D7
	for <webhook@archiver.kernel.org>; Thu, 23 Feb 2023 11:31:49 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.101])
 by mx.groups.io with SMTP id smtpd.web10.8253.1677151907409352595
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Feb 2023 03:31:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=AHqdU8JP;
 spf=pass (domain: renesas.com, ip: 40.107.113.101, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ndWusf5w5JVHXOc5jFyZkaf3lHiQ1u7wRRd+9TFNjLifZqq4zvDmUYHObvT7o8ArOrKR8Y7bMuFuwvpJNB0WR2dkaZwlAeEeUvzBc83ScEib70uVrzuBJwrKlFPuTB6xsqxcnqsWDk/m5e4rZ+8FCE8WAplgOBHI28udNUB+YXuPTJd741AYGOS+QuSeTAQvf4M2hQ6t3Ip584Ea7gzbp7wjoGvgz79O3yo5LQH3/NU4GIIPQXCkeKcqcmWFMQ+mCRu3GQGcQnmrTpW36amdyam7rB7mJesec0UnI7CglD7SrDYVbUg+u0pNiPXQtcxLcY9zv4wyom2LqLZAmhy82g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PeVLTSYo2atZ5SP9aTBS4ALXOQCz4Uftw9NrWbu7cPE=;
 b=k6qJhq6hvJh/nHLABrsJXTuXK7PyiEmcJvT9CpAIuU3FC6QdEpAaST3XrcH16AALq5FbI9YRm713+PYxaaFQPjv42IBaF7aI2F/V+3uEV4mC0FgBcDm6mKPGS87GSeFnVTuolfb36YgNxv27vIqee8U3N1tCoaXv7gsOsyR9/Rb4cAyWxy22vaaomMgJ6eleVEXaazgbkNJRiHX832hf+QPKbd8sUFBWL/+hNIhvfFx0hBU37O6vo/nQSmrfEXzlS3DRy7pJQY9xVLM+Nj4nuzLJXonhessc7kVA0X4xCXiCcGPdQ4O7/oPyibg8TsAiGC9E6JeuxsWpVLjh30B7jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PeVLTSYo2atZ5SP9aTBS4ALXOQCz4Uftw9NrWbu7cPE=;
 b=AHqdU8JPTbwsI867cN03Ck/N/q4TjvoL3h91MnnNVJimiP1CEFre0OnJuTU9Toe3GgklZGCtVYgN7/bBmH4NPhaVB0LTxFiYfqJnSXja3lvMyfcENZmKsowzv571OikiFe8aX2Mfcqyrfutj5ZuTAOV4Q3e0X4SisPiLoQCfnPM=
Received: from TYCPR01MB10588.jpnprd01.prod.outlook.com (2603:1096:400:309::8)
 by OS0PR01MB5313.jpnprd01.prod.outlook.com (2603:1096:604:a0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21; Thu, 23 Feb
 2023 11:31:43 +0000
Received: from TYCPR01MB10588.jpnprd01.prod.outlook.com
 ([fe80::dc49:e307:b424:4a53]) by TYCPR01MB10588.jpnprd01.prod.outlook.com
 ([fe80::dc49:e307:b424:4a53%4]) with mapi id 15.20.6134.021; Thu, 23 Feb 2023
 11:31:43 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Topic: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Index: AQHZR1L0nk52Cuq3NUuHDZq1v5G8cq7cWoiQ
Date: Thu, 23 Feb 2023 11:31:43 +0000
Message-ID: 
 <TYCPR01MB10588023849C8A6929A21B45EB7AB9@TYCPR01MB10588.jpnprd01.prod.outlook.com>
References: <4c4ee732-415b-3552-a255-058ac13a2c2c@siemens.com>
In-Reply-To: <4c4ee732-415b-3552-a255-058ac13a2c2c@siemens.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10588:EE_|OS0PR01MB5313:EE_
x-ms-office365-filtering-correlation-id: 4add3671-2c63-4c66-699d-08db159189f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 hM/L380oLSFqnGw+vdv+ZJO6IGaUknxQ2PItZ3VxSl58cCS5uSY5F94TXJqytActCcJS/hanfVW12OTEM+SToskjGh/JEzqb0SRJTaV5tRUcYEGWBtADDWR/kftRfCVnfNHaS1wWeLEDG9XTc5KHsJfOi7W46e6g4IFBArk5TgbzlG5KfWJVsOgNgz6zUPtpstYtIPO1wXGyPlJiaGyhBw0xrPrCDSTYcS62qho8L+k0YQNZyCQNnsRQ3syAhkpG/osgQgIBi4dWfy0+GbJcarF0YI+V0RLu5zFGl4Xa3V+DSE3ZFa4szxMXoUCrzg/eD8g1nspYiK5tSyQz5MmOwHjirIM0z7nP7RWXCDKeyYlIK9NnMCjbREOO+NEwsXe3NlF/WZ4vhaB6+eu1Qns+TgnA5QGf1/CXaC7WTfM9igC2ZQJhompGyz8NVkQQwm2ddylgtJx8gAeBimH9pmK/3bCSc5tlREMLziCgPiuvW2tMZFc9EbeK4W3tn7fTJtggN4UUrk9HE2znOldw8bmz6QaWh5PM0+suQS1E1eWmQ25vhzARCI7UAIf5c+kEFgtKXmwKfqQ608uV07GptRCBSxEEg/7tsn3Up3uw2jnBrtOWsWBPXKmwfQPLDMB109zcBWGnZBEXHkWnDhUJ2eYCDTTltOX9sYbHRwNtQlhSkRWUjgvhTXzCemYppkddMg5gbt/41B57yZCPH73w5dS273RNU33km7fnzXZDun3yEXo=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(451199018)(5660300002)(52536014)(41300700001)(8936002)(55016003)(33656002)(86362001)(38070700005)(2906002)(38100700002)(966005)(478600001)(7696005)(71200400001)(122000001)(186003)(26005)(9686003)(6506007)(8676002)(64756008)(66446008)(66476007)(66556008)(76116006)(66946007)(83380400001)(6916009)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?alynbqSNu5PsitYgVS+6FWJ7bbs3QEEcbrcx+jSp+s0BMt+nkGOC+FSN?=
 =?Windows-1252?Q?d+U3Nzu8mNLEHhiSA1vBbBTv4hQybMSfiFAsMaGpnpN784K1x+TeeLMY?=
 =?Windows-1252?Q?fzZ2YMmz81e5fiy0WoECRZ0Gqh+5ev7E4JN7xVBgtvUdQCPnpyo0sEJ0?=
 =?Windows-1252?Q?Dr9stXsyNUvjW878ovqawfUTVe2YMWNH+XJ4623cDuJm9Vpkc6y8BD6W?=
 =?Windows-1252?Q?4ZZqY/4ysuJ3IEnJ07YYW+qhJYKZ0KfrORBvMy84RwK2RK0T2IY0+dfw?=
 =?Windows-1252?Q?Hmv0M2riNnCpOPYBVku8uVHRvqi+xjnoXkyvBorDJhNGyDxdfe/UbY3O?=
 =?Windows-1252?Q?9SRFC4UoO486zi3oG9jHxJDoYaIpswGYcJHllEipsMG+b/82prnQ4OVu?=
 =?Windows-1252?Q?XlVPgpnDB+DvMMP39sjfyOYcVISUgr0a6QhsVJMU+ujLWQ+W/kipbfn5?=
 =?Windows-1252?Q?k9IpZg4rvOwOT0ij/uprhykqx4xbbS5quoUAndOzPkYJmjA1Qdxv/OSm?=
 =?Windows-1252?Q?R65Qsn+AGC2Y3kvYxKNnjnmnD6kuOVAuv1twBbB31Eg3MbBH6TxkGHCQ?=
 =?Windows-1252?Q?OzZ9nW+bORfgpcC1L2SkM7Sonk0G+BKpxJKMhwk56IV+dTv5okf98jXy?=
 =?Windows-1252?Q?EdM4h4dr+zc/OdYAuMcUPJMcKxUWAG90cnKcSHa/Dmda8Aq3FxxB49ZT?=
 =?Windows-1252?Q?nHoziPmgf/5F/xkRKWH4RilR3lWHz3echREtm3LQi/e9yTawNiY6Twff?=
 =?Windows-1252?Q?wzWBr3ZJaRD/ds7jolwG9qpiXeI8TCcGm8+ZSRMTzX0j9Lpie66KHxGx?=
 =?Windows-1252?Q?JWxpkV3Nc4+ij5V+hdDMNBkhD7gpEEg95cQPU3YZy4i4Cl1VXxnq2GRE?=
 =?Windows-1252?Q?2UT20OIfNy8rugwp0kmi1LJ3xoLS1atwrpvCV4DetwCT/AslWKm+BWa0?=
 =?Windows-1252?Q?FycI7bnQtnjT2IrAO1V7a/fYh4KUsq85u17tWN55yXjciTEF/x4IB2QC?=
 =?Windows-1252?Q?LUT2WxpQbDrTcBzaW2j6hRz9a65qaXu9yRTkQcdUpHj1eBapMz133bua?=
 =?Windows-1252?Q?5fl8BdDGs3istbctXqlj3fDPVb9dOu/Nem7IljS8U4OUwv+sCdfgNWR5?=
 =?Windows-1252?Q?JER+M5EeLmhlpkWGiq7JRudKur5hOXbTjyjAoJY+3iF8u9vQpEGl1Xb9?=
 =?Windows-1252?Q?JCxWksbAg2EnmvzymbZbifvgCOqQZR0LybhXX3GTz1w7TlNGo7jR8HRM?=
 =?Windows-1252?Q?zDZhCx9On/tXR7DZWmeVafWw3XRDtpXt68oJtGCOqg4oiJ6XtDXRWea0?=
 =?Windows-1252?Q?idE8sIdg97jPrJltk/TRP4ARGD+C7K1hZNM0GHUbN/kUeYJ5hPXiMHzO?=
 =?Windows-1252?Q?bQS8fTFRmdsUdldB91D44fmOrH7ObUNbGoBRJhm3fjLaq1KAsqh2064e?=
 =?Windows-1252?Q?bSrUo8biN3DesejCHq2omlFoajpenaIWSiphxWVPEGgU04br7tovIKsq?=
 =?Windows-1252?Q?UTHQ7VhYts6pbWuBHkqdvs98uKNHgwHYaLBkZnPupSSR3f3/DPViTw7+?=
 =?Windows-1252?Q?3AAXJ3xLpLQbW1lO8TfQWhCLzwUQPCzejtLrUxLRRVy2MZiVmlQWBQE2?=
 =?Windows-1252?Q?h2gxBMqnh6fimFPNTeaXEfzZt1GyBZoG3RoQcFCLtFFaygIPVQZqsF40?=
 =?Windows-1252?Q?zI8wbwCUoekP2KHMGu4j0VGmnWquguY/wSkTpOL5NdDfgSejccvgnA?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4add3671-2c63-4c66-699d-08db159189f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2023 11:31:43.1576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: npnoou3r6GvhEMDla5l1f+h2WhP/B3mcwXhjiKpqCuI8R7WO6EIj+gWMD1ITxfNcSGmbuyNTpeRi8jo2MTHhTVNqaOpS3upY9ol9bi2WxHQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5313
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Feb 2023 11:31:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10797

Hello Jan, all,

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Jan Kiszka via lists.cip-project.org
> Sent: 23 February 2023 06:49
>=20
> Hi all,
>=20
> Kindly be reminded to attend the weekly meeting through IRC to discuss
> technical topics with CIP kernel today. Our channel is the following:
>=20
>     irc:irc.libera.chat:6667/cip
>=20
> The IRC meeting is scheduled to UTC (GMT) 13:00:

I'm sorry, but again I cannot make it this week :(

>=20
> * Action items
>   1. enable more stable trees for testing (patersonc)

I've actually started work on this!

For the kernel configs I have used 5.10 as a base.
WIP branch: https://gitlab.com/patersonc/cip-kernel-config/-/tree/patersonc=
/add-more-stable-trees/

For the CI pipelines again I have used 5.10 as a base.
WIP branch: https://gitlab.com/patersonc/linux-cip-pipelines/-/tree/paterso=
nc/add-more-stable-trees/trees

I've kicked off some initial builds just to see what works doesn't work, th=
en I'll adjust from there.

>   2. report 6.1 test plan to LKML (pavel, depends on 1.)
> * Kernel maintenance updates
> * Kernel release status
>   - 4.4
>   - 4.19
>   - 5.10
> * Kernel testing

Currently working on adding CI support for 4.14, 5.4, 5.15 and 6.1 LTS stab=
le-rc branches.

> * AOB
>   - topics for extended TSC meeting

Topic: Sources files in cip-kernel-config
The 5.10 directory only contains defconfig files.
Do we no longer use the "sources" files to manage what needs maintaining in=
 the kernel?

Kind regards, Chris

>=20
> Jan

