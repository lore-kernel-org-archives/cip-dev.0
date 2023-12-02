Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A307AC4167B
	for <webhook@archiver.kernel.org>; Sat,  2 Dec 2023 04:53:44 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.54])
 by mx.groups.io with SMTP id smtpd.web10.12705.1701492822170921319
 for <cip-dev@lists.cip-project.org>;
 Fri, 01 Dec 2023 20:53:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=SLnn1zLo;
 spf=pass (domain: siemens.com, ip: 40.107.247.54, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ngWGNJ/Dr4x/3UaOz3dmDN+zm/QN5KZJWW/J6Rd0d0m5vPifS0YWNg6OR9EuCGL/1nmIDwQEZOazjMwIf3rEdGMfROGlEVZZKKnK4m4p4ow5kSkwfPaaI+bEyvfN9maD+YSrAhZ9tMMBKcqJO//Z2bM8Bl+dMCfXLi9YcBQKvS8BS16rpK+vPk9/pddXDqIdMhZxnXyk6hBhEYqvVVVc12w90xsyG56v4l+2h6Gc4bxBg20ltzXoe9SSPnyrYO90qBST4ksXNf+cSKLtlhtMS0P3uyq7mL97O9mg1bIx/OqFZOOWQdU1+fzLAiFiVq+A24rmhVOMubnmBRn2suDYWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJnSxKyLX8jYgJfmAgRrnRSlHGHiY54qh13IQb6/HnI=;
 b=R1QJawQW9h04DJW8js+5CsQzTxc1Dn5MW+rpGBu2KZ+IEYhForTBBsLDYV8609YlOYNpPREhOMEqvHGVLOJ/KCGkb2KNmBBQfDAbpiGtGR6HmNS3shl4TIuSUFtLKiVyilwyngkBBwVKYsl8M6OQBMIjAsrLNkJbxsG/VAxIJiMGMEKBPnafUzXswjLYB1vP80clmjILdX71cIVWMecayZVpiHOwPVBSMCl8lrUZCoeYUqkolZb0pHUTqMf3/jWVSscWzOiTqm/aU0318LnrYWaxbdLmuBJG6gEoTUph2QkR0CsNFnWQ99MeldVK4YC5irNAg4KF72BtR6IFQPK3jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJnSxKyLX8jYgJfmAgRrnRSlHGHiY54qh13IQb6/HnI=;
 b=SLnn1zLonzLH7Hafc4alxG/pMDY+lShtOA5vexcJgz5TYTr4Py2tgGFKEcTfEDyikKuH4IRGffACuE0PuEASiktTwVDrKG+OEWOsT68MG/938Nn9Io039M2IXtIYz1DQSc7tDRZ4ijWYlZopTrLeV1vytwCrsmAUy2q5KRcdh30oUu21aNQSA+1KIXdi7z3vFSONJWilM1JB51BmiB4rXBSdFyCWqzDpI3sf2DlOgBn40WaURCv+xZ8TqR7rFRVmVxyKvAcaWYSBfx7QOPMB06OW57fVHhJgxUZnnIYmTY0kDdnWNdFs6qIVnsAMWwDjLsi6YI0huPLi2QHWL4TSMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB5814.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:6c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Sat, 2 Dec
 2023 04:53:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7046.027; Sat, 2 Dec 2023
 04:53:38 +0000
Message-ID: <0691e4cb-335f-48c8-a126-574a3e319403@siemens.com>
Date: Sat, 2 Dec 2023 12:53:31 +0800
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 4.4.302-cip80-rt46,
 5.10.201-cip41[-rt17] and 6.1.64-cip10
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM9P192CA0024.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::29) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB5814:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bc5954d-e58a-4407-0490-08dbf2f2a5bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	fr1BIQ+CCoactteN0CNeNbv/R60JWeHwowOL3Z0Rrf7rTkEI1pNO6mYndab764PgHLhaarzEFGI0vSBgqQywr+o7S2iTMLvun02vWal5AbaCQKxOZr1yBYq+52KteQI94tzzgu2tH6/CL4EUOuMDMGOgBz3rkabYCvQXbAveiRt7pBQY6RRMPEyTtmxFfZ+rU2zXvfg9AKbnmv8LaH9a9SO6IuKBchGXX+PvIfMjfwjBYaTZn4DDWBofrz/0XR4gJHwlF24q+/iaH6vO4TKHTKTw/scnpiWfhu/qWlY+HeYxYpmhcoLl1tpqEgbRetpQOnP+erUK4rfmz0tzVWbBNSUE260+KmnKh+UL0H83GP5OVj6WGbj9t8y89enbtmXBL2R1xfOLBgWu1lzxOGkWP8cYy55n0zsp+ZpJG/26mnt41SxPhlaZ2GlJ+wHp1SovJCg7+i+GWhsKQDYU7Vw6w8zJyx3vmB1SqHLebUMaoP4ACXfqOGbKlQT8zNHl8P+hijf3eq4d0bn9sx+4npyN+i9hnYFEByi6bb2Db4wrATk5R246aQL5NfhK8i4oHdZbPJuyVnBEO5c49gJ4nRkV10qWDKza13Z8VFMMKaXvKcRI4joABIrsNHPArpXDmF4LI0zKuGPDMqjwNg4YPc8Oxw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(396003)(39860400002)(346002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(478600001)(6486002)(83380400001)(26005)(6666004)(6506007)(6512007)(82960400001)(36756003)(2616005)(66476007)(66946007)(6916009)(66556008)(316002)(38100700002)(31686004)(44832011)(8936002)(8676002)(86362001)(2906002)(31696002)(41300700001)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SVBuMnNQTzgvN2hoQ2VkTXl5eFh1YWZrd1I5Tk45MkxLbnYvbUNJTjhNOW1Z?=
 =?utf-8?B?T2haQTRQYlRSOTlTSWhqSHNLVVdQUWYyMU95MFZxZlBILy9iRWtpVCtDeXU4?=
 =?utf-8?B?OFg5b0NmTkhHQnA0SSt4ZlM1UHM3cE9xYXFKOGJhTVU1cy9yTTZMRmtWYjEr?=
 =?utf-8?B?dyt6bGg3ZXpOK3FvbFNjN285TjBYZnZidzJUWm4rUStVM0ZPcldyUVVIL2N4?=
 =?utf-8?B?WGJaVDJSVjczVUFyTmxaSDh2UmNjYnhibmtSVCtIWFg4aEFlQlMrTkw2TGYw?=
 =?utf-8?B?bWtnMlFrSTBJNXEwRFBzY0FvUzh0TjRBRUxJTlp5bEljMWF4dEd4alpGS1VY?=
 =?utf-8?B?KzVNdkVCcWZPcUFFbDJkOWNkdmt0TGVjR080Vm0vU0NSRTBVejUrVERHQUhv?=
 =?utf-8?B?eUwzV215b21BdWoxT0dRMzVwYy94OXVQMno3MGpNVEFQSzBnQU5aSG93em5r?=
 =?utf-8?B?TitnaGc2cEJKSWZVSG5vUDdGVmc1R1hYVzF0UXh6NFZTc0JmazgzV3M2VStj?=
 =?utf-8?B?VFJUZ1lXcmk4UjJ4S3J4ZjRBVEhINXkwdzFpa2JZMEpTUmZoaEZoNHhKakJ3?=
 =?utf-8?B?dkZqQWkwZWxJWlRaZFgrRWdheEEzRk9aS2JPZFRMRG5hM1ROM2ZvcXVvYWMz?=
 =?utf-8?B?bmpuc2xnK21FRVd1OHVKekFDZzBqdDlNWC9DbHpySTZKTVFkL3JZQjJ4ZU5H?=
 =?utf-8?B?enlhZ1ZQcC9CSzRNaDFtNlhwM0trcWZUd2V0a1dpSGJyS2w5bmV4blZudzly?=
 =?utf-8?B?dzMxNzdicWtGUzgrS0tmY3phMnhpNVJPZ1FIWFByVGRzQi9KbS9ncFJ4dlEw?=
 =?utf-8?B?NjZlSG12aGorTXlDMlRwTlNYc3NwR0pmaHpWOG9RNlJ5bFdoRi9GL1NKcmgx?=
 =?utf-8?B?dXcyVm90M2lPMk1YTjR2QUVXT2htSmVHNU5LR1FVRUZzNXZlVUUxaG1ueVB0?=
 =?utf-8?B?enBSZG41N1FmRFVjSlY1L1ByS1hISXdzTE5hTzRwbXFwRHQ1MmdNcm1XZjJj?=
 =?utf-8?B?Wk4yblN4QTdqckNOeU16Y3EyS0czeHBIYVZuTFNBS3dPam8rckVBL2ZLMWFl?=
 =?utf-8?B?RlEyclNhU0ZyTUhaRjN6d3dLMUp1Z0NIZUM3c1RBaXpleWlNOERscmVOSm1y?=
 =?utf-8?B?M1V3RzVOMmEyL2hacVgyK0o0R3NGSmV2OGNOcVZaOWpzMnN5Tmp2NXhOOHJ5?=
 =?utf-8?B?dzFDdS8zWG9EN1NpdmUzc21DeHBJZ212RmV1Q3JMM3Y3M1RKQ2puejhGM2Fk?=
 =?utf-8?B?bU03MkFKRGUvdi9Db3QwOWxQODJ4VEM0azg5dzR0U2Zod09EaWl1QVVvYlpV?=
 =?utf-8?B?YVdENHpwOGFQc1g3VzhjL3o2bExTZnhmaVBKNHFoc1luTlhKN2tseS9ielBO?=
 =?utf-8?B?aVhnUnVYSWhzcVBqY0VObnF3Q2hkZzRFY3hqTHA4ZUw0c2ZEZ201Y3U5YkxH?=
 =?utf-8?B?NFgrMGU5VW9TRGFvRS9wY1R3cW0wNjFJak1BUzVPaXFoMk9DL1hrdGI5aGQx?=
 =?utf-8?B?bHFQNTVpWTc3OUpKMzZjSG9JZTFHSlBkNXpOZlRRVFBpWXRRejEwSjJaa1k5?=
 =?utf-8?B?dldVS1FqSkhUb0ZpSEEvYURxVjR3aUFxRWc1ZlhxajIzNHloOU05TC8zWUx4?=
 =?utf-8?B?NzZMUHlKdEpKT0REYjJ5TVdEWE1CaFJCcHUzckxaZEFHM2lFSzhCa2cvVVhN?=
 =?utf-8?B?WTgvOE16cE9MSEJGYmZGdVgvSk16STlVRXJ5N1MybWNGY2ZxS0NhNmp6Vmpz?=
 =?utf-8?B?RWtHcEZBNjJwYWtwV0svVjZMbm5HVkZjKzJGYkpkRk56NU1xY0d6LzBhcjdz?=
 =?utf-8?B?WlBsWnE4ekhaTjRYYXNJMllNT2poSDdUWGpOdjhYSmE3aU5LTU1IeDVHWElS?=
 =?utf-8?B?dXBSMFI3ZXd3Ti9EYzJQZ01rTXdNWEdpVVVoT1c5R0tRczZac1RIRURoM3pu?=
 =?utf-8?B?N3BZUjRieERsY0FXQ3FLcFJPOTNKcU5JWDcvZVQ2WSt3OWliRGZKUFhqMXVn?=
 =?utf-8?B?MHF0b0dvQ0tlZEVSNHpwb0x1RlBCSVRDTnFRODJ3UmVIZExDbDEwR0VmRzhn?=
 =?utf-8?B?SWtGNUdaS3Zpc2JGUHRTSmlQenhQTUgvaUh0WWYyakIxMFVnc2lqU2RkMVNv?=
 =?utf-8?B?OFkxdXhZTUtMQXlBNHdyeUlyYkxINmFUdEJmUXhIVC9XNlRYeVRNaDFhd0pQ?=
 =?utf-8?B?OVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bc5954d-e58a-4407-0490-08dbf2f2a5bf
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2023 04:53:38.1269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TRdCVXSisTpqqh+3L1N0ZFLjyToH9hKpHewshRGeB5aLyik68If05GF2adsy1wYpcqGH04qfzgiYYSMKpbtPwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB5814
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 02 Dec 2023 04:53:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13776

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...4.4.302-cip78-rt45.bb => linux-cip-rt_4.4.302-cip80-rt46.bb} | 2 +-
 ...10.194-cip39-rt16.bb => linux-cip-rt_5.10.201-cip41-rt17.bb} | 2 +-
 ...{linux-cip_5.10.200-cip40.bb => linux-cip_5.10.201-cip41.bb} | 2 +-
 .../{linux-cip_6.1.59-cip8.bb => linux-cip_6.1.64-cip10.bb}     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_4.4.302-cip78-rt45.bb => linux-cip-rt_4.4.302-cip80-rt46.bb} (68%)
 rename recipes-kernel/linux/{linux-cip-rt_5.10.194-cip39-rt16.bb => linux-cip-rt_5.10.201-cip41-rt17.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_5.10.200-cip40.bb => linux-cip_5.10.201-cip41.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_6.1.59-cip8.bb => linux-cip_6.1.64-cip10.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip-rt_4.4.302-cip78-rt45.bb b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip80-rt46.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip-rt_4.4.302-cip78-rt45.bb
rename to recipes-kernel/linux/linux-cip-rt_4.4.302-cip80-rt46.bb
index 478786b8..678a8027 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.4.302-cip78-rt45.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip80-rt46.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-rt-common.inc
 
-SRC_URI[sha256sum] = "ef3e1dd8ea1445d3b1321ff158f41a50f5319f81539d17110eab4a1cc2f79fde"
+SRC_URI[sha256sum] = "2195422a0d154d8191e6c974a9946b3c91187dde891c52ae971e39ccacf9556e"
diff --git a/recipes-kernel/linux/linux-cip-rt_5.10.194-cip39-rt16.bb b/recipes-kernel/linux/linux-cip-rt_5.10.201-cip41-rt17.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip-rt_5.10.194-cip39-rt16.bb
rename to recipes-kernel/linux/linux-cip-rt_5.10.201-cip41-rt17.bb
index f11a5bfe..32cc13a2 100644
--- a/recipes-kernel/linux/linux-cip-rt_5.10.194-cip39-rt16.bb
+++ b/recipes-kernel/linux/linux-cip-rt_5.10.201-cip41-rt17.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-rt-common.inc
 
-SRC_URI[sha256sum] = "54f319ecb09f98d2df408b97dbed015c90cf8871ef83430b10eae8e40fb93070"
+SRC_URI[sha256sum] = "b1dc1779a9b8e05c1b547c2b3f2b19c5829504431f09c1a82e24b98d1395c4a8"
diff --git a/recipes-kernel/linux/linux-cip_5.10.200-cip40.bb b/recipes-kernel/linux/linux-cip_5.10.201-cip41.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_5.10.200-cip40.bb
rename to recipes-kernel/linux/linux-cip_5.10.201-cip41.bb
index 20c1d178..0868ee58 100644
--- a/recipes-kernel/linux/linux-cip_5.10.200-cip40.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.201-cip41.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "bf0d4f4a745fedde8797c4c5803a23d07fd6142b515f9b15486838d3431a0849"
+SRC_URI[sha256sum] = "40e976196aa52c07a9bd39e9d7d320919aac8978a518de83680223aa04f0d11f"
diff --git a/recipes-kernel/linux/linux-cip_6.1.59-cip8.bb b/recipes-kernel/linux/linux-cip_6.1.64-cip10.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.1.59-cip8.bb
rename to recipes-kernel/linux/linux-cip_6.1.64-cip10.bb
index b8396d8d..de65b6bd 100644
--- a/recipes-kernel/linux/linux-cip_6.1.59-cip8.bb
+++ b/recipes-kernel/linux/linux-cip_6.1.64-cip10.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "bb6e346dfd61f2ad36fbbcc3401cb5da6519ca1c9e0222096e86fab7c203bbb9"
+SRC_URI[sha256sum] = "4439d9cadbe7dfa91490d883270636e6f8f2fb8796dbd4e01356e851f106d90e"
-- 
2.35.3

