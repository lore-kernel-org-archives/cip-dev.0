Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D625C54E58
	for <webhook@archiver.kernel.org>; Tue, 12 Mar 2024 13:16:48 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.50])
 by mx.groups.io with SMTP id smtpd.web10.8760.1710249397937026442
 for <cip-dev@lists.cip-project.org>;
 Tue, 12 Mar 2024 06:16:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ivOuL2Wc;
 spf=pass (domain: siemens.com, ip: 40.107.6.50, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJ7BRXYMYzRFHoAFeV2RgojnJbuulrJxH0Vi0HXNJXYYdavxFCFhlo1spA1F01Bop7J5R68wiLTlrw1U1lqAqj2KW7J9jPh8nt4AvfDU3MNeJQ/5lqnWvsDYFYSSuY8QbHTanTfjfWnTzRWg/BLsQMDzVpOWdGT6wD3iBAVujYGrxQMc88YN2Cgx60KQDyN5puZH16wtxJb2HbYW5VfmfowwLRkY+PExNjJK+Tg2yog4T1EPXHXdzqWvtpQqfK1BSM7cSDqY73hC5jUIBsTRMQMtl1exsVc19bWtlRuIllqrgWLAvlOsec3HvdGsKmt8GuDfezgwd/pYIHZvSV0THg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pIxjf4F+/KrhfBhLxoFAndCFlWXwo6QA9KKN/dHYkk8=;
 b=Z81b7KS2ATIo1Xpnx/ZDFY1ziS3NI9X2HZVZJgvDHYZMug5otvbt9nQuz95XnrW3NUdu8hk6r+Acwn7g94b/cE1XckMbk/zkbgwoVc3Y7xn6FA0kUo+EE5a1+yHnUbYxUgsgazuwQWJs9KT3iGuo3dzQRCKJ1xbefJEbzx9IXFgNDUoVw/PkwOvJuyJpw5i32k33j27736HFB9GRf+HJpXK1hMuY0OvBcy63Lktkh6VfGTEL/9kfJTVdV1w85suGuhBppUfeBifZV+mZNA/qG+Z0Omqa3u9nnc6960oo8ngEXdtmNL/grbpWRlNcvOk1yDQSzenhcmbtryKTSsKe5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIxjf4F+/KrhfBhLxoFAndCFlWXwo6QA9KKN/dHYkk8=;
 b=ivOuL2Wc7FjzQRbPoDda4CpVdAr5TPN2I5NDgDNomhZkNyFe2VZCofgdMLvW/59iCE8MQqlnpXxcZyyuBapEcEVUFe5eIDP7McXwQY/vP8WjJ/qzxp/JuIthOR4fy89rCBS396EHFJjl2CAtV8IO2zHMEp6BUOu0ziwSyDG3TeXZgnh9T3y7iERJ9kdbqP44DU+7ovcMwsRStAORpzGjLm/LywRxgIVPA90/kXBNSbZzc+Fn5AaYV/X/ZNMAvcThV3kiB4dBuDfqFx1G6TDdrz+hlYNIWwXZfcqPs1zbz4IpxofmeQaKheKYL1AxpfCi1LtiMtipI4jgU89++2YStQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by PAWPR10MB7819.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:362::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 13:16:33 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf%7]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 13:16:33 +0000
Message-ID: <311d49c9-68c2-4c35-b658-57fbaa72f430@siemens.com>
Date: Tue, 12 Mar 2024 14:16:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][RFC v1 6/6] doc/README.swupdate.md:
 Update steps to test Delta software Update
Content-Language: en-US, de-DE
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: shivanand.kunijadar@toshiba-tsip.com, sai.sathujoda@toshiba-tsip.com,
 dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20240307074612.1996609-1-Adithya.Balakumar@toshiba-tsip.com>
 <20240307074612.1996609-7-Adithya.Balakumar@toshiba-tsip.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <20240307074612.1996609-7-Adithya.Balakumar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0134.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::18) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|PAWPR10MB7819:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f8f4374-c4be-4bbf-5982-08dc4296a334
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	mXkHSB8YIv/SomrEsuQusiJaxG/jUBFU5BVQ3OEhgFq8bktwqb3cY87FYRpGiQt+CP1z8BOD2dqi9M6r1LCfcwfDVIg3pbWYNv3+UNgSyprtqspWmgZ2mTFLpR3A2AoyYpI5C+IfyeFPaBG+0MKfumhk4EWVKPQ82rx6lIt1FwUegbeY1RLK59a1lwpdfqvWcMRh+v7MfQdpgQSZgPftamobhziU8Dn1yERViyotyEdr6pZTm7EYBZFntRvu+GI0dqrIh8fyy7BoVcD6SRW1zJkoa2Y9VOv6AadyIn7L0V3vzei6nEkCti16Vt5AsfA+RZ576kSWNJ5/bL8K5Hc6DslMuU8VSgHICi0+kFTTEXdIx2rGmRaGh5Gg3r+jf8Y5ocXPT+pcRPrLvQ06Nd/QuY1qr/C8HARonhkDcI3YU3aYwpU/BVp3RszESZ7R80ELJaxECt4VE9iQJQg41rBk5lqp1DvnxvlmXomKuTBcNFq3DATMstmMQkc/XfrQcvPReDc5UtGjPYveG9WXUfZTxO/JBCVdpNwAy715YvHJaCnJvWFhkIQnwp2e3SQKMA0pJM5pXhiV+tTiLQ4SZ3RraokY+f+39Oo3nX8LOkX5o6Q=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?T2p1TVB4OURqWUZoWVZCYlBuVUQ2Rnc4cWpOVUYzRFc2RFkwM0xzT1hJZmhn?=
 =?utf-8?B?bSt5OTA3bFEvR3lwaW5aVjdiL1RUTzJHZW5HZWQ2ajhCNTQrRmtiVEorR2Nn?=
 =?utf-8?B?ZTg5NXdwaVdaR3JKMG1mcmplMmUzRzFoaG5ueFlsdFdCbEdBcGxBdjJtSlFD?=
 =?utf-8?B?R2Q3WGVmRmphcVY1Ri9oQlhZUnhBdDdObjJVL3V1a2tjaXQxcERRc0tZWU0w?=
 =?utf-8?B?R1BSakh2OXphbFRaZ2VzU3M0cDhmVTV4YzdBTW9KSllMdHpkdS90MVVWdmZY?=
 =?utf-8?B?YzhpMnNqN21INk0wUGFTUFZqMGE0Tk52NGMzZTJDSm1adGZ6U1N6bG5JSERL?=
 =?utf-8?B?eGUxaDJCOThvWGJKVFJIUCt4dTN6Y0FxZTdLNGRjeTAwallUWjIwL3lJVmFX?=
 =?utf-8?B?YTJpNVgvVmR3RlNES0NOUXBFckFZd282K0RPMlhpY3Q5RWRlVnFzQStERzR5?=
 =?utf-8?B?bXhoRG92RkQ2SWJiaksvS2hETTJudURja3BkRVZ4Um5wVXoxcm9SdjdkVTBt?=
 =?utf-8?B?aUJzZ1cvMFEzdEIvTjBnek9pYmtrUHQxbU1rU3RVY3d4VHordHhhcEsydk4w?=
 =?utf-8?B?c2Y5NVhoK3A3ZDBuc25UMHE0QzlxNG1VbFExaWxEMGhsTVdLQytMWUZTYk9n?=
 =?utf-8?B?MVNUZ0MwcDFWdERtUFVwUnRjWUZKdUp2ZHpSOW9TZ2ppVS9UK1N1c2lqTUx6?=
 =?utf-8?B?SHpSQThMbkg4QUUzMDRGYWJ6cFA5WHRFbHFvNUhveXYyWWduV1VkV1NCL0kz?=
 =?utf-8?B?NENTaTJXbGlaYm0wRE9oeDE4ODB4aTVleEQvclZXenp6bEZhVUdWU2toWnEx?=
 =?utf-8?B?T05mVndqemRxNHZpbnZ0dWNOUnArOUh3RGhESWM2Z2ZVREo1UWd1ZTA2WW5D?=
 =?utf-8?B?U1oyaTkxc1hXYzliWFRqNjZWSnhLalpXekZqWk9HOGl0bUVuUHRHMnhmcHhL?=
 =?utf-8?B?M0dVOEI1MWZJbHFkZFE0WmZnZkhnbEdjRkNjTE1FNkgyazhkSEIzYXhrRjU3?=
 =?utf-8?B?am5EZ3FncmlZeTNVbUJqWW5iVXYrTDBoZHFqd2gwTDVUYXd3RFJSVmdhUTQx?=
 =?utf-8?B?KzZoQVIrNDJjTnBTeFAzTkhyWktiL2xwejNrWWRwc1hSU1hmTnBRUzFJUGRj?=
 =?utf-8?B?VmtGdU12cEdLbWV6aHdhL3FRTWJlVk8rNmh4R1g1RERxeTZuL3NBbjJROHN4?=
 =?utf-8?B?WUNHUXJQMERqYTRrRHNodjA3VW1URjVmYW9MdnpkVUZvM2NJUzBtdnRuSlVj?=
 =?utf-8?B?eEt3c282RzVnQWgwSE0vVkRXbjA4VUJqV01TRmoveFdUaGFCcG5hSUhyZmcw?=
 =?utf-8?B?a0hwYkpCRWdSTGRna0syR2VhVU1kQ2xIVEhTanA5RTJpS1EwelhBekVlSGdH?=
 =?utf-8?B?YWNnZmdaYk1WZmpWbFc4WWkwV2FCWFJCWUNtd1lKZjB1a2sxVlNMeGxjS3M4?=
 =?utf-8?B?NFk2WCsrMnFnZkpPVFJRVEhkN1g1RW5yYllhc1VLaGw3QlJrRGJ0WHl5RG5M?=
 =?utf-8?B?aXVYTFEvZkEwSk5EQXlwL3lTQ0tFWDl0UStqWHJrVGtLeGRLL1lkV2NkQ2ln?=
 =?utf-8?B?TURaajk0TWZGN1JraitJbFJrQWFyQ3lOZEVnZ3RFRUUzWXRFNzVqWS9XQk1T?=
 =?utf-8?B?d1BORkFWeUI0N0JGRmp4cStiYjRuTVJWMkdpUGhuK3BlNmNNZW1uSU5Ub08v?=
 =?utf-8?B?OVBoT2prNldFc0JiV1ZOZFE1SkpTR3A4ZTUzajVYZzJWU0JOZWZJV0NNd2Nk?=
 =?utf-8?B?M25EY21OQWFFZ3VYSnV0eXhKcnplR29zR2lzQndWYXlUUDRka0Z1Z2c0bFdi?=
 =?utf-8?B?UGlMeE9GYzhEa0lMT0N6dVFoZi9zbG9KTTQ2OGlZQmdmMDFPczJGM1VhQkxW?=
 =?utf-8?B?cnZHREZqYVB4dlp5YzJzNXpDb1FSL3FjQ0w1dEdaTXhQTnNGb0VXVHZ1TDZH?=
 =?utf-8?B?SFZkQ3VEb1lpTUtna1RDemxaWmVWU1YwL1BaaTVJZ1pjUFdvN0djcVJqUHRx?=
 =?utf-8?B?NFVRck9FL3VHU3dLeFNydjFhUVdUMmZGMlRpOXI2alJOS0g1VjFmc1JNUHJs?=
 =?utf-8?B?U2xLczR2ZEkvNUVkQ3R6ZHF5S3FZNmd6ak1Pd3lGWWs5Q3ExZ0RxY1h6TFho?=
 =?utf-8?B?djl5TE1PWW9lTFZBUk91UmZtUkhJanZVaGsrNlBIbVl2UDlwUGllMnhWY0xm?=
 =?utf-8?B?VHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f8f4374-c4be-4bbf-5982-08dc4296a334
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 13:16:33.2020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LHgSPhLCELdJbjJXKztj5sJ2lqu8M7SgSNmPKkys43OJ6i9qe1HgDJ8aCSYPiXZJ+1FE0q4cW+zzvwZi0GFjjRS5DIj0LsC0jIHXksHQZKQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7819
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 12 Mar 2024 13:16:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15277



On 3/7/24 8:45 AM, Adithya Balakumar via lists.cip-project.org wrote:
> This change includes steps to verify Delta Software Update with
> rdiff_image and delta handler
> 
> Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> ---
>   doc/README.swupdate.md | 95 ++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 95 insertions(+)
> 
> diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
> index cf1bcfb..4003243 100644
> --- a/doc/README.swupdate.md
> +++ b/doc/README.swupdate.md
> @@ -324,6 +324,101 @@ user variables:
>   
>   
>   ```
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

In my opinion `DELTA_RDIFF_REF_IMAGE` should allow an url to an server. 
This would allow to setup automatic builds.

Quirin

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
>   # Building and testing the CIP Core image for BBB
>   
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15258): https://lists.cip-project.org/g/cip-dev/message/15258
> Mute This Topic: https://lists.cip-project.org/mt/104783343/1753640
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129121/1753640/1405269326/xyzzy [quirin.gylstorff@siemens.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 

