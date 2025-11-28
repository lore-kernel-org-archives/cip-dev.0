Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BC1CFD376
	for <webhook@archiver.kernel.org>; Fri, 28 Nov 2025 10:08:29 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.55])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12891.1764324502285433750
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Nov 2025 02:08:22 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=0KPXqXCQ;
 spf=pass (domain: siemens.com, ip: 40.107.159.55, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b8BxS0YD4pb6yfOQOgsA7hiccCakuL1Yf34zSQ5kBYOrjJ93aaME2yqClWH0fv4IjnPPIGm1dl8jR0vaVNmDUT1/YPrTiWVVnxUlKYFvsQGaAWQB4bnAscCyz6qYgKt+RTMu8jszqx5n4U1USzV5c83WEjK96OgiwMMZsccbp4a0cGALg3gz5AsN6BZNYxZJJgCwDwcobXcqezTvS8MNXqXIEUx27kBQuuC18PV+GwBl4/HO2x/mW4s39ZFRSZbzt2yBKAb288KGv2RMblBoKUg3KjQe7cpD2eWW/tVrCSLtPhrqilzJtoS24kz8fhKac584tnRwVtM2oRTlm4nnbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TGi/BXpjjoexHiM0mOdKYteLxOYpSevci/CFPdoMdn0=;
 b=S0ePcnwgG3boFcbLKJKoDpK3S183uhm9pBCVCBB2tNomwBz/oCSAYtuMOJ0tpb4azyXMW+9/6pQXcbAv030q5MkUxSzFWIepCBWwxFCX12lJrztCYTP+vCgtqJzUqP0JZEC0FSuXMeOhdpj6Lki+erzEPFmWKA+0L1+eIi8xSC9vHoZZqbolp3SnlU3CuSrs88mD6c1jvN9JfXDZW+lVhlhj9L1XsuxkM1kKUkvabGS2xgrB74ya7NE/CRzSK63DsKCIU3jQiIcaKBGp29e1nsHoE775tEDvhAksSd82xAAfpfawgXMxsu6r0XJPbhO+T6RNo6zTNKRN2Rq+P1h40w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGi/BXpjjoexHiM0mOdKYteLxOYpSevci/CFPdoMdn0=;
 b=0KPXqXCQPTA6Lu5iu1SMilH+lxrRdXyUnYg3bc30D5Cc9N7fE+Pal+Rbmol3zk2cAj24ufeH0Wi5+p8OHUabq/K+XI6+dH6NqVQxu3SvC1ZSbgfbpMW6nu0NYvygLGUQtTkIDFE9zgIoeAbwJmJRDouJ9FPjZcNdEyAv/waD3c051xFiJCX2mBiIyFDvDMhlPehj1psibcPoioUuY0r31qmMkW1VBswD4RXx/WaaMcYBw4XPeSSLcBZUmAua4iXmOPUjOLnxlafGHIise5XwgGNj2DpLcpiqX4+x+L7vEuCMC4Az+jdbbPTZmdsc7MsGhmKHfxFGQCYLNhV4KFX8ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA3PR10MB9359.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4b8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Fri, 28 Nov
 2025 10:08:18 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 10:08:18 +0000
Message-ID: <fdc383af-5e2f-45b8-893f-97e884879a43@siemens.com>
Date: Fri, 28 Nov 2025 11:08:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][PATCH] fix(security): add
 libpam-systemd in Debian trixie
To: Shivanand.Kunijadar@toshiba-tsip.com, gourav.singh.ext@siemens.com,
 cip-dev@lists.cip-project.org
CC: dinesh.kumar@toshiba-tsip.com, kazuhiro.hayashi.f74@mail.toshiba
References: <20251124050607.876836-1-gourav.singh.ext@siemens.com>
 <345f8c1e-0166-4946-893b-02dba9dd71ce@siemens.com>
 <KL1PR0601MB4697CEAF6AACC78EAB99E5CBD5D0A@KL1PR0601MB4697.apcprd06.prod.outlook.com>
 <e3ea7e4e-7679-4ddb-9074-fab4f51c8c8a@siemens.com>
 <KL1PR0601MB4697F954236371E6E07F0C35D5D1A@KL1PR0601MB4697.apcprd06.prod.outlook.com>
 <TY3PR01MB11075803A132ED49E1CFE0D57C7DCA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <64eda5df-e366-4ab9-bde5-20d1e427d043@siemens.com>
 <TY3PR01MB11075E06A9A10AF30623A2C4FC7DCA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <TY3PR01MB11075E06A9A10AF30623A2C4FC7DCA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0223.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA3PR10MB9359:EE_
X-MS-Office365-Filtering-Correlation-Id: f1aa235d-fc21-46c0-49f0-08de2e660d73
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Tjk64MvhgR0TGzH9eG6jbFQoiyvlzqjrNiuJjhgQ1Xf2aMDrEiOr4fIUQadf?=
 =?us-ascii?Q?9ko7214y6LgloDipHo1KIUZkIttajNdkoh0AiFZvfByHv3iKHH2wZidjfS/H?=
 =?us-ascii?Q?9ps/lT81YojjwDsGRXCSkXGC79pSI6OjS8Uw5mBBRYQzqPu4tQ+t+XAZRi0P?=
 =?us-ascii?Q?deCx3G5cHjAGPAxJ8pzUVzl5bt60AuPfvK7f1FsOEMcOtwPfimoRfks5e0if?=
 =?us-ascii?Q?0tQNWppdp1R1rK8AjPvC6itlWXHrC4ySEfrBZ/c88lb2aeiA1fHQIxhToL9h?=
 =?us-ascii?Q?42AsGga2BijRkZRdNPfndm9ohLNNriQ/lxVek8D5nhgkOLpdRwAp4tRp1Ji1?=
 =?us-ascii?Q?ztH7mrq6IMVkz2FhIOtuQQQNI+e2u931ynlTG3jdRIstrAOophonr9kn7bKn?=
 =?us-ascii?Q?JD+dvz8OEVGREVCGncmI97jJd9QtP4m0mkZv+S1wC8jxhOVoqh2eFY0LnFGL?=
 =?us-ascii?Q?DEBwGqUNNhbBefEM4Vobs2mL+YWbXzmM6lSoSc5VIKjcIheBux+JlqBso/OZ?=
 =?us-ascii?Q?aGu+t7XG6KOqUBpanFCj4pZVSRmw8NCez95fY6TQAViFZKef1JvvHk/5QEXn?=
 =?us-ascii?Q?yz948Ocoznm8tqX2/eyAaSlN8zdc0nTHE9++JQk1Ahm7oxJsOSWG0b6zqt0c?=
 =?us-ascii?Q?iaX5Y4M6eM+SFlC5JJyBrbtsSRDHH2veGhVCeavcE/MuBfyvOjn+cOUO58BE?=
 =?us-ascii?Q?9ULUewLpTInxjUlpsaR4fC9pNc3wrvfkQpb0TynFwoMjV4YgMn5JjL72X32C?=
 =?us-ascii?Q?76mLibOLbNCLdqrQXGZkWzZh+UVK4AnwE1KTwKAeWGaDmqIhoR3qGTfN4IFm?=
 =?us-ascii?Q?zds/2slURhmnpF9azC34LoHeCMx/dbTKk9UThDYLC+fTw7LOKCCZYhHdQuTY?=
 =?us-ascii?Q?Y9IfHBg3LkANPaBsZoj752W1zAF5OitmqErhkdpCPeWoqlCFtvvhA81lXdi+?=
 =?us-ascii?Q?nDDLh7Hdpz6WOjEMJENLuyDJQr18Vev6MZFc19U202xCRsXpLnHch8ZEAGBW?=
 =?us-ascii?Q?srr7q0ejVX85QfxNM9MTvLz6914xWcd6hGRBLMQsz5fmjmQZcmjLm2q7dH9s?=
 =?us-ascii?Q?B83iMg6r8Q/C2jehZhNSUwb9cps98msxepD8qCu0CT1A5tYR8KQH9WriSlz3?=
 =?us-ascii?Q?ZB2ro1f0OEI+/giPGMUQfUEBK3w8mJbzxUXEDZPHSnkJgkieRyQjh+kYv8pD?=
 =?us-ascii?Q?9RDxcmAZ+E9TurCutV0DrzoiTVWA/YSFPbyK3T4NCpUILe8150e3lNsngk65?=
 =?us-ascii?Q?71z68PY0aJWNUUPhtIxIWl3IX2T5aCTrkrFVRgpfwnx2sTzkx7Uj7FAEb13l?=
 =?us-ascii?Q?Kxx3jqrG2jSUpOndyiyfEdmNo5q86MfW8442n7HKJ/n6DYigs2vFqKJKTyQF?=
 =?us-ascii?Q?ykiyZf8HVBuw7QpZDgg1FnlkWkMtpBX79P2ban6eHM/iGb3E8s6ZOAeb/2NC?=
 =?us-ascii?Q?OpAv1kttcUUn2TN5W0L6fPc41wXTopQ1?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?5dkL8kLskFv99h2T0DM/uSuBhnCrwTOb/6ixegqxjbWF5Ba8RY/606+a0156?=
 =?us-ascii?Q?UYbqZqnpGwfVIGKGSqA7uanKB3+ztL8jtpEHlK/+yJDXJL1wHlUzem6lO6BR?=
 =?us-ascii?Q?lZ1IgYE9gvuBvetA9ERaaCxPpGnQBxwzxBBqNuXZC21St1itwjXcVqSQMUXt?=
 =?us-ascii?Q?6LdCJG0TxHjB+Lu26uTnJHDOoEbdPiDzcuyb8QmKjAxYQzdwfjSZbgyZHz/+?=
 =?us-ascii?Q?gDNbMds4XcmfRiTAj5zEb2WbKbAbvi/5wHt6GPARcjQEKgdves0pGxHMD4Mh?=
 =?us-ascii?Q?Hz4e2fxD28XRPQaLulcAPaMi8q3Z1aP2bz9PavqQYC1OmuW0aT5fUMBoUCdL?=
 =?us-ascii?Q?TaV81T/vcnv8MFomjtg0NJ104+qH2a8guK4GbDMDGPiOoq7aNe9dHwNHksT7?=
 =?us-ascii?Q?+4UZK8eQKNEU1LE4Uu4j6rpSHq8GbEBkuaQrr8yyFS2Kq4FJMGgw50Eetn5N?=
 =?us-ascii?Q?uGdLriavgwtWgMjNSl9U/EZ0z3HdEbV3bg5DQLWYzB94E7J4Pw9wASZqulEx?=
 =?us-ascii?Q?emHyNfXB+81xX75MgdRFBC8vfK3oaxU6iL4VBCyQNAjV0Px6PsQ8wtbkiWpI?=
 =?us-ascii?Q?wBTNkbDT41sxG/K5v/RDraMv+kAZWos/NDCbLzMNsR31AJhO0Hz6jF5LHvQh?=
 =?us-ascii?Q?n792dxlWx7O5Mm5WFXnmU1rG+tjqQf256jLjjWiYBUcrdEF6tbK13hlLrcul?=
 =?us-ascii?Q?8Fi0oFS6bA7cTzLV530TaoS7TVNY+hbVRruOoJm8+12VcpXdck/NKRMjcbdZ?=
 =?us-ascii?Q?5/mATlG5GJa1dy0/9Hc/PuUiE7vWnqOy+HtgiDMtSUh6J88PCgqba3EGULty?=
 =?us-ascii?Q?HCWjTamu821f2JoSwC0w+8f/4P1optoOFcm0G6v/mfRHhlQZzlHQ7ody1VIS?=
 =?us-ascii?Q?iw1yRJPp+s91hl9i2b+RVWSXUEF1hWY5++YmjHDUgRJScbw5B6i/0X+GD87B?=
 =?us-ascii?Q?Rm2MDsIi/yN0eGADVJBpQ5o23W12vDOOGfCNewxQd7rt413zV/74Gb5Y6tc6?=
 =?us-ascii?Q?LR0GAkSqhaIp9EyDKndybc3BHb7i0AxIu04BLhaVnoKch0RaggmQjOnc/kOv?=
 =?us-ascii?Q?24DnvtmbdL+1r0bM5l9yqN5hGAM4lXH3IK6BIu1Zr5K8LFVyl+DXYkMV8mFg?=
 =?us-ascii?Q?CveKqKw6mYMxk4vET4WaFVrH9rmpOp3WWc+b6z22WlbWpGCoaPnolMm1mtVA?=
 =?us-ascii?Q?Dj5suTGm0Bx9ONx6ya8FT34u3FoOGkTTcyOOk3/3yTxmcphMm3F0Z5nfG3cM?=
 =?us-ascii?Q?Mh+FtqhfptAmDSMh041BZvpgT6ILfw0jFUqY6bEcSzpaXtfgsoppPDSxPnKd?=
 =?us-ascii?Q?vKmpz07YWDKHYFAR0YpE/5vkCWoU+H+f2ZYRvTfUGMzOsZ3TEz2Sd3OOKEJV?=
 =?us-ascii?Q?wTwtP7TELOJ1oiAUFuFPto6pPdEojPgd0Qdrd9K20sSrGwCmMArU67aEzehm?=
 =?us-ascii?Q?8P99hm5N08gBnolHWcAWw/bViz8yLptYWlWf8eUaOj6CODGBOCpHVXc96zWY?=
 =?us-ascii?Q?sQhHAvdIg4/sbCwTGTb/DuiL6RzeqH4SB3LklKUrj0rNIyQS1c+UuH4QYz/L?=
 =?us-ascii?Q?aGOGNUq7h/Js0g6gEgZKPn1al8VTcGkl3meK7lq237rlfAFbVzXLMgtz6Za8?=
 =?us-ascii?Q?bQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1aa235d-fc21-46c0-49f0-08de2e660d73
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 10:08:18.1763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J0EcOU3veiZK3AVVFmzYV54ie/Fu4CBUsjSs05yOmftfBxe1fuMMciXEQ+8P5BfJpzgzGcwPq8TdBR/3x1iNhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR10MB9359
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 28 Nov 2025 10:08:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20763

On 28.11.25 11:04, Shivanand.Kunijadar@toshiba-tsip.com wrote:
> Hi Jan,=20
>=20
>> Then you have likely already seen
>> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commit/321c401d1=
de763ab9b7c7afb0c13d26f0a70b7c5?
>=20
> No, I didn't test it on LAVA environment.=20
> I've executed IEC layer tests locally on QEMU to confirm if there are any=
 test specific issues in trixie.
>=20

We have an inconsistency there that CI tests uses tcg so far, but you
silently switch to KVM if you try to reproduce locally. Will start a
separate thread on that soon, also be cause not all workers have KVM
enabled and need fixing.

Jan

> Thanks & Regards
> Shivanand K
>=20
> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Jan Kiszka via lists.cip-project.org
> Sent: 28 November 2025 15:22
> To: kunijadar shivanand(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 DITC_DIT-OST=
) <Shivanand.Kunijadar@toshiba-tsip.com>; gourav.singh.ext@siemens.com; cip=
-dev@lists.cip-project.org
> Cc: dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 DITC_DIT-OST) <dine=
sh.kumar@toshiba-tsip.com>; hayashi kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=8F =
=E2=96=A1=EF=BC=A4=EF=BC=A9=EF=BC=B4=EF=BC=A3=E2=97=8B=EF=BC=A3=EF=BC=B0=EF=
=BC=B4) <kazuhiro.hayashi.f74@mail.toshiba>
> Subject: Re: [cip-dev] [isar-cip-core][PATCH] fix(security): add libpam-s=
ystemd in Debian trixie
>=20
> On 28.11.25 10:37, Shivanand.Kunijadar@toshiba-tsip.com wrote:
>> Hi Jan,
>>
>> Just an update for IEC layer tests on trixie image.=20
>>
>> I've created trixie based security image for QEMU by applying this patch=
 and executed IEC layer test cases.=20
>> qemu-arm64 and qemu-arm --> No issues, all tests are pass.=20
>> qemu-amd64 --> One fail test out of 44. It is passing if I execute it al=
one, the reason is not know yet.=20
>>
>=20
> Then you have likely already seen
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commit/321c401d1d=
e763ab9b7c7afb0c13d26f0a70b7c5?
> Currently testing in a smaller set, then the full one, and then I will su=
bmit it here as well.
>=20
> Jan
>=20
>> @Singh, Gourav Thanks for testing.=20
>> Let me confirm, did you execute IEC layer tests on qemu-amd64 and shared=
 the log file?
>> =20
>> Thanks & Regards
>> Shivanand K
>>
>> -----Original Message-----
>> From: Singh, Gourav <gourav.singh.ext@siemens.com>
>> Sent: 25 November 2025 16:39
>> To: Kiszka, Jan <jan.kiszka@siemens.com>;=20
>> cip-dev@lists.cip-project.org
>> Cc: kunijadar shivanand(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 DITC_DIT-OS=
T)=20
>> <Shivanand.Kunijadar@toshiba-tsip.com>; dinesh kumar(=EF=BC=B4=EF=BC=B3=
=EF=BC=A9=EF=BC=B0=20
>> DITC_DIT-OST) <dinesh.kumar@toshiba-tsip.com>; hayashi kazuhiro(=E6=9E=
=97 =E5=92=8C=E5=AE=8F=20
>> =E2=96=A1=EF=BC=A4=EF=BC=A9=EF=BC=B4=EF=BC=A3=E2=97=8B=EF=BC=A3=EF=BC=B0=
=EF=BC=B4) <kazuhiro.hayashi.f74@mail.toshiba>
>> Subject: RE: [isar-cip-core][PATCH] fix(security): add libpam-systemd=20
>> in Debian trixie
>>
>> Hi Jan,
>>
>> After applying these changes, the IEC test suite now passes all test cas=
es on the Trixie image. I've verified this on my end, and I'm attaching the=
 results log file for the test suite run on the cip-core-image-security Tri=
xie image.
>>
>> Thanks,
>> Gourav
>>
>> -----Original Message-----
>> From: Kiszka, Jan (FT RPD CED) <jan.kiszka@siemens.com>
>> Sent: 24 November 2025 22:07
>> To: Singh, Gourav (ext) (FT FDS CES LX PBU 2)=20
>> <gourav.singh.ext@siemens.com>; cip-dev@lists.cip-project.org
>> Cc: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>;=20
>> dinesh.kumar@toshiba-tsip.com; Kazuhiro Hayashi=20
>> <kazuhiro.hayashi.f74@mail.toshiba>
>> Subject: Re: [isar-cip-core][PATCH] fix(security): add libpam-systemd=20
>> in Debian trixie
>>
>> On 24.11.25 17:30, Singh, Gourav (ext) (FT FDS CES LX PBU 2) wrote:
>>> Hi Jan,
>>>
>>> Regarding customizations or configurations for the `libpam-systemd` pac=
kage, which provides `pam_systemd.so` - a new systemd mechanism that replac=
es the traditional `/run/utmp` for tracking active user sessions in Debian =
Trixie - it is necessary to ensure that `pam_systemd.so` is included in `/e=
tc/pam.d/common-session`. This replaces the traditional role of `/run/utmp`=
 in session management.
>>> Ref:=20
>>> https://list
>>> s.debian.org%2Fdebian-release%2F2024%2F05%2Fmsg00150.html&data=3D05%7C0
>>> 2
>>> %7Cgourav.singh.ext%40siemens.com%7C69f7415c2bc3402b8cde08de2b77b21d%
>>> 7=20
>>> C38ae3bcd95794fd4addab42e1495d55a%7C1%7C0%7C638995990271096290%7CUnkn
>>> o=20
>>> wn%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJX
>>> a=20
>>> W4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DzbwdGBW1zz
>>> z p3xN5q0UW3qN5o1MXmzbBmJv3uQdILhY%3D&reserved=3D0,
>>> https://ddp-
>>> team.pages.debian.net%2Frelease-notes%2Fen%2Fhtml%2Fissues.html%23the
>>> -=20
>>> last-lastb-and-lastlog-commands-have-been-replaced&data=3D05%7C02%7Cgou
>>> r=20
>>> av.singh.ext%40siemens.com%7C69f7415c2bc3402b8cde08de2b77b21d%7C38ae3
>>> b=20
>>> cd95794fd4addab42e1495d55a%7C1%7C0%7C638995990271126607%7CUnknown%7CT
>>> W=20
>>> FpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiI
>>> s
>>> IkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3D5ry3XapBLPScmMpiz
>>> 5
>>> bdwF%2F9MVx0%2FG6reUH%2Ba5pYxXA%3D&reserved=3D0
>>>
>>
>> This all makes sense so far, and if no one complains, I will merge it so=
on.
>>
>> I furthermore assume that our IEC testsuite will "just work" (again) wit=
h this applied, right? Switch-day for the CI to trixiw is now Wednesday, or=
 more likely Thursday.
>>
>> Jan
>>
>>> Thanks,
>>> Gourav
>>>
>>> -----Original Message-----
>>> From: Kiszka, Jan (FT RPD CED) <jan.kiszka@siemens.com>
>>> Sent: 24 November 2025 12:21
>>> To: Singh, Gourav (ext) (FT FDS CES LX PBU 2)=20
>>> <gourav.singh.ext@siemens.com>; cip-dev@lists.cip-project.org
>>> Cc: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>;
>>> dinesh.kumar@toshiba-tsip.com; Kazuhiro Hayashi=20
>>> <kazuhiro.hayashi.f74@mail.toshiba>
>>> Subject: Re: [isar-cip-core][PATCH] fix(security): add libpam-systemd=20
>>> in Debian trixie
>>>
>>> On 24.11.25 06:06, Gourav Singh wrote:
>>>> In Debian Trixie, /run/utmp has been removed, so traditional=20
>>>> session-tracking mechanisms (used by w/who) no longer work.
>>>> To restore secure and correct session accounting (needed for=20
>>>> enforcing limits like maxlogins to comply with IEC 62443 CR2.7_1),=20
>>>> we can add libpam-systemd.
>>>>
>>>> This ensures that PAM can register user sessions with=20
>>>> systemd-logind, aligning with Debian's design for Trixie.
>>>> See Debian-devel discussion: "/run/utmp is no longer provided in=20
>>>> trixie ... replacement mechanism provided by systemd."
>>>>
>>>> Ref:=20
>>>> https://list
>>>> s.debian.org%2Fdebian-devel%2F2025%2F04%2Fmsg00011.html&data=3D05%7C02
>>>> %
>>>> 7
>>>> Cgourav.singh.ext%40siemens.com%7C13545a99022f43a55dce08de2b25d0fb%7
>>>> C
>>>> 3
>>>> 8ae3bcd95794fd4addab42e1495d55a%7C1%7C0%7C638995638612273708%7CUnkno
>>>> w
>>>> n
>>>> %7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXa
>>>> W
>>>> 4
>>>> zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DtNzGl6b239z
>>>> R
>>>> 7
>>>> GFA5WPQwQwSi0fRIhXp5hQchE7pxKw%3D&reserved=3D0
>>>>
>>>> Signed-off-by: Gourav Singh <gourav.singh.ext@siemens.com>
>>>> ---
>>>>  .../security-customizations/security-customizations.bb         | 3 ++=
+
>>>>  1 file changed, 3 insertions(+)
>>>>
>>>> diff --git
>>>> a/recipes-core/security-customizations/security-customizations.bb
>>>> b/recipes-core/security-customizations/security-customizations.bb
>>>> index 717e2d3..d8fa22b 100644
>>>> ---=20
>>>> a/recipes-core/security-customizations/security-customizations.bb
>>>> +++ b/recipes-core/security-customizations/security-customizations.b
>>>> +++ b
>>>> @@ -25,6 +25,9 @@ DEBIAN_DEPENDS =3D "customizations, sshd-regen-keys,=
=20
>>>> libpam-google-authenticator,  # - libpam-passwdqc: Preferred for newer=
 Debian releases (post-Bullseye).
>>>>  DEBIAN_DEPENDS:append =3D ", libpam-passwdqc | libpam-cracklib"
>>>> =20
>>>> +# Append systemd PAM package to limit concurrent sessions in Debian=20
>>>> +trixie DEBIAN_DEPENDS:append:trixie =3D ", libpam-systemd"
>>>> +
>>>
>>> So, no configuration needed? And does this obsolete any other dependenc=
y in trixie?
>>>
>>>>  do_install[cleandirs] +=3D "${D}/etc/ssh/sshd_config.d/"
>>>>  do_install () {
>>>>      install -m 600 ${WORKDIR}/ssh-remote-session-term.conf
>>>> ${D}/etc/ssh/sshd_config.d/
>>>
>>> Thanks for tracking this down. I suspect that our certification efforts=
 are still focused on bookworm as baseline, but this is an important step a=
head already. I also hope we can soon switch CI to trixie, currently waitin=
g on lava-docker updates on the workers.
>>>
>>> Jan
>>>
>>> --
>>> Siemens AG, Foundational Technologies Linux Expert Center
>>
>>
>> --
>> Siemens AG, Foundational Technologies
>> Linux Expert Center
>>
>=20
>=20


--=20
Siemens AG, Foundational Technologies
Linux Expert Center

