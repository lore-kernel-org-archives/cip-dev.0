Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C936C3ABA3
	for <webhook@archiver.kernel.org>; Fri,  2 May 2025 07:42:27 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.66.37])
 by mx.groups.io with SMTP id smtpd.web11.14241.1746171727697046938
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 May 2025 00:42:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=BF0ku+P2;
 spf=pass (domain: siemens.com, ip: 52.101.66.37, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sV/daJzatCoaUcKfwmqtWXqpW4ftk5Hok9Lt9K7VEcenxsH/zquJAS9kduGOiu4bWdH6/MPhRZObjqgB/RwZI7NKZGvF1gr1/JejxqEHdZrUGf/C7dq+93+HXAJe/lmN/t5cB+Iwz0OH/tTsxeYW3fu5B0mcr7+iZ8cPRFmlscPtsgE71nQKcw09543o35lNIjSOev7syFNQpK0qF8VD4Sr/EEr+id3WEjZqG0cc5nLJVA5LB2eVaznaP5ZOYJJmBcwZUzlylJaVAi32MqM/vm6Kgilw62hkRri5Ivt2OBQUDeIZGMXbLAuK36q21IohI6/cnenc9VltGG49slD3Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C10ay5DIyb92o0NX87DnsWt2vx/cw3HEFtUdLbPurWQ=;
 b=kKuY+WuzIzu2xTLH6NXNjsxIoad2CZv9pRei3G+Ql0jz1gyPN8k/nsfqU3fryPQMesxXJjUskoOMrvW73waAFBLaCZFrVt9lLcUjoE+AHF2sEafWy0ohK4c97qNf/cYMZr60soWD+EpS/KLA5MO5tlaBtwHx/xbZhRS2PZEShf0SwsgQ8zdeG3589VoFqdQGbmEnUFDLl+D89wok+FnmQXD3mcozPCDEMN9Hb8A7iRsvE50j5mn3B6uVEYXK277QwIYU/hBkxQgAtV3F7zFghkULpwSpqSgm96m8N22Nc0ogPe9l6M9lHqjouoUUPu/6QH3HMT/2lquJLqEmJTBTHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C10ay5DIyb92o0NX87DnsWt2vx/cw3HEFtUdLbPurWQ=;
 b=BF0ku+P27QuP2RQLD577dEW43HDQEg4xJ+z6GusnJi1vMw6l1POuGO2txttJsbQfAisGkvVUcP38LWIyG7ngKgG7phvLAnqkT47U80Y7M5eW51jjK0WWRDYhT44LZjNm2uM7xWhlI7kTLHnt9gBUyDrlAg/tZXSuU4zQ0DHPKuiwUHX2d9VR/CXmbu3qqUZbDM/tAhKjL4FxuY3h6zoh7p+ibE6qolPy2krO2bJ+y3KbSf2NZyuAam4SbNTQpcjHizCKrOU5Qwlfo8iHIUT6TTvSkLhdbA9uARsJAIj7KfYGoTCALLLeU3Y8aMj3zhJwSF2ykeB0ZT6z2gim2K5fkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM9PR10MB4133.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Fri, 2 May
 2025 07:42:05 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8699.019; Fri, 2 May 2025
 07:42:05 +0000
Message-ID: <015d9f1b-540c-4943-9a5a-1bc7bce6ec80@siemens.com>
Date: Fri, 2 May 2025 09:42:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v1 2/3] scripts/submit_lava.sh: Remove
 passing readonly=on for amd64 OVMF VARS file
To: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>,
 cip-dev@lists.cip-project.org
Cc: sai.sathujoda@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
 kazuhiro3.hayashi@toshiba.co.jp
References: <20250429042028.3579304-1-Shivanand.Kunijadar@toshiba-tsip.com>
 <20250429042028.3579304-3-Shivanand.Kunijadar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250429042028.3579304-3-Shivanand.Kunijadar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0041.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM9PR10MB4133:EE_
X-MS-Office365-Filtering-Correlation-Id: 405756d0-8c59-441f-ae24-08dd894cd57a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ODQ2dDJqWDNBYi9yTVJnL2tLcXk0OGZDVUZhZ1dFaDIvUGI4d1hCWUdWazBU?=
 =?utf-8?B?RDRzUmJpOFU2NzJZSHVLbnRXUDQ1K1kybkwxUVdsN2Q5NUVKY0JuWlM5S08r?=
 =?utf-8?B?aDhFaTZqYnZYUHovZnlxbE5KZTdFZmNXTkFOSmFxWXhxdVVIZW9BQjFNYmh1?=
 =?utf-8?B?ejNFcHpHeDNUVTlIWVZHQ00rem5HZEVzYVFqQUxVdWxmNTZZamp2cWM4VDhY?=
 =?utf-8?B?YnFma0NUZ0RmK2ticEtMa0p3d1RjeDJ4ZThRT08rMkcxMmpCekFkTjhhTE9y?=
 =?utf-8?B?Q09lallHQnQ4a1F3TldnUlpqaHVyTUNTN2ZKQ0FNdHBPNjFvVFlxQ1Ixcnlm?=
 =?utf-8?B?aWdERjEvMmhWeFNKTXhpbEp4S1JPSkticFVLUDFmcFdURHpPYVNOT0o0czVK?=
 =?utf-8?B?MFh3OWNJK1JhMjV3Y1NEYS82ZkNVSE1aZG1oTS9PREw4QnNRaU42TjlPVDRK?=
 =?utf-8?B?UE55QmZCM2hnMlJ5VDMzbFdFcWk0Y293Z1lTOS9OSWM4bnlraDMxc0dmNjQ4?=
 =?utf-8?B?RHpZRnowbDJEM0djUTV3NHdUQlRjSzhadUFBL1JIM0FKNlBPSlJKKzhqeThD?=
 =?utf-8?B?QjRsUmthbFhLdmd5MFkzOGxGdC9DOWlJZXJDNEFhTDczaFV0ZG1wUEpaSDNY?=
 =?utf-8?B?YVpaWU9XN2NoaUpRRE56WEtXcWhrNnRaK1ZySjlRZDZKUVZOOSt6Ky8vRVpq?=
 =?utf-8?B?SUZZM25DS0xFR21iR3BHSHJFRkZ3K0dRcUJDZzJjM1EvOE1GeXZOUDJTcnFE?=
 =?utf-8?B?WTJOYW91U2FGeWZmZlB6ZzJibzdzMDZianM1Yy9VL29DWWZNT29iZGNtZDlB?=
 =?utf-8?B?YUdPc05YYUxNKzRUNTVxYlp2TnNmV3QvSFlvQzlmTGxXbVY5YWFOQ280b29l?=
 =?utf-8?B?M0dJSU13WTByVi9Qem1MY3FyTUd3VFZjUE5ucHlEcHBrQ29PbVpNaytFTXU1?=
 =?utf-8?B?N1RoQlZGcnRONk9oWDgwMEF2MkRITzd1dnhkaDhEM2JHNjFTdXBYZjhrbzVp?=
 =?utf-8?B?S1p3YldrMDdTRTliRk4yUmtJUEpSSHdqOWFlQzFuek85djdBTEZoRWUyaTBP?=
 =?utf-8?B?Z0MzTEh3cmdyRStvSVA1VVJSaHc0VzZuMnlqdkFJV3F4TE5GUTZoV0NJaW4y?=
 =?utf-8?B?TlpXL1BpQmIwS284bUpEdHd2R3liTG9URmdwLzBVL0RUamdTVzUyQTl0a1kx?=
 =?utf-8?B?K2s5SUpicFdzVEx2Z2Y2UWcycW9SR2wvL3Irc04vZHBTcXlvNjZNQ3dtRFhR?=
 =?utf-8?B?bmdURjc0TzZlTUZnV3RWYytkTVdXZG9EdDJISTNFMDZndEZBTG10ZzZZV3V1?=
 =?utf-8?B?ZWI4QXd4dytLdjRZUXl4ZnJEdUhaM2N1Vk14N3ZQVy8rSk1yZmhWb0w5RWll?=
 =?utf-8?B?R1cyL2h2RnpSOGhhYkJKSURneVlSVVBXTERvWng0Q3pOQTdwQzhUVWQySksw?=
 =?utf-8?B?OVNINnZLaGlxeHFvUXU0UkZPRUZiS0lmYXo1eElwNVg5OHV0bnN6NmFMNm9s?=
 =?utf-8?B?ZVV0enlzQVZ1ZUNHR1lqMWlPbkdhK0VTa3lvell1V0l3M0tUblRDK3R1M25N?=
 =?utf-8?B?eUdhMWZSbVI0N3hxOXhtVGYyVUdubDhkSVEveG4veTNoWlVLNG54NktOUk9W?=
 =?utf-8?B?cWw4a2VQbUszSlk5MmRDbDNEZk1vSnBYV2xFRDVZd0dEN2lQZ3pmUzR3d3hO?=
 =?utf-8?B?UUdUL1dvWTBEMmNDS2ZJYnEzblcyTzJiRGh1QU9FdGZIV25XMGd0WkZrUVNZ?=
 =?utf-8?B?SGdDbnpiWG1BbUJNcWZkMnVPYVNKaktiYW9jeUZNRHFTcGZpL2o0ZUZlY213?=
 =?utf-8?B?RTBQL0JvS29ZY2Fza0p2cUsvN1MwWlI2TERyWUxIUStXY3MwcmdYQ2hTYm1h?=
 =?utf-8?B?TjJKSGk1MS9BTDl0dmdwOVA5V2RrZDBIQVptRHRCSWp0azMrV1BCeWhLRGZr?=
 =?utf-8?Q?p4WqTycwTyg=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?L1UrOXltY3hnSnBlSUFUa2pjSjhwckE0R2J2MUFIMk9CM1RlNEVLeWNTdFIy?=
 =?utf-8?B?NjVDR0wrNDFIaXkyTlJXM1ROdEhJZHc5OXQwUlpUd1RHTG9YTkZLU2FnVm10?=
 =?utf-8?B?V3BBVlFvSFJOSENDdmhiWG44UlNwOGx1UzJ6Sk04WHV0N01kV0Y3c00vQ1py?=
 =?utf-8?B?VW04U0hVUVIvMCtqdmdOQWR0VmRzeGFXYVdmc2tka0w4SWo2dVYwMyt5a1BR?=
 =?utf-8?B?L0dTVE1XTTZJY1F5VktVdmFqaUlYM3ltZjlzNzI3YnBTODQzWlZsd3pQZnhX?=
 =?utf-8?B?Rzd1UlY1b1hITk5IeUZDZzFoTy91aytvclNhNVdaZTJCcUtIM29UaEV5UUhT?=
 =?utf-8?B?eldBMjlTT2Z0Nnh3MUhnVmRkQ2ZkcDJxbTVmVm5EL1h6ZkxxaTJWVHZrSkpE?=
 =?utf-8?B?TzlYYmk3aFlYdnRPTVRQMkVocjNUWnUzcE5aS3NLdnZHS2F1SXVyWDdwR0RM?=
 =?utf-8?B?YjBoRDNnRnljOFpTYUFBNFZ6cFUxTCt0eDA3d2tHWjJCSHRwdlBKYjY3ZFlk?=
 =?utf-8?B?U0ptRGg0NlZxTTlFMjA5a05rcVlyaDBYa29hZElWd2tEcUw0VW0yOXNMT1Jr?=
 =?utf-8?B?NUpld0lrU2Q1M2lBaUN1aDB6M0RzQ1NnbnhiaDhwMXoyZ3JRNUxsYy9sTzJw?=
 =?utf-8?B?THExaU5VdGhMdlV5QUQwWUF5bWh5bCtRYW9UTFVEU05jUy9pQWlNNWVSc0x5?=
 =?utf-8?B?Umc0UExXbkdFU3BRQVJRVWN6L3F3V2VSOEpWY0k4M0NoQUY5Z3ZwZk5WVFJE?=
 =?utf-8?B?R0xZaXc2OXRmZnVpUUN0RGpsYklCdzU0QUhSSHVJVzVPZVV6djl0amQzYXFK?=
 =?utf-8?B?d0pXR0VSVzJ1bEwwVlNiM0NoK3BlejhlOG5pTTJMU3N6enBaa3lLcUJPYVdr?=
 =?utf-8?B?bllpZFRZb1Z2YjcvWi9MMHZjTnlyeHZUb3pnM0thWVdtWE1CM1ZWOUxlbUhy?=
 =?utf-8?B?LzBHWjFjRFcxU2NNVFlBcVlscFlnQjlCV1JvaVh6LzRYd3liY1lGVVZxY3la?=
 =?utf-8?B?N2NXZ3Nmc3RGZ0tVN0F3WExwbS9NRnlqTGlNaUc5bFVRQVgzTVZISHBnaHl2?=
 =?utf-8?B?OHYwUzNQVE5HeVdkTk5WbG9FbWdtdDBaQjdNeWpXZnJzdW81QUtVQUxtWFlu?=
 =?utf-8?B?ZzZ0N2Ftc0loTVp3L3lOblhIYnFzQ2pZekR4Mys5UGUvTmdxRlF2ekJCTlAw?=
 =?utf-8?B?dUJGYXRKZFNsUkptQWVYS25QSE5WMzdITisvbnhnUGJyNHhRb2pBWFVsL0lh?=
 =?utf-8?B?VFYzenkyUDQwUERSMmgrbEpkeCt5TEhsQWRmbnJvQTBUMzVuUm9HQ0RDeksr?=
 =?utf-8?B?SVZKZVpPVC9XUUdOOE1EbVNYYlRMVFlpQXAxcUk5a2JWRGY4VXFlUzd4VFRE?=
 =?utf-8?B?Rm5hSHFheFdqUk9BMHpFcTdNWDBGVUJnWHdVSkRCbm1PNmRmNnBTbGRiMEVL?=
 =?utf-8?B?b0NjZDluUzhCMFNNNTNNRlYzWnpDTGltT1ZlcWVSMEhST0gxcVNzN1Rnd0dG?=
 =?utf-8?B?N0RxUkNQaS84QVZnOTNUR1BiRCtRR0NUbzBHRTFYalJobEptYW9pYm1JaFhQ?=
 =?utf-8?B?MnRyY1NOZkdGL21BTHowMWIxNG1kYjNXeVBOZzZ3S1BKYm11U0IvWTc0RjFm?=
 =?utf-8?B?NCs2UUw3SEtQbUZCWk9tNytZL2hWcGZJUTlmaFNvUmpNQjNtT3FWYmtoeFB0?=
 =?utf-8?B?NUk1TDlIOUgxKzhud2tlbnJRTVk2cGhWRXE1MDVvTms1UmhreGtOTlNqWmFN?=
 =?utf-8?B?TGVYdVBQQ2hudUlieXRrdWZrcXU5TWg2ZVdxeFpEcW9KMUI3S0V2RzRTcmt1?=
 =?utf-8?B?VzhBOHVoMlcvdVJLcjQ4ZGZxenlhZzFZWXVOWE4wUGZQeHRob1Jsb2pweUp6?=
 =?utf-8?B?SzZjUTNFMk9xS2RsMUpBWUI4ZXZGMkpURWM4blRqWlNYcHMrM1B1SFdwelQ4?=
 =?utf-8?B?V1loTnJ5MFZXVFJTelkvYTF1bTBGdCs1eC9BN2JXMlAxTUdWRUtuQXVGL1RH?=
 =?utf-8?B?Nlh1VlFKYkdUZ1VBZ0Z6MENLWWVPZkJnQkUxY0UxekI4dWZGRDlPaTNsSzdL?=
 =?utf-8?B?UjdBQktPQ0k0b0Z0dVg2endYZFVQRHRVRDRhaHB3a2prY1NYM2ZFQmFuWWlW?=
 =?utf-8?Q?iOzGKIY7dkLVQlZUx2tliBKQ8?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 405756d0-8c59-441f-ae24-08dd894cd57a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 07:42:05.0281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tak1qXmgyNRMQsMKf4PN+uyB2D/brgLiT30Ti95XqoezGoVUSGUmvZy/PSpBVSkeQkJJttPafGn1jpR46bWbWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4133
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 May 2025 07:42:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18749

On 29.04.25 06:20, Shivanand Kunijadar wrote:
> Passing readonly=on for OVMF VARS fd is not necessary, so remove it.
> 

But we are using it in start-qemu.sh. So, is this removal needed for any
specific reason?

Jan

> Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
> ---
>  scripts/submit_lava.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/submit_lava.sh b/scripts/submit_lava.sh
> index 6eca70c..6cb0837 100755
> --- a/scripts/submit_lava.sh
> +++ b/scripts/submit_lava.sh
> @@ -33,7 +33,7 @@ if [ -z "$SUBMIT_ONLY" ]; then SUBMIT_ONLY=false; fi
>  
>  # Create a dictionary to handle image arguments based on architecture
>  declare -A image_args
> -image_args[qemu-amd64]="-cpu qemu64 -machine q35,accel=tcg -smp 4 -global ICH9-LPC.noreboot=off -device ide-hd,drive=disk -drive if=pflash,format=raw,unit=0,readonly=on,file=/usr/share/OVMF/OVMF_CODE_4M.secboot.fd -device virtio-net-pci,netdev=net -drive if=pflash,format=raw,readonly=on,file=/usr/share/OVMF/OVMF_VARS_4M.snakeoil.fd  -global ICH9-LPC.disable_s3=1 -global isa-fdc.driveA= -device tpm-tis,tpmdev=tpm0"
> +image_args[qemu-amd64]="-cpu qemu64 -machine q35,accel=tcg -smp 4 -global ICH9-LPC.noreboot=off -device ide-hd,drive=disk -drive if=pflash,format=raw,unit=0,readonly=on,file=/usr/share/OVMF/OVMF_CODE_4M.secboot.fd -device virtio-net-pci,netdev=net -drive if=pflash,format=raw,file=/usr/share/OVMF/OVMF_VARS_4M.snakeoil.fd  -global ICH9-LPC.disable_s3=1 -global isa-fdc.driveA= -device tpm-tis,tpmdev=tpm0"
>  image_args[qemu-arm64]="-cpu cortex-a57 -machine virt -smp 4 -device virtio-serial-device -device virtconsole,chardev=con -chardev vc,id=con -device virtio-blk-device,drive=disk -device virtio-net-device,netdev=net -device tpm-tis-device,tpmdev=tpm0"
>  image_args[qemu-arm]="-cpu cortex-a15 -machine virt -smp 2 -device virtio-serial-device -device virtconsole,chardev=con -chardev vc,id=con -device virtio-blk-device,drive=disk -device virtio-net-device,netdev=net -device tpm-tis-device,tpmdev=tpm0"
>  

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

