Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F42C25B10
	for <webhook@archiver.kernel.org>; Mon, 29 Apr 2024 12:45:28 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.79])
 by mx.groups.io with SMTP id smtpd.web11.20015.1714394721790821259
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Apr 2024 05:45:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=yaRUxnio;
 spf=pass (domain: siemens.com, ip: 40.107.247.79, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HE7Or6rzRZZfL7p6j2RAs7IxAfTgzufoDCKSssejkKmPkL7l9eYyqFONH3aFthwLyQkiegF4L0nxknhfm9HUmn4ud4BE4m6XgL67TINZzcKCDcF1Kx2kFcTfigUQ5hCmuw1N+xrZ8+VNrFb07dLOV1onJfnILqJ9muRu1EY0mklEKM1s7vSn5Eosiq4BojqK5A1QD6MODZn8QyDbivrpPEWiy7q+x9/yp9d0tg/pKegbWU1ijuytPMsiT83ZwvSK4DLzhmNdI835zbMuomkfyAiXBxK9hb0BBtqtVuI5THGNGOvj4VoF3jK5I5bvz6ZLKD3/Q/KuvSS73uomebFrLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OptfEm3zfEypSW35rtuy6tPQbSf8FZnv/Lr9+ixZAg8=;
 b=E69PXl9xv0uHkTxHr5FZJchJ+FcFp8abAX0PddnYSIIQSRqwkmPTFjnzy+874K3TI+7OtTvGobSOGXh1KtolKrTWNMoswSb69EyH2T7HY0RXH5Jvvffu/V9648gtcN3t0gwFPCZQoSsjCXv9n+PssF7XvL1wMiJjL49KhCwpkk9OqL3LQ1zEKDtfaNiiRZwk+aG/KZV3qawgsfBXXhYdGT2mcHTPpAjesr+m1NHBJdRTXz/GK22UAPBreaw0V55ZbyrCTulQkCi7wMIn0CI0O4Zp7Olt5tRkk3h3iD08AhJCccbFb+6ZPKyM+6gpTX457Woz+xMUf4iIAIWK8bZj5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OptfEm3zfEypSW35rtuy6tPQbSf8FZnv/Lr9+ixZAg8=;
 b=yaRUxnioQMjL8MJ5PsOSJUw9gc4vK7WPPt59leYZpyDXbICmrr1pyhgIlQm8ih/hOaqkB5Bra3EvMmA0ePhSHUxxJ7iRGTPNUzEWtB4A0xKOF49/Y6IQ1tjTX0LLepAV3f627LzQn3X4FKCnKLJ7z/+U4pYXThPcvtczU0lzNfQHh/sg6zTwe9znDI8CcYvhQFYALz9aovDVgqVH+EJb3HHq2qwhP9YLX7TeeI7pJ8BZZDgn/Wu4PPLQV0t5RArzyWw9x+LkKIEGdTwnjOh+1Q6qzCS1pVaAm8YtbjH1TMJJY/Cd2uUnN1yBEAyJUBSUGF/IAxIGBh8XUDhqNk+ILw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB8894.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:441::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 12:45:18 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 12:45:18 +0000
Message-ID: <e9c236a6-0d71-4e45-9a95-c5edf8147dff@siemens.com>
Date: Mon, 29 Apr 2024 14:45:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v4 3/3] doc/README.swupdate.md: Update
 steps to test Delta software Update
To: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>,
 cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com, felix.moessbauer@siemens.com,
 shivanand.kunijadar@toshiba-tsip.com, sai.sathujoda@toshiba-tsip.com,
 dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20240425094444.404036-1-Adithya.Balakumar@toshiba-tsip.com>
 <20240425094444.404036-4-Adithya.Balakumar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <20240425094444.404036-4-Adithya.Balakumar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0158.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB8894:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cd94187-ffdc-4823-8e06-08dc684a39d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?MDhIaHZUNEdqRUQrUGN2VFBDWk9scHRxcUFRR3IxTjdrS0xBR3Y5RlJKeGta?=
 =?utf-8?B?RmxnYjVhUjJORm53VDkzQWtpVzNTWTVPZ1BFTzhrLy9MOFdvVGdXNktIVGl2?=
 =?utf-8?B?blNiQlhxTXdLNWFqd05NT3FKZXFmYS9HaVBhM3FyTGJOVENXOU42U1BOcm5W?=
 =?utf-8?B?VEV4cWJjb3BTZ0I3TkQrQXMrRUQzVFhQNE0welRwVVN0dUdLR0RHUUtiLzVr?=
 =?utf-8?B?bFZacS9sRTMrM3BOaTNNYk1WVTE1ZXExMllEWU9GM2JrVm9nR1duTmtLZjVU?=
 =?utf-8?B?SzlFNmJ0ZkdxSjMvV01pOXFpL1dBVW1YZ0g2K3AwZnh1NlBJY29MNnU1SmdC?=
 =?utf-8?B?cGFvK0RZVmJmTlNUUm00cVhMb2VDZU92dGMwWEdiREwrOFJIMkdTZ1lBTE5h?=
 =?utf-8?B?YXlWb1d2VXlKSUdTTzJ5MkdtMFVPQ2o5cE9HOWQ3cDJvR0xxSnBwdFVWSm1W?=
 =?utf-8?B?ZC9vUWpBSkQwaVcycGVheEp2bUJNQjlVbG40Q2V4QTNMMmhvTU1JWWNtQzBH?=
 =?utf-8?B?L1VwQUdoRTVDWGRBTUQ3ZUhwNkRrZFFNU2g3aVdPTkNpWTRac3BvdGhmSDdu?=
 =?utf-8?B?QWFCeXhZSWZORHMyNTRKdFhBc1F0THRJU0htV3BMWkNUdTYzTHFwWkNiRHV4?=
 =?utf-8?B?WjZ5eEpKVTA5cUxkTVlzY3VTOGt2b1c0R0hGeGJuY203d2NpWmdpSlZoY1p0?=
 =?utf-8?B?TGYyOVM4SS9xZ044c2ZZYnNhU1dKYUU4VU9BYzJZYzVSUXNzeFlvL1RqSzBU?=
 =?utf-8?B?eE0yRHJpSG8zQjVGY1ZUL3J6eEh0cml6bWxQS1R2Wkx6d3ArbVg5ZjY5ZkZh?=
 =?utf-8?B?V056Y0dlYXRVVitHQmhURWRHQ3dRaWZUdXh0MVZjR2w1cXNwSnk2Vkw4dGEv?=
 =?utf-8?B?QWJINWo0TFJ4c2lMNXJlQUY3TE5KeGpXTG1KTWxLOGVucURHQ0xORFVkeVk3?=
 =?utf-8?B?bVprdHVzZ0VCYXRmWXg2bWZLaWlhdWhHbU1BT1J4aVNTQzN6amJQY25Ldlh3?=
 =?utf-8?B?eWpDSW9BdkpWUURlN29Zc2RXSDZaNWZIekEwczRsamozRE12N0NERjBtUlVW?=
 =?utf-8?B?Y0hlVk5BeFBaRTVvZHJRc0ZWQVpCV1R2QzVEZGZEcHI0dXl4RWdOWXpkVHNO?=
 =?utf-8?B?THhWUXpQdzNPQ3lDdDVIYnR5SWppY2c5U29TbXZJYzFnZWZjMTdwNUwzcFcy?=
 =?utf-8?B?MCtycDdSWUpIcnJucUEwNlFza090eGFTdGJPQ3ZIMy9wRXhxUUxXRjl4NE5i?=
 =?utf-8?B?QU1uRlhEOUJ3U3dlZ2dVd01IZHpmbW5MbnpBLzg1WkhFc0cvS0xFTnR3RS9Z?=
 =?utf-8?B?N1Iydlo5Vnc1SzRvbjZsbzBvU1dVMTFpZkcrU3VVN1BWR3hXc3M2cXcvNnZh?=
 =?utf-8?B?bDQwUGdhZzNkZU51VGlrQW5CYnBaaEZ2bitrTmpBMHNhcW9GSDk2R1EyQVlW?=
 =?utf-8?B?NmgycXBtYm1mVExtaWdiZEc4ZEtjc3N0dmx6SG9lTmVENlhOTHJ6TWtrSWhJ?=
 =?utf-8?B?SGEwTmw0OW1zL3h5cTJHWTJPOWpIcG9qMmJBY3ZGZzZVczdPUFNLL0VjTS9W?=
 =?utf-8?B?UWZxUm5Oa1cxenNRdlZaSjZJQWdRUTRhZytvb1JSL0pUWlI2djJ2WVIxRUEr?=
 =?utf-8?B?RWloajk1QlExeTlhS2djemRnbHZhc1RwdHZwRVYxZ3N1b1dzY29jeTd6NDhH?=
 =?utf-8?B?RFAzK3h4NlJVOENCYlNXcDBsL0JLUGpLNHFBQ3dYZ0VaeE4vWm85MGRBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OGJCZE0wYnhCZ20xVDhYRWdtVTZCcDR4aEhqb25BcmhZbEtoK1ZpVk9DL1Ft?=
 =?utf-8?B?TzYzVU1qUXBzYzQ3Nk5kWFNYbC84NzU1eEtvb2VSaXlXWTVJWnpicHA3OVlm?=
 =?utf-8?B?YjBOczg4QjJ5TGsySzkvYW02Z2VZdFlUL2Z4VVNPclN1N2RDOFFTR2VLOEhD?=
 =?utf-8?B?VndEdnBKZkZ4MU9uaC92R1F6VE5CaUJlamJMcy80R0g3cXp3cFYyR09jOXB4?=
 =?utf-8?B?MHFaRDI2MTE1R0FFVTEwY1B2QkcvTUp5dU9pMFhhbVhGclJZMUM4elAzKzBm?=
 =?utf-8?B?bjVYSFVMUFdsclp3UUNlMC96T2ZJUkN5TjRKMWFsSG9qOE92ZU5tRURhdzdF?=
 =?utf-8?B?d2IxUFdDRmZHT2JWbFpFVWViVmZzL0d0eDIzQ3UvNXBBeWZsMU8zUjdnSGVh?=
 =?utf-8?B?RWZFdXlVa1ZnTCtkeUorZURTclJoZDRxUU41VFl1ZjR0STlGVVdmL2RvakRj?=
 =?utf-8?B?UHl1dTVsZFNKWHVHb1hFdmpKNm9OdXNIRWJhMUo5bUYyYzMrYUVza2Z5a3Nx?=
 =?utf-8?B?WlNlU0hSNUZZRXFkVDhxY3FXZytoTWNtbFc2UnhQb0x2ZWJkeDJVODV0UjN0?=
 =?utf-8?B?dmtScEpCVDMyakczQjJRUkp5YTlLR1dSZEc3TnNPcU4zNVFpV09LSXhPUm5H?=
 =?utf-8?B?UFltWENUd0RxMlRBVW9DcjYyTkRWMmVoREg0QzlCeXBvcGZPUThtMUhzT2RQ?=
 =?utf-8?B?Z01RZGwrdUlOcFZaVW5OUzFQYWdVbk9HaWx4Wmtuajcrdm5wSkZrQjJQK1Qz?=
 =?utf-8?B?WkIvY0k3UmRya0NWdVYvOWhJNGU4TThiNUp0cGRVKy9jeW9sSkZ0U3h6b3Nn?=
 =?utf-8?B?OVVick1TSENONXJxSFhzc2lxaEZ4TFBzMmY1eU5Gb1pOdGZKbHhnZlFGWWZO?=
 =?utf-8?B?amZKbFFwNU5ZWVpwbEs2Vkp3cVh6Si9yUmRic3FNekFMTFlBN3FVM2NHbGpG?=
 =?utf-8?B?dzIzOXlqUmw1dk1aSGJwVS9XdTI1SDFLaGhCREdXWEdoRDA4STBZRVZ2eDJi?=
 =?utf-8?B?aEdQQmwzQnFLWVBjaEpqZUlxNWV4b0FENGRmUW5LMkN2OGtZaGJKN2NWYmor?=
 =?utf-8?B?VFpyMjhhVkVKclRLekhPRXJXdFMycWVSR0VUOTI5NHVOa2VSMGRPbTdYa0lp?=
 =?utf-8?B?ZjJ6WUZtMWxrQ0cvQzZJZkhNT0Iyd3lzMU4wWVlZVC85SEdQNHlONXNvZTd4?=
 =?utf-8?B?aTFCMHdheFg1SUtBZitDZEUvb2N3NG1zVmZoVnhGd3BIMUxRVUlYOU9YKzkr?=
 =?utf-8?B?ZVdXMWppRTNKR3oxaDVJbVg5QkwveWpsSXRlT1B6QXNFQzRNOGx3cXdOMllt?=
 =?utf-8?B?aHVMRzlXSnF1RUk4V1BYL3JkMVRhVk5majFzRmZmWkw2YnE5ZTZLZ1lhUmQ1?=
 =?utf-8?B?dnZYaisrWWxwcFRHdWJTc3V4ODU3bnk0SzF3M1ZSOWx6ZW5ScmM5dFJEOGNj?=
 =?utf-8?B?dWJsMmNua21CNndqVHc0cDhHZzIvMldUeGxuWGRLc0h2czNHNlRFalZkYytQ?=
 =?utf-8?B?ekVYdko0cGRYUi9yNCszU1lLVmQzelN0Zk54d25maEFGWTRBblV3ZllZMnVQ?=
 =?utf-8?B?dmd3QUgveEo2WGVrd05FQ3p3YTI0ZTJIRHYyTFVpaG53TlpCUWlZQ290aTlK?=
 =?utf-8?B?UlYxSi9idmJxRHBzSjRYaytSNHJobmlNNkdzTWZqS3QxaWxYZTlyTXF6NmN1?=
 =?utf-8?B?MDBvTVpRVGx1NmFGM29Ua0UyRDAyVGtxN2xuQUFGcnBMd0EybE5SZ3B4dkR2?=
 =?utf-8?B?aFdVTStqLzcvci9NMTNqZ0JiRDB6VHJQeS9LR1doZ0JmM0p5ZDMvdldhZTIr?=
 =?utf-8?B?a3JnN29lbUt4cDFrWmV4a1dScjh2SDhpaUJwS2RnTVZIS3FnNkZnYS9WR3Y0?=
 =?utf-8?B?emR2NnZuSStZZEM2aWR1SU8zOGhKZmhMd1g0amxxUThXNGhvT1pHdW9XbVFJ?=
 =?utf-8?B?NVVPM1VndmxjRHJlYnYxZWZyOUV2MFVuazZPZndONFJKSUI2cGd1d3Y5QlRm?=
 =?utf-8?B?RVJMTGkvR1FOV0NHYnhJbzZTeVpLNDRFcy85dXZEZStFNGdNT0p3YkFjMHkr?=
 =?utf-8?B?NUFlMWRWVEJxYTB0V1VrMjlnM2JSRElZWG5uSTBRbDdxc0Q5TmxOVWhBRXRM?=
 =?utf-8?B?bWtlR29Cd0VIa1N5MDNxMnNJbU43VGU2MFlETDZKSXFMRGdXMG9xc0NSaDJT?=
 =?utf-8?B?b2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd94187-ffdc-4823-8e06-08dc684a39d8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 12:45:18.8255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZZM4vLLi1C9OfzWVTFUs/2XxgRZEXQPuRH8R9Du8npI1e8GqHO8ePOz3m+3P+9g8rzKNagWVdljPbwx241DwsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8894
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Apr 2024 12:45:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15778

On 25.04.24 11:44, Adithya Balakumar wrote:
> This change includes steps to verify Delta Software Update with
> rdiff_image and delta handler
> 
> Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> ---
>  doc/README.swupdate.md | 59 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
> 
> diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
> index b7e13f7..d955868 100644
> --- a/doc/README.swupdate.md
> +++ b/doc/README.swupdate.md
> @@ -360,6 +360,65 @@ user variables:
>  
>  ```
>  
> +# Building and testing the CIP Core image for Delta Software Update
> +
> +Set up `kas-container` as described in the [top-level README](../README.md), and then proceed with the following steps.
> +
> +First build an image using the following command:
> +```
> +host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml:kas/opt/rt.yml
> +```
> +The above image will be used as the base image to which the update is applied.
> +
> +## Delta Software Update using rdiff_image handler
> +
> +Creating an delta update file for rdiff_image handler requires a reference artifact (against which the delta is computed). In this case, the image built in the previous section can be used as the reference artifact(.squashfs/.verity file). Set the variable `DELTA_UPDATE_TYPE` as `rdiff` and set the variable `DELTA_RDIFF_REF_IMAGE` with the name of the reference artifact. The values of `DELTA_UPDATE_TYPE` and `DELTA_RDIFF_REF_IMAGE` can be changed in the `swupdate.yml` file.
> +

Can't we enable rdiff by default set DELTA_RDIFF_REF_IMAGE for our own
demo image? I don't want to hack on the code to try things out, at most
select an option in the kconfig menu.

> +The build system looks for the reference artifact in a directory named `previous-image` in the build directory used for the build process.
> +
> +Copy the reference artifact to the mentioned directory with the following commands:
> +```
> +mkdir -p build-v2/previous-image
> +cp build/tmp/deploy/images/qemu-amd64/cip-core-image-cip-core-bookworm-qemu-amd64.squashfs build-v2/previous-image
> +```
> +Build the second image with `build-v2` as the build directory with the following command:
> +```
> +KAS_BUILD_DIR=build-v2 ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml
> +```
> +Now start the first image. Run the following commands:
> +```
> +host$ DISTRO_RELEASE=bookworm SWUPDATE_BOOT=y ./start-qemu.sh amd64
> +```
> +Copy `cip-core-image-cip-core-bookworm-qemu-amd64-delta.swu` file from `build-v2/tmp/deploy/images/qemu-amd64/` folder into the running system:
> +```
> +host$ cd build-v2/tmp/deploy/images/qemu-amd64/
> +host$ scp -P 22222 ./cip-core-image-cip-core-bookworm-qemu-amd64-delta.swu root@localhost:
> +```
> +
> +## Delta Software Update using delta handler

Shouldn't this contain "zchunk" in the title?

> +
> +Currently zchunk based delta updates are supported only in Sid images. Make sure to build the first image with Sid as the distribution (use `sid.yml` file as part of the build command).
> +For Delta update with zchunk, set the variable `DELTA_ZCK_URL` with the URL of the zck file that is hosted in a http server and set the `DELTA_UPDATE_TYPE` to `zchunk` in `swupdate.yml` file.
> +
> +Build the second image with the modification as shown above with the following command:
> +```
> +KAS_BUILD_DIR=build-v2 ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml:kas/opt/sid.yml
> +```
> +Now start the first image. Run the following commands:
> +```
> +host$ DISTRO_RELEASE=sid SWUPDATE_BOOT=y ./start-qemu.sh amd64
> +```
> +Copy `cip-core-image-cip-core-sid-qemu-amd64-delta.swu` file from `build-v2/tmp/deploy/images/qemu-amd64/` folder into the running system:
> +```
> +host$ cd build-v2/tmp/deploy/images/qemu-amd64/
> +host$ scp -P 22222 ./cip-core-image-cip-core-sid-qemu-amd64-delta.swu root@localhost:
> +```
> +The `cip-core-image-cip-core-sid-qemu-amd64.zck` file must be hosted in a http server.
> +
> +### Delta Software Update Verification

This should be "##", i.e. at the same subsection level as the previous ones.

> +
> +Follow the steps mentioned in the section [SWUpdate verification](#swupdate-verification) for verification.
> +
>  # Building and testing the CIP Core image for BBB
>  
>  Follow the steps mentioned in the section [Building and testing the CIP Core image](README.swupdate.md#building-and-testing-the-cip-core-image) for creating images and .swu files.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


