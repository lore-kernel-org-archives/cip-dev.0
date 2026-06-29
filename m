Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C28C43458
	for <webhook@archiver.kernel.org>; Mon, 29 Jun 2026 10:18:42 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.14])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.34585.1782728313494851432
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Jun 2026 03:18:34 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=oZbwf2jc;
 spf=pass (domain: siemens.com, ip: 40.107.162.14, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fsnu+jtPrcyLP7Fi/vp/2oZlRqU6m2bP0ej6YKgajZh0g+wKRzFhrlW6W0L4yccFddvsk4KUFPADKC0W0W4Ln/ZqgX1gZqC5F1UCJjd55CyAPY+3MKLyQNfyQRIRo5BmvPppGZlkCQ+A9XTRvPC+94P0ELBXDgo3LV1am2P8r/uc76h4C4qHlqX6nY2o+T7btjF3cvkYewdNu1lIT/Wsshz6nc5O/96Zzo+3iwqdosWElHspQk3sAcXmxq5w6tlVYIJGT8/qujI48FuyAvMprpFbgY9IlGFgTm3KwsUJaO+Avw6WUGfmSXtAAn8hCN2vWUz/j3Q1835ja0EhbHlYCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujIgBFZQOJCuwidhwr7t2iI90bShgVNFl2XAct+ulWg=;
 b=BCvaJL0Z6UjT7w/XFUEfunJ3f+PwGccfy8WnMAw7i91VYkjT+Lo/355rrk9EW7IbMpg2jGG27hiT00qwWHp/MmZCfeEkmTijghYSKTH6OqCt7lxIXy6MgqOEqWLHcd+SlADKYmVKVcf40H9P7KQu/Y8G/qpbF9Ebyna8Lk39QSNs78+Vu1DrugNPlFyXuZ0ERCECuVqOTWDzE16eSjTMowA3l91fE9O9STRIfq9HCtFatMh4qHgPMkDZenTco1Nv7JqoKPBSEU0+wt9SpRtPJrzamWUlR9SCy+Y240C7UyOkKMFg0yHeH2V5fccrUw2RwH+zIwzdwu4dLPvhmsb5SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujIgBFZQOJCuwidhwr7t2iI90bShgVNFl2XAct+ulWg=;
 b=oZbwf2jccwuFlo5P58oC+xYyCUWpS5nkV60Qn7gupXMsy5ZXsHPgDB+4dwfG2QVlgHPBGpdPOauv9WMpbM+4yMNdpqc7IrTuNTPjmbaClet05WYzKkjEiZ4qbifH7VmWh9UuIkvR7TOifkRduz0FsLxlmpL5rF/HmRuQjW49ahhyCrQxY/0XtgqZZXYxQb6VvJOULVaCacPus06/w/9AuLyjUuPaz5dD500DIsMB+R2OXH4vwJMU7FlyiYVS8CjEwm/mq3vT2r/vgnvIsJVAo9RTCeCxIzdnK0hu4ucIftzr//U02uDWBs9IgZtNRC6NEfVPQ5E1+tIlg04m4PnJdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VE1PR10MB3952.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:168::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 10:18:29 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 10:18:29 +0000
Message-ID: <d109ed7e-ede4-4e0e-8651-b59fff75d8ca@siemens.com>
Date: Mon, 29 Jun 2026 12:18:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][PATCH] Revise README files to reflect
 the latest changes
To: Shivanand.Kunijadar@toshiba-tsip.com, cip-dev@lists.cip-project.org
CC: Adithya.Balakumar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
 kazuhiro.hayashi.f74@mail.toshiba
References: <20260619105617.1891671-1-Shivanand.Kunijadar@toshiba-tsip.com>
 <8b2cfa70-08fe-45ff-8695-7564b37f36b8@siemens.com>
 <TYWPR01MB11063B595D1725A7B252067EAC7EF2@TYWPR01MB11063.jpnprd01.prod.outlook.com>
 <TY3PR01MB11075F67BFD39AEA29DD9D095C7EE2@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <38ec0a76-9e33-4976-a6a4-612b4c12d935@siemens.com>
 <TY3PR01MB110758EEF7898CFF2649036BDC7E82@TY3PR01MB11075.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 xsFNBGZY+hkBEACkdtFD81AUVtTVX+UEiUFs7ZQPQsdFpzVmr6R3D059f+lzr4Mlg6KKAcNZ
 uNUqthIkgLGWzKugodvkcCK8Wbyw+1vxcl4Lw56WezLsOTfu7oi7Z0vp1XkrLcM0tofTbClW
 xMA964mgUlBT2m/J/ybZd945D0wU57k/smGzDAxkpJgHBrYE/iJWcu46jkGZaLjK4xcMoBWB
 I6hW9Njxx3Ek0fpLO3876bszc8KjcHOulKreK+ezyJ01Hvbx85s68XWN6N2ulLGtk7E/sXlb
 79hylHy5QuU9mZdsRjjRGJb0H9Buzfuz0XrcwOTMJq7e7fbN0QakjivAXsmXim+s5dlKlZjr
 L3ILWte4ah7cGgqc06nFb5jOhnGnZwnKJlpuod3pc/BFaFGtVHvyoRgxJ9tmDZnjzMfu8YrA
 +MVv6muwbHnEAeh/f8e9O+oeouqTBzgcaWTq81IyS56/UD6U5GHet9Pz1MB15nnzVcyZXIoC
 roIhgCUkcl+5m2Z9G56bkiUcFq0IcACzjcRPWvwA09ZbRHXAK/ao/+vPAIMnU6OTx3ejsbHn
 oh6VpHD3tucIt+xA4/l3LlkZMt5FZjFdkZUuAVU6kBAwElNBCYcrrLYZBRkSGPGDGYZmXAW/
 VkNUVTJkRg6MGIeqZmpeoaV2xaIGHBSTDX8+b0c0hT/Bgzjv8QARAQABzSNKYW4gS2lzemth
 IDxqYW4ua2lzemthQHNpZW1lbnMuY29tPsLBlAQTAQoAPhYhBABMZH11cs99cr20+2mdhQqf
 QXvYBQJmWPvXAhsDBQkFo5qABQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEGmdhQqfQXvY
 zPAP/jGiVJ2VgPcRWt2P8FbByfrJJAPCsos+SZpncRi7tl9yTEpS+t57h7myEKPdB3L+kxzg
 K3dt1UhYp4FeIHA3jpJYaFvD7kNZJZ1cU55QXrJI3xu/xfB6VhCs+VAUlt7XhOsOmTQqCpH7
 pRcZ5juxZCOxXG2fTQTQo0gfF5+PQwQYUp0NdTbVox5PTx5RK3KfPqmAJsBKdwEaIkuY9FbM
 9lGg8XBNzD2R/13cCd4hRrZDtyegrtocpBAruVqOZhsMb/h7Wd0TGoJ/zJr3w3WnDM08c+RA
 5LHMbiA29MXq1KxlnsYDfWB8ts3HIJ3ROBvagA20mbOm26ddeFjLdGcBTrzbHbzCReEtN++s
 gZneKsYiueFDTxXjUOJgp8JDdVPM+++axSMo2js8TwVefTfCYt0oWMEqlQqSqgQwIuzpRO6I
 ik7HAFq8fssy2cY8Imofbj77uKz0BNZC/1nGG1OI9cU2jHrqsn1i95KaS6fPu4EN6XP/Gi/O
 0DxND+HEyzVqhUJkvXUhTsOzgzWAvW9BlkKRiVizKM6PLsVm/XmeapGs4ir/U8OzKI+SM3R8
 VMW8eovWgXNUQ9F2vS1dHO8eRn2UqDKBZSo+qCRWLRtsqNzmU4N0zuGqZSaDCvkMwF6kIRkD
 ZkDjjYQtoftPGchLBTUzeUa2gfOr1T4xSQUHhPL8zsFNBGZY+hkBEADb5quW4M0eaWPIjqY6
 aC/vHCmpELmS/HMa5zlA0dWlxCPEjkchN8W4PB+NMOXFEJuKLLFs6+s5/KlNok/kGKg4fITf
 Vcd+BQd/YRks3qFifckU+kxoXpTc2bksTtLuiPkcyFmjBph/BGms35mvOA0OaEO6fQbauiHa
 QnYrgUQM+YD4uFoQOLnWTPmBjccoPuiJDafzLxwj4r+JH4fA/4zzDa5OFbfVq3ieYGqiBrtj
 tBFv5epVvGK1zoQ+Rc+h5+dCWPwC2i3cXTUVf0woepF8mUXFcNhY+Eh8vvh1lxfD35z2CJeY
 txMcA44Lp06kArpWDjGJddd+OTmUkFWeYtAdaCpj/GItuJcQZkaaTeiHqPPrbvXM361rtvaw
 XFUzUlvoW1Sb7/SeE/BtWoxkeZOgsqouXPTjlFLapvLu5g9MPNimjkYqukASq/+e8MMKP+EE
 v3BAFVFGvNE3UlNRh+ppBqBUZiqkzg4q2hfeTjnivgChzXlvfTx9M6BJmuDnYAho4BA6vRh4
 Dr7LYTLIwGjguIuuQcP2ENN+l32nidy154zCEp5/Rv4K8SYdVegrQ7rWiULgDz9VQWo2zAjo
 TgFKg3AE3ujDy4V2VndtkMRYpwwuilCDQ+Bpb5ixfbFyZ4oVGs6F3jhtWN5Uu43FhHSCqUv8
 FCzl44AyGulVYU7hTQARAQABwsF8BBgBCgAmFiEEAExkfXVyz31yvbT7aZ2FCp9Be9gFAmZY
 +hkCGwwFCQWjmoAACgkQaZ2FCp9Be9hN3g/8CdNqlOfBZGCFNZ8Kf4tpRpeN3TGmekGRpohU
 bBMvHYiWW8SvmCgEuBokS+Lx3pyPJQCYZDXLCq47gsLdnhVcQ2ZKNCrr9yhrj6kHxe1Sqv1S
 MhxD8dBqW6CFe/mbiK9wEMDIqys7L0Xy/lgCFxZswlBW3eU2Zacdo0fDzLiJm9I0C9iPZzkJ
 gITjoqsiIi/5c3eCY2s2OENL9VPXiH1GPQfHZ23ouiMf+ojVZ7kycLjz+nFr5A14w/B7uHjz
 uL6tnA+AtGCredDne66LSK3HD0vC7569sZ/j8kGKjlUtC+zm0j03iPI6gi8YeCn9b4F8sLpB
 lBdlqo9BB+uqoM6F8zMfIfDsqjB0r/q7WeJaI8NKfFwNOGPuo93N+WUyBi2yYCXMOgBUifm0
 T6Hbf3SHQpbA56wcKPWJqAC2iFaxNDowcJij9LtEqOlToCMtDBekDwchRvqrWN1mDXLg+av8
 qH4kDzsqKX8zzTzfAWFxrkXA/kFpR3JsMzNmvextkN2kOLCCHkym0zz5Y3vxaYtbXG2wTrqJ
 8WpkWIE8STUhQa9AkezgucXN7r6uSrzW8IQXxBInZwFIyBgM0f/fzyNqzThFT15QMrYUqhhW
 ZffO4PeNJOUYfXdH13A6rbU0y6xE7Okuoa01EqNi9yqyLA8gPgg/DhOpGtK8KokCsdYsTbk=
In-Reply-To: <TY3PR01MB110758EEF7898CFF2649036BDC7E82@TY3PR01MB11075.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0276.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VE1PR10MB3952:EE_
X-MS-Office365-Filtering-Correlation-Id: e8066d68-899f-42b9-f4f8-08ded5c7c39b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|18002099003|22082099003|55112099003|4143699003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: 
	+df5/k2I044XIvVUYqokYB5WO5ZziGorQBqp1nEv78vjc8xMTEun4WJd2aiuxc9NVhd1CxlPobZ77p6qX2N5kwZJLLDqEBNih6DdvE1qaO01xr7MNA66VXTZ0Ggc/kY9wtGMNv791GiBDQ+V9qQjQ4uDBXeRzG2xeKgGJ9yJahYSlSLtn8hs2/sSsXH8F63lOCLUexeVwUCwF9sqzp5bqK1kZTZYihbuu7jXp+6119rUURHsXEIupHyLeIGTBJanL5O+pnksem0MXtWaLNy/NKRGhU3gbc3vG5FkH31ECl++in3jq9RxTK2SKvrFnEV9ieCoWMpqDWig3SZcBXmwhEEzP8VOP9SK4LKM6No3aDcmQzokcXElNiIE5LIuhMOGGBWktGskvIjZv1v3R3hZt8Crb4OrOWN02V0bOYPBFHDk3tWC+qV7atQv+EZZwx71w/9qqOvVKbSatttszTPwVxM1XCzSehz7BoPwW2mepZP6Dc+tT2IeSd8UlA/tlUGwd+Lt+rpei1geZWzLaHKGhYt8k+02cRUS4W//EiuCLUNNndBKT4/EURoKCI9Cj6R+vZMMn2XFwt0bCD2YBt2rokYsWnygVm/RMB2dpF53SNDAu2PUrxeQ9wFPBMxg5cLH6wZ3u/MgJXrZqYuaezcgn65DCrjrirdnaz8qqVB8Po0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(55112099003)(4143699003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ZOeANdBoEMaKvJeNIvCoO/ZqpfCbyPoZJviaQbwzOw1uDiZvoT1qvWChKZUA?=
 =?us-ascii?Q?HxcbaOc7U41RcS1orDuOMBHr/kIpyoXCzKXm4a58pWKImQQvsurpHr936hcA?=
 =?us-ascii?Q?FXB83cJJ/328elkBGd90HWSCP2pt7ytMnyDCOo3DYm0NnbAo1/RvdOuFl/zb?=
 =?us-ascii?Q?+XL8X4SqSI2rd76qdTTK/iAEMEUnxb4a68dzs7X6EbynEanFJR8n+nvK2tr9?=
 =?us-ascii?Q?rt6csjwInhwC1l3JY1o8Gylt5LnkOxzEFVFIijXegGJw9UzW4qNrExGmmO7I?=
 =?us-ascii?Q?b3i8sOnFkNTjgPWC61h5zKIVebF75dcKaqQzQkHXdrdqlF9EsSrTNIMkoYNZ?=
 =?us-ascii?Q?+KN6jfa9HjG32V+eHb6RKW1LOvVgRByC2IJTS9E1ByHApA0COhNPhhL8QRrU?=
 =?us-ascii?Q?lFVNRRzoQqx5Ei3ODeeg9Ap/iQ5xSTjknecHDef9Pb0grO6oUS5VSm79xsQj?=
 =?us-ascii?Q?TBDvGOs2O5DKtwgsWKqEbqLjmLSRJSWOLmfwMSOVxLP70j81ZdROf0Q+tkGp?=
 =?us-ascii?Q?pB3zM2b6JAF26iywBHz35aGF2pGP1xjAJsFFJw0Ejab6cy1IeLOI7XObEmDF?=
 =?us-ascii?Q?FROB3S9PN+Jxs1/DOBp9j4qO3hNhgIJmyPHAnpoZFcsfIdb/NnR9Yw+xOE8M?=
 =?us-ascii?Q?JUq/oOj1X9+2OEN05MQeWokl6XycO3aipflR2s9msfz1h5+O6PpjTjNki9F1?=
 =?us-ascii?Q?bhOTQncCQL/VuR42to+LG2Z8PK6IaTlwB0Rwvb5wt6L3wm1cRYxd0bKEQTuo?=
 =?us-ascii?Q?DfHeOqIPgU9jAW/oHyvEt/OSUVfCrumEMfZ49jAy2cTOwpFuR3LbDlB+VKFq?=
 =?us-ascii?Q?YCbYuwG+UhAw5lAuRBuIOtmv3qJgGSUj7E4r9vKgQ+n6QoodHyNkQKuszlAM?=
 =?us-ascii?Q?QnDQjWhLb7F+xxx7+lIEk1oJa41t1qhoFAl9mwvuEzAeDRPFuERLwVJP8+Cj?=
 =?us-ascii?Q?S3Hp+J0aYbjhw6lmDJbNKxJF/H4O0+1Rpg4WiVLCPCSICwWkDaUp20aWQVVv?=
 =?us-ascii?Q?48oFSxpG/+PJxabCKIb4i9wF5SyZz6JAjR79YhEx48+O057FzNuugKPDB2Ge?=
 =?us-ascii?Q?KGCmhI4+tyx3x6fBV4aCoBg9UhWrhF/EFkVaFn1P64hEN2COTdwRDOVYQb+7?=
 =?us-ascii?Q?Z6KLCZc0QNjNHr61/DzOVGZLwAFJ9nG6VJPo2QBpdxn0EclWQhSdjx9cepvx?=
 =?us-ascii?Q?O2iUe5z3JubvaEa4pliVsup0olZ1l7XKws7JfplkL8wiIz2U+wd+WBZm/Ogk?=
 =?us-ascii?Q?h2MZsJFlvze0VCdoaNQ1tW/n6Vc5A27l2+aci1z9DlL/+Hr6AOAVKb755fU1?=
 =?us-ascii?Q?PWqJ7D2rMw5+ZM+dCZkm1B+HlVyZekfszchkLUurqONJPvs6wHAtSZlp5z5K?=
 =?us-ascii?Q?co+US0imUNlDYp1Yd61DbEJtyon2k6mCZKa5OJ+wQuB0IpDwq72nEtKo9p1+?=
 =?us-ascii?Q?YyoB+VnE4cDD0vw4ZPl2Y1QowOOSzUdPLlV3DLqkYDFevYiYIbET9Otr5ejx?=
 =?us-ascii?Q?NF01FR3gqCl56LJ4E/fMoNT7C8lND3G/21Uw4wAhU3Z5OSj17JJ4YBpnXXdX?=
 =?us-ascii?Q?zIMjPdga+3YpDNRo4iUCNN+5vqs65ZVaOrjZsIYPsfUYKGAbEXKYhd3eo4kC?=
 =?us-ascii?Q?JuOk2RPFfarOUR0NkRE/iRJvFJfPz9q4/vWWmErZNZyNqhn4TpQVjs0hwCnZ?=
 =?us-ascii?Q?zuEMYLSRE3AyHgpPHwWmp+XD1RKrSR/TZfq2tjLK3zYOKBD2dCiRBqG0srmx?=
 =?us-ascii?Q?qtYecGzH/Q=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8066d68-899f-42b9-f4f8-08ded5c7c39b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 10:18:29.1776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d1bXot4Dq83KBUDgGap0KndPc4G1HSr8v3Ck8B7bI5SozgqecZEd8rSvvKWjKwO7K7fy5pL2C0aUI0bXWHVLyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3952
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Jun 2026 10:18:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23300

On 29.06.26 09:14, Shivanand.Kunijadar@toshiba-tsip.com wrote:
> Hi Jan,=20
>=20
>> If we need to install that package only for having lsblk showing more de=
tails, I would not consider this a worthwhile step. Anyway, the key is unde=
rstanding what is happening here, then we can decide.
>=20
> The information about why "system-cryptsetup" is required in trixie is me=
ntioned here https://gitlab.com/cip-project/cip-testing/cip-security-tests/=
-/work_items/8#note_2986054640, please have a look at it. As mentioned here=
 this package is already installed as part of security image. =20
>=20
> If we don't install this package then the lsblk doesn't show any informat=
ion about the current root device, in that case we should change the confir=
mation method (rootfs switch) to use "df -h" or some other command instead =
of "lsblk". Please let me know your opinion. I will check it further. =20

Just as I wrote: Adding the package only for visualizing is overkill. If
there are other use cases where we need it, then we can add it
unconditionally. If not, then continue to leave this to the final
integrator to pull it in or not.

Jan

>=20
> Thanks & Regards
> Shivanand K
>=20
> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Jan Kiszka via lists.cip-project.org
> Sent: 23 June 2026 18:01
> To: kunijadar shivanand(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 DITC_DIT-OST=
) <Shivanand.Kunijadar@toshiba-tsip.com>; cip-dev@lists.cip-project.org
> Cc: balakumar adithya(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 =EF=BC=A4=EF=
=BC=A9=EF=BC=B4=EF=BC=A3=EF=BC=BF=EF=BC=A4=EF=BC=A9=EF=BC=B4-=EF=BC=AF=EF=
=BC=B3=EF=BC=B4) <Adithya.Balakumar@toshiba-tsip.com>; dinesh kumar(=EF=BC=
=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 DITC_DIT-OST) <dinesh.kumar@toshiba-tsip.com=
>; hayashi kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=8F =E2=96=A1=EF=BC=A4=EF=BC=
=A9=EF=BC=B4=EF=BC=A3=E2=97=8B=EF=BC=A3=EF=BC=B0=EF=BC=B4) <kazuhiro.hayash=
i.f74@mail.toshiba>
> Subject: Re: [cip-dev] [isar-cip-core][PATCH] Revise README files to refl=
ect the latest changes
>=20
> On 23.06.26 13:15, Shivanand.Kunijadar@toshiba-tsip.com wrote:
>> Hi Jan,
>>
>>>> Your dump is missing the verityroot container. Does lsblk no longer li=
st it by default, or were/are there inconsistencies what was >>configured v=
s.
>>>> what was run?
>>
>>> I also noticed this missing verityroot container in the image. I confir=
med the secure boot is enabled from the boot as well as dmesg logs. >Howeve=
r, the "lsblk" command does not show the verityroot by default.=20
>>
>>> Probably we may have to install "systemd-cryptsetup" for non-security i=
mage as well, see the fix for security image here[1].=20
>>> This package is available from trixie onwards.=20
>>
>>> [1]=20
>>> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commit/36b111
>>> 92674082aaa1228c60e8c0239fa7c94111
>>
>> Any comments on this update?=20
>>
>=20
> Oh, that was a question: If we need to install that package only for havi=
ng lsblk showing more details, I would not consider this a worthwhile step.=
 Anyway, the key is understanding what is happening here, then we can decid=
e.
>=20
> Jan
>=20
> --
> Siemens AG, Foundational Technologies
> Linux Expert Center


--=20
Siemens AG, Foundational Technologies
Linux Expert Center

