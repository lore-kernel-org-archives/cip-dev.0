Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756D4C4332F
	for <webhook@archiver.kernel.org>; Fri,  3 Nov 2023 09:38:54 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.67])
 by mx.groups.io with SMTP id smtpd.web10.46540.1699004330173964329
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Nov 2023 02:38:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=fzdRPc7X;
 spf=pass (domain: siemens.com, ip: 40.107.105.67, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fBj744IsaCVmFAWtO2dGZ4YTPgMIXUY4vTcVtjAAL7idrq7QJpCai9125zxioiBJLGWFMMwss7fhOCaSJjUXucohQZ/XQ0OkDHjLsJ7gk3S5jiMg2sNqpPs5GrbE8GpvptOxegv93h6G+lcVDhkr4k+yq9gEg8JwnTTpuuwtOXkw/lFur6w933ja6JTc7wcXbeIArZATbO/YGeDyW5CQqcaAlBS6a4vPb3JpebERzulrra/vvpZ+hdYZ01OrqoIh7OxfcXE717xoZh9E6VYY298k2/j7GQtmOlIzqANvdKQMTtgArOhnmx10ki5RWXOsFefHmb3/utYHvMiphvVESg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=49PLYkv11A4RrJhWWBJRdf0JMBA7QM5sMXvUjmJy50Y=;
 b=Kxo3jO03nrAzrQlSiSfex2JG27Bxhsw+HCryualXbF1j23TBIL/smXTFfw5SA2fMctjgt0bhwmSYjRYI1+VFM0C4xf4YhxTpRUFpj36HushaLIxxD4lY+PZU5zCcNFRPB+RHx7j7b6da1XSLop6HU5TSDkCQCg2/6mbBDaeHKc9enKbd3Jhb+xpNfbiaDHUuNcA7UiZ7h2ne50ceLrZEjUhIMD8MszCNquy9W3ZTH1IWVmP6Bez3FV1tWulDjTRxZNJqmj2+yeyA0TFkDIo9/3oE+BkZ1DwSK8vSU5o2CduF9mCE2KGEoFVFEIQ5M1j6TtCvss0DO3Qq0ypK6nKBXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=49PLYkv11A4RrJhWWBJRdf0JMBA7QM5sMXvUjmJy50Y=;
 b=fzdRPc7XiNQrdUD3tCNPYpUMoDC6PArw+D7rKpiSlm2ZUrXfvkEfkXCy703DbfUW/mgCPKfhzatqPtfNzYnc4SglVhfXCycOHQEEVj6t+d6Bqbm7Xnf20TuWznEcgs5sd5i3MT4UKY4BuWf7aRC4vaWgQdxqReEI80hLLIENqL4H0e1B1rVTileqR8wSMY6eBFIQWvh8OjVy/MSJIl1lqY6l03DgYzeJ/Zl2L1bl81JrevtHFH87UGUvX1UiJbTZVJlHHXS/pdz8rLj8wDTMqtXztlGhgm+klh6d0JV9LvXJYrN7ukze4FG91prA7zbJalE9oTWKsnQjnPgfCa+EPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7896.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:369::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 09:38:46 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8496:a3a3:d7a8:b24d]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8496:a3a3:d7a8:b24d%4]) with mapi id 15.20.6954.021; Fri, 3 Nov 2023
 09:38:46 +0000
Message-ID: <fbf1e802-c975-4a32-8344-cc76a548438e@siemens.com>
Date: Fri, 3 Nov 2023 10:38:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC v2 0/9] cleanup of customizations
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, venkata.pyla@toshiba-tsip.com,
 dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20231031084943.3105056-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231031084943.3105056-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0065.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7896:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ae966ee-05db-4cf9-4100-08dbdc50ad5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	3In5wIJ/mLt9CtDrheVHfJRACfvrmBx7diCI+rvaSrLDFkxRzkH9KCfqLttO2UhAC1V16KojkW6Ziw7bKBPUQMc/UlV7kq9gwUMrBfNfwU/AlAiAo2KQ0rwAdMg7QM42prTXtowO0XAi9J+x0CIC5/cfwPzHofS6C7LyIm7n39wNEMV4fO94Gows5xt+/MR+4ia7Wp7TcOkPnUU/49kVr2UbcGvq/dL8+HpHruC/DdbBIYnvHDMAQtTVEzn7u3UuTZjuexqYtYHTVvsJFcfNnzvGNu6OqGrK3zMQ1/bSoP2qkEIcZbDEbYhJpaBzSiEbpjs4QqqiTDfJzLXO6K6kkSjLPHJ4bSlHtiVWOvmGyRvhaALgooDFaqh3KVD2UI9LkkI03GXdytV9gp4UfXk9mK4fqIYi6CvmMIoVB3dMB53JEteW+DhhYlnfWiH1h4jlxn+IpxHWT8VpFELIXAAGLWyQMlXnEPfkcvVGm+OiYH0TOKqh9PD31rkB0c9e2hJohQj7EZKAqR+LV2ruMWt4UZWd5GB3Iy0s7N0IxvupOUqT3sMD4aoPaZUOCnf/JQnMVHiKeXRxPZ45GDdiE2dV+0X/KDHMhMbwziAZc9mPOv2yY+/jEUMEfRajqODTEqoO17uq8Q7N1KX53W+yajQ2BQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(346002)(39860400002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(53546011)(8936002)(316002)(66476007)(66946007)(66556008)(8676002)(6506007)(6486002)(478600001)(41300700001)(86362001)(2906002)(2616005)(6512007)(5660300002)(26005)(83380400001)(31696002)(44832011)(31686004)(38100700002)(82960400001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?U29lRjV0R01PbWlUdkdSWWVKNG9ZUnptaURmVHc3VEZxSUhydUxhdmZENFZ0?=
 =?utf-8?B?am9vSk9sUnFCaXNMeUZJaUU4OHRKMnpLdlByQWtxd2hlbGtVQVI3OEtzaHI0?=
 =?utf-8?B?bzc2ZlJLLzQrQ1NDL3dpY1ZnUW1QYWdDR1NUYmxaOUNITkh0TnBsTDRwcUFC?=
 =?utf-8?B?YWtqL3FVZTNIQ1dTOXFLWDNTNHA4UlZxUEZhSTZuWnZCZEVqK3Qvam1rNm8v?=
 =?utf-8?B?RDJEdnA1U3IvcE0raGVlajBJZ3dWS0JaR09qbHZ3U1FVM0MrbGJhbzgzbWxy?=
 =?utf-8?B?OFJQem5YaE5nU3lIc1V4bzB1dGMzZDJpU0F5ZFcwZ2RtTFRWY2VwcHV4SXQw?=
 =?utf-8?B?NVNpTWNOMWVaYXlnck1mcXBMdjBIeTJ6bUtpdkREOFE3Y0pxMFVoZEdKRFNE?=
 =?utf-8?B?bFF0YVI3NE1zZklkRG8zZnNTa0ZZMnRrbGdhR3FObmxrQzhLcHQvc1FvMWs5?=
 =?utf-8?B?Y0FyU0xxZFpIWXp1UkM0aERtanpLNFY3U1ZBc2phSmZRbVFKVStleEpZcHFM?=
 =?utf-8?B?d0VQTlhxSmk0aVFOajZQWG1HZXpxOTgrdUl1cGM0czJLRlJaQlJESFBPb0w5?=
 =?utf-8?B?ZzB4cytrSit3aFlJWXFRdTBqeGdhTURKdW56b3o4eDRIVEFNQkNjZksvLzl6?=
 =?utf-8?B?cnNkMERVRGpMVlRxc1ZKK1lGMGRQa3NMcGxWdjVkOHB6eXlGWXRYbHI0S3JS?=
 =?utf-8?B?NEFKYTN2ZFY5N3YvVVNTMkZZM002NjFZR0ViTHhDUGpQdFBleHZDZ25pUnZH?=
 =?utf-8?B?Nyt1WHRlQjlvZzBrZ21lbW1oNkRZU2lkNm1jay81ZlFYZU9lU2tBYW1SZURh?=
 =?utf-8?B?VlpJLzRnbEtGSzNCVzhHWDB1bmgrMU93UnNPVG8yVTZTdnZtSWt6bjFrOVZG?=
 =?utf-8?B?d0FPMStxSFZsQVRpMDBMalFudVhGa0NTbXdLUVl0WVRkS2pNQVhYUi9hdzlF?=
 =?utf-8?B?UVhiNDMwMnFGdlhrYmV4c3JoWTJ6ck9SYTR0TVlrNXQxMFN1djhTd1V2MHI2?=
 =?utf-8?B?dkRTNllmelp1L1hiYWYyM2czT1RIQWJqNUxIYXYvc3kzSDJkb3VHM1M3NjRJ?=
 =?utf-8?B?ZFBsVTBka0trc2w1SzNvcEJrZEVxZk1TQ0ZDMHNRTURCL3dTRjBCRnZhOWQ2?=
 =?utf-8?B?TUpCaTEvK3ZEWndXQTRmcTBtTElxZ29Jcm5vUUVqMmJ3ZnJJNHZ0V3dkYlo2?=
 =?utf-8?B?cWw2bk1ESFFGQ2pDaTd3a3JSL1lPTm1Sb2JlQWdsVzJNdDZWczVab2NmaytY?=
 =?utf-8?B?NDZmK2grSGoxUzY0SkxQVmNsMEMxT3g0bG1EZnUrTlhPUHovcXpsd3F5TnlT?=
 =?utf-8?B?cVVzVnM5bjBxWWRRcUtxWGx6L0luTXZMRlNnNHZiSy9tbThmOVlvOWZzTUlR?=
 =?utf-8?B?MGJCci9UR3NuNXJmbHlYNnBCdWFmZ3dMUDFIM0MyelFQME5aRFF3d205NnJV?=
 =?utf-8?B?a3lSOFZYb0lTaGtOZHdFSGs3UU83UlJRZElzcGRUWFl2YmtKUElqMytnRDJ0?=
 =?utf-8?B?eGtpTFU4Y1E4K2ZvS2ZGeUxjSEkxNVZLbUlCcWZOc2lFWGF4b015NkhiTCtI?=
 =?utf-8?B?a1p5QTdrcytvV1daNzhRS2VTNnllSmpoS3JjTG5IVXF6ZmJRY3VNYmg2ZmtN?=
 =?utf-8?B?OUg0dEhxMUw2YjMrbXRlSFBVZXI0aWdGd0JaZUVXZUdGZTNoeGxicStuNHh1?=
 =?utf-8?B?b3Uya3hHNE9jTHlJUTM4dEFqNzcrVWtBeFpiU3FiSEZkME90c3NoVXJJcm95?=
 =?utf-8?B?U245aU9NZjFuOU9Xc1RrS0J4S01tWWR0MEMwUnk0NlpESUdCMURqNlJVcW82?=
 =?utf-8?B?YjkrWDNvOWwwWnBzdHJwc05ueExMUU9qUmszekpjNE4vczZBak5Gam44bFBF?=
 =?utf-8?B?QkM2RzVVYnNFcFpSSVJsTjA4QTVJalg2cm8xUDdlZTFmMEZvQlNNbjZORWMx?=
 =?utf-8?B?TkZUR0p1RWRRdHVnSWJCbk1NaHZmQmhXREsrckxiNFFXR1RiVyt2WkVFeC80?=
 =?utf-8?B?cDhSYjBnUkcwOWZMNWpiQmF0SC93YllZcUtGV1Q5eVRPSTFjNlZhc0d4ZWtJ?=
 =?utf-8?B?bGsyZG5Sem5MV0M2UmhROVcwcFdub2VzcEMyejdJakFYTlozZDQ1TU9FWS9T?=
 =?utf-8?B?QTQ0eC9tWnZDcWRSbzZjSmRxWXV2UG5VU3NyQVB5cUkxaWlicjI3ZzQvbm9s?=
 =?utf-8?B?RlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ae966ee-05db-4cf9-4100-08dbdc50ad5f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 09:38:46.8935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cyg5u8JkjpA6XZMPgnuQLUVkj5DioMxkgi+zgq24SjlBW+3hXWwEpNTA179xV1wKw7e/maLB5IJfTVHaYHUUAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7896
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Nov 2023 09:38:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13532

On 31.10.23 09:37, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> cleanup the customizations scripts by:
>   - Move the ssh configuration from postinst to /etc/ssh/sshd_config.d
>   - Move systemd service overrides to files instead of setting it in
>     postinst
>   - fix formatting
>   - fix scripting error in security customizations
> 
> Changes v2:
>   - Remove explicit installation of libtss2-esys* as it is required by
>     tpm2-tools.
>   - Add note about used style checker
> 
> Quirin Gylstorff (9):
>   scripts/deploy-kernelci: Format python code and remove unused import
>   customizations: Add variable to set the HOSTNAME
>   customizations: Move ssh configuration from postinst to sshd_config.d
>   security-customizations: Add dependency to customizations
>   security-customizations: Fix shell error
>   security-customizations: Extract sshd config from postinst to files
>   cip-core-image-security: Move packages to security-customization
>   customization-kernelci: Add dependency to customizations
>   kas/opt/reproducible.yml: Move SOURCE_DATE_EPOCH to layer.conf
> 
>  conf/layer.conf                               |  2 ++
>  kas/opt/reproducible.yml                      |  1 -
>  kas/opt/security.yml                          |  2 ++
>  recipes-core/customizations/common.inc        |  6 +++-
>  recipes-core/customizations/customizations.bb | 10 ++++++
>  .../files/{postinst => postinst.tmpl}         |  8 ++---
>  .../customizations/files/ssh-permit-root.conf |  1 +
>  .../images/cip-core-image-security.bb         | 12 +------
>  .../kernelci-customizations/files/postinst    | 11 -------
>  .../files/serial-getty-kernelci-override.conf |  3 ++
>  .../files/ssh-permit-empty-passwords.conf     |  2 ++
>  .../kernelci-customizations.bb                | 18 ++++++++---
>  .../security-customizations/files/postinst    | 24 ++------------
>  .../files/ssh-pam-remote.conf                 |  4 +++
>  .../files/ssh-remote-session-term.conf        |  5 +++
>  .../security-customizations.bb                | 22 ++++++++++---
>  scripts/deploy-kernelci.py                    | 31 ++++++++++---------
>  17 files changed, 86 insertions(+), 76 deletions(-)
>  rename recipes-core/customizations/files/{postinst => postinst.tmpl} (62%)
>  create mode 100644 recipes-core/customizations/files/ssh-permit-root.conf
>  create mode 100644 recipes-core/kernelci-customizations/files/serial-getty-kernelci-override.conf
>  create mode 100644 recipes-core/kernelci-customizations/files/ssh-permit-empty-passwords.conf
>  create mode 100644 recipes-core/security-customizations/files/ssh-pam-remote.conf
>  create mode 100644 recipes-core/security-customizations/files/ssh-remote-session-term.conf
> 

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


