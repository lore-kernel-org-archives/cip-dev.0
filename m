Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0123ED3C53F
	for <webhook@archiver.kernel.org>; Wed, 10 Dec 2025 12:46:42 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.22])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14599.1765370794738419781
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 Dec 2025 04:46:35 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=Hg/UPEdy;
 spf=pass (domain: siemens.com, ip: 52.101.69.22, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=relDhD4uwzD2SfpQDkRKU7Ck+RLqEMaNVDRYBSlt1MyTV5nb70NEgadg+L+nHXdtO8TnUE/eX8F5Eq70CoYgPg+i+VR2I9VpXqvq2nRAxDSuhsBVIPAcHyKlc49CjUcFp309UQCFet0bU0R1hMoz/WgI2sUaK1ADOET2MmDuGTYXCJUhvWyEYj8PFHYvZaaUxk7dw6JVND1i8qiwoSdhpVCTgTQUk+IfAjFBPMIClxbIuWJVS45OGlwJ5Lws4WsRPWChAfYv6WXG9cIxlXF7bLqueB9c86CxR2vmfFmbUQWOBOO93ALlaH39S4VyaNBUnlP+Q0R2DyKrNlGh4zbqqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2m1mXk0gJe2GvMre/FI3cO4ZMY4gd82Kru73ozMBNI=;
 b=wZeGW7hY7xzaxrgEbn9/DXlHNJQuqnHcWPnHvg1+Wt0fzb9pewpDuNReaNWCr0DlA4/QVfGfyd/I+97AbdkbGhraQuB7Tl98g78YgvlXY91H1YEzA/BxqlK6IbK39eLRq31BkN1B6SDfE5OX8OdZfUcTG5pXjjDzi8mXHvWcU7LCuLKCgT1XfWYIIua5D+u6Y2S/rFaRgv268ie2Ap8jEhlLfwTihQ264rtnfcDieG2ALbIS954ci7FWO3VVvn9a4Xkp7G0qmqgtACY6d6USURAyZrADd+0CTOlMohydwP690h1w3lUxwIuTbMmEvjXi2XJHuKDADS4Y/nCTW8m8/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2m1mXk0gJe2GvMre/FI3cO4ZMY4gd82Kru73ozMBNI=;
 b=Hg/UPEdy337EWqj2I7VS3gsHOcg03gx2YM86nawamELxgcZDb9h/VDHBcjSvhTwsfXzIAVX74y4Eb/O8DtvWWCqZhQkBWwzk38PYI+QStpDZqpwtzmyAt2Onrwrer0f54skW6do8qenfr3UynBnZK8tbpxT2CEWjg4Bkk5PJbc8QBAz8QyMFVeFVCusdPmVW8Us86fNJDLsVUfMkvFxjZZ8gz4DcN2h+Yf9/pWRWKJlirZmxft9dsHJXJgrldN19ZpSq7Cvpvo5gQvmGiFyzS4uD1D4mpPcvlWtAr0nEgFDeU8n9ES4HbRFeieuGc7HllOeGnKpQdPwjQnjuDZ/LLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3219.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:18a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Wed, 10 Dec
 2025 12:46:30 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 12:46:30 +0000
Message-ID: <53becdef-fee2-455d-ad2a-d969d746db34@siemens.com>
Date: Wed, 10 Dec 2025 13:46:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core v1 2/5] tests/templates: Add template
 files required to generate M-COM job defintions
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 Shivanand.Kunijadar@toshiba-tsip.com, cip-dev@lists.cip-project.org,
 Chris Paterson <Chris.Paterson2@renesas.com>
CC: sai.sathujoda@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
 kazuhiro.hayashi.f74@mail.toshiba
References: <20250207150439.392479-1-Sai.Sathujoda@toshiba-tsip.com>
 <20250207150439.392479-3-Sai.Sathujoda@toshiba-tsip.com>
 <0ff460aa-35ad-46f4-b7f6-f643a89d7b78@siemens.com>
 <TY3PR01MB11075341DA1CE1C0E9A379919C7A0A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <b7adc39a-67b5-4189-a36d-cade887a6a02@siemens.com>
 <d78430a4-2d63-46aa-bf67-9f342a9bc068@siemens.com>
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
In-Reply-To: <d78430a4-2d63-46aa-bf67-9f342a9bc068@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0009.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3219:EE_
X-MS-Office365-Filtering-Correlation-Id: 01920e06-a56d-4ef4-92ba-08de37ea2421
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?4J4XY6YV2YUJDZ/ZT2r3mWtOCJ+0euIj+N4yesfPfqodMrVocjHyYqKRvC1j?=
 =?us-ascii?Q?pbNGhpitvQKIUV/7PlpEn1M30TBV6FafKGY6ryqae2rWUM7yTM+C5MeHOr/3?=
 =?us-ascii?Q?0z/StvCWrEoO2+Q9d0cRjN0g1nm77ADmMf67DvNB407T2Y+bi+elty4pwnp+?=
 =?us-ascii?Q?o8hLmfmv8DLmNC+7G4TYjLtTogbXdvHcyZheJHshuqITR1WFCmluCYj/5Yq4?=
 =?us-ascii?Q?8GatyfsB1Y7g024QFQektYe43Y0FvHvYbJMXwyxIC6JL2ptd1ydLByllmd7a?=
 =?us-ascii?Q?vzErO8cJLDqLrl43gv0uVI8KsjMQv/10vMDQrthkTyWpkCJAY9na2yD+hl4N?=
 =?us-ascii?Q?w+H4GKDIsB95DiXPHPX62U/UWlnYndMIBHuHjLm55qhjOTmplfQYoqCGL1fP?=
 =?us-ascii?Q?qo+M8XFwIxcfIi6EnP7nxafttbSuDbI7BtW5m6V71NAkDeOX3TT0zXHz3W2Q?=
 =?us-ascii?Q?hDWqaMDHQ1JIhHV/6G0N6Iiw/yxawp7dHt33zwtnrsD8VqDpxsz7PpYiFv90?=
 =?us-ascii?Q?ZY59S4x4njGXGQ4TKEFZUNGQUjPfJuS34qenH2sv/SclxALu4HyYYdRy/JJO?=
 =?us-ascii?Q?vDzcq6olC6P6tsfr2JIF6kVO0DLX78sQoMvivAHqd7Vt9ZFA5DX6za5v95CA?=
 =?us-ascii?Q?R7jCMgP1hC2V2QMnp0sT6sPZn3ECU7HCcOsFjTIvwqCuNwucvyTEUpxjgaFH?=
 =?us-ascii?Q?c6hyxYqjl/wpu+sWShKe+G+uDnlDThI/U3vt9gyYBlrEx1mh8l9LGKR1oiUL?=
 =?us-ascii?Q?oU4L1A9Cc15XxKGE30r1GqMEQ1Yb/CZNvWK1iID6aHTTM9E0+sCcWssAPFFB?=
 =?us-ascii?Q?BcCoIBKFYXBIGxS131LzlOtvv/UTMw3o+R6alscJOylk2EBN+vi514hsWszm?=
 =?us-ascii?Q?eynb4LY3l5hHt3ge208l+LjtfIFobCWEJouhSZpCDRGp2bvKs+qMgk9mM+EM?=
 =?us-ascii?Q?aIiEybRgd3v0wGf1uu8pRCvVHL+dVqZBtDwaaXMJEWPsdh0BAHHutZKLOUp4?=
 =?us-ascii?Q?YRzNCl+Cqc43KD6cB/n7ehrXLYEqbiU7n0NXgC3AGTGDRvYtJPqgbrKaIl+p?=
 =?us-ascii?Q?Gln3gm6VUdThCrGQNgxSb6bb5tGiV0Y+wzjwBlrY2a0+OKA6xYWJIu7setkC?=
 =?us-ascii?Q?JcfzuHPOa2POl09V87S9Z6zGM59F7ZvYr/ZL7trVpXZssqJ8zPTi7trCLIQz?=
 =?us-ascii?Q?+6mvUi/nxBhPu7p0nf5brZjEe/UHWlrCIzooC6oTBhWH2OnifGgGyfkydob7?=
 =?us-ascii?Q?6aGz8cLl5XC6S2nppetOnhcdEwl0SA5jgcgVvs/Hy8ywtGzYJxg4cEH19WOC?=
 =?us-ascii?Q?xXZOIhrEVOl6B/+3Hgf0yTsN81p5CKdWWw8ayX3SNbr3Co4HRPHN5X03WRhv?=
 =?us-ascii?Q?ICC6ts1KwLVq+gXzNqFIPYfF9y86fVUnvTsm9d8uPq8cM1uIxCymOQCJM1gz?=
 =?us-ascii?Q?ABgvi/5an5ud11U41SxqC7qTHAbEPX+3?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?4O/fAp3XzrqRku6mtW2/8WwjU8Cda0St1cZZbgQZx7Ldk570ETf8RifZ6JIm?=
 =?us-ascii?Q?zJLNCZLHQIiltxZ1J3wsMs2UnW8ugNjb1eYAU9usyA+MBH0DlfYiif6jAaXb?=
 =?us-ascii?Q?I8tqhqix6NB4X2M2yRFZCMWf10VrknJC9cXd2zp4Ij0eSZPR3uiXvmMGXfX4?=
 =?us-ascii?Q?AmKJOqpHQBmG+eHLV+hrZSP8e+2KhT8uR29bVT0SBTo8PpMnJXId8D3CkExn?=
 =?us-ascii?Q?7qQZU+Uq21krcOPNCRA+NbLYif7YaP5DS8BNppRbFY6i0KwrRW+2Ft7DP6t3?=
 =?us-ascii?Q?Gmn6vIQKw0oZEwMp7qZ8ku0JB1xUM8pyuH3FZ9hTiifmdaHXbE3oujC32AO9?=
 =?us-ascii?Q?C6ElIqTIC+YWoKIweFi4pesS5sHQ/m5AzUXD0/yD/BB60+KDtItcJ6ZTLOW7?=
 =?us-ascii?Q?cmBurAYl4i/vkBWF01Ro+exp5C4q6TacJNPZdZRzErhcyiYUyk29VTD5sdzd?=
 =?us-ascii?Q?tf5Sy5rwPz/oKIJdnno4ie097xYBKQm9MKVYcILY2OsjYnT4yQ135jd90GOs?=
 =?us-ascii?Q?wmfqHU1AinuzR8p5RwE5MHkeP/BwGwGaE/0BRgcdG2HHI9cQugYeGmV7EoeR?=
 =?us-ascii?Q?5RK8yjO1iwt4bBT311H2xMxEdoekF14c+u4lSFTLo2Tmn9d1ANJyo0CbyLy/?=
 =?us-ascii?Q?kPatD5ZKV7bb+DHDd4JjlGuRrmXs6Rly7LZnbrsnpnUBwJzFS9bxev4Mbe79?=
 =?us-ascii?Q?FSKBRqX2zsykKDEs+P6vVEyv1oqsDIToGNm1430Cxz9pt1yBvVBX4pTnQbcj?=
 =?us-ascii?Q?k0oMOyxJoe8rrft/wpYqTSaJHPL5F4yqEsZEMEXKNlhk86jgmnLXHI8qNuW9?=
 =?us-ascii?Q?ZJibAlAsldJc+LxkhBi94uYn6kLQ0b+mpTmJNQzI9im9NYlc/GXDHxxpOIiu?=
 =?us-ascii?Q?9ynJeqWBNlRjxOYadQrGvhbcUU6HRg8MR1wQyH0wVyaz0m/S03mahT+oeW7M?=
 =?us-ascii?Q?FW0rgHOcDRSgYGknunqEmtz2tcakA+J36gal0zWM8BDWzQgVLpBobrj5ibWU?=
 =?us-ascii?Q?t2zNHP60iHoh7B/6yVsUSH14O1V7KeepKRVCYL/rRzVqOJeARjWwkxZoBARI?=
 =?us-ascii?Q?mVTS7YtdjzxCia83lS8lIRL9coDaRTEm6zSptucIzxH3zzqdAZCNodtk9992?=
 =?us-ascii?Q?ETIQardAesKz/hKlhV1tO6MbS+GIFWsTnRMWyz6JedtdKNbgfh+TiDi7QObf?=
 =?us-ascii?Q?7estsJpgnM4mDNykZ//Q+XUZfsoPGJZBmQp0ukoiy5IxYGbf9t7i9XqQiWCp?=
 =?us-ascii?Q?bdMvcMXGXzAaJIqXJd1b6WP3p/lmhPnGhPqB1aU+eLnsDIlMK03VXkWArNWa?=
 =?us-ascii?Q?OeIRbn5Jg3lirJggyz0KtMsbHsmuPJxNCU09/x+ssQ6oyBCuD80LbfJZUmaI?=
 =?us-ascii?Q?qgB4Gr97yDTsNsEVRCKKxwn/wDucbB1gDcxqj/h9hAPjjG/P7g3EQk/nW9dV?=
 =?us-ascii?Q?5mN4K/brORbUoaPnFuqok4gyAkiGVMgVfQmMzMn3lrrtMOMdIfYI59jJDt+X?=
 =?us-ascii?Q?r9DSQywrC15D2ZfW+85TdxfLA+VNvwWQTjxXcjUPZlz0AIxmmQ5A6VYSlFpl?=
 =?us-ascii?Q?nFTk6Eney7pPUl/EZ3SCXtUd+YAnXPfIv7L7iuSMuzN8CEAC+PL6S79DoDKr?=
 =?us-ascii?Q?fQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01920e06-a56d-4ef4-92ba-08de37ea2421
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 12:46:30.2761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z5jQpoUCBJzOgLDDqBQxNstC0658IAVe6CX9tj9gKWevBq+mcv9i0lU/108JpdKhtEnL/sonpz1xB13ujYbKIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3219
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 10 Dec 2025 12:46:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20962

On 10.12.25 13:36, Quirin Gylstorff wrote:
>=20
>=20
> On 12/10/25 13:30, Jan Kiszka wrote:
>> On 10.12.25 11:25, Shivanand.Kunijadar@toshiba-tsip.com wrote:
>>> Hi Quirin,
>>>
>>> if I remember correctly, the same license information was being used
>>> in the m-com health check jobs and even now also it is used[1].
>>> The m-com job template is derived from health check job definition,
>>> so the license information is inherited here.
>=20
> The health checks are mostly copied from lava it self and contain the
> AGPL information [qemu],[ipc227e].
>=20
> [qemu]: https://lava.ciplatform.org/scheduler/job/1345735/definition

Copyright Renesas - maybe we can get this dual-licensed under MIT as
well? Then we could select MIT-only for isar-cip-core. Chris?

Or was that template derived from yet another template in KernelCI itself?

Plan B could be moving AGPL bits for KernelCI into a separate repo,
though that is not the most preferred option organizationally.

Jan

> [ipc227e]: https://lava.ciplatform.org/scheduler/job/1344710/definition
>=20
> Quirin>
>> What is the exact external (non-CIP) template file we inherited from
>> here? Maybe we can resolve this differently.
>>
>> While this is just a test file which will never (under normal
>> circumstances) end in a production device image, we should still try to
>> avoid license inflation unless really needed. It will make life of our
>> users simpler.
>>
>> Jan
>>
>>>
>>> [1] https://lava.ciplatform.org/scheduler/job/1238088/definition
>>>
>>> Thanks & Regards
>>> Shivanand K
>>>
>>> -----Original Message-----
>>> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>
>>> On Behalf Of Quirin Gylstorff via lists.cip-project.org
>>> Sent: 10 December 2025 15:05
>>> To: cip-dev@lists.cip-project.org; jan.kiszka@siemens.com
>>> Cc: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>; dinesh
>>> kumar(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 DITC_DIT-OST) <dinesh.kumar@=
toshiba-tsip.com>; hayashi
>>> kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=8F =E2=96=A1=EF=BC=A4=EF=BC=A9=EF=BC=
=B4=EF=BC=A3=E2=97=8B=EF=BC=A3=EF=BC=B0=EF=BC=B4) <kazuhiro.hayashi.f74@mai=
l.toshiba>
>>> Subject: Re: [cip-dev] [isar-cip-core v1 2/5] tests/templates: Add
>>> template files required to generate M-COM job defintions
>>>
>>> Hi,
>>>
>>> On 2/7/25 16:04, sai.sathujoda via lists.cip-project.org wrote:
>>>> From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
>>>>
>>>> Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
>>>> ---
>>>> =C2=A0=C2=A0 tests/templates/M-COM-x86.yml=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 52 =
++++++++++++++
>>>> +++++
>>>> =C2=A0=C2=A0 .../templates/swupdate-test-action-M-COM.yml=C2=A0 | 18 +=
++++++
>>>> =C2=A0=C2=A0 2 files changed, 70 insertions(+)
>>>> =C2=A0=C2=A0 create mode 100644 tests/templates/M-COM-x86.yml
>>>> =C2=A0=C2=A0 create mode 100644 tests/templates/swupdate-test-action-M=
-COM.yml
>>>>
>>>> diff --git a/tests/templates/M-COM-x86.yml
>>>> b/tests/templates/M-COM-x86.yml new file mode 100644 index
>>>> 0000000..4716225
>>>> --- /dev/null
>>>> +++ b/tests/templates/M-COM-x86.yml
>>>> @@ -0,0 +1,52 @@
>>>> +# Copyright (c) 2025, Siemens AG, Quirin Gylstorff
>>>> <quirin.gylstorff@siemens.com>
>>>> +# SPDX-License-Identifier:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AGPL-3.0
>>> I had some request about the license of this file as it is the only
>>> one in CIP with an AGPL.
>>>
>>> Was this license intentionally?
>>>
>>> Quirin
>>>
>>>> +# This program is free software: you can redistribute it and/or
>>>> modify it under the terms of the GNU Affero General Public License
>>>> as published by the Free Software Foundation, version 3.
>>>> +# This program is distributed in the hope that it will be useful,
>>>> but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>> MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
>>>> +job_name: mtda-mcom-#test_function#
>>>> +device_type: mcom-mtda
>>>> +timeouts:
>>>> +=C2=A0 job:
>>>> +=C2=A0=C2=A0=C2=A0 minutes: 180
>>>> +=C2=A0 action:
>>>> +=C2=A0=C2=A0=C2=A0 minutes: 95
>>>> +=C2=A0 connection:
>>>> +=C2=A0=C2=A0=C2=A0 minutes: 25
>>>> +priority: medium
>>>> +visibility: public
>>>> +context:
>>>> +=C2=A0 lava_test_results_dir: /home/lava/%s
>>>> +notify:
>>>> +=C2=A0 criteria:
>>>> +=C2=A0=C2=A0=C2=A0 status: finished
>>>> +=C2=A0 recipients:
>>>> +=C2=A0 - to:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 method: email
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 email: cip-testing-results@lists.cip-project=
.org
>>>> +
>>>> +# ACTION_BLOCK
>>>> +actions:
>>>> +- deploy:
>>>> +=C2=A0=C2=A0=C2=A0 timeout:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minutes: 60
>>>> +=C2=A0=C2=A0=C2=A0 to: flasher
>>>> +=C2=A0=C2=A0=C2=A0 images:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 image:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 url:
>>>> +#project_url#/#branch#/x86-uefi/cip-core-image-security-cip-core-#dis
>>>> +tribution#-x86-uefi.wic.xz
>>>> +
>>>> +# BOOT BLOCK
>>>> +- boot:
>>>> +=C2=A0=C2=A0=C2=A0 method: minimal
>>>> +=C2=A0=C2=A0=C2=A0 timeout:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minutes: 30
>>>> +=C2=A0=C2=A0=C2=A0 reset: true
>>>> +=C2=A0=C2=A0=C2=A0 failure_retry: 1
>>>> +=C2=A0=C2=A0=C2=A0 prompts: ["root@demo:~#"]
>>>> +=C2=A0=C2=A0=C2=A0 auto_login:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 login_prompt: "demo login:"
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 username: "root"
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 password_prompt: "Password:"
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 password: "CIPsecurity@123"
>>>> +=C2=A0=C2=A0=C2=A0 transfer_overlay:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 transfer_method: http
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 download_command: "curl -H 'Connection=
: close' -v --trace-
>>>> time --output overlay-1.1.1.4.tar.gz"
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unpack_command: rm -rf /home/lava; mkd=
ir /home/lava; tar -C
>>>> +/home/lava/ -xf
>>>> diff --git a/tests/templates/swupdate-test-action-M-COM.yml
>>>> b/tests/templates/swupdate-test-action-M-COM.yml
>>>> new file mode 100644
>>>> index 0000000..02b0b03
>>>> --- /dev/null
>>>> +++ b/tests/templates/swupdate-test-action-M-COM.yml
>>>> @@ -0,0 +1,18 @@
>>>> +# TEST BLOCK 1
>>>> +# Fail the job if software update application failed
>>>> +- test:
>>>> +=C2=A0=C2=A0=C2=A0 timeout:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minutes: 15
>>>> +=C2=A0=C2=A0=C2=A0 definitions:
>>>> +=C2=A0=C2=A0=C2=A0 - repository:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 metadata:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 format: Lava-T=
est Test Definition 1.0
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: sample-t=
est
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 description: "=
Test software update"
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 run:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 steps:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - =
curl -v --trace-time http://$LAVA_DISPATCHER_IP/tmp/
>>>> $LAVA_JOB_ID/downloads/common/cip-core-image-security-cip-core-
>>>> bookworm-x86-uefi.swu --output test.swu
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - =
if swupdate -i test.swu; then echo software update is
>>>> successful!!; else lava-test-raise "Fail job"; fi
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from: inline
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: sample-test-1
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 path: inline/sample-test.yaml
>>>>
>>>>
>>>>
>>>>
>>>>
>>>
>>

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

