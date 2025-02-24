Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0BEC021B3
	for <webhook@archiver.kernel.org>; Mon, 24 Feb 2025 06:09:44 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.59])
 by mx.groups.io with SMTP id smtpd.web10.83006.1740377381474393566
 for <cip-dev@lists.cip-project.org>;
 Sun, 23 Feb 2025 22:09:42 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=BQj+z/vA;
 spf=pass (domain: siemens.com, ip: 40.107.21.59, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UYsYaMPvgR4bPKUbiIFIK9ynpn1lxmuayNbHPeKq/ABqoadKUb/610oRQkg8xlGg+5hDynUgnxIaLIduBpTv5G+GZqF8EhSTMs0oLzGDAQkZePLE2y0ExvnZ+S9bOi6q/v3L9KMA41yf0qqNgSZkOmTviF4WOjgBzCXmQpcfc1vNV6dafp3Fsq0BFr0MOaNDtjwe4pqsUbV7BRffahNIhL3atwyUekUMy5pOYUgwDBt5rChPm9L8lCNGgeeelZsf4FHavLG1be3bCiXspRt5+xeIKZ0TN8vpy6BDWXoYVa7YeZeFNkecpPk822iZ+vA5dYiHgcrj5gfTIhBeVd2unA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAZXggll5mlqp4mQgLGdeYGF/eErixtWsN2LYjoYq4s=;
 b=pbER36gpZi9y3w84LA9HL0UJNbHW3SWwdfzd9Q27FmZ1rTDQGvhnKEj/ky9xuefvApZa7nlyzFhMp69T/ZMUdvdcqCtQ6v6sN2UgpMXRcYHzXWSCHB9SqsdxlSsLZPErk706TQQtkcQO4DFXvRdgBiPadVfiCFkivd/q5gWn+MMolTqA7Tfhf6kPImZmaF0PN89DMewx08SSwzIsUOKDTvjnikOS3yrRmBZrbJSXeWfITTDy9GJzvv/TPrNkPUlsDZWyo/gy9WD9nPalWvXo5butVHn4cAjWFEL8u8lhtEtH3f/wEynvf8Smd9usjRDzr9XHTaHLlxquEfofJvnBaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAZXggll5mlqp4mQgLGdeYGF/eErixtWsN2LYjoYq4s=;
 b=BQj+z/vAzqJTa4mwEUmCyIfx3fOgg+dJ6V6JSX8pPUZyAYiLqs2eGwykiJASZBzrf8hI0gDUBbzgCUKji7F3ZDTQusYPmTLHCwlWNAZY6Vz+5qN1qpq7p487WsnJJNacgr1ve/GMhXSqaCKE2bWKS0cg9XUQ1lAkuZPv296u4BFtZBXFU/TbLonvWhizxUkxs7zIa4coKYF/xBXAwP2jgTFiG5KBcvJINnYU88c7WoAIXwKRO2CTiAQHYzZnZX9JvCmQRBoNph1A089ecLIgznahVzfT0uYglUTHYJfPX1/TCGce4ffTzVhtWigpIh78GSm+rLBm6JUfX4RrCXfESg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB7560.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:dc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.10; Mon, 24 Feb
 2025 06:09:37 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 06:09:36 +0000
Message-ID: <6fce5303-59b6-4aee-b60d-d0d25c8a3a2a@siemens.com>
Date: Mon, 24 Feb 2025 07:09:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][PATCH 1/3] Removed "ro" option from
 read-only-rootfs's fstab.
To: "Heinisch, Alexander (FT RPD CED SES-AT)"
 <alexander.heinisch@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "Gylstorff, Quirin (FT RPD CED OES-DE)" <quirin.gylstorff@siemens.com>
References: <20250217100024.42995-1-alexander.heinisch@siemens.com>
 <1824F69F112B9158.31881@lists.cip-project.org>
 <AM7PR10MB33205157A04B7C1290C1B6CB86C72@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
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
In-Reply-To: <AM7PR10MB33205157A04B7C1290C1B6CB86C72@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0156.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB7560:EE_
X-MS-Office365-Filtering-Correlation-Id: 561bdb8e-8dc7-4430-a896-08dd5499d0c8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ZT3lUIqlN8kffJbxZMVYK2gxa1nHgzsza7uzIYOvmmRUtwgqFQwdH/R/u/Jv?=
 =?us-ascii?Q?lZUx6+ukfIKWTxsL32cjGCXCqir165f0LLqhRe932vTcfUdAEQ4ExVDzC622?=
 =?us-ascii?Q?ul84M4U9s6CLtWNC673XhyzW5gbKG3euFzmuXrA33nBJ1Rjfa9FQkbgFeHeA?=
 =?us-ascii?Q?xNW3fyVAe4vKiXgXFW+4VuU5MOF14+KB2Gva1s3mI+aEukOI80273oyNfdGL?=
 =?us-ascii?Q?XUGHs9GkTjd3fLGTeRtl/c6Mj5iNT9zCGRaY15tWnk5uGhEcTFasE6XT1oVX?=
 =?us-ascii?Q?jFRu1ku9/Btpj1ED1iKKoV6orzg56UyCfIfXIAKey9tgQ4P0742/vbIja+AF?=
 =?us-ascii?Q?zl5tdUgPUxMQQnZHxl/uNivRuxWMSpsVITczGigQfn3jfQoAM84EycntnfrO?=
 =?us-ascii?Q?Q+xM5sLaGZ92mq2FlzaN7X3npDoJ1rzEF6iGH3Lx8kCuzM7UKcRzcISvzk3/?=
 =?us-ascii?Q?sCxyvzqmYvrcI2P0uRkNP0ARfXZmTHaUxn1kNbXSeMyVAtyUDE4bI3WiuHmh?=
 =?us-ascii?Q?4ZkOlxXFAedoP0b2ADxZylAkIAnYdwIrIyDhgbadh20bqExomcjHxhTprRNw?=
 =?us-ascii?Q?l16/5n1bSY0A5yGA6QeEMJet4Fz57FVNVpqSYp33LqqQhaGW9Nmc9VvqhhrC?=
 =?us-ascii?Q?VUG4DiNbbw5F9wf4Ev71+5rMpY1Tp0ibxgTPsx8IglAQV4unQVJVexgfYzIW?=
 =?us-ascii?Q?sGjRi1miziKiiU3Nvc000IQu8FQ3kMXEJTnIcJsOpubmGE7ObrpeoSkKRwhK?=
 =?us-ascii?Q?+aYMcTn0dANe76NJeAkO6YgDMoPUyNE5SucDEhGGMoIbqlYWzTpqRKeceMSR?=
 =?us-ascii?Q?0HUehsCLTV+5Mgjuk6TSLWrrYNdSSGl6hZdyPMZtockvLCQauSrMGxVEUTWl?=
 =?us-ascii?Q?ae+WNoftXfFnczLUkLy3EtOfwAckZL3XQkqGvLV4xactswK2H//1J12gpc0r?=
 =?us-ascii?Q?J64tH5/GBA9A3gqcbCLs1E9d8AeuutAwbTNte69AxJMsULPuOfB+WkW3c67i?=
 =?us-ascii?Q?TWddgMeF4JOQyC5T4LWYQ+ICIcYgTaGzSwt4MH9UTEet/TSIvr7NrNjr8kAg?=
 =?us-ascii?Q?hU4BEL5puiyqocGK5FSZ8X069x2UEQg+f9BDzv/HUAM1NV0Mk6/V0kZj6D5G?=
 =?us-ascii?Q?1JS6CcSk+zEbm4oHVJ/luMEAdCIMA8AbMQ6jLq7FVVPf8yjSnX3BcWPFtU9h?=
 =?us-ascii?Q?I0R7qb+k9zJM2YyMibM8wY/uB5U85haOztJqKfaXD+qq89y/0qlakFaEwvAU?=
 =?us-ascii?Q?6n5qzbGtmL5n6gdhDV44ZD5r4THSIjSBfJ3QUn5TCXB8AHiE7NMd785U4+s5?=
 =?us-ascii?Q?tRGEcDxOVYFwe+IxOGaOv0ToKVrh08i5/1nzdMKqyAWWtw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?kRUOxKGRRmE8SvGfmC9oerUVFukikCAilT3Nmnn+MvJYfbTL5Qs/CeOAwqz3?=
 =?us-ascii?Q?1ID25Rn/x7r+yDKGb4ILGewlxjiZ5CarX5ZQ6WxqOBEOEGvWt+V8iEIvDTPV?=
 =?us-ascii?Q?e66Jcs8oLFZoNX9EL+dyVPkNBnQogdaPPD4hyKHr6ytOI/GP3QFKnAwSan4D?=
 =?us-ascii?Q?APbkuZzNUaN5YtTpi5zO/l4GGjywYelCVBm3t/bCy6DwRbLR/qNuJRaFeyqp?=
 =?us-ascii?Q?QCySipeAkH8UyDLnXlxEajgeKZUe5W1B6mlJ3jTEtfdbIDAoOXeclhYynnpF?=
 =?us-ascii?Q?qSCfmg+IDO1drkZ8COhQSDVbrD55HWGDW/rJ/7lPL+5MV+ANrEKv2NnJ6ALs?=
 =?us-ascii?Q?PIgPzb6HZbKINWdGXF3OUElaaVKDV3JUCXZtAIWDsqko3q3mpAd+3va2B16b?=
 =?us-ascii?Q?nXVCfNGBPpBovknSoi9VBURM1iONHCaFTiD+Zd2Clr4+kG3KYFu9fhV9dxtP?=
 =?us-ascii?Q?FH4UhRpkH7V3ag8v1rR7BvpyjOJHrXUyMyM//K4t1FEyfMSQZ8zCvkpxY74Q?=
 =?us-ascii?Q?teeDYuKHxV813VlFRpgT4JWrFSwB1TSLog0ABT+17IxCH209N9/ksrPUYcS5?=
 =?us-ascii?Q?8gCSiE5gGRSglZhdxKl1f04TOddnyUXt7aNJbQZd1iPoWQIlJ/wxlWGd2fvK?=
 =?us-ascii?Q?xk090BIvSS2shqRgFA9Udz9To3Gc8lJAItYVw0CFwP64mJU9C/va68NLWdf3?=
 =?us-ascii?Q?XdzkdMe39kso7vZA7Th+6JB5KDn0pK9gYSAouj9IjHwC66iFzfYlu/ZdfdI1?=
 =?us-ascii?Q?iefERGEATqi6ptGddYfG3umtRV2wQHXrvofbWjOx6NuZUMXMNxbrj9U2bhn5?=
 =?us-ascii?Q?MbcQeiWvz7wV2tbuNY1cRp+OLEF1HPl5lSHYkZaEHI/4bZmc3aTHCOOS1hZR?=
 =?us-ascii?Q?BfEDN5nxKOyuEGSM4kVxXoEc4qyjluM6wiAhLbt8puGu9t0q+BskjCcmufkn?=
 =?us-ascii?Q?jutHw4Tc3jnMAHBiM+FnVdDPS4P2ZPKxSeyiLUpldWf9hgFJFPBHGT/HWRD4?=
 =?us-ascii?Q?B7xzLJLS7MXYNiwsVkmb7y+V0GxVWxj4sBgmmefilvWtV7efPW20pJCGbKdy?=
 =?us-ascii?Q?Vq6iH1wgvRZxz2aCOeKHMe85/V3gXykHgkVlcHpj9BmVJajrW8HGUWqnXaO1?=
 =?us-ascii?Q?N229b0uSzUw7KpkSLXYGYaB27AizoEJRcIbiF09VGGBX70vJJYWs/XUaR+Bl?=
 =?us-ascii?Q?TUhnlAOOEnUhtjyD1ComSnbePpnNku1eUdH1nczmn9LQijHhpceSuNIhSZY5?=
 =?us-ascii?Q?orIcoKanpfL7bh8N35inD5ypdmarFJo3oiuVPcaN3UKzD/uWzTrvELxoqdMa?=
 =?us-ascii?Q?203Svq7+bGK07HK7fWaNI/tV1Fg23rKdFQb7Cup/SNT0jTA+SR0CamqLL1WA?=
 =?us-ascii?Q?uFyBLui3x0A1Seo5uePP4nchuTHD/8gDe6Z5z7nIHhgPo76af9RfY+10Pzl0?=
 =?us-ascii?Q?Itg4ObMn2DBmAVlpsBaMyD31C7/Ts0E6DMT/fEohJdlqnyKuEULC+bbQIcAp?=
 =?us-ascii?Q?M785alxaBK9yB3vFzOIzqKmSVVWMpD7ISSOeqLQW3l9h2J2l/s5rFn7/LXji?=
 =?us-ascii?Q?v3qaG+6+yngwJUv6m8bOeT4ZchhxFyTYTGOI9IiS?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 561bdb8e-8dc7-4430-a896-08dd5499d0c8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 06:09:36.8668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uFrUK/fGsaUdkmIL7kNWc3VIp0iEXc7wDo+JPSEb6aSsPjyTshAKH4Ku0Yp5lQ5Zp0ubSekVXzYXuoWIYGDkwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7560
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Feb 2025 06:09:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17885

On 21.02.25 13:31, Heinisch, Alexander (FT RPD CED SES-AT) wrote:
>> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On B=
ehalf Of Heinisch, Alexander via lists.cip-project.org
>> Sent: Montag, 17. Februar 2025 11:00
>> To: cip-dev@lists.cip-project.org
>> Cc: Kiszka, Jan (FT RPD CED) <jan.kiszka@siemens.com>; Gylstorff, Quirin=
 (FT RPD CED OES-DE) <quirin.gylstorff@siemens.com>; Heinisch, Alexander (F=
T RPD CED SES-AT) <alexander.heinisch@siemens.com>
>> Subject: [cip-dev] [isar-cip-core][PATCH 1/3] Removed "ro" option from r=
ead-only-rootfs's fstab.
>>
>> From: Alexander Heinisch <alexander.heinisch@siemens.com>
>>
>> Since we only support erofs and squashfs this option is not needed any m=
ore. Further, it causes potential overlay rootfs variants to be remounted r=
ead-only.
>>
>> Signed-off-by: Alexander Heinisch <alexander.heinisch@siemens.com>
>> ---
>>  classes/read-only-rootfs.bbclass | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/classes/read-only-rootfs.bbclass b/classes/read-only-rootfs=
.bbclass
>> index 35a3ab3..83ddc33 100644
>> --- a/classes/read-only-rootfs.bbclass
>> +++ b/classes/read-only-rootfs.bbclass
>> @@ -41,7 +41,7 @@ SQUASHFS_EXCLUDE_DIRS =3D "${RO_ROOTFS_EXCLUDE_DIRS}"
>>  image_configure_fstab() {
>>      sudo tee '${IMAGE_ROOTFS}/etc/fstab' << EOF  # Begin /etc/fstab
>> -/dev/root	/		auto		defaults,ro			0	0
>> +/dev/root	/		auto		defaults			0	0
>>  LABEL=3Dvar	/var		auto		defaults			0	0
>>  proc		/proc		proc		nosuid,noexec,nodev		0	0
>>  sysfs		/sys		sysfs		nosuid,noexec,nodev		0	0
>> --
>> 2.39.5
>=20
> We observed `systemd-remount-fs` failing in a downstream layer.
> (using a ro squashfs and apply full disk encryption on top)
> Although, the service is executed in isar-cip-core as well, upstream,
> the service can be executed successfully.
>=20
> In essence what happens is that, the `systemd-remount-fs`
> remounts various mountpoints based on their settings in
> `/etc/fstab`
>=20
> ```
> root@device-mgmt:~# cat /etc/fstab
> # Begin /etc/fstab
> /dev/root	/		auto		defaults			0	0
> LABEL=3Dvar	/var		auto		defaults			0	0
> proc		/proc		proc		nosuid,noexec,nodev		0	0
> sysfs		/sys		sysfs		nosuid,noexec,nodev		0	0
> devpts		/dev/pts	devpts		gid=3D5,mode=3D620			0	0
> tmpfs		/run		tmpfs		nodev,nosuid,size=3D500M,mode=3D755	0	0
> devtmpfs	/dev		devtmpfs	mode=3D0755,nosuid		0	0
> # End /etc/fstab
> ```
>=20
> Since `defaults` in fstab renders to: `rw,suid,dev,exec,auto,nouser,async=
`
> the service fails trying to remount the `squashfs` as `rw` as shown below=
:
>=20
> ```
> root@device-mgmt:~# systemctl status systemd-remount-fs
> =C3=97 systemd-remount-fs.service - Remount Root and Kernel File Systems
>      Loaded: loaded (/lib/systemd/system/systemd-remount-fs.service; enab=
led-ru>
>      Active: failed (Result: exit-code) since Fri 2025-02-21 08:55:39 UTC=
; 5min>
>        Docs: man:systemd-remount-fs.service(8)
>              https://www.freedesktop.org/wiki/Software/systemd/APIFileSys=
tems
>     Process: 7530 ExecStart=3D/lib/systemd/systemd-remount-fs (code=3Dexi=
ted, statu>
>    Main PID: 7530 (code=3Dexited, status=3D1/FAILURE)
>         CPU: 15ms
> ```
>=20
> ```
> root@device-mgmt:~# journalctl --no-pager -u systemd-remount-fs
> Feb 21 08:55:39 device-mgmt.local systemd[1]: Starting systemd-remount-fs=
.service - Remount Root and Kernel File Systems...
> Feb 21 08:55:39 device-mgmt.local systemd-remount-fs[7531]: mount: /: can=
not remount /dev/root read-write, is write-protected.
> Feb 21 08:55:39 device-mgmt.local systemd-remount-fs[7531]:        dmesg(=
1) may have more information after failed mount system call.
> Feb 21 08:55:39 device-mgmt.local systemd-remount-fs[7530]: /bin/mount fo=
r / exited with exit status 32.
> Feb 21 08:55:39 device-mgmt.local systemd[1]: systemd-remount-fs.service:=
 Main process exited, code=3Dexited, status=3D1/FAILURE
> Feb 21 08:55:39 device-mgmt.local systemd[1]: systemd-remount-fs.service:=
 Failed with result 'exit-code'.
> Feb 21 08:55:39 device-mgmt.local systemd[1]: Failed to start systemd-rem=
ount-fs.service - Remount Root and Kernel File Systems.
> ```
>=20
> The rootfs is mounted as follows:
>=20
> ```
> root@device-mgmt:~# mount | grep " / "
> /dev/mapper/verityroot on / type squashfs (ro,relatime,errors=3Dcontinue)
> ```
>=20
> I understand why this happens on our system, but could not clarify why it=
 does=20
> not happen upstream! So any idea, welcome!
>=20

The same issue happens in upstream: secure boot on, data partition
encrypted, remount-fs fails. Which makes me wonder if our boot tests
should check for failing system services...

> Nevertheless, after rethinking this patch. Maybe it was advisible to not =
use
> `default` here and either use a options like `suid,dev,exec,auto,nouser,a=
sync`
> or drop the line for `/dev/root` at all, keeping the mounts as they were =
setup
> in the initramfs.
>=20
> Any opinions, recommendations, hints, ...?
>=20

According to the man pages, a left-out rw/ro means that mount will first
try rw and then, if it fails, ro. That would give us the desired
flexibility. Hard-coding the other values of "defaults" is the downside.

On the other hand, what would be the mount options that the initramfs
will use? We do not have direct control over them as well, do we?

Quirin, other reasons why we want / in our fstab?

Another option: "ro" a parameter of read-only-rootfs.bbclass so that
your scenario can override the default.

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

