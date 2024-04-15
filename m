Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BACC4345F
	for <webhook@archiver.kernel.org>; Mon, 15 Apr 2024 13:20:37 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.69])
 by mx.groups.io with SMTP id smtpd.web11.20956.1713187234319874427
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Apr 2024 06:20:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=hO/s65mS;
 spf=pass (domain: siemens.com, ip: 40.107.105.69, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m0QU6TYjPyq7LGLfMnucBgf+34wUXUcw7zYRwWh4QLUcJnXlPzv9u1KWzB/MKNZuPCdB7SxdcZP30zJYG3dDYhJaAntrJ6nBtkAFXXVOqotyv2vKnJbz5/LDI8eqkmryvVa0KEQNGFPhXWeLJ1Vm1vj3dHz3jqE2T0q/eZqbEb1QgvYbhk5atzFBsVo6fbqbdezRygqhdzrw0RcKsFprTw+or8Pfu8CQ0ZNcVv8wIJ98E4Ax5mXqvzT8ma5qRBnI6TSEo4w7pwL9mM+6KYKzpv2xculnD6ktdVMQ/ozsrHAbi+aDbQeCjBSr2aeB3sCIg129uUnArS3A5n6mwDxC/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+EgSz0vz/QkQqMU5L+nLnL0UU+Qo1ouqb0l32s6dzyY=;
 b=Dy59N+aSqEGw2+58VzQy+e8Pjwatp2XDcXpgFjMeAsS+NxqHPTShkhVafOAoJceylcvrY/skbh+MMp8aUDG4xY51/H3j5Llyg+hj2Q73GOVckbBCgzSgZHRYZSvVW6rooCHiLFnjwnr2YwMs7mcsi2NBPZw1lNkZM4GEu0G25ph+pvOsiJGVh6vRg3RWNFDPzMmXf7mod5XU+mwUafkEP2w1/35GreAQaIyq7QZ2OxGrjlt0c9a5ji6M+srIf5OkN6U/2bIzqu7mkDlz0D15VLO2wHkZiczfvzunAAY/D2/WzbSwyGLY1pXckaWXKl+T7pwc66D0Zn7suLtAMLK8+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+EgSz0vz/QkQqMU5L+nLnL0UU+Qo1ouqb0l32s6dzyY=;
 b=hO/s65mSvyeFHq4aIa+8v5viEsBRUzySyPIHYs8AraGBgOrOUOpG5wPQ0QV4SmpwVReM+oMeZKjNsbRdXngPNNj+UBUqawiIBreB8sUK5J0ipa3rAsGbFJISK4cE0xqqYUb9pVv/6OVTgKawwL+47VXgSMtqV0lTdlL6dRmeoCunhtKYxYDOKzML5XNl6FmX5i/0Hi2yWavxSEJkO2AL+xZvqX1X1tHmIgSrtGzoDuwmuWae9cjihBrqiVfiyHXqQXYi5kXhvDW4kBZfxs1EUJcb/80iZ2hPXf/iMG+gKX6Ry+E+dybJ9OO+0fAqzUE4P+2nRXwlB8sxpNgcnuoomg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5900.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3b7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 13:20:30 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 13:20:30 +0000
Message-ID: <23f048ee-c53d-4305-b8ef-52fab2dc593a@siemens.com>
Date: Mon, 15 Apr 2024 06:20:26 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efibootguard-boot.py: update dtbs based on their
 deploydir subdir paths
To: "Huhulea, Nicusor Liviu (DI CTO FDS CES LX SVCS)"
 <nicusor.huhulea@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <DB3PR10MB69084A558EBBDDE5FB448952E63B2@DB3PR10MB6908.EURPRD10.PROD.OUTLOOK.COM>
 <DB3PR10MB69084FE3C4AD6F2A100E9E28E6042@DB3PR10MB6908.EURPRD10.PROD.OUTLOOK.COM>
 <ebe541bc-8325-4899-97bb-3993c1917a47@siemens.com>
 <DB3PR10MB69085F383DAE201100F503A1E6092@DB3PR10MB6908.EURPRD10.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <DB3PR10MB69085F383DAE201100F503A1E6092@DB3PR10MB6908.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0083.namprd04.prod.outlook.com
 (2603:10b6:303:6b::28) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5900:EE_
X-MS-Office365-Filtering-Correlation-Id: b9fbc4aa-3958-4a41-821c-08dc5d4ed2bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	M8gR3sklW5oaIX2VM2REbWWbPf16+6tUqC34zyPf0il9N4uYosF7tNtDu88eBNIi8DHaSZr1UfbpeayVOvyzg8GF56UYHrOYubTyVsU6BqimZpyD/+bNQnU+ISJ6ocQJXsbfye3TxK4iKINRouH7EJCrbBbiiXmxQaG2qirv3/97rNk3thEX+bhibD0rRefo5zjj2xZ/cFWmcjUjIt7LlmzXa4JqSJETfDvHbxXDKcjMbcKyX/bNh1zOAL6qSPnsSfpnOKAzjwnBsm3vfE9KaWtxhhmwwnzChvyKBdPRLxLBpvdALIOVbVt403BTPKK5XJY6YCkNYR4yHnCEQ+PLISNIXxtwJgX2FCMlFeqAd840ygAjjXWuVg/TO82mPIC4YGT6Sa1ZhHOFdXhOBXtDhQwKmDACmxwKIIB252ZWAfU/fOE439FPMYllrE3iQf9jvt24p3RXUnNc9rHcIsLVAlDL0JJTCCBObT1ezNYgsZxNuznXwFCQp+ANBWC5jdZdgkV5kT9lMN1iSvCRbil1l3CaFZYXTHo6pTjOxAHXk1bVV9XYQpyqbU5jBdUqhwPrF3ziGMIENzSlEgClcEjuYBOD2/wP82Yu56JDiHg2RaAa53pptEQDj06CuQQOARxO
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OFRiTllsQUlvbUNISmVzRFdCbklWZlRxcXRwYktWS1FGTGpTSElXM2N3VUhm?=
 =?utf-8?B?V3lEei9FeWdqZHkxKzUxTUNONk4rUDZBWHVIeU9UeXZwUGZEejNranZaU3BK?=
 =?utf-8?B?MzhrYnhrZGRkUzFWS01ZRUY0UFlBRjM0OHdtTjRZb3Y2WGRUNnFINnhVZlBX?=
 =?utf-8?B?N1dNREFJWG14ay9pK2NYQlZvQTZOR0plQVM2RE94eVBZK0RCLzRUVXdVNmNM?=
 =?utf-8?B?WGpYUGdjbkJaVnI5Tmp6OFBGWDhTMEltVzFLcGZDNXEvWE1NMlRlbHZrblBr?=
 =?utf-8?B?SUpNU1RDdGVpYXc3NU0rR0RyM3JTczVVQnQwaU93S3d1eTdRaUNZeHk1MERN?=
 =?utf-8?B?NjRsVEpNaDJUeUJrcUJLSmJLcll3TDR0NDg4SnFmNXExR0RyYk8yM3o2eUZP?=
 =?utf-8?B?K1pXVTJPVHpsREZvVDI4UFVOQzMySjJLbkc3Sy91RTlaMHVTamN0ZjhiQXNR?=
 =?utf-8?B?T0ZjUWFpcDgvVTJQUDl0NGFQWVlWL0pWbTJGU2VNSzZQejlCZG11U3lkU1VH?=
 =?utf-8?B?bVZjTjNYOGNpTmgzMEw1ZW5DdnBEUmoyTHVsUE9QY3N2bEdFSkd5ckgyVHJC?=
 =?utf-8?B?NUpJbnA2SzFOTTREcGc1dXhqazZ2bXVSYmhGWHEzbis3M3ZBcngxQnY3N3d3?=
 =?utf-8?B?MXdLTmlTdlZLdjNXME11TE5qelVrTnNxeitLN2RUUTNJWmUrRHJxSTdrY3JE?=
 =?utf-8?B?SzRIRSt0alJoVFgyTVBuM3dWTm5rTGdEYUp4d2N6ajRQZmhraENWU3Bxc0Fz?=
 =?utf-8?B?L2JTQ1p6UEc2T1ZRbmROcHhLczcybnd4QzZsWHo2ZllhUFpobmNPcDhPU05r?=
 =?utf-8?B?RUpCOFdPZ04vdFk0a3V6c285OEZ3OUtob1REN2FlNFlpajhNRm1aaDVmYjB3?=
 =?utf-8?B?akYyM21rcm1reTJLeG5BblhOWDJYbENFWnJIWmV2dDZZMHZkOWdZN3NzOXB2?=
 =?utf-8?B?YTByd2VoRm13NUNVSmZaeDRESncrYklSYlI3WVZydDdHZXRqRVFHUE9Pa3RX?=
 =?utf-8?B?cm5SVkJzeG5UVE5aalZNT0xncXY2VmE0SUhuNnVodmY3UUVaeFZsQTBYRmFw?=
 =?utf-8?B?RFhmRVBRYmpSZlc0eW1YMTNMVlNSY2RMaElRYXBVVGNzeWRLdk1pb1A0eDh2?=
 =?utf-8?B?aUtHZG5mSE5LWHovTEdTbDNrRGJxWkpNNEVPR3U3MzUwcjh4S3YyYk1VTGwy?=
 =?utf-8?B?Y0NvTEU4TTFONmJVL0habWdud3RQdURFZ0pwN25EZ0dvM0tTazF0cGZuSTBG?=
 =?utf-8?B?ZFo4MHMzb2wvMkRxVzVyeVpsRW1QME84VnJkdkhnbHJDVW5CTXErM2FxT3Bx?=
 =?utf-8?B?QjA5eFZqYTFpekJUZjU1SytGcWRHVXA1WmF3NHdoMkY2ZXhOUElJSG96Z1lY?=
 =?utf-8?B?R1dkMjZLMHBCRkJaRFFtanIxb2FNQlRoTERncVg5a284QUZ6UVJQdWFpQkpI?=
 =?utf-8?B?SThVemduQVNycHFSK29uWDBxY0ZuaGcwR1JRUWFEa2U2Uk4xY1loQnFUZ2lT?=
 =?utf-8?B?MDZIOTFyRG1RQjc5bW8vU2haS3B6NmVkOEIwcEZ4cHVOcVh2SlVvaTF2YXVi?=
 =?utf-8?B?QUZNYW9YT0k4bjJWZEpHWldZaHlrckNJWlh0bStpZlByeGhSMjZ1ckJTK3Jh?=
 =?utf-8?B?bEswTVY1S1ArWjZpREd2c0h0SGhsQ0s1OVBOditReWlST01RNnk4MC9zVzZZ?=
 =?utf-8?B?TmpGd3JLNks2KzBUZ3BhWGR1blI1cW12UTlVai9HbHN0NlpKekRSMi9Rb3gx?=
 =?utf-8?B?TkdlWk4xNGNpa0ljTkgxVFc0T2ZmQTM4Z2dWNFc2K3N4bWpOMlZCUW5VZU9V?=
 =?utf-8?B?MHRZVGllMFEwajU2QlhuM1hiUUEvazlUUmFUelNZZUJvMnJTL05LeTFON0x6?=
 =?utf-8?B?Z3E4VTduS1BBNlcxSTFBcHVEbWR3K0ZDZTdzc0d3UFpjUmRqQlh6T1FKclhG?=
 =?utf-8?B?clVQTmh2UTVhcXNQdzlsU2ZsYjk4THpjdit5bjNSSXYwM1cvQ083a2xDUnJK?=
 =?utf-8?B?WXU0dkZXRTI2azVvZjZ5WXdadk1sY1pIWmVuM3d5OFVHVVpTUkZCYUlES2d6?=
 =?utf-8?B?c3VIakprTGRhaDYyZ2pZWmRudXR4aEd6ZDZaY0taa2pBSkJ0SEVaMTlJU0s3?=
 =?utf-8?Q?LMUrsQYq6X6Sh7ZtiSZBZ/kTE?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9fbc4aa-3958-4a41-821c-08dc5d4ed2bb
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 13:20:30.6232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1hCjusQIQc/Y/0UjFM2R6WBreBo6I06tmoukf8bcshrWvvnU3GFdnsqW4fpW5ajxOXyudM6grrF/Xsw1LXLE5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5900
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Apr 2024 13:20:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15563

On 15.04.24 15:14, Huhulea, Nicusor Liviu (DI CTO FDS CES LX SVCS) wrote:
> fix patch formatting and will keep this on hold until the isar changes gets approved.
> 

The comments I provided on your isar patch apply here as well. Plus, you
didn't address all my previous remarks.

Jan

> 
> Signed-off-by: Nicusor Huhulea <nicusor.huhulea@siemens.com>
> ---
>  scripts/lib/wic/plugins/source/efibootguard-boot.py | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/lib/wic/plugins/source/efibootguard-boot.py
> index 4e3aefb..9451f55 100644
> --- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
> +++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
> @@ -181,6 +181,7 @@ class EfibootguardBootPlugin(SourcePlugin):
>                                       deploy_dir, kernel_image, initrd_image,
>                                       dtb_files, source_params):
>          rootfs_path = rootfs_dir.get('ROOTFS_DIR')
> +        image_fullname = get_bitbake_var("IMAGE_FULLNAME")
>          efiarch = get_bitbake_var("EFI_ARCH")
>          if not efiarch:
>              msger.error("Bitbake variable 'EFI_ARCH' not set, exiting\n")
> @@ -210,8 +211,9 @@ class EfibootguardBootPlugin(SourcePlugin):
>                  uefi_kernel_file=uefi_kernel_file)
>          if dtb_files:
>              for dtb in dtb_files:
> -                cmd += ' -d {deploy_dir}/{dtb_file}'.format(
> +                cmd += ' -d {deploy_dir}/{image_fullname}.dtbs/{dtb_file}'.format(
>                      deploy_dir=deploy_dir,
> +                    image_fullname=image_fullname,
>                      dtb_file=os.path.basename(dtb))
>          exec_cmd(cmd, as_shell=True)
> 
> --
> 2.39.2
> 
> ________________________________________
> From: Kiszka, Jan (T CED) <jan.kiszka@siemens.com>
> Sent: Saturday, April 13, 2024 12:51 PM
> To: Huhulea, Nicusor Liviu (DI CTO FDS CES LX SVCS); cip-dev@lists.cip-project.org
> Subject: Re: [PATCH] efibootguard-boot.py: update dtbs based on their deploydir subdir paths
> 
> On 12.04.24 16:05, nicusor.huhulea@siemens.com wrote:
>> pass image_fullname instead of machine as there are cases where this is appended
>> e.g. kas/opt/test.yml
>>
>>
>>     Signed-off-by: Nicusor Huhulea <nicusor.huhulea@siemens.com>
>>
>> diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/lib/wic/plugins/source/efibootguard-boot.py
>> index 4e3aefb..9451f55 100644
>> --- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
>> +++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
>> @@ -181,6 +181,7 @@ class EfibootguardBootPlugin(SourcePlugin):
>>                                       deploy_dir, kernel_image, initrd_image,
>>                                       dtb_files, source_params):
>>          rootfs_path = rootfs_dir.get('ROOTFS_DIR')
>> +        image_fullname = get_bitbake_var("IMAGE_FULLNAME")
>>          efiarch = get_bitbake_var("EFI_ARCH")
>>          if not efiarch:
>>              msger.error("Bitbake variable 'EFI_ARCH' not set, exiting\n")
>> @@ -210,8 +211,9 @@ class EfibootguardBootPlugin(SourcePlugin):
>>                  uefi_kernel_file=uefi_kernel_file)
>>          if dtb_files:
>>              for dtb in dtb_files:
>> -                cmd += ' -d {deploy_dir}/{dtb_file}'.format(
>> +                cmd += ' -d {deploy_dir}/{image_fullname}.dtbs/{dtb_file}'.format(
>>                      deploy_dir=deploy_dir,
>> +                    image_fullname=image_fullname,
>>                      dtb_file=os.path.basename(dtb))
>>          exec_cmd(cmd, as_shell=True)
>>
>> ________________________________________
>> From: Huhulea, Nicusor Liviu (DI CTO FDS CES LX SVCS)
>> Sent: Thursday, March 28, 2024 9:09 PM
>> To: cip-dev@lists.cip-project.org
>> Subject: [PATCH] efibootguard-boot.py: update dtbs based on their deploydir subdir paths
>>
>> This fixes the build failures detailed in the https://groups.google.com/g/isar-users/c/Va0Ue-ISYeA and
>> https://groups.google.com/g/isar-users/c/PSGU_AcdPZ8
>> This is a continuation of the https://groups.google.com/g/isar-users/c/ZMD4XY4dKWQ
>>
>>     Signed-off-by: Nicusor Huhulea <nicusor.huhulea@siemens.com>
>>
>> diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/lib/wic/plugins/source/efibootguard-boot.py
>> index 4e3aefb..86e342c 100644
>> --- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
>> +++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
>> @@ -181,6 +181,8 @@ class EfibootguardBootPlugin(SourcePlugin):
>>                                       deploy_dir, kernel_image, initrd_image,
>>                                       dtb_files, source_params):
>>          rootfs_path = rootfs_dir.get('ROOTFS_DIR')
>> +        image_basename = get_bitbake_var("IMAGE_BASENAME")
>> +        machine = get_bitbake_var("MACHINE")
>>          efiarch = get_bitbake_var("EFI_ARCH")
>>          if not efiarch:
>>              msger.error("Bitbake variable 'EFI_ARCH' not set, exiting\n")
>> @@ -210,8 +212,10 @@ class EfibootguardBootPlugin(SourcePlugin):
>>                  uefi_kernel_file=uefi_kernel_file)
>>          if dtb_files:
>>              for dtb in dtb_files:
>> -                cmd += ' -d {deploy_dir}/{dtb_file}'.format(
>> +                cmd += ' -d {deploy_dir}/{image_basename}-{machine}.dtbs/{dtb_file}'.format(
>>                      deploy_dir=deploy_dir,
>> +                    image_basename=image_basename,
>> +                    machine=machine,
>>                      dtb_file=os.path.basename(dtb))
>>          exec_cmd(cmd, as_shell=True)
>>
> 
> This is not a properly formatted patch, plus it seems to change to a
> path that is not in sync with currently selected isar.
> 
> Jan
> 
> --
> Siemens AG, Technology
> Linux Expert Center
> 


