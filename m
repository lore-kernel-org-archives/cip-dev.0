Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512CDC48BC1
	for <webhook@archiver.kernel.org>; Wed, 14 Feb 2024 17:24:53 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.50])
 by mx.groups.io with SMTP id smtpd.web10.46827.1707931491613588985
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 Feb 2024 09:24:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=hrNP8lR5;
 spf=pass (domain: siemens.com, ip: 40.107.22.50, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bjSpXuFDCp/F9jYZ41fvbAZvPkdN1/j4zF5SmXVYz10JMloAftWNesKH8kl9LOjTz3xOnL53vi3wA+atvBu0SDpQrLi4nZCAiSpqDJ3anV/b3XXHT3GCy+Uejf0qw04xCeZVDYP5Qnl0q/vugSRhHQQz6QZBYFh/LyKxeeE4DPIkVJuZ9vP8HzrsCFtGfHs8R5uVvVW8ou9wGyhQrAKsFlGGsRXHEWDut6tRRarEE1W7kake4+L/05Fz2UJcT18026KIll33wIs2JbF4R31oMMfpoVsZhbO8KcMgnvO46TZtoTl/AHaRPXBDEf4GpIWAmiMeyn0NXK0l5/rERB6DPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6GgkO75MJWuaziyPaqomNli9XZwpjQxm1a93OucQCVY=;
 b=JEQBoCQse7CTvYpQNpLAHD9cm4LS5GHzolUFiwHoKlZjr2VwnLLcL1o4Feun+GQLTTuK25hrUqcJcfZUkrk2MSwOkKIJRTxabUzVooI4khDGjxre0iT0JbLdNjP2JXIQ1SGE+Mx/WUkUti05kNZObOcsb8/cPb29AfV4dMqKjgP3vnQaeLhmZeyTu9kshhLZXKKurD51TYFx+ZZzSc9VDoc4ObcJJNr8L9TBye7AFSF2AOiDoggjDyYq27R0jCZY8U6EacFoXz+YrPjVZvPEM/U8w2nbGQbGzBojB+nmcE8WVjgRyF47LRR6/3dtq5/ICn6iRW2KMU+UnL+3KAPNQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GgkO75MJWuaziyPaqomNli9XZwpjQxm1a93OucQCVY=;
 b=hrNP8lR5Ff4i7TORV10DIU2YocrVvw92SuU7SXr/AYjrbl4KdM2oZVZ6TcoxFH+FlZDXrpOfDZ8sxkpnq4NWf4gaIrzcg77rZFPnZpQfSA22W8fSjuTeSzdr2V1e0XdC3AMtIhfErb+61mcuogUtlWW54d48dstClyck2R4bSIbAlLAq9St/fYHONrYbuoxv0fAL1ANTuxX8sCUMIkuHwSCVKztRVEZUCR9+ys6raUeaNX1HqrofrBHxL22S+8epELD991XQdubD7lcKWm7y9bi0D7F6DFfL4IULL10sjn97RM6taTKvmsmlWNV8BFUx9ayJz79iTYN2wQMJH+nKXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6251.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3ee::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Wed, 14 Feb
 2024 17:24:48 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7270.036; Wed, 14 Feb 2024
 17:24:48 +0000
Message-ID: <6a4bfb1e-7240-4714-8794-ac30fd1900a3@siemens.com>
Date: Wed, 14 Feb 2024 18:24:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core v3 2/2] .gitlab-ci.yml: Add condition check in
 .build_base to build v2 image
Content-Language: en-US
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20240214154820.3544080-1-Sai.Sathujoda@toshiba-tsip.com>
 <20240214154820.3544080-3-Sai.Sathujoda@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240214154820.3544080-3-Sai.Sathujoda@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0019.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6251:EE_
X-MS-Office365-Filtering-Correlation-Id: be9dee9e-c382-4103-e201-08dc2d81d875
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Twyw4rUlln+HCfsOdKBjX3Kaz2L3jO7EDsETpGLwQh+sPS9cIXiTB4N9+hMAx0hQV3aC1ZrR8dQW5bV+Ot5ZY5PjquBiXc0W96pcugW11gvFME2Z6piFdPvEMaZuN9h46mlMi5DB3dC2G++OuBPf0+ZIHvk942W7Eb3lMDnizw0gAtuuAzgH2R4Y56lJ+se8DricdYjNEj31dlk1exIHnnm9nvocJJ+yLrmrxMws+mQj2PxmNTiRADJkw5OLHVJcnT5vKU8qnj165ncnEiSiE9Nq3tb5rOD9RDny37Sh+SL1E8XUmxbM8yhdP4r7Gc8javvsAW+UKZOl1eWQO3woa5xsqEhGE/zifwlhxdD8Z+dwVWXqADFeHm9rDdpG9Ay9grpAS7wRN/4b1SHc4Q0a471y8j8hKdvBs5/D+TLNhmYsvsS+4uhJHhFiC6buIJNO/OGIENGg9B17PqXjpgCG4/VPuWgLvqjpYdSScrKYEyRfAckfJEtiktDf0e3SfSkUHKPdDS5VjERckrXjroqIG2OOIW1wKzUUR+0CyNdyQ1PVs/cSetpH3NdDv9Eyqvj3
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(376002)(366004)(136003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(31686004)(316002)(66476007)(66946007)(41300700001)(66556008)(8936002)(2906002)(5660300002)(4326008)(31696002)(8676002)(44832011)(36756003)(86362001)(2616005)(6512007)(6486002)(6506007)(53546011)(83380400001)(82960400001)(26005)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aFF5a1JlVjBwSlhqeHI0ajhiWkVyWkZsR00rZnFUTVZBL0lzU1lEUnloUWdi?=
 =?utf-8?B?OGw2UG9peEdjMXNrQVp0bDhxYS9kOVAzdkV6TGVZVUd3M3QxZlRrc0Z3blNM?=
 =?utf-8?B?R2NZZnVJZEdQSU93MzNaaFpvWUxSUjN0akIvVkVVaHVrMlRxL0w1ZE1zak4z?=
 =?utf-8?B?OHZER2tCMU5VVkx4ZExwcHFCeXVnWWJyYnhMUFVFbTVldGt0SHFXV3A0VzNi?=
 =?utf-8?B?L1ROa3RWWU1scVEza0p4RFBHWHZ0blFLaVZadzUvNGp4NmlHMUdTbHBBSWlh?=
 =?utf-8?B?Mmk2TmlWU2M4ZFFYYVRpTWdrazNrRVVpOWlEQS94ZVgwenVVbndLbjhVeGJ2?=
 =?utf-8?B?elNaNU1VSllqV0NuUVRyZ0FtV0c1TUJ5NGFVUDM0VXhYcSswZnhxdlhLRy84?=
 =?utf-8?B?NUZFSlpHeHJranlkWnlmNmdrK25Ld0JQT0hhK0xBalk0Qmp5MUVuYkwySWRP?=
 =?utf-8?B?SlhHMWEzaytlRnNHSlU5RVNRZU1aMkZsVzJYOWVJZStVYkNQOW94VVlRSHpu?=
 =?utf-8?B?Wk1lM3ZrYnVoZ1l4Q2I0T0xDejRpak5acDREc2dPZk1Hdi9OdkRGRjdBRG5r?=
 =?utf-8?B?QnFvNHZvNWIzd1hBaWkyeEFJb21va0xjanNqMysrUHlpbmhvZUE0NUUwYkMw?=
 =?utf-8?B?NDJWM3lnUHpUTnJ6T0t1ZXJ1alFnVWtsRExIKy8yT0Z5dUoxMGo0dTBkTHdp?=
 =?utf-8?B?YkhnbFduUEwzQVIzNEx4azIwSlltTE5FNkRXUHJPN1VqcmIzR3kwZit5RXp6?=
 =?utf-8?B?R3M2N1VWZmRiSmxhVlNZQ2Mxc1A3T3JnOTE1TXdQVFVxeFQwTThhb0RndmRs?=
 =?utf-8?B?ZUs2YTlXYitvbXA1d2lqQlVPcW5KMW5VbGUxa3d1MGxCTHZneGFiRE4rSGww?=
 =?utf-8?B?R2dOV0VuMGFRWWpZdk9wY2xtaXdLQmM5WXUxS1poWkVxT05xbVZvYTZ5aHg1?=
 =?utf-8?B?dGpocU9UaDVkb0hqS0lyak1yQUJMREsycWlPVzMreHc2NTVxTThCcHZsZG8r?=
 =?utf-8?B?RThLNWJwM3hxdGhtRGo5MDdjVXE4cGpGd2NoRGdpd1FRMXNiYmR2S2sxYWVR?=
 =?utf-8?B?T0tTVHhuaDE3VXA1N3pwMGYxSG5rTWZSeTVmMmI1anp3UzlydE5ObVdZU0ow?=
 =?utf-8?B?RHhDWm0xb1o5SjIxRlhCN1FXVGppcmE0eXJrcTFBWFpxRDIxVG8zN1R6dHBp?=
 =?utf-8?B?d2dTVndPb05GN3phTUxhYlBDejFlWWdweklFbnFvUWlFNkJUKytRK2ZTcTRE?=
 =?utf-8?B?blMxSWV1Q1F2NXNGc0xPWm10TnhYK0hKTzBzeU4wcjZtSGhUeHNpUklNSFpq?=
 =?utf-8?B?V1pxVXVjMUd0T1JvN3ZnVjM2SUFuL0JLem1YR04wamcrZ0Rma3BFd3FNclJ1?=
 =?utf-8?B?VU5GUExwNThyQlhsM1lETHdMTHFaN1YrT0NpVVhndDFiRkxoZmlEN3VQLzhG?=
 =?utf-8?B?NW9LMzRYYWdHQ05UYjUzOUgvZ1I0YkRFTXYzVXZYOVowYjNkV0hsMG1hRWNy?=
 =?utf-8?B?a3QyYXZXUkJ6OEFOeE1CM1RlSHF3WTVaTDRXTDVVaDUyWTQ4OWlpc3J6bHpF?=
 =?utf-8?B?VEZQQjRFK210OGlUSnpsalpZckRZOWJmWVIyWmhzS1BLYTMxancxUzNxRXhX?=
 =?utf-8?B?K0VPQlAwbDdsZ2YwM0RkTkp3andtcVRTUkxuWlNhRFNiYlZDc0VQeVJuNnFo?=
 =?utf-8?B?RWQ3VUdLa1hXa3NRSEZvcmpNT2U2TElkSHBwWGpaMEpxeStjclp0T0h4V2I2?=
 =?utf-8?B?T0FJc1dTVEkxMTNoQkdId2N6UitlWVRscVdGTXk3elhENUN6UVlkMUpqYzFu?=
 =?utf-8?B?bHN5UjU2bXFRVmlITWRxK1pSVEc5SThmY0ZYdVNrM1ByeUZQeVdveHpQZmZK?=
 =?utf-8?B?VThUWStEaC8wbk0zVUZKY0N3Q1kzUXpZOXE0MDdrVmRwem94MU15bkViOWUx?=
 =?utf-8?B?NktiL0h1anBsakg1eVVVMmNpR0RQdnZOcDBDRHdtOFVmdC9PMDZqVVJXbmtr?=
 =?utf-8?B?YnNVK2VuaVg5Mk9VdmlObllQUzFJeGNUYmFMMkREdXI4VDFYKzQ3dllLL0RR?=
 =?utf-8?B?TCtCUUxWK3FzcnVoZEJHZXlwRkoyRE9MMzRxcVFsV3BPQnRUSkx0bkRVVEkz?=
 =?utf-8?B?a25kOEVaSGRPNTVxQ0VGclN4aWNjQzlyNkdpc1QvNFdTM2tRMHhDQlAwNDV3?=
 =?utf-8?B?L0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be9dee9e-c382-4103-e201-08dc2d81d875
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 17:24:48.6153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h/Bxg22L0yHooFhYx+PnB/xu3WEqyz27b0cu5UN0Ylp0EwOpyweZ1BEwMK4XZnT3LtHami9hLzWx5zRK+y8Q5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6251
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Feb 2024 17:24:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14983

On 14.02.24 16:48, Sai.Sathujoda@toshiba-tsip.com wrote:
> From: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>
> 
> To re-use the built artifacts of v1 image, the consecutive build must
> happen in the project directory of the job. So if use_swu is enabled, then
> a consecutive build with a minor recipe change is done to get an .swu
> artifact for swupdate testing in LAVA.
> 
> Signed-off-by: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>
> ---
>  .gitlab-ci.yml | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 4f87ec3..bbd534e 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -25,6 +25,7 @@ variables:
>    dtb: none
>    deploy: enable
>    deploy_kernelci: disable
> +  use_swu: disable

Also here: naming. This is rather "build_swu_v2", and deploy it, of course.

>  
>  stages:
>    - build
> @@ -66,6 +67,12 @@ default:
>      - echo "Building ${base_yaml}"
>      - kas build ${base_yaml}
>      - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG}; fi
> +    - >

Just wondering: Is there a technical reason to use "- >" here, rather
then starting directly with the command?

> +      if [ "${use_swu}" = "enable" ]; then
> +          echo "PV = \"2.0\"" >> recipes-core/images/cip-core-image-security.bb
> +          kas build ${base_yaml}
> +          scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG} ${use_swu}
> +      fi
>      - if [ "${deploy_kernelci}" = "enable" ]; then scripts/deploy-kernelci.py ${release} ${target} ${extension} ${dtb}; fi
>  
>  # base image
> @@ -105,6 +112,7 @@ build:qemu-amd64-base:
>      use_rt: disable
>      wic_targz: disable
>      targz: enable
> +    use_swu: enable
>  
>  build:qemu-amd64-base-kernelci:
>    extends:
> @@ -127,6 +135,7 @@ build:qemu-arm64-base:
>      use_rt: disable
>      wic_targz: disable
>      targz: enable
> +    use_swu: enable
>  
>  build:qemu-arm64-base-kernelci:
>    extends:
> @@ -149,6 +158,7 @@ build:qemu-arm-base:
>      use_rt: disable
>      wic_targz: disable
>      targz: enable
> +    use_swu: enable
>  
>  build:qemu-arm-base-kernelci:
>    extends:

Jan

-- 
Siemens AG, Technology
Linux Expert Center


