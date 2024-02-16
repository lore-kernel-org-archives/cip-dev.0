Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C8BC48BC4
	for <webhook@archiver.kernel.org>; Fri, 16 Feb 2024 15:40:01 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.54])
 by mx.groups.io with SMTP id smtpd.web11.21813.1708097998540617107
 for <cip-dev@lists.cip-project.org>;
 Fri, 16 Feb 2024 07:39:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=zbK4K2qx;
 spf=pass (domain: siemens.com, ip: 40.107.21.54, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YFlmemM4mBLXHnZLmEv/3V0rpsOn45vyaSkxS575r+ayUnD8IvkGF1vgvBBf6vuvhBMX2P4QivZ8WliAHZ+RVHOqq7v9/qBoiRBkAYLAlxhFUz3VXrif7ueKzt4AAfrY8y5tgZbKZ083/gJ/6eYP5X+/+/jioqH5R0TFjc1uG5VxMsUT6u84+jF5uRK91SxmSJe8sQogZ5FjdLX9xsNFouEXFtEQ0UnFmZFGrs5yRSJ3udKy669pRrppDlSYoYUx069lBbwOzu+REP1DQboZEvlqAh6E5Plrsc6BMrFxUIpcP3d225S09hhiQETJwvQhglqRqin6R4LRe+x33XqmNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EdrYxGTN2zlpnmAPyrENGdI1gtCbcP5PNzhrOwyceV4=;
 b=nz84032g6fIgu+8oyWbdF6OIsu17JUqR7X6KekFPoknGmHT52MOJH67pEhyf/J+Ufv5nvPqHjoJ2EnuCC52xluAVcgoIXM/dkQYKGDnssqISQNjKpJ7uoeAouAnZjqMifMDEAqbwJx3mOcJbjM/x0xCTVRA6Yfd6cFCQKO/IikYBDtOsUIdO/5AT05GT5OwRI1UieqkCmkVZjm4DIihd3OOig9ALFl2M0BUog1g86BwF5QCAMRdyOtwPY+yzekCZKShMwe2+CfDqAIw3g5fccZXRO7NNKX0LujyJJZD0AKvGPWmiDk7U6Of+cALq4pJXHUHWTczVnBlEwXvrGjyUCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EdrYxGTN2zlpnmAPyrENGdI1gtCbcP5PNzhrOwyceV4=;
 b=zbK4K2qxNHh9RJRHGdejItIDjpswGWAfP+mLj/ZpMghVrNKlUb6CK5zKJaMJ3cduKSPl8TpfkrkzN/V2Ez9zfA+P012IS2aYIdmYW3E82nbi6qThMm3OLGMbjDcXTC8Cw5oLdP1nb37HirBNdXfrrrEjXKB8k42o587UT9uPwG2iLBv9O9bIJXq8FAPua3z/3/x8yKEUG6XCftB8OfXLZoy0j9ZhVMwxrPlJeAxlyEnd8j4sqFV0ESNAgbycVRSIJG3foOuRIb0HX1ZZJnIb8UbTmg/Kbd+U7ZcGghSYQX0UMKz4lPNFH/QjbXsAuRjkpWvgS3nzy2mqXpUuTBtdrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DBAPR10MB3996.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1c4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.27; Fri, 16 Feb
 2024 15:39:55 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 15:39:54 +0000
Message-ID: <9be1412f-94d9-4c00-8e9c-6fa343ff17f2@siemens.com>
Date: Fri, 16 Feb 2024 16:39:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v3 4/4] doc/README.swupdate.md:
 Add documentation for hardware compatibility
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20240216153024.260416-1-Quirin.Gylstorff@siemens.com>
 <20240216153024.260416-5-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240216153024.260416-5-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0056.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DBAPR10MB3996:EE_
X-MS-Office365-Filtering-Correlation-Id: f526482a-f1f0-43a8-2ef0-08dc2f0585ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	SaGd/358upv60NbE6ZUqFSaspl8WoEt1QYGDJ8KGCvic+y+CkaT2lV9VLiYT1E9Rw+PNa2SRfAjSoMfJEUmsAlui6pZSxYjuhbhLKTm1bIU8ogzWz5NLkBU+MTNxm/mVxNkdgUFzZGuap/CR1NnWTCtKd/R0OxfsKMSNl9xOpMLxcvzMZvJUj4ATFNKkEtJ4sflSvux+oDVmitSifeCa0GbuJxDsq2p09xTT0+P0f06kju+zKFkCnMCz+dv7aMYddzGmOCvDRaDmjYphCbuVffBpnO8XCS64dFVR/o3fIh2xTa3rnKLA+YYEIeNvcdnRoIHHxIw3IvnMKLV7vINm0TYFbqOWw7lfVVjuXKWfS56oezt2rTjNeHVyfDPf9Np0D62CT/eUuCiohYCJTbmCT07jCIlI/XP2groSix6Tc6W70rjuN9hA0Cix8vNuks9FpqMRgolrEVCdMN/N/ui6TwjwIkor7qYhDJ9gsLfFOnp17agI6/c0vmjoeAsYC2jGYZmql7bYZeWenzwKkpjHR1KzFtGZFRucmMorgbIcBMA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(39860400002)(136003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(8676002)(66556008)(5660300002)(8936002)(44832011)(66476007)(2906002)(83380400001)(26005)(82960400001)(31696002)(36756003)(316002)(86362001)(38100700002)(41300700001)(6486002)(6512007)(31686004)(6506007)(53546011)(2616005)(66946007)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YVV4UG9oeWcveXBjYml1ZnJ5cHhpbUZLeFJOc0lwVjNaVXI3ck44YXloS0lR?=
 =?utf-8?B?N05oQjNVWnFzMjVSbGlqWXNQanNKUk9jWFVmQWttaG9zV3ZqVHpSVnZhOUpX?=
 =?utf-8?B?UXFzK1cxY203YzRGZVkrODIzMjkxTi9nQ3dtNHNaWGVka3U2Ym1vRlVuRUFT?=
 =?utf-8?B?YlR0N1Q2c1Q3MXNzUkgrcXNRSHBzNnFUbHZyUUszTGZ2K0p4U3lPbnNYa25V?=
 =?utf-8?B?V09YLzdlbURhVnd5WVRXekl4RURPL2pScXgzQldlaDRNdGZBMm1RT3BjR0Mx?=
 =?utf-8?B?UlVIdUdGTUNKWlNuL1lpayt2VXRzVDE1UnR3SUFpUzRGcmZ6Nk1pdktwMHVX?=
 =?utf-8?B?TTFrSTlIL25hMERlY1cwTUhjdEJiMFE0SjZpdngrSmF2Mk5yTkgzL1AwY09K?=
 =?utf-8?B?VE04SnpVTHAvTW1qU0gvOWxhbUswT3hhU2kyWVU1TlVWM3dobjUrbFlRM01r?=
 =?utf-8?B?a3kvWXBaYjduOFVTUE1CWlVKUFpEYXVjL1JXZnFMa0dnU3FQdUtaNlJjOHpM?=
 =?utf-8?B?MDFoMlhaSU53eWRPbTNBa2REdHFiRG9hY3pubE9POFRzTmNhVDVjdTdkLzlH?=
 =?utf-8?B?LzV3NVdVZHl2d0pONXdpSmxQL2xLS3VoRTdZbHZFbi9TTkI0QVJJQTN4VUNF?=
 =?utf-8?B?U2hXNnF2dE9tRi9IUWgxY2ZiMnN4cnNkd3FRWHNDRUhKK0plSGVqc3VxWFR6?=
 =?utf-8?B?czVHaTBBZEV2YVBzeDQ2eHhGVnF4Y0p5TnIxZVV2c2Q2YlMxQjlxc0dMMHFl?=
 =?utf-8?B?ckx1WFBGV1ZTMjljRmMwNVgvTUhXdVg2MEwvT29YcVNtTlc5cmJZKyt1SFk0?=
 =?utf-8?B?Tkc4WE44TTcrL3pGY3R3QU43RVBLVWFTMTdOdk5ta0x0cTlRR0QyeExtZHhx?=
 =?utf-8?B?bGJqeHQzaHlHekVmOTJFSUhIRXN4SmZ5TTJOeXFLM01KTXVPNFd0alhJT0lz?=
 =?utf-8?B?dnhWckRlTmtJd2svSVJFOTB0U0NIQnZrOWtXd2MydXMwcXgwdElYVnl2Y2hI?=
 =?utf-8?B?VkdyYzlXaUdTVXZ4Vmg5OXA0OFQ4MlZlWFhsYlNVZ0FGY3NjVFJ4TjRjOXJx?=
 =?utf-8?B?a2pUZ2FCMnNwU2UxM0ZUdVRpdlJvQ3FHUnErSFdVSkFXbmFuejhwdk8wWVdw?=
 =?utf-8?B?dENqdzA2aVJoZnhOV2NRbnJJS1F6bGh2aWhxMENIMlZzSysyUmRWVkxXRm4r?=
 =?utf-8?B?TTN3NXpnZjFjc0YvTk94RjBvTk92am4xZHlmRFBST3UxbXdRQXBuSzZkQU5l?=
 =?utf-8?B?K2Jub003T3hsSnlLR1ZtaDFCNXd2ejBiWnlWWkR2ZW9YdFdGRzBzVHdGcmdE?=
 =?utf-8?B?ZTlHMnh4dFJLSzVkcGhpaVBmam1JVCtoM1lPSW45Y21oZzRLd1NwTC90Z3Vl?=
 =?utf-8?B?NTByVytnempBNWtYT3RsUXh1dnNZMGhvZzA0NlEzY2hkV2gyTDdTeUVlVlBs?=
 =?utf-8?B?TDZETnEydXo5R0JvN1JaQnNESGovNHA0T0E3MnRyVzBKS0JRL2FRUTZhencw?=
 =?utf-8?B?endWS3pBZlVxa1QyekZkM0tMczBPTmt0a3pKTDFLaExwK2lXWllxSFlvM2Uz?=
 =?utf-8?B?SDVhckNONXBlNG9qdENLZTRKR1dkZldJNW8vcVhtOFVSdnozeHVWanJWR0V4?=
 =?utf-8?B?SEpEcmsxWDVOMGlLeVF1MlhYSmlVcE1TRU14N01DOStDcW5QQURUbk1HZjFG?=
 =?utf-8?B?QUsvcWhQb29TMDdDM2l3ZGtnR1FiVmc5WlVtUUdMWm1KU2RnK3RnNmhxamM2?=
 =?utf-8?B?RzlpLy9KVDlOOWNYQXBKQ1dqc3RHTmlSSC9HMDdnZ1IvdHM2V1dZZ0NKV3hv?=
 =?utf-8?B?aE42K0dlVzZkbW9vejJ4ODhpeG4xd2dEa1ZWdVREcXV6bnZjL3ljeWp3S1Rk?=
 =?utf-8?B?OW5WUUhLWXBFT1ladUlJT1FUQWx3YUxiQ3FFZ3hPSEFDakJHTlliWHBnZ2Vt?=
 =?utf-8?B?M3NkakVaRnFsdzE5SmQ3ai9QM0h6WnF6dlNXQ0xscjVjUUNrbDlBQVR6MWxP?=
 =?utf-8?B?SnU0a1RlQnFTRmN5SnF3cTlPV2NKbDJUMTlnWmc4a2tnWjZUWThUai9aV1ly?=
 =?utf-8?B?a2xacTd6YndaakMyak9xTkVSSmMvNWZIWTRKQWVwTkFaSmN4eEZLSXEwVXFW?=
 =?utf-8?B?ekxDRW9vWm9zUDlJYXd0QjVqMC9UOUJSYWRHYkVlZTJDSmxYMExDSlc5RVAy?=
 =?utf-8?B?a3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f526482a-f1f0-43a8-2ef0-08dc2f0585ef
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 15:39:54.8951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OdkgDyNupKGMJFh3Abe+c4/XFewO6bsTCasW3CiX6l7BwxGYc95/ZpKwphnQ0jh/CFqivHIECWB6Q0iYpu7UcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB3996
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 16 Feb 2024 15:40:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15019

On 16.02.24 16:30, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  doc/README.swupdate.md | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
> index 1c94699..0f179c4 100644
> --- a/doc/README.swupdate.md
> +++ b/doc/README.swupdate.md
> @@ -21,6 +21,16 @@ window is still possible.
>  If the variable `SWU_EBG_UPDATE` is set to `"1"` the update is also stored in
>  the `*.swu` file.
>  
> +## SWUpdate Hardware compatibility
> +
> +The variable `SWU_HW_COMPAT` contains a space separate list of
> +compatible hardware revisions.
> +SWUpdate checks the compatibility against `/etc/hwrevision`, see
> +[hardware-compatibility in the SWUpdate documentation.](https://sbabic.github.io/swupdate/sw-description.html#hardware-compatibility)
> +
> +For testing purpose the content of `/etc/hwrevision` can be set with
> +the variable `MACHINE_HW_VERSION`.

And what is the pattern to produce that file in production images?

Jan

> +
>  # Building and testing the CIP Core image
>  
>  Set up `kas-container` as described in the [top-level README](../README.md).

-- 
Siemens AG, Technology
Linux Expert Center


