Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F07C25B10
	for <webhook@archiver.kernel.org>; Fri, 10 May 2024 11:19:43 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.50])
 by mx.groups.io with SMTP id smtpd.web11.10137.1715339978680993538
 for <cip-dev@lists.cip-project.org>;
 Fri, 10 May 2024 04:19:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=RDWkxW55;
 spf=pass (domain: siemens.com, ip: 40.107.6.50, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kTRr7f2JU1wXoMewnFYX2DGQnpTYVnK76lMD/jrkEeFTOW1OGCyYyI5uCPakNc8SxTIEzZ35AFqAWm8ukNUvFOr0cZXFxRgUt8pfXSFBy5Q49nBzAvwwQurQJN7e4kI0S3gKFyqdX7uTUAGsbatcfMSXPO0GwLJKNqLPWnyrVU1qorYqq+xo0RdxTdB5zfFd7YePBJV5x4fixxylx8CH7raSjrgleVa5uEtcnhthLmYQqv/lCw4GsXNxYZS76X5RjIeiWEkFrHf1shBpWLrnckQ4gWAzcIjeKRzGk/oqVCfXg65YVtdIBb15zm6nvcBFs3t6+NSlUBF8qEo0gDTRvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=10EPpWXN6vk/JiQJLSTiVB7AfPf6YGu/qx4dAXqN2bk=;
 b=W1K4EeTb0BBMXts4Dd+B13jhofoloZE0Rpg5/UxjfCCz06ijvY7wzT/RHhYNG/vqCbyIjR3joSW9EkbX//bISZFE7DHAlJhogeXKN0pDj9XWKwB+JDA4hlpnodDhG/vu4E94y1lLpESIILC376TAldTOJ/H797T/jHdpSrW1wK8G3N2j3mPupAcKjVTwT7gg4n4H1HgRCXuKP5pkRfqWGTiuuNMN1wgGCoHIDZwQvq2TLk4SXNexkTHrMWUrHNnbY36IXkEKhZwUzaDk5lggFSAnehaz+qBCZQUreSu0R/xHU6s1snZV/RJmVGZT2Mm0dZJUrnvJbpwSBHiNzBjK6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10EPpWXN6vk/JiQJLSTiVB7AfPf6YGu/qx4dAXqN2bk=;
 b=RDWkxW55xd/y0IpnWQ5cacRiGz1kjfD2ZYnEVMUYYO3X/vJeqahWW8IfDzKR9LXIbVu5eLqdsD8shwQzF2ggFkK0G6pPh2PlNRkk1cTzouosMOT6GCO+ZEYeTra0h9xKuy0TnGPDC+84GqdU4VdGMYwBntkw6HhEyqwXhVul/3NAQc81dimOUhiL6dsZPaJTwr/k67yUFf/X4wsfv4XYsaMB0RrtyopVfLsmcxEV7SD2u9f+hayC6cedXWPfgb8utDwjMgBxPPHbZfuDIXsgQHe2MQihdUiredgCax/KhTLYY94WE1088vuELsQflxTTgZUsPiyRl8c4/rco1NpVsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6140.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:79::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 11:19:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7544.048; Fri, 10 May 2024
 11:19:38 +0000
Message-ID: <94e8b177-e56e-48d8-b5d2-880758658b6a@siemens.com>
Date: Fri, 10 May 2024 13:19:37 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] Enable APT snapshot for reproducible builds
Content-Language: en-US
Cc: "Moessbauer, Felix (T CED SES-DE)" <felix.moessbauer@siemens.com>,
 Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0047.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6140:EE_
X-MS-Office365-Filtering-Correlation-Id: 75fb8343-a8d8-4527-5caf-08dc70e31439
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?aXY1YkxnWU1HWW1oMTRyWkFCRSsrcjVRWWVndDMrYmdCTWFIZk9Va0dVVHFN?=
 =?utf-8?B?R1Q0cVcvbEkvZVcyTTVzTnFzSDVsYWlwcmhhemxkeGQwbGkzTmp6RHYwbmhM?=
 =?utf-8?B?eUFPa0xaMmNPOHFoYUUva0YxZUpRNGR4L1VSTmRva3lIV1NVbEsxT2htYjdN?=
 =?utf-8?B?a1F4dGk2NVo4VjhHeTBycXJqSWprcGVxeGw5ZSs4VVA2UUxqRHl3VEtBQWpJ?=
 =?utf-8?B?UkVFQ0g1ZWVpb3NldkVia3l1WWtNRmM3N0I2dlJOZDdmb3A2bkYwTXE4VGhk?=
 =?utf-8?B?OTgxd2JZeUdpeGpYQ0laUEpMQWhvY0k4dGhYK0FaR3JhQmpua2R2MlBhUVlZ?=
 =?utf-8?B?QW1UbGtjeC9pRUQ2eHJ0MVIxUFlLaFcrbkdtWDBSZzRxMC9ab0lNQVQzUGl3?=
 =?utf-8?B?WFJFa3FQc3VIYjQ5WTUrelBaVjhwbk1pUUgrZGR3QTZjOXViQ2JDVkMwaWFn?=
 =?utf-8?B?T05qYldLKzI0cGZ2TnJHRCtRaERzdnhYZ3VXZlkyN1A0VFJTdDhzOEZscFls?=
 =?utf-8?B?Zkd5dUxTbzBmQXFUZDF0b0d1V3NhU21tZzNOc2lEcHZSeUZsbERhTno5b3hk?=
 =?utf-8?B?VnpHWWNhNVo1WUd2dDB1bUJNaGpPQ3NBM25PTjRFMk9ZL0pDYnFHMmJNNnFr?=
 =?utf-8?B?UDVWQ3AvdFJ1RVMyL2VzMmJtTTVJSGljMTBpbVpnN3RUVm1lN1VyQSt0SldN?=
 =?utf-8?B?cUhWdWJLTlllOTkzZWhvWVcrdU5GRkhGaTg5dHdBS25McEJqMG9iMG9BQmJy?=
 =?utf-8?B?ZzRrTEQ2dmM2K1JiLzBodFpodUpsc3RLYkZCM3pDTXNxT0l3T2diaVJCYXQw?=
 =?utf-8?B?YnF4ai96dUdrTGJqeDRudWpraS8zc1Zha1VhQWx0UVhwa0tnMnh0K01hN21L?=
 =?utf-8?B?NS9lRE52Unh3SklkZnozeEhWSDUyYmk0LzMvR2Nva0pIRTl4UjNFQ2RJaitw?=
 =?utf-8?B?clZQMmgwZ1RHYXJoeFh0ckdpU04zaHJsY0dqUGVmR3h3L05ITVQrKzJFMGJj?=
 =?utf-8?B?QjBNcUtBZzNYOEVWQWtlNHkvSDdEdlI5M2o2dUxHQi94ZlF5UDJSN3V6MXFR?=
 =?utf-8?B?UGtHWjZyWTdxRWU5WHJiWmpCUkNQUlBXY0NnaklzMUxuZnFNa2EvUkFyb0I3?=
 =?utf-8?B?R3RobFRuYlNBWGp0ZkpycmNIYkFwdXc1NnIvUVd5ZVNBSGFTUWJEN1dwc25U?=
 =?utf-8?B?M24wYWszNGp3cmIvQ0dvWmRYYlMzMFFFaXdXNXNrbnNES3E3VlNseUJ5MkdN?=
 =?utf-8?B?VFl0MWdzTWhhRXluNTRCSW1pcndZU2lKSlFTSGY1ZlIvZ0hhekFwcjdsK28w?=
 =?utf-8?B?Ulkybjc4KzNQdlJGajNwc3NrWGR3RSsycnQ2WDhXbGJtN3pVTjZRcFNwQXQv?=
 =?utf-8?B?dFVvYW5hUVI4L240Q3RuWWh6TEdiRzUzcG5FZ0hIM2htUGJxeTRObko5WE9J?=
 =?utf-8?B?QlJHbTlES2djSWNDWDR3a0oxNkJYMHF3KzhHS2NucVNwZjNsQzlpbTVvSmJn?=
 =?utf-8?B?VURHeTlFL1J4TGJ4ajQycHlxUC81V2N2aC9qbGpXYkh5Rnc0Y3RpaDE1a1hQ?=
 =?utf-8?B?VVpPT3grdWRWaDRpK21jS1lYTDhnSDdYZ3ZORE5yRnFEQ3FFakdHM3JRbytU?=
 =?utf-8?B?S1YvSWp4TUg3NENUeDIraS9yODNnQXpaTFhNRG80eEFLRWo1L29NeXZudmQ5?=
 =?utf-8?B?ei9kZGFYME0xWmdTN3dvTzFxYzFFbU9yWG40OFhDbkdhaTgvUDJyQ2NBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aEVPZ1k0amJMMVRic0VjUzUrbUtuN2lRS1dHWHk0MHF0bkxNYllQcTZmM3BJ?=
 =?utf-8?B?K0NPUExCd0p2b1QyUjNiWElXRXJPbDFXd0JBYzVFcWRSQ0pmU2llLzBSNjc2?=
 =?utf-8?B?TExzVUU0djlBczlXeWU0clpESnRjd1pZTDY1WUtLL1hsMHhranRtT1lFQXhQ?=
 =?utf-8?B?aGxLbWRkcGdQeU83N0xIUk9nMHdwU1lTT0I4Rm82NnQzOUV3V3JETXU2UnlQ?=
 =?utf-8?B?ZzV4eWQzYkVKMGtrQ01Ea3N1MHZlU2NUV1BpZll2ZnBwajcrVHdsZzI3M3hm?=
 =?utf-8?B?dDNUMm1aV204THh2K1MySko3V2F4TFVjUmM4cVhDYXNQSkpKV2tFRFJmbjVB?=
 =?utf-8?B?c21YN0szQm9KbHpEL3JwRURxK3FvRjhRakxZTUttemFaQWlKRUlVNm5DTExx?=
 =?utf-8?B?Snk1b1ZOc2VWTmduNVYrVXYzRDVGVGV5YW1kbDQ0TFI1dDltU1M4YzZvd1la?=
 =?utf-8?B?NFZGQlVVUWNWdEFFWWdZVEtlaEljb3hzQ1hYNzFRbGdubzJXWjBoVEN4ZDkv?=
 =?utf-8?B?Uks2MTYwaVE0UExJazhsQjliWG5hNDVpYjIxZVM1Zno1RXhPNVo2Zk1SbzlG?=
 =?utf-8?B?ZE5tZ1VhbmFLT0xITXI2a1JEQllDZ2g3bFdzZVB6TzVRMExvYytRRmEyN0Nn?=
 =?utf-8?B?c2h5SU03SnZKK1JacEpQeWpIdHBlc1EwWFpNMjM1OEZnYXFJYzBHVWR6T3dn?=
 =?utf-8?B?b3JITSs0bC9kcVY5anhrT1FuK2d2bWxWTjc2Q2tGNkh1bTN4VFZsOTZzWVpP?=
 =?utf-8?B?M2MreFhnT29FRnNMN00wR2dTbElvWndKVE43ZDJGaEhhMGdJT3RDYjNoVGtO?=
 =?utf-8?B?VWwwVnlXcVo2dmtuMjlId2E4UU9iZzBPVFZ3eHozdVdnSkVGN1FrcThNWjAx?=
 =?utf-8?B?ekxJZmFUNDV0bEl1UDhTQldQUUM3RzFLakJ1Vlpsa00yV3MxbnNTMUlUODd1?=
 =?utf-8?B?MmJWWlVzeFdMNEZFUFRFcGpuWWpSYVh6QXhaNHJJNXpKWmM1SjlkelB2S0JW?=
 =?utf-8?B?WHM4SFBaY1dKWTBWZXpBZWxHejczaUY0TWt2YTVQQUtBMkxHS3ltV1lDb1ZC?=
 =?utf-8?B?UkRoM003a3ozNGFibzFKWThWcGpyYm8rUGRRcTNZdUdieHVOSWhRbVZjUGJO?=
 =?utf-8?B?R3AwcVVvY0QvNHNlZWduQWhUbGJOZFJ2MDhzMS8xUU5PRDA3TGZDOFExREdZ?=
 =?utf-8?B?M2M5TzhEK1dZdFoxMEZYSVVZYktrQjl2cEJYMlJlTWRaMkM4S0kvU1Rrd0Fr?=
 =?utf-8?B?VHp5Q0FETE5CbTd5cG5mZkZsYTdyejN5T2l5TE45YzJVVEJGU2FqVUFCTVk0?=
 =?utf-8?B?Mlh5ck44c0pCVDF4Z3RFYnJCQmV5TmxpTDA2ZkNnNGxHRkg5cHR2VE91T1J3?=
 =?utf-8?B?Z1cza096N2ZsS3ZaS01hdjl0dWNIOUE2dTRHTHlRalJUQU03RUNkYW9JNzlP?=
 =?utf-8?B?dnhlcUJrU3FQWUg1QkRIT0ZTRkRTdTA1MStIOTBSSm1yd2dWNWpZdWo0MlB2?=
 =?utf-8?B?dUwrQ0RYVnFEdVdoWjdwR3AxSThObElpM0xpRHBybDBoU3VHSjFENzRqRElw?=
 =?utf-8?B?bHZodGhzQmVBTjZyUU40YUc1L1U1QXE3UUVFd2t0R3dnNEdKNjhuSmVOWll4?=
 =?utf-8?B?ZEtzOElvcUwrdDVTZFZHeVVYanRFSk9GUVdWRnZFcDdyZ3F1RWs5Q0NSU3A1?=
 =?utf-8?B?VzFaQ3V6R0lIU1Z6SXhueXVBUUZZZmVEUmpPdk5aMm14UW0zeG5zRmZscVBK?=
 =?utf-8?B?MFRrMWYrUDg5MGI0dS8zQlpscVp3Q2EwUk1pRVdRVzhxZXlyRGZVYnNBL1M0?=
 =?utf-8?B?ekdtN3VmcHpXT0Y3b08xQnV2bnRnRENZRjNsaXhuMkhYNVhBR21MWmdzWHBj?=
 =?utf-8?B?Y1VoMDFkNUcxWkhqNk9qUGJ6K1pJT3ZaMXVRWk96bVJPZGMrdklQOUNnaldy?=
 =?utf-8?B?bFhzTTczQkFZRGQ2L0JsSXBvbVo3TU8vekhHSkg5YW5vc3VLNkFEMnBkQ3Nt?=
 =?utf-8?B?ZVJ0QjVEQzJiVzdUYVQ2WHFjS1lCYTQxUis2T1NIU0hDM3dVK28rY2VWU1FT?=
 =?utf-8?B?b2dXM3pNcmsyUW0wRFVVVzhySUlhbmt3S2Z4Rk1KWlJSTVEvWlpNUGh5K0JS?=
 =?utf-8?B?N3NneFpxQWNIMVdWS0VMOEFrdk1tUzlVdDAxcTVNYkVXbkF2UnR4eTluaHZ2?=
 =?utf-8?B?alE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75fb8343-a8d8-4527-5caf-08dc70e31439
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 11:19:37.9711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EpHwgt0zG12Fyo0gn7ZkPFVacQcMYmL9usaIrh+6FMIeY+V2FrWLAZZOQiUzLKPV737RweY0mcb/0gaPxq3BpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6140
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 May 2024 11:19:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15875

From: Jan Kiszka <jan.kiszka@siemens.com>

Ensures that rebuilding this image later on, maybe outside of CI, will
still give the same result.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kas/opt/reproducible.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kas/opt/reproducible.yml b/kas/opt/reproducible.yml
index bc71f28c..a14d59c2 100644
--- a/kas/opt/reproducible.yml
+++ b/kas/opt/reproducible.yml
@@ -14,3 +14,4 @@ header:
 local_conf_header:
   reproducible-builds: |
     WIC_DEPLOY_PARTITIONS = "1"
+    ISAR_USE_APT_SNAPSHOT = "1"
-- 
2.35.3

