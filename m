Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988BCEC8727
	for <webhook@archiver.kernel.org>; Thu,  7 Sep 2023 12:57:50 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.48])
 by mx.groups.io with SMTP id smtpd.web10.12023.1694091460913013199
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Sep 2023 05:57:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=iC14sxbT;
 spf=pass (domain: siemens.com, ip: 40.107.22.48, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XkiwgYWDE6o8+7uGfrzorLWJwVoeImhFI83qqLx1yDnPKoTxK63WSfVeBMR7GbvwQnUh56lM4rJGne61rfmSPxFg+WcW9JkJjO0nJczFUv8iTKhPOOFuXd81FaLyIHVxjPBn5hZqrlAi0d1F5GkTVv3bQmUjmwaRxeXBHBg/CdxRGPAKejx7BnAi9QkNSh9m9PSLKeJIrrMxRUSfA9E5/cqzMFOU5paw36Z2Y28o/zIWwsou+M6dfpJC996gpxY/e5HfQYXTLsuTQoPa1bkYE2wYMZoRRFewXKS3yYFc5buxRbGgfdrCoFHtsjnJPP0TNuy423jZ1YF0jx+7a8LMKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k17JPXF+uNsum2fvSQKZaA4UgBkbX+hX/nnn/IxI2lY=;
 b=CvDkMZtKZFrV9SZOtdgizqf0od/REwRYvp+QNVYFGllk1ypzpU3VboE8Eleu98e0efjYcDpUfjzFsica7hkhNuNUOEDdpZESAleNL9VdIqN2SEWUaG42Jy30Z9XUQ4jFOXUfhQmocWnf3KMYfB9yszTk9z+A0/hXC95pkvzSt0yRvp62sLd4czDmPMsjYOc9yRL+GN7AiV5YAarSOynhdGR4Qi1NfoTpCowB1VXF5KxcS3db6y1ObRzuZbxt1vtHCDV6zDcQnX4TQnJ7qh7nhqs9Py7LhinF/KH3IL9Xg3OU73xpGqn5OcXueoMf8EcwbkrzVquKgEDjtzaOTrlqLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k17JPXF+uNsum2fvSQKZaA4UgBkbX+hX/nnn/IxI2lY=;
 b=iC14sxbTS+yQFjwuilCffT//BJ/bRIU2qXCygsKCEQmcwPp9xNF13Et8Ir2GEK38Z23qB+2eIBgHAeMpX7bygMTVsDeMsxax3oTE723/BBI3Nhl1nKoquX65s02vXWpM6KoXI3WD9B6N2ZofXGgrbHiJ85udGcApaA5NpM3t+TrXpMOPjl67a36w8s+KLU+/Ddqk15NxZ8hSFH7xccKiiZowKLsE4U6pDx/0DfRyIDra4HkGIvQBF2TkYE0wfIaKhTGsxTOJJSrryTFK4Lf6xs3OylGGPeMTabZwsf9oR5c5UvFhTPkNvsSAdqGFhAtA9zEAF2e4tb2RWNfHvHgdIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6028.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:8c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 12:57:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6745.034; Thu, 7 Sep 2023
 12:57:38 +0000
Message-ID: <14487a2b-4d9b-4ddc-9481-e01a70cbabf7@siemens.com>
Date: Thu, 7 Sep 2023 14:57:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][isar-cip-core] secure-boot-secrets/files: remove unwanted
 link files
Content-Language: en-US
To: Srinuvasan Arjunan <srinuvasan_a@mentor.com>,
 cip-dev@lists.cip-project.org
Cc: Srinuvasan A <srinuvasan.a@siemens.com>
References: <20230907125148.10628-1-srinuvasan_a@mentor.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230907125148.10628-1-srinuvasan_a@mentor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0205.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6028:EE_
X-MS-Office365-Filtering-Correlation-Id: 442fa369-e238-4455-6e30-08dbafa20349
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	HaP2B5Vcwpkct1LCFckQGQVprcdLmGh6peR/i2eL8jgjM1b82OHjHMZDJdwjz6OYxhqY0H3i633wdQBB81Vc2rOhZ3cgni+0BD4AR/5QSBmRnkbTzvExr841Hayibezr1WcmLaf+yzadq19Osg8L5CBrIppVEdilJoV/Ix1DQOvCHVnplCZF0H2nQaMvZUokM9cx8eTlh0BA1trWg0M33oo2MRuF393nP/K/bJTGMJmW033FtnX3x3FBxisPGfqFbeWUroL6FAENzONVJx84EQ0Srke/yXiRLm7rvxLFuPor75UDy5UgoezyS7UL9xgmNmukOejKOxQpiy+juvRyGcfPZIAFZGe+jPpxK5WIDunGa6eY8Du+T6tC4ui7zJTAqcFYp+f8AeqOuxZE0Azot0RkpQCzkEtyyo4bruo+oNNoVHG+8Qh19OnmZgA8cjP+U0WFuoQ8Ax7gxNKOIDe92IhBd3vD/K7vA9I5WEck3Ma+8itQpigmC20SJTOFQyb9H2TX5uCKcKSSrIIGZjLpwuKtBHvvb18LS5ohyIMZwyeX/gYea7iirx0eSVo7R3KVdw2DhQqp1ldHO5Owmde37v8lUArCOCVmMRCCZ06lSQG6bB7QQsFQu5mdMxo895RMaODjHpnK/A1fdMUriubk1SqThpy3BW0bNjhj5/0YOvg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(346002)(39860400002)(366004)(451199024)(1800799009)(186009)(53546011)(6486002)(6506007)(83380400001)(6512007)(478600001)(26005)(2616005)(2906002)(316002)(44832011)(66946007)(66556008)(8936002)(8676002)(41300700001)(4326008)(66476007)(5660300002)(38100700002)(107886003)(86362001)(31696002)(36756003)(82960400001)(31686004)(26123001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cWVXajBPSzg0U2RxYjFZczU5OGZGaGZpeEV0WFpBR2l5VUxMb1ZFb0J2NWNX?=
 =?utf-8?B?eFpXWnZXQjdQcVZycG1rYjVRZHpxamQ1TDdqQ29qYktsM0xMR0tMQTdNdzBn?=
 =?utf-8?B?a2I1VTN6Qk9ZeUhJUVRoY2RrcGhlRHpndmlmREJhL2QwRWx6R1k2blNaRFdJ?=
 =?utf-8?B?VjBPMWZocEpnSHhLNW5ZR3J5OXhFK0FjYkQwMnBXZmpndE5WaUJYRCtwbUd0?=
 =?utf-8?B?cUtMQ24wbXlyWVB6SFBYTCs1U2tEVElJWDdNZGZOSGZ5UDFZdDV6U3pyN2Uy?=
 =?utf-8?B?K2hPOXNHYnlFTWtuRlN0NlBySzJOQWkrTzZoN0ZudmFPYkJmb1FTaUdnRzFF?=
 =?utf-8?B?cVF0REMwWVJVY3VYK3JmWlJmOVAxak1wdE9VQzY1SlN2d3BmVlBpQyttc0I2?=
 =?utf-8?B?REV5anpIdkQyU1YrbVJMa083UnVkRFh3UE8yY3loMGNRV2JSR2pKclYxanFq?=
 =?utf-8?B?bVlFUW1YZG1ibGRHR0JJelBiSWVNdDV3NUJvalg5a1JFWEZuM1VFSEp6MWNs?=
 =?utf-8?B?cFowaDN3aWw2UGhoR3RuU0RXS001Qm1FSUI5V3ExWnFaaFlyNjJ1NnhBdXlz?=
 =?utf-8?B?ekx3bjJuTy80S29ESmRBN0gwMHBkQStKaWhHN1gwam96SXNkWmN2SGJndlhP?=
 =?utf-8?B?akVnalF5WVVDZFhqNEk5WFZCTW5hRWEyTlRUNDU3ZWtSczNZZlZqOXJVZ3JI?=
 =?utf-8?B?ek1wTTI0bGx5Znk0ZERDYzVUbEJaS3hGU3I3enAyeER1aWJNSjVGelhvYU8x?=
 =?utf-8?B?QkZ0TlBRRHBTRFpXNFBwTkU1QnVyblV4U3B4K0phazJ3SzRKdmQ2cThLanNH?=
 =?utf-8?B?cWc4ZEZ3MEVWYTh4RVF0ME5yNUNtdDh1S24wb0tRMG1YLzRVZDZuTTVWKzlu?=
 =?utf-8?B?cW5uSWljZUpETnZiOEVLR2lzNjdaNkE5S3R1c2JadktNVzdIcTdPaENhbEEz?=
 =?utf-8?B?TmQ1aTZpR3QvNXRCeHRTbDROeitxTThaU0lXMmY5ekZrN2lFRktwek5mMlAz?=
 =?utf-8?B?azVxN2tpdDhmb2xwYzUyem1VdTExbUpnNFZXby9oR3djd0VHcmE2aVRiTzNa?=
 =?utf-8?B?NGxJZnJ1NS9MaFFyVGIrd0haWmdvRXdjUUMrbkRUd0RNVVB6WktBSmFkUDY3?=
 =?utf-8?B?Wk1ZM0RtaFlmRG0ySnFUU3B2cUd5bWRGYjdsQ2o3OVkvSUlwZnQ1VUlFb2NH?=
 =?utf-8?B?SFJ4NURLQ1NpZDc4TW1VUi96bEswVitXWjlNd0loeGRwUG1EUG9MUUtrVFlx?=
 =?utf-8?B?Q0xpQ0wvYjFNTTBVOEFRSmlaZ096UmpRTVFOOWVEdzJ6allWbnVvdGZOOTZP?=
 =?utf-8?B?NTlYZHg2TkNxZldpdVZVd1NRZnJuVk5TMnJzb09MQ1BOUGNMSy9iTFFOeFVF?=
 =?utf-8?B?TFE4enpGNFdmMmJiQTJ5SWlUOVc2MndQMEM0WFRtd0xGNXdsMWI1MGZDbEJ3?=
 =?utf-8?B?VHdvSkRadTk4V2RLNUFMOWJ6WHBvbW9ZMUdpRFdxK1lHS2RIZWVOMHpuOWlw?=
 =?utf-8?B?dXFJeVB3RkxIZHpjRnJnZDJEMmpnMklqcXZ5bEQvOUN1dE1jVkVGSEM0aDNm?=
 =?utf-8?B?a0RXNHROYW9TNldkd2JOQzJ3T1BDSGI3Nncvd1JBTkI5NWZ5a09kaDdUME9C?=
 =?utf-8?B?OEFRUkZ2TkhyblpPQTI2N083MWJIdDFJTUs1allKRzhwdndCRFhzcGJtMG1i?=
 =?utf-8?B?NFNodjNEbDJGTkZ3cThmbzB0c3hNUkEzbkNZeEhGN3VXVVhkTjZ4ME40ZDRl?=
 =?utf-8?B?RzZydncySnRLU1VPdGQvZ1VXYnVoZ0h1N1p2SEcyMzVsditVMnhtOFZ2UXl3?=
 =?utf-8?B?WmtpWEMzaE0xNURtT1RaOXE0YWk0RlhHa2JZU3VoL094bXFueGV5RVBmeW54?=
 =?utf-8?B?aWdiUXdPekloaEVIb3NFZHJyUm5uMVh4LzVTVzlSY20rMnZBU1VhdCswUXBT?=
 =?utf-8?B?TTc0QjYrdnBkL1JneEd2c3E1S2Y1bjZhTStXYWszS3hjcU9sNnRiZitwOHRC?=
 =?utf-8?B?STZVaFBCRVFKY1pUVFQ1MXhMQVZkeExPdFN5bHc5OGdLRFQ2eU9vN3QxRFZW?=
 =?utf-8?B?VjdJblRKUjVqaTIzVzlaT05nanBySVNycWNSa2U2QUlKUHNibjZwM1Vsc2Fl?=
 =?utf-8?Q?hHJUhbwbC+YS2uDauZwdGpg2c?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 442fa369-e238-4455-6e30-08dbafa20349
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 12:57:37.8905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /5dbGLTdZpWGkWXH4hmMxlMSB0AkFFEvatom3kX9b5Rk9AuCpB+VvJlbR1sA2ZGfM6N3/bToa3kPfDsQQqLEmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6028
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Sep 2023 12:57:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13003

On 07.09.23 14:51, Srinuvasan Arjunan wrote:
> From: Srinuvasan A <srinuvasan.a@siemens.com>
> 
> We have soft link for all the codename to fetch the keys, observed some
> unwanted link file available in buster folder, hence remove them.
> 
> Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
> ---
>  recipes-devtools/secure-boot-secrets/files/buster/bookworm | 1 -
>  recipes-devtools/secure-boot-secrets/files/buster/bullseye | 1 -
>  2 files changed, 2 deletions(-)
>  delete mode 120000 recipes-devtools/secure-boot-secrets/files/buster/bookworm
>  delete mode 120000 recipes-devtools/secure-boot-secrets/files/buster/bullseye
> 
> diff --git a/recipes-devtools/secure-boot-secrets/files/buster/bookworm b/recipes-devtools/secure-boot-secrets/files/buster/bookworm
> deleted file mode 120000
> index b7dbeb4..0000000
> --- a/recipes-devtools/secure-boot-secrets/files/buster/bookworm
> +++ /dev/null
> @@ -1 +0,0 @@
> -../../secure-boot-secrets/files/bookworm
> \ No newline at end of file
> diff --git a/recipes-devtools/secure-boot-secrets/files/buster/bullseye b/recipes-devtools/secure-boot-secrets/files/buster/bullseye
> deleted file mode 120000
> index 3c7fe4f..0000000
> --- a/recipes-devtools/secure-boot-secrets/files/buster/bullseye
> +++ /dev/null
> @@ -1 +0,0 @@
> -../../secure-boot-secrets/files/bullseye
> \ No newline at end of file

Good catch! Applied.

Thanks,
Jan

-- 
Siemens AG, Technology
Linux Expert Center


