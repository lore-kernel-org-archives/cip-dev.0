Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72710C25B47
	for <webhook@archiver.kernel.org>; Fri, 27 Oct 2023 15:19:27 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.50])
 by mx.groups.io with SMTP id smtpd.web11.9540.1698419964976718246
 for <cip-dev@lists.cip-project.org>;
 Fri, 27 Oct 2023 08:19:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=tbHIzfUd;
 spf=pass (domain: siemens.com, ip: 40.107.21.50, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UeLSb50Pxry6ShqLyWJLJGcAJxqvmGjXcDOfC2wI+46VI7+XI5XEjQBuQWtk455cI3ueggmPGYxE7cS+lv+fPIhjgZQMNSSbjxFX3Enlr6S13VJIe4pB0EHeiqM+nf5N+CztaLykLnPhwwpZwK9kmaPyQNR/oYGFrJ6HQNEFR3H6YaJ+NfwUNkCfVcld2KFj17NRkPyfISxFMo5ElPEqrVu9JuxW9dDUVcI0Qd8v0t/igOXi2/zqF8QX634JwSD3ncrMY+q7RJkgV45HkVhW/OTXHuGugQvrWp6ySvIt0F7p0lvdb90PQBtbn7q0Ku7RliwxVX7VUU6RApQ44gwmxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V9Gr2XS9TVzLxfsEEmAdeTcTimnqTB+qQ0gFJg/hQac=;
 b=IGnqLjGBTViRZyTDHpzYgNXtAsYYF8OtbO99A+KrF2H3q4IQv7od6psiRva2xhH8xFLkFeBvw6ygZIF2HtnGddExs1I421j5yUC6BU+og5JrwNb4gunfAbPOMj2fgKMy7f6rRUEh0kRMznsUPQP/Ngq7TJ27NPmaglec80q2UVu8hulrlD8o1t6N2Y9jsNqCijG4DfhVaEJMUNriebdoLb3kHL4KWcsfiy9tJUVdk0YTd4mGSiE46z0OwsrmkvWHBSPMiMP2zamh2NZEW2b27NCSx61r8hiND6RbAyyuxjchXSRXED8MeYSRXQSu5PFtblvYoXB3D9DFkw0E1QZbCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9Gr2XS9TVzLxfsEEmAdeTcTimnqTB+qQ0gFJg/hQac=;
 b=tbHIzfUdxMIj7BAEm1MOiLS6pjVGq1XCAykmXghu5jsGZONhDiuwBoX+/XAXRQhBCcoms6hmMp6rEwEwZlwyheTVVf/Jh1AbDrbxY+jafh8OyuzmZUO1vbxYwZfqs1GnjSaOXo4TwMyvqBaM1ui5KkEu+fNtut+uDEbZm4safdGHpUnEOxWbh2g3QZs+IKmZ+xAmdkBjODrjMve0lObCtIRwwIz7Jb8izc/2/Fnin2uZiVX0sLA2cKhE5BsNXM+Swq5BbixGaL4tr7StRy11OA3dmqvq4INVrElqk4GhjWQOw3sU2vfeM/YtCF4AaZ9U4sP0mse2GGRlYqZ7etb7Ew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DB9PR10MB8165.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4f0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Fri, 27 Oct
 2023 15:19:19 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5d28:13c2:1583:fabc]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5d28:13c2:1583:fabc%6]) with mapi id 15.20.6933.019; Fri, 27 Oct 2023
 15:19:19 +0000
Message-ID: <b19ff39b-91a9-4497-b467-0c2cb4044d54@siemens.com>
Date: Fri, 27 Oct 2023 17:19:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core v2 0/3] Enable swu file in repro tests
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>, venkata.pyla@toshiba-tsip.com,
 cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <92324ead-e15c-48fd-876c-41398d15a956@siemens.com>
 <20231026082959.16939-1-venkata.pyla@toshiba-tsip.com>
 <e522085f-7a17-49d3-b4d5-61a01c847ebf@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <e522085f-7a17-49d3-b4d5-61a01c847ebf@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0431.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::19) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DB9PR10MB8165:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e404e4d-f236-4695-ddc8-08dbd7001755
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	G+kK6M4pBkpEd1ae2ZxJG2Wr2F+aw8bgoXT+CBHKJxDckIQVLvWOxfoPOURxkzEb+CtbUVtBwp6jxzCdC42L6pVgNfWeHvotYsLfJo/6NSDYDXrc/X+CPz4xpRMu/oN/+p/qvGqZbvQYbAAy0gbBK+WfzV6ZrrlJeiTzmYh4L3nSQFziaOldc3/nwJldroKcZslEvT29v+FbFBzkwxqo2Bknc6rkcp0vIMdkWSzikwTffipkSThiYl4gk51dupqaVhKh6WZt8gpCMPUMIVDKhQMXH/6EFYm8dDPHVBQai/f3caVsbJ8uTTNwDvzNoA8GtKd+kUuk84gibnOpnDKZVr6aIiYRlXzKQ64C/sP3eEOTapAyXtv6iAbdxRi7JI7jEO1AZ4GfW1r1KWL/ZLo7aBENy86mr49waiLOkHmtTtcffy9XRw+7IIomxyMJorBWvr9tEhfS/ab1PKwRkqbvIo57YfsaMu9WnTfWmktVM9PXwR257UMB9FSJwIFTIzX80orA8WpZhg83XD9ZzeTdHyk2+3qOTrboev70rBK167Z6KUHnbMSOHEkGfC1HHfonnPGgck/B5s8kv4TSqgfl3XDrj0a++skueTkMrTUWSFNGEZ+rvzPnA+a5k6u+FLdlFS+dPdtzPHqBGX6N3zE11Q==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(396003)(39860400002)(136003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(6512007)(2616005)(82960400001)(41300700001)(5660300002)(6486002)(26005)(8676002)(8936002)(4326008)(478600001)(66556008)(66476007)(316002)(66946007)(36756003)(6506007)(53546011)(86362001)(38100700002)(2906002)(31696002)(4744005)(31686004)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?b2ZLelFJemh3SVoyVWZFaFlObm82ZUYyZDRsdngrUzM5dTk5OG1TdVpJS0Vh?=
 =?utf-8?B?bWRsczkrajFweGlXRCsxVnJDZ1NMaDQ3bVEwRC82eFZTc2g5eVBUTG4zU3py?=
 =?utf-8?B?TUNjSUtHZXViZDU4RGNQV0daSXN2aXJVWW9OOTE5RmxGQXNIYmkza285VVpo?=
 =?utf-8?B?NU9FaHpZQlVOQnRaaEdncXh4dXpPZ29JZXhsREZkSmQvUnJ5VXIxMUswRjNY?=
 =?utf-8?B?VVNZMTUyOEJ1VWJrTUx2UmRxYXh3MWhlUDBzWVZsaU15WExDUmozZjdDNVYv?=
 =?utf-8?B?K0xmWDdFbGM3bm5KaHAydWxmRklKeUdsbHRHdXRTa200WlVuMjFFRXJlbzJw?=
 =?utf-8?B?d0RhdER6MjFnc2ZmbDdFc1d6cG0vZkM3ejlPTVJZZzVMdmZqZnNqZjBId09v?=
 =?utf-8?B?b3pFamUxTS9UUEJwbzUvdWcwVHdOVU1TRkdEYTZRbUZGdS9UdUp5ekpzUnhD?=
 =?utf-8?B?b3ZZTVhIWU1xZDNxUnJxUzhEcUdlSU4vaFVOUGwwYlhqbXBabURQay94a0F5?=
 =?utf-8?B?blVGZXo5UE8rMERONXBaUTlUMzI4djRacnJtWWFlWmdDT01JbEZYWW9nY2hv?=
 =?utf-8?B?UVhtNThyblkxS3E3bWFUREZGTWNhRmF3TlNHbEdzd0JZQllNdzVSUGUzeCtO?=
 =?utf-8?B?MHovUEMyejh5Q3Z5Tm1iNDhJK3pNNGhINDVzenZna1BqcW15NVNJR2UxdkF0?=
 =?utf-8?B?aWxSUm1XcHhWbFZ4b0FYdWhzNjJlNUU0Yk4rU3kxRkxwTlJ6aExseDdGblVp?=
 =?utf-8?B?RE95b05tR0RYU0JYS2I3MzZ6Qjk0YzNiek9kWTdmbEpLTXlSQkJCZGltQTli?=
 =?utf-8?B?WE5DekV4SnFWZW5MT3Bna3JNZUx0VytBcDZzUnVxUHZoRjZ0L0lUMnNua05W?=
 =?utf-8?B?ak5DSzhWby9kVk9Fb0lHcHlydUdDOGRjMlNIT0M2RUVFQmJIanRWTnVVbzl2?=
 =?utf-8?B?ZnpES3lxM1dtQUlseW12RHJWZkM2UThKQUJpSEdUZ1hXNGU0OTBFeGxYUkpr?=
 =?utf-8?B?czlWU3lwM1lWMTllYTdLeUtTMWNubnJwNzNvYU1YMVB5ZXQ5V0VnK1pTM0g3?=
 =?utf-8?B?cHdzVVNTTDI5Q2VJS3BBMjhFSktEdDFpYVY2UTR5R05pb2dHNFBqV1pQTU4w?=
 =?utf-8?B?SzJTb0NnMk1xWGJ0ZFFmZmoxZWxmS1VJYjE1alA1dG55LzZGWGZNZk51QTVC?=
 =?utf-8?B?SG5TejdQWE9FeHUwaW9UNVoyWjd3bE1tZWlaV3ZRR05KY0w3eGNjWVp2YWFY?=
 =?utf-8?B?cm5JYU9qRnh2dUZQdzZ2WHJkQzhLSDVzOE5MVytNQnlXd0gya0lud2pDb0Y5?=
 =?utf-8?B?cEY1cklOTDVhcTlpZEY0ZTFabnllUUp4ZVdaaFFBcWl4SnBycW55cVZabzdV?=
 =?utf-8?B?aTR6a1lHSTNoRElwWTNiTDJOOWRVU1ZYQlJVV2JXbEQ3d1M2M2d6czRBZVJQ?=
 =?utf-8?B?eTlRRm9sanQxZGMyYVlWS1h3RXBIMm16bW9tR2FYc0NGMHZCUUg3NkVOM0ox?=
 =?utf-8?B?Y0lkMGplN05sSm1rQmhCVUkzemdnYVhZVG5zdzYzZHIwcXphOEdZR1hNQnY2?=
 =?utf-8?B?MDliTU9WRGVUY1JsUDc1VHFJUU5SeG4wRWhXc1RkdE5pY2s0RmtTNk5KbnZB?=
 =?utf-8?B?THlTajdKaHVBQytMTGNzZ0p5a1ZkYVpDVnlrcHZiL0RrdVdObFFPa28rV1dL?=
 =?utf-8?B?TVI4WnBxcG9zb1ZhM3FibklUbTJQdmNMWGpPWkFXK0w4Vm53NGlnMTAzaVR4?=
 =?utf-8?B?c2QyZ2dlOXovM1BmZXBmRU5wbnZubWxucy9oNTRrRDQ4b1JQWmlPcHUveGFR?=
 =?utf-8?B?VER1anF0clZFUHZybytLcklhcjNGUmtDZkNRclVRRGwvR2k0MERBVlhDTTR2?=
 =?utf-8?B?cGVsZXFUZURSWkVCRjFyZVVkNnpYRk1JNUpOSW8ydURQNko5cjZmb2VPcHFy?=
 =?utf-8?B?ZlVMM1R4R2tRbGtJMGpvWnA2emU2L2VNbFhOU0M5ZzlCYStvYm1qNkVrK3o5?=
 =?utf-8?B?WjBqREtURFJrUnExc2pTRmxmL200OUdvUS9xS0RLWHlaWlR6RG5FNE01L1l5?=
 =?utf-8?B?TGVUV05xUUlPTFJtbzM4Wm1najhyNlFVeU9kWkhCcUJPdU1aaTgyWXUyWm9n?=
 =?utf-8?B?RmEwVWpCOWVBMzliWjM1d0FtMlJadU84bFRsZGZhNWdCa3NvclcxMjh2cjNS?=
 =?utf-8?B?bWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e404e4d-f236-4695-ddc8-08dbd7001755
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 15:19:19.5672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uUL/ykcKi+6nlL9cLjQt1u5rFam0EbSjsZBJwwYNuJm8i26qnKnDhuSrX+BhB4jue4ARyjT6UWjJVyzG+ZF6YVcFtPSAWIp6qx/WAdwngDY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8165
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 27 Oct 2023 15:19:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13484



On 10/27/23 15:43, Jan Kiszka wrote:
> On 26.10.23 10:29, venkata.pyla@toshiba-tsip.com wrote:
>> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
>>
>> Hi,
>>
>> The following path series enables SWU file in repro tests and fixes
>> repro problems in swu file.
>>
>> repro problems in swu file:
>>   - signatures in swu file is not reproducible #80
>>   - linux.efi file in swu file is not reproducible due to file timestamps
>>     are not matching.
>>
>> venkata pyla (3):
>>    reproducible-check-ci: Include swu files in reproducible tests
>>    swupdate.bbclass: make signed swupdate file reproducible
>>    swupdate.bbclass: Use root privileges when creating swu file
>>
>>   .reproducible-check-ci.yml | 1 +
>>   classes/swupdate.bbclass   | 4 ++--
>>   scripts/repro-tests.sh     | 1 +
>>   3 files changed, 4 insertions(+), 2 deletions(-)
>>
> 
> Looks consistent to me. Quirin?

Looks good to me.
Quirin
> 
> Jan
> 

