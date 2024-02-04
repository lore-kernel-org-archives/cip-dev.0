Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1293C48286
	for <webhook@archiver.kernel.org>; Sun,  4 Feb 2024 20:11:10 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.75])
 by mx.groups.io with SMTP id smtpd.web11.46596.1707077462913457311
 for <cip-dev@lists.cip-project.org>;
 Sun, 04 Feb 2024 12:11:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=vL1fvjyy;
 spf=pass (domain: siemens.com, ip: 40.107.8.75, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XBOjKfy7RbygKI8MvtqzMO8Aj9x/0+sJ6IRP2+gLV6CRS09OmuXTt49Yhw9mT8B/bmoOKaot9nBkK69ZQ4b6y90Dw73g3ccxuwziwCRqmNXVvK8OpPZl7FW4DIP+RM+KroiEL0+NNWeCzhp5k27LuYPKT0yP6i1KK7izFkWMD6hyRFUBPryZSqqVbY/JolY8KcRDOmLIzluBH6+LTmv+mAp0uNJct6Gu591KBKQGD/jr5fORkHiN5WgdRx7bIGnSed2g8vt5okjBajOyhbr4Qbimh7LNup+7VGM3owDNk97fLHQHNNMD5Y3EHRemU6j2GAg9jtUDa3bwncExGO10Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8vevub2/Xq8ugFUDMZGa6SADkXHQ/YJwtooa8CZ4PbM=;
 b=A3RgS5vsLjuA3PRU0JizvInDob654joqA9e5utrUQeoF77PqqKU3mHH4d8njCavhhV0NCzBDD3EuVWPscUloQX2k5VtRPeoe9s0QAbPuRGcedNWHbgFRSHRnyTSWTf7Ciy/tAEi7m+wQn7uODdihl/G48z50mc7Kb+pfb/mIYhvrDiz9k9gjQEc6HF/27vxWiibVkYdpIkeNRi2yzEST4CCdrQd7Esxi1zb/2wEn06SbjSmNXbBXVhqejB2rlclIEtvj9wFkSf70G2ycKSGAFzCPritah06DhOg4fAQabcWDbecQMQ3XkWtpni9rWTiZHXPFyyWG9rAjje35Wq2Fgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8vevub2/Xq8ugFUDMZGa6SADkXHQ/YJwtooa8CZ4PbM=;
 b=vL1fvjyysOyoKPYnhWNokPxBfhwhN7zrwg+naZojDEf/gQUh+/Eark2/saL+A/aAmrXVx13+u+HFiqrjIvE4T+uMrmJbiTFBWcJ0auKBm9ZtaL9X1yTPO/23833p+YaiMjSBaRZjYNTtRZ78HCaYKTYYgSEPPLX9BYpu8PSH2ozRGfredSRixg/6O9jGYS8KvuWZicykNfsxXq94Pu+oNuNtlPCEtwYm2WPpSXAub1VvZspWaNTsOQmLvm9+gKDQxyA7x0GgNMThCeyAEH2hzLtoJITuUU4PMQYHJj6Ot0bz5+CsKhDxiSeS65IdJiIEZKRsMAXurQVPRDHS0QXPiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6511.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:405::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Sun, 4 Feb
 2024 20:10:59 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7249.027; Sun, 4 Feb 2024
 20:10:59 +0000
Message-ID: <a5d2083f-b9ba-4b52-af23-51eafa8fbe89@siemens.com>
Date: Sun, 4 Feb 2024 21:10:56 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 6.1.75-cip14[-rt8]
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0410.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6511:EE_
X-MS-Office365-Filtering-Correlation-Id: edc09c08-4ace-4ef8-57c6-08dc25bd673b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	fj/MoXVNqq9PBHL7GL6pgoeWOIobvdB5v7jGcewS/j1QWliLlr8DP8Hb/pHrcvMr9FFLfsYzREqDQvlBXLoqDm0hH1ab38k6qq5IVGGLnTUxJzmt/REB8pS35VAeWmvR6lWNdvJ1/C1PT+nRruJ78Dym1hAvNB0RxJWLWbrTOu6Mi8PcQnfULnCLzpFd5ShWdqWZ/A5g+k17jAsdEvP5gAQAYYfSa1tRnScpf8BK6/ILPipJVpHFB43tYS0otP5Lbr/JAo7qAOCgza0SPlj+fpHWsWOnQWvbKcN4bSsphSGiY1/7xSr98dhg4KBwsv25pQka5wOTxsOg9qWQEBzLX9Xqs3ow2aWlPwzHCGjCLH2R0jw680DHc57VijBQpRpA/uf9Feio9y63Cr/mhkYY6BlY/NUGm8xKfLFgWaomHAEaZxvFQ1FW8CaEsdQzpw7YQGUkHaDw4BCWOL0vpDIDJGPmfWYMozF2HDWQmkvuMiNMeW2ZzwIljz6Q5XUt5WnGetByegoO6/cdd1UOopde+5AnAwsIcXUAgOljbN/SO9kJMTDwaIhMBh6YsL9uTsbcWHAC1RYQAAfElQa+JZ0gOrxLXBbzVSUy4VRlvR7j61UTmBQXKRiuNOXpe6TACcT1LmBM8OhPTi5zk/ir93CMGg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(346002)(376002)(39860400002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(86362001)(31696002)(41300700001)(31686004)(26005)(2906002)(6666004)(6512007)(6506007)(44832011)(5660300002)(36756003)(83380400001)(82960400001)(66946007)(66556008)(66476007)(478600001)(6486002)(316002)(2616005)(6916009)(38100700002)(8676002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TkpWVUpuYTFLWitLbnRnazBvYUM1d1ZYd2xBR1Njc01MaVh1YXhVVHZjS1da?=
 =?utf-8?B?WUpPNmZBU2NXOUR3OHFqRzFLUzYrZFVLQ2ZuMUhIL29MTm5SV2l0RWxZdDRo?=
 =?utf-8?B?SGI0bHI5UzJ0RUVzQVNtZXZHeTdvVjhIUkg3WFhiZkVMREx4cHQ0amI0YUh4?=
 =?utf-8?B?Z2d5aEVwdkNQa0NPNDYvK29aVWFsd1d3SUJsa1RQOWN6RXo0a1BLdGZtc3pm?=
 =?utf-8?B?TTluZnIxV0Z4L2NXVUdCeCt1VDNpSVhyOGhIZTIwZDdtV0tQcWh2RERCOUNp?=
 =?utf-8?B?bEZiTG4rdzFiY05xN3lmVkZWTlNBS3daZWtBQzQzQ2Y1dG9kWitLTnlmTk9Q?=
 =?utf-8?B?Z25DSTBsRHZPK0FscDUweXVuRGs0YUNmWEg4VllMcG9seHlVM203SWJSU2Uv?=
 =?utf-8?B?N0d3ZFR5dUQxd1RCR21DenFhZDBGNDBqL0xjTmVodVlXS3F0QUJlZ00zSWN2?=
 =?utf-8?B?N3RsWm5uZ1g3dXNpMW1rZ3VnMnRSYlpyQndsYTVxTkwzcGhHOUlsZE1jU2Vt?=
 =?utf-8?B?Um5CQmFvS00vUVkxbE9MbEl2akpyYjdHZjRxVDFsK01WbjBlOGNnVnZFbnMr?=
 =?utf-8?B?dlBCVXFrUWxXYTlzNlJEdHJpaUI4K2xFaloySFdQRU82bUpmQkllM0dRVUYx?=
 =?utf-8?B?bDRnVjd5bVNZcXpoank0Q243OFV1SHk1T21TUVpDeEFPYzVDcVhranJIMFhE?=
 =?utf-8?B?QStwZmEwSzZhYUNnS1lwWU1abWw1ZCtUMzYzNlZxTlBLbE8vZ1M5RE9jS1NO?=
 =?utf-8?B?YW9nVUlsOThVajZxR1VleGpaU1B2TG43UFQxQ24zUU1UWG5xZnJoYy9EQjEx?=
 =?utf-8?B?a01DRFlxbTFWUGNRS09aTTgwZDY4NUJDNWRIbjdNOE5Ra3ExSGZkcFNzTVZ3?=
 =?utf-8?B?UGhWWjJ1WWdETHFNRGFobVhRYUxmN240a3ZVNDNNVmZQOXgvWjEwWXpTWGpp?=
 =?utf-8?B?cThBYnlWYTFaQmh0eFoyMGVPamUvOTY0b25HNEFVMEphMUoyMjJyS1VsZmlx?=
 =?utf-8?B?ZW9tZ1hFSGQ4OTlSdlVoSnMvMnFGcE5JSHV6Vm5XSDl0YVlEd1RKYjcveXZy?=
 =?utf-8?B?eGdtUXlXUnVoaGxTNUVwNzkwQnFUSjlEUzdnMTBjam9HSEt2dG8rZ1VYTXBx?=
 =?utf-8?B?eHNnOUlrbStWUjVUVnc4cVZRWXN2ZDdJbzJqQ2JhcnpVR08vSUZhOVlrYVRw?=
 =?utf-8?B?Q0oxaExkc2ZIVGZ4MWNvVjgraEM2YUxFYnM2aVJERFBkbzA0VDc2cWN5RlBo?=
 =?utf-8?B?QXpPQTBza0RGT0FzRnlMdmUrcXZqdTVvU0czRUxqU1FnTXU3allnWk10WXNw?=
 =?utf-8?B?STYxbWhzdlUrZFVkVGU5VjVkMTBpWkhHemxsd2ExZ1liVkpsWDZqQ3pZSHBp?=
 =?utf-8?B?T21TRVVhOU5aTEZGVGpOYXpuSml0Y204aEtOVFJEM2s1TVFDbkcwRnBmdHhY?=
 =?utf-8?B?WjJNREhCK2ZBalRpZEo1NzRGWGpXMUZ5cEtjYW1Ma0MwWWNYNHk2RUxaR0p3?=
 =?utf-8?B?a0gyV2s0QzlLRk84ZUlLVnFrUTQ0U1ZiZGJqRVEvY1NtUVRRN3N2RHdPMHZh?=
 =?utf-8?B?bld6RW9RcXVYZ0dRM2V1c2VFbjJ2dXBQeW9JRURDcjhPdVBodXBLaDBoNnFP?=
 =?utf-8?B?cDQvenptb3ozb1pPT041K1pPbUxhcEN5MmFiUDNmNGE0TEhGeEUva2xUM2dl?=
 =?utf-8?B?N3BxdHYyQ0lzNmNXSTI5MGpWd0RrT0V5aUh1ZE94dndUbW1TUlRhazhpbEVH?=
 =?utf-8?B?VitlSmlGdkpYaERMdEFGTndNMjF0SlJqNTNGczVDK1psTVZQSUpHVTNNVWRP?=
 =?utf-8?B?Qm5tY0VoRGJyNHllSXNjcitXNlE4VHBSejFIMXo0ZURXSVI0RmdidGhFWTdw?=
 =?utf-8?B?SmxXOUkvNnl0ZzN0NXR0SmhvOVkrMVJoQm9wcW5hVlpFcUpwSEc2N3hEUEU3?=
 =?utf-8?B?TERISkt3eDdSNTg0WGp6NW4rWW45eE1WWi9id0xsTG1QT3RkOUg4OGJPK09E?=
 =?utf-8?B?OUltTkE1b3VtZlc3YzZLN3UwYk9TN0Y0RmwrQWF2elZzT0NGUjliaUVuSkpq?=
 =?utf-8?B?Q0hMYjVwZnZGYllvbDkrYTRCUGp5ODFmWi8vUkFZMXpMZk1WSXdaRmM3bHEy?=
 =?utf-8?B?MW5UR2hKa3lkZTVCSzdFQUlUeG5qWVhINFpleFFaWXNUWldJR1R2blRBT0JJ?=
 =?utf-8?B?RHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edc09c08-4ace-4ef8-57c6-08dc25bd673b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2024 20:10:59.1656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yO04hxynL2DLRgQj06Mj1R9UnaYE3LR1KIuRF9Q905D2rVPTrT/MTdIErwXcK+k9jNJHQwKBO4Vzkc4K4FnUvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6511
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 04 Feb 2024 20:11:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14655

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...-rt_6.1.67-cip12-rt7.bb => linux-cip-rt_6.1.75-cip14-rt8.bb} | 2 +-
 .../{linux-cip_6.1.72-cip13.bb => linux-cip_6.1.75-cip14.bb}    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_6.1.67-cip12-rt7.bb => linux-cip-rt_6.1.75-cip14-rt8.bb} (59%)
 rename recipes-kernel/linux/{linux-cip_6.1.72-cip13.bb => linux-cip_6.1.75-cip14.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip-rt_6.1.67-cip12-rt7.bb b/recipes-kernel/linux/linux-cip-rt_6.1.75-cip14-rt8.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip-rt_6.1.67-cip12-rt7.bb
rename to recipes-kernel/linux/linux-cip-rt_6.1.75-cip14-rt8.bb
index 2e54a3d2..f37645a2 100644
--- a/recipes-kernel/linux/linux-cip-rt_6.1.67-cip12-rt7.bb
+++ b/recipes-kernel/linux/linux-cip-rt_6.1.75-cip14-rt8.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "5b2affdeca3822cdad6fb8a236cdad07ca14f15d6e3e9b263dc1916667586751"
+SRC_URI[sha256sum] = "79f42787e34aa9159f253849dcfbb4665048690105499b1dd77c4f66e65685c2"
diff --git a/recipes-kernel/linux/linux-cip_6.1.72-cip13.bb b/recipes-kernel/linux/linux-cip_6.1.75-cip14.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.1.72-cip13.bb
rename to recipes-kernel/linux/linux-cip_6.1.75-cip14.bb
index 55e55786..4fdc6069 100644
--- a/recipes-kernel/linux/linux-cip_6.1.72-cip13.bb
+++ b/recipes-kernel/linux/linux-cip_6.1.75-cip14.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "31baac22fe43d65797704c70b9bf91554f098f93b7731dd5ccbfe0ca7f0005c0"
+SRC_URI[sha256sum] = "a820699d7342d8ad8a8f580da90e03ee4db37e9d5dac4cf8d14015ab3bae5f62"
-- 
2.35.3

