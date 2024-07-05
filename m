Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2122EC30658
	for <webhook@archiver.kernel.org>; Fri,  5 Jul 2024 11:12:17 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.42])
 by mx.groups.io with SMTP id smtpd.web11.15073.1720177934504102412
 for <cip-dev@lists.cip-project.org>;
 Fri, 05 Jul 2024 04:12:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=jTVVjPvE;
 spf=pass (domain: siemens.com, ip: 40.107.105.42, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k9W/jA07jkEAZts536Xez4Yn6kYXEnOtssVQ3kwaidGn0aQ65WMcWmg0G4jbz8z/yoKgjko2bAr/kY/Cm395CdB3bBhOXp2qawJ9+RHsns2/OfTkoKaEPcGjyDEHoDBb2KcG3x+uPaBi2vEhUdmzYYuRx/shldAaxZ7Z6r1Ck4O0AkNPT1oER3ozMMuYuOv4eusKkrpgxoy9fPiOzfZ3Xk0MORXDhoY014WYFU4CF9URekwTncosOcynLC9wWMqJLCGq0scU13YVHq2GLxZxxkQuTS4Qk17TOsij0GG8O7mBdvyplb/QV9J8GAD+g/u/ZuuhCuNgMWfquo9p9qV+LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rKEa1QX9HX9zp68yIuZIevI24UnsYGh9FLvL5/xDhNk=;
 b=XezGyAxTfcVHUtj+L1vLPzKQ9sXrLloQRl+Xo0fxNdTzwjxiBVU3Ey25fSfq7Gy6BehevBVp2dfLbaO+llBox5BGnIetu2VgXw7RXiMtSM9lfP+1ApC/S1dddtvbARHbpdEV1MrIYXUezEOiQWKorgu/z/McJr7OnmrBT2ZvnJkzY3AjQK/RQ/SkwvzC0Kp39lWoPeeqibnQLBKAIbywjhbXO488EQ/xbD2d+68zbTplho3S4wBMj8vuMYyARr5OwBO0BOqPz2Wr0h7zZ/1CKYUEJEPg7lvcieXLMubYhaouxv3zQXUXWy9Wo6WraqTI2N6agP8jMCZQZIRAshNG2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rKEa1QX9HX9zp68yIuZIevI24UnsYGh9FLvL5/xDhNk=;
 b=jTVVjPvECjdpoHGbzDkc+BEd34EHoR/wS5gGxQ5ISi/hbkI0OpZ3pCyHYH4fuJUbl3ffQbTDXEtUh7wHYZrNIHWIRn2I/HfxRYv2bWi8qRqBTmH8UODQhdpMCYuls8mlPfS6z9r2mh2dLhkUaAZ57oARndo4ktl8GqgKAktouvKA+nDBMYArUHs/3QO2I3XZBEDxpzTtoEDx1iARamQ9/GbuQHJq78hrmFV5pmqaTyvmXh1375XcNs7XldSwZ7oQ6+8p6ozb/NqQEQxvA4Z5pwfLJTHm33okj8r7GSuF+/NjdIS/y22atAHhnHJXOt6sMRJRecx2MLfQy3jNGzGT2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB8706.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1ce::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.30; Fri, 5 Jul
 2024 11:12:11 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 11:12:11 +0000
Message-ID: <123fc579-0f9b-4cb7-bd90-dbada71ecc49@siemens.com>
Date: Fri, 5 Jul 2024 13:12:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core v2 1/2] doc/REAME.secureboot.md: Add steps to
 inject UEFI keys from KeyTool.efi
To: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>,
 cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20240705071129.1374609-1-Shivanand.Kunijadar@toshiba-tsip.com>
 <20240705071129.1374609-2-Shivanand.Kunijadar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240705071129.1374609-2-Shivanand.Kunijadar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0364.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB8706:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c7baa96-7f6b-43d4-838c-08dc9ce35153
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dHQySFhTY2xndVlVU3FscjRWa2lkRENuWFJPQ0FPd1VmREdKbkpyRXBsamJY?=
 =?utf-8?B?VGtlRjhlcVd4TDlXLzNVVGptTjMrV1lZOEdEQ2JVVjNGaEFIV2RKYTN0Nzc0?=
 =?utf-8?B?SzBzNW11cTdSTHZqd1ZZSUVxdnVpeFdoK1lYeFM4NzFmTllsQzVOMi8rckZV?=
 =?utf-8?B?NXFFNVgvUlpYSlltTVlpM3pmUWdvTEtCNEhCNDRJWDFiSFAydWlHcm0zZ1Yr?=
 =?utf-8?B?MWhUM0RIdWgrSnp0UG9rVkxSb1cwQmFJUjIzZlNQOFFzK29zSjNmNnVDWXE0?=
 =?utf-8?B?N1RMcFllR1NtaWY2Y1hIS3FpWUlLVWlwWHVQNSs4Sk90dmZzVXVPTW4vVndv?=
 =?utf-8?B?eWhWWkJaazIwOEJRUGNZTFZ5WVYya29ickhKOWNDTngwOU8xYVN6Nmo4UE9U?=
 =?utf-8?B?RFNOTlZTM2syOTlVL29JNzdGaXpveEFlMGhCbzZvMStiM0JjNGQ5cUo2dWNl?=
 =?utf-8?B?M3Y3SDJRRlNoN1dPYmMyZGpLZGRMdVJuck9zNENaQVFnMUxxNWZUUVgvb2dy?=
 =?utf-8?B?ZG9ZNnJRcURiczZGMm5hRFpIY2FLa2RwVjcwd1J3bWJLMTJlTDAyWFFqSzZM?=
 =?utf-8?B?Sk1rOUhxMWIvaWVkeVlleEhDeE5vS3E5T3MvdEFHRjZjUVI5N1BiTzNwTzFQ?=
 =?utf-8?B?RndkeTN6dmhsWGdTSEZyNDIxZjdLdWZFTGQvOUM2VmZxUmQ5RFEySldjc0Rh?=
 =?utf-8?B?Mjdub3plcHg2R3pLVWNjWk5Ic0thUlBXSVVxVnhzRks2ZWxPdCtCMS9CL29G?=
 =?utf-8?B?K1ZmakwrNVpUdkhBRis4TFB4VnVnMStjL1A4bkZXSGR1VVIxQUtUSlQxbTM3?=
 =?utf-8?B?cGM2c1dyMTIwVUJJcGlJTnlhQ1BnYWZya3JWZ0RIVGdDVWEzS1R2cWFnazhj?=
 =?utf-8?B?K21IWG13NENrS3p0RndmTU5nUCtSQUNYbTZnUmxhb1FkQVRPRFM4SXpFVEF0?=
 =?utf-8?B?T2p4Q3VuZVlKVXkveXh1L0lHQTlCN1FQc1MwMXlYWjJXanlPT2trNFRtUGdG?=
 =?utf-8?B?UlpVRkYrU2gvZ3JrZDB5bEFmU3JLQngySmxteTRPdDNCd0JCdEdFaEVRbUdP?=
 =?utf-8?B?elh2aHVFSk9FZVZWL0VjUlJSWnFmTG5tUk9pS1UxNXJXRytSYm0vbXFsdnJF?=
 =?utf-8?B?SEwvOTNZQjFtVGNCTUlPUWMrTTRWL1ZNUHBUMmcwNlpNMXIwWGdUZTdsVTFZ?=
 =?utf-8?B?L244cGdtYnljVDRQbUE0bUlHQlhmaXhtRmxQN04raWV1SEY4VWkrRGNyRk5O?=
 =?utf-8?B?TkhiSVRxb3hkWmxnbFJ4THZWTC9UZHlVbDNkTDczbk5mOHhJNDFGRkJiTGYy?=
 =?utf-8?B?VjM1Zkk1eFVLVlNueDB3Z1FEdGpNb1E5cjFtV0l2bUFtTzkrR1h3THNQQU1o?=
 =?utf-8?B?aFhRQUViNVI0YnJLZ3E1SXlTNDAxczJNRDREMFhNLzc2bkdJVlpmYlppK00y?=
 =?utf-8?B?SDdhVHYrUm1UdnZaalIxdWE1bnZSUEdhT2lEWlkrR1VmTVNTK2VOYXJjODdV?=
 =?utf-8?B?ejV0Z0R6RXRuYm5oNEJUbTBCcjR4ODdpZjY5aVMvR2ZvalBEelVubmlkNGhR?=
 =?utf-8?B?R1psbkFuamlGOHNhcHM5cmdKOUZkYytTL1R1ME5IN1pXQnZITUM5b256cEd6?=
 =?utf-8?B?YTBsekZiclZJMDFseUV1OUsyUXdLdUZHMGU3RTN4QVI3Uk1FTHV6ek9rVW9N?=
 =?utf-8?B?VHVhTUtxdGpLaTh1SU9jYkMrYkcyMEdZbWxKQ0YwNE9NMTlvSEsyaUhuL01y?=
 =?utf-8?Q?pnjhmIZGhtnftVjNx4=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aWhLOGNWLzBFa1RZSEhoamNZNGZSR3J1eWhhdmljQVFCSzFKbGlQdWxoY3ZQ?=
 =?utf-8?B?bWUxUHM3YXRZRUNFUHJleTVOZEk1M01PYkZwb1FGTGhUY1VTcmI1VG5ZUko1?=
 =?utf-8?B?WktIZ0RVWmcxZjNXSmdCU2tUTzdMdlI4OCtFb3IyTUpKZUdyanRtUC85RU5J?=
 =?utf-8?B?Z2xXY2pYTUcwalY2VlNRemVUMTlET0dpajhEZFNzYkFMQlBYN3R0THRGdi8x?=
 =?utf-8?B?UWg3T2JvdGN0T1FhTysvOGdXeUVJdC93djI4eFlydUdIR0lTalc3WGtPUkZ6?=
 =?utf-8?B?OWZ5ZUtVWUxKK0phN21tRWEwdjVzRnRnMkhFY1VLZXNwdS9TZnYvV2xGeDNx?=
 =?utf-8?B?UGhZVlRtK3cwNjE2clZuT2NHU3pwTUZvcEZpbkNqM2xiVkRwRmhTZFRkL1pr?=
 =?utf-8?B?NE1CTmlkUzNCLzF4WE9MRnQ5VDBvL2wvU3h6bzBFREpGWlVRKzQwYlNZb3Aw?=
 =?utf-8?B?bnNXVFJWNGdzdVlqS2wyVGUrZlRXbEU1QnlwaDhEeHBQMjVUQTQ2VjFWSG80?=
 =?utf-8?B?aDJwMUNjb2Y3Wi9XRXp6Nk1TTUlpajFZcUJJOUZJSm9pSGp3VmRUaE1Bazlk?=
 =?utf-8?B?YVplRXA4SlZyWlB4LzJqWVBxY0MwN1FFQ1o2Qkx6VjlQMVJORWpaamRXOGVP?=
 =?utf-8?B?L2M4eG5sMTZndVV4ZGpTaDFtYnlIYjduVDdTTjNKZTVEQVRldUV0U29VZ2VQ?=
 =?utf-8?B?aWNjWFBUTTF1UWVJVWRpT3NVeFFBeGJWM2JIMkl0SXQ1WEpjanFIQ2xwS0Ry?=
 =?utf-8?B?WGFTTDczNXpvbElLRHZUQWlVWU9MUGR2bm55MUJDRFkybEg0ZTlhQTFnT0Ft?=
 =?utf-8?B?bzA0VThSMzZFb29VUWgwd0k2ZE1XSFN3SlRmTnZXZTEraWY5cmpoc2JrSElL?=
 =?utf-8?B?ZUpQbnBCeGp4SXdZSDVpTTdjR2Q1YU1kaDBLQUJFaFIrWlF2Si9FbnVTWWxz?=
 =?utf-8?B?bFJIQmt1dFVtZFlDVk5hVzgzZWdHZXNwOEFxNkRvbGhPMGVMTVZUejBzYnNM?=
 =?utf-8?B?M1hEWUtPYVRWU0hKK3FFN2lORlEwUVltcVdHR21tMmZzbUEwVm5EL3FadUw5?=
 =?utf-8?B?UG5FaHd4eExIa1h0L2JnUmUwcFRjM2FxL0NxREtaZDVvanYwcHBZckZiL1VX?=
 =?utf-8?B?a0VLcEpqRHdyV0tEQ2Q4VmszRzNyanhxeDlLVjJGNDVTWWE1QzB3MFVyb0Q0?=
 =?utf-8?B?QXk5U3I0UWorS0lIN3ZlTmd2OUxNMG0yT1dUVVNSZUhDc25XLzVBL3U3ZzBN?=
 =?utf-8?B?ZUFoTW5LaGFyOTN1bXpMajB1cTFQVDJES3VoVlVyNjhkSnVqNTNjc0Nram40?=
 =?utf-8?B?L2RWYmxtbmlIU256TEhCNzVMdDhaZnU0ZU1meUZ5aHgxYzc2SzBLTCtkOGNi?=
 =?utf-8?B?YVg1Vk92MDRlUDJBdjRRQ2QzTG41YkxMQkdadUFCQllkZ0I4bnJobHpqZFN6?=
 =?utf-8?B?OUg3dkpDKzg5a09ySWx3d1J5dktjQy9JKzlQd2VOZ3N6MWdQeS9UR3AvWnkv?=
 =?utf-8?B?Z09UcTN2MExGbG9kNXZ3Vjgyc1BPSThvekE4bWJFQkM4T1BPd05VTDBnZGc1?=
 =?utf-8?B?SU1RQlFaVWxSQUNSYVVTME9xYm5TbzNkdnBueDY4VTJtL2Z4Tnl2VSt5VnQv?=
 =?utf-8?B?UnYzTXg3OTlwcTRTZDV0KzQ2ajlNby8yeFNDd1FDVGhEMURFSEJveTA2S1dY?=
 =?utf-8?B?ZnJvV3JERHNtSUk4cndrNG9tWHBZRkJuRXY2OUdpdlJENnk3d1JFRWtlZlZj?=
 =?utf-8?B?ak95azVxdnhiaWsvZCtmTWw4bWNqV0RPMHdaL1BrOUx6V0Y4RUxjQmxZNHVV?=
 =?utf-8?B?Sk5NYUtaOElVOGJLbFc0aGUyU3Y1UkRQZldLcU5jNGpkalhtMzI3eUZndVNE?=
 =?utf-8?B?b2x0cW1iRVVlTWlveWxXR3lWd2UreHQxcnczZ0RMWGZwNmVKU2FrL3BFc1NZ?=
 =?utf-8?B?dVUrOXMzMVFSc0VUeVFWN1gxa29nL3VvMUZaZlR2c0I3RmdaNng0VnlrbE9Z?=
 =?utf-8?B?SytsdVgyVjQ5T0xSNGhsQVp6NVFGZVFrZWZsc09OTXpNNzFoNy8wcTZZOTlD?=
 =?utf-8?B?TnAzS2RZZFdqUEVGcXd4Qkc3ckpyZVJLbStoRGtQZmU2Ynh4M25qSWFhYVVS?=
 =?utf-8?B?OHlGQytmeVhlRHNpb3k4RlhORGd3cEd4VHd0TXNpOVNwdmpNTXA2OEVSbFNX?=
 =?utf-8?B?K2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c7baa96-7f6b-43d4-838c-08dc9ce35153
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 11:12:11.6362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HGb6OK8xJ6eANPTQzKwRyyhNcExqDq5/+kalkRo02Bu63Psm7rq5aGjizo367KmlfKM+71jIXp5CW9BESvkXXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8706
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Jul 2024 11:12:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16393

On 05.07.24 09:11, Shivanand Kunijadar wrote:
> From: Shivanand <Shivanand.Kunijadar@toshiba-tsip.com>
> 
> Signed-off-by: Shivanand <Shivanand.Kunijadar@toshiba-tsip.com>
> ---
>  doc/README.secureboot.md | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md
> index 3ae4154..337ece0 100644
> --- a/doc/README.secureboot.md
> +++ b/doc/README.secureboot.md
> @@ -322,7 +322,28 @@ The following keys need to be enrolled onto the device:
>  
>  The enrollment can typically be achieved with the help of
>  [efi-updatevar](https://manpages.debian.org/bookworm/efitools/efi-updatevar.1.en.html)
> -on the device. Otherwise, consult the manual of the specific UEFI Firmware.
> +on the device.
> +
> +If the device supports built in EFI shell then the enrollment of keys can also be done by KeyTool.efi tool like below:
> +
> +Format the USB memory stick
> +
> +```
> +host$ sudo mkfs.vfat <usb device>
> +host$ sudo mount -t vfat /dev/<usb device> /mnt/
> +```
> +
> +Copy the KeyTool.efi binary and self signed Secure Boot keys to USB stick
> +
> +Here the folder "keys" contains Secure Boot keys(DB, KEK and PK).
> +```
> +host$ sudo apt install efitools
> +host$ sudo mkdir -p /mnt/efi/boot
> +host$ sudo cp /usr/lib/efitools/x86_64-linux-gnu/KeyTool.efi /mnt/efi/boot/KeyTool.efi
> +host$ sudo cp -r keys /mnt/
> +host$ sudo umount /mnt
> +```
> +Launch KeyTool.efi binary from the built in EFI shell and follow step-4 from the section [Add Keys to OVMF](#add-keys-to-ovmf) to inject Secure Boot keys. Otherwise, consult the manual of the specific UEFI Firmware.
>  
>  Use the recipes [secure-boot-key](###secure-boot-key) to provided the keys
>  to the signing script contained in

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


