Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4EFC07548
	for <webhook@archiver.kernel.org>; Wed, 15 Nov 2023 11:33:39 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.77])
 by mx.groups.io with SMTP id smtpd.web10.11023.1700048017096578910
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Nov 2023 03:33:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Nh1DeLOf;
 spf=pass (domain: siemens.com, ip: 40.107.21.77, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=enFIlolf3kXzuI6wrXP4jpBznVYkzvGuwUUuvsumaGIxi7Psue1iWFcPSrmixTRZKVpocf7FKGOuYwba+6SSJ1Jfhbg5/PvZ9rXCD5KdcN2xrVIfKapmGBNrnCJKXsmpU1eMF9hdLmY9fr+asXEcEURWdBUlaz1SocJJGRcx1eQl2DfFOC89sLFrfbdBDkC276mmOeJD556jIs4dLFoBiemQcpwlxUrFf82ABxReib7nJ6q93nHwxLZpGUaW7mMFga4qXbCRpB/BiFMqjC/S+4k/yhvuBWYG0h8AcnACPMhJrdS4QpjSSEJxJ9jFDX7wI/cfs9uxtd/Qv7nGr86R6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4TS8ccL2C5UBLE3/a/JzGXtkE7JvlqH7y7F+SKub+sE=;
 b=ZgxH903VGLFQQssOHYI0tfVhiEysdR3IR5dIt0diJHI8CPzp2grw1xtiI9F/OweN4cW+stbkKpHegDHPmvjSH8AU7cmJlNhOnZLB3uafgqG0YHIzm7kuG3DKskDCDNtHrCPgVni+SiDFHhq1eIP0oVq7zhpxfgMpcC494CJn5Ry3xtE8lYGCvwAY0m7BEs732GwF1g9yenTKe+Na5TSE7GL1eBkjB4jef7LimKM3+9S3puPWdA46dxeXUHlF12Zt2qNAPU2Efr578+FXxkpJF/9AP3DjMnPduRP375IEJKpPyaSO6a4/sjnELhyv2KTURaL+1ABHFrCnG2p7WwDEFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4TS8ccL2C5UBLE3/a/JzGXtkE7JvlqH7y7F+SKub+sE=;
 b=Nh1DeLOfDvEaJLZW86Qoxf0VArfhJi+PRDVnHys8LTs1MdD/K2DiIOihTFWD5dTeDhuB0eB2PU/g8GXd8NJSAybATHRgblrJTz/vZ3wmhGzrgEJOwOPWwanzqNyVpjwWcFE5getrNzIFn9n7OcQXTtxg7WouYlnER1hkTaeuCiTwjzeEpsRw514PkUs/23DT5kk1jBMHsBcDiGfHZvK1QeKQ95FzZ+h5vgl7dorYCAuRDojiJUXXunkoNxoiwQzW/DO0uxWAh7r9jtEdjVwV9JiVVpK9CHMUtOMAx9HiCa9YfpHRTpL4BUb67ciGO3BDWmM3yYDL5plDTR5ao1Z5EA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DU0PR10MB6367.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:40d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Wed, 15 Nov
 2023 11:33:33 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::573:677e:776d:63d8]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::573:677e:776d:63d8%4]) with mapi id 15.20.7002.019; Wed, 15 Nov 2023
 11:33:33 +0000
Message-ID: <a5218aa7-3791-4aa7-a6ed-97fdbf8f2b9e@siemens.com>
Date: Wed, 15 Nov 2023 12:33:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core] ebg-secure-boot-signer: sign artifiacts
 reproducibly
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>, venkata.pyla@toshiba-tsip.com,
 cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20231110080508.20807-1-venkata.pyla@toshiba-tsip.com>
 <e2bc7abe-2a5a-4293-84ae-4ddc40fa457c@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <e2bc7abe-2a5a-4293-84ae-4ddc40fa457c@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P221CA0009.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11c::11) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DU0PR10MB6367:EE_
X-MS-Office365-Filtering-Correlation-Id: e3265edb-7b81-495d-f8a4-08dbe5ceb2bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Z3bB/C41YdSfk61663wcSzWSsJu6bqp3O3N8+U3sSwIcNK0gGYq5TdtpF/1ckn/iFakk3NttAkHGzTjw3GOXRt+Kj2J9DR/+5G/M6Nrp/5Cr3nG1RUbkgJ2cAu/kvEeVBegsKavvorSVCBFmZ0FfVRly1+ocLasQntRMEKo1Xxv3G0GW2W26PRXzcoSEO8ESbBwBa9WO4j6Q5nX1cXxLwgR1Q3hTvNs0/mJrlKOXcwF9xOIbj1LRJ2pTNcleYDQntHiB3TyY+UrvqxCF6qinTAyzG1kHGUjf0hXagAFQw2EIRWcJudn1y2lVNyIGwVOCCniswF7aE8deDHQUpI9v2TpmZZBPzBsWgPS2JkLSp2cx6/2c66QBO6xLsUtYwm4DE7qR4hbE1vBJXXjmOcn/P80rZ73f6VU6Av3MPCZy+bHqYmLNfwkIz6B/IdI0iqpjzJXY/Vh12w/5x+/X5pyhv1fzGlezkOlI3HDqyB+EVb2W+bIAn9W2qYKIafePWR7SAV6T/uVWXxi8OHu68CW68kA7fjxO4EZIa6oYwzhluNXfGe5R6cCiWe8cMHtI5G3BNO49Obv4F/EaTumVKxxpA/8lOMYsjORjjgJl+zzMAskCpHq+Guet1sV/W9e1EEu/o/WGw48YV5jihC7zmtCYHg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(366004)(346002)(39860400002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(2906002)(31696002)(2616005)(86362001)(5660300002)(41300700001)(26005)(82960400001)(6512007)(66946007)(316002)(66476007)(66556008)(38100700002)(83380400001)(31686004)(36756003)(478600001)(6486002)(53546011)(6666004)(6506007)(8676002)(4326008)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UWoyT0VCeUFCbGR2eXBWZnRZQ0hrQXdUM2JxSlYvNVhrZGJENURLNWUyT3pN?=
 =?utf-8?B?dUVuRXFPbXhjeHdOU3N0TnV6VXUrWEh1OW14YmQyM05sTWRKSG55dVhldnd2?=
 =?utf-8?B?VzBsL0VnUkFxOGsrODR5eDBBaW5wUG54aUdDMVpkTHY2amI3Nk1JYjQxUGxz?=
 =?utf-8?B?Z0lFNXcxSjBqNlZOa2t5Q3VJc29RWHF2bWxnNTBEb25NbERsVmNnaEVCeGRO?=
 =?utf-8?B?QlI2TzBlZXdzYXhxL2MwdWR5NjhWbEdDdWwraTBLN0tGZjd4Y3BnMWhtOEVV?=
 =?utf-8?B?RSt5OGJRNURHam1MUVlyUzk5TlFqUWo4dCtsYU95V0wreTVQNnNEVHRoK1NG?=
 =?utf-8?B?RjYxQ2dGNHd5MnYxbnBiZmpxQlRlL3ZoSVlDL1cxaVpLVVF2UGRnYW1weDZP?=
 =?utf-8?B?Yjl4bk41emlPMnVRVG5XY3lzOFFPaVFLQnEzZ1Nud1V1bm5DMUVtalp1RUNy?=
 =?utf-8?B?NGRVRkppaHY1WE43NFU3Z21xREZuQ2tKRGJWQ3krNk04YlNrL2JQdk1pTEdh?=
 =?utf-8?B?ektMa2ZZRzBtamo2UldldEk0MTMyUUtxQWc1OWtkMmdFenVSLzVxN0tMSjhm?=
 =?utf-8?B?dFVyNC9LTGtKcU1vS0hTV1hhMGw5R0NpSmN1QWJMWDBCdk84S1BzTllDOWV6?=
 =?utf-8?B?OU1EZFowRTdjZU43TnRUQVVoYXlKK2l3R0RicUxYUnBUVlhLbHNhTkNmUmpL?=
 =?utf-8?B?T0JEbDFjYkI3Zk1pS0U2ckZ0MFo0M0NNSmhJZlpkbFBRVVdFTmtsTy9CZTIr?=
 =?utf-8?B?R0xsZjJhUTBaZnpvVWJnbTlOQVQ2azErU3h1Sm9rZ0xSNmU5UlNoL3FFRHVG?=
 =?utf-8?B?WU9IWXplNytlblpzeE5aOUhIaVVJRVFoT083bG9NaThXRDNJQ3pLdWVKcmFt?=
 =?utf-8?B?TW5BUFBsbkIrVXVxM0hqeHh1VWlVVGhRb3drTnVXTzlZeTdzWVFxcGg0aWpF?=
 =?utf-8?B?czdIQU9CQ2gxSHZwYWJBcVBvaStkSldhNy9Mb2hVN0x1S2gvYzN1QUJJcWd5?=
 =?utf-8?B?aW9iajJWV2RXQWErNjJVeG05U0NiZnExK2pSYTREdmprMVdPTzRLemVoL1h3?=
 =?utf-8?B?QlJrZjZyaXRtY2NsN21nS3NuczF6enp2UGlOYmJ5Yi9obFc3UU91WDhHNzN4?=
 =?utf-8?B?VHAvSjRMTXFLUXo4NmUvRkZRRDFKZDdQbnJZNG9CbFNRbDh2MUw1TG0xcHBB?=
 =?utf-8?B?WkdIUEp6cm9XeWpEdXVXcmZ5K0xQTW00NkNhV1crWmp1Y2poVXh5SnVITUMy?=
 =?utf-8?B?ZUlTYzNmUnRhZ3pjdUNvcDN4eHpkb2FoZHZETFhXZTdITWxIdHpKUjBWSjJw?=
 =?utf-8?B?N1BFWmVVVXRyb0t3b1E3K2EvcGhHaTRhRnEwTjc3TFAwTGhoTXp5TlNoK2dn?=
 =?utf-8?B?bWZBMUNKci9IQmIxTUczRFpYVHFVRmNaREU0VjRNeCtLc0FiblJwTmlzZlJO?=
 =?utf-8?B?NkdENzhXdzM4TTFYVmVuMVRnSXZpYzZXN212R3kxdndOUkFLblp0b2wrTUJ0?=
 =?utf-8?B?VnJnUkdiSkY5T2VzTXlmTS9Lb0NSMEp2TnZZTW9KWTY4ckUxMzlVUHFEb2JM?=
 =?utf-8?B?bWRwQXBYSFpXNW9uT1ZyZks3TFF3dkdFRUFsZnBrR0NZUjhhbFlIazhzQy9K?=
 =?utf-8?B?WGJLdUVIYXdOSW1tTm1RanE0enpDZ1NPL3YrM09DSko4MUlMRy81Mk1JOFZU?=
 =?utf-8?B?YTBYVG9Sd3pNM2l2cjRsLzloZElPUVZybDFLUkY5SFlTb2QxM3BwQlpxSC9H?=
 =?utf-8?B?ZnFEMVJRNGNoT1A0MG52S2Zta1FmUGNqS2orSFVqZzZjV0o1ZWlNcGFpSkYw?=
 =?utf-8?B?TXJWQWtWWHhIU3FmTFliU3VhSzJFc001MkFuUnpKSFFZbWlGNVhIV0YzNStt?=
 =?utf-8?B?VlNDSW84anhXVDQ5NForZ2tPTmlzTm42SGdnUGpldHVLeEZ2ekhhM21VaWFT?=
 =?utf-8?B?aXpyeExkV2xnREo0OStDeHJHYVJXQ05uRStEU3hId2VFSnZDSjhGcmlTdjd3?=
 =?utf-8?B?aTVzczI0M0pCa1JTMmdxZEd5NCtuU1lVSXRzWUtEMWlTb1BIMEhtVTFuckIz?=
 =?utf-8?B?YVBsRll2ZUdWaU9WVDZYM091cTdGMlhaTXNzNlhrTFJDejc1MVVMNzFldUQw?=
 =?utf-8?B?cUN0T1hMMDh1SjJQRHVuM2VGRVhvT1haTDZHclJzNWp1bG4ralp4WElsejhV?=
 =?utf-8?B?aGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3265edb-7b81-495d-f8a4-08dbe5ceb2bd
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 11:33:33.0763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mg10obH0ttd153OnyM9e4FNn5oxCiIF2iFbNgtvChxYhFYJth8elm+YtEHp/6Ey3RRlMha2+wYYJISGd6VEyPkzQels/PTRzu4w4iUDPVzw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6367
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 Nov 2023 11:33:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13582



On 11/10/23 11:39, Jan Kiszka wrote:
> On 10.11.23 09:05, venkata.pyla@toshiba-tsip.com wrote:
>> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
>>
>> When artifacts are signed with sbsign the images are not reproducible
>> because the signatures includes build time-stamps.
>>
>> This can be avoided by creating the signatures on fixed time-stamp
>> (SOURCE_DATE_EPOCH) using faketime.
>>
>> Fixes: #83
>>
>> Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
>> ---
>>   .../ebg-secure-boot-signer/ebg-secure-boot-signer_0.1.bb   | 2 +-
>>   .../ebg-secure-boot-signer/files/sign_secure_image.sh      | 7 ++++++-
>>   2 files changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.1.bb b/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.1.bb
>> index 546fded..57ad1be 100644
>> --- a/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.1.bb
>> +++ b/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.1.bb
>> @@ -15,7 +15,7 @@ inherit dpkg-raw
>>   DESCRIPTION = "Signing script for EFI Boot Guard setups"
>>   
>>   DEPENDS = "secure-boot-secrets"
>> -DEBIAN_DEPENDS = "sbsigntool, secure-boot-secrets"
>> +DEBIAN_DEPENDS = "sbsigntool, secure-boot-secrets, faketime"
>>   
>>   SRC_URI = "file://sign_secure_image.sh"
>>   
>> diff --git a/recipes-devtools/ebg-secure-boot-signer/files/sign_secure_image.sh b/recipes-devtools/ebg-secure-boot-signer/files/sign_secure_image.sh
>> index 0c9b898..213cf8a 100644
>> --- a/recipes-devtools/ebg-secure-boot-signer/files/sign_secure_image.sh
>> +++ b/recipes-devtools/ebg-secure-boot-signer/files/sign_secure_image.sh
>> @@ -30,4 +30,9 @@ fi
>>   
>>   keydir=/usr/share/secure-boot-secrets
>>   
>> -sbsign --key ${keydir}/secure-boot.key --cert ${keydir}/secure-boot.pem --output $signed $signee
>> +faketime_cmd=""
>> +if [ -n "$SOURCE_DATE_EPOCH" ]; then
>> +    faketime_cmd="faketime -f \"$(TZ=UTC date -d @$SOURCE_DATE_EPOCH +'%Y-%m-%d %H:%M:%S')\""
>> +fi
>> +
>> +eval $faketime_cmd sbsign --key ${keydir}/secure-boot.key --cert ${keydir}/secure-boot.pem --output $signed $signee
> 
> Looks good to me. Quirin, any remarks?
> 
> Jan
> 
Looks good to me.
Quirin

