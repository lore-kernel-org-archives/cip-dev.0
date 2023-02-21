Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17615C6379F
	for <webhook@archiver.kernel.org>; Tue, 21 Feb 2023 09:21:46 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.55])
 by mx.groups.io with SMTP id smtpd.web10.38028.1676971298915508982
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Feb 2023 01:21:39 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=sjNrt/Bt;
 spf=pass (domain: siemens.com, ip: 40.107.22.55, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTlCDqwG3M7DdV31IBFlO8fcWyENP7j1vD93b7d5H5UvLVGqFrKNumDtcBgNqbBf175Hbec/GjCJY6CO+SIbbrzSCz6/jpESuEjVEWDQlOgsijMmylOZXu80zrPhcNxpZ70hVwjTgYZ+qk+MD75nb6layBFPfe7Z5VUZ+CRIOWorfJcq61HSvIlXfo6vylbHgZoALmymUqI54oFv7c4W8pEKDO/xbD9UhIo7cknEaxkCG01NPWfXYi4LYjD4da65enhblAKoc7zqH1OB5HctlAvBrS9rC4VgVBDmiHVCfhsCJBj0g2ovZxAVh+8xCsX/k9myTciM3P06BY0JNfOKuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l1VUE0De4BNtOAqHp+SkxlcD+jMJyYx22lK2Bljupog=;
 b=JCz84e09z9GR0lK77mEadLrze+VMMPoPsdHhhrx+SUwBxnQxTfGWvX2lrckHQZzQRDp5kjaGN2EOUec/cKYLorehD8VfWUzJ1DlsfqvbSND6aZbcLJhyBAHZR/FddrjdqpseJtTaOZO6QIBg3ghGkppEF7SfAUt7Q/jDX6SAyv88AI9r1Rm2iQKqCX89EUZhPKuxeJo0KiMt32Etz+fDRVJaoB1m36YwoM+Pif0a2KYZ4BgS2veeU+4QwomXNt9JqOjv5mVqJZObM+zv+e2Lwbs3E4T/zgV/tcVgt3kSNJADhKxo/WTRGLIvKRVx6w0SBuWP9vjc1HymVSKVSB7j0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1VUE0De4BNtOAqHp+SkxlcD+jMJyYx22lK2Bljupog=;
 b=sjNrt/Bt51oAWS6liC5yUqINk87DDLZAjX7wPyNRC48Uh2HK9AqA+fft5Dp0ISVPrjztm+i9ttaC3kjn0ueAyv+1+IaJT+xdV9M8lN26al+LwJ2FQR4zPME4Wt7NOw5knAQQ87Uj/qAx7pPdWx/EF50mvkuDCRuJjJwSRDDyk0im3GH3hzEfzyh6K8k6vwG0oQdgA+1K+CN3hC38IwVaMRvXqV4PZOG2M7ah8klS+j0RwB1JaA+6Jtp6kFRMFX1xN/nJIYhyC8ej4NyGGcDTyTWjGSM8R7qN1T5oHKiofS+DHxoUVZEVet5gacUw2l/Fzo8x2ChvP8UvgPWCdgTYTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6801.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:477::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Tue, 21 Feb
 2023 09:21:35 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6111.021; Tue, 21 Feb 2023
 09:21:35 +0000
Message-ID: <5b7c25ce-d70f-fac7-7a85-660ebcf45847@siemens.com>
Date: Tue, 21 Feb 2023 10:21:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: SWUpdate+EBG: The impossible state and how it's being handled so
 far
Content-Language: en-US
To: Stefano Babic <sbabic@denx.de>,
 efibootguard-dev <efibootguard-dev@googlegroups.com>,
 cip-dev <cip-dev@lists.cip-project.org>,
 Christian Storm <christian.storm@siemens.com>,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 "Adler, Michael (CT RDA IOT SES-DE)" <michael.adler@siemens.com>
References: <934a4d61-ed5c-cb5b-82af-86d9e3353120@siemens.com>
 <b51cdb4f-fdca-154b-7a09-d24896facb8a@denx.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <b51cdb4f-fdca-154b-7a09-d24896facb8a@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0102.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6801:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e0c2776-48fa-4800-16ef-08db13ed0752
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	4VHWcxiPuJRntT18+Ov1M/u2toPX45HZO9nIiX1sN2qLB4SK3go6C7BNpm03XqX/XZgkG1eDNPRFWCeby0fBs/NWnapkqnxBJunRCDPlzTcRf9+S/NWoG9sEPnEA/d3Ztj/DC7UPx42F2IGqgLevV6ok9ajb579rYPjKgIWc+E0wHow1TtDv+D5U6pFkX7+Vsr/mjKTxrEMfo+r9pfWjBn32zBQB7slDhbCuTumWfik/57C0MswrMeFVt2t0Tf5+PtLO0QcX0e+CU630BGobGU7DKWMYKv5KqpyOjKqKhCig8p3iLli7yHPuQjJoulkRJafoJchB1PfdGbJASuq8BsM2WpH+6n8CNSpTy2h7emL8m2ywJzoF0wTbJ3DBZmxMFUwptAvbHnDLLbNdnuWfD9qU2kKohF1gWMU6PQH2/aWdRJxHmV4lvUSYZHrn2A+4918eRY7wdKb6OFNr0nYP7VXMmUW7eAGsp2Tqxkur77ugHTxyFPjxbRgF//2i3E1j2iigm9jbUSEfbEV0UMR2R3k+Vu4hhZHweQPLVJZjYDgOmBX+/A0s9HX9z8ml3wxbTzSXZVpCMoMyGAqFn7LKpFmVg032h7Bb7X6jz95jmrVgoX1pZgwBVQOpS2efZdb5PdAtrBqx1XvXyM9Tk6J8DBhleWJCe5HKM78MhBJ741j2Ba35GkZ4vKNFwZ4u/kOrqsXlNc+aiWda56V/U6NMQmHLS67xvxnDR9wn7iFDdu4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(39860400002)(366004)(136003)(346002)(451199018)(38100700002)(83380400001)(82960400001)(36756003)(31696002)(86362001)(2906002)(8936002)(44832011)(41300700001)(5660300002)(6512007)(186003)(26005)(53546011)(6666004)(6506007)(2616005)(316002)(66556008)(8676002)(66476007)(6636002)(6486002)(110136005)(478600001)(66946007)(66899018)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?32ownCsHRdEs7GmCzzNRCpP2Nts94Zc/xaVDgPc9p+qaXDGY7LWoFQpqWlcB?=
 =?us-ascii?Q?AAwEFhS5OxZhLGCPbi+SY66xmWlHH2eF2BvGLMbbJ5hiHROr1qfq/jOSq2IX?=
 =?us-ascii?Q?kPqQQ+RA4KK7egZ54o7sQBNcIm7Kd/0QKOrmcK/Bhf4hFaBjDzMlSnFk4wKp?=
 =?us-ascii?Q?9YlrEXnr9wGnsISb6B6hrpAYoE5yzAcCj8INhJVwDFFP82yr6E6UDmoxMl40?=
 =?us-ascii?Q?m+MMm7777NAUdiBScn1RHCqS99mmqedlJgWMaUHIdaiT6vqFmNS7vW4xtjpG?=
 =?us-ascii?Q?H7Xmeeewe0XAFlaLjgHlRRMeXQ9cTYEtAg0xRbu0yUH1H7vKDb9w6i1Mn3uL?=
 =?us-ascii?Q?P7s8O8r/LHOI26Q9Wxbi7Yn5/pIEjuJvUXJ3sSuWGBd8zakMJAS/xA6BgygF?=
 =?us-ascii?Q?aZURwfndSzngPIRdKpzP8abUNHB+f7Hlv1bszn4nZFjfjyMTJfCdXqzFOhW6?=
 =?us-ascii?Q?6w1E+UksfdbNYaFwfEjIELZfGuu2AGHa+TMHSPUWCNZo94vTkPAXzU5tbKFy?=
 =?us-ascii?Q?lI1nTyzKJCllds7DCzcb2Gejusc4TAnd41HmQT9SZc6iB5H0iWE4dWG+glyw?=
 =?us-ascii?Q?i8V6GWBprqGWpVJErV1VucXctRnBhK+d/xKIEHBWzlvdN8FYF+827OWV8XPE?=
 =?us-ascii?Q?zIXfTzfqK8tmw/CDS2K9opHbuVP+MTBrHNHkok/5vfqPA3T3knamEtDhLHCG?=
 =?us-ascii?Q?zVJlovHXcj21vSW5neVoDVpWS2SNhpabtKsobFLHDSocnMo2QRo+HIQ2XASu?=
 =?us-ascii?Q?c497HY01JmcYs/NO3V3VhZvMd/iNcsj2v48i137ObLrl/7kA3A+4TCzcivhj?=
 =?us-ascii?Q?P8HMEPtVc5HxtMyk+HIDbRCoxXMeUnT1RTEkOD7MbheyaYjym48jg04TGYQd?=
 =?us-ascii?Q?QY3T55WI29RVZrMLGiAJloJdfv4JLEoV0qi+5Jylhlq6Yz844x9xSJMMcGuW?=
 =?us-ascii?Q?WbJiUDfSGSvU330NTOWiXuvhV0mJgP+Rc9VOkrey4p4FLKue1BZvs/slWO69?=
 =?us-ascii?Q?Tf0XTBq2l7zVpo1RNoBIIaGa17fiVsKUNXK9ZvvCRkyw+gcG+jABTM7CbVZj?=
 =?us-ascii?Q?hVMJvZ73Rup/Xdadp9JMCHgPNeWGziayd4WtVy8kH/3QoJKS7VJIcAEOOvMb?=
 =?us-ascii?Q?mdEfE/JOUtZQYEJPeEmDqXqNqBkk/DkSN4lf/do/jfBW4/QDMk6/q1ykv9lK?=
 =?us-ascii?Q?dbXOJYVKxqp3IxBA23R/Q+RCkGRPEDQpIY8S+4Mpdop/o+0yE6JuO2k1D2tZ?=
 =?us-ascii?Q?9sXa5PDTjQze5OfpO/Wrk7HVNgqmO+QDe1O5JrvPXqfVQM83w4fVnVvMo5SL?=
 =?us-ascii?Q?uPfxtS3Jbeoq4oBcW/2Z+51EHVDQmcpIbg83nzVBTuD97twtB8Czo7zNxeF8?=
 =?us-ascii?Q?9Nm3HzPps7IZzAl9BfJcQh5IqDhBxQxjFjjnXhLILMMUIJRqb8lmZoMJASrI?=
 =?us-ascii?Q?9Jo2eXD0yw4yWvUAYsCSwRigigdEephLVILCrihsxzaswABE/LU+QUyv+HhJ?=
 =?us-ascii?Q?fCPW+/6XXhrVIOQlfu6alCG+ATX4t9rhIVpVw0W3Ux+mqCJbjnA3+DQW+uan?=
 =?us-ascii?Q?CdOdGgYPymH1uClxYO+kti6+sQKzgtOiX9+DNKznfrIpxBMh5RZiCq5lRkne?=
 =?us-ascii?Q?ew=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e0c2776-48fa-4800-16ef-08db13ed0752
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 09:21:35.6085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ASTklkQUBaWo5+siElZKx+aprn7uYSEUEpAjY2MjJx5glgAGDhuM1sbUUPi8qS10iZE7rZaJgxAQ1aVl4I0iaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6801
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 21 Feb 2023 09:21:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10747

On 21.02.23 09:31, Stefano Babic wrote:
> Hi Jan,
>=20
> On 21.02.23 08:09, Jan Kiszka wrote:
>> Hi again,
>>
>> playing with updates, I maneuvered the EBG envs on a system into this
>> weird state:
>>
>>
>> ----------------------------
>> =C2=A0 Config Partition #0 Values:
>> in_progress:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 yes
>> revision:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4
>> kernel:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 C:BO=
OT1:linux.efi
>> kernelargs:
>> watchdog timeout: 0 seconds
>> ustate:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3 (F=
AILED)
>>
>> user variables:
>> recovery_status =3D failed
>>
>>
>>
>> ----------------------------
>> =C2=A0 Config Partition #1 Values:
>> in_progress:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 no
>> revision:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3
>> kernel:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 C:BO=
OT1:linux.efi
>> kernelargs:
>> watchdog timeout: 0 seconds
>> ustate:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2 (T=
ESTING)
>>
>> user variables:
>>
>=20
> I see - we should *never* reach this state.
>=20
>>
>> To get there, I started an upstate with swupdate and booted into testing
>> path #1.
>=20
> Ok
>=20
>> But then didn't confirm this update and rather started it
>> again, using the same swu.
>=20
> It looks to me that this is the point. SWUpdate requires to close the
> transaction, for itself or for the deployment server (Hawkbit). If a
> system boots with TESTING, the glue logic should start SWUpdate asking
> to close the transaction - with OK or FAILED by passing the -c parameter.
>=20
> However, this was thought to work together with the deployment server,
> because it handles the state machine on Hawkbit. The parameter is
> ignored if another deployment interface (Webserver, USB, ..) is used.
> This is managed (again) on such situation on glue logic, and the
> transaction (that is set of ustate) is done before starting SWUpdate. Or
> in case of U-Boot, it is also managed with the help of additional (and
> custom) variables.
>=20
> In your case, it seems that nothing is done at boot time, and SWUpdate
> is started. SWUpdate does not know (because it expects that someone has
> already decided, and ustate is not checked) that a new software is
> running, and the same SWU is loaded again.
>=20
>> That didn't complete because the UUID clash
>> was detected. swupdate terminated, and I was left with the above.
>>
>> I can still boot this constellation, EBG will select path #1 (endless
>> testing, so to say). OTOH:
>>
>> # bg_printenv -c
>> Using latest config partition
>> Values:
>> in_progress:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 yes
>> revision:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4
>> kernel:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 C:BO=
OT1:linux.efi
>> kernelargs:
>> watchdog timeout: 0 seconds
>> ustate:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3 (F=
AILED)
>>
>> user variables:
>> recovery_status =3D failed
>>
>>
>> That is not quite correct. To be fair, bg_printenv deals with an illegal
>> state here.
>=20
> Agree.
>=20
>> Still...
>>
>> The key question is where to avoid best entering this state in the first
>> place?
>=20
> My question is why the transaction was not closed before running
> SWUpdate. This is a common pattern even with other bootloader, but it is
> more important here because EBG stores an history (well, with deep=3D1) o=
f
> previous run.
>=20
> SWUpdate can check the state when is running, but there is no general
> cases. There are use cases where the OK is coming from the application,
> and SWUpdate waits via IPC the result (but then SWUpdate is started with
> WAIT option, and does not try to load a new SWU). So SWUpdate cannot
> decide itself that TESTING is a wrong ustate, because it depends on a
> single project.

I was running swupdate manually from the command line. No backend
involved, just the desire to intentionally break things. ;)

Jan

--=20
Siemens AG, Technology
Competence Center Embedded Linux


