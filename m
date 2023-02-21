Return-Path: <christian.storm@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9031C636D7
	for <webhook@archiver.kernel.org>; Tue, 21 Feb 2023 21:20:29 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.52])
 by mx.groups.io with SMTP id smtpd.web10.54710.1677014426478893239
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Feb 2023 13:20:27 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=hGw9C1vv;
 spf=pass (domain: siemens.com, ip: 40.107.21.52, mailfrom: christian.storm@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=USeYc6r3A7hepStq7UcVBvaaPd5pF7+jFINb4A7AQxkfKOzLV9gd7lF+cP+jC8tVteFj8SynhzChUT72V+kzO8BTz/28FFZH1gs1ldwIzB81BHuMTuFhliJ/63WwaBcukHM0c/nJ7c7aKlqOBLvAe+pbFjzUTxf9VcO/5DQB3Zy6QsDkvA/cSiS3g7rHTeLe8gl61JSKFxNAHZ0H/elFPmgNbZPVQc8bCczXTuxz5ZDDgILEzHx8DRQ5+1okkpzz4VqOMyTRJjBi7hFtSj8imUDmQBdrqVa51YB/E/2sXkB9KbUR1EclToxRn+mRVSY6LkLtBiMUSzglGPiWBubR/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rTdunXAsdYaDEb3p1G5AJL3D9c1am+iIoz1MEkqArj8=;
 b=np3t87V2uM0RGBevM4WCLbYc3ehgSaj2QadsRUq33Qevq4Tm14TTE1hTuZupi4PlVlejUOpLubbPf5R3NYBj7LcKkrqolw1zBINXgpAY+cmMQt8ElP/Uogv3+te28cuIctBnSPL7zu7dbHXkBigQswGIs+4EWztWRXv+gLAWoEUsN7jP7uwhiukzvRVnsMclbh+kDtp+KEIZIhrxt3TsklaFH5bC7DtAJMeqBWSFc2hE7XF+b4x6bauAd95W+VzgW3zX0Z6oabV3Sn1hFmkdvubcHVRvUye64oU/adqBMMGIa72pNpYzPLn/7QMC50Qjv0foQ0gT+CwwHQPpdidcIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTdunXAsdYaDEb3p1G5AJL3D9c1am+iIoz1MEkqArj8=;
 b=hGw9C1vvmcKchcGytgFFW49lVn4EViiB4H6c9Bb4mZhK2/oRgV1vTIyVAAnUCpN+e6/WzHgnlKjUOS0RpilmlWTasfheDPLPLicAYCqSNNt8HpBobGVowAKaG8V00WEnH5DrEmJeilRkCbXJo4PQYktYBVHr+lCx4RgnX6ye6ExxuMNT3iqxj+gp9lFLnWem2lzmccs3D2jgxY4V0jO0hJoD9IBLeFSABhdssQixlcDfBcikqtZG6ku1RXdul79nDa6b+UwLBVgrUO7xhSozm2pm9Ysa5aCFMHB8ziLf7HLRxtMruuVVjFt0QbrwsQIXmrrqprsnMfHOR4/oM0RiUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS8PR10MB7042.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5a9::19)
 by AS2PR10MB6662.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:55d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Tue, 21 Feb
 2023 21:20:23 +0000
Received: from AS8PR10MB7042.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2b63:57d3:f411:7d1d]) by AS8PR10MB7042.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2b63:57d3:f411:7d1d%6]) with mapi id 15.20.6111.021; Tue, 21 Feb 2023
 21:20:23 +0000
Date: Tue, 21 Feb 2023 22:21:25 +0100
From: Christian Storm <christian.storm@siemens.com>
To: efibootguard-dev <efibootguard-dev@googlegroups.com>,
	cip-dev <cip-dev@lists.cip-project.org>
Subject: Re: SWUpdate+EBG: The impossible state and how it's being handled so
 far
Message-ID: <20230221212125.zdic7daabaa25ovk@cosmos>
Mail-Followup-To: efibootguard-dev <efibootguard-dev@googlegroups.com>,
	cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <42568352-ea72-0f41-0944-fea437f01edc@denx.de>
X-ClientProxiedBy: FR2P281CA0076.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::18) To AS8PR10MB7042.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5a9::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR10MB7042:EE_|AS2PR10MB6662:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e956868-83fd-443c-43ca-08db14517174
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	E8Ge2BeonGPyhWjd86dtXrWNPAQJfjAsUddnT2VvQgnF8UdMzJawzzhHyU4sOavKFl2o0nQdcTP6l3Qe0BnJsj3UkG1wZMJADSFtWQibLRwKTiTRU7nG6F0u3915lpaVtYCoHsArHBqZCiQkOrDrXN8UAIdcdPVHwGUuLUKpeTB6Ukngbn5vqB4hD46Xh3aBz2rgENz3DtJdbUbBWb8o8uODrwlBNp7VJF3QXUBbTLKVEeOd/PiNCVS4eI45GyK4G0eM+fUOkTS91Wr94z0WYXQzTN1QyrNYRR6khH6wWGeykbncC/+lm2s2XHWTkPrN20ZofAlsDY4jeQ6WxDpwSeG/sspWYaQJqq4X68C6ZrUMeF95SanS8hO2owpFujgPKl9XSQt5VcF+FUKh8wDxAXN9SA6gMv4nIudeaW0zysxThwjSf+UB8YPK4MVMmSjBnvxfTIX9+uHcHetErC0+O373HdFjqUhoIgzKinGQ1GtlukeSgqeifmgL9SSHMzqGhrjltUeiBMKL5o6B3ukhL/6miUMqAbRktZg2+N9yHj6fxpEB2mKgLHkCyXzJUyRRVg40o6jnLXwtfG6ybsVLkVRWV82u4q0RYLg0lgLzK9TeRMYVqvszaiu9MttoCqwvFivnUVdmLgUNJA5jHY47ZA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB7042.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(7916004)(4636009)(346002)(366004)(136003)(39860400002)(396003)(376002)(451199018)(316002)(1076003)(8936002)(33716001)(44832011)(82960400001)(66899018)(5660300002)(86362001)(478600001)(6486002)(186003)(6506007)(2906002)(83380400001)(8676002)(110136005)(41300700001)(66946007)(66476007)(66556008)(6512007)(9686003)(66574015)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?8oLsrKZpH5tWeN8dQ7BO7o7+qGB0/y2Y1M4+N7zkC0l+GmRCsx6+0meMx2jI?=
 =?us-ascii?Q?gjyoyYQqV9vyBok1xGkyJSLzM/M4M94zwziwqXY+ExXxgCA/6Z2zPvjyRTir?=
 =?us-ascii?Q?mQgxBrI65oDersXwzooxGJFwYAQV9TqIMIxZL+zjRS//IgKZftP8zmM/mRfi?=
 =?us-ascii?Q?pPvjp3xWgF5OMffw2f9EzdGksYPtvza5GyLsoRvRYksyE5YTgsEN0rQ80vbe?=
 =?us-ascii?Q?AidiKZFxXMjsut5ET9S1CT8GwEbGqwmU6wODJuKjLq3k38REO3MimhJI88BR?=
 =?us-ascii?Q?a9IyD54WGAXSCRJIR2NR7DP2T1g2Ncn9XlvwC/bEPtog5HY9aWKFonLZkfJt?=
 =?us-ascii?Q?TTvVuGPZfWXKyJdQBjrzo+clz+kIrRReFqyq2oP6F3e6i49zGDIp4dFWJd4x?=
 =?us-ascii?Q?Z5FHfoIL0RbaQZPrnV3e/K5du9+uZ7n0J/szpCigl+bcB5PfVGvMsTUH1tAT?=
 =?us-ascii?Q?rX8wNQ5ZuSCKongJbuU0M8hAhydI/tqUgj6t7xne02ztKvICtefrkEBXldes?=
 =?us-ascii?Q?thOsS7Qkchma84uzgb8xCQtdtNiyibN4///pj3X4+a0AeT5iJqN0NHDtOqwk?=
 =?us-ascii?Q?gxwBc8EU1j2SGfwZ2VHFN7G7bxNQluB8SSkHkdHkLlvQiCyNfKBEIZrLVcO1?=
 =?us-ascii?Q?blaEtfTKWgxlQkbyNOx5cQt7FSFxaZ0iD/I1vfc80/da2h2AQ8etMR/Y/FO8?=
 =?us-ascii?Q?Q/fPkFJLqQtpsq5b3RevNbba87eEm6I5Et05UXE2hLT9NABxfoBnF3Q48cut?=
 =?us-ascii?Q?lTpk8Wx8nmxNAxjNE/GkleJHHeUr39V/TaOcmpuPfiv3xttV6jxnTDBgOuC7?=
 =?us-ascii?Q?2V4oNDHWGqIHYBbXo1z4iVUEaL77KV8mA9BSZR9fv9Oh9w07AugMcEbdMWyY?=
 =?us-ascii?Q?tGgFZtDCUDBbmNma94v7xZOxDmM44Ni8W733fO6WmUuX/YREpBOCDuXeZrzE?=
 =?us-ascii?Q?TgtsHsjSxQq1fYZGNxNTfmLlYViIt/V0GzcFsqctm9CmOLY15x1cTnJiHfrU?=
 =?us-ascii?Q?vP9NdSK6iCdSZyNlYOtKzfph/vEh/MwK6Xo5KpkB9t2lHIwAxZ7qwIt+xm2z?=
 =?us-ascii?Q?X21IpyheBfeRsdrAG2w9h0WWp4l4cv6HPe5sqCMJGBt29jhJK109hkXGu40r?=
 =?us-ascii?Q?v7OboePokY0zBIlTEClGRNbR7QL57z5MTl4b0YQRrKRr5/VF68U418Ddqizv?=
 =?us-ascii?Q?OgscfPnH1r4Uyr6P5nHfQTwIT+tRibB2EJTvxCcqA7/Vpy/SEfTKFS2JExW9?=
 =?us-ascii?Q?djBNqZRVr5uagpBkrJE/RQZVx3woWdU/4xz89YxtB2JaI/UDqEcVAtN570xD?=
 =?us-ascii?Q?o/D9g8+HiqiwktwGG8edF3jt4sBgNjjz+iSps0whJfKW5g3iYfVIAUbEiskX?=
 =?us-ascii?Q?yVGQFv1qAoBgjxYiY0+aBTi8Vmx/Y75/EWqHwZ//MwxNEiNgKD+R4/8wG+lD?=
 =?us-ascii?Q?GcZg40ZAm/UclnZvMEO6VoEl8AAhAFvT3ITPEXY3cBGVXyMqME9oUbhtwmFU?=
 =?us-ascii?Q?BDzW//e3Mz8KmOmP5wAv21hXCTveQpNXBbIUsVPrka93EcpKAjTD1lLjn0Sy?=
 =?us-ascii?Q?/kDgcd+ag6/Sm2YVjI7JvBFkJxue2R/chgr/vmZYfvgkbUXWxGa5f1EXS7uQ?=
 =?us-ascii?Q?IE1+YVullH7NToR+BmlJwabgeCFQ5poIFaFBoBuKYlrZzUfKirMI2ZE1AfQf?=
 =?us-ascii?Q?0i0hhw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e956868-83fd-443c-43ca-08db14517174
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB7042.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 21:20:23.2814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K+rxw2cd7F9vGD154ffU4Yke6DBnnIbvGuTZ2SIn9LyPkaLhcTON5b8oNgw8sl5cr5p4Vmy5rov5EM677n5/iQDVWr303iyVkIyz2wGIH7o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6662
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 21 Feb 2023 21:20:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10764

Hi,

> > > > playing with updates, I maneuvered the EBG envs on a system into th=
is
> > > > weird state:
> > > >=20
> > > >=20
> > > > ----------------------------
> > > >  =C2=A0 Config Partition #0 Values:
> > > > in_progress:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 yes
> > > > revision:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4
> > > > kernel:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 C:BOOT1:linux.efi
> > > > kernelargs:
> > > > watchdog timeout: 0 seconds
> > > > ustate:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 3 (FAILED)
> > > >=20
> > > > user variables:
> > > > recovery_status =3D failed

Hm, did you start with a clean environment and SWUpdate >=3D 2022.12?


> > > > ----------------------------
> > > >  =C2=A0 Config Partition #1 Values:
> > > > in_progress:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 no
> > > > revision:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3
> > > > kernel:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 C:BOOT1:linux.efi
> > > > kernelargs:
> > > > watchdog timeout: 0 seconds
> > > > ustate:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 2 (TESTING)
> > > >=20
> > > > user variables:
> > > >=20
> > >=20
> > > I see - we should *never* reach this state.
> > >=20
> > > >=20
> > > > To get there, I started an upstate with swupdate and booted into te=
sting
> > > > path #1.
> > >=20
> > > Ok
> > >=20
> > > > But then didn't confirm this update and rather started it
> > > > again, using the same swu.
> > >=20
> > > It looks to me that this is the point. SWUpdate requires to close the
> > > transaction, for itself or for the deployment server (Hawkbit). If a
> > > system boots with TESTING, the glue logic should start SWUpdate askin=
g
> > > to close the transaction - with OK or FAILED by passing the -c parame=
ter.
> > >=20
> > > However, this was thought to work together with the deployment server=
,
> > > because it handles the state machine on Hawkbit. The parameter is
> > > ignored if another deployment interface (Webserver, USB, ..) is used.

The suricatta modules handle this for you =E2=80=95 as a "convenience" feat=
ure
and to keep the (hawkBit, ...)  server's view of things consistent with
the device's, which is more important than the convenience aspect :)

If you're running it with other modules/modes, you're on your own.
Then, you have to play along the (convention) rules to close the
transaction as there's nothing preventing you to get into this
situation with EFI Boot Guard.

Hence, the valid question whether this should be allowed / denied by EFI
Boot Guard or the tools (SWUpdate in this case) making use of it?


> > > This is managed (again) on such situation on glue logic, and the
> > > transaction (that is set of ustate) is done before starting SWUpdate.=
 Or
> > > in case of U-Boot, it is also managed with the help of additional (an=
d
> > > custom) variables.
> > >=20
> > > In your case, it seems that nothing is done at boot time, and SWUpdat=
e
> > > is started. SWUpdate does not know (because it expects that someone h=
as
> > > already decided, and ustate is not checked) that a new software is
> > > running, and the same SWU is loaded again.

Exactly, here you're on your own. You have to instrument EFI Boot Guard
so that it's happy... which is convention and not enforced, currently.
Granted, this requires a lot of context knowledge how to integrate
things properly and seamlessly...


> > > > That didn't complete because the UUID clash
> > > > was detected. swupdate terminated, and I was left with the above.
> > > >=20
> > > > I can still boot this constellation, EBG will select path #1 (endle=
ss
> > > > testing, so to say). OTOH:
> > > >=20
> > > > # bg_printenv -c
> > > > Using latest config partition
> > > > Values:
> > > > in_progress:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 yes
> > > > revision:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4
> > > > kernel:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 C:BOOT1:linux.efi
> > > > kernelargs:
> > > > watchdog timeout: 0 seconds
> > > > ustate:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 3 (FAILED)
> > > >=20
> > > > user variables:
> > > > recovery_status =3D failed
> > > >=20
> > > >=20
> > > > That is not quite correct. To be fair, bg_printenv deals with an il=
legal
> > > > state here.
> > >=20
> > > Agree.
> > >=20
> > > > Still...
> > > >=20
> > > > The key question is where to avoid best entering this state in the =
first
> > > > place?
> > >=20
> > > My question is why the transaction was not closed before running
> > > SWUpdate. This is a common pattern even with other bootloader, but it=
 is
> > > more important here because EBG stores an history (well, with deep=3D=
1) of
> > > previous run.
> > >=20
> > > SWUpdate can check the state when is running, but there is no general
> > > cases. There are use cases where the OK is coming from the applicatio=
n,
> > > and SWUpdate waits via IPC the result (but then SWUpdate is started w=
ith
> > > WAIT option, and does not try to load a new SWU). So SWUpdate cannot
> > > decide itself that TESTING is a wrong ustate, because it depends on a
> > > single project.

One common pattern is to have a "health" target and once that's reached
you start SWUpdate with according parameters (or set them yourself via
some glueing method). But again, that is convention, not enforced, and=20
it's currently the responsibility of the system integrator to get right.


> > I was running swupdate manually from the command line. No backend
> > involved, just the desire to intentionally break things. ;)
>=20
> The best way to reach the goal...:-D

If you would have used suricatta, you would have missed this :)


> And yes, this can happen because the part deciding if previous update was=
 ok,
> is missing. In most projects, if system is up and running, it is consider=
ed
> ok. That means the decision is done in SWUpdate's systemd run unit (or Sy=
stemV
> init script), see also glue logic under /usr/lib/swupdate. In some other
> cases, update is ok only if application is running, a migration of a cust=
om
> database was ok, ad, and....that means is outside SWUpdate. SWUpdate supp=
orts
> all these use cases.

Yes, that's the codified context knowledge. Still, if you miss out on
one thing, the whole integration will crash and burn. And it's quite
easy to miss a thing...

The question is whether there is a generic pattern like the "health"
target I sketched above so that SWUpdate can handle and abstract=20
the bootloader interactions?=20

Then, any SWUpdate mode/module will behave the same and there's all
in one place reducing the need for having all the context knowledge...

> To avoid the issue you are seeing, the decsion should be done inside SWUp=
date:
> something like a transiction TESTING =3D=3D> OK, because SWUpdate is runn=
ing. But
> as I said, this can be done if it will be configurable, or it will break =
the
> use cases I mentioned.

This is essentially promoting the current suricatta behavior to all
SWUpdate modes/modules w/o the remote reporting part if not run from
a suricatta module. Would be a starter...


Kind regards,
   Christian

--=20
Dr. Christian Storm
Siemens AG, Technology, T CED SES-DE
Otto-Hahn-Ring 6, 81739 M=C3=BCnchen, Germany

