Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E933C4828D
	for <webhook@archiver.kernel.org>; Mon,  5 Feb 2024 10:26:45 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.100])
 by mx.groups.io with SMTP id smtpd.web11.59695.1707128798868929409
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Feb 2024 02:26:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=VHqTP2c9;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.100, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WuP/CZCwYPbXlXtWK+NxFOAv33pI0oqJRuKtokxTZQ3oqFe1KL2MEUkc799yAO8pp5eSIcjAfPOays+y8PGuDWhFo7AKlHJb6MD0y8cVCN32emu9ZxzR+ezSpW0orpt4Ysqd2fKw+FU0+L0YnMerNwP2WEW3vVGxJIH6k6TtCsYnm4+DiWbdqrysuDHxyHM8NV0PWO2YXXbzGAONA2PCjyzqYMWOAmGTe2rrPLuXANb8HispkXmLH55/CBR4Ug4YB+AdTSMElIGvRe9sSarJqfEL41TbHBGLyxWDXmMjzPxmqxeR07KaX7qsMSr1onD50Dj01JOkTBiAwIuHu6b0Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JLinMeGnlkr5Pvrv2lOP7GlzojP6YsLYFwL/cjDND2Q=;
 b=mhQ5Tiey8zquUgMWRNFFerJQZSA2kRIjTfTJvbAWTT7KfGimV+EjF9LhyhwD8Y2Q18AZUILJC3VmNQvPBCzuu8FZhAmHkHZFYjEIfDqBehd4KQFFd8jpyiER3pARiUsQlljLc1JsasXkfvUde8kuCPycg5xWDrnElcqI2P5un4pir62xPEyG1eFTRh3kW63T8OXweFQl3U/1YmMmZa90+0IudJkAEYlYHCtiAkN9y/wxa2mQCmIwwZP2mskG52nyRbU8t3Ttp2+lpoZoF0LRm3I8RxF/UH591rTrmIqbQOF4qJWUMTH8J6RDScbLFC5JtdLq5p7oTiMPeOf84cp7bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JLinMeGnlkr5Pvrv2lOP7GlzojP6YsLYFwL/cjDND2Q=;
 b=VHqTP2c9xvAAi4Rx2bPBiMd7wwEpSS+Vdh7rTmH7eL+HC3X/wVGIFMKaxHK+RjhhRfvl1w3mnI3ieKGzP9hA806JODjZ2/UKGK+mJCO8PUBtgQv6AFLSfZV4kR8cNEX2MPdqmBMV+i4i7mxx6fOTmukSLLtKkr2J92g0Tkivf64=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by TYWPR01MB9340.jpnprd01.prod.outlook.com (2603:1096:400:1a5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 10:26:33 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::deb5:2f61:e3a4:dd66]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::deb5:2f61:e3a4:dd66%6]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 10:26:33 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: RE: [RFC PATCH 5.10.y-cip 00/39] Add support for Renesas RZ/Five
 RISC-V SoC
Thread-Topic: [RFC PATCH 5.10.y-cip 00/39] Add support for Renesas RZ/Five
 RISC-V SoC
Thread-Index: AQHaVDlhz35XwbGvJU+n7DaOll4U2LD7hwrwgAAI1gCAAALIoA==
Date: Mon, 5 Feb 2024 10:26:33 +0000
Message-ID: 
 <OSZPR01MB7019ED91EF71CADDE4476BB6AA472@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20240130203346.94488-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <ZbowIA9sDtDExkBU@duo.ucw.cz>
 <OSZPR01MB70199E2D7FE8CF56D5536481AA472@OSZPR01MB7019.jpnprd01.prod.outlook.com>
 <ZcC1HtNcQJ4dhXNX@duo.ucw.cz>
In-Reply-To: <ZcC1HtNcQJ4dhXNX@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7019:EE_|TYWPR01MB9340:EE_
x-ms-office365-filtering-correlation-id: 19ef01a0-8da7-49ff-f7e8-08dc2634eccf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 IWPntnCY49ynIxApBwoPAkE0k6u7UCMH+Hp7d7QVKK77dShxSUEgGzip93Oi9uPBee/VQkdFfDMr966tYI+7I33CJuLqnFveMY8RjfjFMImvOCmhrBuM11qffrkPlXJK6D8FmUWg8CoXz6jmx/1Rf6voCpaZNkNya3aT1juUgwWAHG9AvGigtNVxPSpI3iAZtN6kbR3/orYUmaFwH0epUMHfpvxK8VWOlO8oiqdc4mEHBWOrh82JuR+T+ZB4/sIrQvh7ndKnT1NuDNuxuA0OC8iSnB6vE/aUdqqUE7CTmiwoob5brFJTmG9z8cU6twE7Dbc17/xQi9RqnW08N7Fx3KQfCWIx4locUY962fkn+fy/VIsWJRUsXcUFJOiubHCdRA/zqYfxsMewi7Bq8QfkxEBBzZmOZcwiKzYbO8l+hW8jQ5QSER3iBBLIDLY3HidlJzQz9nHwZhKz/8awa3hb0eXQuRC8TbkRKb54+91PJvrRUcKT2IV2ibCp77dEViQdFGlOSf0aWozqzHqvshDFdIBICRWfxv/nNjn+1ne+OGcaOjrrmHca6NVJstg5T1EOzQkD/Ig7jG3YvK0QFeBfbTLTVuSHODyTk/CB8Rzg28TREGsAP1xZFKYPw2ay+ubF
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(396003)(346002)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(316002)(83380400001)(26005)(33656002)(107886003)(55016003)(38070700009)(2906002)(122000001)(86362001)(5660300002)(66556008)(66946007)(76116006)(6916009)(64756008)(54906003)(66476007)(66446008)(6506007)(71200400001)(478600001)(7696005)(53546011)(38100700002)(41300700001)(8936002)(4326008)(52536014)(9686003)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?IB4xWbLuXOvuUYvCHckoJOB7Oqz+OTEapaARObxNi/Umrq7KqebEeCbjWkvN?=
 =?us-ascii?Q?mczxzfhVElvESlYyuogTFbvBYcv2RiNcpwhYIw830Rz3ndNIQNYhCOXy84dq?=
 =?us-ascii?Q?9vMe2TGzf+hAZjR9ihXQbMPEzlzmMOCDWJbQHeoqbpQh5FGRHBeojp97rLzh?=
 =?us-ascii?Q?0ocrR1dxVcr1v0FBb+M0jkVDNFMshlKqYxMNrnDeZ7emvaJWW2VwDQ36NaZu?=
 =?us-ascii?Q?zEk+Zl3eVXuySQC/8cMp/XfHeMbFl0BeC2ZvXPMNhmpdf9GTsH9FKvlxtxlS?=
 =?us-ascii?Q?lBGkSrWaZROk6Zfw7jfup+UV2xDstKWzI2u+twxoNpo/mi3TAdtJvkrzUVQ0?=
 =?us-ascii?Q?OXSM7EflZCMPl5/rqr7jy6TBi8qPZc3Z+mSCUDUlgBufoktD9B29LVL0BFhl?=
 =?us-ascii?Q?IV7qD9zOic2HtPRTUedxOZ6+oXnsF2mf5gSW+7dY6wXQH9amzrHEOomXbYAJ?=
 =?us-ascii?Q?IrVT1605EkPLcQX/X5x2EDEf8DD/COyr8kxV/UK6y+LcxGEYSUqFOJk1xQPi?=
 =?us-ascii?Q?72Vkjr6SZTbg9rvK4XSEJYtoYQS06V5oZPhC3vtTDBcFQ0yXOLqPVUns5Pac?=
 =?us-ascii?Q?wScIhpNmLg/L+MHCpB1iF8g8pr2SDOaC+ILqXvBwVBSZBhjTls/Oa79ir89S?=
 =?us-ascii?Q?LktNJo9ZLz8q6Q5PZpS2gZm75P1//beDSXXl/N60Yex0H9xm4kSysC+YyCXs?=
 =?us-ascii?Q?feRDLewTuukYRc15Cj2CytqNzOv3HSErzWa3ym1vC7fGWh2tFC/ZuRIk4Dna?=
 =?us-ascii?Q?IDLOVK5NVSzSDzd6Xs6JJSt1Ly5T4rBfkmyJX8dSOXniqZblQeA0J9YTHMHR?=
 =?us-ascii?Q?PjcsPb3422O70yS11ZcFEEu7vVhuBTxYyZ5axkHucFLiKZ/rskM5VgKsz9CZ?=
 =?us-ascii?Q?3opltdDGUH/31GDMY6yJRDLbENXB4lZXqxPstpR/A3VQKQVHQRVxM30YD2vb?=
 =?us-ascii?Q?J9rnv8CUnNBSKya5XX+q18KfHg6/EqnBUbnXks+/zz96Bj10rDGNV+vXRk2D?=
 =?us-ascii?Q?QETMeY7dJR12JJgIRS7piNd2xvbD6pj5TEbTiYLk2RMj1T4gMvAYpknnt7Ny?=
 =?us-ascii?Q?KZecX5+05CxgJqd16A1T2+wf5kZKg7SJbku4sgBUX6L8J4G8IApsWQkz2Jsz?=
 =?us-ascii?Q?756NtZw4H7p7WpNZbFNnrqP7OldVWlJZNf4Ii/nbz2ls8uvOe1xqUvZ6OtNC?=
 =?us-ascii?Q?97RNUSynFosO+VKjaPoxyHENsBg28zDsOd8xEwQ+nZ0koz9J7612PrmIEzhh?=
 =?us-ascii?Q?k7Mwhxtyw4WbTEGWh1cPU8XuU0oO0IKJG0BJqWjVPQMbTujt7+2g5LZuQmXk?=
 =?us-ascii?Q?/DLyqDR3wLC8ULeSqIohlNbPtlMLNoKg2hfMzmmMXqEhQVdQjy80xec6+exF?=
 =?us-ascii?Q?NSTJKKeApZMSlM4C43EFCFfhQmj0mEYO7nIkvXLKo+cYdz6f1Frr+IJAXOI0?=
 =?us-ascii?Q?qzW6qa8PuDOr4Al4bBRRdyI25w6bXQeHVrlJQJ5j0vuAYIkqgznzT82ujSsv?=
 =?us-ascii?Q?oVdIFLgYhS2FUa92/h4MxtQmpK9BRgrpz1zfDlCT4EEliA+A+j1KnLB+K6C6?=
 =?us-ascii?Q?7O9bYiaTOnaSKckkogBnsAcb0lA5bF6h1aicBRwvWyJEXDVX0/PAQiVRym/e?=
 =?us-ascii?Q?FfWT5aN/m7eMIzWG12uKRcU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19ef01a0-8da7-49ff-f7e8-08dc2634eccf
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2024 10:26:33.2421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G/in0BrvHYUcEk21TffX9kLNwB3dvQTlFc5iTy6/InlSX/nklwat4nISOxf4JcBon7gq7vFwMW8+UFgnkqwGR2OS+0JXTmC6uvWUPmna5FDsYAZ5CftaS6J0S4MUP24q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9340
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Feb 2024 10:26:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14664

Hi Pavel,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Monday, February 5, 2024 10:15 AM
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: Pavel Machek <pavel@denx.de>; cip-dev@lists.cip-project.org; Nobuhiro=
 Iwamatsu
> <nobuhiro1.iwamatsu@toshiba.co.jp>; Biju Das <biju.das.jz@bp.renesas.com>
> Subject: Re: [RFC PATCH 5.10.y-cip 00/39] Add support for Renesas RZ/Five=
 RISC-V SoC
>=20
> Hi!
>=20
> > > > This patch series aims to add support for Renesas RZ/Five RISC-V
> > > > SoC, support for this SoC has already been added to 6.1-cip kernel.
> > > >
> > > > Sending this series as an RFC as,
> > > > 1] Support for Global DMA cohernet pool is added 2] As support for
> > > > non-coherent DMA is missing for RISC-V core,
> > > >    required changes have been added directly in ax45mp_cache.c
> > > >    (ie patch #26)
> > > > 3] Patch #26 has been newly added, rest of the patches have been
> > > >    cherry-picked from upstream kernel.
> > >
> > > I quickly went through this, and found nothing too crazy. But as
> > > this adds whole new architecture into 5.10-cip, I guess I should get
> > > confirmation on the IRC. We'll also need to add this (and RISC-V qemu=
) to 5.10 testing.
> > >
> > Now that we have agreed for RISC-V support on 5.10-cip, shall I send no=
n RFC series?
>=20
> It will be same as RFC series, right? :-). So I guess no need to do that,=
 I believe we can just review
> and apply this one.
>=20
There is one small change in patch #26 (keeping changes identical to upstre=
am) and rest remains unchanged.

Cheers,
Prabhakar

