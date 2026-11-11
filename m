Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5656.1794388131427326807
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Nov 2026 01:08:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=jj7SdfGp;
 spf=pass (domain: siemens.com, ip: 52.101.66.41, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pZ2HTtzg0e/SicOfQCeRnEYhOrqGcvSSLKKMV54HHvhQDJPfxqy82dDN0qj5UnzD3FsUCm8Xuapz3jY5Nzqh0XWihrzySt1HLLeKrCtsvs7WAEBAQJalURZEV0mem4XbcZ6ZYQ5MnsB0ttzeYesoru2bUdXd/FuElFqXxr7nAzZ00VyShMjrOyVz6tUCBZ7+yuJdA5DgFlC8rKDWDabMWEQXp9rFJgR8353fAbz5d2HtRRNmjtGOP9IL8fBoozxv4F1liTZgLkp0lPZXn8d/ICCNwU398Kj4yczJII/OurTakxPO3iFCcI3lQt5R1eRhcR5h+RbaIP9v3S7Tp2GWsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3SwWwNoJbDdK48pXhOsKOoHUWAwIrBDfr6OegKBka2Y=;
 b=GDDZFAN36lAuPPRETkxqBcPXBRDAOF0bD/JDuMag6+bk4JbIKNLqUDHDniukyizMh1SM/tEqdZ9HSQfjT3o3s/SlWEqgq5rfCFR/r5IezuXaw46HUpg5xkCaZKTRVEM0RxildFX5PYWsTFUckpKLQ5h0rZGyeGeMDU7fBJ1iAiTIXm7o/FaZe0K0RkYjwDfTQVUkOcdAT0AZpNpwezIOecpGhLfpp66yP2bUIn5V9mvmkcxnX1RCQm0y2AcsfF0P5LKkrR+S//zf9epJrvYBVsYA9eJqVI1hj30psN8sFtEomAKq8hlNnzo8ffu8wrDkv0NoCtf8EVZsU2JafL4U1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3SwWwNoJbDdK48pXhOsKOoHUWAwIrBDfr6OegKBka2Y=;
 b=jj7SdfGpH34NodbomubIgAcXKiHM8/R7+Gs26qeXuD1AO1v62Zc9levulG1zWoa1kXD/UmXONTp1vr+Z3z1M+esxureGNpjiNmykxKQYW8HoIMYglWI5DJCS6RvJnB84rnIokxin2ul8r7WXlvofM4f3sw2LNbWDhijzcZa5dPPz7bixm3CxXmgDgIrRRQnzVvVcA2+Z9viChTUb0Kej9DXqLuIHypriNyfqrpragJOEAHd7FFkHYHj17lZVg8TBpxPq16LnNcJ1LZtnxbPAiREzBvuQafyPCSFsdhxZWtdm2LkTq1LpfDERlZzDvdfKqHEZcCI+pu30FPvJuLqA+g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by PA2PR10MB8650.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:421::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.7; Wed, 11 Nov
 2026 09:08:40 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 09:08:40 +0000
Message-ID: <4a0901c0-0c40-48bb-b605-a759787b8fad@siemens.com>
Date: Wed, 11 Nov 2026 10:08:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 03/12] wic: select the A/B
 rootfs image via WIC_ROOTFS_IMAGE_TYPE
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 felix.moessbauer@siemens.com, cip-dev@lists.cip-project.org
References: <20261019102541.672620-1-quirin.gylstorff@siemens.com>
 <20261019102541.672620-4-quirin.gylstorff@siemens.com>
 <edeedc71-4d4f-4f96-84d5-1d9e7313148c@siemens.com>
 <84a4c55f-9786-49b9-bd16-42a9ae3dd0ec@siemens.com>
 <2388290b-53b3-47a7-8a41-39c574732916@siemens.com>
 <e17ff609-5a79-43a2-8630-28e143dc21a8@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <e17ff609-5a79-43a2-8630-28e143dc21a8@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0057.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::17) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Return-Path: jan.kiszka@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|PA2PR10MB8650:EE_
X-MS-Office365-Filtering-Correlation-Id: 19cdd6fc-b953-4975-8c22-08df3fd360a2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|18002099003|22082099003|6133799003|10067099003|3023799007|55112099003|56012099006|11063799006|261028144727099003|261022105027099003|261022115727099003|261022075727099003|261021121427099003|261026140227099003|261026121527099003|4143699003|261102123227099003;
X-Microsoft-Antispam-Message-Info: DbTFdaoPIMZE+HAHN6GyTGw/ImwoTy9qBBhV3nj38yYBebc5Ys+IUcFubQQG7WvbbZFjqAqIPX9nKEcrcx7wgxG/cK2I0IiQme9deoPFbjJBWdJ4y0shtUVC6f+KgR19I9lGe70P/xufll6Z0ELzGJfCufFKp8rs1iDx0fKjtaJD9pfxQUsV/7EVSkVVzrjKfMX2BIW/a9euIYZzBOFkZBv/Qo6zY8kM1NRkrPiK0mr8FT3hrqDMm/W+4UhDQBsZ8JzGSJLJwSiPBqPqzguvHye7pb2RxwteT6GRm88MS+6a+rBBeqmLiAldoPzxQ+36VptzqH+UajDpYt+AvUW9EeQWaaR9Lu7Mqp8yDY6pIwlKf1wbcE4wZBTP3qo5lEeZT3DxEzCV8Y1TMGwc5gasUh+s4HQC1qpZGrTHCt5hWvvb5G8BwxXfpFSmBNV4/bkRX3mDEntzk9zJYRDUpeYfp3j0dlM12+shXBjEy5Df4LT5+9lHfW6VZTfZiGkozjir4hXX/NdMGvVoLoa4Yr8UYGJM7l0oOBo484a81BdNPXyQ4woRzJ5Q7mzH+9enJUMKCsMQACDJ2oQpyZf1vM/RuCuwn+JdH236DX932iH12yCBePrs2VMi70bp3JwAEafgRPQlrNqprToDDCl9bt7srKhZt+o4R7mwQyGaJtH1kok=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(18002099003)(22082099003)(6133799003)(10067099003)(3023799007)(55112099003)(56012099006)(11063799006)(261028144727099003)(261022105027099003)(261022115727099003)(261022075727099003)(261021121427099003)(261026140227099003)(261026121527099003)(4143699003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlRybUF6RTVaSDdKbXFCQ1dUeStHQ3ZpSXJVaUpYKzFmUGVYWnJ6aFM4QUty?=
 =?utf-8?B?SFRIUnBPRUhFMCtrdDR3dkROVU9GZHljdERGRHd6eW90ZFEwUElKeS9LYUhY?=
 =?utf-8?B?Zk5BWHBIUXc2SEVBT2tzOUtldVpjOStxaEE1YnE4N25CQzZXTDZRS3Z6emh6?=
 =?utf-8?B?aGdZSDFOWW5PMFdQUFNudXZ4Zis2WXlCVFpWMUJMcExSVkFBOXpqZXJpUjFL?=
 =?utf-8?B?VjVDUTZ2SUFNc1BNeFdXSlJ5UGwwMkYwRTVONUNtcXBqRW1sMWdkbHdST2RU?=
 =?utf-8?B?eG9WandNR25Md214YWExQjd4VlFjYUZNTmdFZ2lmdGNyUVNZTFJ5SkZ6c0ZR?=
 =?utf-8?B?OFFPQ3hjTzRLcnRPMktyZlVGOTI2Q0dWS0NnSVlkRklxZnBOT1FXYWFoT0Nt?=
 =?utf-8?B?R3Uyc1FsTnJjeGhyU1N0OGlkaUp6TCt6azRtTUEwM1VqSWoreENYNGVBL01U?=
 =?utf-8?B?V1NaOHB5dDZpNjBGaUNIQlRKdVhHWnNYeDJodlhsaXlKSlM4N1laQUIzSFds?=
 =?utf-8?B?WlRRMHNmMzBwazM4RVg5S0RKMUQ1dU5KWTB4dXFMUjFWYVlaclJrbXFnUVBG?=
 =?utf-8?B?RXNudENWZExQV3ozU3ZLMGJtanZOeGhtRDJ0WXllcTNmRUNjR1lyU2tVVHNL?=
 =?utf-8?B?YVQwdzIzdW9WZ2puMUlCSnhaZi9YeUl4aXdWWmxzVGZTMng3Qzg1Qm1pUk9h?=
 =?utf-8?B?d3g0a21TS3c0dHV6WFdqTHlHTE5BVWxWdkZZdkZDNzllY1p2ZXNjeFIzVVZI?=
 =?utf-8?B?VER2QVdlNS9vWUZ5K0E5Z05OckpMUVF1dW1neFdrMFIwN0x2ZDMrOCtiK2k5?=
 =?utf-8?B?WFZLZzZhQ2pOREd2Z2d5TkJ5MGl0c2RDZVdFQ3MyTmJyZ2d5UnBIY0cvakpL?=
 =?utf-8?B?YUNlclgrcWRmMmtUKzRvUGZ4SU9QSEhwQ0tsL0czbDcwajRIb1hMU1NZN3BW?=
 =?utf-8?B?WEEvZDBOeW9zdjk4Wk84eWRZR29ZVldIbGc2NUl0S1l6K0d3dHN3MmJzeGUy?=
 =?utf-8?B?ZGVBZHhXc1NBYWx0dWVJOEtXUDFRT3VTWFVpeGN4M0lOdU5menZ3VE83YjZz?=
 =?utf-8?B?UlRTelRScUpLeUI2eUZGWkVDNU9vYURBTi81Wjd5K0NRMTJ3K0kxcExLaEsv?=
 =?utf-8?B?RTFOT0c1aVRBVCtVM3R5YjU0Tzloc1ZnWjZrclZXb2cvQk5GM0lPeFdtbGRX?=
 =?utf-8?B?YlhyVnNQUzhhY3JLL05pYVcvd0FOeVZicFhlVUpVUFQ0dVR0YkVWQ3lRUXBs?=
 =?utf-8?B?WndUTHRJNm9JV1l2MHRMWERnTFRZRVROTlZZOGFodnVvYm04bGFGSnZtVXgx?=
 =?utf-8?B?aFZRUEduKzNGY3REMWVuRWFBS3JUNUNweS9hYlBvZVhnT21NcHN1d3JYSnQ1?=
 =?utf-8?B?Tm1QdU44cW9VRFNKMnpoLzZFSHNoUkl5MHFoUnJLRXlZZ1dBcXZ6bFhhWFRB?=
 =?utf-8?B?WFdJekdYeG9UKzU1NTF1aTg3aHNIQ0ROaVdISHZSa0htd0lGeUhUOWlxSXdx?=
 =?utf-8?B?S29YYmpWQkdramc3anZwUUp3dFZONlNSYUJyaUZWQmc2cFNuVG12c2I1cFk1?=
 =?utf-8?B?cEpPeHF6bWFsamxRWFVkbU9GUU5OejZwOHlRZHVySEpLZHVmWkNObXVqNEE5?=
 =?utf-8?B?WStrSkpXMFFmVUozQm53eHpLZUc5Ri9iR1p4RldHa1FHTGFkd2NZODlGZUFw?=
 =?utf-8?B?S1BKcE5SUkdOcVJJeVRRUnJsQXZpdENENGdIblNuWkNzUGtST0o4TStQNUQ2?=
 =?utf-8?B?ditqTnNyZTZkSE5ZM3Q1eDJhcGw1aWlKS3JhbXJka2hkLzB0Z05mRi93TEYy?=
 =?utf-8?B?RTVOWEU4S3VHTVlxOE9BVkUwUCsrbCtuazRvOTBlckxKQ2xURlVtSEsvYjRn?=
 =?utf-8?B?WGR2bkttUkJZaXVDUHBWQWlrZEMwMVZ6amhXUEdKcWJnZmtNcitqSTlNclFF?=
 =?utf-8?B?RkI4eGFQTzFJNXFSazNjMlhwVnpxTHVQN0dPWjRleUpZNFVRY3lCTGVrL3Iy?=
 =?utf-8?B?QWVsVythSXRtNlFEVktCemdYazVoQlRWSHdlcUlHY0lTMk0wL0lIVUtpNW9k?=
 =?utf-8?B?ZW52cDM5ZWhQQ1MrWWRZV0hscWU3WWN6MmVQTUl6TWV5QWtpcE9rRjZXTklQ?=
 =?utf-8?B?OW9zYlcvWkJyS0tyNElqQ0VvUUYxUlZBNnFNTEZjTkZKSk9JOVFwRjhncVl0?=
 =?utf-8?B?ZnJOeHRwQzZsNEJYSDlLSkl3TjE3NkEvRnpuRGl3R3dScGdCUWZIaHdzYjJK?=
 =?utf-8?B?NEpjUVJUNmpubE8rYmk3Vmh5aDRMRm1KUjMzU01sVnBxZmFMSUhWRjR5UTJ0?=
 =?utf-8?B?Tnp0QkNGVllwSklsaFlOdmlpd0tQb0FxMWN2MnJtY0xUNjJQZFh6dz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19cdd6fc-b953-4975-8c22-08df3fd360a2
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 09:08:40.3024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K4VanNhtV9Fpr/BLAIRJu4IU9i900M4RkdiQHL03J9m6esJixs5L+2bnvr8RqIEIQ5bvRokf3A1mvtQC1XPRow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8650
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 11 Nov 2026 09:09:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24740

On 11.11.26 09:28, Quirin Gylstorff wrote:
> 
> 
> On 11/11/26 9:20 AM, Jan Kiszka wrote:
>> On 11.11.26 08:44, Quirin Gylstorff wrote:
>>>
>>>
>>> On 11/5/26 7:48 AM, Jan Kiszka wrote:
>>>> On 19.10.26 12:25, Quirin Gylstorff wrote:
>>>>> The efibootguard wks files take the rootfs image from
>>>>> WIC_ROOTFS_IMAGE_TYPE, which is verity if RO_ROOTFS_VERITY is set and
>>>>> RO_ROOTFS_TYPE otherwise. cip-core-initramfs installs the verity hook
>>>>> via the new ro-rootfs-verity override instead of secureboot.
>>>>>
>>>>
>>>> Err, we still have both RO_ROOTFS_TYPE and RO_ROOTFS_VERITY? This
>>>> really
>>>> makes no sense. Please avoid the latter, it looks redundant.
>>>
>>> We need two flags or variables to differ because verity consumes a
>>> rootfs.${RO_ROOTFS_TYPE} and changes only the file suffix. in theory
>>> there could even be a ext4 partition.
>>>
>>> The only way we can avoid that variable would be to remove
>>> ${RO_ROOTFS_TYPE} from the image and use a non coded variant but this is
>>> other than normal file systems are handled (.e.g. ext4).
>>>
>>> Third way would be to look into a separate verity hash partition like in
>>> the uapi discoverable partion specification[1]. But that would be a
>>> redesign outside of this patchset.
>>>
>>> Another separate patchset would be to move the partition creation and
>>> verity creation into a wic recipe. Which I don't like because it creates
>>> an additional wic plugin we need to maintain. The current approach was
>>> inspired by meta-security[2]
>>>
>>
>> Is still don't get from this why RO_ROOTFS_VERITY is needed. It's
>> RO_ROOTFS_TYPE == 'verity', no?
>>
> In the v1.13 implementation RO_ROOTFS_TYPE can be squashfs or erofs.
> verity is solved indepented. As verity.bbclass consumes RO_ROOTFS_TYPE
> to create the verity image.
> 
> And the secureboot recipe then has '${IMAGE_FULLNAME}.verity' hardcoded.
> 

OK, it's stacked, makes sense now.

But we should be careful with recipe interface names here. This simple
boolean "verity" underneath "type" looks like a lost opportunity for a
more flexible, thus stable interface.

We should account for different container types in the future, e.g. IMA
or dm-integrity in place of verity. How about ROOTFS_CONTAINER_TYPE?
Would even account for writable rootfs setups (not that we are
supporting them now, though).

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
