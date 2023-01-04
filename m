Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2C1C4332F
	for <webhook@archiver.kernel.org>; Wed,  4 Jan 2023 12:36:52 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.47])
 by mx.groups.io with SMTP id smtpd.web11.7897.1672823468247930441
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Jan 2023 01:11:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=LCrFFKCy;
 spf=pass (domain: siemens.com, ip: 40.107.6.47, mailfrom: henning.schild@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jnnlNukAvIjekKu5XRcy05yfyQWhjdQm0/MTwExsct1ET/kFWjU7GCpNSlYCEwO9YBc4RaXDKanlWTUt1YGuz2eoINZ6dTbhM7te+xS2esf0+Xztl00RP9Ea59IPJyWnhtZzsQRbugzRZMqDz7JIlHzXpsnWJ6A/bjWfMV0AeCTAdvCgvRWVhsX7slRN5R7jbtz+vLZjJ/IBGnTEmPDWRRpNcbZSKnsewsB5BBR4LtGBCBDYP31mOFhBkHKXt7DcGqqT747b+tAFGJFbJPvpbpjNxk852vuVTVMWC6N8quOOFsyji5Hguh59LqB03uuV8FH4pJSyWAYMeqjeQin5iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xj6h83OIOqlUF80DhFRW4Nxl4tIKFHFfovm5HPVu/Gs=;
 b=XBVctW2ncQ3V5oAPLcqaXXfql4HjHSqCVOQiV2By7hsXga1lwU/hXgVPx4xl6LvcRJBbOFP5QX8JLRHWqQSTKCPz+7e7hamCZtdTvE/oXbCOm/z2L/7Eh/wYk2xQ00RuupH9p5HQZ7/23UQ8ACYzb6c/GVc1xhlV6sfGhHGba2fdkDEWcaHGyaNLmzO1Wo4AjK+cWnpqvCd5xqRh5PY8AC1sGpjgRepbtzOV4p8AR1H5livb7cnrk4l79f8brxznXK1oD3UsX8q8gsFE3gAEjUWXxmlz7Y9NQRPmpfXivrIKTHiiWyffSyqtwOmb8EuFPrjwgoHF3U30igLJck1qqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xj6h83OIOqlUF80DhFRW4Nxl4tIKFHFfovm5HPVu/Gs=;
 b=LCrFFKCyyLywZxBO7o2hY2fJCYS2MoUL7rPMzXM0tmc2PTT6wqazvqclDf/TkN7jFtswk7wTXxuNDh1cOxGFe91oz8WcEJIg7L112iuBFIEl0P9GxuCeoOIXnXP8oJ7ZPZqDtHSjjcIMs4ujFn8nIqwkjKqiHFdsuS3YxH1yYxom3+XLbp5X++EBb9xai2lBObT4svXzURjT5H/jR/T937TQi4ZOzoPL7GliyefP7KxuZkzIw1tXtu/IZRkmn34uEOQ4PkxUM2huOJiG4SJdda0S9v0+gjib2J6oouJDyWpKo7fgEtYfsyEk74nGViLXPs5wwHMqgUl2uPVYJ46wCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by AS2PR10MB7348.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:604::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 09:11:05 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bdf0:fdeb:f955:bc79]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bdf0:fdeb:f955:bc79%3]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 09:11:05 +0000
Date: Wed, 4 Jan 2023 10:10:56 +0100
From: Henning Schild <henning.schild@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
 cip-dev@lists.cip-project.org, Wang Jing <wangjing@siemens.com>
Subject: Re: [isar-cip-core][PATCH 4/6] kas: set clear text root password
Message-ID: <20230104101056.1c4b176e@md1za8fc.ad001.siemens.net>
In-Reply-To: <192ab2ed-d727-0232-9e9f-41ec3c14d573@siemens.com>
References: <20230102170818.17689-1-henning.schild@siemens.com>
	<20230102170818.17689-5-henning.schild@siemens.com>
	<56ac1818-f754-ae13-ba5b-203d0a13725b@siemens.com>
	<20230103200854.79dbe287@md1za8fc.ad001.siemens.net>
	<20230103211812.1c3941f1@md1za8fc.ad001.siemens.net>
	<192ab2ed-d727-0232-9e9f-41ec3c14d573@siemens.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.35; x86_64-pc-linux-gnu)
X-ClientProxiedBy: CH0PR03CA0079.namprd03.prod.outlook.com
 (2603:10b6:610:cc::24) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|AS2PR10MB7348:EE_
X-MS-Office365-Filtering-Correlation-Id: c11b3f5b-44a0-46b6-5b59-08daee339ba3
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	8v9Klq/1nAGIl/KlNXknPBmt2Gn63bgeUu8zKeMTIgN25VfvcsOYrfRHrNImMVZGjsX6Xp7CUvV013A1Fpqxm5yiYoldwqJbWmPJxiogo/Swdy2xMT1gJG10k+MzS1uWCuvA/LRRDCxa56uLhqlLbJmyY7q+6FZVRjk4a+skdko72J69x8g+KLeO26u4VCFqI39ROc3jal/Slgnsdmoiv1EeqcBz7P1BqRW1uv1NwogcA6Fd1tCgEUI8ziY9Hq0lh2cbNTAcHkqPP86dnHOG/Ijd7kobjDmMhVRiPIbcrxF6qCvslkkhTFaVI7P99La8+fHwk+nKO2PFB3j9fc2cCNO+geeVOU72srRVbYBzPX+aRrMYq5Xm7JE4hJCmP2f0z1JAyaPaeUTt04fVNoB95nSuRpzMDOEY+wr9l4zOpE5soaLIX3ab0xx5IFvT/2M0ORsI0Ed+iKCtySoyu5IYXjTH2T1NvX46pwU9//jsVm8PFzuoMwyEU6ccoO5Z8mTwL6CO1ulRWzUPqOcbOvoOKrYea4Asd+yXVOH4A9DXnTLWEr4mesn8ykcqdrvHzWfAUDOUfKoHSCrbNOQ0UhlDaSjTG4VqT7Vtpc0fdMFteCHBNt08VWZy8cat4kdrTDvTeGZbsrURyWguD4vVg7f+sVMei0dz6nUtqaBBCuETmUsemm8l8pwWAMy+ess9RbkUW2VDjk8mNIWpDM52gMG4aA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(366004)(39860400002)(376002)(451199015)(6506007)(53546011)(6666004)(107886003)(478600001)(86362001)(82960400001)(38100700002)(966005)(9686003)(6512007)(1076003)(186003)(26005)(83380400001)(6486002)(5660300002)(44832011)(6862004)(8676002)(66556008)(66476007)(66946007)(8936002)(4326008)(316002)(41300700001)(2906002)(54906003)(6636002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?coLnHRKQp06tJgOv8nYIJ0+6OGwOhZqdkYMRC7we0kWbc1wKWus7d7puX/TO?=
 =?us-ascii?Q?+sVl1diwcrkYr9umzk1BKjf55tTawn6hfwvvS6OHi59o55Gaj8UqwnjuXtXX?=
 =?us-ascii?Q?R1ghHflP2HOzjTzslmiPbcEwHvy5B1HAFM4b/P4Ul/O799dCP6Nc3EXjFzer?=
 =?us-ascii?Q?DAZdc9SsoRy+fUekEXEIcmxSS/0MJvOVSXxG74+uCEpWqoshy8FRL44ACg7O?=
 =?us-ascii?Q?UzjUr19C4gCx9F0Ev01+qCzj2LcxIqmRB+4uNUVC/95b+Rj6Ajw6zO+e2Cuj?=
 =?us-ascii?Q?i2Cd2Why03LoDFvsUExf88OCa7SyetkPz7866nB6Y2OyZSHKFONCOZM3EAqA?=
 =?us-ascii?Q?zKfLuxOHrV988vB0+Pg+uxJJ65IC5QfPK4yLLBsMXW/5XQ3541ANkbjt10Rj?=
 =?us-ascii?Q?sYhx+Wes6/ItE/bsAHsR1BGjSlgfdFWJ4rFQMeaKSUwOjHQBL8nNTyjk5fqi?=
 =?us-ascii?Q?HeIs8rUyuFILl0tXhxQsNA1cKh16tDvc6m38eehlhNYOooGStl8ICcKoqdOv?=
 =?us-ascii?Q?ZXMNGnvi/1MfJkCh8Xwqf/06IresivOW4sDnUkyGJMegWrcAL2oWpFOLv4VZ?=
 =?us-ascii?Q?FTj1a9DOe35a5MIcT7AYzG1T+gXrkrTRlINFTVgujc2+2nHxsnMR5ahe8VY3?=
 =?us-ascii?Q?9P5j1t5t+i/yUNiAuUg1icq6PDjUf0HpEo3Gmh08slkA4ZgAob7dWClPWpFW?=
 =?us-ascii?Q?euSH+Br3+kbsQX/wL8HspQGWBFU1YVnl/8ig9Rdu4BdWf6zKzXSHh2xhy1g7?=
 =?us-ascii?Q?9U4+hlutESAKkwVmnniIQ5Fw+HkhMTgxZ8gykNEoMvqAQvsfvbwb7iUzXmE+?=
 =?us-ascii?Q?eoF0pVju61IeAnOQXRgnaMSBnzGhF3RGJlirth6m0znRP48O82ez5gnYQh9s?=
 =?us-ascii?Q?kjKKYs/abiSIo+Eufm8pFdZXFsoDS4e12o84PM1SmdQVLZaF+Oa/L7bPg1C5?=
 =?us-ascii?Q?0OShjNjnd5bBi2efaVa/Q7n4jnMEX7Q08wG5WKbTrDmLqutVOw3JjENRGbcZ?=
 =?us-ascii?Q?PT6dbAU1/VD0JKW+nt8HAv1+DD2BDEf79wQhoWry7W9DOo+TkxlaJ0AZzZE7?=
 =?us-ascii?Q?86dxsxSFOrKQiNCdtgATjFKV9Wj6GS5RRIYKDlcD4HGj/MMluhEb+2T2Vnve?=
 =?us-ascii?Q?lP9AxaXSKyiPO7bntcIIWVIlyzq+s8qVs4HppG3uvX/hR+gH+IsSMSpLL5a4?=
 =?us-ascii?Q?a5EJLc+EplJwAExKMhnJo+Yt1+k9k4MjAUSpCMfcTvur0I80t6EC3AV4LPbg?=
 =?us-ascii?Q?navShCwBhn1+0W5l6spkeSNkAz0hjDXECvF70yJ6weoGNWT6LlHo8PCOF/KY?=
 =?us-ascii?Q?COzlV0Ci64ATxC9UwJ7WdcyFcjFrIeyp7dScouQaLTvNY8zP5rT49wz5zZBh?=
 =?us-ascii?Q?CfhESnipmGFSknHuSwcZS7rlVOcUhTupCRgN0uoUB96EkvJ+n3CgdC4QqWMK?=
 =?us-ascii?Q?uqBl42w/qBoQEsqS0ki1jeluqphQn9VaFlttsyP+kX44qQRZC1AcXnTQoUeC?=
 =?us-ascii?Q?NYqt30En8X9eOQvkuoXalO5wXh5X7LuTlhOtu16Y60JOXBetVhhZk3mjzykl?=
 =?us-ascii?Q?OrraERuRlNKA30rEWyWkaz5PBfmw/7p7nrxbP4NQEqOYnfCFihZX1IScOjNZ?=
 =?us-ascii?Q?I23Qfig+JYG/l24D+yQf5zY=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c11b3f5b-44a0-46b6-5b59-08daee339ba3
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 09:11:04.9669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 59GaDo7HY71ZPON536yBmbNeMBSF6BywMSRKEE+bFw/HTwX3PVyaaX2bAO0+pN9YCWMurZYhflQbvYq+ZMjTJWh4iDIGEO8X1pmbN6TAGPo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7348
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Jan 2023 12:36:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10297

Am Wed, 4 Jan 2023 08:46:36 +0100
schrieb Jan Kiszka <jan.kiszka@siemens.com>:

> On 03.01.23 21:18, Henning Schild wrote:
> > Am Tue, 3 Jan 2023 20:08:54 +0100
> > schrieb Henning Schild <henning.schild@siemens.com>:
> >   
> >> Am Tue, 3 Jan 2023 19:03:13 +0100
> >> schrieb Jan Kiszka <jan.kiszka@siemens.com>:
> >>  
> >>> On 02.01.23 18:08, Henning Schild wrote:    
> >>>> The comment above the hash looks weird. Might as well write it
> >>>> human readable.
> >>>>
> >>>> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> >>>> ---
> >>>>  kas-cip.yml | 4 ++--
> >>>>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/kas-cip.yml b/kas-cip.yml
> >>>> index 10f4594334d6..b970f39ccb13 100644
> >>>> --- a/kas-cip.yml
> >>>> +++ b/kas-cip.yml
> >>>> @@ -37,8 +37,8 @@ local_conf_header:
> >>>>      ISAR_CROSS_COMPILE = "1"
> >>>>    root_password: |
> >>>>      USERS += "root"
> >>>> -    # 'root'
> >>>> -    USER_root[password] = "oC3wEGl799tZU"
> >>>> +    USER_root[password] = "root"
> >>>> +    USER_root[flags] = "clear-text-password"
> >>>>  
> >>>>  env:
> >>>>    DISTRO_APT_PREMIRRORS: ""      
> >>>
> >>> Seems we have some conflict now with settings of the security
> >>> image:
> >>>
> >>> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/3548200620
> >>>    
> >>
> >> Lol. It is not too important after all. Not sure which component
> >> there causes the issue. But if it needs to be tricked to accept a
> >> hashed short password ... keep the hash.  
> > 
> > So please remove from next, we do not need this one.
> >   
> 
> I would prefer to understand the technical reason and then decide if
> the current breakage is desirable, also from Isar perspective, or if
> we should change something maybe even in Isar to account for this.

Plain isar is not affected. But the moving the user stuff to the end
that we did in Isar a while back is related. Because it will happen
after pam has been hardened like in this layer.

> I suppose the conflict comes from something in
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/master/recipes-core/security-customizations/files/postinst.

likely pam_cracklib

The way pam is configured in that postinst is very questionable anyhow.
pam-auth-update would likely be the better option, drop a few snippets
and call that tool

Henning

> Adding also Venkata.
> 
> Jan
> 


