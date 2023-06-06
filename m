Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430CAC77B7A
	for <webhook@archiver.kernel.org>; Tue,  6 Jun 2023 10:19:10 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.121])
 by mx.groups.io with SMTP id smtpd.web10.5190.1686046744264697721
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jun 2023 03:19:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=nQW0iGTk;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.121, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nxKUO+zJltW5GliyQgliIRsCx91o4LYSTUhGV8XpQKkQiVZIkvkweZu9tfQ6IlLJqbgjtThldeZTTsoLizZFPjrwJ+jbNiAXbZ6puuK3jCXiptiupE+cvyUqkSv7gcB4McQxLYcGdfkxzpP8hSEwqbBP0adi+bcvKdPl1vxj0ZX3ugHcq1nuB8Zvlfm3eljj++vrs+7rvSIMDQmOeQIXf6mtmC7QorE3XF25AgYTmHXVmreg2sHrAl9g+lDr6sMl/T6xVXIQLxsZFqjIDL95IqJiWQETelGlolQgsdalm0bTUOpl7ZNns7co8EkKq6+2DXVH+QHwgf7GhBVJQe7vFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jq5agu6hd0DYkHkF/oj7qVbQSZGdhQJhlg5cijxt96E=;
 b=lyTJmKYDXyYxGSC+qRSwEu/elb1fghYFiS45hXwE/pMZ0r9qob/b6gY3NtDK7o3XVWVbudkYPUXZI467+PcRekvM2fjA3DoQqpyMhJV5hCZE8gQ7wbbhYbeaADXxB3GS8GNvkmiQrRtcf9I8YQRF1Gv1cIjo3nYDlVqCVD3wuS1KhEIwwSeYz+SQJ0PCMGEVRVOm91gn3ow91V3u3HdU6bmk/L5FMNkvDEGdKeecTZLZNXvYJw5KceGvwafTlYkpxLvs5eOtXJ3gZU+1qgW12tZUsvq3Q4pN911BJz9Jvqwl88QDc7Zjh9OWbRq6o4FHyTlKjUiS0ljvoAZHJYsLDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jq5agu6hd0DYkHkF/oj7qVbQSZGdhQJhlg5cijxt96E=;
 b=nQW0iGTkk3tNi8xFhOotmooyo7pvN3RV/9QnJHT87z9FAW8FxR4EuU0QpoaLJux8PoBZ6EQMD4NVlP5r6FJpjso3po94FRvJI/u7qkSw8keD6rd9dFFEyrWpu2YZMorL6UlGV63x3RnHkuqrg2zjcZEPhOu+JPdgbswACfVp5Fw=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYWPR01MB10759.jpnprd01.prod.outlook.com (2603:1096:400:2a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.23; Tue, 6 Jun
 2023 10:19:00 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 10:19:00 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Chris Paterson
	<Chris.Paterson2@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 4/8] Documentation: ABI: sysfs-bus-counter: add
 cascade_counts_enable and external_input_phase_clock_select
Thread-Topic: [PATCH 6.1.y-cip 4/8] Documentation: ABI: sysfs-bus-counter: add
 cascade_counts_enable and external_input_phase_clock_select
Thread-Index: AQHZmEvkMjm2bpTadkO9tpueh6I00q99iwEAgAAEzrA=
Date: Tue, 6 Jun 2023 10:19:00 +0000
Message-ID: 
 <OS0PR01MB592290A6DDC3F30BE4C34E198652A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230606075235.183132-1-biju.das.jz@bp.renesas.com>
 <20230606075235.183132-5-biju.das.jz@bp.renesas.com>
 <ZH8D3lCobUJP2T4K@duo.ucw.cz>
In-Reply-To: <ZH8D3lCobUJP2T4K@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYWPR01MB10759:EE_
x-ms-office365-filtering-correlation-id: 1891d1c3-178f-48bb-d74d-08db667771fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 zgNituvn1f4O3sEL47aS4yKAMr/M+XVAMMkMMXSjwqJKdT2ikXVEzLc+G8F2hzK6WiiGBKi1o8/yiyGhAxwjwK5AxNrbpaZdMmP2Slipw1dV6TX8C2tYMwNOpDO+IXsJdUS7MLzg9obcp/lm7M7DdqR/drLEazWjUnN6dBo0PefcKvJBfKFU7ppAQ3CC8KpT1HDzVGJR8LpcvVYP8WL2Fcjfvi1AN/gmCypLY7pSrzcljyhCnfcbwxJqnsNYkcgiLYV9x06aWZ8y6Xr10CWzsAJOkh8B+k9MNoUsX22hPLcgMZhSb7EroG21CF/MNMsH0gNYtZWeKH2PThI7/FlFxYuO4dxxGroHi7lQn+omdObnQXiBp52JPeX2E24umbXLGqMb/BpnWD4d8H19aWgICkZtREIuT6xpUPObMcFS/Ta/ytrWzlm8zBbE0A/pcs4rDVQUscZEcTBlqeBB0SrVfb65up1CimGJcqTDjk3XwE8LMm29/3AgJ9EbmbuFsJWye7MMX/5vY4ZgYRlWhZAAfT3rBXA93djUh6qdonNNhsK5dZhFDNhKU64IrXaq9B1SrCUjoaqLafH28HjkYFN+AKDCJqBS7mFTKs/x+SVy3XV0biLLpNE+YOkUn1sM5F8v
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(346002)(376002)(39860400002)(396003)(451199021)(7696005)(38070700005)(71200400001)(9686003)(26005)(55016003)(107886003)(83380400001)(6506007)(33656002)(38100700002)(186003)(86362001)(2906002)(122000001)(54906003)(5660300002)(52536014)(316002)(41300700001)(64756008)(8676002)(8936002)(66476007)(4326008)(66446008)(6916009)(66556008)(76116006)(66946007)(4744005)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?dl9RJORnNhZlBvBglb4HzuQ2fbKTykYtngQNUxhe60jC+pBHRlx4nGjmtsqn?=
 =?us-ascii?Q?ptF91xyD78dGGVcwok5hugLHyl/M+JSMBbBMDfFerxaooJz+CpAxOKx2LB0X?=
 =?us-ascii?Q?Wo1AJHAK5dj0KM5Fc87BN44/Y6rrAIOg/zo/WMAqbjGZ9Xh/vO3IP+KImPkt?=
 =?us-ascii?Q?eBR6eTDFi7UCK/2fm8cxyVJBfIYnZb54QNe3MZlF+fZOMIkIr5Xj8/qJhHZG?=
 =?us-ascii?Q?9/4+UO2KxDhMAdk85xjb2b/T1eNkz1j4qCm2CacNoRV5O9x389J5RbC0e6lr?=
 =?us-ascii?Q?Zia9s/MT44XxJERRCFGyObqLvW6MoC4Q7j7YfHayP6agFXcEBG9k/uqvECG5?=
 =?us-ascii?Q?pvMV6H+Goro0QsGIusuvnbffo67ouh7THgRI14q9QXERqb0E1IcNtKnWuWox?=
 =?us-ascii?Q?E1bxuZRbiBMYfG+uWRksoIfQGT13GA5vGka7cGNR2g1rC7WkmQweguWi3cN3?=
 =?us-ascii?Q?1bctbbDcXWlj0hIM94NTw4QE2Gtcj7JapHbmpo5bfuoQyBhC0xQf3hmqlDcc?=
 =?us-ascii?Q?bN/T+MSa6VQbPPWP/xYtGYC5xr7ibl1lKIfBoafTF7JSlTagvpTomIuzEheS?=
 =?us-ascii?Q?dT20wjp8uZjbV2W33oZodwGpRC3TMKNYJ+LNp8dJzZqgwCEjVPvxKjiCovds?=
 =?us-ascii?Q?48hjT3jPNj89zT0bDWeMB2OWXfXUNaUQJADPSxyOmhQ7OL7PRAjhjJ3dveg+?=
 =?us-ascii?Q?MueCjaeeWCUCYp51TBMwX2L1sOxXWhuOio6iEjiDOMbLm8wiWV/Axx2P5gH0?=
 =?us-ascii?Q?pUJDMHqxAmuQB31KGl09aI/tiLCaEK/3K1y5XqaOcUBcKXf76uh9CJvUgkHG?=
 =?us-ascii?Q?GQyVu0LSNcaMC5w4dAYrx+o7s7DF7e8nS7Fpi/+bvhgR6sJXpPHILhNLswSY?=
 =?us-ascii?Q?ryck4e5hfeYJxXCqMKXE6WI4NQZs/qmCujc84druprxh3oerrgqmalVItGGF?=
 =?us-ascii?Q?VZwwFFn1/SnvMFlmOijnqCfSnLEPKKa2Ym8l3qtAJGyFsz7ezs0jlkTRQbzQ?=
 =?us-ascii?Q?t5K33kpGLayx52li/yJ83FLRV6r2MQ55ZCKfVvw5kY0UZqtZXUhn8abDA9r3?=
 =?us-ascii?Q?MF75ShpMX1G0fVTbGx+wt61MeI49zah9RSiT9GyMzzXA1G4DMpBePkTDywOf?=
 =?us-ascii?Q?MwMpwfMRsiD7miSsnMgQFTIfnTuuwos6yBEDluAB0nLvosaaSTyvtCuoPj0s?=
 =?us-ascii?Q?/HXfkSaMM3I8VOjUT7YUcP24p3kqxFCDkKp3LHGsEEqm/DzCG0cvKQ5Uschd?=
 =?us-ascii?Q?zC/Dj8xmpzREd5blfZfX5OrWrCRoSAkUm/wrp0QmMMK0OysELupEqxPbCdN9?=
 =?us-ascii?Q?XaaFwFGz6ZIV1WLNlAWOkspuqeXzSYzdeQGqCP01Qi988v5q7JCBuDeyZXUd?=
 =?us-ascii?Q?Y+ch+036vaz2jzXREOXqyx9jGMSBMpzGh4yOESnyF36HjpvsXoLEKIlGDdvx?=
 =?us-ascii?Q?5ofA/pIDs7FLu6VzjdH6i5ecP05jJuyi1/vx3m0azKhreWQ+WucK+AOtVGJr?=
 =?us-ascii?Q?LxtcPyMhCIeIgYkHdtB5ojtTGSBkmDZflooy0GfTMsBmRU36gMgqHUaZpAmZ?=
 =?us-ascii?Q?ZTmhhl+oC7SLbide65RvVw5C8vuhXmHMZUPwoPY2Fk1P6gdiHqi9X9QVPK8o?=
 =?us-ascii?Q?yw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1891d1c3-178f-48bb-d74d-08db667771fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2023 10:19:00.1980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yC3P7M5iKdGew3MZg+hIrTfWPFOnq3qI+uVeDRjBCjuPosOR/s79p8x8qbq2usp/HMcTWnWZEp4yvEkb3iqydcq5IGRvWLsWPTao6lbeRxM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10759
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jun 2023 10:19:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11860

Hi Pavel,

> Subject: Re: [PATCH 6.1.y-cip 4/8] Documentation: ABI: sysfs-bus-
> counter: add cascade_counts_enable and external_input_phase_clock_select
>=20
> Hi!
>=20
> > This commit adds cascade_counts_enable and external_input_phase_
> > clock_select items to counter ABI file.
> > (e.g. for Renesas MTU3 hardware used for phase counting).
>=20
> > +++ b/Documentation/ABI/testing/sysfs-bus-counter
> > @@ -1,3 +1,33 @@
> > +What:
> 	/sys/bus/counter/devices/counterX/cascade_counts_enable
> > +KernelVersion:	6.4
> > +KernelVersion:	6.1
> > +KernelVersion:  6.1
>=20
> Indentation is not consistent here.

OK will fix this.

Cheers,
Biju

