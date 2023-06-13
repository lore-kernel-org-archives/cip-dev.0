Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A27FC88CB2
	for <webhook@archiver.kernel.org>; Tue, 13 Jun 2023 07:12:35 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.73])
 by mx.groups.io with SMTP id smtpd.web10.7782.1686640346052926504
 for <cip-dev@lists.cip-project.org>;
 Tue, 13 Jun 2023 00:12:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=bUz62GIX;
 spf=pass (domain: siemens.com, ip: 40.107.104.73, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CH55q1G17k9eNz4YRVFAfGR4JczUZVDeyjJ4CHQcvw7y+ZvtTsIZNJLW/0NpLZpc+tjYi83O28uBllzbXiadSNko6VObz6ODXu9OKPKG5qvLwWB0ErWTNTLpm0yBYgFtIQMK6XXdawwIA76AArGCEZbX6scSa1EvKMBGuk7eWryLVkrvXtxy7c/JHfLwFVI7+Bwe+Bql1eJ+8V5QSZBtZK+jSfDRqfzaU6DY0j7CMeoKbWsOlD16DRj4bx5CMrN4HIgNgGLW3HVbiXK8+Ravu2cXD5HPRso/EQFlgYEwcVttcDUkuMjyBVVfTyCAgsQDQtJRA9aOHhDX01juQrQxTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S+Y23NR1EqEmcOz9SXK1ZmnNebJ/Lj7Ri4r8NvBMzyk=;
 b=a6HXn7k9oJx/EOvKWlrxc6FX2KFw8sfJNVOQ3F2lW3jd9/0C5mdZcVstb1deIbh3Py/qpXPCN+lSpUiZ0+xoFEHgULC3pcWY+wiM/ppnBOwHfTwH4Ayp7hmIfQFoWUfO3thRlI+2GY5knZ6XE/qwyfL9Emvm0e2f3ge1/L4PoDz0lk0Vnkn/V3Md5wVbZYV+PdGgyD166sQLWsXPky21jT3YkJu0ehKOFzcYIn5UGdNnVpNHGuwBGB3poF+6izqICrEIst0Qm4aVlUIDv/+pvlif7T0gP5SU1Thibi2hpi4NljYTHHewuQGm9Yf32Pp/RqMljs9qSHt/dZvx2vHQdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+Y23NR1EqEmcOz9SXK1ZmnNebJ/Lj7Ri4r8NvBMzyk=;
 b=bUz62GIXDWlpY/zSBfbkCZ4dLWjMPpR8EX+0ME21OUTMvMKnf2JLEe8F3nYXKegZqAuH2uVy+ltpYg35+snGZGpVjfSsiQKt5XefR5Rz9K8f1k3XLbGeKtRz9XnR1xzeyCOhxCLrjE0FG7v0ncXQKZORtVn7cWZxuIg7N0xIrWhVKEooFg3EjSKvnenH4ceVMboWdo8oAA6X/27faJ3JbCqwjf4+QQNuC5Ca6i5Ug7Q0GMz1A77kkRAMHhNMndIe0VmUfnflr28HEzfSbUq5pTZxgKfY4DGE8Mw2jalJKwmttCV5k02kSGhVdSKPKKzUlhKnNO65hGzTj/sJKp9gJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5671.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4f2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 07:12:23 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6455.037; Tue, 13 Jun 2023
 07:12:23 +0000
Message-ID: <4d389a98-07fc-ba02-a067-f7d7349ac9fa@siemens.com>
Date: Tue, 13 Jun 2023 09:12:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [isar-cip-core][PATCH] swupdate: remove BASE_DISTRO_CODENAME
 override for buster recipe
Content-Language: en-US
To: Srinuvasan Arjunan <srinuvasan_a@mentor.com>,
 cip-dev@lists.cip-project.org
Cc: Srinuvasan A <srinuvasan.a@siemens.com>,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
References: <20230612103033.2562735-1-srinuvasan_a@mentor.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230612103033.2562735-1-srinuvasan_a@mentor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0237.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5671:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ea05ef9-0bd7-47ec-b5d1-08db6bdd88c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	mMtD2rLBNd+9+TvwVdv9fUQW4XO6HskFmC5AxhPTNMlEQtxc2swdMY+C4ei9WHQKrehJQEIr/J32c2MU/i52YwL3XZBVP091WWz5FVTEmAstvnAPTNaZA+uZ9ZkJweCtSjibUqS5zY75fNFphzTlGEKu/0cA4VUf91/NBZ/Ov/OdKBHf1PRlygOvq9snT5O7Qub0n584IuaGqX6LBJOCc3slnxOkTZQRGcd7f6qV3sDE/x80sM6LNj7GNmZL/X12ufaxquLXJVX1yDfdFN5F/i/Ytrv7pW4OntmGUO1qo5usAeLDpzvjvFubH5GS6/H/JoikaS5Nx9SjUZm9d4XD7YgJ4YVaFjfkFyFbCNAVaJMS+gCgepauZG29z+f0d60uBKaTfB92nECrrSIelD7A3XX+k23J5gtUq8/ovkSCLqTGYLVs1VkoiWzmTmK1nsEDjiiiCXUU70ZoNdSh2FnbPXqQTikj/6pJsAQSVywiJk2fY7eUqvcoU1enlptss+fRVcvgcHNbywJTblXdBi05D+TeZboem1mtGnBuJLjpOZ+B6h1iIqJk8KetfoDy5aYVBZN7x+9pWvB+D3O0V2cEUoK1+zl7zVxwN5urtNI8TSrr/beVqNqBi4ANwvmQiywDIo11cIYmTZhgI+AjRAkKsA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(396003)(39860400002)(376002)(451199021)(107886003)(6486002)(6506007)(36756003)(83380400001)(38100700002)(82960400001)(31696002)(2616005)(86362001)(53546011)(26005)(6512007)(186003)(54906003)(66556008)(2906002)(4326008)(44832011)(66476007)(316002)(31686004)(41300700001)(5660300002)(478600001)(8936002)(8676002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NlIvVmQ0T01ONnZWdDRwTjZ6dFpBZ0RkMTRFQmg3aS9lSi9NbS9hQnVHeWtR?=
 =?utf-8?B?M25iVHhKMzlmL0pCWHJQSzY5QnVBN2FIN2UrTDBYT285T0dkSldRR3dVQVZJ?=
 =?utf-8?B?djlPc0NwRUxuWGl5UVFEcGs2MU1BTFRweTc0akI4ZHFRWGFyVUE0VVovWENu?=
 =?utf-8?B?QjFHNlp1R0tORU03c3AyeGdESXdFSzZSRmNiZTlGU3R5ekNUZk5PSEp0VVFY?=
 =?utf-8?B?dzBMbTl1WWw3ZFZtdVZBTXk4SllkdUpYTHgySG9Kd2ptbytLaGUrZ3FLbEtF?=
 =?utf-8?B?NXJPRGNIMmk5UnRuRzhiaFNLUGpJR1JtbHUzYnNMT1ZFYWF4V1Q2SjU3WFFZ?=
 =?utf-8?B?Zk92RXBnMXB0SENTc3RNdUIwQndtV1ZXek1vWUhKUlV5QStOS3FlWS9YaFlL?=
 =?utf-8?B?VHJwSy9PdjZlc092U1lWWlVSWGVGR1IzQVBTaTZnUlZGUm03c1ljemVJZnBO?=
 =?utf-8?B?aHRiYWdIZ05VWDYzSFFmcmlUYU0vSGtNbW9yTCtwcjB0dUQ0eEJlckRPUU9w?=
 =?utf-8?B?K1lLcncxbDlyN0wzdTF0RGxnMFpDdHNmcEtoRkRCeUoyanBXeGRUUk5hMmRw?=
 =?utf-8?B?aVg3RC8ySWhSWlcvaDV0SjQwZ3JQR1NrSG42bGtvZUZvcyswUHFONWljVm8v?=
 =?utf-8?B?bmxQQjF4QnRBV3Z2aXFZbkxBa3EwMWVueFAxNS8rVFpmMW5uTjhwN2xPazhD?=
 =?utf-8?B?RTZXanM4WFZQVU9CbGNMbVZaeXBPZnh1c1FheDJsNzhlekxuOTFCM0lxQkww?=
 =?utf-8?B?TlI0MThtTmErM1VpSjlab0ZQVXpYalFINHk2NUE0bjY0Y1pGNUJKUS8rdWho?=
 =?utf-8?B?TzdiTmd4ZXBHOHFNMVI0N0lKWUxuaHk5dmpCSTBuTFB1bUdscnFGOGdGaW45?=
 =?utf-8?B?UDBNTXlCTnduTTU2VzRESmg5dWhPZk1tYldPMExDY0lqVU44ZThoQ2VPSnFq?=
 =?utf-8?B?SUFFNGtid2FibzNDODZsVWFPK0tZMlB2S3NxdzN4Um93TEtvUVkxQTI3d0Fp?=
 =?utf-8?B?NHVVVUl2SU0zY0ovUjRpczR4MHYra2lxbC95ck5wQzZRNGtPSENOOUMxT1NW?=
 =?utf-8?B?QjFoOHhpYzlVS2Q5NG1Ra0NQbjFnS0FwMWlGTlBTUE1IRFVqQlRQNUt0TDlK?=
 =?utf-8?B?YkFHYjBPOEh4V0FaaHFUUFVqbzVqcWVKMm12Q2ZHVDRMZnlxZDJ4YytDMUdW?=
 =?utf-8?B?MzNadXVSZjZXdVlDNktGeW9EK2NqdVl4bDRUUU53a080elFHakkrRHhXL25q?=
 =?utf-8?B?ckFCVUpQc3FWSEFDZWQwdW4xRzRZSXBVdm9LYm9uYzNIMFI5cEJydHVaZkdn?=
 =?utf-8?B?NGNEUElpUHRPcmZ6alhHQisyWkwzNDNLY3BoeUdPQUY1YmIxNUk0MzV3N0w4?=
 =?utf-8?B?QVlZamJnSTFxcHVqblVSa3BOaC8wT2lhZXFwRnlYeklMMzVadEpYekF2SXJa?=
 =?utf-8?B?czcrOTBTUXREMHFLdWFSdlNUd3p3Vnp1ZUN4M0NERGVEMFRrVnVPM1ViV2xx?=
 =?utf-8?B?S0wvdUNBcGxuN0E3UnlORlhSWi8xL3pzd3U4K2VTam9NM21mM3dpeWlvSEY4?=
 =?utf-8?B?WmRXc2paT2V4TlhCamlnclF3KytGUTh1TGovUTBJZzlnZ0FkRUlsbUR4dHpC?=
 =?utf-8?B?bW03ZHVhdjBWaVdLb28vTU9rL3l6NUJYMWl2OHNrSytnLzBFYTlMQXN0emFK?=
 =?utf-8?B?SmRFMDNDZ3JIeXg3MzhuVjdua3ZWTlo3YkVENUFyT2lSWlFzOU1Cai8zZ1FG?=
 =?utf-8?B?blY3U2dVeWFUNGRrOGZ5MDVGcmo2ZE5adU4xaWlwL0lFOVpCaUl6WVdqWk5X?=
 =?utf-8?B?eWIxUEZ0Zm4ycGFCVW90bG5qVW5LUE01aEFBcFliS1ZxbCtBSWxHZndsNjd5?=
 =?utf-8?B?dDM4Y3Z0K2t3VUV1UGtwbDJlVzQ4QXdoeVN0WDlqczdPeHRSWFMyL1hEOTdF?=
 =?utf-8?B?UUdnd2lvbW13dzNrTkR2OFlRN0VrMkxCMy9NZ01XTlU2ckgxNE1MZDN1Qys1?=
 =?utf-8?B?N2NCVDZEeDdiY3BxZzI5NDVraWhzZ2Z2b3Npdy9LREtYcGRrRFJLdEpFVllJ?=
 =?utf-8?B?TVdpaTM1K09PbnFDQW8xMVFjRHN0U1ljdDFZLytZWWM2WUlOOHd1cFJsMnMz?=
 =?utf-8?Q?+sXsir6YyXiHqZOgipjSp3knm?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ea05ef9-0bd7-47ec-b5d1-08db6bdd88c3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 07:12:23.0731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XErt5bgFnatL86IrwRasyBp0yaUEOVs1eBkMV9kLJJfXKvNeDpHe/JsEBu2fQ4gsobYyeBmHiKMrbJC+KKcrHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5671
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 13 Jun 2023 07:12:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11979

On 12.06.23 12:30, Srinuvasan Arjunan wrote:
> From: Srinuvasan A <srinuvasan.a@siemens.com>
> 
> Now we have individual swupdate recipe for buster and bullseye,
> swupdate_2021.11-1+debian-gbp recipe dedicated to buster, hence remove
> the buster override.
> 
> Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
> ---
>  recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
> index 48b5c2d..da1434e 100644
> --- a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
> +++ b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
> @@ -40,14 +40,14 @@ DEB_BUILD_PROFILES += "cross nocheck"
>  # DEB_BUILD_PROFILES += "pkg.swupdate.embeddedlua"
>  
>  # modify for debian buster build
> -SRC_URI:append:buster = " file://0006-debian-prepare-build-for-isar-debian-buster.patch"
> +SRC_URI:append = " file://0006-debian-prepare-build-for-isar-debian-buster.patch"
>  
>  # disable create filesystem due to missing symbols in debian buster
>  # disable webserver due to missing symbols in debian buster
> -DEB_BUILD_PROFILES:append:buster = " \
> -                                   pkg.swupdate.bpo \
> -                                   pkg.swupdate.nocreatefs \
> -                                   pkg.swupdate.nowebserver "
> +DEB_BUILD_PROFILES:append = " \
> +                            pkg.swupdate.bpo \
> +                            pkg.swupdate.nocreatefs \
> +                            pkg.swupdate.nowebserver "
>  # In debian buster the git-compression defaults to gz and does not detect other
>  # compression formats.
>  GBP_EXTRA_OPTIONS += "--git-compression=xz"

Thanks for the cleanup, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


