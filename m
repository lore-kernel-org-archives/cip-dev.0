Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6741091904
	for <webhook@archiver.kernel.org>; Thu, 19 Mar 2026 18:03:53 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.63])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2539.1773943431624346963
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Mar 2026 11:03:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=jxhp4e3k;
 spf=pass (domain: siemens.com, ip: 52.101.65.63, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yCeUADKAwB/YA2ca/GWt6DWmFyAJjHGEkUUBVgKZ9K56lArsZpjj2ObyOSjLF6UUH+xVhn33RjkgWzjUSX+StjGQ7HvGOfDk0WNep213JcnLRDO6Xrd4xb5KMeFC6RElVmWOxVKTlXXqDi/6wfi9GxgzP4q7xfJMIdQlLIzhVYZth7A2zSB6Vqdo0qaeFUQCWUDK+QJctr8oIz7FAQQg9cfsyv9eGXJ5X+dcZ16ikC6KmuElHSZwNdOkAFWZASp/6XuiCvSp0teB0xu2Wh40fZXCBPZ7dhiSwd5ZtX2vnXx6j9f1rmari1U+1NU65e8caBqi48lLK6VSZl/nQhjipw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c37vs/WhaSTBc4250vfXp1rTHqMr9npSZ9PGkGbziTo=;
 b=i2AiGygcri5KWM36BJPqybRGyx8VKDZ/0Fk8ZjCB0zLWKpLAnhmyOXft7zb5b7lWt8Ce7eGPzS87DlaThR1B8QxGRHk98arnnIHIpdm2wRkamx6Ta42C+53PRrPvEt9wbVCBcZvDqPao0FJXOqWagPG379/d4ULEDhfIi56x8b/U7MPmVsy/ArcOp8XqzceFvrNjEKWmhvHx+ylaiMqttq1skd+o5xSr1+hQqCy1Y0XEbUJQHJYo4P2sXYjdgjaQr6Am6SsUV2N6sJGi80HlmXNR1KsqWAURMHPgeNotHvYeOT0cLsbC/4qM/t/NOKEJ8HG6HFGgoxc7/ZfCU8ITMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c37vs/WhaSTBc4250vfXp1rTHqMr9npSZ9PGkGbziTo=;
 b=jxhp4e3kLJ/Z8mBXpZoepL2W6dLxYJ2QxpQ1GPLR3Nv5nsRd/P5HAmqibgdB89Qm1z9JFLu2/Jq7CNyWf4WdlTEXvGK9wpomy1YzJbXtDvhJneKnabN0mocVoirM/EJQoFzGSCYvbLA9eYJauyEjtxUlIA/FzwxJM5knc4dOI2eSQUCiQIDHvjPo2VYWEeGwZctrhLicSXWn/TQDX7XYxxg2Wd66LJuOusiACSro1eLyhFkWJoMDt7NZ0RssAlXizG9Y0opTrMrCC/Wjp+lJcFkgEjD1AEnvC1vDE6nHjRJxG/w6t/fD6w8S/NYCNiga2ckzjpnRy/VCQx7dzpmJ5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PR3PR10MB3849.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:43::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 18:03:47 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 18:03:47 +0000
Message-ID: <32e1e6a5-5bf7-424a-9405-dc86aa90eaf6@siemens.com>
Date: Thu, 19 Mar 2026 19:03:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] swupdate.bbclass: Set owner for
 reproducible swus
To: "Moessbauer, Felix (FT RPD CED OES-DE)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "Gylstorff, Quirin (FT RPD CED OES-DE)" <quirin.gylstorff@siemens.com>
References: <20260319154905.2525216-1-Quirin.Gylstorff@siemens.com>
 <3e9027c3db1a174a46df9176d3cfbe19bcf1a975.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <3e9027c3db1a174a46df9176d3cfbe19bcf1a975.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0697.namprd03.prod.outlook.com
 (2603:10b6:408:ef::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PR3PR10MB3849:EE_
X-MS-Office365-Filtering-Correlation-Id: a579a8cf-6d58-4d9e-663e-08de85e1de01
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	PmYZUuvu5jkDwlVAYfP/snlC8TDHDUL8GT7Fr6oDPDzv9DKrjfUySR9e3pFe2uZ6emXtR7nuBIY92GUCKE6hH+zZyUh5Xf+b2z0/lClW+waL0xADfTke+yTMKZDNfhOvf9oPMzoRVBvWkDH8f39V3MPCSDiTZEN1h9+VZ6AX+9E8qFUSr791UG5JcAGyviNDu+YMT7EE1yybPyKhYxcT0xTF4i4I2FRV5CCEgeCQrkatXHcY5n/33uxOw9TNVnWDcRxIQ+23ls1LCNg56eT/gy5QTxNi7eHZgBzMNsCfmUDV9/Bb+hQgX4JRiKY6VHFJTdRKefUYcROrRTdeX3ndC/2Eqe0pGxTuYXATf+8PlYsXRiHuE569EqtG1JtvYStdwtPn8s4ePJ/IEGFMYZS3mTnOtk4T14cvrVKmsVqhRka/hGNWdJWnUmksBddD/uJp2GdhuCUkloyQdH+8SKXoZHYvZo+pQrBi5/E2FR69ZmAQ3K7Mc1oXGAW6nV0PTRlXrzbDT+MPKb+dEnT15qJK3UaYG9vKJvDuaoZcXj2Aa0rfyIb7UsHvI9KIuh5eQDRR4d+7hDTZBpS/DynQTBvmhsYszOr0fw+7BaxFVPX3jb8edKZjorP1CQv3UtN0VtyG03dmmXrSUa/slyqbN6BO24sJhsuAzD7W2vsftYf9wLrsEcUHXD+wN8AiiMRHdu0gRniLwo7JAE0VWrKSvWlsmm9q+Fpb4p159JrOtopTvKs=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MHJ4ZkRUNStQeXZkeVBMTjcxU2tqVEo1VlpwQUlxYndQYXF5UkgxMU9wZm82?=
 =?utf-8?B?eUZXUU0wN1R1NFowL2FjRStJNGJweEU3QzlFUjZaSmphd3haQ0JkWGxUN0pq?=
 =?utf-8?B?R3FNaGxTMlZNcHgvWFJCNDA5azdnSmM0RjNwT3o4dnh0aFQ3WThpVVJtR0Nn?=
 =?utf-8?B?a3hubkpTWldhRmpESFYwWnRQUjJsYWIrcmdZaVNZNTc3YWhuYjl3MnBVUFJ0?=
 =?utf-8?B?S2dLVHZmc3RJSjlyL21YRXVSM0pGN0VIVTdhUjlpRmhRcHpYaFo3dUpSRzVi?=
 =?utf-8?B?ZnRnL0M0K3N0Yk9tZUdQWEtMd2Z6MzdXaXhnT2VpVlZKQUtQSEtUaEZFZHlO?=
 =?utf-8?B?eEVSY0I2TCtOV1JjQi9ja2hiTWFIeFJqV3h6VWNkOGMyYTJaMXA4RFllMU1k?=
 =?utf-8?B?K2hmSGhhVUNjQXlWTlE2aHE1MHl6NGxONGpQNEg3b2VOekZ2NVF2cllBNENS?=
 =?utf-8?B?eDNTMng1eEFNczAzNWFIbis2c29nNEJvaG5GNzg5ajk0Sk9YVlYyMDhLZlU1?=
 =?utf-8?B?RG95aXJaMUF4bWxOb0w2ZnJSTnpwODZMV1ZLS0NUNDJBRkY2Y0tuaDljWUE3?=
 =?utf-8?B?dTYzaCtkNGdRQU5sT1FQVkFVbWFrZUxidklhQWQ4eVhyZFRuL1pDdTFiMG92?=
 =?utf-8?B?M3FlakdyaXBLZjQzTE92b3BkZUIyWlVMYlhMZWNhSi9VRUQvTSsvMmpPVHB5?=
 =?utf-8?B?Z0ovSWtrMWdsYXNHeENoTVFOQWdZV0hmTUNGWTdlWiszRGMxZjg2aVY3NHha?=
 =?utf-8?B?SzZnZ3ZOZ1BUcXQ1RndLZW1vQ0k2ek9Rd3FyWHB0K3ZyMldlaEs0K0JEZUx2?=
 =?utf-8?B?RmUySi9lZkNmRmpKOEMzR2ZScms2M2V0ZzRiUGdubGFhN21CYXFKNml0OGNo?=
 =?utf-8?B?V0xKdjAzbzg1ZU1xeVNscEJtYmZvTzNjQ3pJbDAvamlNdGRZZDMxSjhPSlFV?=
 =?utf-8?B?djM2eC9Tb0xvTjVML285N1FITDJkdFp0NjZJT2xBWmZQMkpOMGFudHVUVFRE?=
 =?utf-8?B?VnUrYjBLZ1pSY1I1b0hpREE0cjhIRmFjVmVsaHN2cHB5ckM5Zyt0dHQvTklz?=
 =?utf-8?B?REYweXl0UWNVS3QzNWp3YUZOK3pnZHdRdC9VM1gwSk1PbkE5d2NRRGVsV0s0?=
 =?utf-8?B?NVJWb0kvQVNVcnM4RHBSdFVhOEM3dmV6ZHFmWEhZUllMTVdMUi9kOEEyclZt?=
 =?utf-8?B?R3g3cWh3YUE1WEovMExxRVh2ci96dWtZemVVeExhSnpmSGZLRzdVcWdZTGNw?=
 =?utf-8?B?SE1va1pPSGQ1NjdILyswUldJTThCRDFxWG56VnlZTWIyckFXRzVyYkV4NnNM?=
 =?utf-8?B?QlRQR3VHNER2S3NSczRCTStjK3p5NWhXTFdBTmJBZ090aTJiaitaWEJseFlB?=
 =?utf-8?B?TjRqVmdVT3V2SmdKb3VpZzBLdi9nU0pjYzFSejErMjdHWTRlKzhUdjRPTi9V?=
 =?utf-8?B?S0tFbVNuK0dybFJhMTFFc2tGQnNEZVRnbm13aUNTNkl3YXJyM0R6M1VsYTRq?=
 =?utf-8?B?MUhHYjdEbm1DaWN4ZWpJdkllelJTMHltZ2ZuU3Y4QnFOSmYzcFVBczRXMk40?=
 =?utf-8?B?cWdYR05NRjkyWkFaZXpqQ1RnTHNTc1ZZNHlvdGFkcVByQkdwMlZ0b1V5djJs?=
 =?utf-8?B?MnR2ZmwvdkdjZXJMaWl6NTRqQzQwcFFwaC91UDcvMGZIeElFZE8rNm1LNVor?=
 =?utf-8?B?RjF0VzE3bjRqcDRSNS9LemE1SkZ2dllNSVp5S0JLaG1qWTJCcExtbXlwTWlv?=
 =?utf-8?B?UnI4UUNMTityNDByNEhpdUZPRmxRdDhrMVRVSmxBZmY1cXROOEx5Q2hOY0ln?=
 =?utf-8?B?SWVEWkUvY1BobHVHR3ZqNitkL0Y0RkhOTkVESERSQ0drUXhuRHdoQ1ZxeXpM?=
 =?utf-8?B?eWNSSDM4enNsV0NFRGw5WFBCckRDUWRhQmsyUUpQQUhvOC9YZkdialcwSmZH?=
 =?utf-8?B?Q2Jzd0RvR0dqUFpzdXlnNnRQVlYyV2JvbkRQMW9zRnhZK1c0VUE1T2N0WDdp?=
 =?utf-8?B?ZzBuTWtYSUx0QmJqanM1K3Z1ZjVJVUcwWHVnb1NRdTJiN1RlTGIwY05vTWk4?=
 =?utf-8?B?RzR4aDVFRkNxRWdoQkF2dzY4b214SE4zTUd2bmdOZ3RTVGdlM3V0Tmt1dmtO?=
 =?utf-8?B?YVc3NjdyTmYyYUlvYk1oQjhPUWVldkc2ZlVWSFBSTXlVYnJpN1F1TmY2QU5L?=
 =?utf-8?B?L045eVdtSmZXbkdodlpaN3hia0QvVm52d0NzQkEwNEpvZ0xYTFRuQWZMOXpk?=
 =?utf-8?B?VGtyWmJCcGI0SzlkNmVLUDZsbzUzRFVXcUNRbkZNcFZacEUvYk14R2NIVWxm?=
 =?utf-8?B?RGZTK1RYdjkxZmViM3B0L2c0NERNUXRZWFNScmRSejJ5d0cxcDhXUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a579a8cf-6d58-4d9e-663e-08de85e1de01
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 18:03:47.6578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: twaTDEdmP/1ANl2t/RYfFjsnJ3XPRAm5i7CHOkCquse6pryD1KRfjyz5B2u7yEP8G7Y+TschlMHRTkYfFTK+uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3849
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 19 Mar 2026 18:03:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22513

On 19.03.26 17:35, Moessbauer, Felix (FT RPD CED OES-DE) wrote:
> On Thu, 2026-03-19 at 16:48 +0100, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This avoids leaking of build information and allows to reproduce the
>> swu on multiple machines.
>>
>> Reported-by: Felix Moessbauer <felix.moessbauer@siemens.com>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>  classes-recipe/swupdate.bbclass | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/classes-recipe/swupdate.bbclass b/classes-recipe/swupdate.bbclass
>> index d92d55f..8e90169 100644
>> --- a/classes-recipe/swupdate.bbclass
>> +++ b/classes-recipe/swupdate.bbclass
>> @@ -292,7 +292,7 @@ IMAGE_CMD:swu() {
>>                      esac
>>                  fi
>>              done | cpio \
>> -                --verbose --dereference --create --reproducible --format=crc \
>> +                --verbose --owner $(id -u):$(id -g) --dereference --create --reproducible --format=crc \
> 
> I propose to use --owner 0:0 to make the code more robust and easier to
> read. When looking at the patch, $(id -u) anyways seems wrong, however
> the whole command is executed in a here document that is
> (implementation detail) executed as root and as <<'EOIMAGER' is used,
> the $(id) is effectively expanded in the inner shell instead of the
> outer.
> 
> That's a lot of magic, hard to understand when reading the patch or
> even the code.

If the IDs do not matter - and it indeed should not on second glance -,
using that static IDs sounds reasonable to me as well.

Pulling this out again, waiting for v2.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

