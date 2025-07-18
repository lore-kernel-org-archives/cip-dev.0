Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF1AC83F17
	for <webhook@archiver.kernel.org>; Fri, 18 Jul 2025 14:47:43 +0000 (UTC)
Received: from AS8PR03CU001.outbound.protection.outlook.com (AS8PR03CU001.outbound.protection.outlook.com [52.101.71.42])
 by mx.groups.io with SMTP id smtpd.web11.526.1752850058005146203
 for <cip-dev@lists.cip-project.org>;
 Fri, 18 Jul 2025 07:47:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=UJ93Fkw1;
 spf=pass (domain: siemens.com, ip: 52.101.71.42, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eYZCpCB9b8Ioh2MJ/VglAwkdjR4hybnXedxqfbQlRAvBDYmpVRaMVTE95ftwbQ6ZRjs101et0ewXvMMjBpZIJ7dQprktSOygFuctKJ8c6XsmZqdsMFVKBWt2LeEYYVfv+gBD062P0VB7aX3yXKG8LytcSAEgeJTw2ELMVRMcs6p3YsvL8akAgBHVIyO85CtC8SlirZF8YeyprliqukVmcvbpNRbOXw51CMgGgEAimTJuJfbYIF3gV3EYeu8mqRPXdaxt2h1koKd9bzKjtMO7fAkxL/Ghsmx/0zD0CVNx3kXQSSj/kGReZ9PAP3WN/r5pt3HqVOSAGEutuqpa3GCCMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hANV3vnahXAj4558v32WWXOBdi15O8XxmVfPmYRp69A=;
 b=HUXlrsoNIOnbgzxXCKUXGP4AMWtF8oJo2ZPPQMT6nAh5Mna5iyt+FJGahkDzTFv32WFQPslLUny9YevkDvx6d8z9itNB7SwsutS/9CASaONy9VwgGjkViuiz5QVhy/XW11PcGZDpmYVhwXwPQ4nW3RGMKcHEhRU+r/TsMsUY1VCLEJIqM8cWvZDFfHEl4lmKYrSraERfN3o4bomYUzrh3xW/DGEmR7IVF0bFM5VAaU4QMo3FHVQnrLrjqyCyyfzIiSszg8gJ37egj4X6/Ks3rYsvmtOCMq77nAHO0roFK66fF6HG3szfu2YeDxqIh9JChMBAbWOackjfbBB2dc7Twg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hANV3vnahXAj4558v32WWXOBdi15O8XxmVfPmYRp69A=;
 b=UJ93Fkw1EDgfV2uQc4hnmjKt/urGTK5/PrlMuThgJ854jYnmu8GZOEX+kw/batuwhlT8owAMh9/oTVHXDGLBY2mn8A0okATBXRUHuFcPOO7+KCEX/vN4XTN5q7uoiD7LfUi5ei/JFue+GEm3vKZzcLDCN28asCAez4Nx23fwizrJdciA1di1hVqwHyqL5OD2W02epFgyReOJ8W4ja2RedNHAQrRcVghjB34ovWxBzMJ4iUyW/nUWDsLStzVAIoMt/jnbMuIJ/gb8zVdLLY6BVstUtICqtWLbcGEf54GiUrGMrCgkRAeEGYCeNvJoaveLLtGJRUjRfj5M6Z97Dwrjhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7932.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:304::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.25; Fri, 18 Jul
 2025 14:47:34 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 14:47:34 +0000
Message-ID: <7788148b-538e-4f28-bdee-3c975dfec812@siemens.com>
Date: Fri, 18 Jul 2025 16:47:32 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 5.10.239-cip62-rt27
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P250CA0008.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:102:57::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7932:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c4e80ff-dd0b-4fe5-1d09-08ddc60a080e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dVdwSjBleVl5Skh4TmlKWkkxbkcvK2ovZlVUVHZuUHdUempLZ1dvTVFWMHl1?=
 =?utf-8?B?SlU1M0dIY0RGYWh4RmVYOVVWcGUwS0cyMVVyRHVQU1hNM1YycDVBVElmVUh1?=
 =?utf-8?B?TTZrNCtJRit6VVAxTDBQK2I4VkpKK01wdGRyZmtyeHRRcC9rNnZBVERPcEg1?=
 =?utf-8?B?OWVGdnV3eXdtRHBteTgvYXVGSTFCVTRpWWZrbUJnNnJ2TW11MW5jMDJicWhj?=
 =?utf-8?B?aS81S2tDQ0IrbVZRaHZnZkE4aFYwblVEa09OSjNNamdTS1JSVC9SaDNrVjlh?=
 =?utf-8?B?d2Y5Q1JKNXMxclZQZFZrV21IYUE5WXRLaEZrRFV4OE5yTGREMHFOeFJJaHBw?=
 =?utf-8?B?d1ZtZUhEK214ZmM2M3hXR0p0eXVJMUhFdFZuKzZQOE9tbVU5eGFFeGtkWGVt?=
 =?utf-8?B?VkVDTWRubytKM2lWVW1qM0NRNXdqMVNWb3JEeXgyMjZpc24zelpNU1owcGlE?=
 =?utf-8?B?YVJQN2FKUlhSQ0g1L0hjL3libkdIb295d1d0VTFOVXltMGFQWngrOHhsVSt0?=
 =?utf-8?B?Vkd4enlhaHVjaGlnb2k4QWFodHdJRkJuUXlKOUpnWHRJN1FXa2J0YjFrdG0v?=
 =?utf-8?B?OXhmeEo3WncxNmNha0pqRGtrY2xPMk9sYjRZdHhTakMzQTBOc2pFYUloa3R3?=
 =?utf-8?B?aFJKcEtoTVp5Vkp1RDhiT0k0T3pEK0Z5N0w3VnVnNHRmdDF2alIzQzZITEh6?=
 =?utf-8?B?MEFOeFJrVkFJZGNoZHorUzNETnFYeEFNTnNrL3hzaS9vQnJOSjJsZFMrSG51?=
 =?utf-8?B?b2t3YndsVkJaVmhsWWZNdDVrSFcyMTk2OUd2MW9VL1FyblpBa0ZMdWlLMk1i?=
 =?utf-8?B?RytIcXc1QzlScnI1KzlucXo0UTg0NHpwcU9uUHhwR2pZdVJDaWNBVExxNitE?=
 =?utf-8?B?YWhCdnlqbWJsMU01Q2FLdmtJbkU2dFUvTnIzT3RoUzc0aGFzdXBic1ZQbjJH?=
 =?utf-8?B?M0UrdHJmK2RvOUgyNG95ZERlRzU1ZTZrTUsvSURZZVBKd2VSdVhyVmpSSmFD?=
 =?utf-8?B?QVlGbnVtNmljZmxOSnBXalhGaWQxcVUrMk5vRjlGOFdoMXluamlBY3d3dmpk?=
 =?utf-8?B?RTF2c2tIRVo0cFR5SGJCK1JMdVlkcEhEOXpTTjcwaVArdHZSUGxPMEhKaUUy?=
 =?utf-8?B?ZWZGbnhIL0dGeWNjRWdDZnJha1UvVkZqRHppa1FFbVUyZVBka2NqNkFSM3M1?=
 =?utf-8?B?NkxBOXBIYVZtbHQwaDFKOThiYWkzOUc0ZmFKbTVjb20zZlpsR2pNWUtIN0Iy?=
 =?utf-8?B?TjduYnJ6S2VJM3ZFZVpjZmhjbDlnNjJjRFJzL05aVFA0T2Jxekh0Tkl4dHBk?=
 =?utf-8?B?REFwVU9XZEM0a2NUVmVhaDlGaXJLeENVRXZCL2JIYmZuRnhNWGgveUhKSHhN?=
 =?utf-8?B?SzZLU25Sc2dHaHUzSUFTS3VDcE51S2NVbFB5bFNLMTJjWDhRYzZTYnpIYmRV?=
 =?utf-8?B?SjlEZEFMa3IvK3gwT0xUU25nSEZ4SXEzZjRPL2plNzkwcjErMXhiL3RpRUgz?=
 =?utf-8?B?SDgvTVUwcGVTblhLdlBvczQzSUhnb3hmRWJZTkx1S2JNNUR0ZFdVUnlUNkRV?=
 =?utf-8?B?ZVU3cnZDN3JrWVpQaTVBQXZsd1YyN2lINTBNcWtMK0VOTzNOdENMeElMVjV0?=
 =?utf-8?B?VGxvUGI3VG91VUZCUFcyR01oUGRjd0ZwQzA2SVFIbVZmdUNIZmNoTTB3UTli?=
 =?utf-8?B?V3BDemp0b3h4OW00RmFGK3U3MEZyeDBJN0hPUTlTT2FNM3RYZzdUbUd0QlNq?=
 =?utf-8?B?S041aHVyZ0RtcHphUDBXTEVzSXhabGZ6SnZmeUpmelpGSTBFbmw4QXVya0tS?=
 =?utf-8?B?WFhMand4ZEZ6cml2ZkZsbzJUM01WelRYc1dIRUdZL0Z0QjFDcHdjMEkvTWtx?=
 =?utf-8?B?d3pCR0lOeHdmazdScUsvYkNvSTR3MWx4bHAyd3BjazEyd2c9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZWRGbm5IV2E2OEhONlozUVd0cXdJNHhPSkdvNjdMUGZmNUV0NytmTTJYekVs?=
 =?utf-8?B?aFFWdXJacC9mQnVDRHhjazR2WGhxc1VwZWtZR3pPejZMSHVIL3U0c3lUL0dN?=
 =?utf-8?B?TzNsMXptTENJYXd5R2RtWTF6RUU0MDhjUTdwaCtwa0p4azg3K3NaUjBFOWc4?=
 =?utf-8?B?bkt3SG9GSEh5aXFtRHM4K0lYSDFsMVpEaUNzZE1VY3pzWUpNK0h1aTJmTDRY?=
 =?utf-8?B?cEpEUVBWUmxMRDh6bHN4RDR4VERRNXArVkgvdHJxaVFLbm51NzhhYkFwWElQ?=
 =?utf-8?B?OXYrajloV3IvaHlock9yZU9UZVdEb01hdjkzZWNIUmZ1OVgwdXlwZGRQbE9u?=
 =?utf-8?B?eFZxQ0lTV2J6bW0veDdTYnlNVjlhcWpJWjhsaUNyMG1seXFMZXdvbEJuOFQv?=
 =?utf-8?B?WVZmenhDOWVHU0h5SmhzQWdHNko0a0pla2lPMVJQREdibkFYL1F1TG50Rzlh?=
 =?utf-8?B?U2QyelI2cEhTZ2I2aDYyV09XMGFkS3lpMFpQd1hYaWdrbVdWdStFZ3VCVTB4?=
 =?utf-8?B?UFhRWEtuaDZIMjdWNU5wVkdmdTB1Q2FEd0FZYjBtZ29qM3BMbkE4VlhmR1N6?=
 =?utf-8?B?UjVNaVlISGd6VEtpWjdlZkszcTBXOWhNVDBYVkFzVTFPRHpscmhwZVA0aEhv?=
 =?utf-8?B?ZTdobmpXOGp4WUdKZU52NytESDJsdm9tcXN5bmZ0WmVjNHRzWTFOdnZDVXBQ?=
 =?utf-8?B?ZndaOTA4b2I1OWJSbjh4Y29WdG1QVms1NUF5dkZWKzhqc0tKS09Jai81ZTVm?=
 =?utf-8?B?VzN5QThXMWpOVko2UnYycUlEYWRyckt4OHR3VWNoUGtITWRub3R1V0Y3Y1pm?=
 =?utf-8?B?OUtZM2ZxOWdjQ0liMnFTaUtNVk82b2JYMGYzTFc5UmZWeWprSzIrZDB1b2g2?=
 =?utf-8?B?K09SNFRrRTdoUVlocU1OT0NJc0dwb0o0L1hSbzJCSytheUF5bXFTNGRPYk9H?=
 =?utf-8?B?WXV1djZGNTJWeERWR3dvYm1SMEZnOUtreWcrSnJza25FNVpwMXBHd25LTFJx?=
 =?utf-8?B?MFpRSHAxV1ZENHhIK2ZpejhXcFBtak9ubTNBc2NHbGNxTzBJNHVoTWorNzF5?=
 =?utf-8?B?RUk3QzI3b0NXY3hySERFT3o5cTNCSG1DUmpmUzErZE1wOGtGSHVmRk9uWnEz?=
 =?utf-8?B?cXlDQkhQR1lRaXk3UHlHTGZBdythdTdQV04rQ3JBdXFrTlJuWm1jN1FKbkgy?=
 =?utf-8?B?M3JvdHVwYzYxako0dVR1QTJSa0E4TUFHbXlDYng0RzhjZE9mQUhoQTFrdm91?=
 =?utf-8?B?TTJmM1pvZGQ0d1JKcXhaSk9EeWVodFdpQW05SVRaSVlhQVA0ZnZjL2QxTkU0?=
 =?utf-8?B?N2U2ZFNQU1JOTnlTRGsvVjZreU5zKy9uZWcrYmdJaUJXUXpXY2J0MmFweENN?=
 =?utf-8?B?eTl4VmdWc1N4TGVRNmhZUUFjMSt5aDRJVE1IQXJCaVEvdlJ5YmU2Z3AzZnhL?=
 =?utf-8?B?NmZROFhJV3hmSHYxMEdxbENsV0R3TjBacEw5QnE1S0JxN1ZpQ1pGbXdJQTlR?=
 =?utf-8?B?VEJQRnRPOTY3NzZPVVcyRVk2YzVFSlNSdm12NFVtQnd1bnVZNmo1aUwvdTZ1?=
 =?utf-8?B?YjBzQVkzb3o4aGNOaTZRejIvWWJ3Vmc3ZTl3cmFlbVNaZjkyZG13aXQ3bUc5?=
 =?utf-8?B?MlFMODZlaEVZUG50VWVTaDFka3Uya0ZjRXJ3L3FqNEtJaHJYR28wc01ONXVR?=
 =?utf-8?B?d3cvazZoeXFFQk1SVVBSYTRJUjJYNklQenVnc1Bjam01WnVwL2x2c2R0Qmlu?=
 =?utf-8?B?dkpESm5rclVPNWl3enRUS3Q4RnUvcUxQNUlwR2ZaZGhSNmVZcjRUaUZxcE5S?=
 =?utf-8?B?eUpHTFR5ckxwbUZJSTdwTFFzSFAzYVAyNkZVRDdZN2hma2FQUVpkTzc3ajla?=
 =?utf-8?B?WmlYcTd4L2krVnFHQk9oNkdmQXpQUXpRSXd6TlZwR0JqSDZTVzg2eHNiWWdB?=
 =?utf-8?B?cHVMODhzczZIK1VBWE12ZUdSeEtLSnFselhFTXBUWWZCZVZxYVJkZEQwZlRm?=
 =?utf-8?B?dXNRV2VId0g0U3pKQXFiV2ZnSHhRaGNBbXRXdDlPdnFFaVN0anJsUE93bGp2?=
 =?utf-8?B?S09qajY2U01tZkMwR0d1M08wQm9ZSHF3OGZvTkhqWklsb1NqZkVWd3lrcmhn?=
 =?utf-8?B?RDRmejgrcndDOFJXNHR5Uk1LMGN1bk56NlBHdXp6WURDQTZVS0ZyaitoNkpk?=
 =?utf-8?B?cVdLSWpYRy8zUlA2NGtzdjBlMFNzcERMOVhYSWxCanJCMUNhRlZZTytJaXJD?=
 =?utf-8?B?bUREczV2SWN5VjFNRC9rcDFPTWx3PT0=?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c4e80ff-dd0b-4fe5-1d09-08ddc60a080e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 14:47:34.4950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kyE0JhUycdGtCRK6QydO7LfEWuyTXd94lCM6NSYn3d8gSmJ8Et32ymUVVg4iQ6o8fMAmxpCWztfCBozgExgLxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7932
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 18 Jul 2025 14:47:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19568

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...10.237-cip60-rt26.bb => linux-cip-rt_5.10.239-cip62-rt27.bb} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename recipes-kernel/linux/{linux-cip-rt_5.10.237-cip60-rt26.bb => linux-cip-rt_5.10.239-cip62-rt27.bb} (68%)

diff --git a/recipes-kernel/linux/linux-cip-rt_5.10.237-cip60-rt26.bb b/recipes-kernel/linux/linux-cip-rt_5.10.239-cip62-rt27.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip-rt_5.10.237-cip60-rt26.bb
rename to recipes-kernel/linux/linux-cip-rt_5.10.239-cip62-rt27.bb
index 8edf6e85..521dd4da 100644
--- a/recipes-kernel/linux/linux-cip-rt_5.10.237-cip60-rt26.bb
+++ b/recipes-kernel/linux/linux-cip-rt_5.10.239-cip62-rt27.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "e2d8fae539c6429e1680b9875b6b6c16792ee20a85d47b6f8c8227ef679c9886"
+SRC_URI[sha256sum] = "72a79a744898d774fe4f5235345b70595c97fce31f7482a2d35fca9549e6303d"
-- 
2.43.0

