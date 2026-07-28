Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF8EC54F4C
	for <webhook@archiver.kernel.org>; Tue, 28 Jul 2026 15:32:53 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.11])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14061.1785252772508939555
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Jul 2026 08:32:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=saIMU4u/;
 spf=pass (domain: siemens.com, ip: 40.107.162.11, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L31ymRNAxWt9vG2Gy7jszsoz5rtRy6h0/DWs76FeRUNGdZpiaOk03WjmZeXQK8xfk6l2e2a+/tDrNF/dV4gFqwbhnt3MphRUaom49ooI+u1UCSwerMp80fR40Cb/Pl+dBSeEYJYcOKjxJxFx2Dmsjawgm4NXXGyww6xTvzm6EcsnVNKpPBZioMHim+H1ZzB+kdQ870tD3irtgD4iUCwvcp5Rjihpg1zjl828G3wfDqNmfImeuo3IVInFIRV35Dvt/N+kCFjQwI6mq8xqNwoptyGjVOP5HIBi07A9OxPHx6IX7WPBtYHjJ1xkx0KDuosNiW2hHfjcyew2sPXUsOUfMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGEI8uZcRzqdPxRfTxvi6s1vG6A0YCPwQ9rmeRBTyIc=;
 b=V7rTL4qzPtSHHdFY4yW8LKtbFi+xeutFCbmt23Qu1OWJktcVgGl4EON+BO7sgbB7CsRFOUTF4RvSN0lCc37VJaG9xj81/kCuN+1x1yXSFSG6anguEXJcDwVApQezWrXO0+aU03o3IKQkJVjuUI9HSmBmJoePQjfm4PNeVRCKas8ZR2jbbP80tFj/T2kjUDDwcBIi587BLitbGlVn8JJ3fnmPQT8M/8K9n498zzKKghZdkZ6zaQJpF9q+6oHiZj/Dznh+fkpjy5x1ckndOlck1XF24jjPYyP435V1OhwByxz4iar7NSDEMcy9AindEadZorFKyimwZg30u9BOlDeOcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGEI8uZcRzqdPxRfTxvi6s1vG6A0YCPwQ9rmeRBTyIc=;
 b=saIMU4u/8xoIamtwy18lNyKGGzieEpr3Mb6LGTPh6YRj3grLitP2aneOwePRcPdFT+iiVHOct6vhQguYDuWLqvBgubrvJYCbzxu8SZcrU0YNlSFqkf6o++w8ggkJtQC7/nbgf1TX/fNUREiXFVOtah3CxKSwSLCQjHf/gQnAOJBn/lsMTX7k5sahx5d8KxcAZy1OF0GfJL5ElUzbRrxUHE0dMzK5zpJ6NOWgD8z7NQzRqLYD6xnKkqiXifX3WyrBb4AYzBY1h4c3szfEVpzpDQBeakrht+e2W3FwUTw70udufht+5akxjE9zxJgOIcPPf/jtV4NzcF/2lK6TmlTMsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by DB9PR10MB6403.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 15:32:48 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%5]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 15:32:48 +0000
Message-ID: <b88cc355-446e-4190-9b82-b74bcd2b747f@siemens.com>
Date: Tue, 28 Jul 2026 17:32:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 5/5] update README.md for
 rootless build
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org,
 felix.moessbauer@siemens.com
References: <20260728131231.117214-1-quirin.gylstorff@siemens.com>
 <20260728131231.117214-6-quirin.gylstorff@siemens.com>
 <a4b6fda7-15ee-4351-9714-d700cc171504@siemens.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <a4b6fda7-15ee-4351-9714-d700cc171504@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0096.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::8) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|DB9PR10MB6403:EE_
X-MS-Office365-Filtering-Correlation-Id: d8faf58a-64a6-4e12-b14d-08deecbd7a9c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|6133799003|56012099006|11063799006|4143699003|10067099003|22082099003|55112099003|18002099003|20052099010;
X-Microsoft-Antispam-Message-Info: 
	jRrOhBFI1sg5LWEkqDBZgCFUpoZUE7Byx5yIhZfst+1q178hxxNTm6wDTNWQhawDF3ae+kV/D8mPUOXvN03KHjct7x996xLMfRPZO0Wqvgle0vpdITLUueTtcFMixdlbGfLzlEob9Lox8YaZIlUI/EMlg24+ten0NEOqVEAV1OMUP5Mnyh8tm4kEF84LD1vUBFIQBfZub6L00m89T/UqLUeRtVGq/7jx1pQYBX2Qt4+x4Ix9T1x9i/PTb3esRq7HhCzMkev8U85S+MyBnAnsgs/Vva7j9dL7Q0SZbExUJj2Zt9JLqOQ0pMxR7lvSDUoDmsuOZkim/5dgB4fBGJbGeN7b8HBXwKs1KrRxeHPMh+D8QKRlS2sZ/ZLn61GGHajKYwQAbg2nxc9L+Fm7arKqHsJyN8wZH7WEzasSqq+5w3onhWhrm9SfrUbKb+CmANKvj63XWXvkPAduq3zWqpptwevNi16uhMFdnmwC1gg2COvH3LZGtIRMup688Z0GFt3Py3ozbGN7sInVE3/cIERH9QcbdB2rUF4wqd8K4ZP0UdqyiCOrWxERxUa58XBxwBabZ8+5aOGEF8uqqbE6CFxrO65FLJ+s1x5JczSuU6RADq0culwz+rYlwmjAXqRQKzHlfEEAyeTTbPwGDk+6jLcNLQLsRdLgD7Q6NsczfTzxneY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(6133799003)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(55112099003)(18002099003)(20052099010);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MnB5djBrMnpLM1JFbStoV3BzaFh5VWlKUktZNWozV2Rjc1hNZVZGd0I2ajMw?=
 =?utf-8?B?bFIvbm9MOW1nSHM5OU5DWGtIbGg2ZXhwSTY4TWdYQ2c4Zmppc0Y5SkpZSWhs?=
 =?utf-8?B?N2NVZEk1Sm1yaDJkTFBHYk9iOGZkTkVPRW1UZGEvcXZGbEpwUzh4MGprd29q?=
 =?utf-8?B?OGoxUlZQS3lUK2hXMmFVTjZnYi92YytwUTlkbWc3azJ0RDE3bkdQUmFCWEdp?=
 =?utf-8?B?RzB4TTl2QzFtU2creE1TaWNvNE56aXhMYUNRY05NR0ZJOG1mb2l2OThKL0VE?=
 =?utf-8?B?WENJS2R1cnM3NE9hNXFLQlM4b21IUENhWUFFVDJEQk8xdHRYanlSTnUxakJm?=
 =?utf-8?B?R3BsYWpiMjV0ejV0UE1LVU8vVUVOQkJURVhheElFM3M4NVQ4ZVlOYndvMDBB?=
 =?utf-8?B?ZFhSdS9jTlRlQXZLWUh1c3VhdlprTm5iNzhsMWV4TGFLTFA5cUdGV1VFVGRD?=
 =?utf-8?B?QndSMGxEUG9mQlV6dUtobVBERXo4ZlFkQitlSWY1NjRtYnJNNzZOVzFpYnQw?=
 =?utf-8?B?aXFveWFzcWN5NGp6dGFZZXVtNG1DcEJ1UXo3cWlkb09FZVI3eGh4QWNtR1B0?=
 =?utf-8?B?U3VQYWtybU1uOGFJeWtEL2MyZ25kejB0ZDhDNmRqYXJ6Rm1HdkFDQzBIYmVa?=
 =?utf-8?B?Mm1jTFBpd2ZieGpSS1ptVkZvK28ySUhWZUFzY2UzZHp5NTZZWmk5cndTTUZO?=
 =?utf-8?B?MFFSTzl2ZjQ1VTlhYUlTYmZNOFZvMFIxTTVPUU1oU21TR3paMGIxd0daTExU?=
 =?utf-8?B?VGh1bS9DaG1XSCtKa2F1UHJDQzlPaGJST0FsTVo1YThwMjNrcTVKSXhVM1ow?=
 =?utf-8?B?dGI1aWlBTW5zeVBYZnhWN3hZbldLY2drS0M3UFpvY3BsK2JYdzVaYkprKzNE?=
 =?utf-8?B?b1EveVA1M1Q1ZnNEcVN3MXJWbDJSY1Axa0J4Qjh4Y2ord1pqMTU0SHJTNkJL?=
 =?utf-8?B?QXBDK2FmMVl4Z1RTbS9ReUJZdGdMWGtqc2VkVm84Wkw2VW53Sk5Pa1kxTFFM?=
 =?utf-8?B?b1FRSHhrZXk3dGVSSlRUbDJsUDkrTlk3UnlZYmYyOU5TSDBZRHdkUTZBOTVv?=
 =?utf-8?B?UFppWjc1WFJFbU5IYXlSS3dwOUhpM29ybUlKdktzYnpLZXhEVFB0Vlh4MERZ?=
 =?utf-8?B?SlM4bHZTOFgvM3dndysxMmJ4QWx5eHAxVzdSVVM0UnphdGkxbzFSOXZrTm9M?=
 =?utf-8?B?bks5alZkUVk0TTAzWmpURzc2VWh6MzJxVkJOaVp4OVJHTk8zVEQ5YjhGOWFh?=
 =?utf-8?B?ZC9iZnROUGh1NkgvcTllM0lRc0s3Y0VZOTBpYjVSRm5xQmY3YUlrSTZIc3hG?=
 =?utf-8?B?djA3ai80UU56ejlZMXlFZWNMVHhnOXZFdjVFRUxETXlLZWh5QnZJSHBwVTg1?=
 =?utf-8?B?VEhqU2ZoajNhQ0dGZTdQNkZyeVMxWDA4OE5YNUhxdmtlWEh3eGFGcmYwL0Vp?=
 =?utf-8?B?b2hxclI3dUdtdTlHNXJuWWlzQUE5NHdSdDN0NDUxODBpa3hEMmhFNVlsQXlk?=
 =?utf-8?B?ZWVSaDIwT2lHMEpwUjJmTW9vSFU5RE45eG5qeFVaVGd1bVZJZ3JmM1ZtdGRj?=
 =?utf-8?B?UHg2Qi9qbkxFM2tiR2lyQ1JERSt6MU1vRWhuZDIyV3F3UitzR1pDSDVoRVpP?=
 =?utf-8?B?NTN5Um0yaS9ZSncrZVpBS1hPS0E5d0ZzQXBadS9GL0x6ZmxCbFZscVJFMGpi?=
 =?utf-8?B?ZHA1a0toUEZVZCtvOXE0WHp1SGlJQ0pHZExLYTgycENreGh4aXdXa29LeHBK?=
 =?utf-8?B?Ykg4Q29oZjBWdDlOM0NBUTNzYWNyaWdFN3NZdFNIZ3ErT05UVHdETUVveGpE?=
 =?utf-8?B?LzFSZzBseWRJbEZlQkVPRXV2OVd4MWd3b2cram9pUElpTGk0bnZwNXJ1Skph?=
 =?utf-8?B?MnVCa2JndGx2WnpzUHk4TklLRzhxZzYzR1JvdXhHRithQ3Z0dUdDU0dIclBY?=
 =?utf-8?B?TG14c0ZDeER2aHBkWExjdiswQzhnUGtiMWJPNk5pVm54eXgvamVqTTJIV3RZ?=
 =?utf-8?B?RHNyRnphSEd0VldndytXQzNBMjZ3MEk3N1NlM0JKV2hHVm5Vc1g3aTR0QXFm?=
 =?utf-8?B?c0I0MWtHWHhRQmJERzJRd3RzUCt4WUZxMFh2T1oxNUJ5ZUFKUlRPNW5WbHZR?=
 =?utf-8?B?UlhhU1FjSVdweDVPNUR6VXJDeTJzVlhJVERLUjZ4dXh6aHhlaHl4UEtMVCtu?=
 =?utf-8?B?dWdxL21JK1V1S0FaeTQ3cm1SMURJWWlwUzJ4cmhMN3Z2ak5OenRZbTlTVlVo?=
 =?utf-8?B?em1pdVc1RlBNZ3NKNWoyZWszSEVNbTVOdzZURTFkeUtWMDU2NDRldWRWTEYz?=
 =?utf-8?B?dk91aDcwRERoZEZvY2V0b3ZLeVlHNVdZS0JnT25xbC9yRWx0emkxSHA0cFVn?=
 =?utf-8?Q?K47Gka8qT2FOIm+0=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8faf58a-64a6-4e12-b14d-08deecbd7a9c
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 15:32:48.4583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ScM7/JsDr8q048eRyj+YFnLX9JznuMEMp1uKjc6NGw1N/PAqkt2iEYBD+cgZdtVABfzsZqSGGSRxXZK/tAWAHNSUt0+oh7DIB+FmAxbJRjo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6403
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Jul 2026 15:32:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23805



On 7/28/26 5:25 PM, Jan Kiszka wrote:
> On 28.07.26 15:12, Quirin Gylstorff wrote:
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   README.md | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/README.md b/README.md
>> index 435d037..df1564f 100644
>> --- a/README.md
>> +++ b/README.md
>> @@ -10,10 +10,10 @@ from scratch.
>>   
>>   ## Building Target Images
>>   
>> -Install docker or podman and make sure you have required permissions to start
>> -privileged containers. For docker, you need to be part of respective docker
>> -group (`sudo usermod -aG docker <USER>`). Privileged podman requires sudo
>> -rights for the caller (`<USER> ALL=(root) SETENV: /usr/bin/podman` in sudoers).
>> +Install docker or podman. For docker, you need to be part of respective docker
>> +group (`sudo usermod -aG docker <USER>`). The build requires Debian Bullseye
> 
> ...and docker will inherently remain not fully rootless (due to its
> daemon concept). Therefore, we should strongly recommend podman here.
> 
>> +(kernel version >= 5.10.1) or newer to support user namespaces for rootless builds.
> 
> We need much fresher systems, already kernel ~6.7 for binfmt_misc
> namespaces, at least when cross-building. Practically, I do not want to
> debug ANY rootless build on anything older than trixie.
> 
Proposal:
```
Install docker or podman. For docker, you need to be part of respective 
docker
group (`sudo usermod -aG docker <USER>`) as isar-cip-core uses 
isar-rootless and due
to its daemon concept docker cannot be fully rootless it is recommeneded 
to use podman. The build requires Debian Trixie (kernel version >= 6.7) 
or newer to support user and binfmt namespaces for rootless builds.
```

Quirin
> Jan
> 
>> +
>>   
>>   Open up the image configuration menu and select the desired target and its
>>   options:
> 


