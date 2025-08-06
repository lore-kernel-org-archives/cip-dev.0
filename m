Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3310C87FCB
	for <webhook@archiver.kernel.org>; Wed,  6 Aug 2025 07:26:00 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.22])
 by mx.groups.io with SMTP id smtpd.web10.19519.1754465155456218799
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Aug 2025 00:25:56 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=Q9Qcc2ci;
 spf=pass (domain: siemens.com, ip: 40.107.159.22, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j5sfmhpL5DzOqDOhE+ij+kvUvxGMd+gOIWsE2QbS9a8Vp8J/wfnNyClW1B/lk3XACUyvesvBMo2G8+KJd8kF8FqlMEergp4lfMEtGGDdiVX11ZKBVh9YKbbTPyKUVAc/xVvpRqyoyQI1Iyt8eVhGCx1wGV3Idjbh1xTz5YGOp7ViflimEqsiXgPrrysd2I1KTFNUkPak3bA4mDQH6llpysKvepCwy+fa6CCkYHMrHJVD03YRgqCiFOh80qc9xro4xHoyPwBSF2lbjh5IWktDPW8r8sAozKDyVmp+a8593JbBry8/CYB3/YUIhsYf7lGhUjJO1ozPyu1L/6Ev3exxoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8y5lZ57ZWil5d2/v19LiVXRrHF3aMAReZdBPdp1vJ0=;
 b=ig3W4BgSWp0UZh9RQ+1AYDTzc4A2FfhMRwnkzs05wJdbMmU+sAi3kXorrMc2e7kY2mLwLSPJTBIrZto8HswtK0QOLrajb9hrZEIozTwdcVrep3YXWUZc47OHduDXCOFC7MV48bp7uZRTwx4MfT299jk8CLzDM6gIdSdpHAX5DFCdBtwlL056UPh0d45wGK8eE3Q45BMoqsiHaFFVSLIJQDR2TRyAqSJCIblnqSsk3Y+9KqIINCfw1Xdn/oKQxcrpJ4ixuFB6GvqIpWT7/JCH94/f3covcBxNMIDWikPojv+Y5HaqH4TDAAzRbSN51IseaJaItW81LI4J/Mv1R8pKxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8y5lZ57ZWil5d2/v19LiVXRrHF3aMAReZdBPdp1vJ0=;
 b=Q9Qcc2ciC9HveZ8xoE/Jzcr0wub0fDHNkwhPew21rwHeNF7++mepEuzpTCKnK0VCrJQRCAlbJrJjRp8UOutP0L0p5dV+80k67ucQ1mdrBl7iCAqcQQEH3ZDYXzZxbcAFhnd8iXBcsDqGVtVcpOu1obK2EMoj9vwJg/snLR2bCGChRqMNuPLm4hNNti5uaH0OPVHAOmVrxYoUhKozJPPCNg0HGO+9w2n7rQx6QveFAHfDqxhW5NHmT3udZ6WWdBTc7GSXWXotyBz8nQPEpVSzButc3SuE/tZtov5xUkl/G4W3I0MVe48iysFfL9Da9Ho4JymCUDM4wa7NN8RECaRP0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DUZPR10MB8234.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4df::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Wed, 6 Aug
 2025 07:25:51 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 07:25:51 +0000
Message-ID: <179deb01-2f0e-4b0e-9c05-3207eb2ed8e4@siemens.com>
Date: Wed, 6 Aug 2025 09:25:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v4 1/2] kas/opt: Add option for not install
 kernel
To: nobuhiro1.iwamatsu@toshiba.co.jp
CC: cip-dev@lists.cip-project.org
References: <1754457742-4006-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
 <ad7c3971-0c32-4288-ad45-8e96e07742b1@siemens.com>
 <TY7PR01MB14818C313C950D6AD14730112922DA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
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
In-Reply-To: <TY7PR01MB14818C313C950D6AD14730112922DA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0362.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DUZPR10MB8234:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d03c0dc-b6a5-4a9c-b17b-08ddd4ba78cc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?23eVmQH6HaxveHDCgzWN+X3GcQvz+3Lh5ldDIbp/fIo6WhamWBpu2AhUB6J3?=
 =?us-ascii?Q?1XSGEMQezI2B9jv7Ht3stx0z3sPAfYzGaHGcpXtXPbwHn8T8HOwwHI/GqvZT?=
 =?us-ascii?Q?vglc/murbOfz6mHCGaOM/gHwsJjTKFqaq6er6kngoR+VqaUfA7ctFiFTTQrK?=
 =?us-ascii?Q?ij9txcRSJ3q7AiE/K+szc4hM+fio0HkEjxMaTk++eVdVWkh9iP5/j7Ldstoo?=
 =?us-ascii?Q?Kdv22gh6wAKDvxyP1yFZusfQnnKyHWOx1aTtfmGUyae8o2ZVuaO31WCOxppp?=
 =?us-ascii?Q?CWZtaFPrw7woYKM9/yoNuPcGdOzEEF3hl9qkirCTsy8DosJsYillwORbE0WN?=
 =?us-ascii?Q?Hvu4DuuzlhFrgpygN8F3nCdlPtg4C2wIJ/ZWQugplRA6dkw71Plit2C7HoYo?=
 =?us-ascii?Q?QWgFLKGpLTPGd9QchYrPpVO5uzzpgMktiUTlt4AfuKFIfWcfTj/cqPNtODmD?=
 =?us-ascii?Q?zWrNRKQwauW2WLmeDWDFxYfyKCOt3moQwgwW4EN8kV08hMCGvWsSDaGtlB1z?=
 =?us-ascii?Q?7TFUJW6CsmacT5rP46Ts03fMOvDOCjIhsDhngusmO/TLAa7OwJ/kXTHijo4+?=
 =?us-ascii?Q?enIXzTuTAQbSP/OQ4x0xyJ8DyrhmxrqBJaCWwF8rJFDHMrZsuxPHJ7zWHisv?=
 =?us-ascii?Q?nYyZXw9I104AhIGliRguUpS0PlKUJzYe/VI/yTJ8ftVgCL1RnEoHFMafJAfj?=
 =?us-ascii?Q?kWTfaKFt4ogrIM8BrD57ay7iEA0Digjxt8uOhWL0+hgKNRu3tBihHp0S3JpD?=
 =?us-ascii?Q?MDEhay6Mb6vwFCMXL8rKitIwiox4vnh5t+MW/d2qRJjErueiazRStW3T+7TP?=
 =?us-ascii?Q?u7ClEe6WxhgJgxCR+uTQu4S08hZd+iEwB2xWJpYvLKI8KtS5tNkOsTBNHscC?=
 =?us-ascii?Q?Ge0MRvz8uwC81j8qYzrs+gXVU6gTahB0ReqLcOzpOjQSVOI5p4GJWYvhENeu?=
 =?us-ascii?Q?MSh3ZBmFeIFyMWydGEeEEmyYlE07qtT0YvrY5gceQHGR+gsIjjXQUZUbGFPD?=
 =?us-ascii?Q?yjfB+32EtqIwncCIn8XfWHe+YHRCEKB2uobXKMnF3YLYZlenCEus/Z310zNs?=
 =?us-ascii?Q?SHyAJn1Q/9cvN6y+UrDOgFhlblKVFJfWjDPecGY1QJmI1ikLUEUrY8Tox+kn?=
 =?us-ascii?Q?99i6txloU1gNGdv7/pwxGCm86nzYv/ze0Z6W0PAhW0FvZjNi/AsOAvPuo4K4?=
 =?us-ascii?Q?fXOsEDbVbo3FHnWQS7b3MBkn64g9gYKpdk/fYxyOZvamJdPH9AomaGNATHuk?=
 =?us-ascii?Q?drtXQYuHzsu4/oE8kMyYCHXbP7cb/FZjG2yueQqcQpaezF3jqWLZEMa/0dfP?=
 =?us-ascii?Q?+PRt+IeauOA3r0mhZ4zGUO4sHPqQ/Nq3SzIdLo6w0k9LH03V9upyM3rvaWBd?=
 =?us-ascii?Q?Opc/WW56gk8JTp7+qNQmE/RIihKgvuB34zXuur1ugWF6QjBCfzhD+Joswo6T?=
 =?us-ascii?Q?wd8cFjF3UW0=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?uNCpY7PBEjuuOxWv2kv9kB5qw/jCCM2lM7+cw1jcT+odytihApoyzAr73EOV?=
 =?us-ascii?Q?viGk2G+JYaXMVlDSHTI6Cgbz2+V8FcR9Tf38shs4qTlkiptUgmi65dh0uGyU?=
 =?us-ascii?Q?5oEo7xOL3VZ3YUO1Byyq9nE28lfcbjMfj3FqSsl6QPyA44Yx/7ToTQNcMWvC?=
 =?us-ascii?Q?bzynEe3EvfFpoQMpVP8t51oXkKyjyF4tqOwqZ9m5KAQu8Vh7dmh1y53jzWcO?=
 =?us-ascii?Q?IXFZ0nqAUn0o58gdQ5+sGFSxVXqHZE5m9h3ccbKhUQpqPEuG9NsKUXPm0/Al?=
 =?us-ascii?Q?sgLxcgEipXe7VkB3HwX7Mmo/rDyH7Q2cRPIV0DQXfLCxUunl0RYWfZoh49ZM?=
 =?us-ascii?Q?vstoYeWi8DuVBdWsawSqLSB/8c2wGLbvPN4m5EwDvtLU+ME5Pttl3aaVYpkr?=
 =?us-ascii?Q?x4Jf2nHwHs2X5h7xE1JhGTV9CQAKrmpVn3wBRXz+h8oFTMdm0VuTUHS1Eooc?=
 =?us-ascii?Q?Er8992vO1Wr4NXhzsMmuYyWZncMAC3yQOCKtAaWeVUOUTw1Si2HRSCA8on7k?=
 =?us-ascii?Q?3l5tCvLed6os+oGT1nJvA99rmyrEWwWNShRojUEK7aN4IuEcyl4PsB4i1hOJ?=
 =?us-ascii?Q?PuT/v8ne6hB0dL4iWd0XeLhWyzHTYvSdSRWntUZ39sIMfFwNB0cctz8aUHU4?=
 =?us-ascii?Q?Q89+wXEPcJuXBAU4M+0sJE43+XbdEDyQRy4pxLsUh6zY/A87uH41evX2nITM?=
 =?us-ascii?Q?MI2lSiPkuzaeMaTlON6Whtxtlrh7FxtB/RiYz4jD1FjScArjIYVV3DquctJj?=
 =?us-ascii?Q?PK3D2Li+9g6VbEhJhEmwdclk750xMOpC32Z06ifM9VPXixVsSANWd42EpL+K?=
 =?us-ascii?Q?QZWXwxAQUC51ilTsNBDC0hX2AyDio4SzRgk7VTAXYRG6Q60PmUUgQhmNMpLZ?=
 =?us-ascii?Q?biq4+TtRysnto+fN2t2eUc867Sd+X45BLvvqMUIot52jkdgFMPmZJ0nyXoz8?=
 =?us-ascii?Q?7yvow02b0yLQu+KIjeT9jwGMmBf5cK2nJUUjls04kBl3vCFPNW7Mkr1lzjn+?=
 =?us-ascii?Q?53VhZkt60+zcG7XrCFbW4OHet57WqCyrBrWGX7QLJASKBGOgPo+AWdqYywTB?=
 =?us-ascii?Q?4koIdKRqYxLfUcpDbGiFDS8dtoibmiGhIxmRdFx0SsUk3BN1wBmTcr4+f8+E?=
 =?us-ascii?Q?i7fm6reqE+BiTPvku/lzNAxAJfJeepwgkDw5n5SlcWA/xPr75fTojw6JPrNb?=
 =?us-ascii?Q?0/nVHFexLqvPyaGdOfGWkqwPlOOA3J2kuZGmGmy5h83qS4PneWl4TVxBy896?=
 =?us-ascii?Q?s7mZLDDkA7Hno6htA4W1rGtNc97P2+/imSpho+mPIHcTturoTWb+kGlAk8H2?=
 =?us-ascii?Q?8sVVgjqv30Mgoyfy5KhXzIlYGXSFAlqn86q4abwp78rSRUXmX4d2Sa3qfLHY?=
 =?us-ascii?Q?prkBu8fGxnFv99gh1hpctC3u1rCJeIPvdGjkJZi2NfW6Mz6TNXmP61jIdZjI?=
 =?us-ascii?Q?yM2VTFAcbsfMvu20JtW5HKZWAQivHgo+Ezaw8N9ki8Fqz/3dBG6r7WhGufmO?=
 =?us-ascii?Q?SLBcqLpQQg2RSkPiGuKj+O5wl4D0V7u8nendJk4RGhwv+xw8hn/TLCTe2iV5?=
 =?us-ascii?Q?Okok3HPAQ/cyBUovsx/FuhTfw+13Dg3u2dVumb0i?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d03c0dc-b6a5-4a9c-b17b-08ddd4ba78cc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 07:25:51.3619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hBhv7EGMoorTUjI1fvhLizZAizvZ7J2hDuZZE9sP+25WeoTzUcrrsHcrIoD1OCNJ/Vn1FBU0N49l2DJJKRgJ8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR10MB8234
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Aug 2025 07:26:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19690

On 06.08.25 09:16, nobuhiro1.iwamatsu@toshiba.co.jp wrote:
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: Wednesday, August 6, 2025 4:13 PM
>> To: iwamatsu nobuhiro(=E5=B2=A9=E6=9D=BE =E4=BF=A1=E6=B4=8B =E2=96=A1=EF=
=BC=A4=EF=BC=A9=EF=BC=B4=EF=BC=A3=E2=97=8B=EF=BC=A3=EF=BC=B0=EF=BC=B4)
>> <nobuhiro1.iwamatsu@toshiba.co.jp>
>> Cc: cip-dev@lists.cip-project.org
>> Subject: Re: [isar-cip-core][PATCH v4 1/2] kas/opt: Add option for not i=
nstall
>> kernel
>>
>> On 06.08.25 07:22, Nobuhiro Iwamatsu wrote:
>>> This adds an option to create an image that does not contain the kernel=
.
>>> This is mainly intended to provide images for kernel testing.
>>> When testing the kernel, kernel image files that are not used for
>>> testing are not necessary in rootfs. Providing images with these files
>>> removed allows you to reduce the size of the rootfs image.
>>>
>>> wo_kernel is false:
>>>   -rw-r--r-- 1 iwamatsu iwamatsu 351M Jul 25 17:31
>>> cip-core-image-cip-core-bookworm-qemu-amd64.ext4
>>>
>>> no_kernel is true:
>>>   -rw-r--r-- 1 iwamatsu iwamatsu 275M Jul 25 17:09
>>> cip-core-image-cip-core-bookworm-qemu-amd64.ext4
>>>
>>> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
>>>
>>> ---
>>> v4:
>>>   - Fix the NO_KERNEL check to 'enable' only.
>>> v3:
>>>   - Update commit message.
>>> v2:
>>>   - Use KERNEL_NAME instead of IMAGE_INSTALL:remove
>>>   - Add build:qemu-riscv64-test-nokerne; pipeline
>>>
>>>  .gitlab-ci.yml             | 36
>> +++++++++++++++++++++++++++-
>>>  kas/opt/no_kernel.yml      | 17 +++++++++++++
>>>  scripts/deploy-cip-core.sh | 49
>>> ++++++++++++++++++++++++++++----------
>>>  3 files changed, 88 insertions(+), 14 deletions(-)  create mode
>>> 100644 kas/opt/no_kernel.yml
>>>
>>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml index 628e624..496a56d
>>> 100644
>>> --- a/.gitlab-ci.yml
>>> +++ b/.gitlab-ci.yml
>>> @@ -28,6 +28,7 @@ variables:
>>>    swupdate_version: default
>>>    test_function: swupdate
>>>    separate_home_partition: disable
>>> +  no_kernel: disable
>>>
>>>  stages:
>>>    - build
>>> @@ -69,9 +70,10 @@ default:
>>>      - if [ "${watchdog}" =3D "disable" ]; then
>> base_yaml=3D"${base_yaml}:kas/opt/disable-watchdog.yml"; fi
>>>      - if [ "${security_test}" =3D "enable" ]; then
>> base_yaml=3D"${base_yaml}:kas/opt/security_test.yml"; fi
>>>      - if [ "${swupdate_version}" =3D "2022.12" ]; then
>>> base_yaml=3D"${base_yaml}:kas/opt/swupdate-2022.12.yaml"; fi
>>> +    - if [ "${no_kernel}" =3D "enable" ]; then
>>> + base_yaml=3D"${base_yaml}:kas/opt/no_kernel.yml"; fi
>>>      - echo "Building ${base_yaml}"
>>>      - kas build ${base_yaml}
>>> -    - if [ "${deploy}" =3D "enable" ]; then scripts/deploy-cip-core.sh
>> ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG} wic; fi
>>> +    - if [ "${deploy}" =3D "enable" ]; then scripts/deploy-cip-core.sh
>>> + ${release} ${target} ${extension} ${no_kernel} ${dtb}
>>> + ${CI_COMMIT_REF_SLUG} wic; fi
>>>      - if [ "${build_swu_v2}" =3D "enable" ]; then
>>>            mkdir build/previous-image;
>>>            if [ "${extension}" =3D "security" ] || [ "${extension}" =3D
>>> "ebg-secure-boot-snakeoil" ]; then @@ -229,6 +231,38 @@
>> build:qemu-arm-test:
>>>      target:  qemu-arm
>>>      extension: test
>>>
>>> +build:qemu-amd64-test-nokernel:
>>> +  extends:
>>> +    - .build_base
>>> +  variables:
>>> +    target:  qemu-amd64
>>> +    extension: test
>>> +    no_kernel: enable
>>> +
>>> +build:qemu-arm64-test-nokernel:
>>> +  extends:
>>> +    - .build_base
>>> +  variables:
>>> +    target:  qemu-arm64
>>> +    extension: test
>>> +    no_kernel: enable
>>> +
>>> +build:qemu-arm-test-nokernel:
>>> +  extends:
>>> +    - .build_base
>>> +  variables:
>>> +    target:  qemu-arm
>>> +    extension: test
>>> +    no_kernel: enable
>>> +
>>> +build:qemu-riscv64-test-nokernel:
>>> +  extends:
>>> +    - .build_base
>>> +  variables:
>>> +    target:  qemu-riscv64
>>> +    extension: test
>>> +    no_kernel: enable
>>
>> This cannot work: riscv64 is trixie-only. What to do? Lift this to trixi=
e or drop this
>> target?
>=20
> OK, I will fix to trixie only, and send patch.
>=20

OK, just send a v5 of this one, will replace v4 with it in next then.

Thanks,
Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

