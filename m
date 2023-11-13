Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B7F0C4332F
	for <webhook@archiver.kernel.org>; Mon, 13 Nov 2023 15:46:30 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.49])
 by mx.groups.io with SMTP id smtpd.web11.40173.1699890386427925862
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Nov 2023 07:46:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=IKUQmyLp;
 spf=pass (domain: siemens.com, ip: 40.107.13.49, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HDbb9Wi5MFUi81qQVtYBypd85yeJTYCmy0jKH7k/ZBWS8ILE0KQvnAWU+B9Huq/JYghwQ8jcT20qt8d+RaChmOgJsPgMRXswVZozvoI+WCUxgqW+m2bEqfyBLVzULDPwvEM6sKAOXXtl308YKo/f5UnR1O6/Nkz2FnXe6p4NGqkZqX1CWDlrvJ5+4sU2cO4RqqIIfhBAAX2MeKfd2dzCJYc9mvxuFpKdSjAHOroF2A30aqh2nLyKp3BV21RaUGGHrH4SxQrD6nyE+8o2BtZ+kNw1puPNw2nNGVK1Bcv3VnGUSFuIg/JN+TACco69RPxdlEpxCdYNAGSn61au85ukKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S1W0PbSTPmt6aRZvP/h6Y6/AEGZ+5R/ThZgS10RIa2c=;
 b=TRj+nnaXnLzoB90avGTU7nVpX/T4YL9iIvzQrfrTlNCk67v91LAzAPffWXMdHdwe3VHbCy24NcmgY6Q892rE7EQxSsQr0Vj594PSfJKvmu4tWq0IvfnedBDdsbA3XsnRyWQ6g8weSKDkxGV4JvW/rD4ImL5XtciYIbq/PNv0lLt7a1uyo4a5GXHqxSTTx14o5AcfViRdHvEiIqhq5KzUJ2LCgpGQ/9fm7dedn5qUMCpBdj2K/O12/oq/vreGIr/Tsx0/zYsJDGhqjUMUHU1ZhFjDvnuEWK5V6g8GN7hegzcawDmmsq80of1fwf6B1PiorrGafmohOGJyev42BuS+gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1W0PbSTPmt6aRZvP/h6Y6/AEGZ+5R/ThZgS10RIa2c=;
 b=IKUQmyLp8tCnf833f+DZf2icEM5nuB43Zycvs6xlypMVmzDFvM7udRll3nvUShMSdOfs5Y6kRXHC3lec/BQsXwNPxvNmPpUe8LqVN35nm3viKo8wdaKGTmKBbW1TN86P4264gAwdPZYMq9QeMGAt462XnYafo5oGbchR0dRixdGKQyVqIqMzSZmpKRv6Jo/aWLQDbAM6VYxCX2NLqT+co2ypsJQ0gPf4hnmtYkxwMGTu+/ssQBhlhcbYqRkeH+OPTMPRpver16zmsSeWop+a8jo1VfRwZfJtYU8yLz2XdpSb40lA7HmYuArWIbHA7byeZOjuydcegzkeMSChpxmsfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7110.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5ed::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 15:46:22 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%4]) with mapi id 15.20.6977.028; Mon, 13 Nov 2023
 15:46:22 +0000
Message-ID: <bf97043c-4e70-41b6-98bd-15b42ef66ee0@siemens.com>
Date: Mon, 13 Nov 2023 16:46:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] efibootguard: Update to
 efibootguard 0.16
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20231113100528.127244-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231113100528.127244-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0020.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7110:EE_
X-MS-Office365-Filtering-Correlation-Id: 52f97e19-d559-491c-4336-08dbe45fafe2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	sD0GBCY9PIyEQlfUBDLRBLrDpQ3sIbF5JgZkNaxN76uIYdK0vkw8I0AxWdmZZEV6WJzXEuuz/S/Ww6JHBVuMv/7AdBrxURl0W+/42JrFpWaFjGGLpwW0InNWXknuM+FOrZEtwpytowk9XQFMgjYbUfDUn1W3FKI0p4oFBeVgSgMRtiXGnhoVq081a3aoJ5ONnJDEH9OpyFP4uDFTQtzr3MS9zGm6QQrZfyjXys28jnvV22KWnadn24FGbwUlVn0LRxo8Z88UvR1cEXWAotLqj+Fvixsk+x1Su1YoxHp724Kpkvt/I6JMm1k45riP2ucRxqmLAtVrb0ATFprAfp3c6U80SeRYyI93uvpMWeord9Q01ADZ9yZs/93vNcPC7Dc+j7edfuwf9bb+y7kWP3zZ1n1yfN09B4LDLG4KFzIPkf/jaXoF7E+F7fnuB4bcQ/MEgSz8GvXlJEdOYOKSJJrPhaz+QKP1XLaaFEx3C+R2Txiw1fK9kqKv2epQjEsSVKm3xfIgRLTJoc5puaqNajV85u3nKHDj47fYZXEYL6ASUdo999Q+VYPmXVV8qa2rA9peA2457KRBYsdfLFAUnqOIRDMAa7RTPVWBwVbhtfw/lmtHmCQH/Js7rWQYu5svIhQ9Nl3eQFxhL93UEEtPIKe+6cRpkY6ow6iU7jpA+8fftM0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(366004)(376002)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(316002)(66946007)(66476007)(66556008)(478600001)(6486002)(966005)(86362001)(5660300002)(31696002)(41300700001)(36756003)(2906002)(8676002)(8936002)(44832011)(2616005)(38100700002)(83380400001)(26005)(82960400001)(31686004)(53546011)(6506007)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OFhOcUZKSlg2cXBDcEIvTEN6WnRpbUlFL2hQM0RITDNyNmh5azd1S1pKWm9m?=
 =?utf-8?B?eitMNkJYMTR4ZUVBa2kzbWN4bXF0czl4SSsrT1NqVk1kMWgraUdUQmcvS0l6?=
 =?utf-8?B?N2NxcUZENXZ2WTlCYXBxWHMzMkp5U1lnWW0xenVnZ2hMUDY4ZWJxRzZYMGNj?=
 =?utf-8?B?RjQ1Tnk4WXdHcWprVG1RcWFPb2UxRnBHMnhSaFZpYVZHWEdOWHhRcWhJQ1NZ?=
 =?utf-8?B?YWJPb1BpYzBXanpwdGcyZ2lJZWE1WWFOT2xyV3BoNnFaanE1T0dzL2xQUG5G?=
 =?utf-8?B?WmhYWHVaNS9qRXcxTXZCeUp6Wk5DZTlGc0g1WldGMmljVkxiMlNCMDhqOGxl?=
 =?utf-8?B?VTRaNEI0U2puNEtXckNmMUtQbE4vZ3FEZDNObk4xVlVUdmxUSTlXZGY1ZUFH?=
 =?utf-8?B?eU9ibnBleXZ3OGdxdzlPTzl2Y3NIUVErU2c4bnB6K2NRUS9nQnBrNFduVnN6?=
 =?utf-8?B?Z3B3S3dtMEtmSlVRSWp5bWNHdFYzREl2WGtJRDZpYnowc253azloVW1xdWdp?=
 =?utf-8?B?OUdaL2Frc3JDQk9WNURNUDlQeXFBdTViTmxrSW9Qa01pV1FzbW4rYloxNXlK?=
 =?utf-8?B?ZG1hcXNKTzRYQkdRTzlzUGhzZS9jUktxb2RWSnRuQ0dmUjZxc0FNQzBQNndI?=
 =?utf-8?B?NjRKWVhVbWt2aENnenp5NGVmajM5T1M0bUVpWVU1MnJ4VmRJN2c0Zmg0Wkx3?=
 =?utf-8?B?UncxQ3lrL1lyS1RvNFZSZGhJWmpCQ090SFEyUW5sRytXdytIVWpPR25Iajg3?=
 =?utf-8?B?OUo5ZmoyYU54MVN6d04yYjh0TW1ETXc1OGJpQVVmRmM1cHk1T2kwakxUQXli?=
 =?utf-8?B?M3BVaG43VjRxZ2F3RkI2ek5PUnpRdURYL3JtVE9xYzZEenpiMU1Ca2pLRWlC?=
 =?utf-8?B?MW0vYTUrclkvWHQ5RjVQdENGSTdjN2ZQSCtHQ0FJdFZYSHFjcmNqUVIySDVn?=
 =?utf-8?B?UTFDWDBiOWFMM2V2ZXNwWkxteDFRREQxMkZiaEN2eW1JeWFVYlIzZ1RTd1h2?=
 =?utf-8?B?V0dsa2Vxd3ZSbUNCb3dMNGJJNGk2UnhVdENqVk5xOUNFb0pzemJGOHJPRXFX?=
 =?utf-8?B?MDd2c3FBOG5QRnhpeTJMVmZ5RVU4cG42SnFyNUpkN1FRcXNBUzNyZzJGUGsv?=
 =?utf-8?B?Z1ZJOUhDWk5pUWZLaDRpbVpNZ2w3aFlJQzhzVDJLZGtjZEVZTC96MzBRcXNH?=
 =?utf-8?B?T3dZTU5VUURFRXREMDYxTUVzdWhmSExsenk1eTdobkpoSDYxUW1VeVcxZkZj?=
 =?utf-8?B?Yi9zNXRaV082MkZLZUNVc3RQRGtZbGo1RG9LanQxZzRqWGVwV2h2Z2QxMUtQ?=
 =?utf-8?B?VHc0QVdEd3pNbFpBd0ZIR3dtbkkwcTVSTVJOenFwUVJyS0FQZEZRWWlodFJz?=
 =?utf-8?B?dCt0REkxUk1QWFZBZjBWRUlOd0oyYzQ3OTlPbUNVaWRhWS9ZTzVFUlBldENy?=
 =?utf-8?B?a093c3lqSW1OcWJqMmNqZm9VR2JqOWQrWENKY0RSYmJHaXltMlRTOUJTaUdO?=
 =?utf-8?B?SXBoZGo0RDhXdjBJZzhmZ0ttdXJDdXpadkVSVDhOQi9YK3BOM3pKWGtNN21l?=
 =?utf-8?B?UkNhS0xWeDdpNUJUZ0NwWVRMbUZKUVlqdEZ0c2g2ZytZbHJnSHpQT2RGZWZ2?=
 =?utf-8?B?UlBsdm5OSW9hWFdBZDBBWm9IZE0zUHFvY0lnNFRDNFVRMmttYmhqbWFHS3Ft?=
 =?utf-8?B?RHA0NkFWVWRXQjVtQnI2OWFIRisxQXJ1YXU2MHl2K3RlaHV3bzF0MkF4UzdH?=
 =?utf-8?B?VXJta2ZsZ1ptOG9XeFpTRGhwZjJzOHptV2p6K1VmR1hoNjlWWUJweW11UWRo?=
 =?utf-8?B?d1JEazBXbGZsTWlyOVdxMzBDeU5URGhZTWR4Y2pGNkJlM1NvYjBEbmM2UndB?=
 =?utf-8?B?YWc5bUpxNWw3aUg4ay9FaytROHBrREQ1Q2gwRU9TU1gzaUo4emZGSG44MVJG?=
 =?utf-8?B?SEhZUGhJaGZiTWc2QktIY0VnZHNCSEI2eGk0RWZseWdWc1ZrZ1NaSjJtZmx5?=
 =?utf-8?B?T21FMUluOWNXbVVxS0pnV0J5MmNnSnRFOXJ3WVZsZXM3dSs3VWpnMW54SUdQ?=
 =?utf-8?B?QW1obzVqY2VsY1N0M1psd01XSmNEWmZHN1U4YUVaaEhHTGMyQ3U0SFpTT3No?=
 =?utf-8?B?aGZicWE3SjhLUmtGZ3J5VDd1M3BvZ1Vkd1F3TzIwMUZpdnprWkpaeWpTY2Fs?=
 =?utf-8?B?UUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52f97e19-d559-491c-4336-08dbe45fafe2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 15:46:22.7886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4fa3hFM7Pp7mXDyQT4hrczwh8b7yA42YgD/xgJ1w45qsKWR98kKsCvM1cyXJA2d67quzPUTbWdCZQlrb0Ie0nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7110
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Nov 2023 15:46:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13574

On 13.11.23 11:04, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  ...fibootguard_0.15-1+cip.bb => efibootguard_0.16-1+cip.bb} | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>  rename recipes-bsp/efibootguard/{efibootguard_0.15-1+cip.bb => efibootguard_0.16-1+cip.bb} (84%)
> 
> diff --git a/recipes-bsp/efibootguard/efibootguard_0.15-1+cip.bb b/recipes-bsp/efibootguard/efibootguard_0.16-1+cip.bb
> similarity index 84%
> rename from recipes-bsp/efibootguard/efibootguard_0.15-1+cip.bb
> rename to recipes-bsp/efibootguard/efibootguard_0.16-1+cip.bb
> index 0cfb6da..ada0592 100644
> --- a/recipes-bsp/efibootguard/efibootguard_0.15-1+cip.bb
> +++ b/recipes-bsp/efibootguard/efibootguard_0.16-1+cip.bb
> @@ -17,12 +17,12 @@ LIC_FILES_CHKSUM = "file://${LAYERDIR_isar}/licenses/COPYING.GPLv2;md5=751419260
>  MAINTAINER = "Jan Kiszka <jan.kiszka@siemens.com>"
>  
>  SRC_URI = " \
> -    https://github.com/siemens/efibootguard/archive/refs/tags/v0.15.tar.gz;downloadfilename=efibootguard_0.15.orig.tar.gz;unpack=0;name=tarball \
> +    https://github.com/siemens/efibootguard/archive/refs/tags/v0.16.tar.gz;downloadfilename=efibootguard_0.16.orig.tar.gz;unpack=0;name=tarball \

Maybe a good chance to use ${@d.getVar('PV').split('-')[0]} here?

>      git://salsa.debian.org/debian/efibootguard.git;protocol=https;branch=master;name=debian \
>      file://debian-patches/0001-d-control-Make-compatible-with-debian-buster.patch \
>      "
> -SRC_URI[tarball.sha256sum] = "9d2d46913ed8013056a3c2b080a997e68d78d92a1051ced06fbfefa93353bb7f"
> -SRCREV_debian = "e39728f63946d1af2d5edbecd89a30706dc31a9a"
> +SRC_URI[tarball.sha256sum] = "d6d37c59aed17489d02b4f0b63db16994dfb8f9f70f54be4d65c366f58c6be9d"
> +SRCREV_debian = "2e80fafa87f8f6fd093f49ff33ad7cac61592871"
>  
>  PROVIDES = "libebgenv-dev libebgenv0 efibootguard"
>  

Jan

-- 
Siemens AG, Technology
Linux Expert Center


