Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E36C021A4
	for <webhook@archiver.kernel.org>; Fri, 14 Feb 2025 11:02:08 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.66])
 by mx.groups.io with SMTP id smtpd.web11.18338.1739530920474341741
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Feb 2025 03:02:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ou+5r1+T;
 spf=pass (domain: siemens.com, ip: 40.107.162.66, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tI68DXOqRDFEKd2ZVfa3egMDBgNt7YO1gv/vDwxm6KFCLsUppF99QvP7XDstDApsqEqZyIzrGcx09S6QHYJVVT/bCQL0HgR4lMCeSEwK/GhnIoT8ydTebFc8vSpmYOeKa1ftyCb3F/UTj60Nj0FXhu32jJngnVotXLbK4vE5WeOmClxU71AY4tRs4ElsOLhShd+WPVNQeK/2f1itMqrXRaouA8bXPDbG7dJQ8zVy3EB0+WMtsQqz77O++ovVkcgOGleVhAnpbGksK81d/1ZxWE3chuH5JWecaAEe0bCjD8h+i8IFR60FgDScmA+vAopG3743UZt2IfvSzKJ7EapPmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SqLG/8iZpjeFgl66FF4xk2jI2Tm1tHMTEWQ7We5jBfs=;
 b=nfc1X3guQD90YvLe1bGimwCuxoYHnxT+O9nJkm9RjVPqLl8zEcGsosxNjdgQvLkDtT+oJ5ECcZ7X6AN1iDhCFaOH07Zfg31OYJriqXVV4b7kO+I8AsQf8FLeqgju0aR1HDYYFDAAi8G+1pmKQYyNSgRpFbqvd95UvsTgDPCIR7bK266JPgq1nfCshJ9vni7GHQNwYYC70xto5VsWkGXkff5uHxKeYsECKJByKsPOmMCFbkIywmKsj5kE7p0E5rGdDWGPscI57Pxlw0hHXSRAknym/hmOYgDivn8PJVaFDDHqxTBkfPVUuSgOdvMSxOsqZS53Y+H/XbR3amUs4uQeGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SqLG/8iZpjeFgl66FF4xk2jI2Tm1tHMTEWQ7We5jBfs=;
 b=ou+5r1+TRRGRACJcYD6BYAo9CLCHuGwEABy4qCGUi7GNCQ3J49WNmLCD269mmLAZtSUTuP1woRGai3whjZSh8d0owVxG1YtvO7AzVha3Ubhx8BYrOTZgD2ITlK6hRe124HRuHUoVIz66+uN3e8xH//rJY1xxWbbvVYm/hQ8JielvgpzZ/uR4BkqwYmIfCpxS4X0ITYniujdySb7dX8WUundwJMGx1uAZXLGZU7CcGOY1H2D30yi4AbCJ4uxA/vj0kkobTXoZD4e5x3AbBuku2VXbig7bKGp2DRbsksDxnpeUP3jQ8ASURKwSNY6xAqsgvN/9yW1H9aAfrlH7L59voQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PRAPR10MB5274.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:294::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.8; Fri, 14 Feb
 2025 11:01:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8445.008; Fri, 14 Feb 2025
 11:01:56 +0000
Message-ID: <50913583-4cdd-494e-bac1-1cbe8c0f761b@siemens.com>
Date: Fri, 14 Feb 2025 12:01:54 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] Update isar revision
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PRAPR10MB5274:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a570c2b-cba4-45b1-3b5b-08dd4ce6ff36
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SDNQWWlacXZGU24vc0liUC9ETGdGanUrV3RUYjhGaTIvcVlUVjloNWZIR1dM?=
 =?utf-8?B?d2NLY292ZkR5cjJpNFErSzI5ajg5T05DamV3WVAxMmhRVjF4TExYbENEaFNz?=
 =?utf-8?B?aWM0cCticUwvS2E4Q21kRDhyaXo1MXUzTFNDaTVsbm5SV1ZDOWUvd0t5cDZu?=
 =?utf-8?B?ck95bnVPRjNvNWVPbmpTdERDdzZYcDZJczVrT1lsbEpNRHluMVR0WU8yK2I4?=
 =?utf-8?B?cWh3clJSRUN0NHo3ZlVrU2tyZjNTUDFTSWV1a0VzaStVNnNvVFdsRitINGdU?=
 =?utf-8?B?L04zckZZdEVlVktMR3BEcktoNUdCNWhxQS96aG5CNTM4ZWxkYWh1ZHNrY0s0?=
 =?utf-8?B?LzFaM056Vk5VM1hBYXJ1S2JlY2l1VXlhbjJ1ZGdadk4xRFBtTmcwTTA2dGVo?=
 =?utf-8?B?cTY1aFpjV3VQWkZrSHhvdzhySjFRWERldVhwcTN5N2RBY1dUbWowRis2bXEz?=
 =?utf-8?B?NzEyY0lTelhYaG9YZm1ZbWZNUk53WHFMZVZIVDRaWTB1eTludG13eDd3aXd3?=
 =?utf-8?B?cjNldTh1YUFsUGJuRVM1S3RPYUxjQTBjeXpRS2p2NE9TZW5vVGtlNDhxMklq?=
 =?utf-8?B?SkozUkJXWlplbStwZ0tzYVRrUDljcUFGSHJaam9qQ2tMMUdZTGxCQWJTY2Vo?=
 =?utf-8?B?Q3VHT0ZVQ0xUYStiMlNPbk01WnV5eUN2MXgvak9NdzNYejZRRStZYWpiUWtq?=
 =?utf-8?B?cW10RTEvcTRzalRsb2JEWGluMGxLRFFhUm5KRVp3dWhrbitSNEcwVVpXUHpm?=
 =?utf-8?B?Smk4c01zYVRrRkdnR1BmL3hPS0poRVBFQ2F6U0M1ZVhtamxQSEIrc0tsSmRG?=
 =?utf-8?B?NFVLdFIvL3B2WmhUQlBRcWgxVEZPSEUxekUyVnF6Yi9xT1BGYVg4L0d4QUlR?=
 =?utf-8?B?RjUwM2NQZUx5aURkMzN3c2N6QmFRbE55S2NqNkREQ0VLUytZcFp3UFFuQ0FS?=
 =?utf-8?B?UXU0clhYaU9pd05BOXhTdnoxZGNCRXprYndhL05teUF5YTlPK0FqS3lOV3M3?=
 =?utf-8?B?UnNZRXFBazFEM2JEZTV2STBtbzV0dDA3M1k1dzA4MFZ3eERmWmd6VVJXc1FI?=
 =?utf-8?B?aEtLS3o1WmxKanNYVFUvVEtqUk9iZ005aVp6Z0Q0cVFka3I2a0F3M3FHTFli?=
 =?utf-8?B?QmNsWkFEVnBlbEV1d0xCc2F6L2dhUmN0T2FqVDB5dzdRbGRIR040VE5iWEFW?=
 =?utf-8?B?UVgyaSs3NkJzK3R2NzhPYlZ3UTBnblRUV1BOQUVlcmNDN2JZVW53c3I1Y0Iv?=
 =?utf-8?B?UFFadUlySXNFU1NBYm5SZFE2Nm5SZytwSVBkWk1odFl6aElSR29GTTFzdURV?=
 =?utf-8?B?aW1wdDd2M3crdU9tSGQ5SEVlUEhaVXROZE4zYXdnekgzcDd1azdIZVI4akhX?=
 =?utf-8?B?dzhWUFo5R3BHZFpUNXZYWkZHckM1aS9VVnlyQjZtVWdwTTBuKzN0U0xnaUNP?=
 =?utf-8?B?S2F0K2pabHh5a2MzVVVKa0tCYkQ0Sm1QWGNzdDZSeGdzaFZEeDB5U1VvQ3lO?=
 =?utf-8?B?VHlSQlFqN3IvdFhzdWRtUXVQWWZzWHBwREF2MCtwRndrZnJLNUFLaWRtZzky?=
 =?utf-8?B?ZlRMUm5EcjQreEtubkxWUDZNR0RKVXJIZmg2aERldXlSeXZHYjJSb1pIUUVM?=
 =?utf-8?B?K1g3R01LcVFrWXRVUDV0R3ZzR3NTemFUWFpBU0RQWG53dnR2dWEvNlBPSTh2?=
 =?utf-8?B?aFBtWitEc3ROVmdKNzJGeDVsdnc3RzVhQmM5RVREcVNFTVljeCtJbytVWWJw?=
 =?utf-8?Q?ngEXD5Yu1Q7Ki0wBOuNLETDLZ9AWos/79VMT4UW?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NHpyUHEzUFp1MEdBRnRObGthcDB6eEliTldjOFlYaVV5bUc0KzhhbGNuWWUr?=
 =?utf-8?B?OGN1VHBQVGluQlV6RmgwZ0NQMTVRV2lxcGltNktBMHJ6SVA5bXFBRmJtR1NR?=
 =?utf-8?B?ZXQ5bWlEZUw0RGNXR1JLME1IZkc0L0NxT2hYbVJnWE10TW13aGZRZVBndTVX?=
 =?utf-8?B?VnROWm4xeXJTYTlvMXQwWjcvOFFhREJYK1BpenBpNnoveW5oTVVWYi9HN0ZR?=
 =?utf-8?B?UEd0RGNHZ29lOXFZR3Y5Y2NCRVJyeCtKOFV5VE8veExFQU0xdUkva2xHUUxi?=
 =?utf-8?B?SS81NjVyd0NkaXBUZSttWnk5VDNHd0VFN3hpdmVKK3NZVGhUWmVqcllVK1RM?=
 =?utf-8?B?MnNrRUs2aHBqcmwzV2VoNms2bGxJNGRmY21WQ1JLRWVDOEg1ZUJBUmRaeWN6?=
 =?utf-8?B?c3lpSUxscUpDb3NZZWxQZzU1cHhmeEJuajRTUHZ4Q2JiTzVEeEJONzBrMy9D?=
 =?utf-8?B?ZWlsT0JNTEtFRWJLcHFhdHY5aExtQnFZTkE4VTBOcGJoVTUyZnRHUlBlMWUx?=
 =?utf-8?B?SWpjZG5weThhRm1zSGtpNnc5MjJZM1E3bnNFcFlKdzJ4c2h3THVVdW5PdGZS?=
 =?utf-8?B?QlVHTWx0SGtxNS9haUdrL0FzY2RwblRsZ1RqVTEvdXdTV2JyOTEvbUw1VDRz?=
 =?utf-8?B?bUZoclBQSFNjOVNZRGxac3hrbklMOTJ1ZjJLRTBWTXpIZUpJZDQxOXVRbUFX?=
 =?utf-8?B?alJGMEkxUDlaSzZJM2NNWSt2Rm1QVW1KbUM3K0NGdWxGQUZuaXllaGRzck5u?=
 =?utf-8?B?dHVpUFl3RFJVL3YxYWxzcDZ6VDUvRUdsdHVVZmJlWmE2UmJvZWhzKzRMZVNT?=
 =?utf-8?B?dzFscVg2WTZhMVpPTmZBTE9MVmhBcG1TeEdkQnVrRXRjUGlUbWhCNkJjUXZJ?=
 =?utf-8?B?NUxZU2hTMTQwNmlpUUxXVVB0ajQ3MEZEbm5PbERpd2ZGR28vYTVHS2RaeHp4?=
 =?utf-8?B?MTM0dUt2VGJ1Q1R2TG8xdXpDRERTY1FqaXQrMno5eDZvdDZzS3U1QVQ2a3U0?=
 =?utf-8?B?bUxqb25RY3pXSkR6dzZKMkptMEQ0ZURTdTFLT1VsVHYwc1N5bG5WVWNLaFlG?=
 =?utf-8?B?L0JMT3IwY29lRWlWUEorV1F0QXREMGgxSjduQ1pLWkFNK3k2Z2ZCSU1kbjRY?=
 =?utf-8?B?SiszdmtrWGtHY05KTjh3RzRic1ZRVGhBYnNGN0treHN5dE9UcXhGb3RkNTlJ?=
 =?utf-8?B?RW5WSytzLzlOME5PZ0cyYm0zOStoQ2hzMGV4TUpOSmt6M3h6bTRuTlB4YWNz?=
 =?utf-8?B?VGlvUFROMDBpWmM5aEMxM2NXcTBmR214M016VURrRGVxY3NpY2cwK05Cdjd3?=
 =?utf-8?B?RHpIcUUxQi9QcThRbVFLQy9veHZxV0JuNEdSbG5Tdk15czJzVlhBMTJod1JL?=
 =?utf-8?B?cGVXS3ltWlAwK1ppOWhsQzI1bTJLbWExTEN3NlNSdEhja2R2REVja2R6bXBw?=
 =?utf-8?B?MGMyUUtDRnc1SThpNlgyWUt4clFZb3V3dG5qMGpnenZVLzUzQlZySGdQQlFP?=
 =?utf-8?B?L0k0M203WU1Wd0crUHp6ZGFnSHR2d3ZSd2hyazArTEtSVC9GaFE0Zms5K1pj?=
 =?utf-8?B?MzdPbyt3SWszbHVWY2FnRXNxRkVTaXRwUThJcitwOGxqZkMxVDIxek8zMEkz?=
 =?utf-8?B?QzQxY2hFNjBxZVdnYytveU1FMzEwUk81REIvd2M2RFMrYUdpeTFJaTVqRisx?=
 =?utf-8?B?VEhsRVZGL0thR1lBUEVlejhxRWRFL3ZBZjV1blgxTTJWQk9jem1lay85Q1la?=
 =?utf-8?B?bHV2N2RKL3dMSVJSY1hNS1lZVVJ3amtaWXZnVGYzb3phN3BuKzBFQzdTMUc0?=
 =?utf-8?B?dmppVy9keDFKSDFsMGdTSG5nNTBPSjZzNHZpbmJOQmhKZ252RW42ZVNBTm9Y?=
 =?utf-8?B?eURQTzRXVVNvSG5lN2l0d3NUbHRXNnpaY1BPVTVLUXdhaU1PQW5EUzVTaWpr?=
 =?utf-8?B?UDRXaVQ1M1gwdThNYS9TdTVrRThqbnIvTjJwZ2YrQ28xN0ZKYTZWUituYUpN?=
 =?utf-8?B?cWY2S0FENXV6alU1WUYzNko3Z3NtWGp6S1ZwbVRiVFQ1L09sSVVzS2lqUXE0?=
 =?utf-8?B?elpudlRCZHVlb2QwNkJVT2dqMGtiQm5pS2F2U2FySmtodTc2cXQ4NExHcEti?=
 =?utf-8?B?VXM4NE9Fb2phRWIyaFVGUENOOGpNTVRUR2VaSUY2eHQwbkMvVEkveWloS3BZ?=
 =?utf-8?B?ZEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a570c2b-cba4-45b1-3b5b-08dd4ce6ff36
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 11:01:56.5287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rFd8QoPngUz4zYIaWQ1s58py91lmSfQKvdYe47PXiMIxf8Cwem4D4LBvP0fH8nCtmog1Ud41wJ+YTQ/ArrrV5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR10MB5274
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Feb 2025 11:02:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17841

From: Jan Kiszka <jan.kiszka@siemens.com>

This brings our squashfs class from isar upstream. So, drop it here.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

While there are still known issues in isar that are waiting for fixes to 
be merged, key problems for us are solved now.

 classes/squashfs.bbclass | 51 ----------------------------------------
 kas-cip.yml              |  2 +-
 2 files changed, 1 insertion(+), 52 deletions(-)
 delete mode 100644 classes/squashfs.bbclass

diff --git a/classes/squashfs.bbclass b/classes/squashfs.bbclass
deleted file mode 100644
index 829625a1..00000000
--- a/classes/squashfs.bbclass
+++ /dev/null
@@ -1,51 +0,0 @@
-#
-# CIP Core, generic profile
-#
-# Copyright (c) Siemens AG, 2021-2023
-#
-# Authors:
-#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-def get_free_mem():
-    try:
-        with open('/proc/meminfo') as meminfo:
-            lines = meminfo.readlines()
-            for line in lines:
-                if line.startswith('MemAvailable:'):
-                    return int(line.split()[1]) * 1024
-    except FileNotFoundError:
-        pass
-    return 4*1024*1024*1024  # 4G
-
-IMAGER_INSTALL:squashfs += "squashfs-tools"
-
-SQUASHFS_EXCLUDE_DIRS ?= ""
-SQUASHFS_CONTENT ?= "${PP_ROOTFS}"
-SQUASHFS_CREATION_ARGS ?= ""
-
-SQUASHFS_THREADS ?= "${@oe.utils.cpu_count(at_least=2)}"
-SQUASHFS_MEMLIMIT ?= "${@int(get_free_mem() * 3/4)}"
-SQUASHFS_CREATION_LIMITS = "-mem ${SQUASHFS_MEMLIMIT} -processors ${SQUASHFS_THREADS}"
-
-python __anonymous() {
-    exclude_directories = d.getVar('SQUASHFS_EXCLUDE_DIRS').split()
-    if len(exclude_directories) == 0:
-        return
-    # Use wildcard to exclude only content of the directory.
-    # This allows to use the directory as a mount point.
-    args = " -wildcards"
-    for dir in exclude_directories:
-        args += " -e '{dir}/*' ".format(dir=dir)
-    d.appendVar('SQUASHFS_CREATION_ARGS', args)
-}
-
-IMAGE_CMD:squashfs[depends] = "${PN}:do_transform_template"
-IMAGE_CMD:squashfs[vardepsexclude] += "SQUASHFS_CREATION_LIMITS"
-IMAGE_CMD:squashfs() {
-    ${SUDO_CHROOT} /bin/mksquashfs \
-        '${SQUASHFS_CONTENT}' '${IMAGE_FILE_CHROOT}' \
-        -noappend ${SQUASHFS_CREATION_LIMITS} ${SQUASHFS_CREATION_ARGS}
-}
diff --git a/kas-cip.yml b/kas-cip.yml
index 1c868afc..6c8d2f98 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -22,7 +22,7 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    commit: 37cb017a0e63f9cc26c5ff1805190a95cd0cfad9
+    commit: 21e9d1a22124014b274006c917da6681c9fd096f
     layers:
       meta:
 
-- 
2.43.0

