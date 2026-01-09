Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E1CD167FF
	for <webhook@archiver.kernel.org>; Fri,  9 Jan 2026 10:27:37 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.22])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7425.1767954449839593864
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 Jan 2026 02:27:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=RT7pIRf5;
 spf=pass (domain: siemens.com, ip: 40.107.159.22, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=snwr96oj/ZQjgs7S9EuJIAGAcRbnm0nOplE19dRN3kcKfDGJHtWmXH9rf1I9fF9fH3TBkbXDfHGAKk0H5tORwqm/tn1xLqf2sk9DgVHvaTL22rj3pvZOol8vW7sqtVBGV+YUoa8HYTtkj/TEki6LCRdFRLhYOxalzQSQABMMDDB0h1OBGoAkOaEfZV5WnZOSPPgwC67rEzSKeit/u9n0/KLsuld168UNVQplUfyJP/lPKVgMIV+WmqIvQBWYNeAGPCbgqmLP1Yx5zXmL+hlIoTFfu+svXDE2WykvASs59kJRgmoFpPuILO+MdNVvak5pccl5+rK/hF+dSDKTbVnZZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nd5RGVJ1LsAbUsLHeqNyrxBCNlWr1LtsBkCpKpWnaRI=;
 b=IVmgnzeOOtIKXi3ao8zG51j9b69A9gqB1QUtc4shhIWELwoVxwq5aHiEeL/sXLo+1NikcQ/PmEuIbJAcncAPryjKqf9RKjt95IfjdiiSXumCpT03ZiRoO6aW+ESOUjFdqCQmadaB4BGKBeYyVoNak+MI4cv/0Mcphbb0O3cYGCzwcdlDcHFIro5sJH5h5ni5cKBAfmZtZX34JAtuyO2dAdZdYIpyKJ/uEX82UA8SFMf61XjXakycLsNYRI6/xu48cgMsQaBTcQyCu7HrUkEnKlpVGu9xfVyIoO87XfHvHq/ewYUkTq2lyuvIkr+YPdAXQiwF9C0GfpXpAtJ4eGzGkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nd5RGVJ1LsAbUsLHeqNyrxBCNlWr1LtsBkCpKpWnaRI=;
 b=RT7pIRf5rjuNIuJ+Ik2fqyE4muyWtR21g72/Dm9EDaig6Kv8N3h/lQb3kOIOCkM2Tr4M5zlsMzNbh0zhgnfn6TL7pfxLgkqJOPDTuy7/1yFgUT4zlE499YqQCjZrWmQBj3+bYUkgRUTvDV5HyLKWL7v4T71puQr8NDy5ra2+ovESwSzqib/5O1MFFanx1FoByuUkvKM6FBE+/6yezezGOzPqwTwUsHqUfGC/70kgD/n3/Hgtyv1WJ05f5AxA769dQEw5cQX5YeS7ED1DHjcb5QWYoOvkWvJyo1YyAPltGjvjcHOfPN+HBhTl0d1i8Cs5eeXRTaBgJmjypY4BwvtMGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5157.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:285::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Fri, 9 Jan
 2026 10:27:25 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 10:27:25 +0000
Message-ID: <1d429182-d79c-40f2-a412-6240038436bf@siemens.com>
Date: Fri, 9 Jan 2026 11:27:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v3 7/7] rename
 recipes-core/images/swupdate.inc to swupdate-ab-rootfs.inc
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 clara.kowalsky@siemens.com, benedikt.niedermayr@siemens.com,
 cip-dev@lists.cip-project.org
References: <20260108151650.124306-1-Quirin.Gylstorff@siemens.com>
 <20260108151650.124306-8-Quirin.Gylstorff@siemens.com>
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
In-Reply-To: <20260108151650.124306-8-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0084.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5157:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a9e94a9-f64c-497c-55a4-08de4f69ae5c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Z0hOaWxZOSs3d3RZVGZXVDZpMVpxMzVmZytjejBMek4xMWlQSkZzb1BSOVp4?=
 =?utf-8?B?UERXb2FWYjNKZWJhM2M5VEtpMHlSbzJzdjl6K0FsYTVraDdjMjh1UmtJbkRh?=
 =?utf-8?B?QTJCSXZSeUpNTlRkMUNYdHUzYUkwazNzRWM4TVJBT1dhUXg1bHpmYUtFTHZm?=
 =?utf-8?B?Q1ppMU10eU1zRDl2cjEzY1ozeVFNaE1CZmdKOGFmbjlUZTZuUjkyYzNIdlZD?=
 =?utf-8?B?V3ptY1NmYnRLaUpyK280YWVmRnFUazdwTkdKd2k2YURrYUR6NFVjOUxMUjY5?=
 =?utf-8?B?a3lSUUQ4L002RmptYVdjNEJhNUpNOHIzUDQxaVRFVVp5cHRHeGxROGdmcnF2?=
 =?utf-8?B?OHdPcjlFQVgwRmVYTkh6QUNTRlI2QWt4ZURUNHpEY1JDdkozT0E2dzdSb3JH?=
 =?utf-8?B?UXlWUUVKaU5RYnFBNWVtejI5QnpBZ0VnbWxXNldYOHp1dzhtRUd4bjY4UXJn?=
 =?utf-8?B?MDkrY0FpeXhobTNWT1lkdXBScWFTQXFtTUtGLzEwWitxeUQ2UFNkWWlPUnoy?=
 =?utf-8?B?bXVzdmdUdWtsU1BhOTJEWjdlSEVTdGZvQWZvdFdQOE9HSlhqblNvcEJ4bGc1?=
 =?utf-8?B?L0RuTzlvd0dIeUhOTFN1RFV5VmcvUUJ4bDNqTGtkSWt0V2JNdVZUNXBIS3pm?=
 =?utf-8?B?M3l5bHRLWWZIZXFaZXAxMXNHMmtFaWtYUDVNMHgyY1FJSi9rQUpUcEoreVMv?=
 =?utf-8?B?VXlUKzJmVnE5SW8wbHo5MjNTTHpJNWhlMm5uWTYwTCtPcyt1eVdaOUlPbTlD?=
 =?utf-8?B?dG1ScDF4cnZ1djVZYmRLWnpka2R0ZW01Q1V5cU1aeW5QQU5yUU9nQ1hpcmVB?=
 =?utf-8?B?dVdndWpqejFjQkN5UzZzRWJxQmxteTNYU0RTN1dJSUErWS9GU3ZheXRacm1Q?=
 =?utf-8?B?VTJzMnhPRys2VE5yRjFjUUFFTit1ODczTUxKVDRNV3VKanBDblJkTGxOcEpC?=
 =?utf-8?B?NzRKWm92NDY0NXE0TkJFSE1LV1hYUjV6cnhiV3I5d1dZbUhmRU04ZkZEQXJZ?=
 =?utf-8?B?a2xudE9kQ3o5blgrSUNLamZyTmR3dVBSVFZnUlVjbEJVWTFiYTFXSXlaRElS?=
 =?utf-8?B?R0xDSmVIWmtsa2pOalJmbDhVOFBZakFFR3F3V3hVYlZPZnV3R3dPZTlCODRa?=
 =?utf-8?B?RHU4Y1AxMjZyOWhSWnlSdHlkRTBFbi9pT20wUjVldy9WWGVrZjR1YmczWTB4?=
 =?utf-8?B?cHlodWdvRmhReG5zWERGZ25EMWU4WFdJTVRuMkZzME96Zndhc21wQ3RLNXRG?=
 =?utf-8?B?eXZFWDExVTh1d1VLdUJQT1k4WU9zZW40YW0rV21USEJTNDdXOHpLUTdEbGxW?=
 =?utf-8?B?dGJqSG9sYzJkUjJ2cjNMaWdjV21ncG1BSWFUSFNtVnluNExmVFBvK2ZjY1pa?=
 =?utf-8?B?QytwTHcrVFhxUHg1SzJRRlFkWDQ5WDBOeWFoZ3B3b1ptSWZkZHRQaTQ4NDc4?=
 =?utf-8?B?QUxFWitzeDdIR3lra1QwWEhWemRBS3l6eUwxdVRuNEJVaGdUam1oaCs1QnZ0?=
 =?utf-8?B?R1V1ZzJLNy83Y0dLeWtCRVh3K2FVZXlPRjF1bnBraTJYOWx2NXNZYzJ1Wm02?=
 =?utf-8?B?Y1BNSWxoWDNFWGhyUHRqWWhZekJyaWxJM3F6UXh6N2tFUW44Qm5hRjFQbnJa?=
 =?utf-8?B?UlFtSUdaSmNsc0lBVytLUVh6STU3Z2d6ZytTclpWL2Q1RHkwQUErRlBQMHVi?=
 =?utf-8?B?Y2ZXMElTNC9EeHhqUmJLdzZuTVU1YitaS3JuOUFFUzBLL3dZK0JTZ2hzdXN5?=
 =?utf-8?B?dVJZbmwvZ3VDMVFEV01heTA4NklQdGJlSHpOV0RIVURnYktDN1hCQ3pBazN1?=
 =?utf-8?B?ZHRCUGhjdEVicGs2SVJUYmlMV3gycVpyTjBzVC80dWswMzZsWUlEL3ZtSFVh?=
 =?utf-8?B?TFE5aTFqSmJEMkRmYTF6ZGxVUXVrUlp6dXBIckxnQ21CRkc1VE5FQ2FudTQ3?=
 =?utf-8?Q?X1+ZakLCDPPUmwGhUeL+0Lz/sI+4yq7r?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZkkzbUpBZjdlcFJMeTFYekhGOUxHUTNDaDFVMGtNZkl6Z20wQVpKSXNDaW1G?=
 =?utf-8?B?YmJmTVJZNEd6SjNGbk5Ub2s2L1NOZUJUNzFvT0crWVQ5MnNRZlVtWS9yNmdY?=
 =?utf-8?B?YldXRStoZ041WkdoekdtMjdjemhmVDM1ZmNlNHBzVUdBa1BPTVdNKytxTjg3?=
 =?utf-8?B?UEhoQkZpNU5IOFhXb0RZZElCNjhXdDRqaXZidENRVHFFelhueWZNOTBWZnJC?=
 =?utf-8?B?bUxKVENGMm1hb2RSRzlLOVFYRjI2ZmthbTBJNys5NWZIYTIrSjlreE9JNmxt?=
 =?utf-8?B?WGhiOHJhM3JsdHdOZzh6d2tlUkpwOWtPaTBxQ1dNbmZ2UFdqVUt0MDY5WTBj?=
 =?utf-8?B?RWhXdEJySnE4SHUxTis3ektaSjJEN3hoUlpLcE1uWTNoOGFybXlkbjdtUTl1?=
 =?utf-8?B?QkhlVi9iUDdZYXoxalRoN01xb3hJVXNIMG03ejQxVlpCYXpheUFJS0p6R29z?=
 =?utf-8?B?WXhvd3ZoUjZYUFArSnN2dHNhb0xEb0J6TXNrR1BNT29SU0RYdi9DbERJV2ZU?=
 =?utf-8?B?RUhDTXVTUk9iMVlueVFJU1MzS1FseHFOKzJTeSsxcnlwcitpTS9uZC94T05H?=
 =?utf-8?B?ZS9TcDhCaFFhUDd6MU13bk8zSmwrdVZadHJVSndZM1Z2QlliN053UmY0Uzhl?=
 =?utf-8?B?R0o2Rm9yeTRRM3QvUjdXVTZBWmt6SkFSSEsreXoxaGxxN3BpQWVsdm16Qjdr?=
 =?utf-8?B?ck9Vd0ZqcGhtb0l0T0x4WXNrSDA1UVAvTytJcVBza3poYUF4b2FNV2dONkxu?=
 =?utf-8?B?YXZ4UG5KNTRPU1VtRnZHYW9QSEkyMDRLYUpkUGJOeVF6YkxmRW0vWW41cU8v?=
 =?utf-8?B?Vi9yQUUxT3BISm1Lb2I2Y1FiZVM1akxRa2FUUHBLT0VoR2Z5Um4yRnhLL29U?=
 =?utf-8?B?eHd3eHZtSGY0WG1TVzBWYTE3YkNkLzliWjk2bXRNSnhDVVRaVEtqYmI5NmhO?=
 =?utf-8?B?Zk55eTBmL0NpTU5pdXYzc1Jlb0xYbWdxdXVvYVR1OGRhS2FUN2owOGhaQVNu?=
 =?utf-8?B?YTRXNlZ0aElEYWRCWWQ0VHVKSmlCR1VKMHdJSGhHYlpLWGxtcUMybFRrMExR?=
 =?utf-8?B?UGRueW5DWnRhMjB6ZC9CNWdxTEIwdVgwcDJWQWx0Ukd1dnIyT3lPQWxhQ2dw?=
 =?utf-8?B?M01veWhXNnBVdUdHZ3JpTEUwU2dlMFA3TzRlSGJTMTArMzVxRGNFSUJaUWEv?=
 =?utf-8?B?Z3VNOXlpOE5VeW5vdXNxYjJ0d3VNVVYvdG5tb2dUZ282ZzZsbEhYcUszNmlP?=
 =?utf-8?B?L0VaMWZQVCtjQ2tMK3JkMi9oVmRXZVZUUTZaSFhVM0FNWHpRRVhKckJtaWNy?=
 =?utf-8?B?Q0dxWlpLSllXZGlDL044Tk5uNUZDYU9tV0FCOVd0eTJkcmllelJwVTVKYURO?=
 =?utf-8?B?NTNJTjhUSHVScjBhRzRkT1UrSGt5bFRzQ1BEK2xmK2JQclpScFIzelEzclpX?=
 =?utf-8?B?bVd6cFk1a3BLS2l4elRGbTJtQThrVmtSZ1dOK0JSdVdKQStwM3ZiVzBVbGJU?=
 =?utf-8?B?N1RUQlQ4SnJrNVJHaE5TUnZtVFlheUc1YS9SNk9hUEt6ald0Z2I5dWJpVTk3?=
 =?utf-8?B?UTlOMXpWYkNraWZWOEU5V09zVmdDaHkraThqalJpWkRTV29laktzNkRmWFdu?=
 =?utf-8?B?TlFjeWhDcWFJSVlUOWsxd2F3eEVpM2g5MTU4Y3lKbFo4VUdvUGhyU3R5SWpp?=
 =?utf-8?B?Mm96aWV5Yms2Nk53dG9tN0FXSjFVZEM0ekZqQlhFTitERjlXVjJYS3Z3ZHVw?=
 =?utf-8?B?WWRQRStmaE91dkZjSFhNSmFzQjVWWW55cHJjamJzVVh4cmFWcElmRExIK1d3?=
 =?utf-8?B?VWpZRE9iU2g4TzEzSEpaMHZ6d3BWWW9DdzEvSU9sS2hxaHYvVlR3Y0R5Tzla?=
 =?utf-8?B?eG1RUlF1bjRRK1BYanIxT1JDTUl6V2hqYzgwNFBOdHhhK0s5MmhYR2F6dHNr?=
 =?utf-8?B?UTVCSzVLb0tNYS9PN202VVpic09vRCtNUERCWUxJSWxsYXd1d1JFSHlDOUJC?=
 =?utf-8?B?b0ZHMGt6UzhKc0c2MFNLbnRoRkp0YTZkYnVPSjc0dU1JMCtaWG0zT0dDellr?=
 =?utf-8?B?OVFOYThUM2k4dkJCR2Vrd0lxaFNseGVSSVBQQ3IxUmMydG1MQk9aWm1oYmp5?=
 =?utf-8?B?MXVZVEYzUTRjRTFlbTdUTDVTUzU0L0tHaFZBVzZoT2NVbG9Ya2tVSkNBL2ZY?=
 =?utf-8?B?NFpTcXBDRGhicENzMnRlNTh2NnRmM0pjZzI2VmpmR2dkaEtmV3pGY3ora3hk?=
 =?utf-8?B?ZDlHZEg5UU1jMURSWlF0MnVSNXk4aU9ORDh0RzFvcnUveklTTk9Gcmpnb3pu?=
 =?utf-8?B?SFBqRXlOQVVYK0RhS1pUNGJOVkFtYnJlZUh2enhRNGRmbnZOOElIUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a9e94a9-f64c-497c-55a4-08de4f69ae5c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 10:27:25.0167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GseY7e0A1iZxtZSeCr4B24byjVKSi77ERlYU/IG+QDihWaw2bY36zXv1OYU5aBVRkw6qrAeFnbhHgndJlebA7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5157
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 Jan 2026 10:27:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21496

On 08.01.26 16:16, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This clarifies the indented use. Use a include file as some
> defaults are isar-cip-core specific.

Why does that rule out modelling things via a class?

> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  doc/README.layer-integration.md            |  2 +-
>  kas/opt/swupdate.yml                       |  2 +-
>  recipes-core/images/swupdate-ab-rootfs.inc | 61 +++++++++++++++++++++
>  recipes-core/images/swupdate.inc           | 62 +---------------------
>  4 files changed, 64 insertions(+), 63 deletions(-)
>  create mode 100644 recipes-core/images/swupdate-ab-rootfs.inc
>  mode change 100644 => 120000 recipes-core/images/swupdate.inc
> 
> diff --git a/doc/README.layer-integration.md b/doc/README.layer-integration.md
> index 1e1973c..5ba6259 100644
> --- a/doc/README.layer-integration.md
> +++ b/doc/README.layer-integration.md
> @@ -19,7 +19,7 @@ with /etc as overlay. It also installs and configures efibootguard and SWUpdate.
>  An additional image type is generated with contains the update artifacts.
>  
>  ```bitbake
> -require recipes-core/images/swupdate.inc
> +require recipes-core/images/swupdate-ab-rootfs.inc
>  ```
>  
>  ## Create a image description
> diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
> index c5b7c61..3c3c93c 100644
> --- a/kas/opt/swupdate.yml
> +++ b/kas/opt/swupdate.yml
> @@ -16,7 +16,7 @@ header:
>  
>  local_conf_header:
>    image-option-swupdate: |
> -    CIP_IMAGE_OPTIONS:append = " recipes-core/images/swupdate.inc"
> +    CIP_IMAGE_OPTIONS:append = " recipes-core/images/swupdate-ab-rootfs.inc"
>      OVERRIDES .= ":swupdate"
>  
>    wic-swu: |
> diff --git a/recipes-core/images/swupdate-ab-rootfs.inc b/recipes-core/images/swupdate-ab-rootfs.inc
> new file mode 100644
> index 0000000..6858a31
> --- /dev/null
> +++ b/recipes-core/images/swupdate-ab-rootfs.inc
> @@ -0,0 +1,61 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2023-2026
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +inherit image_uuid
> +inherit read-only-rootfs
> +
> +SWUPDATE_BOOTLOADER ??= "efibootguard"
> +python __anonymous() {
> +    bootloader = d.getVar("SWUPDATE_BOOTLOADER") or "None"
> +    if not bootloader in ["efibootguard"]:
> +        bb.error("swupdate: SWUPDATE_BOOTLOADER set to incompatible value: " + bootloader)
> +}
> +
> +include recipes-core/images/swupdate-${SWUPDATE_BOOTLOADER}.inc
> +
> +IMAGE_TYPEDEP:wic += "${RO_ROOTFS_TYPE}"
> +IMAGE_FSTYPES:append = " swu"
> +# input is already compressed
> +SWU_COMPRESSION_TYPE = ""
> +
> +# read-only rootfs with /home and /var
> +# as separate partitions is used
> +# /boot is excluded as an unified kernel image
> +# is used. This images are stored in separate partitions.
> +RO_ROOTFS_EXCLUDE_DIRS = "boot var home"
> +
> +SWU_SIGNED ?= "1"
> +SWU_HW_COMPAT ?= "cip-core-1.0"
> +IMAGER_BUILD_DEPS:swu += "${@'swupdate-signer' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
> +IMAGER_INSTALL:swu += "${@'swupdate-signer' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
> +IMAGE_INSTALL += "${@'swupdate-certificates' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
> +
> +SWUPDATE_SELFBUILT ?= "0"
> +SWUPDATE_SELFBUILT:buster = "1"
> +SWUPDATE_SELFBUILT:bullseye = "1"
> +SWUPDATE_SELFBUILT:bookworm = "1"
> +
> +python() {
> +    base_distro = d.getVar('BASE_DISTRO_CODENAME')
> +    if base_distro not in ['buster', 'bullseye', 'bookworm'] and \
> +       bb.utils.to_boolean(d.getVar('SWUPDATE_SELFBUILT')):
> +        bb.fatal(f'Self-built SWUpdate not supported for {base_distro}')
> +
> +    if not bb.utils.to_boolean(d.getVar('SWUPDATE_SELFBUILT')) and \
> +       not bb.utils.to_boolean(d.getVar('SWU_SIGNED')):
> +        bb.fatal('SWUpdate from Debian requires signed SWUs')
> +}
> +
> +IMAGE_INSTALL:append = "${@' swupdate' if bb.utils.to_boolean(d.getVar('SWUPDATE_SELFBUILT')) else ''}"
> +IMAGE_PREINSTALL:append = "${@'' if bb.utils.to_boolean(d.getVar('SWUPDATE_SELFBUILT')) else ' swupdate'}"
> +
> +IMAGE_INSTALL += " swupdate-handler-roundrobin"
> +IMAGE_INSTALL += " swupdate-config"
> diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
> deleted file mode 100644
> index 7cd816a..0000000
> --- a/recipes-core/images/swupdate.inc
> +++ /dev/null
> @@ -1,61 +0,0 @@
> -#
> -# CIP Core, generic profile
> -#
> -# Copyright (c) Siemens AG, 2023-2026
> -#
> -# Authors:
> -#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> -#
> -# SPDX-License-Identifier: MIT
> -#
> -
> -inherit image_uuid
> -inherit read-only-rootfs
> -
> -SWUPDATE_BOOTLOADER ??= "efibootguard"
> -python __anonymous() {
> -    bootloader = d.getVar("SWUPDATE_BOOTLOADER")
> -    if not bootloader in ["efibootguard"]:
> -        bb.error(f"swupdate: SWUPDATE_BOOTLOADER set to incompatible value: '{bootloader}'")
> -}
> -
> -include recipes-core/images/swupdate-${SWUPDATE_BOOTLOADER}.inc
> -
> -IMAGE_TYPEDEP:wic += "${RO_ROOTFS_TYPE}"
> -IMAGE_FSTYPES:append = " swu"
> -# input is already compressed
> -SWU_COMPRESSION_TYPE = ""
> -
> -# read-only rootfs with /home and /var
> -# as separate partitions is used
> -# /boot is excluded as an unified kernel image
> -# is used. This images are stored in separate partitions.
> -RO_ROOTFS_EXCLUDE_DIRS = "boot var home"
> -
> -SWU_SIGNED ?= "1"
> -SWU_HW_COMPAT ?= "cip-core-1.0"
> -IMAGER_BUILD_DEPS:swu += "${@'swupdate-signer' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
> -IMAGER_INSTALL:swu += "${@'swupdate-signer' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
> -IMAGE_INSTALL += "${@'swupdate-certificates' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
> -
> -SWUPDATE_SELFBUILT ?= "0"
> -SWUPDATE_SELFBUILT:buster = "1"
> -SWUPDATE_SELFBUILT:bullseye = "1"
> -SWUPDATE_SELFBUILT:bookworm = "1"
> -
> -python() {
> -    base_distro = d.getVar('BASE_DISTRO_CODENAME')
> -    if base_distro not in ['buster', 'bullseye', 'bookworm'] and \
> -       bb.utils.to_boolean(d.getVar('SWUPDATE_SELFBUILT')):
> -        bb.fatal(f'Self-built SWUpdate not supported for {base_distro}')
> -
> -    if not bb.utils.to_boolean(d.getVar('SWUPDATE_SELFBUILT')) and \
> -       not bb.utils.to_boolean(d.getVar('SWU_SIGNED')):
> -        bb.fatal('SWUpdate from Debian requires signed SWUs')
> -}
> -
> -IMAGE_INSTALL:append = "${@' swupdate' if bb.utils.to_boolean(d.getVar('SWUPDATE_SELFBUILT')) else ''}"
> -IMAGE_PREINSTALL:append = "${@'' if bb.utils.to_boolean(d.getVar('SWUPDATE_SELFBUILT')) else ' swupdate'}"
> -
> -IMAGE_INSTALL += " swupdate-handler-roundrobin"
> -IMAGE_INSTALL += " swupdate-config"
> diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
> new file mode 120000
> index 0000000..f02080c
> --- /dev/null
> +++ b/recipes-core/images/swupdate.inc
> @@ -0,0 +1 @@
> +swupdate-ab-rootfs.inc
> \ No newline at end of file

There is still no logic to remind user of the migration - why?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

