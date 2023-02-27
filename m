Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E90FC64ED8
	for <webhook@archiver.kernel.org>; Mon, 27 Feb 2023 08:23:31 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.46])
 by mx.groups.io with SMTP id smtpd.web10.85672.1677486208843129935
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Feb 2023 00:23:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ddaMCjV0;
 spf=pass (domain: siemens.com, ip: 40.107.6.46, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AGOr192M9drgzr1JbwkTJsrfURQb81OqNUtPcx16hIPFl+fXrvo9+smWhnFlwD8A8fwsxzHOc2eYOhNLDir9WH/aZstsxbgtfROixVjr/TSriMBEo4vRFscOmfcT3uRoHddzp+iyg+cP1DNOMkwzob8UiR0M77lU17JXUXymVA14M/EAlQSHfSR3CXAJ4NGmI2i8TjTsxQJ+WENrzjCq8Q5kTq9Y7G3gJpzKLJ8NezCEkshBFcybEU8BMd1D7C+5hToG9oJudkWcqjP8FHQ08drt4jdMvqImjykpXf31M7Z7WqyHUu2XU6hQMUIegOBIbAoXBI82uE/jVjZRGkSQfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=haQcC5xsTcij6kC1vtFbbY+O/n4Dg+dspmRrCzUFsE0=;
 b=nnf36VGSkP6huEuEv3T4wKw5wVHsAYjNOO8y3F0OXw16s+uIfDoV4RNcsqa8wtpnDud9GLL7j/Lvb2r94pSGJf8UQir7Nq6fi6hp+1N0aHW/0tfgxWzgYgElwbGUkPFr7dxGV1beZe4g00tHPfKqim/5XUsuS22c+qMJSr235NZXIfZ9HpEfFC70Osj906AEjVbXJaoU40desBSDDaKRbkc4hFooZcLOEg2eerYFE1b/ZPqdLHq064G9E5swDKt5b4+7gBCjGIaSFghjfJFZ7d1bwvR/EDHwSo858GKPRg32xGeobBO/TUDlggYyK9/p7OlrUKEZ4woIoP32feun5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=haQcC5xsTcij6kC1vtFbbY+O/n4Dg+dspmRrCzUFsE0=;
 b=ddaMCjV0iYDlbmStfLvL9bsZShPOB5KLfolUpcTZoZ8fYPLAYrAq30WkdRfsEKQcnB51Eq6UNg1zIicVL4WkTMbeDcTVwXtBu5TF3kb0QRyejdkFo+4BW4DuzYEf/r0NUn7w9oWFV2Qqq9v16XOhI0Hl05I1ZAUmhVncb1RbwNJPV46TwRVPsADhGRWABSxL4Aoc2VlWS+/tgVxjbKxdv3WmgLe8SLpw5pCjV2NCHjQDm7KZ17b1KB0bkV0IhwF10S3RH+m3S/t1QurtgLSGDqXkAFEpDi/hlkl9f2KviJdt3wsIXBGXYYo9vqoH91gjibH/PmKEgNklIUbBy7QpDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7601.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:545::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.27; Mon, 27 Feb
 2023 08:23:25 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6134.029; Mon, 27 Feb 2023
 08:23:25 +0000
Message-ID: <99bcb83e-c74d-86ed-5362-ca5b4bfd47cc@siemens.com>
Date: Mon, 27 Feb 2023 09:23:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [cip-dev][isar-cip-core][PATCH v3 8/8] Add README for encrypted
 partitions
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, christian.storm@siemens.com
References: <20230224162832.327030-1-Quirin.Gylstorff@siemens.com>
 <20230224162832.327030-9-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230224162832.327030-9-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0069.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7601:EE_
X-MS-Office365-Filtering-Correlation-Id: ed91f861-b8d8-4989-b467-08db189be5c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	qvRdDSfl9ZDytMmDtvfB1xNS8ZlHXU5SxVhInSuQfqfFI/N3WAP5At903wRGliJCqqLR0iatNZDbJ/LchDTz6gJfALZy/lcKSqxg6JhIrI0SbCIgRW7gYMscNDGa/NBT5wmQ76ViZAidvbP4/ep0kRKyr4T/KYuJS5gRBQHWblJwVOf56yDGj3zfS6tDy/WEcP/wT4ctlldTXGtSpCPeSCpp/x0Yw8nn89yZL8n7KQXx++th198SfPisvtgna3NuWWH/gY/DpJExFLumUb93u5Ya0Hh+PwnHqDaMGAsiLzfaqOWOeOC+Pgv8cVhGB2L/fIVOzQG3dD4NijVWIOQaoxKbTkS6hAH8ZWyhTgQTL8oV1AaFDhJDecS7F3qHzvQbYB5BhSr2OXpoLp+iZQCymz7YGOpqQo96lm8NLGkO0AeT/7duaOPFV1+hxL4pC4smaFFxVRAvGMJQneoVTue90dpKCCySPiOyZzsOnhsscbhXTa6YVnvdYgZr63ADvhv8r69uNy0G1A0qa4foPtnA/eVrMBgVbfcAk7K2pe5aIQ51HdCUVFTEh8yNC2ytxEoy72gX7Myx13TT1I5rjOF1ozFcsJr4BhXTKeWCoPZKlZc2B3lOJ49kyjrBnEb4XR3Me84W8/weURBsP2rKZezfWeWaI3QEgcdteuImUjtDpDFGArn4uQuX+o8hvC+pbfrsYPzh7PlHG3PVXTBiNmfsTsWAkigRqdqDGjaeSKv+ajo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(366004)(346002)(376002)(39860400002)(451199018)(36756003)(6512007)(6506007)(966005)(6486002)(53546011)(186003)(26005)(2616005)(6636002)(41300700001)(316002)(66946007)(66476007)(44832011)(2906002)(66556008)(82960400001)(478600001)(5660300002)(8936002)(38100700002)(86362001)(31696002)(8676002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bThvaUNDMUFvcmRUNEpYeDk0NG9UNWp3WUUvcU92SlZQeGw2T1FwNlgwYkpz?=
 =?utf-8?B?amNQMTlFS0ptUnJLU2RpT2NUNGdwamRiSUk0Mm11ZHdLSXFsRlZ3U0o2YnN6?=
 =?utf-8?B?cEoxSHlyOUlzVjNzVVZKL1greTJWbExCRld4T3orMG9FU25uUWpKSXp6RGdN?=
 =?utf-8?B?bnFBeWsyc1lMY2g0ZFJ6cEQxbXEwZGU3RmJRTGpROW9PdjdsNm43Mmt3a0U0?=
 =?utf-8?B?Z2ZSd2hHR3dxQVJYWlc4WjIxY3NBbkVJRGwvMU16eWs5NTU1WktSbnNlVGxv?=
 =?utf-8?B?TE5KTTJpd1Y4UnNVQ2xmYndFanE0Wm5Ib3Z1YzdMK00wdXlHOVh6ZnY3b1FE?=
 =?utf-8?B?VXZIT3J4OU1HeXpQMWlpeVVOcEgwQUhnbmxtQVZuVDhOdjRINm9wMmkvd1Av?=
 =?utf-8?B?Y2FsdmVKV2FZb1k1VHU1WStjL0hWVWpjQnJudGdyMWxqc2F3SGtnaFpxdkxR?=
 =?utf-8?B?VUp6UWgwQjRWVGQyY3hxY2JFamowVlY4Y0E2NjMzOWxVbDN3ZDV3VElsN3E2?=
 =?utf-8?B?QzQvbVdzbk9wTktESUt2WHJKY0lPcEZIcHhIbTFjRFpNQmlnUWVPbTVDdUw2?=
 =?utf-8?B?czQyeVdqUE80cEpkdGlVZUdNampVYVFEMWlMYWdTMElac09HVFVZV2VrZWlD?=
 =?utf-8?B?QUgxeDdxU1k0Q1ZWeU5tNURhakprMzFEMzVFcEVaeXNvK0J1T1pQYUZOYm9H?=
 =?utf-8?B?aDBYc0JXMWVLNFA5akZJVkNuZWtvMC9pOGp4V2dJd3d2S1lXNDVKNDJNQnVF?=
 =?utf-8?B?UmlIbXB1M3g1SG5rbzNTVW5xcUw0Tm5OWjBxRGRXL1VITjVwQ05iNDl5WFVn?=
 =?utf-8?B?Y0xNZ2w3NnV2eWtWbWV4VTkwb1lXbksyaWk1WkxSY1AwcmN2ZEZ6dkc5ZXFX?=
 =?utf-8?B?TitwSFhoS0V4V2k3MWgrazlaeUtSSFNobC81eGlncGdtQzh4dW8xTnNDeFpU?=
 =?utf-8?B?VWJPbUpodVNTY2R6WHV6blQ3RWdjWUZxd290Z3ZIQXVyYkhzTVg3MitMZUM0?=
 =?utf-8?B?a0p2dERSRHNPZDl6dUI4ZnpDTDh3VHhnRHh1ZUxrdzg1aTBlMjIydmpTS1JQ?=
 =?utf-8?B?SmErWmEyZ0UreVhRQUdpeHNxRE9QUGVTU1V0bGxBOGVPV1VPSVJYUWNram9S?=
 =?utf-8?B?cVR3OFpNeHhESzhIcGQ1STZXRTVYcitrcEU1UnphU3Z1Z21ra3RpRHNPYlN6?=
 =?utf-8?B?RWdHbzd6VGZJejN5V3lSRG5HcTJpaFFuWmRtY05PRVlRT3hDU1piZVNOY1ZL?=
 =?utf-8?B?SStOQmRXc2pYUG4wT0E5LzFvbTdXNmsvN1VVN1JaMi9Rc2Jyc0lEa0tRMVc2?=
 =?utf-8?B?ZFdNMFZGYnpaNnBFVnZaVDV2QlJ6WTVqWWtmc0dubHpZdUJhOERib0VRSkxn?=
 =?utf-8?B?bUFPb2NIbnBraVRjV25aWThnMUVzRk4yQm9VZHBzK25wSEpwKzdqczVqTTFW?=
 =?utf-8?B?d24wb3FXMVNTbDFlVmZkdjBINlZaUVRaTk8yY2RRc0Z3a1RtbmEyVGtwdTk5?=
 =?utf-8?B?ZE44bW53OVJQQmF0MytOSzY1QjZLOTdKbk96NzRGZE8xK01ibHkzVVNwVEF1?=
 =?utf-8?B?Q0RMaDB6cit6bFdDMy9DK05YNFZ0empWRkwrZGltVEJXOXFEU1FvN1dhaHBz?=
 =?utf-8?B?MjFabW01cC8rTWlmYWxscUNKZXp4TnIvY1JHdUczeGJtQjRONk4zZ1VuM2Vi?=
 =?utf-8?B?bEpKaDZTU2N6NTFJSHJoVDVpZnU0NG9VQXlZMDAxdU11OHlZYmF4LzBncFhG?=
 =?utf-8?B?dnphVVNoV1BwZHRnMXQyNXJDbjgzYi9ZeWF6amMvZlBQS0JtSmEybWptQmg0?=
 =?utf-8?B?ZUpLNGZMVDdCcHpvTXZlczdxb2wwL0s5dXppVGF2UUFNeUFZRHBDakJPNDJa?=
 =?utf-8?B?Ny80ajhkL2JNMi9jbjVIZ2NkYkRyRzZzMTdOUkJyU3dNd2pnT0w0L1BtK1V6?=
 =?utf-8?B?YWtQbFZuK1NLZGJLZXNHajZXWmF2R1RpbjQ1MGdHRFJ4Sm54aUFOcnJlYkVY?=
 =?utf-8?B?aXFSVGNUMWl5ZGp5NitDUi9WWlFjZUNFOVoyOFVpcGF1YlowNXZFZXJZb1lq?=
 =?utf-8?B?LzVJa1RPazN0OUlqK2ZhSGJYZ1d6S243SFRGVE1BcHkvTGVXZ0dFekVYV2NB?=
 =?utf-8?B?VTNodjExd0l2RE8wYktVeW4vTHpBSTlnT0tTdFNHa2tkTDdteGFuR1RtZms4?=
 =?utf-8?B?WFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed91f861-b8d8-4989-b467-08db189be5c5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 08:23:25.8245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TCLwwRPPbZ3qKgDYz2FLOhabV0WTU+xP1eXKLzAwKrJR9mZ2T2eOb5Y2T/bqzEo0Rt1uFgS/9YCqsJVw7dx/Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7601
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Feb 2023 08:23:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10862

On 24.02.23 17:28, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  doc/README.tpm2.encryption.md | 39 +++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 doc/README.tpm2.encryption.md
> 
> diff --git a/doc/README.tpm2.encryption.md b/doc/README.tpm2.encryption.md
> new file mode 100644
> index 0000000..4b2f18b
> --- /dev/null
> +++ b/doc/README.tpm2.encryption.md
> @@ -0,0 +1,39 @@
> +# Encrypted Partitions
> +By adding the recipe `initramfs-crypt-hook` to the initramfs build user defined partitions will be
> +encrypted during first boot. The encrypted partition is a LUKS partition and uses a TPM to secure the
> +passphrase on the device.
> +
> +An example for qemu-amd64 can be build with by selecting the option after calling:
> +
> +```
> +./kas-container menu
> +```
> +or by adding using the following command line build:
> +
> +```
> +./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml:kas/opt/tpm.yml
> +```
> +
> +# initramfs-crypt-hook configuration
> +
> +The initramfs-crypt-hook recipe has the following variables which can be overwritten during image build:
> +- CRYPT_PARTITIONS
> +- CRYPT_CREATE_FILE_SYSTEM_CMD
> +
> +## CRYPT_PARTITIONS
> +
> +The variable `CRYPT_PARTITIONS` contains the information which partition shall be encrypted where to mount.

"...and where to mount it"?

> Each entry uses the schema `<partition-label>:<mountpoint>:<reencrypt or format>`.
> +- The `partition-label` is used to identify the partition on the disk
> +- The `mountpoint` is used mount the decrypted partition in the root file system
> +- `reencrypt` uses `cryptsetup reencrypt` to reencrypt the exiting content of the partition. This reduces the partition by 32MB and the file system by a similar amount
> +- `format` creates a empty LUKS partition and creates a file system defined with the shell command given in `CRYPT_CREATE_FILE_SYSTEM_CMD`
> +
> +## CRYPT_CREATE_FILE_SYSTEM_CMD
> +
> +The variable `CRYPT_CREATE_FILE_SYSTEM_CMD` contains the command to create a new file system on a newly
> +encrypted partition. The Default (`mke2fs -t ext4`) creates an ext4 partition.
> +
> +# TPM2 protected LUKS passphrase
> +
> +The recipe `initramfs-crypt-hook` uses `systemd-cryptenroll` to enroll a TPM2 protected LUKS passphrase.
> +The procedure for storing a key is described in https://github.com/systemd/systemd/blob/0254e4d66af7aa893b31b2326335ded5dde48b51/src/shared/tpm2-util.c#L1395.

And here an explanation regarding the version needs for systemd and
readiness of this for production would be good.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


