Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B2B9C3271E
	for <webhook@archiver.kernel.org>; Mon,  8 Jul 2024 10:25:27 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (EUR03-VI1-obe.outbound.protection.outlook.com [40.107.103.48])
 by mx.groups.io with SMTP id smtpd.web10.76598.1720434326064903299
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Jul 2024 03:25:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=JmIxb1/2;
 spf=pass (domain: siemens.com, ip: 40.107.103.48, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=in7l5Yiw7QUgIclD+uy30LWO7LM5TxRqX17IZVlNDXv2X5OHw7Jj98rhU6pPc6Z/vq6PRqVF2kFFUeBU4H8GVPo3M3Es1EELCfcigwOpRxBx6dQgLxgIiLdRJ3JYF8RuEJ6hJx04MhkjB9Wn6ZCohkIWDmIA5lSgqvxyyExPEpSoBk5XsuLlsVLpIIspd/EYC+zytvlgtH2OLdWVJGIvcSdVlDfENFprtExOeubAKLx1DCE0uI5mQUDO+zCnagNwhciLfWtZVxSRhv1ncTD5Z5u6rjNRLzwddpZPosPP6fjsj0Oadqz+ir5qNgG6YyOXPdSXRLXawF2DeElHwoCMow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/tf18USjUALdNZRevP3cx6YRTPUA01FhMfGltyJvw8=;
 b=b7o/nLOvZfH6VII2Syr8rmhIFWBJiSLZeNlj1Qz+jH2VgD906WAa/G/2HGclN52rRKAR2b8rQaEbEhvod9uuqg2fBjK3+vGDXMv/LYkTVJLYPTOXx+s3vj1Cm98fBmWNpfl262U/DV9Eymr38bUWl9/o2lUzCB7TeNuhvxYutqXacYBhfBKTvxwZhSvva+Khh0faFwZ8mvSSPN3EqVemb4kMbOEvGUcUQlAw4tVnHV21NsyeIcQpxErCVp/JzD0hzrLqpseSCiIVEOr5r0lkpkJ8fEe5kfhEMFUkKP0Qotr04xVmGM3ozzRHg4dMiP2loMyh3JlRFrG0FUmq+E55gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/tf18USjUALdNZRevP3cx6YRTPUA01FhMfGltyJvw8=;
 b=JmIxb1/2+PCrrgF8BcBqwAzYg5H3/qule0q9r4mrlTlz9emKN8pKCnMbcWw/i1jPMLUeFsmidMF9DpgQsweMdjwpoqlhklQAxNS3idW77dZYqA1SJ4flyBFnEvoxWkc3vrHLI6H+aY0Wpj5EiLBTJ0RuwiEmfI7iGYqaWrVhCydwN+TJVKZ2sUN6GXn2asC9yOT0q9+ygGcjSj2AMhAQSiTyss/jrkzavjBGkNh0io3TuNhV3eL41B2C3HTh25aqVy260rNADwKjUXi7ie6YykZBWeTmYdKY+rpUYtDClLaZndh0G4BPnzgKZjfsRtUM6T2bSg5+LwVDyuKzikfQmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3472.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:136::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 10:25:22 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 10:25:22 +0000
Message-ID: <a77eabfa-9ed7-4787-8c77-46782aacafa2@siemens.com>
Date: Mon, 8 Jul 2024 12:25:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2] kas/opt/expand-on-first-boot.yml: add
 an optional expand-on-first-boot
To: "Arjunan, Srinu (DI CTO FDS CES LX PBU 2)" <srinuvasan.a@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <1d3cd14c-24a1-47cb-b48c-b9a711491702@siemens.com>
 <20240417153712.104378-1-srinuvasan.a@siemens.com>
 <PUZPR06MB5747DEDBB966921AF4CF40C488DA2@PUZPR06MB5747.apcprd06.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <PUZPR06MB5747DEDBB966921AF4CF40C488DA2@PUZPR06MB5747.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0007.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::17)
 To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3472:EE_
X-MS-Office365-Filtering-Correlation-Id: 33daa669-623c-48fa-b616-08dc9f384605
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?N01yM0tSVUhhdmJQL2M2V3VMdmVTeXlCeTN2QnFaTjhodStNZEd1QzNueFIy?=
 =?utf-8?B?V3VnNDhHcVdnWXZZUGJURVh1bXhXaEp6UTBsMnIyM0c0YVNCYStQL21rOXEr?=
 =?utf-8?B?TXdxWmRZa3cwL2NaWE9TUjVHK2N5VGhmRGhSZkRabEc0OEpPSEYySUREYVJS?=
 =?utf-8?B?K21OT2pmR25tZFMwMUZycndpTzJ3TCtWNFRiL0FKRlZBc1oyYi9nZzZyZmpK?=
 =?utf-8?B?d21ENFYyaHh4UUZNQmJWRUlmN3N1b3Q1SWwxaFdsTks0WFBrMFdmUXJldVMy?=
 =?utf-8?B?OEoyQjkyd1hsM2Q2eHNkVnBzbmdFMnZHN3pDRWFRSXY3SUJhUTF3ckhod0l2?=
 =?utf-8?B?R0JVZmxYaG0vaTZLSlZ2ZTJqZVF5K0hFaXVLSjQrZG9LNXB6QjdyRlFBay91?=
 =?utf-8?B?eHB1Z2ZTdFBOcnlmZFNMc1BFTUU5MFIzR1dwQnhqaExwaUxtdXo5SDdLSkxy?=
 =?utf-8?B?alh6Z2Z6WjV6b04rL0pMNUwxVXJiUlErOFhMNThENXkyNmpWdnIxRDZHMjd3?=
 =?utf-8?B?cjk4aEZUZnA2TE1xeXNtdEgreU03K0tKRlpGYWdPQnMyRndHV2ZFdGZ6bGhL?=
 =?utf-8?B?YTZPL2VaS0F2RXdsWW9Ldk9RdEs3eTk5d0hMUTY4dkN1Ymc3MFJsb3QvOGU2?=
 =?utf-8?B?VXJ1K2IzckQ2RjVOZFdtUDlvRHBUVllxcFBXMEdCejRNbkNUK0tlVzNxZGVD?=
 =?utf-8?B?TkdaTCtsdTc4VzRNRnJEWUdpSXJ3U0QzakxPTm81eTdQNXhNZTZVQm1pN2tU?=
 =?utf-8?B?WEExQk9rMTgyQ21oSEdZanhZemJjUmFNcDA4S1JoMmZNNHZIUzJJeXFONDNF?=
 =?utf-8?B?K1VGaU4xZzR3ZVIzUEd6VXd5TlNNNjJiZzdtTXlmVW1IUmM4UWtXbXo1TVBi?=
 =?utf-8?B?WjBoUGNCdzJtNzFXR3dFd3pJcWk5dVNXR1hqNkdtL2UxUEZYRThPNjFSWlZL?=
 =?utf-8?B?bFFKbFJNYVJpQzhNUEtldjVaak14S0hZdm9wd205c29Vb2lzWXh0YkVBcnNy?=
 =?utf-8?B?a0l1ckVxY21VQ2poTE1yMWZZL1pILzB0RC9GT3RIdEFienRqS3FrUk04Z3JB?=
 =?utf-8?B?Wk1BUndYTEthLy9oUEhiS2x6Uk5TbSt6QTl3RHU5V3ZrU2sxOUF6ckM0R2VJ?=
 =?utf-8?B?RHNLckZtVzh6NlZqaURsemxjbi9tVlp2Q2NlRkNISWV4YlVMZ1gxbFpobnB5?=
 =?utf-8?B?d1hwMUVjMFZBbktOSG9KZkRhcFZIMWhERXVrTnh4Q1lSU0JGQTBWNVVvMkZQ?=
 =?utf-8?B?WjY0ZlA3QkZUS0VrTUN2Ti96ck05eUJZWHdRRE14VGVHZVJINTltV0ZNbTFG?=
 =?utf-8?B?WFZOREw0UGpqY3ZxNWJUWm11VkFESGJkUUdPbTRhZGg5TGVtUlZsMHkwWDE1?=
 =?utf-8?B?MVNtYmxhOTE1dVRvY2J4dnVkeU5UdjV1V1E0MU1YWjJEdmo4Sy81N0VWTDRa?=
 =?utf-8?B?eDNJQkdkd2VNVUwrUm02dmYrc0FaaEZISFZncGtucUl4Uk4xSmF3VzhxWUp5?=
 =?utf-8?B?dmZYOEdMakEzbGlFYTJSRGw2YklMUGt3WERDK1Z1QUg1cmp2ZkRCQVVuOUR2?=
 =?utf-8?B?Wm9ZTlNleWxNT3RLbXdCTnZ6SUVSTTBNS0MrTzZPaXNabjNzY0p2dFpaSWZt?=
 =?utf-8?B?N3FJWThEbmpEbHRvY1RuNGhtZGJxMU9Pc3c0M0w4Mi9WRVB4c3g4bVpXVlRa?=
 =?utf-8?B?eTBpZ3lPZzd1eUJjZVRTLzFaQVBIY0NoZjlhNncvMkdjdjVUS09aaHdKZEVp?=
 =?utf-8?B?UW1ONU5OMWhlYWlGUjltMGJ4RmErNjR2NldmT0dGWk1icE1sVzEwZ1VjTEZx?=
 =?utf-8?B?Y3JjLyttemZVYVR6cThMZz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eFVnWUE0Z3ZmVGZKcG14S2hKTjNDN1RaY2g5QXdMV3JJUnZZQlpoWEs0L2hF?=
 =?utf-8?B?bVR1aHhwNUtqeDd3WWt4TVZ1RGIxOUw3Zk5NY2dxTFo3U1RCd0tGU254OGp4?=
 =?utf-8?B?R1hSSFVFemFScnJSclVkMnlhdmZKMi9LZDNoL24zQXJ5VWEyTmsrT2R5c1l5?=
 =?utf-8?B?ajhQdFlqMmJOckVrNUdtSXpHekFGa2NNU0lqYmVLMHRxL25IWXdmcEdORm9r?=
 =?utf-8?B?K1ROaG1SelVnQWhZUkhXc28xQU9ZMHgwMlZuWFoxd0I4VUdpUGVPVU1MdkhC?=
 =?utf-8?B?L3haV3VCdnQ4VlRqMWJkeUJrbkREVkhZV3E4SkFsNThaL3hrblkrV3lmc1pv?=
 =?utf-8?B?NmJwZVRtYVl2ak9PakxHUFJGUkxYeC9TZThWWXJ2REtwVDUrZzJFMzdjejl5?=
 =?utf-8?B?YXVDRkJxdkNqU3FaV1FvaHRkNE5DYW51d3dHM3p0ZklmQVJZazBSS1dCSVJh?=
 =?utf-8?B?dWFQS1crRXdLTUg0WHAzbXJERENHYWNiSXgyaU5PM3U3RGVrZktqYURid3R1?=
 =?utf-8?B?S0M1Z2dUYi9Md1RySjJYcEQ4K3YzY1BJNE56RzVpdlBsU3R0d3RoeTlLTDkz?=
 =?utf-8?B?d1AwbjNISEFWYTBVOE9hVy9WNTdVV0Y0TEZQZktzUVp4azAxazV3enlrTnN3?=
 =?utf-8?B?SDlQSUs5ejFKTnF4azFDZmI3Vlh1YmJ4MU10N0g4TmhJdlp5ajQ5dDBmS04w?=
 =?utf-8?B?OStzOU11RFFPclF5bWtYT1Qya1NFMDFMeEdXejkrOFg2bkFLMHVwdmFrRk5t?=
 =?utf-8?B?S25nMGU2WTdMMm5KbE9VcGtJTjFCb2VKY0I3TnVnUk9VblN1N1JpOWpMNTJL?=
 =?utf-8?B?RXJ0OWllQktCYk9yeFZKcGxJSytyQ2ZockhjK2lWWUY4WHdMSzhCZzJ5OFJG?=
 =?utf-8?B?dW9HSmcvcnI2L1AzbTkwQlNLaW9aWVpwaytIZmdPTmZPNjdJWXpHeDd3K3cw?=
 =?utf-8?B?Wmc0TzE4UVR4WDBiSDh2aVdYaytHL2t1TkZSajVSQVRJVy9pZHVkSmY3cWI3?=
 =?utf-8?B?TDFzZko3L3dEeWxldHZZdFNxOFJQZ3NSQnBCcFoxTnk0MFIrSGlkeTQ4WjZM?=
 =?utf-8?B?bElFNTNnNCtyWHpLVVhMSmllUm52T2lUaXBEYWtreXV2NXc2YVZhcjN1VHpm?=
 =?utf-8?B?cHlVVytWbUpMZUpJZy9RbmdtMy9JeTRpSkVOemVvRXYvclNGUWhKZVJSVTNB?=
 =?utf-8?B?eUttZTFPYytiZmdyOVo2eWpaQ042ZW1XdC8xcXIxQkhhUW0vTnZRSnFpZ2t5?=
 =?utf-8?B?UVBPblRjaGZURGUzQWY1WXpiUlc2dlpGZ05JbnRMYVVNMytSRE9PT2Q0NytO?=
 =?utf-8?B?SkhYVUhsTTFEYkUzU0Z6UENYTGplVEFrWTdLVHRNMUZtOTl2T3VWMkhidU53?=
 =?utf-8?B?NGdRaU0yS1E1K0hRbHY4QmpDN0dORyt0WnVBNit5QXB6L2dNNjV5T245d0lU?=
 =?utf-8?B?R1IvWjRqUlpMZUV1MXNvVUhTSW94RUVuS0szRzh1V0I4MTZoV3g5Vkp5TXNW?=
 =?utf-8?B?NmJZYlVQQUdhc0VIYUdibFpleHM1QUdBSmUzNzhCRGVlNmZMQXczeGUwb3U0?=
 =?utf-8?B?ZTVOSlM3dGpWaVppcDRvVUo1NDg1Qk9zQUNkOCtudGpZMTdtYkdwOWRtbTFR?=
 =?utf-8?B?RUkvY012YXRLVjhnMXc5bUsxdmN3QkVQNWZFZlRhS2RPaUJ6UkM5NHRobHhr?=
 =?utf-8?B?VUlSQk56UE9oTzVLOXA2YVV4TG5rTGtvWEgrR0o1NklSclBmSVB0L3MvQWVV?=
 =?utf-8?B?MzBjc3J3NERNb3Evb2ZhaGJkOVR3aXpzNlo3eUMyR3VsWS9xN0ZPWjJ0Qzl6?=
 =?utf-8?B?T0R0L0s5UHRXNHlzVXZFWGxDZm9Tck5HNHNQQmdwSWI1NmFNV3lCZE9icm1L?=
 =?utf-8?B?QS9BZUtwYXBONHc0RWhMaUtPKzA2L2ZJTms1S1RPYkg3Y2IzMmp3OFQ2SzhE?=
 =?utf-8?B?ZmZoZVZ4UHYrK1granVwaC81L3pESGgvYXQ3cWs3RGFNYm1Qbk9abk1KbjZY?=
 =?utf-8?B?azE4akRDdU9sYkN3SXd5NXFkT2htVXFucjJwQ1libGVwTCtzZFNhZlRhRlli?=
 =?utf-8?B?OGJwUnI2MkFMTE5BMEJ4ZzJrL1EyU1pacFZiTTFIejczUEFLamxKUkRjdkpL?=
 =?utf-8?Q?OGMHg3cexvO+0G6XJ4VHDYriQ?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33daa669-623c-48fa-b616-08dc9f384605
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 10:25:22.2464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4MVXTwiSzM/KV76mtLP41H9GY2Um2ArJPGjKl8rjCFfae61DXqt7jPP6oliaFSmYspRNKJEr9zGLkySdoczPiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3472
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 08 Jul 2024 10:25:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16430

On 08.07.24 11:48, Arjunan, Srinu (DI CTO FDS CES LX PBU 2) wrote:
> Hi Jan,
> 
> Any Update on this patch?
> 

Sorry, missed v2.

> Thanks,
> Srinu
> 
> -----Original Message-----
> From: Arjunan, Srinu (DI CTO FDS CES LX PBU 2) <srinuvasan.a@siemens.com> 
> Sent: 17 April 2024 21:07
> To: cip-dev@lists.cip-project.org
> Cc: Kiszka, Jan (T CED) <jan.kiszka@siemens.com>; Arjunan, Srinu (DI CTO FDS CES LX PBU 2) <srinuvasan.a@siemens.com>
> Subject: [isar-cip-core][PATCH v2] kas/opt/expand-on-first-boot.yml: add an optional expand-on-first-boot
> 
> From: Srinuvasan A <srinuvasan.a@siemens.com>
> 
> Add expand-on-first-boot package as an optional file, this would be helpful to understand/debug the expand-on-first boot specifically w.r.t LUKS support, this systemd service expands the last partition on a the boot medium to the full size of that medium and then deactivates itself.
> 
> Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
> ---
>  Kconfig                          |  9 +++++++++
>  kas/opt/expand-on-first-boot.yml | 17 +++++++++++++++++
>  2 files changed, 26 insertions(+)
>  create mode 100644 kas/opt/expand-on-first-boot.yml
> 
> diff --git a/Kconfig b/Kconfig
> index 96f590a..ec7c686 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -151,6 +151,15 @@ config KAS_INCLUDE_DEBIAN
>  
>  comment "Image features"
>  
> +config EXPAND_ON_FIRST_BOOT
> +        bool "expand-on-first-boot"

Not helpful. You can build on the recipe description for that:

"Grow last partition to full medium during first boot"

> +        default n

"n" is already default.

> +
> +config KAS_INCLUDE_EXPAND_ON_FIRST_BOOT
> +        string
> +        default "kas/opt/expand-on-first-boot.yml"
> +        depends on EXPAND_ON_FIRST_BOOT
> +
>  config IMAGE_TESTING
>  	bool "Test extensions"
>  
> diff --git a/kas/opt/expand-on-first-boot.yml b/kas/opt/expand-on-first-boot.yml
> new file mode 100644
> index 0000000..03d666b
> --- /dev/null
> +++ b/kas/opt/expand-on-first-boot.yml
> @@ -0,0 +1,17 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2024
> +#
> +# Authors:
> +#  Srinuvasan Arjunan <srinuvasan.a@siemens.com> # # 
> +SPDX-License-Identifier: MIT #
> +
> +header:
> +  version: 14
> +
> +local_conf_header:
> +  package-expand-on-first-boot: |
> +    IMAGE_INSTALL:append = " expand-on-first-boot"
> --
> 2.34.1
> 

Jan

-- 
Siemens AG, Technology
Linux Expert Center


