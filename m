Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E84D609A5
	for <webhook@archiver.kernel.org>; Wed, 27 Nov 2024 06:49:48 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.83])
 by mx.groups.io with SMTP id smtpd.web10.66332.1732690179447241100
 for <cip-dev@lists.cip-project.org>;
 Tue, 26 Nov 2024 22:49:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=bCSOzO2y;
 spf=pass (domain: siemens.com, ip: 40.107.21.83, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B1g/T5W21U83mmDwzUnhTJ+2Y6vxwNnRMBwOkHEsCSV1EfTe+laRbGGyILlRUYcPv5bx4CNlLKwqjZxI3sjCMrb57vgcb5BeMSgRaqd6eGNxh/aw6U5J41+AqA9dbtwEYJHEzWn4kxdsWmYIuRhmxmEo358ZZIbi3inXwrkpb0Au1spon9QtweqJegaGfQEwVpVC8kjDDWCqwvzTE1Di2kctZ4/qdNBgGHmQ3Ju+U36BOBuDSYpWkgNkkOBEEfZ7nrN+L3BTmH6oZykjP/xA4N0OzCNw708QBMjayBDpA/+PkbqUz7xTqJLF6yUNBSnS6Fj1v4/ksKEjl1JXDJMEKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/evXUOIX5pHIKbhA0lOTqhvb1WT/Tw7XemiVRTgvhqQ=;
 b=Cj35GNyT5aReUm0wBYmeJJnjWLJYOrI8fLxDq+3N13h9XE2q0+xfNOYp/pd5ERg6HEAZtlwpRVTNwSOSQWdy9pd4v7WaXrQtqTE86PXtL6B7HQ/E6aisUHiFOPsdOL/NSOZJ8GUEHed5eIwuHNdmtVNGKcGYwYg4Kgp8818rqg7J4nfSUWdydJl0WsS2VUXrLl23P8V39UWKSmFtIrErlvhk8nLOZC5m6iZa9iP0vm7sCmtPB+t+9UgDN3jfnC1eoAmTE/l9Zkp2OLYwtNAHRJGu9xHGrNS4m/zrLqpv+PeRHPDVjLTxr5B0SwH0zqXgKLmT5QowVSpgD2hV+dRSHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/evXUOIX5pHIKbhA0lOTqhvb1WT/Tw7XemiVRTgvhqQ=;
 b=bCSOzO2y/PRFEZsfxlQ/t7jXosHEu1OSWMomtg2IYr7gJimaRVrU59YmVel5kwwizjbNAGgACmZUPrt2/Sg4UZtphT2aERyzDkfqM3lSBXKPeO1ICIW3/+xDSRCbAjX5kngvekO1r+ElQfjze9XiBxEhQYzfjdkpY+6hBP1Rbh7ge94sdtdu+tmRr2OisHr4PdmmkXpips9JADxWTqiNbsTTBLwKzkIDnRfXBU/7isrvMb5pDJ6WjYqlRNW9HzmVSLTXhDW3DBYYEApnm0KcZQymMEeo+sPbwjLUnnUFppf0xrmSxzAXMMwC3jg2kDGjGzUcFXsD8pIEFe2mB1DQ8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6650.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:564::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.11; Wed, 27 Nov
 2024 06:49:35 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8207.009; Wed, 27 Nov 2024
 06:49:35 +0000
Message-ID: <14e07f5b-e464-4a7d-89d6-b53d5d7630b5@siemens.com>
Date: Wed, 27 Nov 2024 14:49:30 +0800
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Add lzop as build dependency when
 using CIP kernel configs
Content-Language: en-US
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0192.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6650:EE_
X-MS-Office365-Filtering-Correlation-Id: bc1491c0-1dd0-40ff-f373-08dd0eafa7ee
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Vk0vQnByakc5Kyt6ZnZjd2gxbG43TS9aeTluclZ4MjI0Qm9Da2VwVE5iQWRi?=
 =?utf-8?B?eUR3a29MZzZiSkd0ZVVNbm9CQ25jdGUzaDBUNVJpUEkveG9xMHNUQVJzek1U?=
 =?utf-8?B?VW1BL0JKeXdTR2NLRXgwMnF1dHZCOWYxRHFyTlQybGxLcW1KNFBZbFArU0E1?=
 =?utf-8?B?dVBHS2E3ZVg2SDNOeGp5a3NUVjI3YzVMUGkydkV5b2VZU0Z0NkpoUHoxNlBX?=
 =?utf-8?B?NUdMd2JDWE5WNXpZUHlEQkIyRm9tVXAyVkYvaS9Ma0VXN0VablRtY0VpQ051?=
 =?utf-8?B?azIyVC9WM1BsTStEUmRuQjlVWVhCZjN4YUhwL1RxSC9lOU1RQytsam9CcVF3?=
 =?utf-8?B?QUlsckd6Y2gzb2FkVzI3dDRtYUR5Um1XRkNBeHRHZHJPeXpFdDhLTGloZ3U5?=
 =?utf-8?B?ZnkvMTNMTE4xUURqVGRzc1JCR04yU0tvNGcxTkRjSDFmTzEvTFVxWUhrU1o4?=
 =?utf-8?B?VkZlTGpmMTNyVVhFZFVVbnBYb25OVG5aNWFXRWt6WlByaVlXeW04WGJlazI1?=
 =?utf-8?B?cUlOQUxTWjFaWFhMMVlFRGdtdlBQeVh2ZVlTMGo2K3NWa2hRSmxHZm5CeTdu?=
 =?utf-8?B?OWhFei9GVStQTmNMWm56TXRVK3ZOOGF5MVhDenBab0hVTHJXOVlKekJ3L1Nm?=
 =?utf-8?B?eXRqWmUvTlFIMW4xaXNMMUxkQ05OaHRPSDZpUitMdkdWS0Yyc1BWRkZxUjhq?=
 =?utf-8?B?UVpSUVY3c1FCQWNNS21ZcDlqMmI0OGQyeS9TeVNrOGFEelpUSlcwYlp1T0Zo?=
 =?utf-8?B?NG5zcXVuTkUxRkt0U1VZY24wZjZkZGtBcXNERndzYTc0Tlh2czRGWEpmZVpE?=
 =?utf-8?B?aTJ4amxKVWpxTzh4d1VhSXUzUmV3dXA0Zzl3WXNoRHUzdnFzQ21uUWZqU0FY?=
 =?utf-8?B?OU1KNFpYaG5qdC9CVENWcy9qNlp2VVF4bUM0enVvOHIvclB4WUtobFpoZ2ZV?=
 =?utf-8?B?OUJPc0o2dDErbzEwTktOMVViU0JLOGFxS3VyMnNRUkh5SDdxdm5LbEZGNDFK?=
 =?utf-8?B?QzkzUzlmMFBEUE56Y2ExWC90L0twL0RiZDU2Z25XNS9yNkI4Z1JyUmovOXpN?=
 =?utf-8?B?clJaV1NQNlBRWXNYT0xjdjdzeGFWTXZ3WGlTQnowa0tod21BT0JNZlhxUVNa?=
 =?utf-8?B?eHNJNlM2RXZNSHNXREdWQzNkUnBYTHY1NC9sQUdNTlpRaUExbTdzcURXQWY2?=
 =?utf-8?B?QzhDU3ZZcG5XLzJxVlcwaXA2ZDFPc0M3ZitKL2I4TFl3L1pWSitlR2kxQ3NP?=
 =?utf-8?B?aVhlUHJiS2EzcnI4WGhJMUZZMUZsdlV4NDZ4eVV2Y01KUTRXSE1Yd1BwcjZw?=
 =?utf-8?B?RUJ2Z21QN1k0ZmQybS9Wd0tPMEVJb2I4WXF3NjVtR203c05GbnpBeUVXeXp1?=
 =?utf-8?B?QkN4TllKU2pxbmF1aTdDeDlieVBlV2IwN3liUDZ6VWlubHJtczllS3BmenJB?=
 =?utf-8?B?OVRyT3cvSTdJdUU5OXJLSkd4ODE1dzNFb0I1TktpM0hNRVY2KzJHTEFweEw3?=
 =?utf-8?B?TEM3Y3RjTUQ1Ny84cEV4MUl2R1pHTDlrVmdUVTFBZkJWOFdUMzNwSTZmTStH?=
 =?utf-8?B?ZVdpOTVkVHdtNjg0K0p1blVINUIvUncrSjRvcm9GSU14YU5kK0ZzVXZqOFNw?=
 =?utf-8?B?bkUxdWNqdWRINHRiRzJxLzNkZUh2d1BjK0hJeFdFaURwWnhuVEFRWi9wUHlj?=
 =?utf-8?B?Ty9aRktod1MyMnFKMTdHR3VGOXNFQ0dqc2ZCKzBMdmZidVdnZTlFNTNlM05r?=
 =?utf-8?B?WVlJNmVMODRpWnZsWDArME03ZDZEOWI2VTZ0OWtqd1FWVUM3TWdDeUtFdGhF?=
 =?utf-8?Q?d+1724L3rrcF9bgmaBZC42yqz4emxAwRbVtKc=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZGpKRDVpMTFCUk1DaFRpUlVUWElrTk85d3FPMlVIL3ZwTlBkcjBDcGg4Wkwy?=
 =?utf-8?B?ZExKSk0vZURZOVNkYk5tcjRhZk90Y2dRY3N5R1U2TFpYcTVLK2owK0RMZkVj?=
 =?utf-8?B?N0orT2FYaTdldnRYM0xhVTJwd3E0QlBZNVlqelloYkdSVUZ6WmpnYm4rc1Nm?=
 =?utf-8?B?N1p1TUljallrSUtjWkxLTUlBSjE0MDl6TDVxRmVSdzY3KytpMU1lUllsOVV4?=
 =?utf-8?B?K0k3NGV0YnZGdVNhd2UzSnhTNnN4akd3Nmk0Wit2dVVhOThHT3llTmpTcTVa?=
 =?utf-8?B?QXMyakdiSFYrMktmdy82emh3elBMRUVSb1hzQVJYczVGSFJsa3UrWGd1akFa?=
 =?utf-8?B?cDN6elZabktvRmVLMkNtZFdGbG1sVWc0eWdpSE41MFFLUjNVZU1HTFo2Wmlh?=
 =?utf-8?B?L0ZnMDZHUk1Ua3NKc0JLU3dsWWxjUXZHam1OZmNaN1ROUWdPTytLSVhVbi9t?=
 =?utf-8?B?Z2xpc0VwbU1yZnpBUEZFbzhIRW5xRFpVR3FsTE81STVVTHNHN0lCcFA3aE5S?=
 =?utf-8?B?YkhuZDVLeE1ENVVnQk0vb1J2L01VWWVsb2VmZ3VoK1hYdHhRb1FwT2xMY0V5?=
 =?utf-8?B?b2NNMTVveW5oMDRkbG9ZRE1NL1RWWXJhSS9WUWtMWUZRd0RMYStKdHczQ3R2?=
 =?utf-8?B?ckpwcGZ3djJ2S29Xd1hMeWxTcW8yVkRPUVBFb1dRTnFyb0hlKzV2c1krNUNj?=
 =?utf-8?B?VGF5a3RwZTBwT3JBeUlMSTl3SVRYTnVHbzVZRGRPaGVkNHpsZUZCUWd4Z1kr?=
 =?utf-8?B?ZktsUDFxTzVsSThJYlJaK1RRM3M3NTRJVWxPeVMvbjRJa3VYM3I3V2pET0Jt?=
 =?utf-8?B?bXQ5QlJpeGdkR0YxYW9ud3lQU2d1QktIYXpBajFiVHBZdjZyWDFIRk1IY3I1?=
 =?utf-8?B?UWZzWmQvZk5qcjlHaGpJYlhaYzlFYmdVY3hvVFlYbS9CT3d2YnNHYlZ3dm1r?=
 =?utf-8?B?dVAwTUFUWDRjWUd0NWFMRlhQVWdPSldXNjhtRkRvdUgzMGFpZkQxdlR1T2Rl?=
 =?utf-8?B?aGk0NDYyVXhDbmdzZnphdENLNkM0bDhGU29mS1hLOXY0dEpGUkJ2VG1zUFcr?=
 =?utf-8?B?UHFPUk03STdtVEtyTk1VUHlsQ0R5QXJIVkE2cGx2clRIaHovS1oxYzlHejdk?=
 =?utf-8?B?Yjd6eUxzQUpJY3psbEN6OVJiZkJ2NnlFVkJCclVwUUlzZVRyN0IrdXpyK0Nj?=
 =?utf-8?B?cERjWk1qNEc2QldqVE1WSkJEcWJVQXZjZlpjMGd1ZW4vUkpCb3djd2lwZFJW?=
 =?utf-8?B?eW1vdGs2VnpOdm1yRmlzLzJWNzZ2Wlo0cmZkdDQrUjlXVjRHSW53NFJKSXJK?=
 =?utf-8?B?S2QwZ2tJM0YvRXBlYU9MbVJLQmNyUUp6VFRDZmZHWDQybC8wQUlkQk9RTGtJ?=
 =?utf-8?B?eS83bzVIVXdkRkg5cWtNVmsrSTZsVDk2Qm94YmJkY0tlZU53NWMxNFRhQzAr?=
 =?utf-8?B?TEdLbm5WQmUxRzgrRTU3MmJqeUpnc3dIN0h4RkVTY2VqUFdZZnRkb29Jcnkv?=
 =?utf-8?B?OGlPOStxeEUrUHFUVnNiaGUyNDA1NTIzRXhJQ3hzL3lWTC9wUkxxQXpMUzJi?=
 =?utf-8?B?aytxWDR0aTBYSzlsNEFXZU83MlJxVUUxQnltNHFwUWRMU0k3TkRiUmlIQUhk?=
 =?utf-8?B?Rm5SN2p1LzltYXY5WWswL3JnWDFsVUFRUjg4RUt4cVZqc2JHdTdrRFRBYWU5?=
 =?utf-8?B?UE1XdnpRYjd5czJ5aVVDazdlSFhOdXp3VFdnQitOdW1FaWFVM09WUUFSZXo2?=
 =?utf-8?B?TmNxVWM5RFE0cEtTVG41OEVBdm9TY09qbVZ4YVdvTGhqMnpaSzJ3RXI0Ymtl?=
 =?utf-8?B?cVBsR1JqaHYwVzBXbElqSzRSU2ZUNVp4RGw1ZXhKd3FsK3Y0eFlFRFNMekdJ?=
 =?utf-8?B?UTRJRHpVbmRvb2NhbGhyV3pEQ25xMTloQzlMeCs5MGlFQ0Q2bFAzV1hONndk?=
 =?utf-8?B?NE1sVURGZUxEME9PN2NNRzBNWW5sMW5oWDRFTEhUS0cxQm4yZXFEMFcwSldj?=
 =?utf-8?B?RGRkdnQ0UmEyVFJOb1NjS2tUa0t3U0lySnJhalh5VjFYbGhDcnNMbG5ma25Q?=
 =?utf-8?B?ZXQzWVF3TWJrWkwxR21HWjdxN0E4c0M2VDVjNnl1ZmRMZ1lzMHc3T3hOMXZX?=
 =?utf-8?Q?ptLccWPXVYuYUm63kv2ibUtRQ?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc1491c0-1dd0-40ff-f373-08dd0eafa7ee
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 06:49:35.7200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GUhLnIArGBgIJt3uBxdcKJ/CYNo0Se8EOHBukBMXVtxUTV2LF8J+dfjxbBwFPEZAXWovskWenfKh14Ee0x+xDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6650
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Nov 2024 06:49:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17284

From: Jan Kiszka <jan.kiszka@siemens.com>

This will be needed for the merged ARM config soon.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Need to make https://patchwork.kernel.org/project/cip-dev/list/?series=912556 work.

 recipes-kernel/linux/cip-kernel-config.inc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-kernel/linux/cip-kernel-config.inc b/recipes-kernel/linux/cip-kernel-config.inc
index 16821319..c8902cc8 100644
--- a/recipes-kernel/linux/cip-kernel-config.inc
+++ b/recipes-kernel/linux/cip-kernel-config.inc
@@ -17,3 +17,5 @@ SRC_URI:append = " ${@ \
 SRCREV_cip-kernel-config ?= "9b1b425c87248ba476e3a3aff3c9f905abdb3982"
 
 do_fetch[vardeps] += "SRCREV_cip-kernel-config"
+
+KBUILD_DEPENDS:append = "${@', lzop' if d.getVar('USE_CIP_KERNEL_CONFIG') == '1' else ''}"
-- 
2.43.0

