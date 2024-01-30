Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E2BCC47DDF
	for <webhook@archiver.kernel.org>; Tue, 30 Jan 2024 11:44:46 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.66])
 by mx.groups.io with SMTP id smtpd.web10.16404.1706615079225506314
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Jan 2024 03:44:40 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=jtKkH2H4;
 spf=pass (domain: siemens.com, ip: 40.107.21.66, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1tIWumFL4YcJsonzExMVMQYpaGrl+cOf13YLx70FdWG1DjyIP/JwvCuS/lSsWZc85hnJWeRcX0e5i6JLNCM+4F8tRO8QXppBS/VvM3RFN8GaCTCMof2gcgBjztGlfqESfmDwcTzxKDyTDhPBMw5VuC0q3A8l9Ay/svXI4F1c8l8tSbhtloATqSWjfrosvVRkIAwy4haKTCUDb9cMcIkGqa8+gT+6Nc9DwAJyVPUod6qexoToFUgLDF0FQL1VUHnvApUwErlsWgaXGLa++6CZxg/eTPk7wXvGe07GZhnVYByxJhngVKcUw1X0swIGmk8FyTq3Sxror+l+vH8ZS4BWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5kuyl3DFKs0ZHXXWD0MKyrNLUsLn5pC6vCHePP3q70=;
 b=GOFRkS0iJRmWXjMApuCnQ2KEr5PprOxoxcGskip6aDD6CSbwg/4k5mBXn5ueqc0EEnt/5OYg3Webn93EttMyKMp9amQ4odB3dTn6FVflXQlJMYAIK5kW5l128HKuVnMM/l8X25a3qwj36rrlPmG/J4IuTLj6ZDX6GErrZTTsYRhB/9f94FHKirGVIM5sLKqvJ9rtiFJlG9zTp/+HTO3DjH1o71rEgGePcyh3O60nD33iXGpzvUM2nHc6vp3tNoifztC0W1q3Kk2BQdiRWyUXzDdLE6gL2mLIUudmN0XuWfHx0/5OJ3WgSjJgbOBPDrdPr/0jBb5VZxVLH+39fphl+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5kuyl3DFKs0ZHXXWD0MKyrNLUsLn5pC6vCHePP3q70=;
 b=jtKkH2H4gRX3162Dbu+a/sWFM7dezKFPZ+b1zdvjqLeub8YUJLHiP+Js9KD3uJd+XRrbKGy8FqgL3NI03yEb+mHqV0YioWr3Qc8e9MlCjAIzcNG0OIBYaAfUXcFiAZ4ScJVyTIZTDbmwugtjxuye6Cm64l0mE4U4IMLtbGQi2gIkPYQxGh7RWhxRBMTQ39SRkS9BRIkYHThVMS+pTPed4+hZhrU9QbIgwLVNVA39Q5hQoc+cXXis/Jdse0w5eS6WmQcugXD3XLeCc3S4TUcyo/e6km7ncqbIv/F1ryRbPhpiI1liyQqlgkKb8PakDDA2wKlQ+ILROqbZ9mxpEuyuXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7347.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:605::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 11:44:36 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 11:44:36 +0000
Message-ID: <cd00d953-7060-4d98-8f59-8c7c3cdce178@siemens.com>
Date: Tue, 30 Jan 2024 12:44:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2] wic: Set fixed partition UUID values
Content-Language: en-US
To: "Moessbauer, Felix (T CED OES-DE)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "Adithya.Balakumar@toshiba-tsip.com" <Adithya.Balakumar@toshiba-tsip.com>
CC: "shivanand.kunijadar@toshiba-tsip.com"
 <shivanand.kunijadar@toshiba-tsip.com>,
 "sai.sathujoda@toshiba-tsip.com" <sai.sathujoda@toshiba-tsip.com>,
 "dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>,
 "kazuhiro3.hayashi@toshiba.co.jp" <kazuhiro3.hayashi@toshiba.co.jp>
References: <8ee6a477e885307b180d216fd83ec4475247ac0a.camel@siemens.com>
 <20240130111722.1463101-1-Adithya.Balakumar@toshiba-tsip.com>
 <5dcad42f-4759-4a46-8120-b87f862407f4@siemens.com>
 <6415465c22451a7df07efc90dad341ab5ea5d13c.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <6415465c22451a7df07efc90dad341ab5ea5d13c.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0063.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7347:EE_
X-MS-Office365-Filtering-Correlation-Id: c574ab6e-31e9-4c16-fff3-08dc2188d59c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	vTVCqEcYJJlRqAQN2/u7p073qYTv1okiShfINzFSbvTAJ+e4k30unvdEqSolWDjXEG1ZcQWReBGw1VeCYqVqWzXtPm+V8F1rAmJEz0Xn54ky7/dBTVE6EH1Z6Jium/We4G+nVMmZjCTW01BDtN1pAzrELLTLzdh/zp2o6py/R7o7JXe6C2d+pyOZG9DWz8YWB7Hz1/daXTc5+LHgklxx0LPyvfGCWmjGd3vtOFpYru/bbYoKWs6tahBwBU38v5E7Lvm0e6jcUemZDIVJ9MpSwVBr5X2vwdNQ5wnyRCSGYp9FxfuhPWDTIHTy1tl3vkqRkDAfI/lfok6VvLuY1aJ89sbu2lCSV2lo6i0/ZQe8DjHUrnYG8Fcuhkhmf9jLZPssS3Ma8dK0sRW0V6dAPz2QOIuH6onACyNSObSOIog4e9MyzTyxK+jLLiyUw1OhkWLS40UH2gy4J/VNTH3SFvbnMaZmjJMpzG9dPGgtomLYaO6Qmuwz1peD03tLdnYfGEhiroB9bh4E34ywLFNfT8NeMGF4NTSTYBRuIEHMOQwW1GitdbSQNx5d7XAW23ATd5LhepVD9cFsf3ZPHxoWW8+BZbXahQrY0OEcrkyGOx+bhWPXK+vvt5QZ5/fYsTR5AgmVXFJQzRQF4+tbkHgvtPI6GA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(376002)(346002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(41300700001)(5660300002)(8936002)(4326008)(8676002)(44832011)(31686004)(2616005)(82960400001)(86362001)(110136005)(83380400001)(26005)(478600001)(36756003)(2906002)(66556008)(54906003)(316002)(66476007)(31696002)(66946007)(6506007)(6512007)(6486002)(6666004)(53546011)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?aYelqNZ/p1+tF2w+4vokh2kGV2chS/n4fv4Lv4eHhVahemJow/DS8Jx+S10y?=
 =?us-ascii?Q?TqucF86oq218USi8utu+YwxBcFalSJgNW03YBsjC6ByQhCWuqYZ2SD21J8rz?=
 =?us-ascii?Q?xSsWua5B8xB0m4sMgdDpcVFe1FHb5bGORpUOpG2Ns1iN/LjFdqt6dldl/fEt?=
 =?us-ascii?Q?CJ3qajz4ayhVIrdJblH0Z9qEp5aQMNkRcWISSHM7YygGsAApc0Sf3SoA0q3/?=
 =?us-ascii?Q?WYt2JJoOs10WRarNi5KRbcm88ckTxdJs6qJQJt/SpFsfPann5EVUTbTJh6bZ?=
 =?us-ascii?Q?BTahD0KWpRqoOm/BZiwha7ltRZJHiNm+LiHZmC9I4iKVGYEPO9bItWtUAsvI?=
 =?us-ascii?Q?ANvdkYi/1NCSsRl2J1o2DMQGYBRoWoSaQ1cjGecg7Y7OKwsbZB7+nSSPYbji?=
 =?us-ascii?Q?RKiy2/+TlWyBTCpiBBpdolYxHjrmV4iAfvQLycvffNgkZCJ8vPlpafgi3kY1?=
 =?us-ascii?Q?pizlAeOGMMsDIZrj6cl21s7Q2b/2pOkyplZDQYRvQnieBROt1VnP0TXaJnt/?=
 =?us-ascii?Q?rPC2zgFnpaFxBhnbOW1OfAqSaZqLs+8Bt/xhaYkw9DFxMtfqh9yHH9Wvrl45?=
 =?us-ascii?Q?694FrUjMpn8yXwtC6nJJBNsKXFa4oUDg/z9TXSH10gvD5UTGxwT7REEhkNjD?=
 =?us-ascii?Q?8hdpHk7oHkWCfhjKrgJ1c0pHhjpNyiDIxTsTz3n9DhPz0dS5xcUCi/Lw/E+3?=
 =?us-ascii?Q?+WZS8Tqs7Yi+Q/BNT+RiPbjGBuWp5mzpGMSi9THsXfh4fX1URLWxGj7bkKT4?=
 =?us-ascii?Q?DmPEUARod9njLr80Hbxr3BnBmmYDHOIf+VvvbpbXMD+YYtsd4eTX25L3ZySM?=
 =?us-ascii?Q?F/muRVy0D/MqiMdBtGI/dAHlvFGj6rK6Fx3LbXykmLATIpQl8DoVzHVYGg0y?=
 =?us-ascii?Q?4ww7jLP7+Ul+05n8KcyzhN8RXnViUJKUas73kZrVg5fMOJNV4Wbq/ItG9giv?=
 =?us-ascii?Q?opsOKtfO3hczfVBJS3tRT8zfAFleoLUP8muklOB0Wty1IUamw7wsNtk2NRZW?=
 =?us-ascii?Q?USgXxBVPgnr//qo1z/telK4xUd4kng0XaElQHV1j2uOZ2MfmT1xzJziiUXq1?=
 =?us-ascii?Q?0jjSE+Cz3ZQ/DK4H/IrMTQuN89kNs5F4OMWPRZ4UzzIoS0NlVF2dmpQM4386?=
 =?us-ascii?Q?K+wmYPYFwPubAuJZan64TlhfjmzQmvLE5ZyzjQtIkGh2fwic7IOFs/vrbiC3?=
 =?us-ascii?Q?qvdP/k7PM6dZIMlNJKVEEOf/xBXOaWvSKUzAVpXwTjjF39uakmrAZndvrDJl?=
 =?us-ascii?Q?RCrp/5xzz5542W1U7gKiaBVanz3ulVECyJ5J2MATIuXIvX4IzGoZinXwXds3?=
 =?us-ascii?Q?yEBocGfpeFlFQhL+cnjkuh3r5IkGQlr3BvpFCCp0vGPi9m1iwGwAiJRC3lgU?=
 =?us-ascii?Q?6czkCwrLHtDI3WHjh93ec6ou7pd5brZ3xpAFDsvFx/e6xPVvIQqvPZ4yGmda?=
 =?us-ascii?Q?pQjY1xbX8q7ica3oYuuXiKiWrBuyx+pMWh99Sh8LpMnXygGHakiAC3i+qKA0?=
 =?us-ascii?Q?chH2tTL7iU3UothsP94kMqoDz2OYgL6PUPq8cVhTp2VUegEiWPeM1oOi6Yu6?=
 =?us-ascii?Q?KnDEzKE+YC/BzIgjSmqDA9KubIInjAK/731dEf5hyIolkeuZauCFHEwWarGO?=
 =?us-ascii?Q?6A=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c574ab6e-31e9-4c16-fff3-08dc2188d59c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 11:44:36.3904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8pgPsmWJVRquCOfisdKkoBV0nyl5wC7bnQVopMbnXX5snMcWMIL9lnZmqM21uGKQ3A+bAPJDyRnx4NrbAJjCRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7347
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Jan 2024 11:44:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14494

On 30.01.24 12:41, Moessbauer, Felix (T CED OES-DE) wrote:
> On Tue, 2024-01-30 at 12:37 +0100, Jan Kiszka wrote:
>> On 30.01.24 12:17, Adithya Balakumar wrote:
>>> This commit sets fixed partition uuid for partitions. The --uuid
>>> option in wic allows to set fixed uuid for a partition. This is
>>> required for generating reproducible images
>>>
>>> Signed-off-by: Adithya Balakumar
>>> <Adithya.Balakumar@toshiba-tsip.com>
>>> ---
>>> =C2=A0README.md=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 1 +
>>> =C2=A0wic/bbb-efibootguard.wks.in=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
4 ++--
>>> =C2=A0wic/bbb.wks=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 2 +-
>>> =C2=A0wic/ebg-signed-sysparts.inc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
6 +++---
>>> =C2=A0wic/ebg-sysparts.inc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 6 +++---
>>> =C2=A0wic/hihope-rzg2m-efibootguard.wks.in=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++--
>>> =C2=A0wic/hihope-rzg2m.wks=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++--
>>> =C2=A0wic/iwg20m.wks=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++--
>>> =C2=A0wic/qemu-amd64-efibootguard-secureboot.wks.in | 4 ++--
>>> =C2=A0wic/qemu-arm64-efibootguard-secureboot.wks.in | 4 ++--
>>> =C2=A0wic/qemu-arm64-efibootguard.wks.in=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++--
>>> =C2=A0wic/qemu-riscv64-efibootguard.wks.in=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++--
>>> =C2=A0wic/x86-efibootguard.wks.in=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
4 ++--
>>> =C2=A0wic/x86_64-generic.wks=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 4 ++--
>>> =C2=A014 files changed, 28 insertions(+), 27 deletions(-)
>>>
>>> diff --git a/README.md b/README.md
>>> index 4ded924..62f72e5 100644
>>> --- a/README.md
>>> +++ b/README.md
>>> @@ -27,6 +27,7 @@ the BeagleBone Black target image with real-time
>>> kernel, e.g.:
>>> =C2=A0
>>> =C2=A0=C2=A0=C2=A0=C2=A0 ./kas-container build kas-
>>> cip.yml:kas/board/bbb.yml:kas/opt/rt.yml
>>> =C2=A0
>>> +**NOTE**: For Production images, it is recommended to use fresh
>>> UUID's (Partition UUID) and not default ones.
>>> =C2=A0
>>
>> Looking at this from a different angle, this recommendation basically
>> ruins reuse of ebg-*.inc files in own images because wic does not
>> support variables in include files IIRC - while we should better make
>> those UUIDs variables, rather than hardcode them.
>=20
> Well... all products I know of use their own WKS files anyways, because
> they want to change the partition sizes.

I'm not talking about the wks.in, I'm referring to the generally
reusable ebg-*.inc files.

>>
>> Looks like this needs a second thought. I'm dropping this note for
>> now
>> while merging, specifically as the need to customize variables only
>> comes with combined with having multiple images visible to a device
>> which is not totally unlikely but also not really commodity.
>=20
> A risky thing. We already had it in two products that the UUID clashed
> because the installer image used the same WKS file as the product
> itself.

Installer images will generally not be built from isar-cip-core
patterns. Those can then use their own UUIDs, for sure.

Jan

--=20
Siemens AG, Technology
Linux Expert Center


