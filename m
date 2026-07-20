Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06BA9C44515
	for <webhook@archiver.kernel.org>; Mon, 20 Jul 2026 08:14:32 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.55])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4326.1784535265641465496
 for <cip-dev@lists.cip-project.org>;
 Mon, 20 Jul 2026 01:14:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=IXT4QOWj;
 spf=pass (domain: siemens.com, ip: 40.107.162.55, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dk7HXQF/xRl0EWS9DCCK2QQCaFy7lA9m7tfq1rsUcT0a3zIHboNRD/qKcTqUXqYSguaxVNGweCL2GHLHbVgFoLUj3uV+vM7RCuW75vSwR1hL/gAhAsDZ0IhYp5EdqLJ0WSpPkRGYQ2hdqv1VSpJO48poCHIJ1w2LHDIzKJI4eXotuA7L03d/StNWDU5N+3gqkCsZ6i5li+Eyq5AF3FRdi18LMsBtyhPvIWymQZQz6LjanF+EahQd/RabwD8EJrcmbIzdpf41PyKcmbSpF+mDknxquTTCy0OnVC8I+wPiGku5AdILjsCM4O5D+lxvhe6k447YcXgofsxhzrvj9r6Euw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IkiQzk0NwTzpBSDWpBTz98y6A6qYsFyns0ddydXitxs=;
 b=lyeuJjthiFLkYAgyNpiGmcHN3biy9yaYbWzDJQLNl2s/0V10jjbTKW5JsXTfLVYYv7IZoTOeOb5VEr+d8ZUtOv1RUYS/HbPhH8XXKBGMd3IxCPyrfjGb6mwmT0pt4l7QZXip6pxMgO14x5KVJdzci6AHB0QfSCuho8grzzrFaPeyFERSaIC4jfoh+c6Kctms5tYnbGlRb909mCEhcPIsDb8JMVIPcS5w+Vn1nbCGInMpm3DQYu2EsLOhRZ/z/X3NhGH7EXU6VCDgD36rS0TOxOZ618lYZMgAgJ2XzcEGu60NrizSqR9jO6D0BIQ9cQVGttCwkz05KyRL83+mDqlurA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IkiQzk0NwTzpBSDWpBTz98y6A6qYsFyns0ddydXitxs=;
 b=IXT4QOWjLUCqtWk/hSS+eqfITDd4mDrw9lgsJMGfm/D+qABufqYi/S6Swl5BqKCQ+f3MLxtO/V8Q8XcmMCUtFn8OSbq0ux1uz52lVfHAqN3PIqr++dIkW7vGVVY8JLsBH2NqzlCAXDF4l+wKylaLmW1UgJKMnlmNB82ySzVztRJkRagSgJZmqscOWDB+IQZkyD5kDqxIYc5QPynsBRbGyQxxcP6pXAFpDfKM/6a5j4CM27LVYhUYHNuUjSR0plONRBCzddQKSHjQhloYzEzhNeqZnbFz1cZfqBiUS8XT/wOPXwM1xGGq2pfANOZHYZmtuug5yDLo6ThenbzznaHpBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by AS4PR10MB5847.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:512::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 08:14:21 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%5]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 08:14:21 +0000
Message-ID: <41d69f3e-2719-435b-8485-f8218f3a642f@siemens.com>
Date: Mon, 20 Jul 2026 10:14:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][PATCH v1 1/2]
 swupdate-handler-roundrobin: Keep Lua version 5.5 for sid
To: cip-dev@lists.cip-project.org
References: <20260720045903.733394-1-Shivanand.Kunijadar@toshiba-tsip.com>
 <20260720045903.733394-2-Shivanand.Kunijadar@toshiba-tsip.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <20260720045903.733394-2-Shivanand.Kunijadar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0005.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::10) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|AS4PR10MB5847:EE_
X-MS-Office365-Filtering-Correlation-Id: c08a5cd5-e319-41f6-4661-08dee636e743
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|23010399003|4022899009|366016|1800799024|4143699003|11063799006|56012099006|10067099003|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	4TCjDPElySD8S31wL9R1u8ihrYuWJBdelScgOcQWkcuSFfmeFPccnEWAy0ABYCEmNTjBhuIZifNwlKlbE+bhesnG0bsjyB0i23BL3QB2iKkBVSGp6OMB3FHltEaaBlo2sbte6Azumj99kyW15yQ7d+uE39d3M8Kq1Ow/2YhCu/uPzLG+/ZBOBPkTw5sej8KGR3f46auLdmjtc6qmdZ0VTj09ysvqbzTNm2Gxhp+DeBBUAKVKTHVTPLR7ml24yrxSeAx/3UhEt0EaAU9DlmCRQKMuv74OA9ljTEIWSKNqsbpWx0hwpi6Vlc9f6QuBR3+9IAMz6iTOSLl26hNOe6rA8rQn2LWKjg8sDldwxQvAWpSo71ePhVQDNDs9AGpQ+0I2bal7vy7A5tShZ+8JdVUJt8Z0vydYNuSWPQajo+vIvV3wTjftfYdhTRqN8iuk5rdD+JsQZkxQKuQYMa2rmBRAem5vcqPsc5iYqnoU8pN+xNa41g/Gc4+oAkqyrbTzpvlFJPm4Ulznsesv9DtiZg0J7ppAzcfa7eoxDYeDC6n1V49+rcaUOFQLIS/saAPftRySyYyZRvPUTNSoI6Vb+EPxKeYbaR50SPcRjKjhr0xs/dd4sj/ebun70TpKJJuFQneu
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(4022899009)(366016)(1800799024)(4143699003)(11063799006)(56012099006)(10067099003)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZnpBYitJeGpOS2tMbWlkamZycTFjN2RsVzFjY3prU2NaQndoYi9yUkhNR2VC?=
 =?utf-8?B?SHBIdWMrLzd1Y1Z6YUdiTDgzMFlwUFFoQW9PVFptOHcrMlJpaENLS2M3enpD?=
 =?utf-8?B?WFF3N2N1RWRET0JoNXZrMGVpL2h5d3hmVzdJQlo5UzUranVLTS9UaDZpRU51?=
 =?utf-8?B?QWVONkRUajNPWmNpbGNJNHFMWG9PNE5ENGJjb0lmSCtLSmJDT3dqNVBCNFcz?=
 =?utf-8?B?L20zNVRta3ZIcEN1WnVTUFJZbFkrellIVmh2TUE3aDBZQjJhdnNCSU5MQW1n?=
 =?utf-8?B?WCtVODRMTmVuNFVjMHJzcDR0aCs3N2RoZ0VhNW4zSGdGdllOYlZWcU5yN05X?=
 =?utf-8?B?Q2FCSTZyNG1UN0JDNm9nYkwyMVBJNDlpTGdnbVRPRVpVZCtJTjVpdnF3UHBx?=
 =?utf-8?B?dXI2MVZBeFVZc3VhWFUyMXVpOE14MWI0aSszaFgxcEFkZ2lQMGNGQk1zclVQ?=
 =?utf-8?B?QktSbkNocmVjaklVVjRRQ0hhcHBJQ0ErTjZIbzF0WW1KdldrVUlQWW42RlZM?=
 =?utf-8?B?c25sVTdKKzhGUE1QbG5Ua1Z4Ukkra29hNXZGRjR4V0ZuQncvME56RnJkVHRQ?=
 =?utf-8?B?c2w3ZzAzNzRMMnNXVmN5T3lrbjJKaDlUMTRLVnkrRm9ETWx0SkpuUldtSTRI?=
 =?utf-8?B?MUxUYk1iWlc2cWczSDJoWFNVdTZrOFZETVcveDhrUFVEclVWOGRMMm9SMzhG?=
 =?utf-8?B?ZlJxUDZCT3l0eHVYdmtrVllKb0tCNGRZeTIrOHJSeU1TV0diQ3VESzRBTE1T?=
 =?utf-8?B?R0FiVUhmUGVNbDdURGVkZGVUUGNUM1RQNDZKRGlUMGtseWU2OU5ES2Vja3hK?=
 =?utf-8?B?ZmFuUkl3SWc2UUVvaTZIZURLSFV3OXBxL1BwaWNMdkVleWEwN3R1aTZOQ09Y?=
 =?utf-8?B?cE5WQkxlazJiWUhBbit6NW8xWXh3OXlhK1dUZ2RRT0ZnUUZCVFVEc2Q2SUZH?=
 =?utf-8?B?YWd1VzRwWXpqSElQUjdQNzFmcHBZbHFBck0xOG9rcVpQWEc1Y3ZjTURyVEpy?=
 =?utf-8?B?UHZXcXJmdTZtTzc0TWYrRFBWV2t1NnNma2ovV01xUXIvVTRGY2ovL08zczFP?=
 =?utf-8?B?a3NIS0FYeXVRcVRVT3BtdHNrN1JPL05BV0NEbnlqVzlZWEt0bDBHSCtBb1lt?=
 =?utf-8?B?UjZISjlJblNiV3VMZExEUSt1RnNaeWgrWUttaWZPSFFzcmxtNzFDN3B3ekpL?=
 =?utf-8?B?VjYzVFhWV1IveFRNaXczMjAxbGNTanQ4bkxmNDFiUmZuU0tIRmJMajJPdmtB?=
 =?utf-8?B?K01VTDlXVVFlQlFYcEpWSVFvUmw0U0JxUjc5RXpsWGpCMHNIcGxwek8wNUli?=
 =?utf-8?B?U3puWHZkWjZRak8wenhTTm42VzlrdUR0TWN4WWlOMCt6SXU3cmhxUEZuRDhQ?=
 =?utf-8?B?ckl3QmRHNFoxdCt3UkVNMk80bmozY0lmMUd2NG4xZ1Z1MWsyZ0NLT2VaRUpq?=
 =?utf-8?B?dUdSTkVCSGppMFNoeEVMY2ljNGNnWWNXMXlHWE5UeVpxOVRtY3RiTU1PaGNQ?=
 =?utf-8?B?L1NUcUg4eEJEQnBsT1gxNHFQb2FMN0xVN1hXQXk0TlcyTXhBY2UvbGorY1g4?=
 =?utf-8?B?VUc3MThxamQ5Qmw0TkRhdnIzMlkrZlhnVnJoS21ldTVnZ0cxQmQ3RW13QzJC?=
 =?utf-8?B?aXRyL2tzaFJXczVEZHR4K0JEWXFQbHJQVVhkbFZtS0xvc2NnVXZGT3FYcHYw?=
 =?utf-8?B?UVhkRFdWdmE4WWcwbk9FaklnZUUxNytOU0hYdHlpT2h1UE41KzVYcDh0TmM0?=
 =?utf-8?B?bERmMHBHd1pZZ2QxS1hWNmdTa3ZaRDRGQWJINFQvTW9SdHV5N3F4YzM4VCt5?=
 =?utf-8?B?N25JWmQyc0F5N3hldzN3bUtZL3IyV2ZCOXdtbDJZNkZmdzFGc01KRVZlUFVv?=
 =?utf-8?B?a3A1QVFIRVJKWEpPQzdXYkg0S0o1TWhRSXRhNHJyWUFpZDZGbldCdXJxb3lM?=
 =?utf-8?B?UjNPdm1zVk1FNHk1aTJkc2N0N1ZkdERXUThmemlZdDBiOUM2RmZqcnUvdGhY?=
 =?utf-8?B?WWRTcnI3dmowTHczMjgvd2FKZ2JodmFJMmd1dlZoYXZDMkE0RnFEVE1FaDVT?=
 =?utf-8?B?WTFEVU5RWGRBOHJQb0xLMUFpNDMyUTRrcFU1aFY1eHJjQ1lhRnZNNURrOW1h?=
 =?utf-8?B?ekFLRENtK2hpMjZsbDA4M0QxMDFPTlFuUnZYMzZTemZBcEgzaDQ4amZTSUlj?=
 =?utf-8?B?TUJyOEgwV0NiR0Q4NjY3TEVXbHFZZWp0eWFGMzdMY3NRM0NTWnQvWVY5REo3?=
 =?utf-8?B?Um14M2YvTndUeVdHanFzZURNMWNua3ZoWHB0MHgvSm90elFzaHhNREJZTGc0?=
 =?utf-8?B?cWgvMWNWRmpxNGI5eGtIdnhuSWhCNE5FRUdldXIwQ0RXNGpsdW5rOUlueHov?=
 =?utf-8?Q?V5fI/gEKTospGf+w=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c08a5cd5-e319-41f6-4661-08dee636e743
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 08:14:21.6776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3f2OX305tsu+LqSWVp3XW4MZvP7AL1H2C5lhZcAHHRoy4eT0CeQJKuT66x8iNak4PjliuhHsSW15Fumh9NfTECrnQsG6V2TED33HSwbjnjw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5847
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 20 Jul 2026 08:14:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23673

Hi,

On 7/20/26 6:59 AM, Kunijadar Shivanand wrote:
> From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
> 
> Update the Lua version to 5.5 as the SWUpdate package in sid
> checks the lua script at /usr/share/lua/5.5/
> 
> Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
> ---
>   .../swupdate-handler-roundrobin_0.1.bb                           | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
> index e3cc7f8..3505a35 100644
> --- a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
> +++ b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
> @@ -26,6 +26,7 @@ SRC_URI += "${@('file://' + d.getVar('SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG')) if
>   # The lua version used by swupdate to search for additional handler is hard coded in debian/rules
>   # see https://salsa.debian.org/debian/swupdate/-/blob/6ccd44a8539ebb880bf0dac408d5db5de7e2de99/debian/rules#L13
>   SWUPDATE_LUA_VERSION ??= "5.4"
> +SWUPDATE_LUA_VERSION:sid = "5.5"
>   SWUPDATE_ADDITIONAL_LUA_VERSIONS ??= "5.3"

It would be better to pin the version for the previous version instead 
of sid.

Quirin
>   
>   do_prepare_build:append() {
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#23669): https://lists.cip-project.org/g/cip-dev/message/23669
> Mute This Topic: https://lists.cip-project.org/mt/120354798/1753640
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/unsub [quirin.gylstorff@siemens.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


