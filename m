Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D99C25B10
	for <webhook@archiver.kernel.org>; Fri, 10 May 2024 14:42:14 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.76])
 by mx.groups.io with SMTP id smtpd.web10.14659.1715352130069010880
 for <cip-dev@lists.cip-project.org>;
 Fri, 10 May 2024 07:42:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=i9vCnXA5;
 spf=pass (domain: siemens.com, ip: 40.107.22.76, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TmQ2jeIc+lD5v1ztR+xswHVAzN+BJUoCUmt/iRgt5UDONXoM5gGzysGYFYKhFqiaQrAcRFzuqt8HDbWLuNcvTpERft9pk0MEy2OTYRThOcGAu/z52P57rqwpynuc3ZGvIACIo7Alvmi4DRZ0NjhiXNus8IS5EMI1o7P1CMGJtzZGWMA1PBczA51p6aG5qU3WhnljelW2BAJmgbOp8MDox6lLPzn3TGW/KN+wGj4caFLtWRo/N6w+nD0XPRqjd+B2gFTWcnrUGKNn6hNWuaV2bFUTKJynaraA44rTg0F9gITOaAU7q6U7YaGLOzp1M+J6+jXXbDjpyX4377h1dCRFew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ewK1yS5C4b/TWq3xFimE3Xnzqsk0WraPOgeWewNhE1w=;
 b=SIkzUeoFEvyai8pMsW5228t6KoIGJAGjfiDau3CQo9b/D/dIb83ffZj/kwGu7b/dM6JJOxAOx0m5yIZyfS2PaaOcz4ktN6JECp7jWtARxjd6sC3U9BZGwA3PyMfREvxvr7n5fkqxqIHJVnFfWVVSUgy0+Vg/D5/Lf9is2fE79Wat3Bn3Wls4aZVSLjh5nspOxqdxhQCggtY/AwNWemVA/ejG2aY3hmdV5yEeGHAzLPIj5kRsTc/oLsPPLxnwsQuQxrQ6Tit/XlPGQTL+4jy6JhJtkF5OywfoAQ6Oc6UDNcg67RpDgeXKz6uYvsJlbmOS4KHnGPD9o/pJITe446ISpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ewK1yS5C4b/TWq3xFimE3Xnzqsk0WraPOgeWewNhE1w=;
 b=i9vCnXA5kZ7Hm+vWU1PytWw63lFDW92KIfitfpSjfZ6ok8FrXAlrXCIPaj9vhTnmKpHIBFlXb0LYpnvqiySKVcBztKzIJqVjrCfAOby8qKrnOgjKSvRKevg1aJCpWWfNl6lBAsKe2/mhauJoyIBqdu810OZzJlGBjID2h0COq8y3FWRtE468Ro4V+dKFPzoPB8USREdJIIfnm+QVY3AkxSgow/OtwYaU10hglpycXNBKIC3grMJgsT9nPTYXPDDsnBjexHVW2t+B3P4Hhry0YTOWz6x4fg0ZzBkK0jmzZSH51jPF1nc/Utux7uYo/GggvUJ5BZMkf9SfT96M390Ydw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM8PR10MB4116.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1e8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 14:42:07 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7544.048; Fri, 10 May 2024
 14:42:07 +0000
Message-ID: <779c9be2-b3d7-46b6-be1a-13c565e6708e@siemens.com>
Date: Fri, 10 May 2024 16:42:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] use ISAR snapshot infrastructure for sid
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: Adithya.Balakumar@toshiba-tsip.com
References: <20240510130716.152418-1-felix.moessbauer@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <20240510130716.152418-1-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0123.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM8PR10MB4116:EE_
X-MS-Office365-Filtering-Correlation-Id: 9828bec6-c647-460a-0c9d-08dc70ff5dc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RVBRUDgwa2t5U2J2THN4amptVFoyV0RJdCt4YUdOc3dWRS9mVHZJaTlURDdN?=
 =?utf-8?B?M0ZWVGdYRlp0RmZ2cTJaelNMcE1LNC80NW42dFM3RDB2QjlHMDhQdks5Qk1M?=
 =?utf-8?B?NW9ydkdWWUFPZXlySFgrVitoTS9zKysxQ1hmTmRFRDg1cTdNSlNJOUdHOHhX?=
 =?utf-8?B?OWVhMUZsUWUvc0FUY1F0UXFOYTN3MVVCOEF1dXlIQjN6YlFoaElRa0hvczZu?=
 =?utf-8?B?RFYranBUQzBZakhpaGVvVXBtajZBRkpuZHpQNHJsQTFWcWZ6Y2RLamlFM0h5?=
 =?utf-8?B?dHk2R1VrejdJejd2RURiVURpUHYwcWthVHNnTFBoWUVYUzk0cXpZZDFBckFN?=
 =?utf-8?B?RSt5bi9sdWRDT3ZFb2NYMUFOY0FJT0Q2TjN0V3AwUW9oZWl6NkxnQVFZRFlm?=
 =?utf-8?B?K1ZEQmNrK2FLejVDb1N2Ynk5TVV0dXM0OU1saEl2cXdkN0lrM0UrNWE1MHFy?=
 =?utf-8?B?K3hBZmNiYTVTeURZVTYvbXRjNUc5QjZEUmRlMCtYbFVSWWpuRUdRT2FSVS9Q?=
 =?utf-8?B?WWxsbVZsQ05xYm1hLzNPN1kwTXo2M0JTSGFhYlBCeFpIUjQyUVJGY2U2cnFR?=
 =?utf-8?B?NzF0dyt4T1hOQ0pYazNaMFV1Q1pTY1V0Tk9kMEx2T0pnYTdFOXdxK0ZIK0dk?=
 =?utf-8?B?MERVNVRjRTQ2Zm9uR3JuMzhraWRQc21mUjVWeFQ3VG5iN0swcUtId3lwMmEy?=
 =?utf-8?B?TGdLd1FDOVBsZlp6ajJjNWl0UWdyL3k1NzdEQ3ZoVkJWN29zSDNCUitXcWox?=
 =?utf-8?B?cEJ6eFFjd2YxZzhuQ0lXS1ZRcGhSWVBGNXB6cml2ekY5TERScWdGakJZeGZQ?=
 =?utf-8?B?RUZ1bFk5Zko3V2k4WWpvREVxeG15OUw3NWh1cE9KaUZxQXhBY3hndEpPaWJS?=
 =?utf-8?B?Y3pNREFpK1I4Z3ZBN1FSNy9RL0c1RWxtbmdRUG0xcjh3MWJUSFZTeFpwWnoz?=
 =?utf-8?B?cDRMT3F4U1FUTVQydFpaK2FXN2Z1M2w1cC9kQ0JkaXgrSDNXZFIrNTVpWm9s?=
 =?utf-8?B?OU5UMHRwYnV0L3NtZ0FvYlQxMkhhbk1wSTFNa0tNZ0JiZE5HQ1JudzRnUjhE?=
 =?utf-8?B?dWgzTWJySWxsKzZ4TFBTTTcvRnB3cmxQMk50ekhlTGw5ZUoweTZLRGtWQStS?=
 =?utf-8?B?Y3FxU2w4ZytOMlVuc3ZPSnFBQUZvWitNdDhCK0YwbEQ4UXFHT0xQOFNZSGxO?=
 =?utf-8?B?ckZENE9HdCtJRjhxbEFyS2pZYW4vSkpNV3F5YS9oa3V5YVk0Sm40aVIwZHFM?=
 =?utf-8?B?STVJNEJyanpOMjRyNStKaGkySWlYN0NjK0lKbzZHdTI2M29mVWtsRWNLMVpu?=
 =?utf-8?B?WUl2bmd5YWt0SGEvZ0JFWGtJTk9LcElxZ0J3d0FQSFZOT1c4WlRJTnNQMWRp?=
 =?utf-8?B?QTBxNGhZUzZHWFZBN2F6M0JuQkZORUJlM2VNalFvZ25RMkFOYk9mMmFzUURs?=
 =?utf-8?B?TlhjcCtHdzVIRi9oZW1QWmovMGpvMHFwMVNxOERnRXFrS0xCYXFVS0lab1hO?=
 =?utf-8?B?ZmNmQTdpVmM3Z0xoQ3ArSGVzQlBUaGtpMUxBSlhHcVNNOW1nbWNjUmI3V1JK?=
 =?utf-8?B?S2JnRVVTVTlsb1VsTGsyU0RnVTJBZ0tvUjFlSjFoZW1lT3dYKzV0L01rbE5v?=
 =?utf-8?Q?gcNihpbNNxHRUz/moHAAUJbl4EFwslIMasWIsGLhmi2o=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UHpxYlk1VUlxWDNMa0RCL0ZYeGlZeHJ2eGgrT3F6eHpPdmRTWlBKZW0wUTU5?=
 =?utf-8?B?V3F2TW4xa0txdGhpUEZnRXVHVGpRVEFJZzFkYm5wdjFwYmVCTlZJTlcwK3dX?=
 =?utf-8?B?SDZoL1N5Y244UDFOSHpaYzR3YTlCZWpjQ1VOZy90WTBuQzlPUjhDZXVTK1lX?=
 =?utf-8?B?cklsMVJwa09FSkZrSFlGZ2psV1dvdmZBRVVwSTR5c1BTNTljZnU2RnhnRzVY?=
 =?utf-8?B?Y2JTaXVQQ3BZTW03aXg5ZTMvYWlqUmhkMWxlenlwNk1XMWZ0ejdkdHBYeUZE?=
 =?utf-8?B?SE4vVVpMeXBkUCt2NjJoMVowN25TUHdQaTlCQjRUTUJ5L2JYMHBoSHovMGcv?=
 =?utf-8?B?Sjh6QkhpVUxGVDBSRTBHU2VvRVQyNFNHTlpBcUpmeUtKUVhFWktSNnY0d0Ru?=
 =?utf-8?B?T25qVjNXdmdNVGJKTFI0RzA5NjlrWUZ0V0lGMmhBMXgxZnlBaEw2N2JWVDBo?=
 =?utf-8?B?MmJnR1RRTWVxQnNwSFhDQVRESUxDUFhOTEQvSEpSNXhQR1JQcTJNalZHTXB6?=
 =?utf-8?B?cmhWYnhSazJ5UFdOYzFxMFEvc2FCNVRtWUo3ak5tYm13VE1raG9VVWEvSzBZ?=
 =?utf-8?B?TUZWQXBKUm93QVQ2L20vbEVmZ2toWmZDME9lcGFaNEVSMVhoMEdBc2JxYUZH?=
 =?utf-8?B?cmhoNVVRVDFNaE40ZXZqdkVuakF1TXpoWEZIWW55Q0VxUHE4dEpkWVF5NWJh?=
 =?utf-8?B?dWcxa3U3M29rUXJFc1lsL1hxbmZOK1FNOUtwOElUZG8zV2lCcG9yZmxOTlc0?=
 =?utf-8?B?OG9MZVhvTmNpMnkxOEhnNnVrMTdDTUVaNXpvS0I3VFhIbXloS1ZhVGR2eUdJ?=
 =?utf-8?B?RXErVEhpcVpsZGdtbk84VGVoK3hsTU5qMTJadGtxbnpUL0t3N3I3NzlQYjg5?=
 =?utf-8?B?V0kvQnExcThyU0dyMWhwbWxqUkI0SkhzMkQxQ0hnWE9tK1lEWmc4bDZuZmha?=
 =?utf-8?B?S2JsT1lYbzd1emxpcEt0T1RuMnZXU1NGNXh4Q3Z0YkVyWFBmcUJyNzdaQlMw?=
 =?utf-8?B?bjFFUkxFczA3c0JKUGxJNGdMbHdJSUYwSWhwRDgvdlp4KzhzUUhkWUc1TjRU?=
 =?utf-8?B?R09HSjBMTTArVDFydDRpVi9mWjBObWZuT21pSFEwQThDaGxrem0rZlBiQ1A4?=
 =?utf-8?B?K1FKSW1ub3lnWUxXWStZNnUxeEFwWGhzdkVvMFo0dTNSNXlWcXNYK3I1K3NW?=
 =?utf-8?B?WnFzZVB4WjRwK0djNXZtazEwY3Q4QU5OdndNZGllSFNlWEpsY0l6UEcwYkg4?=
 =?utf-8?B?REllbGV5MXdHSWoxZ3c3N29kV0orR1cranJxaStGTDU4c0JrVXpNT1Q2MXha?=
 =?utf-8?B?M2tHSHhnNHhDSW9iSWpjcFRrbzlnYkNDWWdOTG9oNjNkU0phWmZzWm85NzhU?=
 =?utf-8?B?c1ZFek0rVTZzdkxRSGtwVm03ZEd0VE5aL0pIVXhkaE1LSlA1dk1zc3lXVW0z?=
 =?utf-8?B?OG01UHZ4SVl5dExWN0dPSkdUMWhUVEJDWkh4L2x2MnE0bEkrajEwdmF4ZHhx?=
 =?utf-8?B?TUxRZjZVZ081QkNkYUlLWHkrWG9ZRmVRbi84WEEvd2ovUnlxZUo1VktnaXJw?=
 =?utf-8?B?Rk9BU01WNkpucXZ4WXZkUnZKNWtTQTNUZzMwc3FZS1NNbERhYlU3emo3ZEw0?=
 =?utf-8?B?ZlNtT3hVM0JDNnN2S0MyTjc3MWJsb2J5WEorNG1CWHUyRm15Smora1lEcnJt?=
 =?utf-8?B?d0l6TmpDdUExNkFoR01CK2RXeWJvZDdhR3BCRjNoZUNGblBDZjE4dW5sdGp3?=
 =?utf-8?B?SUE5eVpySnd3WEkyT0pxWTVPa25JTXZXVmpOeTBqVmxzY1ZVNm43VWRNeWhi?=
 =?utf-8?B?a0RSTXJlL3J2SzVHdnhYTHh1NjVNaG1xRExBK0UrV0NEQzE3SGhSNGFKekQ4?=
 =?utf-8?B?VWFnRGNFM3RiOGFQOGs2NWtTMXRjQ1ljWEt1Nlk4Z2ZuSU15TEZpa3pnZ3Yx?=
 =?utf-8?B?dmxFdFZkS1VyNWQxTXd2dVBJMFVuK2UxNkc2RW1ETjB1T1pLN0w4aWpvUXZr?=
 =?utf-8?B?enkzL25uNXcwbUpHVEd6eUFuamNBa1pUSjlYNWRkSUdnQnNrWVZVRkx2SmZF?=
 =?utf-8?B?RmNBbnpWYlF4UlludHRaZ00zaUt4dHlxSWRIQlpxSi9BNzRiZGFZTVBOQWhI?=
 =?utf-8?Q?6EvDMzcZzSlx96na7/uRVn2CV?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9828bec6-c647-460a-0c9d-08dc70ff5dc2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 14:42:07.2630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IMT8/YJktfGBKrexrR1QKbfKsDjIws+InsfCtCwy7Mr3njZk/KDGQqJjEgfzXpLDdUyr1G7apdaf4c1sb9TFZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4116
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 May 2024 14:42:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15882

On 10.05.24 15:07, Felix Moessbauer wrote:
> To have a stable base for debian sid, we need to pin the package set to
> a fixed (known to be good) timestamp. Previously, this was done by
> changing the apt sources list. As ISAR now supports to use snapshot
> mirrors on-the-fly, we replace the fixed list with that logic.
> 
> This also makes it possible to later manually update the images (only
> the non-immutable ones) from a running system, as the default apt
> sources are not modified.
> 
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
>  conf/distro/cip-core-sid.conf            | 5 +++--
>  conf/distro/cip-debian-sid-snapshot.list | 2 --
>  2 files changed, 3 insertions(+), 4 deletions(-)
>  delete mode 100644 conf/distro/cip-debian-sid-snapshot.list
> 
> diff --git a/conf/distro/cip-core-sid.conf b/conf/distro/cip-core-sid.conf
> index 48f26ff..eefcbb5 100644
> --- a/conf/distro/cip-core-sid.conf
> +++ b/conf/distro/cip-core-sid.conf
> @@ -12,8 +12,9 @@
>  require conf/distro/debian-sid.conf
>  require cip-core-common.inc
>  
> -DISTRO_APT_SOURCES = "conf/distro/cip-debian-sid-snapshot.list"
> -HOST_DISTRO_APT_SOURCES = "${DISTRO_APT_SOURCES}"
> +# corresponds to 20240211T000000Z
> +ISAR_APT_SNAPSHOT_TIMESTAMP ?= "1707606000"
> +ISAR_USE_APT_SNAPSHOT ?= "1"
>  
>  PREFERRED_VERSION_linux-cip ?= "6.1.%"
>  PREFERRED_VERSION_linux-cip-rt ?= "6.1.%"
> diff --git a/conf/distro/cip-debian-sid-snapshot.list b/conf/distro/cip-debian-sid-snapshot.list
> deleted file mode 100644
> index 874047b..0000000
> --- a/conf/distro/cip-debian-sid-snapshot.list
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -deb	[check-valid-until=no trusted=yes] https://snapshot-cloudflare.debian.org/archive/debian/20240211T000000Z sid main
> -deb-src	[check-valid-until=no trusted=yes] https://snapshot-cloudflare.debian.org/archive/debian/20240211T000000Z sid main

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


