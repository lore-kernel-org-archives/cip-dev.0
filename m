Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DEF3C83F12
	for <webhook@archiver.kernel.org>; Mon, 28 Aug 2023 06:47:27 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.68])
 by mx.groups.io with SMTP id smtpd.web10.8268.1693205245579748787
 for <cip-dev@lists.cip-project.org>;
 Sun, 27 Aug 2023 23:47:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=MAfQJoWN;
 spf=pass (domain: siemens.com, ip: 40.107.21.68, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nA7k3vn/ru7O7zakcPLAebvYhLdSVQgWhHYvnV8ocXO4i7lYVCpAxHP8aezwWM8B9aUhoU9Ya+bVDjyfKqW/ywlUqLSmB8GjPblDRnPQgKXvqBeuACkFCPoaGZgK3iEvqIIIt9UHupugJhaeNb4JHYjA7omcSAsFMOdJcohrj9O6EZMwtyt0w8s9g34hknJESjvTeKlz7SK+2vOV6MjBcUfjDdeWQ/0pAwc5PhJHI2jxhuO+kW5SoRZT94JKSLa7fOokrQ3HpRL/SyaSvuGyzTIwthWSxYUMU09cX+M0/PcqJsHZABjc5BEToZylgWvR4UHQ1CEsy10d/DqnjXAdJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UhvVOgbSjCbHwoN0rLYRWCQIvLx9nZnLfDHuOYJ5Tvk=;
 b=fiUeSolOpUbOE7keC6W8PE48Kih1NMdJTgIvVnnETvqq3D6rZEREAGaZGqVdEn4hLDPxL7QfkxExxKtO4A+pPnWnXSV216dtKNyiaLAL7ggd1z/DL+nabjDswAnK++J4KjkSBYt1xVB7cEPiwPbKA8jDjwVy4QxdvLY1n4BsqLIybrk9Z4luBG0wxfsRbhcm0zFLX0iX1Mu4mC0XQ2vfBJ05joL227IPVtClyHJlaqR5OQKMBxKtqQI+zY4abQoDcI2tZTlE2HVz17cVm1GK6GybfaK4NBhrXODWTmAMU2V/2kBHBzWww2XKVSvruh95etn4AgrNhzMfoaHZCod6XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhvVOgbSjCbHwoN0rLYRWCQIvLx9nZnLfDHuOYJ5Tvk=;
 b=MAfQJoWNrhAiZeBw/UbHdn5MYA89J+mJ5UgZCq0jlTM1gizRZiLtQ848KgNfipZi7AeNb36EPaQNDMy9poTwXUn3o/He1/qOe+P+VJC2mEPOaWK5Q6SZhCWM+RFEvMyaFwj1kW/oLI1SODeT/o96YTjmjH8ol16qU6HMiIPg1rehp14r2SYfp3R7iCGO97PuvE+KSSpAft7Ycx6C2MV2a7e3tyS94OdbvtNjda1zqppyt5MbRLQ+N/PYyrsmOlhPzzVMvuqN/QQpYPpIFHZhQ0acoF37FcBOm/BvcRpM/84Zf4v+Ydu1jJzvZd8OFYI9bhYAGjiw5goVvo7DqzLoEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU2PR10MB7645.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:497::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 06:47:21 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 06:47:21 +0000
Message-ID: <5a4f1ebe-305d-409d-b142-49626877455a@siemens.com>
Date: Mon, 28 Aug 2023 08:47:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] initramfs-verity-hook: Ensure
 sync on rebuild
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com
References: <20230823132816.1011054-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230823132816.1011054-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0169.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU2PR10MB7645:EE_
X-MS-Office365-Filtering-Correlation-Id: a8a8bd01-4c66-4a33-776d-08dba792a155
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	0pZXhyYXeMZkVmEXqRld1A0tsxAgxmW53PU7o+cak2wWKNdc2H78VSb5iKYkXAv3GQAwCVkdf3i1AFH4QOk84V7ev1LLhwh53ako6g0iCJWt7aE3u9QbVUbUz5A4oll//EoyBd6qI/abGJxdpRX0gStpcVmpVak6ECUbcI0ESb8/GZxNjiPAtjH29ItarOPOjNTLVeq/rALKze2h2C1VCTmoUMqpQP8x1Ge+PXa6T129z2NmmhUmr0aJZAhTod6FHqa80OxJxIDOSWecl4VKqYo0auDQ5cs6RjkegaA7uM5y7d7Oi1r9iJRDAqjajl0SjgBeJGYE11MZyYOymWV5fVLB5Nys2dM9mYlGUfTf0br5VZpfFsQIXunxvN+iiC4pt8TQ/eIgO8s0lqJ5RPmDmue2TTn8Ft57Pv2uckMTmD7cFnRs96NHtHtW9kyFPif5sfAnXXudrItSF928WPybJ6OWGJDXZoh9yWscMjArUJdEv7zuIim6KPamoq9SqcG5Ix2loVifHM0SkBXt+UyxWF97DF5PKHArITR5p78kBZzC8lh44dTtZssTmJDolo6pQE7AaOh3IauPPZP5NKyWjMdt2K648bNMUUewW5rf2JAs+Aee3IBdvKY7U33LX1yPbksMPy/w/AjlzA/omEP5Pw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(39860400002)(346002)(366004)(451199024)(1800799009)(186009)(83380400001)(478600001)(26005)(31686004)(6486002)(2616005)(53546011)(6506007)(6512007)(31696002)(86362001)(5660300002)(2906002)(82960400001)(6636002)(44832011)(316002)(38100700002)(41300700001)(66476007)(8676002)(8936002)(36756003)(66556008)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TlBKVjBjNE9lQVhQNDN5dEM1ZGFQbndZWXFRbUd1cWhOSWdqWHlZdnBGMy8x?=
 =?utf-8?B?MmtDbXFNbUFtRU5veUdOQXhjU09qMVR2cjdWOTNoRXVuaFp2Zjd0WUE1NXdo?=
 =?utf-8?B?WDFGOWxQVFgvOUpvUFM0KzhTdGNZVkc5QkhrNDlsbmV3VE9MZzg0ZFpFYW9W?=
 =?utf-8?B?NjBrdllqL0xzMTRyQ3lhSDRadU8zU3NlL3JZek9mL1hISy96R0VlZjFTYk1R?=
 =?utf-8?B?ekxyY2U1ZDUrbHZuT3hmcmRKVHpjdDFFS0ZTMHdaWC93aTYrQ2Q0bUx6NlB0?=
 =?utf-8?B?VlIzNjZNYTJ3Si9JM0lRYXNxL1JWWGFhK01lWDNmc1lSZnUvWWhjOXFlb0U2?=
 =?utf-8?B?N1Vrd1BOR1BZLzZsSFVGcHlwRFpFb3NtV08ycUc1RngxbEhhb3dOZUtCLzNR?=
 =?utf-8?B?Ni82M0VHRHQzL3hDUVlZaVVYZVRyNFBxcGpDdDZ6Qm90V25zTXZQNlR6aVJB?=
 =?utf-8?B?MzB2eUR1NW05MHQ1Nm5aZ3BXQVZPSFNmaWliNnR2TFU1bTFvTGZGVzlGaFZW?=
 =?utf-8?B?TlF2LytET0s5L1I1ZUtVZlRFRC9DQmJnOG1UUVNvVmRZb0Q4K1p5ZklHS1RZ?=
 =?utf-8?B?cXlPUjErUzN5Q0ZqaG14ODU0dVJiVXdRaFREQldWTFZ6YnpsNytSYWFLV25t?=
 =?utf-8?B?Y1N1TlFMU0ZOK3VnMVpKQmVXa0d1NHgrK0VSOUtWZzBURU5hdllnc0dSRjlK?=
 =?utf-8?B?Vk5iZmZXYjB0M1hwVjJtNFhnTDBXdHM3QVJBaEt2cHF3RVg4cFJtcWN6SS90?=
 =?utf-8?B?dkNwMVpFZnJhbUZZbXp0TWlpVDIyT1JxMVU3MVRSQlJzZ3crckMzTDlaUk1G?=
 =?utf-8?B?MFhURG5XSU0yNmRPSGprcFYyV0hiOXpZOFhFdmxSRmMwZVVvR3VzT0ZVSmUz?=
 =?utf-8?B?WlB4N0ZvaS9yTEF5b3FSUzFKNXdodFBFYlBoaVUzV3dNelpNajhkYXhCYkFz?=
 =?utf-8?B?NnA1RnhsK0RDUXR6UE5oUUMxUHArcVRMR09XUnY4MlE2SzZ6MVdmc1YxMTFv?=
 =?utf-8?B?NWNucDJ2eTZubTk0UE9aWWt5RXNOeDloTkVNWjU1bGRhRXlFMEh3dlFYa29a?=
 =?utf-8?B?YzFoaHVtUVNYVmJQT05Wa0Z0RC9LajhucExON3FGdnkrT3NsOWJNMnpzNDUx?=
 =?utf-8?B?VSswdzRSNXE5a2VJZXVvTTEzMG4yVU5mTXBLMDY5NGgyK3dMMHRNYVBhaTVn?=
 =?utf-8?B?SWxqWHExR0hjd0grMzhYTEU2RGppRkRNRDc3NmVTamFBejdjbkFNTFBoN3lJ?=
 =?utf-8?B?Vy8xUEQ2aHliVVRIYTRoRXFmdGtoTlFZT1dKcmd3andzTzFSMVVaRzFhZ1Bu?=
 =?utf-8?B?OUdaT2FRUXlpeElXd3hOOE5KdjkxNU9INmZjbDRQOVZIL0RZYXdDVVIwYkNl?=
 =?utf-8?B?c3FsOFA2b1BZdkRNUzJHVGNLSnJXSnRHclpmUWF2RVpEcUtWNkpHRjRGZklk?=
 =?utf-8?B?Q0phUG5FTnJtdGk2bWsyWWkxd25Ub1hmN3RFZUVDWGZlaVQrYit1eklXUnhM?=
 =?utf-8?B?TVM4NzVRQ2xGcHFrUnp0RXdXWWh0UzdudmFaRGlySDljamoxZjRtM2M0RnhJ?=
 =?utf-8?B?WFdpcmYweEhqRUQ5T21NRldzQi92OHJrbjZva0drMGROUk1ibjFPZTgvdjRn?=
 =?utf-8?B?NHFubmdPUzNLM1VkR0o0TWtOamI4aG5ZN2NyL3RQaU1UdHMydFVuaEhYRnE0?=
 =?utf-8?B?Mk1LK0M3cXJOdVJ5N0pINzR3eWNDWDA1VVhRNEJkNzl6c2pXMW1MYXM1NFE5?=
 =?utf-8?B?VzJXRWpQdWFJZmQxclo2R1YxSEh0eGJ4a0NmdS9tWWQ4Z3RmekhhOHllQ05S?=
 =?utf-8?B?TStsM3k1R05pZlNVaXVvWU1LaWxxMlpZYzZiRHFjK1ZrZUF0QWRiUkxyK1h4?=
 =?utf-8?B?OVBUVDJITERTOUZpTlNZT053c3hyWncxampZYll0eXlMbkJhWHByMWpRSmdv?=
 =?utf-8?B?ekJZMHdlaFFXbUJmK3FSVjF0TUtPc2ViMFQ5VEFVcmpVSmQrT1JsU3NOY01h?=
 =?utf-8?B?RlJTSjJNM3p1ZHdRclpWOE9qaGFkakkxdGNrd2o4aGlEOXI0ZjVreDNvNDJI?=
 =?utf-8?B?bFg4YldWUUhtSm5zWFJ4eG0yT1pkbHhEcEJYa0cwd1RZRjVOS1NTR2R4Ukph?=
 =?utf-8?Q?SkX2et6CGGicSLLzkDCffveUb?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a8bd01-4c66-4a33-776d-08dba792a155
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 06:47:21.8391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nX/9e9WFoM/7/UaNpbBnV+p2fUtVC8ZetMhYaaFqPRYUbHUkURYlk50q2XEP8elLlCjy3xzsLEBKIUU7H+j6Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7645
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Aug 2023 06:47:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12877

On 23.08.23 15:28, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Disable the timestamp of the do_install() task to
> re-execute when ever a dependency on do_install
> is executed.
> 
> Without this change the sstate needs to be clean for
> every rebuild.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .../initramfs-verity-hook/initramfs-verity-hook_0.1.bb         | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb b/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb
> index 3fc63ed..7435649 100644
> --- a/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb
> +++ b/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb
> @@ -40,6 +40,9 @@ do_install[cleandirs] += " \
>      ${D}/usr/share/initramfs-tools/scripts/local-top \
>      ${D}/usr/share/initramfs-tools/conf-hooks.d"
>  
> +# Ensure VERITY_ENV_FILE is updated also when rebuilding initramfs-verity-hook
> +do_install[nostamp] = "1"
> +
>  do_install() {
>      # Insert the veritysetup commandline into the script
>      if [ -f "${VERITY_ENV_FILE}" ]; then

No other dpkg-raw packages require this, do they? What makes initramfs
packages special here? And what about those in isar upstream?

Jan

-- 
Siemens AG, Technology
Linux Expert Center


