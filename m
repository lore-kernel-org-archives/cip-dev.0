Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B73C54E67
	for <webhook@archiver.kernel.org>; Wed, 20 Mar 2024 13:09:32 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.87])
 by mx.groups.io with SMTP id smtpd.web11.44146.1710940164895844859
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Mar 2024 06:09:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Oqlj16TI;
 spf=pass (domain: siemens.com, ip: 40.107.8.87, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZrFcgPaW8eXJQ0ZPBoEyFCSQ5XLgkHAFDfDpJA3mfCIKfCjzLUE4lryXfZpePHhLvdAj28QYSMrG5HjYM+4QwgV+Xu01IAZAmKXHng2xMhzUhFTQe6mwu5UoOviwKbPstrZ25vaMsHOO4CQTwzD0QqePgXhBHnQiJf476lQCixup+RtaRVohcYIjSffIz1QBSUaI8W6gpNcrLlVSEsq4SyN4AbwIPJD9iSLC/UHDDkiB49eRrNcKW+1I6dsn6TrtTofWOaGxkmwW5zxmJob/mmC5n1e76AT8ROHht1Z//Yq2dzr9gO9Euo2hwu7+UDJ8EdCBuAhxYrtKLppnWHb5cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ewDzZyZjuD8L/N/8HIrYt0GMGO/vucvFnUuRg5FRnw=;
 b=YrA9w+VR7SemriTZIbzXEPjc9laHT9BdCyCTdfSFkamVAXypxhZ53VTmH9Y4w7iNMqCRyo3haV6Y/ULmSkwM8QgWSQDTPMn4+2SgeZC1pgckL9+cM7hKKiyF8tl6Ple7lsfrd0SZnsyNXu5LG35IINv/+onn48wl5QLPZQAujTAqbM1dmVMxr/CBUDSxJWAdr5lNJR3ZlW5dhCzX2LGgHVfniWaDiMSKSVCAtxksRRjsi28C6Gwp9cLnkyR5IZZmvpsZ4YoM68mp1VpQveJ5NkUE/sN1sJA4bGj3LAiUYKD97kdN27rQFPFsQRNBrXaZ4NPuFzDUtj5BmjBfpLRYJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ewDzZyZjuD8L/N/8HIrYt0GMGO/vucvFnUuRg5FRnw=;
 b=Oqlj16TIkipR2skfhJLszWzk55UO9bMA3XeqgeCMgxSxDLI0Evw4tabMz1czGF5hPHbLxYRdltXaqWusgaQ3J1ATlEi52QHEYsJHrQRCriByXXy53Fm73UccyFnWf45LgB07HEHXRxEc124imYr6NzqJHLSz/RDxwfT8K5OscDB1z4e9ajSg0jcAxhO0URYP4bfqQ3L/8lq+s/hTYFQLi4iLd9QxniJcSRStpTmtkGvw9KC0iIU5FrDLslROUjCI6mkirZ1CReEc3w4L8tJvoTmtKTCWXmEQVm7FHARqLex2LvSgs/p+cNoN10nQclhutOccu6vfyS51wJwY5DKs0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB7465.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2f4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Wed, 20 Mar
 2024 13:09:21 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 13:09:21 +0000
Message-ID: <3f30557c-6fdd-4715-a959-1cb27334a319@siemens.com>
Date: Wed, 20 Mar 2024 14:09:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] swupdate-handler-roundrobin: Add
 link for handler search path
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, Adithya.Balakumar@toshiba-tsip.com
References: <20240320130056.2335582-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240320130056.2335582-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0213.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB7465:EE_
X-MS-Office365-Filtering-Correlation-Id: 076566f6-d6cb-4209-882a-08dc48def51f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	6evQWIw37a+jzIuouj8tpcqReQPYtbO6ZTNMymP223PP14BmT9ZlaXtNq4VqdEjvQ9f+FRJ5WRhGonRUEiRxm2L3YlyDAA9NFAexf+AT5nBy7W/2PSnlAigPp0gkJG2fDeASNAY/ZXsY7s2Omkxq0q0kQYK6durvFIkI7C99HMjdBa4nLc0WOalzeyXZnjsI2aHZuG9GagK2M5shGWOaqrSS33MsciLZxYUcO6hNLGek5w5Y59E5gp+CcL+QQ3s1GYiEx2kRK2TSCeu7nadcffAYqGRoTeUCPxKYr9HGRnnhqI6q8nXt6Ko9KywOD2LeRzfhFW0C8lL7QSo3K/o4BluQgxVPIwX1tXZiIE89hEmPQm1H7IveEsVGY/Wn8U+HZ2r33NiZlPkVBUOqUfO6lssO3mJXI5xN3vmYO3B9QhGQsAW1xhbZUqf3NcRgGF27beiGhrscyoyhWaOtTVbyF2gYXABFUihUnYNoAnaKr/a++qk7CQ88Lt63n/CbJcABXIDPoOWjLeJRAu7wbJmQRKX829mUwX2fhN6PQhP3owfikGT3c9/zYOMRqCmu1Z99AuB6dLWZjsQd944ERvqFvmYDPIoCB4c9/JbmzXEpyvs=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ejdadGFnWGl2N2RoeFJYb0lMYi9FVEZsazlOTWV4TjVuUDVuZmpwS2VGbXRO?=
 =?utf-8?B?VzZpM2tlQk5lWklRcmJaVmRUT3lwcVdqaUZLUmdXc0t4Mndod0tGMktBc1Ru?=
 =?utf-8?B?QmhwNXpGV1hQNWpmRk1Xb1RMWUJvdjRDelZSVkFXL2g2QTRQNHp4UVhObm9a?=
 =?utf-8?B?WXpmcDZBWFFscEpCSk9UdGduL253ckFIOGJ6M2VuWEVBUHZoUW82UFBnM28w?=
 =?utf-8?B?Y0ZEL004aUxvUmd2VE95ZGtodG8rNUw1amJtaStWeEpCRkd0azJwbUJXQk9I?=
 =?utf-8?B?d2lndFlYclNSaFBMdG1TdGtRQ1VScXltRGJZSUhObk4rRnlKL3VNS2JnTU9k?=
 =?utf-8?B?VWk0Q2lSczNjdVppYWFBc0xXZUNkSFVwQ2RGUjB3MlVmVU04TkRHUWEwNjk5?=
 =?utf-8?B?TWRTbXprSnRwWDkvbm0wKzZ0Z2dUQ2ZQYzVET3NMUWFUU0lQNnhKVTNJZWFH?=
 =?utf-8?B?RVRlbkZDUDQ3VDV0bU44TUkrRDZpNmFlMEdTcXFnQXRLc3lSdnNEUnROQmFB?=
 =?utf-8?B?ZG1GanFWZloyMTJFMjhYUXhwQkM4MHNRWDFNN0lGK1FsNDZIU3RTOUhUV2wv?=
 =?utf-8?B?Q1Jmdmo1c2wweFc5QWFRTHlCTUdaUWd2Qmt4eXJDamN6ZHo0Qk1Uc3JoYzha?=
 =?utf-8?B?Y2lVVVBXOEd2ZDNZL1orK1IrUjdHVk5GbFlqV0FJRlVGc0w4WG1mNyswMnRj?=
 =?utf-8?B?ZmtGZEJIVFJPa3hZMjZmNUhHVGo2WWJ3c0lnY0I4WmtjajRTQ2F1ZEY5L242?=
 =?utf-8?B?RVBtRjlWbUFuZ05Lb3lZRGdiU0Yvem16SnY5K25ndlVkR0gyQitKV3dFc1pX?=
 =?utf-8?B?dkw2RFpCWXl1QzdzdlBUUmwvZGsxMFFkcTExUDBkazBoVDJzVHByRFpSdmlk?=
 =?utf-8?B?QTMzdFB6WkdpZ2pwQ1UrSkE4dmVJS3RuN2NON3VsTlBjQWlKV3laK29kOW01?=
 =?utf-8?B?U1d2RHVIZVFlbDNrdUM1VmM2K2piYUNSMk52Q0ZvWXQ5QUdWenoxaE9KRVFP?=
 =?utf-8?B?cGg5STlpakNYRDlLZ2I5em5GSjIvNTdpaGFxckkwaFdlQ0UyZ2dOamo0dk5s?=
 =?utf-8?B?Q294ZWlmSUJPS05pZTN2a0VBbGQ3UHF2YW9RNmdNNEFpVXM5bDdQS25SR1Uy?=
 =?utf-8?B?MXNpSUhDUmxUTTkrRGw5b0M2Z04rQU05MWNxZ2I0Ui9vcFc2T2pieHd6VjlP?=
 =?utf-8?B?dkRiVTQ0WU5sd0tidGxVb0Jsc3JMTWp2SmVYMGlZc1hySnhDbzAwRktrVitC?=
 =?utf-8?B?bWFKQTFlOEVoNW1UMlhvdjViUFRHYjJuTExBOGNXanRXaTVPUW01U04rRDg5?=
 =?utf-8?B?V2V6cjdpWGgwalNZQkZ5SDY3WXRQNDdINnlCYlQzL09aOTJUaVoyOVFKZE9q?=
 =?utf-8?B?Slp2TnUvdjF5SmF6VGM1N1pIMDdXcGdseXl1dDgzb0VOZHBjd1NIaE5OZUxs?=
 =?utf-8?B?VXBsNE9iMlZTc0MwcDRQMTBhM3RaVzVhVnhHTFhBNnF4U1RWYTkvakk4Ti9o?=
 =?utf-8?B?UGJxTVJQbjF3TWovUXdnQ2ViZStzdldSZ2g5SzdiblBqS0V4clNWWWJjZmg3?=
 =?utf-8?B?L2xrSEg2WFpYT2lmUWI2WGpVZ3hqZ1BBOWtBU0wxSndDREpreTBwVnUvczlw?=
 =?utf-8?B?ZWo4SUZNQkRqSnpOQ2g1VW1oejVrSVNtYmR3UDR4QmdCc0pHK25vb3pDTm5M?=
 =?utf-8?B?aGdIL3ozQ2pEY2k3YkpBWEhEK25vcEI0UjAxdjNiOHViTHZjNlQ2WUdIUytl?=
 =?utf-8?B?eUIxemtrS0lYRVRmazN0ajFaTy94ZjZ3VzlrWGc2cVpRejJaa1ByS2Q4Rlpi?=
 =?utf-8?B?WnRyOU92QmZlTzkxTWlsOTlnblkwUlU2aW9tZ3pNd2xjOG5vUkF0MnpJN2pu?=
 =?utf-8?B?T3R3MVV1OEc5TnlwaFpjdzEwVTZxU3lpQmdac09hRC93N0ZzUG4xa25tU0ZM?=
 =?utf-8?B?aFVLQnhxVXdkdDV5eFV3QkFtcG5XaHV0TmhwV0hZaWp5b2JpU3NQODJrMit5?=
 =?utf-8?B?M3B2S2NZUThybVpSL2tVZ0k4N3FJMXNNQTFaRStpSWlFb1ppemYvUXRBR2RF?=
 =?utf-8?B?U3pVUXQ3LzBpZ3VVS0hEajA0RHRBbEhadTByZkxLeWpSMmtBVXo2NHpxY0NG?=
 =?utf-8?B?aFNDWjFHd1o2WjYwZVpoRlJnby9Zb1ZIb0g5YjZRTlFlWFJYM1QyUlY4V3dm?=
 =?utf-8?B?bmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 076566f6-d6cb-4209-882a-08dc48def51f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 13:09:21.3314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BpcsUXxn291zQUQtvBDRxEK+BCLQwIFgM0XwtNGXqydxhErssougUe6AHzH5FQ8ex2JgYK2txgWjwCKdnPLUAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7465
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Mar 2024 13:09:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15389

On 20.03.24 13:59, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> The lua version which is used to search for additional handler is
> hard coded in SWUpdate and debian salsa[1].
> 
> To support multiple distribution with different lua versions add
> the variables SWUPDATE_LUA_VERSION and SWUPDATE_ADDITIONAL_LUA_VERSIONS.
> 
> SWUPDATE_LUA_VERSION defines the main version and for all space
> seperated entries in SWUPDATE_ADDITIONAL_LUA_VERSIONS a symbolic link
> is generated.
> 
> [1]: https://salsa.debian.org/debian/swupdate/-/blob/6ccd44a8539ebb880bf0dac408d5db5de7e2de99/debian/rules#L13
> 
> This fixes issue #102 SWUpdate failed to install update on bookworm
> amd64 image.
> 

Should this move in front of your recent changes in 'next'? Or is this
issue older?

Jan

> Reported-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .../swupdate-handler-roundrobin_0.1.bb           | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
> index b39278e..95ceedd 100644
> --- a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
> +++ b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
> @@ -20,12 +20,22 @@ SWUPDATE_LUASCRIPT = "swupdate-handler-roundrobin/swupdate_handlers_roundrobin.l
>  SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG ?= "swupdate.handler.${SWUPDATE_BOOTLOADER}.ini"
>  SRC_URI += "${@('file://' + d.getVar('SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG')) if d.getVar('SWUPDATE_BOOTLOADER') else ''}"
>  
> -# lua version 5.2 is currently hard coded in swupdate @ debian salsa
> +# The lua version used by swupdate to search for additional handler is hard coded in debian/rules
> +# see https://salsa.debian.org/debian/swupdate/-/blob/6ccd44a8539ebb880bf0dac408d5db5de7e2de99/debian/rules#L13
> +SWUPDATE_LUA_VERSION ??= "5.4"
> +SWUPDATE_ADDITIONAL_LUA_VERSIONS ??= "5.3"
> +
> +do_prepare_build:append() {
> +    for lua_version in ${SWUPDATE_ADDITIONAL_LUA_VERSIONS}; do
> +        echo "usr/share/lua/${SWUPDATE_LUA_VERSION} usr/share/lua/$lua_version" >> ${WORKDIR}/${PN}-${PV}/debian/${PN}.links
> +    done
> +}
> +
>  do_install[cleandirs] = "${D}/etc \
> -                         ${D}/usr/share/lua/5.3"
> +                         ${D}/usr/share/lua/${SWUPDATE_LUA_VERSION}"
>  do_install() {
>      if [ -e ${WORKDIR}/${SWUPDATE_LUASCRIPT} ]; then
> -        install -m 0644 ${WORKDIR}/${SWUPDATE_LUASCRIPT} ${D}/usr/share/lua/5.3/swupdate_handlers.lua
> +        install -m 0644 ${WORKDIR}/${SWUPDATE_LUASCRIPT} ${D}/usr/share/lua/${SWUPDATE_LUA_VERSION}/swupdate_handlers.lua
>      fi
>      if [ -e ${WORKDIR}/${SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG} ]; then
>         install -m 0644 ${WORKDIR}/${SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG} ${D}/etc/swupdate.handler.ini

-- 
Siemens AG, Technology
Linux Expert Center


