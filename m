Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE0AC636D4
	for <webhook@archiver.kernel.org>; Mon, 13 Feb 2023 15:21:08 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.85])
 by mx.groups.io with SMTP id smtpd.web10.16891.1676301662081029126
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Feb 2023 07:21:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Hxp24BFZ;
 spf=pass (domain: siemens.com, ip: 40.107.241.85, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vo65cuVtgiiR3tzUAyP34VgL0jKqKWj8c02YlQ7R2WFyBDAkBU8Didv5ot7cYTcqJFpvCykWIoMoNFyppe3kbnj/Tc8oBGMP3+/jcWdnqcU0AY23bWoIelGPuO6vadlSpqShHL6PUqBQPc9mJfFTYw45iSyj7TMprOEuPFHV3j5dhq3gFuTDy4WKmvisY/H5R0Yy1W7wlH1Y1BDovdZperZHlvblj7GTg4bIVA3+ssx8uf5sGfJm4IcYLKe3gY/LTKtw4+eZkyZdXvUdmM2Bciy/nn2J92rjgF4JUXqMgefZBfXOWGqw2KmRvTPotc2or3KuQD//edE3vc7SSkiUmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CT+4VTiQVyfyUGRUIIZrlU+9BxXmANqZXA9woAoJ9I=;
 b=kQW5UTqKZ8XRBmsqoJMHQiv5KxD2hP2YFLv8Xs0qlR6YCMYJvor115jpOJedSBA2uBLb9Wczd5Sb0/1MJsj0z/qmkLxVQyG/AyaQkfxWgbVsrOhBkrbTe6iHIHwZhI2imwYkiSuDkJyjtoN9ya5f2SPVuAMLsxYZDA4a5a8D/3wHyQmtJmFZP8IaI3Us+L+dQZMirFBzNHG7+unuToX0NoIhHi9z3UlJ6VVI+Iemx1KtnjK6jSLMypNUP9q8vgHtO1+c1jniYE5OpUc6UhtyOxTxd0AqCI8k3ygGK3jvDs954BXYS5MnAh3MVAzt7eSc/1rv2lTIUjlW3dQuE9ITGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CT+4VTiQVyfyUGRUIIZrlU+9BxXmANqZXA9woAoJ9I=;
 b=Hxp24BFZvn6aGYCfWtQ6dAXuHy1ylnq7RFQmJuQXn+zm8oj5r1uFuHVeCffT3pGKu4j7gaXpdyeW0JmLgFOrleAheUf7JyD2iRuCCAEyLVIaiuscstipQDsgW7zyh5HerEdk/RA+gr8NbBfJGw/8+EUCWBYEv54/27LQLfzeEH7sGKhibGZJV3Szqw8jsekcjhEUPcbInwNemwpivI+STa5y/AILGwGRw6rgENO2WSPIo9O5hL+5Uyrnolt95LJON1CusLgj5+VxIfmWCxizLLfpL7Z9yHyvrUQM2WFw5LUaRSTzHRJaLPTWn609C8cdPk6df3MtOofgCfCk1+yipQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5671.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4f2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Mon, 13 Feb
 2023 15:20:59 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6086.023; Mon, 13 Feb 2023
 15:20:59 +0000
Message-ID: <6a49ef08-7b4f-d358-1844-fafae19e9488@siemens.com>
Date: Mon, 13 Feb 2023 16:20:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [isar-cip-core][PATCH v4 1/8] register image classes via
 layer.conf
Content-Language: en-US
To: "Moessbauer, Felix (T CED INW-CN)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Cc: "Schmidt, Adriaan (T CED SES-DE)" <adriaan.schmidt@siemens.com>,
 "Gylstorff, Quirin (T CED SES-DE)" <quirin.gylstorff@siemens.com>
References: <20230212082758.1166262-1-felix.moessbauer@siemens.com>
 <20230212082758.1166262-2-felix.moessbauer@siemens.com>
 <7201431e-f281-8a48-dceb-5419673fca3a@siemens.com>
 <cb6012fa494252328ab28e05b4e00ab791eaf27a.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <cb6012fa494252328ab28e05b4e00ab791eaf27a.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0094.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5671:EE_
X-MS-Office365-Filtering-Correlation-Id: 257f7750-c5a6-40f8-647d-08db0dd5e8c8
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	M71GzUMnU1uoaOr5DaoMZrQ885dzeDJ7yDFTlDrwQlDDHr1YGB5qeR6OW1MuIpM0H1TfyJIL7jiQkhJ9uxC5ROBfMekNZ1NABQr2jV2BVh8Gi525LoGjEh2vcg2NHRkBNfxmi6KfKBq/z5gclHOqjHyCbILWaC3qfWj5Bn+Rzy5TlqeFKGI04YyWIMrqVRQWbMi/MnWKJTyBmgGAbfi5J24lAhrn8FYH/Rg9PKK4+YRkYRYmvDb1I8HTmcXKHoeRIzaI3U/agPss+58JykVVhLYS2vOMRaIkRpSp3ivV2JajLfuLthnXl0C5cMv+BZLLA7FqiebSqV9qBDFCp+n7HaztqUdRcmNYpwT2Dx7gB/fHKlr9Bk5yhUq6X59/NOQTlv3R1u9PkeiPkpEprO7rPr9yFj6+saAicSw3sP/XdxDBQqPOiyH44x/dnHMRNwck31Nm1dGUsmF5AzYYEPsaS69D5cqRnotNuPfmhrQX+aMDd9iKxQPho88Qi7UWllgjhKfNZh7f+qXuMlEqtxcXGkgarRvxR6GHmDGwNL58nOHk2WwWURRwgAqCNsidfs/i7LNtaweh7LkuyHgp1d0+AdaB/ANmGSULTjVUAQJDTWNg2TVrG3/rsDTpiu/tvKT6lrAgC1yjDJR81pEC9QDtOR3ARO3HbGBvKL1Eq4q/iWFY8dck997y+ckxGDWmPXFmnvzEZQQ2exbngUgOboyMCgLogzEDxisB46mRFjbC1ZU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(366004)(346002)(39860400002)(376002)(451199018)(186003)(26005)(6506007)(6666004)(6512007)(53546011)(36756003)(2616005)(83380400001)(107886003)(44832011)(8936002)(5660300002)(4744005)(8676002)(66476007)(66556008)(4326008)(66946007)(41300700001)(2906002)(6486002)(110136005)(478600001)(54906003)(316002)(38100700002)(82960400001)(31696002)(31686004)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?K0ZzYWw4YlVIZnBKL21nSFdoelZYQTBSODc3MFNZUlVxM0lwalhBcXJUUFgz?=
 =?utf-8?B?Lzh0TFI3aCtDdFoyNFh1Kzg4VG9mSG0zeDJiTUdlaEYvZ3VIeXdhallVMFFV?=
 =?utf-8?B?K3hwdGxKYUtRM3JyREp0c2NQNUlRWkJlbUMwK2dvYUJYUko2aW5OTURaVmJL?=
 =?utf-8?B?SzNQV2ZNY2Zza0hQOHVweVlmaW1vZWc1S1dBWHhkTit1ejVkeGZJUnp4cHpt?=
 =?utf-8?B?dkZBaGpCUUV0ZGVQaWc3TStodG4xNUN1Mnh0UUZjQ0RRMkhneWhIYkI5Ynh2?=
 =?utf-8?B?UnpudHNaRGdmajlma1dCRDlmeEkybFpsZTV4RER3UnJ1RUtZQ21ScEpiejNV?=
 =?utf-8?B?SXg1YksxTnpJMmt1bEhaa0x1Z01wNHZuNW82Q0IrOWtUeHZvNTJVWkV0TFRq?=
 =?utf-8?B?TXlyRC8xcEt2bGtiQUlxRWxKWDloSFNBWGlreFVBVVlMUnFMUDJGYmMyYU93?=
 =?utf-8?B?MEJTNjgwV1hvaTFRYURzbERvOVpQN1FFbEErRGJaUFAwaTV1TmJhTEFVd05I?=
 =?utf-8?B?SERGZkI1bmNReWYxdDFFZ0JvYWpVYmRaZ0RJbnFGNjZsNUY2Nk9DVlhlZnBx?=
 =?utf-8?B?YXVVYlB3dlV6WGZaQTZlMjc3dGpGZWJZemZEb050TXZnUHl0Mll0UTZTakZI?=
 =?utf-8?B?MkhTZkZiY09KWUQwc05qcFV0VFExaytQeFhFYUo2VzErZ3hHOVl2ZENNVlFn?=
 =?utf-8?B?c3pkcnQ3LzJ3OUwxQXpFSVZxMnl4OEtqZ3VPRDdCL0J3blZpTkJVOUJFU25m?=
 =?utf-8?B?M0UxVlBhQk9nc21PUFVmanplOEhrVXp2T3lQbnNTMU4xZ1RxSlZLLytXVER3?=
 =?utf-8?B?SnlLSWw5VnJUY2JOVUVxZG1oNmRpK280ZnlGZ1VDWVZPRVhaQ0RObVpvOVhP?=
 =?utf-8?B?cnFXbkJ6M0UxL0RkMm0rRWU2dkpjc0J3cmI4RkN3YWgwWEJwWEZjOWRKa1BX?=
 =?utf-8?B?a01NZmdKTEFGQkY3YmhiVitqQzlicEgxOGJmbWxycm40SmFUTGFwYyttUkFG?=
 =?utf-8?B?OTROTDlWS1AvL0hsK3JFS1U4WjBBcGNSQ0JpZi9GbmxqVXdrT09tbDZXb09E?=
 =?utf-8?B?Q1IxRWQ3NVgvL1gvd0RpUW5IMEdyVVBoZjhDTmFxVkRmTDZjUzJ1azVMeG9i?=
 =?utf-8?B?SmU5Wk90RXNQQ01KZDRkcnhHeEY4K3g1RFE5em5QMmJyYXhUbHBlblNmTmxS?=
 =?utf-8?B?VmthdEtFLzA3Zm1sQ2hDOWlvT2dYVnhUOS9nWHhJanVLZUFDSkhNZEY1YWd0?=
 =?utf-8?B?ZzlUckdqRWpVQmpZRVR4YXJ0MkJGK09TZjJ1eGtIazhoT0NIN0N3WHBnZDZj?=
 =?utf-8?B?UUtBNHNPWjBqdGR6a2U5dXl0VWNRVk9tcklDbkdxV3QvVG5wVG10cUdkb2Jn?=
 =?utf-8?B?UmVuVFJod3BHY0dYUlQwOGd5ZFVBa0g2aitqbVFQOGZVdUpDZU53c1hkbHhl?=
 =?utf-8?B?N29aVHoyblgvVi8rbExpaWJvRFFGZE1XenVNRVB1cCtCNTBNMW4raWloeXhF?=
 =?utf-8?B?ditCc1Z4UFpZWWZZcUxqY0VuZkpzV1RuUWR6ZmtCanM4V1QrMDVNbEVEUWRr?=
 =?utf-8?B?THloaW9sdTVKUUFyU3B3TmU1SUYzcExoc2dwNkV1czJkOGdwc09DcHllUWtW?=
 =?utf-8?B?NEhiOHNXY3VvOFlRWUcwSlRmMDBoMytzTmprMk92UGxKZElNeElxUUNTbGc1?=
 =?utf-8?B?bkhYZmtzQ0FXcCtFNjJTN1ZOajRuV2YzMkxLdnAzSit3VWN6WHEwWUpYdVNS?=
 =?utf-8?B?OEg2cXhQS2lsOHE2U2dld3Y1bzFwY2wwczJBNUJUWnpxM09BVWlvVm0ydWND?=
 =?utf-8?B?VTRRakt4a0NPazhMVW1MWjZkTGRuZ1lvRFJNL2FBdk1BL2hXb3Bwcll0cHBO?=
 =?utf-8?B?NWFxUUgwbVNJOER2RHpjUjNvbzRMRCtTMHA2TmRLb3Y5THU0aVpQcXV4ODdI?=
 =?utf-8?B?N0hlR3FrcE9aWjBCTEMzMXhNd0ZVSU00aTgrOHl2VTdVVFJZVmlqTG0yL0xp?=
 =?utf-8?B?UDBxQkxFOEpTdFlWWWlKdjJtZDQ1azlSNEdPdDVjY3J4c3hvU3hXMkhIcTg5?=
 =?utf-8?B?QS91d1U5SjAxSk9SbytwNGc0OWF5UmpKUjdhWXl6RTBrcVdaQ3VEU0pibG1s?=
 =?utf-8?B?U3MreFR6ZG5Bb3Z4TzdHSE03WDNnRGJOZWZmLzFXeWV1K09xc2E0N1J2VTZ2?=
 =?utf-8?B?QXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 257f7750-c5a6-40f8-647d-08db0dd5e8c8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 15:20:58.9105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MJF1y1cSLezoRSk3AFsZl+82c6VmjVnf8Ncb8XXKqKCFGFUSvg5HvqZfksfuERrzLxInwwfhnhAjJELwKgkhwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5671
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Feb 2023 15:21:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10683

On 13.02.23 16:18, Moessbauer, Felix (T CED INW-CN) wrote:
> On Mon, 2023-02-13 at 15:51 +0100, Jan Kiszka wrote:
>> On 12.02.23 09:27, Felix Moessbauer wrote:
>>> This patch registers the provided image classes via the
>>> bblayer.conf
>>> file. By that, no manual additions of these classes via kas is
>>> required
>>> and erronous implementations are detected early (e.g. mandatory
>>> inputs
>>> without defaults).
>>>
>>
>> Then why is this commit not removing those obsolete IMAGE_CLASSES
>> additions?
> 
> Good catch. The kas-file changes reg. IMAGE_CLASSES from the following
> commits should be moved into this commit.
> 
> Will send a v5 tomorrow.
> 

Thanks. Then please also check the documentations. There is at least
doc/README.secureboot.md referencing this as well.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


