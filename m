Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B95C25B10
	for <webhook@archiver.kernel.org>; Mon, 13 May 2024 10:34:48 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.43])
 by mx.groups.io with SMTP id smtpd.web11.57105.1715596487939748686
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 May 2024 03:34:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=QyjoJ/iZ;
 spf=pass (domain: siemens.com, ip: 40.107.241.43, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0RVJ1A5h61op/YxtycSb26QqVGXkY0QU3H09iHEBmjPnfVovnoUlD/h6i+OqMW2n3Jb66N1Cf6OkJwdgWuDXuUqMdlpyujE8sO1L5o8KA/YOci8QCZkMwuHVGJqEH66QuXx3cjrn91FpCkvtFAK6RWlk9lWCleYwe1WcMiC4h7Xlrj6OsVlmknn7u4ySp5w9BnSY95Oxred5paqa3qv2IhL2Z18wJoRP7URcQNZIYrlJrKXZ7P1UUaVX86GCumjf/UfwvmkjCdB1NAX/kiHxmjOd3ehYPwHn8ySs+H7N+A9LoKOEIPBJbSF1aQaPEu8LT6BLFF7DR/6Rw02nGZd9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SKSHCh120vXBfCyiziHSCyMhe01oGs+JeBJYXPK0laI=;
 b=ig6+gAK+gaK+a8ceuhFsGAiOP3T4EqYqlBMiJvAik8zC1gSfxcbSQCRvRe5CyzbSSxZaH1TXq16JkZiIjaBc+VPsCs6qsalY6NL8cXUM45d6KWd3INfoVg0W2FZwIZKD3UAPiHf4pHlUyb2bdqj8jnKOhp5X4jZc8qEUoAK8VVeu0xrtIqbvWx8TKPs16CFZAIGNDN+SGxDZgYRVjk/jCIfZus51DmIcA4U4o6vMtlw5yOdnYwp7V3CK5VRSAMUQexNaTOrYSOR9mrcbj3y/akSS0cmnJ6tNuSaZwlqbVpQ9/eODxAZREtq0nS9xz8lUyz3ArQCfh5AeHXfFhtLsFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKSHCh120vXBfCyiziHSCyMhe01oGs+JeBJYXPK0laI=;
 b=QyjoJ/iZANcue3gL6zNfO5ghlysPdRB+EBaessiwY5NGWSUC8gvOb0kbODOQJvejUER5Otg1vBmw0+qyLbvmUXSTilDf7BdBgfOcv7WRX7DAA+SF2UHlRDEcbIIAgiPZj4MrNPZEysE4/s9+qIU0tKW6+xYYgNMWmUZUDts17us48OrLHRwTkCW/mfl04pjicoc3zH/aJEXxvc8NqVGrS099lwb3AGWq4zXSRKfbIGIbUJxeVvI3IDgdR8PWMJ52hMPk54p1YHjrvVAO4QB2SG/cseCcAhHDuFQq75a4PIeXfVwkp+uGwI6jdQULFdAPbPnxwVziWgt01r0/rXy5sA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DU0PR10MB7141.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:44f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 10:34:44 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%5]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 10:34:44 +0000
Message-ID: <302fc487-5d23-480f-b79f-32d7dd140d5e@siemens.com>
Date: Mon, 13 May 2024 12:34:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] Generic x86 kernel configration
To: Chris Paterson <Chris.Paterson2@renesas.com>,
 "Kiszka, Jan (CT RDA IOT SES-DE)" <jan.kiszka@siemens.com>,
 "Schilling, Benjamin (MO MM R&D SYS SEC)" <schilling.benjamin@siemens.com>,
 "dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <04b43c19-f26d-49c9-a12c-71cf3ba22e63@siemens.com>
 <TYWPR01MB1186261BB1B3D572F59B287E5B7E52@TYWPR01MB11862.jpnprd01.prod.outlook.com>
Content-Language: en-US, de-DE
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <TYWPR01MB1186261BB1B3D572F59B287E5B7E52@TYWPR01MB11862.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0046.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::12) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DU0PR10MB7141:EE_
X-MS-Office365-Filtering-Correlation-Id: 61f53c13-615b-4be2-772d-08dc73384d79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SUhUM3FXa0MwZ0F3bThKb3p4SHBJaXVwMGxkVk8vUmJ3SkZ6VTl3c2czRVl0?=
 =?utf-8?B?RWJ4WTNtZEdQdUovUzZUMXdLVzh1cjNoS1Boc0JQTmc1SU52cXBJejdFZEhx?=
 =?utf-8?B?YXZCUnVLMkJNdzNmcTB0M3VzU3IrL2c0KzB0aGJjbytKT3BnbVhUVGt5ZVdy?=
 =?utf-8?B?UmlubGttQWdqQnhKQlQ5VXFkZFhqQ2VleFpueG52SGhic2NTSG5pdU5DSUY1?=
 =?utf-8?B?QjNnbS9BNmhiMFhDZkUveW9yOU9Xdi8xaUo4aGE5LyswZVVBOVFudDF2UTls?=
 =?utf-8?B?QldrZHlRaE9NaUFBQjltQXljaXlnTGRYa0NCRWdVUVNMTGZGaXlQL09CanAy?=
 =?utf-8?B?VnRNNmg3UlcvTk1Uc0VIQzFPUlQwZ3laeTN2SHpsblNOY1lwLzBXUjd4amNO?=
 =?utf-8?B?L3AwTGxiQzBTRDhUNTN4ajZQSHh3Sy8vb1BWbmJBSWVtKzZ4WldRVmZ6a2Ru?=
 =?utf-8?B?ZGFOUkEvbk5PVnFUSlZaZVVYQkpGL0NpcXBBMmxuMjdRWjlkSFBJUU5ycUV5?=
 =?utf-8?B?T2xyZnV3QlNRTThKVjUwSk05ZEdnbzJXQkNHSTJmblpoalFWMWNpWCtXaWJS?=
 =?utf-8?B?VGNwMFhyUmFQTDBORDhIVUhMMkZpZUJFbWFSSUhrMzRUcnJ2cW9pSjBCbkU0?=
 =?utf-8?B?VkRmZkh3cyt4Q0pvckl3T3JCclFyL3Z2YVMwYmlydjJYZzZodFhmRC83aHE4?=
 =?utf-8?B?QWhPOU1PbFpNVlVCdk50aG9QZWZ3ckh1TVkrekZPV09hRGdmemVzekQxZVVS?=
 =?utf-8?B?bGRnOFZsK0kzd1Q0VFQ4cHBjWU1mcktKckZwS1hENWlPTmJuSjA1MUphK2hj?=
 =?utf-8?B?dlRoSTEwRklLTDQrMFl5NDVNOXV2NC83V2dZeGkzUU9mOENyVisxVWV2OUNr?=
 =?utf-8?B?WUtYR0VvZEl2VW4wcUR3T3R0bTdRU0dVU3lHRXhSVkUxYm9oN2dnMmpsblY1?=
 =?utf-8?B?cHE4RjBnUDYwbHNLUzExZFVJSkdEY0EwV2VBMHFvSCtsS2crYjNXTHNUTTZC?=
 =?utf-8?B?Y3J6Y0lvVDhIdkVtNlREK3h2WmZhRkczS2xscFQ2N2d4dnZ1cUp4WTdxT3Nv?=
 =?utf-8?B?TlhnZjhvQlpwaDVwaGpSY1crSWtGTWZqTXppVzYycGU2ejFkcHNxbDFzWkxF?=
 =?utf-8?B?eTkyOEpIdHl5T2tESmI1bGU2UmZuemNtK2FwL0FEN2grcnJ2aXp0QXBHL1hL?=
 =?utf-8?B?dVNEaDR3VG9PcTR5UnZqdGtVOFdWdTN0RmRjNnEyZVlDV1hYRFYvNDVMOGt2?=
 =?utf-8?B?ZW9aR1dVRzdqN1g2RWpSR2tWM3NhamtjZGhxTjNTQXkxTFlnd21SMnBtZHM1?=
 =?utf-8?B?NGpkcncrKzNsZVRSTjNXMWRRWFU4N1hSdW4rMjhEQVZ0Z25DdmJnY0tINmNG?=
 =?utf-8?B?RUVHRTV1ejZLcTJ3Q3ZHMVUxUUJuZGxYQldYenpWdUlQWUI0M1hGR3p5VWtu?=
 =?utf-8?B?ODNhNVFqVDFFdHJrZnB4R2VLeXk1QUxxaDIzb3E0K2xneDdNVitxdVZyTGw1?=
 =?utf-8?B?TmFIWFN2Qm40cXdIL0NXcHJOSDIvaExlQW05MEFzZm9hcVl5VzhKZC8yWmNT?=
 =?utf-8?B?akZoOWpIRkdRNlJpU0ZKdFJUYTRBRERiZm9peGJhQk5iQUNSNmpNeWdnc2R2?=
 =?utf-8?B?NCtmU2FWMkRKaWh3Tm5zb1U2RXRmdFE9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?U0RaZm9NUHpjeHY2d2IwWmpOQ1lVMzBla1BFRmpQdHBVbWZWQ0NFM0xIN1k5?=
 =?utf-8?B?aGdmNDRCa0dzNlJiOHZMRTZtdVhTcGFHaFJFR1lSY1Q4MWJFS29BQkk2NmJl?=
 =?utf-8?B?TVk1eHdyNU16MnU4R2FlOHF0ZUp2TVRGSlAzNkRHRTZDdDRPRnlNTVE0Y0dz?=
 =?utf-8?B?L1M5TkFsVS9vSW5pSFB2YmtFY3ZQZ25HZGYxY1p0WDdCY1BDWmducFZmOW1H?=
 =?utf-8?B?VGdGQlVSeTdNSU9Md1dXK2pSTDYyK2hkQTZ2VlJ1UjZENTFaZkpscmFneWdp?=
 =?utf-8?B?ZkZkRVdKUkJMWUswY3o2NHlTcnlXSDB4b3pERUxvYTJGNDFQUGVQK2xTdkdq?=
 =?utf-8?B?eTlZU1pCYW5GMU5Pa3JjcU5oTk05b28xUU5NTU81QlNlaEVxSktzWktLN0tX?=
 =?utf-8?B?SjEvL2lHZFg4MTRNL2hGV3JaRUV1Qi9qZGJxNGN5dUlWek1JVEg5TXhnMG0r?=
 =?utf-8?B?elRrOStnOWs2eGRMU2h6NGdKeEplN3BlZ2VQRlUxTHljVEF2VzZ2ckUzUGQr?=
 =?utf-8?B?UnEvTjNjNlFuQTlkc0pMbGYrclppd1lhRTY5NkFMbStxTUNxME5nQTlsN08r?=
 =?utf-8?B?UHRlNVB4elpSUkZUSy93M0ZSbURRbjdrN2lpZUlreFQ0WVJNOW5qdTB4dnNK?=
 =?utf-8?B?a3MyTDR0dXZKTzg1UU80aGhXZUZ4bmZUYWRQdG1vODVPYU5hRUNiU3dUUUJV?=
 =?utf-8?B?bnFUT0FGQ2lRUHAwendHKzBXSjlTVjlqUEZqd1RPYUNIUjV3OGNndDlMckdV?=
 =?utf-8?B?WXUrWnNDUXJGTUdZQU9rTnkvb0RyVXdZUTZ3UUVjRmxmekhxSitmRFF3MVdH?=
 =?utf-8?B?Wlc1ZXNuUmRQSGFhdUN5bm1jSDFDVEtGVmRrb0hFZ05jamxlcVlrbjlXTTNo?=
 =?utf-8?B?MllmVUhUWlVTbCtPQ3FRZktRT3lZNDRheXRyZElJbWRRdHNHcG1RcGZVTlA2?=
 =?utf-8?B?eUtTSm84Umh2Qm1WME9aUzc5MncyajdjT0tSM3AwVE5CRFZSNVhJNzhKZXVB?=
 =?utf-8?B?dWpOQ2VoaUVzclU4cDQ2aEpLQ0VJMUoxNWwrRW1tMVU3cUZncitzN0JqQm9S?=
 =?utf-8?B?dGNvQkcvRTN4cVg1eUtRMWRxMUZCY1lWSlRwZ3FlTzR6c3VQaUVHenhqTm5L?=
 =?utf-8?B?aHdkcEVXTktRdWllVlE0elFDMTZ5VFhDMHg3K1NjK1ExSStxSUg4ZjJXTWJB?=
 =?utf-8?B?MmlZQ1ZSekJpRlNYUEtNK1FrN0NPdXZWS3paWm9uakp1Q2g3cUFjTjBJTXpD?=
 =?utf-8?B?Ui9La25tbjdXWHRvR0RJclo0UUtXZW90dU1DaWR6cW5ENkpHb01Hb0VmL3Rx?=
 =?utf-8?B?Tno2VXFWOTYzUndDUW90YUQzVEpVTnBGQ3hjM1RtcC9mNHNxQVd0TlBBcXB1?=
 =?utf-8?B?S2pPeGY5VmNhMXo0N1k4NWxLR3NrRm5YUHBxVWVmdVhZd3k0OGVIQTFSOUJO?=
 =?utf-8?B?Mk1lRm5PNzFzNkh0U2dZZVhLMkVxZkprRUNTckpISTczRWFLcUpOS0VWeHlR?=
 =?utf-8?B?aDV3Z0VSMHc1ZEp2MUZWMXQxYnBscUt1T1k5aU4yRFFRSVBVbUtlY3U0Nk9D?=
 =?utf-8?B?V2IxV2c5OHhWQUJSa2hxU2I1dGx4Z29HZCtKQXgvRVhYUitUY3ZnTXlHeTh4?=
 =?utf-8?B?Yll5aTQ3ZGxZZFZYYXI0NWNRMERqTlhPa3VNTW5wRjNLUWdva0pqTU5va1cr?=
 =?utf-8?B?UVdQS1NmYVBSVzZtdVcxUnRUNmNlamgzaXpheVJnMTAvYVFRSFNBOTRWTDlM?=
 =?utf-8?B?VnB1aFRmV1J0Z0VmOXUwSDZhS0Z0NGpMdkUwK2hWU3I4M2w0YysyU216QW4y?=
 =?utf-8?B?UFRJTVNYVCtPMmNLZXBWK2dwWFNZcTgzWVBHRFROek5sRkV4OTRmR1N1TVhI?=
 =?utf-8?B?UjNtbmNMdTBMZ1Vuc2FJQkx4d2FJdzQ2SER5dG1TRkRLUzNXcVpjN1RCTmt1?=
 =?utf-8?B?Ry9abTdoU0hhdUdybVpBbWpxMjBtMk9xaEhjbVBzR01ObXVUUktmOFlFZmlt?=
 =?utf-8?B?U3ltNk5tbDE0T1l6bGxwY2JLYWF3bCtFaTRYSktjUFVaSkU4U3FMUDJXZUNq?=
 =?utf-8?B?eFFvSWJuQXpxZ052WWo4b0pOSXZUeFBNN3l4T2JaN25CYzh1M2NERWttaEZM?=
 =?utf-8?B?ZUt3Z1dyWUdWY0J5RXh1TnNJeUVFSTVXclVla3oxWmE2MEVTeE1PNzNyblFi?=
 =?utf-8?B?Q2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61f53c13-615b-4be2-772d-08dc73384d79
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 10:34:44.0404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J06+3EyqAUCu+0WFC0wTrO7QwFLb9aHGK6eKs6Kn7AWouGBWh5uY3704TGH0zLgbCxFsOk+nYUW/M7L8nQtRGyLqfIZcdqkAjUwVlnzSQ5U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7141
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 May 2024 10:34:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15886



On 5/8/24 6:00 PM, Chris Paterson wrote:
> Hello Quirin,
> 
> Thank you for your work on this.
> 
>> From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
>> Sent: Friday, May 3, 2024 4:58 PM
>>
>> Dear all,
>>
>> I have used a forked version of [1], which you can find here[2] to
>> merge the following x86 kernel configs together:
>>
>> cip-kernel-config/5.10.y-cip/x86/siemens_server_defconfig'
>> cip-kernel-config/5.10.y-cip/x86/toshiba_atom_baytrail_cip_defconfig'
>> cip-kernel-config/5.10.y-cip/x86/siemens_ipc127e_defconfig'
>> cip-kernel-config/5.10.y-cip/x86/plathome_obsvx2_defconfig'
>> cip-kernel-config/5.10.y-cip/x86/cip_qemu_defconfig'
>> cip-kernel-config/5.10.y-cip/x86/siemens_ipc227e_defconfig'
>> cip-kernel-config/5.10.y-cip/x86/siemens_iot2000_defconfig'
>> cip_core_merge_kernel_config/recipes-kernel/linux/files/mcom.cfg'
>>
>>
>> I have tested the v5.10.214-cip46 version of the config with qemu-amd64.
>> The next step would be to check it in the cip lab on the real hardware.
>>
>> The script takes the Kconfig entries of the specific kernel version into
>> account. It also adds all dependencies to the config. You can find to
>> log of the merge at [3] and the diffs to each configuration at [4].
>>
>> An first integration into cip-core can be found at [5].
>>
>> Any comments from your side?
> 
> I had a go at building/boot testing the linux-cip 6.1 kernel in our GitLab CI setup using your merged config:
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/1283476801
> 
> It built and booted okay on the ipc227e.
> However, it didn't boot on the qemu setup in our LAVA lab:
> https://lava.ciplatform.org/scheduler/job/1129968
> "This kernel requires the following features not present on the CPU: movbe"
> 
> I don't know if that's an issue with our qemu setup or with the kernel config.

This comes from CONFIG_MATOM which is set by the toshiba configuration.

Quirin

> 
> Kind regards, Chris

