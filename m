Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267D8C77B75
	for <webhook@archiver.kernel.org>; Tue,  9 May 2023 07:22:31 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.47])
 by mx.groups.io with SMTP id smtpd.web11.25994.1683616941360218142
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 May 2023 00:22:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=dgxST7xI;
 spf=pass (domain: siemens.com, ip: 40.107.20.47, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P4qqTbS7FJF2Jm3vtboTLSE+BcbMw9tbzhPTCBPQwGTw2O3oHqccji/mKjN8dn0E7qoCqDUTUHgcn/2Omo1a4tNSsGG0If2OE6BjjkWeKzigQ6gY7fDdau4kfzbZ8w1PQRFVWt24iC7bQSGKf12/kfZzaLBmn1GIRxYW49Dyca4M4OIfa8hXF6RSpj64/U62RBCUP9WXlXcuf90KrP1A58mbBhfKS2PjfrRiJ6qk7IAOOeUZBAKhzrvpje+ZKOcnQE7MOeLM98WAOSjmFmZToatJnGEaMr32tEjgOGgD8NyfSjo9DzBkJQhMlmWTwJcAxkXpzBgP4gErtfE69l2osA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSdb+znN5BHXQVL7Tkd/JrGBxzH0EtsfeEhfMcmGgOQ=;
 b=EjmZgbiUNxIqMp1OmZ8tiySk1Lo4htpDins9KuyguBkblFr0GH22Z5Inukm/qK4MHZmlsCLvfqOXk11WwfhQcrd6tAwcjl7MgRMwDdZD19sVnyf14katOeLnBw+P4/90A55Y2ZsU7Ofa+XI2oQlZYOXknuPMtiFwNcw/QBjI1izL/JG62an1SfSlhw0B7/4VOba5yIj1E9DxD873ryOdvmRFv5rYVCBfCgDHsJhj0sAUN3odyd5TO2HICiJWkW3+fxbuAZKYvR3utQJOmO5eVpfUVAvqV8IYT2jeDAKkyKLcXV7WxEfk+1o85atofDKhIfI3WhAZtxcb31WMOS0h+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSdb+znN5BHXQVL7Tkd/JrGBxzH0EtsfeEhfMcmGgOQ=;
 b=dgxST7xIINc/QK8awj9j6MqO2xN3V2HmLirOtzuGS+JhcP9AnUbB5j0YHwqFV9amcTI6ONnkoevnSe445d43lFEr2d0TPtSZGTo/i6vENZiXwDz6x6QtEshZYnq36vZ0QKJuzuAbcoWfBaVkjGBfy84p3Jkc6C31W059vQ0w6hd/Z9RF+i2tgJInV/9e5pY7ehCVZuWkbY9sbBEeGcHc+d9anDB8WZDJDRBBqNx/LOptC3P/cPzWocOXvYiAKBCxlMu3rZbGvp+e1Y2LZCu1obM0fnNhr1ZOuzh+VhfZPskmJQKpxoCsRTMSETuYFTiz/PS/swpP/N5oA6LQHIi7Xg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DBAPR10MB3995.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1c9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 07:22:18 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e08b:7f4f:a8a5:586d]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e08b:7f4f:a8a5:586d%3]) with mapi id 15.20.6363.033; Tue, 9 May 2023
 07:22:18 +0000
Message-ID: <39bea4c9-53fc-4ba3-851b-37ff4798f21e@siemens.com>
Date: Tue, 9 May 2023 09:22:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [isar-cip-core] image_uuid.bbclass: create /etc/osrelease file
 before do_rootfs_finalize
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>, venkata.pyla@toshiba-tsip.com,
 cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20230508154031.26473-1-venkata.pyla@toshiba-tsip.com>
 <a030f206-30b6-b2b1-5e66-9dfd796e5d5f@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
In-Reply-To: <a030f206-30b6-b2b1-5e66-9dfd796e5d5f@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0085.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::22) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DBAPR10MB3995:EE_
X-MS-Office365-Filtering-Correlation-Id: e11e2ac9-f290-4605-f0bd-08db505e1ef2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	iyxGnJ02oIYAuGyHd2ZR/4XfRoDTLE+SH8elHOZw5QHQKcAJlEeDSN9Mih3LSpP9xTFw2XDDZPcazwSpp83uXAdHokCOdU0jxLk1lsus6wihHIwMuxJcXIfVZNNe8y8yh2zJ7bNCEsrSJe+GtEQiFhXdO941QDnFFxzlmSmX3jePGtGu2y6gS5UjapJLFdu5o1KLusvzjDaqWul5pJmS5u4kxIACyTYiIsd6+9p3H/79vrdb9pRWP2ec/GtoLCeG4D/TY61K/9ZaAfqKGP49j5bUR2/aIwHq209gEqMzrqNEkBUFq6YINglvjtOKVwc3EpjyfJ4MVCBZjQZbJ6tpL7oCgvx2BlM6g3zkGGlXweM9KC++ywTo3kMi7YTmOm1hq+9yG4dsUelHysTHolpy18Sv0t/QPkhsimBfPo6bAZgHvz2SaHJv8uPVEwGtIPWrM7mF2yIDXtkq9occiIivToNakUTjXFQTFOHX41u6HlOR3LXMzn+oWBlvTASWkaJx0ld2M8I5vJolB+tmV49twb/HR8rjMVJXdSkmYs4dgh5tNaQV3cwDt1DEgCBX/FuZGEeyjHiZiMMTFWKWHLNlN8Ad0wAn1GdbK8kEcN++Jw3kIABf+kL2SvzK7Ux8Narn8cShBRnAwUnd/5KJyLJliEL3LoTzwbsdZIY7qqmWHxZYCxD9BwvrgkSI95OiPgHf
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(396003)(376002)(39860400002)(451199021)(31686004)(6486002)(41300700001)(82960400001)(36756003)(31696002)(86362001)(2906002)(38100700002)(8676002)(8936002)(5660300002)(66476007)(66556008)(4326008)(66946007)(478600001)(83380400001)(316002)(186003)(26005)(53546011)(6506007)(6512007)(6666004)(2616005)(403724002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Y3o0eFJGYkcySUwxL1ZRbEh0SEFqN25YQWYvTCtEVFQ3cklKYXF1ME0rSVVG?=
 =?utf-8?B?U1E0cjkzNjhyRGZyRmk4QTYyM1o2aXUrVnMvNmlkdG5MWHVzZU5waFpqSEdD?=
 =?utf-8?B?N0p2YW43S2gxMldjanNnQThGVTg1MjZNK1RrYm9hUjE1L1dNdkRxUjNlNGJB?=
 =?utf-8?B?TW9SY2pDdXlPQzAzelo2dHF1MGhndGFDWUpPOGpZY0RJN1lWejBHN1N2V3Fn?=
 =?utf-8?B?bTdJeWpKR0ZmekNEVXZ3ZFB6VFNsOWxscUpOOFA5enFZQ1NjbEt1Rk15NlVn?=
 =?utf-8?B?TWx0NkJ5MC9ZRytZenArSmxPYlVJQnVnOWMySUZ3YmplaGxXak95bTBFV2Vt?=
 =?utf-8?B?SW1zOFppWVU0RXhTd05Td2IxcWMvSGo3VTh1aXBSMDkzQ1Nvc0FGQnUzQ2Zy?=
 =?utf-8?B?N1NVdlR5ejhrMFdYZHUxTC9nTnV6SlJ2VTFNK29lZTlBLytKblBqTVQzbHZT?=
 =?utf-8?B?cUZJYnk0RlZXNWJDd2gzYUJDSWRieUpiMFdYakVHZGRNZXdYa2g2ZTA5Vkgz?=
 =?utf-8?B?Tk5meHFCUGQrRmFsZHdveUxkbytoQi9aTjV4TnRTc0lycWZ6YVlqbldBVDJY?=
 =?utf-8?B?ZUpKb1dvT2NjaG9ydTZ6ckNHb2N0Y2Y2VlhqdmZZdkIvYjhOZUdsRHdiUlc5?=
 =?utf-8?B?ZXM1VDNDWXhYZG5hcnpvUkg1R0VlVVZyYUdiS3pkR1pFUVJ4RVU4Ris4SUM5?=
 =?utf-8?B?UHNpd2JDUUYyUCtheHY0cldCcVAzSGpDQWRvNXFxU0U1ZjRESEp4WmluY3Yw?=
 =?utf-8?B?NWIrT0x2Q3hIcVFvcWZpa2kvZ2tSVFIyYktoUDhmSHJMUDVEWDJjdU9vYWlL?=
 =?utf-8?B?R2d3OFpic3A2dkZGYW5TUlVMMWVldXBXY2lDd1BMMXFIZDB3L3I3RmVIQXZm?=
 =?utf-8?B?d3N3UkphbzQvSDNqSlo3UFZOVjdoZ2tGMXBWbklFZ3NsQ1EwTU5OMEdXS0xS?=
 =?utf-8?B?MStFVzlVdGg5ck9JQU1oTmNQMTUzVWhYZlNVVEliVTlvQWNxZTdDc1E3SWRB?=
 =?utf-8?B?RlhnTGlaZGg2QStrMGhNZ2IzU1BCayt2UTgwQ3UzdldRbzRDU281c2FKcmdO?=
 =?utf-8?B?SG5IZExWM2RWWG9TSXNwZ2ZDMjlrK1YzWFYvNkNjTVBzYVlMMzdZMURlVXls?=
 =?utf-8?B?SjJLVGFBa3V6ZzNaU3dCS0VVMlhoMUN2TDFHVTZ1R2ltYVRCc0p4aHhUdXVO?=
 =?utf-8?B?Y1dObDlKU3E5ZVU0ZCt6SVJrMXZGTEtpMTUxV1ZYS0YxeXhqeC9RWXQ1cWxN?=
 =?utf-8?B?WEF2ZWZRb1ByOFpnV3piYnZ3WGpWeGtYenlTR21QY09pOW9JL1BuRWdmWFBG?=
 =?utf-8?B?R1lKQmp1T2E3bCtZWitnaVFEeDNqdkQ3SFpNSHR5aTBHakR6VW9PWEZLVGxn?=
 =?utf-8?B?SXYwZ1JxbDk5dGZpcjRXd0lDbEhRd3JiMlJIM1pxa1hscW5CSGVtMWFFckl2?=
 =?utf-8?B?QnFJbnM3S3YyeXZ2elZpcWNuL2J0TFdPU1NYODZMTTBvUFlaMERTVG9oTmdW?=
 =?utf-8?B?VThpUjlMMDRPZ0RqQm5HVFI2aEI3anNUanFsTVV2QUhqeVJOaU9yWTN2ZDFu?=
 =?utf-8?B?YnZBd2VDejNBY2JJRkNuMWJ5Q3J4ZWExaXh6dnc1dS9oYmFZdVdLelBvaW8z?=
 =?utf-8?B?bFFnZ0o5VlFJdEFHa0o3YVljNVAvRFQ4QnVIQlFwTURGcjV0a0hycG9Nd1p3?=
 =?utf-8?B?WnEwc09hQ2oyWWl5RENHWjlyaVM3N0dtY2RNWGQxNVdhSDl6d3oxZ1JicHJz?=
 =?utf-8?B?WkV6SEYycEdlS3FuM1haTlhaSHdwSC9XYTNoSzlZUTJ1Q0pTYlZ3aFdTRmdJ?=
 =?utf-8?B?TmdodlBweEtJRm9IeHFnUHh5WmZTa3U5c3F5K2h1dVBvdGRXNGIwZ0pHK05w?=
 =?utf-8?B?eFBIaDNhcHdnakNTTTV5azVJZnJFUGYrVjdyazJoNVlRZFpqVE9IZkExM0xL?=
 =?utf-8?B?L3N2WXpYVkZaZUY5UjNXa1RKdW9IVGxUQUlWTWxLSjd3SzVvSEdubDY3dmZU?=
 =?utf-8?B?c04vRHRVV1B2ODQyMk9HVlp1a1V1aFdaRDczeUtHZ3I2cmU2TytZcyttZ1VB?=
 =?utf-8?B?L0YxMkxnRVhQZDZ0S2Ria1lGVGRnL0l3cnFVZUdMclBvK1VKc3pPdzZzZ01z?=
 =?utf-8?B?RnFteWxUSWhqY0FIbEEveFhjWlFhM0RFRlUzdWl3ay81YXlYVitBbG16Rkg4?=
 =?utf-8?B?SGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e11e2ac9-f290-4605-f0bd-08db505e1ef2
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 07:22:18.5451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ZW+NRl68ZC9HkGzwGxX9j6Vb1eAvUVA89an3Us/6a3UdBZM0u4KQLgTwu0CS2mmxaUNP/GQpjGVFE6nbIBUvGhF9ff7dK4pb393RnWun3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB3995
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 09 May 2023 07:22:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11423



On 5/9/23 08:21, Jan Kiszka wrote:
> On 08.05.23 17:40, venkata.pyla@toshiba-tsip.com wrote:
>> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
>>
>> reproducible build with swupdate target is getting failed due to the
>> `/etc/osrelease` file timestamp is not constant across builds, it is due
> 
> os-release
> 
>> to the file is generated after `do_rootfs_finalize` task and the
>> timestamps of the files are made constant in this task and so move the
>> task `do_generate_image_uuid` prior to `do_rootfs_finalize`.
>>
>> Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
>> ---
>>   classes/image_uuid.bbclass | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/classes/image_uuid.bbclass b/classes/image_uuid.bbclass
>> index 2bd530f..9ffe14d 100644
>> --- a/classes/image_uuid.bbclass
>> +++ b/classes/image_uuid.bbclass
>> @@ -54,4 +54,4 @@ do_generate_image_uuid() {
>>       echo "TARGET_IMAGE_UUID=\"${IMAGE_UUID}\"" \
>>           > "${DEPLOY_DIR_IMAGE}/${IMAGE_FULLNAME}.uuid.env"
>>   }
>> -addtask generate_image_uuid before do_image after do_rootfs
>> +addtask generate_image_uuid before do_rootfs_finalize after do_rootfs_postprocess
> 
> Looks good to me - Quirin, any concerns?

No concerns looks good to me.

Quirin
> 
> Jan
> 

