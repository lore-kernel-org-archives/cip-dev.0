Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D10CA0FE6
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 08:40:09 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.6])
 by mx.groups.io with SMTP id smtpd.web11.15385.1755679204221633695
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 01:40:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=tGZJuAa6;
 spf=pass (domain: siemens.com, ip: 52.101.72.6, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=redIEAqIXgGv2fQk9ivNRR+6Smt3xSPggX/60j7koY3pSAMbeDrIWLi5dzi1ZiLEjwhj2MtTDfpXS9IO3wmmb3mC/7ceGCciLNbKQ4vfLR6oVS/MZJxB/mBMVbV7VuKp+YpeobcfeL21UPPOvi8m13Vnv84nJ+e1J6aqbkC7XAsiuqRu8t25fvIl2G/rr6lQBy0fuhwb3EPt027hkMuILq2oIUM6la+dwpBsEpG0pLi9+Vdcpe6lw0GsEmohXEZ58UW+PmqJv184qc5V94zDyLDkaozeX+hm8z5Mq+RYYDzNnz/P1M694NcJeJL2DYq5MpVahIEgpAKtyBMqzj9ONA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LCxaTJ4FtWhq2Nc+K6YXYjz8QiASb6V5v4msYHnShvc=;
 b=poWs5cT96+rFBHD6RzoYe1me4oU6ScyuwrKVdTmGgTA3cxwgTy0SiPvphf6z2Xs5J4n47F2CkgLduPwpt0uLxpuNtkUBo9B7SlBZCZrNfJAxRjgMJWkyamZNTCmzLlV9O02pC9njVB0Ck9QgWiATRb0vmpgmRiBi8YNDmuSz9eyVuYIkfoYFCNZbDTKpt4d6Z3N9l1azLlEfi5pu6Gv1VK9tqiZLGDaV6FSgujZUu1xPtjdYpKpRYkee0aHGz8NxSTp36AYKQDG8Qj35adHwnwS19aY9G1rKhCdTxViX65TAyT0aIQTQhQNRq4awWeAn2Zjk7eqOgcfEOogD8HOsaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCxaTJ4FtWhq2Nc+K6YXYjz8QiASb6V5v4msYHnShvc=;
 b=tGZJuAa6/gd2CxFz8OStZKVFAqJMAQgaDpnRplLacAFBKtsI9BZeJQ+QiFv3MUbbqXBmTFQfuwG/7IE+nlOp7UiJQYAAujFQjqNrEqsC4tKAPqp55eLaL3iJwcVZAOaI/V2irx2GsNw2CdpX8KGhZOICQILCEjoB3DpseOYmZZfuF/Bbp6+PqYErznbELhOF87CrClvEpx2qPOWhMwmo20hCEya3t7Y6Y/9JlwB9N4GcpVxZXRRpdLWaAe5COlPEvhPdKqBiQgCEWkdnD92HIg4Qfq8G10rk3YfKm5S4z8UOzzEmT13v6liIajir2wj/cx++E3RRzGvDvhn2MKhYTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB8110.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1d7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 08:40:00 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9031.024; Wed, 20 Aug 2025
 08:40:00 +0000
Message-ID: <d4fe8da4-5bff-499d-840c-447e9e8bcaba@siemens.com>
Date: Wed, 20 Aug 2025 10:39:59 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] u-boot: Update to v2025.07
Content-Language: en-US
Cc: Sai Sree Kartheek Adivi <s-adivi@ti.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0345.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB8110:EE_
X-MS-Office365-Filtering-Correlation-Id: 06bdd71b-cfe0-487b-97a5-08dddfc5267e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?THExVmhUUi9yZ0pZNWNraGM4UkNlTVpNRlBuYmlkVW8raFRocDB6a2hZMXc5?=
 =?utf-8?B?RkNqMWNuTi9TbTNsUVF1eWsxeENxb3BXWjhxdi95a000Zm9ZNHphU1VPdGk3?=
 =?utf-8?B?TFZNRTN2Zk91K1VwV0swM1RZckNYdDJmZFhSMFJvN3RBOHFMYlpkSDVINE1V?=
 =?utf-8?B?eXVwZ3NTWDdxa25vL0R0clFwTm1hR2VpMTdvaUVJQzYvck1kUXNaMFdRdjNr?=
 =?utf-8?B?cHcwYzJxbElwV2dCVnFjTm9UTG9tWTd4bTVaTUpGZEdXYkhVeE8zQ0g3QWpN?=
 =?utf-8?B?Y2doeGJqRXV4NlhIRlRlM3FhSmJmVVVCaTFVekxDNTZNUDgvRTVFUmVuWFlK?=
 =?utf-8?B?WDBxR0RoSUhlQ1RPaHg4L3RGL3NvUWdGUmxDK1l4cEtLK0pHU3hUWXA1NVo4?=
 =?utf-8?B?ZVBKYmh2T1piMzVnVDEzYWQ0d1gveW1PSzdIbmJ1bVVHN3JyeUlJa1hza2lW?=
 =?utf-8?B?WjZ2aWlQNXZVQkRlcmZqMUtqdU44NVZxcjRURFJyZDFVMlI0bkFQTzdMU3gy?=
 =?utf-8?B?TUdRNlNFcTkvdy9WOHA4TkRBVHJ1NXdCVXpTbUZITE5nYmh6ak9FTTZQY1Nj?=
 =?utf-8?B?VWFyTWgwYzltNmtwT2lFZHN4YmY1SXFBSFFHc3Q3QmllblN5WmZxUVpvRjE1?=
 =?utf-8?B?dkFiVVg5L0Q3bmprN3hTbFpVNmRHZHZIRkRZTDk1WTN1VU5COG05T3F6TVJq?=
 =?utf-8?B?SWdlaXZicDl3RXB5ck9lZkNjN0NPZnJvem1OOUs1VUlEY21lL1k5VkhKWC9n?=
 =?utf-8?B?RGJLQlQydGxxdW5FM2tLWFRpcHk2aGJPUlIvc0I0WUxJK2l3QXoxMEF2YWo0?=
 =?utf-8?B?STJmcDQwUm5BemNnamszSncxeWNRNGVGSzc4WEo0RmxnS2l6S0tqelQxNVVt?=
 =?utf-8?B?Z1NTa1BIc3pjaXFYZTFOL2xWU3BtdTR4SUpFNnQzVVltc2R0NUFXRVBTcWF3?=
 =?utf-8?B?dlgwYzZpYUJPcElmUVdGb0ZGSTVXaWx1bWRKWTFiNlNmM2FHK25XVnpIeWVm?=
 =?utf-8?B?NTViOWh1SVdMUUJHa0IwWU1QdDRob1lxaGkzQWhraGZuQUtRSXBzZUtFSXVK?=
 =?utf-8?B?aXJxRXY3VG1TUTQ3T01jQ2lMOVo2U01xdU9ma1hrS25LRzRLZVBvcEIxTnhz?=
 =?utf-8?B?N0pBdEhxYW5IekhIZ3pSKzh5VG9ZQzZQMk5EdnJHaEQ1Sjh3ZnpsQzRsdzhj?=
 =?utf-8?B?bkpWL09ZcDdHZ216dXpOVjVaWXpvdWlWN0xBTm0vKzNYMkU4c2labVFmTncw?=
 =?utf-8?B?anBPV1VVOFpISDNLRkdWVHNSVGRNZXBWNHM4OUptYW94enJwUGk5MGw1K2xo?=
 =?utf-8?B?L05DdjBaNStxdkhFbEVnb3JKNlZ2KzJPTXZzOHRqVGFrbnByNGY0S01KV3lE?=
 =?utf-8?B?MDBNRGdrZzJBSW9qZ1RGYk5aaVJwQ3ZnV29PeFdRaEVSc1ZISVR2QWRjV3dI?=
 =?utf-8?B?NEQzR0FCQVBFcVdXcy92Vi9mRDZKZHBubHBNNFlBcEhhMllHT3NIUXpjMms4?=
 =?utf-8?B?NWovUTZNb0Jja2U0QlBCL21EaThMRzM3NmFiTjlUZDBLVnFKMU82VGlwZE8v?=
 =?utf-8?B?SHFNU0lvTmViMUM5cTEzZ2J4cWRvUVRyVlFBaXFpQzRTa0xGRTFDSVFsUndN?=
 =?utf-8?B?OGt6T2h5WFFmRmZZUnlJWlYwVktGaU9tWGJDdnF0alo0YlpCaWszTFY2aHhB?=
 =?utf-8?B?bWRoVkhLVUtScmxkL0ZZR0xOL3EvTnQ2K2pCV2g0WGZPbEQwL2lpL3paL1da?=
 =?utf-8?B?ZFNsNzNpekpGRG85aE55QS83NHRUd3hoZHhKNStVemVDME5WazM2TldES3Rw?=
 =?utf-8?Q?gYIIc3tuKyO1kZbDtybetXcEOzBabakPY7gdI=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NjJiU2JvYm8rL1h5UHEyZ2VMcEQzN1JpNVpFT1lXc2NnNFVzOXVwTlR1T1dm?=
 =?utf-8?B?NDAzMGp0YU5wYlNtdVpjWEtTRU5MSmwzSm93RHltM3JKR3F3bGZQWEFVOEw4?=
 =?utf-8?B?ZVFXbEpoaDU0V294Rkx5Nm9TN3NVSVUwZHA1Ynhic0pSSlptVEg4ZjkyQXps?=
 =?utf-8?B?QUpzZDJOK2o2aEN2K0ZyL1hvajR6emhiYUg2c3o3QmdwZy9jbXhucEU5TWlZ?=
 =?utf-8?B?dEM2REZQOU9MdmdlRG1vcGFta291ejArV2xzS3lucml0Y0lYTER2NEkzc1Q5?=
 =?utf-8?B?YXhvVHczN3poNE5vVHFCc2xMblNKcWYwbmtWdW43OWc4UDArZ0VYVGI0aDNL?=
 =?utf-8?B?WDJZNXBHa1F4N2FUZC8wRDg5dDQvdTFnTlNJZzhZbWtFbmlJVENWMjRSYlox?=
 =?utf-8?B?M1BzU1FuWndEVlVsbFhTZTFFK3owQ2lkZkcxeUxERC9jWDd2Q2VaNnNEamx0?=
 =?utf-8?B?NDEzRTZLT3JhOFpibzZHVkVWUForVFYzR1pUVjNoNERXb2VIdmpiTVh1UHBw?=
 =?utf-8?B?R2dMT0RaRUltcSszWjVvS09aUXMrY1MxVnRyc3RaL01LazlKOEYzUVpzNjJI?=
 =?utf-8?B?cEtGSXZFTm4vRnJJR21WTEpxVjRVY1RmZUQ1bzk2RjNDY3M3N2FmQXZ6d1Bq?=
 =?utf-8?B?SEpUMmlaS1dhRWlidHJzeS9hVlAwV29lRGxCMEpqb3RRenAyQ0t1ZGlvdk1J?=
 =?utf-8?B?anFLaEFJQ1lWZHpWaERzOVhBQjJqR09USHRhYU8zanFZSmJWZnUvWkMrbDRk?=
 =?utf-8?B?dmpLMXVzYzJINWluVlFOb2pWeklqTTdJUDhCRVNyZDUzOExZbXE3QzQrNG44?=
 =?utf-8?B?MHZDTVRTUnI4emZray9tMW1qd0xHSlNBcnNXTDBNK0s3MVlscFpXM0I0dlJ2?=
 =?utf-8?B?TFF3Q3NxK2NaYnR4Rzk3WnZhQmFQZHBsN1JSd2oweHlkZThyaHJvUmdGemhl?=
 =?utf-8?B?VmNFV1lQeXJmL3B0ODJieE15Zk9HZGV0c3hHZXlKa0hvdHRBNjJkS0F4ME5B?=
 =?utf-8?B?RWhmU0g4dFkxOWx0dVAzbkY4am9LOEhBcWQ3TjJuVVJtNjZCNmdteE9FOFpF?=
 =?utf-8?B?elRnamduNGs2U01wbFhYdzhOMWpuZk5rMWtnUTZEcVNtQkRDWVZiMTMzVUpl?=
 =?utf-8?B?alFHcUs4RGlFS0Q3VEljVElFSXR6U2d5WGxFdVdXdkIwUXA4ZHBoUldZQ21p?=
 =?utf-8?B?YjlSY0tNMXZLbjYrWTVkUzIzVm5uZVQxQjcrTDB0UVR4ZFI3N2x6RGRsWCtS?=
 =?utf-8?B?Z0h4T1p0Q2ZEeWQzK2lIbW8rckpiY1dyME9FcjBrRXRjbjhBdmNqMEh0TmhD?=
 =?utf-8?B?RGIyQWN0blNKR0xKQ2dPaExvY3lkN1E4MGtNc1VuZmg1V1VVbWhUNFMvSUpo?=
 =?utf-8?B?Z2FJNTZLdmRQRnBnTnY0bjJDK3hCT0JGWGNjR2ExcWExOVNTZmkzaXRUcFhD?=
 =?utf-8?B?R3B6N3NUdTNuK1NmamNTYVlDZktkUWNCVDMvN0d3VnhFUWp2d2VzWlhsa2cw?=
 =?utf-8?B?dzY5QW92RnJwWDVQSmpSNy90LzI1MUo5VDBUWkxTN3F1U290T1ZJUUg4MUhu?=
 =?utf-8?B?aDVtNDFnL3BxblhoTWk0N0xPbjlzcnBZQ1c2SnpqeHo0NUh1MWVTVVdPdEdG?=
 =?utf-8?B?a0Y1QThWYnFUa094SGlOcHAydEZiVkVzbEROMjVsS2g1em1sRTlmQjd6MFpM?=
 =?utf-8?B?M3FoZXJlUWFlL2JvblJmOG4yeGhEakp0bmU0MmdGamhIOG9BdGtjTks2MCs3?=
 =?utf-8?B?UUNXU0F1V2pXb0FKL3BhMm5YTjVPVG4ydkhhbzMwNXJHWDlGOUN6aEw3dDZ2?=
 =?utf-8?B?OFFSTjZtZUlLUUU2M0Q0QW5OeWlQaW8zblNKbWx0dG9BaWlOYSs0NkcrZ0tQ?=
 =?utf-8?B?SjVERWxINWp0QmtGeUpRTm5rK3FMMnoxVk9VazA2ZU5GK0ZITDRaNGJiYkFR?=
 =?utf-8?B?MlBDWUlZOU5LRFFZQk4rN3Z3ODFjQ3dFUXN1Y2NmbVQ2OGdiT01Fblg0Yzdl?=
 =?utf-8?B?MXYzYUwrcnBGRGN1SWFhbU5DdkpqTHJjZzBLK01DcDhqWUIwUzRZcittTy8x?=
 =?utf-8?B?NXI5V2pzeElGZ2Nma0NUanNnWWNSMFF1K0NiNW9qM2Jkb1Jiek9QWDhVTjM4?=
 =?utf-8?B?QzhBSHlvVDRiNEJyQUkvWEpDWWlDa2cwMnNNeDViaForOHJHWVBwVWxiWDh6?=
 =?utf-8?B?S2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06bdd71b-cfe0-487b-97a5-08dddfc5267e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 08:40:00.5832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DmT585z8nfmgZxw+Hly4ufU/GCj6vYN6cU+OoxceUz5P/CgcWk+GB8JtMSpVt5iAcfULqjNFDk+LGGvjsB6pCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8110
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 08:40:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19792

From: Jan Kiszka <jan.kiszka@siemens.com>

Needed for adding the TI AM62Px and extending secure boot features later
on.

As U-Boot no longer has legacy booting enabled by default, switch the
bbb to EFI even in non-secure mode.

Explicitly re-enabling CONFIG_CMD_DHCP is needed for qemu-arm64 at least
to resolve a missing dependency of EFI_HTTP_BOOT on it.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Tested on all targets. While doing that, I found out that EBG binaries 
for armhf get invalid signature on trixie, and u-boot refuses to boot them 
in secure mode. Not a regression of this update. Working on it right 
now.

 conf/machine/bbb.conf                                      | 4 +---
 recipes-bsp/u-boot/files/secure-boot.cfg                   | 2 ++
 .../{u-boot-bbb_2024.01.bb => u-boot-bbb_2025.07.bb}       | 0
 ...u-boot-common-2024.01.inc => u-boot-common-2025.07.inc} | 7 ++++---
 ...-qemu-arm64_2024.01.bb => u-boot-qemu-arm64_2025.07.bb} | 0
 ...boot-qemu-arm_2024.01.bb => u-boot-qemu-arm_2025.07.bb} | 0
 ...u-riscv64_2024.01.bb => u-boot-qemu-riscv64_2025.07.bb} | 0
 wic/bbb.wks                                                | 5 +++--
 8 files changed, 10 insertions(+), 8 deletions(-)
 rename recipes-bsp/u-boot/{u-boot-bbb_2024.01.bb => u-boot-bbb_2025.07.bb} (100%)
 rename recipes-bsp/u-boot/{u-boot-common-2024.01.inc => u-boot-common-2025.07.inc} (83%)
 rename recipes-bsp/u-boot/{u-boot-qemu-arm64_2024.01.bb => u-boot-qemu-arm64_2025.07.bb} (100%)
 rename recipes-bsp/u-boot/{u-boot-qemu-arm_2024.01.bb => u-boot-qemu-arm_2025.07.bb} (100%)
 rename recipes-bsp/u-boot/{u-boot-qemu-riscv64_2024.01.bb => u-boot-qemu-riscv64_2025.07.bb} (100%)

diff --git a/conf/machine/bbb.conf b/conf/machine/bbb.conf
index 5cf3a0fd..8c42ec08 100644
--- a/conf/machine/bbb.conf
+++ b/conf/machine/bbb.conf
@@ -10,11 +10,9 @@ DISTRO_ARCH = "armhf"
 DTB_FILES = "am335x-boneblack.dtb"
 
 IMAGE_FSTYPES ?= "wic"
-IMAGER_INSTALL:wic += "u-boot-bbb"
+IMAGER_INSTALL:wic += "u-boot-bbb ${SYSTEMD_BOOTLOADER_INSTALL}"
 IMAGER_BUILD_DEPS += "u-boot-bbb"
 
-IMAGE_INSTALL += "u-boot-script"
-
 USE_CIP_KERNEL_CONFIG = "1"
 KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm/cip_bbb_defconfig"
 
diff --git a/recipes-bsp/u-boot/files/secure-boot.cfg b/recipes-bsp/u-boot/files/secure-boot.cfg
index 76ede89b..58786a45 100644
--- a/recipes-bsp/u-boot/files/secure-boot.cfg
+++ b/recipes-bsp/u-boot/files/secure-boot.cfg
@@ -16,3 +16,5 @@ CONFIG_EFI_VARIABLES_PRESEED=y
 CONFIG_EFI_SECURE_BOOT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_EFI_SCROLL_ON_CLEAR_SCREEN=y
+# workaround for v2025.07
+CONFIG_CMD_DHCP=y
diff --git a/recipes-bsp/u-boot/u-boot-bbb_2024.01.bb b/recipes-bsp/u-boot/u-boot-bbb_2025.07.bb
similarity index 100%
rename from recipes-bsp/u-boot/u-boot-bbb_2024.01.bb
rename to recipes-bsp/u-boot/u-boot-bbb_2025.07.bb
diff --git a/recipes-bsp/u-boot/u-boot-common-2024.01.inc b/recipes-bsp/u-boot/u-boot-common-2025.07.inc
similarity index 83%
rename from recipes-bsp/u-boot/u-boot-common-2024.01.inc
rename to recipes-bsp/u-boot/u-boot-common-2025.07.inc
index 7f2d611d..93678cbf 100644
--- a/recipes-bsp/u-boot/u-boot-common-2024.01.inc
+++ b/recipes-bsp/u-boot/u-boot-common-2025.07.inc
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2022-2024
+# Copyright (c) Siemens AG, 2022-2025
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -16,14 +16,15 @@ FILESPATH:append := ":${FILE_DIRNAME}/files"
 SRC_URI += " \
     https://ftp.denx.de/pub/u-boot/u-boot-${PV}.tar.bz2 \
     file://rules.tmpl;subdir=debian"
-SRC_URI[sha256sum] = "b99611f1ed237bf3541bdc8434b68c96a6e05967061f992443cb30aabebef5b3"
+SRC_URI[sha256sum] = "0f933f6c5a426895bf306e93e6ac53c60870e4b54cda56d95211bec99e63bec7"
 
 SRC_URI:append:secureboot = " \
     file://secure-boot.cfg"
 
 S = "${WORKDIR}/u-boot-${PV}"
 
-DEBIAN_BUILD_DEPENDS += ", libssl-dev:native, libssl-dev:${DISTRO_ARCH}"
+DEBIAN_BUILD_DEPENDS += ", libssl-dev:native, libssl-dev:${DISTRO_ARCH}, \
+    libgnutls28-dev:native, libgnutls28-dev:${DISTRO_ARCH}"
 
 DEBIAN_BUILD_DEPENDS:append:secureboot = ", \
     openssl, efivar, secure-boot-secrets, python3-openssl:native"
diff --git a/recipes-bsp/u-boot/u-boot-qemu-arm64_2024.01.bb b/recipes-bsp/u-boot/u-boot-qemu-arm64_2025.07.bb
similarity index 100%
rename from recipes-bsp/u-boot/u-boot-qemu-arm64_2024.01.bb
rename to recipes-bsp/u-boot/u-boot-qemu-arm64_2025.07.bb
diff --git a/recipes-bsp/u-boot/u-boot-qemu-arm_2024.01.bb b/recipes-bsp/u-boot/u-boot-qemu-arm_2025.07.bb
similarity index 100%
rename from recipes-bsp/u-boot/u-boot-qemu-arm_2024.01.bb
rename to recipes-bsp/u-boot/u-boot-qemu-arm_2025.07.bb
diff --git a/recipes-bsp/u-boot/u-boot-qemu-riscv64_2024.01.bb b/recipes-bsp/u-boot/u-boot-qemu-riscv64_2025.07.bb
similarity index 100%
rename from recipes-bsp/u-boot/u-boot-qemu-riscv64_2024.01.bb
rename to recipes-bsp/u-boot/u-boot-qemu-riscv64_2025.07.bb
diff --git a/wic/bbb.wks b/wic/bbb.wks
index 9bda7c04..832abef5 100644
--- a/wic/bbb.wks
+++ b/wic/bbb.wks
@@ -9,6 +9,7 @@
 part --source rawcopy --sourceparams "file=/usr/lib/u-boot/bbb/MLO" --no-table --align 128
 part --source rawcopy --sourceparams "file=/usr/lib/u-boot/bbb/u-boot.img" --no-table --align 384
 
-part / --source rootfs-u-boot --ondisk mmcblk0 --fstype ext4 --mkfs-extraopts "-T default" --label platform --align 1024 --active --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid 25d57b24-f34d-412e-8c88-28629f23aa0d
+part /boot --source bootimg-efi-isar --sourceparams "loader=systemd-boot,dtb=am335x-boneblack.dtb" --label efi --part-type EF00 --align 1024 --fsuuid 0x4321dcba --uuid 16d61432-ec24-42fa-a4b8-b2bc20a26f5e --use-uuid
+part / --source rootfs --fstype ext4 --mkfs-extraopts "-T default" --label platform --align 1024 --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid 25d57b24-f34d-412e-8c88-28629f23aa0d --use-uuid
 
-bootloader --ptable gpt --append "rootwait console=ttyO0,115200"
+bootloader --ptable gpt --timeout=0 --append "rootwait console=ttyO0,115200"
-- 
2.43.0

