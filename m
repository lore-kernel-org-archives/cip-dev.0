Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F142DC10F16
	for <webhook@archiver.kernel.org>; Fri,  3 May 2024 10:05:17 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.47])
 by mx.groups.io with SMTP id smtpd.web11.9215.1714730711915749847
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 May 2024 03:05:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=vLXB6vaK;
 spf=pass (domain: siemens.com, ip: 40.107.21.47, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m274ja9lnKg+iX6HANjppFsshu1VtVj/3JAueXbXpmxJMoVFDm0NYG5k913zgYImb9j9aAvKewGjDK8XY4s7WqVM4nm4eerB9tiGZ5Qfc0pEMlNb5tnbiQM7FyoVcSBEDn8t10DW4utMczoBHM2AVicp79gAb1Y9rMuSKwH95tj31hKpAUQsrzRe0U2o9SrZkM36djeM9iEfFgq2MXjqJlaXkzvUdpoUI1IXsxwif8v4r8+012eb4NDz6mMN/6V6cNcclCdM89N6Efx9xKxi/ycAAYHFSIQDccS7NXLqBj1Xg/h7O5SJoikZkVzBxGn2L/oiozjqTrK9KA0KzIgu/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x8Fs1aJb10hfxlhBNSEYd2UZKtXxwPq/hdS1Mpx4sFI=;
 b=SCu/YM/5lBKImMClXR6AWh/SF1XEhMGxbVM4+VgI9kjoKY9H7JcagMqQSiDGDAISLpUVV7eJDsgcbv3W/LI7tVDBFCgWwIbIHDBNBYqv7bCSvGykwbqhmTjtZxdRzQDMOs66HAIi6fFhbeRVBvJyDiQI6ERSANh3ltrV/1VQRv3VzIXhLnw5ESkswfO0iXCiCDo3VrdIgiiYGk0ZRGW+7gXSNpwtTT/AkEpgtkkcxD9Qon3qYl0gTKtrPL5CkvenD4oMRJBdRR42SXUo2NRnwRnLXdHW3IMCOmP/ScDo9st/zGx+zbNnYIDXFbXvyhv9vtd4SH7dItSb0NCrxpDbgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8Fs1aJb10hfxlhBNSEYd2UZKtXxwPq/hdS1Mpx4sFI=;
 b=vLXB6vaK3L6dQHlvRCbOYVinrV394ACn2myG6Tn/CMMKoDoZXX6CByRBbOsKtzDgIM8/O15lGW1sbWMc8/pi+O6cnFeeRwj92r6fZGGhNqyNgKo1UXbsKZ+ZqwV3xp/JZWjrJPA/9pz+Yzs2Oo06XTTHerU39Sx6gqR55m4TjZcNbenUd34m4gk29hyWIXQa8gYZ0WCKd90xylfdZNPq20jX8GOZH947tvBXHYYFRYZhbM4q79Fe3AQ22sEsC584YjVsrgA5izST6FFy8KK0O2v6CDslaFxV0/2xeGsvpXci/5n2jL049S8uMTDb17vCKatIXP1yDZIwczSUmPK3yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5360.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:282::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Fri, 3 May
 2024 10:04:59 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 10:04:58 +0000
Message-ID: <e106df27-1771-4bd8-b93a-1d3d149d7320@siemens.com>
Date: Fri, 3 May 2024 12:04:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] wic/plugins/efibootguard*: Take
 --size and --fixed-size into account
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20240503085950.667611-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <20240503085950.667611-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0194.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5360:EE_
X-MS-Office365-Filtering-Correlation-Id: 41f48ca5-f965-47bf-efe2-08dc6b587d71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cldrNi9YNGxBVGpCTEUzWjhCTGlhS25TZnZqRzBzK09pZW5MRFh4ZlQ0UGxy?=
 =?utf-8?B?OVkxV3lxVWhBSE5oSjFtc3ZFMUJma0JTSlFCdUMyQmpTZnIyMHhnaVFnT2RV?=
 =?utf-8?B?NjNDUXRrU2o3OWVMa0pvZ1F6dEJwVzFuQWxKMnpXTjk1M3hONHpSNVpGc0pU?=
 =?utf-8?B?ck1GaUxQSDRpZVVweFdUN2RKWWFLajBDdDl6dzBDV3lCU285YTZrMHR5ZU00?=
 =?utf-8?B?Z1d6bmQrc1ljVjNMeGdtMnFsTjBZZXRoUzh0RUpkRGxCcHNrdkFENkhtQUZn?=
 =?utf-8?B?TDBPNnhDdUpDZW1zNW1kOFFBaE5CRzEycGtZNUJSb3JpaHBBZHFyS2Vud2dC?=
 =?utf-8?B?NXJlbXdNa1IwMVJNYTNucTVsNHhMaFNHbnMxcFhYdDlncHk0R2Z1RHl6TWxn?=
 =?utf-8?B?MFE4ZHVnNkRNT1RZaXRyU3pieDcyczR0aWJ4K2xoOGM1ejkvZVhxaTh2TEFB?=
 =?utf-8?B?bGJNZkpPZnhZYXdjUnMzS3JRb2dnTVVNZjZ5VnlUYk5LQ3lFMmJNQW1oUFVu?=
 =?utf-8?B?TE5Bc2JJUU9nZlo5WEI4SGVwR0QraDJLSEprTitJdnFwSzhhSDRGc21LTUI5?=
 =?utf-8?B?WmJ4THV2Y2p3cGxhV3luVE5JelBROGxyNFNERzZJc1NSRmlKZ1FOdmtaRUFM?=
 =?utf-8?B?Z3M0amx6cCt3NVIzVTIxZ0ZrR3hEVWQ0dXgrdGRxdGRhVkpRdFJSOVFubFNX?=
 =?utf-8?B?YUdqRTFHa2dGSUxHNER0endPY3FNNjFxQkZEcUZDbEJxYnh0OXNLMjViL3Rj?=
 =?utf-8?B?Zi9QN2k5K2N6ZmtrVFdKL0ZkdVNCUFlLd3JoS05oQlk5WFBWUWtiSDFtekZD?=
 =?utf-8?B?TGFCNDU3ZHRmNnoyZnB6Q21PQkp3WGtvWW5NRGIveVkyckZ2OFZkV1NmREFL?=
 =?utf-8?B?aHBLNVFWUFgyVkFVaWdMTTlZMEl3VnpYM1hSdFZ3cmZOZG43SElhK09Xd00w?=
 =?utf-8?B?d2QrOU4wSlRZbUFLLzdRWW0wdEdmc2xvSHg1Rm5pOUJ2REtWUjhNT0NMOE9q?=
 =?utf-8?B?YWdZMm43OVdzMk9kbVlVc01KR3liMmZkZ1h1blpEaER4YWpYQkpTdkRKUXda?=
 =?utf-8?B?eDN0RURUaU95WU5NWUw2a2ZWTTltRjhnTXM2WnFIYkMwZ1FSSjRJcHVtTmZF?=
 =?utf-8?B?T0lGYk9UWEk0VmhvbmQrZFg3VWhHZG5ObXd2TG1jZGFhUWlsZEFxYVB0d3NM?=
 =?utf-8?B?U05WaVp0Y2xTRkU3N050M3Y3K0JGcHJQS1lQdVN4V3ZwV1JmRWlVRjdVTXJn?=
 =?utf-8?B?Z2E5aW94NURQU054eTlPZGhVQUMzN1IraW5aQmV3bHVxaGpIOUI4dmpxeHFs?=
 =?utf-8?B?d09qbUhjVHZaSXZvRi9XVlA2YkJQYTI3cHI4SXIrMFMzOEtmNHdHTy9xODlN?=
 =?utf-8?B?bUxhQjJ6LzkwaFVHb2pYOWsvczdlNGkreWNKU0RINWs2K2xPbkQ4cnB6dzZ3?=
 =?utf-8?B?K0dEZVR4cnJEU25IN0lza2IydUtxNUVSNlJLeHRUR2NuZURWcGk1ejl2M2cx?=
 =?utf-8?B?SmJHMjc3WTIrbmMxUng1NGZZUU9QMnpmMlRwYzFDb1R4SEluMjhvakk2OHox?=
 =?utf-8?B?U1hYaFp5MWVMdHkxTDY0K0wrbmFtbTIwOGRrWkxMZXRqUzVnU0x4VWxWbm1F?=
 =?utf-8?Q?uflAonBzEPPwXJ1R6dyyVLRKUsAcmB55eOSYR6+o8ees=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NU8rZk5vWnlDbFVqSVl5NGsyNVpCNE1SQS8wN1JrNUlBYy9qTTJQRG8wUm5B?=
 =?utf-8?B?WHVNdmJDdDFJaUZxN3F0VXBKWVlHWHR2cVl2a005MXdmYmhnWWc0VjlPMmdn?=
 =?utf-8?B?WDZBYkhTVk90WkZGTVlja0Rqd2hoSG85Y1dSUzBNZzBVQ0tLeC90OXl4VDBu?=
 =?utf-8?B?Nzl1WFcxUHNMNmVYS0xOMnlMZ29nd2pQYzM2dFhYY2VrRW1hU0FjaE5tWTRU?=
 =?utf-8?B?ZHlGV3NneXBJa3Q0ZThoalhkTzFMTWZTVUZwQ1JtT09qMkdXQjQvR2pxNmg1?=
 =?utf-8?B?YzZkM1dkT2FDMk5YM0RmQTRLNnBHWGFMMmErbTFpYUQrQW5GTXZyVVpnVmJQ?=
 =?utf-8?B?ZTZqV1ZHRGJ1R0F4aEZYbjZ5Z3F4SEhIY0lBdFVhSGd1c3ByNTRmcDEzdW4y?=
 =?utf-8?B?RFZnNjZLb0RoTk82N0pKVHBqM2tnKzFYVmFDeC95S2g4R2JwTzlNbHdpZElM?=
 =?utf-8?B?ek5pOEF5RlFQRGZNS3ZZd01YVlFVc1k0MCtCRlRrWHljY2FoalNwdmdWM0p3?=
 =?utf-8?B?ckdoZ3dEY3FKVUJLbUNjS0k3cEJodmhkRVZUeU5GNmtNdXRyMzZTUWtaTWpm?=
 =?utf-8?B?cy91SWVremZXZlZNcmZHMkx0V0xnYytIWXV4cVp6RmU4Rmk0dHdZeXhnMzY0?=
 =?utf-8?B?NXVkYmRjZDBWVHlZK2hUYVhNSDJVZmMyWTh5UkI2K3ZIQ25rRmVOZVlaSHly?=
 =?utf-8?B?bVRLR3gra2lpOEQ0Q2Fya2JZa3hIRFlQU0FnU21aN2h2d3BRUlE2cWhtNzFZ?=
 =?utf-8?B?VmQ0MHFYcFZiK2owdDhRS2s0c2lqY094KzA4WC8vWTdUaTFlWnArb1UvTGt0?=
 =?utf-8?B?TS9zcDZvYk56Q0dVV3BYVlRvTlVqd3prTlozbDRCeTVDeFR0aE9BZ00wTGVN?=
 =?utf-8?B?ZG9wd1pPUGxHK0VESE81dnB6eHVZMkdQd1RWZXFKTWJxM0RGYmIzZmFXNFY5?=
 =?utf-8?B?VWNJTytOdUk2U2NWOEtFVmVFcFNiTVVaNE45SEJLNXpMUW5lNjQvdm40QU5T?=
 =?utf-8?B?cEczbHNVQmI2U3BYZ3BUUEFtQnpyYnFtQ293WW9ZQjVRMzBlWkE2OGpzT3dH?=
 =?utf-8?B?OUUvTkNCNi8rQlB6Vnl5YkxYVk9NV1lGeUZpeDYzR1JZODBZSEVEbXZKZUxq?=
 =?utf-8?B?MlBVWTBaOFd5YUZxanRWdTNjMXp2U1V2eXFFN09IVkN0QmQ3RTRFNGo1blpF?=
 =?utf-8?B?SWp5bWdFQUNXcy9jN1NmZlZuZEJTZ3ArS0g2VTdtUVpmdEZYLythK2FLbnBk?=
 =?utf-8?B?dmNJMzlaTTRib0pxRjZEZWFmRXVNZ2gyQTFCeW42aVpydHMwQmsrRnVvVG9N?=
 =?utf-8?B?Qnpwc3BabFJtNnh1aE1pNDU4c3RPWXJ4VW9hNm95SEJUQnBhZUJiMktkNENW?=
 =?utf-8?B?emFJRWo0dEJVUlpMRFlzcXhDNVJpSnlkcktoUmtQbU54cGR5cmhKSlVOL3BS?=
 =?utf-8?B?RnpYTGRqanhwVDZRUnNWMWJjRDZtcElzcHd6VG1qOFJoR01GUEN6eDU5bnpE?=
 =?utf-8?B?VHBvSGZlSEFaVFJPMXpuSldCNzd4LzJCVUtDWkJTYU40SGRWOFNqdzRTRVBJ?=
 =?utf-8?B?VkM4UUJUL1pGc1hOZjV4aGhUbnpEUXdZK3dJYlB3cnZJMHUxTVltdCs5OU1J?=
 =?utf-8?B?VUc3dHdQMk1hRkJMd00zdW96QUhRcnhMODlMZ0JtN1J4MjN0eTh5RlZDa1dx?=
 =?utf-8?B?aFhtdWs4a0t4NGlnZG1Uc2x2dDBZNGFrRE14dStDb2FGVEJjTk9VNHZkdSti?=
 =?utf-8?B?UzR6dEY3V0x5aWlTOTV0dnVhTlplNGpOUWJublJmZE5LdVpHaXBEc1oxVUdC?=
 =?utf-8?B?WTZPdExwa0YzZFJuUjdibUxWL2N5WWMzQjR0V3Vja0l1aWJtdmF5Vmw5RlJi?=
 =?utf-8?B?eVFBSnlabUZmRE5ZdzZDM0piU3l1SkJ4cVY1OEhnN0F0eFZlZm9aRkdOKzQ2?=
 =?utf-8?B?NHZOZHl1d0VHemRTNW1RQjBNUyt5bVRrSFVlVTRYbklabXBvQ1BBTWh5WU1v?=
 =?utf-8?B?QWdnQWRnMUFFVmwzdHhIaGFMbXpXa1dOSEwreFhVbXNkanlvbG9ZQWtlcWNn?=
 =?utf-8?B?T0xOVU1wMzcrQ25mMS9odFlDeU9VS2h0L2RwVDlHL3lnK0xMNDhudDM0ZVhs?=
 =?utf-8?B?K0ZibVRmSzBnYWRkSjQ1bld2ZUxWYTY4cHJQQ3c4dkx4T3dHbGpWU2lrSXJ3?=
 =?utf-8?B?S1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41f48ca5-f965-47bf-efe2-08dc6b587d71
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 10:04:58.6738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ol6ByCu/AJS5ELQr2K4AfCCmTbZa0vFq3TKk17EFYUJr2n0oQ2w5beyAJI3Sx6st4aR13t51sY4lt9E+fJ1lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5360
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 May 2024 10:05:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15814

On 03.05.24 10:59, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This fixes the issue that wic arguments --size and --fixed-size
> are not correctly interpreted.
> 
> part.get_extra_block_count is removed as it is already take into
> account by part.get_rootfs_size[1].
> 
> This fixes issue #104.
> 
> [1]: https://github.com/ilbers/isar/blob/26e9653eb5e096e8b367ebd73054b2fd2310e9bc/scripts/lib/wic/partition.py#L104
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .../wic/plugins/source/efibootguard-boot.py   | 20 ++++++-------------
>  .../wic/plugins/source/efibootguard-efi.py    | 20 ++++++++-----------
>  2 files changed, 14 insertions(+), 26 deletions(-)
> 
> diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/lib/wic/plugins/source/efibootguard-boot.py
> index 4e3aefb..c8d6a19 100644
> --- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
> +++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
> @@ -143,25 +143,17 @@ class EfibootguardBootPlugin(SourcePlugin):
>              # Write label as utf-16le to EFILABEL file
>          with open("%s/EFILABEL" % part_rootfs_dir, 'wb') as filedescriptor:
>              filedescriptor.write(part.label.upper().encode("utf-16le"))
> +        du_cmd = "du --apparent-size --block-size=1K --summarize %s" % part_rootfs_dir
> +        rootfs_size_kb = int(exec_cmd(du_cmd).split()[0])

Naming: it's not a rootfs that we are building here.

Logic: What makes this different from prepare_rootfs_msdos? Why are
there blocks passed around, and we are using bytes?

>  
> -        du_cmd = "du --apparent-size -ks %s" % part_rootfs_dir
> -        blocks = int(exec_cmd(du_cmd).split()[0])
> -
> -        extra_blocks = part.get_extra_block_count(blocks)
> -        if extra_blocks < BOOTDD_EXTRA_SPACE:
> -            extra_blocks = BOOTDD_EXTRA_SPACE
> -
> -        blocks += extra_blocks
> -        blocks = blocks + (16 - (blocks % 16))
> -
> -        msger.debug("Added %d extra blocks to %s to get to %d total blocks",
> -                    extra_blocks, part.mountpoint, blocks)
> -
> +        adjusted_rootfs_size = part.get_rootfs_size(rootfs_size_kb)
>          # dosfs image, created by mkdosfs
>          bootimg = "%s/%s.%s.img" % (cr_workdir, part.label, part.lineno)
>  
> +        # create a fat16 partition with a sector size of 512
> +        # block size is always 1k
>          dosfs_cmd = "mkdosfs -F 16 -S 512 -n %s -C %s %d -i %s" % \
> -            (part.label.upper(), bootimg, blocks, part.fsuuid)
> +            (part.label.upper(), bootimg, adjusted_rootfs_size, part.fsuuid)
>          exec_cmd(dosfs_cmd)
>  
>          mcopy_cmd = "mcopy -v -i %s -s %s/* ::/" % (bootimg, part_rootfs_dir)
> diff --git a/scripts/lib/wic/plugins/source/efibootguard-efi.py b/scripts/lib/wic/plugins/source/efibootguard-efi.py
> index e82e990..1796eb1 100644
> --- a/scripts/lib/wic/plugins/source/efibootguard-efi.py
> +++ b/scripts/lib/wic/plugins/source/efibootguard-efi.py
> @@ -100,23 +100,19 @@ class EfibootguardEFIPlugin(SourcePlugin):
>                                                 name)
>          exec_cmd(cp_to_deploy_cmd, True)
>  
> -        du_cmd = "du --apparent-size -ks %s" % part_rootfs_dir
> -        blocks = int(exec_cmd(du_cmd).split()[0])
> -
> -        extra_blocks = part.get_extra_block_count(blocks)
> -        if extra_blocks < BOOTDD_EXTRA_SPACE:
> -            extra_blocks = BOOTDD_EXTRA_SPACE
> -        blocks += extra_blocks
> -        blocks = blocks + (16 - (blocks % 16))
> -
> -        msger.debug("Added %d extra blocks to %s to get to %d total blocks",
> -                    extra_blocks, part.mountpoint, blocks)
> +        du_cmd = "du --apparent-size --block-size=1k --summarize %s" % part_rootfs_dir
> +        rootfs_size_kb = int(exec_cmd(du_cmd).split()[0])
>  
> +        #  get_rootfs_size use kb as input
> +        adjusted_rootfs_size = part.get_rootfs_size(rootfs_size_kb)
>          # dosfs image, created by mkdosfs
>          efi_part_image = "%s/%s.%s.img" % (cr_workdir, part.label, part.lineno)
>  
> +        # create a fat partition with a sector size of 512
> +        # mkdosfs selects automatically the allocation type table
> +        # block size is always 1k
>          dosfs_cmd = "mkdosfs -S 512 -n %s -C %s %d -i %s" % \
> -            (part.label.upper(), efi_part_image, blocks, part.fsuuid)
> +            (part.label.upper(), efi_part_image, adjusted_rootfs_size, part.fsuuid)
>          exec_cmd(dosfs_cmd)
>  
>          # mtools for buster have problems with resursive mcopy.
Would it be possible to reuse prepare_rootfs_msdos somehow? If not,
could we at least avoid some code duplications?

Thanks,
Jan

-- 
Siemens AG, Technology
Linux Expert Center


