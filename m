Return-Path: <michael.adler@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8842DC43219
	for <webhook@archiver.kernel.org>; Fri,  7 Oct 2022 11:56:24 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.40])
 by mx.groups.io with SMTP id smtpd.web09.3562.1665143778162527499
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Oct 2022 04:56:19 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com
 header.s=selector2 header.b=jDJJTzJH;
 spf=pass (domain: siemens.com, ip: 40.107.7.40,
 mailfrom: michael.adler@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aPIbmSAxs2RVzNsGjc9teGb0yksOzdTZo5deLLgwlP2xJP2hy8vblK7IJ7gbwGlVnbm9wfGii829d/9AsnJRHnJNLY6a0jDF4vcy19OZpCm7lG9Ay/7PnCP44ggni925h18NRA3lEsaG0aVWHhvKnBai4B+Ptoz46zQxwFBrt8lOLzXXHNiz4Pa+lSdZPSP3vMe2lfcvxxGMZuio61FKBgIvD3gQVWrKC+9l/sx/Vuj2aCvFPongQVZ9dE61YTjO174gqpnuvCtEmnqPoT70VhMVvmx6I4Zjq6uopLNGbowhD31WveISm0kKHdA6SMyC8u0GlbYLI+rVF8snV0TlEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/subM4zzNyPnEYEPmrAvqU192h0R0LS4g8hmIHsL64=;
 b=YhRFPpvtdeGUklOVDO1TVhEWx4Yl8WJ2UYwDk14cveBOPiy2cgMp3i81DnW9CGtPM7QR0cFyNxP3/+CvWypcEYYqQzhXHPMM4jomJuaJscM+tvkWCqIbB0lS5sgcAYja0tGSiWXidy6gphW97Nki8iQyVsWoxdHcatOPia2HsMq6ektIo6LkHdcJJ2QIreyWkQknU5AlvHo09pJHtPC3EgGyvWBdw1qfFruTBmu4c9i+pJopLxzpTRETgLyGySblB/2W1JK1snSYiECmfZbTQMktSde6xoY66NQHc6U5tckob/IHZ4gIeNvze61+o+w2LQbB+vs5tFhKGk9T3y3xGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/subM4zzNyPnEYEPmrAvqU192h0R0LS4g8hmIHsL64=;
 b=jDJJTzJHKXQqwsL7GEgeTzDIYNiOjTd/7Biw9Ma84YiBipE1uJFDCX4u2eNUIWah5MJa+TNwTq0+RGZ1LOb6Dd8tWxgoKUDY0BdFdjgEjyUXrcHoIEXbb3tJI4ZlCsKUPTQ8bCK9mT68UC5qvddahgzRjsMI3UpslDLAI0hfLR5BPVm44ievjS9wxMuO9b+RYTmPcsDbwzKzezviVXHDCvdNbpwHHMvJtGkN4M4j2bichDo4yPs+i4n23whXifTN1j/s2kN9gmXo7tlm9TYMS3Vi9XlD2s9cttZSXd2G1tdnnb69zMeUO/4YpVr3mZBQr7+qESXlGZKOib5vsEvqGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by GV2PR10MB6718.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:b6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Fri, 7 Oct
 2022 11:56:14 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ac6b:22b8:6b19:8ce3]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ac6b:22b8:6b19:8ce3%6]) with mapi id 15.20.5676.032; Fri, 7 Oct 2022
 11:56:14 +0000
Date: Fri, 7 Oct 2022 13:56:10 +0200
From: Michael Adler <michael.adler@siemens.com>
To: Chris Paterson <Chris.Paterson2@renesas.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Pavel Machek <pavel@denx.de>,
	"alice.ferrazzi@miraclelinux.com" <alice.ferrazzi@miraclelinux.com>
Subject: Re: [cip-dev] gitlab test failures -- job failed ... pods not found
Message-ID: <20221007115610.b6pno7i7rslwqeji@backstein>
References: <20220930105048.GA19081@duo.ucw.cz>
 <1719A05389EC9CB2.16804@lists.cip-project.org>
 <TYCPR01MB105888A4C268DD3DE0F5481C9B7569@TYCPR01MB10588.jpnprd01.prod.outlook.com>
 <20221004075301.etgur4dyb5dtrcct@backstein>
 <20221006115033.GB21855@duo.ucw.cz>
 <20221007065754.fysie7e4j2bvrvck@backstein>
 <TYCPR01MB105886D9FCFBCD0D2338B3037B75F9@TYCPR01MB10588.jpnprd01.prod.outlook.com>
 <20221007092700.itoos26inn2uz3gt@backstein>
 <171BBFEDD39FD303.15379@lists.cip-project.org>
 <TYCPR01MB10588FE1F7EC3378E1C42AA22B75F9@TYCPR01MB10588.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: 
 <TYCPR01MB10588FE1F7EC3378E1C42AA22B75F9@TYCPR01MB10588.jpnprd01.prod.outlook.com>
X-ClientProxiedBy: ZR0P278CA0031.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::18) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB4734:EE_|GV2PR10MB6718:EE_
X-MS-Office365-Filtering-Correlation-Id: f7d598dd-cf09-453c-7039-08daa85aef8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	fp86NuQaCOG19vpwJTDBmvksUA4eQNAas56ectGaPP0bqPmInSp3E7sSKT9ewbAUtD/GYS6byYnKPkncd+voVQxgIK03Z4dLu1f0ZObRyORvmmhphtUj7TvQcQJZ+tLCiogBiab+JeFkvQNmlGODyomy8oN7cRy/hAXnCP2117bP4Gl+3FdMwL1Y6L8O4caFDF1BSOp/joOxfKngtwafgAE7RJjcas7W+ewG/K9IWDswedNQX6FyQvFqbZoS7KTX7JkCIy46IcpNTKRPiTr4o9GLs44970RaL7RULjKBvKJA6331OeMNdmt47EJsWyxVxWHwOSDma9Phcxz3VuU4bd7axX8QS5EaaTD/eMDJw3Dx+z4CDUmU6A/yzyNh+fkh6ySjS2zAwONYGQmqcEYzkTYrkgO+v6z4pBqdiqCQGxR30y4bt6AoCmuQZP2i46klxMaKYA8S7CTZmvglWa/7PkImAIfZ92zd3dCz3c9xKbZ2aonshDf/2DQh3SP+byyknMWdtgLZLC/vSb+TSjHM938hWCYNpY6JaqrAiH0FxrmSWM0qwepWtCWs0LYZmax2HSFX85Z3DteCwxgqKuJG8jT+Jz/70SSCp2ZlH1kQI6C4mh2hiRSqqwAEeQWepyKStdkOwumoUtHcPQ9ivdeO7XjIh7d5aKl4wIMr0yg0/4HeEye1UJvHW9Pf/90NG7n7rqSZcZsorvA3xuO/Wsm7iGTQcM31JMxjG17PIvQPD14=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(396003)(366004)(39860400002)(346002)(136003)(376002)(451199015)(54906003)(26005)(82960400001)(44832011)(86362001)(38100700002)(1076003)(186003)(83380400001)(6506007)(6666004)(9686003)(478600001)(6486002)(6512007)(6916009)(316002)(4326008)(8676002)(66946007)(66476007)(66556008)(2906002)(33716001)(8936002)(5660300002)(41300700001)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?HjqWPMS33UTxZOJ0qPtVZdBmbpvsUnCZNfd4tW3Qm0vX6E8AfnyrhFLjQN5Z?=
 =?us-ascii?Q?MeBctkrBqY8z6ulNi6wur/+K/hhMcRoNqorIROLMp83ayHJytn8xRHRntysv?=
 =?us-ascii?Q?szqXVfK35ss6e0EzJnhwHhEZEpksFKPMPy3wuaCq831D8Rt3knN40CifYRzY?=
 =?us-ascii?Q?8d+tq9ojpL4X+7AIPA6mRxDeoVLemRjilEkZsj3z7x8lcvWxSC3pRHoRQVSW?=
 =?us-ascii?Q?GatrhkjeOvdLItrDaI8ctg53o9WQUlYHIYJDB3b9jdYfC+aO/dtBH2gX6pZJ?=
 =?us-ascii?Q?Uaf0N+SNoco/5unBuZtNYMW2LKx0KusAZQ7Z/HEkDi66WexeVVvfnODGeLJE?=
 =?us-ascii?Q?Ga1GMpcrqG+mQ5Rjec5wJrU9IDFx4Ujyz85oDB8/x74eb8a/YeP3q81z/x/C?=
 =?us-ascii?Q?s0STlODCEAvre4tNydaEteWsTAEeFiPCZ132N9uBg5FGf02f+q6U0C3lTb4W?=
 =?us-ascii?Q?HMuJjJ7DAyNuszdfYeESuJg7PQB2IHXWyK3U/vfsFipUbDH4PLd+c/tXlYl8?=
 =?us-ascii?Q?KgyVhDmZxgiRYqXNhVFFCVgCrkK/SxUOw/8aTDjCncGEucBuUQftnRSYe3Zh?=
 =?us-ascii?Q?U3PosHXHN0ATQjfFiltxYZDH1LAcZDvXacOgZAT8+UCsVWbqEeAG7fM68VpL?=
 =?us-ascii?Q?kupRLeGjyFfoKSbMmgmlwylrb1/Xsvo0l8Qeux2tbfU9amigf0tTkucYshe0?=
 =?us-ascii?Q?4lwF7jwejsTMchf285Ul6JzzNXnEEBlkAqPn8jz/twHSL4mzAJWx6/dvlibC?=
 =?us-ascii?Q?5kkMI/bzwX1Y2rw8MdRCmVvsJo37APpfmpVcyRPfnhn7CjBIMuDmoeW6AmLD?=
 =?us-ascii?Q?dZriQqVL0eI5jAwRAuUh8gIl7lZQ5Wr0Xz9P5UGkzupFKtH1Io8jqMy7L588?=
 =?us-ascii?Q?skADLesxMzQnarSoWEZHu5M52e5AVKxBaIWQBnJkEYwleRwHL3+R7c2opq0j?=
 =?us-ascii?Q?4mBe5k6D0RJPn2eJhbivyJ/z/cgWl2HLPS8pxkjPcdAXV4lKgencqTk6mEz/?=
 =?us-ascii?Q?kye5VMd6kxF6d4ELoKp5xbACXcTLvQ6o/N16Ga108kpPP3PGNWUdWGYxlNvp?=
 =?us-ascii?Q?sgGFLBk3RFicNK0Q9rmfNIlgvtLYtEiPAaaGZ8Wl4sRyIAwVGL/2stria9va?=
 =?us-ascii?Q?ORpod2PNAquW2QmhvxdOJCGa2LDgkYnrhHgx8dOQInaxEZJQNv1Oq1dlU4mZ?=
 =?us-ascii?Q?GgHuHFRkFkCqnGLAASSWtwX1c4JnTcxeKU6g1MhU+plPkZ/cQ08vtTgrz3AQ?=
 =?us-ascii?Q?CDOW1GjaDWpe3o6vU8VIBLisCd4WvLSYnJv/DhwXehCN/aA62w65qc6VIPv2?=
 =?us-ascii?Q?BHr8+r3lnXY1LlvzAJMrYb21JvI1zs8YTdMTBUCGSgMNrif7tfrIxWSpAS4E?=
 =?us-ascii?Q?xluDFkmTDZ4CYnzbcjqFI9q3D7MiW/QwhHUmTqbf26W06anAxNYhIAG3xdkj?=
 =?us-ascii?Q?nrNqdAjI2AGYmdJ8JbF3P01KlCawFvmPsLx8PKH4Sh6ElJ+6nvbbqzY/LhXH?=
 =?us-ascii?Q?OrSUWENRRWnDEYcMeX4cm+Oov+tXvWqSgajMOGB1V/AkmXpn2z5pSxKP6mXe?=
 =?us-ascii?Q?5+GSNae2PtQlBwjqXfUrfCuWMS63080z5JldX0JLURP1xHfso/jtOmMUBSuM?=
 =?us-ascii?Q?Gw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 f7d598dd-cf09-453c-7039-08daa85aef8b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 11:56:14.7168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 XvvaQfQSqHLZAFuZksmVhztqNbHC97hcnNiP8Xakz+qK6aupY+c+co6z3o//70PUgMid69uBNHD7t5smfXuWAKm8zCGV+/X6l+HqbU4LVko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6718
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Oct 2022 11:56:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9687


> And indeed it seems to work fine:
> https://gitlab.com/cip-project/cip-testing/linux-cip-ci/-/jobs/3141334688

Good! Using shared runners saves us money as well. Is the performance good =
enough? If that's the case, I'd suggest to
use them permanently.

> Working version from above is gitlab-runner 15.4.0~beta.5.gdefc7017 (defc=
7017).

Hmm, that's a bit older than the latest released version (tag v15.4.0). I w=
onder why they haven't upgraded from beta 5 to the
final version? Seems kinda odd, I would have guessed that Gitlab does CI/CD=
. Anyhow, I have upgraded to the officially
released version (and will purge the 15.2.0 runners once they are idle). Co=
uld you give this another try, Chris?

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

