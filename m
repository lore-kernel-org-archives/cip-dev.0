Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F3CC531D0
	for <webhook@archiver.kernel.org>; Mon, 27 Jul 2026 08:04:54 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.11])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.26652.1785139481934304292
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Jul 2026 01:04:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=nQg7/1nT;
 spf=pass (domain: siemens.com, ip: 40.107.162.11, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u01DUTw782/TRKz8OkwYEtSTtqMS3aZEXfAcmp2x6F6BN2ishh7BRVsRYhEaUaHphX3JnePAlQqdqxuhON4J9VHVq6FnQEaqK61BGH6mzgFhKt68Ai8xJms+/E2xSxZAZBueo9OQ1tWHoT70UulBYEJ6K5wO6076vwIzf8VYK+hIa6+EJWD6cT22QPKDLcldBmfxiw1iwqgTadUQ2IRzQlMAShhUIA+gK9r70/SdOe3cWmrlr7cimlW2CeCZcNu92Iu3jAn0S9KxXSHQ6f3xPYBGAFFP3AGqx2BE8q8YqNWhApc1E5rLffAtoen+FJhcdJS/7cTohx7PWDIDdntplg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qBzudMNOfmlOhFYMPw/fV3mAJBQaWLYecACF5/xAT5U=;
 b=cXiSp4asy0xMGet8JWMLq7eqxB0U93AA/oCb74qIaQrSqgIDUUAjzEAeSAyuWi2lwV5bFEI5OWguURz6UNKm1lcr/mbbl/nop8D+j/mNNRD2rjfVxs+KlJzZZ05ZYri5mKjI2YlKbSfvZwzHmub6LGS3sBJy2Ie+V/Gt35cCfZHp0oH0vUChhqabY5lIkLe/9NNj/Z53WVBqaWwOXQqKKdyB+qpe/BHYQKjoaMaToF0fUPavK6yO+cZt2A8Bnw39xPxU36Q/s7ja9w598mR2x7RAAaGvmwhEG/NMz39S2GZK2axHrMINc2wzOULb+BNZk5WIrhmWc8169q/5brd80g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qBzudMNOfmlOhFYMPw/fV3mAJBQaWLYecACF5/xAT5U=;
 b=nQg7/1nTYNgQe9io/DOsTKhs4HGE3PTXosr9cSK2FV6OIiHzlAcWj5AOACVhVDY9mqyvwty/TIgxxAXAv7uvN8jTSk8dFOC6WIEhGF4OvlD1HUNye7ARFaVmAFNvxyHc/PIUrk11YR6GEf4vUhWDeayQ7OR+g8Nn06X2pOh/qw91OgHbllWolOZakAQqpBRfFbBEmdsBR9a65G5goT4FK1sfQ5SL8O16IXn0NKAb/vzbisTXIJzgK0rq4jLHcOxODVoEx55m7vARUu/9g1WT46xpoXO/NgYINqfNOQsquksuhDZ1RzYod7CB3MbmgxGX68mJHMb7lPkadLoO6BWB2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by GVXPR10MB8300.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:11b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 08:04:36 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%5]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 08:04:36 +0000
Message-ID: <229e705b-c33f-4873-8a3c-6b6988bfaaec@siemens.com>
Date: Mon, 27 Jul 2026 10:04:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC cip-dev][isar-cip-core][PATCH 1/4] update to kas 5.4
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org,
 felix.moessbauer@siemens.com
References: <20260724105116.3575045-1-Quirin.Gylstorff@siemens.com>
 <20260724105116.3575045-2-Quirin.Gylstorff@siemens.com>
 <ccbb8f6a-216a-4546-ae7a-8ac13a785d2e@siemens.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <ccbb8f6a-216a-4546-ae7a-8ac13a785d2e@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0385.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::10) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|GVXPR10MB8300:EE_
X-MS-Office365-Filtering-Correlation-Id: 41c81294-4e22-4b32-ec14-08deebb5b32e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|4143699003|10067099003|56012099006|11063799006|6133799003|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	8eDiYbXLNu6kl8QVfl4YUh6BhMSFDPfEALoT30VlCXjRWRITSxdGUD79nw/TMw0Fyc0NpS8k4c+QNDgWfFMi4J2y71jzLTvJ5LHV3jFZbGsnr0rbaF+a2MBjQmT/pQ5N0oHqeH6VTK6Y/XFg7QECvBkwUBxSLgcy3Gr6+1CwJtcU51R0lc3X0njhUuYM/yflRQcc11Wn4ZlX3dt85TbVLbSiC9HybGg/KU1qUgIt08mVList0sFdjwZCaGBop3foKMUfSfCWEZixiGePljIUIVf/6nxaTcbHvfAjfO/KIzefsvu/dSHKR7p6GJljNGIUJcmDHmo6ZZEF0Z90ONYmlrvkEwA3SgFWVCnLo8pthMIs8GzG9uS0P3NmaZBgeJ5ZiqUqLwTLLefyHNlm85iJtlGchhOHWiQljtVFWxLWFLv4pYW53XVX147hHIjLta0MGc0/a8NwbqZsuFnr/znqHEcnsAPi8a0kUf6qgKJQfaH7LV0TmjkOuPSRE/Gl/9uVOn4gZ/nbxKBZDWHHVNPvBOGaxvR0EQU2kvi+c8ZK1X1M3/bt+YZs1Yk29XvRtrddpt53UmWaT3DtI8eDKY0w+08SnOEZA0wkzeyoI5rogA3w1V0RDqP5HH8GmpFopAPu
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(4143699003)(10067099003)(56012099006)(11063799006)(6133799003)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?L016MTJydnZGMkZVb2VXbytadThMVVQ2L3FJVE5rUGhPRnFkdkhYR3VIeGp1?=
 =?utf-8?B?VEdEYkFRWVV4RFliQUtpb2NQVnBqOXZ4ZkJsUlRPMm4wdkwzUnBiajBoelhY?=
 =?utf-8?B?K3F0YS9adE52eGpPOXcyekxqSUtSQjVSc01SeHBmN0srKzNMNkMyRElXVk5h?=
 =?utf-8?B?cVBYUUdtMzNyaXZiVEhRdXlyZFp1QWNqbmUvNVlVeXYxK3RObHhKTTdMZ2ox?=
 =?utf-8?B?dVdqcGcyUldZY25xVTFOWm9mOHZHWnNqMWtnQnVPV05JRzB2Wm41OFV1dmsv?=
 =?utf-8?B?UmgrZlAxWUpyTGgyOHlUeDErV1ZTVVdwYW03NW9JTTU5MGtmekRBbXNWcHR6?=
 =?utf-8?B?dHVxaDZrNFhPblJHRC9zT1c5d3VRZG80cjg0b1IwL0NsUEtxaEdNaFoyYXht?=
 =?utf-8?B?alBGL2ViQVZsSmdzby9pZlA3SEl3clMrZTdqRW1RbWJsYXlvYTk2Z0w3OGR1?=
 =?utf-8?B?WUM4SWIzWWVGSWo1MlQ2TFdRMkZJV1pQZ01iMEVyMGU5RmpqNHZlRTBsS0VC?=
 =?utf-8?B?c21iT3NoNWtuZlBCMlhSYjZvMFpEb05FR1U1UnNkVjgyZHRUUlBhcHlPdGoz?=
 =?utf-8?B?OW9VV0MyN0kzaDFrNHNpWE1NNVprYVZFTFZHdGI0Ny9GQjcrOXRFSm1vWUdE?=
 =?utf-8?B?ekloZW5HU3pKQ2U3YzFrQVpmeithdHFaazZFV1pRREhLNlV6ejZmVzhqRHlI?=
 =?utf-8?B?WVRuZmgwbWlFd3J0d1JvUDd1L216RTlzSHVKd2xlNjlvSWVjQm1hMmFUVExY?=
 =?utf-8?B?MlhYdDdQZUJqRktuNzJpNk54Mll6RUt6RkpIT2NPRFR2UlRETU1QZWRTWkFV?=
 =?utf-8?B?NnVWWUE4S2o2dVRyR05KSmVRdFhxME5lVUo0MVBTYW8wcmJvQW9UVDJ5WklE?=
 =?utf-8?B?S2pCWEZQOXJvKzNSUThhUlVPbERZcGNETXhtcVlzbHMyMnlqckkxODlJT3Nz?=
 =?utf-8?B?RHpOdFVwMnlud1B0TEY0OXZEQnUvTXRNZ2tHaHBYUjZwU3laMW1hc3FiTUVC?=
 =?utf-8?B?MzZyVm52OTJ5SFZrc1ZIcUtnME1BTWJDSnBzMXlUY1hFZmhCcjRrSWVVdkNm?=
 =?utf-8?B?amo5Ujk1MG1hSnFqcTVVUnZma21qTnNtcXpXTmZ6QjdxVGt2bzh0NzEzN2RU?=
 =?utf-8?B?cWZVVDl0Q0p3amZHMDRkeUVuZTMyelNPVmE5Tktuc3RIQnh1c0xnYnRZNGZJ?=
 =?utf-8?B?eWYrbUhic1dCeW9PdFl5ZnB4b1Y5NXJDNEtEbXYzY1RjMjJpcWZXMG9YV2kr?=
 =?utf-8?B?RE5WT2V6U3pkcEZ6cGxIanZGVmVBTFJmeHdBZVIzMVkwRUV4ZWFoajBjRkk3?=
 =?utf-8?B?dk9DQmFuR0xEUndPRlR5QUNxbnpjbE0xR0RBUEpaV0d0MFp2cWhpTEwzS3ly?=
 =?utf-8?B?eXpSRDlTbExJVmNkMzIxYTQ3dDZMdDlGZEV6eUYzM0RycDdVUXpXZGJQNis2?=
 =?utf-8?B?aU0zT0gyOGRUWDE4WmlzSmtwWDNYbWpnSng5ell4U2IzbU9IbmRxcVlobVlD?=
 =?utf-8?B?SzFkVFdNR0lJM3lHbFVORHlzaXZBZ0NQSFZqOVE2cmYrY3RsQzVGeHpwcXpX?=
 =?utf-8?B?OVJEVk45bWJOdG9GSUJPZk9aRFM0eHpKN1hZU1VmR0xUUG56TmZzR3AwSzVF?=
 =?utf-8?B?WlphbmYyZ2xDRDBBUG44Zzhra2VLdHFvMmNyMlNmZ0xUQ25ZQnJDRkhoOWtr?=
 =?utf-8?B?V2o5Zmd4bzl5UG1KSVg5Wk16Qjg4bFFhdVVjVFBLc0NsVndZOGR2R2ZUeS9F?=
 =?utf-8?B?dE1RNFQrdm5QR0g1RXlMZmw3K1UzMjhtaGptUEJVOEMwR3BhUEw5bkNzYTI2?=
 =?utf-8?B?K3ZnUnFKNWRUWGVYUElqRDRhVjllcHc4QTlzVnY0UW5CUDg1TmRuMmNUSFBQ?=
 =?utf-8?B?T1ZJK0N0VmpidFlPaG5RYVlmUTdMMzFhdGxQZ2pGcEZscFlRK3czbTZUaXpo?=
 =?utf-8?B?LzVZbFQwaHNxM2dBRVBqN1dXWXZ2RmI5QW1pdjJFeG9aUEhnVVRWY3B2cEJ6?=
 =?utf-8?B?cnZsbEhUMXEvZmRIVExDeHRWdHBYYjllQ3JaSFIvaGgvMUFudHlNN1FpNTZw?=
 =?utf-8?B?bEc0bEgvTEJ1YXhtNmRWZlVzeXpjSVcwOEl5cS9xMHZKTjE2RzhyOHVCQjNZ?=
 =?utf-8?B?R1RFVEJUY2hZV2NsU1V5aWJEdEpwZzMzNnk0N25xek5OdGtnT1YwOHFBSmVX?=
 =?utf-8?B?SGpZREI3Y0dBZHpGSUhZc28vOHRXY2thV29YSDBhQnZFQitsWllHTnNKbi85?=
 =?utf-8?B?SjNrcGVIeVVvWVprVHF5d1FLRGJVMTRNZHZqK0NrMFlMWjhaelJSWFRYSVlU?=
 =?utf-8?B?NndrUVc2Ri9wRDhPNy9KbzBNaG1PUDFsd0RabkN6bHNyMmt3cVNxQUNDcldn?=
 =?utf-8?Q?9rziAztCwODXT99s=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41c81294-4e22-4b32-ec14-08deebb5b32e
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 08:04:36.2616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7cFsavXHfj0Gc06lRPSh5ltvQwUE1NFLo3uStBC4YVLCOA2pOX9oOdZpmolWPZstFEwK89Gia20HR9XDnhYO5Ksg8iWtIJVfIG7+im+WkXo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8300
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Jul 2026 08:04:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23754



On 7/27/26 8:07 AM, Jan Kiszka wrote:
> On 24.07.26 12:51, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   .gitlab-ci.yml |   2 +-
>>   kas-cip.yml    |   2 +-
>>   kas-container  | 311 ++++++++++++++++++++++++++-----------------------
>>   3 files changed, 170 insertions(+), 145 deletions(-)
>>
>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>> index b53def4..1e61cb0 100644
>> --- a/.gitlab-ci.yml
>> +++ b/.gitlab-ci.yml
>> @@ -33,7 +33,7 @@ stages:
>>     - cve-check
>>   
>>   default:
>> -  image: ghcr.io/siemens/kas/kas-isar:5.2
>> +  image: ghcr.io/siemens/kas/kas-isar:5.4
>>     before_script:
>>       - export http_proxy=$HTTP_PROXY
>>       - export https_proxy=$HTTPS_PROXY
>> diff --git a/kas-cip.yml b/kas-cip.yml
>> index 23bbba4..6badc7d 100644
>> --- a/kas-cip.yml
>> +++ b/kas-cip.yml
>> @@ -15,7 +15,7 @@ header:
>>   distro: cip-core-trixie
>>   target: cip-core-image
>>   
>> -build_system: isar
>> +build_system: isar-privileged
>>   
>>   repos:
>>     cip-core:
>> diff --git a/kas-container b/kas-container
>> index 993f0bb..55bdcfc 100755
>> --- a/kas-container
>> +++ b/kas-container
>> @@ -27,7 +27,7 @@
>>   
>>   set -e
>>   
>> -KAS_CONTAINER_SCRIPT_VERSION="5.2"
>> +KAS_CONTAINER_SCRIPT_VERSION="5.4"
>>   KAS_IMAGE_VERSION_DEFAULT="${KAS_CONTAINER_SCRIPT_VERSION}"
>>   KAS_CONTAINER_IMAGE_DISTRO_DEFAULT=""
>>   KAS_CONTAINER_IMAGE_PATH_DEFAULT="ghcr.io/siemens/kas"
>> @@ -49,9 +49,10 @@ usage()
>>   	printf "%b" "\nPositional arguments:\n"
>>   	printf "%b" "build\t\t\tCheck out repositories and build target.\n"
>>   	printf "%b" "checkout\t\tCheck out repositories but do not build.\n"
>> +	printf "%b" "diff\t\t\tCompare two kas configurations.\n"
>>   	printf "%b" "dump\t\t\tCheck out repositories and write flat version\n"
>>   	printf "%b" "    \t\t\tof config to stdout.\n"
>> -	printf "%b" "lock\t\t\tCreate and update kas project lockfiles\n"
>> +	printf "%b" "lock\t\t\tCreate and update kas project lockfiles.\n"
>>   	printf "%b" "shell\t\t\tRun a shell in the build environment.\n"
>>   	printf "%b" "for-all-repos\t\tRun specified command in each repository.\n"
>>   	printf "%b" "clean\t\t\tClean build artifacts, keep sstate cache and " \
>> @@ -61,20 +62,19 @@ usage()
>>   	printf "%b" "cleanall\t\tClean build artifacts, sstate cache and " \
>>   		    "downloads.\n"
>>   	printf "%b" "purge\t\t\tRemove all data managed by kas. Run with '--dry-run'\n"
>> -	printf "%b" "     \t\t\tto check what would be removed\n"
>> +	printf "%b" "     \t\t\tto check what would be removed.\n"
>>   	printf "%b" "menu\t\t\tProvide configuration menu and trigger " \
>>   		    "configured build.\n"
>>   	printf "%b" "\nOptional arguments:\n"
>> -	printf "%b" "--isar\t\t\tUse kas-isar container to build Isar image. To force\n"
>> -	printf "%b" "      \t\t\tthe use of run0 over sudo, set KAS_SUDO_CMD=run0.\n"
>> -	printf "%b" "--with-loop-dev		Pass a loop device to the " \
>> -		    "container. Only required if\n"
>> -	printf "%b" "\t\t\tloop-mounting is used by recipes.\n"
>> +	printf "%b" "--isar-privileged\tRun an Isar build in privileged mode. " \
>> +	            "To force the use\n"
>> +	printf "%b" "\t\t\tof run0 over sudo, set KAS_SUDO_CMD=run0.\n"
>> +	printf "%b" "--isar-rootless\t\tRun an Isar build in rootless mode.\n"
>>   	printf "%b" "--runtime-args\t\tAdditional arguments to pass to the " \
>> -			"container runtime\n"
>> +			"container runtime.\n"
>>   	printf "%b" "\t\t\tfor running the build.\n"
>>   	printf "%b" "-l, --log-level\t\tSet log level (default=info).\n"
>> -	printf "%b" "--version\t\tprint program version.\n"
>> +	printf "%b" "--version\t\tPrint program version.\n"
>>   	printf "%b" "--ssh-dir\t\tDirectory containing SSH configurations.\n"
>>   	printf "%b" "\t\t\tAvoid \$HOME/.ssh unless you fully trust the " \
>>   		    "container.\n"
>> @@ -83,13 +83,15 @@ usage()
>>   	printf "%b" "\t\t\tAvoid \$HOME/.aws unless you fully trust the " \
>>   		    "container.\n"
>>   	printf "%b" "--git-credential-store\tFile path to the git credential " \
>> -		    "store\n"
>> +		    "store.\n"
>> +	printf "%b" "--git-credential-socket\tPath to the git credential cache " \
>> +	       "socket.\n"
>>   	printf "%b" "--no-proxy-from-env\tDo not inherit proxy settings from " \
>>   		    "environment.\n"
>>   	printf "%b" "--repo-ro\t\tMount current repository read-only\n" \
>> -		    "\t\t\t(default for build command)\n"
>> +		    "\t\t\t(default for build command).\n"
>>   	printf "%b" "--repo-rw\t\tMount current repository writable\n" \
>> -		    "\t\t\t(default for shell command)\n"
>> +		    "\t\t\t(default for shell command).\n"
>>   	printf "%b" "-h, --help\t\tShow this help message and exit.\n"
>>   	printf "%b" "\n"
>>   	printf "%b" "You can force the use of podman over docker using " \
>> @@ -143,11 +145,6 @@ prepare_sudo_cmd()
>>   
>>   enable_isar_mode()
>>   {
>> -	if [ -n "${ISAR_MODE}" ]; then
>> -		return
>> -	fi
>> -	ISAR_MODE=1
>> -
>>   	KAS_CONTAINER_IMAGE_NAME_DEFAULT="kas-isar"
>>   	KAS_ISAR_ARGS="--privileged"
>>   
>> @@ -159,14 +156,38 @@ enable_isar_mode()
>>   		export PATH="${PATH}:/usr/sbin"
>>   	elif [ "${KAS_DOCKER_ROOTLESS}" = "1" ]; then
>>   		prepare_sudo_cmd
>> -		export DOCKER_HOST="${DOCKER_HOST:-unix:///var/run/docker.sock}"
>> -		debug "kas-isar does not support rootless docker. Using system docker"
>> +		DOCKER_HOST_DEFAULT="$(docker context inspect default --format '{{.Endpoints.docker.Host}}')"
>> +		export DOCKER_HOST="${DOCKER_HOST:-$DOCKER_HOST_DEFAULT}"
>> +		debug "kas-isar does not support rootless docker. Using system docker in $DOCKER_HOST"
>>   		# force use of well-known system docker socket
>>   		KAS_CONTAINER_COMMAND="${_KAS_SUDO_CMD} ${KAS_CONTAINER_COMMAND}"
>>   		KAS_DOCKER_ROOTLESS=0
>>   	fi
>>   }
>>   
>> +enable_isar_rootless_mode()
>> +{
>> +	KAS_CONTAINER_IMAGE_NAME_DEFAULT="kas-isar"
>> +
>> +	# Use --privileged to pass the ambient capabilities into the container.
>> +	# When calling from the user session (podman or docker-rootless), this
>> +	# is fundamentally different from the system docker run --privileged
>> +	if [ "${KAS_CONTAINER_ENGINE}" = "podman" ]; then
>> +		KAS_RUNTIME_ARGS="${KAS_RUNTIME_ARGS} --userns=keep-id --privileged"
>> +	elif [ "${KAS_DOCKER_ROOTLESS}" = "1" ]; then
>> +		KAS_ISAR_ARGS="--privileged"
>> +	else
>> +		# we don't need --privileged, but we need to run with SYS_ADMIN
>> +		# to be able to unshare.
>> +		KAS_ISAR_ARGS=" \
>> +			--security-opt seccomp=unconfined \
>> +			--security-opt apparmor=unconfined \
>> +			--security-opt systempaths=unconfined \
>> +			--cap-add=SYS_ADMIN \
>> +		"
>> +	fi
>> +}
>> +
>>   enable_oe_mode()
>>   {
>>   	if [ "${KAS_CONTAINER_ENGINE}" = "podman" ]; then
>> @@ -174,6 +195,7 @@ enable_oe_mode()
>>   		# calling "podman run" has a 1:1 mapping
>>   		KAS_RUNTIME_ARGS="${KAS_RUNTIME_ARGS} --userns=keep-id"
>>   	fi
>> +	BUILD_SYSTEM="openembedded"
>>   }
>>   
>>   enable_unpriv_userns_docker()
>> @@ -210,6 +232,20 @@ check_and_expand()
>>   	realpath -e "$_varval"
>>   }
>>   
>> +# SC2034: DIR appears unused (ignore, as they are used inside eval)
>> +# shellcheck disable=2034
>> +setup_kas_dirs()
>> +{
>> +	KAS_WORK_DIR="${KAS_WORK_DIR:-$(pwd)}"
>> +	KAS_WORK_DIR="$(check_and_expand KAS_WORK_DIR required)"
>> +	KAS_BUILD_DIR="$(check_and_expand KAS_BUILD_DIR create)"
>> +	KAS_REPO_REF_DIR="$(check_and_expand KAS_REPO_REF_DIR required)"
>> +	DL_DIR="$(check_and_expand DL_DIR createrec)"
>> +	SSTATE_DIR="$(check_and_expand SSTATE_DIR createrec)"
>> +	BB_HASHSERVE_DB_DIR="$(check_and_expand BB_HASHSERVE_DB_DIR createrec)"
>> +	KAS_BUILDTOOLS_DIR="$(check_and_expand KAS_BUILDTOOLS_DIR createrec)"
>> +}
>> +
>>   # Params: FILE
>>   # Returns: root repo dir of file
>>   repo_path_of_file()
>> @@ -260,14 +296,6 @@ forward_dir()
>>   	fi
>>   }
>>   
>> -check_docker_rootless()
>> -{
>> -	KAS_DOCKER_ROOTLESS=0
>> -	if [ "$(docker context show)" = "rootless" ]; then
>> -		KAS_DOCKER_ROOTLESS=1
>> -	fi
>> -}
>> -
>>   enable_docker_rootless()
>>   {
>>   	warning "Rootless docker used, only limited functionality available."
>> @@ -281,122 +309,48 @@ enable_docker_rootless()
>>   	KAS_RUNTIME_ARGS="${KAS_RUNTIME_ARGS} -e KAS_DOCKER_ROOTLESS=1"
>>   }
>>   
>> -KAS_GIT_OVERLAY_FILE=""
>> -kas_container_cleanup()
>> -{
>> -	if [ -f "${KAS_GIT_OVERLAY_FILE}" ]; then
>> -		trace rm -f "${KAS_GIT_OVERLAY_FILE}"
>> -	fi
>> -}
>> -trap kas_container_cleanup EXIT INT TERM
>> -
>>   set_container_image_var()
>>   {
>> +	# if the image is explicitly set, use that
>> +	if [ -n "${KAS_CONTAINER_IMAGE}" ]; then
>> +		return
>> +	fi
>>   	KAS_IMAGE_VERSION="${KAS_IMAGE_VERSION:-${KAS_IMAGE_VERSION_DEFAULT}}"
>>   	KAS_CONTAINER_IMAGE_DISTRO="${KAS_CONTAINER_IMAGE_DISTRO:-${KAS_CONTAINER_IMAGE_DISTRO_DEFAULT}}"
>>   	KAS_CONTAINER_IMAGE_NAME="${KAS_CONTAINER_IMAGE_NAME:-${KAS_CONTAINER_IMAGE_NAME_DEFAULT}}"
>>   	KAS_CONTAINER_IMAGE_PATH="${KAS_CONTAINER_IMAGE_PATH:-${KAS_CONTAINER_IMAGE_PATH_DEFAULT}}"
>> -	KAS_CONTAINER_IMAGE_DEFAULT="${KAS_CONTAINER_IMAGE_PATH}/${KAS_CONTAINER_IMAGE_NAME}:${KAS_IMAGE_VERSION}"
>> -	KAS_CONTAINER_IMAGE="${KAS_CONTAINER_IMAGE:-${KAS_CONTAINER_IMAGE_DEFAULT}}"
>> +	KAS_CONTAINER_IMAGE="${KAS_CONTAINER_IMAGE_PATH}/${KAS_CONTAINER_IMAGE_NAME}:${KAS_IMAGE_VERSION}"
>>   	if [ -n "${KAS_CONTAINER_IMAGE_DISTRO}" ]; then
>>   		KAS_CONTAINER_IMAGE="${KAS_CONTAINER_IMAGE}-${KAS_CONTAINER_IMAGE_DISTRO}"
>>   	fi
>>   }
>>   
>> -# SC2034: DIR appears unused (ignore, as they are used inside eval)
>> -# shellcheck disable=2034
>> -setup_kas_dirs()
>> -{
>> -	KAS_WORK_DIR="${KAS_WORK_DIR:-$(pwd)}"
>> -	KAS_WORK_DIR="$(check_and_expand KAS_WORK_DIR required)"
>> -	KAS_BUILD_DIR="$(check_and_expand KAS_BUILD_DIR create)"
>> -	KAS_REPO_REF_DIR="$(check_and_expand KAS_REPO_REF_DIR required)"
>> -	DL_DIR="$(check_and_expand DL_DIR createrec)"
>> -	SSTATE_DIR="$(check_and_expand SSTATE_DIR createrec)"
>> -	KAS_BUILDTOOLS_DIR="$(check_and_expand KAS_BUILDTOOLS_DIR createrec)"
>> -}
>> -setup_kas_dirs
>> -
>> -KAS_CONTAINER_ENGINE="${KAS_CONTAINER_ENGINE:-${KAS_DOCKER_ENGINE}}"
>> -if [ -z "${KAS_CONTAINER_ENGINE}" ]; then
>> -	# Try to auto-detect a container engine
>> -	if command -v docker >/dev/null; then
>> -		case $(docker -v 2>/dev/null) in
>> -		podman*)
>> -			# The docker command is an alias for podman
>> -			KAS_CONTAINER_ENGINE=podman
>> -			;;
>> -		Docker*)
>> -			# The docker command is the real docker
>> -			KAS_CONTAINER_ENGINE=docker
>> -			;;
>> -		*)
>> -			# The docker command is an unknown engine
>> -			fatal_error "docker command found, but unknown engine detected"
>> -		esac
>> -	elif command -v podman >/dev/null; then
>> -		KAS_CONTAINER_ENGINE=podman
>> -	else
>> -		fatal_error "no container engine found, need docker or podman"
>> -	fi
>> -fi
>> -
>> -KAS_RUNTIME_ARGS="--log-driver=none --user=root"
>> -
>> -case "${KAS_CONTAINER_ENGINE}" in
>> -docker)
>> -	KAS_CONTAINER_COMMAND="docker"
>> -	enable_unpriv_userns_docker
>> -	check_docker_rootless
>> -	;;
>> -podman)
>> -	KAS_CONTAINER_COMMAND="podman"
>> -	KAS_RUNTIME_ARGS="${KAS_RUNTIME_ARGS} --security-opt label=disable"
>> -	;;
>> -*)
>> -	fatal_error "unknown container engine '${KAS_CONTAINER_ENGINE}'"
>> -	;;
>> -esac
>> -
>> -# parse kas-container options
>> +# parse kas-container options, leave build system empty to distinguish between
>> +# explicitly set via flag and implicitly via config.
>> +BUILD_SYSTEM=""
>> +KAS_OPTIONS_DIRECT=""
>> +KAS_EXTRA_RUNTIME_ARGS=""
>>   while [ $# -gt 0 ]; do
>>   	case "$1" in
>> -	--isar)
>> -		enable_isar_mode
>> +	--isar | --isar-privileged)
>> +		if [ "$1" = "--isar" ]; then
>> +			warning "The semantic of '--isar' might change in the" \
>> +				"future. Please use '--isar-privileged' instead."
>> +		fi
>> +		BUILD_SYSTEM="isar-privileged"
>>   		shift 1
>>   		;;
>> -	--with-loop-dev)
>> -		if ! KAS_LOOP_DEV=$(/sbin/losetup -f 2>/dev/null); then
>> -			if [ "$(id -u)" -eq 0 ]; then
>> -				fatal_error "loop device not available!"
>> -			fi
>> -			prepare_sudo_cmd
>> -			if ! [ "$KAS_SUDO_CMD" = "sudo" ]; then
>> -				fatal_error '--with-loop-dev requires sudo for device setup.'
>> -			fi
>> -			sudo_command="/sbin/losetup -f"
>> -			sudo_message="[sudo] enter password to setup loop"
>> -			sudo_message="$sudo_message devices by calling"
>> -			sudo_message="$sudo_message '$sudo_command': "
>> -			# SC2086: Double quote to prevent globbing and word splitting.
>> -			# shellcheck disable=2086
>> -			if ! KAS_LOOP_DEV=$(sudo -p "$sudo_message" $sudo_command \
>> -				2>/dev/null); then
>> -				fatal_error "loop device setup unsuccessful!" \
>> -				            "try calling '$sudo_command' with root" \
>> -				            "permissions manually."
>> -			fi
>> -		fi
>> -		KAS_WITH_LOOP_DEV="--device ${KAS_LOOP_DEV}"
>> +	--isar-rootless)
>> +		BUILD_SYSTEM="isar-rootless"
>>   		shift 1
>>   		;;
>> -	--runtime-args|--docker-args)
>> -		[ $# -gt 0 ] || usage
>> -		KAS_RUNTIME_ARGS="${KAS_RUNTIME_ARGS} $2"
>> +	--runtime-args | --docker-args)
>> +		[ $# -gt 1 ] || usage
>> +		KAS_EXTRA_RUNTIME_ARGS="${KAS_EXTRA_RUNTIME_ARGS} $2"
>>   		shift 2
>>   		;;
>>   	--ssh-dir)
>> -		[ $# -gt 2 ] || usage
>> +		[ $# -gt 1 ] || usage
>>   		KAS_SSH_DIR="$2"
>>   		shift 2
>>   		;;
>> @@ -408,15 +362,22 @@ while [ $# -gt 0 ]; do
>>   		shift 1
>>   		;;
>>   	--aws-dir)
>> -		[ $# -gt 2 ] || usage
>> +		[ $# -gt 1 ] || usage
>>   		KAS_AWS_DIR="$2"
>>   		shift 2
>>   		;;
>>   	--git-credential-store)
>> -		[ $# -gt 2 ] || usage
>> +		[ $# -gt 1 ] || usage
>>   		KAS_GIT_CREDENTIAL_STORE="$2"
>>   		shift 2
>>   		;;
>> +
>> +	--git-credential-socket)
>> +		[ $# -gt 1 ] || usage
>> +		KAS_GIT_CREDENTIAL_SOCKET="$2"
>> +		shift 2
>> +		;;
>> +
>>   	--no-proxy-from-env)
>>   		KAS_NO_PROXY_FROM_ENV=1
>>   		shift 1
>> @@ -446,19 +407,19 @@ while [ $# -gt 0 ]; do
>>   	--*)
>>   		usage
>>   		;;
>> -	clean|cleansstate|cleanall|purge)
>> +	clean | cleansstate | cleanall | purge)
>>   		KAS_REPO_MOUNT_OPT_DEFAULT="ro"
>>   		KAS_CMD=$1
>>   		shift 1
>>   		break
>>   		;;
>> -	shell|lock)
>> +	shell | lock)
>>   		KAS_REPO_MOUNT_OPT_DEFAULT="rw"
>>   		KAS_CMD=$1
>>   		shift 1
>>   		break
>>   		;;
>> -	build|checkout|for-all-repos|menu)
>> +	build | checkout | for-all-repos | menu)
>>   		KAS_REPO_MOUNT_OPT_DEFAULT="ro"
>>   		KAS_CMD=$1
>>   		shift 1
>> @@ -486,6 +447,10 @@ while [ $# -gt 0 ]; do
>>   	esac
>>   done
>>   
>> +KAS_RUNTIME_ARGS="--log-driver=none --user=root"
>> +
>> +setup_kas_dirs
>> +
>>   [ -n "${KAS_CMD}" ] || usage
>>   
>>   KAS_EXTRA_BITBAKE_ARGS=0
>> @@ -494,17 +459,17 @@ KAS_FILES=
>>   # parse kas sub-command options
>>   while [ $# -gt 0 ] && [ $KAS_EXTRA_BITBAKE_ARGS -eq 0 ]; do
>>   	case "$1" in
>> -	--format|--indent|--provenance|--skip|--target|--task)
>> +	--format | --indent | --provenance | --skip | --target | --task)
>>   		KAS_OPTIONS="${KAS_OPTIONS} $1 $2"
>>   		shift 1
>>   		shift 1 || KAS_OPTIONS="--help"
>>   		;;
>> -	-c|--cmd|--command)
>> +	-c | --cmd | --command)
>>   		KAS_BITBAKE_C_OPTION_ARGS="$2"
>>   		shift 1
>>   		shift 1 || KAS_OPTIONS="--help"
>>   		;;
>> -	-E|--preserve-env)
>> +	-E | --preserve-env)
>>   		fatal_error "$1 is not supported with ${KAS_CONTAINER_SELF_NAME}"
>>   		;;
>>   	--)
>> @@ -563,10 +528,10 @@ if [ "${KAS_CMD}" = "menu" ]; then
>>   	if [ "$(echo "${KAS_FIRST_FILES}" | wc -w)" -ne "1" ]; then
>>   		fatal_error "menu plugin only supports a single Kconfig file"
>>   	fi
>> -	BUILD_SYSTEM=$(tr '\n' '\f' 2>/dev/null < "${KAS_FIRST_FILES}" | \
>> +	BUILD_SYSTEM=${BUILD_SYSTEM:-$(tr '\n' '\f' 2>/dev/null < "${KAS_FIRST_FILES}" |
>>   		sed -e 's/\(.*\fconfig KAS_BUILD_SYSTEM\f\(.*\)\|.*\)/\2/' \
>>   		    -e 's/\f\([[:alpha:]].*\|$\)//' \
>> -		    -e 's/.*default \"\(.*\)\".*/\1/')
>> +		    -e 's/.*default \"\(.*\)\".*/\1/')}
>>   else
>>   	if [ -z "${KAS_FIRST_FILES}" ]; then
>>   		KAS_FIRST_FILES="${KAS_WORK_DIR}/.config.yaml"
>> @@ -574,20 +539,60 @@ else
>>   
>>   	# We only get the first build system and let kas check if mixed
>>   	_KAS_FIRST_FILE=$(echo "${KAS_FIRST_FILES}" | awk '{print $1}')
>> -	BUILD_SYSTEM=$(grep -e "^build_system: " "${_KAS_FIRST_FILE}" 2>/dev/null | \
>> -		sed 's/build_system:[ ]\+//')
>> +	BUILD_SYSTEM=${BUILD_SYSTEM:-$(grep -e "^build_system: " "${_KAS_FIRST_FILE}" 2>/dev/null |
>> +		sed 's/build_system:[ ]\+//')}
>>   fi
>>   
>> -if [ "${BUILD_SYSTEM}" = "isar" ]; then
>> +KAS_CONTAINER_ENGINE="${KAS_CONTAINER_ENGINE:-${KAS_DOCKER_ENGINE}}"
>> +if [ -z "${KAS_CONTAINER_ENGINE}" ]; then
>> +	# Try to auto-detect a container engine
>> +	# Defaults if there are multiple options:
>> +	# podman if build system is isar-rootless, docker otherwise
>> +	if [ "${BUILD_SYSTEM}" = "isar-rootless" ] && command -v podman >/dev/null 2>&1; then
>> +		KAS_CONTAINER_ENGINE=podman
>> +	elif command -v docker >/dev/null 2>&1 && docker -v 2>/dev/null | grep -q '^Docker'; then
>> +		KAS_CONTAINER_ENGINE=docker
>> +	elif command -v podman >/dev/null 2>&1; then
>> +		KAS_CONTAINER_ENGINE=podman
>> +	else
>> +		fatal_error "no container engine found, need docker or podman"
>> +	fi
>> +fi
>> +
>> +KAS_DOCKER_ROOTLESS=0
>> +case "${KAS_CONTAINER_ENGINE}" in
>> +docker)
>> +	KAS_CONTAINER_COMMAND="docker"
>> +	enable_unpriv_userns_docker
>> +	if [ "$(docker context show)" = "rootless" ]; then
>> +		KAS_DOCKER_ROOTLESS=1
>> +	fi
>> +	;;
>> +podman)
>> +	KAS_CONTAINER_COMMAND="podman"
>> +	KAS_RUNTIME_ARGS="${KAS_RUNTIME_ARGS} --security-opt label=disable"
>> +	;;
>> +*)
>> +	fatal_error "unknown container engine '${KAS_CONTAINER_ENGINE}'"
>> +	;;
>> +esac
>> +
>> +if [ "${BUILD_SYSTEM}" = "isar" ] || [ "${BUILD_SYSTEM}" = "isar-privileged" ]; then
>>   	enable_isar_mode
>> -elif [ -z "${ISAR_MODE}" ]; then
>> +elif [ "${BUILD_SYSTEM}" = "isar-rootless" ]; then
>> +	enable_isar_rootless_mode
>> +else
>>   	enable_oe_mode
>>   fi
>>   
>>   # clean can be executed without config, hence manually forward the build system
>> -if [ "${ISAR_MODE}" = "1" ] && echo "${KAS_CMD}" | grep -qe "^clean\|purge"; then
>> -	KAS_OPTIONS="${KAS_OPTIONS} --isar"
>> -fi
>> +case "${BUILD_SYSTEM}" in
>> +isar*)
>> +	if echo "${KAS_CMD}" | grep -qe "^clean\|purge"; then
>> +		KAS_OPTIONS="${KAS_OPTIONS} --${BUILD_SYSTEM}"
>> +	fi
>> +	;;
>> +esac
>>   
>>   set_container_image_var
>>   
>> @@ -628,10 +633,21 @@ forward_dir KAS_BUILD_DIR "/build" "rw"
>>   forward_dir DL_DIR "/downloads" "rw"
>>   forward_dir KAS_REPO_REF_DIR "/repo-ref" "rw"
>>   forward_dir SSTATE_DIR "/sstate" "rw"
>> +forward_dir BB_HASHSERVE_DB_DIR "/bb-hashserve-db" "rw"
>>   forward_dir KAS_BUILDTOOLS_DIR "/buildtools" "rw"
>>   
>>   if git_com_dir=$(git -C "${KAS_REPO_DIR}" rev-parse --git-common-dir 2>/dev/null) \
>>   	&& [ "$git_com_dir" != "$(git -C "${KAS_REPO_DIR}" rev-parse --git-dir)" ]; then
>> +
>> +	KAS_GIT_OVERLAY_FILE=""
>> +	kas_container_cleanup()
>> +	{
>> +		if [ -f "${KAS_GIT_OVERLAY_FILE}" ]; then
>> +			trace rm -f "${KAS_GIT_OVERLAY_FILE}"
>> +		fi
>> +	}
>> +	trap kas_container_cleanup EXIT INT TERM
>> +
>>   	# If (it's a git repo) and the common dir isn't the git-dir, it is shared worktree and
>>   	# we have to mount the common dir in the container to make git work
>>   	# The mount path inside the container is different from the host path. Hence, we over-mount
>> @@ -685,6 +701,14 @@ if [ -n "${KAS_GIT_CREDENTIAL_STORE}" ] ; then
>>   	set -- "$@" -v "$(realpath -e "${KAS_GIT_CREDENTIAL_STORE}")":/var/kas/userdata/.git-credentials:ro
>>   fi
>>   
>> +if [ -n "${KAS_GIT_CREDENTIAL_SOCKET}" ] ; then
>> +	if [ ! -S "${KAS_GIT_CREDENTIAL_SOCKET}" ]; then
>> +		fatal_error "passed KAS_GIT_CREDENTIAL_SOCKET '${KAS_GIT_CREDENTIAL_SOCKET}' is not a socket"
>> +	fi
>> +	KAS_GIT_CREDENTIAL_HELPER_DEFAULT="cache --socket=/var/kas/userdata/.git-cache-socket"
>> +	set -- "$@" -v "$(realpath -e "${KAS_GIT_CREDENTIAL_SOCKET}")":/var/kas/userdata/.git-cache-socket
>> +fi
>> +
>>   GIT_CREDENTIAL_HELPER="${GIT_CREDENTIAL_HELPER:-${KAS_GIT_CREDENTIAL_HELPER_DEFAULT}}"
>>   
>>   if [ -n "${GIT_CREDENTIAL_HELPER}" ] ; then
>> @@ -731,6 +755,7 @@ fi
>>   for var in TERM KAS_DISTRO KAS_MACHINE KAS_TARGET KAS_TASK KAS_CLONE_DEPTH \
>>              KAS_PREMIRRORS DISTRO_APT_PREMIRRORS BB_NUMBER_THREADS PARALLEL_MAKE \
>>              GIT_CREDENTIAL_USEHTTPPATH \
>> +           BB_HASHSERVE BB_HASHSERVE_UPSTREAM \
>>              TZ; do
>>   	if [ -n "$(eval echo \$${var})" ]; then
>>   		set -- "$@" -e "${var}=$(eval echo \"\$${var}\")"
>> @@ -739,7 +764,7 @@ done
>>   
>>   # propagate only supported SHELL settings
>>   case "$SHELL" in
>> -/bin/sh|/bin/bash|/bin/dash)
>> +/bin/sh | /bin/bash | /bin/dash)
>>   	set -- "$@" -e "SHELL=$SHELL"
>>   	;;
>>   *)
>> @@ -757,7 +782,7 @@ fi
>>   
>>   # SC2086: Double quote to prevent globbing and word splitting.
>>   # shellcheck disable=2086
>> -set -- "$@" ${KAS_ISAR_ARGS} ${KAS_WITH_LOOP_DEV} ${KAS_RUNTIME_ARGS} \
>> +set -- "$@" ${KAS_ISAR_ARGS} ${KAS_RUNTIME_ARGS} ${KAS_EXTRA_RUNTIME_ARGS} \
>>       ${KAS_CONTAINER_IMAGE} ${KAS_OPTIONS_DIRECT} ${KAS_CMD} ${KAS_OPTIONS}
>>   if [ -n "${KAS_BITBAKE_C_OPTION_ARGS}" ]; then
>>   	set -- "$@" -c "${KAS_BITBAKE_C_OPTION_ARGS}"
> 
> This is not kas-container from the 5.4 release.

Uups that was from next - will fix in v2.

Quirin
> 
> Jan
> 


