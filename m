Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFE2C25B10
	for <webhook@archiver.kernel.org>; Fri, 10 May 2024 10:56:02 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.63])
 by mx.groups.io with SMTP id smtpd.web11.9822.1715338560594739118
 for <cip-dev@lists.cip-project.org>;
 Fri, 10 May 2024 03:56:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=HchQD2kj;
 spf=pass (domain: siemens.com, ip: 40.107.241.63, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nEnPgg67gE+FGObmc41IVDDOohp3SFtVC01Tx+Wh5dd6xi8emJsTFtR4+nSi9yFRLJEt/MSc18ymGv53nL25cU4w+705vPj3fKlZO/r0wRQDb7DuCUoLts3QwuL7nGBHSkuGrNDVgScuXPIrp/R6MzuaILpCx3iv9JThGvVFRUywBCggO2q9Smqar1dgYwKW1O6YtvYPcyRUDjsYLfLeQo7YsuvOyRZx2MuN9+uyEbl7qvrfRDfb5TyHW9iUPpvu6dP07TCwWbBIQY9xYBV7ZSIq8ZWI8IRoSUK6XBPK3MSY7VagRugr768IW2Vw73rqQQdjxdhFPDIB8UIydgZ8zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WiK6iyfA+CTawRfWLO7LA6zPHUkv8YTEujYjSzWDVQQ=;
 b=A5C8P5oLrXp1e5q0dXBjTMCEdpGmcwKmTd1WtUL0uGJgembn05xFsyMroaQnEk9c4pCdbRCisoO5p4eTZVnZsPBW4cTiDj83SUOFiwkpSSitux/9Om9ZoBwzTpG89nnnggYvOMohtVqNKFhXXqFxQ+WkiBLOI5rQhlrdrsmHHUWv607QXLBuMpZ1pBCl6q6BXgULRB3vXqzjnKvOE+duA4sQcFvVFURlGUEI7ioCn/x/HTh6mPwks/+CT1Qx7CU61Jsbgo+FLOvC+t47dQu0l8t8sU1ovu+a+9F/y2Du7trhn7+NJoQrdTmZaUk8oKtB+AFopGKr/fLn62EeSS5/hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WiK6iyfA+CTawRfWLO7LA6zPHUkv8YTEujYjSzWDVQQ=;
 b=HchQD2kjlalHt0jr0eQWEwJryMbD6bOPUYBM35XO97r5VmfuzuYawZgGplTgFG98i07EczbB5u0O+WiZTBebSCyPJiPWPEaij37HxYjuYQW4ssDy5ya891t6/wvjY9X/FB57gdBA24gx+wpyNDHc+zmgoGQae9LIxJwqt0FZ1uU+YCdzgJZxI7EcYCv5GgqCr4m0IKFazVnNDiuzkg9e3sM00IXyF8PFlps2LGuLTjMfXdCgPo357+X7wPglLqPcUtIAcTg2aAar42mBtnQHUvCSOSQuNe7VJUaq6yIj1cwBa7dD2GKo6ukwm5SqP/mIVBxkEOXhvqjehI/bqpgaqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB8014.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:509::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.39; Fri, 10 May
 2024 10:55:57 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7544.048; Fri, 10 May 2024
 10:55:57 +0000
Message-ID: <8797152f-d3b8-4c82-990e-e387375db5ae@siemens.com>
Date: Fri, 10 May 2024 12:55:55 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 4.4.302-cip87 and
 5.10.216-cip47
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0220.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB8014:EE_
X-MS-Office365-Filtering-Correlation-Id: f480a7ed-a97d-4cae-04dc-08dc70dfc576
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Y05Janp0YTN3T1dmRHRCZTRiencyOFUrdVNubmxQY2J0aXp2aEttK1VMR0E0?=
 =?utf-8?B?WkZ1US9UWFArczR1V0ZyTnlxUGMvbTh6S0d6OXBwc0YvM0VSQUxDdTU4dVVN?=
 =?utf-8?B?N05YaUt5ZFRza2FMdWtJT1Zmb1I5R2V2UGFDK1BWUDcyamlpTU92UEw2Ykow?=
 =?utf-8?B?NnNzb3NaTmhsdVlTVjEza2FpTzEwUjhVMkliVGdXODBCclBLditacjFVdHJF?=
 =?utf-8?B?ZDhyK00rY3l0ZGlxNXRMcW1laEErdXhMdDR1bHZjTDZxSjNDaUU5WmJ1UStr?=
 =?utf-8?B?eUY2clRaMEdSYjhlRFNEU3ZxM1J1a2ZnanU3bEpINGszQW0rWWM1aklHRTd1?=
 =?utf-8?B?Y1NMZzdDK2M5bXFQYlNhcitwOGNGL0F6T3g1VnFOU0NJOExGQUJ6c1FHMkZF?=
 =?utf-8?B?ZDI4V2JFYjVkaTUvNE5FanU0SGNOak9CalFta2loNlo0VnJ3eWdXYVFlckJK?=
 =?utf-8?B?NUZvdjhzWlZqL0dOUFBORFpmZC9MNyt5L3lJZjZUdURjL1RDWVB1aHJmaUo5?=
 =?utf-8?B?N2lTVytsNitzaFZvRzlma3Z5TGRQdThtSTUxREFJNzV2V1RKN2RhQmF5SWd0?=
 =?utf-8?B?b1pMRDBaQ3ZzWEZlckc0Z3BycHVpOFdvWFo5cEJ4eHJGMGtnOFhSS0RLT1ZX?=
 =?utf-8?B?eUpXTEo3K3JYVnBORG1YTCsvTGE2Y1psYnFuTnNwdHBwNGZFekw3QlJrNDZF?=
 =?utf-8?B?WnNvSExSUFFEMEJkV3NUYllaWDB1ZjVBdzVVQ2ZudGtxeHlRUlo3dzZxUHBJ?=
 =?utf-8?B?L3JoUmFtVXVUSmdQejJhVUpJaHBGZU11a2l0N2YxeDRCTCtCSi9EMGR6aWt4?=
 =?utf-8?B?THRUNEEvOG02ZjdsSlFYQU1RaW9HakhBTHN5bDV5OHE2TjRHQk9MYWEvbWJk?=
 =?utf-8?B?aDgxT1V3UjdpbXYxVm5QV0xGWFdwZzN2L0ZWbll0azRaQUJNdFk2M0pSNXpZ?=
 =?utf-8?B?ME1PWEk5LzZzMFQxUnFWdkh5dnlucE5vMXhDYjloaUptTUxsWlhZNFU0Sjds?=
 =?utf-8?B?dEZsS0xvS3ZIT0pWRjJ4RzZPQVoxVzdVTDlUeStuNElyOHk1amM5eDdmSkFv?=
 =?utf-8?B?a2RNNVAvd2VHVFhyTzduNkV4R0xkNXFyNEJvNFNFYzVhWTFxaUZIUTlHeXpH?=
 =?utf-8?B?S0c4M2pXVFNsbDVRSFVaZG1lRzFVbm5reTNTSHZjUDdjbVlUNGlpcVZSTW5M?=
 =?utf-8?B?bnlqaGZsQUkyUk95OXhIcHduYkxXU1c5RE5mYnJCRDRzYmk3azBheThpSHZF?=
 =?utf-8?B?RGNMaVNpUENsc011SmJFcWNOcFRZRGJheU9YRExBZjB6bHpvcDFRN2hFbit4?=
 =?utf-8?B?Vm5iTTluTHlZcmpiVFdJV0pZNGRpSjZpNlovMTg0UUs2d0owbXJCWjlDZmcv?=
 =?utf-8?B?Ny9vNkdyczFWMXlhOFd5WWJpVmxuSU5QNVhzWWlCUW51QU8yd201WmdocW1R?=
 =?utf-8?B?K0w4UmdHam9zYm1ncEpLWDV6NHEzK2pNZHUyQlFQVEx2MVhSWWIxeElGN0NK?=
 =?utf-8?B?bjc4V2V0ZStzRVBZNGVvZUJTSzBJOHNLeVplbGpmSFhGRXRVWUdNWlBXNk02?=
 =?utf-8?B?NWkwZzVOc0VrUFg3RVRNck45ODc3c1VhTUE5dXBzTjNPYmtieUw0cUNpYW5w?=
 =?utf-8?B?R003SjZSRmpzUzVOVUtIMXJUQ3VnMWpVaSswbzlxQWs5NVFmWnJRZkNFZ3FS?=
 =?utf-8?B?dTUzc3U2RVBvbUt1cHhzMU9Eem9xNkhLVldIbjlUSUZUVldGS2E1eEVRPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MVpaRGxpOGQ2cUpsUndkeGN4Y1JkU2prR2tRcmtVaHFqWUNMSmx2ajlhVnJL?=
 =?utf-8?B?UUFLbFk3Ui9NaE1oY1JVWWZrektmYnlDTnRVNExESmIvNnRDNDV3RTdIdVZ1?=
 =?utf-8?B?VjhNdGR2WVdCYVl6V3dGMDZIRkdOYjlxdlNud0hFZmpic3QwRXFidFVkMXpl?=
 =?utf-8?B?S3JMSm94QlRPQ3NiWHhrZTNNekJCU0tEQWVOTXZuNUEvSGdGYWFNbjhwcVFj?=
 =?utf-8?B?NHdzeDJKTC9vV1NuTXNEVllGWjduRUE3ekJYaEZtVnVuUFVLclBQYzkzQkdG?=
 =?utf-8?B?TlFuOUt3WnZJVFpiTW0yd09vTWlFalJ1dXR3dGUwWXhNcWJ3LzJRb0x4d2RE?=
 =?utf-8?B?Y1ZPVkREd2VvRU9pZzVtbFNobzBXanBtTk12K0ozY3p5UG1DSDdVOXI2QnUv?=
 =?utf-8?B?QThPNDdoRjd3cGl4MkFFbUxDNkx6dWp2aFlvTDcvK3M0MitMd1VibC9VMlBP?=
 =?utf-8?B?cEdzcVFLMC9WNjA0Zk55ZlRMbXlWNmh1Uk1qMmlFWUpkN1RZanhnbzhNY3Q3?=
 =?utf-8?B?S3NSamE1Mjg3K1I3K3AyZ2l3TDFsNWlycE5WcU13TTh5RnF3d3ZFWWxCK2NI?=
 =?utf-8?B?Q0RPMzdHR2lTVEkzSzdzbFYzYWNCQ2w4amRMZDNGNkg0dUNCK2J3MDc5b2JM?=
 =?utf-8?B?LzR0TFVIeEZGWEtrWTRjVkJZZklkVmN2MFlHQkhsdU5STW13NWRZR1h6RGlD?=
 =?utf-8?B?bEdjMFAyYnlvU2k5YTd4N0FQeXJwUWxyV0swcW9RVldCS3Y4bjdZV3ExcXA0?=
 =?utf-8?B?KzlrNUVGR2tTREFKZHI2U1MwemxRZFg3WVZtNVdBMy9kNWwwVDBTUGlYOUFv?=
 =?utf-8?B?c1pUd3REQjhWVnZkU05XUlU3NjIyWFpQQk1UNE5pMmFhZGl1WWtnTjNvS2Nn?=
 =?utf-8?B?TURKWlA0Ty9KNG1MckFpY05uMy93dkFEUWx2TS9QaUt0TmJxdW1IVHBVZi9D?=
 =?utf-8?B?Rll5QnZ4V2dUWFNyUnVvdUd6WXRwWERPWThKTzVFcUt1ZHFlWmNFaGVTNmhM?=
 =?utf-8?B?WmlhS1NDYUtwcjN1d3lmUzlhb2VPbExYVlJFeXQ4bTBQNXVSVm9KQXQyYjJy?=
 =?utf-8?B?MHZkUjliNndtdVNSK3htenFtcEdZb1g5dmF0YXpnM2tpQ2t6TElXelBHMjdw?=
 =?utf-8?B?NWxacVo2R0ZiZXAza1VRUXpvYU5XRGFwZjlEclBxSDY5dG5ZSDNsUzB5blVP?=
 =?utf-8?B?NlNLZG1NVlhHVXpHOW1adnBGdWh6S3NmWFFWc3JHQVNoZzJZYjFuSy9RdXB1?=
 =?utf-8?B?VTY2WTRHM29kejZVYnpQVXJ0cHdnRzNqN0VXUnpTdThtRnBWdGRWVEFoZStM?=
 =?utf-8?B?bEorSDhGQmxBUkRuQnN1ZkoxU1IvbnNOcnhXUHJMQmlIei9Za09vZXdQWUZL?=
 =?utf-8?B?bXUyMWpWa2JBVjhBSmhTdExtQ1hBaGRlcWVGK0RhbG9UVkNGbDlJYmlFQUdF?=
 =?utf-8?B?SVE4UUIrVlVzR0gxNDd2VDJBaVYzV0h1VGJSOURVQTZkNlZtaGxHd0E5RW9a?=
 =?utf-8?B?RjZYNng4aUlRMEhtRm5TdG1mRTNvMXZRYm1DTVRIWVFYU241YTEzSHB1YTFI?=
 =?utf-8?B?ZXF0cDZ4cEY1bkFaOFEzdGpHTUl6a3VwOUxuWUZEdVlESXdNbnNpM2I3bnJi?=
 =?utf-8?B?Zm9ERHN6M3Y2NU5mazliY2tWVXdNbER4WFVPdDhJSG8rWEw2dFNCZGJsdEpq?=
 =?utf-8?B?czlsUUh6Szc1WXJCQTdyNTdCdE1WVDVNcU9kd2VRci9QR01YTVVKNmc3ODhl?=
 =?utf-8?B?OFR1UmJta2Y1Z1NVRXNjTytWRTBIRllaa3NxRlBScUZRd3BieWtSVjlJV0Rn?=
 =?utf-8?B?TTRzSldid0Zla3RmYU1JSERnTmFERTB5THJyb3F3bmcyMUxBSk4wMGZoK2JV?=
 =?utf-8?B?YXNiQWRQUTZBMTNITmMvcnAvak1WaGNPWSswRnZ3aXpnQWErYU9Lb1k0MVB2?=
 =?utf-8?B?UkMzWm5ha2lBZEhsZ0ZzSTVIK0hualRnWTJIVGpnR1pUSzNUeVJFTis2YTVu?=
 =?utf-8?B?MytvYW94UnZObmkvUWlJYWZXWFEzQ3hXK1V0SUI3V0ZzODcvOTEyZVZUekVM?=
 =?utf-8?B?TmxCdE5kVFV2TXhlRmtlcGNFSjlJOTdaT1Rqbi8vTVB1WHlwVDFoY3NUb2Ew?=
 =?utf-8?Q?a/LewBGmHnPsMZ4gp88Ikna2B?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f480a7ed-a97d-4cae-04dc-08dc70dfc576
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 10:55:57.3401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mDgLP75PTDtRru5/oit2/UaYrxsfqz67zH1XCLh07KjB0Z5H6Zd79GhEv5Mvm1HEp5mDmU8KH9hSsmbV0kyiwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB8014
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 May 2024 10:56:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15872

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../{linux-cip_4.4.302-cip86.bb => linux-cip_4.4.302-cip87.bb}  | 2 +-
 ...{linux-cip_5.10.214-cip46.bb => linux-cip_5.10.216-cip47.bb} | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename recipes-kernel/linux/{linux-cip_4.4.302-cip86.bb => linux-cip_4.4.302-cip87.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_5.10.214-cip46.bb => linux-cip_5.10.216-cip47.bb} (68%)

diff --git a/recipes-kernel/linux/linux-cip_4.4.302-cip86.bb b/recipes-kernel/linux/linux-cip_4.4.302-cip87.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.4.302-cip86.bb
rename to recipes-kernel/linux/linux-cip_4.4.302-cip87.bb
index e03e973d..4af5acd8 100644
--- a/recipes-kernel/linux/linux-cip_4.4.302-cip86.bb
+++ b/recipes-kernel/linux/linux-cip_4.4.302-cip87.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "dd6ddb938c103c71a56b87a82cd80df2486a0bc9b5a318bbc3937c88f40c0e82"
+SRC_URI[sha256sum] = "439c904acf199e2cd7a6222c214c97c71923f43b511373ea3d110fe02b3b164d"
diff --git a/recipes-kernel/linux/linux-cip_5.10.214-cip46.bb b/recipes-kernel/linux/linux-cip_5.10.216-cip47.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_5.10.214-cip46.bb
rename to recipes-kernel/linux/linux-cip_5.10.216-cip47.bb
index 1ad22ede..9d769a87 100644
--- a/recipes-kernel/linux/linux-cip_5.10.214-cip46.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.216-cip47.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "66de32f23d3d69b0da06c4c3018cc9aa661aa8aacefbcbdb6bccb583e4ea2f2c"
+SRC_URI[sha256sum] = "aaffc76f59d327387e04c5bcd04e99bcfa8d0c692cb6190a30463eec2e6401b2"
-- 
2.35.3

