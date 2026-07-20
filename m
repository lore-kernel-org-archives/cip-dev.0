Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A42C44515
	for <webhook@archiver.kernel.org>; Mon, 20 Jul 2026 08:13:52 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.61])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4395.1784535228852710417
 for <cip-dev@lists.cip-project.org>;
 Mon, 20 Jul 2026 01:13:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=O8ZGVjmZ;
 spf=pass (domain: siemens.com, ip: 52.101.72.61, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ohz0t9Ri+x012qmIo28rTxK13T1gG+N6Wd93mRhXqu2kY37wyxY4a1OxQw91bRe+rgo6Y8vAGWpZroL1Uof4DEuTV1srMYL3+lVF28XamNOPT7Cyg60jMzKYy5WlaxHBWB7owxQE5JJxnRE76w0nN+qnT4UvINnhvYSGju6+EYgPmKSyV7NRYCWxVa4/ear1tONJdx6Rb8TO811MAup2J20N4JoVvA4QmiQ4K8V4ZLgKKoNeLJM042wrCINegrhLE9vOw6aU5ixAG9bx7yOgdcjUQGNph+r4HACIn/PoYm/iRf4y9plCyR0SSpnI3dfWoVLUCu5Q5xU/3oWVSDUtGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LhE+QlqB3oqlg5gPYk7x2OojtmctE/UUVQcHLKsr2e8=;
 b=mJ4XiQ6deDSQOwg+lVJmCQ5cSM57w1rAGztgncdAwiw8uBbEciZLzfd1dwsJ5bWozGfJnzrioZDkd7/dWytWgeUgJ7Qn6rJ9DTwIbU0CYmBWYvO0oggBcg1k9Kozw7syyJ/4lFljtNByF829lf6NKR/PuW813b6Xl/6zikn/ThxEZvDQ1E3R12FflNXeUe/2J7OTqUYq7/+zDqRtEiMFTsShbb/4ohNsYiunYwQTapCJn5puTxWR6WIkjgBneevXyPTbRZSNVBH1MjYBSlQBDY28OuL25qsZdgv8RwxM1/FclIOydeRlTdTIhJPK8F3OACMPQx2/PHHazl8oMpOBSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LhE+QlqB3oqlg5gPYk7x2OojtmctE/UUVQcHLKsr2e8=;
 b=O8ZGVjmZHmDT2pPaWvYB7hYJ7x8DhImxcZoeSHObs7ThwshmrWZyKnhoGEyXbEIoMTCpsAihG7OHHN7O03lBXC/i0zKVZOUla82l0G1xudN5+QEimUKzb+quHNtmBsvmPO6gr1KU5BzHgYYHrHIVSY5UxDjssc67vraXPdcKih7DRQZOJqzUXX3IaCxtV0hJb3fXaLh0VBbzd4omZQwXClWHHTKI3F/2eOfyBIt2se07UxOi3OMuaUUIG1d8e3plw3vHmnGJWIZF5hkiC7Pc19t2W6oMyGlMDuKpt/J/dK1tzUpuxe7RCdAbvpItszLm+dZIHO3TIjWy7X84X28VaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by DU0PR10MB5631.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:319::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 08:13:36 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%5]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 08:13:34 +0000
Message-ID: <4a161528-95c2-473d-8445-fd50f64b516a@siemens.com>
Date: Mon, 20 Jul 2026 10:13:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][PATCH v1 0/2] Enable SWUpdate support
 for Debian sid
To: cip-dev@lists.cip-project.org
References: <20260720045903.733394-1-Shivanand.Kunijadar@toshiba-tsip.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <20260720045903.733394-1-Shivanand.Kunijadar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::8) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|DU0PR10MB5631:EE_
X-MS-Office365-Filtering-Correlation-Id: cb07bad8-b596-47d5-379a-08dee636caf2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|4022899009|56012099006|11063799006|10067099003|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	BG0CaqaWbs08UXAlDnlGS4GcSeOhVqph7dBzqIjXnmcoUvSLyvRkW3K+9nPulKstNNxeEz5xNfHqrjXAmjFQAkbdqfYP+LI5kWAH7PimlvLQvd8EEfI8tGcNG7ZZRI5j2vP+2+l73jE65qhwo7W2Me5sOuPWgPcOcGLvfbVge1FbScdVHvUmUQc4dJD73zve3k1/kbsf1ZVhFQ1sumowCnyJD6KVuruVj8H6ksGbUrcTD2zvl1ywFtAVo1pmJ4DcwvfKucBljdEsMb6gpdFnbyEgB0hpR02ZC7LdRCUKzggbZ7dE3Ayg5aFzCrnUdKP+lK+yEYE0jobjvgu3SjbsyzGmNu0CJtIfPUe5CwkD3uUNPwl0IlbmdHI7A5Y4FEVpgknOKFIlp19lORt7KA2pHUlwqEVspGK73lu2hI8iiHS61rkMIQ6kOD07kW3z+e/1EOvNRL0YhR8G1pMEHV7AiPL2Wp6cMfwC4g/e5jedNLpwfTEKCr5FLFX/vassPKmenIgeN6pYFhry57NKr9oH1LB0q97sPU/OpeWt8GzL46XMtGaP9pP8zJObB4FXrv2ArP2ZXRQFwQor+jd+WbpW85qGS9XpHeH+Ua/rXJf8HnuSzRxsLmXw60qLpKsBr+Vi
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(4022899009)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eW9zUHRWMEhBSWI3UUR1blZQc2lwRWVPY0kxZjVqVUNGNTQ5TXA5N3B4VmY4?=
 =?utf-8?B?QWRYRHUxcEVIRHNGcHBFSWw1YlVKTjFOUFVwb1Uya2lIRXVFelhLTGZkMHRC?=
 =?utf-8?B?ZlRDWnlqd1VNcWdNSWIrbTVjMWZEaDhiMEFhVkZvWHJKdGRMRVZEbkZadXJB?=
 =?utf-8?B?MDNkU0pibzNKbUVKWnpVcXZPYUp1VW9NUHpHREY2RXZQWnJ2eTJrcEpGeEsv?=
 =?utf-8?B?R1U4VFNQREV1RkphdTB4SE4rck51dDBVd01CZ2FtaXk3aTZRNW1CbUhmMFJP?=
 =?utf-8?B?ZUo0QXU3MUV6M1k0ak03akNXOWxEYW9HcXcvc3lXbkRsUXZkZzZNNmZ3QXNk?=
 =?utf-8?B?T1ZORW5ic0RrNks0Wk9SV0Z4Mk5qMjZDbm0vMGlFOXJsbTQ4YkJvUzh5a21a?=
 =?utf-8?B?MmVRcUd0MzA3cjBOWU5yTGs3bmVxcTVmU1hEc211RG9ZV1huVklBTWVjS3JE?=
 =?utf-8?B?NEpUUnRNZGZ6NFArMldKV3FSWjVRL2hFdzd3aGVZaC9xbFQ4RXlZN004WlYw?=
 =?utf-8?B?VkkxTUZjdUhNVkcwTG9vQ3JVTVJEUzJDd2l0RWQ3d2VLL2t2ckZXd0plTFl6?=
 =?utf-8?B?UWdQK1BiQlF1K0FJdnJzSzhNdUc1R2JXS0xmOFN1ZkV6ZFVvOWMyQjBUdzR6?=
 =?utf-8?B?UFg0SE5OMXNaaTNwN2dNZlVtaFBueXZmalBDVTBNNEtZaFU0eW1XcEVvQnk5?=
 =?utf-8?B?QmxDTkZlMGpDUGI2UXdzeUFLbWZQNnlnL0dWdlc1aDkzWm0zNzBWK2lLRE1T?=
 =?utf-8?B?emxJTnM3VXVwZTdqbE45M0JXeFhWVGNKOHVmOTZxUGh6OXB6dFVpNENSVmFK?=
 =?utf-8?B?VXZQcnVkL0Q0SlhoVTE1QVVzRDRxZlY5bFZ2Nzc4cUxkRGV0eS92azAvNFQx?=
 =?utf-8?B?LzZiZ2MxSmpIbVhFNGFlRHl1ckJhM1BjdW1pU0wvN1hzSHBRN2c5a1hVeGtB?=
 =?utf-8?B?SHdTUlY4WU8wUWNZQS80QnNTSzlZcW9hSHdRUjNUSzkzSkYrc2ttc1ZIOTMy?=
 =?utf-8?B?Y1BJT0FFVlJTUmo1d1pyQm5TUm5qMlM2THdFTVVxUWoyVU54UVRONTdId1lL?=
 =?utf-8?B?S2d2VGNqSDhoTWpPWDdKbGxkRmVwN0UwYVpvbWV6ejRYUXNzZmk1bEE3QkxG?=
 =?utf-8?B?ZTJ5Nm0yd25CSkYxVExJYWxrbFptSnRqczA1RHlCdXN5b2lrdTRHY0RPOXRw?=
 =?utf-8?B?ckdvTDA2NHE5ZFF3Z3JrN3A5ZEFBRS9GbGUyUFNPUThPRUxxUnMvQUkzaDFq?=
 =?utf-8?B?QWRmNTc1MTI0S2NaczRrZWdRS3Q5MldsVjNOL1YwQ2x0ZGZwQ3pJb09YdVJY?=
 =?utf-8?B?OGszUWxHREZUUGk2OXlsY1lJbk9PcFB4R1haYWhWU1dBK3B6Z0EzdFVMYXR0?=
 =?utf-8?B?V1dIMVVITkx3SHdkZmNYOXNFMDZ0andUVitIemRDekpRL00xUGlSY3g0aENS?=
 =?utf-8?B?V2xkRFJ4ZEFIcElGTW1JcU10N3puaUZuUU9DK1E3ZUdIVE1kZExlRXNzZDBM?=
 =?utf-8?B?SmJYTDlITklQeEE4QktJY0pCZTRhd082QlVIZUI5TlpyMXFXWjFtVnAxb2lt?=
 =?utf-8?B?ZGwzY2pCWE9XaUk0UTVGd3JJZGNQYXlZTndMdUNkc3VkTHltVmZhRTdJTitP?=
 =?utf-8?B?UUs0RnZYOHc3b3VWZ2hQdzRaRldaaG01K2xGbzZPNUpEaDNBQjVPalM0NjFu?=
 =?utf-8?B?cVF3eUNDb3Q5OFE0SFc3eVVlSk1QWHVpbEQyc01WcW82czJBZjZXVU9JNU1O?=
 =?utf-8?B?QWp6cGRwMkJmaHZjN21JQjJXTzJ4SUFLd25qS01TVEhHM0paK1VoS1h4VmhK?=
 =?utf-8?B?TlVhMHlxYlFRSzNYR1NHNm8vMTVSSXdWZG1hRC9LUnhCVTF6OUVVVFJyOVdl?=
 =?utf-8?B?S1RHdGluUStjYmF4cG5kNzhTMzhoMnlEU0FkS0VJZDVJZTlMa05aR2hHbS94?=
 =?utf-8?B?WlFjc0xuYjlTNForWHFnWmRFempPbzJUWmNaeDU1SG10QVNQVVhPUDF5R3Vm?=
 =?utf-8?B?NFkrWU1GeS81VUhYY3VaQmk5R29TSytiUEFobkgvQkZkZlVCbFdBZUJHaUxC?=
 =?utf-8?B?cGRaUEpxcks5S0NwRDdNazlzVitQbW9SRlRYRVZGSEhMeWhSanBveU1ZKzlw?=
 =?utf-8?B?UU1jTFh6SUdIYzdFOEhLVWdEQ3VuazMvQkJkVzlVZ0RJUDBpZFhlekNTT1Rz?=
 =?utf-8?B?RDBNV3UxQ01ja2o3anhubGtDejdTSU15K3hFcjZ1ZklpUk9ITjBoaEFYM2xP?=
 =?utf-8?B?OURVc3B4YUFydDYzM2RWREYyWjJCWGZXenJSMDZDRmhORkwzVWdIK0Z4cG43?=
 =?utf-8?B?eTFUSlYyV1dnM2tKQWJZbkFjNWxQR0xWWlZieXFEOUdtU24weGZhcmQxWmNS?=
 =?utf-8?Q?jRR8izLuUV9I83/8=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb07bad8-b596-47d5-379a-08dee636caf2
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 08:13:34.8710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D4kLnbbE93itKJSD2yygihqFED6iGMS5o0jQGPDBIjizLD15lAS13haMr+EtV8e1NGN4Ma84GdJl4kICZ2fxEPDxTkJhQtYDrtaoVnQClD0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5631
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 20 Jul 2026 08:13:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23672

Hi,

On 7/20/26 6:59 AM, Kunijadar Shivanand wrote:
> From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
> 
> This patch series adds the missing settings to enable the SWUpdate
> support for Debian sid.
> On top of these changes, I confirmed the SWUpdate works fine.
> 
I not sure we should test sid here. forky/testing would be better
as it will freeze and not be a moving target like sid.

Quirin
> Shivanand Kunijadar (2):
>    swupdate-handler-roundrobin: Keep Lua version 5.5 for sid
>    swupdate.cfg.tmpl: Add digest-provider option for signature
>      verification
> 
>   .../files/{swupdate.cfg => swupdate.cfg.tmpl}             | 1 +
>   recipes-core/swupdate-config/swupdate-config_0.2.bb       | 8 +++++---
>   .../swupdate-handler-roundrobin_0.1.bb                    | 1 +
>   3 files changed, 7 insertions(+), 3 deletions(-)
>   rename recipes-core/swupdate-config/files/{swupdate.cfg => swupdate.cfg.tmpl} (77%)
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#23668): https://lists.cip-project.org/g/cip-dev/message/23668
> Mute This Topic: https://lists.cip-project.org/mt/120354797/1753640
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/unsub [quirin.gylstorff@siemens.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


