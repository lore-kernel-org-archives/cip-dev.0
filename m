Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8AB1EB64DD
	for <webhook@archiver.kernel.org>; Mon, 14 Aug 2023 09:55:32 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (EUR01-VE1-obe.outbound.protection.outlook.com [40.107.14.41])
 by mx.groups.io with SMTP id smtpd.web11.103936.1692006930889553876
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Aug 2023 02:55:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=q1Oi590D;
 spf=pass (domain: siemens.com, ip: 40.107.14.41, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UgBZFaO20h+lJAh4+TvAFDMvrIVEJ6MFB6w4SllPqCYJ0XjUfhkG5R2rqCfwhib9tchd/cftXObUjCpFSHYU/aMf7Dk3M7IfJb3qghvGWWwM3bLBrQDOVQKT8Ubxw79sKMLz+CuZF/oAJ7+zvkumWuEuB6qATZYgyLBO/ZQ98eShpZVMnxsPB7CKCt9iTWMIY8o6TbZvv2dBVujtyo9VGUc72pDwk5mnx5lijdZZ9m2uw23A+lcfpMXlM8Y1Zemk3pAuE3HO5MSFGuMBAgvPdBh5rJUWoYqQLFRfIRqg2+XtVANnEDDGAvkUmWmj6jEGMYurAWsotBiway+ErQpyMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gqqotXvy/3vj8Zpsb4Qkl3z2HeOuFRlNm0ZHdNt+qi0=;
 b=XkcVOJcMdBvWxgDcblFbaviaaJZS14Sxv5PpJI00u2cLlSS+jIx1IdMMPPyoVLqUB4vW9muy+ZJTGaFvjhFd14ekK5FzRnwDSLuT3iaTqLH62d+nkvAOiCCw869JRf2p17yJ4MfbCzcn07al17/YKep25UZsizKVlfMB03s4hA945Klyvv0zzuubeiB6OEaiEqlxflF/PqjeMMXz0Ilx7VV2J3ZFWGMn5q7+3CX3exHzDw6U/P2KUNZ8mfCQKFuq8h5XHpIXMX0M6ZDeUk7cGI1WTm4l+nsd2rIaZL8bz+NcIoW4fCTS54sR/fqJwIMxVtsUNKbE1uU37X2ir+WL+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqqotXvy/3vj8Zpsb4Qkl3z2HeOuFRlNm0ZHdNt+qi0=;
 b=q1Oi590D0lizIg0oYvXyl2xc2IqRklJWqr06AJSyTuFoOnnnx/Pm/7SntVu8ncfirVzPyzAyI+PAT5LqiEeO/66IPtgfGP6ICg9KBQ+gx+XAAdkzkV5R01yMxL9JeGyJIInlETAzd/uWu2nCcLRLhO6tFKg1ufSiXcrTzE+FELhgRTxeD97/LXau8Q96qSqVrqukLUgH1pUqDYUIiAyUKUV9JERVLIji/YjY5sTF+9bt1yt/4rhIkPaGkO+LyPBFvHBZtGx+ABY3VQ8Gw0ofg3RMn2GVY4+Rs+gYbrIvf2VUmhflmkEdy0GYXn24OhkH+MGG4IjoBzPQI91g54Ia6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7888.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:648::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.19; Mon, 14 Aug
 2023 09:55:27 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6678.025; Mon, 14 Aug 2023
 09:55:27 +0000
Message-ID: <f5698dc9-2a0c-47f9-bac7-6fc17da42c20@siemens.com>
Date: Mon, 14 Aug 2023 11:55:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core 0/4] Enable File system images in reproducible
Content-Language: en-US
To: venkata.pyla@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20230814091714.9400-1-venkata.pyla@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230814091714.9400-1-venkata.pyla@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0102.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7888:EE_
X-MS-Office365-Filtering-Correlation-Id: eac25f50-5f0f-4d58-10db-08db9cac9668
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	18Ply+K1Iw4jf3R8AdAtp/Oy01drC35bPf8DeCf6mPnEdll+0Lv7dhhPn/WThy3mkg5zYG7F0AThFVeVbAnzDe8IF3XQddP6zYjEgRHCZsnZn12eFsxtod1LcrtOyD/ajtA5sEtwBnbjCIh3SRBLqsEkoAONDyoJDNjVm4M0vSt6GWbaSxOeAKmohP+TW2TnWy8ESZNFSZihtIhL6JYXc3KUe65OLzCCPaO3vj0lL7YH3bcCD1VpAXRmT5be9ZQv1Tp5OUsy//1P0Y4RIb11aKUGyeSEotxEM/JNan8s9kmLt1mGl0jMs5s2c/mUO87zN4JT5C6nGFvs2aiyceh32I9gZmpjXtXetVKMWWvhapDDoGUsYLJPrl3K/3iX++qZz2UXvCackgwodODVnA0t5Af4DoLc2fODVi49vPxY+RTfu4qPBeIKFH192OUts+IODMkYn785Jp16B9gYrEyRis/mfmZbP1ARs89cZ7Fo7rZHb4Zhw2cZZ3xtdhNIl5NaYeIkh4f+Z2OszFRDAgvFb6pDVCRq/SZYGxlPrLuKronW9Ldgvun+EMjGyjEpTXNb3iTfnvc8kW6GVv18mQcWx2ij7v6t3fhOPdHyzg1kaI6OW3WLIYNYfR6IdAn5xBK735RpHuX3hE2J3XDbC8kbBg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(376002)(39860400002)(366004)(136003)(186006)(1800799006)(451199021)(6486002)(478600001)(6512007)(26005)(53546011)(2616005)(66946007)(2906002)(41300700001)(4744005)(4326008)(5660300002)(44832011)(66476007)(8936002)(316002)(66556008)(8676002)(82960400001)(38100700002)(36756003)(31696002)(6506007)(83380400001)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aC9JVXd2SURKWGhvYUtVa3gydDBncGFGRFhZYktidzVkWjdsQlo5Wms3aXZm?=
 =?utf-8?B?ZlBEQkFqOXZGaXZPcDhocjdBZmMrdXp3cGdFQkpmd0RQOVZ3QkdkQ2VWak9C?=
 =?utf-8?B?WTRIUmVZdFJvTDNyQmFMN3J1eG40NjlXZDMvaGFEcWFLUm80L041b2VTc2Mv?=
 =?utf-8?B?Q21IQzFGb3hac2JnV2M4bmtQUzNDQUdCalk3WnA5c2hYMzNjWEU1a0t0UjFu?=
 =?utf-8?B?QmZFZ0U0YzVva2ppZThYa3ErTzRsR1MveU5xcmxHQThxQzlDTzJZZFdpeXU5?=
 =?utf-8?B?YmR5a2hXTnJlVnN1bmdsUDErTjFhK2dsU2dpUXJ4eDdJVDhvbUZDMUVxaEQr?=
 =?utf-8?B?bWlmWjRsdCtvU2JXODBQRjJPaldjMG9tQ25GU0NBN2I3eHVoMlFOS0l2RmRY?=
 =?utf-8?B?Ty9kWGNzbmRWRmVhQVNieDNJQWJiM1pnU2d1Q2QvSlRtdXRiUjNrbDhHcGpr?=
 =?utf-8?B?UktaZlFuYmkra0kvTEt5RTdSRGNCRWQ3eUJTVlBDb3Z6U3FsaUlMYnpEZXVC?=
 =?utf-8?B?NnNYNjY1SWQ0ZW9FeXdtQnEvK05WNFhYU0czdjdmMFpjOHJpdVZLU0JORkI5?=
 =?utf-8?B?K2hLNjg1WGNrMUhxY2dremg3MkRUd2U2Z3RoVXNXSUNyNUdLNFViWlp2V0JR?=
 =?utf-8?B?QXQrY21vWnRhVWp0NWlYaXUwbk8vcmdxOXZjV1I2bEpTTGxpUjVIb0FMWUVJ?=
 =?utf-8?B?bDVteHlPTW9RV3ZGSzFGREt5aW9zQkhpYXd3MFE2TGRYbkRpSlFoSDF6SFhO?=
 =?utf-8?B?SEFKRnhiR1VidFAvQVQxeURyYzFDRWtpd1NZR0FiOFRNditzU2xYYnJ3ai8x?=
 =?utf-8?B?cmhZTHExdURoSXBTMXFEU1J4bGlMZnpQK2xPWHZiZktEeE5ncXg0MTlZaGsw?=
 =?utf-8?B?RnZWcWtOTTdvclMxMWdmZGk1ckJ1ZVpJUlpVWGhsdzhSZHEyNVFWR3BwRW9t?=
 =?utf-8?B?cWorZGh5VmpOUm01SFNGTkFDdUwrb01FU09ZYVlKY2doOExVekJJcVp4c0dH?=
 =?utf-8?B?cHByNitUS2IzdHcrWnpaclVlYzYxM1lzKy9VUmx6VHBFdlVPMHhoaU5DSHVo?=
 =?utf-8?B?d2F0RDJEMi9tL0hWektDeGs4NlBnNStBbldQMUEwckduZUEzcFB4S1orbU9p?=
 =?utf-8?B?bytleEFQVEFnemlETFlTRGNnNk8yMURnVitLM3NJVEc1OG9RV1VZN0pnUzZk?=
 =?utf-8?B?NWRkVkhiM3RPbkRxNVRXQW9XSktjTVhaemoyS0JxQXNjcGVlM29ZaG1EZVpk?=
 =?utf-8?B?cXdMOXBWYXREb1FpV3F4TklPN0w3MzlscytybFNDb2dCam9jdTg1SEkwU2JN?=
 =?utf-8?B?c2d6QTdvSk9LOUtHQzUxNnVLbnBKbFFCeDdzcU1zdE5iQlNodEtOeGJLbUxN?=
 =?utf-8?B?ZFkyVU9raEM3RVFNbGFpTXlvdnFsZWtTckEramFvNlplNXE5MS9qanFSZDF6?=
 =?utf-8?B?MTc2eVZ0V01qTmtYeFRSQUMySWl2VlphSFlvcFRqQjhwOUxuSmhoM2lMaG9W?=
 =?utf-8?B?ajVlVzV0czRGaWpvM1hWRUJDT0p3UUtPb2R0RlJOb3BneDA4VnE3Sm5JUWNM?=
 =?utf-8?B?ZlkxbGltVmZuVFV3SG5pcHk5aytHOXBkMFJLbEZOczBRcDk1N0dFZ3JBeG03?=
 =?utf-8?B?ZWhQSm9VRlVCSGZoTWZRMmdTRzM3N2ZMZXR3aVdoMFB3UUlRWTJGek1Ia3pR?=
 =?utf-8?B?cGdObUJKNERoYWE2SzhhWUlMSGpBQXhKaXBFM2wrSGxaMkxTWTJpc2R2SDlJ?=
 =?utf-8?B?ZWFrM1FmRDN4R04vUEVLbjNzTmZ0YUtjQjEwV2ZvWHh6aWFtRWhheEE3M0lD?=
 =?utf-8?B?K3J3OXZoVEllTmh6YUJqcTZhSjhEamV6dGtKMStnU1ZncnRwUFFlWlo4VnpI?=
 =?utf-8?B?cjNXRlhzZERNOXB5MUlibjRXbzRSOWs4YWVHK3Nhb2gwZ2h4aFdqeVNPTkhr?=
 =?utf-8?B?V09WVkhTM3pLbkFiblE4c01ZWDVaZ2FmTTN2ellGOHZxZUlXZ2RvdzJmUmRB?=
 =?utf-8?B?Vkx1UXhuQlMwYlY0bUNLbkxVSnNDdktCRDdyV25FRUdDRUdPaEd5d2JtNE5Z?=
 =?utf-8?B?VUJ4cXhlZmFMbDBMeHRJT2ZhYTRYaEtoSE1mZk5uWXdiQkg3azRPdEhQMzBP?=
 =?utf-8?B?WnBLWG55YzliR1NDZ1lUcHZpV1hFV1RvYW1VLzF1S3lPdGt5em84NzhHalhY?=
 =?utf-8?B?UWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eac25f50-5f0f-4d58-10db-08db9cac9668
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 09:55:27.6047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IfaL6BeD5HbXS9zimmVUXkZLdFcx0GXw1bXAQ6mw/KzC2IEg03fpBee3TOWlaCj9VBvbk59gHv5eXxFEUW1L8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7888
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Aug 2023 09:55:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12632

On 14.08.23 11:17, venkata.pyla@toshiba-tsip.com wrote:
> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
> 
> Hi,
> 
> The following patch series enable file system images in reproducible
> check CI, please review them and provide your feedback.
> 
> There were reproducible build failures with file system image creations,
> will fix them in another patch series.
> 
> venkata pyla (4):
>   kas/opt/reproducible.yml: Enable extracting individual partition files
>   .reproducible-check-ci: Include individual file system images
>   scripts/repro-tests.sh: Fix condition check for artifact folder
>   scripts/repro-tests.sh: Print partition label and fstype in the output
> 
>  .reproducible-check-ci.yml |  7 +------
>  kas/opt/reproducible.yml   |  1 +
>  scripts/repro-tests.sh     | 22 ++++++++++++----------
>  3 files changed, 14 insertions(+), 16 deletions(-)
> 

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


