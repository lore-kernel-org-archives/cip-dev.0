Return-Path: <michael.adler@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C6ECA0ED3
	for <webhook@archiver.kernel.org>; Mon,  2 Sep 2024 08:58:07 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.83])
 by mx.groups.io with SMTP id smtpd.web11.34511.1725267483617559131
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Sep 2024 01:58:04 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=bonx8s5u;
 spf=pass (domain: siemens.com, ip: 40.107.21.83, mailfrom: michael.adler@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kyvmDzhZ2b+zLH+LDDuC+UmpHogXYf5y4F2VwIi6w6L1OzLErk6NwHG0mF7/xfZFv7xhX1LIdTHeTBTVrrijV0FIOYb40C6QH4wR7wrHGEe0WEPNuzeAjfOYVzjCo1Lkv7gPvMZ/0kwqVJtI/CQfiLDe7yhqSo40uksf1MT/r+JCWOsBf2H0/KQGCqHFoI/ZmixJEyR3dp52qkSS0/ZSx+gYiclVFvyXdEgKsZyAD9oUyaWplZ3YGMU0e8kAUqLRvn1DIPsR+yfhIxq9gqUfdvR+WwYRwB37se+XiqitgvSiA70UGQOOjo8bCkzP8qWT+USZCCh9vw57JVbEZz9u/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+TPF/e0+fwSQfLh49Y9m2OScUZWdmMyk/5dk9eLdl68=;
 b=RVwc6FwygG4h933tG7ZH1/xt0KCotOGKlpinpIoWLJYxIjEWFuzaWwG/STL+mGKRsQMIeYnlg5t9iF9W9s7Sp1aJN1fYXzvel7yPmktx3Nl1lRTbFXglKwh0SCss4dQYn5nfJy1HeAlKB+EsXygnc0BJjRc18XLJIKJxYzp3p5BjLfJAFt5x3J3QVtptWr4vrOk6vpDqRjfNcQ/6f48e7gqMOwYWpMN2/ss7CVo+KsTND6r4ibfOmUEZeu1+7lgAGkr0wc6obi9EdhdoCd6/ulfHJazzAavxV2s8PZeYsdkro6CyZigP5/e42+Ogptfpxv6poCXVYFFp/NHMHIYhJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+TPF/e0+fwSQfLh49Y9m2OScUZWdmMyk/5dk9eLdl68=;
 b=bonx8s5u/Unj7SYBS9sgchebuWYNIhQ4z6uuXvvuB27IRrizB0SwSXtuHYDWjMnRxXnJij8uJFwqtcJ6trBtzQqQ03V7yPiOdiYZCOX3dSciRXkGOlsiHdiSE/HXuWkYq5OkSTLKVb5heyLkH6XRS+C/FiavNEaVxkxNy4HLwjKtBhY/JCVAnboeT7LLon7eDETCTFoeniC4TRoFS+mUz8xbrU8d72w7ftvLrRXn1Rky90ETxxWOlqfPhX5hkFakVeFlS1F9rINemtqy3C5mRJIr7j/KUA876S6rnxkav9h0G0JvAtGlQPd5or9tVHK1lXx3PltsCBj2NsYaT/Ewrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PAVPR10MB7490.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Mon, 2 Sep
 2024 08:57:59 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7499:8576:c129:4b89]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7499:8576:c129:4b89%6]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 08:57:59 +0000
Date: Mon, 2 Sep 2024 10:57:48 +0200
From: Michael Adler <michael.adler@siemens.com>
To: cip-dev@lists.cip-project.org
CC: Chris.Paterson2@renesas.com, kazuhiro3.hayashi@toshiba.co.jp, 
	dinesh.kumar@toshiba-tsip.com
Subject: Re: [cip-dev] Issue with 'small' Gitlab runners
Message-ID: <cnkp47rzuahu7yls5ch2mi6okr6w3uevw6eqehmc3ti3f6zesu@of6ittbitant>
References: <OS3PR01MB6103DA72FFDEBC407A5900A6C2962@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <TYYPR01MB12402CF459412685A6824CB45B7962@TYYPR01MB12402.jpnprd01.prod.outlook.com>
 <OS3PR01MB610349E8EFC2F9E8ECEBD450C2972@OS3PR01MB6103.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <OS3PR01MB610349E8EFC2F9E8ECEBD450C2972@OS3PR01MB6103.jpnprd01.prod.outlook.com>
X-ClientProxiedBy: FR5P281CA0034.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::13) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB4734:EE_|PAVPR10MB7490:EE_
X-MS-Office365-Filtering-Correlation-Id: 884c465f-bb22-4f75-f149-08dccb2d583f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?V7s6pkQopV5YrnHd228D+UJTAA9AA2lI9KpOTjmu3VXPtYyFo47JnjRXWW46?=
 =?us-ascii?Q?q2OHFMjUEpO6PpvSRoQFNqXsIjTKD84qCZImeXBlmGi2YXtBHoqEuDHQpLO5?=
 =?us-ascii?Q?rZCP7Glduorsz+tH/OAXkrWaZevITFl2AaMgWChQ7VC100M24v3V8X3lz+Ol?=
 =?us-ascii?Q?VTBRSx5kRhVuhJ3W6iUgCww7YPFhGuzskW0roTS1vll0tgHM0xg8Yy6TwByU?=
 =?us-ascii?Q?P+tL7XWgwACK+M6K1Jg4t7mBDcw9lN63CXeraxvuFxDx4kyJXKJ2KULFszAI?=
 =?us-ascii?Q?jArVS9bVh0VvjtufB2ySP+1t6IjR6jOUXQu2yhJ/8CV4v6zDD67uGvq7LI96?=
 =?us-ascii?Q?E7xozmPs5oZacRa0MLg4+z6zbWOkKMBSf1XlyNRqJgkxdoenHI/QP6RhtipA?=
 =?us-ascii?Q?aokPtiwwmnKy1qdVj2f/z5ya0+3OjxFJYR1EMo6inTyqxBlfaD373ZX7D+5W?=
 =?us-ascii?Q?xtgtBI/z5o9mUXpsgKgSWUQVM2MA8z0pOyk47RjfeEa0v0F0DKIS/EXQBDiT?=
 =?us-ascii?Q?WWOJkAI2fExgQpqr0C0MaofInpUQ3CVnlKG/kDoJq73TTBnDmSovYjjsg8pj?=
 =?us-ascii?Q?OHh0reVNrjrjvxv9RlfEYzYNBbS5xljUMVJXjpZIFbMSWWDPdp10QafsIlLD?=
 =?us-ascii?Q?CmvB0VJfIJy2DykgZrL1yOt/c3LE7iDW4IZQ17tbsO8sapUhiKUQm/CxlPdu?=
 =?us-ascii?Q?etohpmcqPDJ+hw4weJuyMZUt8/oB7fK6gt7Pril8iCt+ElZco/MgsUAKNoNf?=
 =?us-ascii?Q?hsArQFDm4HMsHKL3i/CGijjIcjJyXC5K9N5kaRZmpERwfsHGEYayZMl+giRy?=
 =?us-ascii?Q?dtApdL3ZhZAzlbzRwnuWck5t2wnCLYA8lQzg43ZF1OecZ1JEl3CzukzdBRJk?=
 =?us-ascii?Q?8VqKW1CvLdyXj9e5w1NKRyFbeNMcNEZIgl3xDPtyeMpR6LdrTvTNPjuodrcX?=
 =?us-ascii?Q?v+g3VYAkCDF+pyI3CW48CbaYKfrgFeHlTIY0jF+WbwdlzcrVrfDYEsHgCoD8?=
 =?us-ascii?Q?ZvcYYMdNNG/rv+e9bVRp7WtVe5OUkZ8BWYppBKa4ZSeN8CWbT3q701pY2Aqf?=
 =?us-ascii?Q?U+O6zVHhQJ+b3prRMLOGg/U2B426fe/gbcxGVH120EnYzBTKWvRePAjJhh/h?=
 =?us-ascii?Q?TN28H3QXigeoFXXeB7JHW94Rm1FnhF6ibo5xGBCx06hR04HdsdJcSH4mUTOb?=
 =?us-ascii?Q?2Qps1iD/T2xvjoRPrg3zegZOiKsrrE28cCY07pcKJOnKpDUDkvUTYAnJzZuk?=
 =?us-ascii?Q?IZsiZz9raYRk9mKI1YPtGkzWuIYaN9CW+kCqp2YDNuUceKserKplSRfqIz/H?=
 =?us-ascii?Q?HpCWwuBlLjnrwyIsBpqG5y2OobCREo3qCV8ob9As20IAEg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?nuc4AFI4RKl4GlBOp7N4GrKKKYoRS4tqOf4FF1VfHzejtkdG0wYIkmcgXMrl?=
 =?us-ascii?Q?ZuTQXywJsq8vdnriJmBkl3AVRao9jXZcO/J8Xz5abZVCaWpcbWYfxsqdeBJe?=
 =?us-ascii?Q?82H4wK41LJHsHPRJHin41tE8FV2fKJcfLOV3Lh6Q2GnBMLSpoIMnRTgsIQkk?=
 =?us-ascii?Q?0IdRr/lpUz/cVyCsr6KFeiHBDVmNYR/Pf+yg7YtS/ZvQdR+QlDtUUzpTWE31?=
 =?us-ascii?Q?tdL59bOOw9oPhNM0/vF2RRXb14Tv3jIIRujja4rNsp66JSH70EduGPn4x9zh?=
 =?us-ascii?Q?GXjlm9ZSqnK7tLNomXTuGhPCYxqU2GLY+nOWDNB0n6tGqK+fNvbWnkC71Bpv?=
 =?us-ascii?Q?736WJ5PagozscOrwxUY9mg8+sZIEP4anbOAyUntPGTS8cE5vC1XDA7WihrkI?=
 =?us-ascii?Q?CG8rCIAS8XUZOtQOxK8QS2obg2MPmGFIVC2UKaYNRIiRrtLrZHdNmGZ13cqS?=
 =?us-ascii?Q?S+SmX3cow0dT5xj+1IrYVsg+QL7MTwiNaXVC3l0qjdjZlhu0nnYGXDXcwJmm?=
 =?us-ascii?Q?n37by/Qc4cOOr5mvqBIlwUA89vrFmpjlmljTwpMXu2MbXNXHOD3MwZ+UV3Ys?=
 =?us-ascii?Q?C38sXzm5YPoRz39SDyZf4hZMrTkeyLLYHyG3Bj4fb15MgMK84yjhzY4wSOlj?=
 =?us-ascii?Q?LzxqdOQ3VKxhcL8JkW1tNYWPlWumcnLbDqq9+Z6kH6BR9KSBdRQddHjPvLxq?=
 =?us-ascii?Q?R/UBEIbv8VdLENXpYpEJVHt4L5LsDlGdp8YEdu9uRsDbV7lqc75QMf+8vDTZ?=
 =?us-ascii?Q?B476cYudwRpLV0Q6BU3H0fbCeOe1I4nTQsTR8iqwLK/HQHQHKPMsNh7C0J9F?=
 =?us-ascii?Q?1FrZ+5EafMQBkLMwMWyoQGg9XS0DS9goCkadS8DbDIf0X9SQmbZdZbgAV42n?=
 =?us-ascii?Q?nYaNHxpm3+/jvvFdCWkidCjxcLJBXGl8sgTeCbO7Xo9BArczE7sMVJx+orHx?=
 =?us-ascii?Q?+cP09aV8bv7GSN9+5EihR42Ln2GSTLLNCcNIqBvqBhYuPkKibdHoaBJiExq0?=
 =?us-ascii?Q?ubbUPvPeSbHb9HTTIl7q+7npNB6Oil0cg5mwmHOowZwNlA59SBEwmuy6vnqU?=
 =?us-ascii?Q?mzkyvCB3L0Xob1fbWeQNq3kfQv00TaLMtbalpf70dgy/BC99SMkUX39HKj72?=
 =?us-ascii?Q?dxdYfYn3mtcA0bC4gHRMqYvDQN5+/NzLbFDR7+iq9i0cQKJLr70RHq8lDtXr?=
 =?us-ascii?Q?5GY9JBSRNYqmqLl82JroK3yfLQHHkCasKiqoRDNy8SLuKlb8C2EGOWap7zXC?=
 =?us-ascii?Q?DXzVRQV6Z4GVNy/N8DgZ7gWJduONvOjRRAGoc0rrXDd3CTbR3BAJPYTdGrjA?=
 =?us-ascii?Q?rfsaCIGli0MWU9OmxNxqce8qFAYbTuWiR45gfZSF+TWHhTTzkWeRr1YjYW7t?=
 =?us-ascii?Q?3xjpqvN5wuk+aTJVpn2F7XU6tHFnPq1l1ieCyQW+Yq3M9ZADnHXFZ/9pDyWQ?=
 =?us-ascii?Q?rlL/59Suj/t9lIRnWP8QVfqhpRkj2jP6arGAHgonre1LoFlntUsXHkTDZ2ar?=
 =?us-ascii?Q?qDtj82KTXhci7ve8k/6sKzWvXA1Ql+jdRhwqSjpm4lrhoIgJhF8tODOctJvu?=
 =?us-ascii?Q?lcpe3Jo+RP72Iek0A93kDSNDD46+wX8U95C4fDgWJQYbSH1qEsS5ZMJTF3y7?=
 =?us-ascii?Q?Sg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 884c465f-bb22-4f75-f149-08dccb2d583f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 08:57:59.6910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +VdOr+rhs7rBiJNnXzylJYm5S4fwq88hUwQEyYlw/N2IlPjCTWuJ8VhToR2dOMA3smLNhqcF78ctxmrIv3TfDXs0dY8g7WEg/HPFeS10TGc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7490
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 02 Sep 2024 08:58:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16836

Hi Sai,

> I thought there might be some issue with the runners as the job failure m=
essage said, =E2=80=9CThere has been a runner system failure, please try ag=
ain.=E2=80=9D

maybe there was a temporary issue. I just looked at the cluster and it seem=
s to be (idling) fine. So I'd suggest to try it again.

Kind Regards,
  Michael

--=20
Michael Adler

Siemens AG
Technology
Connectivity & Edge
Open Source Embedded Systems
T CED OES-DE
Friedrich-Ludwig-Bauer-Str. 3
85748 Garching, Germany

Siemens Aktiengesellschaft: Chairman of the Supervisory Board: Jim Hagemann
Snabe; Managing Board: Roland Busch, Chairman, President and Chief Executiv=
e
Officer; Cedrik Neike, Matthias Rebellius, Ralf P. Thomas, Judith Wiese;
Registered offices: Berlin and Munich, Germany; Commercial registries:
Berlin-Charlottenburg, HRB 12300, Munich, HRB 6684; WEEE-Reg.-No. DE 236913=
22

