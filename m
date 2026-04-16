Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C17EF8D753
	for <webhook@archiver.kernel.org>; Thu, 16 Apr 2026 14:56:37 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.48])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16240.1776351386523939891
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Apr 2026 07:56:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=It/V1emm;
 spf=pass (domain: siemens.com, ip: 52.101.72.48, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gvrV3nN0jgfEnSxKtIpk+bJ8F58ybEcroV1wrtwiPTH5jeJSrtEGU5jjW/16hu26F7puTh1yKy5cevmFqtUqYECPetPk+Tq0Ocszipi8+TnDzp0HdlJnJvL2ezQU0A0Z+Gi+VKXJve5qGW2JjiEiNtjfXzZum8iL3yNRqHZKfBosOAVhuP0JR8CWyb1MUVbQFUfsfUZTf3A/2AyyxGATW7CQmEexHJ0D+DlScFbYuxfVfquN3g5DRUHkVu/9KebzKCeiEywM1SB5+LVxYqnkXd6peiz/8qwAkvMEg0iYZ2BuCpAn0lXj8kJf2jBKV8W09AzH+7wQq3tTpm+BfU8d+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dIv0Ga8woXiYY4akRY9VUGtm2vblq4Ph3FBEikxqU0U=;
 b=tg7nPPpY4nzSs2BTLT9vZUxu9EMeawaEGZo/2UTviZswEjNkk8o7iT8j1l5HQoq7ZrxgOIXvLLy5VQSsWUxf7WUoBtVDf+3VXcqX4jZbd4pQBfDONj+BxDhJM7/gxs/7xUh4NQRIj7sm5zLT4qulfCpwNyToE+gJAMCgmku8FK0WRYiPGc5rtfScplBv2RTy15vi/Zph7xMhZ4ze7Nf6liz281SKAgeoCsyl0FCXI/T+d33dsct5yel6bcvoK5sG9ZMy5+bKTuvEg5nZSfSL4vtS2rbk/kFn+EMo+PaZIqwOtJ7pVHjcmV14yTHvFztYUXZFmAG03MgsHliBIWu77A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIv0Ga8woXiYY4akRY9VUGtm2vblq4Ph3FBEikxqU0U=;
 b=It/V1emm8LP+nWU0pckPjp/HaVOTPq6go3Xjlzd80z67tqP/bnWTywBUX5DAMgq/agOktrw6zB76nheWiFf+aIOkPkdfag9whqBOASnraV/KVAaTmzCjwvrwIW31Wxrj+2/A1TuUFByrnOK1HIh2OebAK0+kr7lGBc0HwTT5szBcPlaqtPr53CQ+p59MXAb4itz/lRHtwTunmIVFU/wpMZaCV24qO3L92HFOHT1iXX162mUtCiPt+9VJ70UaPHXeP3d2THnXmnmv3hOn4HTV2aXKl/9w1T+pv2tyx9PBLX3+4PKUquoHnu5iW388lBlKGQVh6Lh3ZHdnbaAQNTiuTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by DB4PR10MB7064.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3f0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Thu, 16 Apr
 2026 14:56:21 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%5]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 14:56:21 +0000
Message-ID: <a4b214d7-4ffa-4bad-ae11-3793a1ea7a2c@siemens.com>
Date: Thu, 16 Apr 2026 16:56:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] encrypt_partition: evict stale systemd SRK
 handle before enrollment
To: Jan Kiszka <jan.kiszka@siemens.com>,
 "Sari, Sercan" <sari.sercan@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <DB9PR10MB6643CE84D750B5014B3606DCF05DA@DB9PR10MB6643.EURPRD10.PROD.OUTLOOK.COM>
 <9171aea6-f54d-401f-8fcd-92a902b3ec16@siemens.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <9171aea6-f54d-401f-8fcd-92a902b3ec16@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::12) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|DB4PR10MB7064:EE_
X-MS-Office365-Filtering-Correlation-Id: fe659a89-aba3-4db3-7d80-08de9bc852b7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|22082099003|56012099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	yjpf8R7h8m8MvR/lcP8xw2n3vtV8kk7ArrIxRp7Tp82zoZuUJKgSsRoNs9ud4TYA845GoCFjmmTC9OuV+XRawj2u2/HKHBKxNPp20ZAN0RGdtUN0cqcwyLruR43NnFdSD/Vn7dR2NwICmDRDadjsKDYk8wyWLYjBQf56J5xWmgT5DFE6AunVttc480N3HunWEbbAT4aoNDyHyOSGM33XjgtkP6HdOOo8eVZvC2rreez3DarzAs4TV4U6/ZrK/6ikctNUwDllOxujVM8X1KRblqlKmyu7/vYw2crdPF6UyiZrNuT5CGX4ZMwkItin6fxQFHXM39bUyc+x+jofbeqkgeOEbFXoqQQ2LMlYzEp5WvaXd3WpmlEtKxRoqIrOhqUfDEEejSaztyGGTM4FYGVoXyE+cAYWl25704+2n0qB+umIFDl4JAdK8Rc2V/9GO3v9Q5hx3tRzaqdxYomBaUcsEAyPFcYRTta3VNdOkrLRu4PRwks+OvsG0sfddXxpVlC8R9XtmSAchQDnMMb+6f+pn4SOLPiZX9GHfuyr/SCk63IXJcMfCzGScXfgonMUt9YPiH32hd/F4i17DJZQwTXUZpssUmaWi2dSk+LQTue1ICzw1lmIXeu1f9grYVieLYTv3xvyo4o7/W/H42hZgBySqv+q/2bJBD+2c1r5dSih6mPu5zMosgjPJhfv2tfUlpAvHDWBRkYnVtKmPBthLYU0bzlrapCDpHnTnje/wrGkGJY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(56012099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MHdGbTExanhjN0xYdDNVU3liNDFLdlRMMU85OVVzc1dlb1I5NWt6aWc4Y1By?=
 =?utf-8?B?U0duQk91cTZNWjBRUHIwUmdzZUJvUXVONUJHOS9YbHJiRDF2RXI1Z29YSFFY?=
 =?utf-8?B?MzdjcjdQeXZZUndDMVMyQVdQbFB1YzYvcjJtaE00VGwzTzR6N1RXWkRKVnhv?=
 =?utf-8?B?U3pucEowQ0tYa1FjU2FoTHQ3VTUrSEtxSFhFYkU2WHZLRkliQkVlQW5SN2Jy?=
 =?utf-8?B?UXFEemRiQnMrR1hpeldWanNneTJzUTlBc3JyYjdFUDJ0MER1elE1d3NYU0Ni?=
 =?utf-8?B?NmxiZWNHTzdIbWFXcGFxVzVsbU9YSWFzbGtVcU16K2MvVnZjbSt1QzhxcEFU?=
 =?utf-8?B?NmJRSFVMZXozNSt3Uit2TzBpNXo2bnZVT2plTHJ3QUtDNU1wQ09JUkFoVjB2?=
 =?utf-8?B?dmdRUVlWWG52Z2lUZEJqMXM0REo2YTNDdWh1T2wwbm56aHNpSmd1bE84clhv?=
 =?utf-8?B?c2tuZDZnK0xNOFc2ZFJwUDRPZC9NQ0kyTXVRVHIxKy9QeEtVN2d6djVtSnQr?=
 =?utf-8?B?ejNYMGhGYWczT01kODVwZXBGZ0FhbjZtT0hIbTVyaE84WmhqY29tWVd3RnVJ?=
 =?utf-8?B?UE9aS3JMR1ZFcEVlYlBjd2ZJbWF3MWN2dnVkZWh1bytQdVdvL2xxdnBuMzdU?=
 =?utf-8?B?UjFZUWxkUlJpU1l6U1ZPd0ZndkxsYVRjcVFUeWRUU2J4SlNYWldhOHk3MFhr?=
 =?utf-8?B?TmU5VnNZNVVIS3JLWFYrcFN5eS9XL21EQmVHVzRyamI2bFZ4eTNDRHdIRElW?=
 =?utf-8?B?R3JHaHpkUm5xTlJMbG9PdVVtR0xObXVQWVloalhRdmRRNy9zWnl0WndsMlNu?=
 =?utf-8?B?WnV1MkVHL0JVWnM2UTJaeklZM2dUUnRXdXBDRyt3V1JQUEs5QzFSZ09wNGkz?=
 =?utf-8?B?b1UyUWNlYmtMR0pqaThmTk9qQzhuSjJ5dlNZdWVPQU5UcWE0L2pyTFRVRmNO?=
 =?utf-8?B?aTRwek96aFhVT1MvaW5xTkdJeFYxeXFLQmpScmRkdTI1akpQM2U2L0IyN3Y2?=
 =?utf-8?B?ZnAwUUpLMWpEak5pdEhQY2pBSFVaU0Y0alU1WlFpSWYzUHNXQzJrblQxWGtp?=
 =?utf-8?B?b3F0TjFEcW9KcXBWbERwZTVCOUpBakNsSHhXeTZBek1CNDhiSkJtaVNWbGdy?=
 =?utf-8?B?STF5NXdXZ0h0OWRrWVVLSnpleXJSamcvWXRONUJQRTJvWENXK05adUt2UDQz?=
 =?utf-8?B?OEJyTTQ3STlFVHVxeU1YUzAyaDB0eXBZU2s2aVNDS1ZHc1BHb2h4dTNuempy?=
 =?utf-8?B?enZKT0pqVnk5SDFhcFhCVkpZUzYvdHczbVg0VHhlR1YvOEszdkY0aFk0KzlD?=
 =?utf-8?B?YW53QWhzZk1hYnhIN3lZdllBL1RHcythdHNXMHN0ekJwd1ErR1NKTmUwcXdV?=
 =?utf-8?B?b01wRFVtSjFXbkowZzZkUWczZXZYT1hMTFJ5a1pPN25RcjM2WG95SlQxNExy?=
 =?utf-8?B?MWQyYTdHblF3V3loQXJYcVozM25ab0kxdk5mYm9mSGoyTmtNbW5QbjQ5RVd2?=
 =?utf-8?B?UmNMbEowdWkyeGZSNk11c2RMRVRDT1EzZzIzZEsvQ2VxeGJqWVpJYTdoWmNt?=
 =?utf-8?B?WG1YQ3VFZXBEK3lJTjErUDc1SGtaMUIwdEV5aGFPREp2Vmc1T3YyQVVaNThO?=
 =?utf-8?B?byt2NTljbzBYYWUxQ3VHMStlc2lGTTFFbHpBaENxVlFacmd1WWQ0TWplSStE?=
 =?utf-8?B?YUZaT2sydnAvVVdFenBOM2JWZ1ZlTk1WamdoWC9QUTZ3Y2xIb0V3MThFQzVV?=
 =?utf-8?B?dURTa1JSaWNxOWh5QjBJV2x0WFk1anZIdWtHWnBEUGJrUUMxdFRYOVlHV2Iw?=
 =?utf-8?B?NG41V2hKc2psL0FqbGZDSDZZTGkwcitMK3JXRVhXUFJQQVZWZG05Sm1LUzRO?=
 =?utf-8?B?ZStpaDdacU04SlJVL3ZXeUlML2Rrc003T3k3L3dKdVBUeGxxMVc2REZ0eWh1?=
 =?utf-8?B?UWZzd09NN3hNaEIvdDFrWWNWdGNlVVl5NWJnNSt0UERpZERMMVRRU0pFNVM2?=
 =?utf-8?B?SWpiQ1JDZ1hIQ0FNcSttR0JEV0R6V3BwNEt1SlEydFNBdlRSeGNnQXJhMjNw?=
 =?utf-8?B?K2xNak9xTDR0SmNzSXVqNmhqZkJNbml4THlweGJaeW5WYWNtYUZUOHVscnRx?=
 =?utf-8?B?SlArQ0VCY0dCTkxITk80SFFOZ3MwSzZhRlBzRHVlc3NDbm9GVURILzVjZ1VX?=
 =?utf-8?B?TGFJY2drQnd6TWFZU052S08xL1NLaUxBcEowd0NGK3lrRUN3R3VXT0kwYXBa?=
 =?utf-8?B?N09XNFJvcENzSXE1T1ZRMDdLcm1vNUtiYmgvNVdjVDRQT01JM0xVWTkzWml0?=
 =?utf-8?B?TUlBTE9NVlk5ekFldlVLY0g0VEpsMHI2dVJSL1BIbUlWK3BXSVJHSlNmdUt0?=
 =?utf-8?Q?roOZCCWvOJ83S2Fw=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe659a89-aba3-4db3-7d80-08de9bc852b7
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 14:56:21.8434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gw2LhTdTeFHONJgUoSCLJDOl+uc1NmJrA3rOkMWFb9yjN/6h63wono4XxSSzoHzLjM7qbw9Vgj9iVbvfZKpqnUpUxVLZlD2sypntWFuo/eQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB7064
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Apr 2026 14:56:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22747



On 4/16/26 4:30 PM, Jan Kiszka wrote:
> On 06.04.26 15:39, Sari, Sercan wrote:
>> systemd-cryptenroll persists its TPM2 SRK at handle 0x81000001
> 
> Is that handle number officially documented? Or was it retrieved from
> the code?
> 
>> evict any stale handle before enrollment to avoid
>> "Failed to seal to TPM2: State not recoverable".

Could you also write when this error occurs.

Quirin

>>
>> Signed-off-by: Sercan Sari <sari.sercan@siemens.com>
>> ---
>>   .../files/encrypt_partition.systemd.script                   | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
>> index 1b7c83b..841219c 100644
>> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
>> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
>> @@ -26,6 +26,11 @@ enroll_tpm2_token() {
>>   	#tpm_key_algorithm="$4"
>>   	#pcr_bank_hash_type="$5"
>>   
>> +	# systemd-cryptenroll persists its TPM2 SRK at handle 0x81000001
>> +	# evict any stale handle before enrollment to avoid
>> +	# "Failed to seal to TPM2: State not recoverable".
>> +	tpm2_evictcontrol -C o -c 0x81000001 2>/dev/null || true
> 
> "|| true" is always a bit fragile and bad for debugging. Can't we test
> for the handle first and actually fail if eviction is then not successful?
> 
>> +
>>   	# check systemd version and export password if necessary
>>   	if [ -x /usr/bin/systemd-cryptenroll ]; then
>>   		systemd_version=$(systemd-cryptenroll --version | \
> 
> Jan
> 


