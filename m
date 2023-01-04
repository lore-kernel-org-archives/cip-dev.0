Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBB6C4332F
	for <webhook@archiver.kernel.org>; Wed,  4 Jan 2023 13:10:43 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.51])
 by mx.groups.io with SMTP id smtpd.web10.11386.1672837380210105341
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Jan 2023 05:03:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=f5pwO0XL;
 spf=pass (domain: siemens.com, ip: 40.107.21.51, mailfrom: henning.schild@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iMeONNRylnzrDZGtvSZ97I4m6HlPH6acKPrZdgN37BiD7ydskyanH/nohDPoSAEwJ8tyUS3+vqknY5T/6jsI9jDmMEU5HvM8QANvUbfPQ8xWTr2PTUziqsi4DiWr66+/q+gDBkYMhdl44w3C45QILOi6Y1lpuNYffm9yJ2t0NQt3HS7uz84RAhiN76JCIC7Zsi5N8z9revh5g7Rlx8pXng3Mv2JENj2vbjIoyqVj5X9zZEj6w4wqba91qXvkfkJ0dG5XAR8MJi9a/jKJtYCg8NnVwYJPS3FqeQVl0MU3Lrpcxq/WD7Et4M1fdgPOftnd52THiyBmEcEKNuqZwZeMtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=da5t9XOthJYep9t6JgITK1zBCIP4LzCoNgyLhMKP+yE=;
 b=fqvmpERGBHxm9KossRAdpAgXSV0KKVCCySO3vjVbYilCXaEJbtHNLuyLS336A0X4hWcJdz1z6o/WEY3VLIwwYUsZP/00hlxqyNZZ+dWJbO+mCY/6uz3Pz7AdQK/2ent8tgY695enONMUBbuve3t9qe7aGmSg4gB/5yG+aE+Z8vNdgWdLY6i9sqTuHMEztTBvujXqJQ6xkcF3o5Ma3AXKoH19HcZU56/w5N2DHE+wEXKP6yFZ1qUKkNgm9FPLFxaF1aSxWty7J49XCNuEsUA/K9N3mxvgClO/ZSH8AeMHRh9qAn3dnJ/j+73jieXMGnzx9F5XjQ3IP3kjYXkHNqWVng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=da5t9XOthJYep9t6JgITK1zBCIP4LzCoNgyLhMKP+yE=;
 b=f5pwO0XLShGgIiTzPxDyKoOpMeSQMEWEScPd+t+5i5YKSs8lF8xOmDCRBHap11ZBAVQsn8bFHyoNKUSK/QW4XbLz3jkky+Qlv5hzXoNryGHpm7mBfA7gNX2Zk8FazsB21kBLJZFux79646i16cv/KQ90D5n38diB8PMWbkrnbPoP/RI6KB03Z0KjGHPiR+lCyCxODoStfl9weFwXRyQv4wE1qdWc9yF2EB1v1Y2SBQ7WOvGKvV18o9FIALd1yk+jt8Fcs+YjDv+QVLJ5AuuIl4Gl2dXIbYgDHvP+MGEwx757oOfUoG+uGb8dres5nbNSLbwQIT/SxDctJ66wJy1T6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by AS8PR10MB6746.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 13:02:57 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bdf0:fdeb:f955:bc79]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bdf0:fdeb:f955:bc79%3]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 13:02:57 +0000
Date: Wed, 4 Jan 2023 14:02:51 +0100
From: Henning Schild <henning.schild@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Henning Schild <henning.schild@siemens.com>, work@hennsch.de, Wang Jing
 <wangjing@siemens.com>, Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [isar-cip-core][PATCH v2 0/1] root home dir package
Message-ID: <20230104140251.52df8822@md1za8fc.ad001.siemens.net>
In-Reply-To: <20230104125103.9089-1-work@hennsch.de>
References: <20230104125103.9089-1-work@hennsch.de>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.35; x86_64-pc-linux-gnu)
X-ClientProxiedBy: FR0P281CA0138.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::7) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|AS8PR10MB6746:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c0afbe5-c7e3-49e6-257e-08daee53ffd4
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Agl3oCHfMpxlUZwOLgW02HzKa9T6lBRj1aGCyboPbs7EPM0oy1/cDzBJgvYgbUZm05zg3f/NTsaI14akWcer23IuX4OUamNpQp1OUOqSx8dNp7LjUWMj0xyETRNMEEgeLNuzKoq3dSn2HRHM55etEq2ziDtCOyV7DJSLLKMGGOlDgxCjfKli1ZddOp+6FdYNsWIi+Ogcw2wO1pZ/uAsb7huTjh/Uk3po4cehiGpLvOzfD8f0NkDxzMhEbuZ0dBo322rQp4/Ac3/5oYyBuVLCT6me4rkJdd9Xpxnn2HsJABF55XATCicXhXMQXmCHkBB23AyCUdfOp3Qe0pyYb8R5WSfIZP3n3CpuvMfJWrIT37UjYFjeHSN3h+p5bcohSnTZTUm5qbkBoB+h0kTlSVBEPn2fZK+q7Uo5WNPQzzdoUaWoun1ceW/ta5APy9G518uOib5LZOQXOPQf0ZrtnoWy8KiY99wHTnz9zWjcuBJsvdIIt78XOSQypfp0rAl7a+PLhK6Hsxe/Wv8nJzlbITPPcSqtd00rzbP0XVilH7w79WR5tXjV0EKFEmSBWB5VTlK/Qb2c0kT/qUaOaJbxEnamqqJulFVksNKgTmR2Ubt3cZa+qqyOZ+fW8klN83IBHvXxbgG6xTHfiW4MBqMYDZ8lEA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(39860400002)(396003)(136003)(346002)(451199015)(5660300002)(2906002)(44832011)(8936002)(41300700001)(4326008)(478600001)(8676002)(316002)(66476007)(54906003)(66946007)(6916009)(66556008)(6486002)(6666004)(9686003)(6512007)(26005)(6506007)(107886003)(83380400001)(1076003)(82960400001)(186003)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?0LIJ0t7dQinbf29AMq9A30KCoJfHhTR/MskJS62eddPVjub/eDFf2gDIhBVE?=
 =?us-ascii?Q?ElhFKgmjvA6pYPLY0pAPHFsHUupZGYHbTh73s1Hpb9PUJkux/lPPgO5BeHKB?=
 =?us-ascii?Q?qkaec2hNkchzR0CyEj/OrXx3mNg+mQysY195r6ZsNeVorlN6B6W77+DpcAQy?=
 =?us-ascii?Q?s0h4DT3C2GgjTZpwfB9ZeouOj5imdEzVbtEv+nDdllnrB9ABSuHb6Srytgqc?=
 =?us-ascii?Q?64Msh6TkSCPh2jPBa1HgR6mG2IHrLpsMLIjYee0uBbg5ZwIctRcbKbhTuRjK?=
 =?us-ascii?Q?RmXJY/O6CvdVanqqBVP3NQa78SP+8tarTMuX+zKgtyjxJwNHN5tfBxi5W5c1?=
 =?us-ascii?Q?qA2xUV4NKQgkcCSI7J1MPepe4rYN6NVoiJf0M2TAv6x3SnpoSBbuLCcg/dju?=
 =?us-ascii?Q?oymJPhgVEyPgJvWPvjuQ8+bA+r7Bt7fsMu8eBjHTduXwJ/FJxq5uGrrUeP5a?=
 =?us-ascii?Q?hcLdzmCBDTxFHbQDzMs0bu9+nm4FQ94l+0X9yH5GBGkJ+wEwVDg2bmXz7m9I?=
 =?us-ascii?Q?q1ZXdMftVexslPJoOQYE5JCE0dHqKH+CyLeZlEvRFHrQyuC4w7Bx1TAEaXs0?=
 =?us-ascii?Q?arbDLdo28mBk7qeCWXCwZnCik6Rws8r8wrp9dSXGH+LI9UcZgbmia+D+A9ZV?=
 =?us-ascii?Q?H/HmA3aDtUJu3Evph0wN+/4mhTwXTYzvu/fOtqy81Pso8yN8I4MT1FPb8moZ?=
 =?us-ascii?Q?i6ngTlLP5YBKTFPw3KppuFgNUQjshGlc66QHzO6alE7GiU7aIFr/Zd7qAwxT?=
 =?us-ascii?Q?le/V35AenoDrKq+7to5UMHLIrIYutujpSS4JQomSReU+CuUEf9ccLJka1+KN?=
 =?us-ascii?Q?ZfJR1g79frs0bc/lQpT8hr7EbU5wZyeryzg1Sa9JN/+NLqR+oTPfuJGUiJcz?=
 =?us-ascii?Q?lJlKbX36RQHGvDAPpnNmk9lrSpp6iGBVcV3f5RIkUpQhOJULvc1FjN4j3zDa?=
 =?us-ascii?Q?zyZapSx9ouDSRU8VHeDL9+PZmT2HAQWY775golYI/YZ0W8B/1UyBPYMfcOEK?=
 =?us-ascii?Q?EuxKgRSdc/8NF96a/RGW04Z6rR7XXsqSa6mJkKhNHC8hbemPs0nr8wQ59NOb?=
 =?us-ascii?Q?gYXAl2ojfUSl9AdSUXuujJd7CN7KL3+jRLA3KBqU1+xNz8zt1rTMaTJyyMM2?=
 =?us-ascii?Q?WxFPeoeFV5m4Yo0NM3/YJIWJ7XOWjUiI4H7VWhSb2ktr2POVM0gdk5qkdQUm?=
 =?us-ascii?Q?5GvI1hlHPEqV4TyQl3p7aQ0hRb6Dkrj47Th6OBYma9Z3oodvoKDNEJTGtRGt?=
 =?us-ascii?Q?UH5fQjM7eSCeETPIEs9K4T1a0jtwt7ot978/vOb5YF3+08S1h8xCgKtQvidN?=
 =?us-ascii?Q?2895yFP3uvLaFQSGTj3TRd/7DTDMoYfZIErPNHs6U8lwD2AbDOVsc/X/g8gV?=
 =?us-ascii?Q?ggiyOHASde50oBhDnIOz6AFvzs947GX4fATYMomUzoocAfIZIIVS+POKOKKd?=
 =?us-ascii?Q?rN6KzZyQLj6fGLBd06fgL938Qd8c1+8Tuol23vuMRC9krc2tC9iDTOQ6mTTY?=
 =?us-ascii?Q?jq7Z238q3Sai4bJ79sNIU4Tm86pRteATgLaFBLy8ijbLE4mJ6iqhxj3sJu/V?=
 =?us-ascii?Q?PfjwWt4Lmv3rVVPVwAuLj47ZL26kjnXrHBBiIToeMcNzPgS0TfPeU+F7KfST?=
 =?us-ascii?Q?e0160/FlWwZGBuBP4cyNtDY=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c0afbe5-c7e3-49e6-257e-08daee53ffd4
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 13:02:56.9554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dxfPyo9kvP2TESHfIPWWKzXNwfTyKbXmkrzztY7Z1o7cVGXQdgw4hH9L+NiyymdBIRmUsyreQYqKrr/M0HD1Y1Hp5tWzPXphJRBpmleuDi0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6746
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Jan 2023 13:10:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10302

I again had problems getting mails on the list, that is why i sent this
twice.

Once with a "Reply-to" and later without it, because i got mail back
telling me that the remote hung up because it classified the mail as
SPAM. No details why ...

I bet none of this is on the list ... again, but at least using that
other mail infra i got some feedback.

Henning

Am Wed,  4 Jan 2023 13:51:02 +0100
schrieb Henning Schild <work@hennsch.de>:

> From: Henning Schild <henning.schild@siemens.com>
> 
> changes since v1:
>  - add missing copyright header
>  - update copyright date
>  - rename recipe to include PV 0.1
> 
> This patch is now coming stand alone as it was not merged with the
> rest of v1. It is based on next
> 
> Henning Schild (1):
>   change-root-homedir: split root home move into own package
> 
>  .../change-root-homedir_0.1.bb                | 15 +++++++++++++
>  .../change-root-homedir/files/postinst        | 21
> +++++++++++++++++++ recipes-core/customizations/common.inc        |
> 5 +++-- recipes-core/customizations/files/postinst    |  8 -------
>  4 files changed, 39 insertions(+), 10 deletions(-)
>  create mode 100644
> recipes-core/change-root-homedir/change-root-homedir_0.1.bb create
> mode 100644 recipes-core/change-root-homedir/files/postinst
> 


