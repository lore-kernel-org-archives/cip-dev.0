Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BF5C25B74
	for <webhook@archiver.kernel.org>; Tue,  4 Jun 2024 05:12:08 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.76])
 by mx.groups.io with SMTP id smtpd.web10.14253.1717477918049317469
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Jun 2024 22:11:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=kDeJ0opb;
 spf=pass (domain: siemens.com, ip: 40.107.22.76, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RYZ270JM/CeFLKZlRMcKRRWUK4jaMTKoUYppaEIR/dnDY6gyAQSL9kNDHheOJ/D3d9aW7kIxFs4PwIgU2B/TFLOSev6jSGyot062KzuHUpFzw4fpbuzYnrTpwkLgxGR4bz/FrZO1s5x7gAwrzGiMljFm/CY7IdpRODbOa3Kc4Vd3LPt1o5iFjkD4Bzm4hHQTp2lymV1LOaKdOSUCAcSrTvSqWfexMMYORrdCnet0JwcJjbIipLn4Y6yDdQ1wCZ2M3E6oObT6ahxhve3ijUBBnkqSyZy/d3bkIjsQAU496FVmBv8cLIHLIR6KdNhv+b/QLWue1/nT7lMCCAvpQu8FyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2rkZ1jP4fzW3D2B3vX3hyBOsS8I8G/brCsS+XxaFbM=;
 b=FkBMCBuYzo4rHOPFfbCGGB5NgBy69xzK+FXq9H4OkFpGckjzIgUB1iOaTpTXH72z8/eOTRISnQ5JE/FDodwLtj9cYDLcq6g9mhHHu9giS3M2qKW5bsIuxvOHJtyCfqREmUQmmWRP9Eyt4Fad4uIND0IZCymmGImVAPxPuLxbsioGA02Vn4EXuJBf8BnH/zh+dlRgJDPlx2YhRvnftGTwHq3pvepS10ewgMXLfWqZh2KO95cUdxqyDvdxCGIpGq3DLz6fxKgYcpV4Lp+xoxyCH3LpyXYOXib3MU80JAz48UD6GsCnYfwUJ8Ztav9sZc8r/cEwSVunWuUq+lX2eKwMcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2rkZ1jP4fzW3D2B3vX3hyBOsS8I8G/brCsS+XxaFbM=;
 b=kDeJ0opbsRjrl9UEFOKmXMtqbnze0d1vM6tR1DjsGgqh8DPLNzW9nZkYNNRXQw7gaNAV+9RxoLxKhkrfOo7UnRUBupXtVmqLGiix3TUV9XxL8xFJtunf2VBOScDQgoFuPTQamR/X2i2FdA2g9PVo49zMh0phgqHeGtlZx/ZfyGoFLqNAhzkvbhF6lBUN0J2Co49bh5SBgaTmu5W5uz23e9OHm1MYLRB4LoOCF79X+t/5Q2egX9u7cd1uVH3zVnq2IYmmHBja6rNVEZPW3rOvoPZX7n+BabfteX+U840RsOjMwK9uz8QcEFq6UM8I4LukYQpVl+hO3l6vE4oWsIDqnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB8775.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Tue, 4 Jun
 2024 05:11:54 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 05:11:53 +0000
Message-ID: <cc210c8e-d95f-4d08-af10-eefa82733453@siemens.com>
Date: Tue, 4 Jun 2024 07:11:51 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] isar-cip-core v1.4-rc1
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0199.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB8775:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d6e2488-9599-44ce-a643-08dc8454d8ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?T29pVFZwTHA4TWhLckhVS0UyejFzQ1k1dUdPRkp4cFd3U3ZJbW9TUDNhZzlR?=
 =?utf-8?B?OHI0NVRUOHgyeWZ2amhmMXFRMmpZVTZiYUhxYXRyWlU2dEY4OUFJaHJlNEJM?=
 =?utf-8?B?TjBuVGlOK1dMWldQbDAvVUxNMHowbEtuaSt1Slo3NDNVVEJ0bWJBOTd0S0V1?=
 =?utf-8?B?VURzS0h6VXFUajVTM0RTREkvSW1JVlFCTVBPOFpoS3lTNDhFTU9wOUI3SXhQ?=
 =?utf-8?B?enpuQzFPL0tYZVBKNHRVb0I4N2pYSTBRelJ5cU1HSjNMM0tTSjZYOFV3TkdF?=
 =?utf-8?B?VlZsVUlXQXpJRzBFUDh2THMra0FQNG9ieTdJdnpHVEYyTkJFVnNjcys4c0hx?=
 =?utf-8?B?OSthV2JEWnZYRkNiSFE5REJWWktWVGlDZHRpMGhBeEkwaEhuRmMyN1dJcVg5?=
 =?utf-8?B?WlpjZWVBcjF3OEZrWUI4TTUwTFgrVE5RbE1paFFrTVh4ZTJaWktha01RUVBB?=
 =?utf-8?B?ZzhmUHdRQjlTQUgwbnh1elY1YXRiUlgrNzhYK2tJZTJQalFBaGZrN0Z3YWVi?=
 =?utf-8?B?aEFDaDJvVVNOckRtSFh1dXFNVmVDeExLcnpXamdtN1M4VkR3SHdxS0pHSEEx?=
 =?utf-8?B?V0k2OERkaE5JTk5QYzBqWnlHK3ZPZW5BMndxNkxyVlg1TmFtZkZsU2VGN0FT?=
 =?utf-8?B?ZmY4cmVJT3BoNFY1RnVicTZ3aFhMSGVCbWt1RkNYTmhlRXRTTE5XN1VoQTV1?=
 =?utf-8?B?NnYxK05zV3ZmaFVzNHhaZlNrc2Rsd0ZaREd0MVJBWE9zMENKMkphd0pMY2RN?=
 =?utf-8?B?eUlHcytXMXVPSXRmUnh6NU9PYm4zbnZEVm5peGd6a2NPRUQ3ZVU0Q3FaSHpn?=
 =?utf-8?B?OW9LQTNKOVozMWRkSWdtRjI4U2IyaEhqSzlra0J4eXp1clFJaWlIZVhpK2d0?=
 =?utf-8?B?NXlPR3lRZTQ5QlFBTm5uTFlpaWtJL241Tm5YUmk1cnE3eXhEY01rNjlUbUJ4?=
 =?utf-8?B?eVVzZ2dlUmpOQndKMXpiRm5HMlJMbytwbmF2SDkvejl6RUVvTDdKNmVrYnEy?=
 =?utf-8?B?cTRnWWlwQzJrdzVHNCs1N0VWcWJUQlFzRC96cWJuSTY3Sm53SWx5SFZoSWFM?=
 =?utf-8?B?Q0V4ZkROZ2dnR0owblE0Y083N2xkeDNNYnhwUE5XeW5XckV1T2F4NlBnd3hQ?=
 =?utf-8?B?dktrTXJmeEpwT2hNUEpDbmtpV3BGdWNqVlBqRHhZQU5HeHAwZUdzdHlZVXFJ?=
 =?utf-8?B?c0JGQW5XNFVFZzd4b2piZnVaT0R6NU1mS0RUTWtTRGZURGlSenZRa2FqQTlo?=
 =?utf-8?B?Si9jakUzRHdINGdCeDJVRmRoUWJQTFpNb01jTU9nUjJxNUlBaGFRdFFPckZ5?=
 =?utf-8?B?MlA4NWsza1VLdlUweHdPOHB4alBhSmJCczNGZmNNYWlCcjRYZG9tck1reXpn?=
 =?utf-8?B?YVpaankzNGNMRk51RGR1aEhibHNmT0k1RkxzeXZ5cEhhT0NNYkpYMzJhcENW?=
 =?utf-8?B?dWU3bThEcUpIWlptaE5tcC9UNEhEN3VWY04zWkgydTZxM25jMDlFTVEwMlZy?=
 =?utf-8?B?ck9qZ0F6akNkeUJwVFZObEx5Tk1JVERWcWJzUnA0M0RDbEhIMFh3eGtzOUZp?=
 =?utf-8?B?eWxvanN3SVJGeWlqT1llcG5Ya1hhTHhOMk1PRjhGamVnQXJ3alNQOU9PN2xs?=
 =?utf-8?B?UlhNaGZTaEZvWC9VS3hZM2ExVE9sdnFLdEFmU2VLSnlXWlpSU1pQR0FEaEpO?=
 =?utf-8?B?ejAzVHd1L08xU0s5cXQ2OVFjNWVwTkhqM1JON3U2aWFob3RyUy9JdHB3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?czgzSjZqL2lOb2c3UFYwUWxiOEpRTkZJSDliK1E2VXBPNnJSbUd3dUthcnpu?=
 =?utf-8?B?WlZyQ3VmSHNVOE1PM3pFM1JnaXBMZkhtYk5zMWZpYXExMTdkcEdvME5sT2Iv?=
 =?utf-8?B?MnZKb3NvNG1EYU5SZG52akRUUUp4K3MxSTRZUmd2ZGVDNVRuMURwTnNsQ1Bh?=
 =?utf-8?B?WWxDZWtIOXI2ZjBqVjlXV0QydHUrSDcvOU5NYmVoNTJrYVRocGpmMWVmUEh0?=
 =?utf-8?B?TGNjM2I4RkpkOEhMV0NpbXRrNE1rS21nQzNLUVhWakRZUTh0MStUcjlaQm5H?=
 =?utf-8?B?ZDdZRHBibUlyMVVvMnNLK3Zpd1ZsOXdiSFM4Mkt2RkVEWmU5eEg3cmp3d1pa?=
 =?utf-8?B?MjJJMVRtUldFU0w1RlNEUkc1OFdrTzk3MHBQSXBVc25DZTJybVFLY1NSSlBT?=
 =?utf-8?B?bTRWTFNlM0pjeVZZZ2U3dG5RSFNyZUNZOStmTVNoQ1NaVUFBVnVpUkIyOWtD?=
 =?utf-8?B?YW1FQ1ZoTnVTMGlNazc2UmJ5dml4NVhJWk5EY3l6UkgwVXNCWGhqYS9SMEFt?=
 =?utf-8?B?K2JRaGMzVWJNWVhaaFVMelFGVUpZZ3NJeHdndm5nSG0xWTF6VTRUR1J5UEhB?=
 =?utf-8?B?ekxFSlR1eTBwM1JQL0hqM3MwT2hHWTA3U3JnS2FlQ2ZtSnFRRkhITU91RnNs?=
 =?utf-8?B?OE4rQlFXY01VVjlZU2Q2TTNhY3lUTzZaNDlJcXlkeXRVQXFScDRWUE9WNkk5?=
 =?utf-8?B?TXdob0ZBMW5HdnBxRXFqc3VNVitmR09jeGFsYVJWMFJmNjdjeERHMWRHMnI3?=
 =?utf-8?B?bEVNbXdzaDAvbDgvOENlK0psQ3FtaSs2c2grTXFPamRacXc1S3A1a1BDNnZn?=
 =?utf-8?B?MjFSdGNIZ2RpbVhyOVNXRnNScWJONVNmWG1PSXlqTmlhMjN2dkhBRC8vbFFr?=
 =?utf-8?B?SzZHWU1BNHpWNHBIZlIrMWFUWHEwZk1WS3VRczlNL09VcXhoeG14eGxOcFYy?=
 =?utf-8?B?VmlHQ3ovbC8ya25vR2luU0J5Q1ZYVllDUUwvdFpJbTc1U05UNEg5WEIvSWp4?=
 =?utf-8?B?ZjN1T0xhU3ZFRCtBMWt3VXhlU2Z3akNiU1E1K3FWZGJNbFlaV1FRN2JacWdI?=
 =?utf-8?B?MXJHS2ZtUDQ4YkVSbVhaWjdOTzUrWkJmZExRVHBzVUFHNmtiaEVMWG5QSU8r?=
 =?utf-8?B?NHpnOVVwYzRrZjFsSDg4UU9JdCtxbGlnKzFDN0ZDcWtPa1gyNmpRdVpHR1dX?=
 =?utf-8?B?SytqRWJLMUIwVEg3REN0Q2tqa2Q2dnR3N05xcEVCOVZ1YmhPYWF5dHV2b1h1?=
 =?utf-8?B?QWdhRXpCdm01eFpNc2xGTkxoYTdpelZreDM2aTFMTkIrRVBob21JeGQ1TDZG?=
 =?utf-8?B?SVFFcXBiS2t4SGNOQlhDVytMUk9HT0UvZy9CYjhhUTBuN1ZaT3NVTjJJUmgr?=
 =?utf-8?B?b1hBRm1BTTg2d3VPZ204SlpYYWVrdzhLNXdtSG1MdWQwSnExNStKM3NXS0lJ?=
 =?utf-8?B?TDl0WlNjNUFPZmR5WTE0ZkZZYXhNMy85ZWJzV0hYQjZ1cURNKzkzc1d6Mmpq?=
 =?utf-8?B?bnhIVVMrbkNqNjNDU1Mrclk5SEpORDJ0UWl3TUVIdlhTWUY4WGNwYURiOUVB?=
 =?utf-8?B?TVY3ZmdVVTRZODFvS1VCdTNGQUpWUVVvbnY4emF6d3B0Z29QK0d1TnJkam8v?=
 =?utf-8?B?dWw5ZHJIU25UNVVhbXd1SXdUenFnd2w3NHRCZ09SUHhScVl5V24xdSs5MzhT?=
 =?utf-8?B?Nmtva3lvUFhVUFQ5YnZBNllwZ2ErcDhXaGZqYkpxVHZKRy9QS1RoYXJFNVJa?=
 =?utf-8?B?TFJnWFFFU3V2MGdDdnllTnFMRXREMnFWSzVzcGV4ZW9JdGpZRmxoSzVOOE1x?=
 =?utf-8?B?ZkI4QkNhT3JCYVpHNlpTNS9ZUmorb0R1TEtPT1JjZjhKeWxBZVJSZWtrUlQw?=
 =?utf-8?B?cnZJZkJadVp5dW9NZk1FaE9XaXdyejBWdGovbXdrQU4xOFBhbEJ0SWNVNUp6?=
 =?utf-8?B?bmVHRlZSdGNBS1hMMzRJdVdHZlYrTDk3ditkWTh6V1JGczZIN3lhREl2WUJx?=
 =?utf-8?B?T01VUDBjcHd0RlI5aG53WVQxRWNDTzhYRzdKQVdTVjY1L3BHL2k2Q09xWDBX?=
 =?utf-8?B?TnJEVmFsVHNhMFpPMWIwUmtRRm41aHM2Z0FyL1N3M2w1VWNhcGVDODdyS3Zo?=
 =?utf-8?B?VEs0WnVKNUJDZjVQbHFNRXVMcm02OXlHTVNXK0Vqc0x3VnR4VS8wU2tlS0dD?=
 =?utf-8?B?VEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d6e2488-9599-44ce-a643-08dc8454d8ef
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 05:11:53.2398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IArCQT+ueJ9iMoper/PrO4SmYxUXbnw1okR7DaRBUFGuGUpX0zD12q9GITP4/8j6+DXcDbMbMB/986zYEq1dcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8775
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Jun 2024 05:12:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16098

Hi all,

this is the first release candidate for the v1.4 release of
isar-cip-core, the Isar layer which allows to build CIP Debian images 
according to the generic profile.

https://gitlab.com/cip-project/cip-core/isar-cip-core/-/archive/v1.4-rc1/isar-cip-core-v1.4-rc1.tar.bz2
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commits/v1.4-rc1?ref_type=tags

It was a longer path towards this milestone. It started later, and then 
we had several dependencies to be resolved first. But now things are 
looking good. Please help in finding any potential remaining issues!

Note that I signed this tag with a new PGP key. Its fingerprint:
004C 647D 7572 CF7D 72BD  B4FB 699D 850A 9F41 7BD8

Jan

-- 
Siemens AG, Technology
Linux Expert Center

