Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3A9C433FE
	for <webhook@archiver.kernel.org>; Fri, 30 Sep 2022 11:56:48 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.97])
 by mx.groups.io with SMTP id smtpd.web10.4728.1664539003035783941
 for <cip-dev@lists.cip-project.org>;
 Fri, 30 Sep 2022 04:56:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=Zkw46Qdd;
 spf=pass (domain: renesas.com, ip: 40.107.114.97,
 mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJ7H/Pmkir2NBi+GoGRyPVTFTv9FLHr1la9Ia24PD2ZNfWUN8aOixRLs5Xm+fsceCwvTTmY9s6WUFAIlGIeewBMhS9IKtgzhbgb5D5d4qVrYVadFjVUxMz0+p+LyGmGR/7Z41SnaZ6ldVeuGsrRzf44yylPTF/jja6xtJQ6XaLZUMDTMPTr9J5JjTW2uIG0HU0RP5Ap4wQ5ZLUjuCJqzYTpKR65PeniDK3GwBdfMbAphoNyXIXMdKB/ID95YNncnm/tHOIXfz9OMcqZEA9lpw+vRdYEgx5QkLJmBJiMSgPUxUzKtAArhbD7oqu2oqyFoC8VZrTnAr9TVDJxHzeL0hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S29h6vu3v5QR9fmKASfPM7D/W74Q168gf6W0BIev2sU=;
 b=TRN43p2mZb/A8T/pGzveDEKyYGZHLe5ChPMg/W+OGuq2m47k8G7bYaFHZqODgtAneGOn1Ay7RdgUk8GCv2nLF4QrZZhyH44i+EW3voVq+uRC2yA/3gAmpov1QOjZuh2qOGsEjelLqbOBdHeP5RJltlNX9REB3sX0LI4ocN1+Bkv8LbWXdK1rSksOL32ehb7nK+BFiQ+W/A/evAUF86EV/z5FyDyDrRLLt3BEVi7LUH6U7/DQ9huwUy+O73KdADe3bROovJ47h5ANzhpQsSu2EtxU8oU7ZiV5OD6qJNLQLjRdZqpbivha0o6rj5oHU3zGCgvVwUx6UlXnhyn7XQSs6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S29h6vu3v5QR9fmKASfPM7D/W74Q168gf6W0BIev2sU=;
 b=Zkw46QddMbqPkSEEoYkvmYlRmrCdQOY3t8BYwaSfkzF4H1OVPBTrfjT0M1O7apfrsS5jm5U9USP1Xf64KCWTbMXPF2Tgw1NUdt1fOcsB+xMcJzA9QFeGhbghWyPGLUYfY1hk3hr5VybmtZji5eLOlDU+qUfeR931CZlHNADGWMs=
Received: from TYCPR01MB10588.jpnprd01.prod.outlook.com (2603:1096:400:309::8)
 by TYCPR01MB10859.jpnprd01.prod.outlook.com (2603:1096:400:26f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Fri, 30 Sep
 2022 11:56:39 +0000
Received: from TYCPR01MB10588.jpnprd01.prod.outlook.com
 ([fe80::68d8:5e72:53f5:ea7b]) by TYCPR01MB10588.jpnprd01.prod.outlook.com
 ([fe80::68d8:5e72:53f5:ea7b%6]) with mapi id 15.20.5676.023; Fri, 30 Sep 2022
 11:56:39 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Pavel
 Machek <pavel@denx.de>, "alice.ferrazzi@miraclelinux.com"
	<alice.ferrazzi@miraclelinux.com>, "Adler, Michael"
	<michael.adler@siemens.com>
Subject: RE: [cip-dev] gitlab test failures -- job failed ... pods not found
Thread-Topic: [cip-dev] gitlab test failures -- job failed ... pods not found
Thread-Index: AQHY1LqD736Cemy9y0G88cTlOE3pAK331CBwgAAI/2A=
Date: Fri, 30 Sep 2022 11:56:39 +0000
Message-ID: 
 <TYCPR01MB105888A4C268DD3DE0F5481C9B7569@TYCPR01MB10588.jpnprd01.prod.outlook.com>
References: <20220930105048.GA19081@duo.ucw.cz>
 <1719A05389EC9CB2.16804@lists.cip-project.org>
In-Reply-To: <1719A05389EC9CB2.16804@lists.cip-project.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10588:EE_|TYCPR01MB10859:EE_
x-ms-office365-filtering-correlation-id: db0da92d-e624-47e6-741b-08daa2dad575
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 uHdIIvAVLdYkqtHYifePV2pmQipp6v7z0WQxuQ9aZfrutnZICD/gujw3mywXM32KjrSFfB1BMpSpsBmHi8ulN/99cG39LsK2uKLi6ygjdvL0+xvomX1VhBF4cwVqTyKk53BFwqzCK1LGGbM6KN4CH0Q5rJb3JS2x+nKWINJMq3+ukf2Jyf2wc2rSx4p2m0Du5xAbBX3K4oJaXJQZIYrWmyb1OHmrG+mj5CtFHnOEPBlaiNpkbO1Ut0/mAgTu3FdEleD/Tv/EGnX/FSHXRbzaQDWDgmNMojKKxjJQNt5B+SquVzJiJtR0XsXp6/1GIKL6Lmfh1GCLD4LSXdOYg00Tb2SnA1UBNZXzGZOf+48yk2/YA8Ju/VhfkL5Z4pnHwiXYZenvjTE8BsX8SmZ7NF+g4RrZQLCQUwBOKWNfWVA6qLc1IHrz6aZXMz82pYQHMv1oK8AIInqpeLWQNz7u9syob9vAaSi5OaVCH8QepSQPuT/UUdnGJOVwWgcYbNtakxPaI3XCtWKosBaysLUC8k6JiwzujW2bamexwcTRRdsFpfnH9CrY3D4FQ/ym3B5Rc/Gwr6CpSnmrFCziS1M3Gc1OQPHiaOhgp5N6+8Rx3aLMs9IC61PkgLvN1C1yJI1CtTNCrHyrWLmH6AZ08bPXS+NTRj+EOW4vdcbTraT/FdGM5mT28v4hCDOW0bMI3O4tPcC5teRfr4oxICUJvzzVYWwzvbDuVX9BhiOG5k2ZrGDKCR2NHxJeU6fl1PFNNNgxqubdAYHlVlIeONlrKjU3e4q9LHBLTJbJ+lZYtOdUQqxL7Ks=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(366004)(346002)(396003)(376002)(451199015)(45080400002)(110136005)(83380400001)(38100700002)(316002)(41300700001)(76116006)(2906002)(66556008)(6506007)(7696005)(66946007)(55016003)(26005)(66476007)(966005)(64756008)(186003)(66446008)(38070700005)(8676002)(478600001)(71200400001)(9686003)(86362001)(122000001)(52536014)(8936002)(33656002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?fQVQOIGe4ypz1nN2lABV/szR0JAXeknxBKlpgginu4UMAhlfOwF8Ak28?=
 =?Windows-1252?Q?wf/ZQFfPD47dXdFM/ruR/YCoirdDcgIrBqnPoC6pATFcERk/2aiI1kub?=
 =?Windows-1252?Q?2U8LCjKm9B4aX0AgmZyQCFSHxWtlFkxBp/bDiQ5gtnfx5V3Qt47XpWn2?=
 =?Windows-1252?Q?IqvVTt6mDqFN1kT/xcQzG2VAQlYiFJPC+edtnBYFPPTdPjf8HCrNXQqT?=
 =?Windows-1252?Q?DFk7IrcXdgDYYKsdr55DP5kn+Z6fXtiGK6E4pLTaPta9DiKNv+BBs53A?=
 =?Windows-1252?Q?xBGi85VbW/l+vNqoviXqMHgsFCuXW6wmt1oTvNlccIQICbFMJtIQqPTu?=
 =?Windows-1252?Q?4FGhqugsr8ufNxLT6QHyKmZxDXDWHu0Iol1Jg9ZABw34dUbRY2Gzba/U?=
 =?Windows-1252?Q?q7gqqciaBQdV5ips0OL4KxcSmLXez2h3T1iVA1Poz9x3hFc001WSbVBn?=
 =?Windows-1252?Q?63AwFL7jd+jE0URJyMBfqGFmSbf/2AM11asp0klWLtHXnb1RRq86SKRq?=
 =?Windows-1252?Q?Wj5seGDJbjcBYk5m89j9MR+NgIp5Quto1705ZIbW4/ebeUmcEPzwDsA9?=
 =?Windows-1252?Q?FgvFMMD+cKJRq2i8Rh9GB3SGVF53P7vltJMo5tr7Y40KLKbgoDcUBJs/?=
 =?Windows-1252?Q?BZJppxPf69QYPUoVgfl/Y0yMTF1A1Y7CObki3M1s7Pu0TqzHcD1dmsUp?=
 =?Windows-1252?Q?rGTCmfeAHXmGZSkIsSrYErDluu4RrTiEA/UeOMDgX37lFx4nIDXIYHJw?=
 =?Windows-1252?Q?LqUum3zyGgXU6W3uA8CexAJYAqORa0yXQqIkQC/X0av3z2kX1WDxwBtG?=
 =?Windows-1252?Q?BBH439kNC/LmQ3G7/DxiEr5xk3NMYO9qTjneUOpmf7zAJsUvVatBP/SG?=
 =?Windows-1252?Q?+Y6SoWucQHyf4PKzP6UfEdO0NZY23KUlKaiBT+aqYgtf21iae5D/A17C?=
 =?Windows-1252?Q?3gAq3FmWiNk5ZgzFCNjgs9ZRXmQ+qvJ/hAhV8wyJ7QcEYN1ZEuH3EQsT?=
 =?Windows-1252?Q?V1hh4icb0eejhHk9tJCBqxjjLK3me3EGhTW6K9w9Q2565km5DHvGzODg?=
 =?Windows-1252?Q?3AC+LFZx40AbL9Y2lplHoB51nKXVMa26guRGb8IFnria9bA7kcz5iyYe?=
 =?Windows-1252?Q?TyeRYjVHOoY2TjzBumBcBtxD8fmUmQBCh/W5UMs1qTMOkRnZN5iKKWFm?=
 =?Windows-1252?Q?fojp2YcqA5Ay4H7QI9QvjlxKBUwY2srfbPFOAnFBXbcSpJBSbXw2rOFr?=
 =?Windows-1252?Q?WFgH74utyhO+OEoc2e20eoIjZRG54QuK/SbQS1Qlb2W784aL2JTUMMlN?=
 =?Windows-1252?Q?5O+y11e/KXZL6FywdWm1hAO1EhoEQ3GD9NhDL4A6VP2Qd+eL3VISB+yu?=
 =?Windows-1252?Q?a3/RW+fQEKlXgO2FHh8nYwafA40BLO+pdFEGhHY4PYqmakCC8YG8l+Hw?=
 =?Windows-1252?Q?pPpsSGHF7ucjhdFZ4LMPbVIp+6tvimbGFcj0LxAubkcBVS6qnfQG0ZvP?=
 =?Windows-1252?Q?63i12WjSOym65SsFym6ffivP2hhG/FpOJ86CQMCcTzsYM4bhx84kdSxp?=
 =?Windows-1252?Q?pr3/XEaF/9KWZboAGY8Q/vOgKxt20vyZMEG7T3YvsJDMmoBGPCPLxqx8?=
 =?Windows-1252?Q?Q5dTlcn7dGUrMvTx4atL6miXP+zyKUw0HdCSWt5XkcqZL1hqcadPg30O?=
 =?Windows-1252?Q?i8QUhW2vxJoYtOngWUCOk86dHfQSiW1+gAGmfUjUYTZRdDhZxt1Neg?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 db0da92d-e624-47e6-741b-08daa2dad575
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2022 11:56:39.3692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 Jz11egSqxWGJmmMN/hCFWsJr+6AAHRSik1iRgUGxekBPvmRZWyUWJciaSk448g3QI+VwCYSrmfM1sbGGSRGquTnPvsxzKuzv3MbQw8cdQu4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10859
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 30 Sep 2022 11:56:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9587

Hi Pavel,

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Chris Paterson via lists.cip-project.org
> Sent: 30 September 2022 12:37
>=20
> Hello Pavel,
>=20
> > From: Pavel Machek <pavel@denx.de>
> > Sent: 30 September 2022 11:51
> >
> > Hi!
> >
> > I have test failures all over the place:
> >
> > -----------------
> > 44Creating test job
> > 45-----------------
> > 46Version: Image_ctj_zynqmp_defconfig_5.10.145-cip17-rt7_411cd76b5
> > 47Arch: arm64
> > 48Config: ctj_zynqmp_defconfig
> > 49Device: zynqmp-zcu102
> > 50Kernel: Image
> > 51DTB: zynqmp-zcu102-rev1.0.dtb
> > 52Modules: N/A
> > 53Test: smc
> > 54------------------
> > 55Uploading binaries
> > 56------------------
> > 58
> > Uploading artifacts for failed job
> > 00:00
> > 60
> > Cleaning up project directory and file based variables
> > 00:00
> > 62ERROR: Job failed (system failure): pods
> > "runner-bwzp7ahx-project-2678032-concurrent-0pstk2" not found
> >
> > Initially everything failed, so I resubmitted everything, then three
> > succeeded but no more luck with resubmitting.
>=20
> Thank you for reporting.
> We recently upgraded the gitlab runner versions, but that was last week s=
o
> it's a bit strange we're seeing issues now.
> I've resubmitted a few of the jobs and as you say, some seem to work,
> others don't.
>=20
> @Adler, Michael, could you take a look when you get a chance? Could this =
be
> caused by the recent upgrade?

FYI if you need some test results sooner, kernelci's test results on the sa=
me code are here:
https://linux.kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Flinux-te=
st/kernel/v5.10.145-cip17-422-g411cd76b5afe8/

The history of all builds/tests for your linux-test branch can be seen here=
:
https://linux.kernelci.org/job/cip-gitlab/branch/ci%2Fpavel%2Flinux-test/

Or results from all of our "CI" branches here:
https://linux.kernelci.org/job/cip-gitlab/


Kind regards, Chris

>=20
> Thanks, Chris
>=20
>=20
> >
> > Example is
> >
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitla=
b
> .com%2Fcip-project%2Fcip-kernel%2Flinux-cip%2F-
> %2Fjobs%2F3109431179&amp;data=3D05%7C01%7Cchris.paterson2%40renesas
> .com%7C71678297f9c24981513908daa2d81661%7C53d82571da1947e49cb4625
> a166a4a2a%7C0%7C0%7C638001346214414952%7CUnknown%7CTWFpbGZsb
> 3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
> %3D%7C3000%7C%7C%7C&amp;sdata=3D3ABojWTs1UqFfSh%2F2ZkYPvcPX2pk
> 6zuOYQYJYGGm8BU%3D&amp;reserved=3D0,
> > I'm trying to test 5.10-rt release candidate
> >
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitla=
b
> .com%2Fcip-project%2Fcip-kernel%2Flinux-cip%2F-
> %2Fpipelines%2F654967302&amp;data=3D05%7C01%7Cchris.paterson2%40ren
> esas.com%7C71678297f9c24981513908daa2d81661%7C53d82571da1947e49cb
> 4625a166a4a2a%7C0%7C0%7C638001346214414952%7CUnknown%7CTWFpb
> GZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI
> 6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3Dq9behdYj1bp38YqpKXWk8nvt9
> UEvbpSnF7nC92W5kTk%3D&amp;reserved=3D0
> > .
> >
> > Any ideas?
> >
> > Best regards,
> > 								Pavel
> > --
> > DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> > HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

