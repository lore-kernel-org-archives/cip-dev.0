Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E29C4167B
	for <webhook@archiver.kernel.org>; Mon, 11 Dec 2023 17:56:36 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.48])
 by mx.groups.io with SMTP id smtpd.web10.1996.1702317392686363097
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Dec 2023 09:56:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=T7/ZL1JK;
 spf=pass (domain: siemens.com, ip: 40.107.104.48, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=idBSnzY2ALyaxf5Y5bXGl7T5E23Nfz+LwpjrSfzYL0i7KVEuRAJ2RL3cLWohjd77gSeee+N59pyf++YRblAlzxviDCqG9BP7BTv7T38xWTUbdBc2ZlMYLou7N8Tqx1oKSS2Rb27uq+sVlouHS8UIwl7LL+sw1Mpe9hT8FNmSCrIJeZFO7gRSyVmrUvq/LbHy/oiCRCd0dQyiAGIZGUsaqVmcSXZYH1T00He71fKpPjnP9hSJnpZ1RRIebZDiqIAcc2FhDuTTypTOiaKKc6S6YpYGDI3i+RwRFJG8bk1Frh1YhpAmmHkIlBs5FFHRKhadvvKvO7GazKhzwG3IruqIgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iGU00UE1cuRoJGWi53YV7R8uYiqHDqRyoUQZMw79R2o=;
 b=aaCHLrtvr3WkN7H5lKQtg/1Xa0k5QlGPezALl0MXa3PAsPoQZ+Qk5yMH+NB/HO8Axicq0zDr5/PO3t5Rv1c6KLyJ4+4m50XUMuUUYqQYVmMOoC6fEvt3kdWQtXjJ/kKH3qTKxR1cp5VIbWmFmSgTW6FpSZEeTdUb3ldSTqiQGMsM1vZHOXWd+gV+cl3+bWLTMCtqZlWDOZ1RKn9YMAbkiRZp3rPekLvKnc0wVcUePG+eadUcc7W5LPtuqBJrDjMAu6Qi0tLQnDhVIf9UvfUGop2uSd9GXV197tCP/2clF1zFUfXdZJRI2H4w9kkPmjp6tzDrJgwFYr9ayvKxpQKxAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGU00UE1cuRoJGWi53YV7R8uYiqHDqRyoUQZMw79R2o=;
 b=T7/ZL1JKC1TcTPB0BCXNUEevVkF2q4pMAw4dHOqJpaCakI1LpmAmznEXn/e0teUQRYuNl8ooYvQtuv8s9Sq2TtkoBBffmbturyDTmjNtLAAaW8DB0edTi1Z2koXNMshEuHOWHvpt0QakSz5ZiQL3WS1sejWWzfwHTZeJpLHreVM7Cy2kToLJkzbMS9jmZrCd8NYb/npYE/R3Wy9Wd+d1OK+IVQC+eHdgjQQs7YZEJAj20FFbk1DQwty4OeM3SyEKnHSGh6vBpO8Iej6qD3JV1cwKK2AhiUbfZGJsmxh5ksb86EXXxOpez/HIRCQhHLKxs9Ml50zSYYgtpIMZL78Ncg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by PR3PR10MB3836.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:48::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 17:56:29 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a40c:1061:b15e:cbde]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a40c:1061:b15e:cbde%5]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 17:56:29 +0000
Message-ID: <aa290603-5e23-4531-9aba-9b3bd5b94409@siemens.com>
Date: Mon, 11 Dec 2023 18:56:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] swupdate-certificates: Fix shell
 error
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20231211165345.821930-1-Quirin.Gylstorff@siemens.com>
 <1eecab1f-5b66-43ca-b6b2-1045a05b6319@siemens.com>
In-Reply-To: <1eecab1f-5b66-43ca-b6b2-1045a05b6319@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0202.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::6) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|PR3PR10MB3836:EE_
X-MS-Office365-Filtering-Correlation-Id: def0bdb4-1584-448b-204a-08dbfa727e03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	AYJsalvjiRr/3lLpYmpAcHK/GG/PfvmKmhZ7hIgFlyP7z53O6YxDuh/4fZ8pfaqagRbpjHbh1/1bABMvfRwOd/ZCttDi5yKD/yS0n5QfuR8cZIAeiFgJPjbB/HDRfb7aBeO43aLGI3PEqcc/pR0ip6UUtmK867PNIivS3ocGbE41jt3v78TcrW3O6dJsFtTxuNXi735D+v4ODElWKhlvO7Vyh6fKkiPGdxF9tgVCrwx3qpKoQr+37OHCAvrlRzAimI8yhdQwCNjLsP/hX0nQqh3zJw77Ed6gnh6qmDPz4w0BgxNmActC6N7wd7kjUPmALMdLP6UOsSqtaEShwlcFcntUGuKrBlSjWpWsUHcl6XRKztmtBC0GwStUPFFCYRFc5qVn7Fo3J8bDqbkAFDcLMfhAgSLv7Dzh0M02snVeT6+PMuTepeqD0uPPuQopBM6eeynmDocwgwxppVAA3yxbav2W/pU+eoGdwFjpNSTrtDWU4ijJmt8TA+C/GYYFGAJA9fubBvOIT0NgpqmAlIx05sW0xcLKB7a67ay+XusZKUIKQDN4o9JJByHmm+zbN/9afQpJku8T3uZXSmzAqnM0+MIPnObylRoO48C9wk9tHM4+LmJt0qP5pQQPR0bcsQ46UVIRHsAyQaXb7/ZpNMdJ+Q==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(366004)(396003)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(41300700001)(26005)(83380400001)(2616005)(82960400001)(86362001)(36756003)(31696002)(38100700002)(44832011)(5660300002)(316002)(8676002)(8936002)(2906002)(6666004)(6512007)(6506007)(53546011)(66476007)(66556008)(66946007)(478600001)(6486002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UHJRcGx5djdJd0Q3ZEpNcm1jcGVQSm85eGFSTGF0UkpHV1VNM3dDa21UYk9x?=
 =?utf-8?B?cjBJdTJDUE9RN2FDV0xoU1NGVzlGRUhqZUpXR1F2aU1IYkYwdGRodVYyRmRl?=
 =?utf-8?B?NlBSUXRweSs1TFpOVWRNK3ZYZ0NsVzIzVnJIUC9wRUR0dXVUNFE2bjZqWkRI?=
 =?utf-8?B?Z0NJeFdGcnVIakZ1ZlJhQisrWVJ5RHVCeVJuT04wMFhJQVEvUnkrWkg4cGtw?=
 =?utf-8?B?d2QvK2M0aCtyMGcwdXNDSVIyRThjcWtiRWlEN05nR1JaZlFsdThHVFI1TitI?=
 =?utf-8?B?ZGlwV2RTYjhRYVlWbithc0c2WGZKTmh3a0k2andTZy9hVFh0N3hmb2JzNW5F?=
 =?utf-8?B?anV4S3R0aFg1cjVscTBHUmNwRmpnWXpaMEo2cmpLSGw1eU5MbFNydllXZkRq?=
 =?utf-8?B?aTVvN3VXYjRzT0R0YUJHWUsrSUUwdEsyYUNTNmhva0FOQ1gxckZ4eUNLMWJB?=
 =?utf-8?B?MjViZUdyNEdrKzJWQTZGWjJIbEZWWEg4OHM1a0tDa3YvenBHRTM4c3dlU0dm?=
 =?utf-8?B?Z28vT1QxZWZxaVRPYmZUVVNORHV2Q2g3ajFGUzZvNzRyb2JiL1hnczBCbG5k?=
 =?utf-8?B?WXBmVVRWeEZHYk02RERNS1YrZklpSGpCNThLZ1l2d2UvZmw4RVdSUmNiRHNk?=
 =?utf-8?B?ZytpWldnK3VnOHZoV24xWkVjOTNUT2tYUFkwRTV4UzhvbngrckppYVVQNWRz?=
 =?utf-8?B?cXprcktCd3o1a0dDSHFtN3dKVGc2c0ZvbHg2TFBTeXVjem03K1NqaXQ5SHpU?=
 =?utf-8?B?NGV4bVhIS3RUdlRyVHJQTXpyU29RcGtnd1o0ZWdtUm12UEUzUGlZd3Q1dDB3?=
 =?utf-8?B?YXNiSmhuN0ZEaytsRWVQaUZyWTJVMWNxT1h2ODhqc0tja3Rqc3VsMWJ2UVpS?=
 =?utf-8?B?VmZqS2xqWjZkdGRXdXJHTW0xYklaQW03NXBwK2Nram9XKzdFdmdOZ1pvNnp6?=
 =?utf-8?B?bmNvUTFMZnEydVpIbzNPVURRN2tJLzhFZjBwNHN5T25PNGhlMHkwNnJqbURK?=
 =?utf-8?B?bEVFbWNnUWJGTzBQYlVIcWNuRFo1MkpwWTJZVXd2eHcyalpNamtmUmZPZnJp?=
 =?utf-8?B?YjRLVFZoOXRuY2x0RXRoc2dvalYySFBKdkljMjF3cmpHdHdzM0xBcENtMWxF?=
 =?utf-8?B?eWg3WXR4L3FYRk9oREFkUTNLWXg0eCs1MGVONG5wWlo1RkNwT0ZPUmxVREg4?=
 =?utf-8?B?R2tJWjIxZEJrS0ZzMkJQYUswbklFTTFYQkVPQ1EwSTQyZ093c0RKSXk3Wlkr?=
 =?utf-8?B?M2MxNjU3ZmhFSHVKLzVENXBIdnNDYzdoeUNGUUJQSU9PdndzVFFIalB3T3dz?=
 =?utf-8?B?bm9UZjVtRGdJL25DZWpDd3JHNlE2cjl0eU1zcnh0UkZTeEtybys1YVZTbC9l?=
 =?utf-8?B?ZHRFc2RmbGxleXltVVJSVXIrT0tNNDNvWjRtVVE2SWFxRXo3TkR2RVl1SUpl?=
 =?utf-8?B?QzQxQ2lub3BhdDhCZm1nbUt3WWcxM0hIdWFyaitaeGNVMTZPMGxUTkNKNVJp?=
 =?utf-8?B?bW1YaHRXUmIrejhLeTBGTXExWE0rMWEvanQxeDRkYjcxSjNISkJ3WjV6TG80?=
 =?utf-8?B?Zk9FY21oVlc0aVFtdTlkTGdRV28xSGhNc1I3MU9vSTFQVXlSYkZUK3BhNTRB?=
 =?utf-8?B?RzZ3SnlqZytlUzE0Q21TUTBENlE3RXJ3MmdOZUh0amRaVk5OZkNMMXhFTjhz?=
 =?utf-8?B?bEU2RTNlTFV5bjVVVWRvU1NnbjY1djZ4VzZTODc3M1plVkhKQ1Z3KzJqYkR5?=
 =?utf-8?B?dzkxcCtlNnMvVGxkQjhBclBjYkNIVUxYM0FjN01DR21ubkx4a3V1VDJueXd5?=
 =?utf-8?B?YWUwZFZmYlJReDVnczE0YkJVVS9kRjgrS1ExekpWMklRTGhJWTR3dTh2dVdM?=
 =?utf-8?B?T1NjWXlyOE0yQmhVajJQU3drQ3dhUFFHQkN5SXptcVpvQnRxVG82blhzeVAr?=
 =?utf-8?B?d0JUemxkQjlibk5ZNnhDTTFkclplSy9tZWtIbWhPUzhVUGNaWEFRbmxwV1Y4?=
 =?utf-8?B?WC9IbVNCQ1dWVzJnT0tYbFRubEI5QmJ1NEI2Z3QwWjBFYjBsTDVsTE1JcVJE?=
 =?utf-8?B?b01aWUxwcmRwdDZMQ2hoQU9LTWdYZDZmL0FCdGo3M2htMnBWa1Y2eVJWNmli?=
 =?utf-8?B?WlFjNms3ek13bFZzL0ZvQzFLbjRqME16RVZybEwzK011V25BOFNzSng2Tzk1?=
 =?utf-8?B?K3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: def0bdb4-1584-448b-204a-08dbfa727e03
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 17:56:29.1791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aC12AYgfq3IyujHm1BCaACcDMa5pRQ+slBwTCAScJxDRPMtc5/wSGE9xy/KrkLdEbBM6N93/4XHyU99Yr3XDhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3836
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Dec 2023 17:56:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14036

On 11.12.23 17:56, Jan Kiszka wrote:
> On 11.12.23 17:53, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> An Additional bracket was added to all if cases, which leads to build
>> errors.
>>
> 
> Fixes: which commit?
> 

The initial one, daa9e6738d1763a953fadc4de6010fe8dfddf27a.

While it is valuable to quote variable content, it was not very helpful
to fold those unrelated changes into the commit. Please avoid that.

> Jan
> 
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>> @Jan This should be added as soon as possible to master
>>

Also, please describe what the impact is. We are carrying this change
for several months, and no one complained so far. Was the issue subtle
for many, or was it only affecting some configurations?

Jan

>>  .../swupdate-certificates/swupdate-certificates-key.inc       | 4 ++--
>>  .../swupdate-certificates/swupdate-certificates.inc           | 2 +-
>>  2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc b/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
>> index 0b3e045..56d006a 100644
>> --- a/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
>> +++ b/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
>> @@ -21,11 +21,11 @@ SRC_URI:append = " ${@ "file://"+d.getVar('SWU_SIGN_SCRIPT') if d.getVar('SWU_SI
>>  do_install[cleandirs] = "${D}/usr/share/swupdate-signing/ \
>>                           ${D}/usr/bin/"
>>  do_install() {
>> -    if [ ! -f ${WORKDIR}/${SWU_SIGN_SCRIPT} ] ]; then
>> +    if [ ! -f "${WORKDIR}/${SWU_SIGN_SCRIPT}" ]; then
>>          bbfatal "You must add a '${SWU_SIGN_SCRIPT}' to execute the signing process"
>>      fi
>>      install -m 0700 ${WORKDIR}/${SWU_SIGN_SCRIPT} ${D}/usr/bin/sign-swu
>> -    if [ -z ${SWU_SIGN_KEY} ] ]; then
>> +    if [ -z "${SWU_SIGN_KEY}" ]; then
>>          bbfatal "You must set SWU_SIGN_KEY and provide the required file as artifacts to this recipe"
>>      fi
>>      TARGET=${D}/usr/share/swupdate-signing/
>> diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates.inc b/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
>> index 0553c25..10b6833 100644
>> --- a/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
>> +++ b/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
>> @@ -18,7 +18,7 @@ SWU_SIGN_CERT ??= ""
>>  SRC_URI:append = " ${@ "file://"+d.getVar('SWU_SIGN_CERT') if d.getVar('SWU_SIGN_CERT') else '' }"
>>  
>>  do_install() {
>> -    if [ -z ${SWU_SIGN_CERT} ] ]; then
>> +    if [ -z "${SWU_SIGN_CERT}" ]; then
>>          bbfatal "You must set SWU_SIGN_CERT and provide the required file as artifacts to this recipe"
>>      fi
>>      TARGET=${D}/usr/share/swupdate-signing/
> 

-- 
Siemens AG, Technology
Linux Expert Center


