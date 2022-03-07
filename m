Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF38C433F5
	for <webhook@archiver.kernel.org>; Mon,  7 Mar 2022 12:44:01 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.73])
 by mx.groups.io with SMTP id smtpd.web11.25645.1646657039545785944
 for <cip-dev@lists.cip-project.org>;
 Mon, 07 Mar 2022 04:44:00 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com
 header.s=selector2 header.b=fzLDLW7x;
 spf=pass (domain: siemens.com, ip: 40.107.7.73,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Djwb3dLfrOmoiYxQXhYVFUmZMuxVm+5DgdmINsiZcZ+0lmp5ImENGWc9P6Eig+8mTUFf/82SALoBbklx8lzCxVkeH8+HfwddtOJCajsTaUQrObTtbMfi0p6uJb5kKv3Uz2cd0aSDLkqzEHPrG9IQ6b4MiH14RH/2CASZQ3FpCZo1A5x5v4MuGlroCI47ZkRsRqs30fodZ1MPp5+o5CDOcRpCH7AAGLCgslZHTmI30kAyWTzvwEUMPzvvyIQWteOFLKJQnKpSn38VO9S/wzYvqP61LawSEk1nM7E1TaKi5MNaSz6X4rzkRpVVskwQ1gT2eDZ6EielIUdPkOEdrxBRjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+nwRkZnSAnlb43N599c5wH1CQjpJKA6GC0VPVgXkb0=;
 b=BPLNazSRUEcaRWk4rnKq3eUWnr2K/lw9/J7bjoRgrzBHtmEdcJABwSYeaYrjEkKupYlcdDSuGlNa0wWN9vaH913Rrrwe6BcLgWCP51Nw/7Uh+GzYnw1le4o97ohDjv1IglFbibCwe8zghQ0IJOd8WcGnL/2X2iSXi2pl6MBr4z8q0Q9PtAR5PqgRXwV2mnIovERz8AxuRwnNFtEHYcWRW0VWzNUjLgPpUIjUlqbBmwvA+1eKSNlBGzznNg5O34VP3/1GIxmQ9YvVHzZQyEetzFVZ6J7DqFnUGg2xjlCJVhVr4qdXJJ1t8DoWiNjI1mzoqOGijKw0ZZ72R3cuDdG3XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=gmail.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+nwRkZnSAnlb43N599c5wH1CQjpJKA6GC0VPVgXkb0=;
 b=fzLDLW7xW0BH3+FVeMuQfyK8uy1vHX+5OovcATi8y+612Q97J+70jnGNWUnHB1AGhKPaouOoapTCBP4EhHepIJyxLN1dGGtEu+zBajIkPWgvd/7zjurvcozThYi5HR9v7orQ5obgBC8Qn8pm4TR2p6DcpkVfEAUDn9wvYYX+KVXginFX+LqW6KcRbdjhXWE2ouJ1pqrpxEJow8EVRcEPt3GGZeocFMABSiS7LY4neTc9UHVhbxk4wRJ2pE8B554fzTQBrRU6oTFhn+T0D9QD29ZDrKB1ueyrNKSD9mHqhP1l/4CwHjyLTqQd2osnOlowBXgX3u2+eyaj/ViDJcSHnw==
Received: from AS8PR04CA0158.eurprd04.prod.outlook.com (2603:10a6:20b:331::13)
 by DBAPR10MB3996.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1c4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 12:43:55 +0000
Received: from VE1EUR01FT041.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:331:cafe::33) by AS8PR04CA0158.outlook.office365.com
 (2603:10a6:20b:331::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Mon, 7 Mar 2022 12:43:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.72) by
 VE1EUR01FT041.mail.protection.outlook.com (10.152.3.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Mon, 7 Mar 2022 12:43:55 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Mon, 7 Mar 2022 13:43:55 +0100
Received: from [167.87.0.7] (167.87.0.7) by DEMCHDC8A0A.ad011.siemens.net
 (139.25.226.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 7 Mar
 2022 13:43:54 +0100
Message-ID: <562b864c-b8f0-53f9-37eb-f0569c45d456@siemens.com>
Date: Mon, 7 Mar 2022 13:43:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [cip-dev][PATCH] Update to kas 3.0
Content-Language: en-US
To: Srinuvasan Arjunan <srinuvasanasv@gmail.com>,
	<cip-dev@lists.cip-project.org>
CC: Srinuvasan A <Srinuvasan_A@mentor.com>
References: <20220307093403.282069-1-Srinuvasan_A@mentor.com>
 <f824e211-66a5-e959-f31c-d54e5565c7a9@siemens.com>
 <CAB2Z2nO9yvUvnmcPhsgOsqvWAWEej9jUYiWqj_=yd3ra9ZfD+w@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: 
 <CAB2Z2nO9yvUvnmcPhsgOsqvWAWEej9jUYiWqj_=yd3ra9ZfD+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [167.87.0.7]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69680e56-e3ba-40ab-f503-08da00382477
X-MS-TrafficTypeDiagnostic: DBAPR10MB3996:EE_
X-Microsoft-Antispam-PRVS: 
	<DBAPR10MB399611FD5C3CE406535C69D995089@DBAPR10MB3996.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	S1qbC2uzSSE0D6YQfxm2Jd7H3DpOTcPh3BEJAS/GPIqVf17dSGiVOwbNUhMySJEWNAmg72hhgjeZhIQshi7CC11sk12El6YPp4e+09nwJG6i+nWn56ASoLet83FyAHMFVUh+Yk7OICE5YUZIRjFhxH2767/IZI0n3RhfEI04Toix3gjTuVCV3IFv7xsPcnT5T0jWVQUQ7cas/D5Gm/bgoNQBtR8/bB3wcYbYsa9xAQkMLVpdC2rcq8JyTtDxMzqIA0xB19wJIMxJJzLbBf6DVheek1VIKoeGjgrsQjbq18z8ok8HVcUp1UJC7E4mj4Nn42mgnkt1H+7CLnBjrAXrVGtpQAsnkLUfWDnex3xQyTmfAYl/d7u/LSbZuXuO7kAvwGvyhvlOiDZrxMgQB3LFbfSZFLhygu6xY/4U2za2rNqdabfgei+tOE5dTi92/FAn24c6S6Od59L4yBpq7kSonzysc2Qe60Bn23lnLETvhL+uer4ob6IcG/aqKjO0ntj3oQLIDPvjTxXhL5SCxQBGwnp3l1aF1Gd5OhqdQcLCP0VVYCQZFYOulc3Yo2Nb5Iz+gXY5hG5zpQzeBJ0XzEcOzWG4eKAAUAfr5CMQik6Wj9oRbN412OXHUWbgNt/IoRpAvHB7kcA39JgFcMiPvoyJZcuLm93CMLd1TF7Hcp8xRUS0F8y5Vh41ITclD3sTLIRpK0WqVxDY6bHiFdpBf1z/ydDYduDdn8pDGxO/7d4TMhbrIkgwVpSdc/jpgQj/nniuZ9xE9bd9MfPFO8kpqW3F4Y6s+sGSqlTVo8igEdyTYnSGmwVHHyZkeCc0Elgiqd/9U+b+AneZvY6AGIMPg/dPkuOfLPIHbuacU2igdTutSnjPnTvWYaNZjkMnrXSqGtllumORDcQtMM6Bm73zf30K4w==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(84970400001)(53546011)(26005)(31696002)(82310400004)(16526019)(336012)(966005)(186003)(83380400001)(86362001)(956004)(2616005)(36756003)(2906002)(5660300002)(8936002)(44832011)(15650500001)(36860700001)(16576012)(316002)(110136005)(6706004)(82960400001)(81166007)(47076005)(8676002)(40460700003)(4326008)(356005)(31686004)(70206006)(70586007)(508600001)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 12:43:55.5887
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 69680e56-e3ba-40ab-f503-08da00382477
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT041.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB3996
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 07 Mar 2022 12:44:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7666

On 07.03.22 11:09, Srinuvasan Arjunan wrote:
>=20
>=20
> On Mon, Mar 7, 2022 at 3:11 PM Jan Kiszka <jan.kiszka@siemens.com
> <mailto:jan.kiszka@siemens.com>> wrote:
>=20
>     On 07.03.22 10:34, Srinuvasan A wrote:
>     > From: Srinuvasan A <srinuvasan_a@mentor.com
>     <mailto:srinuvasan_a@mentor.com>>
>     >
>     > Update to kas 3.0.
>     >
>     > Signed-off-by: Srinuvasan A <srinuvasan_a@mentor.com
>     <mailto:srinuvasan_a@mentor.com>>
>     > ---
>     >=C2=A0 .gitlab-ci.yml | 2 +-
>     >=C2=A0 README.md=C2=A0 =C2=A0 =C2=A0 | 2 +-
>     >=C2=A0 2 files changed, 2 insertions(+), 2 deletions(-)
>     >
>     > diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>     > index c06c783..f573da6 100644
>     > --- a/.gitlab-ci.yml
>     > +++ b/.gitlab-ci.yml
>     > @@ -1,4 +1,4 @@
>     > -image: ghcr.io/siemens/kas/kas-isar:2.6.2
>     <http://ghcr.io/siemens/kas/kas-isar:2.6.2>
>     > +image: ghcr.io/siemens/kas/kas-isar:3.0
>     <http://ghcr.io/siemens/kas/kas-isar:3.0>
>     >=C2=A0
>     >=C2=A0 variables:
>     >=C2=A0 =C2=A0 GIT_STRATEGY: clone
>     > diff --git a/README.md b/README.md
>     > index f7cb86e..fc4ddbf 100644
>     > --- a/README.md
>     > +++ b/README.md
>     > @@ -12,7 +12,7 @@ from scratch.
>     >=C2=A0
>     >=C2=A0 Install `kas-container` from the [kas
>     project](https://github.com/siemens/kas
>     <https://github.com/siemens/kas>):
>     >=C2=A0
>     > -=C2=A0 =C2=A0 wget
>     https://raw.githubusercontent.com/siemens/kas/2.6.2/kas-container
>     <https://raw.githubusercontent.com/siemens/kas/2.6.2/kas-container>
>     > +=C2=A0 =C2=A0 wget
>     https://raw.githubusercontent.com/siemens/kas/3.0/kas-container
>     <https://raw.githubusercontent.com/siemens/kas/3.0/kas-container>
>     >=C2=A0 =C2=A0 =C2=A0 chmod a+x kas-container
>     >=C2=A0
>     >=C2=A0 Furthermore, install docker and make sure you have required
>     permissions to
>=20
>     Please test before you submit: We have an open issue with kas-isar:3.=
0.
>=20
>=20
> =C2=A0 I=C2=A0did a build and verified the pipeline in KAS github, It see=
ms okay,
> but when i trigger the build i was able to see some logs related to sbuil=
d
> Adding user `builder' to group `sbuild' ...
> Adding user builder to group sbuild
> Done.
>=20
> # Setup tasks for sudo users:
>=20
> # BUILD
> # HOME directory in chroot, user:sbuild, 0770 perms, from
> # passwd/group copying to chroot, filtered
> # Maybe source 50sbuild, or move into common location.
>=20
> Next, copy the example sbuildrc file to the home directory of each user a=
nd
> set the variables for your system:
>=20
> =C2=A0 cp /usr/share/doc/sbuild/examples/example.sbuildrc /builder/.sbuil=
drc
>=20
> Now try a build:
>=20
> =C2=A0 cd /path/to/source
> =C2=A0 sbuild-update -ud <distribution>
> =C2=A0 (or "sbuild-apt <distribution> apt-get -f install"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0first if the chroot is broken)
> =C2=A0 sbuild -d <distribution> <package>_<version>
> =C2=A0
> =C2=A0Might be i missed the open issue things

That warning is just a cosmetic issue, but I plan to fix it with 3.0.1
this week. The actual issue was (now fixed in next) that swupdate images
did not build. CI would have revealed it as well, but I happened to
notice this already on Friday during EFI Boot Guard experiments.

Jan

--=20
Siemens AG, Technology
Competence Center Embedded Linux

