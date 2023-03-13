Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BFEC61DA4
	for <webhook@archiver.kernel.org>; Mon, 13 Mar 2023 09:36:23 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.43])
 by mx.groups.io with SMTP id smtpd.web11.15837.1678700179005683297
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Mar 2023 02:36:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ehTuPS1o;
 spf=pass (domain: siemens.com, ip: 40.107.20.43, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e+Q6IbOALbjOyR9yooX5NISUNhbfrqcR8QuwY4n7M1It883L8HrImwQROe/+eOIY0F0H0l481ABdxlhQ8h935cPHfFDWSC2jytAoVOZuWwn7VTfEwgd3yAjQHtNI9GZMJww7UE3lKtrDn2Ql1WlytmjBnIYExMwmolUmqo8A0bbD94QwzfFznyXedhf0vlmS9aAekJnYL/r3t6YC3eDMQ0o0vOxhjYQ2nTTt8ImatUwNlBfoVsiDTQhs0BAUdVHqzLd6gq0QfGHGIQLCFr6IoOXsjC+1bapkWUu7xpkIylU+bazj471ZPslnpkFUFDYc0KZ1b9ilaywxMjWnZcwCfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yUADm2+4fBW0zF0DkP1BiB6uDvYXY02MY5LGZ31O1Js=;
 b=g1XhvDrZNTu4qY2Mvazn7+qOukMOrmt7xvSlDNjT4MgOmia/uAdRF+01+6obUsc2nlrVB9mgUTazqL/vSQ5u1y1HnGtq47pRPJWodU2J6vRAR2NYqaXnDUakJRV+9uRdWdTbJ+0ks6Bx6TiY8W08wNE42aeqPVAYWirEcK6046EvLkZmAJ2/Y88KMV+QU4S7AELpSp+Kklh2R6rj+ey9e1YkG24QAbl5NxS4zpX16itDQhh71kgKE2MVR7bIKmVsvRBDc7nPQNYD9s0g/gl2ZjOl5m+3hGs0A68AOLDB4LZf9+j0txMPMvmKnpqvS0eD2o2+0eglA71XGMJgyPM8Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yUADm2+4fBW0zF0DkP1BiB6uDvYXY02MY5LGZ31O1Js=;
 b=ehTuPS1oTsCEYNcIa2xNkZqE3KVekq1/KcDwy32ajzmKLym4lD3dkkK6m/7lL1ptiA6NTtncLM4WeYybWljvHrBq5lsAmFwCg7fBAmxburwj2fIZyLIIi5wU2yHP2B+vIPbdSwwCxcMZ8wIjuLGKCwka9mwyb1z9Wky8fvTyJ9mRMh/BISrcDCKGxWF/KHzL3EAC0O92lbVysWgkU+OpOQL9ZCFlp9T0b0E/8MCleFibP79Pzj5GUt+s2xa7y85bdDKE3Lcxr7D46+hyGIJMw0PPHVcBlyizoyQZ55RV+vIu26RGHriSMxuZA5bb58a+roMa6Yt6lgL1DbCN5NIIAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB6998.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:59a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 09:36:16 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2%9]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 09:36:16 +0000
Message-ID: <b4c4d9c7-8e4b-c2f4-9747-a808d22540e1@siemens.com>
Date: Mon, 13 Mar 2023 10:36:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 0/2] Enable Images based on
 Debian 12
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 felix.moessbauer@siemens.com, cip-dev@lists.cip-project.org
References: <20230310182003.201194-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230310182003.201194-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0112.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB6998:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eca4b5f-4c05-4169-6893-08db23a664a0
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	hwQ9K0LXhQzJ4wqHm/CjYxjhowM9mzpVLlWgLv40x0NEFv04dIYFcKjmFaG7mqoPBLExpMxBbafOrlu388wAA6IopfKNNoTDdwLWMWbK3v9DInsv5V0upvXKzlJQaPU8q3SPsmfE7GZpOF361ESnT+Stl/rXqBgXZrUCTIczWqTp6+mKvm6eIKUUGiqiW2ptQAq9fcWr4Htcs5JPjWetJCbZ82SibYOMPI2eV9Kk6EQD2to9oDU7ebXXQiCoXp9d8lyb7CZyIKlGZUl0MBToVXJ+3rAtWShCizZTagD21PKZxVUAN8Z73SxKQnAiry58dSXT51lV/IAq/ebtA2xZ+D9BwKtGOKgpTwG/6f0cG2482VuQzwG7AM3xHY96zfukdZv6zfdZFiucsCwNYkaxSauRCFqtpAk88eKN7RPdxVBkkWWMgNAn508DEjal6/IvvOdtbQtR4KLeyUVqX1kQ7tvcGhcSqOb3McidjTfQjqgb9RwbKpfxOCY2AQNOHGtJdd3aXojtjQ0CZVaaNl9jC5qP74QSss6AD2rsUCQlw9AqMzAPktWFUJ7a1bEHbITMLp1unYORniIKXjojUV5D5K8oaIQ04b/S1GgwnkbNq3MaN4En3DNd/4DVzJQhF14dwd9DaK7ikYzYdwBB9qUT46b4hLZNkX1b6NvHq49uy3zGrQUm9GrYxMrXgtq+tRe4Y/WraagFvACT7fiMgfM66L2aEsNi9jXgFORDuW6khJk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(396003)(39860400002)(136003)(376002)(451199018)(66946007)(66556008)(41300700001)(8676002)(5660300002)(66476007)(44832011)(83380400001)(8936002)(26005)(186003)(6486002)(6512007)(6506007)(2616005)(316002)(478600001)(53546011)(36756003)(86362001)(31696002)(2906002)(82960400001)(38100700002)(66899018)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RVVFWlRlY1M2SGlMN3h0YVNvSWpiRm0yZzFQVVJ0NlNJK0VMMGlGYjYzL2xs?=
 =?utf-8?B?eUsxQzdpYlphc3F5N3ZGZEhIZmVXUFpWRExBaC9ORGRCY1JobmdBRlZYOWxk?=
 =?utf-8?B?bXgvcUhwQUFpdnhVSlV6SHU5S2FYbGFhNnhrR2d6d2ZOOXhRZWhIckVQbnUz?=
 =?utf-8?B?M3Z6YWNwVDNNQ2JSSFZXNE5UalhhZ1pDWWtnbGtnOGNtaTljQkZldE1vQ3Mz?=
 =?utf-8?B?Y3o1cko4Y3lHUFZKd0tMQyt2ZHpveWEyYmJxbnM2dkJjR1hEVWFsRGpVOTlk?=
 =?utf-8?B?N3NKaXB2NjNPNG1rQ1Y1Y3ZWWHFpZXlUZ2o0NUVYLzlpTzZVajh2VXdyMnpo?=
 =?utf-8?B?R3JEdk51VWUrb2kzbTF3TC9qd2xBVnRNUXZRbUp0RHlZakc3WnNUTW1EVlhB?=
 =?utf-8?B?NGZSUThMQzdQN1VIUDZEVmN5dWVHWEVVSXV3YkNDOU5KckdmcGRDNllYOFdD?=
 =?utf-8?B?UTNWRzlhYTNkbmIzT2pldUN5bG05WklrSXBaMjBZMnJQR2gxdWlxTnlzaHJs?=
 =?utf-8?B?WDBzRUc1TnNPc2ZGVFJZdUJNejdEbUFSRVlLZWhZRkpHSnFIKzlidnpINFpm?=
 =?utf-8?B?RTAxQ2MxWnJYZlVZcWthdmRkbjJtWldkWko3d282UkJCVno2QnphQXEzdW9N?=
 =?utf-8?B?Wk5pajFvOHErSlVIRkkvdlpXdEo1ajRzdnlCQjNnRE45VUlpSFJIc25PN25Q?=
 =?utf-8?B?d2grWmYvSmx0NHg4WFBDbWhDemR3bmNTUVpDYUhyTTIxK3YwRE9LSzAwdDQw?=
 =?utf-8?B?WEM0TXIwUThocnluc1NYVGlsQWpmT01IZmFjb2I1TzNYUVh6OVJkT1pCMUxP?=
 =?utf-8?B?ZHltZnkybHJKQzVZZjRIUkRuc1gxa3pPWDFwL0FHZVB6bktvQ052bmd6UGs1?=
 =?utf-8?B?N2N0UkVDMTFWMWgzMXIrZHlsSzBNMHdYTHRtRCtEMEFEMjBqOFBrZGlsZlIy?=
 =?utf-8?B?blcycDVoUmdvOCttQUxMSFNqcVVQeGp5SktPM1J6Zk1yVzZqaUVZSUlEdjF5?=
 =?utf-8?B?cDdqY01qTlhZelVrdGhJOGsxTkN3N1lkRERIb3NRQS93NldSK2gveVNFTlZk?=
 =?utf-8?B?MXJpZHZ4c2cyNzFrK1RyVm95WVdua3VZRkRnaWx1REtRL2x2L3R2cXA4NDl1?=
 =?utf-8?B?YXZDNWwxWEVhV0JyZnBEOHlwNXV4azBmK1NUMnYyTkxickdtRFBNMmNBdEw3?=
 =?utf-8?B?VHphTk9ZM0twMlRPQkNJVlhPaHh6YXNTM3RUNFFUT3lTWkFBc3Q0dUF4cnhm?=
 =?utf-8?B?azN3Ui94VVlVL0F0SHhNWFJzUUFTaXNBOGd4S3R1OVRXaXlxdnNyeGVSdHpv?=
 =?utf-8?B?NmljNmtjVE9VeGZHUmR4UVRxU0pSM040TGFxTkdZVW4weGpKOHNpa2xMcm55?=
 =?utf-8?B?TFRaTlZZNjY3V1YySW5EYy81eElvUDNQK2VzZmRnOHUvUnQ3RW10T3hsdEhE?=
 =?utf-8?B?c2ExOExGNWxKNWZjUHZXWi9kQ3JEQitRS2hQNjJxRy9RUWhHbFVSR1A0OTBY?=
 =?utf-8?B?RW1QeWUySE94ckxHQWpxNVYzVEtEQ2tjejRveW9LQ054MStDMFJmcGRhdUNl?=
 =?utf-8?B?cEd4YnpUWnA2UndnbzRkNTJXalFNNzlrc2hReE1sejRac3E2bDIySDljVXhZ?=
 =?utf-8?B?TzZBc2ZRZjR2Tk00T0pMMlZ4QTlGcE03VFpNVk1hajc5Ym44VGI4Vitic3NM?=
 =?utf-8?B?eU9Hd3ZyK3AxVHo2cXEwSlRLUlFHTWQ5TUlQYmJLb1N0dGs3bWV2N2pJbDB2?=
 =?utf-8?B?TFo3bGwxM3lhQVZtY243K2ZDdDdabWR1Rk9CM1JFbkhTQ2FldUUxMEx1R0cx?=
 =?utf-8?B?TmlZWmJpdStyREhFM2swcHVUdzdFVHRHM1M0b2w5QVhVRWx4S3I0c1Z4ZnBj?=
 =?utf-8?B?dUIvcjVlNjNqc0dhb3I5NFVKRTVDMkdVQ05nbFZ3VHJPei9BTDJTYzVJcERH?=
 =?utf-8?B?NVhxNisvS0NZc0NLWlE5K3ZlUTdGVW5wM1lxVDV0T0NjcmsyY0JiZXl5TlFV?=
 =?utf-8?B?b1J2aGZyT3lxbUhBSUdaRnZSZk1XVjN3cFFIN1loZzVEWVRHSzQ0T0gzVHZt?=
 =?utf-8?B?eG00Y0hxS3kyaExXZ3A3aHk4d3k0RGF3cWJBODNRY29uemdBNmtHeHNTMXR5?=
 =?utf-8?B?aWNCcXFMKzJZdHZXQ2RleU9zZnJWV205VHFDakY4S2I0cTZNZ2ZJMFFtWnN1?=
 =?utf-8?B?cXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eca4b5f-4c05-4169-6893-08db23a664a0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 09:36:16.3928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eZ+LBp3Qt6u0ayh1tkLGiQ421lOPFEf3qDcGExvzqyd3xhDQQmH2grzICyZrf9InkLzsfR8gbgtrENlHdHvFrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6998
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Mar 2023 09:36:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10998

On 10.03.23 19:20, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Add ci builds for bookworm
> Change efibootguard build to use debian folder from salsa
> 
> Changes v2:
>  - rebase onto next 
>  - always build efibootguard 
> 
> 
> Quirin Gylstorff (2):
>   Enable Images based on Debian 12 (bookworm)
>   efibootguard: use debian folder from salsa
> 
>  .gitlab-ci.yml                                | 45 +++++++++++++++++++
>  Kconfig                                       |  5 +++
>  conf/distro/cip-core-bookworm.conf            | 16 +++++++
>  kas/opt/bookworm.yml                          | 15 +++++++
>  ...guard_0.13.bb => efibootguard_0.13+cip.bb} | 31 +++++++------
>  ...l-Make-compatible-with-debian-buster.patch | 36 +++++++++++++++
>  ...rol-remove-native-from-python3-shtab.patch | 26 +++++++++++
>  recipes-bsp/efibootguard/files/debian/compat  |  1 -
>  .../efibootguard/files/debian/control.tmpl    | 20 ---------
>  .../debian/efibootguard-dev.install.tmpl      |  2 -
>  .../files/debian/efibootguard.install         |  5 ---
>  recipes-bsp/efibootguard/files/debian/rules   | 15 -------
>  ...01-add-machine-type-name-for-riscv64.patch |  0
>  recipes-core/images/efibootguard.inc          |  1 -
>  recipes-core/images/swupdate.inc              |  6 ++-
>  recipes-core/swupdate/swupdate.inc            |  2 +-
>  16 files changed, 167 insertions(+), 59 deletions(-)
>  create mode 100644 conf/distro/cip-core-bookworm.conf
>  create mode 100644 kas/opt/bookworm.yml
>  rename recipes-bsp/efibootguard/{efibootguard_0.13.bb => efibootguard_0.13+cip.bb} (53%)
>  create mode 100644 recipes-bsp/efibootguard/files/debian-patches/0001-d-control-Make-compatible-with-debian-buster.patch
>  create mode 100644 recipes-bsp/efibootguard/files/debian-patches/0002-d-control-remove-native-from-python3-shtab.patch
>  delete mode 100644 recipes-bsp/efibootguard/files/debian/compat
>  delete mode 100644 recipes-bsp/efibootguard/files/debian/control.tmpl
>  delete mode 100644 recipes-bsp/efibootguard/files/debian/efibootguard-dev.install.tmpl
>  delete mode 100644 recipes-bsp/efibootguard/files/debian/efibootguard.install
>  delete mode 100755 recipes-bsp/efibootguard/files/debian/rules
>  rename recipes-bsp/efibootguard/files/{ => src-patches}/0001-add-machine-type-name-for-riscv64.patch (100%)
> 

As I postponed freezing already longer than planned and patch 2 has
quite some impact on ebg builds, I would push this post-release (should
then be in with the summer release). Any concerns?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


