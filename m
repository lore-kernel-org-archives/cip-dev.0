Return-Path: <michael.adler@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF31C433FE
	for <webhook@archiver.kernel.org>; Fri,  7 Oct 2022 06:58:12 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.73])
 by mx.groups.io with SMTP id smtpd.web09.1604.1665125885510896666
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Oct 2022 23:58:06 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com
 header.s=selector2 header.b=DPA/aRho;
 spf=pass (domain: siemens.com, ip: 40.107.21.73,
 mailfrom: michael.adler@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YfgyYLx4wF0PjXkLphnYWeQXUYS+IRflYLp5Eae7ec8zDJV3b4qzWoK9PtcCil4hvW6lk9Cra3zwRAotI0Bznydqtcwpt6XKwsoaW+w4pnfexyefQMJDEo0xY6RpylQk3h0aylv59R8CBEgDGid9+tuPoDAjKEVV/HyDQvHezw8RrUzG2dtA4HUCj5ZBKoIsJdaU0FnbUjmBqXhyAfnB/6EBoxLh7lGXUUey4+mDgU85kcie3YJDkHyaB+5dTxwRWeRUBQc3dJaBmkP8jdbkrF/1fVkEyh5gIIlNCNPzGrnmS8sqxQb5OCn2/rihbLGG6lQ/mOX2+ZR5S6Tm77Ur/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Hnhv9UN7lavoAN8Cq5HoHEtE8HAI1AdfSvM5dpGrOc=;
 b=cBbPN+EF5mL157wLJt9zCu3Wlvmzg3eNLI0IigYVyWXnr8ncliT7Fle6S6w/65oeevANokzkQiaZNCvflsmjLgFkW8GJEiajFeLkmXig8FTZy/QBb5PLdEuumbmjjUjuMdaIdetuYHLKw+YlAP7QBSrb4Vn3+cbIu50NBsrirYI+hLfMDCjKi3Kh9eB0ztduZGN04/myrW+Z7PJvhBDBwibdedB/Q1gvzSqgPPAc0sQNF9v0PtItyyTdTFZEEdsHRzkiG763P4GQPeONQYdn7LbpQIEFc/Lr+rpP+cNrQi67lzHNE/aB/trc0A1Xxa/5tZktRuZNANs4aZ+EU55U1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Hnhv9UN7lavoAN8Cq5HoHEtE8HAI1AdfSvM5dpGrOc=;
 b=DPA/aRhoMVkVwuV7IEfNlrgr2tqFXn3noY8UZBw999Ro2nvG8J23x5weglkXfZ46GtMGfYgI70DA0pcfd23IhWrRYxs+74gwTMGBYWwVlm8rXrF3dAEtkZvsfvKb8LV32iW4UlaH/1kOGNzmETsnUdlxHMpP1LEcNxzt0CwodbQfhqVUeve9dsfnhzvHAdQtZYhvRlzDZzOAruRd727GbpYP9xKdteEwyd+aqyoT61CCVL822qdMBiZ8pBW5JP4p7KhFRU5t0ViDV0g1cDswyuI8CIMNQY3dhmZ5lu5F8yGxN+cCE4L2O7ZlSo6F5CVv3vaRdSrm/9ul28ms0k//Rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by DB3PR10MB6882.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Fri, 7 Oct
 2022 06:58:02 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ac6b:22b8:6b19:8ce3]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ac6b:22b8:6b19:8ce3%6]) with mapi id 15.20.5676.032; Fri, 7 Oct 2022
 06:58:02 +0000
Date: Fri, 7 Oct 2022 08:57:54 +0200
From: Michael Adler <michael.adler@siemens.com>
To: Pavel Machek <pavel@denx.de>
CC: Chris Paterson <Chris.Paterson2@renesas.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"alice.ferrazzi@miraclelinux.com" <alice.ferrazzi@miraclelinux.com>
Subject: Re: [cip-dev] gitlab test failures -- job failed ... pods not found
Message-ID: <20221007065754.fysie7e4j2bvrvck@backstein>
References: <20220930105048.GA19081@duo.ucw.cz>
 <1719A05389EC9CB2.16804@lists.cip-project.org>
 <TYCPR01MB105888A4C268DD3DE0F5481C9B7569@TYCPR01MB10588.jpnprd01.prod.outlook.com>
 <20221004075301.etgur4dyb5dtrcct@backstein>
 <20221006115033.GB21855@duo.ucw.cz>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221006115033.GB21855@duo.ucw.cz>
X-ClientProxiedBy: ZR0P278CA0173.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::8) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB4734:EE_|DB3PR10MB6882:EE_
X-MS-Office365-Filtering-Correlation-Id: 048f3b13-c21a-437f-1a04-08daa83146ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	NVj0/+uvAbsAa7VxkVwgSx/6jjkkIvRsRN974lPVWbr9sdsobPZQZkh/O0AX34F9NiCgMMv5Xh3BnqvQFhXxSqYiQNZjzjv456aswRNxkdHssXGGaa2WhbH7hTiNJZiqLv0/y667N0kFe7tUAWc0yzsR9F7UgB/H4xp1+0ecULYQM+0Tk4EYD4xwcilbfuSf3qF+Cf7Mco5188tJ9jFA8fzyVZpneVNW3pKi0sDA0eeLp+7ZlNXk6cGlqEgxrzZuZ14j+iF33930Wofhv6D1fxHP1AJ3VFjQfxdGdgpHy8eUrqUwBozmXOyFVKcGHlQCm6H3PgdhngS/Io9DKDDPyQPuvPD5DT++jC78MGGAczkxnyH2t9jal9ZphFQBxH1FgtedHb87aXjJX5ANrr8Ca6IA8Wu/dyp8xseBzVNkaXlXojYq+9OOHR3f60jmHo0tqWjV5lpC64v2w8VVjs2RsHjzAVjPfHwM0QPQEO6QaKpvg8exUPJv6aNvmJwVNaAoZ06VjRIUGVUcVF6OzhqtX0ztWgVK1A8kxvQsaQTOdomG+euWgSRdEZ4jWU2xEzYsTs3IHzEWi7cpx65aubr5DQWy3WbLZJiWyRDt+B4ZtlJbGJXPdUZCZyhCikywhxLSNXsnJRIuCidUESd0sUED9Sg2kvC57bOX0NPF2puNn8CyKhhB+C2taX2hAmat3dKbIjTjf7bQiIwMuepzwoe83mf1ojEq+iLIdsE1EQb26TY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(366004)(376002)(396003)(346002)(136003)(39860400002)(451199015)(966005)(83380400001)(4326008)(478600001)(44832011)(6486002)(6666004)(6916009)(6506007)(38100700002)(5660300002)(8936002)(86362001)(4744005)(1076003)(186003)(41300700001)(26005)(66556008)(9686003)(6512007)(2906002)(66946007)(316002)(8676002)(66476007)(33716001)(82960400001)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?T6X28Xy+i/GHT+Qml3eHgNqo5ueVQbQKaIg3gqi6UoosulJji+bIqwojoOoA?=
 =?us-ascii?Q?Shq7KqGQ1ukfwKhKWzT09GIoaJGYeBax0Wuc/os/NqzlIymr29uXmb9dVGIX?=
 =?us-ascii?Q?VKMHM5903r+nLObv8qKst2sPZ+jkP5f2HJp2AN4xXgoiMyoZE2vM8Oe/Tn0T?=
 =?us-ascii?Q?DMOfqkoM3rBHaK/p7dETHBYtp0gzGdNnFLa521LLMMLMZRX9febXO+B3JZmx?=
 =?us-ascii?Q?yF/yGQW55qa9YFRJybmYqJEXQXle6BKeMZZnwF4H6iFBE9MEVyLQUFe+Ez27?=
 =?us-ascii?Q?jn/II4pn5Hr2HziHmFUoTuCCc10x+zB/hfX2Za64eA2RWx6X1d4SVfqMgYrC?=
 =?us-ascii?Q?Yo/3xK9QmUIVUazP5MJ9ujMiEkJ0W+Nzej10UUdzCjp/rGVQ8tEuXiTyMhVY?=
 =?us-ascii?Q?Fdi8/sfIb5VIhx8Ddbwgug5j8TOwqJIWWXNJDEG1573i1KM9465UGRl8Mw7Q?=
 =?us-ascii?Q?V0SiYHmRvzeGtRaS6mCwBqqDq+L2COzf41AoLia8jGOsNbmfAdhd6n5zciVe?=
 =?us-ascii?Q?vVyY9gp5ovYcPczN1hczpyuR+XLkmBLeKQcDCQMgegcyBk4FIW1eIFRlf0CH?=
 =?us-ascii?Q?mALA5J82kAsZxj+syFI/GPDQ5HAzaQvr6JYzzhNgQBwS8wHgy0cdW2QcVOJ8?=
 =?us-ascii?Q?pky8YWoQjfKEDrR5gToxn2NIf0MF/CG/bQZnd4uP0hCs24gd58isQ1zSBRM0?=
 =?us-ascii?Q?wGTozAgWVqCCjWrYiBSGP4bbTi3b9WgtqtT93BvBPt/ut13ZepdWvm5nqzCJ?=
 =?us-ascii?Q?hVBPbjah7ssZAWpPPG86e7MemQTSX/v8iR4lZsFc9+QsdFtw1gbK/3h9oDNS?=
 =?us-ascii?Q?7PSkt+/JPL4/+vaZ6DL5EEWW2LE31ohGetqtdtk05mZU5txn57YHQcBAg0le?=
 =?us-ascii?Q?LE8rwSx/Dd1QHZ2ymrWN+zsVPks5RWxRQehG1JJyrd7r3s0fWKSM/F7c/8mU?=
 =?us-ascii?Q?JycKx+QkU6/vV/aM5DdwzTHjhOWjpcL4/LxWKdVC7NRjwq9Kl+hPYeZ9rgo7?=
 =?us-ascii?Q?TnqjJ17IHqt5gmEbbU95qaPZYDVIpZNQx2zd1TNrWUxNzJVUE6exEyFi1/SR?=
 =?us-ascii?Q?ynlzy8tkWYPTERLvoHKDPmV2CxIy8+ONAi+53oXrWCpmeH25GO5hlFJSjnYf?=
 =?us-ascii?Q?J3fa7I3chkB9IGYxOp4kv39JiRsX1FFGV6GD313VWpyYmozUj9mGYumz4t3Z?=
 =?us-ascii?Q?9J7I75J1BENNQgxmFsXzhVKUkLpH2TO10Jfv5ilLFrk/XuiexJbpnQkj8uso?=
 =?us-ascii?Q?n7rcpUkWP9I7WGF/WllWsn6APplWA2CGnEsrKHJ8p9XqHy+XAndzzyk96d0j?=
 =?us-ascii?Q?ITeHZTGH729xwRGopxI1ZwnJXduewWCZ6lqL8Uk+fuU4Rjqg6NqcTMsXABnH?=
 =?us-ascii?Q?BsXLLcgrwoY1IMim5ljJ1bYQT9YbV2AxG/hZJS7TL6RnwW8xcOL8zE7Zij0n?=
 =?us-ascii?Q?7xDbwRc0JHGsGb9+IC0uxnEZ/zTQDFxfVJlPw0JyY7QW+YA6o99N9+Ztyfrk?=
 =?us-ascii?Q?ewONNoz7f3G8uSXahLarrK7jbogTvesuOv34L0HNhrqJ+U/g94tfWPv40MC6?=
 =?us-ascii?Q?uK5QFxTmCBVFsw5q8Hr70EBf2YQX5xqWoGdndS6OQorXnH5s3jem+fBqMOPV?=
 =?us-ascii?Q?IQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 048f3b13-c21a-437f-1a04-08daa83146ce
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 06:58:02.2216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 bZfAS71t7GFV4RiQm979kNJv8AskAzlgOIhM9ljO+BpcoaVUWQNHnRibA8ooxiVuUozfYLrV6yCypQgQt0WvNlTg9ODlDB95TLxPiuO9UWw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR10MB6882
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Oct 2022 06:58:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9666

> Still there, I'd say:
>=20
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/3123103311

Ok, I have restored our previous cluster (v9). Please try again and tell me=
 if the problem still persists. If it does,
then I'd blame Gitlab I/O otherwise it could be a regression somewhere in t=
he K8s stack - in that case, our best bet
might be to sit it out.

Kind Regards,
  Michael

--=20
Michael Adler

Siemens AG
T CED SES-DE
Otto-Hahn-Ring 6
81739 M=FCnchen, Deutschland

Siemens Aktiengesellschaft: Vorsitzender des Aufsichtsrats: Jim Hagemann Sn=
abe; Vorstand: Roland Busch, Vorsitzender; Klaus Helmrich, Cedrik Neike, Ma=
tthias Rebellius, Ralf P. Thomas, Judith Wiese; Sitz der Gesellschaft: Berl=
in und M=FCnchen, Deutschland; Registergericht: Berlin-Charlottenburg, HRB =
12300, M=FCnchen, HRB 6684; WEEE-Reg.-Nr. DE 23691322

