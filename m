Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3FDC04FFE
	for <webhook@archiver.kernel.org>; Fri, 17 May 2024 16:21:45 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.61])
 by mx.groups.io with SMTP id smtpd.web11.198.1715962901524548671
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 May 2024 09:21:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=QpPnlSGR;
 spf=pass (domain: siemens.com, ip: 40.107.104.61, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q2u3ieCk0uL9VsGAsyvEzH/LlCBrRZ5Q7QQ4MDxul1W0RxrJEPg68GVdMU+pfie6M0zMMuSDv71nys6swn1VDzKKBp0yV6lR/ai4FEM8v4viKk24ldGaSWje3+ZXyfcK799+UgAJjNRKgHeZlATWunqzKQiBbV1+78VlfZ04ChlKYX65mM7flsEV8okgK4V64Op9aeALwkG19uKEWgM8N9naCb1zWl76tBAnvZmJMJJsNsdQguc7Tssv5m9KASE4eRsMSSr+QAMRjTBNDcxo3Vh7KiNWaHVXfPxNT5kprzmoQy3lacwOHfVvRXMZ+fpQ1ycPC3PDEhOchih2fLH6FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vxvgs2k81zivWXTEz46n1m2szfCqYuuP3PrxpzIWKxM=;
 b=PYsHXQT9IKHwD1gQT9JDBpNohpsaix0tWue2enggXBL511GUf2L4p5COgDLwRRmCqmcBdbjDE4wOsc71MF4NRy61CRZHuU5Y8xcRPmHR7nbY9syCimZIy26KsK2CSjtEO/P1xSYl7F/Tk85mSFYqbxEtSlBrp2967sqj5H6UPqlFhG8z+bqfTqVW/RiTf0LTteavGGuknQ0tyaQXMRXnwVkXvQK2uMKnvZHC6wApryxyJ8SY+Ny4JdTmzpukTyoyPsjHZ9WQiGNWlXOT4qHQkz8coYWtFdaZ8BYUS4tjcJowYAqXeFZWgNnS5aE6zNaFWPaDzcm9nLGWLbRgxyGfrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vxvgs2k81zivWXTEz46n1m2szfCqYuuP3PrxpzIWKxM=;
 b=QpPnlSGRTAvHzXK28NV/gmQwPEQVDa3q4zywZAfFbnnelcZnEkTkT2TbXTzAdfUzi1Jqokhl+G/6dJXYhEg+CpYJm2eJUrev+oB3yM/nNGrKYpahdelzkEpxq5Drw8Ee1D8W0eLEUW6GFoTGoUqYC9cFJmkoJ2Z9KDDDi7bQvfQTAu+QpBLt0xxvKX15SQ16mR9ab2ufvMqvdVEO3Hc/jp2rTLXGmApS8HaPBhibZ2ac6MV7LAFju761JJmtfis4JwFkj5rZBhYmMRxGvX+NGZnoWrBWqBhJjGL145HVN3SvNaGspCi2+RJnGr7B5JZZMbrna7wquAfAb1RjG6DZOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB7754.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1c9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Fri, 17 May
 2024 16:21:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7587.026; Fri, 17 May 2024
 16:21:38 +0000
Message-ID: <1b97327d-d18a-4986-a2bb-339920671ebb@siemens.com>
Date: Fri, 17 May 2024 18:21:34 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] kconfig: Express dependencies on SWUpdate
Content-Language: en-US
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0388.namprd03.prod.outlook.com
 (2603:10b6:610:119::30) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB7754:EE_
X-MS-Office365-Filtering-Correlation-Id: ebbdf3a1-d624-4fff-a088-08dc768d6dd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?eHczRmd2QXNwY2VsZklpaXdIcmd1aDM1bGF6dk9lUnNWakFaT0xrZ2RobzZp?=
 =?utf-8?B?SlZzYVMxSElMSjlyM0R1L2hnTHFNREsvbWRwTVF2Y0lDZU16WCtuWEtvS2Uw?=
 =?utf-8?B?ZXVmTmNYa0tHT2RYZUc4VXZIVGNpc0tibWNWUndYU0dzQ1dQZFhuODM2YlZy?=
 =?utf-8?B?L25RNG8yVndTQit4S2VKeFVTM0lxS1dvQVNuVFplYlRIV0Rvdyt4ekEvcldB?=
 =?utf-8?B?UHVScExmcklVQmpLcUFKeHI2QWxRSmcwdkdFOEVxRmJReXc0RHhFRXhrNE4x?=
 =?utf-8?B?eGhCa2FVekZVQ1JSeWJpRjR4M3hPMmt5US85VWp3ZCtNUWo1V3pYaEo4M1Vo?=
 =?utf-8?B?WnE2YWwzS2RlTUp0ZXVOTVlpR3M4N3lJMEVDd1NwdkVLa3ZGZWFrNk5rWkN0?=
 =?utf-8?B?ME5hNHQ3VUVjeTdub3QwaGlpSXlkZndFT3hiYVF1c2tWNWJmWGZWNWg4VFlD?=
 =?utf-8?B?Sm0vWHY1L2dJbUVoa1N0dFdOOFRKNE1ndXZKT3RrQ2YyNXNKamRPTmFKZzg2?=
 =?utf-8?B?Q1A2YkgrTjkzb2JuOTZlYWtQMU5BYVlIK1FSekhpZDdIbUdRYkNqQlpRLzVk?=
 =?utf-8?B?ZWk4b0VKN3RGa1N2alNyb203bDNjZXlRQmdoMk5MRytBZFNySUlMMnBHRWoz?=
 =?utf-8?B?aG5NaE4rU1dwdFhBZXg0L0wxQVl4OGtvdjFOVlFTeHJBUWticnFWT0ZzTCt6?=
 =?utf-8?B?cHd3alBpajhSdG9nWTA4WUhSdlAxMEdEMUNNSHp1RjVmOVRnV3FHWVhOZ2ht?=
 =?utf-8?B?VndvV0VYcCtsWFNySDN0VHdYcHRYeEFWSzFEeXJkR284VktnVVBqMDVIZWEr?=
 =?utf-8?B?UjRaZUFXaFJmcGtiVUF0SE1qNUxnajl1QTNXQTJOaGR3YzkxdGpnNHRBMXhD?=
 =?utf-8?B?ZVk3cHdRM21mTnBkTEg1OFVDME9xUllhUlR3b3lNVGpaT2Q4UlNCaElROGtD?=
 =?utf-8?B?bDROdmRhTnozQXMyVXdwLzZLV2R2QXVXZHdvNTBiV2J2d25Tdnp2N2ZHbkpG?=
 =?utf-8?B?Vk1EejN4SmJVcHNleFlncVdpS1kvamozOHVVS3RjSzVuTzVzYlU2VzB4K1ZX?=
 =?utf-8?B?LzlscDhhYkQwbHZSREJSaU1MUy9QNXhBbURYMmZXTkZTekxTY0IyellxWVN2?=
 =?utf-8?B?NkpIQVg3czNHUkorbHY2alFnb3IrNXl0QXhtYjd2cldaREo2R0FVZG9Vcklt?=
 =?utf-8?B?QW5HcVZCQXBlNUk1YlVOK0R0V3gvYlVtZWtCNU1QZmhEMDg1YVpLVm53dmd5?=
 =?utf-8?B?ektieHJkZ1J2cU5XU1FHVWRaeGF6SWdiT1B3bWZmYStrY2RISnc1OXZKYzdK?=
 =?utf-8?B?MXVpYUtzWjdvVWRYYXdRaXpOSWxqNGNpckY2UlBqSlhtcFUxdHRyTEdmUFll?=
 =?utf-8?B?Y1owam1ZOWpwQjFlcEppbnpTL3BQSUNyRi9EekRTaWswKzFOZ0l4ZVVWTmhD?=
 =?utf-8?B?VmpGbGhCMjN3VDN6QTdVTUNQV0NOdW5kZTAyVnR5Z0orKzNQZlJjWUE1cUZS?=
 =?utf-8?B?Sjc2WXI5WnQzaDhGSUIzSnhlNVVvbUNKR3ZXa1BHd2RicHludXJWL1E4OVkv?=
 =?utf-8?B?dk9za2FBSGxSK2xtbHJLbUdKdFg1dU54WEtwNEtqUEgyK1IwR3ZwaFdnaE1Z?=
 =?utf-8?B?ZW9nV0lRdlc2ZVIrRVY0azJGc2thbkF2T2J2ZlM4clhOSVAya254VFpVMEVD?=
 =?utf-8?B?dlprMllGaVFQKy84bTJiQnJEZDhkUlJzbVN3Y3crK0g1eDF2L0hWbG9nPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?V2sxMmtkWGJxRzd1VDA2TkJBVUNiNHVsNmxhOS95ZXpXRVE3dStBRUI0VEM1?=
 =?utf-8?B?aDk2aWE5RER1a1htYnlSM1hJaDVVQmYvajBXY1lRR0hkdjNVNkwvUE41S0Jq?=
 =?utf-8?B?WEhHNWZyOEx0TE00YXB2YkFxTGJ1TEZOUTB5NVpoUzI0TWNtdXNvdEU2MnNR?=
 =?utf-8?B?QlZzRnpDNzdvczBnNDgzb3FLUElRd1JvWlE0WkhhQVhsT29oVVVNdjVVRUNy?=
 =?utf-8?B?am9Pd3l5ZHIrK0FwWm40WUQ5akdDU1ArZFE2WW5oeDRybnhoeE9qNnlSOENI?=
 =?utf-8?B?R0MxRlhZVHhpY2Y1OVdTaVllWWViQjdTVEl2TlVidnhzc1U2R2dybXg5RHNl?=
 =?utf-8?B?M1V6T2NFTVhoQ1h6bHJUVjB5VXV3dmo1MjlZU2N3RFdJSEVpbVJCQng5NFRW?=
 =?utf-8?B?UHVUTDRrQmdTN0pWWHptV1FnWjFKR2Evb0lhQklFd1k3bW92Mk9lenlGSUlC?=
 =?utf-8?B?cEZPKzZBS0orMTIvMm9DalZYSFFJcnNoUWpPTGozRXlHais3ekx6aTZEaU9V?=
 =?utf-8?B?M3lSQUFRMkdwbmZmMm9TbGRkcDU5aWUrSThNTEg2SDlqRGlEcTRQN29MK1hO?=
 =?utf-8?B?REZuZW9CRWV6WlBrazlobFVWUTVDV2ljVy9pYXJPZ1pvRWhNd1NNaUpBSzI4?=
 =?utf-8?B?am42dk9veXc5ZG16SC8xRHJmWGJwQWtxS1BLNGdEOGsvODNZTGFrZ3NVbjcx?=
 =?utf-8?B?Z1ZnbFRuNTlSU1NDOWpneUpZUXBCUktzYSsybmxTSkZ5T2ZoSkxnakM5R2ZD?=
 =?utf-8?B?QWp0V0FTcjhVRWlPaGY0QXU1bjZpL1N0QStuenJQM2JacXlJM2puZkh5VElp?=
 =?utf-8?B?UnVVMVFZS2FMZWd2dkNIU29PY0YvME5jQmtYSnQ1Y1Y3M1pRL3NnSmtYeFA0?=
 =?utf-8?B?UVM4L1hoV01DWklQRkpJL2E2R0N1cnhCbXpUcitSa2dMbEhVTHBPeXhkZEk4?=
 =?utf-8?B?SmE4RlV2MEE1LzlzQ2JzY3h5QmpETkVmWjZUM2F2ZUlTVDVsMzdMaWdTMERC?=
 =?utf-8?B?NXlDV2dSL3BEZ0JwdFkyai95bERxcGo5RlNNdFdTL09FOEhpOGlBYXVWUG1L?=
 =?utf-8?B?aWVOcFJzTHFMWkQrOHhsVHNscXUyRGxQdGdYbk5hNTlWK3pRYk9BcGw5NGlK?=
 =?utf-8?B?MU1ZSWRpaGVtMDIrbnJCVVp1STJ1NEVJRHI4d0VJTi9peHU0U2x4ckFSNXkx?=
 =?utf-8?B?U2kzR1p2NXFLdnR6MllVYkx6eGZBbzhHd1ZuMEJHemlsYjUyQ3daTDZBRXNS?=
 =?utf-8?B?T05qeFNzbXdWaTUrdDN4ZVYya1BmeDNROHRGRzN6QUZwQ0l0Q0dqTkg1TUlF?=
 =?utf-8?B?OFc1NmtkOVFpT1FNOWgrcmUrQ2pJOWExdG52OExOb08zNVppcERYNEZIdmhO?=
 =?utf-8?B?ZnRZWlJkQWpEK1pTWHBsaWlqaHA4YzhPd3hWUVQ1akpKcVRBRCtXaDFYZHFx?=
 =?utf-8?B?WnM1WDRFU09lSjIrZlhYYTVRU25ramZnT1JZa2FMazJycGtTUU80RXlRcVZu?=
 =?utf-8?B?WFlMWVFHMitLb2NuMkNLN3ROSHBENGM2dExCdGlLUndjL255c20xOFA2UU5R?=
 =?utf-8?B?V3J1RzFwWndWOVhZRjFYb0tQdEZMOThNL29HL2s3dkgyR1RodEFMRUVGbUJp?=
 =?utf-8?B?NEtnUnk5Smhvc2o2RUI3V0gwYWVpeTRhdnF4V1JNUHRCOFpZQ3E3bE1TWkhW?=
 =?utf-8?B?cUhtWFMweTg2eUdQUGxnWGxwMWU1ZDhSNmZsbFpMeUJTbHIrL0NXUnVFWnMx?=
 =?utf-8?B?YkpDVW1vNHRzTVZiODV1c1dLUWtpVVlyVmpGQ01tTk9zTHJGYm1sWGYrdnh5?=
 =?utf-8?B?SU5ZdTNMbUlXQ2tvSTRkQnRZcUg1dDViTGc4Wk1tSFNQVWo5NzhjTCttMTFl?=
 =?utf-8?B?T2JJYzR0WkYyVkNxVGdKNXFYOUR0T09NVXprVi9WcmVtdEJxNUlMMWlLSDFy?=
 =?utf-8?B?VHlNRmRYdTA5V0pNU1hXaFNkWjhWalozZHpCczY5cXRYem94bTRLSUlpMG9n?=
 =?utf-8?B?VlR5cndkZlNWOUd6Y2xKdDcyTmZ4aklZbGhhYUFvWFptSkd3UzlabnQwZHJB?=
 =?utf-8?B?OVc3aHZUTGlQa3hiSFV5cVl4WDJTdEUvekVuSlJqU3RKUUJnVnFZT21mS0pv?=
 =?utf-8?B?YmhPOTBxNnFiN3VxR3lkcGhTZHNPbzNXcTcyY3RHMFpaZHVac2hsM2hGcDJt?=
 =?utf-8?B?WFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebbdf3a1-d624-4fff-a088-08dc768d6dd0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 16:21:38.6198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5OINd0lKNeGEmrpu51a4RabwJl8p+ZDbtFsHE/XXbSVdS2GDGRLyi3Ds/ij7GHby6XjAWZ9wocIHACmMYlvMDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7754
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 May 2024 16:21:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15913

From: Jan Kiszka <jan.kiszka@siemens.com>

We effectively do not support encryption without SWUpdate enabled, even
if parts of it may work. So, put everything that needs SWUpdate under a
condition so that also the visualization is the menu is cleanly
indented.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Kconfig | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Kconfig b/Kconfig
index 62be071f..6e3ad3ea 100644
--- a/Kconfig
+++ b/Kconfig
@@ -175,9 +175,10 @@ config IMAGE_SWUPDATE
 	bool "SWUpdate support for root partition"
 	depends on TARGET_QEMU_AMD64 || TARGET_SIMATIC_IPC227E || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM || TARGET_BBB || ( TARGET_QEMU_RISCV64 && KERNEL_6_1 ) || TARGET_HIHOPE_RZG2M
 
+if IMAGE_SWUPDATE
+
 choice
 	prompt "Update type"
-	depends on IMAGE_SWUPDATE
 
 config IMAGE_COMPLETE_SWUPDATE
 	bool "Complete Update"
@@ -190,7 +191,6 @@ endchoice
 config IMAGE_SECURE_BOOT
 	bool "Secure boot support"
 	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM
-	select IMAGE_SWUPDATE
 
 config KAS_INCLUDE_SWUPDATE_SECBOOT
 	string
@@ -226,6 +226,8 @@ config KAS_INCLUDE_FULL_ENCRYPTION
 
 endif
 
+endif
+
 config IMAGE_TAR_FORMAT
 	bool "Separate artifacts for NFS boot"
 	depends on !IMAGE_SWUPDATE
-- 
2.35.3

