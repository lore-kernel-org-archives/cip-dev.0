Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D291C4708E
	for <webhook@archiver.kernel.org>; Tue,  3 Jan 2023 20:19:18 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.79])
 by mx.groups.io with SMTP id smtpd.web10.4508.1672777099966686147
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Jan 2023 12:18:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ZPOEbFhZ;
 spf=pass (domain: siemens.com, ip: 40.107.105.79, mailfrom: henning.schild@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SNNslr9oo1aXZj4qDhsePIu1q8TThKXyfTisXZScYqqYMm0Pd5nwP+VvETCmJCtdFxyD7XbHsQ/7UY13mH03DiLXG9K0HwY5FHYesrsyjkoeXg36EQB4QAzlhp5pGThaUGidY5abd77EoiTgWs95ThcpqxIzQCYahkZkrNMrPqm1quU/ETptTBWrNXFQ6oq3kA8/iAFPpqP6J4UZHvR6C7kYgfGt2Sa003dSHc89uxqKK9fZ/NWqSnyOfAlzEQGwibV5cHFRv7tXmHsfrYAovpqf5PoAYFR9udELzka7sc2dXCLLvw7u7+BOr4RvmGC7m5NesRzaZVG5d4d806xcgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJbDPUpZMH6fBm5kWjxWSuyl6cw4uS/5qAeJqMcjihg=;
 b=dN76+hsknafRSRXwrkVH79fATRA//R/Gyvdb6kqwQLjWz8KFitRm2OqOMbpYFrto0dbGSQPmjiFt4xedOxPgvMmYI5/W0pcuJu5LrOPb9+vFPONSx8x3hXeRCyQGdP0ZRm5yb8pg9bB8MgmtNU1EXrA0Ytgfd1mm3LAuONuE60/OZ7mIuTUMeBjQ8yFEFV2TwPtleqbOb3Fm7R/f8viWIonDcCeXCVX9eOg/C+QbgjbqycbkQRPoum7VS2LVFMQHw9xnbKs/c3tf2bInaiMfJGYFwwd/S53kxkKjYiduek9kIz6daNbIqGeNy0rIV9sP/thg2CXln1M1Kuh7XPzEog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJbDPUpZMH6fBm5kWjxWSuyl6cw4uS/5qAeJqMcjihg=;
 b=ZPOEbFhZakBOI1nnHIapn193TP1WrVPKcSyQ05/4zdjnZv2IuExdICpNHpvdqf3jIa1Jw73kXePPi5IKAJy2V1Eju66VosnMbqsFXb3zWKu34lpW2BaVygLLDSRePiel/PqADU/IcZs0xsltiTI35V5TEromaRWw339NNVGd40OHrZc5a6FpqrXtpSeAvI3pSPHK+gVH5TkjmCqoVGwAwnD1xfshw/NdoQldN7MZot0CfmtPFW8V7XPq80v0TYwWN17VKxyAYFidbyrvTqLyOmTPRd4EjkEqxV2DTxVBY9L2e2N8azj/Mg7DlGNDltKmlJBQBUiZz+xCdzV11TwOIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by DU2PR10MB7836.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:496::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 20:18:17 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bdf0:fdeb:f955:bc79]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bdf0:fdeb:f955:bc79%3]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 20:18:17 +0000
Date: Tue, 3 Jan 2023 21:18:12 +0100
From: Henning Schild <henning.schild@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: cip-dev@lists.cip-project.org, Wang Jing <wangjing@siemens.com>
Subject: Re: [isar-cip-core][PATCH 4/6] kas: set clear text root password
Message-ID: <20230103211812.1c3941f1@md1za8fc.ad001.siemens.net>
In-Reply-To: <20230103200854.79dbe287@md1za8fc.ad001.siemens.net>
References: <20230102170818.17689-1-henning.schild@siemens.com>
	<20230102170818.17689-5-henning.schild@siemens.com>
	<56ac1818-f754-ae13-ba5b-203d0a13725b@siemens.com>
	<20230103200854.79dbe287@md1za8fc.ad001.siemens.net>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.35; x86_64-pc-linux-gnu)
X-ClientProxiedBy: FR2P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::11) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|DU2PR10MB7836:EE_
X-MS-Office365-Filtering-Correlation-Id: 31a09808-7a8e-4a0a-eb4b-08daedc7a662
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	B9zQjAk++4bK1m/bm1ZaXA2BdhK00rhAMtB+3IZJKfjH4LzhdDLfXP48HfLBMGfeVSNZxkVDTtjMoK3e276HqKdKwEJ1U6ctjWlPRmgBSbPPz/kdzdW7MqYdSWv+G1AkaBS5gcPbIuGk+RUB0R4Si5f/1m6q53fdPDYzr4TstThIG0JxmlLhf0ziihu93TOZylIA0TFfGkC/U9iPE51JpGt7MiVaroVvAKbVtTZzMOG9iYWkAq4UMtbpuuQzbqMs91HNuPqwSJ2RcsxjYT6zpSqBqRmYRzVqRqdzmawxsVtNdYUhucrB56P0YA7XJipL5AtAMGZlxUlOrtLPq9L8eKzORoOPq2s+e7iHKlduGzwJWwqGQO5WTOp2MyowUFU3gpWpnh4236L1RoWBYz+xbQcG8SmxpATfqZD6DyO8hnnvXxLE3/f7fmHhaayKzKbgyGsumU+fgpcHqAeBBUTygXrMrB/svaOdYkVXUofkFzJlG4YZ5Qdhx5PS9aGn3GYzSzi8f6bu0XZ5MOvtFIP5xp+fMNn9Y9CAU3hHyOEkVT1LNPm0NaCUmYB6xqLzzNhT47x6qA2h43g1CQYePpydVMP92DmcLSM7U3mPYFbZFA3qchVHiJ+t3Tmc2i8xfejwckrK0tXAk0THhu/5nNbBwrqyOIzfO1JhTTYCeSwATtF2DQy2rbi67EK3TgM5xjrUGrLQIEB0ODBgEZxTSaChIG1BlY4ElCn1GP6byG+wL3Q=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(136003)(346002)(396003)(39860400002)(451199015)(5660300002)(2906002)(44832011)(8936002)(8676002)(4326008)(41300700001)(478600001)(6862004)(316002)(66476007)(6636002)(66946007)(66556008)(966005)(6486002)(53546011)(107886003)(6512007)(9686003)(6506007)(6666004)(83380400001)(1076003)(82960400001)(186003)(38100700002)(86362001)(22166006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?RTUxBMlqT6idnuzg4QlSc4dpSnUueRhXmqED3SPI9Mlwj2KmQcyagO7hRKQ2?=
 =?us-ascii?Q?Xb+qxKUdjj6Su0C3kTcPdBHCJjxfcNgW5JYHFeE5mDpKNYNPYG33AvXxtcPc?=
 =?us-ascii?Q?7rPMXJ5eeDo1WsXs3eYJfXuLeQMAVflMXawqWBnE33pnYyNM+8VwbwlBgC3A?=
 =?us-ascii?Q?zNFcHjwSH/Y21Ci28dDBTbWDBdFTYhDxlta7Nogdvut9Xzj1/KzBR7GQGiYc?=
 =?us-ascii?Q?VqsQFVj2jKqAZ1gTkyrMKNzlNwB1KvbYSuEX7HPYt5UF/JCeyEK3RjR4nuaZ?=
 =?us-ascii?Q?gR/jjBYp2iSy4i217bCbWAkOK4R6JbCCjtwjC+9OrELiBJOQmwpdPnM7VeO5?=
 =?us-ascii?Q?KqqDIBBzSrGJ+BizCLTbSVeTna0n3DT8O5mqODMnb09OK5cw0ge6KxLJ3d/p?=
 =?us-ascii?Q?AWdXyHFsEoE0N58kVS2S90B2766oqfWtl85ojhH95i/vREW4TbNST7JbHzjq?=
 =?us-ascii?Q?0gcoH5zchOlnsgf8Yhs1NufXzwNTwDvMa6nWmGLCIwIITegpGEWpE6U5Invm?=
 =?us-ascii?Q?ZhXRgxvjPUHu9s/DNfhNd1WBRliwKfQKQXTXeLrvlsB96IR+NWn6pPm5FQ0V?=
 =?us-ascii?Q?acEXdVPuUVzYaX9h/+pvYNzLA1u6DnEApNXiWAqCWQOzr3A259770s5nn6C4?=
 =?us-ascii?Q?pL8l73sZ/k4TFR0abUa7iM0khOpANuczP4ZxafUJl5u4v2CFISYTcm/CQg8/?=
 =?us-ascii?Q?2HycF9cDrlYpESt7dw18OAUSAg2B1zx0zHfZzm60DODI5Pfoh9PDkiBeYPD0?=
 =?us-ascii?Q?/HBCCzwfc0J1hmTR88aImPOdNSzLhszIOPwoLLFmLIr6pXvnsrobfOraPn/b?=
 =?us-ascii?Q?ZObVRcbWHMsWhefx/wzcaFG7vPH+SMkUcMNNh6VSLCCn/PL6Bd73RfKkpC/s?=
 =?us-ascii?Q?5E1aYPb8EIufW43HYzEjF+nDiGspmqNGrsRdFyerXOyrQ9seDcaSlsd/GDVS?=
 =?us-ascii?Q?x0ZdgZRVucIoVhDEGOii4ABolx+kQm9trNyAM5KFAsUzxJ8W6ORRPDLmaxkL?=
 =?us-ascii?Q?BPh2t4UClfAtfnjQMMsej8MR0BUQbmvvJ8IvnJwB3ZVWA85ThPV65kwgC63I?=
 =?us-ascii?Q?EFYzqckrEoRg2cc5vVJQSNfXOnEOdRd5GW/gQQPeyXHJVlUkW4jzhCDVE+kT?=
 =?us-ascii?Q?D2L1gfvGb2GBXJLR1fyA5Ha9cug9mWTnlR0WRwfq7XdygWSfYeaL6+iyspwk?=
 =?us-ascii?Q?dJt/nANxvGvaNk1eoD71wsyyr2Bw9CWO2knifbrdfKnemmIC2FPm1A2ayCJU?=
 =?us-ascii?Q?LAm96Z2UaUOxVQXq1eoFRebrM76yePtR1kmRpcWTtQbO/ciLdWqsgGBh++98?=
 =?us-ascii?Q?ymeS5YuVzB1FjAX1BSKzWcsYaNMeraB4NXPW0mNeIaQygmCS0wiA/eO+Fxnx?=
 =?us-ascii?Q?xj2QhMJz++4Dx4VstdyWxNf34PvgL7ONap2Kx/pa243PboAp7Op4km1Jt/tk?=
 =?us-ascii?Q?wduIdlUrktiu7Qwzge3QWfrWJQvSG0BkSmbaMlhE4s0GNHeLoSUC96Zzc+FY?=
 =?us-ascii?Q?H7+WmYIn1SF/lJCXwDdMTAaJoXf3roJQEOcSsTFlbv43bBGAuIBt/IkFIz2m?=
 =?us-ascii?Q?DBwkn0U4kEm+WYHVAgttvelFmb0wFttEKN+5/rFYhxgj4bM0/2ASGGLC3WzQ?=
 =?us-ascii?Q?YvHpsayXeNimd7/pddUISNsPi9oc63y2p254+D7m7sK+iAcIjlfP/zl52+3V?=
 =?us-ascii?Q?nsSXzQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31a09808-7a8e-4a0a-eb4b-08daedc7a662
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 20:18:17.3527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A1iqWQl5vgaKBygmBPZSeYJPrzuHTcsF0sVyqqVBbfTQc7Ah3VVKgQ02rnIAE8/8Bbj7cPaBB7CkjItFh5FPwyAwLFEbHEqdmJLUGTizLFM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7836
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Jan 2023 20:19:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10293

Am Tue, 3 Jan 2023 20:08:54 +0100
schrieb Henning Schild <henning.schild@siemens.com>:

> Am Tue, 3 Jan 2023 19:03:13 +0100
> schrieb Jan Kiszka <jan.kiszka@siemens.com>:
> 
> > On 02.01.23 18:08, Henning Schild wrote:  
> > > The comment above the hash looks weird. Might as well write it
> > > human readable.
> > > 
> > > Signed-off-by: Henning Schild <henning.schild@siemens.com>
> > > ---
> > >  kas-cip.yml | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/kas-cip.yml b/kas-cip.yml
> > > index 10f4594334d6..b970f39ccb13 100644
> > > --- a/kas-cip.yml
> > > +++ b/kas-cip.yml
> > > @@ -37,8 +37,8 @@ local_conf_header:
> > >      ISAR_CROSS_COMPILE = "1"
> > >    root_password: |
> > >      USERS += "root"
> > > -    # 'root'
> > > -    USER_root[password] = "oC3wEGl799tZU"
> > > +    USER_root[password] = "root"
> > > +    USER_root[flags] = "clear-text-password"
> > >  
> > >  env:
> > >    DISTRO_APT_PREMIRRORS: ""    
> > 
> > Seems we have some conflict now with settings of the security image:
> > 
> > https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/3548200620
> >  
> 
> Lol. It is not too important after all. Not sure which component there
> causes the issue. But if it needs to be tricked to accept a hashed
> short password ... keep the hash.

So please remove from next, we do not need this one.

Henning

> Henning
> 
> > Jan
> >   
> 


