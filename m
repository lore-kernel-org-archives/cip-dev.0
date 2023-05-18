Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADB3C77B7A
	for <webhook@archiver.kernel.org>; Thu, 18 May 2023 11:59:56 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.113])
 by mx.groups.io with SMTP id smtpd.web11.15068.1684411195427429651
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 May 2023 04:59:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=gyaKXvxT;
 spf=pass (domain: renesas.com, ip: 40.107.113.113, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ae/ROLnw1WuE4h1iW0WrrkpMY/Ph2Y0PCbqBQEKQ6IvtI4XCax07GYmss3B9EI52wNtlDxxq9GU5NtVmumF+mOzdwQxHp+OxnVn39GFMxJXTYfDsxNFe/p5Au2X16UdIof4XVv/F8iMrh55deUuLwTMIq4nyk2f0XiBF3Z+uk0YGpY/IDEWaZVGVNCvacRFwNIJyLCeNmPxgDAF49ma01+1T92WlCgazE8fL1ZvPMg+5D8JR9VrgoBlkecQufH0rb2D0ineDH2vDBenhJxt4itX6dkgGnt5D9ZpKLRcwbCvRUhqI0UD5hpFOE4E0j/1yrfhzt3pnDF58mTJImaDI3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xYKz+aoIYZ+BkKZl9c3LgQsntXQoa30KD+CmIm76z84=;
 b=oOFD8rwWYfIWnUm98Qfh4mmSWm6GuXQl3s4SKTS215bWu+rLB1ot+4C7/oGMGpQsBtcLe6JPhQiKS2+y02NK0yOA+d05Q/uzrORtLuZgrps6Lar0bwja67fiU2AlQOielq/sL9t9sxm5cvWPVAx72EbNaYAj1aXnvvaMoRMyp3ltTVUxFUHX0ENrBBW3eiNSAaCLndWwjhYu9COFP3MXTSYphndb/Rjah6zq2l3e2UJGHpWr0xCmEI0YcZah2ZHEsrlHnvrcXxe5uGgA8YyOQ/12z8eV0WSv1l8GpDU4EUG0L96vBcrNWLWheVQMhDKtwRUVZSjKqLJiLeXDnAQRtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xYKz+aoIYZ+BkKZl9c3LgQsntXQoa30KD+CmIm76z84=;
 b=gyaKXvxTHoPPFLwQ7rMadwttOiM8puOGrZi22V0Ov1e/baYswlpVEyjfQUuvIJSjdFnQtbvtiAvky95kQJBCApmR1fIaA7An6rYR7+uBU0lB7ydbr883M3/1V/hTT4BOHVbDdUBV3Ox0Wdl5xPzriYLRXN1G2I2dRRnxVxVZWm0=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by TYCPR01MB8707.jpnprd01.prod.outlook.com (2603:1096:400:18c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.18; Thu, 18 May
 2023 11:59:51 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a7d8:4c3a:9cfd:2e79]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a7d8:4c3a:9cfd:2e79%4]) with mapi id 15.20.6411.019; Thu, 18 May 2023
 11:59:51 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Pavel Machek <pavel@denx.de>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
Subject: RE: gitlab -- problems with testing
Thread-Topic: gitlab -- problems with testing
Thread-Index: AQHZiXHW3tJ0121yIUugM1vcP6Gy3K9f7WgA
Date: Thu, 18 May 2023 11:59:51 +0000
Message-ID: 
 <TY2PR01MB3788AE927095F898E6CA8F04B77F9@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <ZGX7AqhOPIkUnJD/@duo.ucw.cz>
In-Reply-To: <ZGX7AqhOPIkUnJD/@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|TYCPR01MB8707:EE_
x-ms-office365-filtering-correlation-id: a37271bc-9f6a-40d5-9c3b-08db579762f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 /EdTWi51HVT45AL5hMDIMred1Bzc6eJ6qvIH0z+O/Z2j0uzGsqdGhPROWtkBTfVLShCYdplZBKVRbJrLf2A/c4d4nAwtJx+cAt3rqfamp7EIPRm36yxjt6S45sl+tdV87jD23mTlfNqzkFXGoBlBK5J4iUIp0dI/SNFqoZDW0ggD0V8vLxTzdT5+9Y+HbbR2tO+gPWfGl3L3fFl3T7TOzyIDgSpA3SWoPCwiyKk4AMLQlf4S0sHAfQ/W3aSmTbWO4UNhrd4nEPAtem0845+YrnfQQAOoc5ZMX5uHgikFU4V/HS/WifQpWWQDUBrPm3wsHYozaf0d2haJQnh2yctXWQVOQzpMwAM9gvVKNGx2wnmapxNZ0HDhrcXTs+d2gFqWZcFfZsPXVP9MrStsWE4t1OWjJ+izFbMS2xL3D1qofdxUl3Sc1CgxFTcuI9eRqs3cliVBnXqiV5xO5xq1U7un1irB1w1xakPIpY7Y2WgYXM/W2vZQWBOeqqqaYbte9lHt+ZHPif01wtIiymsDmmlU9D/RO8ATQ6yhg1N4wac/V8G9GvxbYbw+ovbbGA4Mptb5o1GZK7PjYVDm3PFIdhCN+AV29fbetEOy3GvhQ6xJGgi6lqjMLw9atXE30Gzm4DxMgvX9awM0qFzThvhgiVnpvw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(376002)(39860400002)(346002)(451199021)(9686003)(83380400001)(2906002)(64756008)(66946007)(76116006)(316002)(7696005)(66476007)(66556008)(66446008)(966005)(84970400001)(71200400001)(110136005)(38070700005)(478600001)(86362001)(33656002)(55016003)(5660300002)(6506007)(186003)(8676002)(8936002)(52536014)(122000001)(26005)(41300700001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?i4MN8UGaUxMQ9kHfUebyeg9/LMLgxgTWlF8f4/bHUkKp7oY15GnEp6EX?=
 =?Windows-1252?Q?Ul4m9fIDrjFME7xRMIPD3iCaIUNKxDzcrA0ZOwmOduz1rjKRJ0QiIobd?=
 =?Windows-1252?Q?D365zwVWTE0AAC4IHSa5KXhOtMAKLCiIJwFx6esesXmuCgie6zyxl1Z1?=
 =?Windows-1252?Q?sOVaezErm9oBPY0jaM4xLI8/p2TH3F6RBrYPZ5Zpw/cEK+rsiUK3Q0AG?=
 =?Windows-1252?Q?9Vj/u7VnTsag6gOlHhAyCXGn59csggjlW/DZBcvl62szA94tgMBmHjB9?=
 =?Windows-1252?Q?gtXPLdOGUXDVnCogtC+XozCfvmBi3eZTyl03r1uV6oZmub+zg28D/8hO?=
 =?Windows-1252?Q?pVXTGO8Mte7nblJrXTMy/SUSQmBk1TFLqz+g4R9VdNvWzGQQxcayv6NM?=
 =?Windows-1252?Q?m9Lk0We9LshYgmqFMOYwjzQMH/egFl8zjfSPk4S1C1POXGSamf2z8Xeh?=
 =?Windows-1252?Q?VlwJRaCh1ILBI/fHBQr4AbvpBQfCz6L5xX+WtMFtOQiDV9YpDTne4Q7S?=
 =?Windows-1252?Q?DOAwOqAZsbjV6lPQwIylAtqoqiiTLKZvzERI672DqDOfgGYIEc6nJRwe?=
 =?Windows-1252?Q?kKbmmNiY/TWDjhjj9vBeeQLASD3BvKdgVeZz0zZCDoqRAeDx9yPb9Qbu?=
 =?Windows-1252?Q?UMpXHIipIPxNrw+IlfemMOUfKwzuPqkOeaI10M0FzE9dvj9x+bV9CpEP?=
 =?Windows-1252?Q?KQ156O278PA0YUg+IIbudtspMRqyEQnrktDuQvF5iW7Iu6QaYkBD6XTd?=
 =?Windows-1252?Q?XoU9rcNewxLxXMOvico6Rsuz/cCLj1rM0cJXzcV7Z5r6lUWENJEOY6WE?=
 =?Windows-1252?Q?eYYVF8FkNe7jrjwbz65+pP2HsO8hczJ2iDIE+1SbvOG7hLaPMokTClLh?=
 =?Windows-1252?Q?xUtf4gDSFV2UIO/uRFT42V60XqlI9l3sg+/5i8VhXPsbTCvX6BDi9/m4?=
 =?Windows-1252?Q?hSuFaQZKg7P/p8b8SGJKnHMYgWWtC0XWFtckg0sP4FNOwmfvl6P3uzlh?=
 =?Windows-1252?Q?MTMo8YZtdQqqurRiifwNePSOY/vJ+9T4hJPIsEKmsLWpw2zDodr0eJDC?=
 =?Windows-1252?Q?iZrwToCTEvPfh0WTebz7apOQgfcSqCgfajcTq123HQ6Ndn8D39UByPL8?=
 =?Windows-1252?Q?vXlz23FSbIzN2oi6dYPyImwkBBzHf56e8FPPwvhlMfpDl5B/D8KU5pG1?=
 =?Windows-1252?Q?9O4kfA94xFehhi+vno17OjYnRCUpzMlwLsUWhdAYgsJGkt+g0vcZyKSK?=
 =?Windows-1252?Q?d/opth2QEJBMzUEeSCKMKZD/dbJAhnEA8REabsbbrxVabD+XajO7M7f1?=
 =?Windows-1252?Q?heidkxz32oPpIbDipjI2Ct2gamGoZe6yX6G476y2o0fKucS8XjIfejvy?=
 =?Windows-1252?Q?x6+PbvnJ/iod4bNAVb9STBhjSJZHJMhZjZH6NeOd40sJAfD27BN38QhU?=
 =?Windows-1252?Q?OwDlrfZ/nUn7koG7ke5L2rIJWnbtPlRHuHYY8orOR9SpAdeGDlaWjIy/?=
 =?Windows-1252?Q?AykHk/Uf2ZvvohL2PLXGcxVrBVMj/mH4Ri2Va0F2BM3rYdF9M2zDKSZf?=
 =?Windows-1252?Q?HaaTKiDWN4lpUxZNQ+BGWt+oBbavlUOgV2l1kOMfUfHvDznKW/+eS0yN?=
 =?Windows-1252?Q?b0+XgflmOVS3Vu2hpxc8brmLpmOKKSjkElju0WIr62gzN7YLz/A05SeK?=
 =?Windows-1252?Q?qTuJiUkwbRJbLOhI7BfEOAecuCZJKDQQ6bDkXVsVht36eQkNqlqb/Q?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a37271bc-9f6a-40d5-9c3b-08db579762f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2023 11:59:51.4475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FaE8wbqg/Ml/qE/cFE9VdM5hAzdrRWNb2pY5iEPBaMaU+Wzvv/L9Ytb3j/DYaC/qDVYXEC1se5p78GdruIkCJa9wP3GOMmHVB2G8KrQ1/Jo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8707
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 May 2023 11:59:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11517

Hi Pavel,

> From: Pavel Machek <pavel@denx.de>
> Sent: Thursday, May 18, 2023 11:17 AM
>=20
> Hi!
>=20
> I attempted to test 5.10-cip-rt candidate, and something is not right the=
re:
>=20
> Waiting for pod gitlab/runner-gmpa8j7y-project-2678032-concurrent-4vpl2c
> to be running, status is Pending
> 13	ContainersNotInitialized: "containers with incomplete status: [init-
> permissions]"
> 14	ContainersNotReady: "containers with unready status: [build
> helper]"
> 15	ContainersNotReady: "containers with unready status: [build
> helper]"
> 16WARNING: Failed to pull image with policy "": image pull failed: rpc er=
ror:
> code =3D NotFound desc =3D failed to pull and unpack image
> "registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:test-v4": faile=
d to
> resolve reference "registry.gitlab.com/cip-project/cip-testing/linux-cip-
> ci:test-v4": registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:tes=
t-v4: not
> found
> 18ERROR: Job failed: prepare environment: waiting for pod running:
> pulling image
> "registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:test-v4":
> image pull failed: rpc error: code =3D NotFound desc =3D failed to pull
> and unpack image
> "registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:test-v4":
> failed to resolve reference
> "registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:test-v4":
> registry.gitlab.com/cip-project/cip-testing/linux-cip-ci:test-v4: not
> found. Check
> https://docs.gitlab.com/runner/shells/index.html#shell-profile-loading
> for more information
>=20
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/4308049055
>=20
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/871381622
>=20
> Any ideas?

Thank you for reporting. I believe I've fixed the issue now.

Kind regards, Chris

>=20
> Thanks,
> 								Pavel
> --
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

