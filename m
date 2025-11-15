Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51C4CEB2C9
	for <webhook@archiver.kernel.org>; Sat, 15 Nov 2025 07:42:56 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.61])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4878.1763192566915364480
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Nov 2025 23:42:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=W9OzXyll;
 spf=pass (domain: siemens.com, ip: 40.107.162.61, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a43MFlM19HVniZHkzcr2C8cUdxSwtUGX5dgTHrUtqsuXkypz8hkJA8Z+Hwems8DAWOUYyLh2dPUqtJkxPwjh6hh6ErY7igxVly76MFDSzPhmHBFZideCH08myYEF3dxbPHTBPY6s2zH6nFI4JYzsD24k299YsxIdqKdtEZzLbHXsxo8PeLZXzpda6ANw6lY48vPm535iZsw1ZDujElbuuOCsW/4dykRBrCAizJpDtZYKi+Kig3nRWDrog4rd+hHO9R6tr/dlXGFy6KADM16oHqRa9vG+SV1d8xKqDAeOf1hP700fv+ZEIP0xK32EvKc5BLeshdrzLMnP7zxTrYfzlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UfWxs0v5zeDQ6/mEzJZ/2ZEvdxFS6Ea2oblsERV7W8Q=;
 b=KduRqxekBkRI5nO40CFRLrr6JGdgobkcXT0KTIgHUX9wOtXVtt31d6CL2qcRXo1Xkj/sPpJqkMX3+xGwJsWifsh8m7UmvLC+4cqrAbq0aIWelvW1CmGjt0Zo5O1RfcrixAowlAVyLctYP0wMpWMybad1pNjqE0pUNbWh3QFooi0lzwLkPcW2ZVAo7GbXA/rKztpG/nkvWAhqXeOyJLY8cFd+BaKl2dOd9FkkpJnlC+l5ek89AVt1AKw/vcGmfMUTFerZFHKPnHitHwdZlWg3WNDoqYqCyfEJSY8gvzzI15f5mhHYnlVzqiKn7EITOLftflciartftAe4Cwor0NREHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UfWxs0v5zeDQ6/mEzJZ/2ZEvdxFS6Ea2oblsERV7W8Q=;
 b=W9OzXyll+aGeHuviGkeRdBpSQ4qYu7S+Oq9zq8vfhFSHhHIpwtcpWgsuT59q1UYl1HTSFL8faTYY7eIv57KzzxSEA/TWfbgcvKhz0QHBMyyHHyYVWKYyi5zjDuT9ppQXOWqMEQmleoNW628TXIHGbhL3xKgWaQsHpxYLu2XhO8yhCWwzesSzoEOFn0kZn/pWLsAJ1FhA90YijvGVSnux3WWJmFT1rVzYfh5EoJB9lLqbU4Tjz12YmKrT8NbOweBVTGKCt3sKYA85SMeVOLeEq1bx8RkMAhXPH4gGCBifJhhIBwJch6UxSrJFZ60ZVa/b3rSfwsHUPaHk8xTXHQPECQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6275.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3ee::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Sat, 15 Nov
 2025 07:42:42 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9320.013; Sat, 15 Nov 2025
 07:42:42 +0000
Message-ID: <5a2b3329-de23-465d-951b-b08f2b283498@siemens.com>
Date: Sat, 15 Nov 2025 08:42:41 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH v2] ci: Add TI AM62Px SK
Content-Language: en-US
Cc: "Adivi, Sai Sree Kartheek" <s-adivi@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0313.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6275:EE_
X-MS-Office365-Filtering-Correlation-Id: 20426375-ca48-432f-1b87-08de241a8f6b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UUVWdFlLMkRyNWJCSUd2RXp0aDVUN3paNU0xZkhrOHcreFhQTktTUFlZbjRM?=
 =?utf-8?B?V3BkUmxTSU1LSzkxUTh4Y0plTFd6K2NIL0RPcmUrUTJTMXFoVjFZSGxUSDND?=
 =?utf-8?B?SkhSa282L2loeElZMkY5WnJBTy84ZXRtS1VvaGhZbnIwMWRpTndReEROWWpC?=
 =?utf-8?B?SllhQURLY1l4VnRHOW00VlZZMTBYOUNmRWVWQUNWczRkODJ5cXUrRFFsYVo4?=
 =?utf-8?B?dzB4Mk9zQ0pKN3ZyN3c3aE51SXU1Q2p6WC9zQW9lc0FRbTcwcTBWVWdYelJZ?=
 =?utf-8?B?YXkzZkltNnBKUnBZSEQzQm41UmYvWEJtQmZCVVkrWHlRSW5mZTBqSE13YVQ2?=
 =?utf-8?B?RVh2cmE3RUl1azhOeTczMC9iamxJcTVPdlphVUczMUtPMTY0MHQxb05OR3JV?=
 =?utf-8?B?WkR5Rnc2SjdrdW4zYnRVS1VLWGozc0ZqeFpPbmNzRHFJakpwK1p0VHBHKzRB?=
 =?utf-8?B?YXlrZWxvaDUwdXQ5cStOWXIzM2NNdEdaMEZDb1FEN0xINzR4V09JQVVCTUF4?=
 =?utf-8?B?TjdBQnBnV0xwaGVhenJuck5TOTY4OVd6cWFJM1RGZTZoRE5rRDl2TzZwWitD?=
 =?utf-8?B?VVU3RmM0ZUp2aThFenhMYkRLaDJaRXhSbEJnL0x2V00wMHFCTWU3bE55dGpM?=
 =?utf-8?B?N1I0RTJxTHFRQkFWR0hJQ1BsUmgyOXRJWnlwM1JUcVRwK0xLMzI2czZ4Y2Nn?=
 =?utf-8?B?RTFrY25nMnY5cGdMbUJieHo4VzhyQXlaMHVIeTQyUkkvRll1WFhJamNRY2Ja?=
 =?utf-8?B?RS8xUlN2TEJlOFJpSEZtQXQ1dFBnSXhmTGlsMzl2NlBzTHF4OGxJWmR1Y3Zi?=
 =?utf-8?B?WkUrNnV1MGNxb3lRTGRWQUFmRitKNFFVY0dvN0hnNWlSa3JzUG1MTGdxNlIr?=
 =?utf-8?B?WWE0d1NIMk9VQ2NlaU1SelFVYitCVHlmc1ROVEgvdlh0b3c2V0l0cW44d2Qw?=
 =?utf-8?B?d3JIb0tvQjZOejNSYWJaNHZQeXEwZlBQOEI2YWdSRHFCdnlYaHY2TTNxaW5s?=
 =?utf-8?B?S3J5T08zd0E2dWlHUzUyOVVlOWg5UWsyalN0cmFCdVNMb3AxTVpzSWdVRXdL?=
 =?utf-8?B?TUtGNWd6M0cvbDk4NEtYaFZsZldpQmNTMHRBQkZ3N2g2SWl1Rm5pd0RzUnNE?=
 =?utf-8?B?cnh4WE1Yc0xaUWY3b3l6QWc0VCt5UHNUTDdKczc1eWJvaklaZ1B4S3dUU2N5?=
 =?utf-8?B?bTdlZTVyU3p6QVl0b2ZPZ2R0dVVDems1Vm1uaU9ZMTlib1VSREVwVnU5anI0?=
 =?utf-8?B?QXZvd0ZhNm84VEtuZzZRMG1LbFpKMGw4cDRmcDRBbktQemh1YWVvbm42UEVs?=
 =?utf-8?B?QlVpNnkzQTZPdEVBR1hzclgyQ0JrS0UxSXd2RXRrdzlMM1JMaGtLMnUvN2FT?=
 =?utf-8?B?bGRGUzNrRUp4WlBHRmpObm9zdThpaHU0L1ljN3R0cUcxMjNUOVk3ak13Wkl6?=
 =?utf-8?B?K2kxdmt3QmpQdSsvcklLK3Y0T29RN2dIbGpVUDk1blRmOUxtZzlmVUhOaFBX?=
 =?utf-8?B?Y0FObVBEVS9uVEpUV2VVSUZwOVFaVHRpcE9XUTROdVRkQnJZeUhWbzJBMkYz?=
 =?utf-8?B?Q0src1p3RFRSSGVLNUdKZEgvbDNIaTJBUWo0djF1V0RWSXJZTG1CcEtTbWJX?=
 =?utf-8?B?c1hsd2dFMXREdlcvSmR3SzZKc21ZUWc2NVdkUTRKb1FrZ05FRnpqL2JFZEI4?=
 =?utf-8?B?UjFsaW10dTdCcTB1TjNLUkMxMXU5ZzlFOEdmazMvSk94dU9Sd0E1ZEVBWkJq?=
 =?utf-8?B?WitBZ3pvOWw5c3c0d05yVFFLUWczYVZJRHYvbFRBWVRaeEJBLzdVUS9iWlJU?=
 =?utf-8?B?NW41OEw3SHV4OUM4S0VRandPNFlKVXN1b2RzY3BxdlYrTU1BOXhVcG5ESG5P?=
 =?utf-8?B?dzlEME5NVis3QmdhYXhFd3M5MUR2TVZNUDhxSG9teDV5Q3lETmtRK1RkTkEr?=
 =?utf-8?Q?gWKKYNIZZ0y00coNBYEjTovJb4iO1gAO?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?R1YxQzQ0ZDN5N0EzNVdieHFyYTF4Q1I5NC9OUUphakIrNURKTFZjZkM1ai9G?=
 =?utf-8?B?Z2txelRZNmJ5eS9VS1FGNW1Ebmp2dndIV3pwc201a3VqRVYvK1BJUjdacEVt?=
 =?utf-8?B?STlJUk5UdEEya1VNb0Z3YU9uTSsxY04xR09jRjFSVHl6Y2ZVU2czT2VHdlRq?=
 =?utf-8?B?Q2VuSW82T2ZZU1o1RmVYaXI3U0Y5dytlN1pVcUhXTFMyekF1Qm1wdlZ6K0JI?=
 =?utf-8?B?VU9POW9UQ3RpWFREbUlOUndKQ0srbmxBbUVDZUhMRzR3TzBTSVZ3b1NsbFZs?=
 =?utf-8?B?U2VmV1FlZ3BRbEV0cVV1TnZ2KzVGelFRVDlXV01nSENGTDc4RkJSTTdZSHhk?=
 =?utf-8?B?ZG44VFZHNXUyRFVjMWpNOGZ5UVNQNE9xSW8yOWRISkxUWUZNYnFicFFlUmpK?=
 =?utf-8?B?eU4yTUZjRkQ4cGZOa01FR2JrNmtzSDl3cUF0cm5mNm1UWlVvV2JHRUZrUjVQ?=
 =?utf-8?B?VHo1T1phSnJGWFRZbURtZklBM2ZMSVZtQlRScm0xVmxlalQ4bTk2dG1Gd3hm?=
 =?utf-8?B?R2FqYjlFTGlWZENmeUpuVFVPMTBqTXc2R01CYVh5WkE3NmY2QXhZcHduSEZP?=
 =?utf-8?B?NkczVDBrRHpTa2xucTgwdGY1K1Y4cmFjWVcvNlVrZWs3a3F3VkRZY0VpelBZ?=
 =?utf-8?B?QzhlVGJJTUI0VFc3VGxSZUpYNjI5TXJFdjViVGVrK0xQWDlUUEZUOTF3em9F?=
 =?utf-8?B?Q1VqREt6VFd3OFMzTXVHYXg1US9yRkUyZldoOUYza1F1em84cW1TZXd0ejhU?=
 =?utf-8?B?VE5KVVVkcENmU3ZKb2lFemgzSzRqSURVU0c2WW05aG9HajJJb0JNenBXQ2ZW?=
 =?utf-8?B?K3A5a2Z4akdIcCtXSnpSUWxkVjd4NnI0Tzc3ZVZ2WkYyOGYyUlZMQTBUdWlE?=
 =?utf-8?B?Ry8yYU0vbWNUL1k3U0hGaHRkelZsalNPWXpBVTFkbzJrSjZ2R0NQOGpnOHlz?=
 =?utf-8?B?SExCMVN6YmZjUmRhZWsySno5Nnp6VklibjRDOXdiNG0wT2t6eVFrUk9oNVBD?=
 =?utf-8?B?VlBZalROSlN3S09pTVN3ZFlEUEx4aURoWExwZWcrMFhiV01UYSsvME5ZSjFz?=
 =?utf-8?B?YXJwV2UwWWZGcjNUaTQ0S0wxTzNNd1Y2c1Z4U1l1OGo0YVhLS0NkTE9pUElR?=
 =?utf-8?B?WVBsZ2x6QjVUTlJ6c3p5YVBDUXdqNk94Nyt4ZXAwblVLV1pCSGhwQlcvTTcw?=
 =?utf-8?B?aUgzSCtUSy9OSUZCbmxWdi9Eekw0RjdLaXh0YUNjSStMU1NWWDdHTVh2T1Er?=
 =?utf-8?B?Y0RFeWxYK1AyZzVvcGE5MFdxeXRXdGNuV2JJWU5NK0xUQ0hBOXhGTW1lS2d1?=
 =?utf-8?B?OXM2ZGlLS1U3eGdSRFZIZldsUnZsekVmU3RTSFNuTHZHLzMrZWNuOVprWndP?=
 =?utf-8?B?Rll1MjNXZi9VS3k4Qm5WUW5UbXFSSFhGWjVQdEd2VmZKTmQvbVpUYmM5Q2hJ?=
 =?utf-8?B?R0hQcVpZb3pOd3ZMdjZ1bFoyTXUwS2ZkYyt3d1ZUUGZ6MTNsSmU3SGx4c3By?=
 =?utf-8?B?SEdiaFUyZE41T0FjTU1DNWM5V2xJK1B0Wm1oeXNVSFRYTWF0L01GcUpybjB5?=
 =?utf-8?B?Y3grL3hPQ3dMRVVOZnkyaVMvVnI2Y3VZd1k0QWMrNkhxc01JaUFXT0ZOdVFC?=
 =?utf-8?B?OWUxSWRRRlpzdzJyTEpCK0gzVHhyT2FyQ1N6bFBQTGszcjEyamhlTW9NWGF5?=
 =?utf-8?B?UXVtTVk2dVNGdFEvT0t5bnFacFg5NkEyUUlPTWNieGFuS2hqM1orU08xbFJy?=
 =?utf-8?B?ejZmZWs5eDF0RW1uVmI3U0puWXVIQ0x3Y2JON3BUR2t1Y2twb3VueTZKVGxm?=
 =?utf-8?B?R0k0UnlobEdOekYzN1hRaUZ5ZkhsSnE3VUNVMmlObzlIYUY3QStLR2paQWY5?=
 =?utf-8?B?UUhJUlVvUUtiOWxNS3JpcSt3c0tMSWZScVdhWE8zWHNBbk1OZ0dWelN1b3dk?=
 =?utf-8?B?b2xPUlVrL1hrY1NwSWlzNHIyenVjZGMreENBTU9rSEZNcmJVUkE4bVB1SFBF?=
 =?utf-8?B?T3ZqZTJVT2kxTXlxVHYwa29SUENFdVA5eThxbjVMZ2FnMlErbUV4UklXdXN0?=
 =?utf-8?B?b0V1Q0JTZjkyZ0dQNk5vUVdXZW1BYmU1NUw0R0ZVT2VwcUFWY1FFK1FpYVZq?=
 =?utf-8?B?VE9uUFppU1JNWTNpRzJXNVBLNHJicDlOaFpQYXBVWkNJV1RxS3pZVFAzTTNK?=
 =?utf-8?B?bUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20426375-ca48-432f-1b87-08de241a8f6b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2025 07:42:42.8370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OEGqtYrmGimUGkqxP5T3f/NFiJr7XAyKy1qtL5ypacosxgdTetGG7WZfxeL+X1ETU1G0WNbM1m9SWWVPFmjW0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6275
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 15 Nov 2025 07:42:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20573

From: Jan Kiszka <jan.kiszka@siemens.com>

Test the full-featured build by selecting ebg-secure-boot-snakeoil. We
need kernel 6.12, so use trixie as release.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v2:
 - build for trixie

 .gitlab-ci.yml | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index c5bf613b..440d0267 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -344,6 +344,18 @@ build:qemu-riscv64:
     targz: disable
     deploy: disable
 
+build:ti-am62px-sk-secure-boot:
+  extends:
+    - .build_base
+  variables:
+    target: ti-am62px-sk
+    release: trixie
+    extension: ebg-secure-boot-snakeoil
+    use_rt: disable
+    targz: disable
+    deploy: disable
+    encrypt: enable
+
 .test-cip-core:
   stage: test
   image: $CI_REGISTRY_IMAGE/lavacli
-- 
2.51.0

