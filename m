Return-Path: <michael.adler@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C00DC25B75
	for <webhook@archiver.kernel.org>; Thu, 23 May 2024 09:48:10 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.42])
 by mx.groups.io with SMTP id smtpd.web10.11534.1716457688589883363
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 May 2024 02:48:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=WotqV5Cr;
 spf=pass (domain: siemens.com, ip: 40.107.6.42, mailfrom: michael.adler@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eCuq8TMtv+WTQiPUb9C2Q8WNMeAlZwySu+y6/z+L0HPbAfbSGHrvuRwsfFe++JIx+deFVERdazlK46pkwb3mg0j0ZNdoro0UD2ElhVDwBkNtkaeyt2oCeoO92e5uPf23v0cyS9I4HOZIflsNRunb3oY/e8bOVFe5bgkvgVHSyOQiAV8miTk0rtyZWPaMwvwOKqHmPbpjfilqcKdyQMLBAK6oV6JfxbrNvGNGe9YeNQS8kopiIwIOllCF2IP8UV+fXMicyJZOkMygKE6/wnjO3xQVRMha0F+ZpxWl75bljMTKeRVPbS2vaizw4FaoNyvLoNKfXCO6ItXiDKDTRliK0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XrlvLXzYMyK3EAA164aVPRRrjSInYDSpfA9McCnI/lU=;
 b=JTN62mch1bipPb9vGDlXLI+uVRej+tB/drFxfOB0oCFxkhCGc/HkeqSdzGRJfg63xSVUlPXorkagWfJwUXJCKirnhxRHsSSUqNQb5zW/VHN1jP/WdiSQIKaynLyLMbLtY32TfRgvdhBX+BQduAUVAEtGzE+KUzjusQEPWzTT55ETkEa8hLwKmYWVO+DG1hE8uMeN7NV9oPecwSaa6i371tD1OhNz/RJfGhs3ny9wZlNQvSdnnKOYqUBbsbIdc+i2FHsr+OH/caR8y/u8Gupst0jEVTDmuGFJs7Y521B5EBiDmo6ydfl0tPQiYE+9E+q3MKl8FkhmHi0CkR9Ly4d+Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XrlvLXzYMyK3EAA164aVPRRrjSInYDSpfA9McCnI/lU=;
 b=WotqV5CrxEbZIflht8ZYaozGcJEifNp+ZUMZnlHbs9eReZ832qn5fVOBjDrbfrTlRDPJXRKMDY9AYVncJiDrpR1pqpOj7tlMZj+aqfp5KMydu5QKHM+mzbsycOLprglhr+P7eBjRNZV7Y7HI+YB9i+C8RCrEi4tSexSOs1lJkc92iorGCOtBXzm1HrKXYV8APgPJQPfzbOYZ6zvPV1sz+0S8azFwzqYJ3/jhGEjeuokZyWFFWbQ7VEQ1Nyyl+JoW+qirvJ5IKpLsINZXiXZyvNHrqB5KDfO0M6Bhpuf+JyuuLtnF4ONlSU0EzABoBb7CV63w7dw/KKQnfjfu5UkvTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS8PR10MB4727.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:33f::20)
 by GV1PR10MB8821.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Thu, 23 May
 2024 09:48:05 +0000
Received: from AS8PR10MB4727.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8e4a:e5b5:6258:c3d]) by AS8PR10MB4727.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8e4a:e5b5:6258:c3d%7]) with mapi id 15.20.7587.035; Thu, 23 May 2024
 09:48:05 +0000
Date: Thu, 23 May 2024 11:47:54 +0200
From: Michael Adler <michael.adler@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Chris Paterson <Chris.Paterson2@renesas.com>, 
	"pavel@denx.de" <pavel@denx.de>
Subject: Re: [cip-dev] gitlab testing stuck?
Message-ID: <7cumiqb6bgwtvyis7hddi52p76kdxnkmlorqc4a6zrgheaueqr@mhutg6ibp5m4>
References: <ZkTwEKwobEIumswy@duo.ucw.cz>
 <TYWPR01MB118620EFB0163032D2062BA13B7ED2@TYWPR01MB11862.jpnprd01.prod.outlook.com>
 <Zk8NZmeJPwIYiqqH@duo.ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zk8NZmeJPwIYiqqH@duo.ucw.cz>
X-ClientProxiedBy: FR4P281CA0418.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::13) To AS8PR10MB4727.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:33f::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR10MB4727:EE_|GV1PR10MB8821:EE_
X-MS-Office365-Filtering-Correlation-Id: d2597390-2548-4008-c016-08dc7b0d71b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?XhJ05WxBV87zqr+FA357hiFG+5aFJisberSHFdxwHs1IcQnxqOotbY2yuBEo?=
 =?us-ascii?Q?dlCeY9t1UEUVs8CmhL7i4h0pu1TtiOxO8YbyfG9OC5dnHBUYs02IUKsHFxxR?=
 =?us-ascii?Q?1Cs5pt+CZTECwKbUgLzzvtjMfYPR0X5mLuE2pAcFjBceDvuwb0pnoqzf47Sl?=
 =?us-ascii?Q?ovG4xtSEhqI5mlylFKksstQ3+2B/crwofY1te+Oc/DYB5IoNCtzkr02M1PMu?=
 =?us-ascii?Q?u/oPAgvtN+SuYSZ1NM4g1MW/qYfKBk2YS7tXRfXNo9hSMOkX3uf1XKfoFUcK?=
 =?us-ascii?Q?sflZYC12VArnULtnCF+Iy1BISPeIy91Knuj7KpqXrSl0tLAz3JaMotB0ghIi?=
 =?us-ascii?Q?Aew2vv9sc+cQeOH9CYCqRYU9KJVuEDNq9h5c83gPAp88H067flrzNTxGZddt?=
 =?us-ascii?Q?Th0QJpsCz6wGbqAezNfP3ONAOFfbFThYMmI8gDV2a3jg0WEh2nW8JZ7NXpzs?=
 =?us-ascii?Q?P7Gwy78MsXkGcc02c28sr03I/ilhojgqPLK0Or81Ax+XezYqMF2eon18da9y?=
 =?us-ascii?Q?0JsLcZB99vnPaaMvTKFCa8JwI4XJKQGfbJs1ytxsn7CrXJcbw+x2QlRIE/HR?=
 =?us-ascii?Q?ZexKx8n77j43tbGgOKsen61LIwoD7HWBh85v1mHRA/Kd1EJVlF3sWhKE+GLm?=
 =?us-ascii?Q?RZJoxSqcNeUzr1vRzuIecbGQpOcXwU3lGnHP0QxQlBJSuncjmkDq3LsbiFxA?=
 =?us-ascii?Q?ib3Pw9KMmifhTZcUT1Y3w1jWHCYAVwUDlspsTc9R4ot11DQBY+OXHsUqrS9x?=
 =?us-ascii?Q?q01G4F4s5T5ziolq3+q5HzHgN5eQF71Xbekqicvfm5YoqRIIrGFRjNJEs1pc?=
 =?us-ascii?Q?6Y0II13w23HXAcMmTbic9oxZebADqhbcNF42Uh62qIJHQgrSqEEnCyyQJzn5?=
 =?us-ascii?Q?bCQKHcn8Qz3C9JdceLVf4yCrCmVT7MpBpjs99LdRCm07w9+CDz+MWFwQ8ow4?=
 =?us-ascii?Q?T2jcgrKDeXeYUaTWyeZ7KDfGUhuqiwHw8BkLNePNCt7KV/gw5S1NF7rwhS5g?=
 =?us-ascii?Q?feE7/D2OxInrW9TfnRz2qpay1zyUbqJFNN58KhIcVFTzqVndxM73CB0zweXB?=
 =?us-ascii?Q?uAAfzvn9+c2xELe7mazdgNygj70jzziFVG8mo8PKcboha+L4TzqMvHPY1VrP?=
 =?us-ascii?Q?aAMs8fmFbNQnylJmQ4prkkmfID1KjZkCcaly1hseESwipnVd9lk2hXgZaDf4?=
 =?us-ascii?Q?Ev3XFkuRYgrQC/sEEcjckRV0dIYeb+Lw5T8uxc2MK1g7CV5IiRycTg5MzfE?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB4727.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?0CIQpDb9aoIo8Pbf0UkgdtlGt2rTJbUFhOTPuJrBbbUd0YjQZV/3XVQ5USy4?=
 =?us-ascii?Q?cdLjEDqvI/TnsWDpBcSRKQLJMfaq0LKwatDQyuZL6zHYQRjo7cc/ur8ud9X2?=
 =?us-ascii?Q?SIJku7Yapc/QUNcRMPxbYZ8mPwVHu6uxFKgrEmvd5czjDDIQ3seI04oHR5N0?=
 =?us-ascii?Q?XgvjeV0c6JjaDLmMdTlZuQ+oJyDuEe90a+0xTDkqq/eE4jguaHtkm4yBY0wg?=
 =?us-ascii?Q?ppzN2iTMC8XyHhZ/howhyScWvQp08KSlZxwIg2tExt3ARs5OSJi+b3nOGLb9?=
 =?us-ascii?Q?R3nxu8ZI8VyjGpIwq63wb89pfTvzDmxqhNpcEbzGRerkZo/Awbm5baUTEHMT?=
 =?us-ascii?Q?sUsuQC00ff1g+CKXf2D1Pb95I/YltKaPrlxv6d2/wOIWqKXdzHmRcT6JSDpd?=
 =?us-ascii?Q?dF5VnFYLO/hHCSzk5WX9o0rmoswfanhamSkB9L77exeKiNZQVZ+wDkMBVpkc?=
 =?us-ascii?Q?u2WllYQPddu8PbAJipwGsQLtxT8dV6YhT1mcmmFw6XzBfDIthEuiaeH1smaT?=
 =?us-ascii?Q?RQJdGqYDGbRUnUfX8MBECUWG3DXVrWUlHp+o3jMJK+2hHQRGUxg/6ZVdnKlo?=
 =?us-ascii?Q?zvHxI72AhFX/drH9FgYd8fr/iBbOYnLjt3PqA1s+/o2r0grY1S0jJTRiEwdv?=
 =?us-ascii?Q?mG92pNpXWlSxE8RyKIh6Wb0EnrlrkWZJFeNWDoTaRPFrbEH6a/AxZPIagVnf?=
 =?us-ascii?Q?eLq5tn2s6e08wNhizV9ncZ/nNWDuCIk/V1Ubuu6e1AD3r5nA46pnxbnwLWFR?=
 =?us-ascii?Q?TVyV72VJTMahLugfzptRtzL12B5QPd0gHbVxcB4FKtPbPYcSA0dwea1ZF9oe?=
 =?us-ascii?Q?Pe+9AO5vdUZRnkVBrzQz64zWbpsmvfEN00s5qZjuOElVob36gl+O/k9UsVKL?=
 =?us-ascii?Q?u7i1VU93BHSznZ3g7vEHkW5TpeVOWoux6+kQx3ct47ntmDDhCWUo3WiyQfaM?=
 =?us-ascii?Q?/gXPIWUfY/qR1rfJn1H6V0jFEle15ntpeA6EyGfGGsTV9Dmpcif6+JKbHYwc?=
 =?us-ascii?Q?uOhnx2/I1TVqh2gu+EP0Dya/JW9Cvbvsf5OVrG2r9UdvExJEUaO2c4tsCBCm?=
 =?us-ascii?Q?+HNZTrHjjKrf4rv3C1tTe+vdalJBb0el9BE8A0nG9o9uFfd1/veK/GscdvMK?=
 =?us-ascii?Q?FTpx4/Yc/Sz+tZswKTDKJpNbbucWWDmmOui0kPAAFC8pSwLxrrzgr5zaOukR?=
 =?us-ascii?Q?D8EJpTZ5NDjOGD0pJMel91qj6p09kdRWEo/0g6oPQ9HXk/xwDNWcOH2+Hhy5?=
 =?us-ascii?Q?H+VzdZC9CAUqVattqpMuJrrpCVhc/jpM+4uZs2TSwFKhj5sZULhUgeClwVOT?=
 =?us-ascii?Q?kHLC/p5ss7SFH0JBE+fE/m6rN2nONCL7UK3Cf8ASiU4FvClh3+Un+iClOPVt?=
 =?us-ascii?Q?1af2/nRpj5N09d5Fca2vYCN5X5Bpx/dlVAtjdo6gGiQCzlJQRxYMJFN/eFWp?=
 =?us-ascii?Q?3P0Anp9Zz6CyIVCD9Lv0i0rOxqXYoxfU3gjgIyx0VfRnlo2KeN+z3ZHrJKtZ?=
 =?us-ascii?Q?zfSd5CSvevn4hyKux5rMFTXNaNSziJ0+Qdf+eCNwPxlA3lV1DTt2S6PsMGpb?=
 =?us-ascii?Q?xuT/NJiqKg0+FyYjIHB1SfJFWuQmv/zuR1w9TVwT/+JyChIlGd3DqDb95DJv?=
 =?us-ascii?Q?Kw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2597390-2548-4008-c016-08dc7b0d71b9
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB4727.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 09:48:05.3651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RY+CORqnGzD0XIcoMo+gIWPdwJEU+LGbkPy1o3/6VirNz3xHUw1kYoVSr7/c79dW+gutDmIUDSrr8CFWyfEfp0RniopOgWuaxyx3NHwvBDc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8821
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 May 2024 09:48:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15929

Hi,

the runner is gone because of a breaking change by Gitlab [1].
Basically, someone with the appropriate permissions needs to register a runner
and send me the token, so I can re-register our runner again.

Kind Regards,
  Michael

[1] https://docs.gitlab.com/ee/security/token_overview.html#runner-authentication-tokens

On Thu, May 23, 2024 at 11:33:26AM +0200, Pavel Machek via lists.cip-project.org wrote:
> Hi!
> 
> There seems to be something wrong with gitlab testing at the moment:
> 
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/1302074556
> 
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/6920224416
> 
> gitlab says:
> 
> This job is stuck because of one of the following problems. There are no active runners online, no runners for the protected branch, or no runners that match all of the job's tags: small
> 
> Go to project CI settings
> 
> Best regards,
> 								Pavel
> -- 
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany



> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15928): https://lists.cip-project.org/g/cip-dev/message/15928
> Mute This Topic: https://lists.cip-project.org/mt/106259374/4520419
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/12503494/4520419/1780039012/xyzzy [michael.adler@siemens.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


-- 
Michael Adler

Siemens AG
Technology
Connectivity & Edge
Open Source Embedded Systems
T CED OES-DE
Friedrich-Ludwig-Bauer-Str. 3
85748 Garching, Germany

Siemens Aktiengesellschaft: Chairman of the Supervisory Board: Jim Hagemann
Snabe; Managing Board: Roland Busch, Chairman, President and Chief Executive
Officer; Cedrik Neike, Matthias Rebellius, Ralf P. Thomas, Judith Wiese;
Registered offices: Berlin and Munich, Germany; Commercial registries:
Berlin-Charlottenburg, HRB 12300, Munich, HRB 6684; WEEE-Reg.-No. DE 23691322

