Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6267C83F01
	for <webhook@archiver.kernel.org>; Wed, 30 Aug 2023 06:40:00 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.41])
 by mx.groups.io with SMTP id smtpd.web10.8393.1693377592253710139
 for <cip-dev@lists.cip-project.org>;
 Tue, 29 Aug 2023 23:39:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=DxYffEEo;
 spf=pass (domain: siemens.com, ip: 40.107.21.41, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZy78Po0HNwV28J6E60NpOeE5AelfzKlBor77yVNc+moDHA3BzQFmaWotq+taIvw8wKGzYlAK5D8krZQ+9RSLd4cGIhCuFXtMrxyjUCE3B+T/ObzEdzsi2JfN49Ty8dG8b/VQky+Hou2B5HRg0kZnKlZ8+6+uXWGGDSVEJ+8BEm18O/7/rYtq5YTY/gPtUuNnoxMlWWeEtJDGhI7jGB7hOD8f33KSYnSsRsEOLffOw49q6pOAA3CIZbQnm3PvflJ9Ngnxap4Hjw7MdJPv+X++W737cQMCo4YnTN3mzsdRylo3Jc6ZvRo+Zl70NnrMTsZdatBLDwPetbY8l8nU4tBgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uNiAKqUrjfSB5IVX5sd1hYz1yJO+MYiJaId3CCAmO7s=;
 b=XKshgWTevCgX4EDnEMTDKLDilkib6HvVVY/3Soj5mrOFVHs7mkdBtaXtyGMrS7lCdwOffRr2SwNMrRsgHU2C5qaKHv+VUnFxgRGFDoM5x+cGcTYbJ+wWd4j/coeivZtJAONo5ng1USx3ICDoUqzyA2sJwXjgnIEfaATqdZPoJ/J/UTV1Ia7qGFuc2LeVvIhRxKdy2L93NHMjK0PYmUcdO6dApZu2bSL5GXauoSFcTsYkoDXOiXUqTRUMyq8RcIs7enyBHY+2LPWZv8/496nVQKg/a5s1YAv+/f9eBKsN5FywD3tD7Wjjm+saALIZWKa6V0aETmeRPQVREzDjpczCgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNiAKqUrjfSB5IVX5sd1hYz1yJO+MYiJaId3CCAmO7s=;
 b=DxYffEEowZjA7Y947QJ/qi69+E/2ih1VaniuI70sGEY+iICR5EUWf23LC+IIBA1+mT0dwryqgWwbMO9SX0p6D35guNdHc8UxvkIttetbUgA5qrJrfSyM+9PlejjHxMk/V8Wu1y59JeBHhyuZeQzoPV4ufN6rSaliRyNPHRaXjcxNnu4LF+lrVzKsgZ/ympAGa5T1lMQYRPseSir7btIw/naGvy4EEcjJyEkc3YcqUO1yssL8NrBvVDjMK5D5fQTS0/oM3cDtRuzB8X7fa00ZuOaJ4an/xeybl6jCIhBHWq3L/Qk2UcQrGYiPilMHZ1ryMSkl97a80J+9vly5UEcu4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VE1PR10MB3902.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:16d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Wed, 30 Aug
 2023 06:39:49 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6699.035; Wed, 30 Aug 2023
 06:39:49 +0000
Message-ID: <595c4f2e-840e-4e32-8953-5f0079afe186@siemens.com>
Date: Wed, 30 Aug 2023 08:39:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core 2/3] deploy-cip-core.sh: Workaround to search for
 swupdate initrd image name
Content-Language: en-US
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20230830044115.1112349-1-Sai.Sathujoda@toshiba-tsip.com>
 <20230830044115.1112349-3-Sai.Sathujoda@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230830044115.1112349-3-Sai.Sathujoda@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0124.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VE1PR10MB3902:EE_
X-MS-Office365-Filtering-Correlation-Id: 31d2a0ac-b453-4355-1c34-08dba923e837
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	g5NBU2paa2gSjzWUZUXjuSAyhvPrC4Oj3TMQlEFSFxEUZzRcwoUrabIULhYrLv4gE6hXhT9TqOaWBO0y0AfU2fsO4dY/oEfP5Ay0vz0/dmf9ffvWj+OfIQI47xP0KrspdNo4SiCAbr1kLB2oz56U0J81LJ2RonlujR9h7ZRsPxAoiusMCOt9Av21kJx7VsbA3dYDgkrm9C53LE2U16XNsy9e4qw8hxQRk6OwmjTYEUIrIefj1AsYH3Y3kXJQaYaVBXrRmuFqYTIQ6kw6U9CZbaHx7pUMGXiX9f+Y2F3RJcSa14oyO5igQODfU+1i7IgUzm4a71iAQdOkSESycyJrhwEBCQ1CUWJ7f2tb4v7ytIqPhXpMENHnxmiO64HLGw5B9dm9/Nn0wQGSplXzkHp+IovNqaCcDmWWIaAOLCcWbJL+J0x7zCU/VncHfoRtYdWsMySio3lhF1fPKk9QJmVIWCYpqNh7ZE4gxKncviwTUqRTxh7vOJ7asNKI0RKtbR0Mq830HBOUS1g4tedGhbJg8MwWuVwG1NlVB8BkPsOWUx80yZJiZkELP6wuttYCU3f1BuPPYYreq6YjoZzaSZo4flLq8bJmipROuQ9KN6CMzEO3NgQru8g/0PhV3qXi/51Etfrblv9/PFUYm4Cp9qUaPw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(39860400002)(366004)(136003)(451199024)(1800799009)(186009)(36756003)(31686004)(83380400001)(44832011)(86362001)(31696002)(5660300002)(41300700001)(4326008)(8936002)(8676002)(53546011)(26005)(6506007)(6486002)(6666004)(2616005)(6512007)(478600001)(2906002)(38100700002)(66556008)(66946007)(316002)(66476007)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Tk9QR3h2d2JCUWdpY2ZmYjVEK1dLT0xwT3Q1Y1lRYm03RTcxT1BMZ3NNUTRV?=
 =?utf-8?B?WDF2L3pHOHRaN25TVFlvNjdjQkJOazhGaGgvVDNIczZqZGQrbmxDR0dXMThy?=
 =?utf-8?B?dzZmZlk2Rzl1emg5TVQxQklmTUZ5eEQrL2VlbjNIWWpMNEdad0FWL3FPSUtW?=
 =?utf-8?B?Q0Jla0txVkVzS2tHa3ArVGRlaFRtR3Frek56eXJHaCtEelAzTkJoK3RYYzVR?=
 =?utf-8?B?c3BhNks5VjYwQktPS0RpRWt1aldPbUs4WFd6OUFmYjZibWJ4enpDMW01ZXpw?=
 =?utf-8?B?Z2N0QTczbmllT0ZuREI5VXlNTUtKNHErbDdEZXp3SU5pL3ZBSnF3eDlQME1q?=
 =?utf-8?B?Q21aN05aMUxXZDhENXpkd2xsUnh4eTlsbFlIeUdtQTh3dEs1QkNhUEwxdGF2?=
 =?utf-8?B?VVZvZW52cmpJczJkRVg4ZkRtVVRQcW9aODJYc0MxR3JuVnRmdFFtbzFidnBt?=
 =?utf-8?B?d1RhZktsaWhOZ2xpajN6TEYzTGJob1Zka0VLYUdXYUoveUFCWTZXQ0R3MXZ3?=
 =?utf-8?B?NHhELzB3bklYYkMvT1U3Mi8rVnlYVmQvcWZTQml5UmxMbUlNYU9DbkxNZlRr?=
 =?utf-8?B?T1V5R2xwcnhtWjJYcm9aczFycVBwTXFHZWtaWDllU0NucDR5cUErTVNVdW5G?=
 =?utf-8?B?dEg5Y2NpeTQvRmFjajBFVlluRXU3UFpXYTI5K3hELzBnUkVrcHJBZnFycWlX?=
 =?utf-8?B?eG5uUHFuN0dGQ3kwQU5KYUdHUnJ2aERQQU5mWGY2UXNKK2JNS052c2I2V2kw?=
 =?utf-8?B?dUJ5amN6dmtIQTVFVE1zYWhtQlMvRE9NOHRhUm9oNkI2Y0VRNERuaklySDF5?=
 =?utf-8?B?cXFDRWxjV21Ic3ZtRHFKRmRxYzlYZHVIMTZCTG8yeW1RUGJrUjlDTVRyTTIy?=
 =?utf-8?B?UHVvRzNyc2w3YTdGU3FCQ3NtdXdwc1ZVVnBETEVQOEFtbExjdkt0ajNFRFNl?=
 =?utf-8?B?ZWtNMzBMMTVieEtzY2U1MHp4L2VrOVZlLy9wc2ZZcTZxZG5OQUxyNUVBRE93?=
 =?utf-8?B?S3V5Y2xsaGZhdkJVZytnRCtYVEx4SnhlbzhIUEdIdW45dU55a0NidFI5czRC?=
 =?utf-8?B?MkJvd0oxYmVZTVg4NVpueitQclFkOHd6ZTU5WSt4WXpuUnZvSFVNVkQ1Zzh1?=
 =?utf-8?B?RzNHazlRMzFxeE5YV2J6WDh0eURJU2oxb00wUFBMSmRLY2V4VmwyeFcwUVYz?=
 =?utf-8?B?QXBxUVRvM3p1emJFVENJVXRjb1QvQlpCblVJeTlVb2lvWW94OWU2c3hWakJu?=
 =?utf-8?B?cjRmV3NBYVo0T2xJMnhxQXpkWUZDa0hOTkdqRWJ2czJ4cXRRanRwUU1Fa1Ey?=
 =?utf-8?B?SUhSTjRiK2F5ejU2QlUzakFCTGtJUjlxY2lHdjFNL1loMHJvUTF5VEVUd2NN?=
 =?utf-8?B?elprYm9IUkkrUlF0dkdrUktiM1FubzZWM2wzejZGYVViYUMvSnV5d0lRZldY?=
 =?utf-8?B?ZjJCR0JQM09lbExYc0JVOUtKY1czQ1R4akl2YUFlMWx2WWtKNmVER2F0U0hR?=
 =?utf-8?B?WUJRLzBlS0RKOWt6UkZQRFlkc3kvWld5VWtaT09qbi9VMFBlZ0svUXlZSmNq?=
 =?utf-8?B?bHByaE9HYzNUUHI3UEFJVmxmR1ZmeVFPSlh0cG1HdEYzQXBMYjJMS3kxOHVs?=
 =?utf-8?B?VHNsK2c4Y09TZDllNVNJTzdNS1RQL0RDTXNDaGJXNFdDclRQeTZ1cWtueFJq?=
 =?utf-8?B?Zkt6Rm1MZ1Myb1pqR0lUbnpqTG5xNWxtQnFLa3JJQWk3SzlmaWlsSlI0QlMw?=
 =?utf-8?B?UFVJNHdGemNOOEJ3MjlSdEYwL3IyaWFYS3c3TG5oN3g2aGY2STNkaE41MVQz?=
 =?utf-8?B?TGorWGNNUFZrTy8yTWY0RmExamg0RzUvOG16WHRZQnFJNXB5aGN6amhFc1lN?=
 =?utf-8?B?R2d6RmZLdVBwMkMvQlRqUmNIT3JCaXVMdVY0QkRGUE16UzJ4NS9SNkRFTjZp?=
 =?utf-8?B?Nk1sdVVWRENWTzhOVEJuWFdoVmZCMnNPaEc0eVA3alJhQnVxUThVOFdWb1RH?=
 =?utf-8?B?dGdKNmF6MytJS29Pb1MyOUlQMGdvVUpRK2tjS1BkUlAxRUxuUFIyS2dmc1Mw?=
 =?utf-8?B?OFh1OEhERm5hbmh1MEJPQUlJN3AyWDJlVHAvL2FnQW1LcDFubVMyUjF4cHJl?=
 =?utf-8?B?QVFYa3JyMVJ4cWJaQjFEQ1pGc0hKTGw2dTRURUsyaDh1RHlhT0FKa1pYYnMy?=
 =?utf-8?B?dUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31d2a0ac-b453-4355-1c34-08dba923e837
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 06:39:49.0841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sH3CfLsy/bP/Yrs0SVCOBenKTFGq1Y9NhMF13vaqwaAj+Ce+KMqxKcX2rCn2u562LjtArXFhRQvs+kRapwsk7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3902
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Aug 2023 06:40:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12908

On 30.08.23 06:41, Sai.Sathujoda@toshiba-tsip.com wrote:
> From: Sai <Sai.Sathujoda@toshiba-tsip.com>
> 
> Since the security image is now included with swupdate feature, deployment
> of initrd image will fail in CI due to name mismatch. So this workaround
> will search for initrd image name as defined in read-only-rootfs.bbclass

Let's not do this as workaround: Some images, now the security image as
well, are not delivered in broken-up form but only as complete disk
images. There is no point in deploying anything else than that for them,
not even the kernel.

So, let's pass a switch to deploy-cip-core.sh if extra artifacts should
be uploaded as well and disable that for the security images.

Jan

> 
> Signed-off-by: Sai <Sai.Sathujoda@toshiba-tsip.com>
> ---
>  scripts/deploy-cip-core.sh | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/deploy-cip-core.sh b/scripts/deploy-cip-core.sh
> index eaa8974..868e28e 100755
> --- a/scripts/deploy-cip-core.sh
> +++ b/scripts/deploy-cip-core.sh
> @@ -46,9 +46,16 @@ KERNEL_IMAGE="$BASE_PATH-vmlinu[xz]"
>  if [ -f "build/tmp/deploy/images/$TARGET/zImage" ]; then
>  	KERNEL_IMAGE=build/tmp/deploy/images/$TARGET/zImage
>  fi
> +
> +INITRD_IMAGE="${BASE_PATH}-initrd.img"
> +# swupdate image initrd search workaround
> +if [ -f "build/tmp/deployimages/$TARGET/cip-core-initramfs-cip-core-$RELEASE-$TARGET.initrd.img" ]; then
> +	INITRD_IMAGE=build/tmp/deploy/images/$TARGET/cip-core-initramfs-cip-core-$RELEASE-$TARGET.initrd.img
> +fi
> +
>  # shellcheck disable=SC2086
>  aws s3 cp --no-progress --acl public-read $KERNEL_IMAGE "${S3_TARGET}"
> -aws s3 cp --no-progress --acl public-read "${BASE_PATH}-initrd.img" "${S3_TARGET}"
> +aws s3 cp --no-progress --acl public-read "${INITRD_IMAGE}" "${S3_TARGET}"
>  
>  if [ "$DTB" != "none" ]; then
>  	aws s3 cp --no-progress --acl public-read build/tmp/deploy/images/*/"$DTB" "${S3_TARGET}"

-- 
Siemens AG, Technology
Linux Expert Center


