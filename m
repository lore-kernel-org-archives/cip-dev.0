Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D2FD3C907
	for <webhook@archiver.kernel.org>; Wed, 10 Dec 2025 13:36:13 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.67])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15842.1765373769740717469
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 Dec 2025 05:36:10 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=Fv01AA/y;
 spf=pass (domain: siemens.com, ip: 52.101.83.67, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DxJcGke8VK6aLMrPZmv549gq3BmO2+J9x70jnCV5B8ChZlGXpre4SvgEarCqqAsiLkvgiYqC06khgPVetR08Cj/JGcVpvcDBsJSc7rYwNcQGZJti5zglxeL4B5dex8vvz13z9McwtkXNFh9FAh29YNLgdqd8ngwXKuC+QY4vqY5c2QN7UoxHXrsaduEpqfrbAWaqzNVvJlYmeZdL6UAGeOhWcap6sgGH9okZ/Wlp1l2MORlKlcVyfco14hDXq5cxvJFkOiv/Vx79//8DCwPK+J/xFtSPYAXuCJx5sAgLPw1saXU+swP4iJIl8bmHLdqPtqABznyK2yW+5roOVBObEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DWDPonJQ59ezrHgRT7HjiP2/mA4JGKkRK93ETpq7NU8=;
 b=s3vsgM8g0BbV0gekOtvA39qoWY1tnD/CiyT0QguG88PCQU2pVEMOgpw1y/SBX09nrgjOW1XEEcwiJCFM28Kca8wN5iRvntM2XtHzcfMD/sc5JHYQTz3Df6XDCMwOH+bvOa4xR/b71CazHsZbRO6SS/ZMICHmLCPAIdQxhnQuS3SPQF/JsxqK6TsDw1jtsAaYnWqM23MMpgfLdGxS6HzGZcDdej9l9rtzrEYKM+/2gzs+kALAvcYF3rsVxzuTV6ekKEQ3ei27jkrzW9D1CMt6BkMUwcYLAWs55KWCHJiV+q57XFu477bGreNHb9QLwxRSz5CF/Au5WGoiDaQf0/ByKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWDPonJQ59ezrHgRT7HjiP2/mA4JGKkRK93ETpq7NU8=;
 b=Fv01AA/yaEYXCFB+puHjt0UYqQ/jo/MSr0j4vuoRD1WvJFQWfryJazRirS8M/zTEjaYz32z1aR3ROZGvXj2GISf75QZiZuickQ1Sa3vMSGhclATrAz9299Gw8Kt2nZtuZmKftsb4jK7J5AIfmhRpA7KfXNr1W754Lm5ZR89lpgh1kHwAVlUPz5MMA5LqX0O9me0Xw8MJ0vUdRVwMQ+oo4I39H9hHDmPaSGY6a1satBGMl414BLxTmVt7W0C//pIXLqXlzHh9aBUx1tOtg7XAYfxt4GAxc+nQnd2ebrjl6PMlf0rkXKZ6SqRaylvbF65dLhcBytWLgMOo6JBWdR7DpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:89::19)
 by AS8PR10MB6625.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:565::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Wed, 10 Dec
 2025 13:36:05 +0000
Received: from VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ec8c:43f1:36b1:3314]) by VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ec8c:43f1:36b1:3314%4]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 13:36:05 +0000
Message-ID: <a0fab0ee-5f94-4ff0-8628-03a04c6b5f5b@siemens.com>
Date: Wed, 10 Dec 2025 14:36:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core v1 2/5] tests/templates: Add template
 files required to generate M-COM job defintions
To: Jan Kiszka <jan.kiszka@siemens.com>,
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
 <53becdef-fee2-455d-ad2a-d969d746db34@siemens.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <53becdef-fee2-455d-ad2a-d969d746db34@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0377.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::13) To VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:89::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR10MB2319:EE_|AS8PR10MB6625:EE_
X-MS-Office365-Filtering-Correlation-Id: d3383c99-14f2-4d77-899d-08de37f11150
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?gXlofhIWAt3DjWB0rb1SRtb3+tE/+R0ySdavb/G4jliEYxJAiGfr8DUUrH9a?=
 =?us-ascii?Q?TpueWtDph5QcotPrTFyA6cyBbECsokcQt9i7kclhdH5P2kISUSfrf/inwPc1?=
 =?us-ascii?Q?OE0ANYh7KcPY0KQ0RfkvoFp7HgZ0kscEMavTYR3seH9UtqFQESJCdHFmom6F?=
 =?us-ascii?Q?PC5aX78pjyK2kBU+laPj4YPZI7LTJ96hijEqEkGgFDA0qR0dY9oVOZuFEJ4i?=
 =?us-ascii?Q?uf/DghCHJ5Ox22Z3nbj4Wuo1m8JtqIokwf9iNGhNTpyyrQ+QkLnV7Lnr9KSH?=
 =?us-ascii?Q?vkweuDIms99fIwzAqOzCuuPOTfDZlSMh25H2P0crbw+t7Hoz4/5iM9Ik1dyi?=
 =?us-ascii?Q?/UnzKYyFYMiGuhYzsK0RRkcRz5cgC4x898oOadowWtUYEP27dB0MYcOJwSdW?=
 =?us-ascii?Q?rrLIEGhTb6W+GEF//3ISIDC2kfcl7O57QGaKqvGReZtbuhksIKdfQG50UsDF?=
 =?us-ascii?Q?n9PRZeidflCNHRTb4a0t0YemwS4d7KhVF6Ieq0f9XHUDLGLbvP5XM6jkrIkj?=
 =?us-ascii?Q?SwJLm2DBfnmqinseHJIBUrPjOGKdn5NU0PCfn/Wtc7kI33hKPXIptt/ApS5Y?=
 =?us-ascii?Q?Jel82/3diLbmZOHmZv435xzkt/oNTGJYMq5+04jXP5UZl9LiKlkJshU3Ky3L?=
 =?us-ascii?Q?mpibpnBBsA61FfD07IrOAWyTFjnQj5lkhTi5CRcMJYPMRonG0bEntyHmWeC5?=
 =?us-ascii?Q?OAWps7FvjWEE6IVFHOaXnaHMJBtN4X+ZFZUL7lNSslc4hHKpp+oFccFpqkw4?=
 =?us-ascii?Q?ynOZ1ockigEzgyobhAh0c/IyFQ4iajtANzN9J/WLt0x5mtm6KfJx3KifNRDt?=
 =?us-ascii?Q?DYVYtEHmoPlRpA9PWQcgq9NG9JeeVh6QCTyIVr1PadGrdzN24+aQW0WLEVIE?=
 =?us-ascii?Q?uAYZTeA6RHf8TkoYZCzBIW08YGjxBDzjcBS8cd4V6AkbZuzxR2WANRZpsVL7?=
 =?us-ascii?Q?o55IB/DmmLeyfE6p6AdDAKeUHzTxll3WRLPPUh/oVQbGS+WHYyIf88k3z0JC?=
 =?us-ascii?Q?PIfWQxKI2NKVcrrDbH6E99YFFcUSyPe5KmJywsokAHv6IUdJBN+KrE8aGm2i?=
 =?us-ascii?Q?PjvT54AB0bh+yXYUc9xz21i4jhTvy6lALE7jGyl4zpqrGFbZFRBJMMJeo2Rp?=
 =?us-ascii?Q?OAiuLzfsS+1RGHY7p1MDUo4FIEtcWGw+BOI66CWDGbCIJBP7Y/nw266IRmDK?=
 =?us-ascii?Q?L4dzzQAmaWoohq2OS0tbH7VVT3o8lsG7v/kdC1le5EWxhR0MH69GmFl0Bo93?=
 =?us-ascii?Q?QuOJgMIaov81dv3qnjRyV6ZPQgkVhAD/Jq6yJkrWZCqruhjMv3zcEDboSZnV?=
 =?us-ascii?Q?bLEQprLH5Dp9KZfqV/Xu+Yd6w8I3XxTcu4V5WbMr+/0/nNRndznuEdEKoTHZ?=
 =?us-ascii?Q?tmAEckMdoVfqPthbWPTnX5Li7dlq7wVoChEBtETz7JanKsuS0yUD0D1/OuLt?=
 =?us-ascii?Q?8NKo/C+xdIzwptyxDBjPNwHiohutLDhi?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?qBmUQS5I7rSR+1lwN+riwi7WpiU2jxQ8Oo+kSb9xKmGO7J5VDRd/Q2s3aG+Z?=
 =?us-ascii?Q?5oA2S0Sr9Z3y4/MCI8rr8KK362F1F7aTARTwPOL0lJ1Ipb0OyIHdy+rDXXKI?=
 =?us-ascii?Q?cogf9DksDwguR1/B+kQPwKvRIhBV1C6fT2Zi8cmyS631d9qIQ6qyXwtPtqQL?=
 =?us-ascii?Q?fiVTExgSV2UuDYxfaWw1dIvShC46M6EOa7OTw+IDZdSJjHPgcT0uep7+BPxX?=
 =?us-ascii?Q?cE+gqzVq3ecXZOTh/bHo8SNVCjzovAmgc16LwG3Ir3K2a0/csc8QTsithd0G?=
 =?us-ascii?Q?2o5EY/fkzdZIW2zMvmflutzsDp9EPwilX6blOiuezn3K1/CWVdgoyyVI9a3w?=
 =?us-ascii?Q?q5A781Jh8ntyZs7aVcvzKvWIL5youPyLHAmxfRPlPvr49VlY/5ir4HQqVQek?=
 =?us-ascii?Q?EiVVwA50IT41nfC3wHpcH5HcwV9/XLstRBCIaqWUs6WJMvR7O2ucxDCAsndq?=
 =?us-ascii?Q?GMG/RbHbzqnp/cScsCF9WtiuWmnvtGA3GTwWKyzL2LzVnqcCm3TdCfI0slhm?=
 =?us-ascii?Q?IPFtZo5FSqbndZE2B3fLh697VIkIoKvwNVyZQa4vqEokLfGRfTKF5ezZO51w?=
 =?us-ascii?Q?nQjMLKIejOLYFF4C3JWUwxREMqwjQLpbuvGYL629nou20/8QFxUdSuuHJtYN?=
 =?us-ascii?Q?Jh0AQoWYqK7GhjT9R0msdmpBC7hccBnvi0VP+ULcF9ea2IRhz7QgEdwRbr8T?=
 =?us-ascii?Q?pQL+ToZ6PKNi9tDwpLVPKOxOosCckekXRKM+D6nw7KkDHMSsKkpRzF1WjpOv?=
 =?us-ascii?Q?G7AXqdcJac5TSHsfDzL1AZ2kgRuASEH41/LENLon3YdeTB090Y0jmaUmzPCZ?=
 =?us-ascii?Q?dBF1qY62d0cUmFEejHGGgkyxwXaqva6oFF5v6or1RaX3kx40v8Br4MVd4RZF?=
 =?us-ascii?Q?2gz+1xaQkGqwHsNBlXcf8ZDqVTivZGvJFzlFQTJa4AaPXtY7OKCrQQDBgelt?=
 =?us-ascii?Q?asYMa3Dsa3dg707mju1ysekbhUHHM1Eu0f+PpU2YPr0B0MPs7IX8SdG7vIYr?=
 =?us-ascii?Q?fsrnmIjtEf6LNaF/l2a1EHKhFB4p6Oc0L+0XHkomYkyFB5qGCgtB1zVZPAvS?=
 =?us-ascii?Q?xtyzFAz142C8WSar9EzjHdNQv6iDPx027hrgW/HIGdytoulaoVBB6iC4++JG?=
 =?us-ascii?Q?wk6fI3iPnfKmcmFAcDvJrPhVHaUkp+iUyJT5SBpmP48JZIGX2IujOsFxP0ul?=
 =?us-ascii?Q?zqv9Cr2IjD8qtpF4+rthXaig1MJdZiKNzjPmn3kDDdubSpdPkRfHZVN2tW8p?=
 =?us-ascii?Q?i/asWMVDg41/ADPw63hTeBvpO6XfKRfUjv8wl0Pf5mLLYYkhcgJ1/+nYfgR1?=
 =?us-ascii?Q?P/66OYRWdo3KYL+hv0b7RnXkLFifDuEtjohPgsho1Q3an7Iqu2vEyPk+joQH?=
 =?us-ascii?Q?70kGn4ajlfpS4zEZRRLA6jlG4hl7hYnP0R9lSGdMInD/C2JeSe50x/lSsH5j?=
 =?us-ascii?Q?UiwbaUjTug0LPHb4GlZKMZ+PQgsPEIXp4wQfpbAIFbcgJBtumWzWsc3aLTf1?=
 =?us-ascii?Q?wLkPg0QnYqnT9JIY41YmIXLopn4vtOnvnQ6TiXUcbojgyLkWjUttDyK7HPVC?=
 =?us-ascii?Q?9ILFbPBQq5ljxrDVXBdi163oCrueM0a53718wbnXF07ClKPhtGgRJApIz1ek?=
 =?us-ascii?Q?VQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3383c99-14f2-4d77-899d-08de37f11150
X-MS-Exchange-CrossTenant-AuthSource: VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 13:36:05.3496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GubXcdGmIOqmv032+/ecRe+EGrdrehBfiohMmeuDq+bx6q5JsbyDzHtRImGiw98GVRPxNWAOxXmdOoZUNm9t1kn/b/FHQ+4Vv2o+xE3n/yA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6625
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 10 Dec 2025 13:36:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20963



On 12/10/25 13:46, Jan Kiszka wrote:
> On 10.12.25 13:36, Quirin Gylstorff wrote:
>>
>>
>> On 12/10/25 13:30, Jan Kiszka wrote:
>>> On 10.12.25 11:25, Shivanand.Kunijadar@toshiba-tsip.com wrote:
>>>> Hi Quirin,
>>>>
>>>> if I remember correctly, the same license information was being used
>>>> in the m-com health check jobs and even now also it is used[1].
>>>> The m-com job template is derived from health check job definition,
>>>> so the license information is inherited here.
>>
>> The health checks are mostly copied from lava it self and contain the
>> AGPL information [qemu],[ipc227e].
>>
>> [qemu]: https://lava.ciplatform.org/scheduler/job/1345735/definition
>=20
> Copyright Renesas - maybe we can get this dual-licensed under MIT as
> well? Then we could select MIT-only for isar-cip-core. Chris?
>=20
> Or was that template derived from yet another template in KernelCI itself=
?
As far as I see it:
the template was derived from LAVA during the time LAVA was under AGPL=20
(2019 - 2023).

Quirin


>=20
> Plan B could be moving AGPL bits for KernelCI into a separate repo,
> though that is not the most preferred option organizationally.
>=20
> Jan
>=20
>> [ipc227e]: https://lava.ciplatform.org/scheduler/job/1344710/definition
>>
>> Quirin>
>>> What is the exact external (non-CIP) template file we inherited from
>>> here? Maybe we can resolve this differently.
>>>
>>> While this is just a test file which will never (under normal
>>> circumstances) end in a production device image, we should still try to
>>> avoid license inflation unless really needed. It will make life of our
>>> users simpler.
>>>
>>> Jan
>>>
>>>>
>>>> [1] https://lava.ciplatform.org/scheduler/job/1238088/definition
>>>>
>>>> Thanks & Regards
>>>> Shivanand K
>>>>
>>>> -----Original Message-----
>>>> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>
>>>> On Behalf Of Quirin Gylstorff via lists.cip-project.org
>>>> Sent: 10 December 2025 15:05
>>>> To: cip-dev@lists.cip-project.org; jan.kiszka@siemens.com
>>>> Cc: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>; dinesh
>>>> kumar(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 DITC_DIT-OST) <dinesh.kumar=
@toshiba-tsip.com>; hayashi
>>>> kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=8F =E2=96=A1=EF=BC=A4=EF=BC=A9=EF=
=BC=B4=EF=BC=A3=E2=97=8B=EF=BC=A3=EF=BC=B0=EF=BC=B4) <kazuhiro.hayashi.f74@=
mail.toshiba>
>>>> Subject: Re: [cip-dev] [isar-cip-core v1 2/5] tests/templates: Add
>>>> template files required to generate M-COM job defintions
>>>>
>>>> Hi,
>>>>
>>>> On 2/7/25 16:04, sai.sathujoda via lists.cip-project.org wrote:
>>>>> From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
>>>>>
>>>>> Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
>>>>> ---
>>>>>  =C2=A0=C2=A0 tests/templates/M-COM-x86.yml=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
52 ++++++++++++++
>>>>> +++++
>>>>>  =C2=A0=C2=A0 .../templates/swupdate-test-action-M-COM.yml=C2=A0 | 18=
 +++++++
>>>>>  =C2=A0=C2=A0 2 files changed, 70 insertions(+)
>>>>>  =C2=A0=C2=A0 create mode 100644 tests/templates/M-COM-x86.yml
>>>>>  =C2=A0=C2=A0 create mode 100644 tests/templates/swupdate-test-action=
-M-COM.yml
>>>>>
>>>>> diff --git a/tests/templates/M-COM-x86.yml
>>>>> b/tests/templates/M-COM-x86.yml new file mode 100644 index
>>>>> 0000000..4716225
>>>>> --- /dev/null
>>>>> +++ b/tests/templates/M-COM-x86.yml
>>>>> @@ -0,0 +1,52 @@
>>>>> +# Copyright (c) 2025, Siemens AG, Quirin Gylstorff
>>>>> <quirin.gylstorff@siemens.com>
>>>>> +# SPDX-License-Identifier:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AGPL-3.0
>>>> I had some request about the license of this file as it is the only
>>>> one in CIP with an AGPL.
>>>>
>>>> Was this license intentionally?
>>>>
>>>> Quirin
>>>>
>>>>> +# This program is free software: you can redistribute it and/or
>>>>> modify it under the terms of the GNU Affero General Public License
>>>>> as published by the Free Software Foundation, version 3.
>>>>> +# This program is distributed in the hope that it will be useful,
>>>>> but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>>> MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
>>>>> +job_name: mtda-mcom-#test_function#
>>>>> +device_type: mcom-mtda
>>>>> +timeouts:
>>>>> +=C2=A0 job:
>>>>> +=C2=A0=C2=A0=C2=A0 minutes: 180
>>>>> +=C2=A0 action:
>>>>> +=C2=A0=C2=A0=C2=A0 minutes: 95
>>>>> +=C2=A0 connection:
>>>>> +=C2=A0=C2=A0=C2=A0 minutes: 25
>>>>> +priority: medium
>>>>> +visibility: public
>>>>> +context:
>>>>> +=C2=A0 lava_test_results_dir: /home/lava/%s
>>>>> +notify:
>>>>> +=C2=A0 criteria:
>>>>> +=C2=A0=C2=A0=C2=A0 status: finished
>>>>> +=C2=A0 recipients:
>>>>> +=C2=A0 - to:
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 method: email
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 email: cip-testing-results@lists.cip-projec=
t.org
>>>>> +
>>>>> +# ACTION_BLOCK
>>>>> +actions:
>>>>> +- deploy:
>>>>> +=C2=A0=C2=A0=C2=A0 timeout:
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minutes: 60
>>>>> +=C2=A0=C2=A0=C2=A0 to: flasher
>>>>> +=C2=A0=C2=A0=C2=A0 images:
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 image:
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 url:
>>>>> +#project_url#/#branch#/x86-uefi/cip-core-image-security-cip-core-#di=
s
>>>>> +tribution#-x86-uefi.wic.xz
>>>>> +
>>>>> +# BOOT BLOCK
>>>>> +- boot:
>>>>> +=C2=A0=C2=A0=C2=A0 method: minimal
>>>>> +=C2=A0=C2=A0=C2=A0 timeout:
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minutes: 30
>>>>> +=C2=A0=C2=A0=C2=A0 reset: true
>>>>> +=C2=A0=C2=A0=C2=A0 failure_retry: 1
>>>>> +=C2=A0=C2=A0=C2=A0 prompts: ["root@demo:~#"]
>>>>> +=C2=A0=C2=A0=C2=A0 auto_login:
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 login_prompt: "demo login:"
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 username: "root"
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 password_prompt: "Password:"
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 password: "CIPsecurity@123"
>>>>> +=C2=A0=C2=A0=C2=A0 transfer_overlay:
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 transfer_method: http
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 download_command: "curl -H 'Connectio=
n: close' -v --trace-
>>>>> time --output overlay-1.1.1.4.tar.gz"
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unpack_command: rm -rf /home/lava; mk=
dir /home/lava; tar -C
>>>>> +/home/lava/ -xf
>>>>> diff --git a/tests/templates/swupdate-test-action-M-COM.yml
>>>>> b/tests/templates/swupdate-test-action-M-COM.yml
>>>>> new file mode 100644
>>>>> index 0000000..02b0b03
>>>>> --- /dev/null
>>>>> +++ b/tests/templates/swupdate-test-action-M-COM.yml
>>>>> @@ -0,0 +1,18 @@
>>>>> +# TEST BLOCK 1
>>>>> +# Fail the job if software update application failed
>>>>> +- test:
>>>>> +=C2=A0=C2=A0=C2=A0 timeout:
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minutes: 15
>>>>> +=C2=A0=C2=A0=C2=A0 definitions:
>>>>> +=C2=A0=C2=A0=C2=A0 - repository:
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 metadata:
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 format: Lava-=
Test Test Definition 1.0
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: sample-=
test
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 description: =
"Test software update"
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 run:
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 steps:
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=
 curl -v --trace-time http://$LAVA_DISPATCHER_IP/tmp/
>>>>> $LAVA_JOB_ID/downloads/common/cip-core-image-security-cip-core-
>>>>> bookworm-x86-uefi.swu --output test.swu
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=
 if swupdate -i test.swu; then echo software update is
>>>>> successful!!; else lava-test-raise "Fail job"; fi
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from: inline
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: sample-test-1
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 path: inline/sample-test.yaml
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>
>>>
>=20

