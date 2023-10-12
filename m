Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799E2CDB46E
	for <webhook@archiver.kernel.org>; Thu, 12 Oct 2023 11:22:41 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.86])
 by mx.groups.io with SMTP id smtpd.web10.8739.1697109756403599923
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Oct 2023 04:22:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=oEpz+ZHs;
 spf=pass (domain: siemens.com, ip: 40.107.249.86, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1JhZbfatIVIDHcekwML7gJYmQzXbw4vOObgL4P12FR8kO5VJWrose6jJRXxRLgN5vHnH7XEWUZfXf2DMw7MO3UiMHfjd3d33ctDxJmm+AjYRLoehbgmCqNy33DgenzqVSeUn8EOyLXje7PxC3fKQ7GZXWQGnu1RerNizvCpySQqjZhL91RTC6Ks8zuoib4p1DdN/SurX+QHpQnOQhudOrwgAx07LUb1XnF9TdCM4R3ZrzeNlErO533rYTAxE3chGkcKdYPL43JKXfLmSzAUpY7j3VY28WwCGn6cmEX+0bAxn4k7dsbutj3sqcqhDxe5Cwv4aWNcJZziqSwarasDPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2nKAioMdlwozqCJYbbZRE343BJN4yCcSxeAd6NDsWE0=;
 b=l0Xaz9nfTOkgmEcABwcTPOTHn3iLCfnjtYEDgBPdezYexbc0b4Wbv6g0HrbmRFbi58fsmME062qMGsjSuy1TSCloFZKFNGwZvpfk28Y9MmEO8Dm1NfvFzK1dDYKp9MVmiAH4ja+zco/HzlGF1U5dLMPZPiA27R2CGjxCnuO0WfEvJTaHKtC33KNEEW/h3dYAanO/UV6je3uIdIBs3DlDH7k1N/cqmB3VvrZJ75D7vTLSjoat7ZamKZ4mQ7vcaIHWrwiUMXCINK5bqUKh2h7csVKCPBLSBCVWsvQUXoEJrBZs3hh1c/1gaHOLnfImRMC74mgx3kyEFTSW5plNxgxd3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2nKAioMdlwozqCJYbbZRE343BJN4yCcSxeAd6NDsWE0=;
 b=oEpz+ZHsnhLzsn5CzuW3rcJGmIa0Poe4/QBd7hyoWO4Az6MkrrJva8DZPVLBCVgO+CXXCXwJAbtc+V58RzupR/lrLKzjG5WRk3mUJwjeH7Tf2xMUsmPRIbD/LRrhceORNMVIwFRoNSjwnjXRZBquZXCPni448hEXs8T738KCLwpsyGL8/WEmnnt3bn5dmGcSfUkH/lh8Jq1G7ve4BQQZSmcTKE+8q6l/AV4rToDSV+EK7R7A65NlEyUT+7QrNDPWFXfblQP0j/aFFv1wIpsWbsG2RWh/5ux71rhHwhC8imqWhdhqxbeXa3NJsCDlWZo7VZgHXzXfFKgfvj6MmQOUPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DBAPR10MB4090.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1c6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 11:22:33 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2a90:96cb:b3f:6e5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2a90:96cb:b3f:6e5%2]) with mapi id 15.20.6863.032; Thu, 12 Oct 2023
 11:22:33 +0000
Message-ID: <850bec4a-0606-4839-9412-191947697703@siemens.com>
Date: Thu, 12 Oct 2023 13:22:23 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] edk2-standalonemm-rpmb: Fix unbalanced
 brackets
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Cc: "Schultschik, Sven Angelo (PD PA CI R&D 4)" <sven.schultschik@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0066.namprd03.prod.outlook.com
 (2603:10b6:610:cc::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DBAPR10MB4090:EE_
X-MS-Office365-Filtering-Correlation-Id: 84e367ca-c9dc-4632-16b6-08dbcb15879a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	/alsGq4/Q8X7mRoghoRpmz2wS1rYxmt8o3GHfMMpGdmtHrIw/Tuf0UvWn62GKPJ6OHKaU/90Q5D84BkcLdvNlvB6iwTtLTCSQ0/6hPT0RvMMefkwEYRhVjpPKpHG9rsA6VwHJx9G8CaCMZAMzq3sLBWOb08rqLV3AxxiwPr7wROtWBlwpFLmXuoINFZMehwfoS0EI+PECRS2M/rp68DdgNXx6tFeyIP/dnieFiiu+aiN+qHDdEK0ZpnLMIcAJcitlvyvWCNAPbMXCN8X2y1d8wUzNLp6y58kNGoD8S52afHa+Rjm6wgoo6fSyxjiBc8g6brSPQHY4gZP2vQZMP6bXf5WsUQxA9z1uUOFUk2uUdSpzSJ6h7aaKm9Z2995HaR3NdoCB/adAAyhqzVGaXMaVMEPa2n4wC8/8d5FBE6HtfykDKi/5Mnlr9vJqpvonr9k5GwUt8KVO+r1JdoiNj/L/CQjnQP0mk/1PN9QygQqGIW74GDXimCm8IANyoViiVjTlbp785vIpqCLvlDqiN/74AI1HMD98NLj3+NDwLvK0aT9pPax6kAGsugIfqkwapLCYS5jAFlEDIbw+aLZDjypGiuqXCWPOz2RPv+W6nnr93TH51DqRBm6xWlV9VSI9KhCg/7vn6+75koU11LNetRDCQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(136003)(346002)(396003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(966005)(31696002)(6666004)(2906002)(6486002)(478600001)(41300700001)(4326008)(8676002)(8936002)(5660300002)(44832011)(66946007)(66556008)(66476007)(36756003)(316002)(6916009)(83380400001)(26005)(82960400001)(6506007)(31686004)(6512007)(2616005)(107886003)(86362001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OEdpTW5iaGY3ZzFLbzhxVXZINXNxWC9HTFk1a09oOU5MWGIreERXWlZmNXZl?=
 =?utf-8?B?K0t3bUVqS1BKLzNFYXBlR0VHRGMrNis4bUUzTnhXWjE5aUExRnVFMkFEclIv?=
 =?utf-8?B?OGtnTWFXK2Q5UWNFa1dDcjN2YzM2TGNQNlFQN1UzOHp2TkNtQmY3a1B3eVpl?=
 =?utf-8?B?MDJ4cnFqMDdmNmxocGMxTFY3b2FKUGlkdCtMZ1ZwRlZOVTNUMEZ5WlZGanlz?=
 =?utf-8?B?L3plekQvVW1kUUQrc1l1blpJeTM3aEwxTmIvWEVNMjdGbC9OVUNEaHNKYnAx?=
 =?utf-8?B?NU9UQXR2SWNydWJWNlVCMUtZZnZYRnVOSFpkMm9TTzQ5UGYvTGdqK1JPNGQ5?=
 =?utf-8?B?UFhwVG5rYVRnNVQzc0xibHZsOCtMOUZaV1lUMUl3dmEzeUVRbDcwS2E2Wnpm?=
 =?utf-8?B?OExQeFhUUTEyMGxndGRHanB3bGFqdkZoSVR3R0VXdnI5emRxaHdiYUhIbTJN?=
 =?utf-8?B?cVZpQStvMzArT2Rrai9hekZndlJVbUw2THd5L1VjSmtpVjlnTG55K29wZ2t4?=
 =?utf-8?B?TTEzUTQwTWYzMzhTVWNmRW1QcG1CTDJ5eis5QU1uK1Z2TGpRa2FBNFI4THk1?=
 =?utf-8?B?cGpoVHBCNFIrbkRSa0FyMFcvRHhjNlQwc1dqajlMbHZPS0lZZXdLalpqdVo2?=
 =?utf-8?B?ZlRXelJLV0Q4bTVqWWtzcVFyVTB3OWxkbWEwL211eGE0T3dHbk9HM09uTkRr?=
 =?utf-8?B?UjBRMUpBNVB4NDVDa1F3dFFmVzhmZE92OWVhMzJya2R0MXg3VzBkaXJiaUVs?=
 =?utf-8?B?anUrZHVyZnNkMm9CMHNJNDVCMVA5b0dIR3lHa0NNalI5TzJtcVFrYm9VT1Ji?=
 =?utf-8?B?dmQ5TWtVc3FBaHNvRVNnMFd1Tit1VTlHSitEY3VhbHlWckZRcHFNdHljVUhW?=
 =?utf-8?B?M0ovcW0xNEs4a3RIdzlTYmxGWktXOVo5MWNNU3ZEQ0JnRkJPV1YvU1FhVUdM?=
 =?utf-8?B?Y0pUSi9tQ2ZET3dzWHlRNk54R3RSdDlWMHVYalM4bFVFWWRjMTVoaUpUdmlE?=
 =?utf-8?B?bmtxa3hGR3VmcVlGNVAxaEtEZ2lwa01tbysxV1RKSXByMnk3d2g5Y1JmOWVt?=
 =?utf-8?B?Q290Vk9DSmg3R2Z1V0pld0NUaVE4N0tIV1hBSmQ5Yk0vZ2poRnFQU05rZkFo?=
 =?utf-8?B?YTQ3SjFyUFBiN2hOeG5ZeitRUDZpOXJsNU5FSUhESlRtUHJURHRzWDU4VTRF?=
 =?utf-8?B?TmxoVXlZQVFzdXRBTGQzUWlZM09WWUxzNUpIUC9hTlJHcEsyZEF2Rko4OUtC?=
 =?utf-8?B?UWVmWFRwTkhlSUp5clVzdUYvWTkzMWF0WEc4VUR5V1VBci85d1VaMWswSXlO?=
 =?utf-8?B?N1ZVOWZuZHRwTmZrWVdUakxHT1dhdXlpRElkZGtEeDcrUWEwMTNaSUN3L3RK?=
 =?utf-8?B?anlaNEdZWmRKaEVnUjhNZ0J4KytIblhMenpMTXp0WHQyZE84eWF3RGVjbmoy?=
 =?utf-8?B?R1FZSWVHa0FKcENDVXg5WVA0T2JMajFkQ2Y0bnhLMXFleUlmVnJ2dzF6N2JJ?=
 =?utf-8?B?MmUxMHc0OUhBbTBhS1BKTkhRTHg4OUlXMTVwYnY0ZVk3a2lnallSZVVRSTdF?=
 =?utf-8?B?alhoOFpMa1FhRUd0anl1ZmJIWW1kSTdVOGUyWHdoUkRpTDkweUhvRWxkSGti?=
 =?utf-8?B?dmZlbjhWWnJsZ3NEcERjdENwOTFWZW9EQkpKSk90cHZEZnEyajNrNDVwUG8v?=
 =?utf-8?B?V3haT1hmdENzcG55OTdtZHFISHlFUkNqRkRncFc0MGZLVklrVi82andpclhH?=
 =?utf-8?B?bjZ6aDlEek45Ui9lUXlqaFNzeHJwaEw0ZXcxc2pwUkpJeVV6QXlmYWhQMDgw?=
 =?utf-8?B?ZzZaa1ByZVBnTHBrdGxCcC9WWTQweHdnNVZuVVVZb2RpTTZTS1MzSmRjYjNL?=
 =?utf-8?B?ZnJ4bmJ1NFluM2FWaHNHM3FoS3NhZkkxWXZvSXBiekNhWi9Fc25IdTc3ckVo?=
 =?utf-8?B?ZHFlNFZyU01mZmJhUzE4ektwY3plQjRxckxEbGRvdHB0clZPVkovSWV1eWd3?=
 =?utf-8?B?OEdTdG5FcVRrd0s0ZlFKVjI5UlhnVVhaZnUwS2NQak5VSDdROW54M1hiWlVu?=
 =?utf-8?B?YmhnTUVNczBsOWZ0MzZjMFVEZkNuTE5Nb0l0TGFRbnRHbHNRZmdoMEpXaFR0?=
 =?utf-8?B?elNVM2xBL1V2WWpQVXZmSjAvY1ZwTE9nRVhIZXRQNzhmaE1TMTlTQ1cvTkhX?=
 =?utf-8?B?VFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84e367ca-c9dc-4632-16b6-08dbcb15879a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 11:22:33.4738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FMMqhSRsr6Qujy2hAqxrU3xKVfUip4tnaCMLCRhbjPfB9ijje5MrKf6MZ55Y8mSIbtCf50HkMbpzy9N0Jv5/lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4090
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 12 Oct 2023 11:22:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13391

From: Jan Kiszka <jan.kiszka@siemens.com>

Was not recognized when using only arm64.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-bsp/edk2/edk2-standalonemm-rpmb/rules | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/recipes-bsp/edk2/edk2-standalonemm-rpmb/rules b/recipes-bsp/edk2/edk2-standalonemm-rpmb/rules
index 4161e6ca..8d2c1dfc 100755
--- a/recipes-bsp/edk2/edk2-standalonemm-rpmb/rules
+++ b/recipes-bsp/edk2/edk2-standalonemm-rpmb/rules
@@ -18,11 +18,11 @@ export ACTIVE_PLATFORM="Platform/StandaloneMm/PlatformStandaloneMmPkg/PlatformSt
 # https://github.com/tianocore/edk2-platforms/blob/master/Readme.md#if-cross-compiling
 ifeq (arm64,$(DEB_TARGET_ARCH))
 export TARGET_ARCH = 'AARCH64'
-else ifeq ((armhf,$(DEB_TARGET_ARCH))
+else ifeq (armhf,$(DEB_TARGET_ARCH))
 export TARGET_ARCH = 'ARM'
-else ifeq ((amd64,$(DEB_TARGET_ARCH))
+else ifeq (amd64,$(DEB_TARGET_ARCH))
 export TARGET_ARCH = 'X64'
-else ifeq ((i386,$(DEB_TARGET_ARCH))
+else ifeq (i386,$(DEB_TARGET_ARCH))
 export TARGET_ARCH = 'IA32'
 else
 $(error DEB_TARGET_ARCH $(DEB_TARGET_ARCH) unsupported)
-- 
2.35.3

