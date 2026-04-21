Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E11F8FA7A
	for <webhook@archiver.kernel.org>; Tue, 21 Apr 2026 13:33:25 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.12])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.29481.1776778397426233491
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Apr 2026 06:33:18 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=La4KoPhF;
 spf=pass (domain: siemens.com, ip: 52.101.70.12, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KvvivQPQ3lcwazv1aEoXorgFhunhgzqk5Id4lx7DzGToI2bwBeXvrp11Ec/h8om8vBOZ/Fig47XBLWOp/bpvBg4c+uyUuYUfQ3RDqeVzVNSoz2YYGd1j+i0HEeicmtOlLfDyf+yY0rcLVNfpy1utgZSAgHZNMZJdqwByOnVNkMtQpGWqV55D+HjytX/BGEN9OZeSO/weNUibR1jfwe44Zsv7yPtj0jZWJmC6rK4SnsZXy8fLt/llSBESRdVVmLOt7hUaWiarkc5kDcVdCgbkN1cLQ1ioFrrg33zQGBFh3NRl1uS3nRjZg5mfxwhY2pcJb6ZuC85WJAG6537E/9oWzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9CRPhK9kXamWz/ts8EtMd0SgwBNTTrECzAl8dLkTTPc=;
 b=Ydcmpb4UWUeYqwyUOaBvX1F1i1shEmQ69bbFJLOdJm0rTPW/JHYInahrRs+yHnd/m1sGlLdx5Jl0ZvsAx9oW1Xo+SSuwoKu18my5f6GWGY4RxGOvLXKSrVlnJcVXTv+Hsv9K/G3CEnSRw0ClQxMPBnknYz6cKXAwJ8MaT/TWlMpt1+NLg0xU3izHhxL49bVm7+GjfeGTNIY/IoznHdcjml0e/qMTY+fYDE05hatfiZH4txHiF7n55sIknNDRskPymKp1200nNp9wdW35ZZ64VeSXxfdaDs8y9wTObu/6DrRBDxIGFWELnAFUKpyUp6wnLRK4vKcgKn1U+qkZ3VzEkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9CRPhK9kXamWz/ts8EtMd0SgwBNTTrECzAl8dLkTTPc=;
 b=La4KoPhFWGvx3EHs1NTzCypwr12qUV1A0NsDsZPzV+XCVBQWCppadRybclnaQ2diQnHaEta+TO/1WAP9AMs2ePPD7BV3qzXDhT6JmFk3ANBKr5tcVzVH21cK+Y5jJ2tDWV2Vh6+yxyPDAkF3K8G8GbWyPrH1bGmTOXSQXflaadF5bnP5KQ/9IiEVJJFsa5EpHy66HKaeuiTk38+DzI3dnZEaxp7zXaAuk4LXCrYk30Xhc7+wInNt2x8CjhkDuBYl+DMkGLy7Q5UtovIdJsajXVZJCgOTQxiUCCSdjmfW+0Rtlj6GisTVPAUzaHo28dMO/5cs7Pc9147ER7LQ23UxQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6363.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:56f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.30; Tue, 21 Apr
 2026 13:33:13 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9818.032; Tue, 21 Apr 2026
 13:33:13 +0000
Message-ID: <6e3a68d8-87c0-405f-85b4-0dbfcfafacb6@siemens.com>
Date: Tue, 21 Apr 2026 15:33:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 0/2] swupdate-config-wfx: make device
 identity configurable
To: Fatih Alperen Erdogan <alperen.erdogan@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20260420080018.7091-1-alperen.erdogan@siemens.com>
 <782e663a-1503-41ca-940e-6f99da8c1a47@siemens.com>
 <962369.1776696992684909700@lists.cip-project.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <962369.1776696992684909700@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0364.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6363:EE_
X-MS-Office365-Filtering-Correlation-Id: bd3eca84-c422-4bfd-935b-08de9faa892c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|55112099003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	k+qna0+/0TLRupb/+y6oC0eXYhr5oYBMzIQGlJSuRupaQMfG60mYPDNAMflWKBL+xOagqgDfzKv+1rUkVfXPI+Po4yr11xy/Q0slOz/derUpmxryd54GcmNGjGt/2gg82m1u4q/PnsbEIv5KPS+DgOqnte8uhBn86PEKl3OvEH1tOZK62XUBsV8YKZ5Udco/gOoAPWrB8Xy1w2M3+s4TEJ1egwpxgjwHfmXddm+t3WE7maFg00adv6iBhhs1sssZFwfLFY/ililAG+w2lMwaQ54/hz15lb9stWTyQtE7JPctUewCRCQN6ceZyt7e0T3CzxvIybTeC8pBU0+zeBNiRb9Z7j+G3JEn5ufi79Nq8MobqYh8SRbbFEg4WQOqK34VWLfGLVZl7LaouNHCz59oOqnLFqtJBGAVvMUBTPp27bMx7UlaWN/QmxD2E2tHqM9GqGpi3wOqQIlcF/knBfQIJlrXlQ3jbFSbdJPxByAgQW9Ywjhl7TaT2qXxhp2ed4VwBZPUMYGpukQ8M1mwT/xxyNIEWGTBMFiOCSw2JbWU173YU82REeS/c+5tYad6u9TwPmkwFQkDUbbbEhQk7glmKI3s39J+6KGjEqFc58UI3JWElGmI7v8SWn+Jjglb9zsg2s0D0+mKZvhzjkovifv9jI5gFUk3FXwfYtU+0ERy/psM3B0j4AZHyDXFmBpMIoPX1Vw2Pe24kCT18Bg22kn8OdAvLVf5kc0NC3kybp8J41g=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(55112099003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?IDfu6nZocLOIiYmlTBuVUJkGd7avggJ+3w5E+2Rv84w1l9uDHE1BopajxxqH?=
 =?us-ascii?Q?e92pyF6MPNgvcCvnrYmZ6kfHK9aXiWPR7kmye3UC9CuDrTsKdddkJ+rn6cCL?=
 =?us-ascii?Q?Z/VbWPQk8PrKaZLyTL2YdGLAx6E15sI4tOZqs0bON42R5eRfE4rLnavwdjo4?=
 =?us-ascii?Q?IqATehmRSRtDyHFaIP3uEhazJNIq+FUpGQSFNo88g6aqIjnxcVQAehs9IBaz?=
 =?us-ascii?Q?83iUOCwrlMkBPWYYPMK5jA6teLWaK5xwK2GqCkY75KIGYpQOTa36UkuzNSxF?=
 =?us-ascii?Q?ZA4BT7Tn+ypC4heZRnGpM6H4Vj9iDbmMnRkjRPrE3K894Rxy9WE++Y3r8hr9?=
 =?us-ascii?Q?sn9ALMK0portA4kKLVOoPKfgLcZeTFDaxmCRDMwm1ZK2+H8rAq//Fomlzlxk?=
 =?us-ascii?Q?yH6/XodGhPhAPka1Hbya6LgEF/pBLdu12ZgCEcunUHxnpzXthIh8eYCElxBu?=
 =?us-ascii?Q?Dm+UBx+SwkxotlthdsnMY4qUJMtHNHZC/PG+Ag++FioBN706BFBwWXsoRnXB?=
 =?us-ascii?Q?eECs39g0iXO6I/lxW0ljeUfzroVn5hLap8V+NI6nPwNFXWL7vpEc9oax6K0R?=
 =?us-ascii?Q?5ZgTy7aIyQZWs81r0UqVcE2MQGMxSkC0SDo5HihXTmzX3pvNTXxZoIrmweQV?=
 =?us-ascii?Q?c21Z13Jfm6a5w6IxNAi+OtCrlD6Yn5PXVNGgwR1vbbk0rr80y2TXbdqV1kY1?=
 =?us-ascii?Q?WTajSU8T2EB5nHYhFai+CYFI7qwwWoq+Ez2xo4sm1QvrPiaQWR66+D7YkrU4?=
 =?us-ascii?Q?bgsVlviLCbLCZwimwjscEeeOiPfSC/VZTb5/ihR5/QzNygCy04xPbObzZIRA?=
 =?us-ascii?Q?jpViyGNCbtXqk2/O4ZQWfesfkZC89MXzm0VeaBk9Xs3YpAaoLkSzvEik8KrY?=
 =?us-ascii?Q?KkpzKps+VpPE/5XsJYmYX2WNn3vPt9RpE1w7rEpBluC+N+yPw+1hUN/bE0QL?=
 =?us-ascii?Q?R8QFUArUws+A6BkrZacIsPvKeq7cPCAY1sSegrYUM/rIRFu18SD9w14OAT9T?=
 =?us-ascii?Q?gsS9j0TzH28D87FA35C1o6DI4JmcR9G2qKlpptfl+MQAUSRs4FZHJ92S+Hhz?=
 =?us-ascii?Q?0E2L6qQEHy0rBUsJofmiycLE7+6GcDYG2WoOkyuk/LDvzh1KN9vkEy7/Cjkn?=
 =?us-ascii?Q?8/V221xLLRZlPl5Xh1UqxkhLLufvd/4zQ3KNwaMv2u0ua0bqTQRAFsOKhp2t?=
 =?us-ascii?Q?XLcssFdWVfKikVetsl8jYSM7AArzvz7eGYXgpp8UKZtnD+ymbdcZ/isc6OoZ?=
 =?us-ascii?Q?YX5NvpEc6cu8OdctxgSLr9XMjofSU+9ytWUmbUSmmpkqEncp1aRmZ+E0DJCF?=
 =?us-ascii?Q?aRlcN7cDT02/Ip576uAkNoPkDytwrugoK3f4Lo9bnvTBRkBuega+Hs9el/d5?=
 =?us-ascii?Q?xlfyoZTflMgIuNyRJt6HiYQtfTXpLO5EU4VX2pUv24GwSi+3LFnL19QHEEBq?=
 =?us-ascii?Q?VSw34FUoXVxqAURjlxBHtAoprTFxCDwEmxGnMQDvtZ+jvKgbuKf9lGYnrfeH?=
 =?us-ascii?Q?8U+7eO7+y+Yexgi4Pc1wj8p7h1r1ZtfyViEHiCLwmMjfyT/08DFNc4NQ6fWG?=
 =?us-ascii?Q?qouXvWgJakpEJmagB0F8QHaeug9i5lGiDJ7naIbxzWcKu4/NEc70xubqUogE?=
 =?us-ascii?Q?z0xA1G/kSkaiDW/YqdI0Ux/1fsHrxa2xd9bni0lM8wLZOz2iTm70+i2JSRJj?=
 =?us-ascii?Q?cdAjItGrUUBE2GU57vgF2SK0hERcZVpZKUVsoiN+n1MpH/fU+t8Yv0/dONf9?=
 =?us-ascii?Q?fMAxH5sgWG2k1+13gsIKhrOq13hGr/I=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd3eca84-c422-4bfd-935b-08de9faa892c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 13:33:12.9468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xCqMBWBie/oJE/RQod6tO+5kdjptjM8vxOmEry5YOSucT7mEi+UolZpvJ8Ce1UZXVtEACu8AUzt0xBqcszahXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6363
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 21 Apr 2026 13:33:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22776

On 20.04.26 16:56, Fatih Alperen Erdogan wrote:
> On Mon, Apr 20, 2026 at 02:11 AM, Jan Kiszka wrote:
>=20
>>
>> On 20.04.26 10:00, Alperen Erdogan wrote:
>>> Add WFX_DEVICE_ID variable to allow configuring the wfx suricatta
>>> device identity at build time. Defaults to $(cat /etc/machine-id).
>>>
>>> Alperen Erdogan (2):
>>>   swupdate-config-wfx: make device identity configurable
>>>   doc: update wfx documentation for configurable device identity
>>>
>>>  doc/README.swupdate.md                                        | 4 ++--
>>>  .../swupdate-config-wfx/files/suricatta_wfx.conf.tmpl         | 2 +-
>>>  ...{swupdate-config-wfx_0.1.bb =3D> swupdate-config-wfx_0.2.bb} | 4 ++=
+-
>>>  3 files changed, 6 insertions(+), 4 deletions(-)
>>>  rename recipes-core/swupdate-config-wfx/{swupdate-config-wfx_0.1.bb =
=3D>
>> swupdate-config-wfx_0.2.bb} (86%)
>>>
>>> --
>>> 2.43.0
>>>
>>
>> Looks good to me so far - but would you mind explaining your use case as
>> well? Do you replace the extraction logic because your target provides
>> an production device ID differently, or do you pin it to fixed known
>> value in a development image?
>>
>> Jan
>>
>> --=20
>> Siemens AG, Foundational Technologies
>> Linux Expert Center
>>
>=20
> for this use case, target uses a unique device ID provided by the interna=
l system, so it=E2=80=99s read from a different file path.
>=20

OK, that makes sense to me.

Thanks, applied.

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

