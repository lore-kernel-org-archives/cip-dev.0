Return-Path: <SRS0=3drx=5F=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B9AC4332B
	for <cip-dev@archiver.kernel.org>; Fri, 20 Mar 2020 09:56:48 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A54120753
	for <cip-dev@archiver.kernel.org>; Fri, 20 Mar 2020 09:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="JWFNJdgR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A54120753
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4653C88179;
	Fri, 20 Mar 2020 09:56:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ahII7q5cZRJs; Fri, 20 Mar 2020 09:56:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id DFBDB88157;
	Fri, 20 Mar 2020 09:56:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C3F9BC07FF;
	Fri, 20 Mar 2020 09:56:46 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4A732C07FF
 for <cip-dev@lists.cip-project.org>; Fri, 20 Mar 2020 09:56:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 346CF8826A
 for <cip-dev@lists.cip-project.org>; Fri, 20 Mar 2020 09:56:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r7b9UdcKcpyj for <cip-dev@lists.cip-project.org>;
 Fri, 20 Mar 2020 09:56:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from JPN01-TY1-obe.outbound.protection.outlook.com
 (mail-eopbgr1400094.outbound.protection.outlook.com [40.107.140.94])
 by hemlock.osuosl.org (Postfix) with ESMTPS id A642788266
 for <cip-dev@lists.cip-project.org>; Fri, 20 Mar 2020 09:56:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PCAj4ZVaBL0Yq8DRidqgrBkBLJx757klWsy5/6Dtwme7r44zc/ix9tWbThMYwPxS2xXlFEAdn8AZUbYWoRHbRnMRo5pIKe7nSvwbNMjYd2Ee4rfRESBfOQsd5E8T7dH004zGJNxFgl3jcqHfU0Av3kWWHIV+oNLjD2N0DldQZ73pB7uppEtF41VFAZhEur+tzcq8bdtLYzu5rKGTZ0D/+ec+Va52CxUfDkwSZsvYcmQCTTYdBNpFCuAF1HWDaGGmwDiWZ9WN5Uvp1Ob787YLEwP3TBzZFzyOSHRsBpekYgf27v5rsGjqIH3+qp+9tuddWM95xOv7pGqqRO58aNSRfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MIQsGXqUIb/TSShN9u/pMecwd+9TonTkHi2gePOQl1c=;
 b=Zxp6AReH7xSB+3t8FEE2dKuxO8wNp7l8jJU5DDY677T7kNMpHJp/5aYHaoacDOe4Ooblr+x1NrTVQEhtj2QndFk9OjGVrQ/VYD9VLCuXRQyJ9YI1I5bJ7Y886wOb6WTcKVebIetqiyiTwKP97Jql4ak4XYLqyobgAXk0EX4RZggE7CGkawHMt942y9hvuDjtayy8Lqrkv5PPaedmOXctwcypyWyM46YKi8yVe9a4l1hT7+0pBXr/QFRjzy5VswSY4DsReStbwHbR4/NDMh2hOkDLesmHkg5Cm4wBzQNHZ3kJCLOtA1PS8OwehbV0Pl5jLS18SIGVxu17u+4f9YpBsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MIQsGXqUIb/TSShN9u/pMecwd+9TonTkHi2gePOQl1c=;
 b=JWFNJdgR0HgiwG2nPH/UaTq+JPYzts2SbhKxX485Mou7SS/0Ii3PRkvByHgspp/j6mCjnAezvVeRCytyCRu7+GDStT4mWMWkG5zo2JGoRc9fBZTrUG5tarA7a74CEkv8zSLmvx7xzbtHoKaewyLEVgf07Gl2uFvXKdIhZwgOFoc=
Received: from TYAPR01MB2285.jpnprd01.prod.outlook.com (52.133.177.145) by
 TYAPR01MB4749.jpnprd01.prod.outlook.com (20.179.175.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14; Fri, 20 Mar 2020 09:56:39 +0000
Received: from TYAPR01MB2285.jpnprd01.prod.outlook.com
 ([fe80::a882:860e:5745:25e1]) by TYAPR01MB2285.jpnprd01.prod.outlook.com
 ([fe80::a882:860e:5745:25e1%6]) with mapi id 15.20.2814.021; Fri, 20 Mar 2020
 09:56:39 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Pavel Machek <pavel@denx.de>, Ben Hutchings <ben.hutchings@codethink.co.uk>
Thread-Topic: [cip-dev] realtime on de0-nano bisection
Thread-Index: AQHV/d5OZUtRVXucbEegF8Gv7nZvZ6hPxM3wgABQ72CAAFNNAIAABKEAgADSBJA=
Date: Fri, 20 Mar 2020 09:56:39 +0000
Message-ID: <TYAPR01MB2285AA6A0ED614311F861538B7F50@TYAPR01MB2285.jpnprd01.prod.outlook.com>
References: <20200319110524.GA8475@duo.ucw.cz>
 <TYAPR01MB2285F2D82C8049EE8E7F073DB7F40@TYAPR01MB2285.jpnprd01.prod.outlook.com>
 <TYAPR01MB228523C8A226D17D38E7C3CDB7F40@TYAPR01MB2285.jpnprd01.prod.outlook.com>
 <5f2a3e394d6a5e9bc8b9e05df0b17c758c9c46fb.camel@codethink.co.uk>
 <20200319212357.GA28591@duo.ucw.cz>
In-Reply-To: <20200319212357.GA28591@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chris.Paterson2@renesas.com; 
x-originating-ip: [151.224.220.27]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c7959a60-644e-49aa-6509-08d7ccb4fc6f
x-ms-traffictypediagnostic: TYAPR01MB4749:
x-microsoft-antispam-prvs: <TYAPR01MB4749D12EDE691B6557D9BF44B7F50@TYAPR01MB4749.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-forefront-prvs: 03484C0ABF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(39860400002)(136003)(376002)(396003)(346002)(199004)(66946007)(71200400001)(966005)(66556008)(66476007)(76116006)(2906002)(7696005)(5660300002)(64756008)(66446008)(52536014)(4326008)(478600001)(8676002)(316002)(8936002)(6506007)(186003)(86362001)(55016002)(110136005)(9686003)(33656002)(81166006)(81156014)(26005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:TYAPR01MB4749;
 H:TYAPR01MB2285.jpnprd01.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4yOsHr07Mni3r5GKPvs/SESR9ib+kiG0xl/WSKSpn4NeAC/0e+mpAxFV81ixthhLnTWQ1uJAjRZgu9I9OnGpmt3lc7COts+nUa/srfI9D30G2Dsxp0KlOY6nXb2EH2oTVgdOTF4L0yIK3BJgwzRaMID25SFIx7nRTKIVNy041zfmKj5aIoj93ztS1ukS7l5qqKraeMZccPSBYj6sRy081DRQVI3xM22RxxzlTj6TfDqGvuNa4cGjSFcb6sl5RU9vhphizq4X1B9Lc3t47IaLF7RXFHqgDbP68b4qDVnLupNUPBBcDj3DA40fWhDFm8aWerPO7UXdLilsqFMsD6ckedqVZZEt5Fr7QdkqrAbyOrwU3sb8TGbYRwboZB3UWTKRDpwtIcAupl2r566VXw0lxkTXrzS78cXrg/uiovGcIwZjgSfqJkl59x38xaPDyfmfPNnkN8Xb8t9td2lSA1B6OWv8hiQsB/dRrnNjrTzOweMMhe4jjXVvoxKCrXwyfbPKWUNgTZNNmWQJTuAiPHBVpQ==
x-ms-exchange-antispam-messagedata: OloOK6K5s6UYWdgPCbfVfCbkq6tzNbJacAU3cSpz6cV0RPs2hP9HrYeA/RXR0sTui9sNJkzQXzDbVJlBNe+W6yiFOOUNQ0Am9rtmGsp4X0feU6AIbi0n7XDP3F/OZs08BcDYy86keOnmH1s16BbVxg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7959a60-644e-49aa-6509-08d7ccb4fc6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2020 09:56:39.5843 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GKuGlvz7arkSW3CLN/nvl6u13mVsvtThIEO6XtsdZAArK39/VSLNOAQcZfxri3o7vU1UcDPGZ4BXq3hCIg4bSHV1+2TbeGk/fzjgBq1gajg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4749
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] realtime on de0-nano bisection
X-BeenThere: cip-dev@lists.cip-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: <cip-dev.lists.cip-project.org>
List-Unsubscribe: <https://lists.cip-project.org/mailman/options/cip-dev>,
 <mailto:cip-dev-request@lists.cip-project.org?subject=unsubscribe>
List-Archive: <http://lists.cip-project.org/pipermail/cip-dev/>
List-Post: <mailto:cip-dev@lists.cip-project.org>
List-Help: <mailto:cip-dev-request@lists.cip-project.org?subject=help>
List-Subscribe: <https://lists.cip-project.org/mailman/listinfo/cip-dev>,
 <mailto:cip-dev-request@lists.cip-project.org?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Errors-To: cip-dev-bounces@lists.cip-project.org
Sender: "cip-dev" <cip-dev-bounces@lists.cip-project.org>

Hi Pavel,

> From: Pavel Machek <pavel@denx.de>
> Sent: 19 March 2020 21:24
>
> Hi!
>
> > > > From: cip-dev <cip-dev-bounces@lists.cip-project.org> On Behalf Of =
Chris
> > > > Paterson
> > > > Sent: 19 March 2020 11:23
> > > >
> > > > Hello Pavel,
> > > >
> > > > > From: Pavel Machek <pavel@denx.de>
> > > > > Sent: 19 March 2020 11:05
> > [...]
> > > > > like tests are unreliable (and even my basic assumptions may be w=
orth
> > > > > re-testing).
> > > > >
> > > > > Can you help? I'll be away from console for a few hours now.
> > > >
> > > > I'll get bisecting.
> > >
> > > Last 'good' patch is: 2089f853a8c3 ("drm/i915: disable tracing on
> > > -RT")
> > > The first 'bad' path is: c82fe0af5e58 ("drm/i915: skip
> > > DRM_I915_LOW_LEVEL_TRACEPOINTS with NOTRACE")
> > >
> > > Don't ask me why c82fe0af5e58 causes a boot issue on the de0-nano
> > > board but at least it's a starting point for you.
> > [...]
> >
> > When bisection finds a commit touching code that you're not even
> > building, the answer should not be "don't ask me why" but "this is not
> > a reproducible bug".
>
> That's my job, I guess. I asked for bisect and got bisect
> (thanks!). And yes, I have to agree:
>
> In the meantime:
>
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/478548891
> https://lava.ciplatform.org/scheduler/job/13037
>
> So yes, it seems this is not reproducible. Is it easy to make the test
> run .. say 5 times?

Just repeat the test case name 5 times in the gitlab-ci file.
E.g. https://gitlab.com/cip-project/cip-kernel/linux-cip/-/commit/791b84001=
ce05a9a26117a0c2de0e7250b343960

Regards, Chris


>
> I'm starting to suspect
>
> pick fc9f4631a290 irqwork: push most work into softirq context
>
> Best regards,
> =A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=
=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=
 =A0=A0=A0=A0=A0=A0=A0 Pavel
> --
> DENX Software Engineering GmbH,=A0=A0=A0=A0=A0 Managing Director: Wolfgan=
g Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev
