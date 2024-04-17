Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A28C4345F
	for <webhook@archiver.kernel.org>; Wed, 17 Apr 2024 14:57:03 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.61])
 by mx.groups.io with SMTP id smtpd.web10.15231.1713365813852609362
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Apr 2024 07:56:54 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=UG6OTFZc;
 spf=pass (domain: siemens.com, ip: 40.107.22.61, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WHb+VezVgJTThX07XvyZQDYUmMghQVgaT1PMI6qUNKYPCFpRYS7y7+P3fAGnTohGqIaCAaUcnMDTzUIQ+EGrdP7Oaixs4OxboS1/1b2Y8ycuq0cIl7hvaltA6t7g/njvJpJ0AG8f7Qr7MUDTZ/8HdgPRlUCoVCAmbcLfdya/nIjA+gEnmvFL9Qe/ViIc0SQRqF2fhsJAIL726HZohY5YdzKR/wBaH8QC6UqFO5hH/jnuIXJhHEzgzooQCZROsrGLviUpCjEc/XSp2XUrnUG9yNjyGFI4CMeyRJD1ryEi3pi8Q0LgTYEzjozHqCS8jIr9uXj2ET7dgAZf7RkPWzCXMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8QdwzU047fWwmkG/yEh+PF6FgcqI/9qXuRXUD76mfg=;
 b=T+sxKNPJkD7bVyhMaDCEN0Df8B86BvZ+FND88X+iUkL6lt5KWxPVlrYI7ylBICSEL6FSNcb0gWUAFDjDjozmjvVRyu7hbhNkRkJg8FBM/BsO0kZYaYsSlpDnyWa9OxXbffq0QiRgvQK+brY/S9xm0ISj/X65U+twiB0nUSvSSEspSc7okRvKyI0/j04xZch4l3wwKSUyjI/q/xgSKCTwY/ib3yoj/8eoKmB5jgep5/0okOZ9gCmBd0rJ+ExQZt1Dmcqz4O6lq+HeIJs5FpoZr5hfr4BAye0zKV6ZshS6CB7ioYeYUwuKfmJFvOc7jzL2zodmW9msVE8MOkFJnQ6tFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8QdwzU047fWwmkG/yEh+PF6FgcqI/9qXuRXUD76mfg=;
 b=UG6OTFZcZBkIkrlAzHUQ9B9wYnI5+O22UOrs1OmWyaZ57zbWXHo7Y2TNSjbIofNKvZqpDzWQgyzJFURGS9kSTK73/xuvafgtE2gqCt8fjLt4lU3E3+iDyVJy+HUF8FDNM9KJuK0sCFR4zXBQswj4NG84K2Kqz6fM/00M+Qwq6AwYCJOQ/qUEXpMRLcDRCqXA/QpAv4615+ckJ5oDm6Z7981TI0et3vyJ3d6oojiVYaJ6Bo6NUrLdeuD64r9T2Nl1t6AsgUxdtKm68UGfy5LjDf7EnIN++EyJGV6xzdjpOHyOL79igprcQ8kFYf92vdxGnraoK14ATYLkhk4oFeSvBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6155.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3e7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 14:56:50 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 14:56:50 +0000
Message-ID: <a3049a25-04f8-4c63-9089-a72bfa7a3810@siemens.com>
Date: Wed, 17 Apr 2024 07:56:46 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] recipes-devtools: use DPKG_ARCH=all for
 arch-independent packages
To: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "cedric.hombourger@siemens.com" <cedric.hombourger@siemens.com>
References: <17C5CC2DB0C515DA.10043@lists.cip-project.org>
 <20240413100140.2432650-1-cedric.hombourger@siemens.com>
 <20240413100140.2432650-2-cedric.hombourger@siemens.com>
 <62a84992fcb3f160e8012b045d556b45eed941c0.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <62a84992fcb3f160e8012b045d556b45eed941c0.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MW4P222CA0021.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::26) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6155:EE_
X-MS-Office365-Filtering-Correlation-Id: e9041ff3-0e01-41b9-5e9f-08dc5eee9cc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	KGIU47p60bg6q0rYhcupWUMpA0mw8KUWk/Ae5KRvwbYnqJ4Sx5tOIuDycxH0apb3GDgOHIwuptozOZToMwzbrCkiPI+J08uXnsygmLCuXY/8ATkVCCMpu66+qy5NfyQ5wpoVl/gurvgD3Rz5c3qCGXSRBdaedolnrJI+s8APGIYV3wRQgf1WeNy/1nfFuDOwsMzgX5X02r7NJQwxdOZJ1cfU8pTBsVqmeRdlmG8uf4zS6iRiReufhrgLu+yjV8y4tQnHdJOMX7KCs6k3wrk3K87Hv7bL1DpEzhiz3nm7hMJvye5gaD+Oov0rdej7nRsjRJJIt08/sDSocnL842lzekaiNtm0fmAXzENdWz2pSaD1kARMMbWXETEVmE/FQsjMTXqEOGhtCoUixhL0VLFRTr0H5OISWy0w0UonXQOLc/HaECaTaf64WDdl4MJqXXdnSt+tFGPuN1XFpTIjHhUY5ZCZcoSbH6gDbjcCPA2wqtAULEHb3JU1BFdtWGxA+BQtKiDQkkyjHSxhuainBileOEoCRfmh1Fht8Qboh00I0p3id63HGEfiLU7+RL4RPlyDJ+qz3YuRiZnULlPA8BZ9f0lD7OOPLW3di7/AX681uyWd9zjr+EDcMwQYr7knNKCZHj5JLpbSj6U4dSNy3oDJ88HHjaHdU0/eNw5iwufJu0U=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?2duFd+OT81X8by+y4dB/WdCAFvzVUmVG2kRXe7u4tdm9wGNdcj6BxnlgGR3B?=
 =?us-ascii?Q?AV3gb6kAEvHLYTOlQ+msEmyuf3C2CSgnnr08l3ICKu56uoa+eQ4VzwEaGzUD?=
 =?us-ascii?Q?HtYiRLKX/oNR1eCZFMIn3faBcbHMsq9sohE5yOP3QY2j0q0tugacJqHfbfEX?=
 =?us-ascii?Q?rLPs9EAB/tKt+XhFGgbluEJQ1KaVknRZNPbN4ENv3WIGhDic3AZF3z6sqCFd?=
 =?us-ascii?Q?5MOkbkUFAXazM9GK5CW9A6A9ND6g2ISdevIrIMo391JILa5ocmShr8REe2CF?=
 =?us-ascii?Q?bkPBrEl5jxuKmhYCIIHS1QenjuIu3uc0PBuvI7C2hkcgALi6B0Fwcsm/mBTR?=
 =?us-ascii?Q?E14nxEUnB76mlGPaB9zt/b6K97mJGzJc7mSNiPVV74PH7IZgb0XmZJqqv/xl?=
 =?us-ascii?Q?Zu6ivwGn+GwRNq//xzLErXnREI/Gt65qXL7lIzJ7coezFXiNZaTtKM+LxDRY?=
 =?us-ascii?Q?itEYgup+MH7NHN0Iaev2pNVaXHR/cXgCjDx43atU3oIDIu6U2FfQ4FbQ4h+i?=
 =?us-ascii?Q?l9zab7ueX786Dn/gmXk7amBgSEC74D02FgWKiCVAJ0xS8P5BRWTdiVK0bZSL?=
 =?us-ascii?Q?yrtk+J62JgTWADTnEjTgLh/P3UULnoivieMcOZhliFFc4qM1qlNkSA5onAOm?=
 =?us-ascii?Q?jD56CWv1BKNXrWBEK2r7qRK1t0pCUaW4e8r+H762DoHOeLGhGilCnKayEKFW?=
 =?us-ascii?Q?xblEy6LHr42+lprcwpv4STE7mdxHJOPeg/vFjKYodpRozmskviOYZTZOTsls?=
 =?us-ascii?Q?OyJPWon/Mk7uTEE2HSE21bzZY+MHx/8u1O3yyKqXEL6LiU1oVgwNvFklZkAW?=
 =?us-ascii?Q?cOaFwvHNjFJpInShNZ2KJ3EqPIxfQXrtnoQZj9M2Eq05u/uF0kLmdSKPH6V9?=
 =?us-ascii?Q?/bd+iYXVB3qEkjyygDCawVW95Vdsb47Ta1BovAHpTpGxXRcCceSq30M5ASPL?=
 =?us-ascii?Q?X59Z8wHQSt2lECeD+JlpFqp/Adw3RLDEZjm1LeD1TeLbYCSa/20+3Rdlsqae?=
 =?us-ascii?Q?WI3y1HctXkBNvvIL6hiVS28jaDtEkw4EIYrmIoZfW6drmC1esmINGpuWT13W?=
 =?us-ascii?Q?MZUURZMgJB/gVSTxq//EE5pJuhEc9eyB0Yx9VpF2raOmDafqrVrSBIsopXKj?=
 =?us-ascii?Q?J8TirgXnkRrmpN57cgvUw3FyPALbSS9CaeNOBTiu4+PbuMG8xsYBpnFpg7Is?=
 =?us-ascii?Q?esRm+YduUueHFBVq63WKSYoDkEFj4IWOvPHJ/whd3jvrUpbemOjBK2bdL0Lu?=
 =?us-ascii?Q?pq11zPqhI4iKqKdQ1MT6kDtnhdYuuteDUItJFsTF00oNr4i3HIATyVdwkuy8?=
 =?us-ascii?Q?lisPjGHQwkiPCegiidojfvsQ/eXRVqkBh/9LTpl6yjATf7vfXjhUqlYYYAah?=
 =?us-ascii?Q?5qPY8Z6IFOY/yRI39tqmbL5wLq4zwNwpyVD0jUAJyN/1VoAGF7AMZI/iZM8z?=
 =?us-ascii?Q?PnlpWSol/x0S4/jdYfzILJe4vWmjLRiroRMWTrSofRzTP4D0xAhFOXrM2R2k?=
 =?us-ascii?Q?wF+PUh9brEH7oeUiKSIYY/c2e2pM6wa8nGnJ9w2TvHG6zU1crG3Yfpa84ROY?=
 =?us-ascii?Q?sfEDTN63rDpmhM1iJnINwv+9SH1dKf3ZiPH0ixa7?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9041ff3-0e01-41b9-5e9f-08dc5eee9cc4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 14:56:50.6570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SUle8McURmGVJ9BQL1pMevVvsnCSYIoJGCAiOlwnA3JbcL7IILWyBt6cFOZnBg3dMECnI8dHBcogxEHJ1UyqEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6155
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Apr 2024 14:57:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15572

On 16.04.24 22:58, MOESSBAUER, Felix wrote:
> On Sat, 2024-04-13 at 12:01 +0200, Cedric Hombourger wrote:
>> Most devtools packages are architecture-independent and should really
>> be built with "Package: all" instead of "Package: any". Bump PV for
>> all affected packages (to be "apt full-upgrade" friendly).
>>
>> Signed-off-by: Cedric Hombourger <cedric.hombourger@siemens.com>
>> ---
>> =C2=A0...g-secure-boot-signer_0.1.bb =3D> ebg-secure-boot-signer_0.2.bb}=
 | 1
>> +
>> =C2=A0.../{secure-boot-key_0.1.bb =3D> secure-boot-key_0.2.bb}=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 0
>> =C2=A0recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc=C2=A0=
=C2=A0=C2=A0=C2=A0 | 1
>> +
>> =C2=A0.../{secure-boot-snakeoil_0.1.bb =3D> secure-boot-snakeoil_0.2.bb}=
 | 0
>> =C2=A0...snakeoil_0.1.bb =3D> swupdate-certificates-key-snakeoil_0.2.bb}=
 | 0
>> =C2=A0.../swupdate-certificates/swupdate-certificates-key.inc=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1
>> +
>> =C2=A0...-certificates-key_0.1.bb =3D> swupdate-certificates-key_0.2.bb}=
 | 0
>> =C2=A0...tes-snakeoil_0.1.bb =3D> swupdate-certificates-snakeoil_0.2.bb}=
 | 0
>> =C2=A0recipes-devtools/swupdate-certificates/swupdate-certificates.inc |=
 1
>> +
>> =C2=A0...swupdate-certificates_0.1.bb =3D> swupdate-certificates_0.2.bb}=
 | 0
>> =C2=A010 files changed, 4 insertions(+)
>> =C2=A0rename recipes-devtools/ebg-secure-boot-signer/{ebg-secure-boot-
>> signer_0.1.bb =3D> ebg-secure-boot-signer_0.2.bb} (96%)
>> =C2=A0rename recipes-devtools/secure-boot-secrets/{secure-boot-key_0.1.b=
b
>> =3D> secure-boot-key_0.2.bb} (100%)
>> =C2=A0rename recipes-devtools/secure-boot-secrets/{secure-boot-
>> snakeoil_0.1.bb =3D> secure-boot-snakeoil_0.2.bb} (100%)
>> =C2=A0rename recipes-devtools/swupdate-certificates/{swupdate-
>> certificates-key-snakeoil_0.1.bb =3D> swupdate-certificates-key-
>> snakeoil_0.2.bb} (100%)
>> =C2=A0rename recipes-devtools/swupdate-certificates/{swupdate-
>> certificates-key_0.1.bb =3D> swupdate-certificates-key_0.2.bb} (100%)
>> =C2=A0rename recipes-devtools/swupdate-certificates/{swupdate-
>> certificates-snakeoil_0.1.bb =3D> swupdate-certificates-
>> snakeoil_0.2.bb} (100%)
>> =C2=A0rename recipes-devtools/swupdate-certificates/{swupdate-
>> certificates_0.1.bb =3D> swupdate-certificates_0.2.bb} (100%)
>>
>> diff --git a/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-
>> signer_0.1.bb b/recipes-devtools/ebg-secure-boot-signer/ebg-secure-
>> boot-signer_0.2.bb
>> similarity index 96%
>> rename from recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-
>> signer_0.1.bb
>> rename to recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-
>> signer_0.2.bb
>> index 57ad1be..83289d4 100644
>> --- a/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-
>> signer_0.1.bb
>> +++ b/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-
>> signer_0.2.bb
>> @@ -16,6 +16,7 @@ DESCRIPTION =3D "Signing script for EFI Boot Guard
>> setups"
>> =C2=A0
>> =C2=A0DEPENDS =3D "secure-boot-secrets"
>> =C2=A0DEBIAN_DEPENDS =3D "sbsigntool, secure-boot-secrets, faketime"
>> +DPKG_ARCH =3D "all"
>=20
> Hi Cedric,
>=20
> you are missing the multiarch specifier here, as otherwise this package
> will not be accepted as a dependency when cross compiling.
>=20
> Setting DEBIAN_MULTI_ARCH =3D "foreign" should do the trick.
>=20
> For a longer discussion about why this is required for the arch=3Dall
> packages, see
> https://lists.debian.org/debian-cross/2024/01/msg00012.html
>=20

Done that in next now in order to unbreak the pipeline (in this regard).

Thanks,
Jan

--=20
Siemens AG, Technology
Linux Expert Center


