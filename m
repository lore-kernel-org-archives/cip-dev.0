Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BEA5C19F2E
	for <webhook@archiver.kernel.org>; Thu, 27 Feb 2025 16:47:01 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.58])
 by mx.groups.io with SMTP id smtpd.web10.15579.1740674819248509852
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Feb 2025 08:46:59 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=jCP05aBQ;
 spf=pass (domain: siemens.com, ip: 40.107.162.58, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t2h/ILK0b0U/rgi8kB9HHqTvAm4u8diRnwC3pu4UX1uwDDXJ/4dkT3VNFh/cdqeRjwSWwpDaDOwuBpbhy3MOfT7d33TVKIjsdtryr6vWtF04UA0BeILzeZHHcKjmJpwMqvXaVnBNKeobEF1vuy/VnhwM04oSNalkWZhVi3ebIS5cerHf6IYb8VISm9jJZNWsWi8oWlBktID7kJzi1YPz2eUkQN/ucP6LBndhLRt565cLhdcSxX6Mxif71A3hvv/17yEmKK8jaB/Hovmn/vMWtCTwB7+M5E5Adzt3P1ymWDEGPvWrhRqPcckQTreleEVTI4jv/xsSyNDBd56tvN2/Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ACmhyTq7f5m1ab3JCRZqPg6UwAv0RVIevStduJjDnv4=;
 b=irYThf/KoDIqr1dGuwLbclNoU0vuzC9jfJk8N29XKEuZpOy54o2nsV5Abko7zHqTFuXTlbmvmFIIAp30bXsRj09YfVbnxh/MD4zT0hX36BXEvacyEsNyly1v4wp3OvAEqWgTKyDz4egxe//JmRa9y/jIm2HAqgOUegomlpN1TetJ0X73HW4mCc10M7qtbxEAS/ROgDgBsm60b0HcJhVxSIBVKelnndavVwRuqA0geunSaZDJD/2IOXabN55hvNZRnQXLgWk6tgLpEPBpDV0UpP2uf/NKyLRXF2zjl1I93dBVs3iKl/HewhbtJ7QADEOkB1ramYT455DKXB+bnxNacw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACmhyTq7f5m1ab3JCRZqPg6UwAv0RVIevStduJjDnv4=;
 b=jCP05aBQjB1CQmxJ0gsZ4mRlZGpf6hS38ABgbhM+YbDyj0IpRSKcMGYa9LN4VSRbSaTidqzSrd9bS7PBaWtVvffbZ7j+jzLSpIxDRXhboJK0A2Wqq0ZSwWuqXmFAJGoSR7MsSWpLGWGYOfRuN/QIttaSe/NQ8SRbY71HI7Ks5wAS5a8v9yV0ERFgLBjZIRN3XrHBY4FwzUFl41pAXF6VBVgLGZ2UkhaAbtjmBLua66+3xIw4Ts3cuuNZbquVSeNMXCAz0d/ymdtXJavqXK4BWcCHvWKL4/qnTULqvDyqpwzIqV5kleKAfE6lF6BXObazIWzlQUKkhGomUewE3NWB7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5238.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Thu, 27 Feb
 2025 16:46:55 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8466.016; Thu, 27 Feb 2025
 16:46:55 +0000
Message-ID: <1396788e-f1be-44f1-9efa-30bd01f3896f@siemens.com>
Date: Thu, 27 Feb 2025 17:46:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] initramfs-crypt-hook: implement 'noencrypt' option
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 Claudius Heine <ch@denx.de>, cip-dev@lists.cip-project.org
References: <20250227143022.323950-1-ch@denx.de>
 <20250227143022.323950-3-ch@denx.de>
 <56a7a225-2213-49b4-980e-0c288b1e8874@siemens.com>
 <01544894-2abd-4f58-ae7f-4ca43e137138@denx.de>
 <fe273710-8c84-47ce-bcfe-e7df71d9b553@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <fe273710-8c84-47ce-bcfe-e7df71d9b553@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH0PR04CA0060.namprd04.prod.outlook.com
 (2603:10b6:610:77::35) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5238:EE_
X-MS-Office365-Filtering-Correlation-Id: 2074ecca-1345-47f6-8177-08dd574e581e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?aVNi05wzrJEuRExtM6W9mf1wsoK7blt+e79n9tSMW3NT3jDH5Uzkc9vCl78L?=
 =?us-ascii?Q?KxoEVhst7vDPsDFGwaK7p0dg7WrA2/Q71ObcHsWij/7VdLAdjEngqPWbPnT+?=
 =?us-ascii?Q?omb4Tvgz+YmN+0DzSKhRHkqHwVzanmPqYXSWXRylNuaR+oKhgZYt+8mRcP/c?=
 =?us-ascii?Q?okU+zXhKeQ1qpkYd/fKTOwyJxmuw3EKpYkmm2rc+8PsAtVQR4WiylSGZjw2f?=
 =?us-ascii?Q?2ph0sS7LLWNLaz/WhIARJKc8QwZ+ZyuA3WBvysev9gIxXorwTMiCw4RFXWLx?=
 =?us-ascii?Q?2dHq5rcw8QqZFVXmlSYsb+8L1GqRuy7dBWJluPT36jlag4OgZEP5zhFgHVv1?=
 =?us-ascii?Q?PI7F31jGoAhuxp89JtUIU8MBaMJ7k90IAYuX6yeAk8NRCVFPWdAALyoXoAm7?=
 =?us-ascii?Q?ytXWbyAm3XLj0gR3BRB/kxTzTunjqoxc10iIu/88wHXyXRcnYuvv4hCUpDq1?=
 =?us-ascii?Q?hppp3gP6OTblYw61u/FHQetsWg0cP3z/qLS1n81JW8PFPQ2NTl6Nim9MvC/4?=
 =?us-ascii?Q?H9Z/VrXQChaxLS9Zy7ZW4DYqTV/d2sGMoqh1tq4f+ur5+C/XHbGbhJXwRsmX?=
 =?us-ascii?Q?KdN3kV48dJRo8soeVUo/eE27nUasI96A5HM8+kD4TYLvQbhtK08V5KTrmcUg?=
 =?us-ascii?Q?dazej2PB6aEiAIjj2clcFk0vj7fr/gX3C8JBtVjWxaQIYpnKYXV1OqYNV0ko?=
 =?us-ascii?Q?80svVtYoFA6y0rFE2mWAHLTHB0zUrN/ZYJ4My8Y05yGMF0CEMsY/P/WWFhig?=
 =?us-ascii?Q?4aqpYtLB9T8BY0fO3p8viMOsSas+0zy4C7W6gJ4WXZZo+PEPn1xA+B9+ibmT?=
 =?us-ascii?Q?pNBx6cMNxaRqG1TKu7B5A1agpU3HsBrEcCEOoS+kB7Q99plu4MNDaiQTkciB?=
 =?us-ascii?Q?l2+Lfir7F9BtktCUygaNYrtHYifzF5Yp3uol7Yx3+gZBAegZ6qz8cx+Vb378?=
 =?us-ascii?Q?YeB59g3nEH7UF1FksXx4f3U3OLMPdKxfwh77pxh3Is6nJ6bAbizbbbh3F6VC?=
 =?us-ascii?Q?LzlZM64lBkKwegjn9zN9sZ/bySS2guwQKTOePwGieyTnzyJxe1j30emmVcOv?=
 =?us-ascii?Q?s1RDYKFexg6Pr5PlYJid9kZYyZL3QCmnTC2FObfsToI/3vaVNsnLovsJBF/q?=
 =?us-ascii?Q?HgnQX5sRxDKI2KG8X44ATy3V/76YNpHF7E7cju7fyC7nzAO08gCBGqMZ8gnc?=
 =?us-ascii?Q?WScds1KiBFXxg0kv2AW/hBA9k9sjctEQrp1p8PpAIPi9K0cFDxzzKDeVzBGp?=
 =?us-ascii?Q?YNXEnyhDBHnmFjPAoj1jsk5Xfg1ShHl5nmX07LiiG6zRyU6sIpXTA+I0Wt9g?=
 =?us-ascii?Q?Xhp7Jpbopc0vEPKYCagCxFE2zW8PgIWih+v4gHez3o6LpTVj8Jk9i6nY1ha0?=
 =?us-ascii?Q?dDQZN9Ca+yWIg/Ed+tZCQGhPYAHB?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?L3z7bItc1hsQBcv2u442RamEcKY+jFF/0TJpNLxaW9kHAhxWY9MKhbyEJbEq?=
 =?us-ascii?Q?9VzO7nyQ19MabFRLeiA1/pF4KTzFmDh55h5inrT/rWS64Xtuo7FSGhY4PzND?=
 =?us-ascii?Q?XyQhxQmrD6F8Cbhw8ZKMLNIrJPKk6O9OUbFZ5m1l9eIT7tSBf2P5FxtDFOSv?=
 =?us-ascii?Q?Qr5iwWH4D3aZMafjgZz7/4PYbwhqR15PlTYAwMNhtf/42IW/f1xokkx3jlsW?=
 =?us-ascii?Q?46Kbrffc8zWiOaNLFv/y3rljjPv4pnqZONMdsAjP/91rgSQek01iT6SL9PxR?=
 =?us-ascii?Q?gRTT+PHGd13mmn3GFDll5p7GnVAPA8hXB/25/yVC06Th/iM+jMFMY3SAcF0O?=
 =?us-ascii?Q?b159T5IyXP6JQzcWsF3yKhoF7b/ZK/qrtKQ25+QpqCSnI7HIqLP8cYCGa6vC?=
 =?us-ascii?Q?4ARB+ueoCnDtTFZevpiRkAMZwvOo3XGNbwr+BFU59huLxDjYwqXq7y1JvXSV?=
 =?us-ascii?Q?49AVR+HJzXykO570gPV+YO0O1l2Ttp2JREXWcSe4dAPtDGwyTTJ71MWpCDun?=
 =?us-ascii?Q?w+srvRBKWWs8H6KQbSdB7IJ06PTikr94JhXKuQJTfFevSDNfEmK1utelg9us?=
 =?us-ascii?Q?/rfc7rqoN9oKaOpwsoLN4K5sQ1geNTI8uWnMkV2syORmqMMfy6v7Q8EtCYfy?=
 =?us-ascii?Q?ziIQymvj0aaBNgmbmsKfWlW9aZ2UvkBhabHetacV3VDbLDJ+oGFauDG+y7uF?=
 =?us-ascii?Q?203MpIddKSQI0a9LDyyZ368KqpwCsUJwQx9qgc+PqTODRECEgVsyl14sfqQP?=
 =?us-ascii?Q?yuFXt/0GprCzqTgrLPkEfaIqDVBUV+YOm6Rt3BGaGjWpfxD4+rc5eKIOmV8D?=
 =?us-ascii?Q?o8DGGzbZArkvj+Uij6ZQ2pzLb5JDse15lLk917MPQ39DrDzhG5HReDm1XGo7?=
 =?us-ascii?Q?qqk+pSTxUwE1NRXg483uZcQEO/MgdXtd43OaDWqzGc2QZ8t8RYwo9rPhWpLt?=
 =?us-ascii?Q?e8dmcNyi9PWTE4zoGBMvPofU4OzyqSqo/WTYKU+p3pY4t/1wsamWmODi+312?=
 =?us-ascii?Q?mT15YzsQFd6xldDW9HppWIU0E2/SM1UTstaWAPFFwejqE41sCfna+ejESP5k?=
 =?us-ascii?Q?L26RvTRv90lVJr+FIl4NG1IYk9cdTSwUY7VmdGlQr6gQPHatIUygQNm4Uj/A?=
 =?us-ascii?Q?p0YpnXMIthTe0Qpmi1a7ZkeZGUhnFFyRk4hciNBM0YTbjbaAqtV4OsDtjVUz?=
 =?us-ascii?Q?fEBSFBuI6SyZF/hq9jnRl+0U4ysP+61s2CyWodMfSKhYhPx3hCL1WblHMSp1?=
 =?us-ascii?Q?UChtjWgTv7y6gG5LgZ/DMucBJBp9ATJS18P+8TiUkHF5jXR4NhGwm07dZZTp?=
 =?us-ascii?Q?w7dAnBcb9SMqLjnYfVh+X6lieaYx5n975RCOnzNLCuyAmTE6EA8x3fgXTte4?=
 =?us-ascii?Q?JPKFbN4xBhkgcQLKKhvYTo60hFGfX4ww9XQR/63izFfnt1I0SZ4rFEUmlDa9?=
 =?us-ascii?Q?pXhRIHtxtxUC7paTmx0vtW+OaA/y6KQcqS6qNNgBJUyxLLuGNJuGdJM9+Jma?=
 =?us-ascii?Q?R4RsaQzVIuu64mtwMNQFdfUNvGnZF7muuP1Rkykjy0TQLjddrkAOXil0GLA/?=
 =?us-ascii?Q?UnPNRghXJeIqCrQrnX9C4fswPpkGBbZzflDor+1N5hYZ8PsVKEOHTk2fCJWz?=
 =?us-ascii?Q?CQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2074ecca-1345-47f6-8177-08dd574e581e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 16:46:55.6523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G8PGVf0HQ5SUWTycj9xv6OwVa0VMBat3AzqqkhEQJ+/Ii6+RL1tZGPXS3lMbNuS+Tk1kTn/QC4teCsZdgFfCUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5238
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Feb 2025 16:47:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17978

On 27.02.25 17:07, Quirin Gylstorff wrote:
>=20
>=20
> On 2/27/25 15:49, Claudius Heine wrote:
>> Hi Qurin,
>>
>> On 2025-02-27 3:42 pm, Quirin Gylstorff wrote:
>>>
>>>
>>> On 2/27/25 15:30, Claudius Heine wrote:
>>>> In case encryption needs to be enabled via an update, while still
>>>> allowing the update fall back to work. One update step where encryptio=
n
>>>> is supported, but no reencryption is taking place if the device is not
>>>> encrypted.
>>>
>>> The scenario this patch tries to solve is update from A to B:
>>> - Update is not confirmed
>>> - the encryption was successful
>>> -=C2=A0 Error occurs and we fallback to Partition A
>>>
>>> Is that correct?
>>
>> Yes, and it is about a shared data partition, that needs to be
>> available on both systems and should eventually be encrypted. The root
>> file systems do not really matter, because they are belong to each
>> update slot.
>>
>> Update slot A needs to be able to mount the encrypted partition, but
>> should not encrypt it.
>=20
> Can you add that example=C2=A0 to the commit message.
>=20

Actually, that should better go into our documentation so that the
reference case is also clear to users not parsing the code history.

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

