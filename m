Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158D4C83F17
	for <webhook@archiver.kernel.org>; Fri, 18 Jul 2025 08:23:11 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.47])
 by mx.groups.io with SMTP id smtpd.web10.15871.1752826988606018149
 for <cip-dev@lists.cip-project.org>;
 Fri, 18 Jul 2025 01:23:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=0Ez9tWKt;
 spf=pass (domain: siemens.com, ip: 52.101.70.47, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rbDI9ssGEsiLmF4QxZ5LA+xDzk3f7DOsRniT5/CyXxMN+Dj6mIHrLd8nPN9AVJfHB5Ahm/3aV+cwTK3qh/GxjuWM8Z3c0zqq9EJqB8Ru03Hf/X5LtUKuJD+co/PV6K743y4rd2vEIgJl9Vf3tkX8DwN6HCQHIjXc3tNI2JxKkr/vGil1rSqxsrQHytFTKaVYJoW3pZwskhZ9cjjfVPySTAhQQ6mO2UaacHNQxVGVNVVnlgjUEIGw30VE88VaFXuboE76C+ULvIjVMD9YX73y+D6cfGxda7qI+mnNVNbGXdRAsE0uyTVAFztApB29GK9xIi3IE3uwg+gHPhuTVVhCSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qBaAd230EyVx7cU+BlCFEtMCURD7zk6rp+UoQx3luY8=;
 b=w+5rM5vCZVWFm5XyWO3Ur73yTudoFs7chrH63Fpn32Gb588/t2pPz9B605gUb10ovDx7F/SH8Hin3R0rxPSdjRcf0VSqeweDb2TZsUSKlTDe6b6Pv/AvaxQmRn+ovqs9nh0tIjfUYVxfOC9e0IlPjr2YJFROsFbzBI6km+pVG/fbd3P2Sp7eav1FxNStheHWoxAPGP4LO5YRziUYEbYLQ2gy2sHl9PK+ARVixqsnL0HPgU8VaprMzAr8uLDNJW52xijDd5kp5cRTFrpUrzUCLsSEEkqyQNIal7wtVHKeHnKDk2nc4MwkEHNTYnr7ihFivDf5NdYw7kIpkPOw+rg/0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qBaAd230EyVx7cU+BlCFEtMCURD7zk6rp+UoQx3luY8=;
 b=0Ez9tWKtr7+PcIPBdVhhSXeCWHatbnhxW/sRWzzOjqgySw4nb27TVHhmvnR71xsUjBXv9QD0UzOXTSKex+X8b5FmPmo5DJy3oSF3BeIAGKKwd1yexXj++bpjRWAhAuVErF1f0i+Ejqhkz6o7LdUxR/bdtr9r4zHsd+vjBtlIwPMJMc0rHjBGHy7WQ9EwQEj/574dSUryYEW2NA2B+hOnr0kUIzJVUObgX8xB0n3e6O4ROKJB8Dy5Ye1s7VwVyRttGgwcDK5HVgwTUgBBtovXbGgaAn2li/gEBvXvHr/G0JgCXEl/5ggiDIq37Mws+mqbtyPio/rm0NaC/tosM1BvOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU2PR10MB7727.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:49e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Fri, 18 Jul
 2025 08:23:05 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 08:23:05 +0000
Message-ID: <f6ace67b-d312-4b07-89d6-b3200b42bd95@siemens.com>
Date: Fri, 18 Jul 2025 10:23:03 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 4.19.325-cip122
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0055.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34a::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU2PR10MB7727:EE_
X-MS-Office365-Filtering-Correlation-Id: bd92dd19-99a4-4946-3f89-08ddc5d451bf
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UnlWZlFUNEwvdlRubzdub1RwbWxmR1czSGJtUmNNSGdqNEQ5bjIreHhjRHRE?=
 =?utf-8?B?Q0c0VVByaHNhTzBIakx2Z1RCMWFpZXBBTWRGdVh5dnI2TlRSbzRTMHdyeHg5?=
 =?utf-8?B?OWZCQUx1ZUN6MXlXbFhtc2dpOU1IUTBqU1MreG02Z2ZSVEVzNWZ6UTRuUlQy?=
 =?utf-8?B?Y1hERWNucEF1ZktFUzBMYzdPL3cwSXRQUHhGTDlURklUelcxUlI0am5kQStx?=
 =?utf-8?B?KzJ1N1B4TGs0djk3aDgxNTk5a1IxUzg3UFNBSGpYTGNCWkhlOUowanJVeWV1?=
 =?utf-8?B?S1lIbHdaQ29MYmk2OTZ4RjhPZWh2UDAybUFUNjBqV255OUE1Y0VSUHg5ajRZ?=
 =?utf-8?B?RGpteW1UQVJyOCtKdEkrQ3czUGZzYnNybEpFMERmMGNlTEdPRFAzNnJOY3NN?=
 =?utf-8?B?SnlSV1FzWjFTM0lxY0JTZ2dNVVQyZzM3SGdBeUJuV1FzK25rTk9RM252ZXNk?=
 =?utf-8?B?NGpEd1FjdERmMnVBZEV0Y1k2Q29ZdDdFZlByekl5eDlKcXlEUlovOFJmOFBx?=
 =?utf-8?B?bGJVY0lEbExyblBpS1FuamJtWTBQdTNyc0FYR3dUa2pTYU5BY280ZEpBSGwv?=
 =?utf-8?B?aXg4OUZQdlJyYVl1NktEbkU4V0lTMnprZGMyeDZIV3FSY1B1UTg5WXc5K0Ny?=
 =?utf-8?B?ck81dER6T2JMYWF4UmR6a1BpMUVPaEt6ZThxc0JLcFpZUzVmOWdxcmhyUlp5?=
 =?utf-8?B?OFMvS3pwRjRaMTluS0tibDYrUm0xN1M5UkhBK09PbUFFSWhxbVhoZk9WemZH?=
 =?utf-8?B?SmtJczdOSDZiTWFYUDhvVXdlU2IxWFZGSUVZazRjc3Z6am82bWtzMTNtRW91?=
 =?utf-8?B?cXZNR21yY1hzd1lxaHZHRWY0RCtMQ0xFVy8rTFZPVkVVdHRlT1M5RWxYM1Bz?=
 =?utf-8?B?bjg0dFhlbUtTbURQQlhMcEFER0R2aW15d0Q2aHV0Ynd4YUppR3hpc2xnUmNn?=
 =?utf-8?B?MlNWTjlybTArY2VaRjhOTzhLSkkyaW41UnVHcTJLSjcyVUNtZDF3RWJidTZK?=
 =?utf-8?B?RkpMYnJpekl6Tk9MdmtJcmFsbDIwa3VaZXM0Uk1sa1ExdFJ3bW9wU2lZT3JP?=
 =?utf-8?B?aUdVREIzaDdoOWZSRS9GemRTS1lpMHF1a2EzbXhCcEVYVE12eDF1NXpQWUhK?=
 =?utf-8?B?L3hsakt1MU5Rb01JaXo2cXZjYUtiZjhBNW1VUmxWQXRBRVVFbndwZ2NlUmpw?=
 =?utf-8?B?NFZwUGNvSzhFNGxNMGVEU0pKTDYwSkxQRjQ0SGcwZlBndU05aGhDVXVCcXln?=
 =?utf-8?B?NjhjVXdqL0NpTkVWdk1Ob3AvUGdIZ1ZheElQV2FLQlZFODBlUHFPRlF5M0xJ?=
 =?utf-8?B?SFpVdUk0WTFkdHhOejJ6bWRkbVhaVkNodlRRRGpHZnFRdGpJRHBscEE5blZ6?=
 =?utf-8?B?VEhwZjZtT1BmdXY3UmNJRFFud240dnVmQm04dXlma1dKMHgxa0hJdng4VG93?=
 =?utf-8?B?V3RsVDdTaGp5QXM3aTN4c1hndnpacE0veUpMUkNxSkZNOHNxcnI5bURUN2Jx?=
 =?utf-8?B?dy9tTkw1UEFKaHBrenJEb0JHZWM5b3IxYlRhYlNGRWhiWWFNQlhnRUpndTQy?=
 =?utf-8?B?Z254azdIc2ZIdmZuMk1KSkNyK2xZZWw4Z0ZMamVOdTZhczlyT1d5eVdqdTdZ?=
 =?utf-8?B?VXlva0tzRlh5WGwzYnF5OXN3ZTdZQWJJVTdERUJZbXVZVmg3WnZJUTl1dnhx?=
 =?utf-8?B?bm9ZZEJTQm5zdzRjeTJ5dXhkYmxiNTYxT2lZdEpPK0k5enZkQUhUZEV4ZG9Q?=
 =?utf-8?B?bHNZY1NvNzdoenorYTZIaEF6ODVyTXdLbjZTSVBvVkYvMmI3M0lUS3UyMzBK?=
 =?utf-8?B?UDJkWFdncmVJYkQ2Q1BYaVEwOWZleFpINktzVzBEdG9NM1h5bnQ0czRGT0FK?=
 =?utf-8?B?WUZhbWJCNE5NTEp3VC90RDBiNmRuQStOU0ZFQkl6ZlZ6OUE9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Z3hjemdEOHdHQklVaXg3amN6ejJWc3U5L3BWdHZqRjR3NlNTVWsxbFV1UTNY?=
 =?utf-8?B?WVZHTFpSN0JIM2ZoZGVpeExuK2R3ZC9rQlpha2VkamFNWm1ZRTRBWlNXN05G?=
 =?utf-8?B?d29lSzFtTmRqcUFzWldoKzhlbVN3N25ucXlTVURHdksySnF6S3pxTFpQRi9Q?=
 =?utf-8?B?VkhyY2FhME5ybVBleVNxVTR0Zzd0VUw4N0dKLzdMeUFSZE8xTU9FUWg3YytO?=
 =?utf-8?B?ZVVlTVlka2FpQVMvbmtkNDgrV1dJK1hvWHp1bWZSRC9rVlpxSklJbGhNSTFa?=
 =?utf-8?B?ck9jdnZ2aWtjWnVkc0tBN2t2VlNHQzNTcnVndmJVQWIvTjBCa3dWaVo3Z3ZJ?=
 =?utf-8?B?MjQ3UnZ0UWVGQnU2eWxzMVBwSjZRbTJXU2c5Q2huS2JDcDZhU0F2RnhrU0VL?=
 =?utf-8?B?ZHJJSUlnbk5KWDRmWjJyM1VhY1ZJNXBQUjBYbmxnREE1NzBoQ1VHdzBSRlRC?=
 =?utf-8?B?TFpwTU9BM2FxbTcxRFpPcDFLNzJ4Z0x3aE9vVlFwakpqbkZwd3JlNVcxUUNs?=
 =?utf-8?B?L09sOEVhak95MnJJVXJ0dGpxT29IQ0IyZ2lNQ2lXZzd2UThlYVRGV1Vqemxz?=
 =?utf-8?B?OXdTU1l0aDRZMGlTRXNOUm5XWVdreDNDNmlpTktoRG4yWFI4QXVFMEJBN2Z5?=
 =?utf-8?B?MmZ3QWdPZlJTVFdsU0lrRjFoKzBSaXRqMlhhQTdZTUwyenM1b1dwd3NLV2tL?=
 =?utf-8?B?VStYcmpsN2R5dnB2aWpkT2dDOUFFTFVwdUw5M2FGb1NyZk83VGV6Wmx2cS9X?=
 =?utf-8?B?amdVWEc4WFdCKzRDcXF3VFB2N1B1RkRKdUNUK0dPNlorOGtHNFhJS1h6V3l3?=
 =?utf-8?B?SGhSK0Q2bUFkR0tvN0o2dXNZN1piZ0VlRDRIdmRFcGZhUlQ2emI2ZGdpaFhw?=
 =?utf-8?B?NFBXdmlHTHNLc2VacVF3MndsMy8vRk9adHovRG16dGZ3L3lvQjdnWkFld3VH?=
 =?utf-8?B?MENtYTYzZkp6UVNTaGRRZDRyQXM4QXZwa2lIVFhNVk0vUk1STTUzN0haVTdL?=
 =?utf-8?B?Tk9NT2dyU0NKbGhzNVR3R0dqdXhMRzVld1pJR1dBS3VEbHA5WVJGM3VXSHJX?=
 =?utf-8?B?K1lmeGkwU1RTc01lTlZkZms1cE9SeUQ1NFVKWDd0WlBrbit3TVRKWVFwSDdu?=
 =?utf-8?B?MmljbHpKcUZLbGJxbCt1V1lHeFNuVkhqTTBWNHB3UFA3Yzk1aWZUTzJ6Yy9i?=
 =?utf-8?B?ZmsralVSYlJxYUh4N0xJTWdDQ0R2bmxjczJGODFaM1YyNExDM1RFS2NZSG14?=
 =?utf-8?B?cVhyVW01V3ZldlVGY3QyK2dIMStVQzF4WlErT1NMOEZEb1dCNTA3SmdwL3k2?=
 =?utf-8?B?UTF2RTd4b2tiVmZtYldxNUhtSXZiVkJTaWxSK0kxN25YcEQwQ0Vxa2hEbTRl?=
 =?utf-8?B?ZWtJNllXK2UrOWs3OHRQdFJDVHpITWE4NkhYaHE4Yjd4Ykxja0JBd3R2Nmgx?=
 =?utf-8?B?UjhGa1JmWVpBbzR5Zm5mQnVnd3V3MlM5SjN2OUpPWW11SjJ1VVZORk9SSEVy?=
 =?utf-8?B?enl1WHpBNDhnTTZUdk9Odlh6T2U1NjU0amRySGxCRnpnNnd2amxVSjhPTjdx?=
 =?utf-8?B?Z2dkakoyZDhjdUhPUStiK0JpMEovbTM0MFZIOHVaRCtIMHZnSHhXVjRnWUtG?=
 =?utf-8?B?ajBLbkpJbDhlQ2lSbExUWmFBNGtiNmtzRnFOb21XY3Qya0tGcjE2bUtwdVcx?=
 =?utf-8?B?azBqU3ZJUEpZVmFEL285TFA5VUY5TDMrK1JTelVjaGFUWUVTSmRCUlY3TkpT?=
 =?utf-8?B?bllHdUx0Uk53UXV1VGt2c1FoZ1pRdEJtM0xCR0J5SHQySUdlbWRzRlJJdHJF?=
 =?utf-8?B?QWZ2eG1XN3cyTTFWUTBJZHNuYXRZWDBHMUZ4VVYwbUVJL3N1UUtxeVZjSXNj?=
 =?utf-8?B?MUxaQ0h3TWt4THduWVphWEdpZXJSWHRRTWJRTWw0R2tDeDJLV2JCbzB3WnZq?=
 =?utf-8?B?QyttY2ZFYUs3d1lhdnZxTDlFcTV5NVY0azYzWWlTeE54ZnBYb2VMdFJ0OEJj?=
 =?utf-8?B?ZVdpVkFNLy84Y2ZMaitsRFJjNU8vUzhON0YzYzIreG5hTmU1em4zS2pEZ1lH?=
 =?utf-8?B?Vm82U3BhTDRkdGlOMDZzMmNRbVA0djdUYVJ3WWNKZHVUZWFTNS9WUXVueW1Y?=
 =?utf-8?B?VVRmSzFaK29sT0hlNHdrdW9KSTlLaEZWdmZYYjVWU1BleVFFVGIyVy9udVdM?=
 =?utf-8?B?MHJ1VnRpWm1CeHJURXlLem1jb1J6eXJubXRQM0h3a1FGV084RnV1NHZDNHJK?=
 =?utf-8?B?TUtWVUdPd3I4bnRsSnJIVFlXckZRPT0=?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd92dd19-99a4-4946-3f89-08ddc5d451bf
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 08:23:05.3791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mvpFjtymfe1lP34Gc4wwgzJc0bXpEZKjn/YLKy2YTLYgFinhmM5jPTKHhipIk/upOQvAmySNy0xTkU6tV/6APg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7727
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 18 Jul 2025 08:23:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19556

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...inux-cip_4.19.325-cip121.bb => linux-cip_4.19.325-cip122.bb} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename recipes-kernel/linux/{linux-cip_4.19.325-cip121.bb => linux-cip_4.19.325-cip122.bb} (68%)

diff --git a/recipes-kernel/linux/linux-cip_4.19.325-cip121.bb b/recipes-kernel/linux/linux-cip_4.19.325-cip122.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.19.325-cip121.bb
rename to recipes-kernel/linux/linux-cip_4.19.325-cip122.bb
index dbed929a..8b66eb83 100644
--- a/recipes-kernel/linux/linux-cip_4.19.325-cip121.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.325-cip122.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "0c14765ee5a6f3689a22578f3d0270df8a72c49fbfe17ffc3566f4d4aaee455e"
+SRC_URI[sha256sum] = "7e90e8c5a1557a8fe02455437f10c3a549c9f46424638ef9763e08d1cda36152"
-- 
2.43.0

