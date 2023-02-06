Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BCEC05027
	for <webhook@archiver.kernel.org>; Mon,  6 Feb 2023 12:41:24 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.52])
 by mx.groups.io with SMTP id smtpd.web10.52139.1675687274809314308
 for <cip-dev@lists.cip-project.org>;
 Mon, 06 Feb 2023 04:41:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=QogKpF/o;
 spf=pass (domain: siemens.com, ip: 40.107.13.52, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=czvqWAez63iINSrzDuoAPVXza5CJADoAfpBr0ZM/HdURrtaDXLOVfSIx7kD7ntdQohvydKo7DwU9YK/u6fnLFWcss9rml3TPusKYC2cKp/s9iRQK+3y9Ef0HwDa0GAvIg+qGDwRsCn7hQy7d1o40sDRJAIHlXsMtQD1I1mQBhHsXgddGaDnnphO5PVpOMq44dJvl0QbYTHqNG6NP4zqAloTWyVtqYarUgn2J1OR1bW/TcJPnTIYljUVg39PyIFzCwgSizFNXs6iG6mp62uL3IKitO/V1NWgcCbfIdO4YgABv1gKj1lswvXtb3j8gAvCKJitU6jYQ4qAWRwvrWeHfIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cf/1DQmkF9n3AUN9PnbydYx6IgeqY2kuZHsu7xSdg7I=;
 b=QWFbkYOBDN60q61JrI9SERNCF7YS3F5mR6WqQSfeS3wGOLvOh36QDtBrxKf6t95Ft1Q1WowYuyZ/4aL0FcVW6Nhg2uANkhmer/n17LHVHTh8TIOGe2lEAXi/k44jyCoIsNh2qCt35kbKp7Rvm5gwICfQpWxCyc027Fql3AReQW/O30wj8BWSDIuPoHHhZJ7/xmBar+astn43uIWFN9NzicTaOy9+DwDs1t+4IK1yhc5ZFLFAb35HS5BwNBA/ERp+vkIk2qDxXptfsZDxavAGGldPom7VFu7xkc4bzQXWfXDwyryPnSI1eltkXPItJ5RQBEa8xSwWSqSt4RYQbNslXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cf/1DQmkF9n3AUN9PnbydYx6IgeqY2kuZHsu7xSdg7I=;
 b=QogKpF/oSAaxjCSWvlmLAx7gGexi/jDhx/d3ReXO5O/8Q9Qirojz6QAwM+jHzzsipF2Io3i3tBR324vMnx/U1UI56ebc8qG0viKNbGZvXjRpgMKCYQ2mkZhsN4BVELnRy4wotLjK9IkgQ45TPExQe5ct1Ije8U4SZgBxn/hv7Zs2eizwrdC7Uc9SReSzzDAHfO9mCrLBoUm5xJvjBkQW5zozSC3Fy1oVpTjex2ABw3AQXbePD4cK5Z0YuYOz4Ec92Busoo0q199KUOwMLyYRxfUWyDVScysp0Gja/YG33cjWKCcHk6te0Ce+zNXbqQGw4UqomrRU7rZ0SxO5Uw5Ewg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB7941.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4f8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 12:41:10 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%8]) with mapi id 15.20.6064.032; Mon, 6 Feb 2023
 12:41:10 +0000
Message-ID: <6303f836-c50a-4236-5b76-52b1b8e6d6b6@siemens.com>
Date: Mon, 6 Feb 2023 13:41:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [isar-cip-core] generate_rb_kas_file.sh: Add script to generate
 rb.yml
Content-Language: en-US
To: venkata.pyla@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20230206121747.1633-1-venkata.pyla@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230206121747.1633-1-venkata.pyla@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0153.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB7941:EE_
X-MS-Office365-Filtering-Correlation-Id: b5feb063-0319-4697-b497-08db083f6c80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	eGi3G6ojFoHXraNYKB+I0xvcbUaMogQs5cOdt+J76zEVrg3wffHhmiTzeu+HUsFMJXKG5n14UC/KNZ2agrjScEiHID4q4nLqPqmrCb08Xgr7LW4MP1UnrID/VHcN98EQiKtpRjujQEewuaJinYuq6HC0XFHqcDmP/XQnC2QdPpg6sh17//8BNlKnk1bZGzzcXryXZ/SHaodC4xD2u3H5BpsOzVk6+00iB0WkboCx2XDIfCipdzgBIpn82h+HsHl74eDkSX7B8x+PpxxZqSkwzHUy+c3p4G2dH14afiPU8gkRezfiBYprQ5ny/C1cyQK7bSnkTPpRcX1SD+xDuKKedXUopm1XOaCgkInXP7hvuFWtwfS0EjOVdkoVZ6Rpulucpk3eTBajF95fxZghRt0ypXO/J7rYV6/ESKu5L3So1HzIqJiQ1QQCijnuWK2pNWZyWSBY0fzXGfxrW8Tew/X3TO4M0j0zM7XdZAPMEQ6TW4N/struIBx4D8Aysh7mAg81galyU4lO61oWO8Pg83+VNvwxaZfM3Et/aHQEx1y8lEwQCqDenJ7o5+ecUXcfrVJsFR/lHpl0Ylayhww2IxlqQ+gPYrsR3omUQx4QkGlZ1rJxZUwdnZGSscg8IWvxWo20U9tK6lIGh/EOiuDhm3vYpKINzdsa5iGSxdTpwQjXA0UwIdta02tdoIpFRfLWJAcSXmk/jlLTXld/zme+1BgKEMp3ByWoUz5gVv5CCnz85Eg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(366004)(346002)(396003)(136003)(451199018)(31686004)(316002)(66946007)(4326008)(8676002)(41300700001)(66476007)(5660300002)(66556008)(8936002)(82960400001)(86362001)(36756003)(31696002)(38100700002)(6506007)(6512007)(186003)(26005)(6666004)(53546011)(2906002)(44832011)(478600001)(6486002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?a3M4RTg2c3RtamF5azJFSkt4Wi9KWklMamgyODQvQk8zVzM4Vlh6WkV1Sk9Q?=
 =?utf-8?B?STFJYTdLQncxWXdkaGhiTnJDOFpLUHN4UHRENnIxOHdjRmRHSit4ZWJqanIr?=
 =?utf-8?B?ZFRKREhJbVlQV2NGZTNRTU5UUDcrS1pndHZtRmt1MmRjY3pudnA1ZG14aE9h?=
 =?utf-8?B?ZW9nOUxiejQrZlczUHpncXRmNnRjT3dwTUtOK3VwSlFjYlEzdjR2YjlHUk5S?=
 =?utf-8?B?amdKYzljNHV1R25laUVGQnBsOUhGMTNDeEFGekZMbmJ6em1UZTVYYU44cENK?=
 =?utf-8?B?UGd4eHV4UEdJbVVKVFNIYmVxTnZ4czhUVHhiWWZNOHlnWW1DckhZcTJ2QkdH?=
 =?utf-8?B?SnEzd0pBanZuRDNoNFBDb1d3Zm42S284QVNDY2dwbmNscVJCVHRVOVRDK1J5?=
 =?utf-8?B?eU53eVBnMjdCNUNKUWtXOENad3h5czVDKysyUVNmeVdGRUNvSmNpWFZTbVg0?=
 =?utf-8?B?TWxlNXNPeVdmaW0rZTFnUXZBTk9tbXU4OEJNS3M4aHYzcStSMlJ5S29UQXp5?=
 =?utf-8?B?Q2JpbXJ6WWVvVmRrc0VSalpOVFkwN3NyZmgvN09KcEhmYnJTamVHSzJvTm9h?=
 =?utf-8?B?M0ZnMU9lTmJOY1I0QWJXUkdaYXRxVVZXbEJ5WDc5QWRHNHo2cEdNQ3BVWjZ1?=
 =?utf-8?B?UUwxQjV4VG5wbzJJQ2lNOHU1dEpKRHN6NUV5Y1o3NHpheWcxSXFyVzdOcDMw?=
 =?utf-8?B?YUVvVERwb0VDWlY0MEVpZUk2TUF6b0F3Y0VrUEx1dVcrZFJSMW9qdk05dEd0?=
 =?utf-8?B?dVAvTHJVNzFUS1lBSUhJRWRFdzdHNDZLZDNhOWovWGJXSGk0WUxrUHByQ2J1?=
 =?utf-8?B?ZFoyTE9kTThud2hHNFBwODk1emxRTUhUT0VSdmJ1R0dVRER1ZTFPY1p2S3hB?=
 =?utf-8?B?Q2NWZHVrWHEvU2N6OEd5TGNnaldQNTN0RjBiemFTNzUvcmtMU01BOHJFNURs?=
 =?utf-8?B?Y0tuTk5iK3JtdHhZRmxwY1ZTQ3BObVFmaC9QQUx0Vmg5cUlpYzViQkFKS25a?=
 =?utf-8?B?S3VNRXZqZ2FTcWxUTkI4Z1QzUmFvaW5oYXU2bUpkb29zS1ZyN0NobC9SWnpC?=
 =?utf-8?B?eFZ3a1phRFZQM3lQaS9DeWt4MHk2VENJa1V6WUtZZFdRT3lsWUlGR1RwZE9i?=
 =?utf-8?B?U2RVY2tsUGt6a1hGODBKSFNvNmtUSnNtM2JvUGxRMjZFQllMWmJLYWc1WFpC?=
 =?utf-8?B?ODlBbEJpWG1DMCtUcmE2b3pyL2ZNY1ZxVWRIWXF6M1hjNFpXaWFaR2FnVVZR?=
 =?utf-8?B?ZXlmbjFUbXM0a3BubGxiQUk4RG0wQW01RHZqNnpIR3FYRzVKNFR1L21PVkVr?=
 =?utf-8?B?OVhVdHpNRzRiNDQ0ZWpINEpyTHg4d0FUSTkwOHRHR0ltbTJpRVRrSFp4Z2N1?=
 =?utf-8?B?bUFBVkhYWWZWbHNId1hzdWdvWEdTc2ZYM0xSS2lEdVNzR3pnaCtRNk4vT1Av?=
 =?utf-8?B?bDYwWjY1dHVQWnVCYUZKMUZ5Y3lwRjhlb05hSFhUY2tscGJRbGQrcnR1ZklU?=
 =?utf-8?B?a3NzTEcvV1QvcXdDS25mN1hsNWJWVXZNVDViUytLSnNXQU1BMUNqNTg1OFNI?=
 =?utf-8?B?WFl4VXV4aDVtYTIvRGdoQmdXWGpWY3U5MytZUmJ0ZWg5QWdRd0p5T2VOUlZO?=
 =?utf-8?B?NGRGR0w1WTMvdjlqZ05WM3dTR0ExWng1V3NuVy9Vd2pleVpTMzV1dlhZcjRn?=
 =?utf-8?B?bFV4TUkyVytZTURRYmJPdjRiMmJPNWpiR2NKcklINHQ4N3p5b3NXT3Jib3ZS?=
 =?utf-8?B?OVdnNmJudVR1V3Nsemp4MmhORjVJazhHSG50K0lEVEk5a3A5L25aSUVFaXhS?=
 =?utf-8?B?SExMaWx2Vkk5c283Wk9GSVJ3MTFFblhMbzlYakF6OURaZ1RQbDZCUG9NVWNs?=
 =?utf-8?B?M1FQa0dWTW1idnN1VVMwSU9OK2wzNllkMGtxdXdpVy9ON2thTTRLWUlGNUNn?=
 =?utf-8?B?TGNGRkNEVEErSGdrakNRWmNybzVxSENubldkTmZNWDlVVU5DaEJUREdqK3ZY?=
 =?utf-8?B?cFBxaFh3cTNoQ3gwcTlEVzNPRWdnM3EzSHkyV2kxZjRNU0lPSWx2ODdpdlNG?=
 =?utf-8?B?a2Q5aG1aT3U3Z3dDOEFSVlVsRC9qdXUyQ0w0NGdqd3dSNGN4YWh4V1ZYNU1l?=
 =?utf-8?B?cXNyeUt3cC9SMVdydjJUNFIyVUFzUHBnd09ZRDA4ZVlGL3d3KzlPKzM0dU84?=
 =?utf-8?B?MUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5feb063-0319-4697-b497-08db083f6c80
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 12:41:10.0969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OVhrnDQ65lhGtNiJuStuu783h5wh4027CqTOHv1JLZqbIdex4bFefUJzBIJw57DKrDDhctFRAl8ivfge6lebow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB7941
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 06 Feb 2023 12:41:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10602

On 06.02.23 13:17, venkata.pyla@toshiba-tsip.com wrote:
> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
> 
> This script helps to generate kas file on the fly for reproducible
> builds that includes latest value of SOURCE_DATE_EPOCH value.
> 
> Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
> ---
>  scripts/generate_rb_kas_file.sh | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100755 scripts/generate_rb_kas_file.sh
> 
> diff --git a/scripts/generate_rb_kas_file.sh b/scripts/generate_rb_kas_file.sh
> new file mode 100755
> index 0000000..cf0b030
> --- /dev/null
> +++ b/scripts/generate_rb_kas_file.sh
> @@ -0,0 +1,17 @@
> +#!/bin/bash
> +
> +# Generates kas file on the fly for reproducible builds with the
> +# SOURCE_DATE_EPOCH value
> +
> +
> +source_date_epoch=${SOURCE_DATE_EPOCH:-$(git log -1 --pretty=%ct)}

Can't we resolve that via a bitbake function during the build? Then we
do not need this script, just a kas/opt/reproducible-build.yml.

Jan

> +
> +cat <<EOT > rb.yml
> +header:
> +  version: 12
> +
> +local_conf_header:
> +  reproducible-builds: |
> +    SOURCE_DATE_EPOCH = "$source_date_epoch"
> +EOT
> +

-- 
Siemens AG, Technology
Competence Center Embedded Linux


