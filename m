Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.28818.1793861324408846748
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Nov 2026 22:48:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Pel6UI9Y;
 spf=pass (domain: siemens.com, ip: 52.101.65.31, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZTOkPS4Nmoi7X6v7QiIQAwSw/nsy32j+qdjSxCn7Tcl5NALv7jcPdKA9MR3XF9YL7GYmCIWb6JRWH+NIBrdaLJFhi1mPTJlCD4pM/nphVKLazQ68zZnGmXY2TrGtZBF9lP3613ScbBvPXLckWwVTSDj+CfsQh9chZh1U1XF6NTC3ZSFl5n5JL9ioVQtNbkMwlVE4AdvuH9LUgVNZ2bxvvDHgtwX2YxFtweHhA1ck2wAENETUBzM+gk+mS2kc+T1PO+B3YmCQe/ROTb8K56NQOLvSawT/Ai8/GL2aVBN8XROG//AZ88EtR3kSb7ammx4jWxxiA8JXt1ujufp75pqTUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7G5UP4kzOPlAtQ8gv2LbcXFF58bgurE3JzYyjzDQpqE=;
 b=o0fKmrd6mdlu5hlC8pw2mDBqXLNASgqt5xsbNqZbqisDiCtvpuXb76ahRkG7xlxVdUYzTqZSxemQXHvZQQoPRlJblkON5AQfz4yKMJ86xDdVt/2pkmq369V7IRsJPqJbVkl545dAL/nEy8s0vNLYfi3hGNqayxi8jT6eTbzwn2oj4HfVFEJlWB+xHWW6+pxLrGRa/FOtrNxxLvxv7ozS1e6gVI79O+GDZYaRskqW9jA9WWmHoRU0fMwDS+agSBYbmfLY18wtLoGZxO2+IkEnBxwkZ+I8Tm9Hxda23luzdOtGH7GQURVspRF18dqclIQlYbLTFNfq6JA22GlHEXLLrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7G5UP4kzOPlAtQ8gv2LbcXFF58bgurE3JzYyjzDQpqE=;
 b=Pel6UI9Y0Ow9FOBzvRZy2h1DIcBo/0+qnmLXdk7exiAdnPADqDY3L55ePf0cZBObn9FCqAodfAQ43yXoq0BJCTapP/BhbIa62VrWr+8g9n9h+SuqqeKVqUWnqQDnP41XgD/4xaIV+59bD4jAlkdyca8iLLleF9Yhau4IP+7DiUP/MfoLZ2nGyZ6cLvDajfgffQafS831amCq3G3hhmtUlH8S9JlibftXze/MkdyHXarOhzlDWFChdN86II6xW/Gaov8yiR5q3WI5RwjuEx9Hz7iOEVbGD5+nsHSn/WjXHHhNCi43p/hD6CwAymETjh5QkutrgmM9PlPNon6ICVerXw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by GV2PR10MB6115.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:7e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.4; Thu, 5 Nov 2026
 06:48:39 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0615.003; Thu, 5 Nov 2026
 06:48:39 +0000
Message-ID: <edeedc71-4d4f-4f96-84d5-1d9e7313148c@siemens.com>
Date: Thu, 5 Nov 2026 07:48:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 03/12] wic: select the A/B
 rootfs image via WIC_ROOTFS_IMAGE_TYPE
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 felix.moessbauer@siemens.com, cip-dev@lists.cip-project.org
References: <20261019102541.672620-1-quirin.gylstorff@siemens.com>
 <20261019102541.672620-4-quirin.gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20261019102541.672620-4-quirin.gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0196.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::18) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Return-Path: jan.kiszka@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|GV2PR10MB6115:EE_
X-MS-Office365-Filtering-Correlation-Id: dff63c07-ba8d-42e9-9b4e-08df3b08d2e7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|6133799003|18002099003|22082099003|55112099003|3023799007|10067099003|56012099006|261022115727099003|11063799006|4143699003|261022075727099003|261102123227099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: 4o8at0Vo2Q0PXjw8qYUNooCV1dGMvwxfMB/K8c6BjHzyuET5q70/NaqzPv83VzbiCUKJubHjjQS/DrTk7OjL61fEeYma6+cAD9uYzVuxcrYqyFqp0qIqux6+bQxE0D3b47Za/hbTBWZjJvWf6HIHzXikZjkN4iniqggYDyjDTf6GVOxg5MR2ixHcZZN5jCaCo/nmRQobgX7ZorOXPxF0eIu2FTEq1+FwmVzaD7bP2+OYdiZQZZO4tY2ey0vyPnsWBunTwVPCEKuQPD8LqHBAvZ8gkWbYT4sP3gFljA6j6H+93EZTflTia9bSSuR2rXKuUhbxLIqS5kkZg6Cq1vy3995IsKG76oNKHP2UKim0cVcdEhSx+Y7SusMBUDfll7AQPq0FqPSG73imAA51XEBtgz5uPMDFWN0gUFMV93sbYFIsbqW55OrTEl4mX4AxegISeEpLf6bDoMZGHANMWFTy4xQCWS1uOU2OsHCdxPxE/fyEYI4qOnec5HHoOGVFRhmgDtWyLUrT3CRq8u27K6WFmaaLOgw8Kohd5NcpHh8y9Q7Sm6B3imS2pCiUnRFGvEsTAeCeP4Rvo5Z/9ijOhKDs0ZYbYWy1mmCz9vMrXNsp2ZamCsOgO0VaJxpFvyv1NdkFcy9SaJJZxfOtTh7oWiVSyuYmsezuEGJkcjj8zPiKREw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(18002099003)(22082099003)(55112099003)(3023799007)(10067099003)(56012099006)(261022115727099003)(11063799006)(4143699003)(261022075727099003)(261102123227099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDVyTGRqbnRETzdUKzZ6MVZZUEZqRDU0b0dDY0VqRCswWFBqekNLTmtzOXFy?=
 =?utf-8?B?eFRlTXh4czNGTk5CbW1HWUZFTGZyeXp1OWpGeE5KOGcyR3U3MlNFVHJwQWJV?=
 =?utf-8?B?RldlaXlMY1VqMzBxUDJOb29uUmhDNmVSTUZRV2N6WCswOS82OTE5dWV2YVgw?=
 =?utf-8?B?eWVza1dNdjhRVk0xRnpKRnAvSks3MGhnV1hFU3FOWmw4VGJoRm5PbnRNalpm?=
 =?utf-8?B?SGxOQy9yeHVseU9MVGJnNTJwdzRXM0lWQW0yb040ck56RmJaV2xReWJXSXVx?=
 =?utf-8?B?dkdaUGd6Qmt4N2kxbG9hdnVrL1lqVEpwcU5KQUI1YTBNNW5kOENSb0MwMG5a?=
 =?utf-8?B?bU9LQlZvQUEwSUNVS3hmOUU5S1BPRkNLYUFUQ0hlNGl4NEhWQmRxWEdvZXd1?=
 =?utf-8?B?U0N0NFNFb0pDK1ZZL3dCY0FsYkRrTUlFbCtyNWFrUjNPSjNrNWtFSDZSa3Y5?=
 =?utf-8?B?WGxWYmxXMkFoNEpoT3NlYlV2ZWtXTkZXWkhWVklKVnkrT29LdW1SUkdQOFoz?=
 =?utf-8?B?KzV1RWNZNnRmVWdEeGVxMmxRamtJWWNhZTBWekJDQVdRd09rMzNVV2hkaktG?=
 =?utf-8?B?N09QWUVSdXM2T0hZMzhGeEYySm4vdHVpNDdZRllXdXdEUTlqeE5oZTdhelBh?=
 =?utf-8?B?N2pldENwbXlOUUF0aWp1am5EbXBlR0did0dCVWtzZFNRc05vYms5U2J1VXl3?=
 =?utf-8?B?SVBPbTNvUzFFY28xV2lmd1E0L0hqSU9qbXdaL1FDTE1vV3lpOStTWlc2cFVv?=
 =?utf-8?B?RVBscE1xSzAwdFgzT05zMVZCNzAvb0lSakdmeG8yMmFEUCtTVDNBOXpWRWpz?=
 =?utf-8?B?N2hGRmk5d3lmMG96ODBZNW9KVEhpbU52QmdhK2xFaHFTYU9sUmJxRWFiNmN4?=
 =?utf-8?B?eldYUDRlbUVnVnVWNWZIMEdBaW5TRXY4TGdmbGcxemNvTXpvcGFWZDZKMGF1?=
 =?utf-8?B?ZGY4VHQ3alpDYmtBaDFNR1F5RHliZUdOSXdKOVZTS29qYkx5eHArbXBDTHRV?=
 =?utf-8?B?dWt5enFrdmh4bm1oV2c4RlNwK2NxQVZVWnUwU1R2UzYzUWZmQW9CdTlwRnJx?=
 =?utf-8?B?WUxLT29EaUo2ekhZZVJLVU91OFhkMHlIWDhHRlhWU3JjczhyeTlMNDV3NmRp?=
 =?utf-8?B?TnZaU1JLdlUxMUM3UWFaNk8wSUgxeFJNcEw5bjRZTU1oOEdKbFBOSktCRFZR?=
 =?utf-8?B?V3hnL3BTK0Z1T2tQTmt4ZCt6STNqOFRTZGRQRDBVZDVNOXd5bitOMTFBQytj?=
 =?utf-8?B?bmhON0dOVjhVRWFGenRuZFh3TG9KWmFidTVZQ0lmOU16K0FDVFVwaElJOGJ5?=
 =?utf-8?B?ck5QR2tLb1pwMDd4ZkJxb0trY2ErVFkxMXROcEpHQkVoUUY4dzNWdHk2VUta?=
 =?utf-8?B?amxEWnlBeVdac3ZqVmRidEcvaVN4SjRWUlFNaDJDb1NOdUJkbWZkbWx3THVV?=
 =?utf-8?B?YmxPSEJuK3oxL0w1YWZHbnUrOTZjZlQ4eDg3SVdvdThaVUNad0tWd1dxWldZ?=
 =?utf-8?B?WHZIL0pTWVo3SEVFTXJGSDIxTlhHUVZxbXBsZWFndnZMZUhuVkNKRzRCZnh4?=
 =?utf-8?B?ZysrUjVWSUExNStxQWlEYmVLdWlsZUZUUWNqSmIvZHd2WGVMZTM2Z3lzMkQ4?=
 =?utf-8?B?UkVyN1RNYktFRnkzd3lETEcwZ1ZwK0l2SXYxUUNENzhXMWRyNjVPUC93ZFQz?=
 =?utf-8?B?Y2FzU1JSVGFWNmVVS1RBUzdTa2N1SlArcGcyVE1yM1FkTGZxQldPVW04RHFo?=
 =?utf-8?B?U1VUM1B2L0ViVnM4cHdYNXEvSFFiZjRtb0tKeG94V3RDU2VuSDZKUjRkdXFp?=
 =?utf-8?B?ZE5BQ2p3ekpZNmZ3UEhDbWwvWjBLcG0zbXRmODFqYVorL2plUGNsc1JtS0V4?=
 =?utf-8?B?VG1FNkFxOXhuKzNWUUVndi9Qak43RDJPMWI5Q3M2OExTcXNzMXhmcG1CZ3Zo?=
 =?utf-8?B?L29XOTU5eDRkVDFmais2cEs2V0JPcyszc3hNSG52MWp0T0VtZFlsOHR2MXpG?=
 =?utf-8?B?cnV6MVJGVVpNTHBUSUpRVnowc0IrQi9Dbk0vM1pkQnd3QnljM2NUM3lKdTBW?=
 =?utf-8?B?R2tPVzVPOWQ5MUthQ1RLYnJiL3g3d2NxWlAzOEN2bTFkNFMyQmo0cDhWODUv?=
 =?utf-8?B?SE5Lc0RiU2l2Wit6dXloUHhqTmY0eTFTekR0K0dDK2k0TzV6ZDdMalh1UUVY?=
 =?utf-8?B?aldiaFViQ05DRXhQY1JLUFNXd1RJaEpKTk5ETlhFMkFnUUNaMXgxaDFnS0Uy?=
 =?utf-8?B?YVpoUjlHTXhtVWNwK3JCRnFBdkhtZ2puekZsSHJwUWJCYjNjcHhOZDlCckk2?=
 =?utf-8?B?T0pQYkVsYTFwT3JjTkJvWHJpY05kLzJBYmJZUmtSa1dnaEpaRG9mdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dff63c07-ba8d-42e9-9b4e-08df3b08d2e7
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 06:48:39.4860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q8ZM8VVYU4umZHaA32HGpsnRHwarJIAeM2/OcSrmGqmOpr1tK2vC0+sOQkrVtEFse6EugpEPUgW/XWUGju7P9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6115
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 05 Nov 2026 06:48:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24641

On 19.10.26 12:25, Quirin Gylstorff wrote:
> The efibootguard wks files take the rootfs image from
> WIC_ROOTFS_IMAGE_TYPE, which is verity if RO_ROOTFS_VERITY is set and
> RO_ROOTFS_TYPE otherwise. cip-core-initramfs installs the verity hook
> via the new ro-rootfs-verity override instead of secureboot.
> 

Err, we still have both RO_ROOTFS_TYPE and RO_ROOTFS_VERITY? This really
makes no sense. Please avoid the latter, it looks redundant.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
