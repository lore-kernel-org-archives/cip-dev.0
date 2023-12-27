Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264D2C46CD2
	for <webhook@archiver.kernel.org>; Wed, 27 Dec 2023 16:07:12 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.96])
 by mx.groups.io with SMTP id smtpd.web10.104535.1703693228957493616
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Dec 2023 08:07:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=gf5cZt9K;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.96, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XvWpk2jZh9GrQCN+b/B8trFtQbau3xRzOpyVFDPldmvzjALI95/G2KFOa3vP5mAq4fL3VXQakBvZsST51dXkEB+6Zc3p7/VFCP/3pnAiLff8jiFFLEJ6+NZMcJdCF5DlZZ5dSk++md9Fhn/PIqqP9NGc5dBWLMHk3+Y3NW+70USWCpYIIGK1Z906bfLK7djfTgwJvEeUP1klYO7sHTbdE6zhpmO3RsRuzJs3R6/99gy23POW/4bpk881mphYve8u8axw3qJhpToGgHyWzBUpddp9pqHMLD3qriFqia/8Douuva1AREAiRBlRLSusftpv18W2AFiyzI0wZ6SQtdPsAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/T0Abv6FiW4bfuAVHyzFF/0+sf17VhqG8+nLV+D8RdQ=;
 b=SH2Kknnr20G50+7y6kBtC8nouxp4eyXQVZ54nLExL4Kdqs/LN+oLeC6WqcVPzZSzKDFD5tBp5HQAuzTrhVEI7r9ei4H9gZdtiZHXUl+AmSoOgFXSlogPV7RyU6Ps6DLtelgnDwuT65z26Qrm/axEodYgXddrJvWJLf+KNpitYbXmFPYoVdFvnDGFG0KCUJlKTNA71+PQAmhuN+iOzsWl9/j1PjHuV58kY2pj93VMCALt5ejBsmxnFEmjJUekC70Cvp+50hCBlV/1VCFZv/S3Nv8IxOb3Ty+a8wLedjn+FPYS1z+sCIodnqxpc8BGTEMDUYWFEvPIu6g6FJLnYDfSrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/T0Abv6FiW4bfuAVHyzFF/0+sf17VhqG8+nLV+D8RdQ=;
 b=gf5cZt9KNQQHpbfhstpVPE4Hw883ypK9E7QIZGHfNZmtD83Y9h6364YG/NFBTkuALipYV/QmvC9X8ULf5liRz6edA3aAzN09WUmMEnUIIMjqWyl/DYdj2TdJy4G9Umr4wEaNYQzTmIQN9QxAFGOOrv5+gt2ssj8JXFlpcwx67pw=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by TYWPR01MB10996.jpnprd01.prod.outlook.com (2603:1096:400:394::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.19; Wed, 27 Dec
 2023 16:07:04 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::39b3:aad0:4e87:9926]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::39b3:aad0:4e87:9926%5]) with mapi id 15.20.7135.019; Wed, 27 Dec 2023
 16:07:04 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH RFC 17/30] cache: Add L2 cache management for Andes AX45MP
 RISC-V core
Thread-Topic: [PATCH RFC 17/30] cache: Add L2 cache management for Andes
 AX45MP RISC-V core
Thread-Index: AQHaM5lOl8dz4pPUMk2pbFdX8sPofLC77agAgAFkQpA=
Date: Wed, 27 Dec 2023 16:07:03 +0000
Message-ID: 
 <OSZPR01MB701969188B401E976862754EAA9FA@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20231220230646.219816-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20231220230646.219816-18-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <ZYsdKDiw7G+kxQ3m@duo.ucw.cz>
In-Reply-To: <ZYsdKDiw7G+kxQ3m@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7019:EE_|TYWPR01MB10996:EE_
x-ms-office365-filtering-correlation-id: 9a2256de-e395-4c5b-31d3-08dc06f5ddf3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 7AdCIXf78biQ5BS1pjQtHg2Wxc0gwbqtSFYszHgM/PWM/f0KMlo9tkPbB7sKEe2RX1CMwMwi0z9WRpVqvnwmJNlczEReW6wxsEL4WvVEj3yJGQF0WF3ILMyE9GQ2JUgWHdQjWnDo7YSJJh6RY6xlpyHqjuwn5jknrZ9sQyyTqm21L/wnkePhoxEuQ16RupZHYNatEKysfKwTwifSSH2bVRNLbpBblvgQa0FMTKVdzNaopXpL2Fez/peP0g/+ps/CC1bQJGTFej6Ga8cif+e1llet6d/UJce0h9BjSxtFDs1WuTayM3iBybN/nPD76w7NGMQxCw+MLWc8fptrWbcm9OSYXNIioSBkmMkutElbhzNkrizSOmvwWa6Ua/teIk9gEoEmUPPoqyxxD2wmKVVd5zaIgkHDD4i8auhx82rXg+jcz1RpJgCbyOC0X+4r+BR3lXhR2Qg50YJz3wpFqoN9KZZIqgF6bYxVS9xwWGHaHedvxmrO/I/asDcQU3gre42MHXItj1kTuBPE12i23X0/a90xZI+1JZjruu+3OM5BFRNLXK+mN31Eb2/qUmpVs3pPd2hsGt29E0eNkbccGgR5NMBja/8x4aucOJFCZW/XnqORh0OcfK0A4dC8GsXPLP7m
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(396003)(136003)(346002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(2906002)(5660300002)(38100700002)(55016003)(86362001)(52536014)(4326008)(8676002)(122000001)(41300700001)(316002)(8936002)(66556008)(66446008)(64756008)(66476007)(6916009)(76116006)(66946007)(54906003)(83380400001)(33656002)(26005)(107886003)(478600001)(9686003)(6506007)(71200400001)(38070700009)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?6f33AdM8DHAPp3K2q2VVin4HrTWOzButDnRZ55j5BbSC48D+rru5pZBnDMVz?=
 =?us-ascii?Q?qS+CHF5gbQtBWl6qFu+NgmnM6p63kMNE2aO650YcV/a2gylhuEB+Kxj3ADmr?=
 =?us-ascii?Q?5BYHPBw0qq6WkHYTzjTLkumh0IfGJAbh7X34g3uIYoVl8uDq+nBqYTcqL9cu?=
 =?us-ascii?Q?HQOsPjjpyCMOvlrXJHf2PV6aWO+GNo3J9Lj7TVucrG8g1X+UjfijB8VVn+tH?=
 =?us-ascii?Q?X/MFRZAl/8GeZ/bR0Povo5V6wz+MXqcYpcdISqIltDk8vYT93WJW4fgdC7VM?=
 =?us-ascii?Q?DuGeToV01nFjL4TPdOyOmbiRQ1z4MjptEVVc5gQ1RyXxPEnLydl9i5gKo7Qa?=
 =?us-ascii?Q?KpFf9yIbgVyzpl6wu5WvCFTOJbj2WPUwCZ+ao4T0Ouc/yVUWlpycckTYnIq+?=
 =?us-ascii?Q?hEKuYOhdSpADZ0fY5l+934QI3LgGUjtydy+j6+8zJQUxRXvpEcYeZCJ0voIy?=
 =?us-ascii?Q?Sy06ZqtU60IXcJrxsHHlOK6J1ciGMSEGzdpxi1ObHIfst0ZZaNcrseHrajTH?=
 =?us-ascii?Q?HTcihTMk6x7CABbmNGgEK8DU+J6Mn/cgG78ePPQtiyhXNb4uXR4NXG5j70n/?=
 =?us-ascii?Q?SeN6MQatXZq2OyIzyhivKg1Dzu3G9AD9fjp2km5BVHIqeRAm17bZZR/iAsbE?=
 =?us-ascii?Q?edd2NQ4/WRVpyKuR6p0ijn0EP8nv6AMSqTu3U5cOeNHptJ/Zxyu6MGUkzqnq?=
 =?us-ascii?Q?UHlHAOfJOTo8pfaHTuWizPDzY4WDgF8CilbU65uPg/NDMme6wPnrhKETWOjd?=
 =?us-ascii?Q?9ZMrPUny+W3eLqHxEiVMyFeLguNzuBSczLNONKJHqh3hnV2rEdJwt53EFQ6M?=
 =?us-ascii?Q?Fa51xTwk6PoJpzwfvOfyncp6w3fODXM7YQCYIQHANqNXFI8ZFO03szlsoh+q?=
 =?us-ascii?Q?pcKHTL7Ih3BIgiQ8mGdGjdFbNIGx3RF1WUF1hiupO1b38gwQux6VwUnwo6Pw?=
 =?us-ascii?Q?nSs+zG2yTPtsJrHpUDqw7AbvO8Mcgzq/WLlOsjnCMMe+KLkKiEaeBkAipe1e?=
 =?us-ascii?Q?4eJhHF+CIbnY+32A6jczNDGNa9BCqDKkBkKmpvA9xEZQxufOtZWBndQoY6zK?=
 =?us-ascii?Q?dcc3nD0CzReD9JyYDsbKQLLSTEKeBNmcFCqJjQLKujG9rNzRunShlk/NNw9e?=
 =?us-ascii?Q?96TZ8Of2InDw9gH9MRGkHhEnK6J0mIFGaES+tZzkxux+DjOAQFed2gSmpyrt?=
 =?us-ascii?Q?Z8Yd/fna3NvhoG64cryoRlhjDZIboD7JJCEuFOGDDb3uyYuWdaSWig7HMvqP?=
 =?us-ascii?Q?7AVcQC0D8n1S1o1Ho+elkYjLaJS6AzAPYRW56XhR0Y6wnBzPoVHAkffvdaKc?=
 =?us-ascii?Q?Oa6J8q/f8PDr1bXE0SrO5jZS5HnYLILuo+B2VsG1H2/ZwoMAdLCKTCR2s/sK?=
 =?us-ascii?Q?8mV0NrlPyRchnpLaOLPd53ZauS5EqqMsA6hPcrbrKPhPOav2/yhmCgnIwdVA?=
 =?us-ascii?Q?yPDDWztRwZa9RH06wGi0lTm8tj52IOt57HxPeCi4+sBCGabvj+/vlUVJlAQ8?=
 =?us-ascii?Q?aY4PhiACme2F68eZicUgjn+45Q3u9cXrm2lyDmlP3qJqbjF3uo2H8f6Zzarj?=
 =?us-ascii?Q?7g/QFwZlztxD0i4LhN5iU5aivoawPzjqa48HeN4NanukP1TJd1cPS1MURso3?=
 =?us-ascii?Q?CwHYeRSeUwnVBUES0ziAXNI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a2256de-e395-4c5b-31d3-08dc06f5ddf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2023 16:07:04.0020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /4iAS0ELq3cklnLECYWCBQYH19vW9wdEDoTCdXhz4qdvPqguHTbTItyaXxQl+zn4TUQzLobFvcvg+BMUL3Vzp2dUSmzzzV4mibljtl6FxcMF+lUGEEzYjZ1Ybhf6Ktuu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10996
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Dec 2023 16:07:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14202

Hi Pavel,

Thank you for the review.

>=20
> Hi!
>=20
> > +static void ax45mp_dma_cache_inv(phys_addr_t paddr, size_t size) {
> > +	unsigned long start =3D (unsigned long)phys_to_virt(paddr);
> > +	unsigned long end =3D start + size;
> > +	unsigned long line_size;
> > +	unsigned long flags;
> > +
> > +	if (unlikely(start =3D=3D end))
> > +		return;
> > +
> > +	line_size =3D ax45mp_priv.ax45mp_cache_line_size;
> > +
> > +	start =3D start & (~(line_size - 1));
> > +	end =3D ((end + line_size - 1) & (~(line_size - 1)));
>=20
> Could some macros be used to make this more readable? I'm pretty sure we =
have macros for cacheline
> alignment and aligning end to cacheline boundary.
>=20
Hmmm, can you please point me here, I must have missed it.

> > +	local_irq_save(flags);
> > +
> > +	ax45mp_cpu_dcache_inval_range(start, end);
> > +
> > +	local_irq_restore(flags);
> > +}
> > +
> > +static void ax45mp_dma_cache_wback(phys_addr_t paddr, size_t size) {
> > +	unsigned long start =3D (unsigned long)phys_to_virt(paddr);
> > +	unsigned long end =3D start + size;
> > +	unsigned long line_size;
> > +	unsigned long flags;
> > +
> > +	line_size =3D ax45mp_priv.ax45mp_cache_line_size;
> > +	start =3D start & (~(line_size - 1));
> > +	local_irq_save(flags);
> > +	ax45mp_cpu_dcache_wb_range(start, end);
> > +	local_irq_restore(flags);
> > +}
>=20
> This should be very similar to the previous function, but is not.
>=20
> In particular, it does not check start =3D=3D end special case, and does =
not line-align the end.
>=20
Good catch, I'll get that sorted upstream first and then backport it.

Cheers,
Prabhakar

