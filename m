Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C9CCD11C2
	for <webhook@archiver.kernel.org>; Wed, 10 Apr 2024 08:16:47 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.101])
 by mx.groups.io with SMTP id smtpd.web10.160677.1712736996396403981
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 Apr 2024 01:16:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=fcrk57ZC;
 spf=pass (domain: siemens.com, ip: 40.107.247.101, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NHJziZC4RMjO914kgRECBqh5D8v1fePD1jLIcvTCRFS70mNOshd653feb7vuoWb8Xg6smG57y7a9CtvDK/R7RPdYZlFslMWWDttSC53/vECHpONf/EFNAihfrfNNaQL9DJ+0yo/pgPNNWTex8zIV/Mbanv5CUcRKnQcjXMuThv3gxzGuqNwjiISYQyKN2Z+ob4fwBRKbrINvlIL0eRYm60ZsrGW4j6FbedCLJoZOlZmlqTkoIWOV80nvk2BZs8sFVQVqV+Ih4Kfrai3GJ7uwSXq6DYzC4qd+xQudqCCoTzh9klXFfN0KnEa8pu8tlLCrFR/QUT+SFcHDgFfAURMBmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SlBsdpJgbsJaEEg5TKg8W7SaYFKJvozaU9hynZSYy2M=;
 b=kJmoaZEMY6agZP02O8dn5Dm9e+aQrXMIZXvtF+DsnUGl4j6HCshnV/4JmJhDxAmbPcaV9curLCXJKbaqyyC7BeWuo7Hhg4hf+BosqhHLoV9awWluJMD7OsgFZy7G90SAW3PBZPjMxLvfN6IHfndXOID/2t4Em0C5Y4D1cDHv7C8cViP19NygQKgSs/6HLM4ha9JnGNztHWWZN52RMNxzKq0+aB7CggFAiZW4M2b02uhlYfGvnwpzp/UHmCE1tkpvHmR5UHA3NUumj5aqvE7rQ7nUFpR5cJr6wk4dLGhAJ2ugsOopEBR+b4DpSTQQS31e3omQh5Q8y8lT2f18Nm2C+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SlBsdpJgbsJaEEg5TKg8W7SaYFKJvozaU9hynZSYy2M=;
 b=fcrk57ZC5MlnwR8SFfA7Y7cRDklRIcFj2lfQloXvBSfe3BqNZbBjqR9YlXc5oSlFFCzrT3roPJ2Bm2mSnn8I14ybR07X4v6Fqhyov5iJJwM4ol63huSRh/WeS/XPTBQY2LAhXBfFJyA4mkmvKHW2pQx3+UI/eUqziqu/IaZYCoXBMOtc/7fVdUxiu4fBWagDblsnl+slkB2OtVsE5o3FK+QH/UkqjKu24X9Rhjjs1w5C6S9ekJ7Hg1s1vnBSY/vndKdJegJJQ7ye3DxxmJtBgFiBm8cirC9aBav4VI0Q+jfPe/is55+0Fw4DEYyhh605PjuFAl8HhaDJQyejC+jr8g==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6293.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:54e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 10 Apr
 2024 08:16:33 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7409.053; Wed, 10 Apr 2024
 08:16:33 +0000
Message-ID: <c6903590-6433-4826-94e8-4e13df692155@siemens.com>
Date: Wed, 10 Apr 2024 10:16:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v1] swupdate.bbclass: Fix setting
 reproducible timestamps for files in .swu file
To: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>,
 cip-dev@lists.cip-project.org,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
Cc: shivanand.kunijadar@toshiba-tsip.com, sai.sathujoda@toshiba-tsip.com,
 dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20240410072650.1701309-1-Adithya.Balakumar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <20240410072650.1701309-1-Adithya.Balakumar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0239.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6293:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ccB3tXqpEIfgUX+ex0A85C8Rj8zVtkbg4e4pqcn7oQPiRA0myWPlYP1PO/NG+i0QWy27544wMENsbnrazmDWrtF5GHCvnh8DkaWrW9755tlp/c68xVU6HO56GpGTYUBuPs0mtuyEDWEk6I3XM/j77k4CRmYVTp+bn1x+SSFZ9kql5jSiuPzhJC7dkLD7w4RpguqhHSqiexC4pYUTQT+8APgBlS1+Y/pKI0OiYQ78dSyfl3/irxaY1aFtkF8F4R9Hv1CKU6r1MGrdHe6gswN/ChH10DI/xXWZ5Lm16YyUoLm08Ixyc76JPJCiFUJhEisTJ5lkb70NCQn5TH1O8UQV+sScJKqQXySlCZ2jVPVhcNv0xbRscpvmgmFCULNPUOp8acomVCVCAzpU+pDi72ZIrDKFybtx8TKQpgOkNA04VqZX+Eb2McHQ98TkGpJyNK6fzzck6V+9aslH3uo/LUY5yXDecs9267/EI1g9QN3oVNz9AHtYSha/05iMXwLaMjaC5bwSMNzBNtWChOKIThy1zY357smss61fzSaPWyVshsqKDNS5fyvoMdzBNYNRLiM2kgzdxdRjY+05QRHL0g1UwGkO3X+SwIgPgN9d8g6CpaTFt4Ey7OTJikrVUAyW3s/MBD3DS2MrB/9uou4nEqIZ8yN7H3jU5HxC4ox43CpnDHU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TmpvVlN3enRTZVQ0NFlXWWFvSngrSHhqRVBSS0FvbXY3c3dIcXhyZy9YeTgw?=
 =?utf-8?B?d1BCRktSZlh2NjNZTms1Rk9wZDNSa1FEQ3BRRWlFOGpJZGtza25yanJIVmI5?=
 =?utf-8?B?RXdXNS9KLzZKYU1aU1piZ1kvdW02R2VZY3BmcEpscHdCeG91V0ZoYVNncHNu?=
 =?utf-8?B?TjlpQ2c1eHhYeEtxQzhoUUVaamQ3Sk9kWmhWZStZaWZJelZXeEZsMTJPQVc4?=
 =?utf-8?B?VWk2SVMvbE00aWFOdkk4VER4V2J4OStwYkNodkJ1YXExTlBDbWRCWVJ1emEy?=
 =?utf-8?B?a2F4STljakxBek5PK2ZnUForWUZybWhiZVZzdFltVG92VVBVU0hlZFZGOThC?=
 =?utf-8?B?U1pBQ2tXVTEva2YyVUtoYXFzQUJoTWlQOUdMUXozaThXWFMvWVNlSGVjOFRH?=
 =?utf-8?B?N0pEd2QweW1wSlFVODZVU1pJTytXQ2w4WmJyM3VPZUMrU095UU1SUFJLMiti?=
 =?utf-8?B?TTVZUXVHQ3FoNlRQSDEvOWpGa1Fwc2RNdEVIdHBHUTc0aTZrbC9URFVPWDRP?=
 =?utf-8?B?Ly9nQTNKOStNbzFXcm43SGpHWFZGb280dEwrRy9Tb2x1cmVoMGxzQzF5RVpY?=
 =?utf-8?B?eHh1OUZYdkZkSWQ4WlEzQkt1T2o1QXJURTRVcmtGZXpLUWl6R0xCcklrRmlz?=
 =?utf-8?B?Mm1SR2dzUEc3QVI2bW5pdkl6UDhLNG5Wb3hnaUFJcGJUQXlTaHZUVml6WlBO?=
 =?utf-8?B?VzB5NGR0SzFpcTVKeGpxV1Njb1lvNzZCdytXbTZtaG9xR21lMm9VOHFFZGFH?=
 =?utf-8?B?NEZmZjF0Tkw0U3lpemZhcm5DcG9RcDg2NVR0d2xSZER5bTZvblR1T2orRStS?=
 =?utf-8?B?T3BXOHRTM1JsM0hwb04zcFFIT0YzTTl4Nnl5MVpFNTB6d0tKdDNFR3JIOEJL?=
 =?utf-8?B?Qk9rbk91dGEvZWFubzYyVlJHdjQ1Q3hoa0xvYjhqb05Pb3ltZjYwcTA2eXd2?=
 =?utf-8?B?cTdXbVBBQlJoSzA0Z0c4a3VmNGc2YkxhNDgyclJzNHQvWWg5TkhYL0NSaUZ3?=
 =?utf-8?B?UzFBZk9xcWk2SVdoaWdtVXFOa2pYcG50WmtyTVd5azMzTU03ek5zTmtZNzh6?=
 =?utf-8?B?QUFaK3FlL1hCQTQ4dmY3K1BYelBhY3FKVDdLKzhKeHFqUHJ1N0ZyUDNBZzVP?=
 =?utf-8?B?aFFhK0kyaVZmbk8wVjN3VkVMM1hiemNXTStHLzlXZUJJQTBVMnVSK3VUc2Ni?=
 =?utf-8?B?VUxMR0c4VW5XeXIvdjNZMERyRGhFejZTdDAydFVCeWY0MEZTOGRkZGwwN21u?=
 =?utf-8?B?ZVlJK2J4dEppQ3FVQW5FN2VCN1BLNEtTWXVCYjduSWNWdGtWOGFrMnRhUWhu?=
 =?utf-8?B?MVdpak52dHF0Nm1pdGFpVDZObzFDWk9icS85djlRT2h0UUpjZmtRVmJ0UEJt?=
 =?utf-8?B?R1Y0emluOFZuOG1xNStWTDFRSzk5VjVKbVVlRnhwU2M2dmM3VFVuQWpzUGF2?=
 =?utf-8?B?cGNoZEZNUS8vcjYzMDFXMUxBQTFGU2JQYnVzMjRDdmQwazNCVkpONWZITVFZ?=
 =?utf-8?B?d3BKQk1QdGlYNGQySkkyR2J2S3dQWmh5YnJPRTJHd0I2c1pWNm0xQ0xYNUdj?=
 =?utf-8?B?WDlYaFBSZXFGMktkTHFrdmlMbExhOVlDWUZJQ2o4Sm52d2xoKzNUYWRYd25N?=
 =?utf-8?B?NXhUT2s3V0NUQ3o2YXp6ZTM3OHRxK0UveDlENkRVMElJQk14ZUg0eDR6azg1?=
 =?utf-8?B?TWZTeUpIdEVkb3pkZ2FTT2pUbExNQ25yT0tpaFhWNnc5SEI4cmtZT1ZCemk1?=
 =?utf-8?B?VEUrTENlUGFLYlAxUDMvK0dWMjlOSHRzVHB3ZzRoK2hkbVA0RUUvTzFaVU5n?=
 =?utf-8?B?WkVpSW5oYlZhb1FrY3FhZ3YzbDdKN3ZUU2diT0Jpb3lNNWJDVE5SeG1XbFZx?=
 =?utf-8?B?VXJlMkE5WnhaZEIycGFlSWhPZlNNMk9TaitBd2VlNGRlUGI3RjRHTmNFYVJK?=
 =?utf-8?B?NEVFSXdoSUoyOGpLNko0aHVXY3p1RXJGbkdvVTk5YkloVkxQVEpYenlqYTY2?=
 =?utf-8?B?eSsvaXBBdFlIRlFyUTdTby92UWRoNDdlYlduVkFRcDNxdUhOVllJcFpCbXpG?=
 =?utf-8?B?VWZSRzRrNHlOSmk2SVFJcFh1Ny80YkViSEpwQUtIUDhFTGhWd204cHBRQWVz?=
 =?utf-8?Q?sETV6I/nsXIB+C4Uw4/wWckK/?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f732126e-5320-494b-cd9d-08dc5936885a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 08:16:33.1494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vod55czHyrI8ItEeE7+2sbip9xmh0CXygM21rAKuamZyyHOsL4g261EBNQw9eDoc/Rhqhu73xAlcrfKeCez5Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6293
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 10 Apr 2024 08:16:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15529

On 10.04.24 09:26, Adithya Balakumar wrote:
> Fix setting reproducible timestamps for the files that are included in the
> .swu file.
> 
> This fixes issue #103
> 
> Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> ---
>  classes/swupdate.bbclass | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
> index 1c495da..25704aa 100644
> --- a/classes/swupdate.bbclass
> +++ b/classes/swupdate.bbclass
> @@ -252,7 +252,7 @@ IMAGE_CMD:swu() {
>                  if [ -f "$cpio_file" ]; then
>                      # Set file timestamps for reproducible builds
>                      if [ -n "${SOURCE_DATE_EPOCH}" ]; then
> -                        touch -d@"${SOURCE_DATE_EPOCH}" "$file"
> +                        touch -d@"${SOURCE_DATE_EPOCH}" "$cpio_file"
>                      fi
>                      case "$cpio_file" in
>                          sw-description*)

Looks like a regression of 7566320e3f5fa08d89628f4a790c85b737cc5da7.
Thanks, applied to next.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


