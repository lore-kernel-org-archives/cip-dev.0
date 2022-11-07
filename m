Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED481C4332F
	for <webhook@archiver.kernel.org>; Mon,  7 Nov 2022 12:59:41 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.84])
 by mx.groups.io with SMTP id smtpd.web11.2870.1667825975699012589
 for <cip-dev@lists.cip-project.org>;
 Mon, 07 Nov 2022 04:59:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=hghg7OuK;
 spf=pass (domain: siemens.com, ip: 40.107.21.84, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J4u1slK18uGmsee7dIXRGuKKowrOuFcFYcm+NqxH4OUEBXGhWKkr8T436fbDhdytHPr641b0BOK5w0dJi8GJWB6dvjTYcKuRG0ZrrT8mbWOi6ne8opWJherpy1iV1DNSVBZynulWdHg+o08Os+ouKivS6zmluECQbjd7cRjeJNVVSk51yfEVvslhUqPhQ/O33Qpcti894VSqD7JAAxcOHZUZ2XOzlOEQe6ZRho3n+8j2pfsW1xbkwMOw/ZBLzJub11y/jSozfDiofGI71Cr8DKmGXYAfnIztsL1dvF1830gKlUqALk5quJI3CfhjYh+vZVL3t7kfcdh2S2AJ60FFhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=na4dQiaA+W2zsATnEVYqBrdcgxvYtWWDnqNRouE/WDI=;
 b=IocEL1WdKeu1wql4L1/xdGJgCREUMBRUVN0PI5fDa8lIaFmD8EaVRIHw2BOr1AV4rPSyPuOIXMECc7JHwcLNTMIMWgMS7tqikpC+UsIPmx4jjNOmeH7C6ykGWz3fCdct6FZuecfMZldEzgmNMY244FVDzjaGXcrJy1jUPVBodvE8cC47M6shDxouKEA6C11T70ZrAJVkjMLLPp50A/3ps/dAGwpFqcByRrCAChpoDl8ayA3h+ftRT+ISriPjBGPON47XSRjo3e6zt/pCZ+RZxTx0npJUWk0HCpxZi7296bJbOJ6CdqIdaGsUds+RLKmfcrkKI7VKGpDuGTmzp9vPtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=na4dQiaA+W2zsATnEVYqBrdcgxvYtWWDnqNRouE/WDI=;
 b=hghg7OuK32fG+lJ0jNUEuCvOjf4CqcoIwiIgwCmWBcv8+lCenU7QIni6y1jI1k+Nh7lDabJQ2TgE/d/q8wevNYMFxr1JnlO8MBbQIPjQ8FrBzw3xutEldKfS4MQG+tGHkTar2UN+clDl/U2gVC2q14SrHyIFHC5UPBoQVcFrtHNGTcMzkjynhctKJdx75QRwE3x+spM0R9sxB9J7MwFch1xAvcGfhV0i/sBxShynw8T10aKWwNjXffioMIxz3H6tnxS/QyO+S9sThkKdju+UOVlEuPXjmYfAdl8IQK1qcGrM0T2s9rpCkE6RyNkjm1AsfrE7CUvm6TBfkzX183cfrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3705.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:132::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 12:59:32 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5d9b:b9d1:bd69:107b]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5d9b:b9d1:bd69:107b%4]) with mapi id 15.20.5791.025; Mon, 7 Nov 2022
 12:59:32 +0000
Message-ID: <02c0cda8-519f-4814-8c86-124c09fe4de4@siemens.com>
Date: Mon, 7 Nov 2022 13:59:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [isar-cip-core][PATCH 6/8] add kas files for building qemu secure
 boot images
Content-Language: en-US
To: "Schultschik, Sven (DI PA DCP R&D 2)" <sven.schultschik@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <20221024122725.383791-1-sven.schultschik@siemens.com>
 <20221024122725.383791-7-sven.schultschik@siemens.com>
 <1da1e517-4604-3eb9-a43b-01705ca434a0@siemens.com>
 <PAXPR10MB50372DB403704E9AA00BFE07903C9@PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <PAXPR10MB50372DB403704E9AA00BFE07903C9@PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0225.namprd03.prod.outlook.com
 (2603:10b6:610:e7::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3705:EE_
X-MS-Office365-Filtering-Correlation-Id: 9da70b77-6107-49be-1e13-08dac0bfe9ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	FNaYp76q8ih0mL3fNT+TTTrICccMlfdWrKfdLkpKHziK4JXrSnS893kfaCUZOLYYaNVHouatnQstekeBIGaln838hL34EPZjgSEYwWO6ZfSQ3v/LvKXebB+Jjmp0WN6J2FHUHbY8AtR5tv64TrzTdh0Hdtw6fGzR+Nie5DIahE0GVTHXhHlZsiNCdZyd9BYInOsQft3x2IhETY9993l9qYjH+wLODEhYgmfeKh9SIm68EWegDFuGFV6dK4Xh8hSYs7itJKdKwjiIxGlRZF6adB4eTNDlHpqJE3GvVTHakbp+90RUMrVv1+cP04/FtaOr/rx5bkNsLVgiwb7va0HgEq+jRwxtn1X+L6z+qheWuDdIBhG6aOOwauxsaoPF6qRf7TMugCfvGxANMq6C/glnqF9B+sQ4sX8UqFBf+Kjpj8LLLBrdp7oQwpd4zWYphIMLQh9doQ1kHBCsZysSB/r+apelOhACueoilGPhAHU0QpNWrgBkkaWo22cmhbpyiaeFjtjsBDsSiFmmQ2xqyOLIZIov+pjhuss15v7HiwIQKJFUG1OQWEws8CEKdb7Z4u1PfU35RibPU0VkKdyI4TbGRfkbB9w1ANZjAsZ6ngln6EmIwlsvXdyVkyNrdawk9q4/oCj/L3NeX+Um9Q4VEEXmOoOfcbJUSKyJS/dfr6lNg58vn0wRuz9UIIY7KzstmjMnEXoUQZSnwf3ByLUIQ8k+KNlnX8doglyPbJfAxmlqhvnM8uy6TcCXWr1yUNugPjhiKDVF484LeTGP1oxxqFEkdHStshdAllNJOBt8swTLi7A=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(451199015)(36756003)(31686004)(82960400001)(31696002)(86362001)(44832011)(4744005)(2906002)(6666004)(53546011)(26005)(186003)(6512007)(6506007)(2616005)(66556008)(66946007)(66476007)(8676002)(478600001)(110136005)(316002)(8936002)(5660300002)(6486002)(41300700001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OHI2c2NsTG5YblRlOGN5aVVmM1Y4Y3A1NFRpTkUyalpiTTBxRmpTRlByR0I0?=
 =?utf-8?B?d3piOXJLcWVFQUZFajNYLzF3alBpTi82eU5TWVUyZnF6L2xIcXJUTHNNaVNX?=
 =?utf-8?B?ZDg3emJoSUMwY0FJRmwxemxQejF2a1AxKy8yRnV1V0xSbzZTSEw2VXB3d0g0?=
 =?utf-8?B?QytueWhJdityRCtjUW1JQk1oNlJiV3FwTjZ1NFhsZmN6SUIrMGM1ay9BLzBx?=
 =?utf-8?B?eG9FdDlrSVVzS2FhSXRnWG5JMllmbndnZ0l3MWlSUjdCSnd4emlTMVBlYTgz?=
 =?utf-8?B?dVZrN2Y1Tkpmb3d1cHJJejNXNkplYlo3bGtsYm8rNElwZW81SHM2c2ZNYnF2?=
 =?utf-8?B?SDhSZzhMSTBVbkNPQzRocVFpSFQ4VWFPTkwzbmNrbVd6VlNka3Vlb1hmeFk1?=
 =?utf-8?B?Y20wUFduSWtHcEpNYWZ5RWpsek1GV0tGV3d2S1R5TUJXS1NpUCtRNkxoMmFx?=
 =?utf-8?B?czBFRWt2MmFYNnEvM2VOMXMwNFBMOTFiemlrcUNkdXpWRVJYYVdBN3dubHdz?=
 =?utf-8?B?WXdpb2xtM2xub2I5TU9EanVvcG82SWk3aVdDMGtUSFZYZHVneDZOZEJsSEQ2?=
 =?utf-8?B?RXpFbk12MXk2Nk9EZDRBT3B6OUFwOTRNUDBKZFN2NXBJWFhsanRtT0kwYXVD?=
 =?utf-8?B?MDBMVjBWcW5EQzJHNTZPNEVIVWFtbXQrZ2ltVEdxZTBYVlZVaVpXRTNHREdH?=
 =?utf-8?B?c2J1K2J0ZjNUSUcwYmZrZUQzRTQwazJTSzZNcVFocnd4elJzd1NXU0FtbXBH?=
 =?utf-8?B?alIybW5UOE9IaFM3L3NoRVVFVUMydHJUdDJBZnRoUkltQ2xnSGJYNVpLbmpN?=
 =?utf-8?B?Yk5sWXRZVEFQY0NMSlRQaUkybHhlSUo5N015TlJrMmQwVVdQd2FPOXJmd293?=
 =?utf-8?B?MEtPV1Y2VktocUZvTjVYK2hLRmg1L3pGSmtLVHpPK3Y2ejFoNlZTUzVNSVlr?=
 =?utf-8?B?U282QXpOa0c1eDVOcERYN3oxRkZuV0pVOTk5NXNxNU12WG9hUUU2Sml5R0pS?=
 =?utf-8?B?NUlhYVRsRVpOSjVnZzBZVk5JK0x2S2tWMktTVkp4djh1QTRjMXNYRlVxY25m?=
 =?utf-8?B?ZG1NTGRWWlM1ekVEa1k2dmFJcW9JWm1sSVZZaGowL0xUVVRaQlM2YlFCNU5S?=
 =?utf-8?B?aUxtdG1PWXZGQlZVcjAvSTAyR2oxcEEwdzFpUGVBTzNvZDc3dWtWejg4NlZY?=
 =?utf-8?B?QlorZkVJeGRnbjRLQmRjTXhjRmtpWlFOUTZmMXg0aUtRZ2xCTTlHWTh0c3h3?=
 =?utf-8?B?Ly8vVFlydVF5eUVjVHZtRnRlSFJXaGRWejZBT2tDZUVNemRsYzIvVVBmaDZ0?=
 =?utf-8?B?Y0FQZHZYbjJUNzJ6MkFnY0lyV3poNVdQSkM3WU1kby9OS1l0VmhJV3BLcFk5?=
 =?utf-8?B?SkthRUlObnJoVUxkZDJQTkwxTWtiTHF2YndId3dsOXZxQ3hhMHBkZ3lMZzF1?=
 =?utf-8?B?a3RDWHM2TDZ4Mk9Ka2hrc3p2WXY3c1FPRDF1Z0FTYmVOWUhxcDRCQXdLanhT?=
 =?utf-8?B?dXcwVHdmbWZIak5oVzZTbGg0bnJ3S3ZxdnpSTHRFZVlteHNiM25YZTBrVENO?=
 =?utf-8?B?QWtaNmw4OTB2WlFiK3RubDIzU3EyOUJJNGZScDlCblZnM25PRkc4cHIrUmJz?=
 =?utf-8?B?YkVteER6cmw5Ujc0S3BiWUN3a09qT3QxcG5LUm1QcTJQMWJhajdHakgxNFFP?=
 =?utf-8?B?ZTZoNnJKOFVLa0Frb045UDBiNERZQU92RXBKQmwwNUNxamxoazVKNVdyU1RW?=
 =?utf-8?B?ajFCS1JQemprbFdycVA1cEtMN1BRb3BXT3BSdEZwNUtkbXVLaVBVSmQ5QWZk?=
 =?utf-8?B?Q3lPcTlsWkQvcGxlK2I4a0ZHcEg4TnBJZXBTVTNURUY0TXcxc1FCYmNNVnJX?=
 =?utf-8?B?cUo5aXllREhmRXFXVXJLSngzd1JBTVpQendqQXNENWxOODlXbWNLTm1iUEtw?=
 =?utf-8?B?b1VpVWQ4UllmNkFqVE1OU0JOeUxNTk1Sa0hCM1U1Q2VVaGs0TkJNSURRbE9V?=
 =?utf-8?B?blRXYTRvOHhKVVBPVlh1TE5rMGt1c1ZNYlZ4NzczZUN2VGdCWjNBdUlHUXhi?=
 =?utf-8?B?ZklUNlo5bEJ6RjhROXJMQjAzSDNuSnlnOW5rcElpZHpXK0Z1bnRld0NPMmRa?=
 =?utf-8?B?MkNPRzdSK0pZZ3V6VmxBMUdDMnNYV3JVcFRoUFR4NUd2K0dtcnRnb25VeGcv?=
 =?utf-8?B?VVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9da70b77-6107-49be-1e13-08dac0bfe9ff
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 12:59:32.5175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r8IF3Ghd4FK+c1ZAXZgYSUBWHGcNxa8dvx3A2ubP30FO7d+sK1hxtGExA22eTgnTf5oxPH1JRJ6O46UKYjcjTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3705
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 07 Nov 2022 12:59:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9940

On 07.11.22 11:43, Schultschik, Sven (DI PA DCP R&D 2) wrote:
>>> +local_conf_header:
>>> +  trusted-firmware-a-qemu-arm64: |
>>> +    IMAGE_INSTALL_append = " trusted-firmware-a-qemu-arm64"
>>> \ No newline at end of file
>>
>> Why is this still needed? As discussed, we want to have (QEMU) u-boot with TFA
>> and OPTEE when secure boot is selected.
>>
> Looking for the right spot to place the dependencie on TFA.
> Kas/board should be kept clean with only machine option set
> Kas/opt/ebd-secure-boot-snakeoil.yml should work for x86 as well for arm
> 
> So creating a ebd-secure-boot-snakeoil-arm64.yml ?
> Or is there a pssoibility to add a "if machine qemu-arm64" to the ebd-secure-boot-snakeoil.yml?
> Adding it to the secure-boot-secrets.inc is not a good spot as well.
> 
> No idea where to put it currently ...

We already have the override "secureboot". You can make the qemuarm64
specialties depend on that.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


