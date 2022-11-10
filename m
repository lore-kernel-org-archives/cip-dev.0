Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55202C4332F
	for <webhook@archiver.kernel.org>; Thu, 10 Nov 2022 13:52:51 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.45])
 by mx.groups.io with SMTP id smtpd.web08.7581.1668088364123451870
 for <cip-dev@lists.cip-project.org>;
 Thu, 10 Nov 2022 05:52:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=tOSFbrAP;
 spf=pass (domain: siemens.com, ip: 40.107.22.45, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GKFTGSTqftuLcGWM4Z5vwLHvT3xBWhJ9+p+mVqfGoL5RubSOyvVGEKmNkfoByYLftvyryTxIOSYw29D2SmxlNTz3ChJALpCyvwPv30I6zfe9XlNl01nPA4HGWUuYAyIOkW2jJo+JK+KRvpIX8K7b6I47wMB1iJzMHKK28pBYJbRZxYzvP3g5Nb+zByWpl5MPPwKPi09tHOjfyIkBnR+k5w1GGOz2eAJ/zIgGFCb3+DVEH1tdYfk55AzqA9shf89VbVXanzeaaXuie8Hi4AExTnk7EVDSFUg0HMWOeWiGBzHr5mLoxiyeo/cJS84c4R7QfCTP+pdb/eqagnTHqUUHSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MtH9y+wKwQs5LDqdfWfIv/jp3yb9VREAdT4qqWmep/Y=;
 b=gSlZ0KjOLeGrpZerAgTHhM6B0/IfIuuE4hMVQkFDwPpIPjZVisABXNPezVe8NGADsAFhZxqGYdPp0ZS/yhLQx7Krl2+j0tGTAOU/fWNCmigbaqkZEqpR0cqN/7nEpRAiAD0ZouWKUY1n8HtLtJiLAQtzAinuIXOnOfIM9kAqenSTLTqIR4B2fRx/UDieb4Us3aomtmuJwz90xpcUlKGNK3reQCKxb6SPspYBXwwW3iRTcqNdScPmyCaaf029Gq3aEC6lgU5TEc8TsuZBktLn+NuzRNW3xg8WtBfXjO6fhlQReeIrsMyoEPf/8RUMUpNHs80lKieRkkmsxF/vOe7nfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MtH9y+wKwQs5LDqdfWfIv/jp3yb9VREAdT4qqWmep/Y=;
 b=tOSFbrAPjWd/p6Qms1nN1P+IFBgh+0TbllWXO1/s0Lcp1wpoSYS0DXtjxo2rXidihwYPkUhbHNC8kwxglKwwuDoSbaZUt5D2C+/EIrUmqHac9wZ/asVGOYKPeX1QO7LcZ0gpAWbWbSNmT4HwpVPicg9MZod4JRKTu/iKaQ74ccdjBXITl9VpAyvVGW24Xh34JhHoazEZ5/dSxyYBAyh+rUkrgM7Kr/C7QP/xWRfXpHFWJTQMkSX6KpSo8Knp6OWJTb2x3g0BnKLViwbYu+fDHQoEk1y81NR4uPqAO0mbulhboDqS5G+lndqhZRnjyh9IfM6eJLF/4mxsfjgxqh85zA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7075.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:422::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Thu, 10 Nov
 2022 13:52:41 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5d9b:b9d1:bd69:107b]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5d9b:b9d1:bd69:107b%4]) with mapi id 15.20.5791.025; Thu, 10 Nov 2022
 13:52:41 +0000
Message-ID: <a175683d-f5a3-34ba-fab7-5014d019dc21@siemens.com>
Date: Thu, 10 Nov 2022 14:52:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [cip-dev][isar-cip-core][RFC 3/5] swupdate-handler-roundrobin:
 add uuidcheck patch
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com,
 christian.storm@siemens.com
References: <20221110124503.274124-1-Quirin.Gylstorff@siemens.com>
 <20221110124503.274124-4-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20221110124503.274124-4-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0082.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::21) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7075:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ad0a158-431f-4455-9134-08dac322d5e1
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	he8uIq0jtZXeUq0nrB2fa88UYcdf1aNw5K6yfM6JMGVRsx2EfdgCFVJYfkL6P324iQMF3Dq0KPhJc35y0t3k13U9eboUKM9CCM84Ppq7IIDpivJhiyGZJEgltLKRmFVGi3OJhyitwt/Q1WLC/QnIYS/v2nt84J/FMLEjDFqAOuBfPxFof5FWw9MXeREYshhgremq61MWgk5YlRVpStlEplSKEaD8aNuJbQOUb9Ky57ywXbVXkZAMz0Z6mr/h393pTFF691fBwrVyCCbOrDQhtBrhJngG+U83zJaBYgADB4lBO9vks3Q6Ao8qo/VsxkLdAfJB6KnaCkyw5XcW33uOc9lYaxcXVNqm8+LQAwtCYoNn8aum+YxlznfZPAwbBic/wYv/BXuECE+EIQzBXMzp8tILCo1lhkk7Yu++XGtj+qDskTuxazVfVA2tl7dhEhQHHP+KqGuNo3boEiBPUBGy6k7xDTPIU69yhH1aV7v+2J4xZV7genYtjSRuzKlVmpWabL2FS7AwBHDXZKaI2MrHOcAVsaXhKW3Omh7FKiorNzs/WZgJcTUXsyOR/Db94BHGX8fgO2TnPdbZGvZAjW/C+sioe7mOmEoZAfhjWPi9HIxYnd3LSMx47D4mVqh3Dotmt9vq6KqkNBS9Ekoql67n/HHc/SRmt0D6PE2VK2J836E/Db+ysPOpi5opy7QyX2qy3u7nb/39p+BrpuFaAQGPzdw6oOSbpdu3AdjD4+cba7A5uT7dDgh77/9iNiwlQr5L1E3L7D3slkxzleJL7JlMFri02MprmDrJdWXZt6RFJ9s=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(39860400002)(396003)(366004)(376002)(451199015)(8676002)(44832011)(2616005)(316002)(66476007)(66946007)(66556008)(6636002)(8936002)(5660300002)(83380400001)(6506007)(6486002)(31686004)(2906002)(41300700001)(478600001)(26005)(38100700002)(31696002)(86362001)(186003)(6512007)(53546011)(82960400001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Y1czUk1mUzdCRHE1SlpxVVJQb1pOMnBWZnVZZXNlY3VUdG1IZEEzVWd0bDht?=
 =?utf-8?B?NUJOMmdEUEtlTlNWTUR6UzhmTkZVci9ESlBDY2pESHo4NmRlR0h0cDFIVXpI?=
 =?utf-8?B?NUQraE1QMk5iRDRPYWsyZHhMZkFvWTVuclBvZmJvRCtDQTZVNVROLzc3NStk?=
 =?utf-8?B?LzJ4TFZIUXoyR0grWmxuRjdoM3BOeTRKZlNhbkw1VjRJMjFVNXVKVE4xejQy?=
 =?utf-8?B?cEhRMUQ2VzUyZkFMRzMyUGxUemIzZTIwUW4wV2dFUUY5OHlEYjB3K01FT0Vz?=
 =?utf-8?B?bnZpb24xS1kvb1U4Y1RPb2QydzZzaEN4VmhCUlVzNHZBNjFaVVB5OHk1RzR3?=
 =?utf-8?B?K2lySEY0TWhJOHhmQTBoZ2RVZnI2VEFjQVhjSkZ2RHFrTklodFFMVXUvSWlx?=
 =?utf-8?B?bTI4RC9DR1VwckZDVnp0dUxoQlFmTmo5cklWd2lLaFp6b0hyZlBoQmNQVEc1?=
 =?utf-8?B?Z3RJYTArdXliOWxSK2RDVkkrTEpNZVB5Q0FpNDJIellaZ0hVeFpHK29nOHF2?=
 =?utf-8?B?aFN0eUU4MGRLU1ROOUxMV1JpSG1BOXhYVENiSEVVOElJVWs4aS8xNVBqMnV1?=
 =?utf-8?B?UFQ3TDBYcWx1Qld1blQyRVczeWkwMnQ5Y0VUQVo5dkdpYTdZTy9oR0lBYmN5?=
 =?utf-8?B?UkZSaEtGWGJydW1uNGJ1VmVMKzVLZVJURlJ5R1MxV0xqUXNaMVp2eVg1TzJF?=
 =?utf-8?B?KzAyREdSZ0NrbzN2RVpLR3g2T1l1a3dMejA1UjZpcTh4NVdFOTB0Q2RtdUZl?=
 =?utf-8?B?K3BLcHJiLzdlcVpPSmo2TFZQenM0T3Rhb05xVDVleERwWWFobG1ienJOdUZC?=
 =?utf-8?B?VUVGamRqL1Y4VEgrcnN6aGM1ZWZjMzFOckF1WnhuY2ZHMEE3b3FJYkhZaktw?=
 =?utf-8?B?clAvTnhXZW5UbDFuWU1zd0haR1ZPdzRVMldmTzZscHE2TUQxcWU0US9Cb1FW?=
 =?utf-8?B?VWlsSDNhN2EyVENMaEVZR2FJMW9BRCtjcEFkaHZGZjJ4WFYyQVFXNG4zcW10?=
 =?utf-8?B?a3c1dU5acUw2TTBObWRJWDNkQWhDUmh1WERLYko2NTA4VThDQk5sWCthWENE?=
 =?utf-8?B?L3RyQi9lM1ZWU2pvYzBWbjlKY0JqcVp1Z1QxSUw0YnFQVnV6Q3YwQmYwMDlF?=
 =?utf-8?B?Z0lKYmZGd1hkTmJUYlFIYmNMYWRkNXhBRDFPazRWR05pNThIMDc1MDlPQlND?=
 =?utf-8?B?SDJoYmcvVU84dFlSRjBJUHRuNzVHcTlBd2UzWXg4UGdJOGJjaVpMMG9YNEs3?=
 =?utf-8?B?K3FiaUZSR0NFZGtLWEFDaWpseHdQNE9FbzZrZ2Ftd3hDQVVtT0d4QnI5SzQv?=
 =?utf-8?B?QTVFZWVmNnJCTStGSnQ3V1BtNFFPUm9XQXh1QzA0Ryt6T0Q2ckpLNDdZcDVD?=
 =?utf-8?B?TVVlckFrR2VjWmdlU3dHdXpkZTdFZ21zejNSUlR0cnVqSWVta1d1T3dpN05U?=
 =?utf-8?B?bXhSdE9xYlptWTI2ZjIzNy9XMzIrZE5DQXFUc2NDZGp3S0p5OElZZ3JKSnFZ?=
 =?utf-8?B?bUhRR3hVb1dIVjFHTTZERGFHZzdabEMvUnB6U0c2aGZNV3dGNXpQNVh4SmQy?=
 =?utf-8?B?VGEwZjAxVGV1S3Rwci8zRnQ4UHV6R1NpMnFQN2pxQUhlU3VxR2hKbnplZkEr?=
 =?utf-8?B?MlAxS1BUN2V4dk9Lcm12QkdJYXFucW9pR1AwZ0ZPdGZSQ2lsVmJLRHR6Ymx2?=
 =?utf-8?B?SVFYUHFrWjZ2L29SOGpTSGNMYnJDRTNkV1JLekFSK0tHYy9ya05Sa0xudmlz?=
 =?utf-8?B?L0laZEpaVmpad1EvWHowWWJPdU8xMzNscXJwKzU5dHRIZ0VGbzg4dXJMOEx5?=
 =?utf-8?B?WTVJd1d2T2tORnNhTmtaT0M3MlprL3U1Z0VVSS9sYnNQMGxZa2VrZDFQT2hq?=
 =?utf-8?B?SVZxYjFFUEE2VnpPcm5yR2t1TzdhaWphVklsSmNVVUxMZ0J6cTd2R1VjQ3JM?=
 =?utf-8?B?b0c5cmJOa3NPNEN6VysxSU5ibHpOQnpOZEZsRjV0V3drVCtRN1RmY3pRc0tJ?=
 =?utf-8?B?cUQwc1ZpNmxtNTlnS1hid29FZjJjdGFscXZ2UjFjWjRUYW1uZVBZemFvMkdu?=
 =?utf-8?B?aHF1dk9NblhyUnlnV1BvZk9PSytBWEQ3Y3Zvd2Y4Z3FkeGpvTjhpZjFyOHBO?=
 =?utf-8?B?Z3hDS0RlcjdiaHp6aVZCMU5URyt4dUZEUElRS2lxc0c0VWpiYStjZmd5TTZB?=
 =?utf-8?B?K1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ad0a158-431f-4455-9134-08dac322d5e1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 13:52:41.1917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XKGA4aMLDmUP4TpG+y6jW9NwUnMsS5EhB1JYbNmzuYtKCfQpSDCiaFAJW2lswP64ZDquU4oOjF21+FV6iKwDfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7075
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 10 Nov 2022 13:52:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10006

On 10.11.22 13:45, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This patch adds a pre/post function to the swupdate-handler
> roundrobin to compare the uuid parameter from the sw-description
> with the uuid of the current system to avoid a updating with
> the same image and breaking the update cycle.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  ...-add-uuidcheck-to-roundrobin-handler.patch | 43 +++++++++++++++++++
>  .../swupdate-handler-roundrobin_0.1.bb        |  3 ++
>  2 files changed, 46 insertions(+)
>  create mode 100644 recipes-core/swupdate-handler-roundrobin/files/0001-add-uuidcheck-to-roundrobin-handler.patch
> 
> diff --git a/recipes-core/swupdate-handler-roundrobin/files/0001-add-uuidcheck-to-roundrobin-handler.patch b/recipes-core/swupdate-handler-roundrobin/files/0001-add-uuidcheck-to-roundrobin-handler.patch
> new file mode 100644
> index 0000000..f2392f4
> --- /dev/null
> +++ b/recipes-core/swupdate-handler-roundrobin/files/0001-add-uuidcheck-to-roundrobin-handler.patch
> @@ -0,0 +1,43 @@
> +From f093a3a097e518ef9f74ff88eafa9259ba50626f Mon Sep 17 00:00:00 2001
> +From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +Date: Tue, 8 Nov 2022 16:08:25 +0100
> +Subject: [PATCH] add uuidcheck to roundrobin handler
> +
> +Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +---
> + swupdate_handlers_roundrobin.lua | 22 ++++++++++++++++++++++
> + 1 file changed, 22 insertions(+)
> +
> +diff --git a/swupdate_handlers_roundrobin.lua b/swupdate_handlers_roundrobin.lua
> +index bf9c997..bb24fc7 100644
> +--- a/swupdate_handlers_roundrobin.lua
> ++++ b/swupdate_handlers_roundrobin.lua
> +@@ -726,3 +726,25 @@ function pp_mmclock(when, device, image)
> +     swupdate.info("%s: %s MMC device %s", logprefix, when == WHEN.PRE and "Unlocked" or "Locked", device)
> +     return true
> + end
> ++
> ++function pp_uuidcheck(when, uuid, image)
> ++    local filename = "/etc/os-release"
> ++    local filehandle = io.open(filename, "rb")
> ++    if not filehandle then
> ++      swupdate.error("%s: Cannot open file %s", logprefix, filename)
> ++      return false
> ++    end
> ++    osrelease = filehandle:read("*a")
> ++    filehandle:close()
> ++    image_uuid = string.match(osrelease, "IMAGE_UUID.*")
> ++    if not image_uuid then
> ++      swupdate.error("%s: Cannot find IMAGE_UUID in %s", logprefix, filename)
> ++      return false
> ++    end
> ++    swupdate.debug("%s: %s", logprefix, image_uuid, uuid)
> ++    if string.find(image_uuid, uuid, 1, true) then
> ++      swupdate.error("%s: Update already installed.", logprefix)
> ++      return false
> ++    end
> ++    return true
> ++end
> +-- 
> +2.35.1
> +
> diff --git a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
> index 65cd652..447a093 100644
> --- a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
> +++ b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
> @@ -13,8 +13,11 @@ inherit dpkg-raw
>  PROVIDES = "swupdate-handlers"
>  
>  SRC_URI += "git://gitlab.com/cip-project/cip-sw-updates/swupdate-handler-roundrobin.git;protocol=https;destsuffix=swupdate-handler-roundrobin;name=swupdate-handler-roundrobin;nobranch=1"
> +SRC_URI += "file://0001-add-uuidcheck-to-roundrobin-handler.patch"

Can we upstream that directly? It's a CIP sub-project - should be doable. ;)

>  SRCREV_swupdate-handler-roundrobin ?= "fbc8d8a7e4ae8c381198cab81ae3fb13398a028e"
>  
> +S="${WORKDIR}/${PN}"

Unrelated or even unneeded change?

> +
>  SWUPDATE_LUASCRIPT = "swupdate-handler-roundrobin/swupdate_handlers_roundrobin.lua"
>  
>  SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG ?= "swupdate.handler.${SWUPDATE_BOOTLOADER}.ini"

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


