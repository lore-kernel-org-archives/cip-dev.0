Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A44D5C0E5
	for <webhook@archiver.kernel.org>; Fri,  8 Nov 2024 15:06:25 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.54])
 by mx.groups.io with SMTP id smtpd.web10.14609.1731078377363809408
 for <cip-dev@lists.cip-project.org>;
 Fri, 08 Nov 2024 07:06:17 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=oK46KIhG;
 spf=pass (domain: siemens.com, ip: 40.107.105.54, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jR7RNQK7CoOpsvx+qIQRlNT+0Y1gAXojiTfgEfRe2WE7R4j1wuQq0r8UhnNul2OiL/yDNHwNRWVQs6gh1t+WN1e/e3H3cLudKuQ5vuHOmmWtSQcnNSWbtu9wm/q633yC+7aU5d2a1PaCdZ6VMpePMOGCHtST3twxlCNQclwYvyxza6BIz3IZw9cuAxbeLMRmMnxbxLtdFI/UJ/qP8ueqPF7Vb5ZztwbKwITY/Y0mdDIJd6Hvu/qHvw+obi6DtaEjIu5CIUTF4ZCvQRBQY73wl6qYCKVp21rt9ULK0HXKwtZwGgaWFCOf+Ig56IC22doeBDjtX6Gp0oUUB3k7HtlMOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05g+ZyHyjynAWfI81kudXl+72BL6iBiYKK+kayIWaCc=;
 b=AvGYGX+yDmkEMnyBLddpnfxc6ZXhgFEKntqEeNmd9Yk0+WhEE5nXQdsTzJvJn5EeSzDV5BZJW9TN3nOO2jSu+NQ61Laqpa/ima/+Srvfu0sR8LXi3MrRmznteUsjH/QTwG3caPzCbwYLffZP9qlHhM/YLAqCn7tmlo0OSib9AvX/Mh8oZLfRlarRnaYsfduGmatoBTpw+vM0+L0rtoaI7oRld3OBHtxjiWzLJ7F5zJvAQX+ueuCbKnImJHdNE1t6EAmQrjjl3IbDsXY9kTa9aP78kPJNBvwbvNkiBqof8/XFVh2CDrdv/+PGkfnC6WmYTov7u8AIa97FTgc0MjdKLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05g+ZyHyjynAWfI81kudXl+72BL6iBiYKK+kayIWaCc=;
 b=oK46KIhGiTqzYkxjooTl8kcI6b1IHM14rgUJuiKXIEvFhVza71wp3Fi5B7HU0fA9v97xDnPDXN1dtKfC34o06eXKX0Ssa89swMddnlBDkgIO9WOiv2dIvw8+8ytJd50sEaesjdRxVUEl5wRSUMyDowTzFcxlwTZFLT+yyJrKz8tCSKlb/A8uJ6OwbudFHuFqLYCZ/q2MWjKXC1FupdMLCtlWEEZJE8Gbr0wHUmWiEH8X+AQTRyhhoGHzpu15VR/Q/y4jE8qvwqNEdV8Ip4wAWvuFOFCFTYnivAaCHJs1/u76l0/SZ3InDyKcYDE5zpbea7nqIFVAoHRvMr8hO0Ae7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB5868.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:57::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Fri, 8 Nov
 2024 15:06:13 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8137.018; Fri, 8 Nov 2024
 15:06:13 +0000
Message-ID: <7d506128-22a6-4556-9506-a1394390d0fb@siemens.com>
Date: Fri, 8 Nov 2024 16:06:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2 1/2] Fixing dependency of package
 expand-on-first-boot on cryptsetup and tss2 (tpm2) libraries when building
 with disk encryption enabled. (for bookworm)
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 "Heinisch, Alexander (FT RPD CED SES-AT)" <alexander.heinisch@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <20241021185359.927395-1-alexander.heinisch@siemens.com>
 <20241021185359.927395-2-alexander.heinisch@siemens.com>
 <d4932ec9-d4c3-4be4-acac-b3957b710627@siemens.com>
 <AM7PR10MB33202B3696E06E47C3520679864E2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
 <47553bc7-816e-4f42-8745-d5992b6e650e@siemens.com>
 <AM7PR10MB3320E21C3DD427C0C85A3556865C2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
 <07bacbe5-4716-4dd8-88e1-f9fc3175b9f1@siemens.com>
 <AM7PR10MB332087B9AFC5DC69CEAEFE46865D2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
 <61d6c993-6bf9-498e-9952-d000868cdcaa@siemens.com>
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
In-Reply-To: <61d6c993-6bf9-498e-9952-d000868cdcaa@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB5868:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d93e84e-28fc-4423-807e-08dd0006e2aa
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?3gNgbtYMJyl1UjV2BX0pthwDk3aAV3eWj/saIiUpX6ot4BhpLV3Z57TjGisG?=
 =?us-ascii?Q?Sgypp2Apd/zOPMz2Amp8OqfX6tJC2/rxwo5dcfwl8F8wLhF4xNN1VRqjptXR?=
 =?us-ascii?Q?3p8r4ICLVkqrXboTHLVLSZdGIXCGVEZLoep9WPasxZO0nQmkj7hMR1P4fcPN?=
 =?us-ascii?Q?zbRXulxRwU+YYjdJi2Qtpp2QnJR9QWregFmfXBKOjBh28S7tzMC65mNMMYUd?=
 =?us-ascii?Q?pnFS9nF9Tql8P4onDePeEsmhneBdqy2BR6reYc7l5mJQr7Y4432DrUEkWAwF?=
 =?us-ascii?Q?83jTN9nrKu6Wpw0lgkcXzEDk+Xo6l+z1bYDViynVEO8Aj5qHH56ZvFM7eyhx?=
 =?us-ascii?Q?oKQUw54HAbnefaWs8l2NSLec/Wuvg5A/E4LOxgfjqtaNu+usV2k4859LXgsC?=
 =?us-ascii?Q?NcxrJ2IqKTBHeL4QfVT3e/avnmI2i/g7dYAhitxjgPUt89OuJG4Za627yEpb?=
 =?us-ascii?Q?ZiXjsXzdl+ekFzflls7zv6iZJP15o61K2pV18K5IGv/zqy9/s3Kyvsl7SQRS?=
 =?us-ascii?Q?eV+Ne8tXcWuTj3FJ8KQ8g7GOOw2zTw36uFebDUbx0JsvvqnWRUi83wElRl4i?=
 =?us-ascii?Q?FPlcchdnZREj7UzHqghPGMtD2+8LHb3WT+0CciuIrWesKXDukS4vpflXPTTA?=
 =?us-ascii?Q?Z8zoxak4NN9Dxb81sao3QrO7P+LpsYNS/V+9M1RtMQUNxKoimPCmbKZsiIQ8?=
 =?us-ascii?Q?nbyXVKrz+4NqGFuWyME9o5fQUSX6R+qTWI0+jf/9Xj74FtFBdZ3g79s9dOvy?=
 =?us-ascii?Q?7t2lZsTWYKVfzJL7GGAdSxqyJ7dWBl4I2NkilCstnPsly5X2FiOVqUvZqHUj?=
 =?us-ascii?Q?AcdsNiVTRJNsInoBr2LWmN/HNDAlZaNJJXN2eg5e9SV7UzzOQyS8oz5nYpCQ?=
 =?us-ascii?Q?GjumaS4MObVLF6UfAxfySF4GJ0xhzvQJBBfiJ2fAEk20rqP2oljJokK+7Nj1?=
 =?us-ascii?Q?hICfpat9bQHZHTkRsfiHVo2jlTFOM4px2ZRGakqjsKCcmtfchTLevsEv9WKb?=
 =?us-ascii?Q?YHgU+Xt7Bg6o0w6jPCMDGF3XEaMOQnhv/nEYd6gGu/NRuUef224nv9OTNYG3?=
 =?us-ascii?Q?bfd8e/+r+mBTPe3bDBf0X1KRfYmbgN9Xc+JZDJkZ0g+42Zqoypy3+wUjdjdw?=
 =?us-ascii?Q?AK7WPlAiPrz4lJ0kAgQKe19lc9j4GpBnji8oNdW2ciWxCNNLP0uCX2fObFYZ?=
 =?us-ascii?Q?6fxgliOo/34cKAr11cpXM2vtgUdh1yE9xbJ3WaPaXKiaFK5f/TuWLNDyqZ/F?=
 =?us-ascii?Q?MKbxLeaf/pERlf8AtmEdHFY1rBsTT2CUA8Csq9ryY7ISvFF336tT7es0+HZK?=
 =?us-ascii?Q?QMslvjamscFZnSPVfJESWUTF?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?KuxFKxkuvTlS60cA7ffKHfH+qNx+n+9PIdm2PbT3Bjy2q7ysLDb8bKhONkY9?=
 =?us-ascii?Q?VRc4MNpcFmjFUL4ZMRbo43Tzqpacv2UkVnW84I8QjlxXn5qg9JA0P7XceXbk?=
 =?us-ascii?Q?vSXqwtyO5AgOM7LKzEfOQBNyksmucMLJvzTWd+VjDTelfrt3GWykQTRG9aNZ?=
 =?us-ascii?Q?5XPaNmr0iGBI16iwR088xEmnJo2trDzsYEqdspngv7qg9TCDQwjfagRy+YVl?=
 =?us-ascii?Q?EVf6LEfk9sOrD9FFDPsNyv5hY4y+/FWCz3EwMZj7drpFrKBzslTIxjQos/qZ?=
 =?us-ascii?Q?X5LlpZ8ZUSDZv+VU4RjPjD6F7kxkZgxmh2nQ2mH7ndKZdIW76J2mJQoJ+ah8?=
 =?us-ascii?Q?1yorweES5ft/rLnPB7g7+nQmrzt+nbj60lc8Zu9/v5W3287/q7np6rj+IbBq?=
 =?us-ascii?Q?0lvpUk3Nty1VwhKlToYMHBErbDovO9mNI53JQGXO4AMhAUTIvxSM3Glp2hXe?=
 =?us-ascii?Q?kgvFoGL3qWAL5Hytn9F5MH54XeZGntXAANjtJ5AsNDFwrNd1Tpd5Me6KU09F?=
 =?us-ascii?Q?tKDtnUvJHsPjWP1ORnfxVlQO6qnmd9zlfIwYL1CBgukz9LlQV9BVF0vGtCqq?=
 =?us-ascii?Q?C3Imwh/mXAuFSIncpppMVlK9XynH5uTOpCJzi4oD0QVvfkO8m/7d6kQXL2gR?=
 =?us-ascii?Q?Z4wCyrmZon8JQYxU03puUt8mBMWjp6V5mj5lif95lxqvhmqePoK1q4Gt7Yyv?=
 =?us-ascii?Q?D3dpPhr+73c5lwmFLEIgJPT5ctkfFtxIYPGQPRGmw2F3xSjf5d1w1qJD13MX?=
 =?us-ascii?Q?3bjGUSG0EOFk4A4xuBsbqFQCpsPBpuCTEMNbkVU7eFmZxOkoUfxQ2X2jgMEg?=
 =?us-ascii?Q?C8vJmR86myMH2/KCwpHFMxfwHLzrLB7X0hK0sQ+NhgCCh09VI2rAsTJ+D3g3?=
 =?us-ascii?Q?gOmxCe/lc+bhxXuPt6KkLpw20On2kB4d/+KtMKAL46+4258Mr4OSywk4nhnO?=
 =?us-ascii?Q?g7K8vu7J4Y9xkolJkpLkQEifDQ8TbJXnpeg1yIq/8wTqTeicz5mjet+ZKQ4F?=
 =?us-ascii?Q?Wf3J4KJY38a8/9B1J4onQdh0Myf2YexyStWrd/089AtgWzFngbuiN+Xwak2P?=
 =?us-ascii?Q?tNadESI0stXV27n69+BHmbtofiu2xBpEWw9mrBkdCcGHAscnTmjDuoWrpwX9?=
 =?us-ascii?Q?fP8kW43vNwrB1Wh/F777b2Z4Vd9tBGhjwgxPM2Q6hVAVUdQtgGxvA42+UNnB?=
 =?us-ascii?Q?vTmDYZ/UENOD9gyAlkhXSN7iAWQPwwxrW4DGuJ/5idhdvwWXYuRFBzgS6yQ2?=
 =?us-ascii?Q?C8jPuHj2mGRq+KN+B7G+WbNF0nOaJtziQ8bGiclacTwXhrs5aL7XMDsmglDh?=
 =?us-ascii?Q?l+Yr7WsCIqGALkPyue0M372VBG976n2+L324hXKY6EiiAy+aGbJHWciHRc6R?=
 =?us-ascii?Q?6+6I4CDtkGkCHwBCxdI4/FZtIBHc4SEUQIKMbL9gnVDxcPlOkbd0zpgmrK9M?=
 =?us-ascii?Q?OSKPdfo87QIgJ+amtrDRlLYmPxq+tYegHwDEBiuGN4A01Nz0N01cS9EOgRml?=
 =?us-ascii?Q?gNCmwQrw773bBaaO3ZZHoWmSdMPHIEj7fPyRTSnACaw0JOpppZyvW6YjiWBw?=
 =?us-ascii?Q?i6Rr/BKTBrtvWjYBB+gcTcXqaJbOHAl7/mygHR/i3iIFSNVNybk3UKwrC+7c?=
 =?us-ascii?Q?/Q=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d93e84e-28fc-4423-807e-08dd0006e2aa
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 15:06:13.0145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V+XPo3Kb9pECKTQH/+/ApITy7CG7Ev3DtBNF1a6hNlVH2o7Ga4LmsyLJI1db/4u0hukU/22bcvsQadg8DK0MHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB5868
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Nov 2024 15:06:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17228

On 08.11.24 16:02, Quirin Gylstorff wrote:
>=20
>=20
> On 11/8/24 15:53, Heinisch, Alexander (FT RPD CED SES-AT) wrote:
>>>>>
>>>>> Quirin and I discussed this a bit longer today: We actually should
>>>>> remove the need of expand-on-first-boot to access the key again.
>>>>> And that is also due to an idea I picked up yesterday to lock the
>>>>> tpm secret after initramfs so that we reduce the risk of leaking it
>>>>> via the main OS.
>>>>>
>>>>> Our plan is now to convert expand-on-first-boot into an initramfs
>>>>> hook that would then come before the crypt-hook, thus would only
>>>>> work against the unencrypted blank filesystem - problem solved,
>>>>> just differently.
>>>>>
>>>>
>>>> Actually that's a good idea!
>>>> =C2=A0
>>>>> For now, also for trixie, we will just make the dependencies of
>>>>> initramfs-crypt-hook release-dependent in isar-cip-core.
>>>>
>>>> I guess this is the patch [1] you are referring to?
>>>>
>>>
>>> Correct.
>>>
>>>> Just to be sure, still, the implementation of the initramfs hook for
>>>> expansion will be in isar?
>>>>
>>>
>>> Nope, this ideas fell apart after trying to convert the current
>>> systemd unit into an early initramfs hook. We will need to split things=
:
>>>
>>> =C2=A0 - expansion for already or to-be encrypted partitions needs to g=
o into
>>> =C2=A0=C2=A0=C2=A0 the crypt-hook of cip-core
>>
>> ad "expansion for already encrypted": I guess that covers cases like
>> in VM/Cloud infra,
>> where disks can be expanded after first-boot / installation?
>> ---
>>
>> In many use cases resizing the partition should be required during
>> installation / or first boot only.
>> That's why, I'd prefer having those steps separated and opting in for
>> either!
>> Although package dependencies might be tempting to combine those and
>> reduce recipes + initramfs hooks,
>> the use cases and options on combining those justify a split.
>>
>> As an example to point out the combinatorial complexity of just those
>> two recipes
>> and probably there are even more combinations to come when keeping the
>> systemd expand from isar.
>> (which probably also makes sense for non (customized) initramfs use
>> cases):
>> My current approach to streamline that (downstream) is by utilizing a
>> target-bootstrapper (kind of next-gen isar-installer).
>> That means, expansion is not a use case after installation for me when
>> running on
>> target hardware, still, when deploying on vm! Similar combinations
>> apply for encryption,
>> not necessarily mapping the ones for expansion.
>> I am aware of the target-bootstrapping/installer approach is not
>> desired for many other scenarios
>> (e.g. vm, sd-card based installs, ...) but it already shows a good
>> amount of combinations.
>>
>> Apart from that, not related to the initial problem, but maybe
>> something to keep in mind when refactoring/reviewing
>> the existing implementation: The current implementation will
>> potentially break the rollback capability
>> on upgrades from systems without encryption yet in case of full disk
>> encryption.
>> To mitigate such for upgrades of unencrypted systems to use
>> encryption, we must
>> encrypt the partition relating to the current initramfs only!
>=20
> IHMO Rollback should not be supported - this open opens a can of ... .

Right, I don't see that use case either. We are covering the initial
provisioning use case here. Wiping everything is a different thing, and
I would not address that as "rollback".

Jan

--=20
Siemens AG, Technology
Linux Expert Center

