Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50FB4CAC581
	for <webhook@archiver.kernel.org>; Mon,  8 Sep 2025 12:31:14 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.6])
 by mx.groups.io with SMTP id smtpd.web10.12127.1757334671576881375
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Sep 2025 05:31:12 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=iKp5Kk+w;
 spf=pass (domain: siemens.com, ip: 52.101.65.6, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IrVM+w8ZIwuzdbUPUC8aUup+Z2Ut8s8OAilPIfU6SYBJFa0bbMzOKwCQ4PfmPZhLnPhJ8W2o2rFGtM6hUzc/rso/pFuysV0frXFqnYzUmC+r1M1lNp63RZF8mO1l+o6o0UjcyRhN37pyVzwkXuPuMBY3SM27JmonjC5082VsY0dlfk2cWqAJ8mwYQHevNgkF3bu47+AQiG7+Eb3xsG1XjT2DxADe5AI9QXRtURftGXSVh8fdUIZvY5YP4kOHN+OCkLCfcfpMOZpIKget/AMv8FYiXu3z/p8LDXzpP/SjaBmDBf5N/irhnsya9zVb+ph7NigA/cQ7Gi2ldoCXIKIWxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5so6Vxlk6oNCt8By0IJ7Cfajy1LfwQY11JL3RFdvkyw=;
 b=YCS7UClPjHnUOw+vC/dS6CeZd8cP10MbUw37YnIrOGl5qeoPbEfFwvafrymD1pLxvIp21OZncMfhhaWYvJ9nTpZUymITzaMHSrqHOR8R9HO3FS3qi/wkSwbZD3aiEK+yu7X+Su7BiUlfGY5Hm3Oc8kfDnweh6QqevQxiaeW1EbA7VWHfdX00hzStOUqbdBCxHN8FqCVOhlhq62OL4tc6r+070wNbtvpGpDNRsk9tuQMtdzLmbA4TddCyEg8sqHr8DdbF0KlqwPXKGYm505yEiS2DxKLqm9Bsc+gH8BR9K7NzXs2vjICvBwuI21Q5yqwopxLBqUnVZQDRNRShE2lZxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5so6Vxlk6oNCt8By0IJ7Cfajy1LfwQY11JL3RFdvkyw=;
 b=iKp5Kk+wStQNmXwiDBYSm86fLIxjKGpXB+LDiY/n5hWH+CtnNZypaYWDwXN/GEkCXOkjKt2KK9LK/aRWzHryiZO89Pqh4ZPS1gXAxBKjX7tjmwVQfie7LQO4ZpnQYO39RwgqXQVDTHoVp5uBAhMclj7XOo4yiC8l375w9CpIoZri+FN0TUPZCKs92M/ILwCkHXBSGpgNQ9pqOllc5nw7GNkGN5KzKBvDqipwgWLM8B7xAjHO2HVr13c87huju3/0YzZ29IuZKDgrZw8fYTHZ+5LqGLfacUsez+Gbcay1l8+5oN+7tDZPXSvZJvUmYlRCdoIBFjr6HAizy/oMw4HAEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB8262.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4c9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 12:31:07 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9094.021; Mon, 8 Sep 2025
 12:31:07 +0000
Message-ID: <9a09bf31-4716-4c6a-99cf-19ea4328f3e6@siemens.com>
Date: Mon, 8 Sep 2025 14:31:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Fwd: [ANNOUNCE] 1st isar community meetup
Content-Language: en-US
References: <3e92a63b-613e-46b3-8821-b5b5f1f969ee@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <3e92a63b-613e-46b3-8821-b5b5f1f969ee@siemens.com>
X-Forwarded-Message-Id: <3e92a63b-613e-46b3-8821-b5b5f1f969ee@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH0PR03CA0252.namprd03.prod.outlook.com
 (2603:10b6:610:e5::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB8262:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f8be603-5446-49c7-cf17-08ddeed39570
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?AUHpixO3LfEbdYI8grt84R4RMP4p6+x1jLD9SW50Rv4CLe+X3iqQyhOnNR/a?=
 =?us-ascii?Q?wwlSI7CK2BFpMuYOoW/izfsUyYszK+KTz7jNHIZE8rPuGovHR77qqZCR1bJH?=
 =?us-ascii?Q?CVdHkPpknhwYRXeHfgs1ViephFYgXR3H0qNzmdiru8qunUnVGboU87PQWEvy?=
 =?us-ascii?Q?xuT2bG/9v0vV+q5bpsWnM8e1glQRDmlKGHwUpmHKdL2bKQNf6cyH3g4amBjH?=
 =?us-ascii?Q?jxZUW+4tW6e+8xyFH1VsUDjNdpAQeutj9APHuV4tgwo+/LfDSt2zyEzjg2TJ?=
 =?us-ascii?Q?2/zlcVCOPeyJYus0Ah1ousxL9EpzLBuO8k4mXUNnhG7ixstLPAegBmEYAwS4?=
 =?us-ascii?Q?ehnYHlKQowt1jMjSIiWxkLjg2p4FaGQBFLhTIv9gDHlQ7u/9Lg9nwq0NieG4?=
 =?us-ascii?Q?Q+cHqkXEdbieu3ze92OBFlLEGgtf8mPJjo0wafMXJiiPy1iIi/v+hUxTThiC?=
 =?us-ascii?Q?VSh/PGOrP0/UIK643ldM/rUjALBuzQsgpjKi1tVto0zukNnFNvIN9kUefb9q?=
 =?us-ascii?Q?SAo5q9X4BQ3lVgGqQKmJhPe3fe9VM2cNY7qxXl0ZF4/fGXAu3Uz+nytFykQ1?=
 =?us-ascii?Q?58/pPqzVynXcTwkI1gEvjRMFRJI2Rba5sH9MPwQTbx81AbQZ7jxb7MJWw1rq?=
 =?us-ascii?Q?vKuNKTGKYLM3dfWT4loryHTbATkCnFna6GaF96hcGzH62hfH+I1p7EDFFd9A?=
 =?us-ascii?Q?qkhHQe7dc7UbxAxV0ePXLJm7O7Lik2x8BQSKefLZ+zj0ROslyJQTNeoX1VSD?=
 =?us-ascii?Q?FcUeiYvg/rDsrrkEOwiZFZacckUO0Zicuq9quuVWTSkBFvtT7cHc8dFh5S4D?=
 =?us-ascii?Q?Jt29hYnTaodQ/kPhwhwErNIN79WdR1neoXRZukQP3yJPQyCeSQB5FTBJ36NB?=
 =?us-ascii?Q?bf702YxIDAd/lw2XhEobADLPEVgXhsmyaya1WMkx/Ac0bQsJz9Qi63OTK6cx?=
 =?us-ascii?Q?vBO/tzVJTVGyfEXdjILB3e4CnGdmNtxh7dTufRZyEmDqegx2thuRVbkEU8p1?=
 =?us-ascii?Q?rWMkAPLDZCN6Gs5WRn4eBVoAi+SP2glY4X1ZafdYThLmYMtFfZTKeNre9DDj?=
 =?us-ascii?Q?CIYdPGLwGhPeOx21XzTvyIDHBRgshzbT//QkuCRRO+GX6J9g+Vpu+X4aBTXP?=
 =?us-ascii?Q?mMBbtCYO+c50zq33fezELEtwfUlQ3GVGkqz4iuBb3Rk7lFysqSQEvn7e8SCK?=
 =?us-ascii?Q?nDWGbuyFlZ0lIq74xxY1b7W0t6eYiS8KsW6uI2oyRuIIWwopttwTZGqzRdcE?=
 =?us-ascii?Q?uqdoY5mAltCyL+4CFmrPIIFbVTzn9Jc6hM2UoBlOi4767xAB+V3oWzDXZGE+?=
 =?us-ascii?Q?xWtXnnZNOdqjwTqSq/HB4NC0afwGrHUKKKaj5X4AVzk+ACgXc3qdPKgXnCTz?=
 =?us-ascii?Q?naM5GZo=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Orihfpu61T9b6ZjuBH6ZQEANR0mZ08adthCrIG10o2tzxXWqhPACl/emFDoX?=
 =?us-ascii?Q?Kitn+vTgWQXZKf06xITTi/O6hReHcbL+c8RFKbIwwTnGxnsypAvxgVSY+exM?=
 =?us-ascii?Q?aMB0LwGlzE0ghiUjTIX5EeREw7nCLNudyXGppq20Ue0/kUk2lnBhnBeWnvmu?=
 =?us-ascii?Q?nXbpv4rqh57a42NujbbB512NZriCrJG05T/CCDtAa4MkwRskMQ9Y8DVK0uaz?=
 =?us-ascii?Q?j/2GEKjP/KjvAz2/CYXGsul/eEuuWMZoykzbdG3aFmhkcurQo5m4L8BMKRpu?=
 =?us-ascii?Q?eHUlMkUGFUUc1RWZYdq960JydEn39RHrnIvEI7wqvNiN8n5PIjZAISjieMib?=
 =?us-ascii?Q?A2vrzF6MoISs4inw/jrtRgIrdRi1iXCOTvGZ/Y0T2lTj6awPMlQrTAhOtfjq?=
 =?us-ascii?Q?FEaC17QWcZPlXuXrpqRi9GHu5fRqE10PrKPF5U1nxnjRUDs2ykPWP+Xg6uR+?=
 =?us-ascii?Q?yF2FNkhLa8r5aJwX8EPgwoc18WlDAsqjGyh75jibHFCgHqopSIg/1HdOdtRz?=
 =?us-ascii?Q?dtlufs4ER6qV+zIZwDNd1stthpVroHopz4IuDd258qeH+3w1RkzLfdxxBeh7?=
 =?us-ascii?Q?BKK2M0RT2o/Kz4iKouUA8eypvZIaDn2oHnzj5M7yoLDBCfGX4+UnzMDVmI8H?=
 =?us-ascii?Q?4WZFvbYEuqwzV6GJ7dZ9SfG9+4Wdh4MGDhR2uTPDXORlPnmKizhMrfa7rqCE?=
 =?us-ascii?Q?p7Mmd1OQ5NC/A88pVSyD7nvKpnoPk4ehI4Y2f+WcIi5vxQkeaGP0/5T6+gFf?=
 =?us-ascii?Q?GpNEWA+3CZgq3furFqKlXgtTNWtT+rBlGUaD4UXnoQvubZ17OFjo6M701wYk?=
 =?us-ascii?Q?q3x5y/LHJdqNW0cyLGK/1joMZsB+JSAEuVKglhmnpCb00eieg3GoYkTNtBk5?=
 =?us-ascii?Q?kmCMsZyBydRQ4ijxdmP3TDEW7RIKvYQrQf24fCptEdiWTxwWqMQc6oNB8TiT?=
 =?us-ascii?Q?A0xOg2mbGdRdsKA+BxR0iqS/Zhtb6fpqTIthm2r8st+UvBf15TDYhytN5dxF?=
 =?us-ascii?Q?07QevTjZQ6fFeTIY7P9O1RhAifeMolMGWrUahzm9Hn0s/orlxEC8kqrmeEiZ?=
 =?us-ascii?Q?HVr8eRw1It4zy12FVWsEX92YR9rkPlYC2p0bcp1ll20mrtB7l3Kx/fnms4Lu?=
 =?us-ascii?Q?DwQlHnpeDWxPJIpQDD7Y/0bn+OqqByh78BGsv9R2t1PRSJ87ntmbkDckIwr9?=
 =?us-ascii?Q?k2smbBEfwLD5WXFD8Mo4ntCkqE13FAh3ijrdjIVYeCKdWkNjw2owAL4dIpIF?=
 =?us-ascii?Q?f0ynkcHowSk8edmCRxSlkriQ7L1tAsnoquAkGMCEv9tMelm6KAPdFpEVg9bp?=
 =?us-ascii?Q?XTcs+t5JKOBk7Fx9/HBSerC7+KeDxHQBNOF+94sW3ApuFVtDzFWF6zzoNhT8?=
 =?us-ascii?Q?N83N/GzjSr4m7XQGm3iaSWRbHeGv+HfZ22GbYnM4oWNarTLUol9MAOi7hrra?=
 =?us-ascii?Q?baKFALamswrnoQ0KHxBGfztUyAEnvCdO3ZTLxwypmJ9uscZb0H7uBn/BqzuF?=
 =?us-ascii?Q?5raSZPZMtRwBUeWucb8E/e2miyz0hbKrUeHtqQRrJNmb3iG8M/VQj9crl+I5?=
 =?us-ascii?Q?bMqyqWb155wZyVRFRU80DrsqjQWQ2y1pgOZAtfwAHSZ1kulbexQjOvFEhrBU?=
 =?us-ascii?Q?vA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f8be603-5446-49c7-cf17-08ddeed39570
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 12:31:07.0840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BxMYFOq8jq06xHGpjay9yDdfNyZUUsqsfsrln3X46dQ2/i2oDeL6bParQefVnoUgbVky8fxb1V6FkSGt29iuPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8262
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 08 Sep 2025 12:31:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20022

Hi all,

while isar is not a CIP project, it still an some important role for=20
us: In case this wasn't spotted on the isar list yet, I would like to=20
bring this invitation to the attention of the CIP community. Our
isar-cip-core layer will surely play a role there as well.

Jan

-------- Forwarded Message --------
Betreff: [ANNOUNCE] 1st isar community meetup
Datum: Fri, 5 Sep 2025 19:03:58 +0200
Von: 'Jan Kiszka' via isar-users <isar-users@googlegroups.com>
Antwort an: Jan Kiszka <jan.kiszka@siemens.com>
An: isar-users <isar-users@googlegroups.com>
Kopie (CC): Baurzhan Ismagulov <ibr@ilbers.de>

We, the isar enthusiasts at ilbers GmbH and Siemens AG, are happy to
invite you, the isar community to a first meetup!

Date:         Monday, December 8, 2025
Location:     Design Offices N=C3=BCrnberg City
              K=C3=B6nigstorgraben 11, 90402 N=C3=BCrnberg [1]
Registration: https://forms.office.com/r/6ranXDctdA

The event will be a full day. We are planning to fill it with an
introduction of the isar project, updates about latest developments,
user stories, enhancement proposals and enough time for discussions and
exchange of ideas.

Therefore, we are also looking for talks about your own experiences with
isar, your use cases for it, how smoothly (or not) its adoption went,
ways we can enhance it or even ongoing work on that. Short lightnings
talks are as welcome as in-depth presentations. While registering,
please provide a title and an abstract for your proposal.

Hope to see you in Nuremberg!

[1] https://www.openstreetmap.org/node/7230328091#map=3D19/49.448479/11.082=
904


