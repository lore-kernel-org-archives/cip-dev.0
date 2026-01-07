Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D042ED0D14A
	for <webhook@archiver.kernel.org>; Wed,  7 Jan 2026 17:26:57 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.37])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11605.1767806807482100320
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Jan 2026 09:26:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=OJqn4BpG;
 spf=pass (domain: siemens.com, ip: 40.107.159.37, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nLBVVn2iIvUuYyZBe2amh/N13swp7W5Xg1dbkrPMmnKf8AtY9ZmxJeS6eHbasjjDhRhChDgKKC8q/q9ixPMt7Gt1ReJKNQzN23nmVVkAR57VlxHCf91NBVT8iECtI3A4IIe90Y9dmnfknvZOsyEQHhbPGGjhV5t05H3oXep7ah0cq9xNlhPURwDLyzEMUhv0ixZmqwVi1Qzx0dUUEHCJdwirzrt5zfLn1HC9O3YVbw+NBKuKFkBmnQtEnvkrdOKTzqoX0ZQgYKt33G5AZLjrGVmDSsiAcyhCuw8LLAqbIXY4r6pA4d8I91uR9kWdDJSwnCM68XF4057fR1NSIqeMFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZDYeWEBcwOFgBKQaj6cdiKMZz/PME3O+L03lROCe3GQ=;
 b=fUIgPU4Jij3GtjewbkAIPNhIHkAsCHvm/dIO/7zHhBco64K4fe362FMqCa3KVND9QRy+3wkI9JrNdTbbD8zI/C3LHmlZiIdQsHCPwSvw3Twl5r1kC/dVlH9LiT+2jJRcjM1XTkCRD/gyvNnmn38EI0eFZP3d9NtVKpoohaooEMdCpwsmY9VE1HsKypwl74hIRHtWsOUPmM336fIWzhcuzgXWVcUO2xvpseCJwy3ajcAYbIUxHRP93202zI+ssiOsryRFmyyIkV7/AwxiZr27k6D4j+CVCBUHIvfoI1uo0mDd+n8bGCcqKAq2z9eEwzoGxFmh59DAN9iISyw4WRc4Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZDYeWEBcwOFgBKQaj6cdiKMZz/PME3O+L03lROCe3GQ=;
 b=OJqn4BpGDSCiww5fz+7rgQXtIodXbqtzPY7oCIP+i8/QyphH9sw+uCLRAJXC7ZqreKCqC/wNjMHVjeXrSgl8IxBkY9bYd/5gT1ITeeP/Kgjx2b3kQUF8ygpZW2IofnMy35gw/jfbq1TB0Lb2QnSUiDh5JFlMYwZe9+nzMgT0ARJiN9DwzWAxIkdQeOYJkOYOGtxB4AD6k+3oD+AUbbgXrIps4pjljJ9Mj51D7mQOIrABy2xvqXhxKQnixuX8/Z55rHnA+6lDT83Y0zpXtd3dq0LtMebJn1wyb/mbQpN5fCrV6ixOgMCTli5VUncsAoxXMJhmxzmeE7icGHE5j0ZZ4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7289.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 17:26:42 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9478.004; Wed, 7 Jan 2026
 17:26:42 +0000
Message-ID: <a07389cb-947f-49f1-baaa-d7a35f2bfe52@siemens.com>
Date: Wed, 7 Jan 2026 18:26:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 4/7] Move efibootguard to
 swupdate-efibootguard.inc
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 clara.kowalsky@siemens.com, cip-dev@lists.cip-project.org,
 benedikt.niedermayr@siemens.com
References: <20260107132707.733180-1-Quirin.Gylstorff@siemens.com>
 <20260107132707.733180-5-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260107132707.733180-5-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR10CA0006.namprd10.prod.outlook.com
 (2603:10b6:610:4c::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7289:EE_
X-MS-Office365-Filtering-Correlation-Id: 46612038-678b-49d0-bed0-08de4e11ec29
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bHBJU1BMenNOTVdQQUljTnVNdUVDU09HQ3d5SnlTZ1k4ZTVqcEcwMnRxUEYy?=
 =?utf-8?B?NUFYNkNmdGNUeFdMWExqcEZCUlVGV0Y2R085emF0ejFKVzFTSFFDOHBoeTho?=
 =?utf-8?B?YXhtejhYMGNudFFqdTZwK2FHU3RxK1d4c3hUYThzd3VJRUg2UkFkd2Nkb3Zt?=
 =?utf-8?B?emdjdGlvN01VZUd1YjVKZkhYUEpTVmNEZUZxekxpNW9xUnEyZGFTazVnYXp3?=
 =?utf-8?B?b1phYi90NGNFd2YrMVpLak9QbnZwbHVEVDRlc090WUNBQ0ZYY1VHbm9kWWl0?=
 =?utf-8?B?SENRSW9uSHBoOHl1S1NQTUtDamFtS1U1NnJSOTYzZ2RqeU8wOVVIN1QyajY1?=
 =?utf-8?B?eGdEZXF1TjVpNUQvRGEyNWJiNkQzRE1sdVpNM2lYR1NGMTJTcXYrQ1Fmazdh?=
 =?utf-8?B?N0NWekxkL3dabzYyd1hNSUJwRTNXTzhObXdJcGlRTU9SOXNnRTB1ZHZmUCtx?=
 =?utf-8?B?VVNPaDBOT1ZmdmFRUnJ5R3kzZk9jcW8zQnYrVTQ0TXVRWXNWblc5eWUvaS82?=
 =?utf-8?B?djNscm1td1loSUtJeUh5alZLN2s5YngrMEp0QUdsandtV1kvd293YjJtNVc5?=
 =?utf-8?B?YUVnd3VqTC9vV1pHeEtFd0FqRDVwYzBFTWtRVWZPWHd0WGhSanpjRk1UR3pS?=
 =?utf-8?B?bjBNbXdTNVYrQ01ZV0lBQlZ1SGF2MzVVMTBNdDVqNVFheGVOeThjL3c4U09G?=
 =?utf-8?B?NmUxTnRyMFFNNUpSUUtNakVhUE5wNDc4NVpwL1duUmdxdjY4SzdGYWxCSWtl?=
 =?utf-8?B?bnkzLzFGV1IrbXZnSUliTTczS0IzMmlYMmptSk5RY0pwVC9WODJtcU9FZlM2?=
 =?utf-8?B?YU1HZlpWT0l5bDEyOFBuYUMvNnEvV2V0eUlCTFNRYUFOdnRkcjF2WmpMaFlM?=
 =?utf-8?B?WmlZekZSVndrNW9nQm9XeS83dnV2bmtEU0NhdHlwZ2RNa3ZHRGV4TmpTQ2Mv?=
 =?utf-8?B?K1dXTmhtNGg5WHFXNFkzUTZOd01mUmNvS3hHczlocGFMZFoySkh1Z2x4NUIr?=
 =?utf-8?B?U0xrSHBwVTBaQkxrRWtyZVZCdUp2M3BmR1ZWSEhtYzgyaGRXZWlON1hMRnY2?=
 =?utf-8?B?czg4VExEbGZ3VDVKai9aOFVqTXJnZktsSThKZmFiL0J2bElWbFdXSXQwYWJF?=
 =?utf-8?B?Q1ZUb1BhenZESGVyVk5qaGdOeS9IWmdqVmR5eXdCMFJldkJ6Vnp4Umd1WSs2?=
 =?utf-8?B?YTRUTVJlS1htRktQcW1Ib0RhakdYcXo4c1VydlVjaHBZcXk2cDFoNnlsekl6?=
 =?utf-8?B?ZVJCa2VZNWF0NWYxYmM0cCtpWEc2SkptbTRWNUlDREN0RGFBNUZKZVRWTXFC?=
 =?utf-8?B?QWlmSm5uK2xHYVNTUEkvSW5Ea2xXVkNnTTVnLzd3cnJHZ084dkxoUWIyL0dY?=
 =?utf-8?B?WHM1eEpUVUhYTmxkV3pId0JtSlMzUmoxek5vcStuUmZFYys2ZzlWa0swRU1E?=
 =?utf-8?B?L3VHVGtzYkpLaUtPVFhTQzZhSDA4SVlLVzNrMlFuN1orNFc2aTNieWNjVldi?=
 =?utf-8?B?Qm1xdmxrK1N1OC9uemcrMmQ4OEkyNEZRTXppOFV3RGUvZEdlUkRyeWRUajZq?=
 =?utf-8?B?NVpheS9kNkFBT3JUTHR0YTlRVjVlUnQwTDFVN3ZWZGZpclhZSVI0WWFoVVlk?=
 =?utf-8?B?c3l2TU5RcjYvQnBwczE2UHdlKzJ1NWsrWWs4R1lvejJjLzl0STVvUFRqMkg5?=
 =?utf-8?B?MkpYZWFHQlcxVU5vMC9RdWVmZGU3T25aRHdKSWU5ak5EUEx1UFZDUHo3NXFX?=
 =?utf-8?B?S3hSd0duNU1ZUDFkRHMyQVBFcFNFMkY3My9WWnplTnJSME1halZBM1QzUzBX?=
 =?utf-8?B?ZzhKZ09kdi8xUTFwOG82RGNZaEdwNWQ2eDJHV0wxYWNadk1zY0lidTNyVnNm?=
 =?utf-8?B?YlBBM3F4aFRVWHJCMzhkV0ZGUmV3d09BaDlKZFhZbnJRZ2U4czYzL0JYR0E5?=
 =?utf-8?Q?kHAjSIMzmXtOi9fwdEaKmwXy+Xd86t9S?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RUhxaE42OGlXc2pmdHNmUzE2Z3JIeXlGeTdnUUlzUXFxYkw2NURxV1NRRUJL?=
 =?utf-8?B?WStESGNEMGxsSTJzWFl1eit6YjFjQi8xaHBqdjNEQVR5RWVoNWFtNGtWYlI1?=
 =?utf-8?B?ZVh4ZkpzSzVueFM0QXV0ZFNwampRc093aGpCZG1YOUhWa0NKVk83cUhpZGhn?=
 =?utf-8?B?RE9tbGYwQnd4cU9Gd0lyV2ROVFRrRUhxODMyYW5TdEtCeWhPUER3akdVR1k3?=
 =?utf-8?B?VzFPWG1lZ0JuYTkwZHVsdDRZcW5aMVhpUmdnbm9BbFA1OFZKVDQ3eTU4ZUxF?=
 =?utf-8?B?ak5WT3BiVTFqdUQ2a2lETWR5dThGbDV0SnZYN3REL2h0bjI0NFZRSnZkY3Zo?=
 =?utf-8?B?by9jekxaRHlKbzhhc3pxa2lISGxMWTFPaTRLbzFuS2YwT1BGZTUxRkY5Skcr?=
 =?utf-8?B?bmpxSnlMS3BIaHlHcmpzc25HOXp4YzZEaVN6aEw2VjBMOWY0OUVwR2tEMUN1?=
 =?utf-8?B?S3BnSkZ5bXMweG9zN3ZMUmhrUmVWYURaNGJXU3ZtNWNzby9lZHBoQjNqVWty?=
 =?utf-8?B?Z1BYTUVXZ2dXcW5WaE83S1I5MmZRRXJFWlAwTFBpcFdaZS9pWTZQcVBsdVZD?=
 =?utf-8?B?U1B5cFRLdXcvc1BvOEFVb2tDaEg0enR0cktZOEFkdkw0aGFYOEs5ZmhZTVlJ?=
 =?utf-8?B?bXJCaU9YMmgxcmwzUWF3UThSTWIxZHlDMjZ2Z3k1blJXVTM3T2ZHZ3VwQlc5?=
 =?utf-8?B?N2U0Yko3Z1RSRFJaWjMrbmNpeUxzZjdYZ0xDS3RBeklEWWJOTDRUZ1RLeGRx?=
 =?utf-8?B?K0N2aWdKTmdnZVJLVDg2YVFiZG9BUEF0czBieGZWOVFvSnVwTWR0dE5wLyts?=
 =?utf-8?B?NTl0cE05TVZTQzFUeGIwdGlDbXRzblJ5QzE3YzU4aUp2Y3o1R21QSkZKYjgx?=
 =?utf-8?B?RU5JRmVVaDF5bk9oaThDcDhoTU41UmpzMC8rYjJBVHBwMkNQaHBUeHlVTXBl?=
 =?utf-8?B?NTBEd2Jrc0U3UHg4MjJiMW5zMm1UVWJrZDBiaGZRRkRIUk5QMXMvb1FLcWd2?=
 =?utf-8?B?Wnp0eTlNeXl3MFVHeHBHQVcwZWh6ZndQTlU0R3NtZXpTTkJpWDlJdmpBdkZx?=
 =?utf-8?B?WVJjQWovc0xRZW1aSXFDZWF0bktXQ2x0Z3h5TzZqbkFXT0dsR3h3TnN4ZElV?=
 =?utf-8?B?d0Y0WGhENUppVGQvV1lKWkZXYXYxbmFqZTlrTFF3dERhOXFxYTUyZEtmZUtE?=
 =?utf-8?B?aW5KVXdoRU5sVDdxdFNWRmJ6bTNVQWJ6SWNVUXA5cWRoU0V0UTlwSmJOcW4z?=
 =?utf-8?B?MTZjWFRyNEhRcEVDaTl5bVpIM1dZeXM5N2phNWRuZ1J0NlM0V2tNdXUxaURS?=
 =?utf-8?B?QTlGUHNPWWprUmpYMHN6WmUrTFBLLzBacFZFR1liY1pFT0JNdnI0OVNtdGJ2?=
 =?utf-8?B?UjFLdXJwNlRodTMzY3lEUEpMSk9WVExSMks0eFkwRks3TTZxUC9POFk5VzNn?=
 =?utf-8?B?eDdLR294a2p2Mlk3MGZBcGhGRzFHSmd0VktocnZua3hFUTJEOTRVb0pZOU5i?=
 =?utf-8?B?cm81TEdtZ1drdnNvMitrNzNVcVF6em05c1AyL1VMUjcvREt3QURaa0ZjckRY?=
 =?utf-8?B?dnJyUUtXbndqdmZKWUZwdkYzN1NzR1ZUekY0ZHFQL21NemRaQW00ckZhT01X?=
 =?utf-8?B?NUpONDhsemZVVkE0ZkJ4TVlSTjVMd1dRc2ExVWtMQ0Q5MWtFK0RkQi9HamNX?=
 =?utf-8?B?ZEVDa29wU1hRZ01tbVgzMmMydXZRVTFib1Nldm01ZDg4akpFTzY5NG5NY2xG?=
 =?utf-8?B?LzA3Rk5mUThSaGZTemxFakVpRGN3Mll0Y1hSbEx1VVpvdlR5YjNUN0dIZ1l3?=
 =?utf-8?B?K1F2UXZISWFLZTZQSzYrUkw1NnhMWVhwZTNVNEpsaHNUMnFYR0twZDE2NVF3?=
 =?utf-8?B?UjFqaHk0V0hzdkhWMktNb01xOUVFZ2pxZVVGNE96SWpaTGIvNjRYVGxVSVlB?=
 =?utf-8?B?cUQ0cHl6ZXMyUEE1RXh3YnhFUDdEREdNbStyWFVTTXVvR3ZlSklIbkVYVG5L?=
 =?utf-8?B?cVNGb0hDbVhWZ05UZXhlRjZYblgweWNhQ0Q5NC84QVgxZnNlTjRRbTZZNS92?=
 =?utf-8?B?Y3BhZnMyc0V3dzUzS3ZCTlpibU85NmJPNWlkbkRka3UvOC9nWW1qb1dhdUhS?=
 =?utf-8?B?ZkRVWUZ2U05HVUJXeGgvZUlBamdrYTBreUxUVnJ1aEpaeGthS0VBaDg3SnhU?=
 =?utf-8?B?WTVyY0FlK0U2KzI4dHhETklzZk5GUTB6Vm84N1ZyVmJ6WWdwNjlZeWpHVzBO?=
 =?utf-8?B?TGRzWmFiaUZCdkpjVVlqeHpNdGJleEI2YUo0TTB6amlnSlY0c3JQYTBrYVFK?=
 =?utf-8?B?ZFIzTkU0T0k4S0U4cnJNYlNkQSsvS0pnVkpLdzgzRXZPQjd3MTVMN3pRZFdG?=
 =?utf-8?Q?dFO7JbIvuPeJg7Gk=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46612038-678b-49d0-bed0-08de4e11ec29
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 17:26:41.9418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n/RzBmtcCev88fYjkjqMEE6J8R1GzB6uEeJ8nuoeUvYQR2libpos4vo0brlmTp99li804yAgpcvmxubPwkfK0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7289
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Jan 2026 17:26:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21415

On 07.01.26 14:26, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Simplify the generation of A/B root file system with SWUpdate including
> efibootguard into swupdate.inc.
> 
> With this change it is possible to prepare to rootfs by adding:
> 
> ```
> require recipes-core/images/swupdate.inc
> ```
> 
> Also rename the file to swupdate-efibootguard to indictate the indended
> use.
> 

So, the ultimate step is do drop "inherit efibootguard". It would be
good to document here that this is done to free the namespace for some
potential efibootguard package-building class.

Still, it would be good to also describe why no
swupdate-efibootguard.bbclass is introduced instead, rather an include.

> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  classes-recipe/efibootguard.bbclass           | 64 ++---------------
>  kas/opt/ebg-swu.yml                           |  3 -
>  recipes-core/images/efibootguard.inc          | 13 +---
>  recipes-core/images/swupdate-efibootguard.inc | 70 +++++++++++++++++++
>  4 files changed, 76 insertions(+), 74 deletions(-)
>  mode change 100644 => 120000 recipes-core/images/efibootguard.inc
>  create mode 100644 recipes-core/images/swupdate-efibootguard.inc
> 
> diff --git a/classes-recipe/efibootguard.bbclass b/classes-recipe/efibootguard.bbclass
> index cbd2376..4e7a2a6 100644
> --- a/classes-recipe/efibootguard.bbclass
> +++ b/classes-recipe/efibootguard.bbclass
> @@ -1,7 +1,7 @@
>  #
>  # CIP Core, generic profile
>  #
> -# Copyright (c) Siemens AG, 2024
> +# Copyright (c) Siemens AG, 2024 - 2025

2026 by now :)

>  #
>  # Authors:
>  #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> @@ -9,62 +9,8 @@
>  # SPDX-License-Identifier: MIT
>  #
>  
> -IMAGE_INSTALL:append = " efibootguard-tools libebgenv0"
> -IMAGER_INSTALL:wic:append = " efibootguard:${DISTRO_ARCH} efibootguard-tools:${DISTRO_ARCH}"
> -WDOG_TIMEOUT ?= "60"
> -WICVARS += "WDOG_TIMEOUT KERNEL_IMAGE INITRD_DEPLOY_FILE DTB_FILES EFI_ARCH EFI_LIB_ARCH UKI_FILENAME"
> -IMAGE_TYPEDEP:swu:append = " wic"
> -
> -def distro_to_efi_arch(d):
> -    DISTRO_TO_EFI_ARCH = {
> -        "amd64": "x64",
> -        "arm64": "aa64",
> -        "armhf": "arm",
> -        "i386": "ia32",
> -        "riscv64": "riscv64"
> -    }
> -    distro_arch = d.getVar('DISTRO_ARCH')
> -    return DISTRO_TO_EFI_ARCH[distro_arch]
> -
> -EFI_ARCH := "${@distro_to_efi_arch(d)}"
> -
> -def distro_to_lib_arch(d):
> -    DISTRO_TO_LIB_ARCH = {
> -        "amd64": "x86_64-linux-gnu",
> -        "arm64": "aarch64-linux-gnu",
> -        "armhf": "arm-linux-gnueabihf",
> -        "i386": "i386-linux-gnu",
> -        "riscv64": "riscv64-linux-gnu",
> -    }
> -    distro_arch = d.getVar('DISTRO_ARCH')
> -    return DISTRO_TO_LIB_ARCH[distro_arch]
> -
> -EFI_LIB_ARCH := "${@distro_to_lib_arch(d)}"
> -
> -# Add the bootloader file
> -def efi_bootloader_name(d):
> -    efi_arch = distro_to_efi_arch(d)
> -    return "boot{}.efi".format(efi_arch)
> -
> -SWU_EXTEND_SW_DESCRIPTION += "add_ebg_update"
> -python add_ebg_update() {
> -    efi_boot_loader_file = efi_bootloader_name(d)
> -    efi_boot_device = d.getVar('SWU_EFI_BOOT_DEVICE')
> -    swu_ebg_update_node = f"""
> -    {{
> -        filename = "{efi_boot_loader_file}";
> -        path = "EFI/BOOT/{efi_boot_loader_file}";
> -        device = "{efi_boot_device}";
> -        filesystem = "vfat";
> -        sha256 = "{efi_boot_loader_file}-sha256";
> -        properties: {{
> -            atomic-install = "true";
> -        }};
> -    }}
> -    """
> -
> -    d.setVar('SWU_BOOTLOADER_FILE_NODE', swu_ebg_update_node)
> -    ebg_update = d.getVar('SWU_EBG_UPDATE') or ""
> -    if ebg_update:
> -        d.appendVar('SWU_FILE_NODES', "," + swu_ebg_update_node)
> +require recipes-core/images/swupdate-efibootguard.inc
> +do_warn_custom_inc() {
> +    bbwarn "Please migrate from \"inherit efibootguard\" to \"recipes-core/images/swupdate-efibootguard.inc\""
>  }
> +addtask warn_custom_inc before do_unpack
> diff --git a/kas/opt/ebg-swu.yml b/kas/opt/ebg-swu.yml
> index 9b8a0e8..c3733d3 100644
> --- a/kas/opt/ebg-swu.yml
> +++ b/kas/opt/ebg-swu.yml
> @@ -16,11 +16,8 @@ header:
>  
>  local_conf_header:
>    ebg_swu_bootloader: |
> -    WKS_FILE ?= "${MACHINE}-efibootguard.wks.in"
>      SWUPDATE_BOOTLOADER = "efibootguard"
>      IMAGE_INSTALL:remove = "u-boot-script"
> -  ebg_swu_image_options: |
> -    CIP_IMAGE_OPTIONS:append = " recipes-core/images/efibootguard.inc"
>    firmware-binaries: |
>      # Add ovmf binaries for qemu
>      CIP_IMAGE_OPTIONS:append:qemu-amd64 = " recipes-core/images/deploy-ovmf.inc"
> diff --git a/recipes-core/images/efibootguard.inc b/recipes-core/images/efibootguard.inc
> deleted file mode 100644
> index f512b3c..0000000
> --- a/recipes-core/images/efibootguard.inc
> +++ /dev/null
> @@ -1,12 +0,0 @@
> -#
> -# CIP Core, generic profile
> -#
> -# Copyright (c) Siemens AG, 2020, 2024
> -#
> -# Authors:
> -#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> -#
> -# SPDX-License-Identifier: MIT
> -#
> -
> -inherit efibootguard
> diff --git a/recipes-core/images/efibootguard.inc b/recipes-core/images/efibootguard.inc
> new file mode 120000
> index 0000000..0bb31dc
> --- /dev/null
> +++ b/recipes-core/images/efibootguard.inc
> @@ -0,0 +1 @@
> +swupdate-efibootguard.inc
> \ No newline at end of file
> diff --git a/recipes-core/images/swupdate-efibootguard.inc b/recipes-core/images/swupdate-efibootguard.inc
> new file mode 100644
> index 0000000..5b69144
> --- /dev/null
> +++ b/recipes-core/images/swupdate-efibootguard.inc
> @@ -0,0 +1,70 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2024 - 2025

Here as well.

> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +IMAGE_INSTALL:append = " efibootguard-tools libebgenv0"
> +IMAGER_INSTALL:wic:append = " efibootguard:${DISTRO_ARCH} efibootguard-tools:${DISTRO_ARCH}"
> +WDOG_TIMEOUT ?= "60"
> +WICVARS += "WDOG_TIMEOUT KERNEL_IMAGE INITRD_DEPLOY_FILE DTB_FILES EFI_ARCH EFI_LIB_ARCH UKI_FILENAME"
> +IMAGE_TYPEDEP:swu:append = " wic"
> +
> +def distro_to_efi_arch(d):
> +    DISTRO_TO_EFI_ARCH = {
> +        "amd64": "x64",
> +        "arm64": "aa64",
> +        "armhf": "arm",
> +        "i386": "ia32",
> +        "riscv64": "riscv64"
> +    }
> +    distro_arch = d.getVar('DISTRO_ARCH')
> +    return DISTRO_TO_EFI_ARCH[distro_arch]
> +
> +EFI_ARCH := "${@distro_to_efi_arch(d)}"
> +
> +def distro_to_lib_arch(d):
> +    DISTRO_TO_LIB_ARCH = {
> +        "amd64": "x86_64-linux-gnu",
> +        "arm64": "aarch64-linux-gnu",
> +        "armhf": "arm-linux-gnueabihf",
> +        "i386": "i386-linux-gnu",
> +        "riscv64": "riscv64-linux-gnu",
> +    }
> +    distro_arch = d.getVar('DISTRO_ARCH')
> +    return DISTRO_TO_LIB_ARCH[distro_arch]
> +
> +EFI_LIB_ARCH := "${@distro_to_lib_arch(d)}"
> +
> +# Add the bootloader file
> +def efi_bootloader_name(d):
> +    efi_arch = distro_to_efi_arch(d)
> +    return "boot{}.efi".format(efi_arch)
> +
> +SWU_EXTEND_SW_DESCRIPTION += "add_ebg_update"
> +python add_ebg_update() {
> +    efi_boot_loader_file = efi_bootloader_name(d)
> +    efi_boot_device = d.getVar('SWU_EFI_BOOT_DEVICE')
> +    swu_ebg_update_node = f"""
> +    {{
> +        filename = "{efi_boot_loader_file}";
> +        path = "EFI/BOOT/{efi_boot_loader_file}";
> +        device = "{efi_boot_device}";
> +        filesystem = "vfat";
> +        sha256 = "{efi_boot_loader_file}-sha256";
> +        properties: {{
> +            atomic-install = "true";
> +        }};
> +    }}
> +    """
> +
> +    d.setVar('SWU_BOOTLOADER_FILE_NODE', swu_ebg_update_node)
> +    ebg_update = d.getVar('SWU_EBG_UPDATE') or ""
> +    if ebg_update:
> +        d.appendVar('SWU_FILE_NODES', "," + swu_ebg_update_node)
> +}

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

