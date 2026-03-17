Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C95FD8746
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 11:30:46 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.13])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.73686.1773747042005070148
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Mar 2026 04:30:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ixERTAoj;
 spf=pass (domain: siemens.com, ip: 52.101.83.13, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s+oXavujZ1gEp5ontdUr+FNqz+XvejuaLse7RIq9nqSHghuNBDR+u7q/kaI/rk3HvYwkFOGC1VaBKvYjKnVWR3heMjsXcjyBWpn/sSrGyzAiZInfvWbBjlIMNolv4U21M8QYw2GJ/bZRwVlwJ8VwRX8+HFAW4W4WQfIAzZp407wPys8fsMhRDcp+fZTvLN+GZXPOcvY+mTVPtriD1ouGG5JDynvygSei8OwyXAix+Gv+o+2z8tga0nsiqE6UgqwelU+95rBp38rczK0j8FMMT+oD01RtRwKGJOh0gH9XPyvSjDYK1upXBcyw02aBZFtpesV+N85/sk62V6fBOwFXLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S1JV35Eh22qjuLx9boQu4xeMESsMNewwhb/+Re1GcCM=;
 b=xeE+tdRtrCmcZ2XTcCQeYKgn3B9lyJYvOaoOwlrArfI9MrS4j6k5EejdsRw+85ZyDLYJtVPBySjrGecWnnbk5cTxeEojH2VAQk5R4LZsgFZB2iq61IVkHYvPw4dvWdD9epJkOkEqt81xsV0HjBSzZA8c1KvnrUqGgglcY43CF/Kd2fT2bRBONHqo/eUC8vSzCxc6bK3sfsmYQvNEk5oMZvAPK5wqpRyQdXtBYdhipZj21ASPMMqldpYuodx0lhYKeM1Q6/n9Nuv4zhTCdYAABJV3hDkmhr1EcdFDNJkejkYDha7DBXUx1WeE84QWCeGKY7fPuNaYn8fPAEnHdwcNew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1JV35Eh22qjuLx9boQu4xeMESsMNewwhb/+Re1GcCM=;
 b=ixERTAojlNNE4JvOn2XFkAGuy81UQU2FyPXrPQxTzZYoskLSZj6f09V886cRsRSrQOFYQU8NesPniJlEtxxbHsd9raSZEKJMFsXguLgV7Gc/Q4K/FmYBQLYhzbuUz9k/4WO8eEAi2/yUDC5ErZQkoJfa3n7c3ZfMMAlqbldhwdYZybe0Ts0FLBa1PUFClgAW6Ti+Ey3IwMU7Sc8ZOoFXI4PQLR71gJfDbhV9m7vBeDWHKoNKDS1tOaGm1WwB9GlgfP2d2Sw/axhcKwGPmoITTQwJn20yX4Qss1JLbaIlbPqA4HhSUu8komPg6IzvjgumRoMOfkjz8dD4s5unfnp7gA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5716.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2ef::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.27; Tue, 17 Mar
 2026 11:30:32 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9700.022; Tue, 17 Mar 2026
 11:30:32 +0000
Message-ID: <f5c2e9f1-4972-45c0-b051-c8e90f6e134f@siemens.com>
Date: Tue, 17 Mar 2026 12:30:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2 0/2] wic: Wipe LUKS2 header of rootfs-B
 on bmaptool copy
To: "Heinisch, Alexander (FT RPD CED SES-AT)"
 <alexander.heinisch@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "Moessbauer, Felix (FT RPD CED OES-DE)" <felix.moessbauer@siemens.com>
Cc: "Gylstorff, Quirin (FT RPD CED OES-DE)" <quirin.gylstorff@siemens.com>
References: <20260306142213.1273718-1-alexander.heinisch@siemens.com>
 <d4adc9e349cf327841c690df4fd167fe5401940d.camel@siemens.com>
 <0216f21e7481eb83ade9c3b56ffb4dafd16599f6.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <0216f21e7481eb83ade9c3b56ffb4dafd16599f6.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0144.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5716:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d218c84-0af9-4d14-9ab9-08de8418997a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	J22blDDxbcHff85jS434+0j8O5INRGuXhfJFjuOoM7/Xsdj4IkzWSlxZssg0ciK+ToJ38QCsQuabxOg1FMXKZUN+HbbXKfO2EIwhplRNIN8sWGIj+rWLcXqltn/2M1LwzTGmAkcY8yDxlvqRQqekFAXFcv99xd57UObMXcVYZ4LDDqHu8QUiBDdYKNisKQXI3lsy7sxfXK4i5LuV+RwA/OVckNlJCnkr1i7yq/eaPKLGZ1CjDJGdpDAAsaLiqeH27TAfYhEM74JT7Oqfg5xkPlNBcqEq1laTfeVc8n7o5gUkdWoOufJVQMNlmdU0Uf7B72Fxs+JEHZn8giN37msrf+3yFF7ccB0EXOREtcVVG9UVcv9aeALfUMTK2RTCkEsLAH/ULEF794iVEvUCsbWC0X1SoS5K66qzV7ubKca02HeSMRrzrdwXYEN9eEBZ47iFx68yweDayYiX9+79IqGy3WrktB+TtqbW+ItUALdljed7VTXch1iyhVdkJRmz3rfeDCChvxbE0udPbdRa4JVM3+w2b2k1sHw5uDQQV3rHdPUbLe2xgEtaqPTaQLcIYZh+6PV5n3LcePfSalP/LR1rFWgl0HckBoChGVR/YCJdRd+/lmeunfkcsbXJxVsfQy4MnX8jcVQoof7QtYx1UL5XDcxd/1n6miCU+UXWYdcI5LVHtu34MWw93OIszQLG78p9TDjWLaK7tyk+UWc36AgFC5s4FlYa0f2zmTQJiQ6nhK4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SlBkTmNNbElQdVM0eVIwTmtaRFBObGx1elFqK1UzKzJiaEQyN1g1WUF1WmJW?=
 =?utf-8?B?VXhXOU1CQnc0c3l5TEsxVWdJZVJmZDlCdzdCak5ldDdhaE1lYXBEcGtLN1J0?=
 =?utf-8?B?MVZLMUplUVE3QTJXZjAvMUVvZUQzb3U2WDE1U3h0eWozZTVQaGRNbHQyVnh1?=
 =?utf-8?B?TXV4QkxOR3Z1R2ptb01yUDdGZFhQRTNmMkRIZGpwVnlGcmdJa28zT2l5Unpy?=
 =?utf-8?B?alVtUGVGMnRFdThFcUdLOFJLeDRwcWU3bE5MRlVwMm1xVHdkY08vanFQTzRG?=
 =?utf-8?B?ZFZ6czlGTllMWUlCaFRPb1ZFbEdldy80TUZQcFQxZE9pS2VZQ2hhNFVZQjls?=
 =?utf-8?B?bU9EM2txNGp3UDA2Z3ErMWs0WlRHS3czVFk5MFAyN3UxcUllamJnTUdlRlp0?=
 =?utf-8?B?S2d1aS90anlWclZ5Q0Z1TmEzdlNCa1Q4VTVNaXV3VERsNXgyUTc2OXVSL0x0?=
 =?utf-8?B?bHV2SXBLeHh5RXE2ZjZXZjhqWldNTFlaeDdXL3phR2Fma3BkWkw3ZG1jcm9k?=
 =?utf-8?B?eGtobFNEeXZqcENJVnZhSmZDQWErdDZQZ1FiVjBnR1hCL1BvblNDc0RVVkpR?=
 =?utf-8?B?YVBsSUJZUGo3UDQ3YzJGSCtZV09zQlp3TU1ZbE1sMjhPTFBDMU8rYTludkZX?=
 =?utf-8?B?cDZYYXZnMmxGVk5jdGl3UmVlaEtMZUJ0aS9yWkZNKzNvTmFMYVVNTDRLb2Ju?=
 =?utf-8?B?cVg4ZUY0RUliQjlxeVRiaEloQlpaK05tRWthWVBkL244VHlxWXJ3SFlxbzJF?=
 =?utf-8?B?UklORFRzbXd5dmh1ZytBQW8wdURaM3BtRUdSejkyakJjdkhENi85U0FXNzd4?=
 =?utf-8?B?eTFkbFd1cWpNRVplV2hYc1dNUUdUemh5Zk5EY085SEZwL2tKenFmMmRkd0dj?=
 =?utf-8?B?TUM1amtkUFY2MzdCU3dHTGhIcGlrNTFYMEZrMW5jaFhwYkR0cFFMT3VLV21o?=
 =?utf-8?B?Y25Zc1lJZzUycVk1cjRrR1g1WTZkcGtnS1UweFdERkZnMHFuVWlEQkpZQUgz?=
 =?utf-8?B?UlBmdHJFb2RtR1k4KzdnSFlNVzN6VHBNTUYzVkdrTjl5SHFMOTltSjluT2Rn?=
 =?utf-8?B?blNZbXdJdmdhc0N6bDdHZ3pnQ1dHUWdyV2dMYzZnMW9nV0hvY3prelBBazcz?=
 =?utf-8?B?bXRwL2xkQ2dTbTBkZmY2UlM2NWFJRDZ2cU13L0F3Zjgvc2F2WVYxTWhPRTZG?=
 =?utf-8?B?NGJXWUlNZEpWL2Q5RVVDbUdPTStidkdQMnhrWXZrTStBRnZBaTBNRElTNU1j?=
 =?utf-8?B?aW0rUkMyQTJYdXRSWVA3Y1pwRUFiZzNnUC9TRStnazZ5TUFqTjlGNE0yaWZj?=
 =?utf-8?B?R1M0dVN0bU5HaVlyNm5tOFhqTyt1d3ZHbldxeWFJbmh1RE1Pa1IwUUxoMGE0?=
 =?utf-8?B?TjBwM2tHK3NScmZLOTR3enM5aEQ3RDNtMWRGTmlJR0drV3pLZUVvdENWczlK?=
 =?utf-8?B?ZlI4Qm5QWTRZNnUvaXo1L1dlTHl1enB4T0xtSVlscGJPbCtNelk1SzN5bDlq?=
 =?utf-8?B?ZTBVSmZjOVdmWWlRU0pkbU9hYjQ4aXNjY0U3akxOZjNReGlMbmdJYjJJeEJG?=
 =?utf-8?B?d084VnBzdjNDVWM5cjVCdXRQaEdYalN4REVHdHdCM0FkWkRmZVNTZUhuWGlK?=
 =?utf-8?B?VnJCZXZqRWhrTy9qamsvbzVHVE93WlBGckR0UHBUOEhiVUtwbndJalhtRXZD?=
 =?utf-8?B?NlhuL21GSThrT3YxNXUxdWZFN255R29jTFdTYW8xMzhFSzlIRkkzS0JXWkFs?=
 =?utf-8?B?TCt2QUhvZHlZZzV0T2h3RUloVFV6cWhFMS9LOGVCZndVSGViSExZWndoZEYv?=
 =?utf-8?B?SG44eGlXZk5sMDlvSzc0UjJkUkkwc3ZrbUlyK0UvMDVwZmFET2lNUlBBRElK?=
 =?utf-8?B?VjhHS2RyUG1YMHpjRmpHM3JIRXhtUWxGUElTMkZ1NFl2cTBoTUpKK3pxVVF4?=
 =?utf-8?B?NEd6VlVZdWlJY0hwd0h0d3dnbFEyT1NyMEN2NzAvNFFraERwaW03WUF2OUth?=
 =?utf-8?B?UWRWSTJUYkhYTmFya1ZJek9COU5UN0xBUzJhdFVZcEpTekZWb2FUaUxVVTFM?=
 =?utf-8?B?OGFWS3Z2ZTgvZiswa1VKaGhEdGp3OURCU1Y5b2ZlMXA1UVhVUFY5YUtUamdp?=
 =?utf-8?B?ZmVMb2pvRWNQNnI0VTQ5N2VHUzVTR1ZIdUtmcXNxMWNKUVRIY3B3V2dMT3dt?=
 =?utf-8?B?dytNcmFYNVZMeWFIOTl5WStKdjFQVzlqRmxzcWZIbFRRZW1vVXlLbUZKTlc3?=
 =?utf-8?B?N3liaWJWZEc3eDExd0JsVnVJZVJERzRtMFdSSGdrRlFYU2tqNVVlRXJ2SnNw?=
 =?utf-8?B?a2FFcGlWeDlZNURxcEpqdFR1eEpOOVNYVFV5S1V0aTlRbFdZS2ZFUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d218c84-0af9-4d14-9ab9-08de8418997a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 11:30:32.3776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UbUW6XBXG5pI5N78W3PD1QfUFCI4N8X2vpwjFF00K1aj0jU3bD8fH2+/9jqRjsvrKN1d5Ofp919FyZXVvo4ogw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5716
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 11:30:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22473

On 17.03.26 10:32, Heinisch, Alexander (FT RPD CED SES-AT) wrote:
> On Fri, 2026-03-06 at 14:29 +0000, Moessbauer, Felix (FT RPD CED OES-
> DE) wrote:
>> On Fri, 2026-03-06 at 15:22 +0100, alexander.heinisch@siemens.com
>> wrote:
>>> From: Alexander Heinisch <alexander.heinisch@siemens.com>
>>>
>>> To copy images `bmaptool copy` uses a bmap file that maps regions
>>> that actually hold data. That means empty regions / holes in the
>>> file
>>> are skipped by the tool and thus those regions on the disk do not
>>> change. - That's actually the feature why bmaptools exists.
>>>
>>> When reinstalling an image configured to use A/B-rootfs and disk
>>> encryption
>>> that way, this results in a LUKS2 header created for rootfs-B
>>> during
>>> disk encryption setup of the previous installation to remain on the
>>> target.
>>>
>>> The problem was introduced in
>>> 63eef2b4fb5feb393f97cecc4f432688403ded5d
>>> by not copying the rootfs to rootfs-B in the target image, which is
>>> actually fine,
>>> but needs special treatment in case of encryption.
>>>
>>> Based on discussions in V1 we decided to generalize the fix to
>>> apply to filesystem
>>> headers in an A/B setup without disc-encryption as well.
>>
>> Reviewed-by: Felix Moessbauer <felix.moessbauer@siemens.com>
>>
>> Thanks!
> 
> Anything missing for this patchset to get merged for v1.11?
> 

Thanks for reminding. As I wasn't on CC, this would have required /me to
refresh the patchwork state to catch your series.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

