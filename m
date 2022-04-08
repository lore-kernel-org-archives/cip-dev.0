Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C930C433FE
	for <webhook@archiver.kernel.org>; Fri,  8 Apr 2022 17:23:44 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.95])
 by mx.groups.io with SMTP id smtpd.web10.100.1649438243126428465
 for <cip-dev@lists.cip-project.org>;
 Fri, 08 Apr 2022 10:17:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=ocuOGGgk;
 spf=pass (domain: renesas.com, ip: 40.107.114.95,
 mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=StIEP3rrLELdkExDLkp9DUSSbkED32lc9CvVMZpYo8hi5L7FPvWBIdK+LZPe/Aij/3d/oyoA4wo/WEWhcSS/0tTNhdI7Slnea7JO9Qaf0D4KJj5dvASV5pfneIcytdHR/x7HAiykU+jevggd0AcyAVHquDsWtX+zFXzX7vi7zZF0xzrADqzR1Mx8GWKe3bMTRw0Km3LgqJOXYnpwKO6lA5dR9tiFUDX4pMF4emL21zvq6bkofd7qUoytmEtHsCNkakTfeCvr8mz5Zm9yZAozMTrnouzyU5JofRUAN44dA3Z2qNI3U6x/Kxt5GRGfeHkxZPxhqtxIu4P9uueEI/+0NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mbx/kB+AQ3MtoQo6wXQGwFbi6I8pG4gN8PssVuuW9aI=;
 b=CzLnpHaU9K4WZZBW5Cna8GyjGEX7hqH/zNioykDLzpGzFt9mrJlBJBqbVngzBH/zhwASftmTI5/1AI5+6I9b3oygaVy+IogFYGKugxUpqjvXc9L3z6dpb7DvIZTXECN+W+oUyJdO3RBwL2JZ6kfFCm8sbwmbyWAoqJhX/nFENX3w3nnJdvykOVfGlRyFurPvcY6qG4ZSOjbtRKEgwGEhl6evZra9NF7DLSvLdmdo3jkIy3+kJ/YvjbJo8GfuyCjkOq+5FK3+dejkvlbAlZge6P7ndcbVP9c7CTfxOZ4GaUCaE85lk3G153UF1ym1xyIc9A20yN37bLUokP0LUBSp5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mbx/kB+AQ3MtoQo6wXQGwFbi6I8pG4gN8PssVuuW9aI=;
 b=ocuOGGgkaOCER7WBPVaXUW6DjE/P8qtLXKUD3GEafXkpKXMKA6OX63YKbCeVqXhEhm0YFrcakd9xjGsKgq+ZSfBrsSPk2f/gmmi3Qt7z4vsrlZfa0Jz677q7Oo+iHc1CB/BAMp1txdkzvXW/kAAar+zfr7K9BzD6VrmEGf4PDsw=
Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com (2603:1096:604:130::9)
 by OSAPR01MB5026.jpnprd01.prod.outlook.com (2603:1096:604:62::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.26; Fri, 8 Apr
 2022 17:17:18 +0000
Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::440e:cec6:b2f2:be1e]) by OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::440e:cec6:b2f2:be1e%6]) with mapi id 15.20.5144.026; Fri, 8 Apr 2022
 17:17:18 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Pavel Machek <pavel@denx.de>, Jan Kiszka <jan.kiszka@siemens.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: 5.10.110-rc2 mirroring/testing
Thread-Topic: 5.10.110-rc2 mirroring/testing
Thread-Index: AQHYSgKL1Kwgzb8SWkS6QXkHofo8c6zkAZGAgAIthgCAABLBcA==
Date: Fri, 8 Apr 2022 17:17:18 +0000
Message-ID: 
 <OSZPR01MB687796A29FE4D8E87C575B44B7E99@OSZPR01MB6877.jpnprd01.prod.outlook.com>
References: <20220406220612.GB4213@duo.ucw.cz>
 <b0523b80-b7ed-7ec8-2bc8-4a230b31f13b@siemens.com>
 <20220408155858.GA4221@duo.ucw.cz>
In-Reply-To: <20220408155858.GA4221@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9d3bf57b-78d9-4daf-f707-08da1983a2b3
x-ms-traffictypediagnostic: OSAPR01MB5026:EE_
x-microsoft-antispam-prvs: 
 <OSAPR01MB502630B19C47A87F697066DFB7E99@OSAPR01MB5026.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 99yWcScYTpLZmjuI9yUxzaIN7db1QqQu67Jo0hAur6QLHBUactUJB11ql2QPUx5R0qFEPddWbY8DhJJL0Yx/fDEI5mGaHCxu5xcHHL9HfXPwVLb8XxCcO/YLnNaCkwaeHm7/72UNvwUGoQPTvTlZ7ZjCE1CsovG3y2X23Nv1Hbo87ELHkKRFxij8+AZftn0IGXrBe2XGRnPPqlpJGsajCqF/9iCcWguQfuMuH0OsaeZIknboQ4SoIPr3X8hwCQBj1nBUqDNRd/xNuVoD+u1TZjYj1HdO4Rt6H8t5cUA5T9dDVirn/MOm3opcLjmhmB0bhhtxQcNBfi7qPSSCWSoQ3z6eGyou0n3gyb3kEHkM8VpwiutwiIce9dEYvprwIEpvvL/EqzrOzJcoEvVcRY96E4RLPxolJ7PMVFDF22pjPDPvwCUMDinmc4IzZxcWdDdz4297ypbemWYhd1BzlbJCjvAWa04VYttsqNh/kprXqsM5QsTsBWBJgU4yA/WpW/k6Yij2LetejowXsMva+dxwIPS5vKITt0VY/hE5qifsWGSqIGOMFZftQl2VpMdCfYFnTlEZEWOjueQynMXpLd3JaO7cR+FSuqviBg+4e18r48rDuYpImEc6FuvyvsGWSgK8KpDminnrWf2FccizCaWIZHfUut45n3UGUP8WNPd7pT9iqfYTEPwejXk3z4tDaiRwooC7i1V5WMrZobPu99B88J2gzvb+J3IJaOqBNvMPPSNBiIpm3sRJeGL4xE8FeqOH71VdNiZSJnM8zkTIjwzaLa3vdEhAg4Ap4u7uVkoL3sXxm94Pk4oQJTgRdeJL4ryFDGpipBHbApK6JFSlDxPgMw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB6877.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(66946007)(76116006)(83380400001)(316002)(71200400001)(110136005)(8676002)(66446008)(64756008)(5660300002)(66476007)(52536014)(8936002)(4326008)(66556008)(7696005)(9686003)(966005)(508600001)(186003)(26005)(55016003)(33656002)(122000001)(38070700005)(6506007)(38100700002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?LkdG9RW31f7e/k805ymBzzn/3hPcoTAwemiIYU5QRITfSc5fk3EUlIiN?=
 =?Windows-1252?Q?zQQCGfl0Ii0PErzs9vla5xQgCOXOMWI7UMPYhNANmLQM1Tg7H0A6n23F?=
 =?Windows-1252?Q?5e+3Vo/+kdajZbFF2ifmgm0H+U/tPZfg3Af/DqEgmDM7QKz4kp8O4B6c?=
 =?Windows-1252?Q?4pZMwyZswyJ37+t/JFhC2dr4FKe90xywtiiUPEPWL9/IUYB8ZjReT9ya?=
 =?Windows-1252?Q?CX2oxiwl/xFzkQI3FYqUwMG+WwZ4JFW1miteKkobuoQA6m9DNVPfI+LS?=
 =?Windows-1252?Q?gQAZ0KfogRmOrvMBdhbdXJD6bufDKglYcUs26lXwHC5ut52tlXyK1JLd?=
 =?Windows-1252?Q?SBy5Eno6Lww7wsSiWYAzLYKuliKx/b+HGbV2q8JB0QoG5jJcvQyIwdEY?=
 =?Windows-1252?Q?HOsVjwhZGHLaRQB13D/8+V4wkYXOlTQe+XzIZYkmYeq+2pbcwD75K98S?=
 =?Windows-1252?Q?LtrUzNF8wVT8Aq2KdbhVK+tp7DxBd3adzdp45YPZMqTf5yKuo6cdWPYU?=
 =?Windows-1252?Q?YUhFoO7D/JtksL2ErqhsGd1CBj3bAthbh/b6pvRHqavv6OLKUJgZbWeu?=
 =?Windows-1252?Q?bZmzFI7Kg/57hI9G4IoEUNHHCRGgAwyIB1NDRp0NeIVQXhtovtekBw8o?=
 =?Windows-1252?Q?y1UCQHpOFkATm3COyNA0FPBKYU+mN02dDThoXkBQy6012+XTK+Jy3EGz?=
 =?Windows-1252?Q?3XX+JZ4pLPXY2U0VJ28yASdjggkh9BsWI0ZQaVUtZ5UFj60aOxSK4+rb?=
 =?Windows-1252?Q?iGaMk7cHZ6IgToAqf8+sQ5qbn0mt9BDDePwj7v45y2TQGUG7pSyc3E5v?=
 =?Windows-1252?Q?yIFcEIYFhL//bRGXY+Rtja2n2xSEDEmq5IfBkU6ST3Yl50oClKUTd6vI?=
 =?Windows-1252?Q?DxqZ7WzWeWjjPATA7Ju6Db7MnpZxC9UyQtqYh/RSivKFmia2eR3QoW+W?=
 =?Windows-1252?Q?ifB4pF6NsJg9AV5n6skNU+vrJyHmt5LnPf2s+ruCTWaJvwDRm86GBUyN?=
 =?Windows-1252?Q?NquhLurTiHyruoCHMLsGC9TohReuLIq+/evk11ljMKsainQpLF1x+N4/?=
 =?Windows-1252?Q?+LqaRIQjeG/T6zNlky2Fgotwmgt/1ndBTDHURa/JN0ftj8C5/3uONlQ/?=
 =?Windows-1252?Q?na+RBwLrFKFTlJuRtZ2qi/uXyi2NUaxNXeUZFjHBZY01Mxd6+4/c4Mw8?=
 =?Windows-1252?Q?5VbJ3Ty7l5bfhv960QEoDsLrueDEIV+E0zt2sG5hAJLqeaKgXBla9vAj?=
 =?Windows-1252?Q?m9iILzGA5gmNERTsOKt7wSjuUvXz+qgnID04QJ0LHkcbvHX5AlvOYd4C?=
 =?Windows-1252?Q?l2u3vRzOAFekAze9ONvNTr1y1Rl15RGWYHRdSBftk8s91sCc3sHb1YF8?=
 =?Windows-1252?Q?dznjdoVt4dKWggRzVL06w25HW7PQL5s3T0daP74gr67KoDwGPN8tLwnl?=
 =?Windows-1252?Q?G9PTk5Q5xjr3B03jEEGyAjD3zVf9qsD7UQye/7qWmq+r3rSraXG140xd?=
 =?Windows-1252?Q?Yhs5X5TWp3fINcVQ/qymR4AFOVKWfFOD2qiNYA0mJOaOOfLTXXhnG9/3?=
 =?Windows-1252?Q?1KA77Y2QN1oPugI0G8kqwXZzmGgeZzRGsuBBvKSDY5+/cSfx+t8aO20q?=
 =?Windows-1252?Q?nQx3ZjxGMGFPHlrBv+dSEflrrsqbbp6udG4Qn0xMcBTQfBZtCJlnkomV?=
 =?Windows-1252?Q?rHy5AaYA8wLG3dyzMfe9FO83iaie8MHGUby+W5T3l98B4XcOvjZkIXh1?=
 =?Windows-1252?Q?pj4cNQRLka77FQw3UIL/4TqxEmwHTp64KK4nJjDP2sfJgRshmUc7okHD?=
 =?Windows-1252?Q?LPyBZikuibAqCKDmvjm9hdtXGgh0HoeWcr1sf6XsNVFvhLte2/HpcxPE?=
 =?Windows-1252?Q?OJJAMqGCpQTsMIAxHgZQTFERL7VnslzXJmY=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6877.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 9d3bf57b-78d9-4daf-f707-08da1983a2b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2022 17:17:18.6991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 uOgl4Us1tcJbO108EpW4kVeT14O7FQHuHk7ZVyXA7HJN5ZFq6oUaYo6rzGWZpaSA4HY2RpmgxpkLK4p3Sxe38g/gBRTmA1y9WMl4eCG5um4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB5026
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Apr 2022 17:23:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8025

Hi Pavel,

> From: Pavel Machek <pavel@denx.de>
> Sent: 08 April 2022 16:59
>=20
> Hi!
>=20
> > > 5.10.110-rc2 is out, and it would be good to test it, but somehow we
> > > are still at -rc1...?
> >
> > Already linux-stable-rc uses 11G by now.
>=20
> I see there are some changes:
>=20
> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linu=
x-
> 5.10.y
>=20
> but it seems to say "authored 12 minutes ago". Hour ago it also said
> "authored 12 minutes ago", so I believe it will not be able to finish
> the tests.

Today I've implemented a new triggering method for our stable-rc testing.

Originally we had a linux-stable-rc mirror that sent a webhook/trigger to l=
inux-stable-rc-ci when there was an update.
This was the only purpose for CIP to have a copy of the linux-stable-rc rep=
ository.

The new method instead just polls the kernel.org linux-stable-rc repository=
 directly.
If there is an update then the usual build jobs are kicked off.

Downsides of the new approach:
- Currently polling is set to once every 2 hours, so potentially it's slowe=
r then the old method (I think GitLab mirrors poll every 30 minutes).
- Because I just use git remote-ls to see if there is an update to upstream=
 linux-stable-rc, we don't have as detailed information in the linux-stable=
-rc-ci commits. We only have the SHA.
  Inside the jobs however we can see the actual log oneliner to help identi=
fy the RC version.
  Old: Linux 4.4.302 (a09b2d8f61ea)
  New: Upstream SHA: a09b2d8f61ea

Upsides of the new approach:
+ We no longer need linux-stable-rc - we could delete this repo and stop al=
l the warnings/errors from it being too large.
+ The new trigger method has much less data transfer. We don't need to clon=
e all of the branches from linux-stable-rc just to see if there is an updat=
e.

The trigger has already built all 4 LTS trees we monitor and build/test job=
s have gone through.
You can see the latest here: https://gitlab.com/cip-project/cip-testing/lin=
ux-stable-rc-ci/-/pipelines

In the background I'm trying to follow the steps in [0] to reduce our origi=
nal linux-stable-rc repo size, but perhaps we're better off killing it.
I've no idea if this will have an impact on anyone else though?

[0] https://docs.gitlab.com/ee/user/project/repository/reducing_the_repo_si=
ze_using_git.html

There are probably many other ways of doing things, but today this is what =
I've come up with :)

Kind regards, Chris

>=20
> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

