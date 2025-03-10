Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E740FC282DE
	for <webhook@archiver.kernel.org>; Mon, 10 Mar 2025 12:05:26 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.82])
 by mx.groups.io with SMTP id smtpd.web11.35643.1741608325536515271
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Mar 2025 05:05:26 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=zJRvJIBX;
 spf=pass (domain: siemens.com, ip: 40.107.22.82, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hQ+rwshfpPyNF9qhFnZeng6xaAmJsuYswJRDdSkr61MhONNsF9XbwX7A4Z4jktQDk5VWRTu2xWTA19WMaHCDwKx2BteXhVY1zrq6HI9KQDuMD5xnW9QhtPHF+EO2XL10RKZSRFzBXa770TrOY0bCbqG154jTyXaNDy7bePv6LZJCU8r9yaYzpNsRVi2l1/2Rgu55qzM2WFunMWDkVKWTNfaVOwMgi7M+yj5lVIc4DnnPc1j3IN6Vwaq83KjmRokYpTAuqe8lwxsv2s1DjVExrITo3ouN4pF/Xx+TYlos3WfOc0psDfGRyZLwYZzR4Ol5Wcc+hfRPUBh5O6Zd9M9GfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ve2+fR5lwZ7tPoSz223ugyehgBgJTYT3nxd7hELMK2Y=;
 b=I3mIi0uvjCkOVIRjbs6Iwjy/emVZIU8khlWCm460q6T1tYhKinmGscc73u0fKprUYolrDraIpIvTaVD9Q5cuhcG8QjymYCOuP06NnTC5B5hyK3HKmzrkHjVYn6Hp5DTLBsRdjsCzp7lkwuPj/BZEW+xqdFZv5vDR0s0fDK0DcPDXEtpXHoPNU4ZlHZcmLsSWBvoH5B3R7UOiD75aXtrbrRmkrKm/+QYUa5xZW6cq5EWbasElwBv5V3obtqL7+kJWB8BAFCT4OYuuLuUDKtqpT7jdAg/7jqAihius458/oDWt3UAvvt+SKdcnPus9/pt09wRfm3f04AP6c1Zz1B4TdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ve2+fR5lwZ7tPoSz223ugyehgBgJTYT3nxd7hELMK2Y=;
 b=zJRvJIBX/PP+XXcSYyPgLClmk/pQx9L+blY4QBeoq8EdxO97gLhz+taAfda8AdR/9GdfPHX7KgRne680cLOAzKfhygG/ShZl4arqP9G6wtEeUzqZvBfWyXbQVmKvScNPjg0y7MOjNIeAw44Ea33zSl7sv0Nl3JC2g0QjaBE21MRf21IZjgQ6NqP4haN9lnKvRSVyx/VXLsp+gDC3FpmOvJM8b+LxDitmxYLH+uf4dTKe3btf/ooNkOrJ1YiCYDCTDV/PA5u6miLB42YfDthybz6EvEEFeKLyw9JlmyD7sypYbroBeEiklYDeEUCkMzmwnmKXp7s6JeNbtR/Q3dga0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB7636.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1c7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 12:05:22 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 12:05:21 +0000
Message-ID: <ae6fdde4-1f52-441f-bffa-d86cc6045ef4@siemens.com>
Date: Mon, 10 Mar 2025 13:05:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] ebg-secure-boot-signer: convert to signer
 provider that hooks sign-secure-image
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 =?UTF-8?B?w4dldGluLCBHw7ZraGFuIChGVCBEIEVVIFRSIEMmRSk=?=
 <gokhan.cetin@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <20250306093516.3232063-1-gokhan.cetin@siemens.com>
 <3f756d50-aa21-484e-aa52-f91531451dc0@siemens.com>
 <87b88c83-3fce-4038-b8b6-cfe83056fb9a@siemens.com>
 <PRAPR10MB54225595622204A578B7E92880CA2@PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM>
 <b50285e6-d615-4add-b84a-1a8e05b80542@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <b50285e6-d615-4add-b84a-1a8e05b80542@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0251.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB7636:EE_
X-MS-Office365-Filtering-Correlation-Id: c18d0107-fa13-4c8c-6109-08dd5fcbd544
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?he0SpOYCZIDC9Li7GGWpvp0ELI3YOEzofAdfzTkaspmdgVm9gGsDEegV75Ke?=
 =?us-ascii?Q?yjcw77652AK7sVnDj8TYTu/sVwic/sz/EMSV7xZbaMBgCXJAKBXzXrpC0Tvl?=
 =?us-ascii?Q?kaGuDzc8XhVzkoFnNZ82qk1i+aUFGxUdjSMs+q5h60aIVudxCBR/heULJMhx?=
 =?us-ascii?Q?OilJmifXdGWCwbZX1xHEuB/PQvrx4WiZaZWtMkDIPbGRcPOWWK6A0MXLpu9H?=
 =?us-ascii?Q?nhIKcK80p70SJucbez/LqWHjCBn8YFN4lDPgR7azJmmhyPM0wvs/l5EY1OXa?=
 =?us-ascii?Q?VH+b3iJmKxfmlLB5dgP1u1HBwuqOcOs182aDccw123yzlI/9gucPIMXYrj1f?=
 =?us-ascii?Q?yrS3n2IGpVcubLKXSqJq92kp/gkZJdfNDhBZW2iTLnvCbDMI9Kp6bUVOPx88?=
 =?us-ascii?Q?AdbvjG0dPQNLJyUEGRdNL4qZzxOvPBSbbxg1Gwoes+NsDK4k5MtnQ9QRWlbG?=
 =?us-ascii?Q?gkMi8NtOl7L4Wh03q5VhQzUIh9xQGohWrefdOotvSpheYDvOYR4J1Sfpplhj?=
 =?us-ascii?Q?Lv7uhs6tR2g3bs6h4zVI7IXd90m/4sFEiCRWYT1ck4DooxA/IMnr9Y8wSJG7?=
 =?us-ascii?Q?pafrRzqXRaZDgIjLMHMOdtvOI0AplMHRj7SfZ16qXsEfttfYjUd4/69hSzjZ?=
 =?us-ascii?Q?fSWdtjKmwb+VgpcQ2K6BSwSBugvz+fMF6+bxSd2xvpAyO/pgfIZl5S6ZvwUN?=
 =?us-ascii?Q?qHtRjNtqgrxqHn3em3LtBkzoU5o7vR7KUWbRDQzZs3bGXe4b9ahgnuOWWVLD?=
 =?us-ascii?Q?5We7TGKLeZQG0ZNzk6k/EGieBiSPrtHMk28MOkU0TK2pxR6BTRU1BYldY7k6?=
 =?us-ascii?Q?ypiqm4AIZCE3FLXKheL4jvJjeCCDqft1psHrsakODT44W98qz8ptVOT3ItWI?=
 =?us-ascii?Q?YgCsDqlUBSgoT/evZrmjPBxBl/kX1OVNwyocsXIiJQ/ko2DvnaJ2FNob59k5?=
 =?us-ascii?Q?a8C9AedKETyTTFVaRW3e0aWMPQdmpOXiT83Rq8m2J2SMKfP/dWAYnIZ742g7?=
 =?us-ascii?Q?GA1u9YLu0ftIsZmklQDvV4N+HCMO7l9uzqIGXD8IPfmJQZLdv5OGgU8rnM7o?=
 =?us-ascii?Q?8K603R+R8xc1WLUosYZxh7Xa/7FZ+S4m7m8Fo9+wkC6VeQ/IViKv+mQlgFFS?=
 =?us-ascii?Q?EQP05ADxjVu2E2rVl3TaYRdDyNIqyP2NJ2J9OBkdgXLczmndTG5H1lBnZ7UZ?=
 =?us-ascii?Q?fKvew50VK7cyxx/5qlr0K4y6DMwByOsZKV+JOUVCwnh5TONMzcrgxTQ6Pr9n?=
 =?us-ascii?Q?BpIM5XHWfNLS9XGzwDUINL1O9t/yiljBOa4BwAnE75vGbzPp84aGseyrvXYz?=
 =?us-ascii?Q?h7yhD7th+cAIAPgnJZ4d88BF8Gutz5tmXf2I5tStRqDGv8H5dDl5cEXKDIuh?=
 =?us-ascii?Q?BHeI/+IiDhJnAIJE3TWR+h7ByCDs?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?5RpK+nznmlB0UdzxZSjNtyleUtw00Gd5ek9rM1lY6XS5GiXn0hUSAksGqHVJ?=
 =?us-ascii?Q?jKW5JjBSHHJVUH9dvUhTAF2G4V41Qw+LOEXgutgnIMYZBp4N/gOeemEmUF+K?=
 =?us-ascii?Q?rX7umdNBxAtLU9WZ9zVDvfLbISFObBZHBKMp6VcYsHqJBJZx6Ipc2Sz+yh5W?=
 =?us-ascii?Q?84gZDAIDKvZpDrmjCZV0iq1+9mYGAR3Bo7yJ0OiClAf3pmG0/WedV3GqnRHu?=
 =?us-ascii?Q?NK3V4nmOyqcJsQI4O14LykDYTPVqdmNJu12hSaGM/38fyP22XOxE5JnmJBfd?=
 =?us-ascii?Q?DJ/ldXKjjB6RW2WVuAoBil3de8pBHoMq6JISGQ8EV85xB/w7e80/DaIy+8Ab?=
 =?us-ascii?Q?wG/MB+emg/qqLk6tpZQONsmrr/89fJjAN+MImAac4RmCKCm9MH+4x76JV+DT?=
 =?us-ascii?Q?3Fohv63M2vo+yAD05HtiS4tW+PnQOXkcW6uhWqYaWAgM1w9D936c1BGfoMdZ?=
 =?us-ascii?Q?JhgKy4+NObg7JS6QRtN203hQ6+Rv0GB5GLQwcq86hrC4y6JbUqfZ+v1smVrx?=
 =?us-ascii?Q?8vUnCpTy+XM7N0rVhVvLiVjBsJe621qR7SAC5ZB9s0bT6cW1nkHxAi1NxCxJ?=
 =?us-ascii?Q?z6fEPtfGyndY0ZZuCCxYzOJ1bDqratO/Reivp4GM+WgXR604m2DdzpAuyS5W?=
 =?us-ascii?Q?je19O70Y6uFCZb6/RUqwh1BCCVQWr1Day3cFyZxZTiUhukJFtJvOTW5RdC19?=
 =?us-ascii?Q?BFIvvSFOJH+AiN9TF+iX3nRuQxeuBoWrYI2NQQ7JvX8iFCtPgS80yo+RLjHg?=
 =?us-ascii?Q?X+B3HXqLt0DVSbn5+HVmK/0btR73hi0W3kbbCGZCtoe6jqBYGBvt9Fo7zWtD?=
 =?us-ascii?Q?xYDMHUOIl661ojSFEXNb1HmLrOLNLkHa20Gd6T33gyXPlSGiTKEt4GLqJ7iV?=
 =?us-ascii?Q?DcrvQeqQXmIZxsfUkAHq0ED3Ujbk2AzCar+6F9GYLPwGXRj4d+Xu1KzmMBju?=
 =?us-ascii?Q?5GPSk6pblWreFEVtOhSrXn0L75DbZXkXpTf10SyaTDacLbZWiPdW3sN3SGgO?=
 =?us-ascii?Q?g1Gp8kbyPs1dO5OsZdLKABoRSA4vItmEbS5Ff6/ESu8kl8O6JlyEtRGxLEoO?=
 =?us-ascii?Q?OMONxqbQ2BrzCnw2BpZCvwLhggousMcmerrLXVkc99UTlGy8kMzKw7JCsyNi?=
 =?us-ascii?Q?Chkk83yjy5HYu0xMksv6c++DcK2GSDzZ70vQa5LCJj1RkRPqIjUBjDiWsWln?=
 =?us-ascii?Q?HrHbpZfDm/bWEKm0X6u+O6OkXvBMdITz9OaYH9ZlmX0JdPhUaMEzMGwJ6AyK?=
 =?us-ascii?Q?QdtlotjSItGmsPeE37J8F3DLT6v66JQDP7SJDmcGJ2awsMtKy8Z7Mwm5/lKz?=
 =?us-ascii?Q?dvCBdOU4K5huropmg6FW3I+CB8ZHASc5rYNn4hSFkZpVMXRuN8VRogiYs7Ii?=
 =?us-ascii?Q?eBatahAG39oFmbtHmGVaAakdaDipMGea4nHZMJYpoaQS3dQpXczp+D/c0EZ5?=
 =?us-ascii?Q?9Q8Ao7GsksuZapaZD6izEkn64bgtklXPPNJokqKpEHYIpX/q7dvlagFYek3M?=
 =?us-ascii?Q?BFOgg2Zt2EcmL1JkXGqRoM8wEXAVlO/kC1qascjy0/xAhA62Fa0N2NWQivN1?=
 =?us-ascii?Q?o+9Qo6Kr6JbLUhJl/CeI6w0fIpEp3L+n19DK56P3?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c18d0107-fa13-4c8c-6109-08dd5fcbd544
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 12:05:21.9162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ihg5IjfKr6UxLp8FpEAq//C/W2V9RMcyubL86beeEogLFCf7FlBcFhVgeuTySpuCUI+57JoHvHu/cDeXxXzjxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7636
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Mar 2025 12:05:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18075

On 10.03.25 10:28, Quirin Gylstorff wrote:
>=20
>=20
> On 3/6/25 14:46, =C3=87etin, G=C3=B6khan (FT D EU TR C&E) wrote:
>> Hi Jan,
>>
>> I haven't had a chance to try it directly, but past complaints about
>> using OpenSSL provider/engine together with sbsign's OpenSSL3 support
>> have held us back from maintaining/implementing an custom OpenSSL
>> provider for server side signing.
>>
>> In this scenario, pesign is used only for import/export of attributes/
>> signature and this feature makes integration with other tools much
>> easier.
>=20
> sbsign should replicate that with the option `--detached`.
>=20

I'm not sure about that. It creates a detached signature, but it does
not allow a third-party tool to sign the attributes section like pesign
does. Also the (underdocumented) sbattach does not help here.

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

