Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0028C43334
	for <webhook@archiver.kernel.org>; Mon, 27 Jun 2022 08:23:36 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.82])
 by mx.groups.io with SMTP id smtpd.web09.39191.1656318215079505136
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Jun 2022 01:23:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=GwpDoak6;
 spf=pass (domain: siemens.com, ip: 40.107.7.82,
 mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lN4EXdnx8Jp4I9kiPAhLLwqtGyB0nLQX8C87AN0/kUySzfaD3nZGt6nJh0j1JMMwegOUitrSdUpwHrazKRPobyrzGk5/D9aCjmM1tvkwO2xulD2MrmTx9UlrTxjHnNXm/W75oglh9J8YZjSXnwulhQkTcoWX/krJHlCDJUlHnfuyG8nd6HrIwYP6q2NwoYsTElHBOv9Y+pjThrEOXOIB7G0afGsyWRGzQU+iYoq8nDh1gmfQvh6pcxSKGFjeXj3pPQAlKjAPKMrsiaM98QbrKxsa8HhDBbY618pHnGXwW7+J3j5hlzbUBIoXpHGoRHRQKAfAhuBuQcZgLi2nAeKbBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C5ZgPjoDXbRN8xM/0OO8y8o2lYO+Il46bA6FBPdxfKI=;
 b=LbKcONZNlTluvgmoAWqm1XViGygnmXZhtLAqpIgCHC8X7JcPHjfw2JpnL3rZ48kiZ7m29sox4IhmMRBhFWh7b4QgTgZbaIhWX7UJAZUU/vM0/SHyaroH3jORBpxJvyuhoTNHIdPfes7FyTzjR7skvVG2o/UgxTCsnJ7UA7WF8qOjjJOju84iJucJ77Ob8pXIW1399m9wtb87JBBpbWRpd3MnaUzk/dfJEcteg0Up9/QiZbFpL1GdIjghq90a1neAWLqk7Pb+nUfZtbp4rn0kPiS37nJbHF0dtV2MziuNzkP/MqZg/gOYxLMVwyFsz5i0pR0pjkiDexjlFZqnRuV49g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C5ZgPjoDXbRN8xM/0OO8y8o2lYO+Il46bA6FBPdxfKI=;
 b=GwpDoak6FblQXTx4juVurrPRWGjyq2Y5ZgzAedVehq0iyZSLv9gray9CEqwBbOkpxqOj5uHSNo3aWFJ49LhSfst+3QOH0CU6K7X7Hu16wgGP496wgOAlj7JBGWeVuh0Rhdd66D7u0LHc3RI0T7HQdwudDjDtTpuQEKpdl29dAk2wsBEzNvePxcwUMn+194jE9/RzwKLsW89GKpRlI7mPWz5i1ucCdAV1VTEE5pNlZmjnLCgO+gqToLozX18cp+5eb/nAoX+BtlMnXHtit9+VtarxrZRtU5fxGduVBbszjTYoQsxqlVzwUTVhKJbvgsEkysHpvpREaYhDUfxoX2rJ+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DB9PR10MB4896.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2cd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Mon, 27 Jun
 2022 08:23:31 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::39cb:2de9:b553:e2e1]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::39cb:2de9:b553:e2e1%6]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 08:23:31 +0000
Message-ID: <95a32358-94ab-d9c3-c0ac-df0258e2bacb@siemens.com>
Date: Mon, 27 Jun 2022 10:23:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [cip-dev] [isar-cip-core] [PATCH] scripts/start-efishell.sh: Add
 -nographic option
Content-Language: en-US
To: cip-dev@lists.cip-project.org, Sarath P T <Sarath_PT@mentor.com>
References: <20220627071206.21277-1-Sarath_PT@mentor.com>
 <665fa99b-7ab0-1b8c-3662-c1f1ad7a8d4c@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Organization: Siemens
In-Reply-To: <665fa99b-7ab0-1b8c-3662-c1f1ad7a8d4c@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR0301CA0017.eurprd03.prod.outlook.com
 (2603:10a6:20b:468::33) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: acebab1b-1f55-4aa5-6e81-08da581651ca
X-MS-TrafficTypeDiagnostic: DB9PR10MB4896:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	4mdx2WALbIsympmt2Sn+luT8htCHntRbGyFifV+SoxDI2cYoEVyj5IutVHwN2xaVDJdYsg0snFlqK2C4uWr2aUWYx1tpK3YDLOpaxReNSecDNLdtvxRwZa9+BnJrbNQK/pe3ea2G2AeDnDtr3i9fa073E0vYYlqv8xwUC5wJl00Od5qVV3zbiYqCFh9R1rtRVtIeshxM1ZCLRte5V2dmEoDq5mqV09B90nKW84R5h/5l7B/VnHYlGRNt9M/QezSHhZaqIWQ+4VZ1utfnn5nCMZMaY37PLKzZ9gb81+tifBlHKltKjTy8Q4f7JjrTN1FnKkSPJln5W8m30ofxPLFDqFAP6uGzB3thkkBjOjgbo0qTRMHvACgEPh/GwQ4FwNbrVKfDDRzZ34ItUSAi0ziB7jWw1ifR9jBL4M5lN7gXzCe69/jtdyjmF/lbJTO71ntdpnMK7pgvNvi8+6doMrjYWcy/gF65Ksxek+6/Puu8ew+M4m9ZyCiEkdXEiWTMpb4uBhUFQ5Ok95TG+gQSVIiuU6TBMy/da5GbspuPjgaGw8oFxdhScDYEwYWiyKs4l5saRGbwN+deCOaFBNtTtV4Q4EeUAEY2DDSL1LmG1zkZJuHGKkU4cLWVkYc2urxQEWl39ChqIpfj5mnQSey1NdjK7UgPisCfoeWYmQSIynWZtdK0FpEABAId54DnlMnntmfSjNvam3IQelBozqpP6CAg8kb2L0It0xCRGWhRejllxl+UIyCc2RbLdmEv1r5tfNNqMMneOQMV9LBUavod0bjNw/JoxTzDmXkbeS+KhI2GTVgZOANIn+Je1GyV63hXhy1Fqr6yYVxix/WTCsttrILVECFXvZx7GLtYJF+2JqpRvBk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(366004)(136003)(396003)(376002)(6486002)(966005)(478600001)(8676002)(6512007)(86362001)(31686004)(36916002)(31696002)(6666004)(36756003)(41300700001)(5660300002)(8936002)(186003)(83380400001)(2906002)(38100700002)(82960400001)(2616005)(316002)(6506007)(53546011)(6916009)(66476007)(66946007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TzlPcHhCZkxScFVORHNjeHFwWXF2T1JleVREYWZwVEJJNTRMQlc5MlNrYm9V?=
 =?utf-8?B?WmhyeitydHJ4K1piN29Lcit0RGcwZ0k1OWFEWGU5TmdSREtLdjBHNzVWNlZF?=
 =?utf-8?B?QW0wZjk5VWExZjl0V21NRnJSVzIwTUVnUEI2ckh1Sm9aOXphRE1SYWhiOXRY?=
 =?utf-8?B?RVRySGMxNXlDQ1JXRHQ2Y05FMVM5aEZtN1k1U1ViSG1VVWlYa0gxNC9Xc3Qx?=
 =?utf-8?B?N0FSNGJMMEFkM0lZWDE5R3BicmJnZHVORWxmUnR6QnVyT0VZMWRBdm5FeWJy?=
 =?utf-8?B?MVYyZ0IwRFhxVnVFemU4eFFFSWFHRXRuZGVzUjIvdGoyZDZuYVJaVGdYTldM?=
 =?utf-8?B?VzFEUjBaeGkrOW1waDFoMW9GRG1NcVJyUVB2Zjd6WlE5L3BpNWIvYW10UDNp?=
 =?utf-8?B?cnhkS1VKakpMS2s2c29teEVZRGF0b3pTcGlFaGZMRVhob2xkYnhYSnRhSnlR?=
 =?utf-8?B?MXZXekdVcU5jNE5HdGJ6ZjUzbU8rbnphajNrSUY5NXIzUmxvUTAvcW1MblFl?=
 =?utf-8?B?UzcxYXBXSFVSWnRhWmtRT3RBek85ZC9pRkxpaDNRVWNXSnZZSDVuTU9kbHhp?=
 =?utf-8?B?SjBSVHlQZmkrQVNXTjEwby9hby9rSERtdHdSK3pGR1AwSjUxTzU2UWxzOFlR?=
 =?utf-8?B?QVlmK0RRYW1YWVdIUm41cis0OEVjQjM1M0VzMjlLalRqQkFMOUxoNVlxRmV3?=
 =?utf-8?B?RGVSTmFyTFdrSHNVQitOVFErTFQ3aDZ5aHpmMndEUHZXVERCTTRqS3dreUFC?=
 =?utf-8?B?WUhvN2xFbTlHS3JRQkUydzZrWWYzRkg5dUJ1M054RDN3TlpuN0lCRHlGdEli?=
 =?utf-8?B?TTE5SWlDVlBPYm9xUkFZVmZDcHpCZDV5R0crM0k2bGdJOEZ3QnpISFJrcmxV?=
 =?utf-8?B?M1RrTEVxS0FTZThUeGE5dG5DTW53Tnhldk9WMVEwSVRTdG5jWnZsQWxZZXAz?=
 =?utf-8?B?WVQ1SUtHL25nekZQZnlBR0N6SWk3bXlPSkVBMWJoMWZzeTVGaTBubUxHYmUy?=
 =?utf-8?B?Sjd6K1UvcTZsRVUvYUMxWk9JMCtsY1VtbXo2aDZmZWUzUkFLaC9jZGhYTUEw?=
 =?utf-8?B?TFJ3anE3c3JSaWM4dS84TFlEVTNPOGpDZ2thV1FhZUZaN0RNU3FzNlJQa2xF?=
 =?utf-8?B?ampvSEJVTjQwb2EwZk5zTTNvUUk2UFU4aXduTHRyZXJQT0I0THF2dWZJRGNQ?=
 =?utf-8?B?QzFTVzRsZ3BYQmpTM3llV3dYaEh5U3BMK1pMT05MeWNXWk9pRmdoQndabmQr?=
 =?utf-8?B?N1lJRWtCTWp3dHFpdmtaV2VBbVZjcHl5R0txMUQ5RjlZVVN1V1IxTzZocTZP?=
 =?utf-8?B?US9xbVVQRG1ZbVROSC9FQTR3ajZCdWJmM2RsNksrUWk5NVFsRzlobENZUkcz?=
 =?utf-8?B?ZHd0bUpVSjVhRURKaVJxV2UvWUtYeWdvRkNFaVhjOG8vKzdtTSszL0YxY1lV?=
 =?utf-8?B?dnA2VW5vVmh4U1dycEZxQzVZazRIeEZkU01CdTkxWGFzREFWRjFVQ2QwWWJL?=
 =?utf-8?B?V2pwQVpSSEc2aDJlYTFYcjNmcWJKYkhOZUhhUnhuUXd5c0xmVWZFRUdybnow?=
 =?utf-8?B?RjlPRmU4NVdtVVV3Y2hZbWlvU2F6TmxxblE1T2FKZk1iZXhVNkVrcXFENmtk?=
 =?utf-8?B?UzdFZ281MnpySysybzVVOGpjS2RkMDhITE1mdmJNc09ZSDdUZDJKSzdqdEZn?=
 =?utf-8?B?ak93WjB4UGdUbkRhbDNBR29DbnNRRGVmcm1hTHpPcHkrdzByTFJ4T2tWT0FP?=
 =?utf-8?B?WnBUU2dLdkdLOGJFWm16cU8rdnZRMkg1eCtjbmEzdUtyUk9jTmUvbkJHcGIx?=
 =?utf-8?B?WkJWQm9jUVFSQVRQNE9pUmllTWJHQlIwTGJ4b2JKYjRkTUdjWmJweTZyZVdu?=
 =?utf-8?B?L2xkTW1YbDFWL2gvaGo2YVlDSXRlbWdtVjV1TlllYlpPay9DUitab2lsY0h6?=
 =?utf-8?B?SW9FMjZTMzV4SjNOaTl2b0Jvby9ZNUJ1aGNMMVhUYVVzWTlNN0JYL2RUNzE0?=
 =?utf-8?B?ZnRWY0lXeSt5VFprQTdiekpUY2xZbVp5YThLdVI0bDFSVDB3VWZ1N3RmK3lo?=
 =?utf-8?B?di9hZm03cHpXZDR0MXdWOUZudE9DWkViNGMrRSthZmhMeGtwMktjeWg3MENm?=
 =?utf-8?B?Y3ptSmE3WkNqSzFlOW9RaGs2eXJVODAxMy9PcW10MVNpTUNseGo3c2E4ekgr?=
 =?utf-8?B?Q29pNWwySnJvdzNoQWorVjJqZktoNHByYTl4S0ZZRHhkeVJ1NkRLN3ppL25C?=
 =?utf-8?B?dk53UUZUeGQwejlwclA5MjNYQ1NnPT0=?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 acebab1b-1f55-4aa5-6e81-08da581651ca
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2022 08:23:31.2810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 7PqWOPBdFb1mNhBMdaBgy51MwHBsYymvwL1GHDIwU1UFgw8UhTx5+16xn2zdo8wnnEn7ni0YoGtvWdxnP3Ich2hsml8sXenDu1oVwaToSCk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB4896
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Jun 2022 08:23:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8600



On 6/27/22 10:14, Jan Kiszka via lists.cip-project.org wrote:
> On 27.06.22 09:12, Sarath P T wrote:
>> From: sarath P T <Sarath_PT@mentor.com>
>>
>> When we launch the start-efishell.sh script for
>> adding the keys into OVMF firmware we faced
>> gtk initialization failed error. So it seems
>> we need to open the OVMF in nographic mode, hence
>> we added the required option to the script.
>>
> 
> Which QEMU-Version? Which OVMF version (buster/bullseye/something else)?
> I'm not seeing this, but I'm facing other issues with that firmware
> provided by bullseye (a crash).
>  >> Signed-off-by: sarath P T <Sarath_PT@mentor.com>
>> ---
>>   scripts/start-efishell.sh | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/scripts/start-efishell.sh b/scripts/start-efishell.sh
>> index d451f43..0831f83 100755
>> --- a/scripts/start-efishell.sh
>> +++ b/scripts/start-efishell.sh
>> @@ -2,7 +2,7 @@
>>   ovmf_code=${OVMF_CODE:-/usr/share/OVMF/OVMF_CODE.secboot.fd}

This should be changed to the 4M version.

@jan
The 4M version does also trigger a crash?

Quirin

>>   ovmf_vars=${OVMF_VARS:-./OVMF_VARS.fd}
>>   DISK=$1
>> -qemu-system-x86_64 -enable-kvm -M q35 \
>> +qemu-system-x86_64 -enable-kvm -M q35 -nographic \
>>                      -cpu host,hv_relaxed,hv_vapic,hv-spinlocks=0xfff -smp 2 -m 2G -no-hpet \
>>                      -global ICH9-LPC.disable_s3=1 \
>>                      -global isa-fdc.driveA= \
> Jan
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#8599): https://lists.cip-project.org/g/cip-dev/message/8599
> Mute This Topic: https://lists.cip-project.org/mt/92016246/1753640
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129121/1753640/1405269326/xyzzy [quirin.gylstorff@siemens.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 




