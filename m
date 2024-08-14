Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC95C52D7D
	for <webhook@archiver.kernel.org>; Wed, 14 Aug 2024 04:43:48 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.73])
 by mx.groups.io with SMTP id smtpd.web11.90793.1723610619517120698
 for <cip-dev@lists.cip-project.org>;
 Tue, 13 Aug 2024 21:43:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=NzvZXLpn;
 spf=pass (domain: siemens.com, ip: 40.107.21.73, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z0LaTSp/AsLmVMYm/0Dsnq7U0pAawZABBqI2QTrR3AbtbGm4qFkCJCpUZLSXf5+15UyLEpnsM2vcERqBd9wfX+umbT/liCX15de0rVuDnBKwTZUYQl3GOS5kQeIiVfAfXI3NLEswdv1DoTGsk4+47lAoL9EjGEhlaxWtCHFLFctVYvTPMksitWwsCxYkGyu29WdX38lQQjrnlx9SYnjMPPKI2bijCGkqFTtqPYvYXPeZE2WEhcZpKPw66rYUvGjFo7oQ5gg8bz1VWqDbRzQDc85iZNIGpmXTEbITF4mGQEeme+nquK8+AamCRrFeFSUy9BKAvDifGcCnrdLrAmRqEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2R2SZOpfXETEBmPpdULGzUunNsmlL8GrQscZOnopmas=;
 b=Q86C1EJRCHIWU/cfqwgz/ENEnz4qFsWz04nlRnHfTOuqyTNOxlfIKSX58G25UqDpODyeWWUD/rfHsyBfE/v1XCbWtYoQYYR3uYdYcWdFnRKjfSXAzMLYqdh5OUh5t+xbY7lWStz2GhCxeBc2kbZuW20SF7mbI221VVEAFNQz6Tfh7OR9ffVtmbc3gjSkG5mJHzJF2ylp6hf9FBKV+YJn12cdNCWIVSRBKgBdtx+TDVzWNF4fmeOdGE7sVHDKv8XMbYi+DCplK5iMsdlgakOqIW6fRVA/w7vzpKQSCreAbnY+1FI0ark7FwDdwpdwJAjcrsjgoVk4VHvV+klO2P9nMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2R2SZOpfXETEBmPpdULGzUunNsmlL8GrQscZOnopmas=;
 b=NzvZXLpnAbCYdd2Naf90UDSjfy/6yNxcy7B2ftV+b/dN7n4nypnXUzWNZUZlrcPT+0iUto3WXIBRgvXtuCYbAH/WHhGiZKbCKuqoiMBfCuElxDZlJDAe9lxMgjZiEysV38JFrpgkgdMNMCEBPracFizVn9dER0UIAMGk0PPJuZfp3YwzCd3/r2A+vMGLK++HHJrMfnbTQDnyqR9Unoo7H/6IjXblNNadTiuCFTIiJiNdFSPBcJUEBPPXV5g2zKfR2TFnrIqdHNQ2mCRtu89WSzOGK+Q6AQ1ybe/RA/1iWuT0BeJzbozwC8J65qTEr2afBheRitF9AaoJ9/hiZz4rtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB8776.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Wed, 14 Aug
 2024 04:43:36 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7849.021; Wed, 14 Aug 2024
 04:43:35 +0000
Message-ID: <a2344dc6-5577-4df0-a318-0d89cae642f3@siemens.com>
Date: Wed, 14 Aug 2024 06:43:34 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 4.4.302-cip90,
 5.10.223-cip51[-rt21]
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0103.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB8776:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bbcd0b9-e5ce-431e-b9ed-08dcbc1ba89d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bWVNQjhTd2NvUitUNnVGR1hLanhpMWZ5cFVtM2RxY041M2JiaEFoSXN6MDN0?=
 =?utf-8?B?aTc5V2tjQkRadW5vSSt1YWZNR0x0V0tYZzZGM1drQVV1eUZnOXhhNTVWa1lV?=
 =?utf-8?B?dGQwWEErcisyU3lvUzkveVFybjlRYTNsaEtrMVJhVlhKMkpxUUdMMmdUQ2lu?=
 =?utf-8?B?aXdPL1JGUWJsaUNMbVM4ZVNtZUFuRHhBR0hrUkxGbHdqZ3JRMENFc1hkKzRQ?=
 =?utf-8?B?VkIzaUhWeUF3OEx2TUpBbU9YZ2luMm5IdEd5Um82TWNEd3ozSStYclhWYXZk?=
 =?utf-8?B?MXhuYm9sVEh1QWRneWFGWVYxRG13NWZJNXc4dW92d2JuUkxxRWYyUm14Rnl0?=
 =?utf-8?B?M0xwOTJQWld6Qi9YakFNNndyL1BaSEhtZkNFSE1JdGpJUlR2cUVoZisvVi9K?=
 =?utf-8?B?eW5hU1lUUlY4QlNxR2VjaDBJYnh6RGprbUFDbUlsdGdINEdaL1NLVi8yU1Fq?=
 =?utf-8?B?STliVHg3cjlzS3BOOHV1MURKaU0zSkZOeHVlMkV4NFRBTjhoNm0xaUhUZy90?=
 =?utf-8?B?VnFZWk1BMmZHeHZ1bjRTNG1qSWlNWGZpZGxKbWoyUkxrQ2dXWThydGVmV3Fh?=
 =?utf-8?B?TGM5TDFnWXA1N3h1ditHcnkrWElCaE5SWFVZVWlhTzBIL1VZblBXeURMdlpu?=
 =?utf-8?B?bnRuMzdMd1BYbFM5T3lpZk5NTTJ6dEh0RklJS0s2Rk9XTEl6cldCNDB2OUg1?=
 =?utf-8?B?S1VVWSt5Mm56NGswc0hZdVY3a2hhYzBSWThvdHIyR0lRWEFtR3U3ZndjanpT?=
 =?utf-8?B?WmxvbkNZcDhucG0rQURMRDY4YUwxMWNmRFJlVjIrTktNc3FpWWcwT1BlTXFs?=
 =?utf-8?B?UDFwbGJ1ZC93alpINEd5WkhMUVJmTDRvdWtXVG5zcTY5dkRJWFYrR3lKeXdm?=
 =?utf-8?B?cUlIVHN4bDI2dEgreS9oTE5PMmZUYW9PWlRDSmE5a2tUSnp3WU0waVcvVHp5?=
 =?utf-8?B?SVUycE96RUs0cEdROSt1OFJkRHc3d0p3b3Q5QmRDU1hpYkE3Q0I5dy9YZWFt?=
 =?utf-8?B?UWFLZ3R1OG9BWjBuTlh1VE9IZHQxODFCOTZJYXU1Z3I4K2U3Y3pCaDhjN0tw?=
 =?utf-8?B?VUl0Qm81TWxHT0RneHhPb0xKalRiYldOSkFadm9QR0ZIMUh4OC9rS1BrTXZW?=
 =?utf-8?B?VGRyRDVHbWFCOEVCVzVrRjBzeHJodDI1bTNwOE9GZTE2Zmt5TWVUWC9iS2wv?=
 =?utf-8?B?cU1kWFlES1dxb25WRnQvVDdNTEJuTDNqK1gxQnBXYitVRHNrQWF3VFR1clRp?=
 =?utf-8?B?OERZOE1NVkZRbnhDWVRxOUE1VDdwbVhGaHRIN2h6UldmZHJJcjVBeHlmYjUw?=
 =?utf-8?B?N1RkbUNqK1djWWQ2bVkzNU5teGxuaGcrV1Rxa2xZSmNxd2NEdURjTkczU0E5?=
 =?utf-8?B?VlowZXRUVC92WkRJSUtWalAySFMyOGNZRFVEQ1BpeU5uU0lUYlhTYXowWFdh?=
 =?utf-8?B?SzRiK2xROElnUTZ4Q2tZY2tkRHVGQ0k1emw1a29aSVlXL1lUR2JTZ28zSmgy?=
 =?utf-8?B?eHRCVVgzZkNIWW9qUGtoYzRRZDJHMVd0c082ejlKVFN0Z1MyZGllalF3aG8x?=
 =?utf-8?B?RWZhcHBEMWVHVDdQUDI0S1dDVTJXb3NrU1h2VFozRGJSNzB4YUlBNFBFNm5N?=
 =?utf-8?B?dG1tTnZ0NnVyU1lOWXV5aFIxb2VGYklyZEY1QThWS2JDUGxxZ3QxS2xOblV3?=
 =?utf-8?B?ckdmUWZGbDZ4UWNSeFF4SEplV0gxSVNUWldCbUcyWUhieWR0RnJYdng5aUFu?=
 =?utf-8?B?b1lqVDJPSC9iaGxyVm1OUS9FRkRra2JwOVZhc05EcExVWEZ1YWVKcldNcVRO?=
 =?utf-8?B?b3ZnQks4ekRqeWJZNTJaZz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?V1c2Q1N0OEZVYnhuUUFyRFpJdHVwOUYvOVh6OEdNZllXSFoyM21KTXNzYTJX?=
 =?utf-8?B?K0IzMXBIc292NTR3YU1NRk5OYlFrRDNvS2pDWVQ2dmUzNEc4UXRkbloxSFJ5?=
 =?utf-8?B?dXBOM3hsbWJhSUE0YVM3ZnU4a0lVR0toeWJUcTBqK0lIVkppV0VUdmVUcHN3?=
 =?utf-8?B?amFhb1RmS3hVMkdTVGx3TDk1TjBMOWpBb2htMFFoSDgvM3o5WnJXWW5tRW1Q?=
 =?utf-8?B?d0Y4aDM5VmlnZUl1bVlRbWsxR28xcXllWWpYMUJVcHptSDdiSXViZnVENENq?=
 =?utf-8?B?bndGNHdIVDNNaUlCMTB4a3YyVXhQeHBydnVwWWE2SW1zRzJ5NHh3TnNaakts?=
 =?utf-8?B?Uzhra2VUbFQ0K3VsWDZpNVNmWDdKb0dhSTFTbk1VN0dVWDJCRjlEVDFHcHJR?=
 =?utf-8?B?ak02a0s0ZC9hKytNa1RWNUVEaVZ4R1E0WHV1VzgwcU5KSkFZU3JaVkdDbFF6?=
 =?utf-8?B?eXJTaVNRZVk4VjExUXIvdWUzMlM2Ukw1SHJrbHBqMWEzc1FMUWFwcmVTMEJ5?=
 =?utf-8?B?cVJKWklMQlZsd2ZFSDI3M1BVQk00YmRhMDc2QmhrcmwwN0ZTUjdlNWszN3lm?=
 =?utf-8?B?dVdJSnJTaFYxd08yOVpveng1YXlmeVRRLzAra3N1TUt5S1ArUkZZeUkvamxG?=
 =?utf-8?B?NzhrWjJ1cFZEK1ZzR1RoanFKV1JiNGU4dUZydkQyZHljSCtzWSttckZyaitr?=
 =?utf-8?B?K01XOHhRT016ZHhobndaUjYxQ0xaaEVVRjdVRFhURGNlWHpWZkFMSldzVmpT?=
 =?utf-8?B?OGtIQXVJdTNNaVFLME1MNFlMc1dCS21yVnM3VXl0c0F2SXVaNzQvZ1lFTkpL?=
 =?utf-8?B?c2ZsdUV0MGF6RDFGeUdQWEx4MjFVOGhCTUtCWHV0NDhVOGtodjJOZkhmOU9E?=
 =?utf-8?B?bE92ckx3bG10cUI5VWFaZHBURWRKZnNmMDhYaTkzNzMxTlFnS2YvaDlYT3Nm?=
 =?utf-8?B?QnpNN0NCcDNhay9UV3V6YUlMVkoxM1htVTkwT1Eva1VGVVM4WWV0UVdGQ1FD?=
 =?utf-8?B?YlBDcjFydGFZNEhyVnJjYUo3cEkveGl4WEdRWVN4a2x6NjBXOTZzcnM2OFBa?=
 =?utf-8?B?bUkyWTRJSm82ZlI4VnNiam95QXYrOHZGSkM3MnlnbTlwQjhwcFhYcTlkNHFK?=
 =?utf-8?B?OCsveWVoaHoxdHg3QjZXV0h6UWJqekFuM09PSXJxbFFpemhqWnAwc2l5VVJD?=
 =?utf-8?B?S0VqbDN4cGNIK1hhUksrWWtISGxTUWFUYTJ2Rko5N2Fud2NUejkvZnZZVExP?=
 =?utf-8?B?eS95eWNkVndzcU0wK3FubEs4TGZEQW9xWENvVGcwemRIZmFmeXFza01aTm10?=
 =?utf-8?B?QnNlbHVxWSs2ZithV2VqZzgxcFNhZjk1UHBlNzg2eDE2M1Q1RnFRK2pudHlp?=
 =?utf-8?B?Q1dLVE5nTW1ucHYvSUFpbjgrUnp4U2NiWjBSZ0tBTjN3Qkk1TlR4Qk0wemJR?=
 =?utf-8?B?TjJVOG5CUlp5ajNQL0Y3WUp3ZWdtZklKS3hJMGljSHpZTytWTzB0dFhROVJo?=
 =?utf-8?B?YzhVNm5wRCt2TS81a2MyaTk1Mm12YVJpbjV0VmhEaUt0ZEhLTWtXVUFuak5l?=
 =?utf-8?B?aDBGWWVLQkZaNERPeEk5dVptWStjb1dNckdLTW1UbGQyL0djZnZtY3NzTlZB?=
 =?utf-8?B?Q1pmQ0lrbzJLSGF4REN6UnJCd0RVSUU4UE9ONXhTK21rZ3lFQXVwMnp1YUxt?=
 =?utf-8?B?eTN2MFdBTHVwMzhHelgwdDViOG1ndUxpVVozRnR6ckd4Z0c5R092TERNOEZL?=
 =?utf-8?B?UnZnMFlCdm10ZmVrWDRCbFhseGtRSjN1T01zakkyaG5vY3hIeGZ1bnExUEx1?=
 =?utf-8?B?cm9JbGNad3NDY2MwaStFcXF2cVRYSmxQVlRpbEE2WTZTU2J5N2tZOEVSQ3FQ?=
 =?utf-8?B?clN0L2VnSnJwV0dqQjZtOTZENUh1dmJvRWsyRWIvZU9yZjBBWnc1WC9UUlpa?=
 =?utf-8?B?bW9hYkNVek5ablhOV3ZzTUdSKzZvbmRSSjg2a0xGVjNkTlB0KzYrWFYwSWRm?=
 =?utf-8?B?VTdpb09hRnhmd01ZWkVxbHRoTXFjL1NCWVNkRVQxMHRlb0N6SHVRNkJkdC9S?=
 =?utf-8?B?L2JFYWFJTkdhUndaQ3JTY0hubytPTCthR0s2R2xkNXBkZkN3bVJEVGcwOWhF?=
 =?utf-8?Q?9iykT59Hw9MKqjWFufIbvOhld?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bbcd0b9-e5ce-431e-b9ed-08dcbc1ba89d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 04:43:35.9384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DuNnwce4u/gengwFJYTOC1MgT0f6XCt02VIz5Qa8Ox4Mcwyi3tj6XT3RtUNd19Jw9/sIjtf4aZMO9d+uqHSbew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8776
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Aug 2024 04:43:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16786

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...10.218-cip49-rt20.bb => linux-cip-rt_5.10.223-cip51-rt21.bb} | 2 +-
 ...x-cip_6.1.96-cip24.bb => linux-cip-rt_6.1.102-cip26-rt14.bb} | 2 +-
 .../{linux-cip_4.4.302-cip89.bb => linux-cip_4.4.302-cip90.bb}  | 2 +-
 ...{linux-cip_5.10.221-cip50.bb => linux-cip_5.10.223-cip51.bb} | 2 +-
 ...x-cip-rt_6.1.96-cip24-rt13.bb => linux-cip_6.1.102-cip26.bb} | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_5.10.218-cip49-rt20.bb => linux-cip-rt_5.10.223-cip51-rt21.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_6.1.96-cip24.bb => linux-cip-rt_6.1.102-cip26-rt14.bb} (59%)
 rename recipes-kernel/linux/{linux-cip_4.4.302-cip89.bb => linux-cip_4.4.302-cip90.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_5.10.221-cip50.bb => linux-cip_5.10.223-cip51.bb} (68%)
 rename recipes-kernel/linux/{linux-cip-rt_6.1.96-cip24-rt13.bb => linux-cip_6.1.102-cip26.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip-rt_5.10.218-cip49-rt20.bb b/recipes-kernel/linux/linux-cip-rt_5.10.223-cip51-rt21.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip-rt_5.10.218-cip49-rt20.bb
rename to recipes-kernel/linux/linux-cip-rt_5.10.223-cip51-rt21.bb
index 7a8c3f1b..9893b898 100644
--- a/recipes-kernel/linux/linux-cip-rt_5.10.218-cip49-rt20.bb
+++ b/recipes-kernel/linux/linux-cip-rt_5.10.223-cip51-rt21.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-rt-common.inc
 
-SRC_URI[sha256sum] = "ef97669e8f2a06299fe4e25890229548b2da83cafad887f202fb63947fb41723"
+SRC_URI[sha256sum] = "f5190b70b33f389e7315bd2c8d80728e388fc8cf45957de3c81e2e79331a7751"
diff --git a/recipes-kernel/linux/linux-cip_6.1.96-cip24.bb b/recipes-kernel/linux/linux-cip-rt_6.1.102-cip26-rt14.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.1.96-cip24.bb
rename to recipes-kernel/linux/linux-cip-rt_6.1.102-cip26-rt14.bb
index ddcb2ee7..ac122f84 100644
--- a/recipes-kernel/linux/linux-cip_6.1.96-cip24.bb
+++ b/recipes-kernel/linux/linux-cip-rt_6.1.102-cip26-rt14.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "48649290e51a0651c286a108804d3474bb2cca7d7c285c24f5d543736929fdcc"
+SRC_URI[sha256sum] = "7b11725df3d3d460d5f5a178517c6d4bf1c6e3354acb6d2a9b8df0f8d267149f"
diff --git a/recipes-kernel/linux/linux-cip_4.4.302-cip89.bb b/recipes-kernel/linux/linux-cip_4.4.302-cip90.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.4.302-cip89.bb
rename to recipes-kernel/linux/linux-cip_4.4.302-cip90.bb
index e8c9b87f..2d39e999 100644
--- a/recipes-kernel/linux/linux-cip_4.4.302-cip89.bb
+++ b/recipes-kernel/linux/linux-cip_4.4.302-cip90.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "6732ac0e7260d91eb3aa15818629eb48b192a2a2d44ad283c797576e77c1daa7"
+SRC_URI[sha256sum] = "cbb0177ac6fb7f11be31180e2623280da9603a709279f85ab765b535dc69092c"
diff --git a/recipes-kernel/linux/linux-cip_5.10.221-cip50.bb b/recipes-kernel/linux/linux-cip_5.10.223-cip51.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_5.10.221-cip50.bb
rename to recipes-kernel/linux/linux-cip_5.10.223-cip51.bb
index bb801467..97042389 100644
--- a/recipes-kernel/linux/linux-cip_5.10.221-cip50.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.223-cip51.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "089962bcaf2b627ef11ba97b3ec6da0e6db5203ff9dc1882570998d6d7977b66"
+SRC_URI[sha256sum] = "acad4dbcc1eafccbad50c882403c8aa8166e7c61c1dd8d30e4dac4edcbb8bdd8"
diff --git a/recipes-kernel/linux/linux-cip-rt_6.1.96-cip24-rt13.bb b/recipes-kernel/linux/linux-cip_6.1.102-cip26.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip-rt_6.1.96-cip24-rt13.bb
rename to recipes-kernel/linux/linux-cip_6.1.102-cip26.bb
index a6c27921..d0546d9b 100644
--- a/recipes-kernel/linux/linux-cip-rt_6.1.96-cip24-rt13.bb
+++ b/recipes-kernel/linux/linux-cip_6.1.102-cip26.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "5c82d799d5a24f97e00fdc6bdbcbf1b3cc66cf87f9c48f3192201d3d8b00c60e"
+SRC_URI[sha256sum] = "d14dd53b262d415e1a2e80a9dc6977156248ee403b00833ded66e126fb7139f3"
-- 
2.43.0

