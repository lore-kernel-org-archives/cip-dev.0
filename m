Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D049CAC5A7
	for <webhook@archiver.kernel.org>; Thu, 25 Sep 2025 16:19:24 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.12])
 by mx.groups.io with SMTP id smtpd.web11.1214.1758817153882875957
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Sep 2025 09:19:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=lvBM8L5R;
 spf=pass (domain: siemens.com, ip: 40.107.130.12, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hq8o0Psjt/MIyF5BO6v/I1j0jbhfM+/1H3OPXhmb7b/vNkVhn7nwuwtcn51JqL0BLHkp66fuwfZQx8VYzyD063D+9cGcS6FtnGSlSUR4KTtXuNgL2oStYPGipmB23TxLAyik5TINr11yFe6LbSG0RjF336+9MLQEH3E7oLyVGbf4o3tM96IC01hJIwG7UFK6pt7H4BsRLpZ7PD2+r2zkwRDusswiHsMmNnlS7lg10VPRwi81V7NIO8bR1uvIe3TKJOYnCbifqAVnPO20bm0Re5oOAR7BcqE7TXnBAKY3fRD6/Esw3X80TYANbgLwZ4yocOY1wVrWGA1V28EQ0mqcKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BM+2YByEUn5rGeDuOEhap5i34Tnr+R0+2u1zxYItbc0=;
 b=ibzaZI4suv5n50lXjJpP99y2/xuzSJI22KgOfvHb8FMURPrVYenFCx5/n8NoHMZQIgqZAcJ///X5/wzSdtVX2W2LCdIElAuVVuzug9bjznbh68CaGIhBhDub7v00pAhRcabBbjNaUiV7boOC974Zm0W+IVpwaOTu916DXftVa+E3PXIVT/X1sbcqV2jJTzk1iuTkIUTK2UkCcKUBkRqSgeQHW/zQ4jj8cdDcEuyMsThbRTe222sFs1MtEC3YWUZe+atqDcMfTJQMld9bddRWS9y+t+o3vzRF6yw+ERj7gzHphY4ZoKwYG8oPcMk27ZFK3KEdOSYw1h0OWljuWoII/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BM+2YByEUn5rGeDuOEhap5i34Tnr+R0+2u1zxYItbc0=;
 b=lvBM8L5RtoWZmeWu3cdyLPiEljBq89Y0lkrm5M5kaH0iyQGJ8ObsWpiQhMsAEPNJLXMwmQHexP07VcI3JNBJvlrke2e30eyR/7wRNLaEjG+LQ47pyEeVXO32mbe8Y5aZsMGtJyN8Y2L8mUlJkaSqmsrUy+pyHPyhhmpF6+tBuzhuPg3U8q/ythyAYOD8LR+ZNiIqRe6IlpmCxMbrpujFfoEyQU5moBn720OhiqL3x6NFemNqDfZnrZLE0mtSQ99N9K1v5qHpu8rbtsE6EPppaZU5vTxcSWFBRy1z09G2qb6cc1wAXYjy5amWsGEWzn3Wd+xGaKRIigN/1u7JlLU9NQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB9021.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:567::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 16:19:09 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 16:19:08 +0000
Message-ID: <a09138e0-5966-4c93-b548-86b6b5476824@siemens.com>
Date: Thu, 25 Sep 2025 18:19:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] isar-cip-core: on-device tests failing
To: Chris Paterson <Chris.Paterson2@renesas.com>,
 "Shivanand.Kunijadar@toshiba-tsip.com"
 <Shivanand.Kunijadar@toshiba-tsip.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>
References: <53fe043c-eba5-4d8b-826e-5846efce7d57@siemens.com>
 <TY3PR01MB11075F7F38A4345A60D5FF028C71FA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <3643259b-7e4d-4e38-9d53-b0e2227f9931@siemens.com>
 <TY3PR01MB11075A9F4E791BBC04C5EE28DC71FA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <c8e57ef0-6f4f-481a-9e36-214f44fffb5f@siemens.com>
 <TYYPR01MB15132A5CE730EF7EC863D3B5EB71FA@TYYPR01MB15132.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <TYYPR01MB15132A5CE730EF7EC863D3B5EB71FA@TYYPR01MB15132.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0085.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB9021:EE_
X-MS-Office365-Filtering-Correlation-Id: 84283ad0-fecd-4208-6ef9-08ddfc4f4127
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WU5qTWlqcXNIMitEY0FPNEh0RFdNWUFRWEMwUWF2cW8yaDQ1VUJRS1NENmxr?=
 =?utf-8?B?RDRFTHhjUVVnVFNVRlh4NXBzcDI1MTVEdWJMaFdKanZPT281ejFsbUxUOG9W?=
 =?utf-8?B?UEZoOFZveVBUN1N3ODMvSTB0NEJxQVRWTnoxOTVVVi93RC8xQ0ozUjNybyt5?=
 =?utf-8?B?UUI2eVlyYTRDWk02L29mbkRMbVRHTHNuTkxIa3RXV2hUSmpMdnhnd0pCUWE0?=
 =?utf-8?B?WUd1K01SNytQa3FVQmVIaC9CSzhycGxBaitxc3NhU21VblZxeTZrZUZiV3ZZ?=
 =?utf-8?B?VjVodjNJNDN6UlNtMmtTengzVGJUYTRzRjdIejVKNzFpV1E0K0NNbGFrU0JP?=
 =?utf-8?B?VUNXU2JCQnBmRUQ1N1RTK04waWR3clM5c0FVelFMamFBRm84a1NkUHkyTFFy?=
 =?utf-8?B?cE9zbkR0RU8rZndtUUVpUmttUktEM0N5VFlyakF6ZU5PSTFkbHV6NzlSZmZ0?=
 =?utf-8?B?bEcxSTlJMHdRNVNnL2pkb2dibGZFcm9DRnk1bEJkK3BnVmxseWR6WHYwR2Y3?=
 =?utf-8?B?Zk40K3JJZzREWUZQMm5MNnRDSnVpMVpzWnJmQ1ZBcUtPcnhST2VmTUZSOTFl?=
 =?utf-8?B?bHgrR2grU0gwakVsVGRBRU13RERCM1kxaXBGdW1FUm0rbGxkSlZaamtUVmpn?=
 =?utf-8?B?bWQ4MVR3Q0lzV2xwUlBBWUVPVktxVkl1UWdQOHIwbE45QzBObUdvZ2kweU55?=
 =?utf-8?B?WHZ6dHplRWg2ZmxEbXNQd2JHRzJCd2w4UnB1SUZTNXh3SGNJcmp1UUpJVDNO?=
 =?utf-8?B?NHU1VFk3WHQwa2V0bklDc1VUd0RzdXRPOFk1SmxqMXFjeG1icy9GTHhFeEpX?=
 =?utf-8?B?bmN3TXM4TDh1K1V0RTR3VlhoZEUveDM4TkthTVhJd1pzWGdhYXVSVHovdVB3?=
 =?utf-8?B?a3Q5eUtvdWtGalRYQmJHdm05WlZuYkpHL0FoVjdSalRWUFA2UyttSEZmcVNS?=
 =?utf-8?B?WHRoclVuV1VEbmYzRW5sRGluNVZGSlVNckx6cHRFL3NBQ1hsbGgxOHZpbnND?=
 =?utf-8?B?ak92SzJPU1V1bzFpV3JBeUpJUEJzSGNxa1VFcWlPcS9MMmE5Y1RJSDRMSlh0?=
 =?utf-8?B?RWR5Y0NsdVNsa0dFUUNSc216KzVyUEQ0S2F2TXR4dThwdDRXcWR6SkxEcTlh?=
 =?utf-8?B?N2J4UnRoR2h0WWhyUHJPcXhlaExlY3FtOXhvZjJKZC9XeXMxcGczTHJQWHpx?=
 =?utf-8?B?Y0QrdERRVFNQaHE3K3B5NE9qRGk5d3V1UWxDUEdNZVU4TEhWbUhTbS9LRFdH?=
 =?utf-8?B?ZlJBYVU0Q1FDWW40QjZBVFYzemkydmNFU09mdDFFWk5iOEgxTnlRQngyOGRx?=
 =?utf-8?B?TWR3OEJ2YWJTMUcvWHVpazU4N3pLV0xqekhZMzZmTjZla2UramFaR3ZCTHpW?=
 =?utf-8?B?aWlkOEdkbnN4Q1RIV0d5aEErRC9Cb21SbnllWFBVTkJTMmRvSk5zS1pnb2ps?=
 =?utf-8?B?cTdHR0VMamRDWndEbWFpK095TVJjc2dyM2NKc3VWb2QvVTBCNzNpYzNiZWwz?=
 =?utf-8?B?YlNsMDBYeFQzZHJCQmtDTnMvby9pNjY5RGkyeDF2UHdncVdhU1hzQ29reFJZ?=
 =?utf-8?B?RjhuTlFac1ZYd2hnTW9aRXFUdXFYaEpTK1RTbW5SRHB3TmNlY1BQZENDTjBV?=
 =?utf-8?B?R2wrZ1lKVVpvdWRWajZybzVFMXIvVkMzaE5SOWQxQjZWbTZNdCt5Rms4Z2o2?=
 =?utf-8?B?ME9PWm1vbFNhSm1hTFpMTVAzWThEaUZVMlp6NnBweFE2c2hNRVYvYkJwTTBk?=
 =?utf-8?B?MUQvdUlSNEZSNmFpUjhUMTYzSGd2WWp0dGxod1VXSUZiWEZFdnNlOTZYS0RB?=
 =?utf-8?Q?5TNgGA9Nxz30Z0kEpID9v5D0bZ3RsAgtWZTkA=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UFdUVzFpOGVkbDZSdDdMc2RGS3hwdGwxa3Vyb1Z1a2pIRWo0Z2FvRjlNajNY?=
 =?utf-8?B?d2dVb1pqVnZQUmYrOVdhMzVLSnpKakR6SGNqNWdjWldoelo0V285WDIxVlU3?=
 =?utf-8?B?SHowV3lXSmpoYi9jNFRESGdoL09ESkFXZ3Zpa0tobGVRTHgwcmJ2MHFVaDA2?=
 =?utf-8?B?M3BoV1lYL1JBYWFseUJEOEd6M1dUM0phSUM5RnNiWkN4eVRqWlZtV3FKQTFI?=
 =?utf-8?B?S1pSTjE3V1Rhay9vcXdMckNuMHRoUGxWOS9xc2dNSDZuQmZaUXVTcWRWYmNu?=
 =?utf-8?B?SVpwM3RLZXRtQ3pQbWVwREt2ajh6aWpZKzh5OTI2VDA0bkRCRi83VFkrODMx?=
 =?utf-8?B?UDliZEJDVXNFblNIcWp4NWtHbnJqSFBCYnJaVXdiYjVPNVhoYWk1ZXFUZURO?=
 =?utf-8?B?YTQwZGNzdzB2a3ZYY1dXajMxY01TSERMR3VnZnhHYURNY0pDV1Q0c1UvdmlE?=
 =?utf-8?B?bitzZE81VDVzaityd0hwL2lqTTZLOVFuS1owU1d0S05SSXY2SEJLa3VkcVll?=
 =?utf-8?B?ZmZhZ09HYXBUdFRGd3Y5aUQ3TEYvVGZibC9oMnAwcG5nUW1MV1QrdGVFQ0Zk?=
 =?utf-8?B?NXRGaENUM21DRDlaTEg2dGRlQWRMRGQyS1BkYnprRm0zV2ozNUFWL2VnVkhP?=
 =?utf-8?B?bnM1TFd3NFhyVmc4TjhXVlRObXloQUYyL2dNYkI5U3lZWVFXWDFKQzZmTGVY?=
 =?utf-8?B?eVd1c3pEeHU1ZlNiKzQwMU81ZG1jVkJqUUVSRVFXa0IxU1JjVzcrT1NoRCs1?=
 =?utf-8?B?Wms5aWVCWmhNbUhJMC9NcThYSFBFb1RPQWhrZVFCYk9uQUlnamxuV0hja01u?=
 =?utf-8?B?emo5QXN6M2Y0M2V0RkgzMng4ckRLOTg0RE04YWl5a3NpRmlMbTVRZEtDQ2JQ?=
 =?utf-8?B?c1l2NFJmUEhPRzYzTHdQMy8rc1dIbm5BbWMrMnJoQU9LMmIwWEpqTitUS01w?=
 =?utf-8?B?WWF2UjhaZUMvTjhkRVAxdmdCU1YrT3Yxc0JRbVVTWTFPandxM08vckRUSVph?=
 =?utf-8?B?cHdzV254ajYreU42UU9GbFY1UTdPMTBPR29zcllIT3ZrazI4QjQ0OVdDUzEz?=
 =?utf-8?B?UWRyUGp6cUIrN09SbEdjWVF2RFkzNDNpdGRwZHk1ejY1cTRnNVEvSk1PYVVm?=
 =?utf-8?B?WktoRWhPRmNxZ2lKOGVRMjhmT1Vyc3Bmclc0UHNybnE1MUNla2FvN0Fxd3hW?=
 =?utf-8?B?ZjRwczM2RXc3VWFwR3R3SC9TZjZjZVdUNkZaMzFlSmRWMG5vOUY4YTBNUnFy?=
 =?utf-8?B?Y2hmM0cxQmJHbDJWNUxPR2N6Uk5FK3AwNnNzS1Q0YzR3RTd1V3cwWHZyYXh6?=
 =?utf-8?B?RjZRK09BaXdrQkpXeWt3c2VlR3NaNlRZRjdrcWtoMzVaTlhRc1R5K2dTWkcy?=
 =?utf-8?B?aUNiMWZWY3p2ZWtTcDk2TGtKUi8xdjc1Z1p3R0NZQXMveVcrV0hJamNxUVJl?=
 =?utf-8?B?UkFiRWwwdHBvZ1pVVElUSkRwS2tIVFZHbEZ4QXRXRFFzRXd6czBDbzFENjFU?=
 =?utf-8?B?c3hiMVJjc05LNTNLTUJFcFdHVU42UFJHTXY3ci94RzVlbUUvTkExTlNvak95?=
 =?utf-8?B?MmZMY1VBWGN3eS83QmJsUHM0eWVnQmZRQzRXcTdwMWpxUWJWMmxHUkpZRlAv?=
 =?utf-8?B?cmNWNCtuRnB6akZ3QzVPM1lreWJKMDNqcml1UjcwQnJHeW1odmtsQ2NQc3hN?=
 =?utf-8?B?Z3hzS0t1TElHTEFaUDh5NUNrMDJXckFuUUMzbU5EM1dvck9ZM1NNTXpndmxR?=
 =?utf-8?B?eEVIVTBBVjF4Zmo0ZTl4NXNKa0k0M1lvaFlDMVZTenVKaExUblJHMlNQNDN5?=
 =?utf-8?B?ZkhXYXlVYkMvNEZKSXVxWnNKZitxeisrdzkyWmxJT2tZZTZTQ1lCMGNydHVq?=
 =?utf-8?B?Z3drRm9jaFp0c1hXN1AzRitWVmdBQTZDTFFCZ0hwRVVHQ1g1TzN6SUpCalBD?=
 =?utf-8?B?cTVSMmR0cC9EemRpMlJXSUdSeEdmOEtmWWMwZXJHSXBnQ1AzcWRuVEEwZVdw?=
 =?utf-8?B?a0MxMnF5NU05d2NqK3NBeEV1S3g4eFVYMGdrMVNHb3Zuekx6cURxUW5BQ2dU?=
 =?utf-8?B?Z2F6NkNmNHZOdWttQnFMUzF1MWFDSjFyWWk5VXdNMmZzKzdxNzBaN3R1VS9n?=
 =?utf-8?B?d29vSmt4cTJlUlVhQkV5VENPYStZR2xiNmpKTHBiNWh1M2ozZndiWmNxc0tW?=
 =?utf-8?B?UWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84283ad0-fecd-4208-6ef9-08ddfc4f4127
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 16:19:08.3927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NF+QDMUDrmbeTtDAlspW1cqduV9o901PHw3RM/PsN2A9J0Q0HTIH0y4jsuPNxB8TOvxV7pKngQtk7CgzKrmZVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB9021
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Sep 2025 16:19:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20144

On 25.09.25 17:40, Chris Paterson wrote:
> Hello,
> 
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: 25 September 2025 16:27
>>
>> On 25.09.25 13:34, Shivanand.Kunijadar@toshiba-tsip.com wrote:
>>> Hi Jan,
>>>
>>>> I'm already running a test with
>>>> https://gitlab.com/cip-project/cip-core/isar-cip-core/-
>> /commit/e4cf71701983e3cb12f19efe9c217f500b9b0868
>>>
>>> Ah, ok. Thanks. Hope it solves the current timeout issue.
>>>
>>
>> Not all issues yet: https://lava.ciplatform.org/scheduler/job/1310661
>>
>> Will retry once more, bit it feels like our target became "slower",
>> could this be the case?
> 
> Is there anything we can do to reduce the encryption requirement?
> e.g. make /dev/sdb7 or /dev/sdb6 smaller?
> 

I can look into that, but that will only address the boot time. Not sure
if the timeout from above was an overall one or rather one that
monitored the tests themselves.

> Or do it outside of the test job using a faster machine?
> 
> The current timeout of 2 hours is very large for a single job.
> 

Indeed. The reason why some of the tests are so slow is our slow storage
- it's emulated over USB. If we could argue that some tests could also
be run when using the same(!) image inside a qemu/kvm setup, that could
accelerate things a lot (RAM-backed virtual disk...).

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

