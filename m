Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABF3C27C53
	for <webhook@archiver.kernel.org>; Wed, 19 Jun 2024 13:44:34 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.58])
 by mx.groups.io with SMTP id smtpd.web11.21294.1718804670259743667
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Jun 2024 06:44:31 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=rv7GODtc;
 spf=pass (domain: siemens.com, ip: 40.107.8.58, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ccs8IARqRkeiS3Sfr5vHgbELgfGtwAiBe6Yz1TtOHkR546v8kqvqX37ARdqtB+MSONdqIvxQuuxB2DYh74+ykOago3aVYiWM0jG477IZ70iNiL62x5yj5FQJ8nDH0R5zhVzkEhNq5+jiV79jHo1QqeD1q4ezVt6MjhakGq9mMzRNiHYddJ8ecqJrM5Jtg2DIkpy7EuiBuZ7GhmrJXQEnYlK9sRudC525V5htv937YqrgbhgfyC1OEnb7Wmm7eAXPeCegwxTtkzYVEOIhc1KUegT+U71Fd3h+n150efTOFai4adX7C0lNUCd6y639X8vz8+1W5h0HbRbIrUCpWLLgJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fDfrFKvMoiAkFYXpdmBQB7fKQiq09QkYX6Qvd1Ysp98=;
 b=F1L3D3Dc/zUqGVcPZtqzFmVUoHCuGbhuINaBS+2oAu9tI2zZ/8GDxweWaQcXABmhNnhozkwVklTCE9fyg/fDq1vMZR7VC6ic+p/FKdyuvZCzALcj92JiQV9ApFUN5iVn7pQD2Kv1GkcQRFUYH6cl0VbUPK+tBUpi1tROTvtghyFeLONf4Mu5SWwcBUgfHNbK2XHjAD5wXLQNk3elrau5tIsVHwb6gBplXyoX6eeSrn0wFn3R1zKPPmdt8dO1vhIPXi6A7XWiZHqmdY9ctyq0jYXjf4J9d5Mw04o4fiaQF8Hn7fhHTixluYzgUmOMnTc0VyOwjUpsC8IdBYanRgp2QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDfrFKvMoiAkFYXpdmBQB7fKQiq09QkYX6Qvd1Ysp98=;
 b=rv7GODtcSmOrhHGzzkvIXeftkfC6NGjRPCH+j7qhUV114/Evi4bkh6nHh+oieMVzDzC8bZCW4WhigasXUDG6VZ0kpuQiX2F/+9X6NG8o4lYvE7RkCILoO5PJkYO13xO0AhJIC0poNEnqPJ15pP4EwKWyTRXOKzNBmE9Z0jrXGodROrf59wYuIaGFrggMfrzn45rQNobgTJ6W3ywnRctR7CfFJAduXGwGJui93DtqI36P6cXZ8TRaC5A9ghwYn67PkGNhufnLTYgrv/dyLpXEFOACk199huYXRb/pSHE7lLHEd24mYJzDonAScrfisIEVssKszwYPHXXH5YWC56nHew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7325.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:617::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Wed, 19 Jun
 2024 13:44:26 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7677.030; Wed, 19 Jun 2024
 13:44:26 +0000
Message-ID: <83b72a73-08a1-4888-a453-6d2591dc365b@siemens.com>
Date: Wed, 19 Jun 2024 15:44:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Unable to start cve-checks job because it cannot be picked by any
 runner
To: Sai.Sathujoda@toshiba-tsip.com
CC: cip-dev@lists.cip-project.org, dinesh.kumar@toshiba-tsip.com,
 kazuhiro3.hayashi@toshiba.co.jp
References: <OS3PR01MB610300320EFEC1A03B28BAC1C2CF2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <OS3PR01MB610300320EFEC1A03B28BAC1C2CF2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH0PR03CA0426.namprd03.prod.outlook.com
 (2603:10b6:610:10e::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7325:EE_
X-MS-Office365-Filtering-Correlation-Id: cd3cb016-b2e8-4b92-04f5-08dc9065ef88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|376011;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?uSYRNQIwz6mCohYumpjucRqFxxwssUNoRPywwxPqSxq32xBvvF2wpTmE7kOq?=
 =?us-ascii?Q?Qsptq3CzibQkPeeM9rMPE4deVlzwbpJiuz9u7eQW9Ey7scFrh05VYXBJ0eKe?=
 =?us-ascii?Q?FjVnL5emeTnJgQm1J7a9eNfrkXv7O31avZ4g+vKV0Tk8tRket5qATCYDTsRy?=
 =?us-ascii?Q?l8/4412lyGZMQTZG31X1jXAIy1MXWT8moRnzLYvKwJE7yZiwcHpi/rMXOmzi?=
 =?us-ascii?Q?XzacOJ1RmyhLFECf//tdzVe6GRUC+sZag0HS+NUM/tfjzmt9VkWSqqKX6PX4?=
 =?us-ascii?Q?vekoB+fShhumYCoadIizpObH9T1YZfzK+1Ep6mSVyNVKIN71dvvmR7nqtrd6?=
 =?us-ascii?Q?ne8Rm5ZbpW8ucAtZhciz8XcasgySqpl7ZpPfuM0c7Z224q0MoaMOswEhwwQv?=
 =?us-ascii?Q?PWNfLdP2kli0HWEgx/xGk2Im9kvBt64YmVDsbvw43QNvSSHxPwC+4jlnpRq7?=
 =?us-ascii?Q?url3w1QHS8p/lmshCa0FKZRGUgOD5zY4aDxm5KQWnl6OdScM6ELvjsgvihLI?=
 =?us-ascii?Q?FrG7cX9W0PNu+hdZSQ5ZpSnbZRr2Y/xA932CQBOq1RffWTP7KYiUMEB1OCu/?=
 =?us-ascii?Q?ZbKEr3btTGY94VCHNT4jJ7f+c+mjOi4bdSIpRnyh9ab7YWaz1l6ouLKM0dnw?=
 =?us-ascii?Q?LMi1soXbqRlATVVj2v52vlisqW5ofTjP1och8RtORLEMPpvPgVX047EoJXpo?=
 =?us-ascii?Q?2ZWyZLoQWar301oq7/Kc/fLEjbIDPpxO4DIK8Q/rlt1UXjPzJpkODZ+R6o/s?=
 =?us-ascii?Q?CD0SQa1zDQHfBjS1WFd8lXElYBXgSjKHpzroMGLHafNZuuANQ5dlUQLTzFz1?=
 =?us-ascii?Q?EL1wvKuSybrsZjZkS2Pmp+oNl/AaHMPM5flrdFHWFVfT/T0G1osZovlS+9sp?=
 =?us-ascii?Q?sVlaPIl4+DPeZ8b3amLz2rle7LJqtGFkA7wzDXXTFJ+alahNoAi2cN9ifm0C?=
 =?us-ascii?Q?0xIWTB1iMgVt6LmiOFbBkStbRflqu+2ZYQJAUBF3vH06bl7DD6tPN+g4NUm5?=
 =?us-ascii?Q?ojI9pIAc19vZUElX9zBUlKY8bNfjqJNdbbxZltlXeO588mD8Eryy58zx4VgI?=
 =?us-ascii?Q?yj8XfNkp2+GOj8jylwVfiY9zYjju4LK3xt388bGixfxsEgC/u/PLoJjzM5Ml?=
 =?us-ascii?Q?thzRcIMPacC5Ucw+ZAKTxtzKn+LqRkm9dIZvHSjOdtxtFwHI4orn6GjXYa7L?=
 =?us-ascii?Q?PckDSGyyzR4mgweKspxhGuT5GrcmWn/j8A4PhBLCBkpIPbElayBcjas3IGZR?=
 =?us-ascii?Q?YefjlgTfqEWbS8LEnLD5?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?wTklWlMtu7iOhgmRgvq7GDX6MsjEBAIPhxkfGXuvSw92CBqvsN7yUW2GN4aU?=
 =?us-ascii?Q?n2akYFrs+Rn/BWhMdb+ULNJhqLnNyuk9G4ZR9p2nqO8sL68RRZpIPlfM7eC0?=
 =?us-ascii?Q?iinkWwGj1877kprCN0Iu80HkxJgp4ECzYIj7+N9BRjdWfhfqEKame/wsfcmi?=
 =?us-ascii?Q?H0lzeKIEQfoaphxryluM6w7jMNekbk2w0iRMkVaqK5d47XPq4a1zxQXnsuBL?=
 =?us-ascii?Q?Ohxu6PQGW4WV6/YBODwryGhZu54uLeg4sPu4KzxyLLyyM0Ktm3xEdSLAgzYk?=
 =?us-ascii?Q?ub/jIe6QUoPshiWToIR2HuVEiBJ+7mbuXzwcerv8hN/3gaNQU7jxJbuAw6S3?=
 =?us-ascii?Q?t3Fipvw6Dai6SnbJmFwxO47XCbQ5QfElYmRMesYMNLN4mMle8GSVJm95oGHs?=
 =?us-ascii?Q?3Dor2ghOW/CElUHnsArwP3oX86tZeqrMJVix5lgBKZPPfnKTit8gUYu+4tKt?=
 =?us-ascii?Q?Yig+xmG0WyG7vTjzEkZY/9TLLIP93x64Ue/XjvYPuOQ2decO7dzCiYqKwQ3G?=
 =?us-ascii?Q?MrWkEl1PAd5eH71KMKQpXeF58dQDuIF3e7Wwl+/wIYh9ArK91qk9XTymOD6Q?=
 =?us-ascii?Q?iUIKOo/cuVimbfo9CIb2W6ndF4X1d30FA/kJ+NWylokSxW7M1XoT7/lrDmSe?=
 =?us-ascii?Q?Qb90/Y5yFqT9BIVrOk0+SrMKl4jkPNZfuRg9F5PkPtgicj8uotCKvV4mmiPR?=
 =?us-ascii?Q?gJeluCFs0srEozAJBOB8S4oZFW0q7Rfk9LGsqR9K8rhoL12gSkhdRP59Etmj?=
 =?us-ascii?Q?BtdfzAs3Y01369CN8ReRdeAaKhvzvqNViwqL2xzq2bbixe+KLhcdvpLVhdKR?=
 =?us-ascii?Q?bzmN1/nhJ19V8TKeMhKqE3lw6FyLS2x2rkq0V9vh40kOd3UqDnh+Uf0hAUUR?=
 =?us-ascii?Q?IrxVKFViObAFRy11HIEU0gkEe+DYTFAPE0q+WYHOt8W9Bl5MWb8ZndmNbNxI?=
 =?us-ascii?Q?kEN+5n2PKl4Xhqi24XcR3Y+CCLMHxfUal8FniSMzbqmJGgFwNkJdmtf1/vKz?=
 =?us-ascii?Q?GGyLrZ9Zhz1+5a4Q0Idpbtd4nfEZIB8UBKk/sj8nW8vdEaJOBp0CsW7niBSB?=
 =?us-ascii?Q?Be9B63xn3va9vaLxQaybgtxVTnXCTXLevcCCc0R2FkSAEHghvVz2f8rIc+Y2?=
 =?us-ascii?Q?D8rtnY/hFAHtEggUo9LFqOn9yqNzmnrxXVVPBcCOv+bzQ4Mv4xzhTp98Uvlk?=
 =?us-ascii?Q?arzaUeO2b0KHdM3yuXOEy2zGqOPQY2Vx+LOfEddjS09im+4d6mpn2ng7iKnw?=
 =?us-ascii?Q?F9a1tFoh02a37uSvCcoTbyP1fcqlQb5rW8uksZnMM24HXYfpHVrF+SnjpHvd?=
 =?us-ascii?Q?x+d+Q5mlsnbRgiiw3xQPTUtY01aAN+l7cJgk/RezsvqT2jTBJuPKumUpGGPz?=
 =?us-ascii?Q?EexRx/efq+FU0j9u21AhjKS0LXJS5Dbf57RQneM/CU24nEyr7dDX7aSVgiDS?=
 =?us-ascii?Q?37KOZHODPk/FgW05QNyOxgXAJ7EnjZqFwVwHmT60ODWrYfXaGMZy8pI6dFiU?=
 =?us-ascii?Q?m9CT43y767W5CD1Tuas0Ws8h+kltAY+yBEBYdJCP0Yf1rkInFUaxLA6GL3o7?=
 =?us-ascii?Q?9Cx1g5gMXdckjKiR9HGtp+eyjMpsTCoGqsetZtzMWDbxInCoMMiqygvAbtbi?=
 =?us-ascii?Q?3w=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd3cb016-b2e8-4b92-04f5-08dc9065ef88
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 13:44:26.5987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8686aL83zjZsYEU9D15GsbefzZ9zDUERkNcVebrjfXLxrDL+jlCNjkUCf2cF4W1Z80/eNDBL9zeT1+pn5SODPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7325
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Jun 2024 13:44:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16295

On 19.06.24 10:53, Sai.Sathujoda@toshiba-tsip.com wrote:
> Hi Jan,
>=20
> Previously *cve-checks* job can be run manually in a pipeline at the
> time of applying this patch
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commit/bcc87ac530=
9b0c606eaba3a760ab5fd5acce5a3a <https://gitlab.com/cip-project/cip-core/isa=
r-cip-core/-/commit/bcc87ac5309b0c606eaba3a760ab5fd5acce5a3a> even though t=
he job has no assigned tag. But now when I tried to manually run this job, =
it is stuck because there is no assigned runner to pick it up. Is it OK if =
I send a patch to assign =E2=80=9Ctags: small=E2=80=9D runner to this job ?=
 Can this be included in the upcoming release ?
>=20

Hmm, that used to work... We likely need to tag this stage with "small"
- kicked off a run with that.

Jan

--=20
Siemens AG, Technology
Linux Expert Center


