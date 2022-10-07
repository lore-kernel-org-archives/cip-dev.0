Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2C9C433FE
	for <webhook@archiver.kernel.org>; Fri,  7 Oct 2022 08:08:33 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.52])
 by mx.groups.io with SMTP id smtpd.web12.2054.1665130109597398902
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Oct 2022 01:08:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Ktt3rDOj;
 spf=pass (domain: siemens.com, ip: 40.107.21.52,
 mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CvfuZPbiDk7BpVLKZF8Y1p8Bns2qwjtC10xNrNtKheXa+wYhKUy6QwphiI7PE0LVgunqF/YsN5hXokOYAMtjgQSsjcxpdFtYZSTbUY41dpmeE9OtiusgZGoYlkiNaOzg3QNElBJf4rAJ3iRtzHeaLPgTZ7AVWXh7H/+g6Lf1C3P7fObpOCstgz3zCu9dIM5O99HpmukYtAjJclg1A5KOzl2yJ0dsXlkDPD+2zHB0/2x9K9jA3mUesNT8CjUQdI4iUQLl6hSsTpF9onZBEHRkZIuYrsG81kDd4D/FNFxvv2RJsGyHh0fUX3LUayt6rNP8V+BukuBhoTBTi/CIpNV/cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0TCHAcCibLpNwg938Um7G9h836KLitT6iGzwiu3utQ=;
 b=Yyo8fMog7x5Lo9cpoZERb1jjHiK2ONjHIMlgjd/Zx7YoZljPpaHKN6jMB4XYkjaOk3O/PTAbTAn8Hy0WhJgB99ni7en5GOiCbouP04qBXstfQcGbyhzt9T05RMCufjt9a+sS3p8jGOPj1fBHd9+SbHHWOx+gnuAGBlWpbIygcP5h3CgX19Xpa1jvWcJTlZxrAE0ju1Osj0W0cOL5H0UdIGIme0npwXKuncl3b+wIyY9BTZqWLT3F7UZyG+PDeM9IstU2BuGefkb+Sggdb8NU+cWsQU6ami/LGrKAzCf2MVXH436MpVVUMJmsJdhEsgu8FhjcuySTYOwnvfClK9LedQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0TCHAcCibLpNwg938Um7G9h836KLitT6iGzwiu3utQ=;
 b=Ktt3rDOjCuoPz//c5qFjyHftpkGmBfFjNSOeDwQ8c6cCHw+w/AOACWs+Lj3mY0yvoUEta0E/Wkf1ZB+z/pU4YddQCFV/ef5BV8zkkdUJo7h/pBN2lAy28pgR37LWK7QlJPFhx1vqZxQPMt3nDpzyVhnUNorah+Q0lW0juEcr0AXkQP4KHV+oVbEXdpdd0V5HIpza6CqwqQGe9LyIRw2S+mqr/Uc3kUnQnE333QBzXm6d/raE3oNO2NnjH7x5jXKfRpGZ7PzfqEZul3hLH0Y/FXMqLFvEsYNkCFFeGqSJ1ODVokc96uvFupLYlhluB6FveQ2+ktpfFNTXcUchW5TZaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PR3PR10MB4096.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a5::7)
 by AS8PR10MB5928.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:52e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.38; Fri, 7 Oct
 2022 08:08:26 +0000
Received: from PR3PR10MB4096.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3cfd:6d9c:9cf5:9e2a]) by PR3PR10MB4096.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3cfd:6d9c:9cf5:9e2a%5]) with mapi id 15.20.5676.038; Fri, 7 Oct 2022
 08:08:26 +0000
Message-ID: <56f5db40-c995-fc9c-24e3-07fa642443d0@siemens.com>
Date: Fri, 7 Oct 2022 10:08:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [isar-cip-core][PATCH 1/1] use qualified path for
 CIP_IMAGE_OPTIONS
Content-Language: en-US, de-DE
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org,
 "Kiszka, Jan (CT RDA IOT SES-DE)" <jan.kiszka@siemens.com>
References: <20221001045257.441816-1-felix.moessbauer@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Organization: Siemens
In-Reply-To: <20221001045257.441816-1-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P193CA0046.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:51::21) To PR3PR10MB4096.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:a5::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3PR10MB4096:EE_|AS8PR10MB5928:EE_
X-MS-Office365-Filtering-Correlation-Id: d87f8469-5806-4667-daaf-08daa83b1c7e
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	PCi/ziCA5vRI7v/V/zIe/T2NPixLb+/4ay+//mcfmtTY0xiGZzZcvXGYWCPizMlvLeD336m4FTtvw5qg5nq7xVbIExNuxO8k6MpNUFqqaoOH/ZyX9qTJcXHJOS4NMrZ35To7HaMH+A+3yTVOxO8tMuCrWiv/uOEOf+QBE2aBnJzNDZ8VmfGgnvPN56cAiQsFE2FPKjeLnpS1CuGZc/b/8I7Mmpx6trYp8tgA/ekJQVxpYMJPiUyUwpJZ+jk+skHKC/HimshEkEdZdHqO+P6u166px1I8/1d/ldDXYRvRZ+uN0jGDVywdigQ2QvBvt/INvifHnaE/K2qw2aue/kTDEY1fpIBi0xmTcZVnsUDfi8EADo7gVorUTuDne3yJTQuDc/z+diNZi15sN3mb1GUZhq5uf+ypacJb0Yel+8oKadrlGAgAQwf/Otoy5Qw+pIwFFGiz2T8SIn5pldodbspckEOiCCsGOf2T2+x1WnTbNcKaSRT7Mw9dCCCayy3mMB/aWn2MkmzVc3x8LwuOjivevIyi1GiDriqVzAVGrW467Q31/Gb/W3+wuz38SJjLgxJkWqdDu3DVtBEcIooYfHsekmVqIcr0GyZ4t8GNMViFvMjNrl8R7Jk+XNLIvuzATnoY07lmoTC8fKp7AoRx0boJ1dmrvQqYjYu3ScXnYsCRpSdDsyb2DQks/+3cwVxk6FaryYexumo2HQsebjPWToY03X9AXxe1zjUq45zwrAEThaf95HzefLRMefYyVc9mgQkkgdXAc180bRJkAu0cCDe8ODIZtF/8GKo7wNFSvlRiXIk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR10MB4096.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(366004)(39860400002)(376002)(396003)(451199015)(66476007)(66946007)(316002)(66556008)(86362001)(110136005)(31696002)(6636002)(5660300002)(36756003)(2906002)(8936002)(8676002)(41300700001)(186003)(38100700002)(2616005)(83380400001)(82960400001)(478600001)(6486002)(6512007)(53546011)(36916002)(6666004)(6506007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TklCN2tIc2tnMFVBdHF3Zm9RSHJUM0JicEVKY2lETHFqRWtWeWE4TzNVdmJ3?=
 =?utf-8?B?bzh3WkNQQ0dkRno2V3I5azR5V0VVUlpXN2hVSlBWdXJWeExOUmRxd25rekIr?=
 =?utf-8?B?ZEhuaWNlSWhmbStjV3cxYTg4NzhybFRJVC8yQ3hydVdqQVhvMzhPT1BqYTQ0?=
 =?utf-8?B?Rnp2ajAwWEl2SFduYmZzMFhLN1lCSFFheU8xa2NMTDVpWkZGL3FVYk9PMTJ5?=
 =?utf-8?B?Q2loMlJIS3NPWlVPa0NDeFVIZk9nUVNQRFUzQm5ZS2NqN2x3ZzZsaXZjcCtZ?=
 =?utf-8?B?d1h6ZFlCQkhYRUc0TER2RE1xbHpEVDhWaVM1NWtFbFFYVXArb3dEc0NHaHBL?=
 =?utf-8?B?UkJSQjhHbkRJRkZodFphK213d3dIV3dSTUViMVh1OVh6OEszQWtIL0REQnZS?=
 =?utf-8?B?bC9oVFBWUDUrcUVNU3R5VkdpNFZFU0pNaDNKRENZSTlqVXpWazMveWtkUENF?=
 =?utf-8?B?TFdMREhpRjhUaFJMUTNvM3BRRWNvdFN4Q1BUOVQ1U0tRWkdvbE03dmhkQmtF?=
 =?utf-8?B?bTMxSjM2aU5qancxaVVWSU5qVG1UY1BKUWw3Z2NqbUk4c3RoeGlXUGtmNVRa?=
 =?utf-8?B?QmVXWkUvcGR0N2VFRkFkcVFabkRldktvekxOUFNLQ3NKUHExOUR3YVF1aVRI?=
 =?utf-8?B?UlI4TThhWVJKUlFsTkNkdUJKRlU2SGI4WldnL0Z5dm9Sbnp0eDl0bjFFdFdZ?=
 =?utf-8?B?UXk4czZYa2FRQ280QWxibWNHTUNIejJNOEFpMFk4TzArM2ZzaUV0N3FZbENQ?=
 =?utf-8?B?RmxDNTdtMExMZnNKUGlYYmtLRjBCR2k3ZlFScGNFd0VNam01STdnZDdNcFZh?=
 =?utf-8?B?bUN2VmJaQVdwV1lzSUNudjMyM28wZCs2c2FUNjVmL1JDOTl3dFc3aXpaWWQz?=
 =?utf-8?B?Tm9wZnc0Z1h1SXFrVG9LUGdWUkpVSXpFcU4ybFN1K2lZREJSM092TlFzL3RZ?=
 =?utf-8?B?dWxCRUx2YTRqeFkzUFpBRVY3SlJZbGN2aEN1QVJHTzlNcFdXQVI3MURhcjZs?=
 =?utf-8?B?bGp6bXZleDVKbUdwb3VSVEYwNlY3RGxKQ0lWYmtSSHFoQTVFcGRXeGlYQk1V?=
 =?utf-8?B?UDZWdCs1TkdJQ3FwT0ZIYVoyeXFmT3EreENkc2dLVHVoc2Y3encwS2lpSFJw?=
 =?utf-8?B?RWhhY0NUT1ltd0NKL3E5cFBObnZkT2VtdmVvQVVsYVh4czZBNlpFRnZ2ZUxj?=
 =?utf-8?B?NGk3NG0wR3FseEliWDlGR2wzdVlMMUdmV2ExUWx3Zng1WVBBY3luMVltTkRm?=
 =?utf-8?B?TEJXdUxBa1NFSzBqM0Y1NW1mbDBDbjVJVU5WTENNY2hOYjdGZ0xGRjhFRGhD?=
 =?utf-8?B?MHM5OGpPbHVDVWN0MzlZRnEzUmhjZTdhZEY0Wk00b3lKTVRrcE45SDUrWWFk?=
 =?utf-8?B?WW4xeHhEdE9HZGtMN01LbkhkWXFRR2tBYlBUbVViVG4zcTZBUTFid0ZPWDhC?=
 =?utf-8?B?UzhJTTJYMVZTQ0hteFRWNXZNVzZ4K0J6VDRDaC9pdUc1UGtaakNYN0dZWnl5?=
 =?utf-8?B?M1VmWVV3ZXdGTmNxTFNWUVNGVU5oZHJxT1JSUVdOd2JUeGRJQi8xSTFJck0r?=
 =?utf-8?B?MkgzNHMzdjVycGhZaEVOb0hRUkRXK2xwblBXU3ZQK2dqeWtzcFlxUWZodFRD?=
 =?utf-8?B?dWtya0o2RnEyUjhLcmdYRFBsb05kd2R3ZWl3eGNBT1lOeVJUQms2ZHAvQkRF?=
 =?utf-8?B?TzdwTkJGc0NlUUg1Mytqa0Jaek9Kdm9mUHZjNklWbDhQRFhHZkFqYldLbG5l?=
 =?utf-8?B?bHZMU2hHUFZZZkdDa3FLR0hHZXY2S3dCMXJVNXNJOVZJVDdmbzU0R1JScHYx?=
 =?utf-8?B?dno2TWNxalU1V09vSDJlMmVvVE1SaEVCcDFJOUJhalVobWNzVUVaejRmTWlW?=
 =?utf-8?B?ak04MUNOZDNaYUY4UFlMdkZxakhyZ2UvUUZXb213TklIQklwS0hQQjBXQllt?=
 =?utf-8?B?b1h5U21hbU9oYTNqQ0RncExuczdnOU9ialpDUlo2bm8vM0RLVTl3UFNIQkJT?=
 =?utf-8?B?Q3lwYVUwcDdjRjdDWGJXc1ZGQ0ZQT3hBazNUM2VzdDdaT21EcHFOaHNGRFVQ?=
 =?utf-8?B?aElOUk16T0VZTFdBRThZWUY2U1lpbzk5bnlaQ0FicVNvQjJwSjJkeFNaODhS?=
 =?utf-8?B?WnpwU3UyMStuM3NOUzk2U01nZkd6RlZlRUhxU0FLWHVsdVFZTHVIK0RseFQ0?=
 =?utf-8?B?cjdUUzdOL2E2OTIxUnlvNEo2bHNyY1JaZDFRU2tkMjJTRXUrT0UvdStlUDNw?=
 =?utf-8?Q?b2ho7mT2dUtjkqiYwjn8m49QLbACR79S0iXCgiUGCc=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 d87f8469-5806-4667-daaf-08daa83b1c7e
X-MS-Exchange-CrossTenant-AuthSource: PR3PR10MB4096.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 08:08:26.1908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 LfPMQFsMSXR0DCqEO+bY6UjCS5Ki0vJ9aXiJtZfJ2veKaCUxHonZ/i+eM+8ooFtKid66Dk6cQX0rxolPHJbMYcxuFYmlBecYB/rvw3apdXY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB5928
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Oct 2022 08:08:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9668



On 10/1/22 06:52, Felix Moessbauer wrote:
> When using the cip-core layer in another layer that has a slightly
> different directory structure, bitbake is not able to resolve the
> included files.
> 
> To fix this, we simply add the full path to the file so bitbake is able
> to locate it independent of the downstream layer configuration.
> 
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
>   kas/opt/ebg-swu.yml  | 2 +-
>   kas/opt/swupdate.yml | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kas/opt/ebg-swu.yml b/kas/opt/ebg-swu.yml
> index 8b3ffec..78227f1 100644
> --- a/kas/opt/ebg-swu.yml
> +++ b/kas/opt/ebg-swu.yml
> @@ -20,7 +20,7 @@ local_conf_header:
>       SWUPDATE_BOOTLOADER = "efibootguard"
>       IMAGE_INSTALL_remove = "u-boot-script"
>     ebg_swu_image_options: |
> -    CIP_IMAGE_OPTIONS_append = " efibootguard.inc image-uuid.inc"
> +    CIP_IMAGE_OPTIONS_append = " recipes-core/images/efibootguard.inc recipes-core/images/image-uuid.inc"
>     initramfs: |
>       INITRAMFS_INSTALL_append = " initramfs-abrootfs-hook"
>     firmware-binaries: |
> diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
> index 8ba03c9..e32ce20 100644
> --- a/kas/opt/swupdate.yml
> +++ b/kas/opt/swupdate.yml
> @@ -16,7 +16,7 @@ header:
>   
>   local_conf_header:
>     image-option-swupdate: |
> -    CIP_IMAGE_OPTIONS_append = " swupdate.inc"
> +    CIP_IMAGE_OPTIONS_append = " recipes-core/images/swupdate.inc"
>   
>     wic-swu: |
>       IMAGE_CLASSES += "squashfs"

It would be nice if we could write the options without the full path 
necessary.

Quirin

