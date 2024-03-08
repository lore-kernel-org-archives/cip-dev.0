Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE3C3C54E4A
	for <webhook@archiver.kernel.org>; Fri,  8 Mar 2024 11:47:36 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.89])
 by mx.groups.io with SMTP id smtpd.web11.19959.1709898452607613382
 for <cip-dev@lists.cip-project.org>;
 Fri, 08 Mar 2024 03:47:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Tu3bpsqy;
 spf=pass (domain: siemens.com, ip: 40.107.6.89, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=msl1ihXLSQiCbID9H6TU8YKltW6za3UidsVMdCJdI9j/oV6vQnFf5o12TTv5itiHO+Ksp1b/nOnkTPKL5iTe1uSy6BBuJl7I8nnrYiVNmlFmyYg1ly5EsPgem/lBNOcTCQ1Q1A23/KdXeVJ3EeNVNor07PbaGEwQBNOcGB0bQYrzVys5/FcGwV+JWU5Ufu7vBmuo58819I4ORlgMVCFXqNKgOKHDW114lgurn3E6cpJiuoz3M6h9/cITgAA29MT1H98c538+2XeyG1cNjPE0p1TMtg4JoOzP8B8oHBUekR7C9w0vCXZUA0H2/xGw1uGtVKOzKIvff6K3NYY4x4rGlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQ4wj67K9YpH/rYh50c7b+U/rR0SAYtwvHtQYKZ9XgU=;
 b=LOPXSijM/Fm1Cfatw/ZGe9TW7jTq5l7QHJ2LQBQfGa445/Hl1oOwzFRxXNbLDYBv0MiRh+95YqBtNhruI13U1BprJsJ0S3/3yLdBhgNICenRAE8l8Yq1O8Z6i6aUAU2pZiOSqwPbEKG7CJ80hcaoYfqoAw0l7kukliGiZx3uC+b/RnpMFN3k03DsatgUQZeJ2Wk3lFoRMvGgDoqoDdtFb6s+35LSo0+BYDXaWRuoYPRhzv4MjTdXqHzhqYweB7nE9Fqd9WqdB5q5wkWPVyoYKfhuYvYGlVZW06t4UCh5ViMHvVkXsLwmkSDXy8liFuNu4mQFZ1c2THFPS5Lnjs0t5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQ4wj67K9YpH/rYh50c7b+U/rR0SAYtwvHtQYKZ9XgU=;
 b=Tu3bpsqyJj51KpCo+X96grUxEU+DTZcnMR1E/KdLmE/09iBU0pnY9+H224MmQt2Oi4Bv487UqYquprs1rM6+bmECvhPaK2nkGpniGRHZ4u9LmI7V41hsVdmbcfkW0wNfpZiZXM1CeevOBqWUqcijNNNFCEbBt/Tha0qKt1Bf/LiVCVRRTaslJ2cf0GQal7QJ5DvVFw3Fr1veT8NgZkjjH1vC/CQMLmCfvM15utXSF/XfJ7th7FRfTOpGdCNmXdavD/t7o/pG7Y2x7t8IVOKGLYaYXshh2mEHFJLIrsMic5nWcuoE0d3Z5k+54tmG+Sa4ncS3y/r5y8eGG7rZuVl1+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6843.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Fri, 8 Mar
 2024 11:47:29 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 11:47:28 +0000
Message-ID: <4d62b5be-0e26-4752-bcc3-d2d18d043f66@siemens.com>
Date: Fri, 8 Mar 2024 12:47:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][RFC v1 6/6] doc/README.swupdate.md: Update steps
 to test Delta software Update
Content-Language: en-US
To: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>,
 cip-dev@lists.cip-project.org
Cc: shivanand.kunijadar@toshiba-tsip.com, sai.sathujoda@toshiba-tsip.com,
 dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20240307074612.1996609-1-Adithya.Balakumar@toshiba-tsip.com>
 <20240307074612.1996609-7-Adithya.Balakumar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240307074612.1996609-7-Adithya.Balakumar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0247.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6843:EE_
X-MS-Office365-Filtering-Correlation-Id: 63c171a9-3e73-4bba-68ba-08dc3f65881e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	BKbcbNb6UDYUVlMJGQLpK1VccPOlqtxRj/E18sUpQ8HZlp7GnmGLL+ZR3obX2dScA4hr4HnDGeAiPh0XvvHpffcaClaAOS8vGf/giTQstHj6Qc99ULk2Zei6e/FXYSMSpSutakhD8R+AAq3yPMPWTDKlUT5r/6/HMPobmUNMbUMI8DrXJZO90JahQnoJYxiC8uKEnng7tOegcgJvEuo1eP+bCRQPVcuNjylmardov/3ktN/J1XOPakaMuC2+yJv/3byONWzOuC1Sxxr1Ga9IwQJQcjrqRUCVBpn+bjFbWNOkJ2lPpcEVefvS2Kkg31SXm2+8n/dIRVM7HHhEJcq3NhshTEGMEZPhCevZFFnpxI0wcEwbDuDFd1AK1IFRllbqWGkQdwM57ar2nz4IyyjDGDKfTpdEyykAl51bZrJdxTlcy6Htj7U0J8K+LwJ2aWV74PvoWYyiWuKh4cu2XPJb7I2+UNHErP98wghvNDmMijr21u1b+sP1i2upFs9bXtEkQS6D6JqSTcduaWWw5LeNlWFz4tFP6B6fteBXnJiCKJZwt9wn+DA7SKevKSmDCkzzR9D/ZikSKG0Pe47Cbd87imgbZAqcy+JTAFXhCpgTLeTkXRzr4iWGo9WarqSU48+L4gjrCVmiLW7w/9G1BmvWljff1qggBq20BiuffsdQc7g=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MERnK2d1N0VyNG1obTZrSTgwdk9NZm1SYW12cXlaOWVERlJqd2RqQXF6bWJT?=
 =?utf-8?B?TmpOejYwSVRLVm1TY2FISkswMW1Qemt1YmxiRExWYnRGTTdub3QzcjdQbk5r?=
 =?utf-8?B?YTRUbnVZczFnZjNLZnFZdkNLakJDV3AzVVlzMHJVWkpweGdrSGdTQmdoV1Nj?=
 =?utf-8?B?ams5Zmh6YjFhc3REU0Q3M1ZIRGJsZnVqOEVTaEhjbERqK3d0RjVCVGpqSTdP?=
 =?utf-8?B?MVlEeWd0TUVnRHNlTE5zbUMyZjZCeW1vMHgvOVRTSFlyRDZrZ2ttWkQzaEpG?=
 =?utf-8?B?ZDZsRXd5b05acmVRbElsMnIxWXd4K3hHQTA0YmdFVHhLRmZXVnQ1MmF6YXdj?=
 =?utf-8?B?QTFhTjdKWjZid3pjRFZDVjhTbEtpRUJkMVRwSDJjNUJEQ0xyZ2RLV0N1alhu?=
 =?utf-8?B?YXJ6eS85aHB1bjF3bHBFaERsdlBOOEY0N2dRcXZPYmt2c1l6WVYwdzRZY1l6?=
 =?utf-8?B?OHpVbEV3ckVyZG9kN2Z2QWZHZFNOUEFDZXZza29NTDU4V3BnZGE2Kzl1dm1O?=
 =?utf-8?B?aWl5WWlFNkZ3RXVGRlg5NHB5YW9qVnYzcEZtSFBoV1dlNmtZMlYrektwc3dB?=
 =?utf-8?B?WWtkK2NnRVFwdFVpSkJlS0pZR3BBOGFDTXZtVzNhZVF4Q1dEVzZjdCtMTGJi?=
 =?utf-8?B?S09CY281TXdrQXFuUE5udHI0bTZicFVpc0hsQnJhckFGa0xlUzdhbzhNODhZ?=
 =?utf-8?B?T3p3dVVpbmdGVTFYb0NieW9La1ZMQVQwNUlrS2J1Y2phNWphVmRzVkFyc2tV?=
 =?utf-8?B?aUdXczRhUU8wMzhIUG44SVVGdGt6NTNhNjZzVFBSQ21HdXl2OXU4aUVXTExx?=
 =?utf-8?B?WEdDSVNnc3BpNUEzT1N3MnZQaUsreGxVYkxjc3VSNUN0QXd4L2txMzJreUlE?=
 =?utf-8?B?QmZrY3A4WlhXNVFyRVVZbk1qb1VLL1A4TGtTUTJtMUdtZ29SN0VobmhTQ1FI?=
 =?utf-8?B?RExTMHI2aDVpb20vY1lKZWpYVm9qS2NMdnJ4VjlYVHRodzRyek9JRW1nY3dW?=
 =?utf-8?B?cVREU0pUeHAyd1BiUittQzZOOFRBMTNXbmdvRUthT09GdmVkY2R4UU04L2ox?=
 =?utf-8?B?cHV4cUlqSC9WZDhNTkdBOEZVMXpOdHdWM0lzdzd0V3htOVZ4TlV5ZTl3amdJ?=
 =?utf-8?B?N1JQeVhMSi9NaVo2TFlqZFN6dWhRTmdNV05WMitPQWQ2Zk94bzdXNUlBSmh6?=
 =?utf-8?B?U0tPVXNwWWlMTjk1dXdPb0IrMnV4Rjk1WmkzMEVSYWRmbmQ2OVB3M2dCMmhl?=
 =?utf-8?B?MUpDdHdEYXMvNkRjc0ZybkVyRW0xWXJ0OWFLWVo0T2E0Z00zdmd3Wm1pUGIy?=
 =?utf-8?B?MERyNHRWSzBHSFZwN3RGWDY3Y2dZc2NrcWQ3VTVoNjdhMitnRHNhMXhOR2RD?=
 =?utf-8?B?M1daTnpKUSthRzZQUDRsaElFM0diMjY3TWY5djFUcm9Hb1YrMUFDWHJ5ZjZS?=
 =?utf-8?B?Q2VrNGhiTTJoZ1FTRnpndFVoWWVMZmNoTi9naVJIeTFJSXpkVWZ1dDFlUzNX?=
 =?utf-8?B?UnZHWUwxaWkyYTFiNG9xbUk2ZjU3ZWgyenBmK3JubVQ1WHBjV04wa0d2RGtm?=
 =?utf-8?B?QmdtdWR6ZlUwSm1RRUJMbUk3a0JOcXRhQWR3a0dMSDZET2VpTS81ZUdMVkNw?=
 =?utf-8?B?Sng4VTVRU05jdkl5NTAwUjRiVlR4NGtBNTI4VkhrcWs4R3k1SU4rQUl2Z1Bu?=
 =?utf-8?B?OWNhZzNGOFN3eU12ZC9RQ0dOakxUYjFlV25WSTNlYUFvOFdrNi9UWTNUeVhZ?=
 =?utf-8?B?MEIvbkhmak5kMWdURnVZd05sdW9RK1UrRXFhUE81alh1V1M2N0w2dE42YWFE?=
 =?utf-8?B?cm1JSnc1UU0rSnBLdDZSZ2srckVWUW1RYnFPYWQyK3ZsckxqeENWNENjR0J6?=
 =?utf-8?B?bU1CalZCTTQ0VU52YnZIRElhcmFIZE4wYlZML25TR3RYZ25ITDB3bUV4V2hp?=
 =?utf-8?B?ZXpxU2g2YUt3SzVpNHBwZWdFU0JBdTRYWnJIZm51R0VpNWErKytxWlBZL012?=
 =?utf-8?B?U3MwR1FwN3hxMndjNWVWSjFrcVIxVkVSaHNCTHRZeE1KNjE2L3pCeHh6ZjNF?=
 =?utf-8?B?QU9ENzJsbmJPaTZVYlZCeTlISEdRYWJZZWtRUExsUmV4aXR3RlZDU3JMRXpj?=
 =?utf-8?B?V3k2ZlY3MmdqaEUxODMzenVyVTUwUkpxZlpNelNtQW00eDhiUEFPRGVsVHhZ?=
 =?utf-8?B?Q2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63c171a9-3e73-4bba-68ba-08dc3f65881e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 11:47:28.8803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gonwD+JghS5ou6I/zVpPuKn70egGy467SWDVnRQqUQ4+LKvswuvWtNp3pnizLWm6y43ydJX6/i7r6mZCnwlleA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6843
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Mar 2024 11:47:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15267

On 07.03.24 08:46, Adithya Balakumar wrote:
> This change includes steps to verify Delta Software Update with
> rdiff_image and delta handler
> 
> Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> ---
>  doc/README.swupdate.md | 95 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 95 insertions(+)
> 
> diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
> index cf1bcfb..4003243 100644
> --- a/doc/README.swupdate.md
> +++ b/doc/README.swupdate.md
> @@ -324,6 +324,101 @@ user variables:
>  
>  
>  ```
> +# Building and testing the CIP Core image for Delta Software Update
> +
> +Set up `kas-container` as described in the [top-level README](../README.md), and then proceed with the following steps.
> +
> +First build an image using the following command:
> +```
> +host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml:kas/opt/rt.yml
> +```
> +Currently, Delta Software Update is supported only for root file system.
> +Now, to verify a delta update, build an image with some modifications to the root file system (ex: Add additional packages).
> +For this example, add the packages vim and nano (since the packages are not already included in the base image) to the image. This can be done by modifying the `recipes-core/images/cip-core-image.bb` file as shown below.
> +```
> +diff --git a/recipes-core/images/cip-core-image.bb b/recipes-core/images/cip-core-image.bb
> +index 0ec7220..f61ce23 100644
> +--- a/recipes-core/images/cip-core-image.bb
> ++++ b/recipes-core/images/cip-core-image.bb
> +@@ -14,6 +14,7 @@ inherit image
> + ISAR_RELEASE_CMD = "git -C ${LAYERDIR_cip-core} describe --tags --dirty --always --match 'v[0-9].[0-9]*'"
> + DESCRIPTION = "CIP Core image"
> +
> ++IMAGE_PREINSTALL += "vim nano"
> + IMAGE_INSTALL += "customizations"
> +
> + CIP_IMAGE_OPTIONS ?= ""
> +```

Do not duplicate the description how to generate v1 and v2 images,
compared to the existing "Building and testing the CIP Core image", that
is just confusing. Describe the delta-update specifics only, likely the
bits below.

> +## Delta Software Update using rdiff_image handler
> +
> +Creating a delta update file for rdiff_image handler requires a reference image (against which the delta is computed). In this case, the image built in the previous section can be used as the reference image.
> +Copy the reference image to the project directory. And set the variable `DELTA_RDIFF_REF_IMAGE` with the path to the reference image and set the variable `DELTA_UPDATE_TYPE` to `rdiff`.
> +
> +```
> +header:
> +  version: 14
> +
> +local_conf_header:
> +  delta-update: |
> +    IMAGE_CLASSES:append = " delta_update"
> +    DELTA_UPDATE_TYPE = "rdiff"
> +    DELTA_ZCK_URL = ""
> +    DELTA_RDIFF_REF_IMAGE = "path/to/image/from/project/root/directory.wic"
> +
> +```

I don't want to fiddle with such files for a first test unless I really
have to. I would like to have a default case ideally without any
editing, just by rebuilding an image differently, maybe providing v1 to
that build under a specific path/filename, and let the second build
generate the delta image automatically.

Jan

> +Run the below command to build the image with the modification as shown above and with the root file system modification as described in previous section.
> +```
> +KAS_BUILD_DIR=image2 ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml:kas/opt/delta-update.yml
> +```
> +Run the below command to start first image
> +```
> +host$ DISTRO_RELEASE=bookworm SWUPDATE_BOOT=y ./start-qemu.sh amd64
> +```
> +Copy `cip-core-image-cip-core-bookworm-qemu-amd64-delta.swu` file from `image2/tmp/deploy/images/qemu-amd64/` folder into the running system:
> +```
> +host$ cd image2/tmp/deploy/images/qemu-amd64/
> +host$ scp -P 22222 ./cip-core-image-cip-core-bookworm-qemu-amd64-delta.swu root@localhost:
> +```
> +
> +### Delta Software Update Verification
> +
> +Follow the steps mentioned in the section [SWUpdate verification](#swupdate-verification) for verification.
> +
> +Since our target was to update the root file system by adding a few packages (vim and nano in this example), Check if the packages are available after the update by running either the `vim` command or `nano` command.
> +
> +## Delta Software Update using delta handler
> +
> +For Delta update with zchunk, set the variable `DELTA_ZCK_URL` with the URL of the zck file that is hosted in a http server and set the variable `DELTA_UPDATE_TYPE` to `zchunk`.
> +```
> +header:
> +  version: 14
> +
> +local_conf_header:
> +  delta-update: |
> +    IMAGE_CLASSES:append = " delta_update"
> +    DELTA_UPDATE_TYPE = "zchunk"
> +    DELTA_ZCK_URL = "<zck file url>"
> +    DELTA_RDIFF_REF_IMAGE = ""
> +
> +```
> +Run the below command to build the image with the modification as shown above and with the root file system modification as described in previous section.
> +```
> +KAS_BUILD_DIR=image2 ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml:kas/opt/delta-update.yml
> +```
> +Run the below command to start first image
> +```
> +host$ DISTRO_RELEASE=bookworm SWUPDATE_BOOT=y ./start-qemu.sh amd64
> +```
> +Copy `cip-core-image-cip-core-bookworm-qemu-amd64-delta.swu` file from `image2/tmp/deploy/images/qemu-amd64/` folder into the running system:
> +```
> +host$ cd image2/tmp/deploy/images/qemu-amd64/
> +host$ scp -P 22222 ./cip-core-image-cip-core-bookworm-qemu-amd64-delta.swu root@localhost:
> +```
> +The `cip-core-image-cip-core-bookworm-qemu-amd64.zck` file must be hosted in a server.
> +
> +### Delta Software Update Verification
> +
> +Follow the steps mentioned in the section [Delta Software Update Verification](#delta-software-update-verification) for verification.
>  
>  # Building and testing the CIP Core image for BBB
>  

-- 
Siemens AG, Technology
Linux Expert Center


