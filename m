Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D9CC71153
	for <webhook@archiver.kernel.org>; Mon, 28 Aug 2023 06:41:37 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.47])
 by mx.groups.io with SMTP id smtpd.web11.8110.1693204889909381678
 for <cip-dev@lists.cip-project.org>;
 Sun, 27 Aug 2023 23:41:30 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=d/wZd50L;
 spf=pass (domain: siemens.com, ip: 40.107.104.47, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDUROW5ipPT6MT+rnYUE6dJv5FsrDqJmabvjKerAxzw9MeA8OmSANtyK9ZN0zYun7hXMvFNMmt73L+AblGOxsyvAyJ55uNUX4L5Mhgv8SfxoopU/1bKCATbjdXIH/f39KrixuMnUfk/TJOI+7gUMQxu3+ik1nRgos7G6RpGY9RhpX/jH01gQZw7OeSTQOeT7GvTSfnu6GSkhm+B9ef+yUPvjBtAeL02g2bcaff9NSCzsmbNjXXXA0iPEwjZB3LFnQmziI/5AyWgNibxW1UE2vLCm0GKHXEOa+Wp2dejya8J+bJCbfYd8d28Zhly87RMPK++NB5xJwQsvdlO81Yn39w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uh0jGZ9R3gkvz3Y7BrNVZCMbhpD1G84N9jfVcGApop8=;
 b=l1n2L7fYJm3o/99yBrOEOILvpyE9fVbvckDoDQ5h9/lVgj/iqbmL2GVsf0eedOZSzoNGSfdkSi2leCq0LFo5WuOZKE0hxXWPIk9VXgqGb5yJGFa3//qkEPK8czn2auJ2HDEuP+w2dZ0Ko8Y4Z+x8/r/Z6bYKmWvZLjqOEUX9l9F/QcBlUwvvH9UD9AqVpmj6pwAqPJ5Wgw2qzWGypecmqV2k+OY43RC7Crqdgligx/b5nPREfQNdidE6LCwkBI02F/xMRi8F7bG6FpkzgHZ6V6DTy/1g7ZXcKT+5X5ZJ8p0pU13yxZON6D9Pp77uXVkN2OTWme0x5msvKsS3N5L17Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uh0jGZ9R3gkvz3Y7BrNVZCMbhpD1G84N9jfVcGApop8=;
 b=d/wZd50Lzyv1ukzJCrrs0WNTke/Uo4qcsGr0av4YsysoIcOV30GzKVdN7u8LL/AG3bKc0ub07NaEHbvUyzDhnM07GyxFY5NRHbNEGheLXerIYCROfsOOGkwci+0HHEaZwZLy4vIvvy+jOjeqf4WQDbTB/+1fU8p3vthP99BrlZYuG1k72DODzQbrBt08aFTBxezCitsYvlG3XLdamLeuyrz6LTsNJ/vNfq9u4hauzFaLRlDRQt/+9A/BEY/ksPVsdmgqUMRSWuSRsKR29oMECQb4OxJt9AYCr8AVRptfe3Dl23BtrvU0vP/yD4ReWLMGTJc4CX2GAO6BdqnOiYwWLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5401.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:336::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 06:41:27 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 06:41:27 +0000
Message-ID: <33f96612-8663-4918-8968-6bd85fac5253@siemens.com>
Date: Mon, 28 Aug 2023 08:41:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core 3/3] Enable secured boot for BBB
Content-Language: en-US
To: tho1.nguyendat@toshiba.co.jp, cip-dev@lists.cip-project.org
CC: kazuhiro3.hayashi@toshiba.co.jp
References: <OS3PR01MB5880D01E2FB9699B6F47A66F951FA@OS3PR01MB5880.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <OS3PR01MB5880D01E2FB9699B6F47A66F951FA@OS3PR01MB5880.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0129.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5401:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f374d9a-8ba2-4170-7e8c-08dba791cddb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	f+DZzL6kFUQeNGWbJeLZzBlhGjA2e7pg5kAFg0XqiPMiRtJlZ/p1wBZWxdFont2ETR7zP5KXejXc381SXpV8PHZc3o31DgSM/9CW2yNXuUf96I2wSNcj/XdUV6bWeW9vtmB7XBPCREwCMSm7PywCEAkswXfHNW/htSe1UOKXxpPResRwkIjGoc1KEjHBanaDcsHqUannDOGGRRDW6cjVnb/FV/pfLWTEMmQLF9a1cbrdAN1gMVfFX0kYgRkb8whMcy+ikh8SBckpn2EMX8uggKfcK3zAlXu7+ZsXGm5MMMCpYXTmGDO3YKsR5SeM+sxApjlh7BJ1QGfew+Rp1o4af1uFQsqoFsYWX/7A0mw3Mt5Qwg9csa+0Av1JyhcCh7X9tiCnh1J7Ug3QV/9Qkqloi8EdKJVJ/sXvvdkjYx97K4pjGcCV3qFOTKV7aur5mRx49ljLaodRS0RysdwxlOQ9i//5A+kp+TJhTS5/q+wghkqLsHQCB/bJl1zPw7sslmVm31+Ga985SixOttZ5dW98J0f/FZFkk5LhLteH+hxXoLBZMnB7uEMGjQY7E91+7efNcWhANaO9/l/22QEvXj1KGzMcrOhhM88BT6Z7E+pXWLwYEKfOQtqc0h7lSe3WDEY+fxuKFbYww4o7AOCBzRSSkw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(136003)(346002)(39860400002)(186009)(1800799009)(451199024)(2906002)(5660300002)(38100700002)(4326008)(8676002)(8936002)(44832011)(82960400001)(36756003)(31696002)(86362001)(26005)(31686004)(478600001)(6506007)(6486002)(2616005)(6512007)(66946007)(41300700001)(66476007)(66556008)(53546011)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?eQPgV2c7uRBzxZhg+taPq/STwc8kjdqBdNqk9xnfGXHFJ7gDkmfspdWXr+kv?=
 =?us-ascii?Q?CDyFePoE60bAN3x/PT+Pf6/mAQ0pxnlR2452xSVkiUIlh+kr8noN8YTmb+j3?=
 =?us-ascii?Q?hxiEWNAyNzfxv3TVjSJTo0Mt0SXv4nXZC9gAQBmvLptdpOQyzIDsOBnmoCAI?=
 =?us-ascii?Q?J2808S8uwzb+ErAhnZG5+M0cjBh9nCutvDuDp4jxVXSNQkEZUUOy8RXJDzsP?=
 =?us-ascii?Q?v47BAfGowhUTGpRHyXUPu+HcuYDVKRGHu4FzeOroUk4CJhitwgy+dZ6R+w6s?=
 =?us-ascii?Q?hMYVOnm5prnzAJOuoR729/e18y8Vi3n2LW7K78Vg3U6qOslueEdsE8dF0pYo?=
 =?us-ascii?Q?w8RmV1u+QwJRDW1FK9jdkKkmQylg+YmwvEANTU5CF5AuMJTbMn8qhkjjd6vG?=
 =?us-ascii?Q?JpQO5/VY5sy4Wvemv6BHdqL/JUT/AVhcQnGqGAROiEdTTs0WkpBmz3xKQp5O?=
 =?us-ascii?Q?IaICQ5oV5AL5iaNB6BrOqhjWBS7XzNpwsLtFuq6xP8wQJmqjpt2MkFmr34+X?=
 =?us-ascii?Q?jd7uAIy2iT5vf8ap0TYtH3N+7FBFflY2qtQ+hrMzuGfqqrr/AzgIC1mYEzBU?=
 =?us-ascii?Q?EH459B8rUffTUdagyCmQ9e9sWvcJKdzV5zGUKK2XYR+r0q8aInz4oa2SFGV1?=
 =?us-ascii?Q?36j3vGZ/sqPQAFt29YZoZ2dLM6R1chw5r0uXiUdJcZpGznoVWVjZsC4UnMZG?=
 =?us-ascii?Q?e2N68hGcyH3RF4RWWhqPF7xMKcetFyr+QJ56yWD2RYnwLv8Ip9Ky//xOJL1y?=
 =?us-ascii?Q?wMjb+ImWyHQwSDfGbgYNuvrd4l5GB84MM3XhC/prO7QCNl9Q2qjQn58Q1O/2?=
 =?us-ascii?Q?77HqwUdGMqtFSz0RB5BlFyh5dOjsczG6rzl1mUbNMdFeSe0DgBRRqFpGl/G7?=
 =?us-ascii?Q?FCnzcoi3NS/qJFMau+oDHb0tllb+MGoF6HVMEUFKDJNSt7g/JBQydYByv+EH?=
 =?us-ascii?Q?EO9MK2uqDbQ8dRzvBvjVQnAy1WS2ZKP1PNA8NHIai56jSjcYn7M+Enmb0WsC?=
 =?us-ascii?Q?JqIiOOon5Lin9jrnGHqXshG9NP7I2vQyiUZYEYSwUvpOP7aSWhTj22LsqMrq?=
 =?us-ascii?Q?VwmlQBHnBljs93lT/Tc2alXrN55PV+Taj/hrYwthkBWfoWNvE8FlWZhKCg/2?=
 =?us-ascii?Q?1BkniXymTvcYcIfAk/hoe3tqMZZHx0fFkCmDbx4ra2jBZ7HTIprqri/eFRAA?=
 =?us-ascii?Q?N0alhdOANtj9axeFi5Ae16gSgfb55DoTl2NDVTQsqs+ztf5E5c1s2Y9Xa+a/?=
 =?us-ascii?Q?jnYVMzq7/abWbNeUSRrq/xX9WnzjMdfkRS/iv7d3Y33U2ldzo05olBe/PwIB?=
 =?us-ascii?Q?CCvUZC9ZIdJohLfprdmodpxw/MK6GEF12FrGi1JsQd2MVePTnJPk/+MOEU6i?=
 =?us-ascii?Q?WHBfGNU3stwdhLfXL1Jynw+gP2n3Ntzhh+K9OXjg92mQnG9CdprCIWzifFZc?=
 =?us-ascii?Q?iRVOJsucxjwt+fhjJsFQEq1W1wc7KnAfDtcYysfUz/FWWSVF7pCGPbGAyKEF?=
 =?us-ascii?Q?pywZoGqKC2dLDUWMwUZBhXmmdB4LXDnNrKxvloA9W90O4F8v5XhlYYI0Rwh7?=
 =?us-ascii?Q?vIvfSMpgnfyCiVtO2NQtUBTKgsGHlpmDSzmAYWMy?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f374d9a-8ba2-4170-7e8c-08dba791cddb
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 06:41:27.0634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mRXR2ZnHeEeIU1BJRab+3hUMzWYVPYGBY9hmCEbqPW3zt9Bpuu0ZlzY1Qg59YTgU0sN+HgE9/o+SwuGemgCQ7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5401
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Aug 2023 06:41:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12874

On 22.08.23 08:54, tho1.nguyendat@toshiba.co.jp wrote:
> From: Nguyen Dat Tho <tho1.nguyendat@toshiba.co.jp>
> Date: Tue, 13 Dec 2022 10:14:04 +0700
> Subject: [PATCH 3/3] u-boot: Add EFI secure boot dependency
>=20
> CONFIG_EFI_SECURE_BOOT depends on CONFIG_FIT_SIGNATURE.
> Enable CONFIG_FIT_SIGNATURE to make sure CONFIG_EFI_SECURE_BOOT enabled
>=20
> Signed-off-by: Nguyen Dat Tho <tho1.nguyendat@toshiba.co.jp>
> ---
> =C2=A0recipes-bsp/u-boot/files/secure-boot.cfg.tmpl | 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git a/recipes-bsp/u-boot/files/secure-boot.cfg.tmpl
> b/recipes-bsp/u-boot/files/secure-boot.cfg.tmpl
> index 956dcbf..6111007 100644
> --- a/recipes-bsp/u-boot/files/secure-boot.cfg.tmpl
> +++ b/recipes-bsp/u-boot/files/secure-boot.cfg.tmpl
> @@ -4,3 +4,4 @@ CONFIG_USE_BOOTCOMMAND=3Dy
> =C2=A0CONFIG_BOOTCOMMAND=3D"setenv scan_dev_for_boot 'if test -e ${devtyp=
e}
> ${devnum}:${distro_bootpart} efi/boot/boot${EFI_ARCH}.efi; then load
> ${devtype} ${devnum}:${distro_bootpart} ${kernel_addr_r}
> efi/boot/boot${EFI_ARCH}.efi; bootefi ${kernel_addr_r}
> ${fdtcontroladdr}; fi'; run distro_bootcmd; echo 'EFI Boot failed!';
> sleep 1000; reset"
> =C2=A0CONFIG_EFI_VARIABLES_PRESEED=3Dy
> =C2=A0CONFIG_EFI_SECURE_BOOT=3Dy
> +CONFIG_FIT_SIGNATURE=3Dy
> --=20
> 2.30.2
>=20

Thanks, applied.

Jan
--=20
Siemens AG, Technology
Linux Expert Center


