Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE62C54798
	for <webhook@archiver.kernel.org>; Tue,  5 Mar 2024 10:56:04 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.63])
 by mx.groups.io with SMTP id smtpd.web10.19589.1709636155715518356
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Mar 2024 02:55:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=JnbAH+m/;
 spf=pass (domain: siemens.com, ip: 40.107.20.63, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CiITWVckh2MetxLL9Vafidi5DUvzBQAQgiwcA2QRHZQr/NYjCYbaqur7s3XZfByjGDLxWS7j8DBkURiUNgix/1dsTTrUhL+cjhsRZMCpoZQhBA3oSAuuM3g+HbgIfGeNSholg04MTEgjqGIV01uklvAiLEF74rep+Yeeh0qGjJJcfl9YZfOIDVQirDRg4O7wUHuzWXbL4EZ3aki+x7BEk90lEXBzDVRFNv66RvtvBXVDYvn6laL7qDpXMaNUNFNysrmuU+6ygcL+o5YbyESJF46iQ488hzawUcugMpWIdkt7k0g4CqM2jk94MO5MEiukFipdTRynORLde0u1YnjhlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2UVcyRh49fWUPaRuRs2NH30ujS/N5wsRcD6Amt3/wnI=;
 b=Hd1dD0+2I5KA62mJSNK951Ry+ZHrSCgJ6lqvNMKnf+eZxW2lKT09SG5Kl3f8MQQb16nIZ8ZC9AtL73n5iWuycXLR+K0v80MrV8313Ddo+0tuqwdRL+fX4wYMNQPTxAgemx9tv36cNzwrVpfADM6XTNPb+GQpIRnfxENvK2oLTQkKNPPZ/UsmeiDXgb7b4ekpw17Awf0jmNlVqjHExxpKLIptZwpj8iwiRxd6y/bTvQvxAjBCnC7028bMy+U4pwsiZtjF7h3l+9cf37vbHW8HVKZYQkt8z5VT/YotSgBdWj32tL7MUxo3V/B5WBsAs7vZIDH5SUnLGGwYaZYHfv64/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2UVcyRh49fWUPaRuRs2NH30ujS/N5wsRcD6Amt3/wnI=;
 b=JnbAH+m/1+vCyZJnBdiz15/ZSRQI46ffA2u8nJSS5/atdgf7aS0lB5B3eXDJ3VIyBpH/Vl8IvxJqdYFjoYglovbpQQ3SsdKEnmoBYP31IGq5casx8XSDxCy+NfM2rEm2Oqio+qJ8b7fR3cSYXUP9XeuX96xWkag2jxXUG3jAIi8Rm9JDsR2EbiR3eZmlll+Ic8qUIiWQ7vBdOVgcREg5Ipcla4sg8lro6RzmTCAOD3yam74ftmQU79b8WlPYqN/O/eCFy7ZodnR8WGBYEcyzgpbZgrcCVMQsQG9/+pyN7IQ4i22Ry6qMElr5DiiG4yjyiLAsVY2yaieG60u+rcSnIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by AM0PR10MB3345.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:181::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Tue, 5 Mar
 2024 10:55:52 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf%7]) with mapi id 15.20.7339.033; Tue, 5 Mar 2024
 10:55:52 +0000
Message-ID: <4159087f-c5d9-4320-acac-054f7d90dd32@siemens.com>
Date: Tue, 5 Mar 2024 11:55:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] swupdate_2021.11: Backport raw
 handler unmount fix
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>,
 Tobias Schaffner <tobias.schaffner@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20240301121241.259677-1-tobias.schaffner@siemens.com>
 <4e3220ce-429c-4f5d-9066-457443412bf2@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <4e3220ce-429c-4f5d-9066-457443412bf2@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0091.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::11) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|AM0PR10MB3345:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d1b5017-f125-4e00-a791-08dc3d02d382
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	8xgQMN6MnMboO99FYSo6441dFO5MjbAlnXGeq2TWZMjEI8zfZm0v/5iHnNO+/wx2JfdQX1FMiV6kQUvObrT4KDzUY3PeMIus472FWXxtHdb3TL9/mz/iVr3xKmOORRgBO936ho0ALtotshprdMAsOUMHwQl/G7N0vxGPaFN8I1ZRSOryW6F6+Wd/mPuHoIkjtSXg+gQHjlp9k/Z8i6QS8YpZbWYXrDb7SqEhlo3ZAAYlpacUaQQ0PAsilqvogu1DV41pMAJyKR+m2wNCJ9Kz8D6Wr3M0lQmTshwNwY7/SJdS2IwGYL+QJ1ejaxCMCLD9qBt0OPBwmS7Jnqz/ltwhOitmHWlMOkdHVe3yAVEYR49lARG0N80U7/ZpBKX8G/y62Rna9eWuVPfLUI/1rf3/vR3jIl0aqL16AggokEMWBNP8apSUFXn6yOwnce+8gPLVKxeKp+KJGjvttqH881ZXZQFr3Y0mbqCpJk1da6AOn2lGzoHpA4TjlDfRjq2Vm3SmqLDfVuOt19nTqkiwqlyEMbDZd4+vou4ZnX2+zkuJPmpa0xXDUSaeKW/DXZyGWaTI4Sp6J2bukavJPc5SxYiAvuPjcdTW4qDYP8Gvj70n0vVk2T8RzZtM0o5Iv+pY1keBr2pTuJZbH20/gekshh2HD/x7fzDTRgUsknYFDdb+qNE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?azI5K3BDQXQ0enYrK1RsZENpcHd0cFNqR3F1cEhyVnU0WERkTmJMWlRCMlFH?=
 =?utf-8?B?SUtENnNqQ0Zkak4ydE91T0c5c1ozNlFuNFZJMWN6RWl0U3JxUFJtT0I4WUp6?=
 =?utf-8?B?UnVldnZWejE5eHJKL1ErYjVKYzVNZHpVa0plbEpqbGMzdkVJZVY5d0xRMmxQ?=
 =?utf-8?B?aDVWS3F1SW03bU1uckd6a016SW51TEhISlNweU5GaG5MRTA5Yk5Ha21GVVB0?=
 =?utf-8?B?Z3IvbU01NEVvcHA3cFdUbllFMkhrdW9hZ2x4bSs3TWpIZWN0RW9hOGViUWRh?=
 =?utf-8?B?UXZEcTFoQnR5RWJVTDNqS1dlMkdYKytvZ0tzZzRGRkNkOWxXLzZoR2tFZ1p5?=
 =?utf-8?B?Q0FSL2laSjl0WEJKUTY1c01tRDByVGcvUDVWVTU4a0VKRFNIVDh3MEJTU1No?=
 =?utf-8?B?eXhHWGdxS3UxVlhveWM5aDcydUFKN2djVjc3dTh2UzQxNjZRVmFGVDRZb0VN?=
 =?utf-8?B?RU0vc2NSdmRvZDdGRkJKeWNlVzBEQ0s0bXJoc1F6a3BoR2ZtSTM2cG40Qnlw?=
 =?utf-8?B?SWwxbkdpazYrOW1hbW1pZ05hTWIzUTBQMXRQL01NMzd1c1lUekxPbzh1MkNt?=
 =?utf-8?B?T29yeTBPWCtYaGd1WVJld1k4bmROMjhlWSsrMHk0TzFuK1RQM3ZhNzE0L0Y2?=
 =?utf-8?B?UU1WQWk0Tk9yd3NNeWlRMjlPZCsxV09BSVZRRnpaUnA0TTNjMUQ4dkN4Nkl5?=
 =?utf-8?B?SHFwTys4WEYveW5lK2pmdll6VjF2VnpWeVArcExkSTVSeGdJTVdMa0I0cWk2?=
 =?utf-8?B?aWl5Rk5zOW44b2thZ20wTDZpSDNIZkJhSzZTSjVqWHVSdFVCUDBvZy9LWDht?=
 =?utf-8?B?M1dPT2NSRWUwSzFLNnFLRDJRWlpBNU1YRk9lNHR4QnZqR2JXeFM4MUhaRS84?=
 =?utf-8?B?REdXQjZDcjRadzhiTmF6dmRBdGprWFdNSzcyak1nMnNzVUJsNVZiMGREeXVV?=
 =?utf-8?B?ZThCb3FBNmNxY3NtUjFQbUFJS05hTnk3bTVzbnVWQ2haZjB3cURyTWdVVG1s?=
 =?utf-8?B?V3laMUsyQWJQY2xIMXg2RjdFRjBlbGM0UXFYeXlGK2R0WE9KQ3V1bklVeDlr?=
 =?utf-8?B?RU5DYk8ya1hLcDZabUJBR2N3MGhEa0VQZC9IekhUTkJLb3o4NnJab1pJM2VY?=
 =?utf-8?B?TWVIZ2RzQ0FCN0FHSDhWdWhqbzVCV1lTb3I5WU13NlNMcTJyVFZaR3RWVUgr?=
 =?utf-8?B?YW9oazlqUU51WmdZUlBlZWR5VVZCMGlNSW1TNWk5U092U0I3QnFjS2ZqYzdZ?=
 =?utf-8?B?SUgxZEpodUxjaTJVaytqVGFlSzlhaHhJZmxUTXVtZlIxaXNvY2ZsVUVyaG1s?=
 =?utf-8?B?SlFrQTM2UnNrUWtYeHRsbE1HR1lKSlE1QmtmUUVDOWkxOXg3SlRPeWJmRHVj?=
 =?utf-8?B?aU1vaVJ2eER0VU1iQnlKYnBDVW0ydWdvRVVUZkhWMUk1SkdhVmwvRVJOamZJ?=
 =?utf-8?B?UXRGakdIUUUyN3pjZ05wOXRmNWM2TWlDbkdOaE0wa3Z6M2M1TWpoSXhKVzhw?=
 =?utf-8?B?UnVUVGJvNUlMNEVCV0FPUDBhUlVsaTh5aDE0MWV0cXF6L0JKczcrREhTWUNs?=
 =?utf-8?B?dHE0LzZVMkFrQm5NOXFnTlUwTnpDVWtKc0lhTEltVzZ3NWswaTVHUDhmdWR3?=
 =?utf-8?B?NUk1SjhFTmw1TkpMM2ZBWUxkLzVpN21rUGpibURBVVEwUnJVVStza0VGTEly?=
 =?utf-8?B?ZERxR2NkYUt0L3NadytONTZacUY4QkQvdXlNb0pmd3MzVW1zcWdyc0tJcEZp?=
 =?utf-8?B?VmZEY0U4Wm9CSkRuOXB0cDNnbXd5M2J0OGJuQWhaMmY4WlNzeWNVeGRsN1Zy?=
 =?utf-8?B?aHVIZURFb0FFYUxRYTRtNjhDd253RjVqK0Rnb3pQc0hXczhVY2pTMm9xNE5z?=
 =?utf-8?B?VzR0elhrNGtwU0VVQzNLT04vN1hlbmdIcG9SWExmZFZGSlZPaUFoYVFqd3Jl?=
 =?utf-8?B?dUpJVzhoU2lYRXBTcDg2S1FHbDREK2hEMGNNNXBhRTNaaXY1L3dSdGRRRGtM?=
 =?utf-8?B?cDhqdVZlWFJTN3ZiSTNJd3pBZjNHbUwvUVZtRHlJYUE3WnNCRUlHUUpEaDRW?=
 =?utf-8?B?VlRFTGhYR2Y4OWRSM1BGQTUzQnRRRTdObTVZL2Y3d3hKc05NY2ZrUm5uVXgz?=
 =?utf-8?B?aHBsSWkzYmNIb0REZklVY0FERXl6TExhMzdmcUNGZERMdzd3dzA0L2JwYnh3?=
 =?utf-8?B?TFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d1b5017-f125-4e00-a791-08dc3d02d382
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 10:55:52.8611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hIdYkR+ccmbUJ7UxGdwofk2Eum3sfkbweMOocGrx9CiSbfpmgPcWMRlEdPAsG+9DaM6E+m4a9mDDYNmDJIOkfReoQYl6es8LIg30X5nDwHY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3345
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Mar 2024 10:56:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15215



On 3/5/24 10:18 AM, Jan Kiszka wrote:
> On 01.03.24 13:12, Tobias Schaffner wrote:
>> Swupdate 2021.11 has a bug that clears the boot partition if installing
>> a kernel file fails. On error the boot partition will stay mounted to a
>> directory in /tmp which will be recursively cleared.
>> This is critical if A/B partitioning with efibootguard is used as the ebg
>> environment will be destroyed making it impossible to do further updates.
>>
>> Backport efc06332bb0bd622e6b542e0d3bd15135629d06a to fix this issue.
>>
>> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
>> ---
>>   ...ian-backport-raw-handler-unmount-fix.patch | 165 ++++++++++++++++++
>>   .../swupdate/swupdate_2021.11-1+debian-gbp.bb |   3 +-
>>   2 files changed, 167 insertions(+), 1 deletion(-)
>>   create mode 100644 recipes-core/swupdate/files/2021.11/0006-debian-backport-raw-handler-unmount-fix.patch
>>
>> diff --git a/recipes-core/swupdate/files/2021.11/0006-debian-backport-raw-handler-unmount-fix.patch b/recipes-core/swupdate/files/2021.11/0006-debian-backport-raw-handler-unmount-fix.patch
>> new file mode 100644
>> index 0000000..fdea66c
>> --- /dev/null
>> +++ b/recipes-core/swupdate/files/2021.11/0006-debian-backport-raw-handler-unmount-fix.patch
>> @@ -0,0 +1,165 @@
>> +From faae516d5c06dc13b953002fd91c0ba3e9bba7d8 Mon Sep 17 00:00:00 2001
>> +From: Tobias Schaffner <tobias.schaffner@siemens.com>
>> +Date: Thu, 15 Feb 2024 10:43:12 +0100
>> +Subject: [PATCH] Backport raw handler unmount fix
>> +
>> +Swupdate 2021.11 has a bug that clears the boot partition if installing
>> +a kernel file fails. On error the boot partition will stay mounted to a
>> +directory in /tmp which will be recursively cleared.
>> +This is critical if A/B partitioning with efibootguard is used as the ebg
>> +environment will be destroyed making it impossible to do further updates.
>> +
>> +Backport efc06332bb0bd622e6b542e0d3bd15135629d06a to fix this issue.
>> +
>> +Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
>> +---
>> + ...nmount-target-device-when-installing.patch | 128 ++++++++++++++++++
>> + debian/patches/series                         |   1 +
>> + 2 files changed, 129 insertions(+)
>> + create mode 100644 debian/patches/0002-raw-handler-Unmount-target-device-when-installing.patch
>> +
>> +diff --git a/debian/patches/0002-raw-handler-Unmount-target-device-when-installing.patch b/debian/patches/0002-raw-handler-Unmount-target-device-when-installing.patch
>> +new file mode 100644
>> +index 00000000..f291a8bd
>> +--- /dev/null
>> ++++ b/debian/patches/0002-raw-handler-Unmount-target-device-when-installing.patch
>> +@@ -0,0 +1,128 @@
>> ++From d843a97aa56817c2c48dfb4f4b50315cdf753328 Mon Sep 17 00:00:00 2001
>> ++From: Sava Jakovljev <savaj@meyersound.com>
>> ++Date: Wed, 31 May 2023 23:44:22 +0200
>> ++Subject: [PATCH] raw handler: Unmount target device when installing a file
>> ++ fails
>> ++
>> ++Make sure to call 'swupdate_umount' in every scenario in
>> ++'install_raw_file' function - this patch thus solves
>> ++problems when an update fails on installing a file, and next update
>> ++cannot be done because 'swupdate_mount' function fails with message
>> ++"already mounted" because the  mount is still there from the previous
>> ++attempt.
>> ++
>> ++Signed-off-by: Sava Jakovljev <savaj@meyersound.com>
>> ++Signed-off-by: Stefano Babic <sbabic@denx.de>
>> ++---
>> ++ handlers/raw_handler.c | 65 +++++++++++++++++++++++++++++++-----------
>> ++ 1 file changed, 49 insertions(+), 16 deletions(-)
>> ++
>> ++diff --git a/handlers/raw_handler.c b/handlers/raw_handler.c
>> ++index 619a2f47..ac6a2030 100644
>> ++--- a/handlers/raw_handler.c
>> +++++ b/handlers/raw_handler.c
>> ++@@ -206,8 +206,9 @@ static int install_raw_file(struct img_type *img,
>> ++ 	void __attribute__ ((__unused__)) *data)
>> ++ {
>> ++ 	char path[255];
>> ++-	int fdout;
>> ++-	int ret = 0;
>> +++	char tmp_path[255];
>> +++	int fdout = -1;
>> +++	int ret = -1;
>> ++ 	int use_mount = (strlen(img->device) && strlen(img->filesystem)) ? 1 : 0;
>> ++ 	char* DATADST_DIR = alloca(strlen(get_tmpdir())+strlen(DATADST_DIR_SUFFIX)+1);
>> ++ 	sprintf(DATADST_DIR, "%s%s", get_tmpdir(), DATADST_DIR_SUFFIX);
>> ++@@ -228,7 +229,7 @@ static int install_raw_file(struct img_type *img,
>> ++ 		if (snprintf(path, sizeof(path), "%s%s",
>> ++ 					 DATADST_DIR, img->path) >= (int)sizeof(path)) {
>> ++ 			ERROR("Path too long: %s%s", DATADST_DIR, img->path);
>> ++-			return -1;
>> +++			goto cleanup;
>> ++ 		}
>> ++ 	} else {
>> ++ 		if (snprintf(path, sizeof(path), "%s", img->path) >= (int)sizeof(path)) {
>> ++@@ -237,35 +238,67 @@ static int install_raw_file(struct img_type *img,
>> ++ 		}
>> ++ 	}
>> ++
>> ++-	TRACE("Installing file %s on %s",
>> ++-		img->fname, path);
>> +++	if (strtobool(dict_get_value(&img->properties, "atomic-install"))) {
>> +++		if (snprintf(tmp_path, sizeof(tmp_path), "%s.tmp", path) >= (int)sizeof(tmp_path)) {
>> +++			ERROR("Temp path too long: %s.tmp", img->path);
>> +++			ret = -1;
>> +++			goto cleanup;
>> +++		}
>> +++	}
>> +++	else {
>> +++		snprintf(tmp_path, sizeof(tmp_path), "%s", path);
>> +++	}
>> +++	TRACE("Installing file %s on %s", img->fname, tmp_path);
>> ++
>> ++ 	if (strtobool(dict_get_value(&img->properties, "create-destination"))) {
>> ++ 		TRACE("Creating path %s", path);
>> ++-		fdout = mkpath(dirname(strdupa(path)), 0755);
>> ++-		if (fdout < 0) {
>> +++		ret = mkpath(dirname(strdupa(path)), 0755);
>> +++		if (ret < 0) {
>> ++ 			ERROR("I cannot create path %s: %s", path, strerror(errno));
>> ++-			return -1;
>> +++			goto cleanup;
>> ++ 		}
>> ++ 	}
>> ++
>> ++-	fdout = openfileoutput(path);
>> ++-	if (fdout < 0)
>> ++-		return fdout;
>> +++	fdout = openfileoutput(tmp_path);
>> +++	if (fdout < 0) {
>> +++		ret = -1;
>> +++		goto cleanup;
>> +++	}
>> ++ 	if (!img_check_free_space(img, fdout)) {
>> ++-		return -ENOSPC;
>> +++		ret = -ENOSPC;
>> +++		goto cleanup;
>> ++ 	}
>> ++
>> ++ 	ret = copyimage(&fdout, img, NULL);
>> ++-	if (ret< 0) {
>> +++	if (ret < 0) {
>> ++ 		ERROR("Error copying extracted file");
>> +++		goto cleanup;
>> ++ 	}
>> ++-	close(fdout);
>> ++
>> ++-	if (use_mount) {
>> ++-		swupdate_umount(DATADST_DIR);
>> +++	if (fsync(fdout)) {
>> +++		ERROR("Error writing %s to disk: %s", tmp_path, strerror(errno));
>> +++		ret = -1;
>> +++		goto cleanup;
>> +++	}
>> +++
>> +++	if (strtobool(dict_get_value(&img->properties, "atomic-install"))) {
>> +++		TRACE("Renaming file %s to %s", tmp_path, path);
>> +++		if (rename(tmp_path, path)) {
>> +++			ERROR("Error renaming %s to %s: %s", tmp_path, path, strerror(errno));
>> +++			ret = -1;
>> +++			goto cleanup;
>> +++		}
>> ++ 	}
>> ++
>> +++	ret = 0;
>> +++
>> +++cleanup:
>> +++	if (fdout > 0)
>> +++		close(fdout);
>> +++
>> +++	if (use_mount)
>> +++		swupdate_umount(DATADST_DIR);
>> +++
>> ++ 	return ret;
>> ++ }
>> ++
>> ++--
>> ++2.34.1
>> ++
>> +diff --git a/debian/patches/series b/debian/patches/series
>> +index 98628a77..21a82863 100644
>> +--- a/debian/patches/series
>> ++++ b/debian/patches/series
>> +@@ -1,2 +1,3 @@
>> + use-gcc-compiler.diff
>> + 0001-bootloader-EBG-fix-do_env_get-for-anything-but-globa.patch
>> ++0002-raw-handler-Unmount-target-device-when-installing.patch
>> +--
>> +2.34.1
>> +
>> diff --git a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
>> index 2384f41..5671cfa 100644
>> --- a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
>> +++ b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
>> @@ -25,7 +25,8 @@ SRC_URI += "file://0001-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch
>>               file://0002-debian-rules-Add-Embedded-Lua-handler-option.patch \
>>               file://0003-debian-rules-Add-option-to-disable-fs-creation.patch \
>>               file://0004-debian-rules-Add-option-to-disable-webserver.patch \
>> -            file://0005-debian-Add-patch-to-fix-bootloader_env_get-for-EBG.patch"
>> +            file://0005-debian-Add-patch-to-fix-bootloader_env_get-for-EBG.patch \
>> +            file://0006-debian-backport-raw-handler-unmount-fix.patch"
>>   
>>   # If the luahandler shall be embedded into the swupdate binary
>>   # include the following lines.
> 
> Looks good to me. Quirin, any remarks?

Looks good to me.

Quirin
> 
> Jan
> 

