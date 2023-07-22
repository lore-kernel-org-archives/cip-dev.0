Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D376C001B0
	for <webhook@archiver.kernel.org>; Sat, 22 Jul 2023 17:33:29 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.92])
 by mx.groups.io with SMTP id smtpd.web10.10073.1690047208090594201
 for <cip-dev@lists.cip-project.org>;
 Sat, 22 Jul 2023 10:33:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=qaBqOJEe;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.92, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mWWj9GV/GtVTmQs0eKWMo6QO6Qk0U+dxkd4kJvtepoorNIlRk4UUIS4MQ3c7tpWrpxUsQQOokx1XZQSUjw8bZE3KnI9pI1UMJJ1r3wh6Nq60AuzvJS4kJdY0540Vv6Ebl4wDMPXmdCaDaTSKj2K/3U6ytfuMX/bvCD+sQ7oRIjzMYy9c1+bGh3H3svIlQ4RYNQS3x+CKQOdhUC77zm68np5MSAqWNcYpzd/Cjv5kNaA5QpFKnIXocWSMdErL5EuSaz+OtQ7OyyVdNE9XInxNU3G4b6DIaD0NFw1CrF5fZurMK6J9RG9G4anmetx74cEzzOgeVxpjMYCq7nYlNW6/qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05vIu9ZJUjuGbR9wg6CUF6dRaoJulN2Dr16aNvdSuz0=;
 b=GCv5Iu9iUci4KzCe/yHTK4WD6D/6j+jtoNh1PW2cUmiTQaDIMx3ffZz+A727nKVyyZ4VR0Uiy7aHXQZvBTC0TO4lNTTKhmMmXM40GYQUrdTxMYLnCT6Xt0SXvPiWdeqkxNjYnZYYb2WRsXaDmpkAQd77VbsK4PueHZ+qx29umkk/Lh8FGDU2mKqvLmZ9kYW+IU9TUlDZt9BDi267X6CQR5g4SEWBNjyjS2jdl1++tW3frCXquqN0n03gq2C4xkBu8yT7GIgPPigbN2izsLTSCYnCsH3Sn3Zikyr6SosryVFBq4Hf8r8PhV17pguyes5m75t/AdwOvLqd6NiHVsNvPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05vIu9ZJUjuGbR9wg6CUF6dRaoJulN2Dr16aNvdSuz0=;
 b=qaBqOJEedAryTGgp5F0RLmwrEMFGgy7zSRjog7bvfYMek0rqeAWKrmGlRthAId/vQREhL+ga9A+WUOco3aAg64UUZAYXTugxijbVIdEvSbFbIxfplEtikOEzzifh1M4qu3Oa0RynXpez1pSLyrvMGfps5ROPJVx3yaOkdikBpHM=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSZPR01MB6312.jpnprd01.prod.outlook.com (2603:1096:604:ec::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Sat, 22 Jul
 2023 17:33:23 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::834b:28df:28dc:7f95]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::834b:28df:28dc:7f95%7]) with mapi id 15.20.6609.030; Sat, 22 Jul 2023
 17:33:21 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Fabrizio Castro
	<fabrizio.castro.jz@renesas.com>
Subject: RE: [PATCH 5.10.y-cip] pinctrl: renesas: rzg2l: Handle non-unique
 subnode names
Thread-Topic: [PATCH 5.10.y-cip] pinctrl: renesas: rzg2l: Handle non-unique
 subnode names
Thread-Index: AQHZu7n724i6ZK4vgkGm4Njzt5RiGq/FqJQAgABkphA=
Date: Sat, 22 Jul 2023 17:33:21 +0000
Message-ID: 
 <OS0PR01MB5922F8F360A1121F8D680FFF863CA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230721095859.280864-1-biju.das.jz@bp.renesas.com>
 <ZLu+AAp7waAEQZzv@duo.ucw.cz>
In-Reply-To: <ZLu+AAp7waAEQZzv@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OSZPR01MB6312:EE_
x-ms-office365-filtering-correlation-id: 79f149dd-fb92-4971-2070-08db8ad9be9a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 wNhIaGvemJ33n387n1eGaWAJBUPc82QI1reoS9KyX4w+CTrx+9tB1GRfYK8VArx+i/Y4n61r1EQQi7lyWF0dgX8jGEvXrsErLReadpsKsuDs0juy89LYotcW6BA/FcLjOub4zSXBc7xTmKRWruyH/7/v+hcEhmncc8Zko92IkBBAkcfG4hCNBYFukRhGscOLdMsQTymCaXgmhMcuEALJksnorB6xWR3buz1sUapALSJgTuOw6ToNZig5Zd830weA+EsxlDwSiEY5lbpxleiJ6Bcb9Jdru07jgWsoHMNVZNyQWMAdHsUPE1w8P0t8uDOBR5IfxIh0V3DmXAcpNZe5wbC7iLiDnsE75R9qrq/9e04mLQ2AXUDKnAhRxDR4s2mo0gtXTUwVZr9MOelcdjD9A/vQe79rvpW4EGgcbkR1Po9FzSSlQkFkRm0pMoS/fIij8/wvToUpAEM/4QD4pl1NE0rm6IZnhkzqUNFC8fQeFswH0bUcm/zcF7MAnC6RTBQFIbWXMeJUSsxV6SIGx6XCHm3LxiEiExvbPDuzRYrx7W2eVZRqUdew25DyRU82cBQmvC24Vzl9i0Wng++uzbJkVermeYJNq8cH7KQWnC+PXEEd98qvGaw3+1jDiICQYw+n
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(451199021)(2906002)(55016003)(38100700002)(122000001)(9686003)(83380400001)(186003)(107886003)(26005)(6506007)(53546011)(5660300002)(52536014)(86362001)(8936002)(8676002)(38070700005)(33656002)(71200400001)(478600001)(7696005)(4326008)(6916009)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(41300700001)(316002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?fU97u7isdG4Ja8NYLwieuXGhFJh3SNLLcFMen/VrW8/oWn4hOMhy98dHCj0z?=
 =?us-ascii?Q?L05wjRGya8/y1ejdNddtPnjkkuDKw5jUt0tpfpN8XzLP8g5IrP4S0jY1qP8I?=
 =?us-ascii?Q?tTG54Zjd0xhIYgZoFgzd+GdIimvAvtSIiTeoEs2T2wnELLslWzCu8YrvllKH?=
 =?us-ascii?Q?17KhqSc9GP4pnuKzuPZ0MbSClHN77fFzmF7Cz7FDq5x+0zL/IYzc7cKPO84h?=
 =?us-ascii?Q?m/QxdFJ7bkgHxd5w+Rkii/aKFnvlM1kYz4FKDTmz40uf1VBWqWW1ff/Xa+SA?=
 =?us-ascii?Q?KclAtfCcmM5K4MgGNRD5gs0EvpSoBpwKLNv5igYN/8xvsrUGY91SYWw2oNB1?=
 =?us-ascii?Q?MIVvNd4rX7ZVse2adWGLDv65zJliI2qjHIx8gvQXfSo+64vjA4PusNPoYRxw?=
 =?us-ascii?Q?4592EO9eOv01n/mLqie3ehS6UDrRhQ0lYziE3fdH5uAzTbtJh+2tkT//IgtU?=
 =?us-ascii?Q?XfpbdSLxV/chiLXYPra0tKZ9lE2/nHY3H7jaGEMRNTwxqUWrhgMoCfvqQJvS?=
 =?us-ascii?Q?JFThnH5TPzV/a5n+rQBUiwJXYC+QbfXSqqV+Wvq6yH+ylmMeUr1vg0l1XATh?=
 =?us-ascii?Q?gRU6lCuhipNzENbCoitJPM+jNhR9GH4G/QfCtu6Jc/tyCGJXHQVtKZBrZjJI?=
 =?us-ascii?Q?CLYP3VSuJQ7ftp8cWRMYFmdMSNe2LvOEUE/AKL3K9gpM0v31bsWDtLS02nrH?=
 =?us-ascii?Q?R/nc251iRvPZPUKrEDwkoU8v0x+qK9unPHT89+9WL8KnJxz55ue0XojEBEJE?=
 =?us-ascii?Q?dGWyvA298EL79G99DR/2zPI+m7hEGV34a/YRSTybnsTCX9jqyU74aWhiWJqX?=
 =?us-ascii?Q?Ffvb+9Bzubzp6ej98yylpFuCHpAZiCcril5p3by/z9S5Dr8kvffNDLMzK8oY?=
 =?us-ascii?Q?P0ysmhTBX9JeO+rgqrnSS/sQhANPQaNiC0gkrEHse6migZfJIFUkiAnRcyHi?=
 =?us-ascii?Q?8/MyBv//rW4lWu4W15h1NVbWtGw3fXg/zSSbSE+hlFFHITydh/snKUkeadI+?=
 =?us-ascii?Q?5AkItejuxIaUXgs2eORioE24R9jv3CmV0djhSI8kCK46bRAFVLbICxGd9gSP?=
 =?us-ascii?Q?wj3eICsJeURGoB+2GhZhaCFN9Sx9VKw7QlMaCRSyTt+64NPcHsflLrZuDn2/?=
 =?us-ascii?Q?18Jw2TEQesj46YrcFCIzNBzY6+g6W6L7sV6mnEI6zefeAgwkPsW2n7Eq3KcP?=
 =?us-ascii?Q?gNLBqm4J1I3JdSj9VInlIr3vOLDdMC28B+7INhlSEdUbAKWeNzffDmm9bosH?=
 =?us-ascii?Q?cI6KuTVzk5D+o9mRPsVeMGZdHDQpFczZsSjXlMdwW2bP+vhWTPVX9t39kpGG?=
 =?us-ascii?Q?roypYDPUW2xqyXqQlqMvO7imSSg+JdWRTQzpDwF3L6SfYhrB63YfJ9u68ZYB?=
 =?us-ascii?Q?+rZxA+YO+5miiLPmplmDDPf0d2E293jxwd/Jk7uX3U8rOMp/3ZE5p26EmZEQ?=
 =?us-ascii?Q?BWttIyzo8MPzclAPSE7vfje7O+46NiBbFfk5irgVlXzXTVEJSIfytfc1bQkg?=
 =?us-ascii?Q?KRNM9zXmxkfg9v3pqxpIkf+JGncOJGnBMO5UhyDXt47/q67tFhF64Ki1kpY9?=
 =?us-ascii?Q?vGymgrEzOd8xElvgoVj4tDrTcrjbi7K/JZYpj8Co?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79f149dd-fb92-4971-2070-08db8ad9be9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2023 17:33:21.2989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oBjav1IGZP3NVn+cGDXK47VFbSAxAH7jWKd5ec1xZjAQJUkTJjrjkavsMCT6MBz6blNUiervH6i0pfJOtBFo+hx9IWNS4QkxkrRgm4tYAlo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6312
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 22 Jul 2023 17:33:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12498

Hi Pavel,

Thanks for the feedback.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Saturday, July 22, 2023 12:31 PM
> To: Biju Das <biju.das.jz@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu
> <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek <pavel@denx.de>;
> Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> Subject: Re: [PATCH 5.10.y-cip] pinctrl: renesas: rzg2l: Handle non-
> unique subnode names
>=20
> Hi!
>=20
> > Currently, sd1 and sd0 have unique subnode names 'sd1_mux' and
> 'sd0_mux'.
> > If we change these to non-unique subnode names such as 'mux' this can
> > lead to the below conflict as the RZ/G2L pin control driver considers
> > only the names of the subnodes.
> >
> >    pinctrl-rzg2l 11030000.pinctrl: pin P47_0 already requested by
> 11c00000.mmc; cannot claim for 11c10000.mmc
> >    pinctrl-rzg2l 11030000.pinctrl: pin-376 (11c10000.mmc) status -22
> >    pinctrl-rzg2l 11030000.pinctrl: could not request pin 376 (P47_0)
> from group mux  on device pinctrl-rzg2l
> >    renesas_sdhi_internal_dmac 11c10000.mmc: Error applying setting,
> > reverse things back
> >
> > Fix this by constructing unique names from the node names of both the
> > pin control configuration node and its child node, where appropriate.
> >
> > Based on the work done by Geert for the RZ/V2M pinctrl driver.
>=20
> Looks okay to me, and I can apply it if it passes testing and there are
> no other comments.
>=20
> I believe we want this for 6.1, too. I can apply it there, too.

For 6.1, It will be taken care by stable, we just need to wait for it to hi=
t 6.1 stable.

>=20
> There was quite a lot of patches recently; I believe we handled all of
> them, but let me know if we did not.
>=20
> If there's something in 5.10 we don't have in 6.1, we want to fix that,
> too.

Sure.

Cheers,
Biju


