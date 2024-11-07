Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8889DD5AE67
	for <webhook@archiver.kernel.org>; Thu,  7 Nov 2024 06:31:52 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.82])
 by mx.groups.io with SMTP id smtpd.web10.66430.1730961101838217087
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Nov 2024 22:31:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=gxdChkjk;
 spf=pass (domain: siemens.com, ip: 40.107.21.82, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yUGAJVcqlswyy32n250HUknpENou+hSnRlJm0kxYruwYa1PFZzIXgiRCnW+Kj7N/NeRj2/NPfW7wNVxgSAE4kA6zAqP+gAry7F1khAXxz9DHhj6VkdCYx5taw/i8r0ubgxvJZwx5iY5JOqSKTGW3e2GlMuPqGV15pDKbcshIAXPHbg9TJvszxsuTLkomq7U9mh5NWUwfw6vCwF/R3uieVgWqqs6vHL66Oo1fyH6oSuYfnlro9EASqp38MF/FYPuhT/WxupEfYepK+0HHOnhALCj90ZSLBQwgLgM31Gdpci5JMuqdfHQcVMnfZO9Z6QlWOz0jGuqVu/Hc59c+1AKXSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i78c6PQIpHRyNFxlf5UxX6eicEOTQj9XF9n+Rzm/XF8=;
 b=AK8+PRl97X0oK1k6CY4GDwZzmf/bsF9a57XQLTTRUpYlMXtkq9u2uSLCVmE6277gBlGA9p3+ATYq4l4EUeJKvia/NN9zfKpYtVYtqNgJ+S3AQPGjL2XnVFop1wPNtTUvG5BIXNghpERUoZvXoaYqwFkhHP8DjQsJmcV6ellMyi6+ik3XJ6MOX+nD6vbVTPV64qOhfCoH1u8epjNG/3PgLy+oZ6qWRf65Db74fEOrKwS4/fzo7kHcbQK7zSWuBMC4K/AEC9yMmrBgCn/8oaLX9bwCEM6uUq2AeIOYOFHcXfCP/Eiwi+4aRkLqXiyLGilI0EJKKSH5A94WINi/VeHiYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i78c6PQIpHRyNFxlf5UxX6eicEOTQj9XF9n+Rzm/XF8=;
 b=gxdChkjkRjHXHs6tMPV25U4C0FbuX7rfd3r09xEUGwQQpr/zHLieRRgu3ga3lAaSKcKvlIalhFvC4bO0v7FNZz6KvSorooJrSFpCwW7aSUnVOzXFtFXGIUF6RbA6wl3omSoTciRx3ZxRZxlTnb1Ek+KLz0Bc68/grdT4xrii2TcxChdb2oUa6QunPjJVTHZTRrMJkTD10wPYewLfIaraGsdtHOYYRztuEL9w9o6rE91JgoY5VeSsQCWCabZAA5eVPQPMDRXO2c2fgHAUIjnNI/ZVZiO2uRwYNHTfR8AC2xSyTxoVlSKcIt0GrW8H8LsAfwDRXShfMDVlqoejbZjl9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5138.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:331::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Thu, 7 Nov
 2024 06:31:36 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 06:31:35 +0000
Message-ID: <bcb07e33-2ee6-4b9c-a57d-07125662c7f3@siemens.com>
Date: Thu, 7 Nov 2024 07:31:34 +0100
User-Agent: Mozilla Thunderbird
Subject: [isar-cip-core][PATCH v3 6/6] kas: Add option for selecting read-only
 rootfs type
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
References: <cover.1730829273.git.jan.kiszka@siemens.com>
 <12bc32044317b4afd31a97d5eb14c38b997a89be.1730829273.git.jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <12bc32044317b4afd31a97d5eb14c38b997a89be.1730829273.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0212.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5138:EE_
X-MS-Office365-Filtering-Correlation-Id: 9820bd71-5dae-42a6-95b1-08dcfef5d400
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Nk9CZWN2YUdMZStXdHFFYk94cTlQZnhuUTdCOFEwQWlLRkgzcEd4SG1ISGdo?=
 =?utf-8?B?MjJEUTJKNXZTdzJEaVdQekdEL1RreGJhQjhHL3B6K0JwbG1jZ0RtUHBrdk9F?=
 =?utf-8?B?ODJJRUZ1VHNSNW9GNDZuNWJDZ2N6b3NrR2xwaURZTWw4UGZHZFlOdEJzZUl5?=
 =?utf-8?B?SmdDZWlmaDFCN0FVWnMva0p5WFR0VEFhZnFWU05qZ0l5enI4b3phZVdsdkxj?=
 =?utf-8?B?WFJneVhZVGpvcmI1NXZWY0YrekdmcXVNcUJYZzNHVmZ0ODF3VDBIWU5IM1ht?=
 =?utf-8?B?bWZVTFZLRi9iQytYVkt0ZjFQdXdaanNsZjNtRkNqNms0UEJVS0VjaXNXZ0Fl?=
 =?utf-8?B?cjFWVlhVYmhtKzhoL28rRE5oSlBtajhhK2hpLzJGcURxL2Z4RFkzUG9LWk9S?=
 =?utf-8?B?bGVHVm8vNnpTVEJBSVZlMGNhZ1IvNjEzaERYMjNXWFdQNFlydGFQbnkzRlhD?=
 =?utf-8?B?Z1lqdUsxdHQ5Z3RhbzVGc2YrbHBTcmxBTVRITStyV2dVbWQxRVNxbDU5cXZN?=
 =?utf-8?B?Y25EcFZWTktDejRqUFZhSVNMb1NGcWV2S2tPVmpySVFvS1RZMjVpbElSWStO?=
 =?utf-8?B?emJPd1JxaGFReVpZcHFLMHZzZmhod1dyODZyLzN5MWFLUXNNS3hrdEh5SDVB?=
 =?utf-8?B?SGs1R0k2bGpWcU8zSFZwT2dyQURvWnkyL0N2Q0I2ODQ4bks4cnR4NjBsa3Rs?=
 =?utf-8?B?SDg0RGhqVlBLaGduVzYvRTV3WkhyY3lHOWJCUzhtcnVuY2I4MXd6a2xFajY5?=
 =?utf-8?B?eFo3cXhBamFTNmxTdjQxeEkxYTNCa0xySHBXS282ODdyVEpCNFhMS0JrdmlJ?=
 =?utf-8?B?ek1QdGlHNHY5aGdvNkNKZCtCMk1IdmV2VHo5R2RGMG1SbHZmcjRIWXJqQWta?=
 =?utf-8?B?NTZ1d0JmV0VxUHZ4czZhVENaM0JqeHp0OFBNR25KVGdjMy9hdXFScEYrNTVl?=
 =?utf-8?B?RFpNTVZFeGRBNCt5NjhvdDg0UWx3b2tud21MTXh2K21FYjJGbTJlSGRPa0dP?=
 =?utf-8?B?L0QzLzYyMjh4bDVXS1UzSkwzbEFSYllnSXRma0tHbk5wRFVOUEFLUHVmcStq?=
 =?utf-8?B?T2txcU9XWllYaWh5aXA4bFRCYmpmVkNjK0RNc0JyMXBzOExYYzdVK0NQN0tj?=
 =?utf-8?B?ZjFZc2VwclVxRHJMRTNub3FwdlBiM1UwQXNmdTk1UkV3WHZpUHFZc214TWNy?=
 =?utf-8?B?MWJEZ2g5d0c5S3grL3RCcTlUSUc2Z1V2ZzUyZDRFODRWVVNZODJKU0VoSFdZ?=
 =?utf-8?B?YnMzczNJMnN0NGphb25Qb2FWVWhZeXVtWk0zVC9zWm5hTmYwOVd2MXVyOTdX?=
 =?utf-8?B?QmtrNDA1WUhyZ2FTUFh5U29nYWN0N25naEtvSlZENEVRNFdQeHZSQ1lyR3JD?=
 =?utf-8?B?Qk40ZHJ3NEdXSURvRUpKK1c5U0hHL3MzZEI2N1FHOC9waGxra0EwTHo4QmU5?=
 =?utf-8?B?eHpwdGhQVWd3UDlYcXY1MmRhNDVtMlgyb2EyODdsZ3llcGo0WnJtTGNzYmY4?=
 =?utf-8?B?cTAyZGRKbTdkbm56dmJrejV4ay9lc0tYNEEyeGdvL1NMckpRYkJITEsyeUxI?=
 =?utf-8?B?QmdYVWpNQ0ZUeGtDZnZaaHZpcTlRY2ZNZi9meHlka1RnenNzZ0tRSXZFeVBR?=
 =?utf-8?B?S2lDRCs5RjU5WDdpQWRNOTE1Nng1aHNaeGpPWHFlWUR1WVlFSERmZ0tMcER5?=
 =?utf-8?B?U2QvWHI2NnBJZ21UbFk5eXU4T0hJcjU3VWhLazhwdmpIK2k3RTdzRDZzL2NN?=
 =?utf-8?Q?J7tLiyfaRz3twAYav3OsY9e0ne91WDcQgYAfZZy?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?elN6TmVycTBKTENhYnh4dU5hS0VGWThnVG9YL29aLzhOTUg5eE53WDRUNXk5?=
 =?utf-8?B?WVdiRXQ1SGRlWXpkL2FEUXorcXNYMjVKeGpVU1dWTjRMVjVzSUxSWmFmQXVE?=
 =?utf-8?B?QlBuZExmSlVNVVJzam9mQWZma0NNQ01lODF5d2xBaGI2cVBaNUNYVUF1dVFp?=
 =?utf-8?B?U3hPQkxWTGtxa3BzVnVNL2pPWE81WFhsMlZNWUpJb2wxTy9ISVFQTGhQUUto?=
 =?utf-8?B?Z0k3Mkc4Rm50TTF4SEk5WVBIMFFjMkE2bjJkZGcwZVhVN0llRU1XQzF2aVJt?=
 =?utf-8?B?QmltdmpmTU9TdU9qMjFRYW00dDFYY01hNi95RzFxVFI1dzJkMStvYkhXeXM5?=
 =?utf-8?B?V3VWMGdmNDRNNUFvOVdDU3hiZUxycFk4bnQ3S2F0dG1nczBKYmdpck5wQkJ3?=
 =?utf-8?B?Mmp3SVNFSnNmblVNNkdIMnZWVEU1VG85K05zUnZOSEE2RGVtbnVwMjJoZm9j?=
 =?utf-8?B?K3FFaWp4MDBkcThtWjBFaUVvTkxFUGVCLzEyWjMyTUlTbWVRMFpMLzVkcWhr?=
 =?utf-8?B?U1ZHWTZIUnJ5alcvT0d0MlJqY2ZVUmJJQlYzdXhYZDZlL1Z0Zk5yV2Fkanhz?=
 =?utf-8?B?YTZjTWhDVzJyVkUramJ6VlNUR25BS2pYZzBhd2RhbjZ4dFUvdUozOUJ4RFdl?=
 =?utf-8?B?SFd5UTludTM2c2U0S1ViRGhXZnVqR0xieWFuZHlLZXM5Si9OMFZ6dExpQVV1?=
 =?utf-8?B?Wnc5ckZCeGx4Ymc4WjRsaXhkRmNrMnpwTkZsenRHMzkvcW8wTldLR1dvRVcr?=
 =?utf-8?B?UWRhd0VYRWI2MGRvZUJkdzQvck5waXF5QW1rd25oUmdERS9POFFTRjR1d1dN?=
 =?utf-8?B?bE5zTkg4UVlPZ2s2RDR2eG9hTGFidEZkNHZ3amxIOTdIYXJiWlI2QTRTZGV3?=
 =?utf-8?B?d2VpY3JwU1BaYkRER2ROQlpSU0pTWHY2aEl3SUJhaW9wdXN6L1M1UVF1NXpo?=
 =?utf-8?B?ZDN4UkF2T3AyN1loNXVtZ0pMUFgwd28xbkl4dzhlWTNxaG9Gb0liMzZraTV3?=
 =?utf-8?B?Zk8yMjdxcHplM2VGTENaU2NBZTZkVGwwYXQwUHM3eWtjNmhzMlpFUDFTUHZn?=
 =?utf-8?B?M21mQU5iSVRUOEJUSzZyZDZDNTFLMzh4eWhucm9ONkt2MFpobHVIdXpYd0NM?=
 =?utf-8?B?VXBwRTlOM1hkaVNjaHRQV1dJaWhxdHlCaXNTZGYrMy9WTUhNaGJCYnczNDBW?=
 =?utf-8?B?dFU1MmpWNmU5Unl4YjRhamhxSmhWd3YyTzZmL1d2Q3NGblNZbUw4U3FzWlhp?=
 =?utf-8?B?WTVLVkNYMHUxa3pzSzVzVEc1MUdLc0ZUbU5UMmRSZWRMdVBBTmlDOXF3MzZI?=
 =?utf-8?B?VThGL1hNM0pDcmJBUHE5SVNRTUNMUGxHRVZpRDI0MUkvMzhUWHZRMFlnek96?=
 =?utf-8?B?SGNnS3lPelA0QkcrdzZRMFpzL3JvOHVPUy9Ub3BXUHZsZmZLMnU4Y2l3eWJt?=
 =?utf-8?B?ZXlLNHFoM09idXQyU2xZZ1VobVVMbS9OTThKYmpEVTRSenJydVV2MXR0a05E?=
 =?utf-8?B?a0R4bE03V05tV1RVY2JOUlJqUDk1cVRFK2JKVHNkY1ppZHZXMEZYOHdmclJQ?=
 =?utf-8?B?eTJjb0hUaTZUcy83YVFTa3dLanVEbXFlamVweDZ1dVlhbVkweEVFOFp5Wnpk?=
 =?utf-8?B?UjJEZVBPd0NBVWlKUFRXZ1I3NjJ6d3dRdjNMZWxxcEhNQjRVWGdLcWZiUk50?=
 =?utf-8?B?ZHpHOVJwTmIzYjYrMFNQcHFtT21kMTNtOFdQQlRlT3ZPdndBaS9NMmpRL0V1?=
 =?utf-8?B?M3RRd2k2LzcydFhnNFNrRk1OVkVFZ0wwSmNSVWl5Tnh5aXJwL2d0b2FqWTVZ?=
 =?utf-8?B?R1VlSUlncHQ5VlkrMGVpdEdaVm5wcHZDOU1sQ0t5cDR0RXgvRll4RGs0TmlE?=
 =?utf-8?B?VkFsQ1hJbitIZzB3eFQvQjQ4OHNCUkVvUmRUbTdaR0xvYlJ5M2JCaWFaekZk?=
 =?utf-8?B?OU1LbjFnOVVZK1h3bXNtdHQ3ZzFzZ2JGenE5WGZLUG5SV1M5b29uVk80TUw0?=
 =?utf-8?B?YkVJNjlmWDNJWW9PNW1taGRka1BZOEtNMEtKY0NneUtjQVBqUW4zUytPRTlr?=
 =?utf-8?B?bmR5ZVNjRDFnT1pENExDZHpleU5OS2srQ3Vtb3lZUnRkck9PTHZoOXNyV2NG?=
 =?utf-8?Q?0DWP04MnpXVu7k7mnxzKsjJjV?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9820bd71-5dae-42a6-95b1-08dcfef5d400
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 06:31:35.9169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9VGsPMDpWSwZaEf7UN5w29vt2lfRT2wE03EZ9qm9o1MkIdHKJUn38C1yzGZhuiu99kYs+fdD//RrFy2WQ0jm+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5138
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Nov 2024 06:31:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17195

From: Jan Kiszka <jan.kiszka@siemens.com>

This allows to select EROFS as alternative to squashfs. The option is
limited to 6.1 kernels, older ones will no longer be enabled. Debian
buster lacked the required erofs-utils package, and bullseye seems to
generate filesystems that are not detected by kernel 6.1. Therefore,
limit support to bookworm+.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v3:
 - exclude buster and bullseye

 Kconfig           | 16 ++++++++++++++++
 kas/opt/erofs.yml | 16 ++++++++++++++++
 2 files changed, 32 insertions(+)
 create mode 100644 kas/opt/erofs.yml

diff --git a/Kconfig b/Kconfig
index 8062cdb7..d10ae917 100644
--- a/Kconfig
+++ b/Kconfig
@@ -198,6 +198,22 @@ config IMAGE_DELTA_SWUPDATE
 
 endchoice
 
+choice
+	prompt "Read-only rootfs type"
+
+config IMAGE_RO_ROOTFS_SQUASHFS
+	bool "Squashfs"
+
+config IMAGE_RO_ROOTFS_EROFS
+	bool "EROFS"
+	depends on KERNEL_6_1 && !DEBIAN_BUSTER && !DEBIAN_BULLSEYE
+
+endchoice
+
+config KAS_INCLUDE_EROFS
+	string
+	default "kas/opt/erofs.yml" if IMAGE_RO_ROOTFS_EROFS
+
 config IMAGE_SECURE_BOOT
 	bool "Secure boot support"
 	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM || TARGET_X86_UEFI
diff --git a/kas/opt/erofs.yml b/kas/opt/erofs.yml
new file mode 100644
index 00000000..7c44f5b8
--- /dev/null
+++ b/kas/opt/erofs.yml
@@ -0,0 +1,16 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2024
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+
+header:
+  version: 14
+
+local_conf_header:
+  erofs: |
+    RO_ROOTFS_TYPE = "erofs"
-- 
2.43.0


