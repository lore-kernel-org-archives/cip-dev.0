Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A64C001DB
	for <webhook@archiver.kernel.org>; Thu,  3 Aug 2023 22:00:43 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.54])
 by mx.groups.io with SMTP id smtpd.web10.12852.1690977154473786790
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Aug 2023 04:52:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Dp/j0NsW;
 spf=pass (domain: siemens.com, ip: 40.107.20.54, mailfrom: michael.adler@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9evZ3cnkmW05m3TufxAQYWLEoD3tAGqyaBopgUv+iezg6btQ2iEP2BCsl+mFcP2mTiaNfKrfHjZeGfcs28GSKabhyoEldcfky3lNx3CEp8LfRNE+G2DbWsOIud59+mrixzKpOC/LNaGNt8qXvaYFrus8j12bHqJRfsTt+7aD77uYyIcL8BDmfEeG+4IPp8NA/vuXolr18EXNu8pi7D+SsTEUQjhT/tbwSPvxwZOup2vlnsat9IETC1WhhCKbFCchdCPIWWTSnn0rrpD8HuXJpc9Ln1pFOvrt5sd1/ziiYwHXHtfoxY5L9PGMr53XNMNsIDa0w42u4WAxNFTdj1WUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EzU1rzSyC/IkZCkhkkPdN/X+g1fKmJAdaTuVlOXAR9s=;
 b=jQ4CMu4zjYRtoKs7BSLWSM6deZxsvtly1P/X4vQllzdPohFZN4wJWxSlSqaRa/nxQnU8PX7gu2FNRr1lVcpBOr8QQFsO93VO1SuzJ2UmqxvFVwWfi01xgjbZFsoVz4dsexCLUtDJG23CMd6Tb5GwEyNNMLnMUqaxQkbrNSnWn4QaVI4hJRid5kjupRqGos2+7lG31k9KhYK2OyR8NBxqQQZEzMmJh6mTbL6EpNVqHSgp04omvZMAigtws9vOtUDmJVdmhGzC3vPsZQSpJElLcJ9hOOIrWcucD+vAM7zgD82aQMMlwBPr5Md/XzVhhqCzEc+8cDpF/d3RKQwtwOoEFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EzU1rzSyC/IkZCkhkkPdN/X+g1fKmJAdaTuVlOXAR9s=;
 b=Dp/j0NsWzGGY5vueUhTHTeZVF3tAZq3SPRjtJVpSkL9TkPjIyvct7Q21sEd5AwBjBXrAqU+nFrjcy1htegXaB1FfmdjDtKY8CWCoJUapYXPiEYHr/wM4PeRxMunQJMsODkooX4CMzINvQoutLgW31MSD7waBsGLza8TZsEUWSzXSbILk0ajen7SX5NOvw94ReCbCJtUkhWy1D4qbqCFRqak/salLX+F+OuXv6ZdELpBiPYdB7ZihPgNEMICqoE9hL9jasz9E/Bd/1W+WPF2wfoEybnehqoBQKjwwt8XnxJzRfbF/MyYaZXq74kLSNsEu8znqRfLsszhLvR4j+Z2VkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by AS2PR10MB6799.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5f3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 11:52:31 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9505:a6cb:9759:b1df]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9505:a6cb:9759:b1df%3]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 11:52:31 +0000
Date: Wed, 2 Aug 2023 13:52:04 +0200
From: Michael Adler <michael.adler@siemens.com>
To: Chris Paterson <Chris.Paterson2@renesas.com>
Cc: Pavel Machek <pavel@denx.de>, "cip-dev@lists.cip-project.org"
 <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] stable-rc-ci tests failing
Message-ID: <20230802135204.1e883f3c@backstein>
In-Reply-To: <20230802125753.4d2e6225@backstein>
References: <ZMoaWmwWiLQz+vNU@duo.ucw.cz>
	<17778648DB0D91E2.2497@lists.cip-project.org>
	<TY2PR01MB37881707081B7D70710B10BAB70BA@TY2PR01MB3788.jpnprd01.prod.outlook.com>
	<20230802125753.4d2e6225@backstein>
X-ClientProxiedBy: FR0P281CA0203.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::9) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB4734:EE_|AS2PR10MB6799:EE_
X-MS-Office365-Filtering-Correlation-Id: fb4b91ce-1230-43fb-20e8-08db934ef406
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	BXcVaMEAXIVsSCoB+xyzIDRFAzLKhQY3MWEeT/ovxqtDCRBH7A1tMUxThSPzB8qUuRDGJTZ030jFk/3wqRoosZVjeuWC1oEyzrvplNRk44sWxV86GtO3YrGoFMHZ1GUBb4iKTNVz52xgMX5r8O1e9T5L5Irm77Qrr8KamJTSV62OzSthPS/ZViduE6u5uUjdqvsi3YllQ0egpD5nA5DRN/rTRbxr9Z0i7kdJyuaMG/Qnwv/Y7Dg648wFz8aR4o19WEAb2StMtOq38u3mJnWOg6aZzjzx93IzHgJCU9P+kLJp6fhvY3PwqeUhKnsi4oyi6YZqP6ORVon13t18B8pdHi6gXhgR6jEsNfSNl0C5uCyUAclduT0G/HNW6MpblCN3vzqbt5SloCh/ME0cP9M5MhYI1i6jdhnYJfS6zJssyLcAjo/IEgC/xlSPxxK+aSqBCpE5zUIYGbXAv9IanRwHXLp+icKJsTduQp2KebNIxV3o7roW4jIQyCC6uLcdSHCIRJIIG4NKKPT3jjK8+7tBeF9JYBvIs2sE5wrvNaN/898WPL9Dx3bZv3ek9ws1DN7K
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199021)(5660300002)(6506007)(4744005)(8676002)(8936002)(44832011)(54906003)(38100700002)(9686003)(6512007)(2906002)(66476007)(66556008)(6666004)(66946007)(82960400001)(478600001)(4326008)(6916009)(6486002)(33716001)(86362001)(316002)(186003)(1076003)(26005)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?nid3DmsTgO44Q2mylQdANYQi8/OXqkpoWXgle/wwz0lkMmbEisEMbAbx/L6r?=
 =?us-ascii?Q?zvy2kegcPCl4SzWtKx5o4VVw2f38EFltdoC/0xjtkE0fszz9SGUfayLph5Ru?=
 =?us-ascii?Q?Bc00eRZsVpKwkTR9sldyokX9BLBrOiA138imEIr9UwDnsb2sdfnJsm+HQj+g?=
 =?us-ascii?Q?l4DrfsCopWcsdSdvDvNDNRsmaUxPFRuZZGC5lxpC0KdIck2xGeZTW2qLOwZJ?=
 =?us-ascii?Q?vnuPiCB1YSyx8848lF23dV0Mduv+68ejTUeVIkvjlPNxWNWktATLSViK90rF?=
 =?us-ascii?Q?P3FQOaCShHROdezkHd2QPNYDZiv98cBUFEqYU+lIR4h/BI6hXsQdgLArKI1V?=
 =?us-ascii?Q?L5sTTiok2J2bEIia4JyHpMBWwcSkYgLvkL+I7g+1cf6gf/9uthde9BWbJJt5?=
 =?us-ascii?Q?vGkZG8fQvRiubnxdZ7diKGo6vjcKAHWZ4DjmMDOCkktb/bTEoR6qNBkr7rRX?=
 =?us-ascii?Q?zQ4jl+NDxTv3+NJWhDPnxPducwURhKpCrZ3bfPglJofZB7wlJajWAi30tbPz?=
 =?us-ascii?Q?KkdR2MlsJSD2jm9JZkxhmbVoagkM9WNRjuyxesNmb2TgbmwzyjxpiUXQUm5J?=
 =?us-ascii?Q?GbGkRRoy+MMSI0jtwYGACLMc7lXPDRiLvCnJKbEf8wSUis1e7EVAOckcK4Ct?=
 =?us-ascii?Q?zX8d+NPbaV4A9VyE9XmHRx42lCM3XMPvu8j1b/aTQu60z3IiSfpX2/jxjqF2?=
 =?us-ascii?Q?zMETIsaLGQOyLlTyAEt6n7IWb7NxWUPVZU+aI2ENiy7Yo/C7a4+OUMgFvmVg?=
 =?us-ascii?Q?0wvCPCpzv4/MXRiRHrPQpvmVgMRYqk9asizKZQO6qV1rJ+bTgxex44CzK20q?=
 =?us-ascii?Q?MQFt3pVdHH15KGTl3SpOzaa5yvyBhVZlhmfnJaTPF0PActIgCCl9eloG136P?=
 =?us-ascii?Q?87/yihvYnq21vU+EVcGt1hrGS8oZtP+WIw5JOzKL+UMcWgH3+PikdWCfr94t?=
 =?us-ascii?Q?FlahtQxW0C2o+vAdHeP4bYVt3RDrFB1ifBJN6ZdQKWhEx9e/oAuLPB4qnU6P?=
 =?us-ascii?Q?sLSeLM3asCAYBwTfJB/8ttrUcmhr0f3dDrrWYZOCiu/VKC2V053+Pub5Fur6?=
 =?us-ascii?Q?aaktCuwx1kw3lG1IOJImGsymYwL7mfujWv2IHx/pqhUu4iaCAA5TO3ANi4Io?=
 =?us-ascii?Q?mRrw91xTcDc8SAL2j5raz8oO0qw4cvz2wYsxbCMT5WIhQ6wMWH6W7OwUQJWQ?=
 =?us-ascii?Q?J8IRLFCdnlEJykczSvUcucfF2JmsN1GZ3TUFtMjiNS2xYLGbMhHt6VJK9q9+?=
 =?us-ascii?Q?ZXUHQVj6+XFb22RBnwrRgwNYem1Na3LWuQq07eU7zbPYdOvCKtgNkb7L70on?=
 =?us-ascii?Q?zsKZQmcwNGSXZpFy6CcA+ehHXgFvXq4QsBtN1rJnRyDpFuH2dDAa406+EVb5?=
 =?us-ascii?Q?5rs1RkyZyqTR8aXMEo3TWOTPD6oK/wL22duVR4Oid6O+GS1PzqAKBD5cnZMk?=
 =?us-ascii?Q?z7dhGSsYSW+JdLX7nTGtvwiTc+rRQfLDUbkykQGwZRJwE2xLTorjoqJBUHzJ?=
 =?us-ascii?Q?U9m7NoxABV/wogQAJ0shRfzZfKFey248InXWW5TN1R3GzTbrqhOaO1tWgIyW?=
 =?us-ascii?Q?diLwD/+pl9h9u+hEANZ/izZq5pTCruguoFzjRHZ0ODNL9cYDIN6XE7NPoBwD?=
 =?us-ascii?Q?Og=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb4b91ce-1230-43fb-20e8-08db934ef406
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 11:52:31.5268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SW6mW9aLkDG5Q8r0KkivQrg1sD+yvHhHhcB7AC8ltLDkZeE5gKvVDBvU12fhWbvxNTKAt0Ga+kxk83u/k7lpO6iPvLWEz8QPXiBAIlVEUxw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6799
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Aug 2023 22:00:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12552

> In general it seems like autoscaling has some issues in eu-central-1a
> since I can also see i/o timeouts. I'll try to spin up a new cluster
> in zone -1b.

The new small cluster is up and running. Auto-scaling seems to work in
this zone.

-- 
Michael Adler

Siemens AG
Technology
Connectivity & Edge
Smart Embedded Systems
T CED SES-DE
Otto-Hahn-Ring 6
81739 Munich, Germany

Siemens Aktiengesellschaft: Chairman of the Supervisory Board: Jim
Hagemann Snabe; Managing Board: Roland Busch, Chairman, President and
Chief Executive Officer; Cedrik Neike, Matthias Rebellius, Ralf P.
Thomas, Judith Wiese; Registered offices: Berlin and Munich, Germany;
Commercial registries: Berlin-Charlottenburg, HRB 12300, Munich, HRB
6684; WEEE-Reg.-No. DE 23691322

