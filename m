Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8BFC7EE2F
	for <webhook@archiver.kernel.org>; Tue,  6 Jun 2023 10:18:20 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.133])
 by mx.groups.io with SMTP id smtpd.web11.5398.1686046691779440369
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jun 2023 03:18:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=j0BBHSLa;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.133, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m7crswRXvPSMJ4yj+1O088U9iN7T6bp1eipdet2hA79m7YElfezgNHGa0/741ZfNuyVx6BnOnisgtUckmynwqDGR05FCThUiYI8MxXDlERwUtHfJUtkqCPzjNsTUtpZFuYgHTF1PbBhAgg6ouJkhYL4RpIC+RfEAiqaQItoTn/A2jEtKD48Z5i8GLgmE02VG5OeiHZf2QHMRP9kMNTGlQCmVmbhlLIgwgOLwMuzeItdSjnsNt0+2x+T9Y3YdStfZdmAl45WAfvpF4Ra6i7LwIw2o+sAzpIwr5W0txB99pCoJt37/yVBftgfnXrXfomhzjsPA27z5sWX8xDXhLuZQhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CaQRXl/VdwROYJ6iSSBhaFQoIFl3lRtj2U4Jr81u7ZQ=;
 b=W0TzMPwHhjt9kdg/wC7Bp2HU0JFQOroB5T2OKvpH32cg601yPdQJbXnxY3Tiaoxc7JMzj48xtCCLk/STPFYh5UHxrCiRJOu9k7TDTWG/ZSLei6p+lOtbj29V8JX8C2R1ME7vtwgWCTnOH+ldZ6ZoCyy/uckzK57LC+lWSRabaVs/XIgB73u6+5cHutkT7novZdYUMcK11vMp1UKaP6j8uzw+mWvbDolt03hLW/HONwVbac9ZC59IMJ/0jSzRyB0Cqo+i7bS9zSokdQqRyXcWIPK471QKrM4l+ooSgCR6anqZAlvJ0o/QgkoXDEtjKNFJjg0lCCsbb3YvDSm3sNoUsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CaQRXl/VdwROYJ6iSSBhaFQoIFl3lRtj2U4Jr81u7ZQ=;
 b=j0BBHSLavqS/+ZIyfXYXuhU0dUuCT2g1iivsYIvSxaar+emr3YkYXz+H9gNZgbxvJkeEo5Zf4xplkkDb6ao2t99VbawP40LMA1DTq4aLzngiEKgYk5C/F6NkVQFoqTfjg3oCgSp0s2xjAz2Do/dZ61J+AtoWEHeziMZT6A8UUQ8=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYWPR01MB10759.jpnprd01.prod.outlook.com (2603:1096:400:2a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.23; Tue, 6 Jun
 2023 10:18:07 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 10:18:07 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Chris Paterson
	<Chris.Paterson2@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 2/8] dt-bindings: timer: Document RZ/G2L MTU3a
 bindings
Thread-Topic: [PATCH 6.1.y-cip 2/8] dt-bindings: timer: Document RZ/G2L MTU3a
 bindings
Thread-Index: AQHZmEviuLPOV7Gb9EORunJ3NRPtuq99g/+AgAALTTA=
Date: Tue, 6 Jun 2023 10:18:07 +0000
Message-ID: 
 <OS0PR01MB5922F2C4AD7482DB7AF84C738652A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230606075235.183132-1-biju.das.jz@bp.renesas.com>
 <20230606075235.183132-3-biju.das.jz@bp.renesas.com>
 <ZH79/UjgYg+0Ruiu@duo.ucw.cz>
In-Reply-To: <ZH79/UjgYg+0Ruiu@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYWPR01MB10759:EE_
x-ms-office365-filtering-correlation-id: 63c7213d-36fb-4336-37a4-08db66775298
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 dsjccycrSkNnHAt1wwcnQd3kSmclXCgZzfvBUBlOh0aQh2V7h7WVFFvOTIMoXLKK88zp8dwFcQmdQus4eUxZvFBmsyFi9WnyOu3dwGu9oXMK4O1V9kpRMka0lfp0zu11EOzaXs/wPLPTtpmRWeIJOYdkaNGDrQd0qfkYwGfp9ZxaNH2mbn4ekJtKE4cQrFWkHX5hSYdFy2WK0vvvmYfHeH6Uup2eQHMEMUk21u+LBSLxg50J/KDBVjQ8Yby4QGDau1RW59yzA6wyr/pp8jtbQjdU2Zj2yZg3O5igEkSdXisi1jG2qzgeXveftU6vxUeANg/eqD7Kedvz0OWSGa0pZvRXYxEEfTihre6ayJyoo3rb4BSf1IYeTTvp6ltb5uxZ/4jsLXFr2N2RxHKb4f/2WxLHxtGc+/yVjuy9JxB9k/M8oGZqw7IbNRB6l0mCsgUWW942DQi8pshotUhX1kCafG9OvryON5tRPWIIwVQEPPzVtBevDQx2J3mlXmA0W3eGF+HpOungPSkC2ccSKedOf2WJlKbIcHgmwBUUSE00IG1tUJD1vZ004iEOwc/519S7lbQszMitiij6iVR6+xQKp9Hb01MiWoDhv2+4fSuMua2SZNWLEj8Dcf/iF4OlYei5
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(346002)(376002)(39860400002)(396003)(451199021)(966005)(7696005)(38070700005)(71200400001)(9686003)(26005)(55016003)(107886003)(83380400001)(6506007)(33656002)(38100700002)(186003)(86362001)(2906002)(122000001)(54906003)(5660300002)(52536014)(316002)(41300700001)(64756008)(8676002)(8936002)(66476007)(4326008)(66446008)(6916009)(66556008)(76116006)(66946007)(478600001)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?vd7IR3EdwuA3Zm0aEUbb2QEYUO1rBY9mrKSXgyErJD45j13PTEEqyoUOh/sZ?=
 =?us-ascii?Q?uIDzXlYtRUQ+5DokQvo+fwvD6y1mFseTzjKqQl3bqTM822Z10htmU3fmIlWz?=
 =?us-ascii?Q?0myW5Ib3txortzB+xF6h/8RQfz+/BIJcjAxMYWHUbZwO4DgU2gXIpMbXTZ5p?=
 =?us-ascii?Q?KM2luvpd38szHz7coVj5l5AvtfOVxbeMldw1vBtrerHt+GyepVepiMVtmmgj?=
 =?us-ascii?Q?3tONyZ7LRl7E5fmlcrRzopXWVL0ue+rQpfk7VG4vsGN274TLBoB/kO1gpuB6?=
 =?us-ascii?Q?pemQwCi1gh0WlaxE8tQX9sXTYS1bGD1g8uqT1ui/Ba2AeprrkRoDHf6gEA/r?=
 =?us-ascii?Q?zpjyS6OHvZ5LmKg6v1yct8LUbGJxBW65G7L/LuwvWxkfzVBb4SbDG9ON8wnN?=
 =?us-ascii?Q?J+Rf31yr1ZPOI1Xnr2VclxFt5IOYxTxYwoEKFjoZcYSxMPLGYR/0cWmAgR2I?=
 =?us-ascii?Q?xtW57jxcGGlHDJYwzJHAuz/KFv6221+QzTn6DrNvis0oKJZXV8CDwnR6tzQP?=
 =?us-ascii?Q?Nk94xIFlIU5fciBTQXc+iRqBGKV0UWVNUvLeZYMCGNDHx48Aw/HlGXHtCFJM?=
 =?us-ascii?Q?/Le4MoChN4elRgSHMCPz3mJzXdG4ywtlVv6XvWpFnNZgFyZjcAuBjzC57HwL?=
 =?us-ascii?Q?J2Yk6G/cHzM4b65284dmHhwPXLxSTDfRjan3tYY3AtE1Lo+l2LsssyHCVjfJ?=
 =?us-ascii?Q?1dtpzLc++T3paAU4FkochZUHjFrBCu2bmIzyME/wjwh3MI77QT/WlbIciyFo?=
 =?us-ascii?Q?MNRPqCJCD+1WmSmtGmsvnBYyd6taawRpelcJh+JfNn4Ih0tGJpBMDrRDwV/8?=
 =?us-ascii?Q?KtzKeJz0b/S5OFLbifMzY4bu9XKcX8kFFsWXKBkb7w7oQFraOACQDUiFezHD?=
 =?us-ascii?Q?zPuWZvD3wJ/hcCXVUiOzHlN1WTEK6JjBLLjQ/AqMIIoWXhzW/mvOYi9kdT4F?=
 =?us-ascii?Q?Y9H6CrFAufQAgYAwYA/QSNORiJbcTugU8NiUi3gkitQGl/GXxj0xy2tyozTl?=
 =?us-ascii?Q?St/0UkFN3oNfOv7O1d207oiTGKaJjmpM6/7ntnIlXq/3eTpXTuoJE7ViGtBN?=
 =?us-ascii?Q?0E+Zpqcok+2npETY8Az6oVc6kb99uqPWfVTQPDmzPqAoZT8MiJUPYXffAbib?=
 =?us-ascii?Q?PsHEx4Pe9oyZoHXagIPFEnCaVyUyyU5Q7ffXsxyHtvKiqs1TAyixIQjhouc5?=
 =?us-ascii?Q?7PB0xmvRIUwCeCYdOZtYmxf2TBATRFAT7M4BzBxX7B1GYisQy0PxQcWIA86N?=
 =?us-ascii?Q?6EKrQ6KHXEC2LUMbqEQ1lWFiR4bMFsugc6ULVHZgkvG1m6EBnYcSrL9rQFky?=
 =?us-ascii?Q?uvHydvAeniX0Y4kuG+qzgOUTtB6xQ369+W6sfcvGN2ATJhnvofIA8ajE7gpY?=
 =?us-ascii?Q?Tcm1wIbEaAaPcc1uLsE+9vRj/mrdhSiVUGgAQ5rYhipOZCflsCC6jEvQydKf?=
 =?us-ascii?Q?l5UCXuDpUsN+ClKHsx3pHgB3wPlej7kH+tbJpdyeLd1bNTRQSFvEAr4nO14m?=
 =?us-ascii?Q?mtBRNQskOYgQsNfdW/jKy1Adi6ickFOheGGWKuMeJopSMssVVcI06PJiMzu7?=
 =?us-ascii?Q?kKFY1IpqhyNscYxmAYxdmM6rZhMRRHau8GzB7FjW/yXtepREYCPOOjxzSIMY?=
 =?us-ascii?Q?oQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63c7213d-36fb-4336-37a4-08db66775298
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2023 10:18:07.5818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qn8hLDmOmij+HadIa+3Uh31Yn2h2JBSOW/14f95eOEagmlWgHbYv2zqqC1nX+bAKrxnZETQibJawh5iAeDkvaCo7cCkTfQRpEA3tWx+NHV0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10759
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jun 2023 10:18:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11859

Hi Pavel,

Thanks for the feedback.

> Subject: Re: [PATCH 6.1.y-cip 2/8] dt-bindings: timer: Document RZ/G2L
> MTU3a bindings
>=20
> Hi!
>=20
> > commit 0a9d6b54297e216199cbfd08c5e6a35cce152477 upstream.
> >
> > The RZ/G2L multi-function timer pulse unit 3 (MTU3a) is embedded in
> > the Renesas RZ/G2L family SoC's. It consists of eight 16-bit timer
> > channels and one 32-bit timer channel. It supports the following
> > functions
> >  - Counter
> >  - Timer
> >  - PWM
>=20
> Ok, some cleanups are possible here.
>=20
> > +++ b/Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml
> > @@ -0,0 +1,302 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/timer/renesas,rz-mtu3.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Renesas RZ/G2L Multi-Function Timer Pulse Unit 3 (MTU3a)
> > +
> > +maintainers:
> > +  - Biju Das <biju.das.jz@bp.renesas.com>
> > +
> > +description: |
> > +  This hardware block consists of eight 16-bit timer channels and one
> > +  32- bit timer channel. It supports the following specifications:
>=20
> "32-bit".

Agreed.

>=20
> > +    - Pulse input/output: 28 lines max.
> > +    - Pulse input 3 lines
>=20
> Lets get "." at the end of line consistent? Probably remove them.
> (Please fix globally).

OK will add . at the end of each line.
>=20
> > +    - Count clock 11 clocks for each channel (14 clocks for MTU0, 12
> clocks
> > +      for MTU2, and 10 clocks for MTU5, four clocks for MTU1-MTU2
> combination
> > +      (when LWA =3D 1))
> > +    - Operating frequency Up to 100 MHz
> > +    - Available operations [MTU0 to MTU4, MTU6, MTU7, and MTU8]
> > +        - Waveform output on compare match
> > +        - Input capture function (noise filter setting available)
> > +        - Counter-clearing operation
> > +        - Simultaneous writing to multiple timer counters (TCNT)
> > +          (excluding MTU8).
> > +        - Simultaneous clearing on compare match or input capture
> > +          (excluding MTU8).
> > +        - Simultaneous input and output to registers in
> synchronization with
> > +          counter operations           (excluding MTU8).
>=20
> "         " -> " ".
OK

Cheers,
Biju

