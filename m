Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1FCC25B75
	for <webhook@archiver.kernel.org>; Mon,  3 Jun 2024 09:12:36 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.78])
 by mx.groups.io with SMTP id smtpd.web10.78914.1717405952341848063
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Jun 2024 02:12:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=HC0tnr7n;
 spf=pass (domain: siemens.com, ip: 40.107.22.78, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oCMwCgFOYj6Ex4E4C9QT2ZmI8WXDOtZbfZlIS7D03ujwY+8db5WjNgvPjpN3eDI75aZ8qZifd9cg0tfJK6YSHDYx0gxpivqOXY/eUxxs8/WR5Yv3dwiO0Ipl9QIxrbdukCUqyrHPEHzAcDSiVmVvA+7pHiycTybrQiaJKywH7OWBcrARBk0kTzrMcYTgbE6Fjtf4lOU4ylCfU30n/9mZq6gjEOg0ujhz96cxjT+lMllMmU9EMfb3MJ8Fqg+uUbjm6c2yvK2Gopj0LlYlFwxi6CetPZwG13i8tzskafVkFrS6Bxq8ZBHKM1+EVvlZQxXfquRhfT1tmBeDYjyz8EImSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gwxuMnQ3fHinmG6gKFVK4yr5DpCYD+1q6lYoyvcvVb0=;
 b=MSzFTT8W5jlQCXfO9EN6by1hBw5ZY3qgH3sVFHozZaPqM6u0t8ZCJDpVJlhJUTZKtiCwILHuwglBRWZHlz76Ul5rZuNhdApefebnBx+aumCnTS4tJ1NPRyFDQ43z1T0O1Oul6L5An8TZKKDwkm9ip4F1sfPQ15KvSMvZMteJvaBugMfwtL/IUZ76l5lh++MpXAbxFM/10zi8LEvvBAtYCTfb7H+Gb0R00afgtTI5+kTdg/f5A1ETjGkAi1u0+1YCL2pZlrbaQ6HpIVIRbowizMbJAv0B/PEPv/F2FHGf3IjzBVJWHZOSAAz+vwfpY2o09tcp+JDyT4rzCEUkvoPfAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwxuMnQ3fHinmG6gKFVK4yr5DpCYD+1q6lYoyvcvVb0=;
 b=HC0tnr7nPdTYkzyY9o2CcL67MzDL0//AtrfehN+dLBcBu+wyL13V1ou2D5mu5kplj4M55WGdDjRFuOXyE/h+Po8FKqXkBSCXEUCNNEfoeijrpjp4oFI/9OwmHRZkgRiOhPQQBQ1r6dmnZvmq581mf+/96jdfI0Yx5UUgsWXRc9eZx7InjqMQL6Q+U490nwuWcPcccXU86nkPrcKitVwlSunInvB2WtCzHuzNcl4tWfkeqQCuLMk9D9EMt+G8Dpt0EqE51zrIVbRwISr6fNrxSKaO0YVeaho3N3xKpLkyfYHLEViUvNbZmU9r/57Sqge2i2RiFtpiutewjHfYZ2ow+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB9044.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Mon, 3 Jun
 2024 09:12:26 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 09:12:26 +0000
Message-ID: <441b9fa4-27d2-48b1-8c8c-9380ad839ccc@siemens.com>
Date: Mon, 3 Jun 2024 11:12:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core 3/3] .gitlab-ci.yml: Add test targets specific for
 CIP core functionalities
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20240603070920.2942859-1-Sai.Sathujoda@toshiba-tsip.com>
 <20240603070920.2942859-4-Sai.Sathujoda@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240603070920.2942859-4-Sai.Sathujoda@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0088.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB9044:EE_
X-MS-Office365-Filtering-Correlation-Id: 83516cf6-b05a-425a-71b5-08dc83ad498b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TE1yYlZoekZmNnZJU0FpbWh2eC9pRzhpbldObURWaUhOazg3aEN3aXY4cnY5?=
 =?utf-8?B?cG5PSVpUNlpCdFFScEprNWgrRHJhRFVuSlJFSWpUK2dwVk1KYzVBSWI4NTdw?=
 =?utf-8?B?WkQrUkxpaHJYYXlsYVZleG81S2hJbVdwQi83S0FmK0daZkhlbHZXaWF4cWJM?=
 =?utf-8?B?czFsVFJPK0FJMS9JRjIyWUZlelFTSzFCMmVLUlNCazJ3UmZENnNtemliSktq?=
 =?utf-8?B?WkE5T1VwdHBxT0htbWl2RlFlelRhQmF4VU5zeE1lamNTeHg4NXhyanplZW5H?=
 =?utf-8?B?OWhVVSs4eG5nSlltZUhjUWpyV2MweG5kNnZTTnFpbWlUMzJES05zZ2NpdEpV?=
 =?utf-8?B?Wm5NMVJya3pURXBTeHFNcHVTWjAxRW1vTnRWR3VmVkpRektwVW5mV2VweHN5?=
 =?utf-8?B?Z3VHY1NPZUNMa0orUkpteXpBV010Vi9sOFhzRzVCbVVKU21pOUgvUmt2emdC?=
 =?utf-8?B?aldsVVJudjJPdWVBWWlIOFZ2d3lXcXdicGhWOVVWWUl1R2xLV204NzQyYlJ5?=
 =?utf-8?B?Q2dZR0I4TElveGJwUmg1dHF6cFFVVVdFcjZyYmo3YjFHTG5BenFBbFdseGRC?=
 =?utf-8?B?VEZJb1JMeFd5ZHFvQlpOYzI4RjFCNzRsSCtuK1RyeFpEVkN5NU1EdytzSjVC?=
 =?utf-8?B?TTBMRDBOL2EyU0dFOURXTG5VRVcxaEdoUTQwRjhLcjZpUkpMajBjKzVLWUZ4?=
 =?utf-8?B?WnVrakcrWnpSMGRQOFczaVN5TzZDcDkyZVQwOG5VelVQakprZEFUdkVWa3h6?=
 =?utf-8?B?anZ2d05FVHA1Z2RhZjZuNERPOU9GeDZtTXBUVjZDblo1M01lTTFRcXpGKzQ5?=
 =?utf-8?B?VGRSbmU5SEs5OXZxaWxmWjF0NU5ab2Y4T3ZwTktWUk11YWYvKzVvM3NBVHJK?=
 =?utf-8?B?cUlCalZFNzRhRFJxcm01dTNDZGx4eUhmOTNRczg4MFFQUFlKdlVUdk93Y245?=
 =?utf-8?B?QUhxNjJhL3MxSzFyT08wK3FCTExaSVRZT3k2YXc1MUZ2bWhSdXg5OGxrVXpJ?=
 =?utf-8?B?VG1ycW43dE5UMlhKUi9ZMmRKN0RES01SWlB5RjFEbTBhQlgvQ2d0b0Y2Q1Fo?=
 =?utf-8?B?aXVXYm01emo1SlRaSFJhQ3VzSkdWNVFTYnZ2WU9LM0JIRG1hSytoSXV2R1I2?=
 =?utf-8?B?RlN6eWl3bmxva0hKcHU5RVJnQjYvOVY1UTV1MUVEdmQ1UE9md2VqRkRqT2hJ?=
 =?utf-8?B?VWZScElVS1R5c3I0OXJNNnFWMEh6aDBCY2JSM2VpUEE5TzdRRmNKUjZTb3FJ?=
 =?utf-8?B?d3MrZ3VLcnAyTnJjZms2Vk5MMlhPeGVjWlJxemU4WkYwZzQ5Z2RzS3NOT3F6?=
 =?utf-8?B?QXEyM1d4RXRXb2s2ZDBMOWVuRUFndGFsTk9iK0xXZjgrMXhHQmhaZTFvOXhj?=
 =?utf-8?B?T0Q5WVpnbHk1UDJXYWhPTmgzSS9EU25mNGxGR2ZhWGNUdi9QZDhMQllMY0ts?=
 =?utf-8?B?cDVwZXZDRnlyRTFEV2psU0FOOE4rdXA5SnQrNkZNWmUxYjNHQnhFcUh4Z2FF?=
 =?utf-8?B?bEpwcHg1MU1XbTlpREtOTDZyd3VvNzh6ajE5dEJUN1hlaW5LVUNqTGZ4RHJ1?=
 =?utf-8?B?dk9DY0Z1dHkxM0w5MW1rNUpQR21QenkzY3pURFRyTlc0NkRjWU1sbnRuMG9t?=
 =?utf-8?B?ZlpveTRGQUx6Y0VUMy9hUTZJc1hGc294cFVFWERvYTRNS2Z1cWlBOGNtRms2?=
 =?utf-8?B?YytNTktSdDJWSVJSMklncG5MRTR2SkRLczh3Wis3bGprYXpTVmRaOFZBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MmxIUm5rb3NqeTIyam45eTQwSk9CQWMyMVoyUUY5WnhiMUxzTXRYdUkvUXlw?=
 =?utf-8?B?K0tydmVjVGw4azB1eUJpZGRZNC9aN2g0SGtpYUs3empkYnhpWUJYb3cwc2N5?=
 =?utf-8?B?dGJtRzZKS21vTWdnZ0ZWM0JLUW5TYmZ5TlhLeEUwTTRYT1JzYUZyRzJQRXgv?=
 =?utf-8?B?TjU2eUZRRlZZNDdUVXhOeC9sTnMwSDZRbzBNNzg0K0hETlY1czQ5d2hwemRF?=
 =?utf-8?B?U1lRMmZrd0o2dDZnd1ZXMFRqYlVnOEFJd1hPV1k2dmEwOTI2VlBXaUl5Lyty?=
 =?utf-8?B?YUF4QXVOV29pNk5JSzkyZ01kK0pIeGJ2dmw4VUtuVEJydXJnZCs4OFM5dGRu?=
 =?utf-8?B?MWVxYXVlR0xwcXBhUlZFdkdzbEx6MHVPN2RGemQ5UUR5bndIUWZwbnJxcVow?=
 =?utf-8?B?VEc0UlFJY1cxZHVxdzVGa3N5OTlXSGxhRFBZd0RGU1ovN3QzYzJvTFpWYyt2?=
 =?utf-8?B?enNSczRuRzJ0cEJMQ0VSUFVmZkdHVDhKNERhbk44ck53NHd1MUFQbnNpYXlI?=
 =?utf-8?B?TE5GRDN4TjdLQlpRYUU3SExBRVlaWEpjSUFjeHEyVkVkU1d4YzJLTjN0MWE1?=
 =?utf-8?B?WWlrYk9VNzhZa3RPK1RWTE96NW9XWWFKcUcyQ1B4bUkrYzNtb0hlejVCSStH?=
 =?utf-8?B?eVl1ZUJuQ2IxZ05FS3ZvUGRnRitHZVpIQnhUbXdpbTd3dVlOK1luSHhBV2xP?=
 =?utf-8?B?cVZtaVlUYVZsbldNdGgzNVZhR0hEeFM5czFySjNhN3V3UHRLdjZFek5kYnZz?=
 =?utf-8?B?SFJaUFpZUWRJM2I4WlM4MEx1cTBVOXBZYmtDemQ0VEU5YWZMNWo1RzMwNTVj?=
 =?utf-8?B?OTVwSjZ6TCtpTXdrZi92MFF4QU85endmUGtvaklpREF6NWd4eFVHaWtrYith?=
 =?utf-8?B?RFpja0xBQ1RVWGxmVW03Yk9mQjh4cjI5Vjc0akVYdFM1RWlYSk44NHNLVERC?=
 =?utf-8?B?WndKNi9PZ0FjM0tHVThvNDUwT3h0V0hWSjZtemptN2k5L3pkWDdhL0tTRVdN?=
 =?utf-8?B?SmNYdTN1V1RvanRvN0ZxcjlZN0pVTTliT1FsbWVoNEUveGt0R1UvN0hnVUds?=
 =?utf-8?B?YStGWlNCdXJ6SGpKNTBwTHdxWDFTQ091MEFxellQU0lVQTNWNm81Y1YzbmRz?=
 =?utf-8?B?bzVodEhqdjBRTjJ2WEJaRjNDTUtrQ2tJNVJQZVBsUHpBTVhMUzdvcTN6b3RU?=
 =?utf-8?B?VmpOTEMvV3EyUGgrdGpGTmw0V3lCSGEyZFgvOXRzWHBFT3p6S2RwZFZFMWxF?=
 =?utf-8?B?cFBzR3lWMUVnS2FObjVlZ3h2b0RYTDJjc3hLd1JBY3FBZmFLUDB1bEZ5WTNp?=
 =?utf-8?B?dEptRUQrQWZNRkIwOGxRclppTDZOM1k2aTkwSzMxQUVpd2phVHRPSWx1UG50?=
 =?utf-8?B?MmhrNDRtM2VPTG01bGNveHczZnFYWG5oNWhQN2pIUDc4MlRsam9OQzNJM1JF?=
 =?utf-8?B?Q29sUjZ1bElzelNncGY3UmgvZGJyeU91Ykc0SVAxSlJ3bytXejdlUURyU1VQ?=
 =?utf-8?B?TUVMSjl4dHRVTE1sMHRpZkJ3d0ZMa0RQOUMxRXc0T0pwVzNYTlFIdnNrV0Er?=
 =?utf-8?B?UWV1ai9pWEd5TGFrc1Y3OE9KZktBaXR0d3BRM1dPcExWVkdTS01UQVNiZFdm?=
 =?utf-8?B?dzE5Q1A1M1VvenZwTVgxUEJuYWt2eWRyR3Uva3lQYkt6MnJPRk5qckRuVGRR?=
 =?utf-8?B?ajdqUHdWYXlhcFNoMFg2OUNIcmUwYU9wSlFOL0IxTk4wWlg4UEdUUkRvVWh4?=
 =?utf-8?B?cTdHTkRTZFVUcFdlSkxtMC9NWUx6KzJiSU1RL3ZxTGdnY3F2a2xWOUUzUDcr?=
 =?utf-8?B?Ty9BbDlPb0xCaDU3UDAveXJMUS9LbXBZcm4vVGJyNmJFMzlGaDBJREFUc3hP?=
 =?utf-8?B?OU5EVnBwcnNpd01VM1I5b3AwQ3ZYa3UrZGRzVGVoV3JWL3JsZWVjMVdDNU52?=
 =?utf-8?B?NjRnTjZxdmhKUFRWNy9yRTh6K1Z5RUUzVUtUeGI0cFVFU2RkTWh1VE1ENnpV?=
 =?utf-8?B?R004UTNLRkd2QzlRcFJLVUV6cERoSHNPaHQ0Z0JjRVZlY3ZrNkI5RmM3UmlF?=
 =?utf-8?B?NnZrTXpmaUh3MFlwNTBnbTNOd3R2NnpFc3ZLbmo5cDB0ZlRqaWxIUEV0T0NX?=
 =?utf-8?B?Tm9oQ1V3VmpNNVpCc3VnQjYvYkQ0VTFjS1FqZ0RQbjBaa3pJL3R5OElxN1lS?=
 =?utf-8?B?OEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83516cf6-b05a-425a-71b5-08dc83ad498b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 09:12:26.6926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fBGt4WVLIoEmNTN9ER+uRDsCbDTZpgKycRspB99J6GYKZoY0NIgVy0S6/auYMAikM1oBf+cLPQICQF96c1GQUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB9044
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Jun 2024 09:12:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16089

On 03.06.24 09:09, Sai.Sathujoda@toshiba-tsip.com wrote:
> From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
> 
> Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
> ---
>  .gitlab-ci.yml | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index aab55be..0a22a3f 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -358,6 +358,39 @@ build:qemu-riscv64:
>      deploy: disable
>    allow_failure: true
>  
> +.test-cip-core:
> +  stage: test
> +  needs: ["build:qemu-amd64-base","build:qemu-arm64-base","build:qemu-arm-base"]
> +  tags:
> +    - large

Conceptually, we should not need large runners for these jobs. Do we
need that for other reasons.

> +  allow_failure: true

Why?

> +  artifacts:
> +    name: "$CI_JOB_NAME"
> +    when: always
> +    expire_in: 1 day
> +    paths:
> +      - results
> +    reports:
> +      junit: results/results*.xml
> +
> +test-qemu-secure-boot:
> +  extends:
> +    - .test-cip-core
> +  script:
> +    - scripts/submit_lava.sh secure-boot ${CI_COMMIT_SHA} ${release}
> +
> +test-qemu-swupdate:
> +  extends:
> +    - .test-cip-core
> +  script:
> +    - scripts/submit_lava.sh swupdate ${CI_COMMIT_SHA} ${release}
> +
> +test-qemu-IEC:
> +  extends:
> +   - .test-cip-core
> +  script:
> +    - scripts/submit_lava.sh IEC ${CI_COMMIT_SHA} ${release}
> +
>  cve-checks:
>    stage: cve-check
>    needs: []

Jan

-- 
Siemens AG, Technology
Linux Expert Center


