Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A7BC77B7A
	for <webhook@archiver.kernel.org>; Tue,  6 Jun 2023 07:14:49 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.100])
 by mx.groups.io with SMTP id smtpd.web10.3150.1686035686208957252
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jun 2023 00:14:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=alklMkN0;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.100, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tr7yjAT0tmjlDvySw2HpQR+De3uXyoHWWCvZHocdlsQ9ilPYxoTQsv+hzyMwPcG0kJ+w7+yiG5+mXHcXiI/d5voxFHx/QlIWWptdnauZvITP+PrOIZgpiV43t83sWHRSNf1sIlJqdTPNxUnc5OvCiH9XDePuwSlbESQDID3loY3y5nBVbAdOftc6+VFPZkyfLKQlMg1mgHnT5jnQE0sjM4g5Zcdz8b/IX7msRJ/ON6Pvyw1xyusnYyFkgS+8Z/UuSQhLZGMridLfyp6jxfwoeIs9HBZ7+ZZp2c/p/JxOPAiVHHfNOga2ZdMEDzE2GXdELTt6sjDncFDAT5cudefDbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7n6zhzoW15/br9kvpi2AJE1ZqL1oxjO1imbvV9tR1M=;
 b=mDWw3lzd+ZW3nKEqFsjDnyfI0bnmmdcJwlHHK0mopu13K67rA/90EAu6u9vv4iqwyvS5j/Y9rueb/JcKVwK9EyrhRkivvFUJ4M0Y1c7+5aVPUf9BMUlNidCd53DwVNb6re2FFJOTpzLqw15i5JETpXyamo+YWo8bbeBN7wR7kN7kn7iSR/ks9goGQCesCk4I29lHg19xnf6H8FYiCn4u2CgeU5nkEJ8OZPLNzwIVeaT1LPoP4rF1VLpkI/8OJtG7do738JDII3uDr7rfT+pGFZR63GqHQB8A404F5UDu/3UWGoULkay3qdED1SGf6FKC8j7LRtGmfOqou2soea9jIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7n6zhzoW15/br9kvpi2AJE1ZqL1oxjO1imbvV9tR1M=;
 b=alklMkN0y9aFicJmPBfatbA5YXl9n2hZsm0+hpJWuqJ9gN7e68/g307rMq9ICSj5bkA8pugLmQvugNjhj4z2GUhhABIGb+l8WNT13IHB6lPs/e1WFlKFHU71ptwVP/j3JgacBKgdUsAvFa1Vi1yfWukfRAE9JQbFn4xVYsA1HPQ=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB10215.jpnprd01.prod.outlook.com (2603:1096:400:1ef::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 07:14:42 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 07:14:41 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
CC: Chris Paterson <Chris.Paterson2@renesas.com>
Subject: RE: [cip-dev] v6.1-cip: state of forward porting
Thread-Topic: [cip-dev] v6.1-cip: state of forward porting
Thread-Index: AQHZl++bJ6zLyclMYUeS62j6oSuDmK99WhJA
Date: Tue, 6 Jun 2023 07:14:41 +0000
Message-ID: 
 <OS0PR01MB5922BAEED36FD47B0E4BC3DF8652A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <1765D9D28CD911EB.3349@lists.cip-project.org>
 <ZH5K91uDzLaJ1MMr@duo.ucw.cz>
In-Reply-To: <ZH5K91uDzLaJ1MMr@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB10215:EE_
x-ms-office365-filtering-correlation-id: 03d9e8e3-a58d-464d-bb49-08db665db2ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 LpbeR3xFI4Cf/yPxKGPBImj+Q7x7M593oSkioAX2ZewD5dLx8fa6rxS4QfHPw/VEtx7/6xine4JiRc/E01Pw5vqTyRoeygoXj6w1s6tZDijf3WkYbAoWp4IHElm2UqzwDj/xQKToeQZqnDOoCkkCvNXWJ7yYmlehpKaJr6SAKhUeRFPNJkgQUOiHAnq/j2kdlsRethSg6JeNPzw9hAkwSMP8LJ7hoYpqF10MAA7bmLOAOMQO1vmtxbRCwJIVGe7nxF2C4dkHxKArALnwCTzU0UYen2vxv/XE5dwW94ZmE++VbBsuz6zSwD1MJEX/sgQ9ZgJZzbRJbXoO8p65AV3X5MFftKck3WpBFiE/Qo8zWY9aI6R2xJ8x8zM8pLPb75UeP7lkNLFgUzZLO6sBTyalwEc6Jg10jqRQGL1YjfmT1lZKsygAqEal8/V5g3j2itj779tW+z4nTHubyYi5zgD9IkpUjx2gjpAaTMfbolKpOnlP4wwfGtVySJKyd0y3OMtN+FNnxPM/CpiM0g497MFIVCT8lbVJCew5n3u4PdCasRE3Kkh3UfXM4bmp5tZQYrvKnOtTp+nnSXTrPIdlVAYa06xzC5n7DOjYnCGf2YHeCwE=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(376002)(39860400002)(346002)(396003)(451199021)(76116006)(66946007)(66556008)(66476007)(64756008)(66446008)(4326008)(38100700002)(2906002)(55016003)(41300700001)(122000001)(52536014)(38070700005)(5660300002)(86362001)(33656002)(316002)(8936002)(8676002)(7696005)(71200400001)(478600001)(9686003)(26005)(53546011)(186003)(6506007)(107886003)(83380400001)(110136005)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?9OjCYPMbiHpz75y/TGOO1FwJH0ZjxIXHGCk798/UD/bhKoW6ZogrVMUMgvrg?=
 =?us-ascii?Q?sb3ctAaI4Tuiw13GRelwdsoQdoRTVNXNIitfaVx1HfeEOMndT4T+70pbdgK4?=
 =?us-ascii?Q?kO/mqxlPnLmzJafH1tFlDBa8POamwpFvn3bTHNn6gh//1deBEwYsTGcIyE6A?=
 =?us-ascii?Q?6EHcs5pAh/12gQOoLrCfAMHXNdbxIm1wSB1QI6Cz9gupsvDHHbRYdvaGJngg?=
 =?us-ascii?Q?EShRW9waCdQS9gJT1liSIlfqpjrypDi80+gGO+hU2hsXAKMjPRiaHbtJOch4?=
 =?us-ascii?Q?sGLgsz2c+hJitBi+MV2RcM3LI6JFhzkCsG2E6M7mCiyZoVcY+QP78pFnwkAs?=
 =?us-ascii?Q?E/cyY+x6rsH2eEBmpAqwS3lSYRybSznekYcNb+qooGKF76P+pXHQ+INEJZ8t?=
 =?us-ascii?Q?ViRzhxRkC4DmyNfEMtIl6CGYkg/JqnLDnLGUx2HFF+fF8QIhbMZv9EQu8QdV?=
 =?us-ascii?Q?i4y4jJgTOhCpYZ3/koVp4L9MEVNnlaEhllqk38hfzi56bJxwP0EmeEqoxbdC?=
 =?us-ascii?Q?7yEG6TXtbTabe3kBnh8rzPNSCyh0+s+dUrttpCzCss8MWswItvVlxSFiJUzF?=
 =?us-ascii?Q?s5ujVczFf0QFAAk79FFUgjb5GeJN0TxkPvosv7chNGNFDtLu0bNGR55N3XQb?=
 =?us-ascii?Q?jHfp936bsvC4lFcT3HmrtaX6zlyMv9IuYp7p1j4otx8CMkJxi9Oj1hlR3lXQ?=
 =?us-ascii?Q?hv615KdNTLQ6AYKCF4VSzO1iKYuvcmmTMro9rsIcg4J7fX4Rcq7g4b2ZTueC?=
 =?us-ascii?Q?sytZGlutYBFoeRsFyug2DbtsLB95rvKeJX2xlcCTxZfWiBEdQy73aUFq3HFP?=
 =?us-ascii?Q?P8DeTrt/HWc/XISbrrdnqp+YA6NM+2vEDZifWremuTtkIwLhc7ftPF6juXct?=
 =?us-ascii?Q?aQlB/R5RhBITECeAdVOnber0SDN60VkZfY9B9HC1r00wcFZcxLIp4aTn6jgL?=
 =?us-ascii?Q?myl54eOmGfFk3FyEFr19EBLzt0NM4zJhcvT1WvDxGRGPJZqljthwgmUaec/u?=
 =?us-ascii?Q?kyqllBldI8GS4q/Erm4szSDeK8RuAiSnckCCYRszOa2a9NPmXk1Klxni9gTf?=
 =?us-ascii?Q?yZ00v0FzToQ9TbeuO4ezT3kJKiPX407bVcDA30tAmr6oMKIJ2zoJFFrt+8h2?=
 =?us-ascii?Q?U7CSvedSbrX7mayqVlc8qHQEZPcdnBmBzFztB484E5NJ0q1JMqVx3Ly9FwE+?=
 =?us-ascii?Q?eNkgU7auiW7D6rUhWaCVnKClr+mjY79GqhWeaX8FwAP6ntK0ELS2hHeJLwEB?=
 =?us-ascii?Q?fwhs1clZy6ZeEFYVdu5E0GXbxSMRFY/4K0D1BbLEDn7Ix0b61U3XdYk4bR8F?=
 =?us-ascii?Q?L7UhcjxZ+JZ3n8sSSUj/UyWwQZKg1sWQpMkGHlkIdCk66BIBNCkeKJdJYUhs?=
 =?us-ascii?Q?KAnB66RjJxIidtnZ0oHUxlX22y6DYBBHBHNjjjOMgV7+eaf2ze8sk1LpLzKj?=
 =?us-ascii?Q?lzDzZYF04kJ4ob2jYK3VupNBTvkpkdNbmKaEBJyJXRyuu1k9lR/JHCeWxEmJ?=
 =?us-ascii?Q?WFhD75cSSL3iYuWODzmLrhzJEafZJc875FkloqvQFCukFj2TDApCt/s/Oq0e?=
 =?us-ascii?Q?1UOHwmLnwdlOPn//Qdv8tb8zQlGJbZsL9nzupbgz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03d9e8e3-a58d-464d-bb49-08db665db2ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2023 07:14:41.8479
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5D2S55+COAJQdjHb1sgHUjZb4J7uHQXjSE4AwX637ojqIFSDvsSviaQ9A39kjbAwjq8eykgU4oU7RlFU+itBsH/mySIWJyEZ6Fwh0xtlpiM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10215
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jun 2023 07:14:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11840

Hi Pavel,

Thanks for the 6.1 porting.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Monday, June 5, 2023 9:52 PM
> To: cip-dev@lists.cip-project.org
> Cc: Biju Das <biju.das.jz@bp.renesas.com>
> Subject: Re: [cip-dev] v6.1-cip: state of forward porting
>=20
> Hi!
>=20
> > I moved 6.1-cip branch a bit forward. Below is a summary of patches
> > that needed forward-porting according to my scripts. Let me know if I
> > missed some.
>=20
> To be clear, by "forward-porting", I mean "making sure all patches
> specific to 5.10-cip are in 6.1-cip, too".

I confirm, It looks good to me. Maybe this patch as well[1], which I missed=
 in 5.10.y-cip.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/com=
mit/?h=3Dnext-20230606&id=3Dbf58a687db232e738105244e34a85d21f5e2598d

For CAN I guess we need to backport below patches for 6.1 aswell.

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/dri=
vers/net/can/rcar/rcar_canfd.c?h=3Dlinux-6.3.y&id=3D34f9e9852b90d7be6eef958=
74500d1fb1b768e7f

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/dri=
vers/net/can/rcar/rcar_canfd.c?h=3Dlinux-6.3.y&id=3D841645cfc773cdd0a21c673=
57c53845f2e972f91

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/dri=
vers/net/can/rcar/rcar_canfd.c?h=3Dlinux-6.3.y&id=3Da1dcfbdfd1d0f7843f381f7=
c58cc87a0f8c11f6c

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/dri=
vers/net/can/rcar/rcar_canfd.c?h=3Dlinux-6.3.y&id=3Dea6ff7792203ad6786bda75=
d1dabf33311c8bef4

Cheers,
Biju

