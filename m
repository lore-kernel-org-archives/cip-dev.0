Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5050.1794385210068378724
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Nov 2026 00:20:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=qVv3YDQY;
 spf=pass (domain: siemens.com, ip: 40.107.130.31, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YxpMtdfI8CTVd84F8MWHy6HXWav/ulmNOKaabPibSONrmKzH9YEfFq4Jf/ysmyra1jtcyJfMxHtfoVMgBllEhmZsjuSpwHbj0JaEjeoAMwniVd8a5b7gjffvZ04bq1qjSmxU58//QvG8V8MSasFrDMEt+IAFgWmfHLxYOlNKsbBIvX7BgE6YOjjZZucOIg3ZZIc1irVXCKsrgrtuaS0V3VRIFwos8ftcX5sIrx5IhmH/0eKGGFrtMcs63cCyi3ToSr38TbjJJXUJlCyJCurAA93ccZdDYMYIbr6VMGoqWrFACjdR0NXT3xZ/r3D4kRl5GUlx1jPp77rPWe+s3QjEYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YU2xKO5hOKQJBAQAxJR2kvHrYu3TbdoCpNJtzqzktH0=;
 b=Ajcb9vF+kNu3xxdmlNQg2XrOX1K5SU8zg2ThLySLrODESwNnO51IGb7Dpz9bR7NgpOZesv7So6/TI56z/POeoMxZHqm1Nubp6ki/tueJITvvYjnLB+GWuEMrbHtSwlN3MuQNOLV47RsOP2Rb3I9pdZktxgojVQh+QMnP3ZDjylfm1HAyOGkFLUPs27Ed9251C3bBevY3du3L8fli3ipxne2jW+Uk0iCCvhY8RVQ5DPPU6rAfS4Eu9T/RS4lviZ7t64UHhfnayFol6G2SXD7/zzJsCl14THTMu1VgEdQLxDudhM1Fkkw8aMdhpswaKSdd7bNd9e1jeEYMwKeLC6hMyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YU2xKO5hOKQJBAQAxJR2kvHrYu3TbdoCpNJtzqzktH0=;
 b=qVv3YDQYG7lfGy8Vj6bWOLQxRx1mdVD8eTipGWMu4Qd24gYTresWUCkpYyVPQbSpCiE4BXv3YUGxXsVppcqwOBSx98QPT3O6KcWiEub1XqQnf8sfyQ8pBJVNbfCgLkH07DpxQJ0zw7kN3CXPJYSSaPhv5og7CA+JwnTWrTC60iAuOaaMI55jNpkn+61g+AA9osZXkftIIDXh1/jRopXoboQYAguBHyO9eSlUf5xRrxgKYLivhiUIubIRlZ9XISTwaoB8EfmmLg5MVKllf+S0NIi4Pr8ObSLzRpXuazsowk9rQOkKMG9fZMcRZjBSd+AWCjA4B7eOrRwFIR323L3yuA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by AS8PR10MB6697.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:565::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 08:20:05 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 08:20:05 +0000
Message-ID: <2388290b-53b3-47a7-8a41-39c574732916@siemens.com>
Date: Wed, 11 Nov 2026 09:20:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 03/12] wic: select the A/B
 rootfs image via WIC_ROOTFS_IMAGE_TYPE
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 felix.moessbauer@siemens.com, cip-dev@lists.cip-project.org
References: <20261019102541.672620-1-quirin.gylstorff@siemens.com>
 <20261019102541.672620-4-quirin.gylstorff@siemens.com>
 <edeedc71-4d4f-4f96-84d5-1d9e7313148c@siemens.com>
 <84a4c55f-9786-49b9-bd16-42a9ae3dd0ec@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <84a4c55f-9786-49b9-bd16-42a9ae3dd0ec@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0242.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::12) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Return-Path: jan.kiszka@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|AS8PR10MB6697:EE_
X-MS-Office365-Filtering-Correlation-Id: 997700d7-58db-43f9-94c1-08df3fcc976d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|11063799006|261021121427099003|4143699003|56012099006|261026140227099003|261022075727099003|261026121527099003|261022115727099003|261022105027099003|261028144727099003|261102123227099003|55112099003|18002099003|22082099003|6133799003|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info: l8OE9BZk/P1I3Ry/Kf+ZhXr19Uh1PI081XyFfaDd/HidhMuFtuVD3BHRqqJXV7jDPxD6YHmwwrDT2N67n9HnAXKyiRioQ37Q0Ke2uYz9OQu9of5JATyvxtTrzP/SEMESdHoz8SX4hC0F2gysUOKvYKrJlteMiPSB0nFD33cwo8LSx41q3YlIaE7sWz5UiVdykUQ9l3SQvMgseM0Knx44/aUn0K0MwltGvKkfgHN2d+RkjF1mx/ocfd598/LxnlP879hmNCCBfgMPGqg68JnObAIAetBONMkQ4mQ0MnEGPNB5sMrRPrHQAy3s9Yvm1pAqxUtIAgLGQ6DgGBONCICL7gdeUJGwBHMrUtYg6CMqgc+eGKPn5uwQs03IORMCiGMb5nIWTCT72nbfRjq27T446/K/K9R32T81D2t+JXS/WosnByDCWfkQ9nuMxbt02WksZdtZ0w5Spma1SRwmndLRwZg6chde8eG9LsuMJNqIvOiGygU6H2ju3f00JbdD3edWZuCoq1dBDGKR3rRkn6M1+N0DM2GxGKrPyuAvxwsCUUCufPXF+4f8cJgo+fD2Wy+/2TfeyUA+L60JKnbUMcdkyJs/28wtjb5CFAFFj+dx3GLV0bDcQj70VcCH2Dfng9x0yijWT9RvUANjSMuLmw32BArZlfuBCCQYqYyEWBxWrTI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(11063799006)(261021121427099003)(4143699003)(56012099006)(261026140227099003)(261022075727099003)(261026121527099003)(261022115727099003)(261022105027099003)(261028144727099003)(261102123227099003)(55112099003)(18002099003)(22082099003)(6133799003)(10067099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d28vWWNabStacFVVY21DSDhSdUI2MUZ5K2NCZDE4Z3d2dFk4SUhvcmNjcGFG?=
 =?utf-8?B?Tng3WENlWDROdHVqbE5MMHhyRGE0SW43K3JHczI5MjJ4ZEJWTmhic2FNb1dI?=
 =?utf-8?B?Z2xpQmFaTjZmaGhnaXI0djdzZDZORnl6N2JHU0hGZUVocXQrSmJPR1lCT2cr?=
 =?utf-8?B?WGE3VDJ4OVFlWXlHdmxBdFc2MzRDaGVyNmtHdXM4ZDNzV25HZmhzbEJYNnBt?=
 =?utf-8?B?UTVhRFFrUktpdEdPTlBPNzJmNXFWZHkvK25uUXpzMzl2bTVqb1FWenk3UlQ3?=
 =?utf-8?B?amFWN243NTlyZ2ZMeUR1bTNXTVdzQmliYnNkemp3ZkpXSDNoR2FtTnhDMHBP?=
 =?utf-8?B?MkxqNitKM1g4S3ZqTE1na0NUeHpKL09jNTBCMHc0L0xJeTkxYkZ2bDBPamV0?=
 =?utf-8?B?cXBnR3liU056cGhqMWJXd0owa0dmVU91VE1qWVVKbGxtc0pVL1VUTTAyZVda?=
 =?utf-8?B?UW5wWnJ4aS9MaXhZaE11eXdTdTUrZG5WWW8raUNWbXo0aS9ucDJYQkQvb0Rt?=
 =?utf-8?B?SjhNdnNPWnJjZ2pwVHBGVGluMStrQmg0OVd0YWZsdCttNUpDUFhTT1d1dHFq?=
 =?utf-8?B?OFZSd0w4SFpsOU8xS1N6UEgxV1loazljUmQ4TC95QUVybTgySWNtUDM3cDJI?=
 =?utf-8?B?dGJXNUhxL0NHWTE1cDN4anE3eWVjNUZuZW1SNUkxK0Mxamp2N1NaK09vcWFl?=
 =?utf-8?B?M3J4QXZ6VXpkb3JZb3VkREJ5QUVlb3VrNkpjanNvb0V2QkJUY0l1TmZkTXQr?=
 =?utf-8?B?cmltNDk5N3FGcHRYU0NzM2NwYU1ZOFAxbjVybXY2azAybFFweWdqTlBXMlUw?=
 =?utf-8?B?N3FqTFpHVTRENWJBWlVpdkFNK2dKMks4T3NwSkFrZ2E0aWxCSVpYSExna2dj?=
 =?utf-8?B?dy8rL1BFRDBETEtKSmc0dzJQQ1o4ejJmYmk4S2kyY0VkUWZKVkxZeFJwZkN1?=
 =?utf-8?B?NnBPSWZsQXQxZUREd3AzSjhnV0JUdHBsUTlXYzFNK3lXaU5tcjlyYUIvYjNY?=
 =?utf-8?B?VmVWYldodCtVUEVLSy9TLzd6RUVBYmpNV050TU5xbVZFbDQ2bjRoSGRhaEFa?=
 =?utf-8?B?Y20yaVI3cTR6TE5Vc0tkb0Y4LzB3Z0tuWS9qeHN6SWhBRmsrcmREc0tYL21j?=
 =?utf-8?B?VmtuZU1xVllMM2pFVW45VlRNT0RNb0tteENLOEs4bkxWUGNkTnBMejBKZ3VL?=
 =?utf-8?B?NEQ3M0ZKUFFMOUVKZStyRUNYSUptQzQvdkliNkF6Q0hQaXY2TEdtTEx0UnJP?=
 =?utf-8?B?MGlxTVhYcHRrd0c3YVRTeUcyeXBUaVB6dk1ZQ3lyMEcrdjlBZ3RnZWdWYWxq?=
 =?utf-8?B?UFRtMzhhY1FzaG1Rd1Fxekk3S2pWQTc3ZklYVW9xeGhscmc5QkRWaCtNMEgx?=
 =?utf-8?B?bmNpSm1yd0VJSjJwZ2RoWjEwNkc5S1JwMC9nUzgvNE1Zc3o0OTFYZjVrS0Ri?=
 =?utf-8?B?Ry8yR001b2pMZElyMVJaUlQwV3ZHSGllTnV6enczMGRJU1dJQzdKcWFLTy9U?=
 =?utf-8?B?VjUwVjNBUkVHWDR4K0krWW9FRldvT25yYjIvSU5kUTMwTWRndW1icEc5MFZ3?=
 =?utf-8?B?ME1BTW1WYUdjNlRSRjlRVFJWN3VGb3p0VE81WFZ5dStDQ0xhUGQ0TUJSRmF5?=
 =?utf-8?B?N1Byd0UzVFhMcTZGWEFTZzRpQ1hVempIaWdHdGlFVlMyUklaRlpVTENza1JC?=
 =?utf-8?B?aDRRaEU1RGNRclpZWnhJVVpuNkFRNGN4VUZPZVJnTWhLUStpeWNqK0JXVFVC?=
 =?utf-8?B?Y1Z0QUQ2S1RBTHJMUTRDTm1SeWxJaGVnYm5WNndaUk5BVVFvZ1pqMFVBcnNi?=
 =?utf-8?B?R1dGenRqdGZMLzYwNFVZQTNrRFVac1hVbFprZ05IQ2dsNmJmTENJeFNtUVJU?=
 =?utf-8?B?T2g3VjZSQjVObTIyZjN2dFFVRzZQdlJkMEJISldaeG9HUUtCRDU4dGI1a1Z0?=
 =?utf-8?B?anVhTmVOL1I3UlhKYWxnVW10Qko3T3JpcytvR3FuNjl1enNsYm1ESFM4alNx?=
 =?utf-8?B?VlcwckRJeFBVUUx3ekp3NVhqTy9VZE9WL205ekNpUjRYRXJ5bGVVL1ZZT0NZ?=
 =?utf-8?B?bUNxSHhkZjhrcXhXUmlXbm9YN0JYNDdsMFZGRXp1cUNmMkhlZi9QdUdmUFFZ?=
 =?utf-8?B?S3VxUVhHanFGc2FjMldnM3lxbW9VQnhCSGdBNXpVeGtJdUpoUU0ydzNCOXRr?=
 =?utf-8?B?WExuVDNEYnpsRkZveFNzcU9DUHVkWm5PWk9hc01OZGpJajhYRFdZclhqV3Q4?=
 =?utf-8?B?UEdyS05VdzhZQTVRNzdDMkl0aGV3Rjd3OU1RNmJVN0NCeFpPTWdoTDNxV1pW?=
 =?utf-8?B?QWtVR0w0aUROWS9MQ05qRnZ2VlAyQUR0dnUrOVIzSU13ZFRrNGVKQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 997700d7-58db-43f9-94c1-08df3fcc976d
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 08:20:05.7330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yaINiO5ZLk0AcPCwGSda+i+ArANv7iajIi83cxULw1jtthQqLzlYXbvDx/kmIHkv/1KHouDqF4ZmAt7wn2ob9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6697
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 11 Nov 2026 08:20:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24738

On 11.11.26 08:44, Quirin Gylstorff wrote:
> 
> 
> On 11/5/26 7:48 AM, Jan Kiszka wrote:
>> On 19.10.26 12:25, Quirin Gylstorff wrote:
>>> The efibootguard wks files take the rootfs image from
>>> WIC_ROOTFS_IMAGE_TYPE, which is verity if RO_ROOTFS_VERITY is set and
>>> RO_ROOTFS_TYPE otherwise. cip-core-initramfs installs the verity hook
>>> via the new ro-rootfs-verity override instead of secureboot.
>>>
>>
>> Err, we still have both RO_ROOTFS_TYPE and RO_ROOTFS_VERITY? This really
>> makes no sense. Please avoid the latter, it looks redundant.
> 
> We need two flags or variables to differ because verity consumes a
> rootfs.${RO_ROOTFS_TYPE} and changes only the file suffix. in theory
> there could even be a ext4 partition.
> 
> The only way we can avoid that variable would be to remove
> ${RO_ROOTFS_TYPE} from the image and use a non coded variant but this is
> other than normal file systems are handled (.e.g. ext4).
> 
> Third way would be to look into a separate verity hash partition like in
> the uapi discoverable partion specification[1]. But that would be a
> redesign outside of this patchset.
> 
> Another separate patchset would be to move the partition creation and
> verity creation into a wic recipe. Which I don't like because it creates
> an additional wic plugin we need to maintain. The current approach was
> inspired by meta-security[2]
> 

Is still don't get from this why RO_ROOTFS_VERITY is needed. It's
RO_ROOTFS_TYPE == 'verity', no?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
