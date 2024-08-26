Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9E8C5321D
	for <webhook@archiver.kernel.org>; Mon, 26 Aug 2024 12:10:41 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.44])
 by mx.groups.io with SMTP id smtpd.web10.51483.1724674231255261167
 for <cip-dev@lists.cip-project.org>;
 Mon, 26 Aug 2024 05:10:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=y0Xyf7QE;
 spf=pass (domain: siemens.com, ip: 40.107.104.44, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=on7NCdgE/rxqxoGdhvxn2utnsajpN1Fj+P9Ky5szqTXN3K3Kv0IomIgbzHbczcTpdFb8WzMsqlLF2B33FAda2BYANBxfCYSl7qhbqDDWTEnvjD8f9Paob1iDikuaVFj8oEjLH7wzDalrZ4fAjoT0Gm+HO3yFqA2hwa4HO8TjjnM2wj9a+iO0WCraOcB69KRZIPeG4Iu7YZU97dJX0UBreex80DY5MefxqZBSYhmrDRzpNFh+3DZqVklnGXQntuI3DSpGGq8JLz2yGgHTo/loGQjUz2Dl/Wc6x3yj/rIwgOC6H+oF1UhWTsY1CeusCB2c6f1tA+TRpW6OCXkMgY6V7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AxIo9hFw4j+v2whc6zjaSPdMVlgTdK7lZqO2p1bi7P8=;
 b=vhMSFmo3MjpIzFmlRrnubkEo3dH2NLxsDXRPN/n3sLFypPfKO6llSuQS+IKJUPkpTECaGKauYt9JfPge8h0cyqcHNdLgu4jEDcMcS4wC/QmflQA6ve34AQOzJLwscB0j7ZdW9MM89zy5MTX09dIMJEM2t7gs1c9kE6X3ARX81vkhCTIMNyK3M2eeaweO+CMT41zZ0q9G7tN2rPVWWZvQHaHytjORIJPYVpCQc+Ov4B2BisDK125i1hOhbptDQ/2gXasCacVyx+btNieMS46HuEg5UgJ6ZlH/kFVnMLIOy4QKs9/BEvSDP97YhUp+/cAJC/7jYdT8aK93bV+7QSR0vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AxIo9hFw4j+v2whc6zjaSPdMVlgTdK7lZqO2p1bi7P8=;
 b=y0Xyf7QE8czb/icFhRPDfwzQIm+WrS1JUREN1Eht5pxjYmZp3eze85N6874nKFAhoDPUlsTSxWMe2gQU0fFFnLH3rM63ZgbziJIa/vZN5RTsOg+v1/IphLSXK7bhqnpHMD4C7b599QsB+Zd83S8f/gYrwYCb+MwqwN3V8L8vxKezmyhjTneRUxuXc25TU2IFkGHrcfPPz7h2gMvRYxzTpP1CSik7++NHz1n4mQbgwup55dMrLvkFVwB/vTwfjyhsl406eitapct4DROMwf23NToueZCGsFAz71CvuHZHCOTp/n50E1ti2abScRRlV+ang5NQIolX21YdN6cq3Pehrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB8821.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Mon, 26 Aug
 2024 12:10:27 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 12:10:27 +0000
Message-ID: <70399ffd-bf1f-4a28-b8d6-b7a7981c7726@siemens.com>
Date: Mon, 26 Aug 2024 14:10:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] Fixing dependency of package
 expand-on-first-boot on cryptsetup and tss2 (tpm2) libraries when building
 with disk encryption enabled.
To: alexander.heinisch@siemens.com, cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com
References: <20240823161906.1168642-1-alexander.heinisch@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240823161906.1168642-1-alexander.heinisch@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0099.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB8821:EE_
X-MS-Office365-Filtering-Correlation-Id: 87710709-16bd-44e0-1ad5-08dcc5c81257
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?YjR2bGVDTzZXZzVmNkRGVUc0ZzZXM3RaVHoxMHM4WEVzWExIdnhob29RWWMy?=
 =?utf-8?B?dTJPQ1p2MkZSZEZDS0YvVXdoaGdlZDcvNzgxTmMzVmZVQktWamR0WTFpYVd5?=
 =?utf-8?B?VmtkVmFNdEsrN3dRZ1hXK3YrK0VYQzdFWUNWUy9LaEo2emxmbUtpSEMzZ1V5?=
 =?utf-8?B?UjNtS2pIMndpOXQwNW1xQzNqWFhSaWFRNm1HVEdLZ1VaZytrRzVxV21La08x?=
 =?utf-8?B?YjY1S0JhTnZJb2hDY0xnTC85RFVKaGpRUlZ6NXc1cGFDeVBzUEdUbitEVVl2?=
 =?utf-8?B?V3dtV1JsamxxM3ZwWTMrYkIvMW5lRmE4RlVuS0JINmhFTkNBMUpTL09rS2w0?=
 =?utf-8?B?bzRINUd6bjlmU3o1VGJPTXpveEZVZUxtaXdjenFVb2NYcUhsTDVNK1dhSmdW?=
 =?utf-8?B?VDlCSmhxWkFGZ2gzWkNDUzVhOEtTa1pnZGhZRFdFNlNUTU51TDdyRFU0SnFC?=
 =?utf-8?B?clMzQ0NFL2xzUGRDTzZvaU9hY1FnR1FlK2RBZ3d5NjYyOFlHUG5MRk1EVExi?=
 =?utf-8?B?QXVKM0hXK0hnb09iaTA4Wk5rWjJnQTk4cGl1ZVJlaEJIWXlwbXdTa1FkQ3FP?=
 =?utf-8?B?Z3VVcDhxVmZsUmhWYWRrcGJLOTdRUlJ4cGVFalUzSXVQcjBRZHNvaVg0eGQr?=
 =?utf-8?B?R0lEbHZGWVRXSzNDRmpFK05Xemh5UC9nUXo1eEdrUk1jTWRtUHc5UVZaT2lI?=
 =?utf-8?B?MDBWOGNrNVZLdUp3QVo3ODQ0Y3lWcEYvTVZJQ290V1lxY2haM2tQdXVodHk1?=
 =?utf-8?B?bkRhbGVPNDlhamJqRTdPNWl5dVVTYU5UWko3TWd4bm9HV2ZkS1UzZ2JiTzNy?=
 =?utf-8?B?d1hhTWtzejNYL0taeTM4QmxPWUppK0l3Ulg3Vm1hRjQxMy9KSlo0dXhuRlM5?=
 =?utf-8?B?MUsyWjNXdjVxWnhDMVQzNFJtZlNzemtJVUMxcjd6SklZajdjOFZjVmxYWUl6?=
 =?utf-8?B?ZFVLQ0pra3NGM01STUlDZ3FLR2R0RHVmOFIzN3EwQUw1SGljcWhtMGh0eXI5?=
 =?utf-8?B?ZW1uY2s5clZYcnk4SFFHVllkb0JJdEJFUjZ5dUl4SVkwVUFKTWxVR0MzOWxK?=
 =?utf-8?B?OXZsTWdISFBxZFozT0c5MURBcmVITkQyeFB4dk1VNW9IUWFGL09xYW03N1pw?=
 =?utf-8?B?VFhzbXROSUlEdXo0dWtRYnVMZG0zNmtDNUxicEI5Ry9LbldTV3ZGQ0NQbHJP?=
 =?utf-8?B?Skhnc2xtdndFY1pDRmJHQ09reFZwUHQ0U0hCUkQ1UnVKUVRYdHNxZ25nRTRV?=
 =?utf-8?B?MVZxcVAyRVNYbWtJdXhsYWRWcWJPWWx4VWpJZzJxK2RwMjUxWXEzektuSC90?=
 =?utf-8?B?R0VsaG9xY00xeXNWWDBMT2tOSDlMeFhNeVNUQUJxUlVNR09HNTJ2ZHNCVldo?=
 =?utf-8?B?RzNrOEE4MzBpYkNiT21rNDNaUXl5TWtjT0hNY3dkRXJZNGc0VkRrcEtWSEo5?=
 =?utf-8?B?dTRMeEdWdklMNGNtNElXcEx0UmRlaTRPbDRZRHhVM01jTDZsZGoxS3Nxa3VI?=
 =?utf-8?B?YmJFUnU3ZDdDTG1QZ1pUVi9xQmpRbVplNjJOTno1VUdpdTd3Wng1anp4aGVy?=
 =?utf-8?B?QjBmZTB5aHhnQW9ONWZ6NFZOaFA3QzVVWkM1eVlsTmVJVlpQV2FRUk9sRThw?=
 =?utf-8?B?eFExcnRvTkN2clBvTVI1UmZVS1BMRnVlOCtXRk85UlNxZTVOSWhyTXlDeFhI?=
 =?utf-8?B?MGxJbDI2SnJBZ200WEdvOGpvYW95ek9XWStxT0JST3dYMmFNOXhHR3lqdTd1?=
 =?utf-8?Q?NDzvxGErzAGOFjpWSY=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aE0wSUxZMkMrWW5RaHMwZHp2OHhsZ3F5TnhVQ1Q5M1ExMS9mdDlWTjRjWVRy?=
 =?utf-8?B?SytzTk1EVXN6ajJxdmtMYm94MnpUZWtPbzREQlcydXNVcHlRcUdlVmhkcS80?=
 =?utf-8?B?enBzYU44UWlWa1ZTbC9ObzlyWUxzWnZvWjVUUkxQU0JmYy9MRnhxakhIeTR2?=
 =?utf-8?B?UnprclFDZ2hTNllid3B0b0ZxVS93Y2ZFNUR2cFBLR1hTc1R0T3kvQmh2VHMw?=
 =?utf-8?B?NXZSVDZvdTdqT21JQ3AvYkJFeFZHa3p2bi91N2s5Y0RtcUZ6bUEwWE5qakYx?=
 =?utf-8?B?dWVEMFl6OFE1MFFvOGpxYzhzbS9RREhWNVRTUWpwZk4zeUd6TlFwL1ZndzZE?=
 =?utf-8?B?bC9NVHNvb083cEJ0WktLQ1RsczQvdHFUQTFxMkJDTEFkaFlKczBLclFxRkxu?=
 =?utf-8?B?YWdQVmQzcDZHbHhNdzd1QmlHeU9zM09FR3lVRmNObUFrTkpna3JCdERkZlhP?=
 =?utf-8?B?azg5UktYNDkwaXJtNjQyQ3N2bHRJVWFRM1ZCV0ZNY1owSGZVQ3J6a2wwYXcw?=
 =?utf-8?B?YktSNlRLTnlGUmFvVGczVklsUndqZGFOM2tzc0YyTU9KSG5VNURhWm9adEp6?=
 =?utf-8?B?bTNYVm9weEtNTUxpTjgvelVZTzJYMUlnSS8xL2RHMWZvRk5iQmZ1ek9CRmJB?=
 =?utf-8?B?M2paakVsMTVPUnU3MURIUEJESTcwRWlndWtseXZkTEJOYzdHZndKaCtTWW9q?=
 =?utf-8?B?dGc3SkpKc01pem04Mncwa0p1ZWxWQnhkQUdpVGRMMlNobnlHOXBaYmJFSHYv?=
 =?utf-8?B?TUtnRTRQelZURnc1NGZJRm1zcmsrbERXUmFxLzVGanMrRzJHTDYyMDNvMEIv?=
 =?utf-8?B?cFZ0bjBVWUJDS0orbE5QUHp3cU1NWTlPTlZPbW5JWTM0dHdjSUZqQnhkMnhN?=
 =?utf-8?B?cjBIQ25GKzl1U01OMHE3NmtsM3BFM2JJeDNPSVhic0dGdVZ4eTVZLzd5Z0xm?=
 =?utf-8?B?bExoL255WEVYaUNoTnlzUkRBQW9ML01YdW1HelRyYXVJbDNqdHpRMHA3eGxJ?=
 =?utf-8?B?TW1aV0ZWUEVCODYza2RKNHh3QmtBZjZ1SmRweENEQjJIcmdEWGpQM1pJckhO?=
 =?utf-8?B?dnNKVGZSN2RHZ3d6UGNuK2o0VmxuOHZjblNOTjlhYjZCbTh4VVdQTVc0d2pM?=
 =?utf-8?B?L3JIZ25YajJ0b1JIY3lyTkNneDJxN0hGcWYvVHFZeTBoK3p1d3c3N25WNFpK?=
 =?utf-8?B?V1NXSVUxZ2lEMGUvMWNGdGZsVktRdUszWE5zSWwwc1VpQjBaemFRZk4rL29r?=
 =?utf-8?B?ejZSelNKSWtlNGx4enR0cmJua1g3UXNUOUZDczVPcHVEdG9HTEtpL1Bkd2dC?=
 =?utf-8?B?YzNvMkVSREdnb1NhVmdUdkxFR3hzUjYvU2pLS211RThpSXBZdUpKSDlwbzRP?=
 =?utf-8?B?cWVFTTNHN0ZFZVZCYlNuN0lxaDJrL0xRam5VYzZZSCtiazUrUnZXSmhlVjl3?=
 =?utf-8?B?ZmsvNGZ5Um9Zdk5Kc01EZVhJTURoV1FDSzk0WkRrUVZUV0psVWxTNXRlNGRj?=
 =?utf-8?B?UGpzNFREenN4VUx4UTVWd082YU5jdHRnTC9tK3g3QjlXdk9OTWo1WnVTSHNC?=
 =?utf-8?B?czR5QTYxUkNuVHJrdFMwbXR3U0pXakx6aE1wajh1WElMWTVhY0VuMlBMRHNB?=
 =?utf-8?B?Q0lET01zNHlEL01yKzhUbXVnS09jUHdEMzQyNTVmQ2dkTW40OFdaRDB6T2RV?=
 =?utf-8?B?eW55NjhWYXpRN083ZStTYlNGMEpRYWR5cHlPaEhLbkFQSTZzY096b1hITFUz?=
 =?utf-8?B?L1JrdmJodlI1QkF4ajlVQ2x3OWM3MmpJZWZNZkhvYVBRYmZaaHlhaC9mTk5o?=
 =?utf-8?B?S09UY0FnMGVublpzVVpLWlJkUXEyZnNTeHNVaGhtR2dOeHFmaTBGWFRxZWpG?=
 =?utf-8?B?V3duMzREZTczUHpUMU1qVGZpM0hlSVhBTTZKWHg1YkZtSSt3YUs3MXd1Tklq?=
 =?utf-8?B?VGFvVHhqbUg0L0c5SHkreExmdWJob0dtVnRyVUhhWDR3YWpha3BxQXJmRDFD?=
 =?utf-8?B?c1hYYmMySU9uVVFNUnpZSkFoeFd2N2lHRHBpc1RQSWxTT1hTYVVVYVhnS2sy?=
 =?utf-8?B?QnA5YWwrUGRVR1JYb2d2UFpuYlU3dVBVbEdJQlVLbkYvbFpJeHBkdnVGeVE0?=
 =?utf-8?B?VlBSL0V0MGJFdG5NcmJLc1dDbExucFFZMW80Q3VQSGtsVkVpYml4YUswdmRD?=
 =?utf-8?B?UFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87710709-16bd-44e0-1ad5-08dcc5c81257
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 12:10:27.3184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sj7U4g3YtvqUvQqWc91n/wVgngC1S2iQ4vBh1CcqXM2q2LgHm8S1I9fm5+7oDgwb5DjUZmMPsmrfZ4OJZfCxfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8821
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 26 Aug 2024 12:10:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16810

On 23.08.24 18:19, alexander.heinisch@siemens.com wrote:
> From: Alexander Heinisch <alexander.heinisch@siemens.com>
> 
> When building with disk encryption enabled (kas/opt/encrypt-*.yml) the initramfs encrypts
> the specified disks if it detects unencrypted disks.
> In case of a fresh installation this happens during first boot of the device.
> Unfortunately, expand-on-first-boot (kas/opt/expand-on-first-boot.yml) is executed
> after the initramfs already encrypted the data partition (in case of *-efibootguard-*.wks.in /var).
> Checking if the disk to expand is encrypted got already handled by https://github.com/ilbers/isar/commit/c44c088cd224e44a401410c860bd625f28950ac3
> but dependencies are not automatically set for the package.
> Since expand-on-first-boot is hosted in isar and
> disk encryption features are enabled with encrypt-partitions override in isar-cip-core,
> we extended (.bbappend) on said recipe by adding needed dependencies if this override is set.

While the implementation of encryption is handled here, everything that
expand-on-first-boot needs to run cryptsetup resize needs to go
upstream. I should not matter how the image was encrypted before.

> 
> While the dependency for cryptsetup is obvious, the other dependencies are not!
> Here is why:
> 
> From cryptsetup 2.4.0 release notes:
> "
>   Cryptsetup 2.4 adds the possibility to implement token handlers
>   in external libraries (possibly provided by other projects).
>   ...
>   As of cryptsetup 2.4.0 release systemd project already merged upstream
>   native cryptsetup token handler for its systemd-tpm2 LUKS2 token
>   released originally in systemd-v248. The token can be created using
>   systemd-cryptenroll utility and devices may be manipulated either by
>   systemd-cryptsetup cli or by cryptsetup for actions listed above.
> "
> ("actions above" include `resize` - see https://gitlab.com/cryptsetup/cryptsetup/-/blob/main/docs/v2.4.0-ReleaseNotes)
> Proof: https://gitlab.com/cryptsetup/cryptsetup/-/blob/main/lib/luks2/luks2_token.c#L170
> 
> For the disk encryption method we use a token `systemd-tpm2` is added to the luks header.
> Thus, `cryptsetup resize` uses libcryptsetup-token-systemd-tpm2.so to handle this token
> which comes with package `systemd`.
> 
> Following source gives the dependencies on libs: https://github.com/systemd/systemd/blob/a3f17a8f88f7332d0bef67a2d523c41f23f164b6/src/shared/tpm2-util.c#L114
> libtss2-esys.so.0 -> in package libtss2-esys-3.0.2-0 (available for bullseye, bookworm)
> libtss2-rc.so.0 -> in package libtss2-rc0 (available for bullseye, bookworm)
> libtss2-mu.so.0 -> in package libtss2-mu0 (available for bullseye, bookworm)
> 
> (for buster it seems required libs are packaged in libtss2-esys0 - I did not verify that! - but,
>  since they are used as alternatives in the initramfs-crypt-hook, I am pretty confident,
>  nothing too bad will happen at this stage)
> 
> Note: For bullseye-backports and bookworm package systemd already suggests: libtss2-esys-3.0.2-0, libtss2-rc0 and libtss2-mu0
> (For sid packages: libtss2-rc0t64 and libtss2-tcti-device0 are suggested.)
> 
> Thus, I decided to go with packages libtss2-esys-3.0.2-0, libtss2-rc0, libtss2-mu0 and libtss2-esys0 as a (legacy?) fallback for buster.
> 
> Signed-off-by: Alexander Heinisch <alexander.heinisch@siemens.com>
> ---
>  .../expand-on-first-boot_%.bbappend              | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>  create mode 100644 recipes-support/expand-on-first-boot/expand-on-first-boot_%.bbappend
> 
> diff --git a/recipes-support/expand-on-first-boot/expand-on-first-boot_%.bbappend b/recipes-support/expand-on-first-boot/expand-on-first-boot_%.bbappend
> new file mode 100644
> index 0000000..6736fce
> --- /dev/null
> +++ b/recipes-support/expand-on-first-boot/expand-on-first-boot_%.bbappend
> @@ -0,0 +1,16 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2024
> +#
> +# Authors:
> +#  Alexander Heinisch <alexander.heinisch@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +DEBIAN_DEPENDS:append:encrypt-partitions = ", cryptsetup, \
> +                                            libtss2-esys-3.0.2-0 | libtss2-esys0, \
> +                                            libtss2-rc0 | libtss2-esys0, \
> +                                            libtss2-mu0 | libtss2-esys0 \

Two issues:
 - this looks debian release-specific and needs to take that into
   account
 - indention is unusual and ugly wide

> +                                           "
> \ No newline at end of file

...and this should also be avoided.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


