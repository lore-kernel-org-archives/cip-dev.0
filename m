Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B5FC77B7E
	for <webhook@archiver.kernel.org>; Sat, 27 May 2023 16:52:51 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.58])
 by mx.groups.io with SMTP id smtpd.web11.13832.1685206362441834890
 for <cip-dev@lists.cip-project.org>;
 Sat, 27 May 2023 09:52:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=rAEa6Ino;
 spf=pass (domain: siemens.com, ip: 40.107.105.58, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gbnluPDQwtBAlg+WLbviLPD5h6KELkxGeuL7Zp7EHGGvT3yRXxEVpDkIyCjqXT133xOYMjzw3dEvNgG2ruLXhemv4wtt74xTYaH/5mDP/Uzmt2fK1kR/M3jZ+Xz+S4k75NLE/j8GybGXt4/OkK/kI6zwGMz/a+iet5WpbClgoDp8MLYbnFXY9B0hLKphDcWT2LQxZbzoUw78/48UnxJwMZVdi7F9n0IyZeKof35xPvz1WhHcmu5SBTyq+hdOZD5PdMdq9mcLiQikCcOAKU+gazbPGUTkeDRIVfVv53MOInOsD6b8h3lIeziYi3+OWPCKHI+iNVM3piyXlGh4Rtyurg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T5wAxJBatTd4DiwU/8inZ7Qg9MzavdB5kTtAMLJTg9A=;
 b=QtFi0TejgA2I1mn1SAFDU+75bMJJgnvjFCUEYG59SLiCMjDeWlBHTqPVWAvzw22yGv8ZOxxx+pamCS9344JoIejfoYyp35gMK5PVp90yFK41D/ZIGXTp8CFRtJcrb7EgzevzudVm+QDtUx0cfChcfXp11FjXfn8s+uvKyMIFPpR9jMM1qfqGy3hidcOfDrkS/Ik2Ya7cz+sQiG6rPW+ZIwJDNKUptjbPH00mv0d4Y0wh3hqZCSmclrZFYoIznY+hr2s768LY/VlDmnVMc5eGGwtIYZ9hH8VdOM+lo3WoMSGLC1TySIBXQAw9/18Os0vjV6jrpHjE4uMNYpuzubFerA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5wAxJBatTd4DiwU/8inZ7Qg9MzavdB5kTtAMLJTg9A=;
 b=rAEa6InoTR+cwTodT02PqK1T+D39H+iURWXsrZdXNJPMITggtnQkxSVAlyldmR+MANuikVZWdMpTJ2gp7h9ts0uZSWU1C8McKxLwe/n5ZvtvTzBxZ45Z0ItIFJOlRtOrr43XFU2UMUlVEzf5xwPmGwWgBP25pixraGLG3t3Fd1+2I9kvSJiHKqixDmGTiXbh61n31aycChWFgmhfx/NdLZGwKthQqums2cORUFQLxfXzc9gzBFGUy1djFzrjQK86tDqdIK3RsyW/D3n+5Fsu30OERgNldZZnd2CNcY25HJIwgUu4wy7C/1tx6w/+lUJRUC8SGZ/JOoPOB9ZrjB/6WA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5589.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:241::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.18; Sat, 27 May
 2023 16:52:39 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18%7]) with mapi id 15.20.6433.018; Sat, 27 May 2023
 16:52:39 +0000
Message-ID: <49501500-7f11-b9e4-a5a2-7dd15af3ae3b@siemens.com>
Date: Sat, 27 May 2023 18:52:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [isar-cip-core][PATCH] Drop redundant expand=True parameter from
 getVar
Content-Language: en-US
To: Srinuvasan Arjunan <srinuvasan_a@mentor.com>,
 cip-dev@lists.cip-project.org
Cc: Srinuvasan A <srinuvasan.a@siemens.com>
References: <20230524094724.1953389-1-srinuvasan_a@mentor.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230524094724.1953389-1-srinuvasan_a@mentor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0104.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5589:EE_
X-MS-Office365-Filtering-Correlation-Id: 38804e3d-68c0-44ca-86dd-08db5ed2c770
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	sforUu2YUjr7Z8UKKny7BNKGXnVjBKQENy0yULzpqVblio+7jI3ABUs0XmqLa2NTUSz/08rpLmTDX2imAQ/fC2HYi7VyU1T81DhoCjKdUbeHlOXWsQ+8Atfx641QIMLIlrTr2jd0RgsRfIFLu87EtOkEMUteieLoPbPhg3tXPUxfu8iwu//9+5kPMmKhjUTIPP5UgbtTTnnmrrtRGbMvv4KPSaRqM/nqbdLuBLGRfRv20OShPl1yH7zmOMFAziCZMzLkGOGRMUuOngVKJqSbrbm0/fjkDsVjgcwyD68kl2Kja0pxvne8zEDNwxwc91M3PIyikYXYzqEvQC+dgaRb+MMfWmONwXq+4KsV7mPMK9sPMGrMsrxxRpEPCTFZp9uD9jaA04S93H8zeQ9xf0o+p8c8FMROM5raBIFlaypoHbXyFkKpkaRvg0lbXX78H9NkJ92fnohJeUCNs6jUbQUTD/Gp5Fj9VdLXHCACj2n0eFbbU00390bBH2NZ9qyUDbxKp6vpcdzzRBMiCTy5CuOEbSommeu/xpYUD/rynp50uPwDxItHfTzpva1w87KNfo6MEWj0NJ8sNTer0JXsSriM+iJ9pk5Jhn6yl+OZAl0ArqWM+AUOW0/fyGADDgfTk8r9DN3xjqSHaU90QXrg1+4apz8e5yYXKGnts8V03qmB+bZ4wxng80cyKFbVeIUM50yXhvsdpk0VQaD2o478FFYhHQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(451199021)(5660300002)(6666004)(8676002)(8936002)(82960400001)(38100700002)(2616005)(31696002)(83380400001)(86362001)(53546011)(6512007)(6506007)(6486002)(107886003)(26005)(186003)(478600001)(66476007)(4326008)(66556008)(41300700001)(44832011)(36756003)(316002)(66946007)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Rk1qS1R0eXo1RURZallpSlU2UTFYY3o1TUdxOGlGYjI5TFErRnlmQXBRV3Bz?=
 =?utf-8?B?ZWlTalNOTC8rTmlqMWJ0U3FKbmVxcDZiUmdsdnlyaHBmREgvaGwrYWpYNm5r?=
 =?utf-8?B?Q1Axc1JlNVVhNEovSzY3cGdiUWVJWXpSa1lrOURydjJvQTNJdUFNU1ErZGhM?=
 =?utf-8?B?RURxRXMyNklIbm9jZENBajVrUUpmVEFRUHh4TnBjdlpTMEpDMDJPeG02VDdS?=
 =?utf-8?B?QjVEVnViSUZtYXRQSWUvM1Bxdi9RekU5SGE3UFQvNWd0K0tsZjhJaWdiWGlj?=
 =?utf-8?B?NGJnYmNoREhBSHRzaXN2VHo5U082aVQrSWJJMGVIQTYrSEFZajYvcjhad25T?=
 =?utf-8?B?cFZOekpzNUR1czZjcFhkY3A4TjdaWTByV0pWNjd3RkxxSlBJUCtaSHE0TjRm?=
 =?utf-8?B?RlQrcEZnWUt5ejJORTIrL1N3K0lRVTNRNi9zVWIrMkFKQ2l4aHovQkVZWE5y?=
 =?utf-8?B?SnRBUDBCd2pFYTQyNGxDZG85SjFpcFFvTE12OHFvbXBlQmExUkZWWDhNSllS?=
 =?utf-8?B?VHZlQkc2YVJyNHd0Wk5aTzYzek9JZGozeDRkemlNU0czd2dxT3ZNc01oa1Jk?=
 =?utf-8?B?ZWdoUlZrc3REcWd0QldZY2lPeWozWWVGbkYrZ3RCdmhlRjl1a1dCUzFFV1Qw?=
 =?utf-8?B?MG80ei9YZXB0YjRQNHo3dSs5cTFzY3ZmNTVPNFk0eGhkcTVIUHptQ0JBOXpP?=
 =?utf-8?B?aStrVDcrdzhyR3dUWjNYZHRXKzB0amxSY25FRy9BQldsV2x5aThCanNTL1FO?=
 =?utf-8?B?b2xqVlBhemlDcGtvZU4xQ1A0NjFOVDF4RGw3dVBsQmdTditzMWxPS0tXdktH?=
 =?utf-8?B?K1Q3dDhyU3lXWlh1WWJyamlGU3dWUTlZQmZvbzUwTWVSR290bWNCREllcm5y?=
 =?utf-8?B?RnFvRnU0MHZWNXphb3dJYnc2UGVwNVRtZFZVZVFJSzBNMUlGVkFBTEl3by9W?=
 =?utf-8?B?M3FLOXlKcGF6QXNkMWdsVG9uaFZuNzh4elZsQU1wMW0rRjJCZnNIOUlWTXYx?=
 =?utf-8?B?NXUzT1BpU0NTcDM2NmQ4WkU1bzlBVUJwSDRvWTNESzFSS1h5UjI3T3BVTlZ1?=
 =?utf-8?B?UHREd2VjditHcHVVTnRJbmsvVU5qQkluZTN6YUxCUGVQVWdVdnMxdkhGL2Zv?=
 =?utf-8?B?OEJzbndaQXBRT0J2dmZ6angrMlJ5NmU5M25qZGZ3dFYzbXR2aDB6ZEFPYnJ5?=
 =?utf-8?B?OG5YaENSN2ZkZWVTUDlka0xVQUNGQ0plbUhIUm8wN3JtUWM5dXZNUEJPYW93?=
 =?utf-8?B?Q0paM1ZRU2RNSFhoSU1SQW5mdTRVY2srb3FBSXdmdldVdnpQcEVzWWcxQ21a?=
 =?utf-8?B?T2RGUWQvbDZrMGJsdU9yZXpEYXppQzdjQ2N3b0ZTTkhxUDI2V0RMcnI4bnRM?=
 =?utf-8?B?N1NCRDdROHRmTVhFZUhIK256OFh4c3JsTUZodEgzUWwrWHlUd2VyNjdHWkg2?=
 =?utf-8?B?VzNFSm1sdTZlYVJGYmM5R3BtaGVHNHEyR3NLdzk2aHBGM2J0R3l0STd1L3ZD?=
 =?utf-8?B?ZWkvVUdDVVhSdjFEbHNVVk5DUFdyZjJLNUVva2lPVU9QR2ZYcEhES2p1dTdh?=
 =?utf-8?B?M1gyRHNkMDdrTjFZVTlCOVVXVXdldmxycjc0TW0yaUlFTExFZ3lxMXZxMk5q?=
 =?utf-8?B?Zk5BK1A1Q3E5L0xQYmVBM1F6ZVJVWG9sNVVib1djVFJMQXIvU2Fad3VJdERX?=
 =?utf-8?B?MC94S1NsMVFxVUNpZkdmaU0veElSWU0wMlBUSC9DcC9JOWVVUGxyOW1idTA0?=
 =?utf-8?B?OXllZXczeFlYWmNaVDdWR0hkTVl5bytocGpEWWZNVHlEZE1JeWc4QmlCaTNL?=
 =?utf-8?B?SmxlMFp3Y3dFbUVhTjJhczJXVlpZaUt5WGFpcUpDK1p6QUlzZk9tZHcrc0Ja?=
 =?utf-8?B?U1I2Q0JXNnJ0NmU5YXFXcFFjUHQvZWhWNTFuSUVWYTVrbm1LaG5Qd3BwcW9I?=
 =?utf-8?B?Wng0QWdaMUozcjAyVlliUmZ3SzdQSFNsbmVnKyt3WEtoUlR0OTltRmZuQ3Ju?=
 =?utf-8?B?b3NjTEdabmh3b2o5RkExYXgxU0w3VURNT2Z3eVZkOTR2SWVsMFdXcFZXNmF2?=
 =?utf-8?B?Nisrai9ZTzdkSlp2MGhiYlQ3Qk1SY2g0RnZPdXFUSmpocGtVNERvck5lQi9G?=
 =?utf-8?Q?wNy01nDZ57B6TDvVr9X+2l8H/?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38804e3d-68c0-44ca-86dd-08db5ed2c770
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2023 16:52:38.8032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vt2LfH4yxzRhVCidkTR9H8AMnj4nacwIpRb1sgYcNDvjxf9WGPD+EoMikV2KdwcQNjGxqnl7pP0KPHJCyQoldg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5589
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 27 May 2023 16:52:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11666

On 24.05.23 11:47, Srinuvasan Arjunan wrote:
> From: Srinuvasan A <srinuvasan.a@siemens.com>
> 
> It is long True by default, but people keep adding new cases of this
> redundancy, hence fix this one.
> 
> Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
> ---
>  classes/image_uuid.bbclass | 2 +-
>  classes/swupdate.bbclass   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/classes/image_uuid.bbclass b/classes/image_uuid.bbclass
> index 9ffe14d..f6b631f 100644
> --- a/classes/image_uuid.bbclass
> +++ b/classes/image_uuid.bbclass
> @@ -18,7 +18,7 @@ inherit image
>  def generate_image_uuid(d):
>      import uuid
>  
> -    base_hash = d.getVar("BB_TASKHASH", True)
> +    base_hash = d.getVar("BB_TASKHASH")
>      if base_hash is None:
>          return None
>      return str(uuid.UUID(base_hash[:32], version=4))
> diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
> index 9a4d509..1056ab5 100644
> --- a/classes/swupdate.bbclass
> +++ b/classes/swupdate.bbclass
> @@ -67,7 +67,7 @@ python(){
>  
>  # convert between swupdate compressor name and imagetype extension
>  def get_swu_compression_type(d):
> -    swu_ct = d.getVar('SWU_COMPRESSION_TYPE', True)
> +    swu_ct = d.getVar('SWU_COMPRESSION_TYPE')
>      if not swu_ct:
>          return ''
>      swu_to_image = {'zlib': '.gz', 'zstd': '.zst'}

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


