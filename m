Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895EDCE7B00
	for <webhook@archiver.kernel.org>; Thu, 28 Sep 2023 06:52:12 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.49])
 by mx.groups.io with SMTP id smtpd.web10.8565.1695883931671942632
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Sep 2023 23:52:12 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=TX4Dv3Jk;
 spf=pass (domain: siemens.com, ip: 40.107.104.49, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EbZC8KvBSCoJpO2EW8OWqwi51m0fRYVZeHgruyuPz6TRS7JBJNV+lTVocw8JtXhaj8syQkwdsY7GG8ZzGD0BsqHmeHxdaYWZsX2ot8dpKx85LAmliEuPowa+T6I2mV90EssT6661jdYkZeEgxVhnMc0s6LIpEso1Mbn0Eur2mWPq8pzBzW5ndM984jO/T9JY7iTkDNpQD0HMJCaaEysMwt0nvsyzGdDyP58CUtNQPvNmjA51yAXM7V6juJAPTbeuOpD/yLTtBDdH6+lJ7HE8UfTDLbOh+fmATLFWlplKUpWoLEdRvBsdKHw1/h+fOKS2GX1BLLet03WmbGwhIxmc7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GuxRn0cKiDZ94tFSgV1gJeU8FhixXOR2Gk8WBno9ek8=;
 b=i+3NMPqtmLYEJ/9eqiG3bBu6IPU8PksAULaxflBrOICUQYLRrWV5GfrXfeH4c7NGxIIufoTcEcC0QHCCGUkS95bbNuyZQ6E/lV+SXdeoFihadZQEg23k9fWKlK1kDWNTJzU/y4Xcczikl/0uxOCZn/RWo+FvpZ50OhXboX0hcn8XsA5jq6i6dhjfIaacjchpujzG5ZvachcIJz705g4nU17hWhLCap8qbt6K1YZRp9v2J4kkDxkOuW6TXyjHyUDpROeHQStzIA/gb0yHEeUvj1V995Ap9+gw/YoAHQ3JMn2H02StnyferlyU0LILIA4uFpHdMh7oB+47tEmuWELSsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GuxRn0cKiDZ94tFSgV1gJeU8FhixXOR2Gk8WBno9ek8=;
 b=TX4Dv3JkOVYRhifHHE4DPgoHFDIt25IWk7LMGsd4MredeRWSVjrWkGFgJ3hDp5osQC5OkIxA1AVaPUyNRpMrfVnzKMDhDdamKVwD/p1cxvh1Iq75NZtSfit+2rG4FIJHCvVVg0xulvs/sO7DUSCwylv9fFddL8fNLPpISRq4eKrxUSpfnNj/UIrtnbijnduddd6LpieVo3QzLjmgBUVRa7SaAmjcImlE5rnsmDtDmW0iguaxU6Jg5T8wJrRJyOJ/indIrGFN5outfjeG05KZ9LSu4iEm0naCm7X1CVX6jK6zbVOMHEeTCcwxjWxoQOrKj52LvFykh/+2ZLRgT/ED2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5368.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4a0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Thu, 28 Sep
 2023 06:52:08 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6838.016; Thu, 28 Sep 2023
 06:52:08 +0000
Message-ID: <4785f4d6-3bd4-4f98-92b9-77e705f4bd95@siemens.com>
Date: Thu, 28 Sep 2023 08:52:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: projected EOL v4.4 SLTS
Content-Language: en-US
To: "Kadel, Michael" <michael.kadel@karlstorz.com>,
 cip-dev@lists.cip-project.org
References: <ed42752c-3a2e-4e47-9d48-f10b2c89da13@siemens.com>
 <29568.1695799699066068267@lists.cip-project.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <29568.1695799699066068267@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0105.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5368:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c614768-ee15-4232-e360-08dbbfef6eed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	LKXtWYq9xyoVzu+8Uy+liBwr+dYabeaQnQE5Jdd+D6+id/++cNC3S/kE78NvxN/RelGt4egZKZ4o5M65ZuiiFFAQAj2CePfOlnf4hls7aWzoVLB1cmsnecHDyro29t75dYBgszSl4/vW4TtBFqt+okYMhUc6+ZANtMstP5os8aHoN+P4NSl8sbGgdSzo01EXoohFY4TsOzC9R4cyaChTmNTGpPs/7Svs9VaDkqC+c7FPll7Lfdvry98ajOCDWPHyTHMhV+VaaPedPzsHXXm1gn2Ttmc/4tu8dr4YWva6qfXIVjRWH6A9UxzxkpdDh9RoqO2zmJvdGNYInNhsFGMpL7gfIq1RjpBydHjWwtBt0DwxLo6LLluUOUo3JOZ9qlg39lZfTL9f+kuZf2DviVv+gl1ypRK33/HiCOLX8lXfNev5f0kcvIiP+nMDQdFMY2aNf4HeMacSuqSGrfc8+J5LX9dWk23bc26IerNfX7ltpxogM8niIJJhBuGOhDSnSe9c6GUdRPSlfIzFnArsd7sBQ+MjSHN4xb4ZceeMe9WQEi32dU0pl6WZpw2f+0aFusto0XvcYw3k3Ze2/CDEtB9gEp2DwfQGk/hWCRpdFCISLmIxyd2fmaWtJ3dG1OKgUU7X
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(366004)(376002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(26005)(4744005)(41300700001)(5660300002)(31686004)(44832011)(8936002)(8676002)(2906002)(86362001)(316002)(66946007)(83380400001)(31696002)(66556008)(66476007)(6506007)(53546011)(82960400001)(478600001)(6512007)(36756003)(38100700002)(6486002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?xKJxw5Y9rNb8XC1rC5iFSat0okpTY5FfjETlvc7G1DTCgS+dxCeY74LQeTsE?=
 =?us-ascii?Q?/ugdfpjhg4y0t0hQtzEijDY4X60addDGTWqJSqsnGgeM5b4WyyWga5CkutvQ?=
 =?us-ascii?Q?N4Wz8XzIWX34/2oumhEkCMpk22BNIe6yaMBTpnjxNoGbJ5Q6DifIIIDPIHF2?=
 =?us-ascii?Q?xPVfVBuUiw+RIg8aIfuNOBf6ppPPQr7Hh9Jv945bn3g9oZdEfYvDtaRFQHfD?=
 =?us-ascii?Q?BjOx+5qi0HyqZmzhDVaUunfUMLXwIGZGB80XPa00v2WhBTw808LCI+O2Kh+J?=
 =?us-ascii?Q?zHWGKfW2o6w0SMgW5yo5CAz8/xx3TiXUCU7QwbaeNKvnmJNb1f54JhpwhPiT?=
 =?us-ascii?Q?bJVyt00eHTadpM9M6tWd9A91Da+9oqVhXt+fLhkP1khju1Vcxm43EWmCEScG?=
 =?us-ascii?Q?+9oAdfU2ASHh4VkRKUCP5WhNhdH1oRROl+uZUY1Osz75+cChCpPQfWPrCsUR?=
 =?us-ascii?Q?/xUhdNxY6Z7oN/d0yKBZT6wsb3fJKjCvduEVsTIJ6vxUtDPyj4rA6G8cOduV?=
 =?us-ascii?Q?sHRX4IN7KVeAwyC+tC/TViuNpUKw46OeXFnpTotXgSDvxEuTVrlUgAug5rho?=
 =?us-ascii?Q?CQ0LOwirImCxFg87qse0S60L+rx/NFLEJhuKsz7rgnvhvMP9oHbqT0L/Jy4A?=
 =?us-ascii?Q?5zyMNrZahS1f/if5gp+9VJYpPE/+iZTUt1vpPOXbmPnrDY/DgEFf7hUC00R/?=
 =?us-ascii?Q?w2kHibIUT+KkM/EimSIKbxNmLbCGkkNYyzKvVf5tIDjTDaugcCBW9FAwWdww?=
 =?us-ascii?Q?QgDP3iAG9XCk5U0pH7uSBn2LBjrgi9Wz05oTCe1NbOyyh6YG3NB6rn+fFDa1?=
 =?us-ascii?Q?JjJ0TEYN/UQF67V9ItGQ+RtS0dn3A8ajdZ3/PDbSGorPWnnJV28sImyMhlhS?=
 =?us-ascii?Q?omgXBMsOHQnMDqyU1McpRaBh1+JzC1EUcTxrsXyPNrCAXa5C8ZbtsBLZw09t?=
 =?us-ascii?Q?KgDcJtFSoEb7+AnPkbbegLDI+6oZkAUmf8h+6l5fJEs2W/EQN0j94YXWnyFc?=
 =?us-ascii?Q?ACrbdTtSBLCtlUGXYYpr+pEQ+2pofoXAnN2kCNByjTO2Z0+XB87BYeZo9J/r?=
 =?us-ascii?Q?Mo61dfgKShEXL4kJpA37z54KYTTHmauOIZ6oa62C7xClqDHpz/WCVl/cXHPo?=
 =?us-ascii?Q?xvTAnj5qvAV/RBKue00rBRkToiUdaJ1LBNvVifboxzkUjjQbZh8AXwJfdTJF?=
 =?us-ascii?Q?+PMKr0+6m0bTroW0j/DfkGf4j71F7p88dHyjz7J5b2pULRxpHtVL4IuV3Ui9?=
 =?us-ascii?Q?Su6lap0O49i/9eJrNHdUEvKAp0+SYMuTOA3zQABOKECnAap6rbfVTcQ2+cbr?=
 =?us-ascii?Q?EsCz2BpwYKhiH3l5l9IC3MvG7CUjWLzA0qpIYaGY2oUSw6h6uOelqpKsJdkC?=
 =?us-ascii?Q?osiLUjMmjcwHIxK8KSZClKGG/0JjnmBP/wU+mAbTyLKm200UF28f7MGn1AwP?=
 =?us-ascii?Q?vOD5lTcCkAONvqiQr9wU3kHKTQ7t01Od9pQdSBgI1KZNRhjOMZA5GpWUvf+v?=
 =?us-ascii?Q?8Dg87LSRTB/x3TVpIwrf6ZtpSaWaSZ0/UEhe0u3Iu+NjshHAUUWySjdPeJpn?=
 =?us-ascii?Q?y/zDntfE7/03IxQMe9HC/9pW3A6oZo5Dh4njto6w0ri147lXq6Tc/Yn8AONZ?=
 =?us-ascii?Q?EQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c614768-ee15-4232-e360-08dbbfef6eed
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 06:52:08.3487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wm5QyKT52df06vv+W+dustsFaToEuHfSnX8UbaTHmXBW98p/Xyxc2x1XJL60h550VbEh2CabJ5eAC5lTFSNSbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5368
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 28 Sep 2023 06:52:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13244

On 27.09.23 09:28, Kadel, Michael wrote:
> Hi Jan,
>=20
> thanks for your fast answer.
>=20
> I found this vague statement "..*/possibly 2036/*" under:=C2=A0Linux kern=
el
> version history - Wikipedia
> <https://en.wikipedia.org/wiki/Linux_kernel_version_history>
>=20

Oh, thanks for the pointer! Both this as well as the original source
have been fixed now.

> A use case:
> End of Service for medical devices can vary from 5 to 10 years.
> If the End of Life of a medical device was announced in 2018 or later,
> it runs out of support (e.g. cyber security patches for linux kernel v4.4=
)
> This then leads to expensive alternative measures.

Good to know. But that also underlines that we are with about 10 years
in the sweet spot of the demand.

Jan

--=20
Siemens AG, Technology
Linux Expert Center


