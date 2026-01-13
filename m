Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E1CD2F339
	for <webhook@archiver.kernel.org>; Tue, 13 Jan 2026 15:26:53 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.61712.1768318011764668041
 for <cip-dev@lists.cip-project.org>;
 Tue, 13 Jan 2026 07:26:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=XMSqACy7;
 spf=pass (domain: siemens.com, ip: 52.101.84.57, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v897fY/6DP75D+d/Fd0+aVSzWbgLN7XZiEIvDlpzrOFWh8gVMzJRBz8Knh128famw2MeEAUcvRyRNcMcf5HTqro6SFsl8b4/FSkVjJmLQLF3cGggv5OYm90Zi8Bay7ZxrYbfrGsz80j24tufnmGg1AFq032gKpy7vPpOMFzrS/lDRqTG9brFuEGQqoj177PDakEI/iLu4DGgUcs6kGQQHAGL712fo9N+mR8bccAlQHDm7AAz3LDUjbThY8EpOajmyzq2hyf973oRvUjZQU+oNpCMp7xY/u7FF9QxCI8FdvG+RGaa4rB6pZ49DblM523xxqKOApc90+Ryb6mhHnw8nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12nqtDa4ONwUC5jKSwgsaGqYPfWOzHq6MbBFfvw0Jkw=;
 b=CIWPxDJ/ASaIbigMFHXDnl+9bS2pksIr62qNnwEXiNRxUwKv9LnuifkvlF+yyxpCl6lkG/KdytAF3qjsX2wEvZbn1BAcH5y2Ueuf6YqvxfulCniIahM0M6gMIjCLgkKxAGPzhU4oG4jLvcYmtwBVUh32ecAkccKS21hF3McGQzbjW2mwD2VcMZ2sSMwM+IbgGKWSFwFnOvpg4s+EaTwjOPHvE2t+ISwCswKR/FWc5QyCDGz9mJUOIHS62nhOJe2HB2wkM3UzBb3AmSGnnPjxqt4S4bQNPvX3/u6hoKWpHWbwJbePmeZ0001JWAaJ+Ln9b91UxMxpLC7V9SfiqTPx5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12nqtDa4ONwUC5jKSwgsaGqYPfWOzHq6MbBFfvw0Jkw=;
 b=XMSqACy7lKRdH1EuNHKR1FSBObl1suAVuht04O1OAI8RoXtbj7XJiCqjPmyj8UWCdkzbOw/4p0F5F5drpRO8Z9pBqzVmALiXjSc8V/ndyFIbYTaPJZEAvQCmTiMAkqSfgQfvVG0fUt6gPoRqL5AgO49Id3yCgkcl4ExUx2aC7KjngLYqa4EJWTrif6xci03Bjngn6D+bnFAk4S92pxreIfYdTsfl959rzo7s6Zt7sLLBs9yV1ePXTlw1QgKWvrzdzRpaPpCxHhrWXvrU6hxcvVy4veA7QDCGOExRBx0CFl4QWaFLOPheWSJrA2MJ+6R5lAPIfSHVt9Iq70GnI45cMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:89::19)
 by DB9PR10MB8096.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4c3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 15:26:48 +0000
Received: from VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ec8c:43f1:36b1:3314]) by VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ec8c:43f1:36b1:3314%4]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 15:26:48 +0000
Message-ID: <a4494e98-5cce-43f3-981d-1d1e7c437ee6@siemens.com>
Date: Tue, 13 Jan 2026 16:26:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v3 7/7] rename
 recipes-core/images/swupdate.inc to swupdate-ab-rootfs.inc
To: Jan Kiszka <jan.kiszka@siemens.com>, clara.kowalsky@siemens.com,
 benedikt.niedermayr@siemens.com, cip-dev@lists.cip-project.org
References: <20260108151650.124306-1-Quirin.Gylstorff@siemens.com>
 <20260108151650.124306-8-Quirin.Gylstorff@siemens.com>
 <1d429182-d79c-40f2-a412-6240038436bf@siemens.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <1d429182-d79c-40f2-a412-6240038436bf@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0004.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::14) To VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:89::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR10MB2319:EE_|DB9PR10MB8096:EE_
X-MS-Office365-Filtering-Correlation-Id: c7013f49-af9d-4a44-f421-08de52b82acf
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?NnJzbmVwYlR6YldBeE5NdXErSEVxME5HekJoRE04dlJSK0Z6NU9JSEUyc0xI?=
 =?utf-8?B?YUdwTzFtaEQydXMvMmx4Z1pjSDNzbjJpSThyS3BIZVhaZUpyZlNVcDYrTWtr?=
 =?utf-8?B?Y3FiWURPWU5ZV0owLzNaQ01HUDFxZXBwbndvZVExWUR4QjNsSjEwakRnZUxv?=
 =?utf-8?B?dUNNTzJqNnd1NGo3UTN4RUhENlRTb3lXYjFVMzYwZVhqSnRZbHZ5QTdKb1FP?=
 =?utf-8?B?cmticURqbThGVDNSQ1RDcStDVFg1R0JNejh3M2pCcGgwSEUxL2grRE1Kdkl0?=
 =?utf-8?B?bWt4ZnA2U0hHM0hGZ2IvUGE3a3RuMjJsdXdlL0hRaC9SdjJ5d1lUZ0d1MVZO?=
 =?utf-8?B?UENibnJDaDJWb2VVUjNjdzRKcG9kU3pEcW5ZYVVIek4xZVpXYy9LUklYdGh0?=
 =?utf-8?B?TEozUldZdnQ4ZVFNaVo5Y2hzamVuOFpFbTN2TDhDMmdyM3JOUzN5aFI4eERk?=
 =?utf-8?B?K3ZaVmNRai9MbndWM2xIaDJXL0xueGtoU0doNWt5c1dxS2I4bi9XanQzWm84?=
 =?utf-8?B?Q3czVVhhRHBsR0R2VnF0YTNPUkIveGF4Ryt3VWw2alJKZFloQjlmWlBLS2R6?=
 =?utf-8?B?N3Foc2pmWmhVK3ZmQloxN3dnbDV4UFRwa0dSZTNaQURxcDlick9NSTM2NHJm?=
 =?utf-8?B?eDhMT2lYUHBabjNsOWcwaVhXR2NsRE10OTZNaHdOUVJOci8rZ25FRiswdlhI?=
 =?utf-8?B?UjBJU2pCSzFUaW5ER2RTSUVGcHBReUhyNDRQWlA2dmYxOEl1bDZVSGNjb1VN?=
 =?utf-8?B?c1pNaFVBSmgybG9FMEdjTW01N0tWVXl5RGk2cDBER0J3b2t0UnovVy9KK1d2?=
 =?utf-8?B?ajcwdTJ6c1crb0xIRmRFMmRZVVAwZlBoZ0hOa25IejBxZXU4WDNQM29xWlhq?=
 =?utf-8?B?a0h6czJFR254dWFxOVhqWTRhOWkrYkpSM1RrcWs4RXROTjBSOWJhZkkvS083?=
 =?utf-8?B?RENyandvT0lNVXJydEM3cnhSRitNR1hMRlNCVVlVOHBYblREMHlBWFlKWGdj?=
 =?utf-8?B?SUdrOUlETDVJVHRibStVRE5TcjRHSCtLOXc5R0M2Y0dwUUlmTWdCVmFPNDM5?=
 =?utf-8?B?R0hjTUFjRGM3dXVGVzBySDFpSkRwTE0rbHNkMFg3dWFRTmFWMDhWYkRMSUpn?=
 =?utf-8?B?bEVUcUlIbVF5UElzVjRhRS9BWWhlZ3ZuVCtFMVB4a3oxN1h0cVdYVHJMaXlj?=
 =?utf-8?B?YkwrTFIyTitrQkUrVERKR0swZjJOUWVMcVhwMGEzY1FNWnRkbTBlKzh1NWpG?=
 =?utf-8?B?T3dyRSs5MVlMQmhxK1p4akgzenNnMGo1WndHenNLV3lYR05PMVRnakhCQm1E?=
 =?utf-8?B?U2NtODhyTzVCU1E1MHpwdmZQb3lXREltNEcvZU5taGdDSElCS0l4TDdwVG1L?=
 =?utf-8?B?MmpGRnNhS2JGcFZzSVFna2RoWWd0SGtrdUM2U2NQUzBvenFOZUpqRkE4c25Z?=
 =?utf-8?B?Rm50SDVtRmV4QlgrZ0QrMDdDYVFuZE85M0g1U2dVSkdQdmZBTEpuckFSQncy?=
 =?utf-8?B?blU5UGhSamd1OWZURXZNYmhqOTc4WjZpNlpNT1V4UTlkUkdmV2llZ3FRUXpJ?=
 =?utf-8?B?ZDduSzJVRE1aV0hETitxcWh4M2JrakhFMkpLVlVaK0hvYWp0alZrTXloVFR5?=
 =?utf-8?B?cDdKN3gvRzY2YlRtRkczNWxLZWw0Vndxc2FCanFxaC82MFV2bFhVQVZEdE9E?=
 =?utf-8?B?STBlMU9pQmYycCszWnU3c1lnZDFld04yNE55RDRMRGxISy9aOEhEMHZ2KzVz?=
 =?utf-8?B?NTRDYXdPUzY5YXVFQ3hsR1BudWhXM21SQ3QyT0xUZ29YaFpXamN4Tmc2T09E?=
 =?utf-8?B?RWs0NFVDOCt5aU5YS2pKNHhFYXY2QzlHOVJYU3RSdnBWOTF0MjVGeTRpSnlY?=
 =?utf-8?B?V1IwQVd3Um9kcFBZenBON3F3bzdTaGkzUzhnMnJVa243TWVGVlF5ZDBwS0ZR?=
 =?utf-8?Q?hrsp5WCD2sOaEfSWAo+aI726zj3fB+Oi?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UmdvYzkraDZhazY2UUd6WjVyRW1MYXpEaFVaUzdQWkxPTFRQbkpyb1NkUENP?=
 =?utf-8?B?MHhSKzZtVktOYW9CQ3pZOGpBYnNoaWRjdkNlUWdQZWRYR1hFNjN6eE1hZFNZ?=
 =?utf-8?B?STh2anlPY1Nnb2cyZVg3UmlIRFNEeDJKbFEvZUFrMk5KbHVycVYvVjV6TWJv?=
 =?utf-8?B?VzRXY3Y4UXcxNDRrM3FwQ3NtZFBqNFdZV1Fia1dpMzZFUkx0UVFEMUpIMDhU?=
 =?utf-8?B?SS9EbklsTEZrcmNxMjF2alJkeEVmT1NBZWhwSFZYZzZQU0RtNjUrSnFKWlkw?=
 =?utf-8?B?R09hRUw0Z0VBbVZqNGdlMzUrdXBiODM1RGIwWjJXMkpHMXFETUY1RUNVK1Fu?=
 =?utf-8?B?RGhlelRtREFGQW0vRjFPUXJMWmg2LzJtZ3F3cnA3U042SWFybFlpZklIWWhv?=
 =?utf-8?B?ZGxvOTZtT3BFQXZSL0FsSTlQYVpWdUVWZnhOaXorMUpscXZ4aTdkYndUcVZJ?=
 =?utf-8?B?K3VoZTNpMDgxcGM1T1U2aUpjdFNnOTFSRUxqUUlGb3FtL04xTlhUKzQ0Z2Ri?=
 =?utf-8?B?cWJpYXc0L0QvcUFWVGdDSlVpM0xDSCtoVlZmczQ3UHl4K1JqWE1EczlPTlh1?=
 =?utf-8?B?YU50N1RwL2lKbjZpSGZ3V1BpRXQ4K3ZRdWdybUtrdFN3b1hhczRnUkw1VzN0?=
 =?utf-8?B?bWJSVk92di8yaXlqeFpjM2FWSVY0VVBlcEY3ZXp5UTBkQXZSWHJnNThzOTdB?=
 =?utf-8?B?TEVDdFN3Yzc2S0dKUjlPejA4cGdmSEJOOUx5STdURTVGbS9BWm5EdmpQd2dG?=
 =?utf-8?B?ejVkN3pzOE12dVpDbVJ1Qm02YlUxMGZqN1g1T2ZDbWVqSE5OOVJ4blU5am4r?=
 =?utf-8?B?ckRtYVNnMVJyaHNFV1BPRFZxT2xPS1YzVTRvYWZ6MEtRd3JvWmxKRjhMZXIw?=
 =?utf-8?B?SXBWWStvV3BZbStuQldQNVB4RGFlR29lMzJTMmk3WWVpNlRFeGFpblk3c2d5?=
 =?utf-8?B?RllxT2hZK3NXVVR0cHhNQUNiODIraFBuaVAwMGZaQVRKTDVycUJHQlVXSUdn?=
 =?utf-8?B?RmxHUlh5OHA4V0NXZjNpSm5ja1VqamtSbUEvVE1FTkVBR0NBdkd3ajdBaVlm?=
 =?utf-8?B?aXRFQmFIS01VRVJnZVVZM1U1RzZIS2toSElkU0VreHlCb2VWM04zM2tNRkFa?=
 =?utf-8?B?bVVibmdjdW5VampuL2tDUHNYUXlKSzhFUGk1UjJpZHQweWo2QXY3d1dvaE5W?=
 =?utf-8?B?N0VaZDlvM3VMUUZVL24xNFBGcEdqeTUxNllJYkhXOStnOGdCeHIxTFJXQWh4?=
 =?utf-8?B?M1FKK0ZvRXh5a3BHelR5ZXMwZ1dMNk8vTlAyL1VkT3NuenRBMWE1ZERRZ0JL?=
 =?utf-8?B?cWg0ZHl2ZWV0UVkraC9aTlNYaTRXeWpWTzdMM1UzeU5WNTRMdnp4alpEdmIr?=
 =?utf-8?B?QkpDYzNpWjBudHNqV0k3ZGZGK3BMOFJMS2hJYTloSjJLOUt3Zkt6RlBRNDBt?=
 =?utf-8?B?ZU05b1JReEhhTE9OaTRidlhXM1htVGUrZUZ4M0MzS3M5c0ZvZkhXOWVNcVJl?=
 =?utf-8?B?Ylh1TGxqcFMya3Vna0wxOGJDcnRjdnZlQ2FVdVliRXI0YXV3ZitWeXE5MmFs?=
 =?utf-8?B?MXlJMWJwSXZETE0ybzFrbHRTWWVESkxvSDlsclRnRElrOG96aWZSMTVsdk1U?=
 =?utf-8?B?U24welJrSW5pNjdaaDBhMlpCaExSdGVtYkg4MVdCUElkRGJROUYvU1dmcTJD?=
 =?utf-8?B?dWdQbWRoa0hBTFl0WHgvUU1LV1B3RjVoYTIwY0tpZUF3ekRiQ0RQM3Z2M0dF?=
 =?utf-8?B?WWZ2SVdQVEd2YlRTVFRMSXRxM0UvQlIweTROeFFEUjd4aStsdXRuQ2pmU0ll?=
 =?utf-8?B?Y2xSdFBoMFE2N0NjaDVBK2VGK3RlcFBHRm8zNytoZm9yMkErK2FoYzQyYVYw?=
 =?utf-8?B?UlFZalJzNSs4cXd4dkN3d1BqSXdwTms2SUE3amt2YVF1QmZ5RWlMZCtNOE9r?=
 =?utf-8?B?L0V3Q3ZmdzkyUGJZenkvZkxSVWptckZYN3I1OE9sK2IrRkdsY3J0elRwekNr?=
 =?utf-8?B?WUxYT3ZJQXBtMnp4SC90aHdoVVBDMHhqbmlRYmwyWnZYTjd0QXRXcDlqaVNo?=
 =?utf-8?B?VS9ZQ0xlT21Hb09rdjVqRGlHcEZqV21OVGVRcE9RU3JnckNZdzNjRjhpZWp2?=
 =?utf-8?B?eTBiL3ZFMFJHMXU0MVZ0RTMyNC91UldRdS9UWVQ4Y1oxc1h3SVhiMUs2VlNJ?=
 =?utf-8?B?VHNqNnBycmxLSlFUS0tpc3RTb2tMekNWNGVkRlZmb2FkZGNzZGxtMVJTOU5z?=
 =?utf-8?B?b0owaHZJMytraDlCcVAvNkZUcC9ucmsvTmwwQ01rdW9yR2NkbFEyNlQwWnFU?=
 =?utf-8?B?YmdYVk93NXc4b05rdSt0R3RnYUVvRGM1L1JJUWl4RS9uVW92Vnh6RU4zSE95?=
 =?utf-8?Q?ejYsCqoS/BlamF24=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7013f49-af9d-4a44-f421-08de52b82acf
X-MS-Exchange-CrossTenant-AuthSource: VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 15:26:48.1502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aI9pyoYMVnepgl/ea7e0GP4KeviLQc3yXK8vV3X2FoH8/2XV2Xt2pkZVYBGlzQNfVmcy968+0QkiBBYm9lK2ID04jWDtG7lARbm+s3yzlSs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8096
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 13 Jan 2026 15:26:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21536



On 1/9/26 11:27 AM, Jan Kiszka wrote:
> On 08.01.26 16:16, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This clarifies the indented use. Use a include file as some
>> defaults are isar-cip-core specific.
> 
> Why does that rule out modelling things via a class?One issue is the CIP_IMAGE_OPTIONS which are currently model with 
require. We would need to change that. Also we have a coupling due to
the include of the swupdate-${SWUPDATE_BOOLOADER}.


 > >>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   doc/README.layer-integration.md            |  2 +-
>>   kas/opt/swupdate.yml                       |  2 +-
>>   recipes-core/images/swupdate-ab-rootfs.inc | 61 +++++++++++++++++++++
>>   recipes-core/images/swupdate.inc           | 62 +---------------------
>>   4 files changed, 64 insertions(+), 63 deletions(-)
>>   create mode 100644 recipes-core/images/swupdate-ab-rootfs.inc
>>   mode change 100644 => 120000 recipes-core/images/swupdate.inc
>>
>> diff --git a/doc/README.layer-integration.md b/doc/README.layer-integration.md
>> index 1e1973c..5ba6259 100644
>> --- a/doc/README.layer-integration.md
>> +++ b/doc/README.layer-integration.md
>> @@ -19,7 +19,7 @@ with /etc as overlay. It also installs and configures efibootguard and SWUpdate.
>>   An additional image type is generated with contains the update artifacts.
>>   
>>   ```bitbake
>> -require recipes-core/images/swupdate.inc
>> +require recipes-core/images/swupdate-ab-rootfs.inc
>>   ```
>>   
>>   ## Create a image description
>> diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
>> index c5b7c61..3c3c93c 100644
>> --- a/kas/opt/swupdate.yml
>> +++ b/kas/opt/swupdate.yml
>> @@ -16,7 +16,7 @@ header:
>>   
>>   local_conf_header:
>>     image-option-swupdate: |
>> -    CIP_IMAGE_OPTIONS:append = " recipes-core/images/swupdate.inc"
>> +    CIP_IMAGE_OPTIONS:append = " recipes-core/images/swupdate-ab-rootfs.inc"
>>       OVERRIDES .= ":swupdate"
>>   
>>     wic-swu: |
>> diff --git a/recipes-core/images/swupdate-ab-rootfs.inc b/recipes-core/images/swupdate-ab-rootfs.inc
>> new file mode 100644
>> index 0000000..6858a31
>> --- /dev/null
>> +++ b/recipes-core/images/swupdate-ab-rootfs.inc
>> @@ -0,0 +1,61 @@
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Siemens AG, 2023-2026
>> +#
>> +# Authors:
>> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +inherit image_uuid
>> +inherit read-only-rootfs
>> +
>> +SWUPDATE_BOOTLOADER ??= "efibootguard"
>> +python __anonymous() {
>> +    bootloader = d.getVar("SWUPDATE_BOOTLOADER") or "None"
>> +    if not bootloader in ["efibootguard"]:
>> +        bb.error("swupdate: SWUPDATE_BOOTLOADER set to incompatible value: " + bootloader)
>> +}
>> +
>> +include recipes-core/images/swupdate-${SWUPDATE_BOOTLOADER}.inc
>> +
>> +IMAGE_TYPEDEP:wic += "${RO_ROOTFS_TYPE}"
>> +IMAGE_FSTYPES:append = " swu"
>> +# input is already compressed
>> +SWU_COMPRESSION_TYPE = ""
>> +
>> +# read-only rootfs with /home and /var
>> +# as separate partitions is used
>> +# /boot is excluded as an unified kernel image
>> +# is used. This images are stored in separate partitions.
>> +RO_ROOTFS_EXCLUDE_DIRS = "boot var home"
>> +
>> +SWU_SIGNED ?= "1"
>> +SWU_HW_COMPAT ?= "cip-core-1.0"
>> +IMAGER_BUILD_DEPS:swu += "${@'swupdate-signer' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
>> +IMAGER_INSTALL:swu += "${@'swupdate-signer' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
>> +IMAGE_INSTALL += "${@'swupdate-certificates' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
>> +
>> +SWUPDATE_SELFBUILT ?= "0"
>> +SWUPDATE_SELFBUILT:buster = "1"
>> +SWUPDATE_SELFBUILT:bullseye = "1"
>> +SWUPDATE_SELFBUILT:bookworm = "1"
>> +
>> +python() {
>> +    base_distro = d.getVar('BASE_DISTRO_CODENAME')
>> +    if base_distro not in ['buster', 'bullseye', 'bookworm'] and \
>> +       bb.utils.to_boolean(d.getVar('SWUPDATE_SELFBUILT')):
>> +        bb.fatal(f'Self-built SWUpdate not supported for {base_distro}')
>> +
>> +    if not bb.utils.to_boolean(d.getVar('SWUPDATE_SELFBUILT')) and \
>> +       not bb.utils.to_boolean(d.getVar('SWU_SIGNED')):
>> +        bb.fatal('SWUpdate from Debian requires signed SWUs')
>> +}
>> +
>> +IMAGE_INSTALL:append = "${@' swupdate' if bb.utils.to_boolean(d.getVar('SWUPDATE_SELFBUILT')) else ''}"
>> +IMAGE_PREINSTALL:append = "${@'' if bb.utils.to_boolean(d.getVar('SWUPDATE_SELFBUILT')) else ' swupdate'}"
>> +
>> +IMAGE_INSTALL += " swupdate-handler-roundrobin"
>> +IMAGE_INSTALL += " swupdate-config"
>> diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
>> deleted file mode 100644
>> index 7cd816a..0000000
>> --- a/recipes-core/images/swupdate.inc
>> +++ /dev/null
>> @@ -1,61 +0,0 @@
>> -#
>> -# CIP Core, generic profile
>> -#
>> -# Copyright (c) Siemens AG, 2023-2026
>> -#
>> -# Authors:
>> -#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> -#
>> -# SPDX-License-Identifier: MIT
>> -#
>> -
>> -inherit image_uuid
>> -inherit read-only-rootfs
>> -
>> -SWUPDATE_BOOTLOADER ??= "efibootguard"
>> -python __anonymous() {
>> -    bootloader = d.getVar("SWUPDATE_BOOTLOADER")
>> -    if not bootloader in ["efibootguard"]:
>> -        bb.error(f"swupdate: SWUPDATE_BOOTLOADER set to incompatible value: '{bootloader}'")
>> -}
>> -
>> -include recipes-core/images/swupdate-${SWUPDATE_BOOTLOADER}.inc
>> -
>> -IMAGE_TYPEDEP:wic += "${RO_ROOTFS_TYPE}"
>> -IMAGE_FSTYPES:append = " swu"
>> -# input is already compressed
>> -SWU_COMPRESSION_TYPE = ""
>> -
>> -# read-only rootfs with /home and /var
>> -# as separate partitions is used
>> -# /boot is excluded as an unified kernel image
>> -# is used. This images are stored in separate partitions.
>> -RO_ROOTFS_EXCLUDE_DIRS = "boot var home"
>> -
>> -SWU_SIGNED ?= "1"
>> -SWU_HW_COMPAT ?= "cip-core-1.0"
>> -IMAGER_BUILD_DEPS:swu += "${@'swupdate-signer' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
>> -IMAGER_INSTALL:swu += "${@'swupdate-signer' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
>> -IMAGE_INSTALL += "${@'swupdate-certificates' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
>> -
>> -SWUPDATE_SELFBUILT ?= "0"
>> -SWUPDATE_SELFBUILT:buster = "1"
>> -SWUPDATE_SELFBUILT:bullseye = "1"
>> -SWUPDATE_SELFBUILT:bookworm = "1"
>> -
>> -python() {
>> -    base_distro = d.getVar('BASE_DISTRO_CODENAME')
>> -    if base_distro not in ['buster', 'bullseye', 'bookworm'] and \
>> -       bb.utils.to_boolean(d.getVar('SWUPDATE_SELFBUILT')):
>> -        bb.fatal(f'Self-built SWUpdate not supported for {base_distro}')
>> -
>> -    if not bb.utils.to_boolean(d.getVar('SWUPDATE_SELFBUILT')) and \
>> -       not bb.utils.to_boolean(d.getVar('SWU_SIGNED')):
>> -        bb.fatal('SWUpdate from Debian requires signed SWUs')
>> -}
>> -
>> -IMAGE_INSTALL:append = "${@' swupdate' if bb.utils.to_boolean(d.getVar('SWUPDATE_SELFBUILT')) else ''}"
>> -IMAGE_PREINSTALL:append = "${@'' if bb.utils.to_boolean(d.getVar('SWUPDATE_SELFBUILT')) else ' swupdate'}"
>> -
>> -IMAGE_INSTALL += " swupdate-handler-roundrobin"
>> -IMAGE_INSTALL += " swupdate-config"
>> diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
>> new file mode 120000
>> index 0000000..f02080c
>> --- /dev/null
>> +++ b/recipes-core/images/swupdate.inc
>> @@ -0,0 +1 @@
>> +swupdate-ab-rootfs.inc
>> \ No newline at end of file
> 
> There is still no logic to remind user of the migration - why?
I will add that.

Quirin
> 
> Jan
> 



