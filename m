Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59FC0C77B7F
	for <webhook@archiver.kernel.org>; Thu, 26 Jun 2025 08:17:31 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.29])
 by mx.groups.io with SMTP id smtpd.web11.3432.1750925846656269502
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Jun 2025 01:17:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=iAGzkUxz;
 spf=pass (domain: siemens.com, ip: 40.107.130.29, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R3RfqCeb5sMqjGiSWLthZ11d5drztPLNHQ59lG6ziSiKYM82jH8dXltNkoTIpNqEqW3NGjBeTcpiBYzZ9lAVvNkJH5j5lGJzOK5yW1ahAIAiqsdsIh4wn46Qpz4F+Y6eq09hdiUh3qFf8Hvb05ssaeZcwh5ebddptJL8uDxSDlX1vt2RYRml7jBDWJNfgUNaZwsS676LuyNxyrpikzC3RpETE3oRFl7FNZqJ3jAql62521uyosQf5E4qNjZFchRsHW3WJw23q0DSSczAhqL69W2758aodq9/dXxXgB0fnQNmQzJB/3hnjDZl6YWOUFn+VS8Zhg+WHkGfiq/O4A/WvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rPxMmYLpwvTx6BfH6FzzR/BsRq5eWmhb5l07ibWAeg=;
 b=JoAlgQQ++d4lsURFTbGzQjmmUMXSWt1Xxbf8jNnazYQqH6raj4cQSNqA/oPR51PZnCSYzj4V80pDCArb1WlPmIgAGlEOnc8tuSy1OPdHpscGNtFTedCKFdAvpAz0jeQ9FkjagNIuV1nsyEF1IPiARbAWOCtbh1B5WCAn/YZSSpqFcaNlDTaHv7QS9laTL8AKNAiAslAZFt0NlAkW+6/IvqmNjdT1zThtKE+LsWetNcxG1CbXBzwvn/PJiXkT2roWLbVRr08DOOS8TlHdZRGeipL/q+JGmn811ChI4rcG/IOSEBkCfC3M66PUI5suwfKM5OIHhty2j89O7NauF7uiXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rPxMmYLpwvTx6BfH6FzzR/BsRq5eWmhb5l07ibWAeg=;
 b=iAGzkUxznOiD4Txh5pv1jNhA9I5CMABNvHK0iDhJXxxxqvK/3aVb/JmApnE4co3qEvTYjHWCfNN0XT/fmTyUS3fE3xlsS+UURKGTmnKIhRHM7Jw836h8TrGmlFjhp0KmqaGnoawVo9piWenEIg7kbLaNCp0wmZf+bETRwmKgWed8jE/+fT10HgOOEyHpzVr199W2YXUUBqwKXmB9FiLcd+Xx4iAIAll6Lptd98pu2WTDwSHHUSEcVR6wf2gA/wUgaXtCEWzWwMiWwFJo9LG2qyVhUJZLmHpyqpDWCPoJ9zMb+aYdjyk9CqffLJrYpWctHmBa5Jafrri52GhKP+0pOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by AS2PR10MB6637.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:55c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.18; Thu, 26 Jun
 2025 08:17:21 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%7]) with mapi id 15.20.8857.026; Thu, 26 Jun 2025
 08:17:21 +0000
Message-ID: <6788d273-be4b-4720-8a81-9458f360bfe0@siemens.com>
Date: Thu, 26 Jun 2025 10:17:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Siemens LAVA lab down
To: Chris Paterson <Chris.Paterson2@renesas.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, cip-dev <cip-dev@lists.cip-project.org>
References: <b7e641b6-f14b-4e2a-932f-f123a549d39c@siemens.com>
 <TYYPR01MB1513242522DD7987EA384A6B1B779A@TYYPR01MB15132.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
In-Reply-To: <TYYPR01MB1513242522DD7987EA384A6B1B779A@TYYPR01MB15132.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0025.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::20) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|AS2PR10MB6637:EE_
X-MS-Office365-Filtering-Correlation-Id: de0b2a72-737c-45e2-4eb0-08ddb489dfb3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?enhFNmJrVkY3MVFEcTRqOE1LdWI3N3lFUk8zTmZHaDFIekxJM2oxNjQ2TktS?=
 =?utf-8?B?OTVObFFVcXFNMmh5TWc5b0xvVFJxSThQcHVTRFhJamEyT3JqR0F4VzhXRUQv?=
 =?utf-8?B?a2ZHZUVjcnlkTXY2RGtpeW4xenFXWFJvN0ZIbjZxQXZkaUtORE9oWHFRZWpw?=
 =?utf-8?B?cTZ6Szg0QlVoVFZWeWtQVmlwdTZIaXpvMUtBbjlpN1NBN25RN1dPT0ViV2Jp?=
 =?utf-8?B?bDlwdjdHZElOc1kvaDlobjUwTlhrNkx2d0VxV2RyaFdGbXhRbmF4ODBqZnNJ?=
 =?utf-8?B?YU5iVWhGWDBBWDRYaVp5N0EwYmRoMHorajB0MVVRWmFJM1JMYzlHeGN3Wjg1?=
 =?utf-8?B?VTkyRzVUTFUwYXdLS1A2UjVCS0VEUk94bnN6aTFhaUh5akdxcmIwVjVGUnB0?=
 =?utf-8?B?ekNFbGhWeGhMTWF4MGdBMEJrMDVGVVZWKzB5YXIwYWQxSGVsY2JXU0cvQ3FH?=
 =?utf-8?B?UWlTc1doNm5HUU5lbVZnQzRkSllUb2M1MHFZcVNJY1AyL2hSeUxuRk9uT2g1?=
 =?utf-8?B?ZzE3SW1nUmZtNENId1RvYmVuTFAyekVyUS8vRGJHOXdlWTV3aW9ETmFKa2xW?=
 =?utf-8?B?VS9hU2d5NDNpdjI5ek1BOWdSN3RxeURjcE1wSTRyUFhHNVRQMVkrdUcwZ1hE?=
 =?utf-8?B?YU1NOG5udWsrajFyQjFWQUxPRHV6eEk2K1JTQ2JiNjgzVUlSVFY1N3paSTFM?=
 =?utf-8?B?THVod1dSUGx3b2NMSjFBZU5JSHY1dWNPdlpaM0o3MmRlQTRFWDg4OVpjOG5y?=
 =?utf-8?B?WlJUU1FsUlZRMzI0NnkvdGplTFZaOHNmelQ4YUpmdTkrWGF4MTRtK3YvYjhR?=
 =?utf-8?B?VVcwa05nU09aQTRnV1ZYb2IxN2NIWXU4SGNRN29TejJpRXFaNDY3bGxBNnF0?=
 =?utf-8?B?b1RmUmNLU0tXNzhyK09zdWsrVnZpQkJLUFM3ZFdiWEVDZTRCa1o3OFF0NUkv?=
 =?utf-8?B?ZXNYdVpDTGFwRVZ2UFM2OGlKU3ljMFRpZFI3ek1zeFgrYmx1d0ozYVR4TEZS?=
 =?utf-8?B?SUJJU1p6VGNEMGJFS01CQ1phdFFRRlRYcDVEajd1VDg1ZmMyRFZuclg1bmZG?=
 =?utf-8?B?OVZnejZrZ2ZFWFFSQ1F3N0I1a25mb0ZQYXFEOHVjQWlVUFlyUkMwcjdDdCti?=
 =?utf-8?B?UFFTR0t1cVY0c2tvL2QwTU1TQUdJQUxXUkVqQWloWEJQMzNyT3Q3SGNzb3V0?=
 =?utf-8?B?OW9aTlJwdUhwODBZNndSNXdieFRkQkxORDlNZ1VKcXJDS3JnSi9EMDJTM2Zm?=
 =?utf-8?B?NUJ6Z21TUXJOMVROa1Izc0NiR2tZaUtVdDgxNVMyaENkcXl4TXN1Q0NucTVB?=
 =?utf-8?B?NnVLMHQzS2wvLzN1RzRrSjE5TUp6NjRpeE1vYTc3VURvL1VpNUE2d2ZvdlZ6?=
 =?utf-8?B?SkdMZnkrU2Q5cEFsVGhZZHgvc3h2ak5ua3RBVVNqaFdqMThQbWF2dmVZcG96?=
 =?utf-8?B?L0JyTmdxZjVDdS82YVVHUVA5MWRGUWo4eHord2VRa3FST29Fei9kakJPREdU?=
 =?utf-8?B?OUxONDU1YlRzSDhvTFN5K3VkN25LblFGNW1mdm53eVBhUGRvV1h0SUNlTFhI?=
 =?utf-8?B?anVHS0xLRjE2Q01aR283RklVcG5UNmhwUkdzZEx2cGdPRGpnYnQ1ZE1La0JH?=
 =?utf-8?B?NHRpV2gzZmV3L3RvcDhsMVpqa3pFcE0yclpQNzF5N21aV2ZOcEFveWhUT3hz?=
 =?utf-8?B?aXE5cGc2enNpNkNncVNJUS9JRy9ianp6Z1Mva2M3bXZCOE9lZXFUbGNIRG1n?=
 =?utf-8?B?V1ZLalJMYmRUcURyaWJBNnAzcTFkNms4SUlVbXhMUlgzZmtwQTlKY2c5cGdz?=
 =?utf-8?B?SU1vanN1ZFhhb2ZOQU4xS25QWUFTUGlmdiszaXNBczN0WWhmbGxFVUJzeGtG?=
 =?utf-8?B?R2dOWDc1KytiWXpNb2JqOE1LSGtQaWl3VkFqQ1VNR1ZzVVA3RjlyQkVOc1Jz?=
 =?utf-8?Q?dxE50oG/uhQ=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YXhUMmI2ZkxYZ2dSVHgraXQybGVzS0NpT2tpMXpDQmZrdkpRanVpN1M4VnE1?=
 =?utf-8?B?ZXB4amNxc0pEditRQVVMTUw2TG51c2ZnbzVacTYyd1RSUkpod0kvNjNrdzdv?=
 =?utf-8?B?ZElDeG9mSTN4eGtya2pvQUFFRWhmUlI4RDM0Yzl4K3M2cFBJSlMzV2lLWkEw?=
 =?utf-8?B?NEN2UHhOSEJqaHpqOUt5Szh6SEFWWlVXbXFYblpiN2dsUzJPTDBYd29weUVY?=
 =?utf-8?B?dTJDOHp5a2xoR0xodE5qUTlDRk8wWUtvN1FhNExSNk5od3JNWGdlbzJNWkQw?=
 =?utf-8?B?K0VzMFh5ZjB1Sm5IRjBieldBYURPdkhYQ0xqNnNFa3FRelMrU3dVRkUzSUhC?=
 =?utf-8?B?amRVVG8xUG5XRFBSWlAvMzNFMUIzTlROcHdQeWFuZTUwOEo2SGlodFViWndt?=
 =?utf-8?B?U0xwbG1HL1VDSGZCMVhGdkU3dzJQMWU5REY3V202UStXOEhuNEF3MHVodGc4?=
 =?utf-8?B?RzMzY2lXamJ3RnhUTTgvNnNQSXgrYyt3OE5TZC9wTkNnd1FnR0RyYVBDL2c0?=
 =?utf-8?B?cUJnK1RtYmlXd0dXZ1dzNU1kTnc0dWpnZ1NiRmR5OTExdDZ3c2xVNnJtYXVY?=
 =?utf-8?B?bmZsZkhURDVUTW5hVzJwRU9JZTFNQy9MMWhmN3Rsbm92SmZHVGV6Vm5mOEVp?=
 =?utf-8?B?TGRHOVpBS2cvT0psRUVsQktzZmNDdUNkaEIrTjV1Y2czaHI0MGlZSjJab3Nk?=
 =?utf-8?B?alYvSkxYcUF6YlhsTGJ3eTdGbFlsNllMMW94aFVoWkdkcmwwditXSXprdDVo?=
 =?utf-8?B?a0cwZkYxUnMzbXNNUTRzTGVzTlRGUXVucWwwZWRCNUhENEVKNXFHU0kvZUxt?=
 =?utf-8?B?MkNJOEdPdUROZXFWVVRLZGJ3a0dJM3V3NU9NUWVjbXUvS0g0dkV1WnRETE5W?=
 =?utf-8?B?WmJTbzF6RTZQbGdSU2JBVHdwY0NUdzZsMlgzTExOYmJSVC9UcFdkcU9NbExs?=
 =?utf-8?B?QUdQc1NMQ3VlQUZ6QUJnZVdUUjdBS3AyeWJaSFVnTHRsdmluM0drUW5NOURK?=
 =?utf-8?B?VkEyTnN0VHZjK1kxR3A1dXJacHJ1dDNSTFl1RTJIT0U1Mk1Da005QmZyNTVY?=
 =?utf-8?B?TTRWUEJKaUZpRlBDYktkU1ZvS0QvTW9sdkszMkpmN0dLWmg3cEhUV2gzUUxC?=
 =?utf-8?B?Sjd5dmNNWkhZcXhidDRlQkxxTzN4cC90M1pxTm1YSGhtMHRyT3ZwcGU5ck1U?=
 =?utf-8?B?T0VQME56TDUvTzZqRlFGb0lJQi9BcnVDNk9ITXgzSjYxNWpyTnF4M0Fsb2hW?=
 =?utf-8?B?Rk5tbDdCT1RwN1FEY2M2RDl4QXlUdWJKK2NDeUYrb21RN2ZxQlBFSjR6cXRY?=
 =?utf-8?B?aGJYQXdEczQ3aEZPcXV6di9BQ0t5M05uVVdoUmc3eXdEbEVkdno5OHlSZmVn?=
 =?utf-8?B?M0dWcnhqRGtxVDJCRWZWeXJQRUVqNEdzank2aDlLKzVQRVE3NngwMzZ3Vnpz?=
 =?utf-8?B?Z2JESlFBU3hJSmlpRTlyejk3YVIraWZ1Z2RnL0ZuUGRoMmE2ZTR0QXJwdFE5?=
 =?utf-8?B?UmplWWhxTm1iUDN1b2tHRUVoZ09vbHh1cGdyVms1UGk2VmJxNjZ4WnhDS1R1?=
 =?utf-8?B?emxsaUE4QVJNbmljRnAwajZFWDU3dG5leVJ2NFFpYTlyeWhoYS9Hb0s5ZDd5?=
 =?utf-8?B?VlE0NVliZWhYYW1HbHJPOERsMjA0dEUvenBMOWpDQnpwbTdKMzdLNHVrc2V4?=
 =?utf-8?B?Y0c5T2ZNa0diNXJrRjI5ZzMrR1h6cCtxYjdMUFRIVGhzNHpHYUd5R0NYaUta?=
 =?utf-8?B?WGtvUkdWdTcvVFQ5TjQ3SGwxZW5ReXo2NWpyMFlzSEZRVWlrd1FPK3JUZ3Jj?=
 =?utf-8?B?MVJTeFE1bTR1NFlsc0M0RmVTaVc1b0hSMUcxeElJTitNcGZwUW9NUTNWdGlP?=
 =?utf-8?B?bkZKTDA5M3EzTGg4WFNEc2RZZkZ2Q2Fsc1hDMjBOZFRGdmk4aEM0L0p1UDA3?=
 =?utf-8?B?ZElJTVl6djZqUTFZUUN3b3lFbnFYbm1WSGhWVDNNbExYVDd5TFZXcFdubjdm?=
 =?utf-8?B?USs0MFIzR3pOT3huL0RFZ0tLekVTY3F3T01WdjNrTlhqYVY4TEZLejFBVEtY?=
 =?utf-8?B?OUZjRnBEclV2dmE4KzB0Nkc2L3F1ZnJUVEd0d3BKZElaTFFaTzdSM0VWanBk?=
 =?utf-8?B?MzJOTGFlUUZlOVVUU1owbzJoT0dGOFZJWW9KeE1TVlhNUTE2NDJNUmRuSzkr?=
 =?utf-8?B?Nmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de0b2a72-737c-45e2-4eb0-08ddb489dfb3
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 08:17:21.4818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CVgFhknEWi+PLb3SyjHHu4csbQXCSU4nkMwe2OlJKGwIzAu8RtuHeQcnJvagLWERiBI8pYcu/uwsSF2jcQSwSGJK12pXHi0X3zRkzmzTFbc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6637
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Jun 2025 08:17:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19236

The lab is running.

Quirin

On 6/23/25 15:04, Chris Paterson wrote:
> Hi Jan,
> 
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: 23 June 2025 13:50
>>
>> Hi all,
>>
>> FYI: Our LAVA lab is currently down (including the only MCOM MTDA
>> device), and our team is on retreat - perfect timing :(. We will look
>> into this ASAP but likely only later this week.
> 
> Thanks for letting us know.
> 
> Chris
> 
>>
>> Jan
>>
>> --
>> Siemens AG, Foundational Technologies
>> Linux Expert Center
> 


