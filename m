Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5FAFCA0EEB
	for <webhook@archiver.kernel.org>; Fri, 22 Aug 2025 09:48:22 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.12])
 by mx.groups.io with SMTP id smtpd.web11.6122.1755856090324527834
 for <cip-dev@lists.cip-project.org>;
 Fri, 22 Aug 2025 02:48:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=E1rwm0hl;
 spf=pass (domain: siemens.com, ip: 52.101.65.12, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fe0CogZTSS6vR9iHHTAIg7ewasNoKxvbfMvCDokHCuqopmfb19HD9uYU2Z5BmQTNGxsxHYUEY3mpXnkJlYevsGMxUwUq6gZ31NTWp7ho0jH08wA8hysClimHpm5e4jOjJhlRUT7dVF1qbQm7tqySAsDsEjAXkO49s242864kL325OZPEY48ilK1U232TB2tkqnv5my/giB/K1G3Xuz607HKhc7Bu63gDnIyxP/oqiay7hpQZWHPLs7MTfD7Nj5PbEsS7OuLx97fT+uPJgVZ1dw7fKIIsGPS0w4OKS808p79RhcOXhL34ZiWy4QTPDbnxTjkVE3VqmOhhZAT3WV3ngA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TX0Tbk0YGSd3ZCdMf2D6bJvkZHKpkk0ZNXbHizGk63U=;
 b=eOArTaScymjNanVJfhs873+gr3bJLWgCcKFvCsFuvur2ogxvhbjpu5BJOGl7wdm/wUeNcjZqzujXwgTgxVPj2PX0EnR1QraGpJOLNgBhc4yEhgwwLOg2TxKlo3NMDV6ha8iaNeWMtZ+EJ6CEXR5ZpAeePzqeWI5LS0K24hCUfTPb9F8zBdWwsIBr+yecOqB4h6Tv6RBOHjK2sA2PW86vmMqGdOSAgv5hUj1sss+m4U+g0eexzzKYRwG6/8hobU5ZaSJ9CEzpYwHsEILo+iLoounQcTsaAKnMoDM//Xo9W1ELydNqI+9oS+uayqzAbhchzNSfSLviid1njfxUaqKAjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TX0Tbk0YGSd3ZCdMf2D6bJvkZHKpkk0ZNXbHizGk63U=;
 b=E1rwm0hlVZtxAcDITYbk2h2LXEuK1Cy+7sEJcZkxIZT9pyanbrno4IbPMmH2iguWPbviJVBkDZY/GvBHxKqxBxuh/ZC2MwNQzoA07yJkIsHx5syh828RBji5GWNCx3B3zvIoWaYse+2os/AElT1aVH/0o0CTvQTXQz3P/rxtGZe//f4C/S9F+xHjVO2GuB6mrxNsL6KqH33QsyP7oVxTo1B6x5klCcLYgcBeBfRamKhsurcBPWCkx0yXuLlQTqSukto0BnY01q0Dq9Bhb/45bdhrGsDEmQbDuNPvsIwSJAthK7bRo2CEfCl9gkQTfVyi/8OQ8dUOXKrn2dBavkkqAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DBAPR10MB4124.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1ce::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Fri, 22 Aug
 2025 09:48:06 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 09:48:06 +0000
Message-ID: <8008dc96-0881-4146-8440-6373be72fb00@siemens.com>
Date: Fri, 22 Aug 2025 11:48:05 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] secure-boot-snakeoil: Use bullseye key for
 non-x86 buster targets
Content-Language: en-US
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0078.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DBAPR10MB4124:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cd3c19e-30aa-4e29-9504-08dde160feda
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RkM2RitnNnlFTi8yRzFYdlZtRWRsMWtXL2hnWndaYWdITTJacFFvOTdvTEsx?=
 =?utf-8?B?b25HQzZYUG5tdjJJT09iZEpRcm5HWEZCQWZwc09wWlRmYjhXSmRkUTkwNWgr?=
 =?utf-8?B?OWtIREZ6b09VRmZkVVJYTmRDVFliK2lUMGdpKzI4RjNaUmdtRmdMREJKNFdo?=
 =?utf-8?B?TVFGRExucHhnYUoyd1J3V0RHQmtJZ0V2cHU5OWZWclYwOEpxejJHZ1pPQ1pw?=
 =?utf-8?B?NitSTndmUXc1MDVwUlROL1YzWm9JNFVJNXREYzNqTnhrWmpONmI5U3FialpG?=
 =?utf-8?B?QUU2ZDlRZ2w3cC9pcUtjcTA4a0FCd0VTZjdLSWtDR1FtM0twU2dHdkx3YzhJ?=
 =?utf-8?B?dElKTUVFU2crdGkwcGhpR3c5OElaNUM3RjNkak5CZ3pyRW92VmwzVUhMY25E?=
 =?utf-8?B?OXFyZGhOQnIrNm83OWQ2cXV5cjB4TlVBTFRqYjFiUFYyU0N3aU9qeHIwKzlq?=
 =?utf-8?B?QTlsKzRxKzdkem5YK1lHODZlWkxnZUJ0eDlybGdISldBRFk4STZzMUF4c29M?=
 =?utf-8?B?d21qL0ZNLytHUVJ4Sk9LOEFKM0o2eFd3bW43L3ovZG9Wb2d3aEZhcEtpQkRS?=
 =?utf-8?B?eENCL25wSU1tOGFqZlRXWURRR3hzN1RuVTNsL0tjYnlaVzNJL2cyVXJJWXNq?=
 =?utf-8?B?eElmaXVHaGR5MnRxdStrczJiSXRjY2ZQaDh6OGNGaUJxcGVYRnl4dnN2Nlh2?=
 =?utf-8?B?TVV1c3JxWFhPb0w0VWEvZVFFOXV3ZjNibHp0OVBBTkFUd1ZUaDVjSWJVanZ3?=
 =?utf-8?B?anBBRklvTU1iclo5UUFZckNla2MrNGh1UjR2eXNaTkkzaDRFSEdKSkUrTDQv?=
 =?utf-8?B?QTc3UEZPT2FIUC80alBac1V3S0FjWDM5Z0s2QjNhak4yWUFBaXdBYjdFK0Ru?=
 =?utf-8?B?Y0FYSGRoa2VscjgzekcyWjZwYnhkUmpXY21xam5TbDEvdWcra3dRNmxUZFBT?=
 =?utf-8?B?NGprNXdMQWVKK1Q2OUpHb0lCMnNXcVhVZE5IS3ZXUUhXOFhkRVE1TngwaVp1?=
 =?utf-8?B?bXNPbXpRclFyVHNSRUpIclhoMzV1SU9KcHl3cXNXNjMvUUhkbi9pR0tQZWpB?=
 =?utf-8?B?bVd4cEVrZVlta3ZuMjZGeWh0WHM5MlluUjdOcDNGTU1mbTU3NFZPMlV1V3h0?=
 =?utf-8?B?VEZhUGhCRTFybHF3UStmQjg2N3BackZueS82QVdhLzIySERvNmUwWEliZ3JN?=
 =?utf-8?B?SWlxR1BkSng0R3hUbHFMVWZUR0oyNUxXcFBzUmppZHhzdkZPNFlzd2p4eWx5?=
 =?utf-8?B?VVYxTk41Qmd0eFdQVDQvL2FpVUJoaWpaZ1JFYThTbFJoa1BmMG9INTk2SnJp?=
 =?utf-8?B?K0lSMGxwTVdNUHA4Y2tqdWxNTEI4WXFZcVRSR1cvbVZsUDRxdGRDUzV1ejZK?=
 =?utf-8?B?aG0yb0kways2MDhRb3h1OXM5dldjZFNQRDRId1hRWnFPUStmTHpvaDU2RFNL?=
 =?utf-8?B?QUxiUk1GOS90SUtyd2hmTkNBVnY5RVllelJ2VjYycDRLeEhQSTF4WXhlYUk1?=
 =?utf-8?B?SzE4bVRkUDlPNU5mV2Job0dTQU4zTkNyUlI5dTlDNnJzVmJ0TW50K0NyYXdK?=
 =?utf-8?B?Y29RRWVvMzlpM2FMalhWM0dqcFhzak9TUWZEamlaT0ZCdHBjTlFmbkY1V2VW?=
 =?utf-8?B?K0ZsaFEyU1VzN0NKTFpvaTRHNlR0RVBkMjJzbHpBRjVuOHE5YkdTSlZVWHFq?=
 =?utf-8?B?ZXlXaGJ5dWNzSUdldHpxSE82UU96Y3ZscUxNSVF3T1UzT3A4OVRpNG1GaWN0?=
 =?utf-8?B?UDRnamhXMVcrYUZEWWd1K0ZLTU1yUitRRE9BWExVdTNFQ0c0YjZwbnhBL3BK?=
 =?utf-8?B?aFk0U2pIRXR2OVEzd3RrRjI1bHhLN1Q5ZHcrWmdNUFg1eFRLUTE5T0dzSTQ5?=
 =?utf-8?B?UHZrT2wxZGJBMkRyY3FjMWpqQ0pmRTNqUnNJVEJSQ2dDQVkvQVYyNGpVb2c1?=
 =?utf-8?Q?PC/03p+L1WU=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NkxOQ3Rwd05BTG1hM3VBNUYxeDYvNC8yUWFUK2xwRjFLZjBlWEVpeWpGblNM?=
 =?utf-8?B?USsyeThBak9MRDdOZ1dHQ280YkZObjBuQkcraUZCUVl6ak1CK3EwR1BjcTRu?=
 =?utf-8?B?S3J4OWFMN25uTUlXVGtsMCtkMWs3eWtUdUE5NkE5WnRhYU9ZT2p5bHRYOEdG?=
 =?utf-8?B?bXRqcnlCS0xaaVp3VlNNOTZJQitCcktUSXpRSno3dEIvUnNKRHVlOE0yaDAw?=
 =?utf-8?B?UFdWK1p5M29NcGpOWEhPQjZxL1h4QzBuVzh4bTUzTS9HQWF0Q094bzc1bTVE?=
 =?utf-8?B?YlpCVUcrWWExZXpiT2t2cFNXUHUzSk1YU0FTNFlVOWJvYU1QYmdiUjFTV2gr?=
 =?utf-8?B?ajZTT3pMWXZpaklUUFQyTVoweUxMRDg5S3ZDRFpRdGphdFVkQ1ZoWENXcndu?=
 =?utf-8?B?T3JlTForclRRckpKVWIxbGJ2OC9LNkhzTWttaGptU3htMW5ISEJXd3lmWjIz?=
 =?utf-8?B?cGpQTnlLcVB0U3NaeDZoTFpVc1BzR3VsaVlOaC9qbFkydldvOXZpdWlhV3Na?=
 =?utf-8?B?L0VoMU5jMEZ4aXVzK3RqYmZucE42ZDlIUm90L0dMOVBNNGp6aFVZUHFUWjl5?=
 =?utf-8?B?ZFc2OTRGWnUyZWR0aVJMN3VEaXBoRHZlN2F0cXcrNFkzYUhnU2RjRTFPMjFx?=
 =?utf-8?B?ODNuWDEwU3c3allQUWQ0NmlHZm1VRUJVc0gzeWl0Ni9oWHVBSlZPeDAvQkhR?=
 =?utf-8?B?ajA1Szc0U2FneWhKcWRwb00zREttM0o4c1dXUzlKc2JMTGZPellqY3hacng5?=
 =?utf-8?B?TWJDWHVEUkNPeVUvdEdyVksvR0c2SjU0NjkwZ1BNL0FBeHpOQndoS2cvcmhM?=
 =?utf-8?B?UjhTd0dmRG5SaDltMksrZVhySGZCcmprblNQQ0xzQXpsMGxmdCswYzJFWkpm?=
 =?utf-8?B?YmJvQy9DOWNteEtPL0dSQkRXTXZpdEdzRWlvTlAvaXJkbEVLcWsveHVIM2Vw?=
 =?utf-8?B?UXppYmtxWFNnZEo3RG9hRU5pTE5FNUY5QzA5SlZWU21qRThOejdiNDJvQlRU?=
 =?utf-8?B?WUFuUVphbHd6WWpRR2hsdXBnblo3T3J3ZS9yc2IzY0tTM1N6UVo0SjZhdWl4?=
 =?utf-8?B?b3BRVktqY05Na0lZa2JZZVBhM2RtSVg5QUhwUEpZcmhpeUI3K0trTTJUa2p3?=
 =?utf-8?B?djgwUGMxcTFwRXdyLytqSFd3R0RMVHpVSTVyODVma3pBNDRsU2FvSmxpYS9D?=
 =?utf-8?B?MVVUanR3S2pQL2VUbFJJc1ZJd3NtV2ExSnZiZXM4Wkd6SS82YjRjZHhadUpt?=
 =?utf-8?B?eXo5U1ZQMG5uMFpHcjN2Y1VtTVpDbzY4WldWbnhKMEFXMzY3TSttNWg0aFVh?=
 =?utf-8?B?clEwVFRPcTZOZUpPUzdQMU9Tcks0bFU4K1NWUVFpd3NOeUlQSE1NVXFYQnhT?=
 =?utf-8?B?Nm03Y3dtSy9SekxqTnltaHc3MkRmZHU2Z0pjZXNQZ0F3UHdRV3cyUE5ZRUpw?=
 =?utf-8?B?QkNoQ1FpaE5PTHQxd2Q2MDljRDIyVXI0NFVjU0dmMGZwTmJsOEl2TVJNdkdt?=
 =?utf-8?B?Z25hK2RjR2t2TVNMNHZsN3FQOE40OXU0VHlSL3lJVS8xRHUrU1FZem1Pci82?=
 =?utf-8?B?SVhJUWpYNEU3M3Q4d1EzcUZ3VzZMdEVqTFk2dThodnd0YkFtVFQwTU5IZk4v?=
 =?utf-8?B?L1JZM0FJMzFDYWsxUlYwR2tFZXJEaVZGdnB4b0dISmpVaDB6RlNCVjlOcjAw?=
 =?utf-8?B?WGlPcUZaSlF3b1NqdG0xUlZmTWlOWmthU3V3SkNxdGFIQ0M3UFNacXFaN1dP?=
 =?utf-8?B?ZlNjZVFYNVhDN1NFTWdiRkJXUGJmY0FXdnlhcjVPL2M2Vlg2RmhLbDNzNUdo?=
 =?utf-8?B?akFwVVhxbHM2dnEzK0x6M3NucVFjK0hGaTJ4d2pTLytMbHZLaDBDczhKZHpi?=
 =?utf-8?B?S2JvbnFNRG8rQzNxVHl1UWRKSUVUdmI5dUVneDN1bHJjbFo3eVVnN3JXN0xN?=
 =?utf-8?B?SHNwd29SelVmNytSR08rclpKUTZNNDcvQkJpNi9HRE9oN2x3Zi9BSGFoN2hQ?=
 =?utf-8?B?ZDd0eGpSRzVqVzRMY0E5c1R3SVJmcy9KZHhRMXhOMmd2NHdWci96V3FQSW9X?=
 =?utf-8?B?WW90VTV1Nm5YYVNOY1BpQ1A4OGFaWEs3UjZUd2tmS2dkd3pMYWVPdW1kZFEz?=
 =?utf-8?B?eUpHTG5Ya2ZSS25nN1RudnRMMDZpUGNoMm5UcllJeGlWa0RSVXlPWFFFMjV1?=
 =?utf-8?B?d3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cd3c19e-30aa-4e29-9504-08dde160feda
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 09:48:06.7190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9sGHE20S8QKmSy2KQn/8MMx2HPET/+sKWsLhS0rHLPmuRCcmXqmZ6nkak/b4u9oXfA1UyRVDoyO+BDzoouY0PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4124
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 22 Aug 2025 09:48:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19943

From: Jan Kiszka <jan.kiszka@siemens.com>

The buster snakeoil key expired basically during creation, and U-Boot
notices that the signature was done outside of its narrow validity
window. The bullseye key is lasting a century, thus not problematic. We
just can't switch amd64 targets over because the QEMU firmware contains
the original key (while not performing such validity window checks).

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

This was already broken for the previous U-Boot version - who knows how 
long in fact.

 .../secure-boot-snakeoil_0.2.bb               | 17 ---------------
 .../secure-boot-snakeoil_0.3.bb               | 21 +++++++++++++++++++
 2 files changed, 21 insertions(+), 17 deletions(-)
 delete mode 100644 recipes-devtools/secure-boot-secrets/secure-boot-snakeoil_0.2.bb
 create mode 100644 recipes-devtools/secure-boot-secrets/secure-boot-snakeoil_0.3.bb

diff --git a/recipes-devtools/secure-boot-secrets/secure-boot-snakeoil_0.2.bb b/recipes-devtools/secure-boot-secrets/secure-boot-snakeoil_0.2.bb
deleted file mode 100644
index a4469870..00000000
--- a/recipes-devtools/secure-boot-secrets/secure-boot-snakeoil_0.2.bb
+++ /dev/null
@@ -1,17 +0,0 @@
-#
-# CIP Core, generic profile
-#
-# Copyright (c) Siemens AG, 2022
-#
-# Authors:
-#  Jan Kiszka <jan.kiszka@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-require secure-boot-secrets.inc
-
-SB_KEY = "${BASE_DISTRO_CODENAME}/PkKek-1-snakeoil.key"
-SB_CERT = "${BASE_DISTRO_CODENAME}/PkKek-1-snakeoil.pem"
-
-DEBIAN_CONFLICTS = "secure-boot-key"
diff --git a/recipes-devtools/secure-boot-secrets/secure-boot-snakeoil_0.3.bb b/recipes-devtools/secure-boot-secrets/secure-boot-snakeoil_0.3.bb
new file mode 100644
index 00000000..a4195b4f
--- /dev/null
+++ b/recipes-devtools/secure-boot-secrets/secure-boot-snakeoil_0.3.bb
@@ -0,0 +1,21 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2022-2025
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+require secure-boot-secrets.inc
+
+SECRETS_DIR = "${BASE_DISTRO_CODENAME}"
+SECRETS_DIR:buster = "bullseye"
+SECRETS_DIR:buster:amd64 = "buster"
+
+SB_KEY = "${SECRETS_DIR}/PkKek-1-snakeoil.key"
+SB_CERT = "${SECRETS_DIR}/PkKek-1-snakeoil.pem"
+
+DEBIAN_CONFLICTS = "secure-boot-key"
-- 
2.43.0

