Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B59C67861
	for <webhook@archiver.kernel.org>; Mon,  8 Apr 2024 13:27:32 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.100])
 by mx.groups.io with SMTP id smtpd.web10.106345.1712582850744140500
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Apr 2024 06:27:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=AtLzIwtw;
 spf=pass (domain: siemens.com, ip: 40.107.241.100, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YKwn4FjHikXImd5aZPqBzmN38E2C9FbTWihH8A6YwG49adUA1Oe4wcPqJL7rFzhQxor/YcbzbtORlHZANg2L1RdIaSXTrQF2xklnIYd6RmfzxpktkK/qfyyH37lzPLAoXS2rvV0xFq274zE49xwTsqLZ+7jAkShkCpLs07i0AJZTPZfusVjgqcf9F61sLcdFzUhbECb7gIm1GE9d1OXwG3hptXJSTfKoy/w5NPfVZKkrSiS5l7xkXhR4Y3vQ8pwXMpqJmx4K3DeeNhJ+ih1F1BbYjVgV7eipm+qZSAVJTGWq+A8XMJj7ruPXKbPk9+Qjql1k3SykHmRs7sRKbyP7QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=06tRoTOmsrlwOtO1jU1S+RoHyXtrzrzhkYHfZ1td67I=;
 b=FejpbcHAV88nc4c65r2bFT1QLohrxmjSCXYIxbfWyWc5E6A+GZNZ4mAXLrVJ4rsTyYxwZ7y6V9iIxP+9Kx1bcZOueRm1WSbLYcPWA4IVhEEZupDQCyMuP5aMPiF+z3UaFLeS1oglsg1CMOOSJMRutEngV54abubM/3Zr8WvuhspbosZHk9vzRj8h5sRpv/YKTLnNDAUnPrHpkZ2NJIgFxhx5Uyost8w7R+Ao21OZ/Bh61T1FIrbjZVlypEVX3JJqqeMSBZ2KcURwOvMf8mzR6fucTZJBgqat/8ng2wC52KYvgsN6aymIBcGOc6jSQPLkC1x33daHEokoimojtD5y/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06tRoTOmsrlwOtO1jU1S+RoHyXtrzrzhkYHfZ1td67I=;
 b=AtLzIwtwaWKnxcSuq518afbpCwtNJLa/twVAoDdvlFHpD7Xxqx8Ily1r6wyWAYTqnPOZIBSwXXu8A/ORuPqfUQnv1uY2doTuvn74covjc4ws7AQxlQfnLZGQuAWRfxAVUfR2hkkbnqXe5RnZljZX0tPaP/Wq/up76zwSW4/zUnnEUIdk/zZLFclfqfcg+jCGNbRlZMg3Z1WcWhb1JLVn6sUE1EKuUsWFleSAqeJerrzcESMOeDncI2DEeO30PzL7wnGd1EC5UdaTtvLMJQ1bSmyQG67l7HNJHoYswYAuei7/CYKOmgLE0R6zLLXLEmcO4LciCqY2RaaezD8RqMUALg==
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by PAVPR10MB6910.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:320::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 13:26:26 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf%7]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 13:26:26 +0000
Message-ID: <51e697bf-4c2c-445f-b3a1-884e7923904f@siemens.com>
Date: Mon, 8 Apr 2024 15:26:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][RFC v2 4/4] doc/README.swupdate.md:
 Update steps to test Delta software Update
Content-Language: en-US, de-DE
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: shivanand.kunijadar@toshiba-tsip.com, sai.sathujoda@toshiba-tsip.com,
 dinesh.kumar@toshiba-tsip.com, adithya.balakumar@toshiba-tsip.com,
 kazuhiro3.hayashi@toshiba.co.jp
References: <20240320103229.1078738-1-Adithya.Balakumar@toshiba-tsip.com>
 <20240320103229.1078738-5-Adithya.Balakumar@toshiba-tsip.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <20240320103229.1078738-5-Adithya.Balakumar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0105.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::6) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|PAVPR10MB6910:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	kbzAGaZIeD9d0VkHKOdejPV2ICZKz2nyE9WEA0STVFD7SS3LUQQdNSdENjhXAMFAiAVtjRkqe3K+l83rPasD2+j6SA9oHki1ZvhaKsaR/Mb0jQzyHx26s+KYLREOaN2h4+mt5wj0MvIRPldd1D4it6XMzQ+MfrkUMZfsKmlh+7uJ7Co0M4poQTblHNVXaraWQuF4FPJEJRXSX5dWmjAvET2iXpq0IPvUjfwT+F3nSmtKI5nCZIfwN8ikG4rESF2tYtIPDi51LZutahNnVYa8xphdwpKg5yd3Rtads3rOabR6odw1ZpXuh56CSlG8P03CCPQigschnU6mu4ZuQw28KNkuhwKz3CMhGuWojAuDTTNorxY0077amDiTyh3XMA22Nt7CyTh8E3us0uD1LqY9cmnMq2rr1AsxdJ9gx4MISkyA/BN5EFHgWTEajdZSHsIxEk0xm6NCIWX3KBV/F+JqFMcQclpvOTMJN2UzjMzhcu3c7kNeGV1l3iMai/rNjs4uH+IxnsrZ4NF5jrqY2H+pemVR3L4V5ANO3VBRvlBCP5QK5MeW1MGlU8+l0H9aAhai/x0fAhbflP3ah/vB/QOGmWOEy9UIFrOOzCW+VsfuCpw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?L2ZoaHRXWXg2YzNNUVpaOTBWcDFMeW9sQTJjZFNJdXlaYkFFR1N5Q2djSGp2?=
 =?utf-8?B?a2REREJzMUVMdW81V2lBQTlxSVl6SnpJSHFoZWcraTRYSlpaWDc5VU01bGsx?=
 =?utf-8?B?VzVrbVgwSFNOdTdVSFB6RHVheTR0aE1oU09BT1E3NHo5a0NOcERjN0c3VWti?=
 =?utf-8?B?TlNna05FRmIrTUZ1bjZ6SUVDbEhCR3VFdHk4L0JVTE9LWHpaTUNrK29aeU1q?=
 =?utf-8?B?b2JjZitQNjRzeVBhSG0zY0M5MGMwOXpqK0VBeWEvWjMyNVN6QjNpSm4wWWZm?=
 =?utf-8?B?eEhKdzI2d1ZiYlpUMFFSL3JoMnNtTVlIb2JpK0NFaUUzUmZkVVoyZG4vY0ov?=
 =?utf-8?B?RlNsV0xtSmwvVE04ZDVjK21UR1pUVUVjRmxENDZxSGI5UUFEVVBHOE4rNmIr?=
 =?utf-8?B?NkFQeXJ1RXRpTXZTSXdFVlVZS3FrVllzampvK0k0Ymx3RFZTNkhTL21nSTlx?=
 =?utf-8?B?K2RpdE4xU2FvSUw0UXl1SzI1UWJCUXFMYlJnenhkNUJDTmdOM1FXKzNsM0lx?=
 =?utf-8?B?eVcvejhzWmRIbFJ0MCt2OWVFZHJYV0g1THV1N0dnaEhOOFU3UURGRVM4T2dK?=
 =?utf-8?B?bm9iM1lUU0EybUY5MUNWVHNNMzk5bHVLblIyMTJpd2FCL2xjblNpQnFTeVZG?=
 =?utf-8?B?VktscDFRRThDZFpSRHVQQVJUMnFLOU5vT0g4RmRucHliZHEvZ3R0V1Nta1Jh?=
 =?utf-8?B?Q3A0Y3l0S3VNbUtPblZkeWg5SkJ2Y0FNUnlCd2plMFBVT21ERENZSlpEYjJK?=
 =?utf-8?B?UnFNaHBrUWIwaGl4SjRXLzNrdzFFZ0pQRldsdS9vL2FZVGdOUG9FbSs1U1NO?=
 =?utf-8?B?NW9OZjJaa2l1blRHMitWU2VkYjVlWHhGaTVmaUlNS1AwbzdnbmpKVUdmdzlQ?=
 =?utf-8?B?WHpJbStUbmhNU3I3L2pqTnhlRTJwanJWVVkxT1psYjEzN1hyTGh2a3dKc1pm?=
 =?utf-8?B?ZnF2cG1SVnpPanREZFRZOHA2Z0VEam9GLzY4SkxBc1ZNbG9SMkxBaDl3Z1Ni?=
 =?utf-8?B?V0ZxaW90cDlmSS9BZkxrbTZlbEttWG0zQ0ZDV2VNTmxSNEhsRnBaMCtJdFZC?=
 =?utf-8?B?cm9lTVlIZWlDYVp3N05tYTV4aVl0RE0vNjJ0eTBTYTNEcUR4dExKdzcrKzJs?=
 =?utf-8?B?SXVsdnlBVXROOEEydUpJOURLMlhYcjgxTHAxV3I2ZTVBakQ1eFFzRUZMN0FT?=
 =?utf-8?B?TnJBS3NnUDFzeDMzT0lvY2paVmFZbFZROHdlL0Q2UG1iN3hJbHZyM1Z1Rm1x?=
 =?utf-8?B?Tld3MEJablE5SmhMdm5mSGhmU0JZLzVoQ3RwKzNnOU0rQVFxZlB1T09POTRY?=
 =?utf-8?B?TDBUdXNEelBoWUphU0IzYStoSU16ZTlhc2NtZ3JLQU1HaTcrelhZc0xGdjcz?=
 =?utf-8?B?NC9PL0h0TEtpcE5oUWdKTFBPengvMHMvSHJscHdzZGUrZ1pSMXN0UnlBdnMr?=
 =?utf-8?B?aXQwVVlzenhoUnZUbk16SzBSZ1lWMW5FcFViVzFYZVEvM3ZKUUQ2dHNpT0Rw?=
 =?utf-8?B?cURuYTArRUdXYkw3VGZyRzRFUDlDYmg3cXFPQ0lkZWMyWGZDaU5ybFF6UGFC?=
 =?utf-8?B?M3VsK2FpRkZMeCszK29kSnd4OTNyb1AzV1ZEbzRyeE0zZERBL2dlbUxnc0NH?=
 =?utf-8?B?UWVFNGdVcFY3ZHArWmR0ZWdBOVBkNXc3UGZueUY5MnN4Rm0vTCtNYUUvaW5w?=
 =?utf-8?B?V2xjYkt0RlFqZDZ4Rm1acVJBdG1XRXNvZGxFMTZPUXZUaXhTZ3lXdGNUd1Nq?=
 =?utf-8?B?Wk5FQTdXODRHbU5LckJBSFhhRG53SFlpalEwYng5QUVXK2lDSDhIU2NFZVFQ?=
 =?utf-8?B?UW9pR2VJMXVCcTJqUXk3RWhpWXBzeDZqd1lQZTNKaGRQRWEybXFlY3dmWmow?=
 =?utf-8?B?Qy9vN3VYUjRRM3haSitZVTR4VHN2TU9wcG4xL0s5WUFQd0RwQU1MRHI0cFFG?=
 =?utf-8?B?VGpkaUpTVm9CRHE2dHp2a0IyT21jNnpiUUEwU01Nd3p4akNQSUdxMEdHOSt3?=
 =?utf-8?B?YktjTVQ4ZFpoemUwM0lWcFJhWDQ3RkluR2dVYkU4aXdram9YNDVSU2dzbVly?=
 =?utf-8?B?a2xDWmNyM1JJWjhaaDd5VjY0Qm5RWnNtL2wrY0lKMU9STFRZUW4wNk16N2Ft?=
 =?utf-8?B?eHlFWnVmTGgreHRHbG1YamhBWi9WSzRPSlN2c1E1VFJ0N09aMXZheDFiSHhY?=
 =?utf-8?B?Q2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44046af3-b848-4c4a-c936-08dc57cf7e07
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 13:26:26.5314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N61rl+poyY42NzT4FV4HJ8PpIr33Mjd4jtwy8AzH9z4PGIC8EA0BEsV9AtZH121p5RoXv4ELARTAPXxAGKiTPYf7z1jnCWXrX4t3HWfJPZU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6910
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 08 Apr 2024 13:27:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15503



On 3/20/24 11:32 AM, Adithya Balakumar via lists.cip-project.org wrote:
> This change includes steps to verify Delta Software Update with
> rdiff_image and delta handler
> 
> Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> ---
>   doc/README.swupdate.md | 59 ++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 59 insertions(+)
> 
> diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
> index b7e13f7..3862649 100644
> --- a/doc/README.swupdate.md
> +++ b/doc/README.swupdate.md
> @@ -360,6 +360,65 @@ user variables:
>   
>   ```
>   
> +# Building and testing the CIP Core image for Delta Software Update
> +
> +Set up `kas-container` as described in the [top-level README](../README.md), and then proceed with the following steps.
> +
> +First build an image using the following command:
> +```
> +host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml:kas/opt/rt.ym > +```
This is already written in section `# Building and testing the CIP Core 
image`
> +
> +## Delta Software Update using rdiff_image handler
> +
> +Creating an delta update file for rdiff_image handler requires a reference image (against which the delta is computed). In this case, the image built in the previous section can be used as the reference image artifact. By default the `DELTA_UPDATE_TYPE` is set to `rdiff` and `DELTA_RDIFF_REF_IMAGE` is set to the path `image-v1/<artifact-name>.squashfs` (or <artifact-name>.verity in the case of Secure boot enabled image).
> +Copy the reference artifact to the mentioned directory in project folder.
> +
> +Custom artifact path can be set in `DELTA_RDIFF_REF_IMAGE` manually by adding the variable in the `swupdate.yml` file.
> +
> +Build the image with the modification as shown above with the following command:
> +```
> +KAS_BUILD_DIR=image2 ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml
> +```
> +Now start the first image (which does not contain the packages vim and nano), run the following commands:
There is nothing related to vim and nano in the previous steps - and vim 
or nano are added to any image in cip-core.
>  +```
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
> +## Delta Software Update using delta handler
> +
> +Currently zchunk based delta updates are supported only in Sid images.
> +For Delta update with zchunk, set the variable `DELTA_ZCK_URL` with the URL of the zck file that is hosted in a http server and set the `DELTA_UPDATE_TYPE` to `zchunk` im `swupdate.yml` file.
> +
> +Build the image with the modification as shown above with the following command:
> +```
> +KAS_BUILD_DIR=image2 ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml
> +```
> +Now start the first image (which does not contain the packages vim and nano), run the following commands:
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
> +
> +
Duplicated section. Already written above.
>   # Building and testing the CIP Core image for BBB
>   
>   Follow the steps mentioned in the section [Building and testing the CIP Core image](README.swupdate.md#building-and-testing-the-cip-core-image) for creating images and .swu files.
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15382): https://lists.cip-project.org/g/cip-dev/message/15382
> Mute This Topic: https://lists.cip-project.org/mt/105041877/1753640
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129121/1753640/1405269326/xyzzy [quirin.gylstorff@siemens.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 

