Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFBE7C001B0
	for <webhook@archiver.kernel.org>; Thu, 10 Aug 2023 10:56:15 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.61])
 by mx.groups.io with SMTP id smtpd.web11.14425.1691664970696092259
 for <cip-dev@lists.cip-project.org>;
 Thu, 10 Aug 2023 03:56:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=nhTjxq8f;
 spf=pass (domain: siemens.com, ip: 40.107.6.61, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LG8PmxGs21SfD66MZIuYGWDtyl5ap3rn0JWBGaoHR9CaocOQ6/hn7fF5Npo3Vmc/kkUyx1EOOBJ3QA+Uw+ueOJzWBpCqbkjib5ujiDIQBlWDxOAKFqXqhMgABj3LHCOXgFBvTUy1dh9t+4lfuYWHdA0guKgKYO0sAe2X/5p3S5799puFyYAYgvf3MdiLoHakdmcbK99OMHBGvwOolsRylhwQtedDxsF9iI6M0dSKVnBAohwwdXI7RxwFGTsE/tJSOzBKLqrDsDl/Mv9Wu38wri02WCPGnZyoz0tRqeQS9zAc5794q9xlZeG5J42uVXd7AuTudIfGCkfI40PG6S1kEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N158lSHPfICX5fAc+8UCo6M+w9aH5E8eal4G/DAnhp8=;
 b=me9sT343Pxsfy6FPplrRMgK6wKyaluZT3o8Qan53mjpCGkRaE9kfR+PnCsiVyw7c2ohp4M0TjrWPhOlA7XAJ8cv3btYNOsZM8bpU64cQO6Zygj1zt3DkBKLeaaRkdtT02iBbTJjQC2ajWKJcafmQ4Mefx/82vOZjyCxNMdpruLq/huH0jLsKtJpyfOMUJeUUtc8EYEDo3PYyydaYLsr9pabXVQ3MttItIxas/R3WorATZRnawr2ovclcdSi1XbshgNL/AU6bOSKjrQdlQqhR2T78js2eiabJicRDm+McUlrWDwY2niX06Bxg4f0NuEEsL9lJaKyawPZ8ugM8JnCr/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N158lSHPfICX5fAc+8UCo6M+w9aH5E8eal4G/DAnhp8=;
 b=nhTjxq8fl/xNpXq1drFe6H7/jT3DlqjDhYF1X/oxjqFG3I3NOfreagY60mzkOhx6j/nlIuih84HUAyykBvdjNh9bdQjvuIZ9vaeqUA62KOBA9jJkeyOlK1AsVewbI8u7qmmcnqdqXmGXkUPR1iqdCYQ6kcuQD069koTEHocC2tD2mWwHrFmJN2EgDa9xYM5HhgUwzNfRDufMweLtJoxgPtERYVQ/vJFGvxnmcdjmTXz0bStlPEQrOMWjNVyO+nRnlBulYh5BTMY1EC2riXlbvx8NY4MtwUVCGqtqxHYJARRMNpR0MUwH9vAmgtGEKVNQGZsCEfz1naSX0NNZMhXOeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3683.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:15b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 10:56:07 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 10:56:07 +0000
Message-ID: <26b0c006-867c-4f42-b96d-7dfa0e9a0e9b@siemens.com>
Date: Thu, 10 Aug 2023 12:56:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 1/4] initramfs-crypt-hook: Avoid data loss
 in case of resize2fs failure
Content-Language: en-US
To: "Koch, Stefan (DI PA DCP R&D 3)" <stefan-koch@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Cc: "Storm, Christian (T CED SES-DE)" <christian.storm@siemens.com>,
 "Adler, Michael (T CED SES-DE)" <michael.adler@siemens.com>,
 "Sudler, Simon (DI PA DCP TI)" <simon.sudler@siemens.com>
References: <20230728143320.3891194-1-stefan-koch@siemens.com>
 <20230728143320.3891194-2-stefan-koch@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230728143320.3891194-2-stefan-koch@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0112.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3683:EE_
X-MS-Office365-Filtering-Correlation-Id: f6ba6eaa-fe56-4c7b-98c0-08db99906676
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ul9oTg6azn6KPOEeiXYi5TeWv6nDoEMmSFeCVwXC+zNvVcq84JF/BGJOtgZ2hB4psC3Cl7wCSAzW2gS1TykCU5mTfnm2/tJT+XXFLfSHI5WzqQ+HstVvG3zd1TbSWtfUW7nEphKT77Q3A8N0+oArcaw9uv14hEfsl1bleOWNDVHE6yukxNDL9tZxAJRbt+W5FQCB/wcmMT9iJK3u9Ccu4jr7lbDoNb0gZSwsRM+0eA64GxKvjl/zXFjnixf+hU5/rmWWtLJUnRCoCXLshhHNc5Hy4KU81U9nxvldOl439iS/D4EQ/cnvB0Do75+17umE4AFqLr9BrJtJKXJq5aMRTBDRbukHoPuISjNrenH0PG+WAHJgaZKogU1Hw7Rr5PC6uZVrku/gw7Zi0or1k0YNjb+blvpBV2byEFlIU4zfZE+zgIjbOBK6FOjYlKCvrdiTOfhbHxtmyOeqigekKmsZXyVhdP5C/I5BkMbH7AOk6arDixiZHUJ6mfwAeccwyjxQhSfzj1lMKOvtJQXSo2su3aA4F7Qdvscshtc3duigYXi9r7+1EsuPqjQr2EIt6lM4wyrG6ISAyW650tgGnPNI+hn2XzE9fq4rKlr3ZJN1dlHxm8tV4VDjwkGkLe8j37KwRs3LyQRuDkXbCgQkqcY94w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(39860400002)(136003)(346002)(396003)(1800799006)(186006)(451199021)(107886003)(36756003)(2616005)(4326008)(316002)(54906003)(38100700002)(2906002)(110136005)(6506007)(26005)(53546011)(66556008)(66476007)(66946007)(6486002)(5660300002)(31696002)(8676002)(8936002)(82960400001)(41300700001)(478600001)(31686004)(86362001)(44832011)(83380400001)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dXhvRDVvYW9sTjk2cE0wQVB0NS9MYmoxYld2QWRJSVNrRHhRZCtKdCtlVzBx?=
 =?utf-8?B?MVRsbG4vVVJRQ2xJMDFucDZZNnc1R3ZnU1FkS0l3WXlndFFpNEc2T2dmN0RY?=
 =?utf-8?B?TUZ2SE01eVkyZWRnU0lEdFo1K2ZoRmcyWmpZUUd6ZTNDUjUrM3kyOVo2SnRQ?=
 =?utf-8?B?R2VpNGtCS3hkNWpEN0x5dVBab3BrRSt5VkpMM3FvRkxGV0pyWXdOaWh6dC81?=
 =?utf-8?B?RWFFa0ZCK3dxekJkZ0FleUh4bkdDRmtwQk8vRDI0SklDRHl6OTF6d3VGRm9t?=
 =?utf-8?B?R1lrYzFnV3d6U1lxZTVJMlk3aWhaWXJObzRBR21qSlE4ZWRCd0djRllpVWpM?=
 =?utf-8?B?WVNGM2RVUG13Z2lvRlpwUzA1QVRTYVZpZWF5a3pjRlA1OSthMmFRZno0NnA5?=
 =?utf-8?B?d0pmVi9oQUVQVldHK2x6WGErTmgwOUphK0ZEek41VmEwSDh1c21kWWUxZ0NR?=
 =?utf-8?B?aFBYTSt5cG53YWF3eW9XVm0xZzNsSGl4SmtQdFMvanBnWjUxQ0xyVG9FNTFP?=
 =?utf-8?B?bkZ6UXFQMlA5U2dHdjAzdko1NEcvMkFWN0U0ZjUvZWtGYitrUHVQZWFDZFBQ?=
 =?utf-8?B?U0YwdGdIWHJUdTFMWEo4RkM0NUhzeWVaMW9lcEx4d2ZjTHN0MVoyb3VWMWFJ?=
 =?utf-8?B?WVVmUzZtWlJQR1grMGdHUnUySmRiZHpVQ0doL29ycm5jZ0hzR05oTUxUM21y?=
 =?utf-8?B?azN1WUpLYTRYQ1dTZHlBSDVsVXJEWVdwRTU5amFTLzJCZXlNTlhHV1VrM0Vn?=
 =?utf-8?B?Z0dPYnpUYnpXNTRMM3RhZXBrYzA3QmFMZWFsZjIwdlNDNXpNbjQrNi93WE1k?=
 =?utf-8?B?Z1BEZmF1UXJGZVlNSThoQUVwclJ0dDdmVmN3VDJuTmcyRGxYcGFlcGtDUjNp?=
 =?utf-8?B?MWd3NmhXRjZuemlNUTRRUURZMWRaQXd2WDQ0YWszbVNDTGpvai8vZzdRV1FQ?=
 =?utf-8?B?ZTF4VTFkZ284OFoyYXBiUnZjQVkva1FNSDhpblJEWEZRNWVoM2d0Q3h6UEEx?=
 =?utf-8?B?a0g0RTF3WkNNVFdLSGJUSHB4b0c2cENGSDNaUGZyZEdyM0FpbllYbEh0VGpu?=
 =?utf-8?B?OVpTc29PRWtxSCsyVnIzeG9RVGtwYjN2cXdpYk80Wlc2UXE2eHZZVmdPd0w0?=
 =?utf-8?B?VnNzWkZVMEdqNVVPSEtjRU45bFFvNDZJUUNWbklnTG12c1ZwS2RnTXdEYzdP?=
 =?utf-8?B?aEJPTVFvT3BWa281LzRINkVZbS9IYVMzWFZZY3I5VkRXaURzWkpwMzU2NnRy?=
 =?utf-8?B?RnN2U3c1MFNlQ3B2TWlSMlptRi9FTEcxNVA0SUxVaGlmNlBKaUx2alp5TnY1?=
 =?utf-8?B?VitRL1FGZGd4THFqZVFzQkhRQmxvMXR5elZZYUhoWGVsQ0JRS3pxRTlHWXFL?=
 =?utf-8?B?NFVRL3Q2dWZGRFlMZHFMaUlOdURFYzlIU0RwSFFYQUtoUEN1OE5VNTZ4ZFo5?=
 =?utf-8?B?SWtOcTNXSGthdjVlU1pIZFZTVk53QXZVT29EZkU1ZnVYWmlKU2dsUHJ3SVJ2?=
 =?utf-8?B?QlN6VmovY1NFV2VEUmowa3ROdHkySVhRQ2FLcTg5djc3T1ZHajk5Ly9yTzA2?=
 =?utf-8?B?NXlDWmV0bThSbEl2RC9ZSGFFenpUSXplWUlzTGwwWXJ1QmZqYkxRMEZFWkVy?=
 =?utf-8?B?MW1OYkMvZHJlTTlCY2s0cnNqblR3bUVnb05kTG1meGQ5MThvY2N4RkxjL2J4?=
 =?utf-8?B?Mk9WSTFkVUhvY3lFUkJyOExZdVp2Wko3VGV2MUI0RWRmYk82OTB0cnV0WE8r?=
 =?utf-8?B?V093cUZ6VUxKZjVHM2UwUzY3UHpxV3FIclgvek5GNTVVbmo4Q3h0WFF2am01?=
 =?utf-8?B?elpzSFhweUM5b1lvRGJ0SjFjcnRXSllTUGx5OU03czFDNy9qYW95bmVMQUtK?=
 =?utf-8?B?bndUYjdONm95YVZEbTBiVDQvZStBaHdPSzVITjI1TEFNMjA5VFQyQU10bUxs?=
 =?utf-8?B?dU9KVUpZcUhIWi83TTZVaURPVnNNYk5OblV5OUorSFRTdFdUbFJ3U2I0VFhB?=
 =?utf-8?B?OVM3U2xMdDZZQVZETDNTRXhpK3FWNnZPcTh2cXNlYTB2T3dmSXZrem16QzNl?=
 =?utf-8?B?Q0NKc043Ukc1SFdZOFlDbEovRXNPWHI2QlVMbVFITE92L25NZjF5ckJoVnNa?=
 =?utf-8?B?dmxMUzFkWGc5OVI1amxLN3c4dkphZ1RyeStlRzZKbjVuYWJ0VzlmaUlyT1JD?=
 =?utf-8?B?MEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6ba6eaa-fe56-4c7b-98c0-08db99906676
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 10:56:07.7407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1hTjh/WQzioxTNx4PcfYlQVK/kaNLMS3j4xE39R+0JjNox1jxvMJLMak27RTFgwodFLJUyGCGJW4FTiloF6f8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3683
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 10 Aug 2023 10:56:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12593

On 28.07.23 16:33, Koch, Stefan (DI PA DCP R&D 3) wrote:
> This prevents writing random data at reencryption
> after resize2fs had already failed.
> 
> Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
> ---
>  .../files/encrypt_partition.systemd.script                    | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
> index 330188a..83c3238 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
> @@ -87,7 +87,9 @@ reencrypt_existing_partition() {
>  	reduced_size="$(expr "$part_size_blocks" - 65536 )"
>  	reduced_size_in_byte="$(expr "$reduced_size" \* 512)"
>  	reduced_size_in_kb="$(expr "$reduced_size_in_byte" / 1024)K"
> -	resize2fs "$1" "${reduced_size_in_kb}"
> +	if ! resize2fs "$1" "${reduced_size_in_kb}"; then
> +		panic "reencryption of filesystem $1 cannot continue!"
> +	fi
>  	if [ -x /usr/sbin/cryptsetup-reencrypt ]; then
>  		/usr/sbin/cryptsetup-reencrypt --new --reduce-device-size "$reduce_device_size"k "$1" < "$2"
>  	else

Thanks, applied this one already.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


