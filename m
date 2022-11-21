Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D069BC4332F
	for <webhook@archiver.kernel.org>; Mon, 21 Nov 2022 17:25:18 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.70])
 by mx.groups.io with SMTP id smtpd.web11.45338.1669051516832817631
 for <cip-dev@lists.cip-project.org>;
 Mon, 21 Nov 2022 09:25:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ysUJY1Km;
 spf=pass (domain: siemens.com, ip: 40.107.6.70, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1JqtSZ/QiJ84BEYkEC3wHLnSOCw0T91ohgmxq1KUKeUxxfjL3wUDrEz9K/IsIjC8n8WGZxOwpBy3Phz3+TMLq6/mKuNkldMxDc4td3m5+qk0s6gwhrNKBT6xW1lOqzQrkPefxH51nJ+5EPpr3b3Cb90mBA14aoSUMzQ22XB5G7Z263opE9Y8ii/KUdqWlq/Rss8enP799pLGyifWSqUWWURCQDHTo+gvqzmhBl1CSwDSxaQbvZvr7GlF8oz8xfwRAaHaS5ZFxf1tcZWeM+nwB8Nfk0x3NvmtAWFwGQRvcyQfkdfX3TayH0Bvm/q0v+nuX8wllgHmGKx1M918w1TtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ySsDjkmfFmXNp6Ta/KBJj8l+4UTXWTrutDtqnTe/bM=;
 b=lECCnZzcD/TvD5cizA8uwDvU2azD0EMCWetv6kohZ3J3CAG1dbougBZ2BZSpnjC90UamLnqmhv2tJjCamunFN+J4CorvWp/3cJ39fj6iXjaN9KGJanCfq4vZbS7e1DJ2EMRnoGxngYKQLIz1ybuN08Sma5m3UTVGZpGQfXx7u4fQVPY6o8IchSTa7Rppjma2BQy+qt2pgyENpCjHTkEGfVCRI+UPirZWCbOURtDEm0MPc7k2PUf3k2cK+SWFJQyykMmcPT7EaoOul2sHkXpipUm61ViNH0kGXKIVE03KqZg0Er4a5MV9Jl21Zlx0JULurcB4ZATDrrCfgaYc3xLRZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ySsDjkmfFmXNp6Ta/KBJj8l+4UTXWTrutDtqnTe/bM=;
 b=ysUJY1KmG5V70saeQrVcOBq7tdF2bW4n4IVmWBmQKQAZRp74iTOk/vJ9rziSh0X10onWAIzeo5ylZD50pj2ufBeeiRpG1lZROOVxx/iTgh8mgUdGoZd5LNU9WiWkQ8IyPB2wcJtAvvYl6Q4DhYvr1DztcNwN6J1aNGEDhQDLjt5Pos3E1HHWA9/wXlJZP1elUy0ghyUcgad9ZC0zgNRYa5nGN47LP5vw2igNbEwW/ijNzpavuNlDXjKlMXP/hOfO19fgpRN5ezrEAGyT22xxqZMHoXf9PX+Rs86yTqEBSFF1hEUZH48gMLHFHLkisgijoUr8yFAub41sbf0coJzjLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6728.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:400::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Mon, 21 Nov
 2022 17:25:13 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%9]) with mapi id 15.20.5834.015; Mon, 21 Nov 2022
 17:25:13 +0000
Message-ID: <cc87f549-be75-00c9-dbf0-f37d6f9dd04d@siemens.com>
Date: Mon, 21 Nov 2022 18:25:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [isar-cip-core][PATCH 6/8] change ebg sb signer and secrets to pk
 kek db
Content-Language: en-US
To: "Schultschik, Sven (DI PA DCP R&D 2)" <sven.schultschik@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <20221120204711.5826-1-sven.schultschik@siemens.com>
 <20221120204711.5826-7-sven.schultschik@siemens.com>
 <3512a1f1-a15a-22bf-3b08-2cc6a85e668e@siemens.com>
 <DU2PR10MB503009A3EF056F4DAD581ADB900A9@DU2PR10MB5030.EURPRD10.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <DU2PR10MB503009A3EF056F4DAD581ADB900A9@DU2PR10MB5030.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0053.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6728:EE_
X-MS-Office365-Filtering-Correlation-Id: a666c2e3-f86a-466c-b1fb-08dacbe5598b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	+tJPJOJ2ApueJ3r8fenPYypC1GT8wBABzzkxo22CCzN5Gn5Dfteq6DN1cYWUJPaonew7YCPk9lLChG1tYJZKEGTkQXlHcf5/9j8ynMza/Uwi4kV2zkr4sYSaNF0w7gudlNAq2ZfX+2bFUNT75RfERFxtEVRGktCdTPR3KRTjYlCyg0oSnEqy76yRC+8RqIap7qX02eISM7tBWQZh5NmA+9pKJF/q2zxABsGbsf7N15XGvZNoSi7zQiPSMxIGEehOk+hf6k3+lgAchytTbhe+HyJ2dJAXTrwfOieEoJd95EUkqZzJF5JqgeWOZ/R3X8Hz8vJJkEzbERqfaDEOTq+Jvu2RpQCJRG1FkxWHNZHy/MpUrVgyG/J/gCGxLbwYQ+g9DtFPVaksVmPT7R9b4SMrp2xZ5DMbsvGC+S7a16FXU49z+bw0ncvy/6fkAH/Qj2Z93MUXxL6FdTKIYydzvcFedSK9cXVbrcw2j7sC3TqVKU+grYDLLpB2bx/zsVpv3hXqj88K1GiEMakLNe+Vzg2fQtc8YKGWEcogfYzCU6eMlkigJhTL77Lx7UZYuDuJHNVT6pxfpbOum8WzClaPFtsYXUJjWjUEshibJ7PPD+tpEPRsNeFD4iRQ3T2QYSXKIm040scoKfl2Nw/T9rznP4qEJZ1nBDHa+2CJ3Azb8ag1BZ2pluW+KJHApSrKaDVdXiTMpoX0PyGD5nAJK1uOoMGRkR5QUPHRrO+SKb44HpBN8lYGFNBmMo/28xte5PmyqfUz
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199015)(2906002)(110136005)(66556008)(8936002)(66946007)(44832011)(8676002)(5660300002)(66476007)(31686004)(41300700001)(31696002)(53546011)(478600001)(36756003)(86362001)(6486002)(6506007)(6512007)(26005)(38100700002)(186003)(83380400001)(316002)(82960400001)(2616005)(14743001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZlM0ZytzcmMvWGdOM3p2TkQ4bVdQdXRkVnlCM0FDSU1EOXltWWRtVDlaci95?=
 =?utf-8?B?QW5ieTFnMnRJVjV3R0hwb1lFUlcwMElkWTB6WHV3OTJYcFlFeHBxaWJOaFU5?=
 =?utf-8?B?c1FmWVZ5eW1rRkdGUUV5OXgwL2xVN2g0WVB1dG1NbVh1bmRpTkhTdW1pTlRm?=
 =?utf-8?B?Q0JKTXhjcVNHdm9MWjNuZTNXbFZSV2ZlVUJxbmVyVWI4L1hCL1NOL3A1aHFN?=
 =?utf-8?B?cWlGdVoxUEU3U2RPTllqVFB6MEVzeldiMU5rblB0dGxRNjFjYkpPSUJoTjlr?=
 =?utf-8?B?UXU1VEFwNi9ob3V3b05wMWM0TjNDSjZ4eE1kT2FmOFdlbWZib3dHUnhXallR?=
 =?utf-8?B?WUlvbXc5L1NidkFhVE16YVRLMDlwZlJTTkEzeCtFamZYcURrYkVleWw3c1dY?=
 =?utf-8?B?c3poNDBBUUtxSlpub2R1ZklrbUVDS2R4VTBSdko2bXZzS2dpcFd4UmhDWFFM?=
 =?utf-8?B?RUkvTTcvajdvQU1NOXU5SlZ2Y3BWbzR2OForSlkzRVB0N2YrY2dUSklqaDZy?=
 =?utf-8?B?a1o1UlU3emNnbkcwbHpyK0UrN0Rmd29UUG9iVUpsTTRsSjZUUEExRjV3Vi96?=
 =?utf-8?B?N0tvcjJ2cDl2U245SjIrd1RIejQ3M2d0Y1J0eEtnUnVDS0lhUWdUMlR1QzVX?=
 =?utf-8?B?UUpzN3J6UWd0NmNWQ2NjaUt2OWxadWFqTGVkNjJOcEl4dldvVDRtcnJqVkR1?=
 =?utf-8?B?ckszZnorOVVlbjdkUEpMUHdYc2R1Tk9kSnZ6WDRPT24ySys4ZkhQY3M3ZjY1?=
 =?utf-8?B?S3dHb2JkNGtKd0ZtVDVsbVV2VUtjY3RuQWlvelptTW1NTGlXR3dCL3pjdm9H?=
 =?utf-8?B?ZEJuZkRuMEJWc2RYRmVhOEk3L2hGemxvNGtyM2xRT1lkVWU1Yk1qTlA3SmNr?=
 =?utf-8?B?MUljekFuOWgwYm4vTVlDZVRVUnJha1Y1RTJiSTNqcDVoMWtJdGlGNzMrbVNi?=
 =?utf-8?B?UC81NlROM2g5cVN5dFcvbmFaUm5jZ09jbnYxV0gxYUJ1dTNudDFLdXBZOGNn?=
 =?utf-8?B?ZXJrSlZPNjA5Z0tXb1VJNHJlSldrNlhvanNLT0t4Q3dQTUZNVy82a2prUmlU?=
 =?utf-8?B?T1BQYW1NcVUvUTZESWxlUkc0R2RzQlBINW1od2haWkZFS3hJanIvRWx2TFJE?=
 =?utf-8?B?eWsxZkMvNGdqa2RjZ2xjeTh0VnllNXowWlE5b0hJTXVnRmZqVkVoUUdUYUlF?=
 =?utf-8?B?QWpsYUhoZ0JJUUEzUGVLNFFpRHdpMXI2eTVzcUZ4RzloMDdQUlBjbVhLM0x1?=
 =?utf-8?B?b3FUSE5BWXk1cURvTjlENW04MmtMYk41ZXdqTVFrYW1DOU13UUJzUlV2RFZ3?=
 =?utf-8?B?NThWNmR0L1lCcUY3TUVTOUdRdC8rSFZMQWlXR2loMXRQVHgvdndmSmgzOExj?=
 =?utf-8?B?TENpQUphVzBpclROdkVGTEdBUGxSNEwzNEVNVHdodDFydXVZaWIwWU5WeGZh?=
 =?utf-8?B?clphSjBiV1pmMDlCaE9hdWtINTNHMXdnK1NkbmdPeUZLem1FWkU1RC84MHVq?=
 =?utf-8?B?SEJUTTJMeDdyMFpoMVRzWkhrY2R5ZDdiaWlmK01FWVlwZk45dWFLQmtTMGhL?=
 =?utf-8?B?QkYyQ1JrUHc2NEl6WnhKZkVmSVR2MEtHSWRBOXh4T2FVSTBlU2JoUjhEdkln?=
 =?utf-8?B?VVhEUlhIQTFvRGhKZkM2K0dNM0FoQVZ0cnBvZ0dTbFd6dVVEdVBVWkJhajdl?=
 =?utf-8?B?aGE1TkhaL2lzcVlrbGkza3VTWlVValkxZ01OM3dIVTdXOWxidDhoNVk1ay9I?=
 =?utf-8?B?VG9McmNUYTJRSHkrSjd2ekxucWtwbWhRWDhmTC9QQVVGN1EwWXQxUGJpckdu?=
 =?utf-8?B?RVlYNDFwTWw2TGg2Y3NwN0VxUXliUVVWdHdwWHB4WDBnanN6anAvYkVFb3di?=
 =?utf-8?B?K2EzV0V2Q1EzNkUzM0JFNThyYjVKdE1IUG9qczhnTWJEblUyQmtqaE00Q0Qy?=
 =?utf-8?B?cWc4RStCRnpKc2UwT0tCSHA2cXlNRHNkWUhNeWg4S21JcEo2d2ZLRjFsSEcz?=
 =?utf-8?B?bnoxUHVsQUptWHZOdHRmcXozTG5nVmlFemh3S0g4VzVrbGFXOTZBRWFJaWNU?=
 =?utf-8?B?TXR6OXYvN1lTejNMRjl5enVYWkxMY3dtak1pSGc3M1h0TFJMNklrR3hKVzJS?=
 =?utf-8?B?anFhREZSRnpZQlNxOTgyaDNXVEJZejdkRitUUU42REJnMjFzTC9vRk1oWnlS?=
 =?utf-8?B?dFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a666c2e3-f86a-466c-b1fb-08dacbe5598b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 17:25:13.7885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KmPTymRTg5mNrqajapbo2S+K+7O32lrGN01VfTi/csfi/QsnGVnZrL73Zpk8m2wdJMiHFtVLhpV5MEXYq1NWYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6728
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 21 Nov 2022 17:25:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10064

On 21.11.22 16:10, Schultschik, Sven (DI PA DCP R&D 2) wrote:
> 
>> On 20.11.22 21:47, sven.schultschik@siemens.com wrote:
>>> From: Sven Schultschik <sven.schultschik@siemens.com>
>>>
>>> The secure boot setup with OP-TEE, u-boot and EFI works with a platform 
>>> key
>> (pk), key exchange key (kek) and signature database (db). isar-cip-core 
>> should
>> only provide one secure boot solution and so the key structure and setup 
>> needed
>> to be adjusted.
>>>
>>
>> I don't understand the purpose yet, specifically as the touched keys and the
>> signing structure was already use for UEFI secure boot, on x86 and ARM[64]. 
>> It
>> rather looks to me like you are committing a lot of stuff that can be easily
>> generated, given the secure boot key pair.
>>
> 
> It depends on the purpose you want to create.
> 
> My idea was to provide the complete PK,KEK,db structure as sankeoil and 
> possibility to be added to the build.
> 
> Your idea is to use the existing key end pem as "PK" and generate KEK and db 
> while the build is running.
> 
> - But then my question would be, why then not generating all snakeoil keys and 
> certs on the fly?

Because we use existing provisioning for x86 OVMF.

> - Or do you want only the PkKek-1-snakeoil key/cert to be provisioned in qemu 
> as "db"
> - or should the PkKek-1-snakeoil key/cert be used as "PK" and KEK and db 
> should be generated on the fly and signed
> by the PkKek-1-snakeoil key/cert?
> 
> It depends on the goal you want to achieve.
> 
> For production you only need the "db" to sign the efi file, but for qemu you 
> would need PK and KEK as well to be
> provisioned to the efi environment.

sbsign takes the private key and the cert to sign a binary. That cert
then has to be added into the cert DB on the target in order to validate
the signature later on. We do that during the build so far for U-Boot
and expect the x86 firmware to have been provisioning accordingly.

However, in order to model a complete UEFI device lifecycle, there
should also be the Platform Key and the Key Exchange Key involved. We
don't do anything about those yet for U-Boot, just set them to be
identical to the signing key. We can change that eventually, but I don't
see that related to adding RPMB as secure storage.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


