Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB887C54F54
	for <webhook@archiver.kernel.org>; Fri, 31 Jul 2026 05:13:00 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.30])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.348.1785474771360582915
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Jul 2026 22:12:51 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=y2PK8n0m;
 spf=pass (domain: siemens.com, ip: 40.107.159.30, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DBNQa/6BaKOGcu5hsvQ/b3Nyi6ds15DEA6Nlck/1QH4lGAjtUBwqJ3QmaPGEgKRLJArhSjIipHco6Czvj/OD2lGn48jpCsF54AygWZYui20CLZSoSp26VTnxr28hGjJA85r/G47RJwjvFvFhTOjzt18nP0dgmsrHo1q+VrSNuPHph8svfr15eKT+2dW3j7zn0oKFZn9AVhFkvAzHT9usRZsz9IUJvphAhGbv2l/HfIa+mvCAH1M3vzNDxf8ndwKhofggJl39G28fMw2TBrLeOTqsSlH02wLW9BB6HQdQjUyqZFATpL+2aFBVlyW0L/N/10D7+HFv6MeDhf5rh3mfgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QuWND94SjLUqfEdd3jvVLAXSbpGWyWvOlSBx6muFrtQ=;
 b=PFYyOkf88RcJ43+bxHWoMOTec6zU9WG/2jhCyu8HCCIyw8CP79ZyZBU95HfrX3olQIKwR43YNuSZZdjWG2BGXOrspS/sIVB6P1F2Z9GSikJlefH5eBBgb0Pvj8mpVjtCopOr42JZQGTJfMzz2K+zvRDEZb/dED98GaTQgdt6CzUHDgW0zIvZL8S0tLOKW93+rTjQPpdXLaTWKZgebsH/eEnSnox3v7XOv6NeYp4Vm6BKmdqbKtgfBUzIDsIfXdLgmL+J2skTvwsmiWqV3ETM8cUO8ef2Sb30U7XjfZ7Mjt5H7zs9GV5Gdl4dJ17IxzqvD8lJE39hwOydH+j88MEyrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QuWND94SjLUqfEdd3jvVLAXSbpGWyWvOlSBx6muFrtQ=;
 b=y2PK8n0m+i690+gL4hcZ0Vr/aiSxUlJ3pc4gs+TzUAkE7HlzbsuGs2KwXYIBF15lIA0EN+cbjOeATRYk385buH6FXSWMuVzJoOqKd8VZtFYfBReRdrLbz6N7As0kN+jk9zhj8ch920evU7l7vih3ZqqvONjCR3mfsFPH76Eg0mHiVGw5Kv2F4WnoO56pOsF90zkuiw6XoE8VPlhHfzOf/3yfr+Yox2ytCLZSIWOM44YrX7mOVb1AS6g+1HrvVrxC4RbsE+H1m3nAX0FSP7C1yxhVvvElPLoIMrw55gMg/vadVI0gqL7O62GQt1bmsIyzKuVNXXTFWFRF/pa7bpFRjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by GV1PR10MB8388.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1ca::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 05:12:46 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9%4]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 05:12:46 +0000
Message-ID: <dfbc2c0e-ea92-433c-bfed-83e795097ead@siemens.com>
Date: Fri, 31 Jul 2026 07:12:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] CVE-2026-64560
To: Pavel Machek <pavel@nabladev.com>,
 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
 Ulrich Hecht <uli@fpond.eu>,
 Masami Ichikawa <masami.ichikawa@miraclelinux.com>
CC: cip-dev <cip-dev@lists.cip-project.org>
References: <4d61ec83-bb55-4c27-b370-0e2ed60bd800@siemens.com>
 <18C72D766E036C67.1779571@lists.cip-project.org>
 <amvF1nVER--og1Wz@duo.ucw.cz>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <amvF1nVER--og1Wz@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0436.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::8) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|GV1PR10MB8388:EE_
X-MS-Office365-Filtering-Correlation-Id: 31a6754b-5881-444b-ff53-08deeec25b89
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|10067099003|11063799006|4143699003|5023799004|6133799003|56012099006|18002099003|55112099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	pj3ZJSFEJ1uLVq948v+UC4JtZ2ZiEK/2IqXLLY92MpqXLu09EpbgNKwaVgKVWnjw069QTPx3EjKSindlDg7bE98JkMZwi3WfYBoXeQ/fbyfB+2tOURNTcg3y2XJqoS9C7WO+E40zJwKGIonHwiFV2gBaDHCc5aS2VAZVc+Y1G0voTyO81vCybsmZWI3ahyqekTqcr2PIshS3LtnM5WYz+Ks8UkemoA+KC+KFSKJJqlz0jhxKYJG1J7ImLL8GroAwXoz0CjbsROKYGePqyOPzg2zS0f9AgBOxDMoMrA8eq3kOTQJJWu4+wt81x4KbQz0kC+ti1FY8+Zz5CsDtQhJT3hHar1uUAXs6lRRytr/Spp7AeF9E436ZlXIlhvFb/G1otzuMfwTaWSIfEcHq2nqQftm+G+x/RPAPYZkLHdmhesUHsMvKmiIYjVzIpNCFw5dxha3zDU4D3qrfZtV9UXdGywroJcDO0tu5lZtbqZLJTF3otH/Ge0HEJQetMJtWuCdvbVGCjD/JXwEio91D6ZR5CfC5BQ5eJKAzebsjucZx58ni7DUaUeCZAsJXnBKeX+gyHtKvbqDD/Wt+swCw+dem/7wwu+7gZdjf97QwZZ8hyZZkFwRQOgH8G46TRVzMsLUGXZ7fH557R3fUFvIQikDFMlIjGRTL0JXiItC5jxY9Nxo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(11063799006)(4143699003)(5023799004)(6133799003)(56012099006)(18002099003)(55112099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?SIfHMdrbnYMDXQBABDEfkF/Hu8MAf1uPwOZqKbzwtLgfIfYsHhumUH8oXpoj?=
 =?us-ascii?Q?zy7ntJkN77YlJHu6T7SQKstvUnyJ7Fwsp4vgrW42BGHnjC88v/thp2lcbGwp?=
 =?us-ascii?Q?Yoajri1Oc9vrRkeJay0nNcbl1OW/rGpGROiMLNYrxEhHv1Uppw9qQaRavz7T?=
 =?us-ascii?Q?NoiYes4UN2qENUw6FG1fX1XhVYmTi+0r2BdJBIwlH5Shp2QFf4r+6oNNU1dh?=
 =?us-ascii?Q?KuBNH1VPnuAyU9gHc7Dm7Chdz/WGxqTWgNEOmTxaFdLbcPTpCuKRCQfBbTjE?=
 =?us-ascii?Q?DCi/olFQrbSa8rqGU/G/ekq5r29ellZu1x8C3aMi2grhqzIIzuUMEpXmHJKC?=
 =?us-ascii?Q?uTzTufE+1Q8f1SjrhbmW31/AR+xeOsBNkFZVjoRvvxPCbn8lBF7aWgG2RyGM?=
 =?us-ascii?Q?yeB3nuVN9qc9d2BNbm5Y3GPoqwkCgS6UARpcdbiy16ygvUJ9UNBuQwJo0ipw?=
 =?us-ascii?Q?oIBhh64UVIVPiQfYy9tBsJoFzwXCrxA89R6Jf9nzprfzoTFvUuvsZPawWzU0?=
 =?us-ascii?Q?3reoPnrJ4rNQXoxtd9e5BPvFB9W9xf7+Wm7S6Vze2S3SrW7FHJrGi++jL2p8?=
 =?us-ascii?Q?FnBt3Mj3Y91+ejd2vzboHi4gzW/IhDy4HjalXVXkK5KZUMUv67fy7RFHcuiF?=
 =?us-ascii?Q?aTVIAbstdMQ/4//BJyChAazr6SLlfzCNKCwXLsd1hAqMZk8wygEljGSjxBYw?=
 =?us-ascii?Q?3t2QbPTtPDy3PSBpBvuWBM865lRTAFl+MKmqJY8lJs1R74j093+eeP7MBF0E?=
 =?us-ascii?Q?YuVgHXGLqdleyhQV/Z/GjzE1Ye30mILbFHW7ZTwu0fO/aiUAkBN7j2a8JNNA?=
 =?us-ascii?Q?oO4sauAazLIzHfrYAlvY1ORWVHe7x+CI7m8j6yNyaanaW9XxhJuy6bh4UMmG?=
 =?us-ascii?Q?2+jCEWHZ3j9CpsF4u7br9EA5rpTX854RQlBhml/xWIz3iPiwPsqcypQbqYNw?=
 =?us-ascii?Q?bmv1BMRC/cKIyWZ7OrrJtB0xOQm8qjrFELrogWCCsai3uOQJpuOTF8pOtqQF?=
 =?us-ascii?Q?05120NRLWtvT79ZkqpXioJt/oZ3KBCebcbsRr5ASSm4BvvsfzQ2mN7UcOhWF?=
 =?us-ascii?Q?8PIlkVKN5HEM1Lqyi8uBqJPY1kFYo2/lgeLq6RR0HJNn7Y7cvbrKouJN2PfJ?=
 =?us-ascii?Q?R1RuyMHlFcdpFGIO71PAItF7xy14EFOf39ZrOG1chfVctq6AmOthQbaAmez3?=
 =?us-ascii?Q?iQlvI/w+eJifdVlcfEqUNsvdRSHzymp/WyuHP9aHB1tyo5rh95yE9yyIkL8i?=
 =?us-ascii?Q?JAoSlW42xopEIXKHORYqbBo5yoQ+iuQHXKCB86oxJUdfNHndz3RHklBmICnH?=
 =?us-ascii?Q?NPRAU1E/qs3s3pVDSdAfGTOPwwm9vhAExFfrgW+IyEvIa63m77TS6RQsTY5B?=
 =?us-ascii?Q?aJ/71ZgPz/6Ccwbd1Z4YDMZcIUyfjjnNbUOML1y0degpjql+vym1+p0OxWQa?=
 =?us-ascii?Q?9yVVJE8SKG4r5p1wsMn+jC3iTSJ0Guv1HaQpHcLHOz4x+zfXJMmGBRci9T/1?=
 =?us-ascii?Q?nFCO+f8fLUyjK0k66KfrSG6VFcgd2ELwf6LluDXtd9CfGzJBY+7vUeZFF5Wu?=
 =?us-ascii?Q?RfDKZEf9fmMMcJumb8i91qgfw368z8JrsmRzuHYbncANnIKU6PjUuHHrdaEF?=
 =?us-ascii?Q?kxTEqBFumFiDeWTnfwYRE62gwOPtMhqSQoFu/kJugirY334YYAB6oCeK8kVb?=
 =?us-ascii?Q?KwK7DPFsBnz0KjTBdozUerQh5nuMBWsU5/jHOcFCpDA4NxCitV9OPCxt+XNT?=
 =?us-ascii?Q?8DS2ZLrDCg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31a6754b-5881-444b-ff53-08deeec25b89
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 05:12:46.2035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l7gqgxtgEbRCNXcR9W4kM3HGvMypaHVJ1MOILnymjL5rSYestYI5hWBkEBjzutijmLEnn8B5Fe4UPtT6DiUcDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8388
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 31 Jul 2026 05:13:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23823

On 30.07.26 23:44, Pavel Machek wrote:
> Hi!
>=20
>>> this looks like it does not need special drivers and is not that easy
>>> to mitigate (CONFIG_POSIX_TIMERS=3Dn...):
>>>
>>> https://git.kernel.org/pub/scm/linux/security/vulns.git/commit/?id=3D08=
1d2ff9592751aa400828237f17c108e4e1f513
>>>
>>> Early releases?
>>
>> No cool name, no logo, and no website? Aint doing no release for that!
>>
>> So... this is crasher, and you need local access for it. In my eyes,
>> it is below "Dirty Cow" in severity.
>=20
> So .. apparently Sasha or his robots believe this may be exploitable:
>=20
> I:H -`collect_timerqueue()` writes into freed memory
>     (`ctmr->firing`, `ctmr->handling`, rbtree rebalancing, list
>     insertion) and the `do_cpu_nanosleep()` variant does so into a
>     live, attacker-groomed kernel stack frame, followed by
>     `cpu_timer_fire()` dereferencing attacker-controlled
>     `it_process`/`it_signal` =E2=80=94 a control-flow-hijack-capable writ=
e
>     primitive.
>=20
> So far, I don't see distributions acting the way they did on "Dirty
> Cow":
>=20
> https://security-tracker.debian.org/tracker/CVE-2026-64560
>=20
> (Note the auto-generated, useless description).

That is a 1:1 pick-up of the commit message, "just" truncated where the
CVE record overflew (hope /that/ is not exploitable ;)).

>=20
> So the other two one-patch releases are. Not good, but not "Dirty Cow"
> level of dangerous, either, AFAICT.
>=20
>     Linux 6.12.99
> commit 41fb1f3c8a712eba4b1eae0a9023e80007a71413
> Author: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Date:   Tue Sep 24 21:10:23 2024 +0100
>=20
>     mm: refactor mm_access() to not return NULL
>    =20
>     [ Upstream commit cd3f8467afd470ccab0de2fbc7c76664af4a0bac ]
>    =20
>     mm_access() can return NULL if the mm is not found, but this is handl=
ed
>     the same as an error in all callers, with some translating this into =
an
>     -ESRCH error.
> ....
>     Linux 6.12.98
> commit 913e7b4459d6eef807bb8088b39b890ed6a74ee3
> Author: Yun Zhou <yun.zhou@windriver.com>
> Date:   Sat Jul 25 10:40:29 2026 +0800
>=20
>     ext4: fix fd leak in EXT4_IOC_MOVE_EXT cross-sb validation
>    =20
>     The backport of upstream commit c143957520c6 ("ext4: validate donor
>     file superblock early in EXT4_IOC_MOVE_EXT") uses a bare 'return -EXD=
EV'
>     which is safe upstream because the fd is managed via CLASS(fd) with
>     automatic cleanup (commit 8152f8201088 ("fdget(), more trivial
>     conversions")).
>    =20
>     However, on 6.12.y the ioctl still uses the traditional fdget/fdput
>     pattern, so the bare return bypasses fdput(donor) at the mext_out lab=
el,
>     leaking the file reference.
>=20
> Best regards,
> 									Pavel

Thanks for checking.

We should keep in eye on it, specifically regarding exploitation and
reactions of others. I agree that we do not need to hurry at this stage.

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

