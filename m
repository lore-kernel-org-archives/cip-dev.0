Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827A3C001DB
	for <webhook@archiver.kernel.org>; Thu,  3 Aug 2023 21:59:53 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.72])
 by mx.groups.io with SMTP id smtpd.web10.15154.1691070639130299045
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Aug 2023 06:50:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=R+wjqtIf;
 spf=pass (domain: siemens.com, ip: 40.107.6.72, mailfrom: michael.adler@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DexCDjIf7lSM3oWHhKMolEbcGlYCoIfv7BR8kmvGQNvzjDBzIpEQO3Qei9tvR3X8b3G4k/wG3lcnpgCjpZ7q6ImAmOQ6Q45sLcOe12l6ZQOJz+fdpnyFq2osAIm+MeXbBBDdj0QbBTx5mYliF373/W8gZ8YelsQmuMF0xrXQ0BIzLz9+8v6dkWZm9EKMEIlDnAsfvar42Cc0RsMJPrNPb3IdhvWk9hEKyiSPm/OI41nYpEqOzqy8Zroj7W1ZCtNTMnz0wF57JkwVwilk/p6YpNANgLrhIHAkPd1u8opFT2tgk37qhPziVfMBQVETWv0jRGJdFdoBSVJ9ndx82Uucvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iFv/1UnwizYaFLhgUtKFflrg8z8lq5Z12jZhHAgi+K0=;
 b=TcozSob/iJhRYVWtrZU8o7DPtt2qfCOeJfnGpDEBc1BQ722b9tM7PCz54GxmcdUKW163WIQQRXeilgzDyx6E8OBnX3U74xmCADgFf/bCoYFcuL5QiDZsEin1CzrbZJckuN2yf6ikmH+aXpQF6poaZTk5ztLwgHkZcaaV6FHqqZn/LcvzTAkzJI5kFO8qbMor+NfDZNewOeMH5/xN7fYzCB7pNAPki0t6pfGsJIvlqbG6DGmx497VS1Cndzw8V79tMf8o5AKNyYiRY+C7JOUIKn9Fj6+hfjLSgIUUYXP+89xWQCmER1QWTwVUy4RQCAJKTeR48NZEuM120P4RgQh9KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFv/1UnwizYaFLhgUtKFflrg8z8lq5Z12jZhHAgi+K0=;
 b=R+wjqtIfh1fFX1OTzF/Is2O3feormK791nayQo+7Bbyx31L8WNyG5oKZeAGTrqCiWn0VUuICypVmudLhrujp4tcBxSDgyP8vNZwLpmR3LebmcZ/3HvFpXI8/AhviUf0RQ6AToOAhTfi3k/EmOsk394Bze6H/vIQdivkM2RBxi7YhQMJ1y9NMRvaCIeINp0gYNTK9xhIOauCPYoB0dU4YkcjnESzn7UF0qK6ucO6QFWPDuSC4QNomZpKDZCCuscDzOmULta7OuSol4KekPeZmeNXpc+QnnuwA3x6rVryYeRASCM9iEp+cOaLa1eqVRs8eKJYI7ULJ/6qOAAbguaLCNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by DB8PR10MB3878.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:164::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 13:50:35 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9505:a6cb:9759:b1df]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9505:a6cb:9759:b1df%3]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 13:50:35 +0000
Date: Thu, 3 Aug 2023 15:50:23 +0200
From: Michael Adler <michael.adler@siemens.com>
To: Chris Paterson <Chris.Paterson2@renesas.com>
Cc: Pavel Machek <pavel@denx.de>, 
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] stable-rc-ci tests failing
Message-ID: <q5pupmrk75fuafwywd5q4io52r2xzxgnjtkeemmgr3wotkmscs@acv2be4t4bma>
References: <ZMoaWmwWiLQz+vNU@duo.ucw.cz>
 <17778648DB0D91E2.2497@lists.cip-project.org>
 <TY2PR01MB37881707081B7D70710B10BAB70BA@TY2PR01MB3788.jpnprd01.prod.outlook.com>
 <20230802125753.4d2e6225@backstein>
 <TY2PR01MB3788D79592068F488400767EB70BA@TY2PR01MB3788.jpnprd01.prod.outlook.com>
 <x6gtttscicyj2tuy4jbrdjk7s4c5idx52gjmf2ussf7bey4kcm@rqhxeuxkfk4j>
 <TY2PR01MB37883202516D8EC3512F1FBFB708A@TY2PR01MB3788.jpnprd01.prod.outlook.com>
In-Reply-To: <TY2PR01MB37883202516D8EC3512F1FBFB708A@TY2PR01MB3788.jpnprd01.prod.outlook.com>
X-ClientProxiedBy: FR0P281CA0083.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::18) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB4734:EE_|DB8PR10MB3878:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bd84fed-b1b0-45be-edb4-08db94289ca2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	8zqN8aWYYWFb3LBgZFPw31s31POGbcwcAf8J3dnzN5JzvfXjRIqGn1TFqpGN5zelxTK3wny6uJbjNnzzHBqHFs7lCTehQgpCHyRUVHf+oSyuMQh4u4I3WdfTWDa0V1yoKgWmIQsK0+NHUloDZVqQmAKClOuimp0L7hNfsx6IRMv8TaHwrXha5wU/yoqBKiKdN3JFvf1xcwLhftRhHrngCseAYQE786NzvcitEwagTZAC0oOiDmOb2GjWGLbR5QUHXnMUv6pHkd46nh7Cw7sD8/YDxTBwo1X05uPtgbyYYjauUhX1v681K86ujD3Hz1lswvXfMyBLz8wX8h6dlJf7ziYTGUkEiGH6BXXhrJQk/fGUVD7A0EOBlATqqlHIY5DvhkfNGKjuxuJe/zBIy+wJFrjezG00svq53CtEv0a+0CCdS0kh5EqoSFdhtGzqo4BHAtXEydJ22HxsjoTMfiJz/xc8FkSjam2qhAz4rcgGSYdUD5a2FOtjOFyUXNyeD6M+oqg0vEgHPRxCxcRB/SFakyD6aSL7lBIE2oT6/TpyMT4NPPUG5iI0P8vMTze1OUty
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(396003)(39860400002)(376002)(366004)(346002)(136003)(451199021)(33716001)(86362001)(54906003)(478600001)(38100700002)(82960400001)(41300700001)(186003)(26005)(6506007)(8936002)(8676002)(44832011)(9686003)(6512007)(6486002)(6666004)(4744005)(66556008)(6916009)(5660300002)(4326008)(316002)(66476007)(2906002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?XRXVW3I5fZVgDs2Y/2tupnn6DRlk5vyrfSO2KtAKfJ61MAfIXMBsMmiNQh5I?=
 =?us-ascii?Q?BFviGvqNNYNLBoQsTKXUe7/W5HIWRROzYIQjcH6pzjsy7CGGeU/osWw/dh4F?=
 =?us-ascii?Q?QaW4dGHwFwOX1Zt2MwULkFpIdNQ8ihHN2Y1C1Mu17fqcGUB3b5e9OPXjZW7+?=
 =?us-ascii?Q?e6HYt0Y4zqjdG22ERFUW9+klaTmKHEMtgxu4As1qrQHDi3RsjZFwuKahL7Jv?=
 =?us-ascii?Q?7+m/OEjmhVTnLbKsX/qKYO84KPRRRuHszP0lZWlwBIu63emCFWX08vsvKsKj?=
 =?us-ascii?Q?72xExyo5mhTSEg5S8c2F/ooUaiUON+ZdlpX+WtDauOzwK5inUdcgui0V65Fv?=
 =?us-ascii?Q?pZ7nhPjzWdCZJ/Fptn1Rd5gTKaR59Ak3VErzK1P4ecuA/+TubrRdcch3RuCS?=
 =?us-ascii?Q?t23UUN6mBC4zlJYz8C+TG/H1nuhI8e/TKjBElSZJl6sFWTdy/YtKnlY3pJ3x?=
 =?us-ascii?Q?zgmbkI1jAYy0Nfeb89LQFxOU0xG2wrZWSeWOX7BN8sf8xWjZbGbjJo9suNmh?=
 =?us-ascii?Q?1p2xexwtobbyWNX3SoL3KNY970c6lzrk8DaTRWooh9tUeocVbfVGHB7ZmoO1?=
 =?us-ascii?Q?ZO1vIdbRva9kNBMQ5Mzrd3jBX8AoZKIUSmCsPuNFg+Rfq/2B6kBvVGgLqgos?=
 =?us-ascii?Q?+//b2YftoDysRDHUciOepFAKlieUzZl1c1Gq4K0M4dPTHfrDWBUmA5/d+BNt?=
 =?us-ascii?Q?PH2qOdYQ+686CF859H3JqtzrjMqu7r3bqU7c07cpE14MIPVLs1sO7rKbpDvi?=
 =?us-ascii?Q?VW5kwqCcuEik7oEvRm7yPYid+gl6G6rTO16uGrZmD+4sPDC65cFL33u9hzNA?=
 =?us-ascii?Q?qXWf6UjGooVHcHs6pOSqO7/HnDOZbINjJpfRVMiwhpvkxcul24ukppvoeccY?=
 =?us-ascii?Q?vR/pvq1C1Sy/r6QKcjVcoLCeW0V/4hWU2HASCBi+Def3OzO8d8h2Jv/88tbA?=
 =?us-ascii?Q?IA7gnO5FAXUIwS1UuUivovq35mdEpV2QmyBBniAHpn7q+I6zeQeR9sjyhogq?=
 =?us-ascii?Q?0pzghAMj1xhuvhwfqhVSOx9Ky7AcOCEB+LU6/VMuoIthHf42jHsI2zuupOM/?=
 =?us-ascii?Q?ZMY8SByXTSzr5X7P3knt+ugtgH3sdtH62ziMJdtB7eURc6WAITASFCR5ROGo?=
 =?us-ascii?Q?BWjOO+wRtoAjFAP0UmpzaRxIps2lq4YPWUuO1A2JyAiWznGfRnUvoSiETEno?=
 =?us-ascii?Q?INgg8hbCHIuaLGkzlPzPunmGS60rpcNHc6CPifHzd3GwGmU+b/ra0D3Zq44p?=
 =?us-ascii?Q?JudksWk5lwprZoqQ5isdTWeGD0FO+lbUAKwxUY2UGT4D53/BVMbvwAmI9af6?=
 =?us-ascii?Q?NeQo9rZ68QHYqjGtAMUNa1W/s0SLqaqhVj67Y4I7gO62prwfphw9d3IzmXtw?=
 =?us-ascii?Q?1pWlsw6+fM8TcDRowhoHJNM1uoGTDfynur34o2Pwep7XdsawWBy8zgop53RV?=
 =?us-ascii?Q?PzTEqNkn3Cahb71Zv8rSMWBM5zFK+Z1j2j58cp119dDdo2wrAq6fFcaH2+fm?=
 =?us-ascii?Q?0Tc3KLP5FbmQ13R3fPJWr9kCJswfot5UOIlFgJzR8HKy2J6rfdKgp9lDGjF6?=
 =?us-ascii?Q?ccQ8BbiVkG2BB3B6cbjRgtw4rw8w2Ceb2eg1kCmhiGy9NeYtCzGRsq1pwrfa?=
 =?us-ascii?Q?/A=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bd84fed-b1b0-45be-edb4-08db94289ca2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 13:50:35.8012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lfl3X7z4FpBWfGsHL8sC/EVRrRSDAqQmK1IX+iOz2b/0fqvHQQJyKN/vOeK7unUd94iKCixuTJJGDlkf6V1Aky6RXdT5LgTQSDlAQWDMS4E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3878
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Aug 2023 21:59:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12549

> Is there any relevant text we'll see in the GitLab CI job log to indicate which region is being used?
> Or can this only be seen from AWS?

This can only be seen from AWS. We're using zones eu-central-1a,
eu-central-1b, eu-central-1c for the small cluster now.

Kind Regards,
  Michael

-- 
Michael Adler

Siemens AG
Technology
Connectivity & Edge
Smart Embedded Systems
T CED SES-DE
Otto-Hahn-Ring 6
81739 Munich, Germany

Siemens Aktiengesellschaft: Chairman of the Supervisory Board: Jim Hagemann
Snabe; Managing Board: Roland Busch, Chairman, President and Chief Executive
Officer; Cedrik Neike, Matthias Rebellius, Ralf P. Thomas, Judith Wiese;
Registered offices: Berlin and Munich, Germany; Commercial registries:
Berlin-Charlottenburg, HRB 12300, Munich, HRB 6684; WEEE-Reg.-No. DE 23691322

