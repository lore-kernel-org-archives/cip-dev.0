Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66053E91265
	for <webhook@archiver.kernel.org>; Thu,  5 Feb 2026 14:23:11 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.10])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.21823.1770301385748489549
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 Feb 2026 06:23:06 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=Z5Iw7Lhf;
 spf=pass (domain: siemens.com, ip: 52.101.69.10, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KsCKEaSpHyaflR7QkPm6vV46hMS1ecDSgxOtD0nrqQYTDwSd+vQoR6vAbYBVrwbkgVIw9CAqcN4O1U5GhziWe+C0k+sg4E+ZhaAAYEHSVme1ZVThFQVkcnFWoM9lTgWLWMmCTK5IbdtXVHnk6A7Wc7EMmPkn1gtX/LnK+X75ZK39zi6nQLFd18I01itqMrmxNZbtCGtLiN7AnIbOyLyZ3MuWViCaUXLht72tO0dqoKObZ5i7xls2FkXbDpIHoTx8A5Chqc101LAoDYp3KoT9KuDxz7xlB+wAPcepoDi74npSepaasLWQnwKOhQMs2EZA7Mu+SKg3x3TzM5EoS61ZhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z838JVgV9hmaCZyIFBoRoyWD1ppsxl60JFvuy0Wzv60=;
 b=cFmXBQkEAT1Ket5BTicuE5i5nTIliSUUggPMY3l6oNFPMlBOVxcadTC5WZzTfK1xYZ/KnQGLnQkM6dIxK7hm1y8eKXx+4rPtTAI+xFPTXWH+Zx7TZzSM6CZ9zBZ/8rkOhQXyMJYiKcwUgvs+lS4wjwjJRM6Aq00qSwMM+IwOJNz4U8arzqh4tww9Kg8+0Ke8igrlvalK0ffav4d0Lua3OvfSm4nH7Y0Pr/KQy391rkeBaS5urrx7ywtzhIeFi+jwzBErdFKl/s2h4nPboa31RwKfipACs24B+rOkh59oTeYWQOoOnNCLbzBCAqRZesrM4wP+0JhVw9rgJL+eoRDuYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z838JVgV9hmaCZyIFBoRoyWD1ppsxl60JFvuy0Wzv60=;
 b=Z5Iw7Lhf5MbrztSUzuamc8w9RRLzbsMpDtTygkq4SgGF1aNIzg6GlYLVjhqBncdiLFNCkqoSNZ21KW7YJfAxjM3KdJn4l9QBIGNcp488OH5UMTTYLi3JSs1Kucapj+rmYdW40Ika/Nqu1nR3moUiFTPxhTxPb2dJCwq+j0NlEDfsiVc5nAOusBdKYJeRnRD3DmBWog4jRRH/Leya38kQ3eqmqjzUihsYlhQfsWdXLixqafT3FhyUKVxzrOHqWixtQXvBnPav2E+LAXgfwN30ST8fSopEwfcYAXzEnqzXRa9TduGJ2jkgbJjZXMJR22xE3AoeECkhd8riSzwsqbABfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:89::19)
 by AS2PR10MB7478.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:592::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 14:23:01 +0000
Received: from VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b57f:1a19:e3c8:fbb6]) by VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b57f:1a19:e3c8:fbb6%6]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 14:23:01 +0000
Message-ID: <35d9181c-ab62-4ba2-99b4-9e4c027bbb8e@siemens.com>
Date: Thu, 5 Feb 2026 15:23:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 0/2] swupdate: Enforce signature
 verification
To: "Heinisch, Alexander (FT RPD CED SES-AT)"
 <alexander.heinisch@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "Kiszka, Jan (FT RPD CED)" <jan.kiszka@siemens.com>
References: <20260119162444.672037-1-alexander.heinisch@siemens.com>
 <32bacc829a084a0ea04f52ccc568e3f2adb27acc.camel@siemens.com>
 <442bbdc5-5d46-4ce6-85be-dabe01ce52e4@siemens.com>
 <d0d12eedcd058d076a2b4ee16240d3f3f1f72329.camel@siemens.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <d0d12eedcd058d076a2b4ee16240d3f3f1f72329.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FRYP281CA0018.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::28)
 To VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:89::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR10MB2319:EE_|AS2PR10MB7478:EE_
X-MS-Office365-Filtering-Correlation-Id: 44016273-98c4-41bd-3259-08de64c21163
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?QXj5Vb8cqV7kcxdACO4nsFSvfglyEcG049W+CSYI3Kj2sIX4v1blxMYa5lqb?=
 =?us-ascii?Q?/cicKeSbL5tMfYqSiWgYz9AKQKssjCnUzNYQeZaF9II9j8ndZ5qkoHE11pLM?=
 =?us-ascii?Q?io8G28Ll6Pci2ZL7YS4NYTHqokEnQ0wbQbSH2AbK/IGztRMpqPvGY9OGljFS?=
 =?us-ascii?Q?xHjV8vPUHobhdymdyLIau3SbNqWnV0mDAT5S5F93aX6sF1I/G1mrlupfSWAb?=
 =?us-ascii?Q?5yYWTHjakbUebVeasJN8EvjWZSqVt0CW9OmAYQq3vWz5gmwqvXvFPpi1E5rP?=
 =?us-ascii?Q?7O//dxW/ZhU3D0mi2VOqEyRR/mtCQkd1DZS9bu6FmfIoImAaYFJy5DFna0Mg?=
 =?us-ascii?Q?VTE31gEuvFcKttnIznWUF3RbEvS1gXmF8sePOwnYuJ4sMTvhI86BYCRuS9J3?=
 =?us-ascii?Q?6IUYqH8Y3voxQ0nK8E6WQRZtCNW3NYFKeQNqnTD/i2XLShF+KwaYUJMVtjcv?=
 =?us-ascii?Q?IKvtdUEZmffC29zXvws09JLTc34NFeBRFwhiN0VNS4Y9/daz/K66eUWtW26P?=
 =?us-ascii?Q?snpSeG5oDbqP8Uus41u1lzS2tlld1c60vE0DbqS0WpTm2zIRQegYEYajvDOX?=
 =?us-ascii?Q?hgfXBIKfFtd+JwHnsqiDaLHG7d6yv7T2ww4XtIM/2J/pu21oRiEHamaZ3gda?=
 =?us-ascii?Q?h6zHH11B3YMvlTRy7nl9qp7f7tM69xlU/VKs+g6A5aDuut6HHgVwFVXOKg+U?=
 =?us-ascii?Q?ZK5IHRbFTF+Q7sH2ZNxPViFo3nwmD0LfUUc6CXmMG1NbQri/qiGGgATpejpT?=
 =?us-ascii?Q?2P4OqcFK6nSlk65WY++qK2zmvhe6sEmUyG8vTNOnymUKl/YGKNdbFGSY5WWI?=
 =?us-ascii?Q?rNPB6a5yRHIW/pquDl1rCyM+uRgyoypQmSFAz8zO6o4Ew/PewpZ7WXrEqgsQ?=
 =?us-ascii?Q?mcBKvLjlQoybaXai7DMRasjDtVzR7g3va7tAk23tfeyJPqRlCxyVMPghzxua?=
 =?us-ascii?Q?4b164FaqoUuOIT+57RmUIT4tcGRPjtNke31lV9L/Mfc2EeUZouWhszMVea9c?=
 =?us-ascii?Q?AXr5ay8VwcxWDBwbXiPzukpofHfDS6qQO90qm+zWvP37wF/12Xy7BlItLpQ9?=
 =?us-ascii?Q?PsIFiLw24s77mhiz6s0hkZqOZ6qTYC4X1vrKmHCvpcSNmr5l+AO5LeW5XncA?=
 =?us-ascii?Q?P5GdbxRxfgCiVjk1XjCVAqCLkx21gLeUC208csDPaDODCfjDCmtjaivdP+dZ?=
 =?us-ascii?Q?5Ua0f3j4N/wrjr/ucR3l92qAEYvDWVxfGGZd8QI9y3GweL4jWa10xVjYK7e1?=
 =?us-ascii?Q?rgC3sLYQ6RQOs3Zs7Rc3fKOfuDsCMzuNu6YMLYkNNsc5juOpiRM929V0RcXL?=
 =?us-ascii?Q?pSXmbz0ULEfpA7TwQURYXOJu6QNPRw4fvC9fnCEaELcs4LxXKfOIHk4WD47F?=
 =?us-ascii?Q?MNl/CGM2t1lBbN2SDFeLqFl+woc+gxWX/CtvrqnATJ0iiqm9zpKNDkwP3IAy?=
 =?us-ascii?Q?2IME3vIvKGC9r0kTrJWHVn3pW0rzHoe+i9IzNa/7C8SpKLrl54F1BTF8PWf/?=
 =?us-ascii?Q?1Evj7f7loITyYCL+oyirYIi5sXd51lt5CzCnoxrpXFKt4HjssqZB7dGQi1Ut?=
 =?us-ascii?Q?oKzmq6uQjejyp+zpQts=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?a5TlaDe2Fi0wGqRUx1MTenpFZCLTtUzCznQIQ09iVBpsoXigheQWxqNkZihM?=
 =?us-ascii?Q?b2N98b3JPfZ1Fp0ogaH570giBnTJT+hqgtltzUwL1L82gQvW/D0qBmNG/O4A?=
 =?us-ascii?Q?aFvaEq6WIih9a3v1/1R+pPk52SOhW5k3SBVFtfU0wjvD9GBe5p3Zx32/03D5?=
 =?us-ascii?Q?9gShQrFzqzQNQTQyRj05U93ir0xWMt4PBnVuBomUmIQOsZUBMDPFXtFY1xY6?=
 =?us-ascii?Q?AihQDuOg4qZRv/2kOQxnMQG6yZaf5jpOIcI0KTEveJAVEMKXAxD6ZkeVmifR?=
 =?us-ascii?Q?TB5c6F8NKN1s36wB+5wsQUoLPCfpnSc4PxLatdOYqZkGIKUhp8zEw3orAhdC?=
 =?us-ascii?Q?A+q0sAsvVg1//nE2ss3mU6g7X1BmhQAsxLKSWkiBztvvvcgqceelOKr5WCyx?=
 =?us-ascii?Q?IPLC+9Q/9iNtPgMBHH8BzQSAztksKLVC5Isp0Ekd1FXmNWvqcpKpt0Uc7DcB?=
 =?us-ascii?Q?OURd1gRnze5ylJJ62Jg6mcDojpVTEQA4IIoG8mN0Qp7S+Cddor1YhRBs40o2?=
 =?us-ascii?Q?nBUkFev2BdjSwfwyshM8VEH4i/Hplo0QuBRa6xTJDkMZa2uq6xEyEgDbhllG?=
 =?us-ascii?Q?PvIMYVvsnFcbdnukDUXm9i3lR24sXWNSMpak0A3+z9W0EbyVjXoFTgogAaNd?=
 =?us-ascii?Q?GDo3CAR6QyqWAwTs6fHArzT1o937Uuk1/OBg6A8JJfT95iBgPHXX2RDkJy/8?=
 =?us-ascii?Q?6ZVhbdR/49sV8bqJ+2Y/FbAZnx2fPmOtJFN7HWNT6CnYUtLtKu0htyPp2L5D?=
 =?us-ascii?Q?fDb2kOny22A8mPlT7SmynbBxTbEMlIVjJntr+yjUtwNkQmCP+LT2kpVyfF5y?=
 =?us-ascii?Q?PCdv/9wHPnDutQgZ7xOYu+f1ZVvL7CZFMFiOo9Kd/oFtB/ZLl3KXJ13N8CkX?=
 =?us-ascii?Q?D53sUd68CuWDv8TTjPlEE+qhEREUQJoa3Nf3DDu/VArMPjIjkzRR9Y1XSg6I?=
 =?us-ascii?Q?5evJqYxjAb5rM3pwLxZ+Tca9164ORruGPF0C/pIubj+/xV96kLm9i++jKeUS?=
 =?us-ascii?Q?utViVyPOsAyxe4IxOifPE1hwGj21fD4ofZfGC0uusyYBTjV9nc5L8YQxEsiL?=
 =?us-ascii?Q?/TdtQaZCWEznn2dzBMg51vHrINcvOtgtDZIFh0OK8vV1lMFfMDQbBc8GkoJz?=
 =?us-ascii?Q?69Abq5877peiyO9mhBW+fOmaLo4xBCTx7WWrcr88HXshPLILfdjpbLTgqWya?=
 =?us-ascii?Q?4eH5SU/1XwSaBrxv+sYcch5GQKYGTj0JyhXcSF75zmFJBsUdtAowG2b8CVji?=
 =?us-ascii?Q?aBgoTMxuhV1Xhr62Mb4E3r4oDsWYCWhFrg4Yn70++dovYW0qGwenbx1U4DKg?=
 =?us-ascii?Q?VPxsUE5+5gkrZjQmN5pdquctTSrh2SnpPXaHUzoNySIfSex84Eoh0/0XRFUI?=
 =?us-ascii?Q?t+sJdU9pnZGQ2zuno6poU+Hr0clbdWdh5mVVPeDf1RWglwGVBi1isqiC0UI1?=
 =?us-ascii?Q?HMO8fNUyiC16IWSq4wmGvQBwnwa/bAP796e8ZfeB3M1Of55WZuMA/rh8efzK?=
 =?us-ascii?Q?7F9jvagYbOL8hNgFP9NKef53+yjtblLUNu6EfzoCmThXWTnIgewrxs1iqu14?=
 =?us-ascii?Q?dYnX2RSBmNctUkk8uhMxMiCFzuGAUoTB4bBGD6yiAU0kH3RSNaNUhegj4GRT?=
 =?us-ascii?Q?HzBHYvw8cmRp8lMho0y2o+AftgqENzhNNQwloYiYwQBX3sS4fzucdxltBj8U?=
 =?us-ascii?Q?WQW/bSoHYqg2RdiS91X7hgJBbFYjLsmPAoPDuOWLkDZiSfWNIAFJuZ6golzO?=
 =?us-ascii?Q?tkEi8ZtdSfgdWZHYB9FnhASi8OsO0bU=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44016273-98c4-41bd-3259-08de64c21163
X-MS-Exchange-CrossTenant-AuthSource: VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 14:23:01.5768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4cSmtvR/I/zGPJZHMpwG5JHVJxQnu3H7VPT10tzYNEMs9qR9aqs7f6sXsctSCQ1YsSllftcGNIq479C7PSAuyI7ASGC0dogC886VQVp/Sss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7478
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 Feb 2026 14:23:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21839



On 1/28/26 7:01 PM, Heinisch, Alexander (FT RPD CED SES-AT) wrote:
> On Wed, 2026-01-28 at 15:44 +0100, Jan Kiszka wrote:
>> On 28.01.26 12:15, Heinisch, Alexander wrote:
>>> Any comments on that?
>>>
>>
>> Quirin?
>>
>> And why do we need need to flip SWU_SIGNED in both kas configs and
>> the
>> recipes? Isn't the latter sufficient?

SWU_SIGNED is need at two points:
1. for the configuration of the running system swupdate-config
2. During the build of the *.swu where the signing occurs.

Due to this you need to set it in a *.conf


Quirin
>=20
> True.
>=20
>>
>> Jan
>>
>>> On Mon, 2026-01-19 at 17:24 +0100, alexander.heinisch@siemens.com
>>> wrote:
>>>> From: Alexander Heinisch <alexander.heinisch@siemens.com>
>>>>
>>>> The self built versions of swupdate (used by default in distros <
>>>> trixie)
>>>> do not enforce signature verification.
>>>>
>>>> ```
>>>> $ sudo swupdate -n -v -i demo.swu
>>>> [DEBUG] : SWUPDATE running :=C2=A0 [read_settings_file] : Reading
>>>> config
>>>> file /etc/swupdate.cfg
>>>> [DEBUG] : SWUPDATE running :=C2=A0 [read_module_settings] : Reading
>>>> config
>>>> settings for module globals
>>>> [TRACE] : SWUPDATE running :=C2=A0 [swupdate_dgst_init] : public key /
>>>> cert /usr/share/swupdate-signing/swupdate-sign.crt ignored, you
>>>> need
>>>> to set SIGALG
>>>> ```
>>>>
>>>> This patch series enables signature verification by default for
>>>> swupdate.
>>>> The series is split into two patches:
>>>> 1) Build swupdate with signature check enabled.
>>>>  =C2=A0=C2=A0 This simply fixes the provided demo build configuration =
in the
>>>> kas
>>>> file
>>>>  =C2=A0=C2=A0 (+ ./kas-container menu).
>>>>
>>>> 2) Enforce signing and verification for swupdate by default.
>>>>  =C2=A0=C2=A0=C2=A0 This patch modifies the swupdate configuration fil=
es to
>>>> enforce
>>>> signature
>>>>  =C2=A0=C2=A0=C2=A0 verification by default, which may break downstrea=
ms relying
>>>> on
>>>> unsigned
>>>>  =C2=A0=C2=A0=C2=A0 swupdate images. However, the diverged default con=
fig for
>>>> signing
>>>> and
>>>>  =C2=A0=C2=A0=C2=A0 verification of swu files is probably not desired =
anyways.
>>>>
>>>>
>>>> Alexander Heinisch (2):
>>>>  =C2=A0 swupdate: Build swupdate with signature check enabled.
>>>>  =C2=A0 swupdate: Enforce signing and verification for swupdate by
>>>> default.
>>>>
>>>>  =C2=A0classes-recipe/swupdate.bbclass=C2=A0=C2=A0=C2=A0 | 2 +-
>>>>  =C2=A0kas/opt/swupdate.yml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1 +
>>>>  =C2=A0recipes-core/images/swupdate.inc=C2=A0=C2=A0 | 2 +-
>>>>  =C2=A0recipes-core/swupdate/swupdate.inc | 1 +
>>>>  =C2=A04 files changed, 4 insertions(+), 2 deletions(-)
>>>>
>>>> --
>>>> 2.47.3
>>>
>=20


