Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5238C25B75
	for <webhook@archiver.kernel.org>; Mon,  3 Jun 2024 11:59:56 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.57])
 by mx.groups.io with SMTP id smtpd.web10.81468.1717415994471075259
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Jun 2024 04:59:55 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=BdLFG4Zq;
 spf=pass (domain: siemens.com, ip: 40.107.249.57, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJzrgfhS0I7cRMWXgGG002cuC8eO+DkVYlbG7GjjmsbQEew5XsQi81jnOuyN0FPgs8lOQDN+6nQuivUAvt+3z0QYs7Z8gl439MQjVWoijJr4NRviwYlbYBvgPRWjxBIy4XGisBh5iYVavckJB9bgtcf6UtWRxli7IeFWNPN7f3XSA42jNWcx0kC2Feh6UogSp7Sto9tnKF3P87NpqZQ6IPDAh4F7Xbmb8sDDgONgt0uDHVZkQ5Yh454vzTrgql1ucimhBXXIDZhgCaMcMa8g7EiXppN3JjvcDgJJ+rN0xDMZmT1hoMonWrtNCHuYl5Sp0khvXy8M62BC+OFtZ4fqyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yJQ1tL9Ly5BQJSsXThpZv8sdPEXqQnw2eCit2QF3QPc=;
 b=Ug7yhRyR4+FOe2uterHMcL5kJsUoAeiO6e6R4k6NhIDqYCbEzxADXZ7prGFl06b7LTSQx95y414UaD8fC5winDq3KiRUy+OLDNytL3mM8rj1tOCHgRFxGob1/LIoQoM+6WSukwlha+HEVgKzwCEj178sJy77ix8OLhmGx7Cf4brCQEjRTzgy9ycIe5T7lHi0FgHO4iYKrg47w6ytlH78jcz6udbRrfrbizKFQjSTHOZusRrYs6/Ob7hFlI2EMvnUtFrsZfWsb0vcwq7UGgS9TYjomzoYGyS0EMdU0fxGZj/nd8UMA5ccb8T6Bz6eeTwBEAfUOc+zzv6qVNGjsdpLxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJQ1tL9Ly5BQJSsXThpZv8sdPEXqQnw2eCit2QF3QPc=;
 b=BdLFG4ZqFNzzQMNAqiOG7/7iOyo8tsmnKLBMVydyH2i/xZQ0hnBlwaCa+rPGINwAIPj1WV+S06k6Db0xUr+0KfJTTHkzss1GSwC1gApVll9ZYahvDLW0D7Mi7fpGibxZg8I9/ZvcveNtCo0/z81Z2mB0f9I6/z5OJIzt9jl6za6CFpupZkO8Klj3TLuworm4C9FejLlPFlAK1ItdfZv0hN3P5O5aNTlZsyVjYmUuvYQklI9qkDaV2I1M3ay5kSSIJh9PkoNFlhjMaYaPz/mqK+OuKc8fx15PB7hwTcvDt+29Qe5fqjglTht/oNT0f3ZYIhUMqhua+Ts8/Vo7JwExNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB5914.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:59::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Mon, 3 Jun
 2024 11:59:51 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 11:59:51 +0000
Message-ID: <84045416-495a-4acd-9746-2a3166d026c9@siemens.com>
Date: Mon, 3 Jun 2024 13:59:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core 3/3] .gitlab-ci.yml: Add test targets
 specific for CIP core functionalities
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
CC: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20240603070920.2942859-1-Sai.Sathujoda@toshiba-tsip.com>
 <20240603070920.2942859-4-Sai.Sathujoda@toshiba-tsip.com>
 <441b9fa4-27d2-48b1-8c8c-9380ad839ccc@siemens.com>
 <17D5748A2FB0DABE.21428@lists.cip-project.org>
 <OS3PR01MB6103885E6783C601CA5052BEC2FF2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <OS3PR01MB6103885E6783C601CA5052BEC2FF2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0152.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB5914:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dfcfad9-0f53-4024-b1a4-08dc83c4ac7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?iEJtyzA3l+4vazL7CCDpt5Tj6k7/PHB8pFSx/1b0plTthlo9JYUnXWrQIopA?=
 =?us-ascii?Q?qHYHh9KeafefCvsLc0LcHFpG4GDErV5n77URCys8dmpJc8MJFbJSWl9m/KcY?=
 =?us-ascii?Q?gb6GLygw8H8d36ltC7uQ7F29xowACho6S1YeFEvb6zkVZNMapXbFdSxKJbwH?=
 =?us-ascii?Q?WIOLYL3y7/MQ+DrWiUZLdDA8Afss2Llsul66j0DT7gV++cI+TwL8S3DL7gca?=
 =?us-ascii?Q?P9HxUjvxsmEMJOh4EwrJyNpzX2OaN8FHLfuF7BeG4EbjuLNwor6C2RHMnqhh?=
 =?us-ascii?Q?MUD7Pw3U/Iaf94h5zXqfaxkwtojLlKOSzGg7zyTLncJX/mftwCkeIEQznEBM?=
 =?us-ascii?Q?IaunqgqX7YEGnrixI3NU/gII6DmAgcl46fP8TvRPHd5g+OcWqdGFpZxySx8d?=
 =?us-ascii?Q?YWxBemxf8Ez9ezTY9z107+ecXiC4q3EcNV7D5won4LYVzr3u9hDypwu/hF59?=
 =?us-ascii?Q?ndnnkP0CtKuxCvUvGKm336wPUeOs3hkTZFopKiZ0ICKOezCpzHtsqrz3T6XA?=
 =?us-ascii?Q?mcqAU2g6AuAzK5JEc7nVYVJKKD9o0MNjab/SEfJVCM5L09GRMcRalziGC3VH?=
 =?us-ascii?Q?0vsmXNhOLytS/RHD//my9SUt4RsN3F4Pd39H1VE747ukF9ug4Ti7WVU3L0ox?=
 =?us-ascii?Q?xOV5KMW8YxhxoKzladNwpXYICHasj1jRYxQ6Vjcpm0ehiNsB5VSLQn8eMrSD?=
 =?us-ascii?Q?eI9EsvCily4JbBmldWS165MSqYXmLer0YyE21I0pLAjGLnp8Bow3E/Ah6PNc?=
 =?us-ascii?Q?wIAKwVkK7T9YhqCJL5TlL8tG1t4jjfXXYQzawKbLRYA07Bt+lETFR+ezSNqr?=
 =?us-ascii?Q?QBkPzTdjvJkIDgJy6wXZjl22J0mx48OjcuiV3PS1nB4CVvjYHnx9SL7pbxPH?=
 =?us-ascii?Q?jbEQe0raYHeLIugwbqfUzrUCjguuSXteLzcuvdsAHx1IymruPwbmtgVQGG+u?=
 =?us-ascii?Q?US31fMY4N8Wl+LxCtpS8NUrOovi1vp09Z/kxE+KWmeFfKs+ZZ0pJ1SVwx5cI?=
 =?us-ascii?Q?t4OnDcGsgqzN/dpjPQjmmEHu4cuJB0KHd4owDQC4NB6Q/wsnqi1jcf2KZRji?=
 =?us-ascii?Q?q0l8BF024bLMgqiSqbKcxLFOdo3+NRD7Z6DEpw3mQvuKzVhkXdVAZ/fTjGKo?=
 =?us-ascii?Q?nnkcBbgyQsGRhJQCtOmp6acKX5lTFQMuHdDOMd+xjBFUBiROdGW+q1aKsIlI?=
 =?us-ascii?Q?KrbHENF0KrQfMYNm2qJoKNjJWUbJzGkCwpeRX0RWJaFj1EJOhI9RUhHdY5LS?=
 =?us-ascii?Q?DCSrNVMw5M5Ff7Uy42BzsJrA92jJlRT7TmxKAL/c3Q=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?j2FopjK44rLPpQ5jbYUIG7gSsDsV2BUfWYnBPfr7XeBCYexjFf3CQhNpmWe4?=
 =?us-ascii?Q?kUubf3gC22iEwEoVwYhKaGgzqMgmtnCbv53wwS3AzF7Ek7m5dn2bN5AeL2Lq?=
 =?us-ascii?Q?Rfpk07p/AhnZj5w6yhYimphWRIIk1//tQyltxlKFXhOAVHhkzVzr2TZ7sRDC?=
 =?us-ascii?Q?cntaS82Um7NrKjf/2WGHPse3ZxvEdp5eefJ2MjSqOMWrc+2yKf2H+n9qveIe?=
 =?us-ascii?Q?+lkVvZEr5M9Ac079cW0m3dIcsaFvDPDcLcCUVMc/zoszXopeErYIY2KU7f3H?=
 =?us-ascii?Q?OFz3imPMAyGhc0/ONe34SB1KLMgl/OGqI7qvWLDJBVOubrtqi1mOHa59zLEw?=
 =?us-ascii?Q?igtgZ43WlwmCRTNmmPOxIkMFZfy8I6gOCtGH4SwkNC098IEjBf/S9vdTRaoX?=
 =?us-ascii?Q?iUwBR9j4r/RdCQzops2xavW/r7rrnLnO+gsbQ46DccP25xCL0fNM3ofYCEsM?=
 =?us-ascii?Q?qyhjppWrsPU1n4Tnm3NqApxhUf831prD2vwYkIxPgM/bzzNSyhmz6mui0uXi?=
 =?us-ascii?Q?gOyf2WTsAd4t+bcIavDWIekeoryY+GDPhPRuSjH8GLIV9uAHvgoBkNciaC3q?=
 =?us-ascii?Q?B83146duN8q8ukA+pVYWcW7RzUR191Lp3ZomhtRv7F6hRabF6xqBlisdRNaC?=
 =?us-ascii?Q?BIZ4EPxS0npCNhPbjG6STsTB3OP+SXQCLvQ1CAAEHz09mdM4oMkHK9Kbzg/I?=
 =?us-ascii?Q?Q60qxqrQ1E94u8MNlNnu1wqA0yfVdXTEuglLE9KDoB4sCYfcqJ6fKAiOaOS6?=
 =?us-ascii?Q?zSp9YtOP/kLi3ET/M/waG9BhdA3lMttd+T6Tu6Ezm5MWIHYzv0EJhpucx94T?=
 =?us-ascii?Q?gL0lnbecKbe5A9ybmHWUnCxZh/jZ7hh0qbFwtDurFQjmKBqOT0sDjoD2a/09?=
 =?us-ascii?Q?DlLg6pY/I6RvQHuwksqiBFjieBXEQXFZWuXr2nHep5x0Bf4lqM/cIxgkttHw?=
 =?us-ascii?Q?N7Ue7DZDu4pIiktvawj5zP7DenoFXwUUCjh9a6hV5X1QddtOPe1q930TAEES?=
 =?us-ascii?Q?43wOmrdgsTjU3kqIiZvwjd7B6q8kZL10sBg3tLh4d9zv8G3UdvCXvxeQU+Y8?=
 =?us-ascii?Q?w1fcOfRAc1LKV7jfBDjQfyOQxiFNZA8gUAsttHgzXNl60ZunLx5YZmnV+945?=
 =?us-ascii?Q?mnCQCcVdSpyDJTRtJhdurYGQk1mVbSARb1FpLoJLL18sfDUvxS+z9HLfdQDm?=
 =?us-ascii?Q?tWwty0yRLXrKH8G+Ogyy+5gRGa4KtQ7GiieEYgFbzhUFvwznbhNrpgd/1aed?=
 =?us-ascii?Q?7LOUj7MH7PJkxcEbYEUkBZaVVdWxGZ4f9fLMTHBrEs35uQ957JpBc6IU58Hn?=
 =?us-ascii?Q?T9IlmIBrRrPtL4lxFDyFXuzHgLkBzM4Tz8yt4y6y2dPruLFSIyAjuir2ekXR?=
 =?us-ascii?Q?3cTMsSQvxVzaF+22Rf5pXeHLnanY1QQ7PuhZsL2Wjcx2qgM1+AFV+ES5WEk+?=
 =?us-ascii?Q?mEY92XcvrPtMgNpi2aaLyext7kFCxUXSuRd5rkOBalZm5KCs1ic606eudQWg?=
 =?us-ascii?Q?Uy5/FOCg4e5Qxf4SGsoiCbivS5gBvI+0QXeSS1GkZnbDC9GMIDVsP1p9+VlK?=
 =?us-ascii?Q?4FQ9NZI8FUv5zevFqq4L1vjZz5Y7AUOmvgcNqe07Y8cAVZXOpwn/adgZFmMW?=
 =?us-ascii?Q?cA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dfcfad9-0f53-4024-b1a4-08dc83c4ac7a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 11:59:51.1529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qUZYrXw8q/w6QlRjGrhdr98+rgDG3aVEjuh/EbaHsBOcCrsu+D4/0DUuI07qTtXikbysuXNTVPZBkapH5KO8HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB5914
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Jun 2024 11:59:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16097

Ok, thanks for the clarification. Then we can also merge this after the
release.

Still, if you see any issues in isar-cip-core's swupdate while evolving
this pipeline, the upcoming release candidate phase would already
benefit from hints!

Thanks,
Jan

On 03.06.24 11:44, Sai.Sathujoda@toshiba-tsip.com wrote:
> I apologize for the typo "might now" -> "might not".
>=20
> Regards,
> Sai Ashrith Sathujoda
>=20
> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of sai.sathujoda@toshiba-tsip.com
> Sent: Monday, June 3, 2024 2:59 PM
> To: jan.kiszka@siemens.com; cip-dev@lists.cip-project.org
> Cc: dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Porting) =
<dinesh.kumar@toshiba-tsip.com>; hayashi kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=
=8F =EF=BC=A4=EF=BC=AD=EF=BC=A5 =E2=97=8B=EF=BC=A4=EF=BC=A9=EF=BC=A7=E2=96=
=A1=EF=BC=AD=EF=BC=B0=EF=BC=B3=E2=97=8B=EF=BC=AD=EF=BC=B0=EF=BC=94) <kazuhi=
ro3.hayashi@toshiba.co.jp>
> Subject: Re: [cip-dev] [isar-cip-core 3/3] .gitlab-ci.yml: Add test targe=
ts specific for CIP core functionalities
>=20
> Hi Jan,
>=20
> I added "allow_failure: true" because I felt every change which triggers =
a pipeline might now be related to the functionalities we are testing with =
these LAVA jobs. So, I thought it is not good to fail the entire pipeline j=
ust because one of these test jobs fail. So, I think it is better to give i=
t as a warning instead of letting the pipeline fail.
>=20
> Thanks and regards,
> Sai Ashrith Sathujoda
>=20
> -----Original Message-----
> From: Jan Kiszka <jan.kiszka@siemens.com>=20
> Sent: Monday, June 3, 2024 2:42 PM
> To: ashrith sai(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0) <Sai.Sathujoda@tosh=
iba-tsip.com>; cip-dev@lists.cip-project.org
> Cc: dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Porting) =
<dinesh.kumar@toshiba-tsip.com>; hayashi kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=
=8F =EF=BC=A4=EF=BC=AD=EF=BC=A5 =E2=97=8B=EF=BC=A4=EF=BC=A9=EF=BC=A7=E2=96=
=A1=EF=BC=AD=EF=BC=B0=EF=BC=B3=E2=97=8B=EF=BC=AD=EF=BC=B0=EF=BC=94) <kazuhi=
ro3.hayashi@toshiba.co.jp>
> Subject: Re: [isar-cip-core 3/3] .gitlab-ci.yml: Add test targets specifi=
c for CIP core functionalities
>=20
> On 03.06.24 09:09, Sai.Sathujoda@toshiba-tsip.com wrote:
>> From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
>>
>> Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
>> ---
>>  .gitlab-ci.yml | 33 +++++++++++++++++++++++++++++++++
>>  1 file changed, 33 insertions(+)
>>
>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml index aab55be..0a22a3f=20
>> 100644
>> --- a/.gitlab-ci.yml
>> +++ b/.gitlab-ci.yml
>> @@ -358,6 +358,39 @@ build:qemu-riscv64:
>>      deploy: disable
>>    allow_failure: true
>> =20
>> +.test-cip-core:
>> +  stage: test
>> +  needs:=20
>> +["build:qemu-amd64-base","build:qemu-arm64-base","build:qemu-arm-base
>> +"]
>> +  tags:
>> +    - large
>=20
> Conceptually, we should not need large runners for these jobs. Do we need=
 that for other reasons.
>=20
>> +  allow_failure: true
>=20
> Why?
>=20
>> +  artifacts:
>> +    name: "$CI_JOB_NAME"
>> +    when: always
>> +    expire_in: 1 day
>> +    paths:
>> +      - results
>> +    reports:
>> +      junit: results/results*.xml
>> +
>> +test-qemu-secure-boot:
>> +  extends:
>> +    - .test-cip-core
>> +  script:
>> +    - scripts/submit_lava.sh secure-boot ${CI_COMMIT_SHA} ${release}
>> +
>> +test-qemu-swupdate:
>> +  extends:
>> +    - .test-cip-core
>> +  script:
>> +    - scripts/submit_lava.sh swupdate ${CI_COMMIT_SHA} ${release}
>> +
>> +test-qemu-IEC:
>> +  extends:
>> +   - .test-cip-core
>> +  script:
>> +    - scripts/submit_lava.sh IEC ${CI_COMMIT_SHA} ${release}
>> +
>>  cve-checks:
>>    stage: cve-check
>>    needs: []
>=20
> Jan
>=20
> --
> Siemens AG, Technology
> Linux Expert Center

--=20
Siemens AG, Technology
Linux Expert Center


